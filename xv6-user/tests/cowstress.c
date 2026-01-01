// cowstress.c - Copy-on-Write 压力测试
// V2.0 压力测试套件: 验证 CoW 在高并发 fork + 写入下的稳定性

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

#define NFORK 20      // 并发 fork 数量
#define NPAGES 10     // 每个子进程写入的页面数
#define ITERATIONS 3  // 重复迭代次数

// 用于测试的全局数组
char data[NPAGES * 4096];

void
cowstress_run(void)
{
  int pids[NFORK];
  int i, j, iter;
  
  printf("cowstress: starting CoW stress test...\n");
  printf("  NFORK=%d, NPAGES=%d, ITERATIONS=%d\n", NFORK, NPAGES, ITERATIONS);
  
  for(iter = 0; iter < ITERATIONS; iter++) {
    printf("cowstress: iteration %d/%d\n", iter + 1, ITERATIONS);
    
    // 初始化父进程数据
    for(i = 0; i < NPAGES * 4096; i++) {
      data[i] = 'P';  // Parent
    }
    
    // Fork 多个子进程
    for(i = 0; i < NFORK; i++) {
      pids[i] = fork();
      if(pids[i] < 0) {
        printf("cowstress: fork %d failed\n", i);
        exit(1);
      }
      
      if(pids[i] == 0) {
        // 子进程：写入页面触发 CoW
        for(j = 0; j < NPAGES; j++) {
          int offset = j * 4096;
          // 写入每个页面的第一个字节
          data[offset] = 'C' + (i % 26);  // Child
          // 验证其他字节仍是父进程数据
          if(data[offset + 1] != 'P') {
            printf("cowstress: child %d page %d corrupted!\n", i, j);
            exit(1);
          }
        }
        exit(0);
      }
    }
    
    // 父进程：等待所有子进程
    for(i = 0; i < NFORK; i++) {
      int status;
      int pid = wait(&status);
      if(pid < 0) {
        printf("cowstress: wait failed\n");
        exit(1);
      }
      if(status != 0) {
        printf("cowstress: child %d failed with status %d\n", pid, status);
        exit(1);
      }
    }
    
    // 验证父进程数据未被污染
    for(i = 0; i < NPAGES * 4096; i++) {
      if(data[i] != 'P') {
        printf("cowstress: parent data corrupted at offset %d!\n", i);
        exit(1);
      }
    }
  }
  
  printf("cowstress: PASSED\n");
}

static int cowstress_main(int argc, char *argv[])
{
  cowstress_run();
  exit(0);
}
