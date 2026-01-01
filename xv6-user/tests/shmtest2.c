// Cross-process and boundary tests for shared memory
// Tests:
// 1) Parent creates and writes, child attaches and verifies, child modifies, parent sees changes
// 2) Concurrent children attach and write different offsets
// 3) Boundary: creating larger than allowed should fail
// 4) Unlink while attached: unlink should remove name but mapping still usable until detach

#include "xv6-user/user.h"

#define PGSIZE 4096

static int shmtest2_main(void)
{
  int shmid;
  uint64 va_parent;
  int pid, i;

  printf("=== Shared Memory Test 2: Cross-process & Boundaries ===\n");

  // Test 1: parent create, write, child attach/read/modify, parent sees changes
  printf("Test 2.1: Cross-process visibility (parent->child->parent)...\n");
  shmid = shmcreate("cross_shm", 2*PGSIZE);
  if(shmid < 0){
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  va_parent = shmattach(shmid);
  if(va_parent == 0){
    printf("ERROR: parent shmattach failed\n");
    exit(1);
  }

  // fill with pattern 0x11
  for(i = 0; i < 16; i++)
    ((char*)va_parent)[i] = 0x11;

  pid = fork();
  if(pid < 0){
    printf("ERROR: fork failed\n");
    exit(1);
  }

  if(pid == 0){
    // child
    int cshmid = shmopen("cross_shm");
    if(cshmid < 0){
      printf("CHILD ERROR: shmopen failed\n");
      exit(1);
    }
    uint64 va_child = shmattach(cshmid);
    if(va_child == 0){
      printf("CHILD ERROR: shmattach failed\n");
      exit(1);
    }
    // check pattern
    for(i = 0; i < 16; i++){
      if(((char*)va_child)[i] != 0x11){
        printf("CHILD ERROR: unexpected data before modify\n");
        exit(1);
      }
    }
    // modify
    ((char*)va_child)[0] = 0xAA;
    ((char*)va_child)[1] = 0xBB;

    // detach and exit
    if(shmdetach(va_child, PGSIZE) < 0){
      printf("CHILD ERROR: shmdetach failed\n");
      exit(1);
    }
    exit(0);
  }

  // parent waits for child
  wait(0);

  // parent should see child's modifications
  if(((char*)va_parent)[0] != 0xAA || ((char*)va_parent)[1] != 0xBB){
    printf("ERROR: Parent did not see child's modifications\n");
    exit(1);
  }
  printf("SUCCESS: Cross-process visibility works\n");

  // cleanup
  shmdetach(va_parent, 2*PGSIZE);
  shmunlink("cross_shm");

  // Test 2: concurrent attach/write by multiple children
  printf("Test 2.2: Concurrent attach/write by multiple children...\n");
  shmid = shmcreate("concurrent_shm", PGSIZE);
  if(shmid < 0){
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  va_parent = shmattach(shmid);
  if(va_parent == 0){
    printf("ERROR: parent shmattach failed\n");
    exit(1);
  }

  int nchildren = 4;
  for(i = 0; i < nchildren; i++){
    if(fork() == 0){
      int c = shmopen("concurrent_shm");
      if(c < 0){
        printf("CHILD ERROR: shmopen failed\n");
        exit(1);
      }
      uint64 v = shmattach(c);
      if(v == 0){
        printf("CHILD ERROR: shmattach failed\n");
        exit(1);
      }
      // each child writes its id to offset i
      ((char*)v)[i] = (char)(i + 1);
      shmdetach(v, PGSIZE);
      exit(0);
    }
  }

  for(i = 0; i < nchildren; i++)
    wait(0);

  // parent reads back and checks that values are present (note: order may vary)
  int seen[5] = {0};
  for(i = 0; i < nchildren; i++){
    int val = (int)((char*)va_parent)[i];
    if(val < 1 || val > nchildren){
      printf("ERROR: unexpected value %d at offset %d\n", val, i);
      exit(1);
    }
    seen[val] = 1;
  }
  for(i = 1; i <= nchildren; i++){
    if(!seen[i]){
      printf("ERROR: missing value %d\n", i);
      exit(1);
    }
  }
  printf("SUCCESS: Concurrent attach/write succeeded\n");

  shmdetach(va_parent, PGSIZE);
  shmunlink("concurrent_shm");

  // Test 3: Boundary (too big) should fail
  printf("Test 2.3: Boundary: create too-large shared memory should fail...\n");
  int big = shmcreate("big_shm", 70000); // > 16*4096 = 65536
  if(big >= 0){
    printf("ERROR: creation of too-large shared memory succeeded unexpectedly\n");
    exit(1);
  }
  printf("SUCCESS: Too-large shmcreate failed as expected\n");

  // Test 4: Unlink while attached
  printf("Test 2.4: Unlink while attached...\n");
  shmid = shmcreate("unlink_shm", PGSIZE);
  if(shmid < 0){
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  va_parent = shmattach(shmid);
  if(va_parent == 0){
    printf("ERROR: shmattach failed\n");
    exit(1);
  }
  // use a pipe to ensure child attaches before parent unlinks
  int fds[2];
  if(pipe(fds) < 0){
    printf("ERROR: pipe failed\n");
    exit(1);
  }

  // fork child to attach
  pid = fork();
  if(pid < 0){
    printf("ERROR: fork failed\n");
    exit(1);
  }
  if(pid == 0){
    close(fds[0]); // close read end
    int c = shmopen("unlink_shm");
    if(c < 0){
      printf("CHILD ERROR: shmopen failed\n");
      exit(1);
    }
    uint64 v = shmattach(c);
    if(v == 0){
      printf("CHILD ERROR: shmattach failed\n");
      exit(1);
    }
    // signal parent that attach succeeded
    char ok = 1;
    write(fds[1], &ok, 1);

    // child writes
    ((char*)v)[0] = 0x5A;
    shmdetach(v, PGSIZE);
    close(fds[1]);
    exit(0);
  }
  // parent waits for child's signal (attach done)
  close(fds[1]);
  char buf;
  if(read(fds[0], &buf, 1) != 1){
    printf("ERROR: pipe read failed\n");
    exit(1);
  }
  close(fds[0]);

  // parent unlink while child still mapped
  if(shmunlink("unlink_shm") < 0){
    printf("ERROR: shmunlink failed\n");
    exit(1);
  }
  wait(0);
  // parent should detach its original mapping before re-attaching to the same shmid
  printf("Parent: original va=%p, detaching now...\n", (void*)va_parent);
  if(shmdetach(va_parent, PGSIZE) < 0){
    printf("ERROR: parent shmdetach failed\n");
    exit(1);
  }

  // parent re-attach to check value (should be 0x5A if still present)
  uint64 va2 = shmattach(shmid);
  if(va2 == 0){
    printf("ERROR: re-attach after unlink failed (va2==0)\n");
    exit(1);
  }
  printf("Parent: re-attached at va2=%p, reading byte...\n", (void*)va2);
  unsigned char got = ((unsigned char*)va2)[0];
  printf("Parent: read byte=0x%x\n", got);
  if(got != 0x5A){
    printf("ERROR: expected byte 0x5A after unlink/child write, got %x\n", got);
    exit(1);
  }
  shmdetach(va2, PGSIZE);
  printf("SUCCESS: Unlink while attached behaves correctly\n");

  printf("\n=== All Tests in shmtest2 Passed ===\n");
  exit(0);
}
