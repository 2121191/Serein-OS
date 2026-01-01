#include "include/types.h"
#include "include/riscv.h"
#include "include/param.h"
#include "kernel/include/memlayout.h"
#include "kernel/include/spinlock.h"
#include "kernel/include/proc.h"
#include "kernel/include/syscall.h"
#include "kernel/include/sysnum.h"
#include "kernel/include/sysnum.h"
#include "kernel/include/sbi.h" // V3.1: For power management
#include "include/timer.h"
#include "include/kalloc.h"
#include "include/string.h"
#include "include/printf.h"
#include "include/sem.h"
#include "include/sched.h"
#include "include/vm.h"
#include "include/sysinfo.h"

extern int exec(char *path, char **argv);
extern struct proc proc[NPROC];

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

// V2.2: 进程组管理系统调用

uint64
sys_getpgid(void)
{
  int pid;
  struct proc *p;

  if(argint(0, &pid) < 0)
    return -1;

  // pid == 0 表示获取当前进程的 pgid
  if(pid == 0)
    return myproc()->pgid;

  // 查找指定进程
  for(p = proc; p < &proc[NPROC]; p++) {
    acquire(&p->lock);
    if(p->pid == pid && p->state != UNUSED) {
      int pgid = p->pgid;
      release(&p->lock);
      return pgid;
    }
    release(&p->lock);
  }

  return -1;  // 未找到进程
}

uint64
sys_setpgid(void)
{
  int pid, pgid;
  struct proc *target;
  struct proc *cur = myproc();

  if(argint(0, &pid) < 0 || argint(1, &pgid) < 0)
    return -1;

  // pid == 0 表示当前进程
  if(pid == 0)
    pid = cur->pid;

  // pgid == 0 表示使用 pid 作为 pgid
  if(pgid == 0)
    pgid = pid;

  // 查找目标进程
  for(target = proc; target < &proc[NPROC]; target++) {
    acquire(&target->lock);
    if(target->pid == pid && target->state != UNUSED) {
      // 只能修改自己或子进程的 pgid
      // 简化实现：只允许修改自己
      if(target != cur && target->parent != cur) {
        release(&target->lock);
        return -1;
      }
      target->pgid = pgid;
      release(&target->lock);
      return 0;
    }
    release(&target->lock);
  }

  return -1;  // 未找到进程
}

// V2.2C: 获取 TTY 前台进程组
extern int tty_fg_pgid;

uint64
sys_tcgetpgrp(void)
{
  return tty_fg_pgid;
}

// V2.2C: 设置 TTY 前台进程组
uint64
sys_tcsetpgrp(void)
{
  int pgid;
  if(argint(0, &pgid) < 0)
    return -1;
  
  // 简化实现：允许任何进程设置前台进程组
  // 完整实现应检查调用者是否是控制终端的会话领导
  tty_fg_pgid = pgid;
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
  
  #ifdef DEBUG
  printf("[sys_sigaction] pid=%d sig=%d handler=%p\n", p->pid, sig, handler);
  #endif
  
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
  #ifdef DEBUG
  printf("[sigreturn] pid=%d frame_addr=%p\n", p->pid, frame_addr);
  #endif
  
  if(frame_addr == 0) {
    #ifdef DEBUG
    printf("[sigreturn] ERROR: no active frame!\n");
    #endif
    return -1;  // 没有活跃的信号帧
  }
  
  if(copyin(p->pagetable, (char*)&frame, frame_addr, sizeof(frame)) < 0) {
    #ifdef DEBUG
    printf("[sigreturn] ERROR: copyin failed!\n");
    #endif
    return -1;
  }
  
  #ifdef DEBUG
  printf("[sigreturn] restoring epc=%p, signo=%d\n", frame.epc, frame.signo);
  #endif
  
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

// V3.1: 查询页面是否驻留在物理内存
// int mincore(void *addr, size_t length, unsigned char *vec);
// 返回: 0 成功, -1 失败
uint64
sys_mincore(void)
{
  uint64 addr;
  uint64 length;
  uint64 vec;
  struct proc *p = myproc();
  
  // 获取参数
  if(argaddr(0, &addr) < 0 || argaddr(1, &length) < 0 || argaddr(2, &vec) < 0)
    return -1;
    
  // 检查地址对齐和长度是否有效
  if(addr % PGSIZE != 0 || length == 0)
    return -1;
    
  // 计算需要的字节数 (每个页面对应1位，向上取整)
  uint64 npages = (length + PGSIZE - 1) / PGSIZE;
  uint64 vec_size = (npages + 7) / 8;  // 位图大小(字节)
  
  // 结果缓冲区（内核临时 buffer）
  // vec_size 最多是 (npages+7)/8，通常远小于一页。
  char *vec_buf = kalloc();
  if(vec_buf == 0)
    return -1;
  memset(vec_buf, 0, PGSIZE);
  
  pte_t *pte;
  uint64 a;
  int i;
  
  // 基本范围检查（避免 addr+length 溢出）
  if(addr + length < addr){
    kfree(vec_buf);
    return -1;
  }

  // 遍历所有页面（按 npages 遍历更稳妥）
  for(a = addr, i = 0; i < npages; a += PGSIZE, i++) {
    // 检查地址是否在用户空间范围内
    if(a >= p->sz)
      break;
      
    // 获取页表项
    pte = walk(p->pagetable, a, 0);
    if(pte == 0 || (*pte & PTE_V) == 0) {
      // 页面无效，继续下一个
      continue;
    }
    
    // 该工程的 PTE flag 里没有实现 RISC-V 的 Accessed(PTE_A) 位，
    // 因此这里采用“是否已映射且有效(PTE_V)”作为是否驻留的判断。
    // 这等价于：只要页表项存在且有效，就认为该页当前在物理内存中。
    vec_buf[i/8] |= (1 << (i % 8));
  }
  
  // 将结果复制回用户空间
  if(copyout2(vec, vec_buf, vec_size) < 0) {
    kfree(vec_buf);
    return -1;
  }
  
  kfree(vec_buf);
  return 0;
}

// V3.0: 设置 SIGALRM 定时器
// alarm(seconds) - 设置定时器，seconds 秒后发送 SIGALRM
// 返回: 上次 alarm 的剩余时间 (秒)，如果没有则返回 0
uint64
sys_alarm(void)
{
  int seconds;
  struct proc *p = myproc();
  
  if(argint(0, &seconds) < 0)
    return -1;
  
  // 禁止负数
  if(seconds < 0)
    return -1;
  
  extern uint ticks;
  extern struct spinlock tickslock;
  
  acquire(&tickslock);
  uint current_ticks = ticks;
  release(&tickslock);
  
  // 计算旧 alarm 的剩余时间
  uint remaining = 0;
  if(p->alarm_ticks > current_ticks) {
    // 还有剩余时间
    remaining = (p->alarm_ticks - current_ticks) / 10;  // 转换为秒 (假设 10 ticks/s)
  }
  
  // 设置新 alarm
  if(seconds == 0) {
    // 取消 alarm
    p->alarm_ticks = 0;
  } else {
    // 设置新的到期时间
    p->alarm_ticks = current_ticks + seconds * 10;  // 转换为 ticks
  }
  
  return remaining;
}


// V3.0: clone() - 创建线程/进程
// 简化实现：基于 fork，支持部分 clone 标志
uint64
sys_clone(void)
{
  int flags;
  uint64 stack;
  
  if(argint(0, &flags) < 0 || argaddr(1, &stack) < 0)
    return -1;
  
  struct proc *p = myproc();
  
  // 调用 fork 创建新进程
  int pid = fork();
  if(pid < 0)
    return -1;
  
  if(pid == 0) {
    // 子进程/线程
    struct proc *np = myproc();
    
    // 如果指定了新栈，设置 sp
    if(stack != 0) {
      np->trapframe->sp = stack;
    }
    
    // 标记为线程
    if(flags & CLONE_THREAD) {
      np->is_thread = 1;
      np->thread_group = p;
    }
    
    // 注意: CLONE_VM 需要更复杂的实现 (共享页表)
    // 当前简化版本不支持真正的共享内存
    // 完整实现需要修改 fork() 核心逻辑
  }
  
  return pid;
}

// V3.0: futex() - 快速用户空间互斥锁
// 简化实现：使用 sleep/wakeup
uint64
sys_futex(void)
{
  uint64 addr;
  int op, val;
  
  if(argaddr(0, &addr) < 0 || argint(1, &op) < 0 || argint(2, &val) < 0)
    return -1;
  
  struct proc *p = myproc();
  
  switch(op) {
    case FUTEX_WAIT: {
      // 检查内存值是否等于 val
      int current;
      if(copyin(p->pagetable, (char*)&current, addr, sizeof(int)) < 0)
        return -1;
      
      if(current != val)
        return -1;  // 值已改变，不需要等待
      
      // 睡眠等待
      sleep((void*)addr, 0);
      return 0;
    }
    
    case FUTEX_WAKE: {
      // 唤醒等待在该地址上的进程
      wakeup((void*)addr);
      return 0;
    }
    
    default:
      return -1;
  }
}

// V3.0: exit_group() - 退出整个线程组
uint64
sys_exit_group(void)
{
  int status;
  if(argint(0, &status) < 0)
    return -1;
  
  // 简化实现：直接调用 exit
  // 完整实现需要终止同一线程组的所有线程
  exit(status);
  return 0;  // 不会到达
}

// V3.1: Power management system calls
uint64
sys_halt(void)
{
  printf("System halting...\n");
  sbi_shutdown();
  return 0; // Should not reach here
}

uint64
sys_reboot(void)
{
  printf("System rebooting...\n");
  // type=0 (SHUTDOWN), reason=1 (WARM_REBOOT) -> sbi_system_reset standard
  // or type=0 (SHUTDOWN), reason=0 (COLD_REBOOT)
  // Let's try regular cold reboot.
  sbi_system_reset(0, 0); 
  return 0; // Should not reach here
}

// V3.0: System-wide information
// int sysinfo(struct sysinfo *info);
// Returns: 0 on success, -1 on error.
uint64
sys_sysinfo(void)
{
  uint64 addr;
  struct sysinfo info;
  extern uint64 freemem_amount(void);
  extern uint64 procnum(void);
  extern uint64 kcow_pages(void);
  extern uint64 kshm_pages(void);
  extern uint64 kmmap_pages(void);
  extern void kalloc_stats_copyout(void *);
  extern uint64 console_dropped_chars;

  if(argaddr(0, &addr) < 0)
    return -1;

  // Collect information
  info.freemem = freemem_amount();
  info.nproc = procnum();
  info.uptime = ticks; // from timer.c
  info.cow_pages = kcow_pages();
  info.shm_pages = kshm_pages();
  info.mmap_pages = kmmap_pages();
  info.dropped = console_dropped_chars;
  
  // Copy kalloc statsS
  kalloc_stats_copyout(&info.kalloc_stats);

  // Copy to user space
  if(copyout2(addr, (char *)&info, sizeof(info)) < 0)
    return -1;

  return 0;
}