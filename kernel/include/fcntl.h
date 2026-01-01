#define O_RDONLY  0x000
#define O_WRONLY  0x001
#define O_RDWR    0x002
#define O_APPEND  0x004
#define O_CREATE  0x200
#define O_TRUNC   0x400
#define O_NONBLOCK 0x800  // V3.0 (Task 12)
#define O_CLOEXEC  0x80000  // V3.0: close-on-exec (高位避免冲突)

// V3.0: fcntl() 命令
#define F_DUPFD     0   // 复制 fd
#define F_GETFD     1   // 获取 fd 标志 (FD_CLOEXEC)
#define F_SETFD     2   // 设置 fd 标志
#define F_GETFL     3   // 获取文件状态标志
#define F_SETFL     4   // 设置文件状态标志

// V3.0: 文件描述符标志
#define FD_CLOEXEC  1   // close-on-exec 标志

// mmap protection flags (V2.0.2)
#define PROT_NONE   0x0
#define PROT_READ   0x1
#define PROT_WRITE  0x2
#define PROT_EXEC   0x4

// mmap flags (V2.0.2)
#define MAP_SHARED    0x01
#define MAP_PRIVATE   0x02
#define MAP_ANONYMOUS 0x20
#define MAP_FAILED    ((void *)-1)
