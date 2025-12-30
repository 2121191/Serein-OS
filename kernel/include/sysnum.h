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

#endif