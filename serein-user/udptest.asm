
serein-user/_udptest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <server_process>:
// Tests message boundaries and connectionless-style (via connect) logic

#include "kernel/include/types.h"
#include "serein-user/user.h"

void server_process(void) {
   0:	7155                	addi	sp,sp,-208
   2:	e586                	sd	ra,200(sp)
   4:	e1a2                	sd	s0,192(sp)
   6:	fd26                	sd	s1,184(sp)
   8:	f94a                	sd	s2,176(sp)
   a:	0980                	addi	s0,sp,208
  int sockfd;
  struct sockaddr_un addr;
  char buf[64];
  int n;
  
  printf("[SERVER] Creating DGRAM socket...\n");
   c:	00001517          	auipc	a0,0x1
  10:	cc450513          	addi	a0,a0,-828 # cd0 <malloc+0xec>
  14:	00001097          	auipc	ra,0x1
  18:	b18080e7          	jalr	-1256(ra) # b2c <printf>
  sockfd = socket(AF_UNIX, SOCK_DGRAM, 0);
  1c:	4601                	li	a2,0
  1e:	4589                	li	a1,2
  20:	4505                	li	a0,1
  22:	00000097          	auipc	ra,0x0
  26:	7e2080e7          	jalr	2018(ra) # 804 <socket>
  if(sockfd < 0){
  2a:	0e054163          	bltz	a0,10c <server_process+0x10c>
  2e:	84aa                	mv	s1,a0
    printf("[SERVER] socket() failed\n");
    exit(1);
  }
  
  addr.family = AF_UNIX;
  30:	4785                	li	a5,1
  32:	f6f41823          	sh	a5,-144(s0)
  strcpy(addr.path, "/tmp/udp.sock");
  36:	00001597          	auipc	a1,0x1
  3a:	ce258593          	addi	a1,a1,-798 # d18 <malloc+0x134>
  3e:	f7240513          	addi	a0,s0,-142
  42:	00000097          	auipc	ra,0x0
  46:	2b2080e7          	jalr	690(ra) # 2f4 <strcpy>
  
  printf("[SERVER] Binding to /tmp/udp.sock...\n");
  4a:	00001517          	auipc	a0,0x1
  4e:	cde50513          	addi	a0,a0,-802 # d28 <malloc+0x144>
  52:	00001097          	auipc	ra,0x1
  56:	ada080e7          	jalr	-1318(ra) # b2c <printf>
  if(bind(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
  5a:	06e00613          	li	a2,110
  5e:	f7040593          	addi	a1,s0,-144
  62:	8526                	mv	a0,s1
  64:	00000097          	auipc	ra,0x0
  68:	7aa080e7          	jalr	1962(ra) # 80e <bind>
  6c:	0a054d63          	bltz	a0,126 <server_process+0x126>
    printf("[SERVER] bind() failed\n");
    exit(1);
  }
  
  // Note: UDP server does NOT listen() or accept()
  printf("[SERVER] Waiting for packets...\n");
  70:	00001517          	auipc	a0,0x1
  74:	cf850513          	addi	a0,a0,-776 # d68 <malloc+0x184>
  78:	00001097          	auipc	ra,0x1
  7c:	ab4080e7          	jalr	-1356(ra) # b2c <printf>
  
  // Packet 1
  memset(buf, 0, sizeof(buf));
  80:	04000613          	li	a2,64
  84:	4581                	li	a1,0
  86:	f3040913          	addi	s2,s0,-208
  8a:	854a                	mv	a0,s2
  8c:	00000097          	auipc	ra,0x0
  90:	308080e7          	jalr	776(ra) # 394 <memset>
  n = recv(sockfd, buf, sizeof(buf), 0);
  94:	4681                	li	a3,0
  96:	04000613          	li	a2,64
  9a:	85ca                	mv	a1,s2
  9c:	8526                	mv	a0,s1
  9e:	00000097          	auipc	ra,0x0
  a2:	7a2080e7          	jalr	1954(ra) # 840 <recv>
  a6:	85aa                	mv	a1,a0
  if(n > 0){
  a8:	08a05c63          	blez	a0,140 <server_process+0x140>
    printf("[SERVER] Packet 1 received (%d bytes): %s\n", n, buf);
  ac:	864a                	mv	a2,s2
  ae:	00001517          	auipc	a0,0x1
  b2:	ce250513          	addi	a0,a0,-798 # d90 <malloc+0x1ac>
  b6:	00001097          	auipc	ra,0x1
  ba:	a76080e7          	jalr	-1418(ra) # b2c <printf>
  } else {
    printf("[SERVER] Recv failed\n");
  }

  // Packet 2
  memset(buf, 0, sizeof(buf));
  be:	04000613          	li	a2,64
  c2:	4581                	li	a1,0
  c4:	f3040913          	addi	s2,s0,-208
  c8:	854a                	mv	a0,s2
  ca:	00000097          	auipc	ra,0x0
  ce:	2ca080e7          	jalr	714(ra) # 394 <memset>
  n = recv(sockfd, buf, sizeof(buf), 0);
  d2:	4681                	li	a3,0
  d4:	04000613          	li	a2,64
  d8:	85ca                	mv	a1,s2
  da:	8526                	mv	a0,s1
  dc:	00000097          	auipc	ra,0x0
  e0:	764080e7          	jalr	1892(ra) # 840 <recv>
  if(n > 0){
  e4:	06a04763          	bgtz	a0,152 <server_process+0x152>
    printf("[SERVER] Packet 2 received (%d bytes): %s\n", n, buf);
  }
  
  close(sockfd);
  e8:	8526                	mv	a0,s1
  ea:	00000097          	auipc	ra,0x0
  ee:	4ea080e7          	jalr	1258(ra) # 5d4 <close>
  printf("[SERVER] Done\n");
  f2:	00001517          	auipc	a0,0x1
  f6:	d1650513          	addi	a0,a0,-746 # e08 <malloc+0x224>
  fa:	00001097          	auipc	ra,0x1
  fe:	a32080e7          	jalr	-1486(ra) # b2c <printf>
  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	4a8080e7          	jalr	1192(ra) # 5ac <exit>
    printf("[SERVER] socket() failed\n");
 10c:	00001517          	auipc	a0,0x1
 110:	bec50513          	addi	a0,a0,-1044 # cf8 <malloc+0x114>
 114:	00001097          	auipc	ra,0x1
 118:	a18080e7          	jalr	-1512(ra) # b2c <printf>
    exit(1);
 11c:	4505                	li	a0,1
 11e:	00000097          	auipc	ra,0x0
 122:	48e080e7          	jalr	1166(ra) # 5ac <exit>
    printf("[SERVER] bind() failed\n");
 126:	00001517          	auipc	a0,0x1
 12a:	c2a50513          	addi	a0,a0,-982 # d50 <malloc+0x16c>
 12e:	00001097          	auipc	ra,0x1
 132:	9fe080e7          	jalr	-1538(ra) # b2c <printf>
    exit(1);
 136:	4505                	li	a0,1
 138:	00000097          	auipc	ra,0x0
 13c:	474080e7          	jalr	1140(ra) # 5ac <exit>
    printf("[SERVER] Recv failed\n");
 140:	00001517          	auipc	a0,0x1
 144:	c8050513          	addi	a0,a0,-896 # dc0 <malloc+0x1dc>
 148:	00001097          	auipc	ra,0x1
 14c:	9e4080e7          	jalr	-1564(ra) # b2c <printf>
 150:	b7bd                	j	be <server_process+0xbe>
    printf("[SERVER] Packet 2 received (%d bytes): %s\n", n, buf);
 152:	864a                	mv	a2,s2
 154:	85aa                	mv	a1,a0
 156:	00001517          	auipc	a0,0x1
 15a:	c8250513          	addi	a0,a0,-894 # dd8 <malloc+0x1f4>
 15e:	00001097          	auipc	ra,0x1
 162:	9ce080e7          	jalr	-1586(ra) # b2c <printf>
 166:	b749                	j	e8 <server_process+0xe8>

0000000000000168 <client_process>:
}

void client_process(void) {
 168:	7175                	addi	sp,sp,-144
 16a:	e506                	sd	ra,136(sp)
 16c:	e122                	sd	s0,128(sp)
 16e:	fca6                	sd	s1,120(sp)
 170:	0900                	addi	s0,sp,144
  int sockfd;
  struct sockaddr_un addr;
  
  sleep(5); // Wait for server to bind
 172:	4515                	li	a0,5
 174:	00000097          	auipc	ra,0x0
 178:	4b0080e7          	jalr	1200(ra) # 624 <sleep>
  
  printf("[CLIENT] Creating DGRAM socket...\n");
 17c:	00001517          	auipc	a0,0x1
 180:	c9c50513          	addi	a0,a0,-868 # e18 <malloc+0x234>
 184:	00001097          	auipc	ra,0x1
 188:	9a8080e7          	jalr	-1624(ra) # b2c <printf>
  sockfd = socket(AF_UNIX, SOCK_DGRAM, 0);
 18c:	4601                	li	a2,0
 18e:	4589                	li	a1,2
 190:	4505                	li	a0,1
 192:	00000097          	auipc	ra,0x0
 196:	672080e7          	jalr	1650(ra) # 804 <socket>
  if(sockfd < 0){
 19a:	0c054863          	bltz	a0,26a <client_process+0x102>
 19e:	84aa                	mv	s1,a0
    printf("[CLIENT] socket() failed\n");
    exit(1);
  }
  
  addr.family = AF_UNIX;
 1a0:	4785                	li	a5,1
 1a2:	f6f41823          	sh	a5,-144(s0)
  strcpy(addr.path, "/tmp/udp.sock");
 1a6:	00001597          	auipc	a1,0x1
 1aa:	b7258593          	addi	a1,a1,-1166 # d18 <malloc+0x134>
 1ae:	f7240513          	addi	a0,s0,-142
 1b2:	00000097          	auipc	ra,0x0
 1b6:	142080e7          	jalr	322(ra) # 2f4 <strcpy>
  
  // In our simple impl, we use connect() to set the destination
  printf("[CLIENT] Connecting to /tmp/udp.sock...\n");
 1ba:	00001517          	auipc	a0,0x1
 1be:	ca650513          	addi	a0,a0,-858 # e60 <malloc+0x27c>
 1c2:	00001097          	auipc	ra,0x1
 1c6:	96a080e7          	jalr	-1686(ra) # b2c <printf>
  if(connect(sockfd, (struct sockaddr*)&addr, sizeof(addr)) < 0){
 1ca:	06e00613          	li	a2,110
 1ce:	f7040593          	addi	a1,s0,-144
 1d2:	8526                	mv	a0,s1
 1d4:	00000097          	auipc	ra,0x0
 1d8:	658080e7          	jalr	1624(ra) # 82c <connect>
 1dc:	0a054463          	bltz	a0,284 <client_process+0x11c>
    printf("[CLIENT] connect() failed\n");
    exit(1);
  }
  
  printf("[CLIENT] Sending Packet 1...\n");
 1e0:	00001517          	auipc	a0,0x1
 1e4:	cd050513          	addi	a0,a0,-816 # eb0 <malloc+0x2cc>
 1e8:	00001097          	auipc	ra,0x1
 1ec:	944080e7          	jalr	-1724(ra) # b2c <printf>
  send(sockfd, "Hello", 5, 0);
 1f0:	4681                	li	a3,0
 1f2:	4615                	li	a2,5
 1f4:	00001597          	auipc	a1,0x1
 1f8:	cdc58593          	addi	a1,a1,-804 # ed0 <malloc+0x2ec>
 1fc:	8526                	mv	a0,s1
 1fe:	00000097          	auipc	ra,0x0
 202:	638080e7          	jalr	1592(ra) # 836 <send>
  
  printf("[CLIENT] Sending Packet 2...\n");
 206:	00001517          	auipc	a0,0x1
 20a:	cd250513          	addi	a0,a0,-814 # ed8 <malloc+0x2f4>
 20e:	00001097          	auipc	ra,0x1
 212:	91e080e7          	jalr	-1762(ra) # b2c <printf>
  send(sockfd, "World", 5, 0);
 216:	4681                	li	a3,0
 218:	4615                	li	a2,5
 21a:	00001597          	auipc	a1,0x1
 21e:	cde58593          	addi	a1,a1,-802 # ef8 <malloc+0x314>
 222:	8526                	mv	a0,s1
 224:	00000097          	auipc	ra,0x0
 228:	612080e7          	jalr	1554(ra) # 836 <send>
  
  close(sockfd);
 22c:	8526                	mv	a0,s1
 22e:	00000097          	auipc	ra,0x0
 232:	3a6080e7          	jalr	934(ra) # 5d4 <close>
  printf("[CLIENT] Done\n");
 236:	00001517          	auipc	a0,0x1
 23a:	cca50513          	addi	a0,a0,-822 # f00 <malloc+0x31c>
 23e:	00001097          	auipc	ra,0x1
 242:	8ee080e7          	jalr	-1810(ra) # b2c <printf>
  close(sockfd);
 246:	8526                	mv	a0,s1
 248:	00000097          	auipc	ra,0x0
 24c:	38c080e7          	jalr	908(ra) # 5d4 <close>
  printf("[CLIENT] Done\n");
 250:	00001517          	auipc	a0,0x1
 254:	cb050513          	addi	a0,a0,-848 # f00 <malloc+0x31c>
 258:	00001097          	auipc	ra,0x1
 25c:	8d4080e7          	jalr	-1836(ra) # b2c <printf>
  // return instead of exit so parent can wait for server
  return;
}
 260:	60aa                	ld	ra,136(sp)
 262:	640a                	ld	s0,128(sp)
 264:	74e6                	ld	s1,120(sp)
 266:	6149                	addi	sp,sp,144
 268:	8082                	ret
    printf("[CLIENT] socket() failed\n");
 26a:	00001517          	auipc	a0,0x1
 26e:	bd650513          	addi	a0,a0,-1066 # e40 <malloc+0x25c>
 272:	00001097          	auipc	ra,0x1
 276:	8ba080e7          	jalr	-1862(ra) # b2c <printf>
    exit(1);
 27a:	4505                	li	a0,1
 27c:	00000097          	auipc	ra,0x0
 280:	330080e7          	jalr	816(ra) # 5ac <exit>
    printf("[CLIENT] connect() failed\n");
 284:	00001517          	auipc	a0,0x1
 288:	c0c50513          	addi	a0,a0,-1012 # e90 <malloc+0x2ac>
 28c:	00001097          	auipc	ra,0x1
 290:	8a0080e7          	jalr	-1888(ra) # b2c <printf>
    exit(1);
 294:	4505                	li	a0,1
 296:	00000097          	auipc	ra,0x0
 29a:	316080e7          	jalr	790(ra) # 5ac <exit>

000000000000029e <main>:

int main(int argc, char *argv[]) {
 29e:	1141                	addi	sp,sp,-16
 2a0:	e406                	sd	ra,8(sp)
 2a2:	e022                	sd	s0,0(sp)
 2a4:	0800                	addi	s0,sp,16
  printf("=== UDP/DGRAM Socket Test ===\n\n");
 2a6:	00001517          	auipc	a0,0x1
 2aa:	c6a50513          	addi	a0,a0,-918 # f10 <malloc+0x32c>
 2ae:	00001097          	auipc	ra,0x1
 2b2:	87e080e7          	jalr	-1922(ra) # b2c <printf>
  
  int pid = fork();
 2b6:	00000097          	auipc	ra,0x0
 2ba:	2ee080e7          	jalr	750(ra) # 5a4 <fork>
  if(pid == 0){
 2be:	e509                	bnez	a0,2c8 <main+0x2a>
    server_process();
 2c0:	00000097          	auipc	ra,0x0
 2c4:	d40080e7          	jalr	-704(ra) # 0 <server_process>
  } else {
    client_process();
 2c8:	00000097          	auipc	ra,0x0
 2cc:	ea0080e7          	jalr	-352(ra) # 168 <client_process>
  }
  
  wait(0);
 2d0:	4501                	li	a0,0
 2d2:	00000097          	auipc	ra,0x0
 2d6:	2e2080e7          	jalr	738(ra) # 5b4 <wait>
  printf("\n=== UDP Test Complete ===\n");
 2da:	00001517          	auipc	a0,0x1
 2de:	c5650513          	addi	a0,a0,-938 # f30 <malloc+0x34c>
 2e2:	00001097          	auipc	ra,0x1
 2e6:	84a080e7          	jalr	-1974(ra) # b2c <printf>
  exit(0);
 2ea:	4501                	li	a0,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	2c0080e7          	jalr	704(ra) # 5ac <exit>

00000000000002f4 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2fa:	87aa                	mv	a5,a0
 2fc:	0585                	addi	a1,a1,1
 2fe:	0785                	addi	a5,a5,1
 300:	fff5c703          	lbu	a4,-1(a1)
 304:	fee78fa3          	sb	a4,-1(a5)
 308:	fb75                	bnez	a4,2fc <strcpy+0x8>
    ;
  return os;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <strcat>:

char*
strcat(char *s, const char *t)
{
 310:	1141                	addi	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 316:	00054783          	lbu	a5,0(a0)
 31a:	c385                	beqz	a5,33a <strcat+0x2a>
 31c:	87aa                	mv	a5,a0
    s++;
 31e:	0785                	addi	a5,a5,1
  while(*s)
 320:	0007c703          	lbu	a4,0(a5)
 324:	ff6d                	bnez	a4,31e <strcat+0xe>
  while((*s++ = *t++))
 326:	0585                	addi	a1,a1,1
 328:	0785                	addi	a5,a5,1
 32a:	fff5c703          	lbu	a4,-1(a1)
 32e:	fee78fa3          	sb	a4,-1(a5)
 332:	fb75                	bnez	a4,326 <strcat+0x16>
    ;
  return os;
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  while(*s)
 33a:	87aa                	mv	a5,a0
 33c:	b7ed                	j	326 <strcat+0x16>

000000000000033e <strcmp>:


int
strcmp(const char *p, const char *q)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 344:	00054783          	lbu	a5,0(a0)
 348:	cb91                	beqz	a5,35c <strcmp+0x1e>
 34a:	0005c703          	lbu	a4,0(a1)
 34e:	00f71763          	bne	a4,a5,35c <strcmp+0x1e>
    p++, q++;
 352:	0505                	addi	a0,a0,1
 354:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 356:	00054783          	lbu	a5,0(a0)
 35a:	fbe5                	bnez	a5,34a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 35c:	0005c503          	lbu	a0,0(a1)
}
 360:	40a7853b          	subw	a0,a5,a0
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret

000000000000036a <strlen>:

uint
strlen(const char *s)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 370:	00054783          	lbu	a5,0(a0)
 374:	cf91                	beqz	a5,390 <strlen+0x26>
 376:	0505                	addi	a0,a0,1
 378:	87aa                	mv	a5,a0
 37a:	4685                	li	a3,1
 37c:	9e89                	subw	a3,a3,a0
 37e:	00f6853b          	addw	a0,a3,a5
 382:	0785                	addi	a5,a5,1
 384:	fff7c703          	lbu	a4,-1(a5)
 388:	fb7d                	bnez	a4,37e <strlen+0x14>
    ;
  return n;
}
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret
  for(n = 0; s[n]; n++)
 390:	4501                	li	a0,0
 392:	bfe5                	j	38a <strlen+0x20>

0000000000000394 <memset>:

void*
memset(void *dst, int c, uint n)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 39a:	ca19                	beqz	a2,3b0 <memset+0x1c>
 39c:	87aa                	mv	a5,a0
 39e:	1602                	slli	a2,a2,0x20
 3a0:	9201                	srli	a2,a2,0x20
 3a2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3aa:	0785                	addi	a5,a5,1
 3ac:	fee79de3          	bne	a5,a4,3a6 <memset+0x12>
  }
  return dst;
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <strchr>:

char*
strchr(const char *s, char c)
{
 3b6:	1141                	addi	sp,sp,-16
 3b8:	e422                	sd	s0,8(sp)
 3ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3bc:	00054783          	lbu	a5,0(a0)
 3c0:	cb99                	beqz	a5,3d6 <strchr+0x20>
    if(*s == c)
 3c2:	00f58763          	beq	a1,a5,3d0 <strchr+0x1a>
  for(; *s; s++)
 3c6:	0505                	addi	a0,a0,1
 3c8:	00054783          	lbu	a5,0(a0)
 3cc:	fbfd                	bnez	a5,3c2 <strchr+0xc>
      return (char*)s;
  return 0;
 3ce:	4501                	li	a0,0
}
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret
  return 0;
 3d6:	4501                	li	a0,0
 3d8:	bfe5                	j	3d0 <strchr+0x1a>

00000000000003da <gets>:

char*
gets(char *buf, int max)
{
 3da:	711d                	addi	sp,sp,-96
 3dc:	ec86                	sd	ra,88(sp)
 3de:	e8a2                	sd	s0,80(sp)
 3e0:	e4a6                	sd	s1,72(sp)
 3e2:	e0ca                	sd	s2,64(sp)
 3e4:	fc4e                	sd	s3,56(sp)
 3e6:	f852                	sd	s4,48(sp)
 3e8:	f456                	sd	s5,40(sp)
 3ea:	f05a                	sd	s6,32(sp)
 3ec:	ec5e                	sd	s7,24(sp)
 3ee:	e862                	sd	s8,16(sp)
 3f0:	1080                	addi	s0,sp,96
 3f2:	8baa                	mv	s7,a0
 3f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f6:	892a                	mv	s2,a0
 3f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3fa:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3fe:	4b29                	li	s6,10
 400:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 402:	89a6                	mv	s3,s1
 404:	2485                	addiw	s1,s1,1
 406:	0344d763          	bge	s1,s4,434 <gets+0x5a>
    cc = read(0, &c, 1);
 40a:	4605                	li	a2,1
 40c:	85d6                	mv	a1,s5
 40e:	4501                	li	a0,0
 410:	00000097          	auipc	ra,0x0
 414:	1b4080e7          	jalr	436(ra) # 5c4 <read>
    if(cc < 1)
 418:	00a05e63          	blez	a0,434 <gets+0x5a>
    buf[i++] = c;
 41c:	faf44783          	lbu	a5,-81(s0)
 420:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 424:	01678763          	beq	a5,s6,432 <gets+0x58>
 428:	0905                	addi	s2,s2,1
 42a:	fd879ce3          	bne	a5,s8,402 <gets+0x28>
  for(i=0; i+1 < max; ){
 42e:	89a6                	mv	s3,s1
 430:	a011                	j	434 <gets+0x5a>
 432:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 434:	99de                	add	s3,s3,s7
 436:	00098023          	sb	zero,0(s3)
  return buf;
}
 43a:	855e                	mv	a0,s7
 43c:	60e6                	ld	ra,88(sp)
 43e:	6446                	ld	s0,80(sp)
 440:	64a6                	ld	s1,72(sp)
 442:	6906                	ld	s2,64(sp)
 444:	79e2                	ld	s3,56(sp)
 446:	7a42                	ld	s4,48(sp)
 448:	7aa2                	ld	s5,40(sp)
 44a:	7b02                	ld	s6,32(sp)
 44c:	6be2                	ld	s7,24(sp)
 44e:	6c42                	ld	s8,16(sp)
 450:	6125                	addi	sp,sp,96
 452:	8082                	ret

0000000000000454 <stat>:

int
stat(const char *n, struct stat *st)
{
 454:	1101                	addi	sp,sp,-32
 456:	ec06                	sd	ra,24(sp)
 458:	e822                	sd	s0,16(sp)
 45a:	e426                	sd	s1,8(sp)
 45c:	e04a                	sd	s2,0(sp)
 45e:	1000                	addi	s0,sp,32
 460:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 462:	4581                	li	a1,0
 464:	00000097          	auipc	ra,0x0
 468:	188080e7          	jalr	392(ra) # 5ec <open>
  if(fd < 0)
 46c:	02054563          	bltz	a0,496 <stat+0x42>
 470:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 472:	85ca                	mv	a1,s2
 474:	00000097          	auipc	ra,0x0
 478:	180080e7          	jalr	384(ra) # 5f4 <fstat>
 47c:	892a                	mv	s2,a0
  close(fd);
 47e:	8526                	mv	a0,s1
 480:	00000097          	auipc	ra,0x0
 484:	154080e7          	jalr	340(ra) # 5d4 <close>
  return r;
}
 488:	854a                	mv	a0,s2
 48a:	60e2                	ld	ra,24(sp)
 48c:	6442                	ld	s0,16(sp)
 48e:	64a2                	ld	s1,8(sp)
 490:	6902                	ld	s2,0(sp)
 492:	6105                	addi	sp,sp,32
 494:	8082                	ret
    return -1;
 496:	597d                	li	s2,-1
 498:	bfc5                	j	488 <stat+0x34>

000000000000049a <atoi>:

int
atoi(const char *s)
{
 49a:	1141                	addi	sp,sp,-16
 49c:	e422                	sd	s0,8(sp)
 49e:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 4a0:	00054703          	lbu	a4,0(a0)
 4a4:	02d00793          	li	a5,45
  int neg = 1;
 4a8:	4585                	li	a1,1
  if (*s == '-') {
 4aa:	04f70363          	beq	a4,a5,4f0 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 4ae:	00054703          	lbu	a4,0(a0)
 4b2:	fd07079b          	addiw	a5,a4,-48
 4b6:	0ff7f793          	zext.b	a5,a5
 4ba:	46a5                	li	a3,9
 4bc:	02f6ed63          	bltu	a3,a5,4f6 <atoi+0x5c>
  n = 0;
 4c0:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 4c2:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 4c4:	0505                	addi	a0,a0,1
 4c6:	0026979b          	slliw	a5,a3,0x2
 4ca:	9fb5                	addw	a5,a5,a3
 4cc:	0017979b          	slliw	a5,a5,0x1
 4d0:	9fb9                	addw	a5,a5,a4
 4d2:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 4d6:	00054703          	lbu	a4,0(a0)
 4da:	fd07079b          	addiw	a5,a4,-48
 4de:	0ff7f793          	zext.b	a5,a5
 4e2:	fef671e3          	bgeu	a2,a5,4c4 <atoi+0x2a>
  return n * neg;
}
 4e6:	02d5853b          	mulw	a0,a1,a3
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret
    s++;
 4f0:	0505                	addi	a0,a0,1
    neg = -1;
 4f2:	55fd                	li	a1,-1
 4f4:	bf6d                	j	4ae <atoi+0x14>
  n = 0;
 4f6:	4681                	li	a3,0
 4f8:	b7fd                	j	4e6 <atoi+0x4c>

00000000000004fa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4fa:	1141                	addi	sp,sp,-16
 4fc:	e422                	sd	s0,8(sp)
 4fe:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 500:	02b57463          	bgeu	a0,a1,528 <memmove+0x2e>
    while(n-- > 0)
 504:	00c05f63          	blez	a2,522 <memmove+0x28>
 508:	1602                	slli	a2,a2,0x20
 50a:	9201                	srli	a2,a2,0x20
 50c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 510:	872a                	mv	a4,a0
      *dst++ = *src++;
 512:	0585                	addi	a1,a1,1
 514:	0705                	addi	a4,a4,1
 516:	fff5c683          	lbu	a3,-1(a1)
 51a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 51e:	fee79ae3          	bne	a5,a4,512 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 522:	6422                	ld	s0,8(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret
    dst += n;
 528:	00c50733          	add	a4,a0,a2
    src += n;
 52c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 52e:	fec05ae3          	blez	a2,522 <memmove+0x28>
 532:	fff6079b          	addiw	a5,a2,-1
 536:	1782                	slli	a5,a5,0x20
 538:	9381                	srli	a5,a5,0x20
 53a:	fff7c793          	not	a5,a5
 53e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 540:	15fd                	addi	a1,a1,-1
 542:	177d                	addi	a4,a4,-1
 544:	0005c683          	lbu	a3,0(a1)
 548:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 54c:	fee79ae3          	bne	a5,a4,540 <memmove+0x46>
 550:	bfc9                	j	522 <memmove+0x28>

0000000000000552 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 552:	1141                	addi	sp,sp,-16
 554:	e422                	sd	s0,8(sp)
 556:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 558:	ca05                	beqz	a2,588 <memcmp+0x36>
 55a:	fff6069b          	addiw	a3,a2,-1
 55e:	1682                	slli	a3,a3,0x20
 560:	9281                	srli	a3,a3,0x20
 562:	0685                	addi	a3,a3,1
 564:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 566:	00054783          	lbu	a5,0(a0)
 56a:	0005c703          	lbu	a4,0(a1)
 56e:	00e79863          	bne	a5,a4,57e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 572:	0505                	addi	a0,a0,1
    p2++;
 574:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 576:	fed518e3          	bne	a0,a3,566 <memcmp+0x14>
  }
  return 0;
 57a:	4501                	li	a0,0
 57c:	a019                	j	582 <memcmp+0x30>
      return *p1 - *p2;
 57e:	40e7853b          	subw	a0,a5,a4
}
 582:	6422                	ld	s0,8(sp)
 584:	0141                	addi	sp,sp,16
 586:	8082                	ret
  return 0;
 588:	4501                	li	a0,0
 58a:	bfe5                	j	582 <memcmp+0x30>

000000000000058c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 58c:	1141                	addi	sp,sp,-16
 58e:	e406                	sd	ra,8(sp)
 590:	e022                	sd	s0,0(sp)
 592:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 594:	00000097          	auipc	ra,0x0
 598:	f66080e7          	jalr	-154(ra) # 4fa <memmove>
}
 59c:	60a2                	ld	ra,8(sp)
 59e:	6402                	ld	s0,0(sp)
 5a0:	0141                	addi	sp,sp,16
 5a2:	8082                	ret

00000000000005a4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 5a4:	4885                	li	a7,1
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ac:	4889                	li	a7,2
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5b4:	488d                	li	a7,3
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5bc:	4891                	li	a7,4
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <read>:
.global read
read:
 li a7, SYS_read
 5c4:	4895                	li	a7,5
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <write>:
.global write
write:
 li a7, SYS_write
 5cc:	48c1                	li	a7,16
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <close>:
.global close
close:
 li a7, SYS_close
 5d4:	48d5                	li	a7,21
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <kill>:
.global kill
kill:
 li a7, SYS_kill
 5dc:	4899                	li	a7,6
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5e4:	489d                	li	a7,7
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <open>:
.global open
open:
 li a7, SYS_open
 5ec:	48bd                	li	a7,15
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f4:	48a1                	li	a7,8
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5fc:	48d1                	li	a7,20
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 604:	48a5                	li	a7,9
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <dup>:
.global dup
dup:
 li a7, SYS_dup
 60c:	48a9                	li	a7,10
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 614:	48ad                	li	a7,11
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 61c:	48b1                	li	a7,12
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 624:	48b5                	li	a7,13
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 62c:	48b9                	li	a7,14
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 634:	48d9                	li	a7,22
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <dev>:
.global dev
dev:
 li a7, SYS_dev
 63c:	48dd                	li	a7,23
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 644:	48e1                	li	a7,24
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 64c:	48e5                	li	a7,25
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <remove>:
.global remove
remove:
 li a7, SYS_remove
 654:	48c5                	li	a7,17
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <trace>:
.global trace
trace:
 li a7, SYS_trace
 65c:	48c9                	li	a7,18
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 664:	48cd                	li	a7,19
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <rename>:
.global rename
rename:
 li a7, SYS_rename
 66c:	48e9                	li	a7,26
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 674:	48ed                	li	a7,27
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 67c:	48f1                	li	a7,28
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 684:	48f5                	li	a7,29
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 68c:	48f9                	li	a7,30
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 694:	48fd                	li	a7,31
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 69c:	02000893          	li	a7,32
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 6a6:	02100893          	li	a7,33
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 6b0:	02200893          	li	a7,34
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 6ba:	02300893          	li	a7,35
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 6c4:	02400893          	li	a7,36
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 6ce:	02500893          	li	a7,37
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 6d8:	02600893          	li	a7,38
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 6e2:	02700893          	li	a7,39
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 6ec:	02800893          	li	a7,40
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 6f6:	02900893          	li	a7,41
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 700:	02a00893          	li	a7,42
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 70a:	02b00893          	li	a7,43
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 714:	02c00893          	li	a7,44
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 71e:	02d00893          	li	a7,45
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 728:	02e00893          	li	a7,46
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 732:	02f00893          	li	a7,47
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 73c:	03000893          	li	a7,48
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 746:	03100893          	li	a7,49
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 750:	03200893          	li	a7,50
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 75a:	03300893          	li	a7,51
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 764:	03400893          	li	a7,52
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 76e:	03500893          	li	a7,53
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 778:	03600893          	li	a7,54
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 782:	03700893          	li	a7,55
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 78c:	03800893          	li	a7,56
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 796:	03900893          	li	a7,57
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 7a0:	03a00893          	li	a7,58
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <poll>:
.global poll
poll:
 li a7, SYS_poll
 7aa:	03b00893          	li	a7,59
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 7b4:	03c00893          	li	a7,60
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 7be:	03d00893          	li	a7,61
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 7c8:	03e00893          	li	a7,62
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <clone>:
.global clone
clone:
 li a7, SYS_clone
 7d2:	03f00893          	li	a7,63
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <futex>:
.global futex
futex:
 li a7, SYS_futex
 7dc:	04000893          	li	a7,64
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 7e6:	04100893          	li	a7,65
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <halt>:
.global halt
halt:
 li a7, SYS_halt
 7f0:	04200893          	li	a7,66
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 7fa:	04300893          	li	a7,67
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <socket>:
.global socket
socket:
 li a7, SYS_socket
 804:	04400893          	li	a7,68
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <bind>:
.global bind
bind:
 li a7, SYS_bind
 80e:	04500893          	li	a7,69
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <listen>:
.global listen
listen:
 li a7, SYS_listen
 818:	04600893          	li	a7,70
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <accept>:
.global accept
accept:
 li a7, SYS_accept
 822:	04700893          	li	a7,71
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <connect>:
.global connect
connect:
 li a7, SYS_connect
 82c:	04800893          	li	a7,72
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <send>:
.global send
send:
 li a7, SYS_send
 836:	04900893          	li	a7,73
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <recv>:
.global recv
recv:
 li a7, SYS_recv
 840:	04a00893          	li	a7,74
 ecall
 844:	00000073          	ecall
 ret
 848:	8082                	ret

000000000000084a <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 84a:	04b00893          	li	a7,75
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 854:	1101                	addi	sp,sp,-32
 856:	ec06                	sd	ra,24(sp)
 858:	e822                	sd	s0,16(sp)
 85a:	1000                	addi	s0,sp,32
 85c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 860:	4605                	li	a2,1
 862:	fef40593          	addi	a1,s0,-17
 866:	00000097          	auipc	ra,0x0
 86a:	d66080e7          	jalr	-666(ra) # 5cc <write>
}
 86e:	60e2                	ld	ra,24(sp)
 870:	6442                	ld	s0,16(sp)
 872:	6105                	addi	sp,sp,32
 874:	8082                	ret

0000000000000876 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 876:	7139                	addi	sp,sp,-64
 878:	fc06                	sd	ra,56(sp)
 87a:	f822                	sd	s0,48(sp)
 87c:	f426                	sd	s1,40(sp)
 87e:	f04a                	sd	s2,32(sp)
 880:	ec4e                	sd	s3,24(sp)
 882:	0080                	addi	s0,sp,64
 884:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 886:	c299                	beqz	a3,88c <printint+0x16>
 888:	0805c863          	bltz	a1,918 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 88c:	2581                	sext.w	a1,a1
  neg = 0;
 88e:	4881                	li	a7,0
  }

  i = 0;
 890:	fc040993          	addi	s3,s0,-64
  neg = 0;
 894:	86ce                	mv	a3,s3
  i = 0;
 896:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 898:	2601                	sext.w	a2,a2
 89a:	00000517          	auipc	a0,0x0
 89e:	71650513          	addi	a0,a0,1814 # fb0 <digits>
 8a2:	883a                	mv	a6,a4
 8a4:	2705                	addiw	a4,a4,1
 8a6:	02c5f7bb          	remuw	a5,a1,a2
 8aa:	1782                	slli	a5,a5,0x20
 8ac:	9381                	srli	a5,a5,0x20
 8ae:	97aa                	add	a5,a5,a0
 8b0:	0007c783          	lbu	a5,0(a5)
 8b4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8b8:	0005879b          	sext.w	a5,a1
 8bc:	02c5d5bb          	divuw	a1,a1,a2
 8c0:	0685                	addi	a3,a3,1
 8c2:	fec7f0e3          	bgeu	a5,a2,8a2 <printint+0x2c>
  if(neg)
 8c6:	00088c63          	beqz	a7,8de <printint+0x68>
    buf[i++] = '-';
 8ca:	fd070793          	addi	a5,a4,-48
 8ce:	00878733          	add	a4,a5,s0
 8d2:	02d00793          	li	a5,45
 8d6:	fef70823          	sb	a5,-16(a4)
 8da:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8de:	02e05663          	blez	a4,90a <printint+0x94>
 8e2:	fc040913          	addi	s2,s0,-64
 8e6:	993a                	add	s2,s2,a4
 8e8:	19fd                	addi	s3,s3,-1
 8ea:	99ba                	add	s3,s3,a4
 8ec:	377d                	addiw	a4,a4,-1
 8ee:	1702                	slli	a4,a4,0x20
 8f0:	9301                	srli	a4,a4,0x20
 8f2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8f6:	fff94583          	lbu	a1,-1(s2)
 8fa:	8526                	mv	a0,s1
 8fc:	00000097          	auipc	ra,0x0
 900:	f58080e7          	jalr	-168(ra) # 854 <putc>
  while(--i >= 0)
 904:	197d                	addi	s2,s2,-1
 906:	ff3918e3          	bne	s2,s3,8f6 <printint+0x80>
}
 90a:	70e2                	ld	ra,56(sp)
 90c:	7442                	ld	s0,48(sp)
 90e:	74a2                	ld	s1,40(sp)
 910:	7902                	ld	s2,32(sp)
 912:	69e2                	ld	s3,24(sp)
 914:	6121                	addi	sp,sp,64
 916:	8082                	ret
    x = -xx;
 918:	40b005bb          	negw	a1,a1
    neg = 1;
 91c:	4885                	li	a7,1
    x = -xx;
 91e:	bf8d                	j	890 <printint+0x1a>

0000000000000920 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 920:	7119                	addi	sp,sp,-128
 922:	fc86                	sd	ra,120(sp)
 924:	f8a2                	sd	s0,112(sp)
 926:	f4a6                	sd	s1,104(sp)
 928:	f0ca                	sd	s2,96(sp)
 92a:	ecce                	sd	s3,88(sp)
 92c:	e8d2                	sd	s4,80(sp)
 92e:	e4d6                	sd	s5,72(sp)
 930:	e0da                	sd	s6,64(sp)
 932:	fc5e                	sd	s7,56(sp)
 934:	f862                	sd	s8,48(sp)
 936:	f466                	sd	s9,40(sp)
 938:	f06a                	sd	s10,32(sp)
 93a:	ec6e                	sd	s11,24(sp)
 93c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 93e:	0005c903          	lbu	s2,0(a1)
 942:	18090f63          	beqz	s2,ae0 <vprintf+0x1c0>
 946:	8aaa                	mv	s5,a0
 948:	8b32                	mv	s6,a2
 94a:	00158493          	addi	s1,a1,1
  state = 0;
 94e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 950:	02500a13          	li	s4,37
 954:	4c55                	li	s8,21
 956:	00000c97          	auipc	s9,0x0
 95a:	602c8c93          	addi	s9,s9,1538 # f58 <malloc+0x374>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 95e:	02800d93          	li	s11,40
  putc(fd, 'x');
 962:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 964:	00000b97          	auipc	s7,0x0
 968:	64cb8b93          	addi	s7,s7,1612 # fb0 <digits>
 96c:	a839                	j	98a <vprintf+0x6a>
        putc(fd, c);
 96e:	85ca                	mv	a1,s2
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	ee2080e7          	jalr	-286(ra) # 854 <putc>
 97a:	a019                	j	980 <vprintf+0x60>
    } else if(state == '%'){
 97c:	01498d63          	beq	s3,s4,996 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 980:	0485                	addi	s1,s1,1
 982:	fff4c903          	lbu	s2,-1(s1)
 986:	14090d63          	beqz	s2,ae0 <vprintf+0x1c0>
    if(state == 0){
 98a:	fe0999e3          	bnez	s3,97c <vprintf+0x5c>
      if(c == '%'){
 98e:	ff4910e3          	bne	s2,s4,96e <vprintf+0x4e>
        state = '%';
 992:	89d2                	mv	s3,s4
 994:	b7f5                	j	980 <vprintf+0x60>
      if(c == 'd'){
 996:	11490c63          	beq	s2,s4,aae <vprintf+0x18e>
 99a:	f9d9079b          	addiw	a5,s2,-99
 99e:	0ff7f793          	zext.b	a5,a5
 9a2:	10fc6e63          	bltu	s8,a5,abe <vprintf+0x19e>
 9a6:	f9d9079b          	addiw	a5,s2,-99
 9aa:	0ff7f713          	zext.b	a4,a5
 9ae:	10ec6863          	bltu	s8,a4,abe <vprintf+0x19e>
 9b2:	00271793          	slli	a5,a4,0x2
 9b6:	97e6                	add	a5,a5,s9
 9b8:	439c                	lw	a5,0(a5)
 9ba:	97e6                	add	a5,a5,s9
 9bc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9be:	008b0913          	addi	s2,s6,8
 9c2:	4685                	li	a3,1
 9c4:	4629                	li	a2,10
 9c6:	000b2583          	lw	a1,0(s6)
 9ca:	8556                	mv	a0,s5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	eaa080e7          	jalr	-342(ra) # 876 <printint>
 9d4:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9d6:	4981                	li	s3,0
 9d8:	b765                	j	980 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9da:	008b0913          	addi	s2,s6,8
 9de:	4681                	li	a3,0
 9e0:	4629                	li	a2,10
 9e2:	000b2583          	lw	a1,0(s6)
 9e6:	8556                	mv	a0,s5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	e8e080e7          	jalr	-370(ra) # 876 <printint>
 9f0:	8b4a                	mv	s6,s2
      state = 0;
 9f2:	4981                	li	s3,0
 9f4:	b771                	j	980 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9f6:	008b0913          	addi	s2,s6,8
 9fa:	4681                	li	a3,0
 9fc:	866a                	mv	a2,s10
 9fe:	000b2583          	lw	a1,0(s6)
 a02:	8556                	mv	a0,s5
 a04:	00000097          	auipc	ra,0x0
 a08:	e72080e7          	jalr	-398(ra) # 876 <printint>
 a0c:	8b4a                	mv	s6,s2
      state = 0;
 a0e:	4981                	li	s3,0
 a10:	bf85                	j	980 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a12:	008b0793          	addi	a5,s6,8
 a16:	f8f43423          	sd	a5,-120(s0)
 a1a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a1e:	03000593          	li	a1,48
 a22:	8556                	mv	a0,s5
 a24:	00000097          	auipc	ra,0x0
 a28:	e30080e7          	jalr	-464(ra) # 854 <putc>
  putc(fd, 'x');
 a2c:	07800593          	li	a1,120
 a30:	8556                	mv	a0,s5
 a32:	00000097          	auipc	ra,0x0
 a36:	e22080e7          	jalr	-478(ra) # 854 <putc>
 a3a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a3c:	03c9d793          	srli	a5,s3,0x3c
 a40:	97de                	add	a5,a5,s7
 a42:	0007c583          	lbu	a1,0(a5)
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	e0c080e7          	jalr	-500(ra) # 854 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a50:	0992                	slli	s3,s3,0x4
 a52:	397d                	addiw	s2,s2,-1
 a54:	fe0914e3          	bnez	s2,a3c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 a58:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a5c:	4981                	li	s3,0
 a5e:	b70d                	j	980 <vprintf+0x60>
        s = va_arg(ap, char*);
 a60:	008b0913          	addi	s2,s6,8
 a64:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 a68:	02098163          	beqz	s3,a8a <vprintf+0x16a>
        while(*s != 0){
 a6c:	0009c583          	lbu	a1,0(s3)
 a70:	c5ad                	beqz	a1,ada <vprintf+0x1ba>
          putc(fd, *s);
 a72:	8556                	mv	a0,s5
 a74:	00000097          	auipc	ra,0x0
 a78:	de0080e7          	jalr	-544(ra) # 854 <putc>
          s++;
 a7c:	0985                	addi	s3,s3,1
        while(*s != 0){
 a7e:	0009c583          	lbu	a1,0(s3)
 a82:	f9e5                	bnez	a1,a72 <vprintf+0x152>
        s = va_arg(ap, char*);
 a84:	8b4a                	mv	s6,s2
      state = 0;
 a86:	4981                	li	s3,0
 a88:	bde5                	j	980 <vprintf+0x60>
          s = "(null)";
 a8a:	00000997          	auipc	s3,0x0
 a8e:	4c698993          	addi	s3,s3,1222 # f50 <malloc+0x36c>
        while(*s != 0){
 a92:	85ee                	mv	a1,s11
 a94:	bff9                	j	a72 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 a96:	008b0913          	addi	s2,s6,8
 a9a:	000b4583          	lbu	a1,0(s6)
 a9e:	8556                	mv	a0,s5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	db4080e7          	jalr	-588(ra) # 854 <putc>
 aa8:	8b4a                	mv	s6,s2
      state = 0;
 aaa:	4981                	li	s3,0
 aac:	bdd1                	j	980 <vprintf+0x60>
        putc(fd, c);
 aae:	85d2                	mv	a1,s4
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	da2080e7          	jalr	-606(ra) # 854 <putc>
      state = 0;
 aba:	4981                	li	s3,0
 abc:	b5d1                	j	980 <vprintf+0x60>
        putc(fd, '%');
 abe:	85d2                	mv	a1,s4
 ac0:	8556                	mv	a0,s5
 ac2:	00000097          	auipc	ra,0x0
 ac6:	d92080e7          	jalr	-622(ra) # 854 <putc>
        putc(fd, c);
 aca:	85ca                	mv	a1,s2
 acc:	8556                	mv	a0,s5
 ace:	00000097          	auipc	ra,0x0
 ad2:	d86080e7          	jalr	-634(ra) # 854 <putc>
      state = 0;
 ad6:	4981                	li	s3,0
 ad8:	b565                	j	980 <vprintf+0x60>
        s = va_arg(ap, char*);
 ada:	8b4a                	mv	s6,s2
      state = 0;
 adc:	4981                	li	s3,0
 ade:	b54d                	j	980 <vprintf+0x60>
    }
  }
}
 ae0:	70e6                	ld	ra,120(sp)
 ae2:	7446                	ld	s0,112(sp)
 ae4:	74a6                	ld	s1,104(sp)
 ae6:	7906                	ld	s2,96(sp)
 ae8:	69e6                	ld	s3,88(sp)
 aea:	6a46                	ld	s4,80(sp)
 aec:	6aa6                	ld	s5,72(sp)
 aee:	6b06                	ld	s6,64(sp)
 af0:	7be2                	ld	s7,56(sp)
 af2:	7c42                	ld	s8,48(sp)
 af4:	7ca2                	ld	s9,40(sp)
 af6:	7d02                	ld	s10,32(sp)
 af8:	6de2                	ld	s11,24(sp)
 afa:	6109                	addi	sp,sp,128
 afc:	8082                	ret

0000000000000afe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 afe:	715d                	addi	sp,sp,-80
 b00:	ec06                	sd	ra,24(sp)
 b02:	e822                	sd	s0,16(sp)
 b04:	1000                	addi	s0,sp,32
 b06:	e010                	sd	a2,0(s0)
 b08:	e414                	sd	a3,8(s0)
 b0a:	e818                	sd	a4,16(s0)
 b0c:	ec1c                	sd	a5,24(s0)
 b0e:	03043023          	sd	a6,32(s0)
 b12:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b16:	8622                	mv	a2,s0
 b18:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b1c:	00000097          	auipc	ra,0x0
 b20:	e04080e7          	jalr	-508(ra) # 920 <vprintf>
}
 b24:	60e2                	ld	ra,24(sp)
 b26:	6442                	ld	s0,16(sp)
 b28:	6161                	addi	sp,sp,80
 b2a:	8082                	ret

0000000000000b2c <printf>:

void
printf(const char *fmt, ...)
{
 b2c:	711d                	addi	sp,sp,-96
 b2e:	ec06                	sd	ra,24(sp)
 b30:	e822                	sd	s0,16(sp)
 b32:	1000                	addi	s0,sp,32
 b34:	e40c                	sd	a1,8(s0)
 b36:	e810                	sd	a2,16(s0)
 b38:	ec14                	sd	a3,24(s0)
 b3a:	f018                	sd	a4,32(s0)
 b3c:	f41c                	sd	a5,40(s0)
 b3e:	03043823          	sd	a6,48(s0)
 b42:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b46:	00840613          	addi	a2,s0,8
 b4a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b4e:	85aa                	mv	a1,a0
 b50:	4505                	li	a0,1
 b52:	00000097          	auipc	ra,0x0
 b56:	dce080e7          	jalr	-562(ra) # 920 <vprintf>
}
 b5a:	60e2                	ld	ra,24(sp)
 b5c:	6442                	ld	s0,16(sp)
 b5e:	6125                	addi	sp,sp,96
 b60:	8082                	ret

0000000000000b62 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b62:	1141                	addi	sp,sp,-16
 b64:	e422                	sd	s0,8(sp)
 b66:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b68:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b6c:	00000797          	auipc	a5,0x0
 b70:	45c7b783          	ld	a5,1116(a5) # fc8 <freep>
 b74:	a02d                	j	b9e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b76:	4618                	lw	a4,8(a2)
 b78:	9f2d                	addw	a4,a4,a1
 b7a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b7e:	6398                	ld	a4,0(a5)
 b80:	6310                	ld	a2,0(a4)
 b82:	a83d                	j	bc0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b84:	ff852703          	lw	a4,-8(a0)
 b88:	9f31                	addw	a4,a4,a2
 b8a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b8c:	ff053683          	ld	a3,-16(a0)
 b90:	a091                	j	bd4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b92:	6398                	ld	a4,0(a5)
 b94:	00e7e463          	bltu	a5,a4,b9c <free+0x3a>
 b98:	00e6ea63          	bltu	a3,a4,bac <free+0x4a>
{
 b9c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9e:	fed7fae3          	bgeu	a5,a3,b92 <free+0x30>
 ba2:	6398                	ld	a4,0(a5)
 ba4:	00e6e463          	bltu	a3,a4,bac <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ba8:	fee7eae3          	bltu	a5,a4,b9c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bac:	ff852583          	lw	a1,-8(a0)
 bb0:	6390                	ld	a2,0(a5)
 bb2:	02059813          	slli	a6,a1,0x20
 bb6:	01c85713          	srli	a4,a6,0x1c
 bba:	9736                	add	a4,a4,a3
 bbc:	fae60de3          	beq	a2,a4,b76 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 bc0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 bc4:	4790                	lw	a2,8(a5)
 bc6:	02061593          	slli	a1,a2,0x20
 bca:	01c5d713          	srli	a4,a1,0x1c
 bce:	973e                	add	a4,a4,a5
 bd0:	fae68ae3          	beq	a3,a4,b84 <free+0x22>
    p->s.ptr = bp->s.ptr;
 bd4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bd6:	00000717          	auipc	a4,0x0
 bda:	3ef73923          	sd	a5,1010(a4) # fc8 <freep>
}
 bde:	6422                	ld	s0,8(sp)
 be0:	0141                	addi	sp,sp,16
 be2:	8082                	ret

0000000000000be4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 be4:	7139                	addi	sp,sp,-64
 be6:	fc06                	sd	ra,56(sp)
 be8:	f822                	sd	s0,48(sp)
 bea:	f426                	sd	s1,40(sp)
 bec:	f04a                	sd	s2,32(sp)
 bee:	ec4e                	sd	s3,24(sp)
 bf0:	e852                	sd	s4,16(sp)
 bf2:	e456                	sd	s5,8(sp)
 bf4:	e05a                	sd	s6,0(sp)
 bf6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf8:	02051493          	slli	s1,a0,0x20
 bfc:	9081                	srli	s1,s1,0x20
 bfe:	04bd                	addi	s1,s1,15
 c00:	8091                	srli	s1,s1,0x4
 c02:	00148a1b          	addiw	s4,s1,1
 c06:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c08:	00000517          	auipc	a0,0x0
 c0c:	3c053503          	ld	a0,960(a0) # fc8 <freep>
 c10:	c515                	beqz	a0,c3c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c12:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c14:	4798                	lw	a4,8(a5)
 c16:	04977163          	bgeu	a4,s1,c58 <malloc+0x74>
 c1a:	89d2                	mv	s3,s4
 c1c:	000a071b          	sext.w	a4,s4
 c20:	6685                	lui	a3,0x1
 c22:	00d77363          	bgeu	a4,a3,c28 <malloc+0x44>
 c26:	6985                	lui	s3,0x1
 c28:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 c2c:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c30:	00000917          	auipc	s2,0x0
 c34:	39890913          	addi	s2,s2,920 # fc8 <freep>
  if(p == (char*)-1)
 c38:	5afd                	li	s5,-1
 c3a:	a8a5                	j	cb2 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 c3c:	00000797          	auipc	a5,0x0
 c40:	38c78793          	addi	a5,a5,908 # fc8 <freep>
 c44:	00000717          	auipc	a4,0x0
 c48:	38c70713          	addi	a4,a4,908 # fd0 <base>
 c4c:	e398                	sd	a4,0(a5)
 c4e:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 c50:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c54:	87ba                	mv	a5,a4
 c56:	b7d1                	j	c1a <malloc+0x36>
      if(p->s.size == nunits)
 c58:	02e48c63          	beq	s1,a4,c90 <malloc+0xac>
        p->s.size -= nunits;
 c5c:	4147073b          	subw	a4,a4,s4
 c60:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c62:	02071693          	slli	a3,a4,0x20
 c66:	01c6d713          	srli	a4,a3,0x1c
 c6a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c6c:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 c70:	00000717          	auipc	a4,0x0
 c74:	34a73c23          	sd	a0,856(a4) # fc8 <freep>
      return (void*)(p + 1);
 c78:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c7c:	70e2                	ld	ra,56(sp)
 c7e:	7442                	ld	s0,48(sp)
 c80:	74a2                	ld	s1,40(sp)
 c82:	7902                	ld	s2,32(sp)
 c84:	69e2                	ld	s3,24(sp)
 c86:	6a42                	ld	s4,16(sp)
 c88:	6aa2                	ld	s5,8(sp)
 c8a:	6b02                	ld	s6,0(sp)
 c8c:	6121                	addi	sp,sp,64
 c8e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c90:	6398                	ld	a4,0(a5)
 c92:	e118                	sd	a4,0(a0)
 c94:	bff1                	j	c70 <malloc+0x8c>
  hp->s.size = nu;
 c96:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c9a:	0541                	addi	a0,a0,16
 c9c:	00000097          	auipc	ra,0x0
 ca0:	ec6080e7          	jalr	-314(ra) # b62 <free>
  return freep;
 ca4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ca8:	d971                	beqz	a0,c7c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 caa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cac:	4798                	lw	a4,8(a5)
 cae:	fa9775e3          	bgeu	a4,s1,c58 <malloc+0x74>
    if(p == freep)
 cb2:	00093703          	ld	a4,0(s2)
 cb6:	853e                	mv	a0,a5
 cb8:	fef719e3          	bne	a4,a5,caa <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 cbc:	854e                	mv	a0,s3
 cbe:	00000097          	auipc	ra,0x0
 cc2:	95e080e7          	jalr	-1698(ra) # 61c <sbrk>
  if(p == (char*)-1)
 cc6:	fd5518e3          	bne	a0,s5,c96 <malloc+0xb2>
        return 0;
 cca:	4501                	li	a0,0
 ccc:	bf45                	j	c7c <malloc+0x98>
