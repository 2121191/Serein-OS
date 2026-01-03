// Test program for /dev/null and /dev/zero device files

#include "kernel/include/param.h"
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"
#include "kernel/include/fcntl.h"

static int testdev_main()
{
  char buf[100];
  int fd, n;
  
  printf("=== Testing /dev/null ===\n");
  
  // Test 1: Write to /dev/null (data should be discarded)
  printf("Test 1: Writing to /dev/null\n");
  fd = open("/dev/null", O_WRONLY);
  if (fd < 0) {
    printf("ERROR: Failed to open /dev/null\n");
    exit(1);
  }
  
  n = write(fd, "test data", 9);
  printf("  -> Write returned: %d bytes (data discarded)\n", n);
  if (n == 9) {
    printf("  -> SUCCESS: Write operation succeeded\n");
  } else {
    printf("  -> ERROR: Write should return 9 bytes\n");
  }
  close(fd);
  
  // Test 2: Read from /dev/null (should return EOF immediately)
  printf("\nTest 2: Reading from /dev/null\n");
  fd = open("/dev/null", O_RDONLY);
  if (fd < 0) {
    printf("ERROR: Failed to open /dev/null\n");
    exit(1);
  }
  
  n = read(fd, buf, 100);
  printf("  -> Read returned: %d bytes (should be 0, EOF)\n", n);
  if (n == 0) {
    printf("  -> SUCCESS: /dev/null correctly returns EOF\n");
  } else {
    printf("  -> ERROR: /dev/null should return 0 bytes\n");
  }
  close(fd);
  
  printf("\n=== Testing /dev/zero ===\n");
  
  // Test 3: Read from /dev/zero (should return all zeros)
  printf("Test 3: Reading from /dev/zero\n");
  fd = open("/dev/zero", O_RDONLY);
  if (fd < 0) {
    printf("ERROR: Failed to open /dev/zero\n");
    exit(1);
  }
  
  n = read(fd, buf, 50);
  printf("  -> Read returned: %d bytes\n", n);
  
  // Check if all read data is zero
  int all_zero = 1;
  for (int i = 0; i < n; i++) {
    if (buf[i] != 0) {
      all_zero = 0;
      printf("  -> ERROR: Byte at position %d is %d, not 0\n", i, (unsigned char)buf[i]);
      break;
    }
  }
  
  if (all_zero) {
    printf("  -> SUCCESS: /dev/zero returns all zeros\n");
  } else {
    printf("  -> ERROR: /dev/zero should return all zeros\n");
  }
  close(fd);
  
  // Test 4: Write to /dev/zero (data should be discarded)
  printf("\nTest 4: Writing to /dev/zero\n");
  fd = open("/dev/zero", O_WRONLY);
  if (fd < 0) {
    printf("ERROR: Failed to open /dev/zero\n");
    exit(1);
  }
  
  n = write(fd, "test data", 9);
  printf("  -> Write returned: %d bytes (data discarded)\n", n);
  if (n == 9) {
    printf("  -> SUCCESS: Write operation succeeded\n");
  } else {
    printf("  -> ERROR: Write should return 9 bytes\n");
  }
  close(fd);
  
  // Test 5: Multiple reads from /dev/zero (verify infinite reading)
  printf("\nTest 5: Multiple reads from /dev/zero\n");
  fd = open("/dev/zero", O_RDONLY);
  for (int i = 0; i < 3; i++) {
    n = read(fd, buf, 10);
    printf("  -> Read #%d: %d bytes\n", i + 1, n);
    if (n != 10) {
      printf("  -> ERROR: Read should return 10 bytes\n");
      close(fd);
      exit(1);
    }
  }
  printf("  -> SUCCESS: Multiple reads work correctly\n");
  close(fd);
  
  printf("\n=== All tests completed ===\n");
  printf("SUCCESS: /dev/null and /dev/zero are working correctly!\n");
  
  exit(0);
}

