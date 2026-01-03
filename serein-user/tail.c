// serein-user/tail.c
// 完整实现：支持 `-n N` / `-N`，可对多个文件处理，默认输出最后 10 行
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

#define DEF_N 10
#define MAX_LINE 4096

static void
usage(void)
{
  fprintf(2, "usage: tail [-n N] [file ...]\n");
  exit(1);
}

void
tailfd(int fd, int n)
{
  char buf[512];
  char *linebuf;
  char **lines;
  int r, i;
  int li = 0; // linebuf index
  int idx = 0; // circular index
  int total = 0;

  if(n <= 0) return;

  lines = malloc(sizeof(char*) * n);
  if(!lines){
    fprintf(2, "tail: malloc failed\n");
    exit(1);
  }
  for(i = 0; i < n; i++) lines[i] = 0;

  linebuf = malloc(MAX_LINE);
  if(!linebuf){
    fprintf(2, "tail: malloc failed\n");
    exit(1);
  }

  while((r = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < r; i++){
      char c = buf[i];
      if(li < MAX_LINE - 1) linebuf[li++] = c;
      if(c == '\n'){
        linebuf[li] = '\0';
        if(lines[idx]) free(lines[idx]);
        lines[idx] = malloc(li + 1);
        if(!lines[idx]){
          fprintf(2, "tail: malloc failed\n");
          exit(1);
        }
        strcpy(lines[idx], linebuf);
        idx = (idx + 1) % n;
        if(total < n) total++;
        li = 0;
      }
    }
  }

  if(r < 0){
    fprintf(2, "tail: read error\n");
    free(linebuf);
    exit(1);
  }

  // 处理 EOF 时如果有未以 \n 结尾的残余行
  if(li > 0){
    linebuf[li] = '\0';
    if(lines[idx]) free(lines[idx]);
    lines[idx] = malloc(li + 1);
    if(!lines[idx]){
      fprintf(2, "tail: malloc failed\n");
      free(linebuf);
      exit(1);
    }
    strcpy(lines[idx], linebuf);
    idx = (idx + 1) % n;
    if(total < n) total++;
  }

  free(linebuf);

  // 输出 oldest -> newest
  int start = (idx - total + n) % n;
  for(i = 0; i < total; i++){
    int p = (start + i) % n;
    if(lines[p]){
      if(write(1, lines[p], strlen(lines[p])) != strlen(lines[p])){
        fprintf(2, "tail: write error\n");
        exit(1);
      }
    }
  }

  for(i = 0; i < n; i++) if(lines[i]) free(lines[i]);
  free(lines);
}

int main(int argc, char *argv[])
{
  int n = DEF_N;
  int i = 1;
  int firstFile = 1;

  if(argc > 1){
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
    tailfd(0, n);
    exit(0);
  }

  for(; i < argc; i++){
    int fd = open(argv[i], 0);
    if(fd < 0){
      fprintf(2, "tail: cannot open %s\n", argv[i]);
      exit(1);
    }
    if(argc - i > 1) {
      if(!firstFile) printf("\n");
      printf("==> %s <==\n", argv[i]);
      firstFile = 0;
    }
    tailfd(fd, n);
    close(fd);
  }
  exit(0);
}