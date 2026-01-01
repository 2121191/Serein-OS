
#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/syscall.h"
#include "include/sysinfo.h"
#include "include/kalloc.h"
#include "include/vm.h"
#include "include/string.h"
#include "include/printf.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
  struct proc *p = myproc();
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    return -1;
  // if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
  if(copyin2((char *)ip, addr, sizeof(*ip)) != 0)
    return -1;
  return 0;
}

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
  struct proc *p = myproc();
  int err = copyinstr(p->pagetable, buf, addr, max);
  // int err = copyinstr2(buf, addr, max);
  if(err < 0)
    return err;
  return strlen(buf);
}

static uint64
argraw(int n)
{
  struct proc *p = myproc();
  switch (n) {
  case 0:
    return p->trapframe->a0;
  case 1:
    return p->trapframe->a1;
  case 2:
    return p->trapframe->a2;
  case 3:
    return p->trapframe->a3;
  case 4:
    return p->trapframe->a4;
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  *ip = argraw(n);
  return 0;
}

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
  *ip = argraw(n);
  return 0;
}

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
}

extern uint64 sys_chdir(void);
extern uint64 sys_close(void);
extern uint64 sys_dup(void);
extern uint64 sys_exec(void);
extern uint64 sys_exit(void);
extern uint64 sys_fork(void);
extern uint64 sys_fstat(void);
extern uint64 sys_getpid(void);
extern uint64 sys_kill(void);
extern uint64 sys_mkdir(void);
extern uint64 sys_open(void);
extern uint64 sys_pipe(void);
extern uint64 sys_read(void);
extern uint64 sys_sbrk(void);
extern uint64 sys_sleep(void);
extern uint64 sys_wait(void);
extern uint64 sys_write(void);
extern uint64 sys_uptime(void);
extern uint64 sys_test_proc(void);
extern uint64 sys_dev(void);
extern uint64 sys_readdir(void);
extern uint64 sys_getcwd(void);
extern uint64 sys_remove(void);
extern uint64 sys_trace(void);
extern uint64 sys_sysinfo(void);
extern uint64 sys_rename(void);
extern uint64 sys_sem_open(void);
extern uint64 sys_sem_wait(void);
extern uint64 sys_sem_post(void);
extern uint64 sys_sem_close(void);
extern uint64 sys_sem_getvalue(void);
extern uint64 sys_settickets(void);
extern uint64 sys_getpinfo(void);
extern uint64 sys_waitpid(void);
extern uint64 sys_shmcreate(void);
extern uint64 sys_shmopen(void);
extern uint64 sys_shmattach(void);
extern uint64 sys_shmdetach(void);
extern uint64 sys_shmunlink(void);
extern uint64 sys_mmap(void);
extern uint64 sys_munmap(void);
extern uint64 sys_kill2(void);  // V2.1
extern uint64 sys_sigaction(void);  // V2.1
extern uint64 sys_sigreturn(void);  // V2.1
extern uint64 sys_lseek(void);      // V2.2
extern uint64 sys_dup2(void);       // V2.2
extern uint64 sys_getppid(void);    // V2.2
extern uint64 sys_getuid(void);     // V2.2
extern uint64 sys_setuid(void);     // V2.2
extern uint64 sys_getgid(void);     // V2.2
extern uint64 sys_setgid(void);     // V2.2
extern uint64 sys_getpgid(void);    // V2.2
extern uint64 sys_setpgid(void);    // V2.2
extern uint64 sys_tcgetpgrp(void);  // V2.2C
extern uint64 sys_tcsetpgrp(void);  // V2.2C
extern uint64 sys_pipe2(void);      // V3.0 (Task 12)
extern uint64 sys_mincore(void);     // V3.1
extern uint64 sys_alarm(void);       // V3.0: SIGALRM 定时器
extern uint64 sys_poll(void);        // V3.0: I/O 多路复用
extern uint64 sys_fcntl(void);       // V3.0: 文件描述符控制
extern uint64 sys_chmod(void);       // V3.0: 更改文件权限
extern uint64 sys_fchmod(void);      // V3.0: 更改 fd 权限
extern uint64 sys_clone(void);       // V3.0: 创建线程/进程
extern uint64 sys_futex(void);       // V3.0: 快速用户空间互斥锁
extern uint64 sys_exit_group(void);  // V3.0: 退出线程组
extern uint64 sys_halt(void);        // V3.1: 关机
extern uint64 sys_reboot(void);      // V3.1: 重启

static uint64 (*syscalls[])(void) = {
  [SYS_fork]        sys_fork,
  [SYS_exit]        sys_exit,
  [SYS_wait]        sys_wait,
  [SYS_pipe]        sys_pipe,
  [SYS_read]        sys_read,
  [SYS_kill]        sys_kill,
  [SYS_exec]        sys_exec,
  [SYS_fstat]       sys_fstat,
  [SYS_chdir]       sys_chdir,
  [SYS_dup]         sys_dup,
  [SYS_getpid]      sys_getpid,
  [SYS_sbrk]        sys_sbrk,
  [SYS_sleep]       sys_sleep,
  [SYS_uptime]      sys_uptime,
  [SYS_open]        sys_open,
  [SYS_write]       sys_write,
  [SYS_mkdir]       sys_mkdir,
  [SYS_close]       sys_close,
  [SYS_test_proc]   sys_test_proc,
  [SYS_dev]         sys_dev,
  [SYS_readdir]     sys_readdir,
  [SYS_getcwd]      sys_getcwd,
  [SYS_remove]      sys_remove,
  [SYS_trace]       sys_trace,
  [SYS_sysinfo]     sys_sysinfo,
  [SYS_rename]      sys_rename,
  [SYS_sem_open]    sys_sem_open,
  [SYS_sem_wait]    sys_sem_wait,
  [SYS_sem_post]    sys_sem_post,
  [SYS_sem_close]   sys_sem_close,
  [SYS_sem_getvalue] sys_sem_getvalue,
  [SYS_settickets]  sys_settickets,
  [SYS_getpinfo]    sys_getpinfo,
  [SYS_waitpid]     sys_waitpid,
  [SYS_shmcreate]   sys_shmcreate,
  [SYS_shmopen]     sys_shmopen,
  [SYS_shmattach]   sys_shmattach,
  [SYS_shmdetach]   sys_shmdetach,
  [SYS_shmunlink]   sys_shmunlink,
  [SYS_mmap]        sys_mmap,
  [SYS_munmap]      sys_munmap,
  [SYS_kill2]       sys_kill2,
  [SYS_sigaction]   sys_sigaction,
  [SYS_sigreturn]   sys_sigreturn,
  [SYS_lseek]       sys_lseek,
  [SYS_dup2]        sys_dup2,
  [SYS_getppid]     sys_getppid,
  [SYS_getuid]      sys_getuid,
  [SYS_setuid]      sys_setuid,
  [SYS_getgid]      sys_getgid,
  [SYS_setgid]      sys_setgid,
  [SYS_getpgid]     sys_getpgid,
  [SYS_setpgid]     sys_setpgid,
  [SYS_tcgetpgrp]   sys_tcgetpgrp,
  [SYS_tcsetpgrp]   sys_tcsetpgrp,
  [SYS_pipe2]       sys_pipe2,
  [SYS_mincore]     sys_mincore,
  [SYS_alarm]       sys_alarm,
  [SYS_poll]        sys_poll,
  [SYS_fcntl]       sys_fcntl,
  [SYS_chmod]       sys_chmod,
  [SYS_fchmod]      sys_fchmod,
  [SYS_clone]       sys_clone,
  [SYS_futex]       sys_futex,
  [SYS_exit_group]  sys_exit_group,
  [SYS_halt]        sys_halt,
  [SYS_reboot]      sys_reboot,
};

static char *sysnames[] = {
  [SYS_fork]        "fork",
  [SYS_exit]        "exit",
  [SYS_wait]        "wait",
  [SYS_pipe]        "pipe",
  [SYS_read]        "read",
  [SYS_kill]        "kill",
  [SYS_exec]        "exec",
  [SYS_fstat]       "fstat",
  [SYS_chdir]       "chdir",
  [SYS_dup]         "dup",
  [SYS_getpid]      "getpid",
  [SYS_sbrk]        "sbrk",
  [SYS_sleep]       "sleep",
  [SYS_uptime]      "uptime",
  [SYS_open]        "open",
  [SYS_write]       "write",
  [SYS_mkdir]       "mkdir",
  [SYS_close]       "close",
  [SYS_test_proc]   "test_proc",
  [SYS_dev]         "dev",
  [SYS_readdir]     "readdir",
  [SYS_getcwd]      "getcwd",
  [SYS_remove]      "remove",
  [SYS_trace]       "trace",
  [SYS_sysinfo]     "sysinfo",
  [SYS_rename]      "rename",
  [SYS_sem_open]    "sem_open",
  [SYS_sem_wait]    "sem_wait",
  [SYS_sem_post]    "sem_post",
  [SYS_sem_close]   "sem_close",
  [SYS_sem_getvalue] "sem_getvalue",
  [SYS_settickets]  "settickets",
  [SYS_getpinfo]    "getpinfo",
  [SYS_waitpid]     "waitpid",
  [SYS_shmcreate]   "shmcreate",
  [SYS_shmopen]     "shmopen",
  [SYS_shmattach]   "shmattach",
  [SYS_shmdetach]   "shmdetach",
  [SYS_shmunlink]   "shmunlink",
  [SYS_mmap]        "mmap",
  [SYS_munmap]      "munmap",
  [SYS_kill2]       "kill2",
  [SYS_sigaction]   "sigaction",
  [SYS_sigreturn]   "sigreturn",
  [SYS_lseek]       "lseek",
  [SYS_dup2]        "dup2",
  [SYS_getppid]     "getppid",
  [SYS_getuid]      "getuid",
  [SYS_setuid]      "setuid",
  [SYS_getgid]      "getgid",
  [SYS_setgid]      "setgid",
  [SYS_getpgid]     "getpgid",
  [SYS_setpgid]     "setpgid",
  [SYS_mincore]     "mincore",
  [SYS_alarm]       "alarm",
  [SYS_poll]        "poll",
  [SYS_fcntl]       "fcntl",
  [SYS_chmod]       "chmod",
  [SYS_fchmod]      "fchmod",
  [SYS_clone]       "clone",
  [SYS_futex]       "futex",
  [SYS_exit_group]  "exit_group",
  [SYS_halt]        "halt",
  [SYS_reboot]      "reboot",
};

void
syscall(void)
{
  int num;
  struct proc *p = myproc();

  num = p->trapframe->a7;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    p->trapframe->a0 = syscalls[num]();
        // trace
    if ((p->tmask & (1 << num)) != 0) {
      printf("pid %d: %s -> %d\n", p->pid, sysnames[num], p->trapframe->a0);
    }
  } else {
    printf("pid %d %s: unknown sys call %d\n",
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
  }
}

uint64 
sys_test_proc(void) {
    int n;
    argint(0, &n);
    printf("hello world from proc %d, hart %d, arg %d\n", myproc()->pid, r_tp(), n);
    return 0;
}

uint64
sys_sysinfo(void)
{
  uint64 addr;
  // struct proc *p = myproc();

  if (argaddr(0, &addr) < 0) {
    return -1;
  }

  struct sysinfo info;
  info.freemem = freemem_amount();
  info.nproc = procnum();
  extern uint ticks;
  info.uptime = ticks;
  info.cow_pages = kcow_pages();
  info.shm_pages = kshm_pages();
  info.mmap_pages = kmmap_pages();
  kalloc_stats_copyout(&info.kalloc_stats);

  // if (copyout(p->pagetable, addr, (char *)&info, sizeof(info)) < 0) {
  if (copyout2(addr, (char *)&info, sizeof(info)) < 0) {
    return -1;
  }

  return 0;
}