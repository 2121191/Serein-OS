// serein-user/timer.c
#include "kernel/include/param.h"
#include "serein-user/user.h"

int main(int argc, char *argv[])
{
  if(argc <= 1){
    fprintf(2, "usage: timer command [args...]\n");
    exit(1);
  }

  int HZ = 390000000 / INTERVAL; // typically 200

  uint64 t0 = uptime();
  int pid = fork();
  if(pid < 0){
    fprintf(2, "timer: fork failed\n");
    exit(1);
  }
  if(pid == 0){
    exec(argv[1], &argv[1]);
    fprintf(2, "exec %s failed\n", argv[1]);
    exit(1);
  } else {
    wait(0);
    uint64 t1 = uptime();
    uint64 dt = t1 - t0;
    int total_ms = (int)(dt * 1000 / HZ);
    int secs = total_ms / 1000;
    int msecs = total_ms % 1000;
    // manual zero-pad milliseconds to 3 digits (since %03d unsupported)
    if (msecs < 10)
      printf("real %d.00%d s (%d ticks)\n", secs, msecs, (int)dt);
    else if (msecs < 100)
      printf("real %d.0%d s (%d ticks)\n", secs, msecs, (int)dt);
    else
      printf("real %d.%d s (%d ticks)\n", secs, msecs, (int)dt);
    exit(0);
  }
}