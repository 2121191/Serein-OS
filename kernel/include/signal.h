#ifndef __SIGNAL_H
#define __SIGNAL_H

// xv6-k210 信号系统 (V2.1)
// 简化版 POSIX 信号定义

// 信号定义
#define SIGHUP    1   // 终端挂起
#define SIGINT    2   // 中断 (Ctrl+C)
#define SIGQUIT   3   // 退出 (产生 core dump)
#define SIGILL    4   // 非法指令
#define SIGABRT   6   // abort() 信号
#define SIGFPE    8   // 浮点异常
#define SIGKILL   9   // 强制终止 (不可捕获/忽略)
#define SIGSEGV   11  // 段错误
#define SIGPIPE   13  // 管道破裂
#define SIGALRM   14  // 定时器
#define SIGTERM   15  // 终止请求 (可捕获)
#define SIGCHLD   17  // 子进程状态改变
#define SIGCONT   18  // 继续执行
#define SIGSTOP   19  // 停止 (不可捕获/忽略)
#define SIGTSTP   20  // 终端停止 (Ctrl+Z)
#define SIGUSR1   30  // 用户定义信号1
#define SIGUSR2   31  // 用户定义信号2

#define NSIG      32  // 最大信号数

// 信号处理器特殊值
// 使用无效用户地址（内核空间地址）作为特殊标记
// 用户程序代码从 0x0 开始，这些高地址不可能是有效用户函数
#define SIG_DFL   ((void (*)(int))(-2))  // 默认处理 (0xfffffffffffffffe)
#define SIG_IGN   ((void (*)(int))(-3))  // 忽略信号 (0xfffffffffffffffd)
#define SIG_ERR   ((void (*)(int))(-1))  // 错误返回 (0xffffffffffffffff)

// 不可捕获/忽略的信号掩码
#define SIG_UNCATCHABLE  ((1 << SIGKILL) | (1 << SIGSTOP))

// 信号默认行为
#define SIG_DFL_TERM    0   // 终止进程
#define SIG_DFL_IGN     1   // 忽略
#define SIG_DFL_CORE    2   // 终止并产生 core dump (暂不支持)
#define SIG_DFL_STOP    3   // 停止进程
#define SIG_DFL_CONT    4   // 继续执行

// sigaction 结构体 (简化版)
struct sigaction {
  void (*sa_handler)(int);    // 信号处理函数
  uint32 sa_mask;             // 执行处理器时额外阻塞的信号
  int sa_flags;               // 标志 (暂保留)
};

// 信号帧：保存用户上下文到用户栈
// 用于 sigreturn 恢复执行
struct sigframe {
  // 通用寄存器 (与 trapframe 布局匹配)
  uint64 ra, sp, gp, tp;
  uint64 t0, t1, t2;
  uint64 s0, s1;
  uint64 a0, a1, a2, a3, a4, a5, a6, a7;
  uint64 s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
  uint64 t3, t4, t5, t6;
  // 信号相关信息
  uint64 epc;                 // 原始程序计数器 (返回地址)
  uint32 sig_blocked_saved;   // 保存的信号阻塞掩码
  int signo;                  // 当前处理的信号号
  // sigreturn trampoline 代码 (用户空间执行)
  uint32 sigreturn_code[2];   // 存放 sigreturn 调用指令
};

#endif
