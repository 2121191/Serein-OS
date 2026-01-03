// ps.c - 显示进程状态和调度统计
#include "kernel/include/types.h"
#include "kernel/include/param.h"
#include "serein-user/user.h"

// 本地定义 pstat 结构（与内核一致）
struct pstat {
  int inuse[NPROC];
  int pid[NPROC];
  int tickets[NPROC];
  unsigned long runticks[NPROC];
  char name[NPROC][16];
};

int
main(int argc, char *argv[])
{
  struct pstat ps;
  int i;
  
  if(getpinfo(&ps) < 0) {
    printf("ps: getpinfo failed\n");
    exit(1);
  }
  
  printf("PID\tTICKETS\tTICKS\tNAME\n");
  for(i = 0; i < NPROC; i++) {
    if(ps.inuse[i]) {
      printf("%d\t%d\t%l\t%s\n", 
             ps.pid[i], 
             ps.tickets[i], 
             ps.runticks[i],
             ps.name[i]);
    }
  }
  
  exit(0);
}
