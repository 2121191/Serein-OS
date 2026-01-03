// serein-user/cp.c
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

#define BUFSIZE 512

void
usage(void)
{
  printf("usage: cp src dst\n");
  exit(1);
}

int
main(int argc, char *argv[])
{
  if(argc != 3){
    usage();
  }

  char *src = argv[1];
  char *dst = argv[2];

  if(strcmp(src, dst) == 0){
    printf("cp: source and destination are the same\n");
    exit(1);
  }

  int fd_src = open(src, 0);
  if(fd_src < 0){
    printf("cp: cannot open %s\n", src);
    exit(1);
  }

  int fd_dst = open(dst, O_CREATE | O_WRONLY | O_TRUNC);
  if(fd_dst < 0){
    printf("cp: cannot create %s\n", dst);
    close(fd_src);
    exit(1);
  }

  char buf[BUFSIZE];
  int n;
  while((n = read(fd_src, buf, sizeof(buf))) > 0){
    int written = 0;
    while(written < n){
      int m = write(fd_dst, buf + written, n - written);
      if(m < 0){
        printf("cp: write error\n");
        close(fd_src);
        close(fd_dst);
        exit(1);
      }
      written += m;
    }
  }

  if(n < 0){
    printf("cp: read error\n");
    close(fd_src);
    close(fd_dst);
    exit(1);
  }

  close(fd_src);
  close(fd_dst);
  exit(0);
}
