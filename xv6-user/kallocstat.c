#include "user.h"
#include "kernel/include/sysinfo.h"

static void
print_kalloc_stats(struct sysinfo *info)
{
  printf("freemem=%d bytes, nproc=%d\n", (int)info->freemem, (int)info->nproc);
  printf("per-cpu kalloc stats:\n");
  for(int i = 0; i < NCPU; i++){
    printf("  cpu%d: alloc=%d free=%d steal=%d\n",
           i,
           (int)info->kalloc_stats[i].nalloc,
           (int)info->kalloc_stats[i].nfree,
           (int)info->kalloc_stats[i].nsteal);
  }
}

int
main(int argc, char *argv[])
{
  struct sysinfo info;
  if(sysinfo(&info) < 0){
    printf("kallocstat: sysinfo failed\n");
    exit(1);
  }
  print_kalloc_stats(&info);
  exit(0);
}

