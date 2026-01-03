// socket.c - Simplified Socket implementation for xv6-k210
// Uses shared buffer model similar to pipes

#include "include/types.h"
#include "include/riscv.h"
#include "include/param.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/socket.h"
#include "include/kalloc.h"
#include "include/string.h"
#include "include/poll.h"

// Global socket table
struct socket sockets[NSOCKET];
struct spinlock socket_table_lock;

// Initialize socket subsystem
void
sockinit(void)
{
  initlock(&socket_table_lock, "socktbl");
  for(int i = 0; i < NSOCKET; i++){
    sockets[i].ref = 0;
    initlock(&sockets[i].lock, "socket");
  }
}

// Allocate a new socket
struct socket*
sockalloc(void)
{
  struct socket *so;
  
  acquire(&socket_table_lock);
  for(so = sockets; so < &sockets[NSOCKET]; so++){
    if(so->ref == 0){
      so->ref = 1;
      so->domain = 0;
      so->type = 0;
      so->state = SS_UNCONNECTED;
      so->bound = 0;
      so->peer_sock = 0;
      so->recvhead = 0;
      so->recvtail = 0;
      so->recv_closed = 0;
      so->pending_head = 0;
      so->pending_tail = 0;
      so->backlog = 0;
      memset(&so->local, 0, sizeof(so->local));
      memset(&so->peer, 0, sizeof(so->peer));
      memset(so->recvbuf, 0, SOCKBUF_SIZE);
      memset(so->pending, 0, sizeof(so->pending));
      release(&socket_table_lock);
      return so;
    }
  }
  release(&socket_table_lock);
  return 0;
}

// Free a socket
void
sockfree(struct socket *so)
{
  acquire(&socket_table_lock);
  so->ref = 0;
  so->bound = 0;
  so->state = SS_UNCONNECTED;
  so->peer_sock = 0;
  memset(&so->local, 0, sizeof(so->local));
  release(&socket_table_lock);
}

// Find Unix domain socket by path
struct socket*
sockfind_unix(char *path)
{
  struct socket *so;
  
  for(so = sockets; so < &sockets[NSOCKET]; so++){
    if(so->ref > 0 && so->domain == AF_UNIX && so->bound){
      if(strncmp(so->local.un.path, path, UNIX_PATH_MAX) == 0){
        return so;
      }
    }
  }
  return 0;
}

// Find inet socket by address and port
struct socket*
sockfind_inet(uint32 addr, uint16 port)
{
  struct socket *so;
  
  for(so = sockets; so < &sockets[NSOCKET]; so++){
    if(so->ref > 0 && so->domain == AF_INET && so->bound){
      if((so->local.in.addr == addr || so->local.in.addr == INADDR_ANY) &&
         so->local.in.port == port){
        return so;
      }
    }
  }
  return 0;
}

// Bind socket to address
int
sockbind(struct socket *so, struct sockaddr *addr, int addrlen)
{
  if(so->bound)
    return -1;
  
  acquire(&socket_table_lock);
  
  if(so->domain == AF_UNIX){
    struct sockaddr_un *un = (struct sockaddr_un*)addr;
    if(sockfind_unix(un->path) != 0){
      release(&socket_table_lock);
      return -1;
    }
    so->local.un.family = AF_UNIX;
    strncpy(so->local.un.path, un->path, UNIX_PATH_MAX);
  } else if(so->domain == AF_INET){
    struct sockaddr_in *in = (struct sockaddr_in*)addr;
    if(sockfind_inet(in->addr, in->port) != 0){
      release(&socket_table_lock);
      return -1;
    }
    so->local.in.family = AF_INET;
    so->local.in.addr = in->addr;
    so->local.in.port = in->port;
  } else {
    release(&socket_table_lock);
    return -1;
  }
  
  so->bound = 1;
  release(&socket_table_lock);
  return 0;
}

// Start listening for connections
int
socklisten(struct socket *so, int backlog)
{
  if(so->type != SOCK_STREAM)
    return -1;
  if(!so->bound)
    return -1;
  
  so->state = SS_LISTENING;
  so->backlog = (backlog > SOMAXCONN) ? SOMAXCONN : backlog;
  return 0;
}

// Accept incoming connection  
struct socket*
sockaccept(struct socket *so, struct sockaddr *addr, int *addrlen)
{
  struct socket *newso;
  
  if(so->type != SOCK_STREAM || so->state != SS_LISTENING)
    return 0;
  
  acquire(&so->lock);
  
  // Wait for pending connection
  while(so->pending_head == so->pending_tail){
    if(myproc()->killed){
      release(&so->lock);
      return 0;
    }
    sleep(so, &so->lock);
  }
  
  // Get pending socket
  newso = so->pending[so->pending_head % SOMAXCONN];
  so->pending_head++;
  
  release(&so->lock);
  
  // Copy peer address if requested
  if(addr && addrlen){
    if(so->domain == AF_UNIX){
      memmove(addr, &newso->peer.un, sizeof(struct sockaddr_un));
      *addrlen = sizeof(struct sockaddr_un);
    } else if(so->domain == AF_INET){
      memmove(addr, &newso->peer.in, sizeof(struct sockaddr_in));
      *addrlen = sizeof(struct sockaddr_in);
    }
  }
  
  return newso;
}

// Connect to a listening socket
int
sockconnect(struct socket *so, struct sockaddr *addr, int addrlen)
{
  struct socket *listener;
  struct socket *accepted;
  
  if(so->state != SS_UNCONNECTED)
    return -1;
  
  acquire(&socket_table_lock);
  
  // Find listening socket
  if(so->domain == AF_UNIX){
    struct sockaddr_un *un = (struct sockaddr_un*)addr;
    listener = sockfind_unix(un->path);
  } else if(so->domain == AF_INET){
    struct sockaddr_in *in = (struct sockaddr_in*)addr;
    listener = sockfind_inet(in->addr, in->port);
  } else {
    release(&socket_table_lock);
    return -1;
  }
  
  // Verify listener
  if(!listener || !listener->bound){
    release(&socket_table_lock);
    return -1;
  }
  
  // For TCP, listener must be in LISTENING state
  if(so->type == SOCK_STREAM && listener->state != SS_LISTENING){
    release(&socket_table_lock);
    return -1;
  }
  
  // For UDP, we just need a bound target
  if(so->type == SOCK_DGRAM){
    if(listener->type != SOCK_DGRAM){
      release(&socket_table_lock);
      return -1;
    }
    so->peer_sock = listener;
    so->state = SS_CONNECTED;
    release(&socket_table_lock);
    return 0;
  }
  
  release(&socket_table_lock);
  
  // TCP Logic continues here...
  // Create accepted socket (server side)
  accepted = sockalloc();
  if(!accepted)
    return -1;
  
  accepted->domain = so->domain;
  accepted->type = so->type;
  accepted->state = SS_CONNECTED;
  
  // Link the sockets - each writes to the other's recvbuf
  so->peer_sock = accepted;
  accepted->peer_sock = so;
  so->state = SS_CONNECTED;
  
  // Copy addresses
  if(so->domain == AF_UNIX){
    memmove(&accepted->local.un, &listener->local.un, sizeof(struct sockaddr_un));
  } else if(so->domain == AF_INET){
    memmove(&accepted->local.in, &listener->local.in, sizeof(struct sockaddr_in));
  }
  
  // Add to listener's pending queue
  acquire(&listener->lock);
  if(listener->pending_tail - listener->pending_head >= listener->backlog){
    release(&listener->lock);
    sockfree(accepted);
    so->peer_sock = 0;
    so->state = SS_UNCONNECTED;
    return -1;
  }
  listener->pending[listener->pending_tail % SOMAXCONN] = accepted;
  listener->pending_tail++;
  wakeup(listener);
  release(&listener->lock);
  
  return 0;
}

// Send data - write to peer's receive buffer (like pipe)
int
socksend(struct socket *so, char *buf, int len, int flags)
{
  struct socket *peer;
  int i;
  int hdr = len; // Packet length header for DGRAM
  
  if(so->state != SS_CONNECTED)
    return -1;
  
  peer = so->peer_sock;
  if(!peer || peer->recv_closed)
    return -1;
  
  acquire(&peer->lock);
  
  if(so->type == SOCK_DGRAM){
    // UDP: Write length packet first (atomic-ish write check)
    if(SOCKBUF_SIZE - (peer->recvtail - peer->recvhead) < len + sizeof(int)){
      // Drop packet if no space
      release(&peer->lock);
      return -1; 
    }
    
    // Write Header
    char *hdr_ptr = (char*)&hdr;
    for(i=0; i<sizeof(int); i++){
      peer->recvbuf[peer->recvtail % SOCKBUF_SIZE] = hdr_ptr[i];
      peer->recvtail++;
    }
    
    // Write Data
    for(i = 0; i < len; i++){
      peer->recvbuf[peer->recvtail % SOCKBUF_SIZE] = buf[i];
      peer->recvtail++;
    }
  } else {
    // TCP: Stream write
    for(i = 0; i < len; i++){
      // Wait if buffer full
      while(peer->recvtail - peer->recvhead >= SOCKBUF_SIZE){
        if(peer->recv_closed || myproc()->killed){
          release(&peer->lock);
          return i > 0 ? i : -1;
        }
        wakeup(&peer->recvhead);  // Wake reader
        sleep(&peer->recvtail, &peer->lock);
      }
      peer->recvbuf[peer->recvtail % SOCKBUF_SIZE] = buf[i];
      peer->recvtail++;
    }
  }
  
  wakeup(&peer->recvhead);  // Wake reader
  release(&peer->lock);
  return len;
}

// Receive data - read from own receive buffer (like pipe)
int
sockrecv(struct socket *so, char *buf, int len, int flags)
{
  int i;
  int packet_len = 0;
  
  acquire(&so->lock);
  
  // Wait for data
  while(so->recvhead == so->recvtail){
    if(so->recv_closed){
      release(&so->lock);
      return 0;
    }

    if(flags & MSG_DONTWAIT){
      release(&so->lock);
      return -1;
    }

    if(myproc()->killed){
      release(&so->lock);
      return -1;
    }
    sleep(&so->recvhead, &so->lock);
  }
  
  if(so->type == SOCK_DGRAM){
    // Read packet header
    char *hdr_ptr = (char*)&packet_len;
    for(i=0; i<sizeof(int); i++){
      if(so->recvhead == so->recvtail) break; // Should not happen if protocol kept
      hdr_ptr[i] = so->recvbuf[so->recvhead % SOCKBUF_SIZE];
      so->recvhead++;
    }
    
    // Truncate if buffer too small
    int read_len = (len < packet_len) ? len : packet_len;
    
    for(i = 0; i < read_len; i++){
      buf[i] = so->recvbuf[so->recvhead % SOCKBUF_SIZE];
      so->recvhead++;
    }
    
    // Skip remaining packet bytes if any
    if(packet_len > read_len){
      so->recvhead += (packet_len - read_len);
    }
    
    wakeup(&so->recvtail);
    release(&so->lock);
    return read_len;
    
  } else {
    // TCP: Stream read
    for(i = 0; i < len; i++){
      if(so->recvhead == so->recvtail)
        break;
      buf[i] = so->recvbuf[so->recvhead % SOCKBUF_SIZE];
      so->recvhead++;
    }
    
    wakeup(&so->recvtail);  // Wake writer
    release(&so->lock);
    return i;
  }
}

// Close socket
void
sockclose(struct socket *so)
{
  struct socket *peer = so->peer_sock;
  
  if(peer){
    if(so->type == SOCK_STREAM){
      acquire(&peer->lock);
      peer->recv_closed = 1;
      peer->peer_sock = 0;
      wakeup(&peer->recvhead);
      wakeup(&peer->recvtail);
      release(&peer->lock);
    } 
    // For UDP, we just detach, don't close peer's input
    // because peer might be receiving from others
  }
  
  sockfree(so);
}

// Poll for events
int
sockpoll(struct socket *so, int events)
{
  int revents = 0;
  
  acquire(&so->lock);
  
  if(so->state == SS_LISTENING){
    // Readable if new connection pending
    if(so->pending_head != so->pending_tail){
      revents |= POLLIN;
    }
  } else if(so->state == SS_CONNECTED || so->state == SS_DISCONNECTING){
    // Readable if data available
    if(so->recvhead != so->recvtail || so->recv_closed){
      revents |= (POLLIN | POLLRDNORM);
    }
    if(so->recv_closed){
      revents |= POLLHUP;
    }
    
    // Writable if peer has space
    struct socket *peer = so->peer_sock;
    if(peer){
      acquire(&peer->lock);
      if(peer->recv_closed){
        revents |= POLLHUP; // Peer closed
      } else {
        if(peer->recvtail - peer->recvhead < SOCKBUF_SIZE){
           revents |= (POLLOUT | POLLWRNORM);
        }
      }
      release(&peer->lock);
    } else if(so->type == SOCK_STREAM) {
       // Connected stream but no peer? Broken pipe
       revents |= POLLERR;
    } else {
       // UDP with no peer set? Always writable (will fail on send)
       revents |= POLLOUT;
    }
  }
  
  release(&so->lock);
  return revents;
}
