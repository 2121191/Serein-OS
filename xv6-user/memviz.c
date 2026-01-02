// memviz.c - Memory Management Visualization Demo
// 一体化演示：Lazy Allocation 和 Copy-on-Write 的可视化展示
// 使用 sysinfo() 和 mincore() 实时跟踪内存状态

#include "kernel/include/types.h"
#include "kernel/include/param.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"

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

// 获取内存统计
static void get_mem_stats(uint *free_kb, uint *cow_faults) {
  struct sysinfo info;
  if(sysinfo(&info) < 0) {
    *free_kb = 0;
    *cow_faults = 0;
    return;
  }
  *free_kb = (uint)(info.freemem / 1024);
  *cow_faults = (uint)info.cow_pages;
}

// 注意：Ctrl+C (SIGINT) 使用默认行为，会直接终止进程

// 演示 1: Lazy Allocation
static void demo_lazy_allocation(void) {
  color_cyan();
  fprintf(2, "\n");
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|              DEMO 1: Lazy Allocation (懒加载)                 |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  
  uint free_before, cow_before;
  get_mem_stats(&free_before, &cow_before);
  
  fprintf(2, "\n");
  fprintf(2, "  Initial free memory: %d KB\n", free_before);
  fprintf(2, "\n");
  
  // 分配 16 页 = 64KB
  int num_pages = 16;
  int alloc_size = num_pages * 4096;
  
  fprintf(2, "  Step 1: sbrk(%d KB) - Requesting virtual memory...\n", alloc_size / 1024);
  sleep(100);
  
  char *mem = sbrk(alloc_size);
  if(mem == (char*)-1) {
    fprintf(2, "  ERROR: sbrk failed!\n");
    return;
  }
  
  uint free_after_sbrk, cow_temp;
  get_mem_stats(&free_after_sbrk, &cow_temp);
  
  fprintf(2, "\n");
  color_yellow();
  fprintf(2, "  [LAZY] Virtual address allocated: %p\n", mem);
  fprintf(2, "  [LAZY] Free memory: %d KB (should be SAME as before!)\n", free_after_sbrk);
  color_reset();
  
  if(free_after_sbrk >= free_before - 4) {
    color_green();
    fprintf(2, "  [OK] No physical pages allocated yet! (Lazy Allocation works)\n");
    color_reset();
  }
  
  fprintf(2, "\n");
  fprintf(2, "  Step 2: Touching pages one by one...\n");
  fprintf(2, "\n");
  
  // 逐页触摸，观察物理内存消耗
  for(int i = 0; i < num_pages; i++) {
    mem[i * 4096] = (char)i;  // 触摸页面触发 page fault
    
    uint free_now, cow_now;
    get_mem_stats(&free_now, &cow_now);
    
    // 打印进度
    fprintf(2, "  Touched page %d: Free=%d KB  ", i + 1, free_now);
    fprintf(2, "[");
    for(int j = 0; j <= i; j++) {
      color_green();
      fprintf(2, "#");
      color_reset();
    }
    for(int j = i + 1; j < num_pages; j++) {
      fprintf(2, ".");
    }
    fprintf(2, "]\n");
    
    sleep(30);  // 短暂延迟便于观察
  }
  
  uint free_final, cow_final;
  get_mem_stats(&free_final, &cow_final);
  
  fprintf(2, "\n");
  color_green();
  fprintf(2, "  === Lazy Allocation Demo Complete ===\n");
  color_reset();
  fprintf(2, "  Memory consumed: %d KB (for %d pages)\n", 
          free_before - free_final, num_pages);
  
  // 释放内存
  sbrk(-alloc_size);
  sleep(50);
}

// 演示 2: Copy-on-Write
static void demo_cow(void) {
  color_cyan();
  fprintf(2, "\n");
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|             DEMO 2: Copy-on-Write (写时复制)                  |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  
  // 先分配一些内存并写入数据
  int num_pages = 8;
  int alloc_size = num_pages * 4096;
  
  fprintf(2, "\n");
  fprintf(2, "  Step 1: Parent allocates %d pages and writes data...\n", num_pages);
  sleep(100);
  
  char *mem = sbrk(alloc_size);
  if(mem == (char*)-1) {
    fprintf(2, "  ERROR: sbrk failed!\n");
    return;
  }
  
  // 写入数据确保页面已分配
  for(int i = 0; i < num_pages; i++) {
    mem[i * 4096] = 'P';  // Parent's data
  }
  
  uint free_before_fork, cow_before_fork;
  get_mem_stats(&free_before_fork, &cow_before_fork);
  
  fprintf(2, "  Parent memory allocated. Free: %d KB\n", free_before_fork);
  fprintf(2, "  COW faults so far: %d\n", cow_before_fork);
  fprintf(2, "\n");
  
  fprintf(2, "  Step 2: fork() - Child shares parent's pages (COW)...\n");
  sleep(100);
  
  int pid = fork();
  
  if(pid < 0) {
    fprintf(2, "  ERROR: fork failed!\n");
    sbrk(-alloc_size);
    return;
  }
  
  if(pid == 0) {
    // 子进程
    sleep(50);  // 让父进程先打印
    
    uint free_child, cow_child;
    get_mem_stats(&free_child, &cow_child);
    
    fprintf(2, "\n");
    color_magenta();
    fprintf(2, "  [Child] I'm the child process (PID=%d)\n", getpid());
    fprintf(2, "  [Child] Free memory: %d KB (should be similar - pages shared!)\n", free_child);
    color_reset();
    
    fprintf(2, "\n");
    fprintf(2, "  Step 3: Child writes to pages (triggers COW faults)...\n");
    fprintf(2, "\n");
    
    // 子进程逐页写入，触发 COW
    for(int i = 0; i < num_pages; i++) {
      uint cow_before, cow_after;
      get_mem_stats(&free_child, &cow_before);
      
      mem[i * 4096] = 'C';  // Child's data - triggers COW!
      
      get_mem_stats(&free_child, &cow_after);
      
      color_yellow();
      fprintf(2, "  [Child] Wrote page %d: COW faults: %d -> %d  ", 
              i + 1, cow_before, cow_after);
      
      // 可视化
      fprintf(2, "[");
      for(int j = 0; j <= i; j++) {
        color_magenta();
        fprintf(2, "C");  // Child's private copy
        color_reset();
      }
      for(int j = i + 1; j < num_pages; j++) {
        color_green();
        fprintf(2, "S");  // Still shared
        color_reset();
      }
      fprintf(2, "]\n");
      color_reset();
      
      sleep(50);
    }
    
    fprintf(2, "\n");
    color_green();
    fprintf(2, "  [Child] All pages now private copies!\n");
    color_reset();
    
    exit(0);
  } else {
    // 父进程
    uint free_after_fork, cow_after_fork;
    get_mem_stats(&free_after_fork, &cow_after_fork);
    
    color_cyan();
    fprintf(2, "  [Parent] Forked child PID=%d\n", pid);
    fprintf(2, "  [Parent] Free memory: %d KB (minimal change - COW!)\n", free_after_fork);
    color_reset();
    
    // 等待子进程完成
    wait(0);
    
    uint free_final, cow_final;
    get_mem_stats(&free_final, &cow_final);
    
    fprintf(2, "\n");
    color_green();
    fprintf(2, "  === Copy-on-Write Demo Complete ===\n");
    color_reset();
    fprintf(2, "  Total COW faults: %d (should be ~%d)\n", 
            cow_final - cow_before_fork, num_pages);
    fprintf(2, "  Memory saved by COW during fork: ~%d KB\n", alloc_size / 1024);
    
    // 清理
    sbrk(-alloc_size);
  }
}

int main(int argc, char *argv[]) {
  // 注意：Ctrl+C 使用默认 SIGINT 行为，直接终止进程
  
  cls();
  
  color_cyan();
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|         Memory Management Visualization - xv6-k210            |\n");
  fprintf(2, "|              Lazy Allocation & Copy-on-Write                  |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  
  fprintf(2, "\n");
  fprintf(2, "  This demo shows two key memory optimization techniques:\n");
  fprintf(2, "\n");
  color_yellow();
  fprintf(2, "  1. Lazy Allocation: sbrk() doesn't allocate physical pages\n");
  fprintf(2, "     until they are actually accessed (page fault)\n");
  color_reset();
  fprintf(2, "\n");
  color_magenta();
  fprintf(2, "  2. Copy-on-Write: fork() shares parent's pages with child,\n");
  fprintf(2, "     copies only when written (COW fault)\n");
  color_reset();
  fprintf(2, "\n");
  fprintf(2, "  Starting demos in 2 seconds...\n");
  
  sleep(200);
  
  // 运行演示
  demo_lazy_allocation();
  
  sleep(100);
  
  demo_cow();
  
  fprintf(2, "\n");
  color_cyan();
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|                    All Demos Complete!                        |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  fprintf(2, "\n");
  
  exit(0);
}
