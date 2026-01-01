#undef ITERATIONS
#undef NPROCS
// semstress.c - 信号量压力测试
// V2.0 压力测试套件: 验证信号量在高并发下的正确性和 kill 清理

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

#define NPROCS 8       // 并发进程数
#define ITERATIONS 50  // 每个进程的信号量操作次数

static int sem_id;

void
producer(int id)
{
  for(int i = 0; i < ITERATIONS; i++) {
    sem_post(sem_id);
    // 让出 CPU 增加交错
    if(i % 5 == 0) sleep(0);
  }
  exit(0);
}

void
consumer(int id)
{
  for(int i = 0; i < ITERATIONS; i++) {
    sem_wait(sem_id);
    // 让出 CPU 增加交错
    if(i % 3 == 0) sleep(0);
  }
  exit(0);
}

void
semstress_run(void)
{
  int pids[NPROCS * 2];
  int i;
  
  printf("semstress: starting semaphore stress test...\n");
  printf("  NPROCS=%d (each side), ITERATIONS=%d\n", NPROCS, ITERATIONS);
  
  // 创建信号量，初始值为 0
  sem_id = sem_open(0);
  if(sem_id < 0) {
    printf("semstress: sem_open failed\n");
    exit(1);
  }
  
  // 创建生产者和消费者
  for(i = 0; i < NPROCS; i++) {
    // 消费者
    pids[i] = fork();
    if(pids[i] < 0) {
      printf("semstress: fork consumer %d failed\n", i);
      exit(1);
    }
    if(pids[i] == 0) {
      consumer(i);
    }
    
    // 生产者
    pids[NPROCS + i] = fork();
    if(pids[NPROCS + i] < 0) {
      printf("semstress: fork producer %d failed\n", i);
      exit(1);
    }
    if(pids[NPROCS + i] == 0) {
      producer(i);
    }
  }
  
  // 等待所有进程完成
  for(i = 0; i < NPROCS * 2; i++) {
    int status;
    int pid = wait(&status);
    if(pid < 0) {
      printf("semstress: wait failed\n");
      exit(1);
    }
    if(status != 0) {
      printf("semstress: child %d failed with status %d\n", pid, status);
      exit(1);
    }
  }
  
  // 验证信号量最终值为 0
  int val;
  if(sem_getvalue(sem_id, &val) < 0) {
    printf("semstress: sem_getvalue failed\n");
    exit(1);
  }
  
  if(val != 0) {
    printf("semstress: final semaphore value is %d, expected 0\n", val);
    exit(1);
  }
  
  sem_close(sem_id);
  printf("semstress: PASSED\n");
}

// 测试 kill 清理
void
semkilltest(void)
{
  printf("semkilltest: testing semaphore cleanup on kill...\n");
  
  int sem = sem_open(0);
  if(sem < 0) {
    printf("semkilltest: sem_open failed\n");
    exit(1);
  }
  
  int pid = fork();
  if(pid < 0) {
    printf("semkilltest: fork failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    // 子进程：阻塞在信号量上
    sem_wait(sem);
    // 如果能到这里说明被唤醒了（kill 后）
    exit(0);
  }
  
  // 父进程：等待子进程阻塞，然后 kill
  sleep(1);  // 等待子进程进入 wait
  kill(pid);
  
  int status;
  wait(&status);
  
  // 验证信号量可以正常操作（没有死锁）
  sem_post(sem);
  int val;
  sem_getvalue(sem, &val);
  
  if(val != 1) {
    printf("semkilltest: unexpected semaphore value %d after kill\n", val);
    exit(1);
  }
  
  sem_close(sem);
  printf("semkilltest: PASSED\n");
}

static int semstress_main(int argc, char *argv[])
{
  semstress_run();
  semkilltest();
  exit(0);
}
