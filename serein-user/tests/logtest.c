#include "serein-user/user.h"

static int logtest_main(int argc, char **argv)
{
  printf("logtest: hello from user, pid=%d\n", getpid());

  fprintf(2, "logtest: stderr output works too\n");

  // 也可以触发一个 syscall 输出（看内核是否还能正常工作）
  int t = uptime();
  printf("logtest: uptime=%d\n", t);

  exit(0);
}