#ifndef __SOCKET_H
#define __SOCKET_H

#include "types.h"
#include "spinlock.h"

// Address families
#define AF_UNIX     1   // Unix domain sockets (local IPC)
#define AF_INET     2   // IPv4 (loopback only)

// Socket types
#define SOCK_STREAM 1   // Connection-oriented (like TCP)
#define SOCK_DGRAM  2   // Connectionless (like UDP)

// Socket states
#define SS_UNCONNECTED  0
#define SS_LISTENING    1
#define SS_CONNECTING   2
#define SS_CONNECTED    3
#define SS_DISCONNECTING 4

// Socket buffer size
#define SOCKBUF_SIZE    512

// Maximum pending connections
#define SOMAXCONN       8

// Unix domain socket path length
#define UNIX_PATH_MAX   108

// Generic socket address (for API compatibility)
struct sockaddr {
  short family;
  char data[14];
};

// Unix domain socket address
struct sockaddr_un {
  short family;           // AF_UNIX
  char path[UNIX_PATH_MAX];
};

// IPv4 socket address (for loopback)
struct sockaddr_in {
  short family;           // AF_INET
  uint16 port;            // Port number (network byte order)
  uint32 addr;            // IP address (127.0.0.1 = 0x7f000001)
  char zero[8];           // Padding
};

// Loopback address
#define INADDR_LOOPBACK 0x7f000001  // 127.0.0.1
#define INADDR_ANY      0x00000000  // 0.0.0.0

// Socket structure
struct socket {
  int domain;             // AF_UNIX or AF_INET
  int type;               // SOCK_STREAM or SOCK_DGRAM
  int state;              // Connection state
  int ref;                // Reference count
  
  // Local address
  union {
    struct sockaddr_un un;
    struct sockaddr_in in;
  } local;
  int bound;              // Is address bound?
  
  // Peer address (for connected sockets)
  union {
    struct sockaddr_un un;
    struct sockaddr_in in;
  } peer;
  
  // Connected peer socket (STREAM)
  struct socket *peer_sock;
  
  // Data buffer (bidirectional ring buffer)
  struct spinlock lock;
  char recvbuf[SOCKBUF_SIZE];
  uint recvhead;          // Read position
  uint recvtail;          // Write position
  int recv_closed;        // Peer closed send side
  
  // Listening queue (for accept)
  struct socket *pending[SOMAXCONN];
  int pending_head;
  int pending_tail;
  int backlog;            // Max pending connections
};

// Global socket table
#define NSOCKET 64
extern struct socket sockets[NSOCKET];
extern struct spinlock socket_table_lock;

// Socket operations
void sockinit(void);
struct socket* sockalloc(void);
void sockfree(struct socket *so);
int sockbind(struct socket *so, struct sockaddr *addr, int addrlen);
int socklisten(struct socket *so, int backlog);
struct socket* sockaccept(struct socket *so, struct sockaddr *addr, int *addrlen);
int sockconnect(struct socket *so, struct sockaddr *addr, int addrlen);
int socksend(struct socket *so, char *buf, int len, int flags);
int sockrecv(struct socket *so, char *buf, int len, int flags);
void sockclose(struct socket *so);

// Find socket by address (for connection matching)
struct socket* sockfind_unix(char *path);
struct socket* sockfind_inet(uint32 addr, uint16 port);

#endif // __SOCKET_H
