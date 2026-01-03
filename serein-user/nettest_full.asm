
serein-user/_nettest_full：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <server>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

// POLL macros and struct pollfd are defined in user.h

void server() {
   0:	7131                	addi	sp,sp,-192
   2:	fd06                	sd	ra,184(sp)
   4:	f922                	sd	s0,176(sp)
   6:	f526                	sd	s1,168(sp)
   8:	f14a                	sd	s2,160(sp)
   a:	0180                	addi	s0,sp,192
  int fd;
  struct sockaddr_un addr;
  
  printf("[SERVER] Creating socket...\n");
   c:	00001517          	auipc	a0,0x1
  10:	cf450513          	addi	a0,a0,-780 # d00 <malloc+0xec>
  14:	00001097          	auipc	ra,0x1
  18:	b48080e7          	jalr	-1208(ra) # b5c <printf>
  fd = socket(AF_UNIX, SOCK_STREAM, 0);
  1c:	4601                	li	a2,0
  1e:	4585                	li	a1,1
  20:	4505                	li	a0,1
  22:	00001097          	auipc	ra,0x1
  26:	812080e7          	jalr	-2030(ra) # 834 <socket>
  if(fd < 0) exit(1);
  2a:	08054e63          	bltz	a0,c6 <server+0xc6>
  2e:	84aa                	mv	s1,a0
  
  addr.family = AF_UNIX;
  30:	4785                	li	a5,1
  32:	f6f41823          	sh	a5,-144(s0)
  strcpy(addr.path, "/tmp/netfull.sock");
  36:	00001597          	auipc	a1,0x1
  3a:	cea58593          	addi	a1,a1,-790 # d20 <malloc+0x10c>
  3e:	f7240513          	addi	a0,s0,-142
  42:	00000097          	auipc	ra,0x0
  46:	2e2080e7          	jalr	738(ra) # 324 <strcpy>
  
  if(bind(fd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
  4a:	06e00613          	li	a2,110
  4e:	f7040593          	addi	a1,s0,-144
  52:	8526                	mv	a0,s1
  54:	00000097          	auipc	ra,0x0
  58:	7ea080e7          	jalr	2026(ra) # 83e <bind>
  5c:	06054a63          	bltz	a0,d0 <server+0xd0>
      printf("[SERVER] bind failed\n");
      exit(1);
  }
  
  listen(fd, 5);
  60:	4595                	li	a1,5
  62:	8526                	mv	a0,s1
  64:	00000097          	auipc	ra,0x0
  68:	7e4080e7          	jalr	2020(ra) # 848 <listen>
  
  printf("[SERVER] Polling on listen socket...\n");
  6c:	00001517          	auipc	a0,0x1
  70:	ce450513          	addi	a0,a0,-796 # d50 <malloc+0x13c>
  74:	00001097          	auipc	ra,0x1
  78:	ae8080e7          	jalr	-1304(ra) # b5c <printf>
  struct pollfd pfd;
  pfd.fd = fd;
  7c:	f6942423          	sw	s1,-152(s0)
  pfd.events = POLLIN;
  80:	4785                	li	a5,1
  82:	f6f41623          	sh	a5,-148(s0)
  
  int ret = poll(&pfd, 1, 5000); // 5s timeout
  86:	6605                	lui	a2,0x1
  88:	38860613          	addi	a2,a2,904 # 1388 <__BSS_END__+0x380>
  8c:	4585                	li	a1,1
  8e:	f6840513          	addi	a0,s0,-152
  92:	00000097          	auipc	ra,0x0
  96:	748080e7          	jalr	1864(ra) # 7da <poll>
  9a:	85aa                	mv	a1,a0
  if(ret > 0 && (pfd.revents & POLLIN)) {
  9c:	00a05663          	blez	a0,a8 <server+0xa8>
  a0:	f6e45783          	lhu	a5,-146(s0)
  a4:	8b85                	andi	a5,a5,1
  a6:	e3b1                	bnez	a5,ea <server+0xea>
      printf("[SERVER] Writing via write()...\n");
      write(client_fd, "Reply", 5);
      
      close(client_fd);
  } else {
      printf("[SERVER] Poll timed out or failed (ret=%d, revents=%x)\n", ret, pfd.revents);
  a8:	f6e41603          	lh	a2,-146(s0)
  ac:	00001517          	auipc	a0,0x1
  b0:	de450513          	addi	a0,a0,-540 # e90 <malloc+0x27c>
  b4:	00001097          	auipc	ra,0x1
  b8:	aa8080e7          	jalr	-1368(ra) # b5c <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	51e080e7          	jalr	1310(ra) # 5dc <exit>
  if(fd < 0) exit(1);
  c6:	4505                	li	a0,1
  c8:	00000097          	auipc	ra,0x0
  cc:	514080e7          	jalr	1300(ra) # 5dc <exit>
      printf("[SERVER] bind failed\n");
  d0:	00001517          	auipc	a0,0x1
  d4:	c6850513          	addi	a0,a0,-920 # d38 <malloc+0x124>
  d8:	00001097          	auipc	ra,0x1
  dc:	a84080e7          	jalr	-1404(ra) # b5c <printf>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	4fa080e7          	jalr	1274(ra) # 5dc <exit>
      printf("[SERVER] Poll successful (POLLIN set)\n");
  ea:	00001517          	auipc	a0,0x1
  ee:	c8e50513          	addi	a0,a0,-882 # d78 <malloc+0x164>
  f2:	00001097          	auipc	ra,0x1
  f6:	a6a080e7          	jalr	-1430(ra) # b5c <printf>
      int client_fd = accept(fd, 0, 0);
  fa:	4601                	li	a2,0
  fc:	4581                	li	a1,0
  fe:	8526                	mv	a0,s1
 100:	00000097          	auipc	ra,0x0
 104:	752080e7          	jalr	1874(ra) # 852 <accept>
 108:	892a                	mv	s2,a0
      if(client_fd < 0) {
 10a:	0a054763          	bltz	a0,1b8 <server+0x1b8>
      printf("[SERVER] Accepted client (fd=%d)\n", client_fd);
 10e:	85aa                	mv	a1,a0
 110:	00001517          	auipc	a0,0x1
 114:	ca850513          	addi	a0,a0,-856 # db8 <malloc+0x1a4>
 118:	00001097          	auipc	ra,0x1
 11c:	a44080e7          	jalr	-1468(ra) # b5c <printf>
      printf("[SERVER] Blocking read() from client...\n");
 120:	00001517          	auipc	a0,0x1
 124:	cc050513          	addi	a0,a0,-832 # de0 <malloc+0x1cc>
 128:	00001097          	auipc	ra,0x1
 12c:	a34080e7          	jalr	-1484(ra) # b5c <printf>
      int n = read(client_fd, buf, sizeof(buf));
 130:	02000613          	li	a2,32
 134:	f4840593          	addi	a1,s0,-184
 138:	854a                	mv	a0,s2
 13a:	00000097          	auipc	ra,0x0
 13e:	4ba080e7          	jalr	1210(ra) # 5f4 <read>
      if(n > 0) {
 142:	08a05863          	blez	a0,1d2 <server+0x1d2>
          buf[n] = 0;
 146:	fe050793          	addi	a5,a0,-32
 14a:	00878533          	add	a0,a5,s0
 14e:	f6050423          	sb	zero,-152(a0)
          printf("[SERVER] Read via read(): %s\n", buf);
 152:	f4840593          	addi	a1,s0,-184
 156:	00001517          	auipc	a0,0x1
 15a:	cba50513          	addi	a0,a0,-838 # e10 <malloc+0x1fc>
 15e:	00001097          	auipc	ra,0x1
 162:	9fe080e7          	jalr	-1538(ra) # b5c <printf>
      printf("[SERVER] Writing via write()...\n");
 166:	00001517          	auipc	a0,0x1
 16a:	cea50513          	addi	a0,a0,-790 # e50 <malloc+0x23c>
 16e:	00001097          	auipc	ra,0x1
 172:	9ee080e7          	jalr	-1554(ra) # b5c <printf>
      write(client_fd, "Reply", 5);
 176:	4615                	li	a2,5
 178:	00001597          	auipc	a1,0x1
 17c:	d0058593          	addi	a1,a1,-768 # e78 <malloc+0x264>
 180:	854a                	mv	a0,s2
 182:	00000097          	auipc	ra,0x0
 186:	47a080e7          	jalr	1146(ra) # 5fc <write>
      close(client_fd);
 18a:	854a                	mv	a0,s2
 18c:	00000097          	auipc	ra,0x0
 190:	478080e7          	jalr	1144(ra) # 604 <close>
  }
  
  close(fd);
 194:	8526                	mv	a0,s1
 196:	00000097          	auipc	ra,0x0
 19a:	46e080e7          	jalr	1134(ra) # 604 <close>
  printf("[SERVER] Done\n");
 19e:	00001517          	auipc	a0,0x1
 1a2:	ce250513          	addi	a0,a0,-798 # e80 <malloc+0x26c>
 1a6:	00001097          	auipc	ra,0x1
 1aa:	9b6080e7          	jalr	-1610(ra) # b5c <printf>
  exit(0);
 1ae:	4501                	li	a0,0
 1b0:	00000097          	auipc	ra,0x0
 1b4:	42c080e7          	jalr	1068(ra) # 5dc <exit>
          printf("[SERVER] accept failed\n");
 1b8:	00001517          	auipc	a0,0x1
 1bc:	be850513          	addi	a0,a0,-1048 # da0 <malloc+0x18c>
 1c0:	00001097          	auipc	ra,0x1
 1c4:	99c080e7          	jalr	-1636(ra) # b5c <printf>
          exit(1);
 1c8:	4505                	li	a0,1
 1ca:	00000097          	auipc	ra,0x0
 1ce:	412080e7          	jalr	1042(ra) # 5dc <exit>
          printf("[SERVER] Read failed or EOF\n");
 1d2:	00001517          	auipc	a0,0x1
 1d6:	c5e50513          	addi	a0,a0,-930 # e30 <malloc+0x21c>
 1da:	00001097          	auipc	ra,0x1
 1de:	982080e7          	jalr	-1662(ra) # b5c <printf>
 1e2:	b751                	j	166 <server+0x166>

00000000000001e4 <client>:
}

void client() {
 1e4:	7131                	addi	sp,sp,-192
 1e6:	fd06                	sd	ra,184(sp)
 1e8:	f922                	sd	s0,176(sp)
 1ea:	f526                	sd	s1,168(sp)
 1ec:	0180                	addi	s0,sp,192
  sleep(20); // Wait for server listen
 1ee:	4551                	li	a0,20
 1f0:	00000097          	auipc	ra,0x0
 1f4:	464080e7          	jalr	1124(ra) # 654 <sleep>
  
  int fd = socket(AF_UNIX, SOCK_STREAM, 0);
 1f8:	4601                	li	a2,0
 1fa:	4585                	li	a1,1
 1fc:	4505                	li	a0,1
 1fe:	00000097          	auipc	ra,0x0
 202:	636080e7          	jalr	1590(ra) # 834 <socket>
 206:	84aa                	mv	s1,a0
  struct sockaddr_un addr;
  addr.family = AF_UNIX;
 208:	4785                	li	a5,1
 20a:	f6f41823          	sh	a5,-144(s0)
  strcpy(addr.path, "/tmp/netfull.sock");
 20e:	00001597          	auipc	a1,0x1
 212:	b1258593          	addi	a1,a1,-1262 # d20 <malloc+0x10c>
 216:	f7240513          	addi	a0,s0,-142
 21a:	00000097          	auipc	ra,0x0
 21e:	10a080e7          	jalr	266(ra) # 324 <strcpy>
  
  if(connect(fd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
 222:	06e00613          	li	a2,110
 226:	f7040593          	addi	a1,s0,-144
 22a:	8526                	mv	a0,s1
 22c:	00000097          	auipc	ra,0x0
 230:	630080e7          	jalr	1584(ra) # 85c <connect>
 234:	06054663          	bltz	a0,2a0 <client+0xbc>
      printf("[CLIENT] connect failed\n");
      exit(1);
  }
  
  printf("[CLIENT] Connected. Writing via write()...\n");
 238:	00001517          	auipc	a0,0x1
 23c:	cb050513          	addi	a0,a0,-848 # ee8 <malloc+0x2d4>
 240:	00001097          	auipc	ra,0x1
 244:	91c080e7          	jalr	-1764(ra) # b5c <printf>
  write(fd, "Hello", 5);
 248:	4615                	li	a2,5
 24a:	00001597          	auipc	a1,0x1
 24e:	cce58593          	addi	a1,a1,-818 # f18 <malloc+0x304>
 252:	8526                	mv	a0,s1
 254:	00000097          	auipc	ra,0x0
 258:	3a8080e7          	jalr	936(ra) # 5fc <write>
  
  // Wait for reply via poll
  struct pollfd pfd;
  pfd.fd = fd;
 25c:	f6942423          	sw	s1,-152(s0)
  pfd.events = POLLIN;
 260:	4785                	li	a5,1
 262:	f6f41623          	sh	a5,-148(s0)
  if(poll(&pfd, 1, 2000) > 0) {
 266:	7d000613          	li	a2,2000
 26a:	4585                	li	a1,1
 26c:	f6840513          	addi	a0,s0,-152
 270:	00000097          	auipc	ra,0x0
 274:	56a080e7          	jalr	1386(ra) # 7da <poll>
 278:	04a04163          	bgtz	a0,2ba <client+0xd6>
          buf[n] = 0;
          printf("[CLIENT] Read reply: %s\n", buf);
      }
  }
  
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	386080e7          	jalr	902(ra) # 604 <close>
  printf("[CLIENT] Done\n");
 286:	00001517          	auipc	a0,0x1
 28a:	cba50513          	addi	a0,a0,-838 # f40 <malloc+0x32c>
 28e:	00001097          	auipc	ra,0x1
 292:	8ce080e7          	jalr	-1842(ra) # b5c <printf>
  // return; // Let parent wait
  exit(0); // Actually if we use exit, main loop logic needs to be careful
 296:	4501                	li	a0,0
 298:	00000097          	auipc	ra,0x0
 29c:	344080e7          	jalr	836(ra) # 5dc <exit>
      printf("[CLIENT] connect failed\n");
 2a0:	00001517          	auipc	a0,0x1
 2a4:	c2850513          	addi	a0,a0,-984 # ec8 <malloc+0x2b4>
 2a8:	00001097          	auipc	ra,0x1
 2ac:	8b4080e7          	jalr	-1868(ra) # b5c <printf>
      exit(1);
 2b0:	4505                	li	a0,1
 2b2:	00000097          	auipc	ra,0x0
 2b6:	32a080e7          	jalr	810(ra) # 5dc <exit>
      int n = read(fd, buf, sizeof(buf));
 2ba:	02000613          	li	a2,32
 2be:	f4840593          	addi	a1,s0,-184
 2c2:	8526                	mv	a0,s1
 2c4:	00000097          	auipc	ra,0x0
 2c8:	330080e7          	jalr	816(ra) # 5f4 <read>
      if(n > 0) {
 2cc:	faa058e3          	blez	a0,27c <client+0x98>
          buf[n] = 0;
 2d0:	fe050793          	addi	a5,a0,-32
 2d4:	00878533          	add	a0,a5,s0
 2d8:	f6050423          	sb	zero,-152(a0)
          printf("[CLIENT] Read reply: %s\n", buf);
 2dc:	f4840593          	addi	a1,s0,-184
 2e0:	00001517          	auipc	a0,0x1
 2e4:	c4050513          	addi	a0,a0,-960 # f20 <malloc+0x30c>
 2e8:	00001097          	auipc	ra,0x1
 2ec:	874080e7          	jalr	-1932(ra) # b5c <printf>
 2f0:	b771                	j	27c <client+0x98>

00000000000002f2 <main>:
}

int main() {
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e406                	sd	ra,8(sp)
 2f6:	e022                	sd	s0,0(sp)
 2f8:	0800                	addi	s0,sp,16
    printf("=== Net Full Integration Test ===\n");
 2fa:	00001517          	auipc	a0,0x1
 2fe:	c5650513          	addi	a0,a0,-938 # f50 <malloc+0x33c>
 302:	00001097          	auipc	ra,0x1
 306:	85a080e7          	jalr	-1958(ra) # b5c <printf>
    
    int pid = fork();
 30a:	00000097          	auipc	ra,0x0
 30e:	2ca080e7          	jalr	714(ra) # 5d4 <fork>
    if(pid == 0) {
 312:	e509                	bnez	a0,31c <main+0x2a>
        server();
 314:	00000097          	auipc	ra,0x0
 318:	cec080e7          	jalr	-788(ra) # 0 <server>
    } else {
        client();
 31c:	00000097          	auipc	ra,0x0
 320:	ec8080e7          	jalr	-312(ra) # 1e4 <client>

0000000000000324 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 32a:	87aa                	mv	a5,a0
 32c:	0585                	addi	a1,a1,1
 32e:	0785                	addi	a5,a5,1
 330:	fff5c703          	lbu	a4,-1(a1)
 334:	fee78fa3          	sb	a4,-1(a5)
 338:	fb75                	bnez	a4,32c <strcpy+0x8>
    ;
  return os;
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret

0000000000000340 <strcat>:

char*
strcat(char *s, const char *t)
{
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 346:	00054783          	lbu	a5,0(a0)
 34a:	c385                	beqz	a5,36a <strcat+0x2a>
 34c:	87aa                	mv	a5,a0
    s++;
 34e:	0785                	addi	a5,a5,1
  while(*s)
 350:	0007c703          	lbu	a4,0(a5)
 354:	ff6d                	bnez	a4,34e <strcat+0xe>
  while((*s++ = *t++))
 356:	0585                	addi	a1,a1,1
 358:	0785                	addi	a5,a5,1
 35a:	fff5c703          	lbu	a4,-1(a1)
 35e:	fee78fa3          	sb	a4,-1(a5)
 362:	fb75                	bnez	a4,356 <strcat+0x16>
    ;
  return os;
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
  while(*s)
 36a:	87aa                	mv	a5,a0
 36c:	b7ed                	j	356 <strcat+0x16>

000000000000036e <strcmp>:


int
strcmp(const char *p, const char *q)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 374:	00054783          	lbu	a5,0(a0)
 378:	cb91                	beqz	a5,38c <strcmp+0x1e>
 37a:	0005c703          	lbu	a4,0(a1)
 37e:	00f71763          	bne	a4,a5,38c <strcmp+0x1e>
    p++, q++;
 382:	0505                	addi	a0,a0,1
 384:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 386:	00054783          	lbu	a5,0(a0)
 38a:	fbe5                	bnez	a5,37a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 38c:	0005c503          	lbu	a0,0(a1)
}
 390:	40a7853b          	subw	a0,a5,a0
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <strlen>:

uint
strlen(const char *s)
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	cf91                	beqz	a5,3c0 <strlen+0x26>
 3a6:	0505                	addi	a0,a0,1
 3a8:	87aa                	mv	a5,a0
 3aa:	4685                	li	a3,1
 3ac:	9e89                	subw	a3,a3,a0
 3ae:	00f6853b          	addw	a0,a3,a5
 3b2:	0785                	addi	a5,a5,1
 3b4:	fff7c703          	lbu	a4,-1(a5)
 3b8:	fb7d                	bnez	a4,3ae <strlen+0x14>
    ;
  return n;
}
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
  for(n = 0; s[n]; n++)
 3c0:	4501                	li	a0,0
 3c2:	bfe5                	j	3ba <strlen+0x20>

00000000000003c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3ca:	ca19                	beqz	a2,3e0 <memset+0x1c>
 3cc:	87aa                	mv	a5,a0
 3ce:	1602                	slli	a2,a2,0x20
 3d0:	9201                	srli	a2,a2,0x20
 3d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3da:	0785                	addi	a5,a5,1
 3dc:	fee79de3          	bne	a5,a4,3d6 <memset+0x12>
  }
  return dst;
}
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <strchr>:

char*
strchr(const char *s, char c)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e422                	sd	s0,8(sp)
 3ea:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3ec:	00054783          	lbu	a5,0(a0)
 3f0:	cb99                	beqz	a5,406 <strchr+0x20>
    if(*s == c)
 3f2:	00f58763          	beq	a1,a5,400 <strchr+0x1a>
  for(; *s; s++)
 3f6:	0505                	addi	a0,a0,1
 3f8:	00054783          	lbu	a5,0(a0)
 3fc:	fbfd                	bnez	a5,3f2 <strchr+0xc>
      return (char*)s;
  return 0;
 3fe:	4501                	li	a0,0
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
  return 0;
 406:	4501                	li	a0,0
 408:	bfe5                	j	400 <strchr+0x1a>

000000000000040a <gets>:

char*
gets(char *buf, int max)
{
 40a:	711d                	addi	sp,sp,-96
 40c:	ec86                	sd	ra,88(sp)
 40e:	e8a2                	sd	s0,80(sp)
 410:	e4a6                	sd	s1,72(sp)
 412:	e0ca                	sd	s2,64(sp)
 414:	fc4e                	sd	s3,56(sp)
 416:	f852                	sd	s4,48(sp)
 418:	f456                	sd	s5,40(sp)
 41a:	f05a                	sd	s6,32(sp)
 41c:	ec5e                	sd	s7,24(sp)
 41e:	e862                	sd	s8,16(sp)
 420:	1080                	addi	s0,sp,96
 422:	8baa                	mv	s7,a0
 424:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 426:	892a                	mv	s2,a0
 428:	4481                	li	s1,0
    cc = read(0, &c, 1);
 42a:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 42e:	4b29                	li	s6,10
 430:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 432:	89a6                	mv	s3,s1
 434:	2485                	addiw	s1,s1,1
 436:	0344d763          	bge	s1,s4,464 <gets+0x5a>
    cc = read(0, &c, 1);
 43a:	4605                	li	a2,1
 43c:	85d6                	mv	a1,s5
 43e:	4501                	li	a0,0
 440:	00000097          	auipc	ra,0x0
 444:	1b4080e7          	jalr	436(ra) # 5f4 <read>
    if(cc < 1)
 448:	00a05e63          	blez	a0,464 <gets+0x5a>
    buf[i++] = c;
 44c:	faf44783          	lbu	a5,-81(s0)
 450:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 454:	01678763          	beq	a5,s6,462 <gets+0x58>
 458:	0905                	addi	s2,s2,1
 45a:	fd879ce3          	bne	a5,s8,432 <gets+0x28>
  for(i=0; i+1 < max; ){
 45e:	89a6                	mv	s3,s1
 460:	a011                	j	464 <gets+0x5a>
 462:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 464:	99de                	add	s3,s3,s7
 466:	00098023          	sb	zero,0(s3)
  return buf;
}
 46a:	855e                	mv	a0,s7
 46c:	60e6                	ld	ra,88(sp)
 46e:	6446                	ld	s0,80(sp)
 470:	64a6                	ld	s1,72(sp)
 472:	6906                	ld	s2,64(sp)
 474:	79e2                	ld	s3,56(sp)
 476:	7a42                	ld	s4,48(sp)
 478:	7aa2                	ld	s5,40(sp)
 47a:	7b02                	ld	s6,32(sp)
 47c:	6be2                	ld	s7,24(sp)
 47e:	6c42                	ld	s8,16(sp)
 480:	6125                	addi	sp,sp,96
 482:	8082                	ret

0000000000000484 <stat>:

int
stat(const char *n, struct stat *st)
{
 484:	1101                	addi	sp,sp,-32
 486:	ec06                	sd	ra,24(sp)
 488:	e822                	sd	s0,16(sp)
 48a:	e426                	sd	s1,8(sp)
 48c:	e04a                	sd	s2,0(sp)
 48e:	1000                	addi	s0,sp,32
 490:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 492:	4581                	li	a1,0
 494:	00000097          	auipc	ra,0x0
 498:	188080e7          	jalr	392(ra) # 61c <open>
  if(fd < 0)
 49c:	02054563          	bltz	a0,4c6 <stat+0x42>
 4a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4a2:	85ca                	mv	a1,s2
 4a4:	00000097          	auipc	ra,0x0
 4a8:	180080e7          	jalr	384(ra) # 624 <fstat>
 4ac:	892a                	mv	s2,a0
  close(fd);
 4ae:	8526                	mv	a0,s1
 4b0:	00000097          	auipc	ra,0x0
 4b4:	154080e7          	jalr	340(ra) # 604 <close>
  return r;
}
 4b8:	854a                	mv	a0,s2
 4ba:	60e2                	ld	ra,24(sp)
 4bc:	6442                	ld	s0,16(sp)
 4be:	64a2                	ld	s1,8(sp)
 4c0:	6902                	ld	s2,0(sp)
 4c2:	6105                	addi	sp,sp,32
 4c4:	8082                	ret
    return -1;
 4c6:	597d                	li	s2,-1
 4c8:	bfc5                	j	4b8 <stat+0x34>

00000000000004ca <atoi>:

int
atoi(const char *s)
{
 4ca:	1141                	addi	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 4d0:	00054703          	lbu	a4,0(a0)
 4d4:	02d00793          	li	a5,45
  int neg = 1;
 4d8:	4585                	li	a1,1
  if (*s == '-') {
 4da:	04f70363          	beq	a4,a5,520 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 4de:	00054703          	lbu	a4,0(a0)
 4e2:	fd07079b          	addiw	a5,a4,-48
 4e6:	0ff7f793          	zext.b	a5,a5
 4ea:	46a5                	li	a3,9
 4ec:	02f6ed63          	bltu	a3,a5,526 <atoi+0x5c>
  n = 0;
 4f0:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 4f2:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 4f4:	0505                	addi	a0,a0,1
 4f6:	0026979b          	slliw	a5,a3,0x2
 4fa:	9fb5                	addw	a5,a5,a3
 4fc:	0017979b          	slliw	a5,a5,0x1
 500:	9fb9                	addw	a5,a5,a4
 502:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 506:	00054703          	lbu	a4,0(a0)
 50a:	fd07079b          	addiw	a5,a4,-48
 50e:	0ff7f793          	zext.b	a5,a5
 512:	fef671e3          	bgeu	a2,a5,4f4 <atoi+0x2a>
  return n * neg;
}
 516:	02d5853b          	mulw	a0,a1,a3
 51a:	6422                	ld	s0,8(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret
    s++;
 520:	0505                	addi	a0,a0,1
    neg = -1;
 522:	55fd                	li	a1,-1
 524:	bf6d                	j	4de <atoi+0x14>
  n = 0;
 526:	4681                	li	a3,0
 528:	b7fd                	j	516 <atoi+0x4c>

000000000000052a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 52a:	1141                	addi	sp,sp,-16
 52c:	e422                	sd	s0,8(sp)
 52e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 530:	02b57463          	bgeu	a0,a1,558 <memmove+0x2e>
    while(n-- > 0)
 534:	00c05f63          	blez	a2,552 <memmove+0x28>
 538:	1602                	slli	a2,a2,0x20
 53a:	9201                	srli	a2,a2,0x20
 53c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 540:	872a                	mv	a4,a0
      *dst++ = *src++;
 542:	0585                	addi	a1,a1,1
 544:	0705                	addi	a4,a4,1
 546:	fff5c683          	lbu	a3,-1(a1)
 54a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 54e:	fee79ae3          	bne	a5,a4,542 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 552:	6422                	ld	s0,8(sp)
 554:	0141                	addi	sp,sp,16
 556:	8082                	ret
    dst += n;
 558:	00c50733          	add	a4,a0,a2
    src += n;
 55c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 55e:	fec05ae3          	blez	a2,552 <memmove+0x28>
 562:	fff6079b          	addiw	a5,a2,-1
 566:	1782                	slli	a5,a5,0x20
 568:	9381                	srli	a5,a5,0x20
 56a:	fff7c793          	not	a5,a5
 56e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 570:	15fd                	addi	a1,a1,-1
 572:	177d                	addi	a4,a4,-1
 574:	0005c683          	lbu	a3,0(a1)
 578:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 57c:	fee79ae3          	bne	a5,a4,570 <memmove+0x46>
 580:	bfc9                	j	552 <memmove+0x28>

0000000000000582 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 582:	1141                	addi	sp,sp,-16
 584:	e422                	sd	s0,8(sp)
 586:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 588:	ca05                	beqz	a2,5b8 <memcmp+0x36>
 58a:	fff6069b          	addiw	a3,a2,-1
 58e:	1682                	slli	a3,a3,0x20
 590:	9281                	srli	a3,a3,0x20
 592:	0685                	addi	a3,a3,1
 594:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 596:	00054783          	lbu	a5,0(a0)
 59a:	0005c703          	lbu	a4,0(a1)
 59e:	00e79863          	bne	a5,a4,5ae <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5a2:	0505                	addi	a0,a0,1
    p2++;
 5a4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5a6:	fed518e3          	bne	a0,a3,596 <memcmp+0x14>
  }
  return 0;
 5aa:	4501                	li	a0,0
 5ac:	a019                	j	5b2 <memcmp+0x30>
      return *p1 - *p2;
 5ae:	40e7853b          	subw	a0,a5,a4
}
 5b2:	6422                	ld	s0,8(sp)
 5b4:	0141                	addi	sp,sp,16
 5b6:	8082                	ret
  return 0;
 5b8:	4501                	li	a0,0
 5ba:	bfe5                	j	5b2 <memcmp+0x30>

00000000000005bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5bc:	1141                	addi	sp,sp,-16
 5be:	e406                	sd	ra,8(sp)
 5c0:	e022                	sd	s0,0(sp)
 5c2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5c4:	00000097          	auipc	ra,0x0
 5c8:	f66080e7          	jalr	-154(ra) # 52a <memmove>
}
 5cc:	60a2                	ld	ra,8(sp)
 5ce:	6402                	ld	s0,0(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret

00000000000005d4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 5d4:	4885                	li	a7,1
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 5dc:	4889                	li	a7,2
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5e4:	488d                	li	a7,3
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5ec:	4891                	li	a7,4
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <read>:
.global read
read:
 li a7, SYS_read
 5f4:	4895                	li	a7,5
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <write>:
.global write
write:
 li a7, SYS_write
 5fc:	48c1                	li	a7,16
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <close>:
.global close
close:
 li a7, SYS_close
 604:	48d5                	li	a7,21
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <kill>:
.global kill
kill:
 li a7, SYS_kill
 60c:	4899                	li	a7,6
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <exec>:
.global exec
exec:
 li a7, SYS_exec
 614:	489d                	li	a7,7
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <open>:
.global open
open:
 li a7, SYS_open
 61c:	48bd                	li	a7,15
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 624:	48a1                	li	a7,8
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 62c:	48d1                	li	a7,20
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 634:	48a5                	li	a7,9
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <dup>:
.global dup
dup:
 li a7, SYS_dup
 63c:	48a9                	li	a7,10
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 644:	48ad                	li	a7,11
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 64c:	48b1                	li	a7,12
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 654:	48b5                	li	a7,13
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 65c:	48b9                	li	a7,14
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 664:	48d9                	li	a7,22
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <dev>:
.global dev
dev:
 li a7, SYS_dev
 66c:	48dd                	li	a7,23
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 674:	48e1                	li	a7,24
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 67c:	48e5                	li	a7,25
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <remove>:
.global remove
remove:
 li a7, SYS_remove
 684:	48c5                	li	a7,17
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <trace>:
.global trace
trace:
 li a7, SYS_trace
 68c:	48c9                	li	a7,18
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 694:	48cd                	li	a7,19
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <rename>:
.global rename
rename:
 li a7, SYS_rename
 69c:	48e9                	li	a7,26
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 6a4:	48ed                	li	a7,27
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 6ac:	48f1                	li	a7,28
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 6b4:	48f5                	li	a7,29
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 6bc:	48f9                	li	a7,30
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 6c4:	48fd                	li	a7,31
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 6cc:	02000893          	li	a7,32
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 6d6:	02100893          	li	a7,33
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 6e0:	02200893          	li	a7,34
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 6ea:	02300893          	li	a7,35
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 6f4:	02400893          	li	a7,36
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 6fe:	02500893          	li	a7,37
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 708:	02600893          	li	a7,38
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 712:	02700893          	li	a7,39
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 71c:	02800893          	li	a7,40
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 726:	02900893          	li	a7,41
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 730:	02a00893          	li	a7,42
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 73a:	02b00893          	li	a7,43
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 744:	02c00893          	li	a7,44
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 74e:	02d00893          	li	a7,45
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 758:	02e00893          	li	a7,46
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 762:	02f00893          	li	a7,47
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 76c:	03000893          	li	a7,48
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 776:	03100893          	li	a7,49
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 780:	03200893          	li	a7,50
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 78a:	03300893          	li	a7,51
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 794:	03400893          	li	a7,52
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 79e:	03500893          	li	a7,53
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 7a8:	03600893          	li	a7,54
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 7b2:	03700893          	li	a7,55
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 7bc:	03800893          	li	a7,56
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 7c6:	03900893          	li	a7,57
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 7d0:	03a00893          	li	a7,58
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <poll>:
.global poll
poll:
 li a7, SYS_poll
 7da:	03b00893          	li	a7,59
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 7e4:	03c00893          	li	a7,60
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 7ee:	03d00893          	li	a7,61
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 7f8:	03e00893          	li	a7,62
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <clone>:
.global clone
clone:
 li a7, SYS_clone
 802:	03f00893          	li	a7,63
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <futex>:
.global futex
futex:
 li a7, SYS_futex
 80c:	04000893          	li	a7,64
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 816:	04100893          	li	a7,65
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <halt>:
.global halt
halt:
 li a7, SYS_halt
 820:	04200893          	li	a7,66
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 82a:	04300893          	li	a7,67
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <socket>:
.global socket
socket:
 li a7, SYS_socket
 834:	04400893          	li	a7,68
 ecall
 838:	00000073          	ecall
 ret
 83c:	8082                	ret

000000000000083e <bind>:
.global bind
bind:
 li a7, SYS_bind
 83e:	04500893          	li	a7,69
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <listen>:
.global listen
listen:
 li a7, SYS_listen
 848:	04600893          	li	a7,70
 ecall
 84c:	00000073          	ecall
 ret
 850:	8082                	ret

0000000000000852 <accept>:
.global accept
accept:
 li a7, SYS_accept
 852:	04700893          	li	a7,71
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <connect>:
.global connect
connect:
 li a7, SYS_connect
 85c:	04800893          	li	a7,72
 ecall
 860:	00000073          	ecall
 ret
 864:	8082                	ret

0000000000000866 <send>:
.global send
send:
 li a7, SYS_send
 866:	04900893          	li	a7,73
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <recv>:
.global recv
recv:
 li a7, SYS_recv
 870:	04a00893          	li	a7,74
 ecall
 874:	00000073          	ecall
 ret
 878:	8082                	ret

000000000000087a <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 87a:	04b00893          	li	a7,75
 ecall
 87e:	00000073          	ecall
 ret
 882:	8082                	ret

0000000000000884 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 884:	1101                	addi	sp,sp,-32
 886:	ec06                	sd	ra,24(sp)
 888:	e822                	sd	s0,16(sp)
 88a:	1000                	addi	s0,sp,32
 88c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 890:	4605                	li	a2,1
 892:	fef40593          	addi	a1,s0,-17
 896:	00000097          	auipc	ra,0x0
 89a:	d66080e7          	jalr	-666(ra) # 5fc <write>
}
 89e:	60e2                	ld	ra,24(sp)
 8a0:	6442                	ld	s0,16(sp)
 8a2:	6105                	addi	sp,sp,32
 8a4:	8082                	ret

00000000000008a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8a6:	7139                	addi	sp,sp,-64
 8a8:	fc06                	sd	ra,56(sp)
 8aa:	f822                	sd	s0,48(sp)
 8ac:	f426                	sd	s1,40(sp)
 8ae:	f04a                	sd	s2,32(sp)
 8b0:	ec4e                	sd	s3,24(sp)
 8b2:	0080                	addi	s0,sp,64
 8b4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8b6:	c299                	beqz	a3,8bc <printint+0x16>
 8b8:	0805c863          	bltz	a1,948 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8bc:	2581                	sext.w	a1,a1
  neg = 0;
 8be:	4881                	li	a7,0
  }

  i = 0;
 8c0:	fc040993          	addi	s3,s0,-64
  neg = 0;
 8c4:	86ce                	mv	a3,s3
  i = 0;
 8c6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8c8:	2601                	sext.w	a2,a2
 8ca:	00000517          	auipc	a0,0x0
 8ce:	70e50513          	addi	a0,a0,1806 # fd8 <digits>
 8d2:	883a                	mv	a6,a4
 8d4:	2705                	addiw	a4,a4,1
 8d6:	02c5f7bb          	remuw	a5,a1,a2
 8da:	1782                	slli	a5,a5,0x20
 8dc:	9381                	srli	a5,a5,0x20
 8de:	97aa                	add	a5,a5,a0
 8e0:	0007c783          	lbu	a5,0(a5)
 8e4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8e8:	0005879b          	sext.w	a5,a1
 8ec:	02c5d5bb          	divuw	a1,a1,a2
 8f0:	0685                	addi	a3,a3,1
 8f2:	fec7f0e3          	bgeu	a5,a2,8d2 <printint+0x2c>
  if(neg)
 8f6:	00088c63          	beqz	a7,90e <printint+0x68>
    buf[i++] = '-';
 8fa:	fd070793          	addi	a5,a4,-48
 8fe:	00878733          	add	a4,a5,s0
 902:	02d00793          	li	a5,45
 906:	fef70823          	sb	a5,-16(a4)
 90a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 90e:	02e05663          	blez	a4,93a <printint+0x94>
 912:	fc040913          	addi	s2,s0,-64
 916:	993a                	add	s2,s2,a4
 918:	19fd                	addi	s3,s3,-1
 91a:	99ba                	add	s3,s3,a4
 91c:	377d                	addiw	a4,a4,-1
 91e:	1702                	slli	a4,a4,0x20
 920:	9301                	srli	a4,a4,0x20
 922:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 926:	fff94583          	lbu	a1,-1(s2)
 92a:	8526                	mv	a0,s1
 92c:	00000097          	auipc	ra,0x0
 930:	f58080e7          	jalr	-168(ra) # 884 <putc>
  while(--i >= 0)
 934:	197d                	addi	s2,s2,-1
 936:	ff3918e3          	bne	s2,s3,926 <printint+0x80>
}
 93a:	70e2                	ld	ra,56(sp)
 93c:	7442                	ld	s0,48(sp)
 93e:	74a2                	ld	s1,40(sp)
 940:	7902                	ld	s2,32(sp)
 942:	69e2                	ld	s3,24(sp)
 944:	6121                	addi	sp,sp,64
 946:	8082                	ret
    x = -xx;
 948:	40b005bb          	negw	a1,a1
    neg = 1;
 94c:	4885                	li	a7,1
    x = -xx;
 94e:	bf8d                	j	8c0 <printint+0x1a>

0000000000000950 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 950:	7119                	addi	sp,sp,-128
 952:	fc86                	sd	ra,120(sp)
 954:	f8a2                	sd	s0,112(sp)
 956:	f4a6                	sd	s1,104(sp)
 958:	f0ca                	sd	s2,96(sp)
 95a:	ecce                	sd	s3,88(sp)
 95c:	e8d2                	sd	s4,80(sp)
 95e:	e4d6                	sd	s5,72(sp)
 960:	e0da                	sd	s6,64(sp)
 962:	fc5e                	sd	s7,56(sp)
 964:	f862                	sd	s8,48(sp)
 966:	f466                	sd	s9,40(sp)
 968:	f06a                	sd	s10,32(sp)
 96a:	ec6e                	sd	s11,24(sp)
 96c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 96e:	0005c903          	lbu	s2,0(a1)
 972:	18090f63          	beqz	s2,b10 <vprintf+0x1c0>
 976:	8aaa                	mv	s5,a0
 978:	8b32                	mv	s6,a2
 97a:	00158493          	addi	s1,a1,1
  state = 0;
 97e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 980:	02500a13          	li	s4,37
 984:	4c55                	li	s8,21
 986:	00000c97          	auipc	s9,0x0
 98a:	5fac8c93          	addi	s9,s9,1530 # f80 <malloc+0x36c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 98e:	02800d93          	li	s11,40
  putc(fd, 'x');
 992:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 994:	00000b97          	auipc	s7,0x0
 998:	644b8b93          	addi	s7,s7,1604 # fd8 <digits>
 99c:	a839                	j	9ba <vprintf+0x6a>
        putc(fd, c);
 99e:	85ca                	mv	a1,s2
 9a0:	8556                	mv	a0,s5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	ee2080e7          	jalr	-286(ra) # 884 <putc>
 9aa:	a019                	j	9b0 <vprintf+0x60>
    } else if(state == '%'){
 9ac:	01498d63          	beq	s3,s4,9c6 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 9b0:	0485                	addi	s1,s1,1
 9b2:	fff4c903          	lbu	s2,-1(s1)
 9b6:	14090d63          	beqz	s2,b10 <vprintf+0x1c0>
    if(state == 0){
 9ba:	fe0999e3          	bnez	s3,9ac <vprintf+0x5c>
      if(c == '%'){
 9be:	ff4910e3          	bne	s2,s4,99e <vprintf+0x4e>
        state = '%';
 9c2:	89d2                	mv	s3,s4
 9c4:	b7f5                	j	9b0 <vprintf+0x60>
      if(c == 'd'){
 9c6:	11490c63          	beq	s2,s4,ade <vprintf+0x18e>
 9ca:	f9d9079b          	addiw	a5,s2,-99
 9ce:	0ff7f793          	zext.b	a5,a5
 9d2:	10fc6e63          	bltu	s8,a5,aee <vprintf+0x19e>
 9d6:	f9d9079b          	addiw	a5,s2,-99
 9da:	0ff7f713          	zext.b	a4,a5
 9de:	10ec6863          	bltu	s8,a4,aee <vprintf+0x19e>
 9e2:	00271793          	slli	a5,a4,0x2
 9e6:	97e6                	add	a5,a5,s9
 9e8:	439c                	lw	a5,0(a5)
 9ea:	97e6                	add	a5,a5,s9
 9ec:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9ee:	008b0913          	addi	s2,s6,8
 9f2:	4685                	li	a3,1
 9f4:	4629                	li	a2,10
 9f6:	000b2583          	lw	a1,0(s6)
 9fa:	8556                	mv	a0,s5
 9fc:	00000097          	auipc	ra,0x0
 a00:	eaa080e7          	jalr	-342(ra) # 8a6 <printint>
 a04:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a06:	4981                	li	s3,0
 a08:	b765                	j	9b0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a0a:	008b0913          	addi	s2,s6,8
 a0e:	4681                	li	a3,0
 a10:	4629                	li	a2,10
 a12:	000b2583          	lw	a1,0(s6)
 a16:	8556                	mv	a0,s5
 a18:	00000097          	auipc	ra,0x0
 a1c:	e8e080e7          	jalr	-370(ra) # 8a6 <printint>
 a20:	8b4a                	mv	s6,s2
      state = 0;
 a22:	4981                	li	s3,0
 a24:	b771                	j	9b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 a26:	008b0913          	addi	s2,s6,8
 a2a:	4681                	li	a3,0
 a2c:	866a                	mv	a2,s10
 a2e:	000b2583          	lw	a1,0(s6)
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	e72080e7          	jalr	-398(ra) # 8a6 <printint>
 a3c:	8b4a                	mv	s6,s2
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	bf85                	j	9b0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a42:	008b0793          	addi	a5,s6,8
 a46:	f8f43423          	sd	a5,-120(s0)
 a4a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a4e:	03000593          	li	a1,48
 a52:	8556                	mv	a0,s5
 a54:	00000097          	auipc	ra,0x0
 a58:	e30080e7          	jalr	-464(ra) # 884 <putc>
  putc(fd, 'x');
 a5c:	07800593          	li	a1,120
 a60:	8556                	mv	a0,s5
 a62:	00000097          	auipc	ra,0x0
 a66:	e22080e7          	jalr	-478(ra) # 884 <putc>
 a6a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a6c:	03c9d793          	srli	a5,s3,0x3c
 a70:	97de                	add	a5,a5,s7
 a72:	0007c583          	lbu	a1,0(a5)
 a76:	8556                	mv	a0,s5
 a78:	00000097          	auipc	ra,0x0
 a7c:	e0c080e7          	jalr	-500(ra) # 884 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a80:	0992                	slli	s3,s3,0x4
 a82:	397d                	addiw	s2,s2,-1
 a84:	fe0914e3          	bnez	s2,a6c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 a88:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a8c:	4981                	li	s3,0
 a8e:	b70d                	j	9b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 a90:	008b0913          	addi	s2,s6,8
 a94:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 a98:	02098163          	beqz	s3,aba <vprintf+0x16a>
        while(*s != 0){
 a9c:	0009c583          	lbu	a1,0(s3)
 aa0:	c5ad                	beqz	a1,b0a <vprintf+0x1ba>
          putc(fd, *s);
 aa2:	8556                	mv	a0,s5
 aa4:	00000097          	auipc	ra,0x0
 aa8:	de0080e7          	jalr	-544(ra) # 884 <putc>
          s++;
 aac:	0985                	addi	s3,s3,1
        while(*s != 0){
 aae:	0009c583          	lbu	a1,0(s3)
 ab2:	f9e5                	bnez	a1,aa2 <vprintf+0x152>
        s = va_arg(ap, char*);
 ab4:	8b4a                	mv	s6,s2
      state = 0;
 ab6:	4981                	li	s3,0
 ab8:	bde5                	j	9b0 <vprintf+0x60>
          s = "(null)";
 aba:	00000997          	auipc	s3,0x0
 abe:	4be98993          	addi	s3,s3,1214 # f78 <malloc+0x364>
        while(*s != 0){
 ac2:	85ee                	mv	a1,s11
 ac4:	bff9                	j	aa2 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 ac6:	008b0913          	addi	s2,s6,8
 aca:	000b4583          	lbu	a1,0(s6)
 ace:	8556                	mv	a0,s5
 ad0:	00000097          	auipc	ra,0x0
 ad4:	db4080e7          	jalr	-588(ra) # 884 <putc>
 ad8:	8b4a                	mv	s6,s2
      state = 0;
 ada:	4981                	li	s3,0
 adc:	bdd1                	j	9b0 <vprintf+0x60>
        putc(fd, c);
 ade:	85d2                	mv	a1,s4
 ae0:	8556                	mv	a0,s5
 ae2:	00000097          	auipc	ra,0x0
 ae6:	da2080e7          	jalr	-606(ra) # 884 <putc>
      state = 0;
 aea:	4981                	li	s3,0
 aec:	b5d1                	j	9b0 <vprintf+0x60>
        putc(fd, '%');
 aee:	85d2                	mv	a1,s4
 af0:	8556                	mv	a0,s5
 af2:	00000097          	auipc	ra,0x0
 af6:	d92080e7          	jalr	-622(ra) # 884 <putc>
        putc(fd, c);
 afa:	85ca                	mv	a1,s2
 afc:	8556                	mv	a0,s5
 afe:	00000097          	auipc	ra,0x0
 b02:	d86080e7          	jalr	-634(ra) # 884 <putc>
      state = 0;
 b06:	4981                	li	s3,0
 b08:	b565                	j	9b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 b0a:	8b4a                	mv	s6,s2
      state = 0;
 b0c:	4981                	li	s3,0
 b0e:	b54d                	j	9b0 <vprintf+0x60>
    }
  }
}
 b10:	70e6                	ld	ra,120(sp)
 b12:	7446                	ld	s0,112(sp)
 b14:	74a6                	ld	s1,104(sp)
 b16:	7906                	ld	s2,96(sp)
 b18:	69e6                	ld	s3,88(sp)
 b1a:	6a46                	ld	s4,80(sp)
 b1c:	6aa6                	ld	s5,72(sp)
 b1e:	6b06                	ld	s6,64(sp)
 b20:	7be2                	ld	s7,56(sp)
 b22:	7c42                	ld	s8,48(sp)
 b24:	7ca2                	ld	s9,40(sp)
 b26:	7d02                	ld	s10,32(sp)
 b28:	6de2                	ld	s11,24(sp)
 b2a:	6109                	addi	sp,sp,128
 b2c:	8082                	ret

0000000000000b2e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b2e:	715d                	addi	sp,sp,-80
 b30:	ec06                	sd	ra,24(sp)
 b32:	e822                	sd	s0,16(sp)
 b34:	1000                	addi	s0,sp,32
 b36:	e010                	sd	a2,0(s0)
 b38:	e414                	sd	a3,8(s0)
 b3a:	e818                	sd	a4,16(s0)
 b3c:	ec1c                	sd	a5,24(s0)
 b3e:	03043023          	sd	a6,32(s0)
 b42:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b46:	8622                	mv	a2,s0
 b48:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b4c:	00000097          	auipc	ra,0x0
 b50:	e04080e7          	jalr	-508(ra) # 950 <vprintf>
}
 b54:	60e2                	ld	ra,24(sp)
 b56:	6442                	ld	s0,16(sp)
 b58:	6161                	addi	sp,sp,80
 b5a:	8082                	ret

0000000000000b5c <printf>:

void
printf(const char *fmt, ...)
{
 b5c:	711d                	addi	sp,sp,-96
 b5e:	ec06                	sd	ra,24(sp)
 b60:	e822                	sd	s0,16(sp)
 b62:	1000                	addi	s0,sp,32
 b64:	e40c                	sd	a1,8(s0)
 b66:	e810                	sd	a2,16(s0)
 b68:	ec14                	sd	a3,24(s0)
 b6a:	f018                	sd	a4,32(s0)
 b6c:	f41c                	sd	a5,40(s0)
 b6e:	03043823          	sd	a6,48(s0)
 b72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b76:	00840613          	addi	a2,s0,8
 b7a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b7e:	85aa                	mv	a1,a0
 b80:	4505                	li	a0,1
 b82:	00000097          	auipc	ra,0x0
 b86:	dce080e7          	jalr	-562(ra) # 950 <vprintf>
}
 b8a:	60e2                	ld	ra,24(sp)
 b8c:	6442                	ld	s0,16(sp)
 b8e:	6125                	addi	sp,sp,96
 b90:	8082                	ret

0000000000000b92 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b92:	1141                	addi	sp,sp,-16
 b94:	e422                	sd	s0,8(sp)
 b96:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b98:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9c:	00000797          	auipc	a5,0x0
 ba0:	4547b783          	ld	a5,1108(a5) # ff0 <freep>
 ba4:	a02d                	j	bce <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ba6:	4618                	lw	a4,8(a2)
 ba8:	9f2d                	addw	a4,a4,a1
 baa:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bae:	6398                	ld	a4,0(a5)
 bb0:	6310                	ld	a2,0(a4)
 bb2:	a83d                	j	bf0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bb4:	ff852703          	lw	a4,-8(a0)
 bb8:	9f31                	addw	a4,a4,a2
 bba:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bbc:	ff053683          	ld	a3,-16(a0)
 bc0:	a091                	j	c04 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc2:	6398                	ld	a4,0(a5)
 bc4:	00e7e463          	bltu	a5,a4,bcc <free+0x3a>
 bc8:	00e6ea63          	bltu	a3,a4,bdc <free+0x4a>
{
 bcc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bce:	fed7fae3          	bgeu	a5,a3,bc2 <free+0x30>
 bd2:	6398                	ld	a4,0(a5)
 bd4:	00e6e463          	bltu	a3,a4,bdc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd8:	fee7eae3          	bltu	a5,a4,bcc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bdc:	ff852583          	lw	a1,-8(a0)
 be0:	6390                	ld	a2,0(a5)
 be2:	02059813          	slli	a6,a1,0x20
 be6:	01c85713          	srli	a4,a6,0x1c
 bea:	9736                	add	a4,a4,a3
 bec:	fae60de3          	beq	a2,a4,ba6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 bf0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 bf4:	4790                	lw	a2,8(a5)
 bf6:	02061593          	slli	a1,a2,0x20
 bfa:	01c5d713          	srli	a4,a1,0x1c
 bfe:	973e                	add	a4,a4,a5
 c00:	fae68ae3          	beq	a3,a4,bb4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 c04:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c06:	00000717          	auipc	a4,0x0
 c0a:	3ef73523          	sd	a5,1002(a4) # ff0 <freep>
}
 c0e:	6422                	ld	s0,8(sp)
 c10:	0141                	addi	sp,sp,16
 c12:	8082                	ret

0000000000000c14 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c14:	7139                	addi	sp,sp,-64
 c16:	fc06                	sd	ra,56(sp)
 c18:	f822                	sd	s0,48(sp)
 c1a:	f426                	sd	s1,40(sp)
 c1c:	f04a                	sd	s2,32(sp)
 c1e:	ec4e                	sd	s3,24(sp)
 c20:	e852                	sd	s4,16(sp)
 c22:	e456                	sd	s5,8(sp)
 c24:	e05a                	sd	s6,0(sp)
 c26:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c28:	02051493          	slli	s1,a0,0x20
 c2c:	9081                	srli	s1,s1,0x20
 c2e:	04bd                	addi	s1,s1,15
 c30:	8091                	srli	s1,s1,0x4
 c32:	00148a1b          	addiw	s4,s1,1
 c36:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c38:	00000517          	auipc	a0,0x0
 c3c:	3b853503          	ld	a0,952(a0) # ff0 <freep>
 c40:	c515                	beqz	a0,c6c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c42:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c44:	4798                	lw	a4,8(a5)
 c46:	04977163          	bgeu	a4,s1,c88 <malloc+0x74>
 c4a:	89d2                	mv	s3,s4
 c4c:	000a071b          	sext.w	a4,s4
 c50:	6685                	lui	a3,0x1
 c52:	00d77363          	bgeu	a4,a3,c58 <malloc+0x44>
 c56:	6985                	lui	s3,0x1
 c58:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 c5c:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c60:	00000917          	auipc	s2,0x0
 c64:	39090913          	addi	s2,s2,912 # ff0 <freep>
  if(p == (char*)-1)
 c68:	5afd                	li	s5,-1
 c6a:	a8a5                	j	ce2 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 c6c:	00000797          	auipc	a5,0x0
 c70:	38478793          	addi	a5,a5,900 # ff0 <freep>
 c74:	00000717          	auipc	a4,0x0
 c78:	38470713          	addi	a4,a4,900 # ff8 <base>
 c7c:	e398                	sd	a4,0(a5)
 c7e:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 c80:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c84:	87ba                	mv	a5,a4
 c86:	b7d1                	j	c4a <malloc+0x36>
      if(p->s.size == nunits)
 c88:	02e48c63          	beq	s1,a4,cc0 <malloc+0xac>
        p->s.size -= nunits;
 c8c:	4147073b          	subw	a4,a4,s4
 c90:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c92:	02071693          	slli	a3,a4,0x20
 c96:	01c6d713          	srli	a4,a3,0x1c
 c9a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c9c:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 ca0:	00000717          	auipc	a4,0x0
 ca4:	34a73823          	sd	a0,848(a4) # ff0 <freep>
      return (void*)(p + 1);
 ca8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cac:	70e2                	ld	ra,56(sp)
 cae:	7442                	ld	s0,48(sp)
 cb0:	74a2                	ld	s1,40(sp)
 cb2:	7902                	ld	s2,32(sp)
 cb4:	69e2                	ld	s3,24(sp)
 cb6:	6a42                	ld	s4,16(sp)
 cb8:	6aa2                	ld	s5,8(sp)
 cba:	6b02                	ld	s6,0(sp)
 cbc:	6121                	addi	sp,sp,64
 cbe:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 cc0:	6398                	ld	a4,0(a5)
 cc2:	e118                	sd	a4,0(a0)
 cc4:	bff1                	j	ca0 <malloc+0x8c>
  hp->s.size = nu;
 cc6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cca:	0541                	addi	a0,a0,16
 ccc:	00000097          	auipc	ra,0x0
 cd0:	ec6080e7          	jalr	-314(ra) # b92 <free>
  return freep;
 cd4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cd8:	d971                	beqz	a0,cac <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cda:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cdc:	4798                	lw	a4,8(a5)
 cde:	fa9775e3          	bgeu	a4,s1,c88 <malloc+0x74>
    if(p == freep)
 ce2:	00093703          	ld	a4,0(s2)
 ce6:	853e                	mv	a0,a5
 ce8:	fef719e3          	bne	a4,a5,cda <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 cec:	854e                	mv	a0,s3
 cee:	00000097          	auipc	ra,0x0
 cf2:	95e080e7          	jalr	-1698(ra) # 64c <sbrk>
  if(p == (char*)-1)
 cf6:	fd5518e3          	bne	a0,s5,cc6 <malloc+0xb2>
        return 0;
 cfa:	4501                	li	a0,0
 cfc:	bf45                	j	cac <malloc+0x98>
