#ifndef __SYSNUM_H
#define __SYSNUM_H

// System call numbers
#define SYS_fork         1
#define SYS_exit         2
#define SYS_wait         3
#define SYS_pipe         4
#define SYS_read         5
#define SYS_kill         6
#define SYS_exec         7
#define SYS_fstat        8
#define SYS_chdir        9
#define SYS_dup         10
#define SYS_getpid      11
#define SYS_sbrk        12
#define SYS_sleep       13
#define SYS_uptime      14
#define SYS_open        15
#define SYS_write       16
#define SYS_remove      17
#define SYS_trace       18
#define SYS_sysinfo     19
#define SYS_mkdir       20
#define SYS_close       21
#define SYS_test_proc   22
#define SYS_dev         23
#define SYS_readdir     24
#define SYS_getcwd      25
#define SYS_rename      26
#define SYS_sem_open    27
#define SYS_sem_wait    28
#define SYS_sem_post    29
#define SYS_sem_close   30
#define SYS_sem_getvalue 31
#define SYS_settickets  32
#define SYS_getpinfo    33
#define SYS_waitpid     34
#define SYS_shmcreate   35
#define SYS_shmopen     36
#define SYS_shmattach   37
#define SYS_shmdetach   38
#define SYS_shmunlink   39
#define SYS_mmap        40
#define SYS_munmap      41
#define SYS_kill2       42  // V2.1: kill(pid, sig) 带信号参数
#define SYS_sigaction   43  // V2.1: 设置信号处理器
#define SYS_sigreturn   44  // V2.1: 从信号处理器返回
#define SYS_lseek       45  // V2.2: 文件定位
#define SYS_dup2        46  // V2.2: 复制文件描述符到指定槽
#define SYS_getppid     47  // V2.2: 获取父进程 PID
#define SYS_getuid      48  // V2.2: 获取用户 ID
#define SYS_setuid      49  // V2.2: 设置用户 ID
#define SYS_getgid      50  // V2.2: 获取组 ID
#define SYS_setgid      51  // V2.2: 设置组 ID
#define SYS_getpgid     52  // V2.2: 获取进程组 ID
#define SYS_setpgid     53  // V2.2: 设置进程组 ID
#define SYS_tcgetpgrp   54  // V2.2C: 获取 TTY 前台进程组
#define SYS_tcsetpgrp   55  // V2.2C: 设置 TTY 前台进程组
#define SYS_pipe2       56  // V3.0 (Task 12)
#define SYS_mincore     57  // V3.1: 查询页面是否驻留在物理内存
#define SYS_alarm       58  // V3.0: 设置 SIGALRM 定时器
#define SYS_poll        59  // V3.0: I/O 多路复用
#define SYS_fcntl       60  // V3.0: 文件描述符控制
#define SYS_chmod       61  // V3.0: 更改文件权限
#define SYS_fchmod      62  // V3.0: 更改 fd 权限
#define SYS_clone       63  // V3.0: 创建线程/进程
#define SYS_futex       64  // V3.0: 快速用户空间互斥锁
#define SYS_exit_group  65  // V3.0: 退出整个线程组
#define SYS_halt        66  // V3.1: 关机
#define SYS_reboot      67  // V3.1: 重启

// V3.0: clone() 标志
#define CLONE_VM        0x00000100  // 共享虚拟内存
#define CLONE_FS        0x00000200  // 共享文件系统信息
#define CLONE_FILES     0x00000400  // 共享文件描述符表
#define CLONE_THREAD    0x00010000  // 同一线程组

// V3.0: futex() 操作码
#define FUTEX_WAIT      0
#define FUTEX_WAKE      1

#endif