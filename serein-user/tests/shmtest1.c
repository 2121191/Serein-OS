//
// Test 1: Basic shared memory creation and opening
// This test verifies that shmcreate and shmopen work correctly
//

#include "serein-user/user.h"

static int shmtest1_main(void)
{
  int shmid1, shmid2;
  
  printf("=== Shared Memory Test 1: Basic Operations ===\n");
  
  // Test 1: Create a shared memory segment
  printf("Test 1.1: Creating shared memory 'test_shm' with size 4096...\n");
  shmid1 = shmcreate("test_shm", 4096);
  if(shmid1 < 0) {
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  printf("SUCCESS: Created shm with shmid=%d\n", shmid1);
  
  // Test 2: Try to create the same name again (should fail)
  printf("Test 1.2: Trying to create 'test_shm' again (should fail)...\n");
  shmid2 = shmcreate("test_shm", 4096);
  if(shmid2 >= 0) {
    printf("ERROR: Should not be able to create duplicate name\n");
    exit(1);
  }
  printf("SUCCESS: Correctly rejected duplicate name\n");
  
  // Test 3: Open existing shared memory
  printf("Test 1.3: Opening existing 'test_shm'...\n");
  shmid2 = shmopen("test_shm");
  if(shmid2 < 0) {
    printf("ERROR: shmopen failed\n");
    exit(1);
  }
  if(shmid2 != shmid1) {
    printf("ERROR: shmid mismatch (expected %d, got %d)\n", shmid1, shmid2);
    exit(1);
  }
  printf("SUCCESS: Opened shm with shmid=%d\n", shmid2);
  
  // Test 4: Try to open non-existent shared memory (should fail)
  printf("Test 1.4: Trying to open non-existent 'nonexistent' (should fail)...\n");
  shmid2 = shmopen("nonexistent");
  if(shmid2 >= 0) {
    printf("ERROR: Should not be able to open non-existent shm\n");
    exit(1);
  }
  printf("SUCCESS: Correctly rejected non-existent name\n");

  // Test 5: Attach and write to shared memory
  printf("Test 1.5: Attaching 'test_shm' and writing a pattern...\n");
  uint64 va = shmattach(shmid1);
  if(va == 0){
    printf("ERROR: shmattach failed\n");
    exit(1);
  }
  char *p = (char*)va;
  p[0] = 0x5A;
  p[1] = 0xA5;
  printf("SUCCESS: Wrote pattern at va=%p\n", va);

  // Test 6: Detach and re-attach to check persistence
  printf("Test 1.6: Detach and re-attach to check persistence...\n");
  if(shmdetach(va, 4096) < 0){
    printf("ERROR: shmdetach failed\n");
    exit(1);
  }
  uint64 va2 = shmattach(shmid1);
  if(va2 == 0){
    printf("ERROR: shmattach (2) failed\n");
    exit(1);
  }
  char *q = (char*)va2;
  if(q[0] != 0x5A || q[1] != 0xA5){
    printf("ERROR: Data not persistent after detach/attach\n");
    exit(1);
  }
  printf("SUCCESS: Data persisted after detach/attach (va2=%p)\n", va2);

  // Test 7: Unlink behavior - unlink should remove name but not free until detach
  printf("Test 1.7: Unlink 'test_shm' (should still be accessible until detach)...\n");
  if(shmunlink("test_shm") < 0){
    printf("ERROR: shmunlink failed\n");
    exit(1);
  }
  printf("SUCCESS: shmunlink returned success\n");

  // After unlink, opening by name should fail
  shmid2 = shmopen("test_shm");
  if(shmid2 >= 0){
    printf("ERROR: shmopen should fail after unlink\n");
    exit(1);
  }
  printf("SUCCESS: shmopen correctly failed after unlink\n");

  // Detach last mapping - this should free the underlying memory
  if(shmdetach(va2, 4096) < 0){
    printf("ERROR: shmdetach failed (final)\n");
    exit(1);
  }

  // Now creating with same name should succeed and likely produce a different shmid
  printf("Test 1.8: Re-create 'test_shm' after detach/unlink...\n");
  int shmid3 = shmcreate("test_shm", 4096);
  if(shmid3 < 0){
    printf("ERROR: shmcreate failed on re-create\n");
    exit(1);
  }
  if(shmid3 == shmid1){
    printf("WARNING: shmid reused (allowed), new shmid=%d\n", shmid3);
  }
  printf("SUCCESS: Re-created 'test_shm' with shmid=%d\n", shmid3);

  printf("\n=== All Tests Passed! ===\n");
  exit(0);
}

