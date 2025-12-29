#ifndef __PROC_H
#define __PROC_H

#include "param.h"
#include "riscv.h"
#include "types.h"
#include "spinlock.h"
#include "file.h"
#include "fat32.h"
#include "trap.h"

// Saved registers for kernel context switches.
struct context {
  uint64 ra;
  uint64 sp;

  // callee-saved
  uint64 s0;
  uint64 s1;
  uint64 s2;
  uint64 s3;
  uint64 s4;
  uint64 s5;
  uint64 s6;
  uint64 s7;
  uint64 s8;
  uint64 s9;
  uint64 s10;
  uint64 s11;
};

// Per-CPU state.
struct cpu {
  struct proc *proc;          // The process running on this cpu, or null.
  struct context context;     // swtch() here to enter scheduler().
  int noff;                   // Depth of push_off() nesting.
  int intena;                 // Were interrupts enabled before push_off()?
};

extern struct cpu cpus[NCPU];

enum procstate { UNUSED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// VMA (Virtual Memory Area) for mmap support (V2.0.2)
#define MAX_VMA 16

struct vma {
  uint64 addr;        // 起始虚拟地址
  uint64 len;         // 映射长度
  int prot;           // 权限 (PROT_READ, PROT_WRITE, PROT_EXEC)
  int flags;          // 标志 (MAP_SHARED, MAP_PRIVATE)
  struct file *f;     // 关联的文件 (MAP_ANONYMOUS 时为 0)
  uint64 offset;      // 文件偏移
  int valid;          // 是否有效
};

// Per-process state
struct proc {
  struct spinlock lock;

  // p->lock must be held when using these:
  enum procstate state;        // Process state
  struct proc *parent;         // Parent process
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID

  // these are private to the process, so p->lock need not be held.
  uint64 kstack;               // Virtual address of kernel stack
  uint64 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  pagetable_t kpagetable;      // Kernel page table
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct dirent *cwd;          // Current directory
  char name[16];               // Process name (debugging)
  int tmask;                    // trace mask
  
  // Stride Scheduling (V2.0)
  int tickets;                  // 票数权重 (1-100)
  uint64 stride;                // stride = STRIDE_LARGE / tickets
  uint64 pass;                  // 累计 pass 值，每次运行后 +stride
  uint64 runticks;              // 累计运行 ticks
  uint64 schedcount;            // 被调度次数

  // mmap support (V2.0.2)
  struct vma vmas[MAX_VMA];     // 虚拟内存区域数组
};

// 进程统计信息（用于 getpinfo 系统调用）
struct pstat {
  int inuse[NPROC];             // 进程槽是否使用
  int pid[NPROC];               // PID
  int tickets[NPROC];           // 彩票数
  uint64 runticks[NPROC];       // 运行时间
  char name[NPROC][16];         // 进程名
};

void            reg_info(void);
int             cpuid(void);
void            exit(int);
int             fork(void);
int             growproc(int);
pagetable_t     proc_pagetable(struct proc *);
void            proc_freepagetable(pagetable_t, uint64);
int             kill(int);
struct cpu*     mycpu(void);
struct cpu*     getmycpu(void);
struct proc*    myproc();
void            procinit(void);
void            scheduler(void) __attribute__((noreturn));
void            sched(void);
void            setproc(struct proc*);
void            sleep(void*, struct spinlock*);
void            userinit(void);
int             wait(uint64);
int             waitpid(int, uint64, int);
void            wakeup(void*);
void            yield(void);
int             either_copyout(int user_dst, uint64 dst, void *src, uint64 len);
int             either_copyin(void *dst, int user_src, uint64 src, uint64 len);
void            procdump(void);
uint64          procnum(void);
void            test_proc_init(int);

#endif