// poll.h - V3.0 I/O Multiplexing definitions
// POSIX-compatible poll() interface

#ifndef __POLL_H
#define __POLL_H

#include "types.h"

// Poll event flags
#define POLLIN      0x0001   // 可读数据
#define POLLPRI     0x0002   // 紧急数据
#define POLLOUT     0x0004   // 可写
#define POLLERR     0x0008   // 错误 (仅 revents)
#define POLLHUP     0x0010   // 挂起 (仅 revents)
#define POLLNVAL    0x0020   // 无效 fd (仅 revents)
#define POLLRDNORM  0x0040
#define POLLRDBAND  0x0080
#define POLLWRNORM  0x0100
#define POLLWRBAND  0x0200

// poll file descriptor structure
struct pollfd {
    int fd;           // 文件描述符
    short events;     // 请求的事件
    short revents;    // 返回的事件
};

// nfds_t type
typedef unsigned int nfds_t;

// 最大 poll 文件描述符数
#define POLL_MAX_FDS  64

#endif // __POLL_H
