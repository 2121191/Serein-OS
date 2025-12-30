
#include "include/types.h"
#include "include/riscv.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/syscall.h"
#include "include/timer.h"
#include "include/kalloc.h"
#include "include/string.h"
#include "include/printf.h"
#include "include/sem.h"
#include "include/sched.h"
#include "include/vm.h"

extern int exec(char *path, char **argv);

uint64
sys_exec(void)
{
  char path[FAT32_MAX_PATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv)){
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
      goto bad;
    }
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    kfree(argv[i]);
  return -1;
}

uint64
sys_exit(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_getppid(void)
{
  struct proc *p = myproc();
  uint64 ppid;
  
  acquire(&p->lock);
  if(p->parent)
    ppid = p->parent->pid;
  else
    ppid = 0;
  release(&p->lock);
  
  return ppid;
}



// V2.2: 权限管理系统调用

uint64
sys_getuid(void)
{
  return myproc()->uid;
}

uint64
sys_setuid(void)
{
  int uid;
  struct proc *p = myproc();

  if(argint(0, &uid) < 0 || uid < 0 || uid > 32767)
    return -1;

  // 只有 root 可以切换到任意用户
  // 普通用户只能切换到自己 (no-op)
  if(p->uid != 0 && p->uid != uid)
    return -1;

  p->uid = uid;
  return 0;
}

uint64
sys_getgid(void)
{
  return myproc()->gid;
}

uint64
sys_setgid(void)
{
  int gid;
  struct proc *p = myproc();

  if(argint(0, &gid) < 0 || gid < 0 || gid > 32767)
    return -1;

  if(p->uid != 0 && p->gid != gid)
    return -1;

  p->gid = gid;
  return 0;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  if(argaddr(0, &p) < 0)
    return -1;
  return wait(p);
}

uint64
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

// V2.1: 发送指定信号到进程
uint64
sys_kill2(void)
{
  int pid, sig;

  if(argint(0, &pid) < 0 || argint(1, &sig) < 0)
    return -1;
  return kill_sig(pid, sig);
}

// V2.1: 设置信号处理器
// sigaction(int sig, void (*handler)(int))
// 返回: 0 成功, -1 失败
uint64
sys_sigaction(void)
{
  int sig;
  uint64 handler;
  struct proc *p = myproc();

  if(argint(0, &sig) < 0 || argaddr(1, &handler) < 0)
    return -1;
  
  printf("[sys_sigaction] pid=%d sig=%d handler=%p\n", p->pid, sig, handler);
  
  // 验证信号范围
  if(sig < 1 || sig >= NSIG)
    return -1;
  
  // SIGKILL 和 SIGSTOP 不可捕获
  if(sig == SIGKILL || sig == SIGSTOP)
    return -1;
  
  // 设置处理器
  p->sig_handlers[sig] = (void (*)(int))handler;
  return 0;
}

// V2.1: 从信号处理器返回，恢复原始上下文
uint64
sys_sigreturn(void)
{
  struct proc *p = myproc();
  struct sigframe frame;
  
  // 从保存的地址读取 sigframe
  uint64 frame_addr = p->sig_frame_addr;
  printf("[sigreturn] pid=%d frame_addr=%p\n", p->pid, frame_addr);
  
  if(frame_addr == 0) {
    printf("[sigreturn] ERROR: no active frame!\n");
    return -1;  // 没有活跃的信号帧
  }
  
  if(copyin(p->pagetable, (char*)&frame, frame_addr, sizeof(frame)) < 0) {
    printf("[sigreturn] ERROR: copyin failed!\n");
    return -1;
  }
  
  printf("[sigreturn] restoring epc=%p, signo=%d\n", frame.epc, frame.signo);
  
  // 恢复寄存器
  p->trapframe->ra = frame.ra;
  p->trapframe->sp = frame.sp;
  p->trapframe->gp = frame.gp;
  p->trapframe->tp = frame.tp;
  p->trapframe->t0 = frame.t0;
  p->trapframe->t1 = frame.t1;
  p->trapframe->t2 = frame.t2;
  p->trapframe->s0 = frame.s0;
  p->trapframe->s1 = frame.s1;
  p->trapframe->a0 = frame.a0;
  p->trapframe->a1 = frame.a1;
  p->trapframe->a2 = frame.a2;
  p->trapframe->a3 = frame.a3;
  p->trapframe->a4 = frame.a4;
  p->trapframe->a5 = frame.a5;
  p->trapframe->a6 = frame.a6;
  p->trapframe->a7 = frame.a7;
  p->trapframe->s2 = frame.s2;
  p->trapframe->s3 = frame.s3;
  p->trapframe->s4 = frame.s4;
  p->trapframe->s5 = frame.s5;
  p->trapframe->s6 = frame.s6;
  p->trapframe->s7 = frame.s7;
  p->trapframe->s8 = frame.s8;
  p->trapframe->s9 = frame.s9;
  p->trapframe->s10 = frame.s10;
  p->trapframe->s11 = frame.s11;
  p->trapframe->t3 = frame.t3;
  p->trapframe->t4 = frame.t4;
  p->trapframe->t5 = frame.t5;
  p->trapframe->t6 = frame.t6;
  
  // 恢复 epc（程序返回地址）
  p->trapframe->epc = frame.epc;
  
  // 恢复信号阻塞掩码
  p->sig_blocked = frame.sig_blocked_saved;
  
  // 清除信号帧地址
  p->sig_frame_addr = 0;
  
  // 返回原始 a0 值
  return frame.a0;
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64
sys_trace(void)
{
  int mask;
  if(argint(0, &mask) < 0) {
    return -1;
  }
  myproc()->tmask = mask;
  return 0;
}

// Semaphore system calls

uint64
sys_sem_open(void)
{
  int initial_value;
  
  if(argint(0, &initial_value) < 0) {
    return -1;
  }
  
  // Allocate semaphore and return its index
  return semalloc(initial_value);
}

uint64
sys_sem_wait(void)
{
  int sem_id;
  struct sem *sem;
  
  if(argint(0, &sem_id) < 0) {
    return -1;
  }
  
  sem = semget(sem_id);
  if(sem == 0) {
    return -1;  // Invalid semaphore ID
  }
  
  semwait(sem);
  return 0;
}

uint64
sys_sem_post(void)
{
  int sem_id;
  struct sem *sem;
  
  if(argint(0, &sem_id) < 0) {
    return -1;
  }
  
  sem = semget(sem_id);
  if(sem == 0) {
    return -1;  // Invalid semaphore ID
  }
  
  sempost(sem);
  return 0;
}

uint64
sys_sem_close(void)
{
  int sem_id;
  struct sem *sem;
  
  if(argint(0, &sem_id) < 0) {
    return -1;
  }
  
  sem = semget(sem_id);
  if(sem == 0) {
    return -1;  // Invalid semaphore ID
  }
  
  semfree(sem);
  return 0;
}

uint64
sys_sem_getvalue(void)
{
  int sem_id;
  uint64 value_addr;
  int value;
  struct sem *sem;
  
  if(argint(0, &sem_id) < 0 || argaddr(1, &value_addr) < 0) {
    return -1;
  }
  
  sem = semget(sem_id);
  if(sem == 0) {
    return -1;  // Invalid semaphore ID
  }
  
  if(semgetvalue(sem, &value) < 0) {
    return -1;
  }
  
  // Copy value to user space
  if(copyout2(value_addr, (char *)&value, sizeof(value)) < 0) {
    return -1;
  }
  
  return 0;
}
// 设置当前进程的票数权重 (Stride 调度)
uint64
sys_settickets(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  
  // 边界检查：票数必须在合法范围内
  if(n < MIN_TICKETS || n > MAX_TICKETS)
    return -1;
  
  struct proc *p = myproc();
  p->tickets = n;
  p->stride = STRIDE_LARGE / n;  // 重新计算 stride
  return 0;
}

// 获取所有进程的统计信息
extern struct proc proc[];

uint64
sys_getpinfo(void)
{
  uint64 addr;
  struct pstat ps;
  struct proc *p;
  int i;
  
  if(argaddr(0, &addr) < 0)
    return -1;
  
  // 清零
  memset(&ps, 0, sizeof(ps));
  
  // 填充进程信息
  for(i = 0, p = proc; p < &proc[NPROC]; p++, i++) {
    acquire(&p->lock);
    if(p->state != UNUSED) {
      ps.inuse[i] = 1;
      ps.pid[i] = p->pid;
      ps.tickets[i] = p->tickets;
      ps.runticks[i] = p->runticks;
      memmove(ps.name[i], p->name, 16);
    }
    release(&p->lock);
  }
  
  // 复制到用户空间
  if(copyout2(addr, (char *)&ps, sizeof(ps)) < 0)
    return -1;
  
  return 0;
}

// 等待指定子进程
uint64
sys_waitpid(void)
{
  int pid;
  uint64 addr;
  int options;
  
  if(argint(0, &pid) < 0)
    return -1;
  if(argaddr(1, &addr) < 0)
    return -1;
  if(argint(2, &options) < 0)
    return -1;
  
  return waitpid(pid, addr, options);
}