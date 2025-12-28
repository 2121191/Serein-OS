// xv6-user/head.c
// 完整实现：支持 `-n N` / `-N`，可对多个文件处理，默认输出前 10 行
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

#define DEF_N 10

void
headfd(int fd, int n)
{
  char buf[512];
  int i, r;
  int lines = 0;

  while((r = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < r; i++){
      if(write(1, &buf[i], 1) != 1){
        fprintf(2, "head: write error\n");
        exit(1);
      }
      if(buf[i] == '\n' && ++lines >= n)
        return;
    }
  }
  if(r < 0){
    fprintf(2, "head: read error\n");
    exit(1);
  }
}

static void
usage(void)
{
  fprintf(2, "usage: head [-n N] [file ...]\n");
  exit(1);
}

int main(int argc, char *argv[])
{
  int n = DEF_N;
  int i = 1;
  int firstFile = 1;

  if(argc > 1){
    // parse -n N or -N or -nN
    if(argv[1][0] == '-'){
      if(argv[1][1] == 'n'){
        if(argv[1][2]){ // -nN
          n = atoi(argv[1] + 2);
          i = 2;
        } else { // -n N
          if(argc < 3) usage();
          n = atoi(argv[2]);
          i = 3;
        }
      } else if(argv[1][1] >= '0' && argv[1][1] <= '9'){
        n = atoi(argv[1] + 1); // -N
        i = 2;
      }
    }
    if(n <= 0) usage();
  }

  if(i >= argc){
    headfd(0, n);
    exit(0);
  }

  for(; i < argc; i++){
    int fd = open(argv[i], 0);
    if(fd < 0){
      fprintf(2, "head: cannot open %s\n", argv[i]);
      exit(1);
    }
    if(argc - i > 1) { // 当有多个文件时，打印文件头
      if(!firstFile) printf("\n");
      printf("==> %s <==\n", argv[i]);
      firstFile = 0;
    }
    headfd(fd, n);
    close(fd);
  }
  exit(0);
}