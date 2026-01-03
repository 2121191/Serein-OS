// procshow.c - Stride Scheduler Visualization Dashboard (All-in-One Demo)
// 一体化演示：自动启动 worker 进程并实时可视化 Stride 调度公平性
// 自动退出，无需 Ctrl+C

#include "kernel/include/types.h"
#include "kernel/include/param.h"
#include "serein-user/user.h"

// 与内核一致的 pstat 结构
struct pstat {
  int inuse[NPROC];
  int pid[NPROC];
  int tickets[NPROC];
  unsigned long runticks[NPROC];
  char name[NPROC][16];
};

// 配置 5 个 worker
#define NUM_WORKERS 5
static int worker_pids[NUM_WORKERS];
static int worker_tickets[NUM_WORKERS] = {5, 10, 20, 40, 10};  // 不同票数
static int num_workers = 0;

// ANSI 转义序列
static void cls(void) {
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
  write(2, seq, sizeof(seq));
}

static void color_green(void) {
  char seq[] = {0x1b, '[', '3', '2', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_yellow(void) {
  char seq[] = {0x1b, '[', '3', '3', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_cyan(void) {
  char seq[] = {0x1b, '[', '3', '6', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_magenta(void) {
  char seq[] = {0x1b, '[', '3', '5', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_reset(void) {
  char seq[] = {0x1b, '[', '0', 'm'};
  write(2, seq, sizeof(seq));
}

static void print_bar(unsigned long value, unsigned long max, int width) {
  if(max == 0) max = 1;
  int filled = (int)((value * width) / max);
  if(filled > width) filled = width;
  
  color_green();
  for(int i = 0; i < filled; i++) {
    fprintf(2, "#");
  }
  color_reset();
  for(int i = filled; i < width; i++) {
    fprintf(2, ".");
  }
}

static void print_header(int round, int total) {
  color_cyan();
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|       Stride Scheduler Dashboard - Serein OS V3.0              |\n");
  fprintf(2, "|                     Round %d / %d                               |\n", round, total);
  fprintf(2, "+================================================================+\n");
  color_reset();
}

// CPU 密集型工作函数
static void cpu_worker(int tickets) {
  settickets(tickets);
  volatile unsigned long counter = 0;
  while(1) {
    counter++;
  }
}

// 启动 worker 进程
static void spawn_workers(void) {
  for(int i = 0; i < NUM_WORKERS; i++) {
    int pid = fork();
    if(pid == 0) {
      cpu_worker(worker_tickets[i]);
      exit(0);
    }
    worker_pids[num_workers++] = pid;
  }
}

// 终止所有 worker
static void kill_workers(void) {
  for(int i = 0; i < num_workers; i++) {
    kill(worker_pids[i]);
  }
  for(int i = 0; i < num_workers; i++) {
    wait(0);
  }
}

int main(int argc, char *argv[]) {
  int rounds = 10;  // 默认运行 10 轮
  
  if(argc >= 2) {
    rounds = atoi(argv[1]);
    if(rounds <= 0) rounds = 10;
    if(rounds > 30) rounds = 30;
  }
  
  // 注意：Ctrl+C (SIGINT) 使用默认行为，会终止进程
  // worker 进程在同一进程组，也会被终止
  
  cls();
  color_cyan();
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|            Stride Scheduler Visualization Demo                |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  fprintf(2, "\n");
  fprintf(2, "  Spawning %d CPU-bound workers with different tickets:\n\n", NUM_WORKERS);
  
  // 显示配置
  for(int i = 0; i < NUM_WORKERS; i++) {
    if(worker_tickets[i] >= 40) color_magenta();
    else if(worker_tickets[i] >= 20) color_green();
    else color_yellow();
    
    fprintf(2, "    Worker %d: tickets = %d", i+1, worker_tickets[i]);
    if(worker_tickets[i] == 40) fprintf(2, "  <-- 8x vs Worker1");
    else if(worker_tickets[i] == 20) fprintf(2, "  <-- 4x vs Worker1");
    else if(worker_tickets[i] == 10) fprintf(2, "  <-- 2x vs Worker1");
    else if(worker_tickets[i] == 5) fprintf(2, "  <-- baseline");
    fprintf(2, "\n");
    color_reset();
  }
  
  fprintf(2, "\n");
  fprintf(2, "  Expected: CPU time proportional to tickets (5:10:20:40:10)\n");
  fprintf(2, "\n");
  fprintf(2, "  Starting in 2 seconds... (auto-exit after %d rounds)\n", rounds);
  fprintf(2, "\n");
  
  sleep(200);
  
  // 启动 worker
  spawn_workers();
  fprintf(2, "  Workers spawned: PIDs = ");
  for(int i = 0; i < NUM_WORKERS; i++) {
    fprintf(2, "%d", worker_pids[i]);
    if(i < NUM_WORKERS - 1) fprintf(2, ", ");
  }
  fprintf(2, "\n");
  sleep(100);
  
  struct pstat ps;
  
  for(int r = 1; r <= rounds; r++) {
    
    if(getpinfo(&ps) < 0) {
      fprintf(2, "procshow: getpinfo failed\n");
      kill_workers();
      exit(1);
    }
    
    // 收集 worker 数据
    unsigned long worker_ticks[NUM_WORKERS];
    for(int w = 0; w < NUM_WORKERS; w++) worker_ticks[w] = 0;
    
    for(int i = 0; i < NPROC; i++) {
      if(!ps.inuse[i]) continue;
      for(int w = 0; w < NUM_WORKERS; w++) {
        if(ps.pid[i] == worker_pids[w]) {
          worker_ticks[w] = ps.runticks[i];
          break;
        }
      }
    }
    
    // 计算最大值
    unsigned long max_ticks = 1;
    for(int w = 0; w < NUM_WORKERS; w++) {
      if(worker_ticks[w] > max_ticks) max_ticks = worker_ticks[w];
    }
    
    // 清屏并显示
    cls();
    print_header(r, rounds);
    
    fprintf(2, "\n");
    fprintf(2, "  WORKER  TICKETS   TICKS       RUNTIME BAR (proportional)\n");
    fprintf(2, "  ------  -------   -----       ---------------------------\n");
    
    for(int w = 0; w < NUM_WORKERS; w++) {
      // 颜色编码
      if(worker_tickets[w] >= 40) color_magenta();
      else if(worker_tickets[w] >= 20) color_green();
      else color_yellow();
      
      fprintf(2, "  W%d       %d", w+1, worker_tickets[w]);
      // 手动对齐
      if(worker_tickets[w] < 10) fprintf(2, " ");
      fprintf(2, "       %l", worker_ticks[w]);
      
      // 手动填充空格
      int spaces = 8;
      unsigned long temp = worker_ticks[w];
      while(temp >= 10) { temp /= 10; spaces--; }
      for(int s = 0; s < spaces; s++) fprintf(2, " ");
      
      color_reset();
      print_bar(worker_ticks[w], max_ticks, 28);
      fprintf(2, "\n");
    }
    
    fprintf(2, "\n");
    color_cyan();
    fprintf(2, "  +------------------------------------------------------------+\n");
    color_reset();
    
    // 计算比例验证
    if(worker_ticks[0] > 0) {
      fprintf(2, "  Ratios vs W1: ");
      for(int w = 1; w < NUM_WORKERS; w++) {
        int ratio = (int)((worker_ticks[w] * 100) / worker_ticks[0]);
        int expected = (worker_tickets[w] * 100) / worker_tickets[0];
        
        if(ratio >= expected - 20 && ratio <= expected + 20) {
          color_green();
        } else {
          color_yellow();
        }
        fprintf(2, "W%d=%d%%", w+1, ratio);
        color_reset();
        if(w < NUM_WORKERS - 1) fprintf(2, " ");
      }
      fprintf(2, "\n");
      fprintf(2, "  Expected:     W2=200%% W3=400%% W4=800%% W5=200%%\n");
    }
    
    fprintf(2, "\n");
    fprintf(2, "  Auto-exit in %d rounds...\n", rounds - r);
    
    sleep(100);
  }
  
  // 演示完成
  color_green();
  fprintf(2, "\n  === Demo Complete! ===\n");
  color_reset();
  fprintf(2, "  Terminating workers...\n");
  
  kill_workers();
  
  fprintf(2, "  The Stride scheduler ensures fair CPU distribution!\n");
  fprintf(2, "  (CPU time is proportional to ticket count)\n\n");
  
  exit(0);
}
