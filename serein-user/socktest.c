// socktest.c - Unix Domain Socket Test
// Tests basic socket API: socket/bind/listen/accept/connect/send/recv

#include "kernel/include/types.h"
#include "serein-user/user.h"

#define SOCK_PATH "/tmp/test.sock"

void server_process(void) {
  int sockfd, clientfd;
  struct sockaddr_un addr;
  struct sockaddr_un client_addr;
  int addrlen;
  char buf[64];
  int n;
  
  printf("Server: Creating socket...\n");
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  if(sockfd < 0){
    printf("Server: socket() failed\n");
    exit(1);
  }
  printf("Server: Socket created (fd=%d)\n", sockfd);
  
  // Bind to path
  addr.family = AF_UNIX;
  strcpy(addr.path, SOCK_PATH);
  
  printf("Server: Binding to %s...\n", SOCK_PATH);
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
    printf("Server: bind() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Server: Bound successfully\n");
  
  // Listen for connections
  printf("Server: Listening...\n");
  if(listen(sockfd, 5) < 0){
    printf("Server: listen() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Server: Listening for connections\n");
  
  // Accept connection
  printf("Server: Waiting for client...\n");
  addrlen = sizeof(client_addr);
  printf("Server: calling accept...\n");
  clientfd = accept(sockfd, (struct sockaddr*)&client_addr, &addrlen);
  
  // Debug output (commented out for clean run)
  // write(1, "ACCEPT_RET\n", 11);
  // printf("Server: accept returned %d\n", clientfd);
  if(clientfd < 0){
    printf("Server: accept() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Server: Client connected (fd=%d)\n", clientfd);
  
  // Receive message
  n = recv(clientfd, buf, sizeof(buf), 0);
  if(n > 0){
    buf[n] = 0;
    printf("Server: Received: %s\n", buf);
    
    // Echo back
    send(clientfd, buf, n, 0);
    printf("Server: Echoed message back\n");
  }
  
  close(clientfd);
  close(sockfd);
  printf("Server: Done\n");
  exit(0);
}

void client_process(void) {
  int sockfd;
  struct sockaddr_un addr;
  char *msg = "Hello from client!";
  char buf[64];
  int n;
  
  // Small delay to let server start
  sleep(10);
  
  printf("Client: Creating socket...\n");
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  if(sockfd < 0){
    printf("Client: socket() failed\n");
    exit(1);
  }
  printf("Client: Socket created (fd=%d)\n", sockfd);
  
  // Connect to server
  addr.family = AF_UNIX;
  strcpy(addr.path, SOCK_PATH);
  
  printf("Client: Connecting to %s...\n", SOCK_PATH);
  if(connect(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
    printf("Client: connect() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Client: Connected!\n");
  
  // Send message
  printf("Client: Sending: %s\n", msg);
  send(sockfd, msg, strlen(msg), 0);
  
  // Receive echo
  n = recv(sockfd, buf, sizeof(buf), 0);
  if(n > 0){
    buf[n] = 0;
    printf("Client: Received echo: %s\n", buf);
  }
  
  close(sockfd);
  printf("Client: Done\n");
  exit(0);
}

int main(int argc, char *argv[]) {
  printf("=== Unix Domain Socket Test ===\n\n");
  
  int pid = fork();
  if(pid == 0){
    // Child: server
    server_process();
  } else {
    // Parent: client
    client_process();
  }
  
  wait(0);
  
  printf("\n=== Socket Test Complete ===\n");
  exit(0);
}
