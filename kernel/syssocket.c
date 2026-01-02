// syssocket.c - Socket system call implementations
// V3.1: Network stack foundation

#include "include/types.h"
#include "include/param.h"
#include "include/riscv.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/file.h"
#include "include/socket.h"
#include "include/syscall.h"
#include "include/vm.h"

// Helper: allocate file descriptor for socket
static int
sockfdalloc(struct socket *so, int readable, int writable)
{
  struct file *f;
  int fd;
  struct proc *p = myproc();

  f = filealloc();
  if(f == 0)
    return -1;
  
  fd = -1;
  for(int i = 0; i < NOFILE; i++){
    if(p->ofile[i] == 0){
      fd = i;
      p->ofile[i] = f;
      break;
    }
  }
  
  if(fd < 0){
    fileclose(f);
    return -1;
  }
  
  f->type = FD_SOCKET;
  f->socket = so;
  f->readable = readable;
  f->writable = writable;
  f->ref = 1;
  
  return fd;
}

// Helper: get socket from fd
static struct socket*
sockfromfd(int fd)
{
  struct proc *p = myproc();
  struct file *f;
  
  if(fd < 0 || fd >= NOFILE)
    return 0;
  f = p->ofile[fd];
  if(f == 0 || f->type != FD_SOCKET)
    return 0;
  return f->socket;
}

// sys_socket(domain, type, protocol) -> fd
uint64
sys_socket(void)
{
  int domain, type, protocol;
  struct socket *so;
  int fd;
  
  if(argint(0, &domain) < 0)
    return -1;
  if(argint(1, &type) < 0)
    return -1;
  if(argint(2, &protocol) < 0)
    return -1;
  
  // Validate domain
  if(domain != AF_UNIX && domain != AF_INET)
    return -1;
  
  // Validate type
  if(type != SOCK_STREAM && type != SOCK_DGRAM)
    return -1;
  
  so = sockalloc();
  if(so == 0)
    return -1;
  
  so->domain = domain;
  so->type = type;
  
  // Allocate fd (readable and writable for socket)
  fd = sockfdalloc(so, 1, 1);
  if(fd < 0){
    sockfree(so);
    return -1;
  }
  
  return fd;
}

// sys_bind(sockfd, addr, addrlen) -> 0 or -1
uint64
sys_bind(void)
{
  int sockfd, addrlen;
  uint64 addr_ptr;
  struct socket *so;
  char addr[128];  // Large enough for sockaddr_un (110 bytes)
  
  if(argint(0, &sockfd) < 0)
    return -1;
  if(argaddr(1, &addr_ptr) < 0)
    return -1;
  if(argint(2, &addrlen) < 0)
    return -1;
  
  so = sockfromfd(sockfd);
  if(so == 0)
    return -1;
  
  // Copy address from user space
  if(addrlen > sizeof(addr))
    addrlen = sizeof(addr);
  if(copyin2(addr, addr_ptr, addrlen) < 0)
    return -1;
  
  return sockbind(so, (struct sockaddr*)addr, addrlen);
}

// sys_listen(sockfd, backlog) -> 0 or -1
uint64
sys_listen(void)
{
  int sockfd, backlog;
  struct socket *so;
  
  if(argint(0, &sockfd) < 0)
    return -1;
  if(argint(1, &backlog) < 0)
    return -1;
  
  so = sockfromfd(sockfd);
  if(so == 0)
    return -1;
  
  return socklisten(so, backlog);
}

// sys_accept(sockfd, addr, addrlen) -> new fd
uint64
sys_accept(void)
{
  int sockfd;
  uint64 addr_ptr, addrlen_ptr;
  struct socket *so, *newso;
  char addr[128];  // Must be large enough for sockaddr_un (110 bytes)
  int addrlen;
  int fd;
  
  if(argint(0, &sockfd) < 0)
    return -1;
  if(argaddr(1, &addr_ptr) < 0)
    return -1;
  if(argaddr(2, &addrlen_ptr) < 0)
    return -1;
  
  so = sockfromfd(sockfd);
  if(so == 0)
    return -1;
  
  addrlen = sizeof(addr);
  newso = sockaccept(so, (struct sockaddr*)addr, &addrlen);
  if(newso == 0)
    return -1;
  
  // Allocate fd for new socket
  fd = sockfdalloc(newso, 1, 1);
  if(fd < 0){
    sockclose(newso);
    return -1;
  }
  
  // Copy address back to user space if requested
  if(addr_ptr != 0 && addrlen > 0){
    if(addrlen > sizeof(addr))
      addrlen = sizeof(addr);
    copyout2(addr_ptr, addr, addrlen);
  }
  if(addrlen_ptr != 0){
    copyout2(addrlen_ptr, (char*)&addrlen, sizeof(addrlen));
  }
  
  return fd;
}

// sys_connect(sockfd, addr, addrlen) -> 0 or -1
uint64
sys_connect(void)
{
  int sockfd, addrlen;
  uint64 addr_ptr;
  struct socket *so;
  char addr[128];  // Large enough for sockaddr_un
  
  if(argint(0, &sockfd) < 0)
    return -1;
  if(argaddr(1, &addr_ptr) < 0)
    return -1;
  if(argint(2, &addrlen) < 0)
    return -1;
  
  so = sockfromfd(sockfd);
  if(so == 0)
    return -1;
  
  if(addrlen > sizeof(addr))
    addrlen = sizeof(addr);
  if(copyin2(addr, addr_ptr, addrlen) < 0)
    return -1;
  
  return sockconnect(so, (struct sockaddr*)addr, addrlen);
}

// sys_send(sockfd, buf, len, flags) -> bytes sent
uint64
sys_send(void)
{
  int sockfd, len, flags;
  uint64 buf_ptr;
  struct socket *so;
  char buf[256];  // Stack buffer for copy
  int n, total = 0;
  
  if(argint(0, &sockfd) < 0)
    return -1;
  if(argaddr(1, &buf_ptr) < 0)
    return -1;
  if(argint(2, &len) < 0)
    return -1;
  if(argint(3, &flags) < 0)
    return -1;
  
  so = sockfromfd(sockfd);
  if(so == 0)
    return -1;
  
  // Send in chunks
  while(total < len){
    n = len - total;
    if(n > sizeof(buf))
      n = sizeof(buf);
    if(copyin2(buf, buf_ptr + total, n) < 0)
      return total > 0 ? total : -1;
    n = socksend(so, buf, n, flags);
    if(n < 0)
      return total > 0 ? total : -1;
    total += n;
  }
  
  return total;
}

// sys_recv(sockfd, buf, len, flags) -> bytes received
uint64
sys_recv(void)
{
  int sockfd, len, flags;
  uint64 buf_ptr;
  struct socket *so;
  char buf[256];
  int n;
  
  if(argint(0, &sockfd) < 0)
    return -1;
  if(argaddr(1, &buf_ptr) < 0)
    return -1;
  if(argint(2, &len) < 0)
    return -1;
  if(argint(3, &flags) < 0)
    return -1;
  
  so = sockfromfd(sockfd);
  if(so == 0)
    return -1;
  
  if(len > sizeof(buf))
    len = sizeof(buf);
  
  n = sockrecv(so, buf, len, flags);
  if(n < 0)
    return -1;
  
  if(n > 0 && copyout2(buf_ptr, buf, n) < 0)
    return -1;
  
  return n;
}
