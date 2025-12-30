#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "user.h"

void test_pgid_basic(void) {
  printf("Test: pgid basic...\n");
  
  int mypgid = getpgid(0);
  int mypid = getpid();
  
  printf("Initial pgid=%d, pid=%d\n", mypgid, mypid);

  // Shell runs children in its own group (usually 1 or 2)
  // So mypgid != mypid is expected in current shell implementation.
  
  // Test 1: Become process group leader
  if(setpgid(0, 0) < 0) {
      printf("setpgid(0, 0) failed\n");
      exit(1);
  }

  int newpgid = getpgid(0);
  if(newpgid != mypid) {
      printf("After setpgid(0,0), pgid should be pid (pgid=%d, pid=%d)\n", newpgid, mypid);
      exit(1);
  }
  
  printf("pgid basic: ok (became leader)\n");
}

void test_pgid_inherit(void) {
  printf("Test: pgid inherit...\n");
  
  int parent_pgid = getpgid(0);
  int pid = fork();
  
  if(pid < 0) {
    printf("fork failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    // Child
    int child_pgid = getpgid(0);
    if(child_pgid != parent_pgid) {
      printf("Child should inherit parent pgid (child=%d, parent=%d)\n", 
             child_pgid, parent_pgid);
      exit(1);
    }
    exit(0);
  } else {
    int status;
    wait(&status);
    if(status != 0) {
      printf("Child test failed\n");
      exit(1);
    }
  }
  printf("pgid inherit: ok\n");
}

void test_setpgid(void) {
  printf("Test: setpgid...\n");
  
  int newpgid = 12345;
  if(setpgid(0, newpgid) < 0) {
    printf("setpgid failed\n");
    exit(1);
  }
  
  if(getpgid(0) != newpgid) {
    printf("getpgid after setpgid failed\n");
    exit(1);
  }
  
  // Reset to self
  if(setpgid(0, 0) < 0) {
    printf("setpgid(0,0) failed\n");
    exit(1);
  }
  
  if(getpgid(0) != getpid()) {
    printf("setpgid(0,0) should set pgid to pid\n");
    exit(1);
  }
  
  printf("setpgid: ok\n");
}

int main(void) {
  printf("pgtest starting\n");
  test_pgid_basic();
  
  // Run inheritance test in child to not affect main
  int pid = fork();
  if(pid == 0) {
    test_pgid_inherit();
    exit(0);
  }
  wait(0);
  
  // Run setpgid test in child
  pid = fork();
  if(pid == 0) {
    test_setpgid();
    exit(0);
  }
  wait(0);
  
  printf("pgtest finished\n");
  exit(0);
}
