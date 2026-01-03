// net_full_test.c - Test standard I/O (read/write/poll) on sockets

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

// POLL macros and struct pollfd are defined in user.h

void server() {
  int fd;
  struct sockaddr_un addr;
  
  printf("[SERVER] Creating socket...\n");
  fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if(fd < 0) exit(1);
  
  addr.family = AF_UNIX;
  strcpy(addr.path, "/tmp/netfull.sock");
  
  if(bind(fd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
      printf("[SERVER] bind failed\n");
      exit(1);
  }
  
  listen(fd, 5);
  
  printf("[SERVER] Polling on listen socket...\n");
  struct pollfd pfd;
  pfd.fd = fd;
  pfd.events = POLLIN;
  
  int ret = poll(&pfd, 1, 5000); // 5s timeout
  if(ret > 0 && (pfd.revents & POLLIN)) {
      printf("[SERVER] Poll successful (POLLIN set)\n");
      
      int client_fd = accept(fd, 0, 0);
      if(client_fd < 0) {
          printf("[SERVER] accept failed\n");
          exit(1);
      }
      
      printf("[SERVER] Accepted client (fd=%d)\n", client_fd);
      
      // Test read() instead of recv()
      char buf[32];
      printf("[SERVER] Blocking read() from client...\n");
      int n = read(client_fd, buf, sizeof(buf));
      if(n > 0) {
          buf[n] = 0;
          printf("[SERVER] Read via read(): %s\n", buf);
      } else {
          printf("[SERVER] Read failed or EOF\n");
      }
      
      // Test write() instead of send()
      printf("[SERVER] Writing via write()...\n");
      write(client_fd, "Reply", 5);
      
      close(client_fd);
  } else {
      printf("[SERVER] Poll timed out or failed (ret=%d, revents=%x)\n", ret, pfd.revents);
      exit(1);
  }
  
  close(fd);
  printf("[SERVER] Done\n");
  exit(0);
}

void client() {
  sleep(20); // Wait for server listen
  
  int fd = socket(AF_UNIX, SOCK_STREAM, 0);
  struct sockaddr_un addr;
  addr.family = AF_UNIX;
  strcpy(addr.path, "/tmp/netfull.sock");
  
  if(connect(fd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
      printf("[CLIENT] connect failed\n");
      exit(1);
  }
  
  printf("[CLIENT] Connected. Writing via write()...\n");
  write(fd, "Hello", 5);
  
  // Wait for reply via poll
  struct pollfd pfd;
  pfd.fd = fd;
  pfd.events = POLLIN;
  if(poll(&pfd, 1, 2000) > 0) {
      char buf[32];
      int n = read(fd, buf, sizeof(buf));
      if(n > 0) {
          buf[n] = 0;
          printf("[CLIENT] Read reply: %s\n", buf);
      }
  }
  
  close(fd);
  printf("[CLIENT] Done\n");
  // return; // Let parent wait
  exit(0); // Actually if we use exit, main loop logic needs to be careful
}

int main() {
    printf("=== Net Full Integration Test ===\n");
    
    int pid = fork();
    if(pid == 0) {
        server();
    } else {
        client();
        wait(0);
    }
    
    printf("\n=== Test Complete ===\n");
    exit(0);
}
