#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/param.h"
#include "kernel/include/sysinfo.h"
#include "user.h"

static void
print_sysinfo_mem(const char *tag)
{
  struct sysinfo info;
  if(sysinfo(&info) < 0){
    printf("sysinfo failed\n");
    return;
  }

  uint total_kb = 128U * 1024U; // 128MB
  uint free_kb = (uint)(info.freemem / 1024);
  uint used_kb = (total_kb > free_kb) ? (total_kb - free_kb) : 0;
  int used_percent = (total_kb == 0) ? 0 : (int)((used_kb * 100U) / total_kb);

  printf("\n[%s]\n", tag);
  printf("tick=%d proc=%d free=%dKB used=%dKB (%d%%)\n",
         (int)info.uptime,
         (int)info.nproc,
         (int)free_kb,
         (int)used_kb,
         used_percent);
  printf("events: cow_faults=%d\n", (int)info.cow_pages);
}

static void
test_lazy_and_cow(void)
{
  printf("Running memory tests (lazy alloc + COW)...\n");
  print_sysinfo_mem("initial state");

  // Lazy allocation
  printf("\n=== Testing Lazy Allocation ===\n");
  int np = 16; // 16 pages = 64KB
  printf("sbrk(%d KB) without touching...\n", (np * 4096) / 1024);
  char *p = sbrk(np * 4096);
  if(p == (char*)-1){
    printf("sbrk failed\n");
    return;
  }
  print_sysinfo_mem("after sbrk (before touch)");

  printf("touching pages...\n");
  for(int i = 0; i < np; i++)
    p[i * 4096] = (char)i;
  print_sysinfo_mem("after touching pages");

  // COW
  printf("\n=== Testing Copy-on-Write ===\n");
  printf("forking...\n");
  int pid = fork();
  if(pid < 0){
    printf("fork failed\n");
    return;
  }

  if(pid == 0){
    for(int i = 0; i < np; i++)
      p[i * 4096] = (char)(i + 1);
    exit(0);
  }

  wait(0);
  print_sysinfo_mem("parent after child COW");

  // cleanup
  sbrk(-np * 4096);
  print_sysinfo_mem("after sbrk(-size)");

  printf("\nTests completed.\n");
}

static void
print_header(void)
{
  printf("vmstat monitor: use vmstat [sec] [n]\n");
  printf("%-6s %-7s %-6s %-5s %-5s\n",
         "tick",
         "freeKB",
         "used%",
         "proc",
         "cow");
  printf("--------------------------------\n");
}

static void
monitor_vmstat(int delay_sec, int rounds)
{
  struct sysinfo prev;
  for(uint i = 0; i < sizeof(prev); i++)
    ((char*)&prev)[i] = 0;

  if(sysinfo(&prev) < 0){
    printf("vmstat: sysinfo failed\n");
    exit(1);
  }

  print_header();

  while(rounds-- > 0){
    struct sysinfo cur;
    if(sysinfo(&cur) < 0){
      printf("vmstat: sysinfo failed\n");
      exit(1);
    }

    uint total_kb = 128U * 1024U;
    uint free_kb = (uint)(cur.freemem / 1024);
    uint used_kb = (total_kb > free_kb) ? (total_kb - free_kb) : 0;
    int used_percent = (total_kb == 0) ? 0 : (int)((used_kb * 100U) / total_kb);

    printf("%-6d %-7d %3d%%   %-5d %-5d\n",
           (int)cur.uptime,
           (int)free_kb,
           used_percent,
           (int)cur.nproc,
           (int)cur.cow_pages);

    int dA0 = (int)(cur.kalloc_stats[0].nalloc - prev.kalloc_stats[0].nalloc);
    int dF0 = (int)(cur.kalloc_stats[0].nfree  - prev.kalloc_stats[0].nfree);
    int dS0 = (int)(cur.kalloc_stats[0].nsteal - prev.kalloc_stats[0].nsteal);
    int dA1 = 0, dF1 = 0, dS1 = 0;
    if(NCPU > 1){
      dA1 = (int)(cur.kalloc_stats[1].nalloc - prev.kalloc_stats[1].nalloc);
      dF1 = (int)(cur.kalloc_stats[1].nfree  - prev.kalloc_stats[1].nfree);
      dS1 = (int)(cur.kalloc_stats[1].nsteal - prev.kalloc_stats[1].nsteal);
    }
    printf("       kalloc delta: cpu0 %d/%d/%d  cpu1 %d/%d/%d\n",
           dA0, dF0, dS0, dA1, dF1, dS1);

    prev = cur;
    if(rounds > 0)
      sleep(delay_sec * 100);
  }
}

int
main(int argc, char *argv[])
{
  // 无参数：跑测试，且显示 mem 输出
  if(argc == 1){
    test_lazy_and_cow();
    exit(0);
  }

  // 有参数：监控模式，不输出 mem 详细信息（只输出表格）
  int delay_sec = 1;
  int rounds = 10;

  if(argc >= 2){
    delay_sec = atoi(argv[1]);
    if(delay_sec <= 0) delay_sec = 1;
  }
  if(argc >= 3){
    rounds = atoi(argv[2]);
    if(rounds <= 0) rounds = 1;
  }

  monitor_vmstat(delay_sec, rounds);
  exit(0);
}
