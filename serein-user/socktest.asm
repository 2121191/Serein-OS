
serein-user/_socktest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <server_process>:
#include "kernel/include/types.h"
#include "serein-user/user.h"

#define SOCK_PATH "/tmp/test.sock"

void server_process(void) {
   0:	710d                	addi	sp,sp,-352
   2:	ee86                	sd	ra,344(sp)
   4:	eaa2                	sd	s0,336(sp)
   6:	e6a6                	sd	s1,328(sp)
   8:	e2ca                	sd	s2,320(sp)
   a:	fe4e                	sd	s3,312(sp)
   c:	fa52                	sd	s4,304(sp)
   e:	1280                	addi	s0,sp,352
  struct sockaddr_un client_addr;
  int addrlen;
  char buf[64];
  int n;
  
  printf("Server: Creating socket...\n");
  10:	00001517          	auipc	a0,0x1
  14:	db050513          	addi	a0,a0,-592 # dc0 <malloc+0xf0>
  18:	00001097          	auipc	ra,0x1
  1c:	c00080e7          	jalr	-1024(ra) # c18 <printf>
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  20:	4601                	li	a2,0
  22:	4585                	li	a1,1
  24:	4505                	li	a0,1
  26:	00001097          	auipc	ra,0x1
  2a:	8ca080e7          	jalr	-1846(ra) # 8f0 <socket>
  if(sockfd < 0){
  2e:	12054d63          	bltz	a0,168 <server_process+0x168>
  32:	84aa                	mv	s1,a0
    printf("Server: socket() failed\n");
    exit(1);
  }
  printf("Server: Socket created (fd=%d)\n", sockfd);
  34:	85aa                	mv	a1,a0
  36:	00001517          	auipc	a0,0x1
  3a:	dca50513          	addi	a0,a0,-566 # e00 <malloc+0x130>
  3e:	00001097          	auipc	ra,0x1
  42:	bda080e7          	jalr	-1062(ra) # c18 <printf>
  
  // Bind to path
  addr.family = AF_UNIX;
  46:	4785                	li	a5,1
  48:	f6f41023          	sh	a5,-160(s0)
  strcpy(addr.path, SOCK_PATH);
  4c:	00001597          	auipc	a1,0x1
  50:	dd458593          	addi	a1,a1,-556 # e20 <malloc+0x150>
  54:	f6240513          	addi	a0,s0,-158
  58:	00000097          	auipc	ra,0x0
  5c:	388080e7          	jalr	904(ra) # 3e0 <strcpy>
  
  printf("Server: Binding to %s...\n", SOCK_PATH);
  60:	00001597          	auipc	a1,0x1
  64:	dc058593          	addi	a1,a1,-576 # e20 <malloc+0x150>
  68:	00001517          	auipc	a0,0x1
  6c:	dc850513          	addi	a0,a0,-568 # e30 <malloc+0x160>
  70:	00001097          	auipc	ra,0x1
  74:	ba8080e7          	jalr	-1112(ra) # c18 <printf>
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
  78:	06e00613          	li	a2,110
  7c:	f6040593          	addi	a1,s0,-160
  80:	8526                	mv	a0,s1
  82:	00001097          	auipc	ra,0x1
  86:	878080e7          	jalr	-1928(ra) # 8fa <bind>
  8a:	0e054c63          	bltz	a0,182 <server_process+0x182>
    printf("Server: bind() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Server: Bound successfully\n");
  8e:	00001517          	auipc	a0,0x1
  92:	dda50513          	addi	a0,a0,-550 # e68 <malloc+0x198>
  96:	00001097          	auipc	ra,0x1
  9a:	b82080e7          	jalr	-1150(ra) # c18 <printf>
  
  // Listen for connections
  printf("Server: Listening...\n");
  9e:	00001517          	auipc	a0,0x1
  a2:	dea50513          	addi	a0,a0,-534 # e88 <malloc+0x1b8>
  a6:	00001097          	auipc	ra,0x1
  aa:	b72080e7          	jalr	-1166(ra) # c18 <printf>
  if(listen(sockfd, 5) < 0){
  ae:	4595                	li	a1,5
  b0:	8526                	mv	a0,s1
  b2:	00001097          	auipc	ra,0x1
  b6:	852080e7          	jalr	-1966(ra) # 904 <listen>
  ba:	0e054663          	bltz	a0,1a6 <server_process+0x1a6>
    printf("Server: listen() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Server: Listening for connections\n");
  be:	00001517          	auipc	a0,0x1
  c2:	e0250513          	addi	a0,a0,-510 # ec0 <malloc+0x1f0>
  c6:	00001097          	auipc	ra,0x1
  ca:	b52080e7          	jalr	-1198(ra) # c18 <printf>
  
  // Accept connection
  printf("Server: Waiting for client...\n");
  ce:	00001517          	auipc	a0,0x1
  d2:	e1a50513          	addi	a0,a0,-486 # ee8 <malloc+0x218>
  d6:	00001097          	auipc	ra,0x1
  da:	b42080e7          	jalr	-1214(ra) # c18 <printf>
  addrlen = sizeof(client_addr);
  de:	06e00793          	li	a5,110
  e2:	eef42623          	sw	a5,-276(s0)
  printf("Server: calling accept...\n");
  e6:	00001517          	auipc	a0,0x1
  ea:	e2250513          	addi	a0,a0,-478 # f08 <malloc+0x238>
  ee:	00001097          	auipc	ra,0x1
  f2:	b2a080e7          	jalr	-1238(ra) # c18 <printf>
  clientfd = accept(sockfd, (struct sockaddr*)&client_addr, &addrlen);
  f6:	eec40613          	addi	a2,s0,-276
  fa:	ef040593          	addi	a1,s0,-272
  fe:	8526                	mv	a0,s1
 100:	00001097          	auipc	ra,0x1
 104:	80e080e7          	jalr	-2034(ra) # 90e <accept>
 108:	892a                	mv	s2,a0
  
  // Debug output (commented out for clean run)
  // write(1, "ACCEPT_RET\n", 11);
  // printf("Server: accept returned %d\n", clientfd);
  if(clientfd < 0){
 10a:	0c054063          	bltz	a0,1ca <server_process+0x1ca>
    printf("Server: accept() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Server: Client connected (fd=%d)\n", clientfd);
 10e:	85aa                	mv	a1,a0
 110:	00001517          	auipc	a0,0x1
 114:	e3850513          	addi	a0,a0,-456 # f48 <malloc+0x278>
 118:	00001097          	auipc	ra,0x1
 11c:	b00080e7          	jalr	-1280(ra) # c18 <printf>
  
  // Receive message
  n = recv(clientfd, buf, sizeof(buf), 0);
 120:	4681                	li	a3,0
 122:	04000613          	li	a2,64
 126:	ea840593          	addi	a1,s0,-344
 12a:	854a                	mv	a0,s2
 12c:	00001097          	auipc	ra,0x1
 130:	800080e7          	jalr	-2048(ra) # 92c <recv>
 134:	89aa                	mv	s3,a0
  if(n > 0){
 136:	0aa04c63          	bgtz	a0,1ee <server_process+0x1ee>
    // Echo back
    send(clientfd, buf, n, 0);
    printf("Server: Echoed message back\n");
  }
  
  close(clientfd);
 13a:	854a                	mv	a0,s2
 13c:	00000097          	auipc	ra,0x0
 140:	584080e7          	jalr	1412(ra) # 6c0 <close>
  close(sockfd);
 144:	8526                	mv	a0,s1
 146:	00000097          	auipc	ra,0x0
 14a:	57a080e7          	jalr	1402(ra) # 6c0 <close>
  printf("Server: Done\n");
 14e:	00001517          	auipc	a0,0x1
 152:	e5a50513          	addi	a0,a0,-422 # fa8 <malloc+0x2d8>
 156:	00001097          	auipc	ra,0x1
 15a:	ac2080e7          	jalr	-1342(ra) # c18 <printf>
  exit(0);
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	538080e7          	jalr	1336(ra) # 698 <exit>
    printf("Server: socket() failed\n");
 168:	00001517          	auipc	a0,0x1
 16c:	c7850513          	addi	a0,a0,-904 # de0 <malloc+0x110>
 170:	00001097          	auipc	ra,0x1
 174:	aa8080e7          	jalr	-1368(ra) # c18 <printf>
    exit(1);
 178:	4505                	li	a0,1
 17a:	00000097          	auipc	ra,0x0
 17e:	51e080e7          	jalr	1310(ra) # 698 <exit>
    printf("Server: bind() failed\n");
 182:	00001517          	auipc	a0,0x1
 186:	cce50513          	addi	a0,a0,-818 # e50 <malloc+0x180>
 18a:	00001097          	auipc	ra,0x1
 18e:	a8e080e7          	jalr	-1394(ra) # c18 <printf>
    close(sockfd);
 192:	8526                	mv	a0,s1
 194:	00000097          	auipc	ra,0x0
 198:	52c080e7          	jalr	1324(ra) # 6c0 <close>
    exit(1);
 19c:	4505                	li	a0,1
 19e:	00000097          	auipc	ra,0x0
 1a2:	4fa080e7          	jalr	1274(ra) # 698 <exit>
    printf("Server: listen() failed\n");
 1a6:	00001517          	auipc	a0,0x1
 1aa:	cfa50513          	addi	a0,a0,-774 # ea0 <malloc+0x1d0>
 1ae:	00001097          	auipc	ra,0x1
 1b2:	a6a080e7          	jalr	-1430(ra) # c18 <printf>
    close(sockfd);
 1b6:	8526                	mv	a0,s1
 1b8:	00000097          	auipc	ra,0x0
 1bc:	508080e7          	jalr	1288(ra) # 6c0 <close>
    exit(1);
 1c0:	4505                	li	a0,1
 1c2:	00000097          	auipc	ra,0x0
 1c6:	4d6080e7          	jalr	1238(ra) # 698 <exit>
    printf("Server: accept() failed\n");
 1ca:	00001517          	auipc	a0,0x1
 1ce:	d5e50513          	addi	a0,a0,-674 # f28 <malloc+0x258>
 1d2:	00001097          	auipc	ra,0x1
 1d6:	a46080e7          	jalr	-1466(ra) # c18 <printf>
    close(sockfd);
 1da:	8526                	mv	a0,s1
 1dc:	00000097          	auipc	ra,0x0
 1e0:	4e4080e7          	jalr	1252(ra) # 6c0 <close>
    exit(1);
 1e4:	4505                	li	a0,1
 1e6:	00000097          	auipc	ra,0x0
 1ea:	4b2080e7          	jalr	1202(ra) # 698 <exit>
    buf[n] = 0;
 1ee:	fd050793          	addi	a5,a0,-48
 1f2:	97a2                	add	a5,a5,s0
 1f4:	ec078c23          	sb	zero,-296(a5)
    printf("Server: Received: %s\n", buf);
 1f8:	ea840a13          	addi	s4,s0,-344
 1fc:	85d2                	mv	a1,s4
 1fe:	00001517          	auipc	a0,0x1
 202:	d7250513          	addi	a0,a0,-654 # f70 <malloc+0x2a0>
 206:	00001097          	auipc	ra,0x1
 20a:	a12080e7          	jalr	-1518(ra) # c18 <printf>
    send(clientfd, buf, n, 0);
 20e:	4681                	li	a3,0
 210:	864e                	mv	a2,s3
 212:	85d2                	mv	a1,s4
 214:	854a                	mv	a0,s2
 216:	00000097          	auipc	ra,0x0
 21a:	70c080e7          	jalr	1804(ra) # 922 <send>
    printf("Server: Echoed message back\n");
 21e:	00001517          	auipc	a0,0x1
 222:	d6a50513          	addi	a0,a0,-662 # f88 <malloc+0x2b8>
 226:	00001097          	auipc	ra,0x1
 22a:	9f2080e7          	jalr	-1550(ra) # c18 <printf>
 22e:	b731                	j	13a <server_process+0x13a>

0000000000000230 <client_process>:
}

void client_process(void) {
 230:	7155                	addi	sp,sp,-208
 232:	e586                	sd	ra,200(sp)
 234:	e1a2                	sd	s0,192(sp)
 236:	fd26                	sd	s1,184(sp)
 238:	0980                	addi	s0,sp,208
  char *msg = "Hello from client!";
  char buf[64];
  int n;
  
  // Small delay to let server start
  sleep(10);
 23a:	4529                	li	a0,10
 23c:	00000097          	auipc	ra,0x0
 240:	4d4080e7          	jalr	1236(ra) # 710 <sleep>
  
  printf("Client: Creating socket...\n");
 244:	00001517          	auipc	a0,0x1
 248:	d7450513          	addi	a0,a0,-652 # fb8 <malloc+0x2e8>
 24c:	00001097          	auipc	ra,0x1
 250:	9cc080e7          	jalr	-1588(ra) # c18 <printf>
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
 254:	4601                	li	a2,0
 256:	4585                	li	a1,1
 258:	4505                	li	a0,1
 25a:	00000097          	auipc	ra,0x0
 25e:	696080e7          	jalr	1686(ra) # 8f0 <socket>
  if(sockfd < 0){
 262:	0e054663          	bltz	a0,34e <client_process+0x11e>
 266:	84aa                	mv	s1,a0
    printf("Client: socket() failed\n");
    exit(1);
  }
  printf("Client: Socket created (fd=%d)\n", sockfd);
 268:	85aa                	mv	a1,a0
 26a:	00001517          	auipc	a0,0x1
 26e:	d8e50513          	addi	a0,a0,-626 # ff8 <malloc+0x328>
 272:	00001097          	auipc	ra,0x1
 276:	9a6080e7          	jalr	-1626(ra) # c18 <printf>
  
  // Connect to server
  addr.family = AF_UNIX;
 27a:	4785                	li	a5,1
 27c:	f6f41823          	sh	a5,-144(s0)
  strcpy(addr.path, SOCK_PATH);
 280:	00001597          	auipc	a1,0x1
 284:	ba058593          	addi	a1,a1,-1120 # e20 <malloc+0x150>
 288:	f7240513          	addi	a0,s0,-142
 28c:	00000097          	auipc	ra,0x0
 290:	154080e7          	jalr	340(ra) # 3e0 <strcpy>
  
  printf("Client: Connecting to %s...\n", SOCK_PATH);
 294:	00001597          	auipc	a1,0x1
 298:	b8c58593          	addi	a1,a1,-1140 # e20 <malloc+0x150>
 29c:	00001517          	auipc	a0,0x1
 2a0:	d7c50513          	addi	a0,a0,-644 # 1018 <malloc+0x348>
 2a4:	00001097          	auipc	ra,0x1
 2a8:	974080e7          	jalr	-1676(ra) # c18 <printf>
  if(connect(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
 2ac:	06e00613          	li	a2,110
 2b0:	f7040593          	addi	a1,s0,-144
 2b4:	8526                	mv	a0,s1
 2b6:	00000097          	auipc	ra,0x0
 2ba:	662080e7          	jalr	1634(ra) # 918 <connect>
 2be:	0a054563          	bltz	a0,368 <client_process+0x138>
    printf("Client: connect() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("Client: Connected!\n");
 2c2:	00001517          	auipc	a0,0x1
 2c6:	d9650513          	addi	a0,a0,-618 # 1058 <malloc+0x388>
 2ca:	00001097          	auipc	ra,0x1
 2ce:	94e080e7          	jalr	-1714(ra) # c18 <printf>
  
  // Send message
  printf("Client: Sending: %s\n", msg);
 2d2:	00001597          	auipc	a1,0x1
 2d6:	d9e58593          	addi	a1,a1,-610 # 1070 <malloc+0x3a0>
 2da:	00001517          	auipc	a0,0x1
 2de:	dae50513          	addi	a0,a0,-594 # 1088 <malloc+0x3b8>
 2e2:	00001097          	auipc	ra,0x1
 2e6:	936080e7          	jalr	-1738(ra) # c18 <printf>
  send(sockfd, msg, strlen(msg), 0);
 2ea:	00001517          	auipc	a0,0x1
 2ee:	d8650513          	addi	a0,a0,-634 # 1070 <malloc+0x3a0>
 2f2:	00000097          	auipc	ra,0x0
 2f6:	164080e7          	jalr	356(ra) # 456 <strlen>
 2fa:	4681                	li	a3,0
 2fc:	0005061b          	sext.w	a2,a0
 300:	00001597          	auipc	a1,0x1
 304:	d7058593          	addi	a1,a1,-656 # 1070 <malloc+0x3a0>
 308:	8526                	mv	a0,s1
 30a:	00000097          	auipc	ra,0x0
 30e:	618080e7          	jalr	1560(ra) # 922 <send>
  
  // Receive echo
  n = recv(sockfd, buf, sizeof(buf), 0);
 312:	4681                	li	a3,0
 314:	04000613          	li	a2,64
 318:	f3040593          	addi	a1,s0,-208
 31c:	8526                	mv	a0,s1
 31e:	00000097          	auipc	ra,0x0
 322:	60e080e7          	jalr	1550(ra) # 92c <recv>
  if(n > 0){
 326:	06a04363          	bgtz	a0,38c <client_process+0x15c>
    buf[n] = 0;
    printf("Client: Received echo: %s\n", buf);
  }
  
  close(sockfd);
 32a:	8526                	mv	a0,s1
 32c:	00000097          	auipc	ra,0x0
 330:	394080e7          	jalr	916(ra) # 6c0 <close>
  printf("Client: Done\n");
 334:	00001517          	auipc	a0,0x1
 338:	d8c50513          	addi	a0,a0,-628 # 10c0 <malloc+0x3f0>
 33c:	00001097          	auipc	ra,0x1
 340:	8dc080e7          	jalr	-1828(ra) # c18 <printf>
  exit(0);
 344:	4501                	li	a0,0
 346:	00000097          	auipc	ra,0x0
 34a:	352080e7          	jalr	850(ra) # 698 <exit>
    printf("Client: socket() failed\n");
 34e:	00001517          	auipc	a0,0x1
 352:	c8a50513          	addi	a0,a0,-886 # fd8 <malloc+0x308>
 356:	00001097          	auipc	ra,0x1
 35a:	8c2080e7          	jalr	-1854(ra) # c18 <printf>
    exit(1);
 35e:	4505                	li	a0,1
 360:	00000097          	auipc	ra,0x0
 364:	338080e7          	jalr	824(ra) # 698 <exit>
    printf("Client: connect() failed\n");
 368:	00001517          	auipc	a0,0x1
 36c:	cd050513          	addi	a0,a0,-816 # 1038 <malloc+0x368>
 370:	00001097          	auipc	ra,0x1
 374:	8a8080e7          	jalr	-1880(ra) # c18 <printf>
    close(sockfd);
 378:	8526                	mv	a0,s1
 37a:	00000097          	auipc	ra,0x0
 37e:	346080e7          	jalr	838(ra) # 6c0 <close>
    exit(1);
 382:	4505                	li	a0,1
 384:	00000097          	auipc	ra,0x0
 388:	314080e7          	jalr	788(ra) # 698 <exit>
    buf[n] = 0;
 38c:	fe050793          	addi	a5,a0,-32
 390:	00878533          	add	a0,a5,s0
 394:	f4050823          	sb	zero,-176(a0)
    printf("Client: Received echo: %s\n", buf);
 398:	f3040593          	addi	a1,s0,-208
 39c:	00001517          	auipc	a0,0x1
 3a0:	d0450513          	addi	a0,a0,-764 # 10a0 <malloc+0x3d0>
 3a4:	00001097          	auipc	ra,0x1
 3a8:	874080e7          	jalr	-1932(ra) # c18 <printf>
 3ac:	bfbd                	j	32a <client_process+0xfa>

00000000000003ae <main>:
}

int main(int argc, char *argv[]) {
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e406                	sd	ra,8(sp)
 3b2:	e022                	sd	s0,0(sp)
 3b4:	0800                	addi	s0,sp,16
  printf("=== Unix Domain Socket Test ===\n\n");
 3b6:	00001517          	auipc	a0,0x1
 3ba:	d1a50513          	addi	a0,a0,-742 # 10d0 <malloc+0x400>
 3be:	00001097          	auipc	ra,0x1
 3c2:	85a080e7          	jalr	-1958(ra) # c18 <printf>
  
  int pid = fork();
 3c6:	00000097          	auipc	ra,0x0
 3ca:	2ca080e7          	jalr	714(ra) # 690 <fork>
  if(pid == 0){
 3ce:	e509                	bnez	a0,3d8 <main+0x2a>
    // Child: server
    server_process();
 3d0:	00000097          	auipc	ra,0x0
 3d4:	c30080e7          	jalr	-976(ra) # 0 <server_process>
  } else {
    // Parent: client
    client_process();
 3d8:	00000097          	auipc	ra,0x0
 3dc:	e58080e7          	jalr	-424(ra) # 230 <client_process>

00000000000003e0 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 3e0:	1141                	addi	sp,sp,-16
 3e2:	e422                	sd	s0,8(sp)
 3e4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3e6:	87aa                	mv	a5,a0
 3e8:	0585                	addi	a1,a1,1
 3ea:	0785                	addi	a5,a5,1
 3ec:	fff5c703          	lbu	a4,-1(a1)
 3f0:	fee78fa3          	sb	a4,-1(a5)
 3f4:	fb75                	bnez	a4,3e8 <strcpy+0x8>
    ;
  return os;
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <strcat>:

char*
strcat(char *s, const char *t)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 402:	00054783          	lbu	a5,0(a0)
 406:	c385                	beqz	a5,426 <strcat+0x2a>
 408:	87aa                	mv	a5,a0
    s++;
 40a:	0785                	addi	a5,a5,1
  while(*s)
 40c:	0007c703          	lbu	a4,0(a5)
 410:	ff6d                	bnez	a4,40a <strcat+0xe>
  while((*s++ = *t++))
 412:	0585                	addi	a1,a1,1
 414:	0785                	addi	a5,a5,1
 416:	fff5c703          	lbu	a4,-1(a1)
 41a:	fee78fa3          	sb	a4,-1(a5)
 41e:	fb75                	bnez	a4,412 <strcat+0x16>
    ;
  return os;
}
 420:	6422                	ld	s0,8(sp)
 422:	0141                	addi	sp,sp,16
 424:	8082                	ret
  while(*s)
 426:	87aa                	mv	a5,a0
 428:	b7ed                	j	412 <strcat+0x16>

000000000000042a <strcmp>:


int
strcmp(const char *p, const char *q)
{
 42a:	1141                	addi	sp,sp,-16
 42c:	e422                	sd	s0,8(sp)
 42e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 430:	00054783          	lbu	a5,0(a0)
 434:	cb91                	beqz	a5,448 <strcmp+0x1e>
 436:	0005c703          	lbu	a4,0(a1)
 43a:	00f71763          	bne	a4,a5,448 <strcmp+0x1e>
    p++, q++;
 43e:	0505                	addi	a0,a0,1
 440:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 442:	00054783          	lbu	a5,0(a0)
 446:	fbe5                	bnez	a5,436 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 448:	0005c503          	lbu	a0,0(a1)
}
 44c:	40a7853b          	subw	a0,a5,a0
 450:	6422                	ld	s0,8(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret

0000000000000456 <strlen>:

uint
strlen(const char *s)
{
 456:	1141                	addi	sp,sp,-16
 458:	e422                	sd	s0,8(sp)
 45a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 45c:	00054783          	lbu	a5,0(a0)
 460:	cf91                	beqz	a5,47c <strlen+0x26>
 462:	0505                	addi	a0,a0,1
 464:	87aa                	mv	a5,a0
 466:	4685                	li	a3,1
 468:	9e89                	subw	a3,a3,a0
 46a:	00f6853b          	addw	a0,a3,a5
 46e:	0785                	addi	a5,a5,1
 470:	fff7c703          	lbu	a4,-1(a5)
 474:	fb7d                	bnez	a4,46a <strlen+0x14>
    ;
  return n;
}
 476:	6422                	ld	s0,8(sp)
 478:	0141                	addi	sp,sp,16
 47a:	8082                	ret
  for(n = 0; s[n]; n++)
 47c:	4501                	li	a0,0
 47e:	bfe5                	j	476 <strlen+0x20>

0000000000000480 <memset>:

void*
memset(void *dst, int c, uint n)
{
 480:	1141                	addi	sp,sp,-16
 482:	e422                	sd	s0,8(sp)
 484:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 486:	ca19                	beqz	a2,49c <memset+0x1c>
 488:	87aa                	mv	a5,a0
 48a:	1602                	slli	a2,a2,0x20
 48c:	9201                	srli	a2,a2,0x20
 48e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 492:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 496:	0785                	addi	a5,a5,1
 498:	fee79de3          	bne	a5,a4,492 <memset+0x12>
  }
  return dst;
}
 49c:	6422                	ld	s0,8(sp)
 49e:	0141                	addi	sp,sp,16
 4a0:	8082                	ret

00000000000004a2 <strchr>:

char*
strchr(const char *s, char c)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4a8:	00054783          	lbu	a5,0(a0)
 4ac:	cb99                	beqz	a5,4c2 <strchr+0x20>
    if(*s == c)
 4ae:	00f58763          	beq	a1,a5,4bc <strchr+0x1a>
  for(; *s; s++)
 4b2:	0505                	addi	a0,a0,1
 4b4:	00054783          	lbu	a5,0(a0)
 4b8:	fbfd                	bnez	a5,4ae <strchr+0xc>
      return (char*)s;
  return 0;
 4ba:	4501                	li	a0,0
}
 4bc:	6422                	ld	s0,8(sp)
 4be:	0141                	addi	sp,sp,16
 4c0:	8082                	ret
  return 0;
 4c2:	4501                	li	a0,0
 4c4:	bfe5                	j	4bc <strchr+0x1a>

00000000000004c6 <gets>:

char*
gets(char *buf, int max)
{
 4c6:	711d                	addi	sp,sp,-96
 4c8:	ec86                	sd	ra,88(sp)
 4ca:	e8a2                	sd	s0,80(sp)
 4cc:	e4a6                	sd	s1,72(sp)
 4ce:	e0ca                	sd	s2,64(sp)
 4d0:	fc4e                	sd	s3,56(sp)
 4d2:	f852                	sd	s4,48(sp)
 4d4:	f456                	sd	s5,40(sp)
 4d6:	f05a                	sd	s6,32(sp)
 4d8:	ec5e                	sd	s7,24(sp)
 4da:	e862                	sd	s8,16(sp)
 4dc:	1080                	addi	s0,sp,96
 4de:	8baa                	mv	s7,a0
 4e0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4e2:	892a                	mv	s2,a0
 4e4:	4481                	li	s1,0
    cc = read(0, &c, 1);
 4e6:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4ea:	4b29                	li	s6,10
 4ec:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 4ee:	89a6                	mv	s3,s1
 4f0:	2485                	addiw	s1,s1,1
 4f2:	0344d763          	bge	s1,s4,520 <gets+0x5a>
    cc = read(0, &c, 1);
 4f6:	4605                	li	a2,1
 4f8:	85d6                	mv	a1,s5
 4fa:	4501                	li	a0,0
 4fc:	00000097          	auipc	ra,0x0
 500:	1b4080e7          	jalr	436(ra) # 6b0 <read>
    if(cc < 1)
 504:	00a05e63          	blez	a0,520 <gets+0x5a>
    buf[i++] = c;
 508:	faf44783          	lbu	a5,-81(s0)
 50c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 510:	01678763          	beq	a5,s6,51e <gets+0x58>
 514:	0905                	addi	s2,s2,1
 516:	fd879ce3          	bne	a5,s8,4ee <gets+0x28>
  for(i=0; i+1 < max; ){
 51a:	89a6                	mv	s3,s1
 51c:	a011                	j	520 <gets+0x5a>
 51e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 520:	99de                	add	s3,s3,s7
 522:	00098023          	sb	zero,0(s3)
  return buf;
}
 526:	855e                	mv	a0,s7
 528:	60e6                	ld	ra,88(sp)
 52a:	6446                	ld	s0,80(sp)
 52c:	64a6                	ld	s1,72(sp)
 52e:	6906                	ld	s2,64(sp)
 530:	79e2                	ld	s3,56(sp)
 532:	7a42                	ld	s4,48(sp)
 534:	7aa2                	ld	s5,40(sp)
 536:	7b02                	ld	s6,32(sp)
 538:	6be2                	ld	s7,24(sp)
 53a:	6c42                	ld	s8,16(sp)
 53c:	6125                	addi	sp,sp,96
 53e:	8082                	ret

0000000000000540 <stat>:

int
stat(const char *n, struct stat *st)
{
 540:	1101                	addi	sp,sp,-32
 542:	ec06                	sd	ra,24(sp)
 544:	e822                	sd	s0,16(sp)
 546:	e426                	sd	s1,8(sp)
 548:	e04a                	sd	s2,0(sp)
 54a:	1000                	addi	s0,sp,32
 54c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 54e:	4581                	li	a1,0
 550:	00000097          	auipc	ra,0x0
 554:	188080e7          	jalr	392(ra) # 6d8 <open>
  if(fd < 0)
 558:	02054563          	bltz	a0,582 <stat+0x42>
 55c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 55e:	85ca                	mv	a1,s2
 560:	00000097          	auipc	ra,0x0
 564:	180080e7          	jalr	384(ra) # 6e0 <fstat>
 568:	892a                	mv	s2,a0
  close(fd);
 56a:	8526                	mv	a0,s1
 56c:	00000097          	auipc	ra,0x0
 570:	154080e7          	jalr	340(ra) # 6c0 <close>
  return r;
}
 574:	854a                	mv	a0,s2
 576:	60e2                	ld	ra,24(sp)
 578:	6442                	ld	s0,16(sp)
 57a:	64a2                	ld	s1,8(sp)
 57c:	6902                	ld	s2,0(sp)
 57e:	6105                	addi	sp,sp,32
 580:	8082                	ret
    return -1;
 582:	597d                	li	s2,-1
 584:	bfc5                	j	574 <stat+0x34>

0000000000000586 <atoi>:

int
atoi(const char *s)
{
 586:	1141                	addi	sp,sp,-16
 588:	e422                	sd	s0,8(sp)
 58a:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 58c:	00054703          	lbu	a4,0(a0)
 590:	02d00793          	li	a5,45
  int neg = 1;
 594:	4585                	li	a1,1
  if (*s == '-') {
 596:	04f70363          	beq	a4,a5,5dc <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 59a:	00054703          	lbu	a4,0(a0)
 59e:	fd07079b          	addiw	a5,a4,-48
 5a2:	0ff7f793          	zext.b	a5,a5
 5a6:	46a5                	li	a3,9
 5a8:	02f6ed63          	bltu	a3,a5,5e2 <atoi+0x5c>
  n = 0;
 5ac:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 5ae:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 5b0:	0505                	addi	a0,a0,1
 5b2:	0026979b          	slliw	a5,a3,0x2
 5b6:	9fb5                	addw	a5,a5,a3
 5b8:	0017979b          	slliw	a5,a5,0x1
 5bc:	9fb9                	addw	a5,a5,a4
 5be:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 5c2:	00054703          	lbu	a4,0(a0)
 5c6:	fd07079b          	addiw	a5,a4,-48
 5ca:	0ff7f793          	zext.b	a5,a5
 5ce:	fef671e3          	bgeu	a2,a5,5b0 <atoi+0x2a>
  return n * neg;
}
 5d2:	02d5853b          	mulw	a0,a1,a3
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret
    s++;
 5dc:	0505                	addi	a0,a0,1
    neg = -1;
 5de:	55fd                	li	a1,-1
 5e0:	bf6d                	j	59a <atoi+0x14>
  n = 0;
 5e2:	4681                	li	a3,0
 5e4:	b7fd                	j	5d2 <atoi+0x4c>

00000000000005e6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5e6:	1141                	addi	sp,sp,-16
 5e8:	e422                	sd	s0,8(sp)
 5ea:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5ec:	02b57463          	bgeu	a0,a1,614 <memmove+0x2e>
    while(n-- > 0)
 5f0:	00c05f63          	blez	a2,60e <memmove+0x28>
 5f4:	1602                	slli	a2,a2,0x20
 5f6:	9201                	srli	a2,a2,0x20
 5f8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 5fe:	0585                	addi	a1,a1,1
 600:	0705                	addi	a4,a4,1
 602:	fff5c683          	lbu	a3,-1(a1)
 606:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 60a:	fee79ae3          	bne	a5,a4,5fe <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 60e:	6422                	ld	s0,8(sp)
 610:	0141                	addi	sp,sp,16
 612:	8082                	ret
    dst += n;
 614:	00c50733          	add	a4,a0,a2
    src += n;
 618:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 61a:	fec05ae3          	blez	a2,60e <memmove+0x28>
 61e:	fff6079b          	addiw	a5,a2,-1
 622:	1782                	slli	a5,a5,0x20
 624:	9381                	srli	a5,a5,0x20
 626:	fff7c793          	not	a5,a5
 62a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 62c:	15fd                	addi	a1,a1,-1
 62e:	177d                	addi	a4,a4,-1
 630:	0005c683          	lbu	a3,0(a1)
 634:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 638:	fee79ae3          	bne	a5,a4,62c <memmove+0x46>
 63c:	bfc9                	j	60e <memmove+0x28>

000000000000063e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 63e:	1141                	addi	sp,sp,-16
 640:	e422                	sd	s0,8(sp)
 642:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 644:	ca05                	beqz	a2,674 <memcmp+0x36>
 646:	fff6069b          	addiw	a3,a2,-1
 64a:	1682                	slli	a3,a3,0x20
 64c:	9281                	srli	a3,a3,0x20
 64e:	0685                	addi	a3,a3,1
 650:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 652:	00054783          	lbu	a5,0(a0)
 656:	0005c703          	lbu	a4,0(a1)
 65a:	00e79863          	bne	a5,a4,66a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 65e:	0505                	addi	a0,a0,1
    p2++;
 660:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 662:	fed518e3          	bne	a0,a3,652 <memcmp+0x14>
  }
  return 0;
 666:	4501                	li	a0,0
 668:	a019                	j	66e <memcmp+0x30>
      return *p1 - *p2;
 66a:	40e7853b          	subw	a0,a5,a4
}
 66e:	6422                	ld	s0,8(sp)
 670:	0141                	addi	sp,sp,16
 672:	8082                	ret
  return 0;
 674:	4501                	li	a0,0
 676:	bfe5                	j	66e <memcmp+0x30>

0000000000000678 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 678:	1141                	addi	sp,sp,-16
 67a:	e406                	sd	ra,8(sp)
 67c:	e022                	sd	s0,0(sp)
 67e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 680:	00000097          	auipc	ra,0x0
 684:	f66080e7          	jalr	-154(ra) # 5e6 <memmove>
}
 688:	60a2                	ld	ra,8(sp)
 68a:	6402                	ld	s0,0(sp)
 68c:	0141                	addi	sp,sp,16
 68e:	8082                	ret

0000000000000690 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 690:	4885                	li	a7,1
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <exit>:
.global exit
exit:
 li a7, SYS_exit
 698:	4889                	li	a7,2
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6a0:	488d                	li	a7,3
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6a8:	4891                	li	a7,4
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <read>:
.global read
read:
 li a7, SYS_read
 6b0:	4895                	li	a7,5
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <write>:
.global write
write:
 li a7, SYS_write
 6b8:	48c1                	li	a7,16
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <close>:
.global close
close:
 li a7, SYS_close
 6c0:	48d5                	li	a7,21
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6c8:	4899                	li	a7,6
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6d0:	489d                	li	a7,7
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <open>:
.global open
open:
 li a7, SYS_open
 6d8:	48bd                	li	a7,15
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6e0:	48a1                	li	a7,8
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6e8:	48d1                	li	a7,20
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6f0:	48a5                	li	a7,9
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6f8:	48a9                	li	a7,10
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 700:	48ad                	li	a7,11
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 708:	48b1                	li	a7,12
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 710:	48b5                	li	a7,13
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 718:	48b9                	li	a7,14
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 720:	48d9                	li	a7,22
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <dev>:
.global dev
dev:
 li a7, SYS_dev
 728:	48dd                	li	a7,23
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 730:	48e1                	li	a7,24
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 738:	48e5                	li	a7,25
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <remove>:
.global remove
remove:
 li a7, SYS_remove
 740:	48c5                	li	a7,17
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <trace>:
.global trace
trace:
 li a7, SYS_trace
 748:	48c9                	li	a7,18
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 750:	48cd                	li	a7,19
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <rename>:
.global rename
rename:
 li a7, SYS_rename
 758:	48e9                	li	a7,26
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 760:	48ed                	li	a7,27
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 768:	48f1                	li	a7,28
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 770:	48f5                	li	a7,29
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 778:	48f9                	li	a7,30
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 780:	48fd                	li	a7,31
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 788:	02000893          	li	a7,32
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 792:	02100893          	li	a7,33
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 79c:	02200893          	li	a7,34
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 7a6:	02300893          	li	a7,35
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 7b0:	02400893          	li	a7,36
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 7ba:	02500893          	li	a7,37
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 7c4:	02600893          	li	a7,38
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 7ce:	02700893          	li	a7,39
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 7d8:	02800893          	li	a7,40
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 7e2:	02900893          	li	a7,41
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 7ec:	02a00893          	li	a7,42
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 7f6:	02b00893          	li	a7,43
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 800:	02c00893          	li	a7,44
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 80a:	02d00893          	li	a7,45
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 814:	02e00893          	li	a7,46
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 81e:	02f00893          	li	a7,47
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 828:	03000893          	li	a7,48
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 832:	03100893          	li	a7,49
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 83c:	03200893          	li	a7,50
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 846:	03300893          	li	a7,51
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 850:	03400893          	li	a7,52
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 85a:	03500893          	li	a7,53
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 864:	03600893          	li	a7,54
 ecall
 868:	00000073          	ecall
 ret
 86c:	8082                	ret

000000000000086e <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 86e:	03700893          	li	a7,55
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 878:	03800893          	li	a7,56
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 882:	03900893          	li	a7,57
 ecall
 886:	00000073          	ecall
 ret
 88a:	8082                	ret

000000000000088c <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 88c:	03a00893          	li	a7,58
 ecall
 890:	00000073          	ecall
 ret
 894:	8082                	ret

0000000000000896 <poll>:
.global poll
poll:
 li a7, SYS_poll
 896:	03b00893          	li	a7,59
 ecall
 89a:	00000073          	ecall
 ret
 89e:	8082                	ret

00000000000008a0 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 8a0:	03c00893          	li	a7,60
 ecall
 8a4:	00000073          	ecall
 ret
 8a8:	8082                	ret

00000000000008aa <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 8aa:	03d00893          	li	a7,61
 ecall
 8ae:	00000073          	ecall
 ret
 8b2:	8082                	ret

00000000000008b4 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 8b4:	03e00893          	li	a7,62
 ecall
 8b8:	00000073          	ecall
 ret
 8bc:	8082                	ret

00000000000008be <clone>:
.global clone
clone:
 li a7, SYS_clone
 8be:	03f00893          	li	a7,63
 ecall
 8c2:	00000073          	ecall
 ret
 8c6:	8082                	ret

00000000000008c8 <futex>:
.global futex
futex:
 li a7, SYS_futex
 8c8:	04000893          	li	a7,64
 ecall
 8cc:	00000073          	ecall
 ret
 8d0:	8082                	ret

00000000000008d2 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 8d2:	04100893          	li	a7,65
 ecall
 8d6:	00000073          	ecall
 ret
 8da:	8082                	ret

00000000000008dc <halt>:
.global halt
halt:
 li a7, SYS_halt
 8dc:	04200893          	li	a7,66
 ecall
 8e0:	00000073          	ecall
 ret
 8e4:	8082                	ret

00000000000008e6 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 8e6:	04300893          	li	a7,67
 ecall
 8ea:	00000073          	ecall
 ret
 8ee:	8082                	ret

00000000000008f0 <socket>:
.global socket
socket:
 li a7, SYS_socket
 8f0:	04400893          	li	a7,68
 ecall
 8f4:	00000073          	ecall
 ret
 8f8:	8082                	ret

00000000000008fa <bind>:
.global bind
bind:
 li a7, SYS_bind
 8fa:	04500893          	li	a7,69
 ecall
 8fe:	00000073          	ecall
 ret
 902:	8082                	ret

0000000000000904 <listen>:
.global listen
listen:
 li a7, SYS_listen
 904:	04600893          	li	a7,70
 ecall
 908:	00000073          	ecall
 ret
 90c:	8082                	ret

000000000000090e <accept>:
.global accept
accept:
 li a7, SYS_accept
 90e:	04700893          	li	a7,71
 ecall
 912:	00000073          	ecall
 ret
 916:	8082                	ret

0000000000000918 <connect>:
.global connect
connect:
 li a7, SYS_connect
 918:	04800893          	li	a7,72
 ecall
 91c:	00000073          	ecall
 ret
 920:	8082                	ret

0000000000000922 <send>:
.global send
send:
 li a7, SYS_send
 922:	04900893          	li	a7,73
 ecall
 926:	00000073          	ecall
 ret
 92a:	8082                	ret

000000000000092c <recv>:
.global recv
recv:
 li a7, SYS_recv
 92c:	04a00893          	li	a7,74
 ecall
 930:	00000073          	ecall
 ret
 934:	8082                	ret

0000000000000936 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 936:	04b00893          	li	a7,75
 ecall
 93a:	00000073          	ecall
 ret
 93e:	8082                	ret

0000000000000940 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 940:	1101                	addi	sp,sp,-32
 942:	ec06                	sd	ra,24(sp)
 944:	e822                	sd	s0,16(sp)
 946:	1000                	addi	s0,sp,32
 948:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 94c:	4605                	li	a2,1
 94e:	fef40593          	addi	a1,s0,-17
 952:	00000097          	auipc	ra,0x0
 956:	d66080e7          	jalr	-666(ra) # 6b8 <write>
}
 95a:	60e2                	ld	ra,24(sp)
 95c:	6442                	ld	s0,16(sp)
 95e:	6105                	addi	sp,sp,32
 960:	8082                	ret

0000000000000962 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 962:	7139                	addi	sp,sp,-64
 964:	fc06                	sd	ra,56(sp)
 966:	f822                	sd	s0,48(sp)
 968:	f426                	sd	s1,40(sp)
 96a:	f04a                	sd	s2,32(sp)
 96c:	ec4e                	sd	s3,24(sp)
 96e:	0080                	addi	s0,sp,64
 970:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 972:	c299                	beqz	a3,978 <printint+0x16>
 974:	0805c863          	bltz	a1,a04 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 978:	2581                	sext.w	a1,a1
  neg = 0;
 97a:	4881                	li	a7,0
  }

  i = 0;
 97c:	fc040993          	addi	s3,s0,-64
  neg = 0;
 980:	86ce                	mv	a3,s3
  i = 0;
 982:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 984:	2601                	sext.w	a2,a2
 986:	00000517          	auipc	a0,0x0
 98a:	7d250513          	addi	a0,a0,2002 # 1158 <digits>
 98e:	883a                	mv	a6,a4
 990:	2705                	addiw	a4,a4,1
 992:	02c5f7bb          	remuw	a5,a1,a2
 996:	1782                	slli	a5,a5,0x20
 998:	9381                	srli	a5,a5,0x20
 99a:	97aa                	add	a5,a5,a0
 99c:	0007c783          	lbu	a5,0(a5)
 9a0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 9a4:	0005879b          	sext.w	a5,a1
 9a8:	02c5d5bb          	divuw	a1,a1,a2
 9ac:	0685                	addi	a3,a3,1
 9ae:	fec7f0e3          	bgeu	a5,a2,98e <printint+0x2c>
  if(neg)
 9b2:	00088c63          	beqz	a7,9ca <printint+0x68>
    buf[i++] = '-';
 9b6:	fd070793          	addi	a5,a4,-48
 9ba:	00878733          	add	a4,a5,s0
 9be:	02d00793          	li	a5,45
 9c2:	fef70823          	sb	a5,-16(a4)
 9c6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 9ca:	02e05663          	blez	a4,9f6 <printint+0x94>
 9ce:	fc040913          	addi	s2,s0,-64
 9d2:	993a                	add	s2,s2,a4
 9d4:	19fd                	addi	s3,s3,-1
 9d6:	99ba                	add	s3,s3,a4
 9d8:	377d                	addiw	a4,a4,-1
 9da:	1702                	slli	a4,a4,0x20
 9dc:	9301                	srli	a4,a4,0x20
 9de:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 9e2:	fff94583          	lbu	a1,-1(s2)
 9e6:	8526                	mv	a0,s1
 9e8:	00000097          	auipc	ra,0x0
 9ec:	f58080e7          	jalr	-168(ra) # 940 <putc>
  while(--i >= 0)
 9f0:	197d                	addi	s2,s2,-1
 9f2:	ff3918e3          	bne	s2,s3,9e2 <printint+0x80>
}
 9f6:	70e2                	ld	ra,56(sp)
 9f8:	7442                	ld	s0,48(sp)
 9fa:	74a2                	ld	s1,40(sp)
 9fc:	7902                	ld	s2,32(sp)
 9fe:	69e2                	ld	s3,24(sp)
 a00:	6121                	addi	sp,sp,64
 a02:	8082                	ret
    x = -xx;
 a04:	40b005bb          	negw	a1,a1
    neg = 1;
 a08:	4885                	li	a7,1
    x = -xx;
 a0a:	bf8d                	j	97c <printint+0x1a>

0000000000000a0c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 a0c:	7119                	addi	sp,sp,-128
 a0e:	fc86                	sd	ra,120(sp)
 a10:	f8a2                	sd	s0,112(sp)
 a12:	f4a6                	sd	s1,104(sp)
 a14:	f0ca                	sd	s2,96(sp)
 a16:	ecce                	sd	s3,88(sp)
 a18:	e8d2                	sd	s4,80(sp)
 a1a:	e4d6                	sd	s5,72(sp)
 a1c:	e0da                	sd	s6,64(sp)
 a1e:	fc5e                	sd	s7,56(sp)
 a20:	f862                	sd	s8,48(sp)
 a22:	f466                	sd	s9,40(sp)
 a24:	f06a                	sd	s10,32(sp)
 a26:	ec6e                	sd	s11,24(sp)
 a28:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 a2a:	0005c903          	lbu	s2,0(a1)
 a2e:	18090f63          	beqz	s2,bcc <vprintf+0x1c0>
 a32:	8aaa                	mv	s5,a0
 a34:	8b32                	mv	s6,a2
 a36:	00158493          	addi	s1,a1,1
  state = 0;
 a3a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 a3c:	02500a13          	li	s4,37
 a40:	4c55                	li	s8,21
 a42:	00000c97          	auipc	s9,0x0
 a46:	6bec8c93          	addi	s9,s9,1726 # 1100 <malloc+0x430>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a4a:	02800d93          	li	s11,40
  putc(fd, 'x');
 a4e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a50:	00000b97          	auipc	s7,0x0
 a54:	708b8b93          	addi	s7,s7,1800 # 1158 <digits>
 a58:	a839                	j	a76 <vprintf+0x6a>
        putc(fd, c);
 a5a:	85ca                	mv	a1,s2
 a5c:	8556                	mv	a0,s5
 a5e:	00000097          	auipc	ra,0x0
 a62:	ee2080e7          	jalr	-286(ra) # 940 <putc>
 a66:	a019                	j	a6c <vprintf+0x60>
    } else if(state == '%'){
 a68:	01498d63          	beq	s3,s4,a82 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 a6c:	0485                	addi	s1,s1,1
 a6e:	fff4c903          	lbu	s2,-1(s1)
 a72:	14090d63          	beqz	s2,bcc <vprintf+0x1c0>
    if(state == 0){
 a76:	fe0999e3          	bnez	s3,a68 <vprintf+0x5c>
      if(c == '%'){
 a7a:	ff4910e3          	bne	s2,s4,a5a <vprintf+0x4e>
        state = '%';
 a7e:	89d2                	mv	s3,s4
 a80:	b7f5                	j	a6c <vprintf+0x60>
      if(c == 'd'){
 a82:	11490c63          	beq	s2,s4,b9a <vprintf+0x18e>
 a86:	f9d9079b          	addiw	a5,s2,-99
 a8a:	0ff7f793          	zext.b	a5,a5
 a8e:	10fc6e63          	bltu	s8,a5,baa <vprintf+0x19e>
 a92:	f9d9079b          	addiw	a5,s2,-99
 a96:	0ff7f713          	zext.b	a4,a5
 a9a:	10ec6863          	bltu	s8,a4,baa <vprintf+0x19e>
 a9e:	00271793          	slli	a5,a4,0x2
 aa2:	97e6                	add	a5,a5,s9
 aa4:	439c                	lw	a5,0(a5)
 aa6:	97e6                	add	a5,a5,s9
 aa8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 aaa:	008b0913          	addi	s2,s6,8
 aae:	4685                	li	a3,1
 ab0:	4629                	li	a2,10
 ab2:	000b2583          	lw	a1,0(s6)
 ab6:	8556                	mv	a0,s5
 ab8:	00000097          	auipc	ra,0x0
 abc:	eaa080e7          	jalr	-342(ra) # 962 <printint>
 ac0:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 ac2:	4981                	li	s3,0
 ac4:	b765                	j	a6c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 ac6:	008b0913          	addi	s2,s6,8
 aca:	4681                	li	a3,0
 acc:	4629                	li	a2,10
 ace:	000b2583          	lw	a1,0(s6)
 ad2:	8556                	mv	a0,s5
 ad4:	00000097          	auipc	ra,0x0
 ad8:	e8e080e7          	jalr	-370(ra) # 962 <printint>
 adc:	8b4a                	mv	s6,s2
      state = 0;
 ade:	4981                	li	s3,0
 ae0:	b771                	j	a6c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 ae2:	008b0913          	addi	s2,s6,8
 ae6:	4681                	li	a3,0
 ae8:	866a                	mv	a2,s10
 aea:	000b2583          	lw	a1,0(s6)
 aee:	8556                	mv	a0,s5
 af0:	00000097          	auipc	ra,0x0
 af4:	e72080e7          	jalr	-398(ra) # 962 <printint>
 af8:	8b4a                	mv	s6,s2
      state = 0;
 afa:	4981                	li	s3,0
 afc:	bf85                	j	a6c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 afe:	008b0793          	addi	a5,s6,8
 b02:	f8f43423          	sd	a5,-120(s0)
 b06:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 b0a:	03000593          	li	a1,48
 b0e:	8556                	mv	a0,s5
 b10:	00000097          	auipc	ra,0x0
 b14:	e30080e7          	jalr	-464(ra) # 940 <putc>
  putc(fd, 'x');
 b18:	07800593          	li	a1,120
 b1c:	8556                	mv	a0,s5
 b1e:	00000097          	auipc	ra,0x0
 b22:	e22080e7          	jalr	-478(ra) # 940 <putc>
 b26:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b28:	03c9d793          	srli	a5,s3,0x3c
 b2c:	97de                	add	a5,a5,s7
 b2e:	0007c583          	lbu	a1,0(a5)
 b32:	8556                	mv	a0,s5
 b34:	00000097          	auipc	ra,0x0
 b38:	e0c080e7          	jalr	-500(ra) # 940 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b3c:	0992                	slli	s3,s3,0x4
 b3e:	397d                	addiw	s2,s2,-1
 b40:	fe0914e3          	bnez	s2,b28 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 b44:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 b48:	4981                	li	s3,0
 b4a:	b70d                	j	a6c <vprintf+0x60>
        s = va_arg(ap, char*);
 b4c:	008b0913          	addi	s2,s6,8
 b50:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 b54:	02098163          	beqz	s3,b76 <vprintf+0x16a>
        while(*s != 0){
 b58:	0009c583          	lbu	a1,0(s3)
 b5c:	c5ad                	beqz	a1,bc6 <vprintf+0x1ba>
          putc(fd, *s);
 b5e:	8556                	mv	a0,s5
 b60:	00000097          	auipc	ra,0x0
 b64:	de0080e7          	jalr	-544(ra) # 940 <putc>
          s++;
 b68:	0985                	addi	s3,s3,1
        while(*s != 0){
 b6a:	0009c583          	lbu	a1,0(s3)
 b6e:	f9e5                	bnez	a1,b5e <vprintf+0x152>
        s = va_arg(ap, char*);
 b70:	8b4a                	mv	s6,s2
      state = 0;
 b72:	4981                	li	s3,0
 b74:	bde5                	j	a6c <vprintf+0x60>
          s = "(null)";
 b76:	00000997          	auipc	s3,0x0
 b7a:	58298993          	addi	s3,s3,1410 # 10f8 <malloc+0x428>
        while(*s != 0){
 b7e:	85ee                	mv	a1,s11
 b80:	bff9                	j	b5e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 b82:	008b0913          	addi	s2,s6,8
 b86:	000b4583          	lbu	a1,0(s6)
 b8a:	8556                	mv	a0,s5
 b8c:	00000097          	auipc	ra,0x0
 b90:	db4080e7          	jalr	-588(ra) # 940 <putc>
 b94:	8b4a                	mv	s6,s2
      state = 0;
 b96:	4981                	li	s3,0
 b98:	bdd1                	j	a6c <vprintf+0x60>
        putc(fd, c);
 b9a:	85d2                	mv	a1,s4
 b9c:	8556                	mv	a0,s5
 b9e:	00000097          	auipc	ra,0x0
 ba2:	da2080e7          	jalr	-606(ra) # 940 <putc>
      state = 0;
 ba6:	4981                	li	s3,0
 ba8:	b5d1                	j	a6c <vprintf+0x60>
        putc(fd, '%');
 baa:	85d2                	mv	a1,s4
 bac:	8556                	mv	a0,s5
 bae:	00000097          	auipc	ra,0x0
 bb2:	d92080e7          	jalr	-622(ra) # 940 <putc>
        putc(fd, c);
 bb6:	85ca                	mv	a1,s2
 bb8:	8556                	mv	a0,s5
 bba:	00000097          	auipc	ra,0x0
 bbe:	d86080e7          	jalr	-634(ra) # 940 <putc>
      state = 0;
 bc2:	4981                	li	s3,0
 bc4:	b565                	j	a6c <vprintf+0x60>
        s = va_arg(ap, char*);
 bc6:	8b4a                	mv	s6,s2
      state = 0;
 bc8:	4981                	li	s3,0
 bca:	b54d                	j	a6c <vprintf+0x60>
    }
  }
}
 bcc:	70e6                	ld	ra,120(sp)
 bce:	7446                	ld	s0,112(sp)
 bd0:	74a6                	ld	s1,104(sp)
 bd2:	7906                	ld	s2,96(sp)
 bd4:	69e6                	ld	s3,88(sp)
 bd6:	6a46                	ld	s4,80(sp)
 bd8:	6aa6                	ld	s5,72(sp)
 bda:	6b06                	ld	s6,64(sp)
 bdc:	7be2                	ld	s7,56(sp)
 bde:	7c42                	ld	s8,48(sp)
 be0:	7ca2                	ld	s9,40(sp)
 be2:	7d02                	ld	s10,32(sp)
 be4:	6de2                	ld	s11,24(sp)
 be6:	6109                	addi	sp,sp,128
 be8:	8082                	ret

0000000000000bea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 bea:	715d                	addi	sp,sp,-80
 bec:	ec06                	sd	ra,24(sp)
 bee:	e822                	sd	s0,16(sp)
 bf0:	1000                	addi	s0,sp,32
 bf2:	e010                	sd	a2,0(s0)
 bf4:	e414                	sd	a3,8(s0)
 bf6:	e818                	sd	a4,16(s0)
 bf8:	ec1c                	sd	a5,24(s0)
 bfa:	03043023          	sd	a6,32(s0)
 bfe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c02:	8622                	mv	a2,s0
 c04:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c08:	00000097          	auipc	ra,0x0
 c0c:	e04080e7          	jalr	-508(ra) # a0c <vprintf>
}
 c10:	60e2                	ld	ra,24(sp)
 c12:	6442                	ld	s0,16(sp)
 c14:	6161                	addi	sp,sp,80
 c16:	8082                	ret

0000000000000c18 <printf>:

void
printf(const char *fmt, ...)
{
 c18:	711d                	addi	sp,sp,-96
 c1a:	ec06                	sd	ra,24(sp)
 c1c:	e822                	sd	s0,16(sp)
 c1e:	1000                	addi	s0,sp,32
 c20:	e40c                	sd	a1,8(s0)
 c22:	e810                	sd	a2,16(s0)
 c24:	ec14                	sd	a3,24(s0)
 c26:	f018                	sd	a4,32(s0)
 c28:	f41c                	sd	a5,40(s0)
 c2a:	03043823          	sd	a6,48(s0)
 c2e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c32:	00840613          	addi	a2,s0,8
 c36:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c3a:	85aa                	mv	a1,a0
 c3c:	4505                	li	a0,1
 c3e:	00000097          	auipc	ra,0x0
 c42:	dce080e7          	jalr	-562(ra) # a0c <vprintf>
}
 c46:	60e2                	ld	ra,24(sp)
 c48:	6442                	ld	s0,16(sp)
 c4a:	6125                	addi	sp,sp,96
 c4c:	8082                	ret

0000000000000c4e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c4e:	1141                	addi	sp,sp,-16
 c50:	e422                	sd	s0,8(sp)
 c52:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c54:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c58:	00000797          	auipc	a5,0x0
 c5c:	5187b783          	ld	a5,1304(a5) # 1170 <freep>
 c60:	a02d                	j	c8a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c62:	4618                	lw	a4,8(a2)
 c64:	9f2d                	addw	a4,a4,a1
 c66:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c6a:	6398                	ld	a4,0(a5)
 c6c:	6310                	ld	a2,0(a4)
 c6e:	a83d                	j	cac <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c70:	ff852703          	lw	a4,-8(a0)
 c74:	9f31                	addw	a4,a4,a2
 c76:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c78:	ff053683          	ld	a3,-16(a0)
 c7c:	a091                	j	cc0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c7e:	6398                	ld	a4,0(a5)
 c80:	00e7e463          	bltu	a5,a4,c88 <free+0x3a>
 c84:	00e6ea63          	bltu	a3,a4,c98 <free+0x4a>
{
 c88:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c8a:	fed7fae3          	bgeu	a5,a3,c7e <free+0x30>
 c8e:	6398                	ld	a4,0(a5)
 c90:	00e6e463          	bltu	a3,a4,c98 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c94:	fee7eae3          	bltu	a5,a4,c88 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c98:	ff852583          	lw	a1,-8(a0)
 c9c:	6390                	ld	a2,0(a5)
 c9e:	02059813          	slli	a6,a1,0x20
 ca2:	01c85713          	srli	a4,a6,0x1c
 ca6:	9736                	add	a4,a4,a3
 ca8:	fae60de3          	beq	a2,a4,c62 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 cac:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 cb0:	4790                	lw	a2,8(a5)
 cb2:	02061593          	slli	a1,a2,0x20
 cb6:	01c5d713          	srli	a4,a1,0x1c
 cba:	973e                	add	a4,a4,a5
 cbc:	fae68ae3          	beq	a3,a4,c70 <free+0x22>
    p->s.ptr = bp->s.ptr;
 cc0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 cc2:	00000717          	auipc	a4,0x0
 cc6:	4af73723          	sd	a5,1198(a4) # 1170 <freep>
}
 cca:	6422                	ld	s0,8(sp)
 ccc:	0141                	addi	sp,sp,16
 cce:	8082                	ret

0000000000000cd0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 cd0:	7139                	addi	sp,sp,-64
 cd2:	fc06                	sd	ra,56(sp)
 cd4:	f822                	sd	s0,48(sp)
 cd6:	f426                	sd	s1,40(sp)
 cd8:	f04a                	sd	s2,32(sp)
 cda:	ec4e                	sd	s3,24(sp)
 cdc:	e852                	sd	s4,16(sp)
 cde:	e456                	sd	s5,8(sp)
 ce0:	e05a                	sd	s6,0(sp)
 ce2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ce4:	02051493          	slli	s1,a0,0x20
 ce8:	9081                	srli	s1,s1,0x20
 cea:	04bd                	addi	s1,s1,15
 cec:	8091                	srli	s1,s1,0x4
 cee:	00148a1b          	addiw	s4,s1,1
 cf2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 cf4:	00000517          	auipc	a0,0x0
 cf8:	47c53503          	ld	a0,1148(a0) # 1170 <freep>
 cfc:	c515                	beqz	a0,d28 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cfe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d00:	4798                	lw	a4,8(a5)
 d02:	04977163          	bgeu	a4,s1,d44 <malloc+0x74>
 d06:	89d2                	mv	s3,s4
 d08:	000a071b          	sext.w	a4,s4
 d0c:	6685                	lui	a3,0x1
 d0e:	00d77363          	bgeu	a4,a3,d14 <malloc+0x44>
 d12:	6985                	lui	s3,0x1
 d14:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 d18:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d1c:	00000917          	auipc	s2,0x0
 d20:	45490913          	addi	s2,s2,1108 # 1170 <freep>
  if(p == (char*)-1)
 d24:	5afd                	li	s5,-1
 d26:	a8a5                	j	d9e <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 d28:	00000797          	auipc	a5,0x0
 d2c:	44878793          	addi	a5,a5,1096 # 1170 <freep>
 d30:	00000717          	auipc	a4,0x0
 d34:	44870713          	addi	a4,a4,1096 # 1178 <base>
 d38:	e398                	sd	a4,0(a5)
 d3a:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 d3c:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d40:	87ba                	mv	a5,a4
 d42:	b7d1                	j	d06 <malloc+0x36>
      if(p->s.size == nunits)
 d44:	02e48c63          	beq	s1,a4,d7c <malloc+0xac>
        p->s.size -= nunits;
 d48:	4147073b          	subw	a4,a4,s4
 d4c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d4e:	02071693          	slli	a3,a4,0x20
 d52:	01c6d713          	srli	a4,a3,0x1c
 d56:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d58:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 d5c:	00000717          	auipc	a4,0x0
 d60:	40a73a23          	sd	a0,1044(a4) # 1170 <freep>
      return (void*)(p + 1);
 d64:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 d68:	70e2                	ld	ra,56(sp)
 d6a:	7442                	ld	s0,48(sp)
 d6c:	74a2                	ld	s1,40(sp)
 d6e:	7902                	ld	s2,32(sp)
 d70:	69e2                	ld	s3,24(sp)
 d72:	6a42                	ld	s4,16(sp)
 d74:	6aa2                	ld	s5,8(sp)
 d76:	6b02                	ld	s6,0(sp)
 d78:	6121                	addi	sp,sp,64
 d7a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 d7c:	6398                	ld	a4,0(a5)
 d7e:	e118                	sd	a4,0(a0)
 d80:	bff1                	j	d5c <malloc+0x8c>
  hp->s.size = nu;
 d82:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d86:	0541                	addi	a0,a0,16
 d88:	00000097          	auipc	ra,0x0
 d8c:	ec6080e7          	jalr	-314(ra) # c4e <free>
  return freep;
 d90:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d94:	d971                	beqz	a0,d68 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d96:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d98:	4798                	lw	a4,8(a5)
 d9a:	fa9775e3          	bgeu	a4,s1,d44 <malloc+0x74>
    if(p == freep)
 d9e:	00093703          	ld	a4,0(s2)
 da2:	853e                	mv	a0,a5
 da4:	fef719e3          	bne	a4,a5,d96 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 da8:	854e                	mv	a0,s3
 daa:	00000097          	auipc	ra,0x0
 dae:	95e080e7          	jalr	-1698(ra) # 708 <sbrk>
  if(p == (char*)-1)
 db2:	fd5518e3          	bne	a0,s5,d82 <malloc+0xb2>
        return 0;
 db6:	4501                	li	a0,0
 db8:	bf45                	j	d68 <malloc+0x98>
