
serein-user/_simplesock：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
// simplesock.c - Minimal socket test without fork
#include "kernel/include/types.h"
#include "serein-user/user.h"

int main(int argc, char *argv[]) {
   0:	7155                	addi	sp,sp,-208
   2:	e586                	sd	ra,200(sp)
   4:	e1a2                	sd	s0,192(sp)
   6:	fd26                	sd	s1,184(sp)
   8:	f94a                	sd	s2,176(sp)
   a:	f54e                	sd	s3,168(sp)
   c:	0980                	addi	s0,sp,208
  int sockfd, clientfd;
  struct sockaddr_un addr;
  int addrlen;
  
  printf("=== Simple Socket Test ===\n");
   e:	00001517          	auipc	a0,0x1
  12:	caa50513          	addi	a0,a0,-854 # cb8 <malloc+0xee>
  16:	00001097          	auipc	ra,0x1
  1a:	afc080e7          	jalr	-1284(ra) # b12 <printf>
  
  // Create socket
  printf("1. Creating socket...\n");
  1e:	00001517          	auipc	a0,0x1
  22:	cba50513          	addi	a0,a0,-838 # cd8 <malloc+0x10e>
  26:	00001097          	auipc	ra,0x1
  2a:	aec080e7          	jalr	-1300(ra) # b12 <printf>
  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  2e:	4601                	li	a2,0
  30:	4585                	li	a1,1
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	7b6080e7          	jalr	1974(ra) # 7ea <socket>
  3c:	84aa                	mv	s1,a0
  printf("2. socket() returned %d\n", sockfd);
  3e:	85aa                	mv	a1,a0
  40:	00001517          	auipc	a0,0x1
  44:	cb050513          	addi	a0,a0,-848 # cf0 <malloc+0x126>
  48:	00001097          	auipc	ra,0x1
  4c:	aca080e7          	jalr	-1334(ra) # b12 <printf>
  if(sockfd < 0) {
  50:	1204c363          	bltz	s1,176 <main+0x176>
    printf("FAIL: socket() failed\n");
    exit(1);
  }
  
  // Bind
  addr.family = AF_UNIX;
  54:	4785                	li	a5,1
  56:	f6f41023          	sh	a5,-160(s0)
  strcpy(addr.path, "/tmp/simple.sock");
  5a:	00001597          	auipc	a1,0x1
  5e:	cce58593          	addi	a1,a1,-818 # d28 <malloc+0x15e>
  62:	f6240513          	addi	a0,s0,-158
  66:	00000097          	auipc	ra,0x0
  6a:	274080e7          	jalr	628(ra) # 2da <strcpy>
  printf("3. Binding...\n");
  6e:	00001517          	auipc	a0,0x1
  72:	cd250513          	addi	a0,a0,-814 # d40 <malloc+0x176>
  76:	00001097          	auipc	ra,0x1
  7a:	a9c080e7          	jalr	-1380(ra) # b12 <printf>
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
  7e:	06e00613          	li	a2,110
  82:	f6040593          	addi	a1,s0,-160
  86:	8526                	mv	a0,s1
  88:	00000097          	auipc	ra,0x0
  8c:	76c080e7          	jalr	1900(ra) # 7f4 <bind>
  90:	10054063          	bltz	a0,190 <main+0x190>
    printf("FAIL: bind() failed\n");
    exit(1);
  }
  printf("4. bind() OK\n");
  94:	00001517          	auipc	a0,0x1
  98:	cd450513          	addi	a0,a0,-812 # d68 <malloc+0x19e>
  9c:	00001097          	auipc	ra,0x1
  a0:	a76080e7          	jalr	-1418(ra) # b12 <printf>
  
  // Listen
  printf("5. Listening...\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	cd450513          	addi	a0,a0,-812 # d78 <malloc+0x1ae>
  ac:	00001097          	auipc	ra,0x1
  b0:	a66080e7          	jalr	-1434(ra) # b12 <printf>
  if(listen(sockfd, 5) < 0) {
  b4:	4595                	li	a1,5
  b6:	8526                	mv	a0,s1
  b8:	00000097          	auipc	ra,0x0
  bc:	746080e7          	jalr	1862(ra) # 7fe <listen>
  c0:	0e054563          	bltz	a0,1aa <main+0x1aa>
    printf("FAIL: listen() failed\n");
    exit(1);
  }
  printf("6. listen() OK\n");
  c4:	00001517          	auipc	a0,0x1
  c8:	ce450513          	addi	a0,a0,-796 # da8 <malloc+0x1de>
  cc:	00001097          	auipc	ra,0x1
  d0:	a46080e7          	jalr	-1466(ra) # b12 <printf>
  
  // Accept with timeout simulation - use fork to create client
  printf("7. Forking to create client...\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	ce450513          	addi	a0,a0,-796 # db8 <malloc+0x1ee>
  dc:	00001097          	auipc	ra,0x1
  e0:	a36080e7          	jalr	-1482(ra) # b12 <printf>
  int pid = fork();
  e4:	00000097          	auipc	ra,0x0
  e8:	4a6080e7          	jalr	1190(ra) # 58a <fork>
  
  if(pid == 0) {
  ec:	e96d                	bnez	a0,1de <main+0x1de>
    // Child: client
    sleep(5);  // Let parent reach accept
  ee:	4515                	li	a0,5
  f0:	00000097          	auipc	ra,0x0
  f4:	51a080e7          	jalr	1306(ra) # 60a <sleep>
    printf("[CLIENT] Connecting...\n");
  f8:	00001517          	auipc	a0,0x1
  fc:	ce050513          	addi	a0,a0,-800 # dd8 <malloc+0x20e>
 100:	00001097          	auipc	ra,0x1
 104:	a12080e7          	jalr	-1518(ra) # b12 <printf>
    int csock = socket(AF_UNIX, SOCK_STREAM, 0);
 108:	4601                	li	a2,0
 10a:	4585                	li	a1,1
 10c:	4505                	li	a0,1
 10e:	00000097          	auipc	ra,0x0
 112:	6dc080e7          	jalr	1756(ra) # 7ea <socket>
 116:	84aa                	mv	s1,a0
    if(connect(csock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
 118:	06e00613          	li	a2,110
 11c:	f6040593          	addi	a1,s0,-160
 120:	00000097          	auipc	ra,0x0
 124:	6f2080e7          	jalr	1778(ra) # 812 <connect>
 128:	08054e63          	bltz	a0,1c4 <main+0x1c4>
      printf("[CLIENT] connect failed\n");
      exit(1);
    }
    printf("[CLIENT] Connected! Sending...\n");
 12c:	00001517          	auipc	a0,0x1
 130:	ce450513          	addi	a0,a0,-796 # e10 <malloc+0x246>
 134:	00001097          	auipc	ra,0x1
 138:	9de080e7          	jalr	-1570(ra) # b12 <printf>
    send(csock, "HELLO", 5, 0);
 13c:	4681                	li	a3,0
 13e:	4615                	li	a2,5
 140:	00001597          	auipc	a1,0x1
 144:	cf058593          	addi	a1,a1,-784 # e30 <malloc+0x266>
 148:	8526                	mv	a0,s1
 14a:	00000097          	auipc	ra,0x0
 14e:	6d2080e7          	jalr	1746(ra) # 81c <send>
    printf("[CLIENT] Sent. Exiting.\n");
 152:	00001517          	auipc	a0,0x1
 156:	ce650513          	addi	a0,a0,-794 # e38 <malloc+0x26e>
 15a:	00001097          	auipc	ra,0x1
 15e:	9b8080e7          	jalr	-1608(ra) # b12 <printf>
    close(csock);
 162:	8526                	mv	a0,s1
 164:	00000097          	auipc	ra,0x0
 168:	456080e7          	jalr	1110(ra) # 5ba <close>
    exit(0);
 16c:	4501                	li	a0,0
 16e:	00000097          	auipc	ra,0x0
 172:	424080e7          	jalr	1060(ra) # 592 <exit>
    printf("FAIL: socket() failed\n");
 176:	00001517          	auipc	a0,0x1
 17a:	b9a50513          	addi	a0,a0,-1126 # d10 <malloc+0x146>
 17e:	00001097          	auipc	ra,0x1
 182:	994080e7          	jalr	-1644(ra) # b12 <printf>
    exit(1);
 186:	4505                	li	a0,1
 188:	00000097          	auipc	ra,0x0
 18c:	40a080e7          	jalr	1034(ra) # 592 <exit>
    printf("FAIL: bind() failed\n");
 190:	00001517          	auipc	a0,0x1
 194:	bc050513          	addi	a0,a0,-1088 # d50 <malloc+0x186>
 198:	00001097          	auipc	ra,0x1
 19c:	97a080e7          	jalr	-1670(ra) # b12 <printf>
    exit(1);
 1a0:	4505                	li	a0,1
 1a2:	00000097          	auipc	ra,0x0
 1a6:	3f0080e7          	jalr	1008(ra) # 592 <exit>
    printf("FAIL: listen() failed\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	be650513          	addi	a0,a0,-1050 # d90 <malloc+0x1c6>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	960080e7          	jalr	-1696(ra) # b12 <printf>
    exit(1);
 1ba:	4505                	li	a0,1
 1bc:	00000097          	auipc	ra,0x0
 1c0:	3d6080e7          	jalr	982(ra) # 592 <exit>
      printf("[CLIENT] connect failed\n");
 1c4:	00001517          	auipc	a0,0x1
 1c8:	c2c50513          	addi	a0,a0,-980 # df0 <malloc+0x226>
 1cc:	00001097          	auipc	ra,0x1
 1d0:	946080e7          	jalr	-1722(ra) # b12 <printf>
      exit(1);
 1d4:	4505                	li	a0,1
 1d6:	00000097          	auipc	ra,0x0
 1da:	3bc080e7          	jalr	956(ra) # 592 <exit>
  }
  
  // Parent: server continues
  printf("8. Calling accept()...\n");
 1de:	00001517          	auipc	a0,0x1
 1e2:	c7a50513          	addi	a0,a0,-902 # e58 <malloc+0x28e>
 1e6:	00001097          	auipc	ra,0x1
 1ea:	92c080e7          	jalr	-1748(ra) # b12 <printf>
  // write(1, "PRE_ACCEPT\n", 11);
  addrlen = sizeof(addr);
 1ee:	06e00793          	li	a5,110
 1f2:	f4f42e23          	sw	a5,-164(s0)
  clientfd = accept(sockfd, (struct sockaddr*)&addr, &addrlen);
 1f6:	f5c40613          	addi	a2,s0,-164
 1fa:	f6040593          	addi	a1,s0,-160
 1fe:	8526                	mv	a0,s1
 200:	00000097          	auipc	ra,0x0
 204:	608080e7          	jalr	1544(ra) # 808 <accept>
 208:	892a                	mv	s2,a0
  // write(1, "POST_ACCEPT\n", 12);
  printf("9. accept() returned %d\n", clientfd);
 20a:	85aa                	mv	a1,a0
 20c:	00001517          	auipc	a0,0x1
 210:	c6450513          	addi	a0,a0,-924 # e70 <malloc+0x2a6>
 214:	00001097          	auipc	ra,0x1
 218:	8fe080e7          	jalr	-1794(ra) # b12 <printf>
  
  if(clientfd < 0) {
 21c:	06094c63          	bltz	s2,294 <main+0x294>
    exit(1);
  }
  
  // Receive
  char buf[32];
  printf("10. Calling recv()...\n");
 220:	00001517          	auipc	a0,0x1
 224:	c8850513          	addi	a0,a0,-888 # ea8 <malloc+0x2de>
 228:	00001097          	auipc	ra,0x1
 22c:	8ea080e7          	jalr	-1814(ra) # b12 <printf>
  int n = recv(clientfd, buf, sizeof(buf), 0);
 230:	4681                	li	a3,0
 232:	02000613          	li	a2,32
 236:	f3840593          	addi	a1,s0,-200
 23a:	854a                	mv	a0,s2
 23c:	00000097          	auipc	ra,0x0
 240:	5ea080e7          	jalr	1514(ra) # 826 <recv>
 244:	89aa                	mv	s3,a0
  printf("11. recv() returned %d\n", n);
 246:	85aa                	mv	a1,a0
 248:	00001517          	auipc	a0,0x1
 24c:	c7850513          	addi	a0,a0,-904 # ec0 <malloc+0x2f6>
 250:	00001097          	auipc	ra,0x1
 254:	8c2080e7          	jalr	-1854(ra) # b12 <printf>
  if(n > 0) {
 258:	07304063          	bgtz	s3,2b8 <main+0x2b8>
    buf[n] = 0;
    printf("12. Received: %s\n", buf);
  }
  
  close(clientfd);
 25c:	854a                	mv	a0,s2
 25e:	00000097          	auipc	ra,0x0
 262:	35c080e7          	jalr	860(ra) # 5ba <close>
  close(sockfd);
 266:	8526                	mv	a0,s1
 268:	00000097          	auipc	ra,0x0
 26c:	352080e7          	jalr	850(ra) # 5ba <close>
  wait(0);
 270:	4501                	li	a0,0
 272:	00000097          	auipc	ra,0x0
 276:	328080e7          	jalr	808(ra) # 59a <wait>
  printf("=== Test Complete ===\n");
 27a:	00001517          	auipc	a0,0x1
 27e:	c7650513          	addi	a0,a0,-906 # ef0 <malloc+0x326>
 282:	00001097          	auipc	ra,0x1
 286:	890080e7          	jalr	-1904(ra) # b12 <printf>
  exit(0);
 28a:	4501                	li	a0,0
 28c:	00000097          	auipc	ra,0x0
 290:	306080e7          	jalr	774(ra) # 592 <exit>
    printf("FAIL: accept() failed\n");
 294:	00001517          	auipc	a0,0x1
 298:	bfc50513          	addi	a0,a0,-1028 # e90 <malloc+0x2c6>
 29c:	00001097          	auipc	ra,0x1
 2a0:	876080e7          	jalr	-1930(ra) # b12 <printf>
    wait(0);
 2a4:	4501                	li	a0,0
 2a6:	00000097          	auipc	ra,0x0
 2aa:	2f4080e7          	jalr	756(ra) # 59a <wait>
    exit(1);
 2ae:	4505                	li	a0,1
 2b0:	00000097          	auipc	ra,0x0
 2b4:	2e2080e7          	jalr	738(ra) # 592 <exit>
    buf[n] = 0;
 2b8:	fd098793          	addi	a5,s3,-48
 2bc:	008789b3          	add	s3,a5,s0
 2c0:	f6098423          	sb	zero,-152(s3)
    printf("12. Received: %s\n", buf);
 2c4:	f3840593          	addi	a1,s0,-200
 2c8:	00001517          	auipc	a0,0x1
 2cc:	c1050513          	addi	a0,a0,-1008 # ed8 <malloc+0x30e>
 2d0:	00001097          	auipc	ra,0x1
 2d4:	842080e7          	jalr	-1982(ra) # b12 <printf>
 2d8:	b751                	j	25c <main+0x25c>

00000000000002da <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e0:	87aa                	mv	a5,a0
 2e2:	0585                	addi	a1,a1,1
 2e4:	0785                	addi	a5,a5,1
 2e6:	fff5c703          	lbu	a4,-1(a1)
 2ea:	fee78fa3          	sb	a4,-1(a5)
 2ee:	fb75                	bnez	a4,2e2 <strcpy+0x8>
    ;
  return os;
}
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strcat>:

char*
strcat(char *s, const char *t)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 2fc:	00054783          	lbu	a5,0(a0)
 300:	c385                	beqz	a5,320 <strcat+0x2a>
 302:	87aa                	mv	a5,a0
    s++;
 304:	0785                	addi	a5,a5,1
  while(*s)
 306:	0007c703          	lbu	a4,0(a5)
 30a:	ff6d                	bnez	a4,304 <strcat+0xe>
  while((*s++ = *t++))
 30c:	0585                	addi	a1,a1,1
 30e:	0785                	addi	a5,a5,1
 310:	fff5c703          	lbu	a4,-1(a1)
 314:	fee78fa3          	sb	a4,-1(a5)
 318:	fb75                	bnez	a4,30c <strcat+0x16>
    ;
  return os;
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
  while(*s)
 320:	87aa                	mv	a5,a0
 322:	b7ed                	j	30c <strcat+0x16>

0000000000000324 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 32a:	00054783          	lbu	a5,0(a0)
 32e:	cb91                	beqz	a5,342 <strcmp+0x1e>
 330:	0005c703          	lbu	a4,0(a1)
 334:	00f71763          	bne	a4,a5,342 <strcmp+0x1e>
    p++, q++;
 338:	0505                	addi	a0,a0,1
 33a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 33c:	00054783          	lbu	a5,0(a0)
 340:	fbe5                	bnez	a5,330 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 342:	0005c503          	lbu	a0,0(a1)
}
 346:	40a7853b          	subw	a0,a5,a0
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <strlen>:

uint
strlen(const char *s)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 356:	00054783          	lbu	a5,0(a0)
 35a:	cf91                	beqz	a5,376 <strlen+0x26>
 35c:	0505                	addi	a0,a0,1
 35e:	87aa                	mv	a5,a0
 360:	4685                	li	a3,1
 362:	9e89                	subw	a3,a3,a0
 364:	00f6853b          	addw	a0,a3,a5
 368:	0785                	addi	a5,a5,1
 36a:	fff7c703          	lbu	a4,-1(a5)
 36e:	fb7d                	bnez	a4,364 <strlen+0x14>
    ;
  return n;
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret
  for(n = 0; s[n]; n++)
 376:	4501                	li	a0,0
 378:	bfe5                	j	370 <strlen+0x20>

000000000000037a <memset>:

void*
memset(void *dst, int c, uint n)
{
 37a:	1141                	addi	sp,sp,-16
 37c:	e422                	sd	s0,8(sp)
 37e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 380:	ca19                	beqz	a2,396 <memset+0x1c>
 382:	87aa                	mv	a5,a0
 384:	1602                	slli	a2,a2,0x20
 386:	9201                	srli	a2,a2,0x20
 388:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 38c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 390:	0785                	addi	a5,a5,1
 392:	fee79de3          	bne	a5,a4,38c <memset+0x12>
  }
  return dst;
}
 396:	6422                	ld	s0,8(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret

000000000000039c <strchr>:

char*
strchr(const char *s, char c)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e422                	sd	s0,8(sp)
 3a0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3a2:	00054783          	lbu	a5,0(a0)
 3a6:	cb99                	beqz	a5,3bc <strchr+0x20>
    if(*s == c)
 3a8:	00f58763          	beq	a1,a5,3b6 <strchr+0x1a>
  for(; *s; s++)
 3ac:	0505                	addi	a0,a0,1
 3ae:	00054783          	lbu	a5,0(a0)
 3b2:	fbfd                	bnez	a5,3a8 <strchr+0xc>
      return (char*)s;
  return 0;
 3b4:	4501                	li	a0,0
}
 3b6:	6422                	ld	s0,8(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret
  return 0;
 3bc:	4501                	li	a0,0
 3be:	bfe5                	j	3b6 <strchr+0x1a>

00000000000003c0 <gets>:

char*
gets(char *buf, int max)
{
 3c0:	711d                	addi	sp,sp,-96
 3c2:	ec86                	sd	ra,88(sp)
 3c4:	e8a2                	sd	s0,80(sp)
 3c6:	e4a6                	sd	s1,72(sp)
 3c8:	e0ca                	sd	s2,64(sp)
 3ca:	fc4e                	sd	s3,56(sp)
 3cc:	f852                	sd	s4,48(sp)
 3ce:	f456                	sd	s5,40(sp)
 3d0:	f05a                	sd	s6,32(sp)
 3d2:	ec5e                	sd	s7,24(sp)
 3d4:	e862                	sd	s8,16(sp)
 3d6:	1080                	addi	s0,sp,96
 3d8:	8baa                	mv	s7,a0
 3da:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3dc:	892a                	mv	s2,a0
 3de:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3e0:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3e4:	4b29                	li	s6,10
 3e6:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 3e8:	89a6                	mv	s3,s1
 3ea:	2485                	addiw	s1,s1,1
 3ec:	0344d763          	bge	s1,s4,41a <gets+0x5a>
    cc = read(0, &c, 1);
 3f0:	4605                	li	a2,1
 3f2:	85d6                	mv	a1,s5
 3f4:	4501                	li	a0,0
 3f6:	00000097          	auipc	ra,0x0
 3fa:	1b4080e7          	jalr	436(ra) # 5aa <read>
    if(cc < 1)
 3fe:	00a05e63          	blez	a0,41a <gets+0x5a>
    buf[i++] = c;
 402:	faf44783          	lbu	a5,-81(s0)
 406:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 40a:	01678763          	beq	a5,s6,418 <gets+0x58>
 40e:	0905                	addi	s2,s2,1
 410:	fd879ce3          	bne	a5,s8,3e8 <gets+0x28>
  for(i=0; i+1 < max; ){
 414:	89a6                	mv	s3,s1
 416:	a011                	j	41a <gets+0x5a>
 418:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 41a:	99de                	add	s3,s3,s7
 41c:	00098023          	sb	zero,0(s3)
  return buf;
}
 420:	855e                	mv	a0,s7
 422:	60e6                	ld	ra,88(sp)
 424:	6446                	ld	s0,80(sp)
 426:	64a6                	ld	s1,72(sp)
 428:	6906                	ld	s2,64(sp)
 42a:	79e2                	ld	s3,56(sp)
 42c:	7a42                	ld	s4,48(sp)
 42e:	7aa2                	ld	s5,40(sp)
 430:	7b02                	ld	s6,32(sp)
 432:	6be2                	ld	s7,24(sp)
 434:	6c42                	ld	s8,16(sp)
 436:	6125                	addi	sp,sp,96
 438:	8082                	ret

000000000000043a <stat>:

int
stat(const char *n, struct stat *st)
{
 43a:	1101                	addi	sp,sp,-32
 43c:	ec06                	sd	ra,24(sp)
 43e:	e822                	sd	s0,16(sp)
 440:	e426                	sd	s1,8(sp)
 442:	e04a                	sd	s2,0(sp)
 444:	1000                	addi	s0,sp,32
 446:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 448:	4581                	li	a1,0
 44a:	00000097          	auipc	ra,0x0
 44e:	188080e7          	jalr	392(ra) # 5d2 <open>
  if(fd < 0)
 452:	02054563          	bltz	a0,47c <stat+0x42>
 456:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 458:	85ca                	mv	a1,s2
 45a:	00000097          	auipc	ra,0x0
 45e:	180080e7          	jalr	384(ra) # 5da <fstat>
 462:	892a                	mv	s2,a0
  close(fd);
 464:	8526                	mv	a0,s1
 466:	00000097          	auipc	ra,0x0
 46a:	154080e7          	jalr	340(ra) # 5ba <close>
  return r;
}
 46e:	854a                	mv	a0,s2
 470:	60e2                	ld	ra,24(sp)
 472:	6442                	ld	s0,16(sp)
 474:	64a2                	ld	s1,8(sp)
 476:	6902                	ld	s2,0(sp)
 478:	6105                	addi	sp,sp,32
 47a:	8082                	ret
    return -1;
 47c:	597d                	li	s2,-1
 47e:	bfc5                	j	46e <stat+0x34>

0000000000000480 <atoi>:

int
atoi(const char *s)
{
 480:	1141                	addi	sp,sp,-16
 482:	e422                	sd	s0,8(sp)
 484:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 486:	00054703          	lbu	a4,0(a0)
 48a:	02d00793          	li	a5,45
  int neg = 1;
 48e:	4585                	li	a1,1
  if (*s == '-') {
 490:	04f70363          	beq	a4,a5,4d6 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 494:	00054703          	lbu	a4,0(a0)
 498:	fd07079b          	addiw	a5,a4,-48
 49c:	0ff7f793          	zext.b	a5,a5
 4a0:	46a5                	li	a3,9
 4a2:	02f6ed63          	bltu	a3,a5,4dc <atoi+0x5c>
  n = 0;
 4a6:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 4a8:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 4aa:	0505                	addi	a0,a0,1
 4ac:	0026979b          	slliw	a5,a3,0x2
 4b0:	9fb5                	addw	a5,a5,a3
 4b2:	0017979b          	slliw	a5,a5,0x1
 4b6:	9fb9                	addw	a5,a5,a4
 4b8:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 4bc:	00054703          	lbu	a4,0(a0)
 4c0:	fd07079b          	addiw	a5,a4,-48
 4c4:	0ff7f793          	zext.b	a5,a5
 4c8:	fef671e3          	bgeu	a2,a5,4aa <atoi+0x2a>
  return n * neg;
}
 4cc:	02d5853b          	mulw	a0,a1,a3
 4d0:	6422                	ld	s0,8(sp)
 4d2:	0141                	addi	sp,sp,16
 4d4:	8082                	ret
    s++;
 4d6:	0505                	addi	a0,a0,1
    neg = -1;
 4d8:	55fd                	li	a1,-1
 4da:	bf6d                	j	494 <atoi+0x14>
  n = 0;
 4dc:	4681                	li	a3,0
 4de:	b7fd                	j	4cc <atoi+0x4c>

00000000000004e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e422                	sd	s0,8(sp)
 4e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4e6:	02b57463          	bgeu	a0,a1,50e <memmove+0x2e>
    while(n-- > 0)
 4ea:	00c05f63          	blez	a2,508 <memmove+0x28>
 4ee:	1602                	slli	a2,a2,0x20
 4f0:	9201                	srli	a2,a2,0x20
 4f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4f8:	0585                	addi	a1,a1,1
 4fa:	0705                	addi	a4,a4,1
 4fc:	fff5c683          	lbu	a3,-1(a1)
 500:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 504:	fee79ae3          	bne	a5,a4,4f8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	addi	sp,sp,16
 50c:	8082                	ret
    dst += n;
 50e:	00c50733          	add	a4,a0,a2
    src += n;
 512:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 514:	fec05ae3          	blez	a2,508 <memmove+0x28>
 518:	fff6079b          	addiw	a5,a2,-1
 51c:	1782                	slli	a5,a5,0x20
 51e:	9381                	srli	a5,a5,0x20
 520:	fff7c793          	not	a5,a5
 524:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 526:	15fd                	addi	a1,a1,-1
 528:	177d                	addi	a4,a4,-1
 52a:	0005c683          	lbu	a3,0(a1)
 52e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 532:	fee79ae3          	bne	a5,a4,526 <memmove+0x46>
 536:	bfc9                	j	508 <memmove+0x28>

0000000000000538 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 538:	1141                	addi	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 53e:	ca05                	beqz	a2,56e <memcmp+0x36>
 540:	fff6069b          	addiw	a3,a2,-1
 544:	1682                	slli	a3,a3,0x20
 546:	9281                	srli	a3,a3,0x20
 548:	0685                	addi	a3,a3,1
 54a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 54c:	00054783          	lbu	a5,0(a0)
 550:	0005c703          	lbu	a4,0(a1)
 554:	00e79863          	bne	a5,a4,564 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 558:	0505                	addi	a0,a0,1
    p2++;
 55a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 55c:	fed518e3          	bne	a0,a3,54c <memcmp+0x14>
  }
  return 0;
 560:	4501                	li	a0,0
 562:	a019                	j	568 <memcmp+0x30>
      return *p1 - *p2;
 564:	40e7853b          	subw	a0,a5,a4
}
 568:	6422                	ld	s0,8(sp)
 56a:	0141                	addi	sp,sp,16
 56c:	8082                	ret
  return 0;
 56e:	4501                	li	a0,0
 570:	bfe5                	j	568 <memcmp+0x30>

0000000000000572 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 572:	1141                	addi	sp,sp,-16
 574:	e406                	sd	ra,8(sp)
 576:	e022                	sd	s0,0(sp)
 578:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 57a:	00000097          	auipc	ra,0x0
 57e:	f66080e7          	jalr	-154(ra) # 4e0 <memmove>
}
 582:	60a2                	ld	ra,8(sp)
 584:	6402                	ld	s0,0(sp)
 586:	0141                	addi	sp,sp,16
 588:	8082                	ret

000000000000058a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 58a:	4885                	li	a7,1
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <exit>:
.global exit
exit:
 li a7, SYS_exit
 592:	4889                	li	a7,2
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <wait>:
.global wait
wait:
 li a7, SYS_wait
 59a:	488d                	li	a7,3
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a2:	4891                	li	a7,4
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <read>:
.global read
read:
 li a7, SYS_read
 5aa:	4895                	li	a7,5
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <write>:
.global write
write:
 li a7, SYS_write
 5b2:	48c1                	li	a7,16
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <close>:
.global close
close:
 li a7, SYS_close
 5ba:	48d5                	li	a7,21
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c2:	4899                	li	a7,6
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ca:	489d                	li	a7,7
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <open>:
.global open
open:
 li a7, SYS_open
 5d2:	48bd                	li	a7,15
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5da:	48a1                	li	a7,8
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5e2:	48d1                	li	a7,20
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5ea:	48a5                	li	a7,9
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5f2:	48a9                	li	a7,10
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5fa:	48ad                	li	a7,11
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 602:	48b1                	li	a7,12
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 60a:	48b5                	li	a7,13
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 612:	48b9                	li	a7,14
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 61a:	48d9                	li	a7,22
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <dev>:
.global dev
dev:
 li a7, SYS_dev
 622:	48dd                	li	a7,23
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 62a:	48e1                	li	a7,24
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 632:	48e5                	li	a7,25
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <remove>:
.global remove
remove:
 li a7, SYS_remove
 63a:	48c5                	li	a7,17
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <trace>:
.global trace
trace:
 li a7, SYS_trace
 642:	48c9                	li	a7,18
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 64a:	48cd                	li	a7,19
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <rename>:
.global rename
rename:
 li a7, SYS_rename
 652:	48e9                	li	a7,26
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 65a:	48ed                	li	a7,27
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 662:	48f1                	li	a7,28
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 66a:	48f5                	li	a7,29
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 672:	48f9                	li	a7,30
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 67a:	48fd                	li	a7,31
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 682:	02000893          	li	a7,32
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 68c:	02100893          	li	a7,33
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 696:	02200893          	li	a7,34
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 6a0:	02300893          	li	a7,35
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 6aa:	02400893          	li	a7,36
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 6b4:	02500893          	li	a7,37
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 6be:	02600893          	li	a7,38
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 6c8:	02700893          	li	a7,39
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 6d2:	02800893          	li	a7,40
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 6dc:	02900893          	li	a7,41
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 6e6:	02a00893          	li	a7,42
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 6f0:	02b00893          	li	a7,43
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 6fa:	02c00893          	li	a7,44
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 704:	02d00893          	li	a7,45
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 70e:	02e00893          	li	a7,46
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 718:	02f00893          	li	a7,47
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 722:	03000893          	li	a7,48
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 72c:	03100893          	li	a7,49
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 736:	03200893          	li	a7,50
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 740:	03300893          	li	a7,51
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 74a:	03400893          	li	a7,52
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 754:	03500893          	li	a7,53
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 75e:	03600893          	li	a7,54
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 768:	03700893          	li	a7,55
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 772:	03800893          	li	a7,56
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 77c:	03900893          	li	a7,57
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 786:	03a00893          	li	a7,58
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <poll>:
.global poll
poll:
 li a7, SYS_poll
 790:	03b00893          	li	a7,59
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 79a:	03c00893          	li	a7,60
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 7a4:	03d00893          	li	a7,61
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 7ae:	03e00893          	li	a7,62
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <clone>:
.global clone
clone:
 li a7, SYS_clone
 7b8:	03f00893          	li	a7,63
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <futex>:
.global futex
futex:
 li a7, SYS_futex
 7c2:	04000893          	li	a7,64
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 7cc:	04100893          	li	a7,65
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <halt>:
.global halt
halt:
 li a7, SYS_halt
 7d6:	04200893          	li	a7,66
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 7e0:	04300893          	li	a7,67
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <socket>:
.global socket
socket:
 li a7, SYS_socket
 7ea:	04400893          	li	a7,68
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 7f4:	04500893          	li	a7,69
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <listen>:
.global listen
listen:
 li a7, SYS_listen
 7fe:	04600893          	li	a7,70
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <accept>:
.global accept
accept:
 li a7, SYS_accept
 808:	04700893          	li	a7,71
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <connect>:
.global connect
connect:
 li a7, SYS_connect
 812:	04800893          	li	a7,72
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <send>:
.global send
send:
 li a7, SYS_send
 81c:	04900893          	li	a7,73
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <recv>:
.global recv
recv:
 li a7, SYS_recv
 826:	04a00893          	li	a7,74
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 830:	04b00893          	li	a7,75
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 83a:	1101                	addi	sp,sp,-32
 83c:	ec06                	sd	ra,24(sp)
 83e:	e822                	sd	s0,16(sp)
 840:	1000                	addi	s0,sp,32
 842:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 846:	4605                	li	a2,1
 848:	fef40593          	addi	a1,s0,-17
 84c:	00000097          	auipc	ra,0x0
 850:	d66080e7          	jalr	-666(ra) # 5b2 <write>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6105                	addi	sp,sp,32
 85a:	8082                	ret

000000000000085c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 85c:	7139                	addi	sp,sp,-64
 85e:	fc06                	sd	ra,56(sp)
 860:	f822                	sd	s0,48(sp)
 862:	f426                	sd	s1,40(sp)
 864:	f04a                	sd	s2,32(sp)
 866:	ec4e                	sd	s3,24(sp)
 868:	0080                	addi	s0,sp,64
 86a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 86c:	c299                	beqz	a3,872 <printint+0x16>
 86e:	0805c863          	bltz	a1,8fe <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 872:	2581                	sext.w	a1,a1
  neg = 0;
 874:	4881                	li	a7,0
  }

  i = 0;
 876:	fc040993          	addi	s3,s0,-64
  neg = 0;
 87a:	86ce                	mv	a3,s3
  i = 0;
 87c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 87e:	2601                	sext.w	a2,a2
 880:	00000517          	auipc	a0,0x0
 884:	6e850513          	addi	a0,a0,1768 # f68 <digits>
 888:	883a                	mv	a6,a4
 88a:	2705                	addiw	a4,a4,1
 88c:	02c5f7bb          	remuw	a5,a1,a2
 890:	1782                	slli	a5,a5,0x20
 892:	9381                	srli	a5,a5,0x20
 894:	97aa                	add	a5,a5,a0
 896:	0007c783          	lbu	a5,0(a5)
 89a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 89e:	0005879b          	sext.w	a5,a1
 8a2:	02c5d5bb          	divuw	a1,a1,a2
 8a6:	0685                	addi	a3,a3,1
 8a8:	fec7f0e3          	bgeu	a5,a2,888 <printint+0x2c>
  if(neg)
 8ac:	00088c63          	beqz	a7,8c4 <printint+0x68>
    buf[i++] = '-';
 8b0:	fd070793          	addi	a5,a4,-48
 8b4:	00878733          	add	a4,a5,s0
 8b8:	02d00793          	li	a5,45
 8bc:	fef70823          	sb	a5,-16(a4)
 8c0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8c4:	02e05663          	blez	a4,8f0 <printint+0x94>
 8c8:	fc040913          	addi	s2,s0,-64
 8cc:	993a                	add	s2,s2,a4
 8ce:	19fd                	addi	s3,s3,-1
 8d0:	99ba                	add	s3,s3,a4
 8d2:	377d                	addiw	a4,a4,-1
 8d4:	1702                	slli	a4,a4,0x20
 8d6:	9301                	srli	a4,a4,0x20
 8d8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8dc:	fff94583          	lbu	a1,-1(s2)
 8e0:	8526                	mv	a0,s1
 8e2:	00000097          	auipc	ra,0x0
 8e6:	f58080e7          	jalr	-168(ra) # 83a <putc>
  while(--i >= 0)
 8ea:	197d                	addi	s2,s2,-1
 8ec:	ff3918e3          	bne	s2,s3,8dc <printint+0x80>
}
 8f0:	70e2                	ld	ra,56(sp)
 8f2:	7442                	ld	s0,48(sp)
 8f4:	74a2                	ld	s1,40(sp)
 8f6:	7902                	ld	s2,32(sp)
 8f8:	69e2                	ld	s3,24(sp)
 8fa:	6121                	addi	sp,sp,64
 8fc:	8082                	ret
    x = -xx;
 8fe:	40b005bb          	negw	a1,a1
    neg = 1;
 902:	4885                	li	a7,1
    x = -xx;
 904:	bf8d                	j	876 <printint+0x1a>

0000000000000906 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 906:	7119                	addi	sp,sp,-128
 908:	fc86                	sd	ra,120(sp)
 90a:	f8a2                	sd	s0,112(sp)
 90c:	f4a6                	sd	s1,104(sp)
 90e:	f0ca                	sd	s2,96(sp)
 910:	ecce                	sd	s3,88(sp)
 912:	e8d2                	sd	s4,80(sp)
 914:	e4d6                	sd	s5,72(sp)
 916:	e0da                	sd	s6,64(sp)
 918:	fc5e                	sd	s7,56(sp)
 91a:	f862                	sd	s8,48(sp)
 91c:	f466                	sd	s9,40(sp)
 91e:	f06a                	sd	s10,32(sp)
 920:	ec6e                	sd	s11,24(sp)
 922:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 924:	0005c903          	lbu	s2,0(a1)
 928:	18090f63          	beqz	s2,ac6 <vprintf+0x1c0>
 92c:	8aaa                	mv	s5,a0
 92e:	8b32                	mv	s6,a2
 930:	00158493          	addi	s1,a1,1
  state = 0;
 934:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 936:	02500a13          	li	s4,37
 93a:	4c55                	li	s8,21
 93c:	00000c97          	auipc	s9,0x0
 940:	5d4c8c93          	addi	s9,s9,1492 # f10 <malloc+0x346>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 944:	02800d93          	li	s11,40
  putc(fd, 'x');
 948:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 94a:	00000b97          	auipc	s7,0x0
 94e:	61eb8b93          	addi	s7,s7,1566 # f68 <digits>
 952:	a839                	j	970 <vprintf+0x6a>
        putc(fd, c);
 954:	85ca                	mv	a1,s2
 956:	8556                	mv	a0,s5
 958:	00000097          	auipc	ra,0x0
 95c:	ee2080e7          	jalr	-286(ra) # 83a <putc>
 960:	a019                	j	966 <vprintf+0x60>
    } else if(state == '%'){
 962:	01498d63          	beq	s3,s4,97c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 966:	0485                	addi	s1,s1,1
 968:	fff4c903          	lbu	s2,-1(s1)
 96c:	14090d63          	beqz	s2,ac6 <vprintf+0x1c0>
    if(state == 0){
 970:	fe0999e3          	bnez	s3,962 <vprintf+0x5c>
      if(c == '%'){
 974:	ff4910e3          	bne	s2,s4,954 <vprintf+0x4e>
        state = '%';
 978:	89d2                	mv	s3,s4
 97a:	b7f5                	j	966 <vprintf+0x60>
      if(c == 'd'){
 97c:	11490c63          	beq	s2,s4,a94 <vprintf+0x18e>
 980:	f9d9079b          	addiw	a5,s2,-99
 984:	0ff7f793          	zext.b	a5,a5
 988:	10fc6e63          	bltu	s8,a5,aa4 <vprintf+0x19e>
 98c:	f9d9079b          	addiw	a5,s2,-99
 990:	0ff7f713          	zext.b	a4,a5
 994:	10ec6863          	bltu	s8,a4,aa4 <vprintf+0x19e>
 998:	00271793          	slli	a5,a4,0x2
 99c:	97e6                	add	a5,a5,s9
 99e:	439c                	lw	a5,0(a5)
 9a0:	97e6                	add	a5,a5,s9
 9a2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9a4:	008b0913          	addi	s2,s6,8
 9a8:	4685                	li	a3,1
 9aa:	4629                	li	a2,10
 9ac:	000b2583          	lw	a1,0(s6)
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	eaa080e7          	jalr	-342(ra) # 85c <printint>
 9ba:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9bc:	4981                	li	s3,0
 9be:	b765                	j	966 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9c0:	008b0913          	addi	s2,s6,8
 9c4:	4681                	li	a3,0
 9c6:	4629                	li	a2,10
 9c8:	000b2583          	lw	a1,0(s6)
 9cc:	8556                	mv	a0,s5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	e8e080e7          	jalr	-370(ra) # 85c <printint>
 9d6:	8b4a                	mv	s6,s2
      state = 0;
 9d8:	4981                	li	s3,0
 9da:	b771                	j	966 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9dc:	008b0913          	addi	s2,s6,8
 9e0:	4681                	li	a3,0
 9e2:	866a                	mv	a2,s10
 9e4:	000b2583          	lw	a1,0(s6)
 9e8:	8556                	mv	a0,s5
 9ea:	00000097          	auipc	ra,0x0
 9ee:	e72080e7          	jalr	-398(ra) # 85c <printint>
 9f2:	8b4a                	mv	s6,s2
      state = 0;
 9f4:	4981                	li	s3,0
 9f6:	bf85                	j	966 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9f8:	008b0793          	addi	a5,s6,8
 9fc:	f8f43423          	sd	a5,-120(s0)
 a00:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a04:	03000593          	li	a1,48
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	e30080e7          	jalr	-464(ra) # 83a <putc>
  putc(fd, 'x');
 a12:	07800593          	li	a1,120
 a16:	8556                	mv	a0,s5
 a18:	00000097          	auipc	ra,0x0
 a1c:	e22080e7          	jalr	-478(ra) # 83a <putc>
 a20:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a22:	03c9d793          	srli	a5,s3,0x3c
 a26:	97de                	add	a5,a5,s7
 a28:	0007c583          	lbu	a1,0(a5)
 a2c:	8556                	mv	a0,s5
 a2e:	00000097          	auipc	ra,0x0
 a32:	e0c080e7          	jalr	-500(ra) # 83a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a36:	0992                	slli	s3,s3,0x4
 a38:	397d                	addiw	s2,s2,-1
 a3a:	fe0914e3          	bnez	s2,a22 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 a3e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a42:	4981                	li	s3,0
 a44:	b70d                	j	966 <vprintf+0x60>
        s = va_arg(ap, char*);
 a46:	008b0913          	addi	s2,s6,8
 a4a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 a4e:	02098163          	beqz	s3,a70 <vprintf+0x16a>
        while(*s != 0){
 a52:	0009c583          	lbu	a1,0(s3)
 a56:	c5ad                	beqz	a1,ac0 <vprintf+0x1ba>
          putc(fd, *s);
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	de0080e7          	jalr	-544(ra) # 83a <putc>
          s++;
 a62:	0985                	addi	s3,s3,1
        while(*s != 0){
 a64:	0009c583          	lbu	a1,0(s3)
 a68:	f9e5                	bnez	a1,a58 <vprintf+0x152>
        s = va_arg(ap, char*);
 a6a:	8b4a                	mv	s6,s2
      state = 0;
 a6c:	4981                	li	s3,0
 a6e:	bde5                	j	966 <vprintf+0x60>
          s = "(null)";
 a70:	00000997          	auipc	s3,0x0
 a74:	49898993          	addi	s3,s3,1176 # f08 <malloc+0x33e>
        while(*s != 0){
 a78:	85ee                	mv	a1,s11
 a7a:	bff9                	j	a58 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 a7c:	008b0913          	addi	s2,s6,8
 a80:	000b4583          	lbu	a1,0(s6)
 a84:	8556                	mv	a0,s5
 a86:	00000097          	auipc	ra,0x0
 a8a:	db4080e7          	jalr	-588(ra) # 83a <putc>
 a8e:	8b4a                	mv	s6,s2
      state = 0;
 a90:	4981                	li	s3,0
 a92:	bdd1                	j	966 <vprintf+0x60>
        putc(fd, c);
 a94:	85d2                	mv	a1,s4
 a96:	8556                	mv	a0,s5
 a98:	00000097          	auipc	ra,0x0
 a9c:	da2080e7          	jalr	-606(ra) # 83a <putc>
      state = 0;
 aa0:	4981                	li	s3,0
 aa2:	b5d1                	j	966 <vprintf+0x60>
        putc(fd, '%');
 aa4:	85d2                	mv	a1,s4
 aa6:	8556                	mv	a0,s5
 aa8:	00000097          	auipc	ra,0x0
 aac:	d92080e7          	jalr	-622(ra) # 83a <putc>
        putc(fd, c);
 ab0:	85ca                	mv	a1,s2
 ab2:	8556                	mv	a0,s5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	d86080e7          	jalr	-634(ra) # 83a <putc>
      state = 0;
 abc:	4981                	li	s3,0
 abe:	b565                	j	966 <vprintf+0x60>
        s = va_arg(ap, char*);
 ac0:	8b4a                	mv	s6,s2
      state = 0;
 ac2:	4981                	li	s3,0
 ac4:	b54d                	j	966 <vprintf+0x60>
    }
  }
}
 ac6:	70e6                	ld	ra,120(sp)
 ac8:	7446                	ld	s0,112(sp)
 aca:	74a6                	ld	s1,104(sp)
 acc:	7906                	ld	s2,96(sp)
 ace:	69e6                	ld	s3,88(sp)
 ad0:	6a46                	ld	s4,80(sp)
 ad2:	6aa6                	ld	s5,72(sp)
 ad4:	6b06                	ld	s6,64(sp)
 ad6:	7be2                	ld	s7,56(sp)
 ad8:	7c42                	ld	s8,48(sp)
 ada:	7ca2                	ld	s9,40(sp)
 adc:	7d02                	ld	s10,32(sp)
 ade:	6de2                	ld	s11,24(sp)
 ae0:	6109                	addi	sp,sp,128
 ae2:	8082                	ret

0000000000000ae4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ae4:	715d                	addi	sp,sp,-80
 ae6:	ec06                	sd	ra,24(sp)
 ae8:	e822                	sd	s0,16(sp)
 aea:	1000                	addi	s0,sp,32
 aec:	e010                	sd	a2,0(s0)
 aee:	e414                	sd	a3,8(s0)
 af0:	e818                	sd	a4,16(s0)
 af2:	ec1c                	sd	a5,24(s0)
 af4:	03043023          	sd	a6,32(s0)
 af8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 afc:	8622                	mv	a2,s0
 afe:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b02:	00000097          	auipc	ra,0x0
 b06:	e04080e7          	jalr	-508(ra) # 906 <vprintf>
}
 b0a:	60e2                	ld	ra,24(sp)
 b0c:	6442                	ld	s0,16(sp)
 b0e:	6161                	addi	sp,sp,80
 b10:	8082                	ret

0000000000000b12 <printf>:

void
printf(const char *fmt, ...)
{
 b12:	711d                	addi	sp,sp,-96
 b14:	ec06                	sd	ra,24(sp)
 b16:	e822                	sd	s0,16(sp)
 b18:	1000                	addi	s0,sp,32
 b1a:	e40c                	sd	a1,8(s0)
 b1c:	e810                	sd	a2,16(s0)
 b1e:	ec14                	sd	a3,24(s0)
 b20:	f018                	sd	a4,32(s0)
 b22:	f41c                	sd	a5,40(s0)
 b24:	03043823          	sd	a6,48(s0)
 b28:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b2c:	00840613          	addi	a2,s0,8
 b30:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b34:	85aa                	mv	a1,a0
 b36:	4505                	li	a0,1
 b38:	00000097          	auipc	ra,0x0
 b3c:	dce080e7          	jalr	-562(ra) # 906 <vprintf>
}
 b40:	60e2                	ld	ra,24(sp)
 b42:	6442                	ld	s0,16(sp)
 b44:	6125                	addi	sp,sp,96
 b46:	8082                	ret

0000000000000b48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b48:	1141                	addi	sp,sp,-16
 b4a:	e422                	sd	s0,8(sp)
 b4c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b4e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b52:	00000797          	auipc	a5,0x0
 b56:	42e7b783          	ld	a5,1070(a5) # f80 <freep>
 b5a:	a02d                	j	b84 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b5c:	4618                	lw	a4,8(a2)
 b5e:	9f2d                	addw	a4,a4,a1
 b60:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b64:	6398                	ld	a4,0(a5)
 b66:	6310                	ld	a2,0(a4)
 b68:	a83d                	j	ba6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b6a:	ff852703          	lw	a4,-8(a0)
 b6e:	9f31                	addw	a4,a4,a2
 b70:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b72:	ff053683          	ld	a3,-16(a0)
 b76:	a091                	j	bba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b78:	6398                	ld	a4,0(a5)
 b7a:	00e7e463          	bltu	a5,a4,b82 <free+0x3a>
 b7e:	00e6ea63          	bltu	a3,a4,b92 <free+0x4a>
{
 b82:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b84:	fed7fae3          	bgeu	a5,a3,b78 <free+0x30>
 b88:	6398                	ld	a4,0(a5)
 b8a:	00e6e463          	bltu	a3,a4,b92 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b8e:	fee7eae3          	bltu	a5,a4,b82 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b92:	ff852583          	lw	a1,-8(a0)
 b96:	6390                	ld	a2,0(a5)
 b98:	02059813          	slli	a6,a1,0x20
 b9c:	01c85713          	srli	a4,a6,0x1c
 ba0:	9736                	add	a4,a4,a3
 ba2:	fae60de3          	beq	a2,a4,b5c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ba6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 baa:	4790                	lw	a2,8(a5)
 bac:	02061593          	slli	a1,a2,0x20
 bb0:	01c5d713          	srli	a4,a1,0x1c
 bb4:	973e                	add	a4,a4,a5
 bb6:	fae68ae3          	beq	a3,a4,b6a <free+0x22>
    p->s.ptr = bp->s.ptr;
 bba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bbc:	00000717          	auipc	a4,0x0
 bc0:	3cf73223          	sd	a5,964(a4) # f80 <freep>
}
 bc4:	6422                	ld	s0,8(sp)
 bc6:	0141                	addi	sp,sp,16
 bc8:	8082                	ret

0000000000000bca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bca:	7139                	addi	sp,sp,-64
 bcc:	fc06                	sd	ra,56(sp)
 bce:	f822                	sd	s0,48(sp)
 bd0:	f426                	sd	s1,40(sp)
 bd2:	f04a                	sd	s2,32(sp)
 bd4:	ec4e                	sd	s3,24(sp)
 bd6:	e852                	sd	s4,16(sp)
 bd8:	e456                	sd	s5,8(sp)
 bda:	e05a                	sd	s6,0(sp)
 bdc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bde:	02051493          	slli	s1,a0,0x20
 be2:	9081                	srli	s1,s1,0x20
 be4:	04bd                	addi	s1,s1,15
 be6:	8091                	srli	s1,s1,0x4
 be8:	00148a1b          	addiw	s4,s1,1
 bec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 bee:	00000517          	auipc	a0,0x0
 bf2:	39253503          	ld	a0,914(a0) # f80 <freep>
 bf6:	c515                	beqz	a0,c22 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bf8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bfa:	4798                	lw	a4,8(a5)
 bfc:	04977163          	bgeu	a4,s1,c3e <malloc+0x74>
 c00:	89d2                	mv	s3,s4
 c02:	000a071b          	sext.w	a4,s4
 c06:	6685                	lui	a3,0x1
 c08:	00d77363          	bgeu	a4,a3,c0e <malloc+0x44>
 c0c:	6985                	lui	s3,0x1
 c0e:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 c12:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c16:	00000917          	auipc	s2,0x0
 c1a:	36a90913          	addi	s2,s2,874 # f80 <freep>
  if(p == (char*)-1)
 c1e:	5afd                	li	s5,-1
 c20:	a8a5                	j	c98 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 c22:	00000797          	auipc	a5,0x0
 c26:	35e78793          	addi	a5,a5,862 # f80 <freep>
 c2a:	00000717          	auipc	a4,0x0
 c2e:	35e70713          	addi	a4,a4,862 # f88 <base>
 c32:	e398                	sd	a4,0(a5)
 c34:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 c36:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c3a:	87ba                	mv	a5,a4
 c3c:	b7d1                	j	c00 <malloc+0x36>
      if(p->s.size == nunits)
 c3e:	02e48c63          	beq	s1,a4,c76 <malloc+0xac>
        p->s.size -= nunits;
 c42:	4147073b          	subw	a4,a4,s4
 c46:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c48:	02071693          	slli	a3,a4,0x20
 c4c:	01c6d713          	srli	a4,a3,0x1c
 c50:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c52:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 c56:	00000717          	auipc	a4,0x0
 c5a:	32a73523          	sd	a0,810(a4) # f80 <freep>
      return (void*)(p + 1);
 c5e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c62:	70e2                	ld	ra,56(sp)
 c64:	7442                	ld	s0,48(sp)
 c66:	74a2                	ld	s1,40(sp)
 c68:	7902                	ld	s2,32(sp)
 c6a:	69e2                	ld	s3,24(sp)
 c6c:	6a42                	ld	s4,16(sp)
 c6e:	6aa2                	ld	s5,8(sp)
 c70:	6b02                	ld	s6,0(sp)
 c72:	6121                	addi	sp,sp,64
 c74:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c76:	6398                	ld	a4,0(a5)
 c78:	e118                	sd	a4,0(a0)
 c7a:	bff1                	j	c56 <malloc+0x8c>
  hp->s.size = nu;
 c7c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c80:	0541                	addi	a0,a0,16
 c82:	00000097          	auipc	ra,0x0
 c86:	ec6080e7          	jalr	-314(ra) # b48 <free>
  return freep;
 c8a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c8e:	d971                	beqz	a0,c62 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c90:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c92:	4798                	lw	a4,8(a5)
 c94:	fa9775e3          	bgeu	a4,s1,c3e <malloc+0x74>
    if(p == freep)
 c98:	00093703          	ld	a4,0(s2)
 c9c:	853e                	mv	a0,a5
 c9e:	fef719e3          	bne	a4,a5,c90 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 ca2:	854e                	mv	a0,s3
 ca4:	00000097          	auipc	ra,0x0
 ca8:	95e080e7          	jalr	-1698(ra) # 602 <sbrk>
  if(p == (char*)-1)
 cac:	fd5518e3          	bne	a0,s5,c7c <malloc+0xb2>
        return 0;
 cb0:	4501                	li	a0,0
 cb2:	bf45                	j	c62 <malloc+0x98>
