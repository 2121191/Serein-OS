#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

void test_basic(void) {
  printf("Test: basic uid/gid...\n");
  int uid = getuid();
  int gid = getgid();
  printf("Current uid=%d, gid=%d\n", uid, gid);
  if(uid != 0 || gid != 0) {
    printf("Initial uid/gid should be 0 (got uid=%d, gid=%d)\n", uid, gid);
    exit(1);
  }
  printf("basic: ok\n");
}

void test_setuid(void) {
  printf("Test: setuid...\n");
  
  // Root can set strict
  if(setuid(100) < 0) {
    printf("root setuid(100) failed\n");
    exit(1);
  }

  if(getuid() != 100) {
     printf("getuid failed after setuid(100)\n");
     exit(1);
  }

  // Fork should inherit
  int pid = fork();
  if(pid < 0) {
      printf("fork failed\n");
      exit(1);
  }

  if(pid == 0) {
      // Child
      int cuid = getuid();
      if(cuid != 100) {
          printf("Child did not inherit uid 100 (got %d)\n", cuid);
          exit(1);
      }
      
      // Non-root cannot set to 0
      if(setuid(0) == 0) {
          printf("Non-root (100) setuid(0) should fail but succeeded\n");
          exit(1);
      }
      
      // Non-root can set to self
      if(setuid(100) < 0) {
          printf("Non-root setuid(self) failed\n");
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

  // Restore root? No wait, we are 100 now.
  // We cannot restore to 0. Ideally test should fork before changing self.
  // But for this simple test suite, it's fine.
  printf("setuid: ok\n");
}

int idtest_main(void) {
  printf("idtest starting\n");
  test_basic();
  
  // run setuid test in a child to not affect main process (though irrelevant for userinit)
  int pid = fork();
  if(pid == 0) {
     test_setuid();
     exit(0);
  }
  wait(0);
  
  printf("idtest finished\n");
  exit(0);
}
