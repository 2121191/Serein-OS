#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

void
test_pipe2_basic()
{
  int fd[2];
  char buf[10];
  int n;

  printf("test pipe2 basic...\n");

  if(pipe2(fd, O_NONBLOCK) < 0){
    printf("pipe2 failed\n");
    exit(1);
  }

  // 1. Read from empty non-blocking pipe should return -1
  n = read(fd[0], buf, sizeof(buf));
  if(n != -1){
    printf("read empty non-blocking pipe returned %d, expected -1\n", n);
    exit(1);
  } else {
    printf("read empty non-blocking pipe returned -1 (expected)\n");
  }

  // 2. Write to non-blocking pipe
  n = write(fd[1], "hello", 5);
  if(n != 5){
    printf("write non-blocking pipe failed\n");
    exit(1);
  }

  // 3. Read back
  n = read(fd[0], buf, sizeof(buf));
  if(n != 5){
    printf("read back from non-blocking pipe returned %d\n", n);
    exit(1);
  }
  buf[n] = 0;
  if(strcmp(buf, "hello") != 0){
    printf("read content mismatch\n");
    exit(1);
  }

  close(fd[0]);
  close(fd[1]);
  printf("test pipe2 basic OK\n");
}

int
main(int argc, char *argv[])
{
  test_pipe2_basic();
  exit(0);
}
