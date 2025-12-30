#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/sbi.h"
#include "include/plic.h"
#include "include/trap.h"
#include "include/syscall.h"
#include "include/printf.h"
#include "include/console.h"
#include "include/timer.h"
#include "include/disk.h"
#include "driver/driver.h"
#include "include/vm.h"

// trap.c 的“方案A优化版本”：
// - UART 外部中断上半部只负责从硬件 FIFO 搬运到 ring buffer
// - 在 trap 返回路径中小批量 drain 到 consoleintr()，减少中断处理时延与锁争用
//
// 注意：该文件是新增的同名逻辑副本（trap_opt.c），不会被默认构建系统引用。
// 你需要在 Makefile / 编译列表中显式替换 kernel/trap.c 才会生效。

extern char trampoline[], uservec[], userret[];

// in kernelvec.S, calls kerneltrap().
extern void kernelvec();

int devintr();

// -----------------------------
// UART RX ring buffer (global)
// -----------------------------

#define UART_RB_SIZE 1024

struct uart_rb {
  struct spinlock lock;
  char buf[UART_RB_SIZE];
  uint32 r;
  uint32 w;
  uint32 drop;
};

static struct uart_rb urx;
static volatile int urx_pending = 0;

static inline int
urx_empty(void)
{
  return urx.r == urx.w;
}

static inline void
urx_push(char c)
{
  uint32 next = (urx.w + 1) % UART_RB_SIZE;
  if(next == urx.r){
    // full: drop
    urx.drop++;
    return;
  }
  urx.buf[urx.w] = c;
  urx.w = next;
}

static inline int
urx_pop(void)
{
  if(urx_empty())
    return -1;
  int c = (unsigned char)urx.buf[urx.r];
  urx.r = (urx.r + 1) % UART_RB_SIZE;
  return c;
}

// 下半部（方案A）：在 trap 返回路径中小批量把 ring buffer 喂给 consoleintr()
// 用 budget 防止一次处理过多，避免把“慢路径”又塞回 trap。
static void
uart_rx_drain_to_console(int budget)
{
  if(!urx_pending)
    return;

  while(budget-- > 0){
    int c;

    acquire(&urx.lock);
    c = urx_pop();
    if(c < 0){
      urx_pending = 0;
      release(&urx.lock);
      break;
    }
    release(&urx.lock);

    // consoleintr() 内部会 acquire(&cons.lock)
    // 我们在这里调用（而非 UART IRQ 上半部），以减少外部中断处理时长。
    consoleintr(c);
  }
}

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
  w_stvec((uint64)kernelvec);
  w_sstatus(r_sstatus() | SSTATUS_SIE);
  // enable supervisor-mode timer interrupts.
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE | SIE_STIE);
  set_next_timeout();
#ifdef DEBUG
  printf("trapinithart\n");
#endif

  // init urx lock once (per hart init here也可，但多次 initlock 不安全)
  // 保险起见，仅允许 hart0 初始化。
  if(r_tp() == 0){
    initlock(&urx.lock, "urx");
    urx.r = urx.w = 0;
    urx.drop = 0;
    urx_pending = 0;
  }
}

// handle an interrupt, exception, or system call from user space.
void
usertrap(void)
{
  int which_dev = 0;

  if((r_sstatus() & SSTATUS_SPP) != 0)
    panic("usertrap: not from user mode");

  w_stvec((uint64)kernelvec);

  struct proc *p = myproc();

  // save user program counter.
  p->trapframe->epc = r_sepc();

  if(r_scause() == 8){
    // system call
    if(p->killed)
      exit(-1);
    p->trapframe->epc += 4;
    intr_on();
    syscall();
  }
  else if((which_dev = devintr()) != 0){
    // ok
  }
  else if(r_scause() == 13 || r_scause() == 15) {
    // Load Page Fault (13) 或 Store Page Fault (15)
    // 可能是 CoW、Lazy Allocation 或 mmap 触发
    uint64 va = r_stval();
    int handled = 0;

    if (r_scause() == 15) {
      if (cow_handle(p->pagetable, p->kpagetable, va) == 0) {
        handled = 1;
      }
    }

    if (!handled) {
      if (lazy_alloc(p->pagetable, p->kpagetable, va, p->sz) == 0) {
        handled = 1;
      }
    }
    
    // 最后尝试 mmap 缺页处理 (V2.0.2)
    if (!handled) {
      if (mmap_handle_fault(p->pagetable, p->kpagetable, va) == 0) {
        handled = 1;
      }
    }
    
    if (!handled) {
      if (mmap_handle_fault(p->pagetable, p->kpagetable, va) == 0) {
        handled = 1;
      }
    }

    if (!handled) {
      printf("\nusertrap(): page fault failed pid=%d va=%p scause=%d\n",
             p->pid, va, r_scause());
      p->killed = 1;
    }
  }
  else {
    printf("\nusertrap(): unexpected scause %p pid=%d %s\n", r_scause(), p->pid, p->name);
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    p->killed = 1;
  }

  if(p->killed)
    exit(-1);

  // 方案A：在返回用户态前 drain 一小批 UART 输入
  // 放在 check_signals 前后都可以；这里放在信号检查之前，减少交互延迟。
  uart_rx_drain_to_console(128);

  check_signals();

  if(p->killed)
    exit(-1);

  if(which_dev == 2)
    yield();

  usertrapret();
}

void
usertrapret(void)
{
  struct proc *p = myproc();

  intr_off();
  w_stvec(TRAMPOLINE + (uservec - trampoline));

  p->trapframe->kernel_satp = r_satp();
  p->trapframe->kernel_sp = p->kstack + PGSIZE;
  p->trapframe->kernel_trap = (uint64)usertrap;
  p->trapframe->kernel_hartid = r_tp();

  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP;
  x |= SSTATUS_SPIE;
  w_sstatus(x);

  w_sepc(p->trapframe->epc);

  uint64 satp = MAKE_SATP(p->pagetable);

  uint64 fn = TRAMPOLINE + (userret - trampoline);
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
}

void
kerneltrap()
{
  int which_dev = 0;
  uint64 sepc = r_sepc();
  uint64 sstatus = r_sstatus();
  uint64 scause = r_scause();

  if((sstatus & SSTATUS_SPP) == 0)
    panic("kerneltrap: not from supervisor mode");
  if(intr_get() != 0)
    panic("kerneltrap: interrupts enabled");

  if((which_dev = devintr()) == 0){
    struct proc *p = myproc();

    if ((scause == 13 || scause == 15) && p != 0) {
      uint64 va = r_stval();
      int handled = 0;

      if (scause == 15) {
        if (cow_handle(p->pagetable, p->kpagetable, va) == 0) {
          handled = 1;
        }
      }

      if (!handled) {
        if (lazy_alloc(p->pagetable, p->kpagetable, va, p->sz) == 0) {
          handled = 1;
        }
      }

      if (handled) {
        w_sepc(sepc);
        w_sstatus(sstatus);
        return;
      }
    }

    printf("\nscause %p\n", scause);
    printf("sepc=%p stval=%p hart=%d\n", r_sepc(), r_stval(), r_tp());
    if (p != 0) {
      printf("pid: %d, name: %s\n", p->pid, p->name);
    }
    panic("kerneltrap");
  }

  // 方案A：内核态 trap 返回前也 drain 一小批，避免只在 usertrap drain 时
  // 内核里产生输入堆积。
  uart_rx_drain_to_console(128);

  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    yield();
  }

  w_sepc(sepc);
  w_sstatus(sstatus);
}

// Check if it's an external/software interrupt, and handle it.
int
devintr(void)
{
  uint64 scause = r_scause();

#ifdef QEMU
  if ((0x8000000000000000L & scause) && 9 == (scause & 0xff))
#else
  if (0x8000000000000001L == scause && 9 == r_stval())
#endif
  {
    int irq = platform->plic->claim();

    if (irq == platform->plic->uart_irq) {
      // UART IRQ 上半部：只搬运 FIFO -> ring buffer
      int n = 0;
      acquire(&urx.lock);
      while (1) {
        int c = platform->console->getc();
        if (c == -1)
          break;

        // 轻量转换（若 handle_char 很复杂，建议移到 drain 阶段）
        c = platform->console->handle_char(c);
        if (c <= 0)
          continue;

        urx_push((char)c);
        n++;
      }
      if (n > 0)
        urx_pending = 1;
      release(&urx.lock);
    }
    else if (irq == platform->plic->disk_irq) {
      platform->disk->intr();
    }
    else if (irq) {
      // ignore
    }

    if (irq) {
      platform->plic->complete(irq);
    }

#ifndef QEMU
    w_sip(r_sip() & ~2);
    sbi_set_mie();
#endif

    return 1;
  }
  else if (0x8000000000000005L == scause) {
    timer_tick();
    return 2;
  }
  else {
    return 0;
  }
}

void
trapframedump(struct trapframe *tf)
{
  printf("a0: %p\t", tf->a0);
  printf("a1: %p\t", tf->a1);
  printf("a2: %p\t", tf->a2);
  printf("a3: %p\n", tf->a3);
  printf("a4: %p\t", tf->a4);
  printf("a5: %p\t", tf->a5);
  printf("a6: %p\t", tf->a6);
  printf("a7: %p\n", tf->a7);
  printf("t0: %p\t", tf->t0);
  printf("t1: %p\t", tf->t1);
  printf("t2: %p\t", tf->t2);
  printf("t3: %p\n", tf->t3);
  printf("t4: %p\t", tf->t4);
  printf("t5: %p\t", tf->t5);
  printf("t6: %p\t", tf->t6);
  printf("s0: %p\n", tf->s0);
  printf("s1: %p\t", tf->s1);
  printf("s2: %p\t", tf->s2);
  printf("s3: %p\t", tf->s3);
  printf("s4: %p\n", tf->s4);
  printf("s5: %p\t", tf->s5);
  printf("s6: %p\t", tf->s6);
  printf("s7: %p\t", tf->s7);
  printf("s8: %p\n", tf->s8);
  printf("s9: %p\t", tf->s9);
  printf("s10: %p\t", tf->s10);
  printf("s11: %p\t", tf->s11);
  printf("ra: %p\n", tf->ra);
  printf("sp: %p\t", tf->sp);
  printf("gp: %p\t", tf->gp);
  printf("tp: %p\t", tf->tp);
  printf("epc: %p\n", tf->epc);
}
