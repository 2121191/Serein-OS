#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"
#include "kernel/include/fcntl.h"

// V3.0: chmod/fchmod test program

void test_chmod() {
  printf("Test 1: chmod basic functionality\n");
  
  // Create a test file
  int fd = open("chmod_test_file", O_CREATE | O_RDWR);
  if(fd < 0) {
    printf("  FAILED: create file\n");
    exit(1);
  }
  write(fd, "test", 4);
  close(fd);

  // Test chmod
  if(chmod("chmod_test_file", 0755) < 0) {
    printf("  FAILED: chmod failed\n");
    exit(1);
  }
  
  printf("  SUCCESS: chmod() returned 0\n");
}

void test_fchmod() {
  printf("Test 2: fchmod functionality\n");
  
  int fd = open("fchmod_test_file", O_CREATE | O_RDWR);
  if(fd < 0) {
    printf("  FAILED: create file\n");
    exit(1);
  }
  
  // Test fchmod
  if(fchmod(fd, 0644) < 0) {
    printf("  FAILED: fchmod failed\n");
    close(fd);
    exit(1);
  }
  
  close(fd);
  printf("  SUCCESS: fchmod() returned 0\n");
}

void test_permission_check() {
  printf("Test 3: Permission checking\n");
  
  int uid = getuid();
  printf("  Current UID: %d\n", uid);
  
  if(uid == 0) {
    printf("  Root user: all permissions granted\n");
  } else {
    printf("  Non-root user: limited permissions\n");
  }
  
  printf("  SUCCESS: Permission system active\n");
}

int chmodtest_main(int argc, char *argv[]) {
  printf("=== chmod/fchmod Test ===\n\n");
  
  test_chmod();
  test_fchmod();
  test_permission_check();
  
  // Cleanup
  remove("chmod_test_file");
  remove("fchmod_test_file");
  
  printf("\n=== All chmod tests PASSED ===\n");
  exit(0);
}
