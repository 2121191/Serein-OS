// stressload.c - CPU Stress Loader for Scheduler Visualization
// 启动多个 CPU 密集型进程，设置不同的 tickets，用于演示 Stride 调度公平性

#include "kernel/include/types.h"
#include "xv6-user/user.h"

// 简单的 CPU 密集型工作
static void
cpu_burn(int id, int tickets)
{
  // 设置票数
  settickets(tickets);
  
  // 无限循环消耗 CPU
  volatile unsigned long counter = 0;
  while(1) {
    counter++;
    // 每隔一段时间让出 CPU，避免完全占用
    if((counter & 0xFFFFF) == 0) {
      // 偶尔打印状态（可选，注释掉以避免干扰可视化）
      // printf("Worker %d (tickets=%d): %d\n", id, tickets, (int)(counter >> 20));
    }
  }
}

int
main(int argc, char *argv[])
{
  printf("=== Stride Scheduler Demo ===\n");
  printf("Spawning 3 workers with different tickets...\n\n");
  printf("  Worker 1: tickets = 10 (低优先级)\n");
  printf("  Worker 2: tickets = 20 (中优先级)\n");
  printf("  Worker 3: tickets = 10 (低优先级)\n\n");
  printf("预期结果: Worker 2 获得约 50%% CPU 时间, Worker 1 和 3 各约 25%%\n\n");
  printf("请在另一个终端运行 'procshow' 查看可视化效果\n");
  printf("按 Ctrl+C 可终止所有 worker\n\n");
  
  int pid1 = fork();
  if(pid1 == 0) {
    cpu_burn(1, 10);
    exit(0);
  }
  
  int pid2 = fork();
  if(pid2 == 0) {
    cpu_burn(2, 20);
    exit(0);
  }
  
  int pid3 = fork();
  if(pid3 == 0) {
    cpu_burn(3, 10);
    exit(0);
  }
  
  printf("Workers started: PIDs = %d, %d, %d\n", pid1, pid2, pid3);
  printf("Parent waiting... (press Ctrl+C to stop)\n");
  
  // 父进程等待
  wait(0);
  wait(0);
  wait(0);
  
  printf("All workers finished.\n");
  exit(0);
}
