// udptest.c - UDP/DGRAM Socket Test
// Tests message boundaries and connectionless-style (via connect) logic

#include "kernel/include/types.h"
#include "xv6-user/user.h"

void server_process(void) {
  int sockfd;
  struct sockaddr_un addr;
  char buf[64];
  int n;
  
  printf("[SERVER] Creating DGRAM socket...\n");
  sockfd = socket(AF_UNIX, SOCK_DGRAM, 0);
  if(sockfd < 0){
    printf("[SERVER] socket() failed\n");
    exit(1);
  }
  
  addr.family = AF_UNIX;
  strcpy(addr.path, "/tmp/udp.sock");
  
  printf("[SERVER] Binding to /tmp/udp.sock...\n");
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
    printf("[SERVER] bind() failed\n");
    exit(1);
  }
  
  // Note: UDP server does NOT listen() or accept()
  printf("[SERVER] Waiting for packets...\n");
  
  // Packet 1
  memset(buf, 0, sizeof(buf));
  n = recv(sockfd, buf, sizeof(buf), 0);
  if(n > 0){
    printf("[SERVER] Packet 1 received (%d bytes): %s\n", n, buf);
  } else {
    printf("[SERVER] Recv failed\n");
  }

  // Packet 2
  memset(buf, 0, sizeof(buf));
  n = recv(sockfd, buf, sizeof(buf), 0);
  if(n > 0){
    printf("[SERVER] Packet 2 received (%d bytes): %s\n", n, buf);
  }
  
  close(sockfd);
  printf("[SERVER] Done\n");
  exit(0);
}

void client_process(void) {
  int sockfd;
  struct sockaddr_un addr;
  
  sleep(5); // Wait for server to bind
  
  printf("[CLIENT] Creating DGRAM socket...\n");
  sockfd = socket(AF_UNIX, SOCK_DGRAM, 0);
  if(sockfd < 0){
    printf("[CLIENT] socket() failed\n");
    exit(1);
  }
  
  addr.family = AF_UNIX;
  strcpy(addr.path, "/tmp/udp.sock");
  
  // In our simple impl, we use connect() to set the destination
  printf("[CLIENT] Connecting to /tmp/udp.sock...\n");
  if(connect(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
    printf("[CLIENT] connect() failed\n");
    exit(1);
  }
  
  printf("[CLIENT] Sending Packet 1...\n");
  send(sockfd, "Hello", 5, 0);
  
  printf("[CLIENT] Sending Packet 2...\n");
  send(sockfd, "World", 5, 0);
  
  close(sockfd);
  printf("[CLIENT] Done\n");
  close(sockfd);
  printf("[CLIENT] Done\n");
  // return instead of exit so parent can wait for server
  return;
}

int main(int argc, char *argv[]) {
  printf("=== UDP/DGRAM Socket Test ===\n\n");
  
  int pid = fork();
  if(pid == 0){
    server_process();
  } else {
    client_process();
  }
  
  wait(0);
  printf("\n=== UDP Test Complete ===\n");
  exit(0);
}
