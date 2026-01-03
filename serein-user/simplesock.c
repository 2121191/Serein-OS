// simplesock.c - Minimal socket test without fork
#include "kernel/include/types.h"
#include "serein-user/user.h"

int main(int argc, char *argv[]) {
  int sockfd, clientfd;
  struct sockaddr_un addr;
  int addrlen;
  
  printf("=== Simple Socket Test ===\n");
  
  // Create socket
  printf("1. Creating socket...\n");
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  printf("2. socket() returned %d\n", sockfd);
  if(sockfd < 0) {
    printf("FAIL: socket() failed\n");
    exit(1);
  }
  
  // Bind
  addr.family = AF_UNIX;
  strcpy(addr.path, "/tmp/simple.sock");
  printf("3. Binding...\n");
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
    printf("FAIL: bind() failed\n");
    exit(1);
  }
  printf("4. bind() OK\n");
  
  // Listen
  printf("5. Listening...\n");
  if(listen(sockfd, 5) < 0) {
    printf("FAIL: listen() failed\n");
    exit(1);
  }
  printf("6. listen() OK\n");
  
  // Accept with timeout simulation - use fork to create client
  printf("7. Forking to create client...\n");
  int pid = fork();
  
  if(pid == 0) {
    // Child: client
    sleep(5);  // Let parent reach accept
    printf("[CLIENT] Connecting...\n");
    int csock = socket(AF_UNIX, SOCK_STREAM, 0);
    if(connect(csock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
      printf("[CLIENT] connect failed\n");
      exit(1);
    }
    printf("[CLIENT] Connected! Sending...\n");
    send(csock, "HELLO", 5, 0);
    printf("[CLIENT] Sent. Exiting.\n");
    close(csock);
    exit(0);
  }
  
  // Parent: server continues
  printf("8. Calling accept()...\n");
  // write(1, "PRE_ACCEPT\n", 11);
  addrlen = sizeof(addr);
  clientfd = accept(sockfd, (struct sockaddr*)&addr, &addrlen);
  // write(1, "POST_ACCEPT\n", 12);
  printf("9. accept() returned %d\n", clientfd);
  
  if(clientfd < 0) {
    printf("FAIL: accept() failed\n");
    wait(0);
    exit(1);
  }
  
  // Receive
  char buf[32];
  printf("10. Calling recv()...\n");
  int n = recv(clientfd, buf, sizeof(buf), 0);
  printf("11. recv() returned %d\n", n);
  if(n > 0) {
    buf[n] = 0;
    printf("12. Received: %s\n", buf);
  }
  
  close(clientfd);
  close(sockfd);
  wait(0);
  printf("=== Test Complete ===\n");
  exit(0);
}
