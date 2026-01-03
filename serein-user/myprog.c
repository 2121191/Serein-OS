// serein-user/myprog.c
#include "user.h"

int main(int argc, char **argv)
{
  printf("myprog: hello from pid %d\n", getpid());

  // 测试：创建并写文件
  int fd = open("testfile.txt", O_CREATE | O_RDWR);
  if (fd < 0) {
    printf("myprog: open create failed\n");
    exit(1);
  }
  char *msg = "Hello Serein OS!\n";
  write(fd, msg, strlen(msg));
  close(fd);

  // 测试：读取文件内容
  fd = open("testfile.txt", O_RDONLY);
  if (fd >= 0) {
    char buf[128];
    int n = read(fd, buf, sizeof(buf) - 1);
    if (n > 0) {
      buf[n] = 0;
      printf("myprog: read -> %s", buf);
    }
    close(fd);
  } else {
    printf("myprog: open read failed\n");
  }

  // 测试：fork/wait
  int pid = fork();
  if (pid == 0) {
    // child
    printf("myprog: child pid %d\n", getpid());
    exit(0);
  } else if (pid > 0) {
    wait(0);
    printf("myprog: parent, child %d finished\n", pid);
  } else {
    printf("myprog: fork failed\n");
  }

  exit(0);
}