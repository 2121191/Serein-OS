
serein-user/_inettest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <server_process>:
#include "kernel/include/types.h"
#include "serein-user/user.h"

#define PORT 8080

void server_process(void) {
   0:	7135                	addi	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	e14a                	sd	s2,128(sp)
   a:	fcce                	sd	s3,120(sp)
   c:	f8d2                	sd	s4,112(sp)
   e:	1100                	addi	s0,sp,160
  struct sockaddr_in client_addr;
  int addrlen;
  char buf[64];
  int n;
  
  printf("[SERVER] Creating socket...\n");
  10:	00001517          	auipc	a0,0x1
  14:	d7850513          	addi	a0,a0,-648 # d88 <malloc+0xee>
  18:	00001097          	auipc	ra,0x1
  1c:	bca080e7          	jalr	-1078(ra) # be2 <printf>
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  20:	4601                	li	a2,0
  22:	4585                	li	a1,1
  24:	4509                	li	a0,2
  26:	00001097          	auipc	ra,0x1
  2a:	894080e7          	jalr	-1900(ra) # 8ba <socket>
  if(sockfd < 0){
  2e:	10054763          	bltz	a0,13c <server_process+0x13c>
  32:	84aa                	mv	s1,a0
    printf("[SERVER] socket() failed\n");
    exit(1);
  }
  printf("[SERVER] Socket created (fd=%d)\n", sockfd);
  34:	85aa                	mv	a1,a0
  36:	00001517          	auipc	a0,0x1
  3a:	d9250513          	addi	a0,a0,-622 # dc8 <malloc+0x12e>
  3e:	00001097          	auipc	ra,0x1
  42:	ba4080e7          	jalr	-1116(ra) # be2 <printf>
  
  // Bind to 127.0.0.1:8080
  addr.family = AF_INET;
  46:	4789                	li	a5,2
  48:	fcf41023          	sh	a5,-64(s0)
  addr.addr = 0x7f000001;  // 127.0.0.1
  4c:	7f0007b7          	lui	a5,0x7f000
  50:	0785                	addi	a5,a5,1 # 7f000001 <__global_pointer$+0x7effe700>
  52:	fcf42223          	sw	a5,-60(s0)
  addr.port = PORT;
  56:	6589                	lui	a1,0x2
  58:	f9058593          	addi	a1,a1,-112 # 1f90 <__global_pointer$+0x68f>
  5c:	fcb41123          	sh	a1,-62(s0)
  
  printf("[SERVER] Binding to 127.0.0.1:%d...\n", PORT);
  60:	00001517          	auipc	a0,0x1
  64:	d9050513          	addi	a0,a0,-624 # df0 <malloc+0x156>
  68:	00001097          	auipc	ra,0x1
  6c:	b7a080e7          	jalr	-1158(ra) # be2 <printf>
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
  70:	4641                	li	a2,16
  72:	fc040593          	addi	a1,s0,-64
  76:	8526                	mv	a0,s1
  78:	00001097          	auipc	ra,0x1
  7c:	84c080e7          	jalr	-1972(ra) # 8c4 <bind>
  80:	0c054b63          	bltz	a0,156 <server_process+0x156>
    printf("[SERVER] bind() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("[SERVER] Bound successfully\n");
  84:	00001517          	auipc	a0,0x1
  88:	dac50513          	addi	a0,a0,-596 # e30 <malloc+0x196>
  8c:	00001097          	auipc	ra,0x1
  90:	b56080e7          	jalr	-1194(ra) # be2 <printf>
  
  // Listen
  printf("[SERVER] Listening...\n");
  94:	00001517          	auipc	a0,0x1
  98:	dbc50513          	addi	a0,a0,-580 # e50 <malloc+0x1b6>
  9c:	00001097          	auipc	ra,0x1
  a0:	b46080e7          	jalr	-1210(ra) # be2 <printf>
  if(listen(sockfd, 5) < 0){
  a4:	4595                	li	a1,5
  a6:	8526                	mv	a0,s1
  a8:	00001097          	auipc	ra,0x1
  ac:	826080e7          	jalr	-2010(ra) # 8ce <listen>
  b0:	0c054563          	bltz	a0,17a <server_process+0x17a>
    close(sockfd);
    exit(1);
  }
  
  // Accept
  printf("[SERVER] Waiting for connection...\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	dd450513          	addi	a0,a0,-556 # e88 <malloc+0x1ee>
  bc:	00001097          	auipc	ra,0x1
  c0:	b26080e7          	jalr	-1242(ra) # be2 <printf>
  addrlen = sizeof(client_addr);
  c4:	47c1                	li	a5,16
  c6:	faf42623          	sw	a5,-84(s0)
  clientfd = accept(sockfd, (struct sockaddr*)&client_addr, &addrlen);
  ca:	fac40613          	addi	a2,s0,-84
  ce:	fb040593          	addi	a1,s0,-80
  d2:	8526                	mv	a0,s1
  d4:	00001097          	auipc	ra,0x1
  d8:	804080e7          	jalr	-2044(ra) # 8d8 <accept>
  dc:	892a                	mv	s2,a0
  if(clientfd < 0){
  de:	0c054063          	bltz	a0,19e <server_process+0x19e>
    printf("[SERVER] accept() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("[SERVER] Client connected (fd=%d)\n", clientfd);
  e2:	85aa                	mv	a1,a0
  e4:	00001517          	auipc	a0,0x1
  e8:	dec50513          	addi	a0,a0,-532 # ed0 <malloc+0x236>
  ec:	00001097          	auipc	ra,0x1
  f0:	af6080e7          	jalr	-1290(ra) # be2 <printf>
  
  // Receive
  n = recv(clientfd, buf, sizeof(buf), 0);
  f4:	4681                	li	a3,0
  f6:	04000613          	li	a2,64
  fa:	f6840593          	addi	a1,s0,-152
  fe:	854a                	mv	a0,s2
 100:	00000097          	auipc	ra,0x0
 104:	7f6080e7          	jalr	2038(ra) # 8f6 <recv>
 108:	89aa                	mv	s3,a0
  if(n > 0){
 10a:	0aa04c63          	bgtz	a0,1c2 <server_process+0x1c2>
    // Echo back
    send(clientfd, buf, n, 0);
    printf("[SERVER] Echoed message back\n");
  }
  
  close(clientfd);
 10e:	854a                	mv	a0,s2
 110:	00000097          	auipc	ra,0x0
 114:	57a080e7          	jalr	1402(ra) # 68a <close>
  close(sockfd);
 118:	8526                	mv	a0,s1
 11a:	00000097          	auipc	ra,0x0
 11e:	570080e7          	jalr	1392(ra) # 68a <close>
  printf("[SERVER] Done\n");
 122:	00001517          	auipc	a0,0x1
 126:	e0e50513          	addi	a0,a0,-498 # f30 <malloc+0x296>
 12a:	00001097          	auipc	ra,0x1
 12e:	ab8080e7          	jalr	-1352(ra) # be2 <printf>
  exit(0);
 132:	4501                	li	a0,0
 134:	00000097          	auipc	ra,0x0
 138:	52e080e7          	jalr	1326(ra) # 662 <exit>
    printf("[SERVER] socket() failed\n");
 13c:	00001517          	auipc	a0,0x1
 140:	c6c50513          	addi	a0,a0,-916 # da8 <malloc+0x10e>
 144:	00001097          	auipc	ra,0x1
 148:	a9e080e7          	jalr	-1378(ra) # be2 <printf>
    exit(1);
 14c:	4505                	li	a0,1
 14e:	00000097          	auipc	ra,0x0
 152:	514080e7          	jalr	1300(ra) # 662 <exit>
    printf("[SERVER] bind() failed\n");
 156:	00001517          	auipc	a0,0x1
 15a:	cc250513          	addi	a0,a0,-830 # e18 <malloc+0x17e>
 15e:	00001097          	auipc	ra,0x1
 162:	a84080e7          	jalr	-1404(ra) # be2 <printf>
    close(sockfd);
 166:	8526                	mv	a0,s1
 168:	00000097          	auipc	ra,0x0
 16c:	522080e7          	jalr	1314(ra) # 68a <close>
    exit(1);
 170:	4505                	li	a0,1
 172:	00000097          	auipc	ra,0x0
 176:	4f0080e7          	jalr	1264(ra) # 662 <exit>
    printf("[SERVER] listen() failed\n");
 17a:	00001517          	auipc	a0,0x1
 17e:	cee50513          	addi	a0,a0,-786 # e68 <malloc+0x1ce>
 182:	00001097          	auipc	ra,0x1
 186:	a60080e7          	jalr	-1440(ra) # be2 <printf>
    close(sockfd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	4fe080e7          	jalr	1278(ra) # 68a <close>
    exit(1);
 194:	4505                	li	a0,1
 196:	00000097          	auipc	ra,0x0
 19a:	4cc080e7          	jalr	1228(ra) # 662 <exit>
    printf("[SERVER] accept() failed\n");
 19e:	00001517          	auipc	a0,0x1
 1a2:	d1250513          	addi	a0,a0,-750 # eb0 <malloc+0x216>
 1a6:	00001097          	auipc	ra,0x1
 1aa:	a3c080e7          	jalr	-1476(ra) # be2 <printf>
    close(sockfd);
 1ae:	8526                	mv	a0,s1
 1b0:	00000097          	auipc	ra,0x0
 1b4:	4da080e7          	jalr	1242(ra) # 68a <close>
    exit(1);
 1b8:	4505                	li	a0,1
 1ba:	00000097          	auipc	ra,0x0
 1be:	4a8080e7          	jalr	1192(ra) # 662 <exit>
    buf[n] = 0;
 1c2:	fd050793          	addi	a5,a0,-48
 1c6:	97a2                	add	a5,a5,s0
 1c8:	f8078c23          	sb	zero,-104(a5)
    printf("[SERVER] Received: %s\n", buf);
 1cc:	f6840a13          	addi	s4,s0,-152
 1d0:	85d2                	mv	a1,s4
 1d2:	00001517          	auipc	a0,0x1
 1d6:	d2650513          	addi	a0,a0,-730 # ef8 <malloc+0x25e>
 1da:	00001097          	auipc	ra,0x1
 1de:	a08080e7          	jalr	-1528(ra) # be2 <printf>
    send(clientfd, buf, n, 0);
 1e2:	4681                	li	a3,0
 1e4:	864e                	mv	a2,s3
 1e6:	85d2                	mv	a1,s4
 1e8:	854a                	mv	a0,s2
 1ea:	00000097          	auipc	ra,0x0
 1ee:	702080e7          	jalr	1794(ra) # 8ec <send>
    printf("[SERVER] Echoed message back\n");
 1f2:	00001517          	auipc	a0,0x1
 1f6:	d1e50513          	addi	a0,a0,-738 # f10 <malloc+0x276>
 1fa:	00001097          	auipc	ra,0x1
 1fe:	9e8080e7          	jalr	-1560(ra) # be2 <printf>
 202:	b731                	j	10e <server_process+0x10e>

0000000000000204 <client_process>:
}

void client_process(void) {
 204:	7159                	addi	sp,sp,-112
 206:	f486                	sd	ra,104(sp)
 208:	f0a2                	sd	s0,96(sp)
 20a:	eca6                	sd	s1,88(sp)
 20c:	1880                	addi	s0,sp,112
  char *msg = "Hello via loopback!";
  char buf[64];
  int n;
  
  // Wait for server to start
  sleep(10);
 20e:	4529                	li	a0,10
 210:	00000097          	auipc	ra,0x0
 214:	4ca080e7          	jalr	1226(ra) # 6da <sleep>
  
  printf("[CLIENT] Creating socket...\n");
 218:	00001517          	auipc	a0,0x1
 21c:	d2850513          	addi	a0,a0,-728 # f40 <malloc+0x2a6>
 220:	00001097          	auipc	ra,0x1
 224:	9c2080e7          	jalr	-1598(ra) # be2 <printf>
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
 228:	4601                	li	a2,0
 22a:	4585                	li	a1,1
 22c:	4509                	li	a0,2
 22e:	00000097          	auipc	ra,0x0
 232:	68c080e7          	jalr	1676(ra) # 8ba <socket>
  if(sockfd < 0){
 236:	0e054163          	bltz	a0,318 <client_process+0x114>
 23a:	84aa                	mv	s1,a0
    printf("[CLIENT] socket() failed\n");
    exit(1);
  }
  printf("[CLIENT] Socket created (fd=%d)\n", sockfd);
 23c:	85aa                	mv	a1,a0
 23e:	00001517          	auipc	a0,0x1
 242:	d4250513          	addi	a0,a0,-702 # f80 <malloc+0x2e6>
 246:	00001097          	auipc	ra,0x1
 24a:	99c080e7          	jalr	-1636(ra) # be2 <printf>
  
  // Connect to 127.0.0.1:8080
  addr.family = AF_INET;
 24e:	4789                	li	a5,2
 250:	fcf41823          	sh	a5,-48(s0)
  addr.addr = 0x7f000001;  // 127.0.0.1
 254:	7f0007b7          	lui	a5,0x7f000
 258:	0785                	addi	a5,a5,1 # 7f000001 <__global_pointer$+0x7effe700>
 25a:	fcf42a23          	sw	a5,-44(s0)
  addr.port = PORT;
 25e:	6589                	lui	a1,0x2
 260:	f9058593          	addi	a1,a1,-112 # 1f90 <__global_pointer$+0x68f>
 264:	fcb41923          	sh	a1,-46(s0)
  
  printf("[CLIENT] Connecting to 127.0.0.1:%d...\n", PORT);
 268:	00001517          	auipc	a0,0x1
 26c:	d4050513          	addi	a0,a0,-704 # fa8 <malloc+0x30e>
 270:	00001097          	auipc	ra,0x1
 274:	972080e7          	jalr	-1678(ra) # be2 <printf>
  if(connect(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
 278:	4641                	li	a2,16
 27a:	fd040593          	addi	a1,s0,-48
 27e:	8526                	mv	a0,s1
 280:	00000097          	auipc	ra,0x0
 284:	662080e7          	jalr	1634(ra) # 8e2 <connect>
 288:	0a054563          	bltz	a0,332 <client_process+0x12e>
    printf("[CLIENT] connect() failed\n");
    close(sockfd);
    exit(1);
  }
  printf("[CLIENT] Connected!\n");
 28c:	00001517          	auipc	a0,0x1
 290:	d6450513          	addi	a0,a0,-668 # ff0 <malloc+0x356>
 294:	00001097          	auipc	ra,0x1
 298:	94e080e7          	jalr	-1714(ra) # be2 <printf>
  
  // Send
  printf("[CLIENT] Sending: %s\n", msg);
 29c:	00001597          	auipc	a1,0x1
 2a0:	d6c58593          	addi	a1,a1,-660 # 1008 <malloc+0x36e>
 2a4:	00001517          	auipc	a0,0x1
 2a8:	d7c50513          	addi	a0,a0,-644 # 1020 <malloc+0x386>
 2ac:	00001097          	auipc	ra,0x1
 2b0:	936080e7          	jalr	-1738(ra) # be2 <printf>
  send(sockfd, msg, strlen(msg), 0);
 2b4:	00001517          	auipc	a0,0x1
 2b8:	d5450513          	addi	a0,a0,-684 # 1008 <malloc+0x36e>
 2bc:	00000097          	auipc	ra,0x0
 2c0:	164080e7          	jalr	356(ra) # 420 <strlen>
 2c4:	4681                	li	a3,0
 2c6:	0005061b          	sext.w	a2,a0
 2ca:	00001597          	auipc	a1,0x1
 2ce:	d3e58593          	addi	a1,a1,-706 # 1008 <malloc+0x36e>
 2d2:	8526                	mv	a0,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	618080e7          	jalr	1560(ra) # 8ec <send>
  
  // Receive echo
  n = recv(sockfd, buf, sizeof(buf), 0);
 2dc:	4681                	li	a3,0
 2de:	04000613          	li	a2,64
 2e2:	f9040593          	addi	a1,s0,-112
 2e6:	8526                	mv	a0,s1
 2e8:	00000097          	auipc	ra,0x0
 2ec:	60e080e7          	jalr	1550(ra) # 8f6 <recv>
  if(n > 0){
 2f0:	06a04363          	bgtz	a0,356 <client_process+0x152>
    buf[n] = 0;
    printf("[CLIENT] Received echo: %s\n", buf);
  }
  
  close(sockfd);
 2f4:	8526                	mv	a0,s1
 2f6:	00000097          	auipc	ra,0x0
 2fa:	394080e7          	jalr	916(ra) # 68a <close>
  printf("[CLIENT] Done\n");
 2fe:	00001517          	auipc	a0,0x1
 302:	d5a50513          	addi	a0,a0,-678 # 1058 <malloc+0x3be>
 306:	00001097          	auipc	ra,0x1
 30a:	8dc080e7          	jalr	-1828(ra) # be2 <printf>
  exit(0);
 30e:	4501                	li	a0,0
 310:	00000097          	auipc	ra,0x0
 314:	352080e7          	jalr	850(ra) # 662 <exit>
    printf("[CLIENT] socket() failed\n");
 318:	00001517          	auipc	a0,0x1
 31c:	c4850513          	addi	a0,a0,-952 # f60 <malloc+0x2c6>
 320:	00001097          	auipc	ra,0x1
 324:	8c2080e7          	jalr	-1854(ra) # be2 <printf>
    exit(1);
 328:	4505                	li	a0,1
 32a:	00000097          	auipc	ra,0x0
 32e:	338080e7          	jalr	824(ra) # 662 <exit>
    printf("[CLIENT] connect() failed\n");
 332:	00001517          	auipc	a0,0x1
 336:	c9e50513          	addi	a0,a0,-866 # fd0 <malloc+0x336>
 33a:	00001097          	auipc	ra,0x1
 33e:	8a8080e7          	jalr	-1880(ra) # be2 <printf>
    close(sockfd);
 342:	8526                	mv	a0,s1
 344:	00000097          	auipc	ra,0x0
 348:	346080e7          	jalr	838(ra) # 68a <close>
    exit(1);
 34c:	4505                	li	a0,1
 34e:	00000097          	auipc	ra,0x0
 352:	314080e7          	jalr	788(ra) # 662 <exit>
    buf[n] = 0;
 356:	fe050793          	addi	a5,a0,-32
 35a:	00878533          	add	a0,a5,s0
 35e:	fa050823          	sb	zero,-80(a0)
    printf("[CLIENT] Received echo: %s\n", buf);
 362:	f9040593          	addi	a1,s0,-112
 366:	00001517          	auipc	a0,0x1
 36a:	cd250513          	addi	a0,a0,-814 # 1038 <malloc+0x39e>
 36e:	00001097          	auipc	ra,0x1
 372:	874080e7          	jalr	-1932(ra) # be2 <printf>
 376:	bfbd                	j	2f4 <client_process+0xf0>

0000000000000378 <main>:
}

int main(int argc, char *argv[]) {
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  printf("=== IPv4 Loopback Socket Test ===\n\n");
 380:	00001517          	auipc	a0,0x1
 384:	ce850513          	addi	a0,a0,-792 # 1068 <malloc+0x3ce>
 388:	00001097          	auipc	ra,0x1
 38c:	85a080e7          	jalr	-1958(ra) # be2 <printf>
  
  int pid = fork();
 390:	00000097          	auipc	ra,0x0
 394:	2ca080e7          	jalr	714(ra) # 65a <fork>
  if(pid == 0){
 398:	e509                	bnez	a0,3a2 <main+0x2a>
    // Child: server
    server_process();
 39a:	00000097          	auipc	ra,0x0
 39e:	c66080e7          	jalr	-922(ra) # 0 <server_process>
  } else {
    // Parent: client
    client_process();
 3a2:	00000097          	auipc	ra,0x0
 3a6:	e62080e7          	jalr	-414(ra) # 204 <client_process>

00000000000003aa <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 3aa:	1141                	addi	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3b0:	87aa                	mv	a5,a0
 3b2:	0585                	addi	a1,a1,1
 3b4:	0785                	addi	a5,a5,1
 3b6:	fff5c703          	lbu	a4,-1(a1)
 3ba:	fee78fa3          	sb	a4,-1(a5)
 3be:	fb75                	bnez	a4,3b2 <strcpy+0x8>
    ;
  return os;
}
 3c0:	6422                	ld	s0,8(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <strcat>:

char*
strcat(char *s, const char *t)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e422                	sd	s0,8(sp)
 3ca:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 3cc:	00054783          	lbu	a5,0(a0)
 3d0:	c385                	beqz	a5,3f0 <strcat+0x2a>
 3d2:	87aa                	mv	a5,a0
    s++;
 3d4:	0785                	addi	a5,a5,1
  while(*s)
 3d6:	0007c703          	lbu	a4,0(a5)
 3da:	ff6d                	bnez	a4,3d4 <strcat+0xe>
  while((*s++ = *t++))
 3dc:	0585                	addi	a1,a1,1
 3de:	0785                	addi	a5,a5,1
 3e0:	fff5c703          	lbu	a4,-1(a1)
 3e4:	fee78fa3          	sb	a4,-1(a5)
 3e8:	fb75                	bnez	a4,3dc <strcat+0x16>
    ;
  return os;
}
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret
  while(*s)
 3f0:	87aa                	mv	a5,a0
 3f2:	b7ed                	j	3dc <strcat+0x16>

00000000000003f4 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	cb91                	beqz	a5,412 <strcmp+0x1e>
 400:	0005c703          	lbu	a4,0(a1)
 404:	00f71763          	bne	a4,a5,412 <strcmp+0x1e>
    p++, q++;
 408:	0505                	addi	a0,a0,1
 40a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 40c:	00054783          	lbu	a5,0(a0)
 410:	fbe5                	bnez	a5,400 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 412:	0005c503          	lbu	a0,0(a1)
}
 416:	40a7853b          	subw	a0,a5,a0
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <strlen>:

uint
strlen(const char *s)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 426:	00054783          	lbu	a5,0(a0)
 42a:	cf91                	beqz	a5,446 <strlen+0x26>
 42c:	0505                	addi	a0,a0,1
 42e:	87aa                	mv	a5,a0
 430:	4685                	li	a3,1
 432:	9e89                	subw	a3,a3,a0
 434:	00f6853b          	addw	a0,a3,a5
 438:	0785                	addi	a5,a5,1
 43a:	fff7c703          	lbu	a4,-1(a5)
 43e:	fb7d                	bnez	a4,434 <strlen+0x14>
    ;
  return n;
}
 440:	6422                	ld	s0,8(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret
  for(n = 0; s[n]; n++)
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <strlen+0x20>

000000000000044a <memset>:

void*
memset(void *dst, int c, uint n)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 450:	ca19                	beqz	a2,466 <memset+0x1c>
 452:	87aa                	mv	a5,a0
 454:	1602                	slli	a2,a2,0x20
 456:	9201                	srli	a2,a2,0x20
 458:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 45c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 460:	0785                	addi	a5,a5,1
 462:	fee79de3          	bne	a5,a4,45c <memset+0x12>
  }
  return dst;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret

000000000000046c <strchr>:

char*
strchr(const char *s, char c)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
  for(; *s; s++)
 472:	00054783          	lbu	a5,0(a0)
 476:	cb99                	beqz	a5,48c <strchr+0x20>
    if(*s == c)
 478:	00f58763          	beq	a1,a5,486 <strchr+0x1a>
  for(; *s; s++)
 47c:	0505                	addi	a0,a0,1
 47e:	00054783          	lbu	a5,0(a0)
 482:	fbfd                	bnez	a5,478 <strchr+0xc>
      return (char*)s;
  return 0;
 484:	4501                	li	a0,0
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
  return 0;
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <strchr+0x1a>

0000000000000490 <gets>:

char*
gets(char *buf, int max)
{
 490:	711d                	addi	sp,sp,-96
 492:	ec86                	sd	ra,88(sp)
 494:	e8a2                	sd	s0,80(sp)
 496:	e4a6                	sd	s1,72(sp)
 498:	e0ca                	sd	s2,64(sp)
 49a:	fc4e                	sd	s3,56(sp)
 49c:	f852                	sd	s4,48(sp)
 49e:	f456                	sd	s5,40(sp)
 4a0:	f05a                	sd	s6,32(sp)
 4a2:	ec5e                	sd	s7,24(sp)
 4a4:	e862                	sd	s8,16(sp)
 4a6:	1080                	addi	s0,sp,96
 4a8:	8baa                	mv	s7,a0
 4aa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4ac:	892a                	mv	s2,a0
 4ae:	4481                	li	s1,0
    cc = read(0, &c, 1);
 4b0:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4b4:	4b29                	li	s6,10
 4b6:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 4b8:	89a6                	mv	s3,s1
 4ba:	2485                	addiw	s1,s1,1
 4bc:	0344d763          	bge	s1,s4,4ea <gets+0x5a>
    cc = read(0, &c, 1);
 4c0:	4605                	li	a2,1
 4c2:	85d6                	mv	a1,s5
 4c4:	4501                	li	a0,0
 4c6:	00000097          	auipc	ra,0x0
 4ca:	1b4080e7          	jalr	436(ra) # 67a <read>
    if(cc < 1)
 4ce:	00a05e63          	blez	a0,4ea <gets+0x5a>
    buf[i++] = c;
 4d2:	faf44783          	lbu	a5,-81(s0)
 4d6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4da:	01678763          	beq	a5,s6,4e8 <gets+0x58>
 4de:	0905                	addi	s2,s2,1
 4e0:	fd879ce3          	bne	a5,s8,4b8 <gets+0x28>
  for(i=0; i+1 < max; ){
 4e4:	89a6                	mv	s3,s1
 4e6:	a011                	j	4ea <gets+0x5a>
 4e8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 4ea:	99de                	add	s3,s3,s7
 4ec:	00098023          	sb	zero,0(s3)
  return buf;
}
 4f0:	855e                	mv	a0,s7
 4f2:	60e6                	ld	ra,88(sp)
 4f4:	6446                	ld	s0,80(sp)
 4f6:	64a6                	ld	s1,72(sp)
 4f8:	6906                	ld	s2,64(sp)
 4fa:	79e2                	ld	s3,56(sp)
 4fc:	7a42                	ld	s4,48(sp)
 4fe:	7aa2                	ld	s5,40(sp)
 500:	7b02                	ld	s6,32(sp)
 502:	6be2                	ld	s7,24(sp)
 504:	6c42                	ld	s8,16(sp)
 506:	6125                	addi	sp,sp,96
 508:	8082                	ret

000000000000050a <stat>:

int
stat(const char *n, struct stat *st)
{
 50a:	1101                	addi	sp,sp,-32
 50c:	ec06                	sd	ra,24(sp)
 50e:	e822                	sd	s0,16(sp)
 510:	e426                	sd	s1,8(sp)
 512:	e04a                	sd	s2,0(sp)
 514:	1000                	addi	s0,sp,32
 516:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 518:	4581                	li	a1,0
 51a:	00000097          	auipc	ra,0x0
 51e:	188080e7          	jalr	392(ra) # 6a2 <open>
  if(fd < 0)
 522:	02054563          	bltz	a0,54c <stat+0x42>
 526:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 528:	85ca                	mv	a1,s2
 52a:	00000097          	auipc	ra,0x0
 52e:	180080e7          	jalr	384(ra) # 6aa <fstat>
 532:	892a                	mv	s2,a0
  close(fd);
 534:	8526                	mv	a0,s1
 536:	00000097          	auipc	ra,0x0
 53a:	154080e7          	jalr	340(ra) # 68a <close>
  return r;
}
 53e:	854a                	mv	a0,s2
 540:	60e2                	ld	ra,24(sp)
 542:	6442                	ld	s0,16(sp)
 544:	64a2                	ld	s1,8(sp)
 546:	6902                	ld	s2,0(sp)
 548:	6105                	addi	sp,sp,32
 54a:	8082                	ret
    return -1;
 54c:	597d                	li	s2,-1
 54e:	bfc5                	j	53e <stat+0x34>

0000000000000550 <atoi>:

int
atoi(const char *s)
{
 550:	1141                	addi	sp,sp,-16
 552:	e422                	sd	s0,8(sp)
 554:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 556:	00054703          	lbu	a4,0(a0)
 55a:	02d00793          	li	a5,45
  int neg = 1;
 55e:	4585                	li	a1,1
  if (*s == '-') {
 560:	04f70363          	beq	a4,a5,5a6 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 564:	00054703          	lbu	a4,0(a0)
 568:	fd07079b          	addiw	a5,a4,-48
 56c:	0ff7f793          	zext.b	a5,a5
 570:	46a5                	li	a3,9
 572:	02f6ed63          	bltu	a3,a5,5ac <atoi+0x5c>
  n = 0;
 576:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 578:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 57a:	0505                	addi	a0,a0,1
 57c:	0026979b          	slliw	a5,a3,0x2
 580:	9fb5                	addw	a5,a5,a3
 582:	0017979b          	slliw	a5,a5,0x1
 586:	9fb9                	addw	a5,a5,a4
 588:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 58c:	00054703          	lbu	a4,0(a0)
 590:	fd07079b          	addiw	a5,a4,-48
 594:	0ff7f793          	zext.b	a5,a5
 598:	fef671e3          	bgeu	a2,a5,57a <atoi+0x2a>
  return n * neg;
}
 59c:	02d5853b          	mulw	a0,a1,a3
 5a0:	6422                	ld	s0,8(sp)
 5a2:	0141                	addi	sp,sp,16
 5a4:	8082                	ret
    s++;
 5a6:	0505                	addi	a0,a0,1
    neg = -1;
 5a8:	55fd                	li	a1,-1
 5aa:	bf6d                	j	564 <atoi+0x14>
  n = 0;
 5ac:	4681                	li	a3,0
 5ae:	b7fd                	j	59c <atoi+0x4c>

00000000000005b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b0:	1141                	addi	sp,sp,-16
 5b2:	e422                	sd	s0,8(sp)
 5b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5b6:	02b57463          	bgeu	a0,a1,5de <memmove+0x2e>
    while(n-- > 0)
 5ba:	00c05f63          	blez	a2,5d8 <memmove+0x28>
 5be:	1602                	slli	a2,a2,0x20
 5c0:	9201                	srli	a2,a2,0x20
 5c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 5c8:	0585                	addi	a1,a1,1
 5ca:	0705                	addi	a4,a4,1
 5cc:	fff5c683          	lbu	a3,-1(a1)
 5d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5d4:	fee79ae3          	bne	a5,a4,5c8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5d8:	6422                	ld	s0,8(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret
    dst += n;
 5de:	00c50733          	add	a4,a0,a2
    src += n;
 5e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5e4:	fec05ae3          	blez	a2,5d8 <memmove+0x28>
 5e8:	fff6079b          	addiw	a5,a2,-1
 5ec:	1782                	slli	a5,a5,0x20
 5ee:	9381                	srli	a5,a5,0x20
 5f0:	fff7c793          	not	a5,a5
 5f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5f6:	15fd                	addi	a1,a1,-1
 5f8:	177d                	addi	a4,a4,-1
 5fa:	0005c683          	lbu	a3,0(a1)
 5fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 602:	fee79ae3          	bne	a5,a4,5f6 <memmove+0x46>
 606:	bfc9                	j	5d8 <memmove+0x28>

0000000000000608 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 608:	1141                	addi	sp,sp,-16
 60a:	e422                	sd	s0,8(sp)
 60c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 60e:	ca05                	beqz	a2,63e <memcmp+0x36>
 610:	fff6069b          	addiw	a3,a2,-1
 614:	1682                	slli	a3,a3,0x20
 616:	9281                	srli	a3,a3,0x20
 618:	0685                	addi	a3,a3,1
 61a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 61c:	00054783          	lbu	a5,0(a0)
 620:	0005c703          	lbu	a4,0(a1)
 624:	00e79863          	bne	a5,a4,634 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 628:	0505                	addi	a0,a0,1
    p2++;
 62a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 62c:	fed518e3          	bne	a0,a3,61c <memcmp+0x14>
  }
  return 0;
 630:	4501                	li	a0,0
 632:	a019                	j	638 <memcmp+0x30>
      return *p1 - *p2;
 634:	40e7853b          	subw	a0,a5,a4
}
 638:	6422                	ld	s0,8(sp)
 63a:	0141                	addi	sp,sp,16
 63c:	8082                	ret
  return 0;
 63e:	4501                	li	a0,0
 640:	bfe5                	j	638 <memcmp+0x30>

0000000000000642 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 642:	1141                	addi	sp,sp,-16
 644:	e406                	sd	ra,8(sp)
 646:	e022                	sd	s0,0(sp)
 648:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 64a:	00000097          	auipc	ra,0x0
 64e:	f66080e7          	jalr	-154(ra) # 5b0 <memmove>
}
 652:	60a2                	ld	ra,8(sp)
 654:	6402                	ld	s0,0(sp)
 656:	0141                	addi	sp,sp,16
 658:	8082                	ret

000000000000065a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 65a:	4885                	li	a7,1
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <exit>:
.global exit
exit:
 li a7, SYS_exit
 662:	4889                	li	a7,2
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <wait>:
.global wait
wait:
 li a7, SYS_wait
 66a:	488d                	li	a7,3
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 672:	4891                	li	a7,4
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <read>:
.global read
read:
 li a7, SYS_read
 67a:	4895                	li	a7,5
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <write>:
.global write
write:
 li a7, SYS_write
 682:	48c1                	li	a7,16
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <close>:
.global close
close:
 li a7, SYS_close
 68a:	48d5                	li	a7,21
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <kill>:
.global kill
kill:
 li a7, SYS_kill
 692:	4899                	li	a7,6
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <exec>:
.global exec
exec:
 li a7, SYS_exec
 69a:	489d                	li	a7,7
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <open>:
.global open
open:
 li a7, SYS_open
 6a2:	48bd                	li	a7,15
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6aa:	48a1                	li	a7,8
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6b2:	48d1                	li	a7,20
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6ba:	48a5                	li	a7,9
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6c2:	48a9                	li	a7,10
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6ca:	48ad                	li	a7,11
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6d2:	48b1                	li	a7,12
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6da:	48b5                	li	a7,13
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6e2:	48b9                	li	a7,14
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 6ea:	48d9                	li	a7,22
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <dev>:
.global dev
dev:
 li a7, SYS_dev
 6f2:	48dd                	li	a7,23
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 6fa:	48e1                	li	a7,24
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 702:	48e5                	li	a7,25
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <remove>:
.global remove
remove:
 li a7, SYS_remove
 70a:	48c5                	li	a7,17
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <trace>:
.global trace
trace:
 li a7, SYS_trace
 712:	48c9                	li	a7,18
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 71a:	48cd                	li	a7,19
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <rename>:
.global rename
rename:
 li a7, SYS_rename
 722:	48e9                	li	a7,26
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 72a:	48ed                	li	a7,27
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 732:	48f1                	li	a7,28
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 73a:	48f5                	li	a7,29
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 742:	48f9                	li	a7,30
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 74a:	48fd                	li	a7,31
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 752:	02000893          	li	a7,32
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 75c:	02100893          	li	a7,33
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 766:	02200893          	li	a7,34
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 770:	02300893          	li	a7,35
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 77a:	02400893          	li	a7,36
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 784:	02500893          	li	a7,37
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 78e:	02600893          	li	a7,38
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 798:	02700893          	li	a7,39
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 7a2:	02800893          	li	a7,40
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 7ac:	02900893          	li	a7,41
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 7b6:	02a00893          	li	a7,42
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 7c0:	02b00893          	li	a7,43
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 7ca:	02c00893          	li	a7,44
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 7d4:	02d00893          	li	a7,45
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 7de:	02e00893          	li	a7,46
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 7e8:	02f00893          	li	a7,47
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 7f2:	03000893          	li	a7,48
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 7fc:	03100893          	li	a7,49
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 806:	03200893          	li	a7,50
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 810:	03300893          	li	a7,51
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 81a:	03400893          	li	a7,52
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 824:	03500893          	li	a7,53
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 82e:	03600893          	li	a7,54
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 838:	03700893          	li	a7,55
 ecall
 83c:	00000073          	ecall
 ret
 840:	8082                	ret

0000000000000842 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 842:	03800893          	li	a7,56
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 84c:	03900893          	li	a7,57
 ecall
 850:	00000073          	ecall
 ret
 854:	8082                	ret

0000000000000856 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 856:	03a00893          	li	a7,58
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <poll>:
.global poll
poll:
 li a7, SYS_poll
 860:	03b00893          	li	a7,59
 ecall
 864:	00000073          	ecall
 ret
 868:	8082                	ret

000000000000086a <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 86a:	03c00893          	li	a7,60
 ecall
 86e:	00000073          	ecall
 ret
 872:	8082                	ret

0000000000000874 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 874:	03d00893          	li	a7,61
 ecall
 878:	00000073          	ecall
 ret
 87c:	8082                	ret

000000000000087e <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 87e:	03e00893          	li	a7,62
 ecall
 882:	00000073          	ecall
 ret
 886:	8082                	ret

0000000000000888 <clone>:
.global clone
clone:
 li a7, SYS_clone
 888:	03f00893          	li	a7,63
 ecall
 88c:	00000073          	ecall
 ret
 890:	8082                	ret

0000000000000892 <futex>:
.global futex
futex:
 li a7, SYS_futex
 892:	04000893          	li	a7,64
 ecall
 896:	00000073          	ecall
 ret
 89a:	8082                	ret

000000000000089c <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 89c:	04100893          	li	a7,65
 ecall
 8a0:	00000073          	ecall
 ret
 8a4:	8082                	ret

00000000000008a6 <halt>:
.global halt
halt:
 li a7, SYS_halt
 8a6:	04200893          	li	a7,66
 ecall
 8aa:	00000073          	ecall
 ret
 8ae:	8082                	ret

00000000000008b0 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 8b0:	04300893          	li	a7,67
 ecall
 8b4:	00000073          	ecall
 ret
 8b8:	8082                	ret

00000000000008ba <socket>:
.global socket
socket:
 li a7, SYS_socket
 8ba:	04400893          	li	a7,68
 ecall
 8be:	00000073          	ecall
 ret
 8c2:	8082                	ret

00000000000008c4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 8c4:	04500893          	li	a7,69
 ecall
 8c8:	00000073          	ecall
 ret
 8cc:	8082                	ret

00000000000008ce <listen>:
.global listen
listen:
 li a7, SYS_listen
 8ce:	04600893          	li	a7,70
 ecall
 8d2:	00000073          	ecall
 ret
 8d6:	8082                	ret

00000000000008d8 <accept>:
.global accept
accept:
 li a7, SYS_accept
 8d8:	04700893          	li	a7,71
 ecall
 8dc:	00000073          	ecall
 ret
 8e0:	8082                	ret

00000000000008e2 <connect>:
.global connect
connect:
 li a7, SYS_connect
 8e2:	04800893          	li	a7,72
 ecall
 8e6:	00000073          	ecall
 ret
 8ea:	8082                	ret

00000000000008ec <send>:
.global send
send:
 li a7, SYS_send
 8ec:	04900893          	li	a7,73
 ecall
 8f0:	00000073          	ecall
 ret
 8f4:	8082                	ret

00000000000008f6 <recv>:
.global recv
recv:
 li a7, SYS_recv
 8f6:	04a00893          	li	a7,74
 ecall
 8fa:	00000073          	ecall
 ret
 8fe:	8082                	ret

0000000000000900 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 900:	04b00893          	li	a7,75
 ecall
 904:	00000073          	ecall
 ret
 908:	8082                	ret

000000000000090a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 90a:	1101                	addi	sp,sp,-32
 90c:	ec06                	sd	ra,24(sp)
 90e:	e822                	sd	s0,16(sp)
 910:	1000                	addi	s0,sp,32
 912:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 916:	4605                	li	a2,1
 918:	fef40593          	addi	a1,s0,-17
 91c:	00000097          	auipc	ra,0x0
 920:	d66080e7          	jalr	-666(ra) # 682 <write>
}
 924:	60e2                	ld	ra,24(sp)
 926:	6442                	ld	s0,16(sp)
 928:	6105                	addi	sp,sp,32
 92a:	8082                	ret

000000000000092c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 92c:	7139                	addi	sp,sp,-64
 92e:	fc06                	sd	ra,56(sp)
 930:	f822                	sd	s0,48(sp)
 932:	f426                	sd	s1,40(sp)
 934:	f04a                	sd	s2,32(sp)
 936:	ec4e                	sd	s3,24(sp)
 938:	0080                	addi	s0,sp,64
 93a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 93c:	c299                	beqz	a3,942 <printint+0x16>
 93e:	0805c863          	bltz	a1,9ce <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 942:	2581                	sext.w	a1,a1
  neg = 0;
 944:	4881                	li	a7,0
  }

  i = 0;
 946:	fc040993          	addi	s3,s0,-64
  neg = 0;
 94a:	86ce                	mv	a3,s3
  i = 0;
 94c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 94e:	2601                	sext.w	a2,a2
 950:	00000517          	auipc	a0,0x0
 954:	7a050513          	addi	a0,a0,1952 # 10f0 <digits>
 958:	883a                	mv	a6,a4
 95a:	2705                	addiw	a4,a4,1
 95c:	02c5f7bb          	remuw	a5,a1,a2
 960:	1782                	slli	a5,a5,0x20
 962:	9381                	srli	a5,a5,0x20
 964:	97aa                	add	a5,a5,a0
 966:	0007c783          	lbu	a5,0(a5)
 96a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 96e:	0005879b          	sext.w	a5,a1
 972:	02c5d5bb          	divuw	a1,a1,a2
 976:	0685                	addi	a3,a3,1
 978:	fec7f0e3          	bgeu	a5,a2,958 <printint+0x2c>
  if(neg)
 97c:	00088c63          	beqz	a7,994 <printint+0x68>
    buf[i++] = '-';
 980:	fd070793          	addi	a5,a4,-48
 984:	00878733          	add	a4,a5,s0
 988:	02d00793          	li	a5,45
 98c:	fef70823          	sb	a5,-16(a4)
 990:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 994:	02e05663          	blez	a4,9c0 <printint+0x94>
 998:	fc040913          	addi	s2,s0,-64
 99c:	993a                	add	s2,s2,a4
 99e:	19fd                	addi	s3,s3,-1
 9a0:	99ba                	add	s3,s3,a4
 9a2:	377d                	addiw	a4,a4,-1
 9a4:	1702                	slli	a4,a4,0x20
 9a6:	9301                	srli	a4,a4,0x20
 9a8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 9ac:	fff94583          	lbu	a1,-1(s2)
 9b0:	8526                	mv	a0,s1
 9b2:	00000097          	auipc	ra,0x0
 9b6:	f58080e7          	jalr	-168(ra) # 90a <putc>
  while(--i >= 0)
 9ba:	197d                	addi	s2,s2,-1
 9bc:	ff3918e3          	bne	s2,s3,9ac <printint+0x80>
}
 9c0:	70e2                	ld	ra,56(sp)
 9c2:	7442                	ld	s0,48(sp)
 9c4:	74a2                	ld	s1,40(sp)
 9c6:	7902                	ld	s2,32(sp)
 9c8:	69e2                	ld	s3,24(sp)
 9ca:	6121                	addi	sp,sp,64
 9cc:	8082                	ret
    x = -xx;
 9ce:	40b005bb          	negw	a1,a1
    neg = 1;
 9d2:	4885                	li	a7,1
    x = -xx;
 9d4:	bf8d                	j	946 <printint+0x1a>

00000000000009d6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 9d6:	7119                	addi	sp,sp,-128
 9d8:	fc86                	sd	ra,120(sp)
 9da:	f8a2                	sd	s0,112(sp)
 9dc:	f4a6                	sd	s1,104(sp)
 9de:	f0ca                	sd	s2,96(sp)
 9e0:	ecce                	sd	s3,88(sp)
 9e2:	e8d2                	sd	s4,80(sp)
 9e4:	e4d6                	sd	s5,72(sp)
 9e6:	e0da                	sd	s6,64(sp)
 9e8:	fc5e                	sd	s7,56(sp)
 9ea:	f862                	sd	s8,48(sp)
 9ec:	f466                	sd	s9,40(sp)
 9ee:	f06a                	sd	s10,32(sp)
 9f0:	ec6e                	sd	s11,24(sp)
 9f2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 9f4:	0005c903          	lbu	s2,0(a1)
 9f8:	18090f63          	beqz	s2,b96 <vprintf+0x1c0>
 9fc:	8aaa                	mv	s5,a0
 9fe:	8b32                	mv	s6,a2
 a00:	00158493          	addi	s1,a1,1
  state = 0;
 a04:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 a06:	02500a13          	li	s4,37
 a0a:	4c55                	li	s8,21
 a0c:	00000c97          	auipc	s9,0x0
 a10:	68cc8c93          	addi	s9,s9,1676 # 1098 <malloc+0x3fe>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a14:	02800d93          	li	s11,40
  putc(fd, 'x');
 a18:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a1a:	00000b97          	auipc	s7,0x0
 a1e:	6d6b8b93          	addi	s7,s7,1750 # 10f0 <digits>
 a22:	a839                	j	a40 <vprintf+0x6a>
        putc(fd, c);
 a24:	85ca                	mv	a1,s2
 a26:	8556                	mv	a0,s5
 a28:	00000097          	auipc	ra,0x0
 a2c:	ee2080e7          	jalr	-286(ra) # 90a <putc>
 a30:	a019                	j	a36 <vprintf+0x60>
    } else if(state == '%'){
 a32:	01498d63          	beq	s3,s4,a4c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 a36:	0485                	addi	s1,s1,1
 a38:	fff4c903          	lbu	s2,-1(s1)
 a3c:	14090d63          	beqz	s2,b96 <vprintf+0x1c0>
    if(state == 0){
 a40:	fe0999e3          	bnez	s3,a32 <vprintf+0x5c>
      if(c == '%'){
 a44:	ff4910e3          	bne	s2,s4,a24 <vprintf+0x4e>
        state = '%';
 a48:	89d2                	mv	s3,s4
 a4a:	b7f5                	j	a36 <vprintf+0x60>
      if(c == 'd'){
 a4c:	11490c63          	beq	s2,s4,b64 <vprintf+0x18e>
 a50:	f9d9079b          	addiw	a5,s2,-99
 a54:	0ff7f793          	zext.b	a5,a5
 a58:	10fc6e63          	bltu	s8,a5,b74 <vprintf+0x19e>
 a5c:	f9d9079b          	addiw	a5,s2,-99
 a60:	0ff7f713          	zext.b	a4,a5
 a64:	10ec6863          	bltu	s8,a4,b74 <vprintf+0x19e>
 a68:	00271793          	slli	a5,a4,0x2
 a6c:	97e6                	add	a5,a5,s9
 a6e:	439c                	lw	a5,0(a5)
 a70:	97e6                	add	a5,a5,s9
 a72:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 a74:	008b0913          	addi	s2,s6,8
 a78:	4685                	li	a3,1
 a7a:	4629                	li	a2,10
 a7c:	000b2583          	lw	a1,0(s6)
 a80:	8556                	mv	a0,s5
 a82:	00000097          	auipc	ra,0x0
 a86:	eaa080e7          	jalr	-342(ra) # 92c <printint>
 a8a:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a8c:	4981                	li	s3,0
 a8e:	b765                	j	a36 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a90:	008b0913          	addi	s2,s6,8
 a94:	4681                	li	a3,0
 a96:	4629                	li	a2,10
 a98:	000b2583          	lw	a1,0(s6)
 a9c:	8556                	mv	a0,s5
 a9e:	00000097          	auipc	ra,0x0
 aa2:	e8e080e7          	jalr	-370(ra) # 92c <printint>
 aa6:	8b4a                	mv	s6,s2
      state = 0;
 aa8:	4981                	li	s3,0
 aaa:	b771                	j	a36 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 aac:	008b0913          	addi	s2,s6,8
 ab0:	4681                	li	a3,0
 ab2:	866a                	mv	a2,s10
 ab4:	000b2583          	lw	a1,0(s6)
 ab8:	8556                	mv	a0,s5
 aba:	00000097          	auipc	ra,0x0
 abe:	e72080e7          	jalr	-398(ra) # 92c <printint>
 ac2:	8b4a                	mv	s6,s2
      state = 0;
 ac4:	4981                	li	s3,0
 ac6:	bf85                	j	a36 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 ac8:	008b0793          	addi	a5,s6,8
 acc:	f8f43423          	sd	a5,-120(s0)
 ad0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 ad4:	03000593          	li	a1,48
 ad8:	8556                	mv	a0,s5
 ada:	00000097          	auipc	ra,0x0
 ade:	e30080e7          	jalr	-464(ra) # 90a <putc>
  putc(fd, 'x');
 ae2:	07800593          	li	a1,120
 ae6:	8556                	mv	a0,s5
 ae8:	00000097          	auipc	ra,0x0
 aec:	e22080e7          	jalr	-478(ra) # 90a <putc>
 af0:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 af2:	03c9d793          	srli	a5,s3,0x3c
 af6:	97de                	add	a5,a5,s7
 af8:	0007c583          	lbu	a1,0(a5)
 afc:	8556                	mv	a0,s5
 afe:	00000097          	auipc	ra,0x0
 b02:	e0c080e7          	jalr	-500(ra) # 90a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b06:	0992                	slli	s3,s3,0x4
 b08:	397d                	addiw	s2,s2,-1
 b0a:	fe0914e3          	bnez	s2,af2 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 b0e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 b12:	4981                	li	s3,0
 b14:	b70d                	j	a36 <vprintf+0x60>
        s = va_arg(ap, char*);
 b16:	008b0913          	addi	s2,s6,8
 b1a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 b1e:	02098163          	beqz	s3,b40 <vprintf+0x16a>
        while(*s != 0){
 b22:	0009c583          	lbu	a1,0(s3)
 b26:	c5ad                	beqz	a1,b90 <vprintf+0x1ba>
          putc(fd, *s);
 b28:	8556                	mv	a0,s5
 b2a:	00000097          	auipc	ra,0x0
 b2e:	de0080e7          	jalr	-544(ra) # 90a <putc>
          s++;
 b32:	0985                	addi	s3,s3,1
        while(*s != 0){
 b34:	0009c583          	lbu	a1,0(s3)
 b38:	f9e5                	bnez	a1,b28 <vprintf+0x152>
        s = va_arg(ap, char*);
 b3a:	8b4a                	mv	s6,s2
      state = 0;
 b3c:	4981                	li	s3,0
 b3e:	bde5                	j	a36 <vprintf+0x60>
          s = "(null)";
 b40:	00000997          	auipc	s3,0x0
 b44:	55098993          	addi	s3,s3,1360 # 1090 <malloc+0x3f6>
        while(*s != 0){
 b48:	85ee                	mv	a1,s11
 b4a:	bff9                	j	b28 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 b4c:	008b0913          	addi	s2,s6,8
 b50:	000b4583          	lbu	a1,0(s6)
 b54:	8556                	mv	a0,s5
 b56:	00000097          	auipc	ra,0x0
 b5a:	db4080e7          	jalr	-588(ra) # 90a <putc>
 b5e:	8b4a                	mv	s6,s2
      state = 0;
 b60:	4981                	li	s3,0
 b62:	bdd1                	j	a36 <vprintf+0x60>
        putc(fd, c);
 b64:	85d2                	mv	a1,s4
 b66:	8556                	mv	a0,s5
 b68:	00000097          	auipc	ra,0x0
 b6c:	da2080e7          	jalr	-606(ra) # 90a <putc>
      state = 0;
 b70:	4981                	li	s3,0
 b72:	b5d1                	j	a36 <vprintf+0x60>
        putc(fd, '%');
 b74:	85d2                	mv	a1,s4
 b76:	8556                	mv	a0,s5
 b78:	00000097          	auipc	ra,0x0
 b7c:	d92080e7          	jalr	-622(ra) # 90a <putc>
        putc(fd, c);
 b80:	85ca                	mv	a1,s2
 b82:	8556                	mv	a0,s5
 b84:	00000097          	auipc	ra,0x0
 b88:	d86080e7          	jalr	-634(ra) # 90a <putc>
      state = 0;
 b8c:	4981                	li	s3,0
 b8e:	b565                	j	a36 <vprintf+0x60>
        s = va_arg(ap, char*);
 b90:	8b4a                	mv	s6,s2
      state = 0;
 b92:	4981                	li	s3,0
 b94:	b54d                	j	a36 <vprintf+0x60>
    }
  }
}
 b96:	70e6                	ld	ra,120(sp)
 b98:	7446                	ld	s0,112(sp)
 b9a:	74a6                	ld	s1,104(sp)
 b9c:	7906                	ld	s2,96(sp)
 b9e:	69e6                	ld	s3,88(sp)
 ba0:	6a46                	ld	s4,80(sp)
 ba2:	6aa6                	ld	s5,72(sp)
 ba4:	6b06                	ld	s6,64(sp)
 ba6:	7be2                	ld	s7,56(sp)
 ba8:	7c42                	ld	s8,48(sp)
 baa:	7ca2                	ld	s9,40(sp)
 bac:	7d02                	ld	s10,32(sp)
 bae:	6de2                	ld	s11,24(sp)
 bb0:	6109                	addi	sp,sp,128
 bb2:	8082                	ret

0000000000000bb4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 bb4:	715d                	addi	sp,sp,-80
 bb6:	ec06                	sd	ra,24(sp)
 bb8:	e822                	sd	s0,16(sp)
 bba:	1000                	addi	s0,sp,32
 bbc:	e010                	sd	a2,0(s0)
 bbe:	e414                	sd	a3,8(s0)
 bc0:	e818                	sd	a4,16(s0)
 bc2:	ec1c                	sd	a5,24(s0)
 bc4:	03043023          	sd	a6,32(s0)
 bc8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 bcc:	8622                	mv	a2,s0
 bce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 bd2:	00000097          	auipc	ra,0x0
 bd6:	e04080e7          	jalr	-508(ra) # 9d6 <vprintf>
}
 bda:	60e2                	ld	ra,24(sp)
 bdc:	6442                	ld	s0,16(sp)
 bde:	6161                	addi	sp,sp,80
 be0:	8082                	ret

0000000000000be2 <printf>:

void
printf(const char *fmt, ...)
{
 be2:	711d                	addi	sp,sp,-96
 be4:	ec06                	sd	ra,24(sp)
 be6:	e822                	sd	s0,16(sp)
 be8:	1000                	addi	s0,sp,32
 bea:	e40c                	sd	a1,8(s0)
 bec:	e810                	sd	a2,16(s0)
 bee:	ec14                	sd	a3,24(s0)
 bf0:	f018                	sd	a4,32(s0)
 bf2:	f41c                	sd	a5,40(s0)
 bf4:	03043823          	sd	a6,48(s0)
 bf8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bfc:	00840613          	addi	a2,s0,8
 c00:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c04:	85aa                	mv	a1,a0
 c06:	4505                	li	a0,1
 c08:	00000097          	auipc	ra,0x0
 c0c:	dce080e7          	jalr	-562(ra) # 9d6 <vprintf>
}
 c10:	60e2                	ld	ra,24(sp)
 c12:	6442                	ld	s0,16(sp)
 c14:	6125                	addi	sp,sp,96
 c16:	8082                	ret

0000000000000c18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c18:	1141                	addi	sp,sp,-16
 c1a:	e422                	sd	s0,8(sp)
 c1c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c1e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c22:	00000797          	auipc	a5,0x0
 c26:	4e67b783          	ld	a5,1254(a5) # 1108 <freep>
 c2a:	a02d                	j	c54 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c2c:	4618                	lw	a4,8(a2)
 c2e:	9f2d                	addw	a4,a4,a1
 c30:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c34:	6398                	ld	a4,0(a5)
 c36:	6310                	ld	a2,0(a4)
 c38:	a83d                	j	c76 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c3a:	ff852703          	lw	a4,-8(a0)
 c3e:	9f31                	addw	a4,a4,a2
 c40:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c42:	ff053683          	ld	a3,-16(a0)
 c46:	a091                	j	c8a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c48:	6398                	ld	a4,0(a5)
 c4a:	00e7e463          	bltu	a5,a4,c52 <free+0x3a>
 c4e:	00e6ea63          	bltu	a3,a4,c62 <free+0x4a>
{
 c52:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c54:	fed7fae3          	bgeu	a5,a3,c48 <free+0x30>
 c58:	6398                	ld	a4,0(a5)
 c5a:	00e6e463          	bltu	a3,a4,c62 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c5e:	fee7eae3          	bltu	a5,a4,c52 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c62:	ff852583          	lw	a1,-8(a0)
 c66:	6390                	ld	a2,0(a5)
 c68:	02059813          	slli	a6,a1,0x20
 c6c:	01c85713          	srli	a4,a6,0x1c
 c70:	9736                	add	a4,a4,a3
 c72:	fae60de3          	beq	a2,a4,c2c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c76:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c7a:	4790                	lw	a2,8(a5)
 c7c:	02061593          	slli	a1,a2,0x20
 c80:	01c5d713          	srli	a4,a1,0x1c
 c84:	973e                	add	a4,a4,a5
 c86:	fae68ae3          	beq	a3,a4,c3a <free+0x22>
    p->s.ptr = bp->s.ptr;
 c8a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c8c:	00000717          	auipc	a4,0x0
 c90:	46f73e23          	sd	a5,1148(a4) # 1108 <freep>
}
 c94:	6422                	ld	s0,8(sp)
 c96:	0141                	addi	sp,sp,16
 c98:	8082                	ret

0000000000000c9a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c9a:	7139                	addi	sp,sp,-64
 c9c:	fc06                	sd	ra,56(sp)
 c9e:	f822                	sd	s0,48(sp)
 ca0:	f426                	sd	s1,40(sp)
 ca2:	f04a                	sd	s2,32(sp)
 ca4:	ec4e                	sd	s3,24(sp)
 ca6:	e852                	sd	s4,16(sp)
 ca8:	e456                	sd	s5,8(sp)
 caa:	e05a                	sd	s6,0(sp)
 cac:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cae:	02051493          	slli	s1,a0,0x20
 cb2:	9081                	srli	s1,s1,0x20
 cb4:	04bd                	addi	s1,s1,15
 cb6:	8091                	srli	s1,s1,0x4
 cb8:	00148a1b          	addiw	s4,s1,1
 cbc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 cbe:	00000517          	auipc	a0,0x0
 cc2:	44a53503          	ld	a0,1098(a0) # 1108 <freep>
 cc6:	c515                	beqz	a0,cf2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cca:	4798                	lw	a4,8(a5)
 ccc:	04977163          	bgeu	a4,s1,d0e <malloc+0x74>
 cd0:	89d2                	mv	s3,s4
 cd2:	000a071b          	sext.w	a4,s4
 cd6:	6685                	lui	a3,0x1
 cd8:	00d77363          	bgeu	a4,a3,cde <malloc+0x44>
 cdc:	6985                	lui	s3,0x1
 cde:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 ce2:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ce6:	00000917          	auipc	s2,0x0
 cea:	42290913          	addi	s2,s2,1058 # 1108 <freep>
  if(p == (char*)-1)
 cee:	5afd                	li	s5,-1
 cf0:	a8a5                	j	d68 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 cf2:	00000797          	auipc	a5,0x0
 cf6:	41678793          	addi	a5,a5,1046 # 1108 <freep>
 cfa:	00000717          	auipc	a4,0x0
 cfe:	41670713          	addi	a4,a4,1046 # 1110 <base>
 d02:	e398                	sd	a4,0(a5)
 d04:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 d06:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d0a:	87ba                	mv	a5,a4
 d0c:	b7d1                	j	cd0 <malloc+0x36>
      if(p->s.size == nunits)
 d0e:	02e48c63          	beq	s1,a4,d46 <malloc+0xac>
        p->s.size -= nunits;
 d12:	4147073b          	subw	a4,a4,s4
 d16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d18:	02071693          	slli	a3,a4,0x20
 d1c:	01c6d713          	srli	a4,a3,0x1c
 d20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d22:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 d26:	00000717          	auipc	a4,0x0
 d2a:	3ea73123          	sd	a0,994(a4) # 1108 <freep>
      return (void*)(p + 1);
 d2e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 d32:	70e2                	ld	ra,56(sp)
 d34:	7442                	ld	s0,48(sp)
 d36:	74a2                	ld	s1,40(sp)
 d38:	7902                	ld	s2,32(sp)
 d3a:	69e2                	ld	s3,24(sp)
 d3c:	6a42                	ld	s4,16(sp)
 d3e:	6aa2                	ld	s5,8(sp)
 d40:	6b02                	ld	s6,0(sp)
 d42:	6121                	addi	sp,sp,64
 d44:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 d46:	6398                	ld	a4,0(a5)
 d48:	e118                	sd	a4,0(a0)
 d4a:	bff1                	j	d26 <malloc+0x8c>
  hp->s.size = nu;
 d4c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d50:	0541                	addi	a0,a0,16
 d52:	00000097          	auipc	ra,0x0
 d56:	ec6080e7          	jalr	-314(ra) # c18 <free>
  return freep;
 d5a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d5e:	d971                	beqz	a0,d32 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d60:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d62:	4798                	lw	a4,8(a5)
 d64:	fa9775e3          	bgeu	a4,s1,d0e <malloc+0x74>
    if(p == freep)
 d68:	00093703          	ld	a4,0(s2)
 d6c:	853e                	mv	a0,a5
 d6e:	fef719e3          	bne	a4,a5,d60 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 d72:	854e                	mv	a0,s3
 d74:	00000097          	auipc	ra,0x0
 d78:	95e080e7          	jalr	-1698(ra) # 6d2 <sbrk>
  if(p == (char*)-1)
 d7c:	fd5518e3          	bne	a0,s5,d4c <malloc+0xb2>
        return 0;
 d80:	4501                	li	a0,0
 d82:	bf45                	j	d32 <malloc+0x98>
