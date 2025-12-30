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

extern char trampoline[], uservec[], userret[];

// in kernelvec.S, calls kerneltrap().
extern void kernelvec();

int devintr();

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
}

//
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
  int which_dev = 0;

  if((r_sstatus() & SSTATUS_SPP) != 0)
    panic("usertrap: not from user mode");

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);

  struct proc *p = myproc();
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
  
  if(r_scause() == 8){
    // system call
    if(p->killed)
      exit(-1);
    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
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
    
    // 先尝试 CoW 处理 (仅 Store Page Fault)
    if (r_scause() == 15) {
      if (cow_handle(p->pagetable, p->kpagetable, va) == 0) {
        handled = 1;
      }
    }
    
    // 再尝试 Lazy Allocation 处理
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

  // V2.1: 返回用户空间前检查并处理信号
  check_signals();
  
  // 信号可能导致进程被杀死
  if(p->killed)
    exit(-1);

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    yield();

  usertrapret();
}

//
// return to user space
//
void
usertrapret(void)
{
  struct proc *p = myproc();

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
  p->trapframe->kernel_trap = (uint64)usertrap;
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
  x |= SSTATUS_SPIE; // enable interrupts in user mode
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
}

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap() {
  int which_dev = 0;
  uint64 sepc = r_sepc();
  uint64 sstatus = r_sstatus();
  uint64 scause = r_scause();
  
  if((sstatus & SSTATUS_SPP) == 0)
    panic("kerneltrap: not from supervisor mode");
  if(intr_get() != 0)
    panic("kerneltrap: interrupts enabled");

  if((which_dev = devintr()) == 0){
    // 非设备中断时的处理
    struct proc *p = myproc();
    
    // 检查是否是 Load/Store Page Fault (scause=13/15)
    // 可能是 CoW 或 Lazy Allocation 触发
    if ((scause == 13 || scause == 15) && p != 0) {
      uint64 va = r_stval();
      int handled = 0;
      
      // 先尝试 CoW 处理（仅 Store Page Fault）
      if (scause == 15) {
        if (cow_handle(p->pagetable, p->kpagetable, va) == 0) {
          handled = 1;
        }
      }
      
      // 再尝试 Lazy Allocation 处理
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
    
    // 处理失败或非页面错误异常，打印调试信息并 Panic
    printf("\nscause %p\n", scause);
    printf("sepc=%p stval=%p hart=%d\n", r_sepc(), r_stval(), r_tp());
    if (p != 0) {
      printf("pid: %d, name: %s\n", p->pid, p->name);
    }
    panic("kerneltrap");
  }
  
  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    yield();
  }
  
  w_sepc(sepc);
  w_sstatus(sstatus);
}

// Check if it's an external/software interrupt, 
// and handle it. 
int devintr(void) {
    uint64 scause = r_scause();

    #ifdef QEMU 
    // QEMU S-mode 外部中断判断
    // 最高位为1 (Interrupt) 且 低位为9 (Supervisor External)
    if ((0x8000000000000000L & scause) && 9 == (scause & 0xff)) 
    #else 
    // K210 M-mode 逻辑
    if (0x8000000000000001L == scause && 9 == r_stval()) 
    #endif 
    {
        int irq = platform->plic->claim();

        if (irq == platform->plic->uart_irq) {
            // 使用驱动抽象层读取字符
            // 循环读取，直到读不到字符为止，确保清空 UART FIFO
            while (1) {
                int c = platform->console->getc();
                if (c == -1) {
                    break;
                }
                // 处理特殊字符 (如 \r -> \n)
                c = platform->console->handle_char(c);
                if (c > 0) {
                    consoleintr(c);
                }
            }
        }
        else if (irq == platform->plic->disk_irq) {
            platform->disk->intr();
        }
        else if (irq) {
            // 忽略未知的IRQ，不要打印太多报错，以免刷屏
            // printf("unexpected interrupt irq = %d\n", irq);
        }

        if (irq) { 
            platform->plic->complete(irq);
        }

        #ifndef QEMU 
        w_sip(r_sip() & ~2);    // clear pending bit
        sbi_set_mie();
        #endif 

        return 1;
    }
    else if (0x8000000000000005L == scause) {
        timer_tick();
        return 2;
    }
    else { return 0;}
}

void trapframedump(struct trapframe *tf)
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
