// mmaptest.c - mmap 系统调用测试
// V2.0.2 mmap 功能验证

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

#define PGSIZE 4096

void
test_anonymous_mmap(void)
{
  printf("test anonymous mmap: ");
  
  // 匿名映射
  char *p = mmap(0, PGSIZE, PROT_READ | PROT_WRITE, 
                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if(p == MAP_FAILED) {
    printf("FAILED - mmap returned MAP_FAILED\n");
    exit(1);
  }
  
  // 写入和读取
  p[0] = 'A';
  p[100] = 'B';
  p[PGSIZE - 1] = 'C';
  
  if(p[0] != 'A' || p[100] != 'B' || p[PGSIZE - 1] != 'C') {
    printf("FAILED - data mismatch\n");
    exit(1);
  }
  
  // 解除映射
  if(munmap(p, PGSIZE) != 0) {
    printf("FAILED - munmap failed\n");
    exit(1);
  }
  
  printf("OK\n");
}

void
test_file_mmap(void)
{
  printf("test file mmap: ");
  
  // 使用 malloc 而不是栈上大缓冲区，避免栈溢出
  char *buf = malloc(PGSIZE);
  if(buf == 0) {
    printf("FAILED - malloc failed\n");
    exit(1);
  }
  
  // 创建测试文件
  int fd = open("mmaptest.txt", O_CREATE | O_RDWR);
  if(fd < 0) {
    printf("FAILED - cannot create file\n");
    free(buf);
    exit(1);
  }
  
  for(int i = 0; i < PGSIZE; i++) {
    buf[i] = 'X';
  }
  write(fd, buf, PGSIZE);
  close(fd);
  
  // 重新打开并映射
  fd = open("mmaptest.txt", O_RDWR);
  if(fd < 0) {
    printf("FAILED - cannot open file\n");
    free(buf);
    exit(1);
  }
  
  char *p = mmap(0, PGSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  if(p == MAP_FAILED) {
    printf("FAILED - mmap returned MAP_FAILED\n");
    close(fd);
    free(buf);
    exit(1);
  }
  
  // 验证读取
  if(p[0] != 'X' || p[PGSIZE - 1] != 'X') {
    printf("FAILED - file content mismatch (got %c, %c)\n", p[0], p[PGSIZE-1]);
    munmap(p, PGSIZE);
    close(fd);
    free(buf);
    exit(1);
  }
  
  // 修改映射内容
  p[0] = 'Y';
  p[PGSIZE - 1] = 'Z';
  
  // 解除映射 (应该写回文件)
  munmap(p, PGSIZE);
  close(fd);
  
  // 重新读取文件验证写回
  fd = open("mmaptest.txt", O_RDONLY);
  if(fd < 0) {
    printf("FAILED - cannot reopen file\n");
    free(buf);
    exit(1);
  }
  
  read(fd, buf, PGSIZE);
  close(fd);
  
  if(buf[0] != 'Y' || buf[PGSIZE - 1] != 'Z') {
    printf("FAILED - writeback mismatch\n");
    free(buf);
    exit(1);
  }
  
  // 清理
  remove("mmaptest.txt");
  free(buf);
  
  printf("OK\n");
}

static int mmaptest_main(int argc, char *argv[])
{
  printf("mmaptest starting\n");
  
  test_anonymous_mmap();
  test_file_mmap();
  
  printf("mmaptest: ALL TESTS PASSED\n");
  exit(0);
}
