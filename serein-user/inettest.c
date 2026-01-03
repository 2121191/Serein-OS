// inettest.c - IPv4 Loopback Socket Test
// Tests AF_INET socket on 127.0.0.1

#include "kernel/include/types.h"
#include "serein-user/user.h"

#define PORT 8080

void server_process(void) {
  int sockfd, clientfd;
  struct sockaddr_in addr;
  struct sockaddr_in client_addr;
  int addrlen;
  char buf[64];
  int n;
  
  printf("[SERVER] Creating socket...\n");
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if(sockfd < 0){
    printf("[SERVER] socket() failed\n");
    exit(1);
  }
  printf("[SERVER] Socket created (fd=%d)\n", sockfd);
  
  // Bind to 127.0.0.1:8080
  addr.family = AF_INET;
  addr.addr = 0x7f000001;  // 127.0.0.1
  addr.port = PORT;
  
  printf("[SERVER] Binding to 127.0.0.1:%d...\n", PORT);
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
    printf("[SERVER] bind() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("[SERVER] Bound successfully\n");
  
  // Listen
  printf("[SERVER] Listening...\n");
  if(listen(sockfd, 5) < 0){
    printf("[SERVER] listen() failed\n");
    close(sockfd);
    exit(1);
  }
  
  // Accept
  printf("[SERVER] Waiting for connection...\n");
  addrlen = sizeof(client_addr);
  clientfd = accept(sockfd, (struct sockaddr*)&client_addr, &addrlen);
  if(clientfd < 0){
    printf("[SERVER] accept() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("[SERVER] Client connected (fd=%d)\n", clientfd);
  
  // Receive
  n = recv(clientfd, buf, sizeof(buf), 0);
  if(n > 0){
    buf[n] = 0;
    printf("[SERVER] Received: %s\n", buf);
    
    // Echo back
    send(clientfd, buf, n, 0);
    printf("[SERVER] Echoed message back\n");
  }
  
  close(clientfd);
  close(sockfd);
  printf("[SERVER] Done\n");
  exit(0);
}

void client_process(void) {
  int sockfd;
  struct sockaddr_in addr;
  char *msg = "Hello via loopback!";
  char buf[64];
  int n;
  
  // Wait for server to start
  sleep(10);
  
  printf("[CLIENT] Creating socket...\n");
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if(sockfd < 0){
    printf("[CLIENT] socket() failed\n");
    exit(1);
  }
  printf("[CLIENT] Socket created (fd=%d)\n", sockfd);
  
  // Connect to 127.0.0.1:8080
  addr.family = AF_INET;
  addr.addr = 0x7f000001;  // 127.0.0.1
  addr.port = PORT;
  
  printf("[CLIENT] Connecting to 127.0.0.1:%d...\n", PORT);
  if(connect(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
    printf("[CLIENT] connect() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("[CLIENT] Connected!\n");
  
  // Send
  printf("[CLIENT] Sending: %s\n", msg);
  send(sockfd, msg, strlen(msg), 0);
  
  // Receive echo
  n = recv(sockfd, buf, sizeof(buf), 0);
  if(n > 0){
    buf[n] = 0;
    printf("[CLIENT] Received echo: %s\n", buf);
  }
  
  close(sockfd);
  printf("[CLIENT] Done\n");
  exit(0);
}

int main(int argc, char *argv[]) {
  printf("=== IPv4 Loopback Socket Test ===\n\n");
  
  int pid = fork();
  if(pid == 0){
    // Child: server
    server_process();
  } else {
    // Parent: client
    client_process();
  }
  
  wait(0);
  printf("\n=== Loopback Test Complete ===\n");
  exit(0);
}
