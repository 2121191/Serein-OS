#undef ITERATIONS
#undef NPROCS
// shmstress.c - 共享内存压力测试
// V2.0 压力测试套件: 验证共享内存在多进程高并发访问下的稳定性

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

#define NPROCS 4       // 并发进程数
#define ITERATIONS 100 // 每个进程的写入次数

void
shmstress_run(void)
{
  int pids[NPROCS];
  int i;
  
  printf("shmstress: starting shared memory stress test...\n");
  printf("  NPROCS=%d, ITERATIONS=%d\n", NPROCS, ITERATIONS);
  
  // 创建共享内存段
  int shmid = shmcreate("stress", 4096);
  if(shmid < 0) {
    printf("shmstress: shm_create failed\n");
    exit(1);
  }
  
  // 映射到当前进程
  uint64 addr = shmattach(shmid);
  if(addr == 0) {
    printf("shmstress: parent shm_attach failed\n");
    exit(1);
  }
  
  // 初始化共享计数器
  volatile int *counter = (volatile int *)addr;
  *counter = 0;
  
  // 创建子进程
  for(i = 0; i < NPROCS; i++) {
    pids[i] = fork();
    if(pids[i] < 0) {
      printf("shmstress: fork %d failed\n", i);
      exit(1);
    }
    
    if(pids[i] == 0) {
      // 子进程：映射共享内存并递增计数器
      uint64 child_addr = shmattach(shmid);
      if(child_addr == 0) {
        printf("shmstress: child %d shm_attach failed\n", i);
        exit(1);
      }
      
      volatile int *child_counter = (volatile int *)child_addr;
      for(int j = 0; j < ITERATIONS; j++) {
        // 简单递增（非原子，但我们只是测试内存共享）
        int old = *child_counter;
        *child_counter = old + 1;
        // 少量延迟增加交错
        if(j % 20 == 0) sleep(0);
      }
      
      shmdetach(child_addr, 4096);
      exit(0);
    }
  }
  
  // 等待所有子进程
  for(i = 0; i < NPROCS; i++) {
    int status;
    int pid = wait(&status);
    if(pid < 0) {
      printf("shmstress: wait failed\n");
      exit(1);
    }
    if(status != 0) {
      printf("shmstress: child %d failed with status %d\n", pid, status);
      exit(1);
    }
  }
  
  // 检查计数器（由于非原子操作，值可能小于预期，但不应为 0 或负数）
  int final = *counter;
  printf("shmstress: final counter = %d (expected up to %d)\n", 
         final, NPROCS * ITERATIONS);
  
  if(final <= 0) {
    printf("shmstress: counter corruption detected!\n");
    exit(1);
  }
  
  shmdetach(addr, 4096);
  shmunlink("stress");  // 释放共享内存段，避免资源泄漏
  printf("shmstress: PASSED\n");
}

static int shmstress_main(int argc, char *argv[])
{
  shmstress_run();
  exit(0);
}
