#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

// simple strcmp
int parent_strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

void test_lseek(void) {
  printf("Test: lseek...\n");
  int fd = open("lseek.test", O_CREATE | O_RDWR);
  if(fd < 0){
    printf("lseek: create failed\n");
    exit(1);
  }

  write(fd, "hello world", 11);

  // SEEK_SET
  if(lseek(fd, 0, 0) != 0){ // SEEK_SET = 0
    printf("lseek: SEEK_SET failed\n");
    exit(1);
  }
  
  char buf[6];
  if(read(fd, buf, 5) != 5){
    printf("lseek: read failed\n");
    exit(1);
  }
  buf[5] = 0;
  if(parent_strcmp(buf, "hello") != 0){ // strcmp is not available? use manual compare
     printf("lseek: content mismatch (expected hello, got %s)\n", buf);
     exit(1);
  }

  // SEEK_CUR
  if(lseek(fd, 1, 1) != 6){ // SEEK_CUR = 1, current is 5, +1 = 6
    printf("lseek: SEEK_CUR failed\n");
    exit(1);
  }

  if(read(fd, buf, 5) != 5){
     printf("lseek: read2 failed\n");
     exit(1);
  }
  buf[5] = 0;
  if(parent_strcmp(buf, "world") != 0){
      printf("lseek: content mismatch 2 (expected world, got %s)\n", buf);
      exit(1);
  }

  // SEEK_END
  if(lseek(fd, -5, 2) != 6){ // SEEK_END = 2, size is 11, -5 = 6
      printf("lseek: SEEK_END failed\n");
      exit(1);
  }

  close(fd);
  printf("lseek: ok\n");
}

void test_dup2(void) {
  printf("Test: dup2...\n");
  int fd = open("dup2.test", O_CREATE | O_RDWR);
  if(fd < 0){
      printf("dup2: create failed\n");
      exit(1);
  }
  
  // dup2 to 10
  if(dup2(fd, 10) != 10){
      printf("dup2: failed to dup to 10\n");
      exit(1);
  }
  
  write(10, "dup2data", 8);
  close(10);
  
  // Verify content
  if(lseek(fd, 0, 0) != 0){
      printf("dup2: lseek failed\n");
      exit(1);
  }
  char buf[9];
  if(read(fd, buf, 8) != 8){
      printf("dup2: verify read failed\n");
      exit(1);
  }
  buf[8] = 0;
  if(parent_strcmp(buf, "dup2data") != 0){
      printf("dup2: content mismatch\n");
      exit(1);
  }
  
  close(fd);
  printf("dup2: ok\n");
}

void test_getppid(void) {
  printf("Test: getppid...\n");
  int pid = fork();
  if(pid < 0){
      printf("getppid: fork failed\n");
      exit(1);
  }
  
  if(pid == 0){
      // child
      int ppid = getppid();
      // int actual_ppid = getpid(); // Unused
      exit(ppid);
  } else {
      // parent
      int mypid = getpid();
      int status;
      wait(&status);
      if(status != mypid){
          printf("getppid: expected %d, got %d\n", mypid, status);
          exit(1);
      }
      printf("getppid: ok\n");
  }
}

int exttest_main(void) {
  printf("exttest starting\n");
  test_lseek();
  test_dup2();
  test_getppid();
  printf("exttest finished\n");
  exit(0);
}
