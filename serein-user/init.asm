
serein-user/_init：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32

  // if(open("console", O_RDWR) < 0){
  //   mknod("console", CONSOLE, 0);
  //   open("console", O_RDWR);
  // }
  dev(O_RDWR, CONSOLE, 0);
   c:	4601                	li	a2,0
   e:	4585                	li	a1,1
  10:	4509                	li	a0,2
  12:	00000097          	auipc	ra,0x0
  16:	3fe080e7          	jalr	1022(ra) # 410 <dev>
  dup(0);  // stdout
  1a:	4501                	li	a0,0
  1c:	00000097          	auipc	ra,0x0
  20:	3c4080e7          	jalr	964(ra) # 3e0 <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	00000097          	auipc	ra,0x0
  2a:	3ba080e7          	jalr	954(ra) # 3e0 <dup>

  for(;;){
    printf("init: starting sh\n");
  2e:	00001917          	auipc	s2,0x1
  32:	a7a90913          	addi	s2,s2,-1414 # aa8 <malloc+0xf0>
  36:	854a                	mv	a0,s2
  38:	00001097          	auipc	ra,0x1
  3c:	8c8080e7          	jalr	-1848(ra) # 900 <printf>
    pid = fork();
  40:	00000097          	auipc	ra,0x0
  44:	338080e7          	jalr	824(ra) # 378 <fork>
  48:	84aa                	mv	s1,a0
    if(pid < 0){
  4a:	02054963          	bltz	a0,7c <main+0x7c>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  4e:	c521                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	336080e7          	jalr	822(ra) # 388 <wait>
      if(wpid == pid){
  5a:	fca48ee3          	beq	s1,a0,36 <main+0x36>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  5e:	fe0559e3          	bgez	a0,50 <main+0x50>
        printf("init: wait returned an error\n");
  62:	00001517          	auipc	a0,0x1
  66:	a9650513          	addi	a0,a0,-1386 # af8 <malloc+0x140>
  6a:	00001097          	auipc	ra,0x1
  6e:	896080e7          	jalr	-1898(ra) # 900 <printf>
        exit(1);
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	30c080e7          	jalr	780(ra) # 380 <exit>
      printf("init: fork failed\n");
  7c:	00001517          	auipc	a0,0x1
  80:	a4450513          	addi	a0,a0,-1468 # ac0 <malloc+0x108>
  84:	00001097          	auipc	ra,0x1
  88:	87c080e7          	jalr	-1924(ra) # 900 <printf>
      exit(1);
  8c:	4505                	li	a0,1
  8e:	00000097          	auipc	ra,0x0
  92:	2f2080e7          	jalr	754(ra) # 380 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	afa58593          	addi	a1,a1,-1286 # b90 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	a3a50513          	addi	a0,a0,-1478 # ad8 <malloc+0x120>
  a6:	00000097          	auipc	ra,0x0
  aa:	312080e7          	jalr	786(ra) # 3b8 <exec>
      printf("init: exec sh failed\n");
  ae:	00001517          	auipc	a0,0x1
  b2:	a3250513          	addi	a0,a0,-1486 # ae0 <malloc+0x128>
  b6:	00001097          	auipc	ra,0x1
  ba:	84a080e7          	jalr	-1974(ra) # 900 <printf>
      exit(1);
  be:	4505                	li	a0,1
  c0:	00000097          	auipc	ra,0x0
  c4:	2c0080e7          	jalr	704(ra) # 380 <exit>

00000000000000c8 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e422                	sd	s0,8(sp)
  cc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ce:	87aa                	mv	a5,a0
  d0:	0585                	addi	a1,a1,1
  d2:	0785                	addi	a5,a5,1
  d4:	fff5c703          	lbu	a4,-1(a1)
  d8:	fee78fa3          	sb	a4,-1(a5)
  dc:	fb75                	bnez	a4,d0 <strcpy+0x8>
    ;
  return os;
}
  de:	6422                	ld	s0,8(sp)
  e0:	0141                	addi	sp,sp,16
  e2:	8082                	ret

00000000000000e4 <strcat>:

char*
strcat(char *s, const char *t)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e422                	sd	s0,8(sp)
  e8:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  ea:	00054783          	lbu	a5,0(a0)
  ee:	c385                	beqz	a5,10e <strcat+0x2a>
  f0:	87aa                	mv	a5,a0
    s++;
  f2:	0785                	addi	a5,a5,1
  while(*s)
  f4:	0007c703          	lbu	a4,0(a5)
  f8:	ff6d                	bnez	a4,f2 <strcat+0xe>
  while((*s++ = *t++))
  fa:	0585                	addi	a1,a1,1
  fc:	0785                	addi	a5,a5,1
  fe:	fff5c703          	lbu	a4,-1(a1)
 102:	fee78fa3          	sb	a4,-1(a5)
 106:	fb75                	bnez	a4,fa <strcat+0x16>
    ;
  return os;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	addi	sp,sp,16
 10c:	8082                	ret
  while(*s)
 10e:	87aa                	mv	a5,a0
 110:	b7ed                	j	fa <strcat+0x16>

0000000000000112 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 112:	1141                	addi	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 118:	00054783          	lbu	a5,0(a0)
 11c:	cb91                	beqz	a5,130 <strcmp+0x1e>
 11e:	0005c703          	lbu	a4,0(a1)
 122:	00f71763          	bne	a4,a5,130 <strcmp+0x1e>
    p++, q++;
 126:	0505                	addi	a0,a0,1
 128:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	fbe5                	bnez	a5,11e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 130:	0005c503          	lbu	a0,0(a1)
}
 134:	40a7853b          	subw	a0,a5,a0
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strlen>:

uint
strlen(const char *s)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 144:	00054783          	lbu	a5,0(a0)
 148:	cf91                	beqz	a5,164 <strlen+0x26>
 14a:	0505                	addi	a0,a0,1
 14c:	87aa                	mv	a5,a0
 14e:	4685                	li	a3,1
 150:	9e89                	subw	a3,a3,a0
 152:	00f6853b          	addw	a0,a3,a5
 156:	0785                	addi	a5,a5,1
 158:	fff7c703          	lbu	a4,-1(a5)
 15c:	fb7d                	bnez	a4,152 <strlen+0x14>
    ;
  return n;
}
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret
  for(n = 0; s[n]; n++)
 164:	4501                	li	a0,0
 166:	bfe5                	j	15e <strlen+0x20>

0000000000000168 <memset>:

void*
memset(void *dst, int c, uint n)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 16e:	ca19                	beqz	a2,184 <memset+0x1c>
 170:	87aa                	mv	a5,a0
 172:	1602                	slli	a2,a2,0x20
 174:	9201                	srli	a2,a2,0x20
 176:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 17a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 17e:	0785                	addi	a5,a5,1
 180:	fee79de3          	bne	a5,a4,17a <memset+0x12>
  }
  return dst;
}
 184:	6422                	ld	s0,8(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret

000000000000018a <strchr>:

char*
strchr(const char *s, char c)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 190:	00054783          	lbu	a5,0(a0)
 194:	cb99                	beqz	a5,1aa <strchr+0x20>
    if(*s == c)
 196:	00f58763          	beq	a1,a5,1a4 <strchr+0x1a>
  for(; *s; s++)
 19a:	0505                	addi	a0,a0,1
 19c:	00054783          	lbu	a5,0(a0)
 1a0:	fbfd                	bnez	a5,196 <strchr+0xc>
      return (char*)s;
  return 0;
 1a2:	4501                	li	a0,0
}
 1a4:	6422                	ld	s0,8(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret
  return 0;
 1aa:	4501                	li	a0,0
 1ac:	bfe5                	j	1a4 <strchr+0x1a>

00000000000001ae <gets>:

char*
gets(char *buf, int max)
{
 1ae:	711d                	addi	sp,sp,-96
 1b0:	ec86                	sd	ra,88(sp)
 1b2:	e8a2                	sd	s0,80(sp)
 1b4:	e4a6                	sd	s1,72(sp)
 1b6:	e0ca                	sd	s2,64(sp)
 1b8:	fc4e                	sd	s3,56(sp)
 1ba:	f852                	sd	s4,48(sp)
 1bc:	f456                	sd	s5,40(sp)
 1be:	f05a                	sd	s6,32(sp)
 1c0:	ec5e                	sd	s7,24(sp)
 1c2:	e862                	sd	s8,16(sp)
 1c4:	1080                	addi	s0,sp,96
 1c6:	8baa                	mv	s7,a0
 1c8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ca:	892a                	mv	s2,a0
 1cc:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1ce:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1d2:	4b29                	li	s6,10
 1d4:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1d6:	89a6                	mv	s3,s1
 1d8:	2485                	addiw	s1,s1,1
 1da:	0344d763          	bge	s1,s4,208 <gets+0x5a>
    cc = read(0, &c, 1);
 1de:	4605                	li	a2,1
 1e0:	85d6                	mv	a1,s5
 1e2:	4501                	li	a0,0
 1e4:	00000097          	auipc	ra,0x0
 1e8:	1b4080e7          	jalr	436(ra) # 398 <read>
    if(cc < 1)
 1ec:	00a05e63          	blez	a0,208 <gets+0x5a>
    buf[i++] = c;
 1f0:	faf44783          	lbu	a5,-81(s0)
 1f4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f8:	01678763          	beq	a5,s6,206 <gets+0x58>
 1fc:	0905                	addi	s2,s2,1
 1fe:	fd879ce3          	bne	a5,s8,1d6 <gets+0x28>
  for(i=0; i+1 < max; ){
 202:	89a6                	mv	s3,s1
 204:	a011                	j	208 <gets+0x5a>
 206:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 208:	99de                	add	s3,s3,s7
 20a:	00098023          	sb	zero,0(s3)
  return buf;
}
 20e:	855e                	mv	a0,s7
 210:	60e6                	ld	ra,88(sp)
 212:	6446                	ld	s0,80(sp)
 214:	64a6                	ld	s1,72(sp)
 216:	6906                	ld	s2,64(sp)
 218:	79e2                	ld	s3,56(sp)
 21a:	7a42                	ld	s4,48(sp)
 21c:	7aa2                	ld	s5,40(sp)
 21e:	7b02                	ld	s6,32(sp)
 220:	6be2                	ld	s7,24(sp)
 222:	6c42                	ld	s8,16(sp)
 224:	6125                	addi	sp,sp,96
 226:	8082                	ret

0000000000000228 <stat>:

int
stat(const char *n, struct stat *st)
{
 228:	1101                	addi	sp,sp,-32
 22a:	ec06                	sd	ra,24(sp)
 22c:	e822                	sd	s0,16(sp)
 22e:	e426                	sd	s1,8(sp)
 230:	e04a                	sd	s2,0(sp)
 232:	1000                	addi	s0,sp,32
 234:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 236:	4581                	li	a1,0
 238:	00000097          	auipc	ra,0x0
 23c:	188080e7          	jalr	392(ra) # 3c0 <open>
  if(fd < 0)
 240:	02054563          	bltz	a0,26a <stat+0x42>
 244:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 246:	85ca                	mv	a1,s2
 248:	00000097          	auipc	ra,0x0
 24c:	180080e7          	jalr	384(ra) # 3c8 <fstat>
 250:	892a                	mv	s2,a0
  close(fd);
 252:	8526                	mv	a0,s1
 254:	00000097          	auipc	ra,0x0
 258:	154080e7          	jalr	340(ra) # 3a8 <close>
  return r;
}
 25c:	854a                	mv	a0,s2
 25e:	60e2                	ld	ra,24(sp)
 260:	6442                	ld	s0,16(sp)
 262:	64a2                	ld	s1,8(sp)
 264:	6902                	ld	s2,0(sp)
 266:	6105                	addi	sp,sp,32
 268:	8082                	ret
    return -1;
 26a:	597d                	li	s2,-1
 26c:	bfc5                	j	25c <stat+0x34>

000000000000026e <atoi>:

int
atoi(const char *s)
{
 26e:	1141                	addi	sp,sp,-16
 270:	e422                	sd	s0,8(sp)
 272:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 274:	00054703          	lbu	a4,0(a0)
 278:	02d00793          	li	a5,45
  int neg = 1;
 27c:	4585                	li	a1,1
  if (*s == '-') {
 27e:	04f70363          	beq	a4,a5,2c4 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 282:	00054703          	lbu	a4,0(a0)
 286:	fd07079b          	addiw	a5,a4,-48
 28a:	0ff7f793          	zext.b	a5,a5
 28e:	46a5                	li	a3,9
 290:	02f6ed63          	bltu	a3,a5,2ca <atoi+0x5c>
  n = 0;
 294:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 296:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 298:	0505                	addi	a0,a0,1
 29a:	0026979b          	slliw	a5,a3,0x2
 29e:	9fb5                	addw	a5,a5,a3
 2a0:	0017979b          	slliw	a5,a5,0x1
 2a4:	9fb9                	addw	a5,a5,a4
 2a6:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 2aa:	00054703          	lbu	a4,0(a0)
 2ae:	fd07079b          	addiw	a5,a4,-48
 2b2:	0ff7f793          	zext.b	a5,a5
 2b6:	fef671e3          	bgeu	a2,a5,298 <atoi+0x2a>
  return n * neg;
}
 2ba:	02d5853b          	mulw	a0,a1,a3
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret
    s++;
 2c4:	0505                	addi	a0,a0,1
    neg = -1;
 2c6:	55fd                	li	a1,-1
 2c8:	bf6d                	j	282 <atoi+0x14>
  n = 0;
 2ca:	4681                	li	a3,0
 2cc:	b7fd                	j	2ba <atoi+0x4c>

00000000000002ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2d4:	02b57463          	bgeu	a0,a1,2fc <memmove+0x2e>
    while(n-- > 0)
 2d8:	00c05f63          	blez	a2,2f6 <memmove+0x28>
 2dc:	1602                	slli	a2,a2,0x20
 2de:	9201                	srli	a2,a2,0x20
 2e0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e6:	0585                	addi	a1,a1,1
 2e8:	0705                	addi	a4,a4,1
 2ea:	fff5c683          	lbu	a3,-1(a1)
 2ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2f2:	fee79ae3          	bne	a5,a4,2e6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret
    dst += n;
 2fc:	00c50733          	add	a4,a0,a2
    src += n;
 300:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 302:	fec05ae3          	blez	a2,2f6 <memmove+0x28>
 306:	fff6079b          	addiw	a5,a2,-1
 30a:	1782                	slli	a5,a5,0x20
 30c:	9381                	srli	a5,a5,0x20
 30e:	fff7c793          	not	a5,a5
 312:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 314:	15fd                	addi	a1,a1,-1
 316:	177d                	addi	a4,a4,-1
 318:	0005c683          	lbu	a3,0(a1)
 31c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 320:	fee79ae3          	bne	a5,a4,314 <memmove+0x46>
 324:	bfc9                	j	2f6 <memmove+0x28>

0000000000000326 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 32c:	ca05                	beqz	a2,35c <memcmp+0x36>
 32e:	fff6069b          	addiw	a3,a2,-1
 332:	1682                	slli	a3,a3,0x20
 334:	9281                	srli	a3,a3,0x20
 336:	0685                	addi	a3,a3,1
 338:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 33a:	00054783          	lbu	a5,0(a0)
 33e:	0005c703          	lbu	a4,0(a1)
 342:	00e79863          	bne	a5,a4,352 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 346:	0505                	addi	a0,a0,1
    p2++;
 348:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 34a:	fed518e3          	bne	a0,a3,33a <memcmp+0x14>
  }
  return 0;
 34e:	4501                	li	a0,0
 350:	a019                	j	356 <memcmp+0x30>
      return *p1 - *p2;
 352:	40e7853b          	subw	a0,a5,a4
}
 356:	6422                	ld	s0,8(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret
  return 0;
 35c:	4501                	li	a0,0
 35e:	bfe5                	j	356 <memcmp+0x30>

0000000000000360 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 360:	1141                	addi	sp,sp,-16
 362:	e406                	sd	ra,8(sp)
 364:	e022                	sd	s0,0(sp)
 366:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 368:	00000097          	auipc	ra,0x0
 36c:	f66080e7          	jalr	-154(ra) # 2ce <memmove>
}
 370:	60a2                	ld	ra,8(sp)
 372:	6402                	ld	s0,0(sp)
 374:	0141                	addi	sp,sp,16
 376:	8082                	ret

0000000000000378 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 378:	4885                	li	a7,1
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <exit>:
.global exit
exit:
 li a7, SYS_exit
 380:	4889                	li	a7,2
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <wait>:
.global wait
wait:
 li a7, SYS_wait
 388:	488d                	li	a7,3
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 390:	4891                	li	a7,4
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <read>:
.global read
read:
 li a7, SYS_read
 398:	4895                	li	a7,5
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <write>:
.global write
write:
 li a7, SYS_write
 3a0:	48c1                	li	a7,16
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <close>:
.global close
close:
 li a7, SYS_close
 3a8:	48d5                	li	a7,21
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b0:	4899                	li	a7,6
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b8:	489d                	li	a7,7
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <open>:
.global open
open:
 li a7, SYS_open
 3c0:	48bd                	li	a7,15
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3c8:	48a1                	li	a7,8
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3d0:	48d1                	li	a7,20
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d8:	48a5                	li	a7,9
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3e0:	48a9                	li	a7,10
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e8:	48ad                	li	a7,11
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3f0:	48b1                	li	a7,12
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3f8:	48b5                	li	a7,13
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 400:	48b9                	li	a7,14
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 408:	48d9                	li	a7,22
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <dev>:
.global dev
dev:
 li a7, SYS_dev
 410:	48dd                	li	a7,23
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 418:	48e1                	li	a7,24
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 420:	48e5                	li	a7,25
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <remove>:
.global remove
remove:
 li a7, SYS_remove
 428:	48c5                	li	a7,17
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <trace>:
.global trace
trace:
 li a7, SYS_trace
 430:	48c9                	li	a7,18
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 438:	48cd                	li	a7,19
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <rename>:
.global rename
rename:
 li a7, SYS_rename
 440:	48e9                	li	a7,26
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 448:	48ed                	li	a7,27
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 450:	48f1                	li	a7,28
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 458:	48f5                	li	a7,29
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 460:	48f9                	li	a7,30
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 468:	48fd                	li	a7,31
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 470:	02000893          	li	a7,32
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 47a:	02100893          	li	a7,33
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 484:	02200893          	li	a7,34
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 48e:	02300893          	li	a7,35
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 498:	02400893          	li	a7,36
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4a2:	02500893          	li	a7,37
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4ac:	02600893          	li	a7,38
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 4b6:	02700893          	li	a7,39
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 4c0:	02800893          	li	a7,40
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 4ca:	02900893          	li	a7,41
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 4d4:	02a00893          	li	a7,42
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 4de:	02b00893          	li	a7,43
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 4e8:	02c00893          	li	a7,44
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4f2:	02d00893          	li	a7,45
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4fc:	02e00893          	li	a7,46
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 506:	02f00893          	li	a7,47
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 510:	03000893          	li	a7,48
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 51a:	03100893          	li	a7,49
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 524:	03200893          	li	a7,50
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 52e:	03300893          	li	a7,51
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 538:	03400893          	li	a7,52
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 542:	03500893          	li	a7,53
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 54c:	03600893          	li	a7,54
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 556:	03700893          	li	a7,55
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 560:	03800893          	li	a7,56
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 56a:	03900893          	li	a7,57
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 574:	03a00893          	li	a7,58
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <poll>:
.global poll
poll:
 li a7, SYS_poll
 57e:	03b00893          	li	a7,59
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 588:	03c00893          	li	a7,60
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 592:	03d00893          	li	a7,61
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 59c:	03e00893          	li	a7,62
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <clone>:
.global clone
clone:
 li a7, SYS_clone
 5a6:	03f00893          	li	a7,63
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <futex>:
.global futex
futex:
 li a7, SYS_futex
 5b0:	04000893          	li	a7,64
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 5ba:	04100893          	li	a7,65
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <halt>:
.global halt
halt:
 li a7, SYS_halt
 5c4:	04200893          	li	a7,66
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 5ce:	04300893          	li	a7,67
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <socket>:
.global socket
socket:
 li a7, SYS_socket
 5d8:	04400893          	li	a7,68
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5e2:	04500893          	li	a7,69
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <listen>:
.global listen
listen:
 li a7, SYS_listen
 5ec:	04600893          	li	a7,70
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5f6:	04700893          	li	a7,71
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <connect>:
.global connect
connect:
 li a7, SYS_connect
 600:	04800893          	li	a7,72
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <send>:
.global send
send:
 li a7, SYS_send
 60a:	04900893          	li	a7,73
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <recv>:
.global recv
recv:
 li a7, SYS_recv
 614:	04a00893          	li	a7,74
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 61e:	04b00893          	li	a7,75
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 628:	1101                	addi	sp,sp,-32
 62a:	ec06                	sd	ra,24(sp)
 62c:	e822                	sd	s0,16(sp)
 62e:	1000                	addi	s0,sp,32
 630:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 634:	4605                	li	a2,1
 636:	fef40593          	addi	a1,s0,-17
 63a:	00000097          	auipc	ra,0x0
 63e:	d66080e7          	jalr	-666(ra) # 3a0 <write>
}
 642:	60e2                	ld	ra,24(sp)
 644:	6442                	ld	s0,16(sp)
 646:	6105                	addi	sp,sp,32
 648:	8082                	ret

000000000000064a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 64a:	7139                	addi	sp,sp,-64
 64c:	fc06                	sd	ra,56(sp)
 64e:	f822                	sd	s0,48(sp)
 650:	f426                	sd	s1,40(sp)
 652:	f04a                	sd	s2,32(sp)
 654:	ec4e                	sd	s3,24(sp)
 656:	0080                	addi	s0,sp,64
 658:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 65a:	c299                	beqz	a3,660 <printint+0x16>
 65c:	0805c863          	bltz	a1,6ec <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 660:	2581                	sext.w	a1,a1
  neg = 0;
 662:	4881                	li	a7,0
  }

  i = 0;
 664:	fc040993          	addi	s3,s0,-64
  neg = 0;
 668:	86ce                	mv	a3,s3
  i = 0;
 66a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 66c:	2601                	sext.w	a2,a2
 66e:	00000517          	auipc	a0,0x0
 672:	50a50513          	addi	a0,a0,1290 # b78 <digits>
 676:	883a                	mv	a6,a4
 678:	2705                	addiw	a4,a4,1
 67a:	02c5f7bb          	remuw	a5,a1,a2
 67e:	1782                	slli	a5,a5,0x20
 680:	9381                	srli	a5,a5,0x20
 682:	97aa                	add	a5,a5,a0
 684:	0007c783          	lbu	a5,0(a5)
 688:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 68c:	0005879b          	sext.w	a5,a1
 690:	02c5d5bb          	divuw	a1,a1,a2
 694:	0685                	addi	a3,a3,1
 696:	fec7f0e3          	bgeu	a5,a2,676 <printint+0x2c>
  if(neg)
 69a:	00088c63          	beqz	a7,6b2 <printint+0x68>
    buf[i++] = '-';
 69e:	fd070793          	addi	a5,a4,-48
 6a2:	00878733          	add	a4,a5,s0
 6a6:	02d00793          	li	a5,45
 6aa:	fef70823          	sb	a5,-16(a4)
 6ae:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6b2:	02e05663          	blez	a4,6de <printint+0x94>
 6b6:	fc040913          	addi	s2,s0,-64
 6ba:	993a                	add	s2,s2,a4
 6bc:	19fd                	addi	s3,s3,-1
 6be:	99ba                	add	s3,s3,a4
 6c0:	377d                	addiw	a4,a4,-1
 6c2:	1702                	slli	a4,a4,0x20
 6c4:	9301                	srli	a4,a4,0x20
 6c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ca:	fff94583          	lbu	a1,-1(s2)
 6ce:	8526                	mv	a0,s1
 6d0:	00000097          	auipc	ra,0x0
 6d4:	f58080e7          	jalr	-168(ra) # 628 <putc>
  while(--i >= 0)
 6d8:	197d                	addi	s2,s2,-1
 6da:	ff3918e3          	bne	s2,s3,6ca <printint+0x80>
}
 6de:	70e2                	ld	ra,56(sp)
 6e0:	7442                	ld	s0,48(sp)
 6e2:	74a2                	ld	s1,40(sp)
 6e4:	7902                	ld	s2,32(sp)
 6e6:	69e2                	ld	s3,24(sp)
 6e8:	6121                	addi	sp,sp,64
 6ea:	8082                	ret
    x = -xx;
 6ec:	40b005bb          	negw	a1,a1
    neg = 1;
 6f0:	4885                	li	a7,1
    x = -xx;
 6f2:	bf8d                	j	664 <printint+0x1a>

00000000000006f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f4:	7119                	addi	sp,sp,-128
 6f6:	fc86                	sd	ra,120(sp)
 6f8:	f8a2                	sd	s0,112(sp)
 6fa:	f4a6                	sd	s1,104(sp)
 6fc:	f0ca                	sd	s2,96(sp)
 6fe:	ecce                	sd	s3,88(sp)
 700:	e8d2                	sd	s4,80(sp)
 702:	e4d6                	sd	s5,72(sp)
 704:	e0da                	sd	s6,64(sp)
 706:	fc5e                	sd	s7,56(sp)
 708:	f862                	sd	s8,48(sp)
 70a:	f466                	sd	s9,40(sp)
 70c:	f06a                	sd	s10,32(sp)
 70e:	ec6e                	sd	s11,24(sp)
 710:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 712:	0005c903          	lbu	s2,0(a1)
 716:	18090f63          	beqz	s2,8b4 <vprintf+0x1c0>
 71a:	8aaa                	mv	s5,a0
 71c:	8b32                	mv	s6,a2
 71e:	00158493          	addi	s1,a1,1
  state = 0;
 722:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 724:	02500a13          	li	s4,37
 728:	4c55                	li	s8,21
 72a:	00000c97          	auipc	s9,0x0
 72e:	3f6c8c93          	addi	s9,s9,1014 # b20 <malloc+0x168>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 732:	02800d93          	li	s11,40
  putc(fd, 'x');
 736:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 738:	00000b97          	auipc	s7,0x0
 73c:	440b8b93          	addi	s7,s7,1088 # b78 <digits>
 740:	a839                	j	75e <vprintf+0x6a>
        putc(fd, c);
 742:	85ca                	mv	a1,s2
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	ee2080e7          	jalr	-286(ra) # 628 <putc>
 74e:	a019                	j	754 <vprintf+0x60>
    } else if(state == '%'){
 750:	01498d63          	beq	s3,s4,76a <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 754:	0485                	addi	s1,s1,1
 756:	fff4c903          	lbu	s2,-1(s1)
 75a:	14090d63          	beqz	s2,8b4 <vprintf+0x1c0>
    if(state == 0){
 75e:	fe0999e3          	bnez	s3,750 <vprintf+0x5c>
      if(c == '%'){
 762:	ff4910e3          	bne	s2,s4,742 <vprintf+0x4e>
        state = '%';
 766:	89d2                	mv	s3,s4
 768:	b7f5                	j	754 <vprintf+0x60>
      if(c == 'd'){
 76a:	11490c63          	beq	s2,s4,882 <vprintf+0x18e>
 76e:	f9d9079b          	addiw	a5,s2,-99
 772:	0ff7f793          	zext.b	a5,a5
 776:	10fc6e63          	bltu	s8,a5,892 <vprintf+0x19e>
 77a:	f9d9079b          	addiw	a5,s2,-99
 77e:	0ff7f713          	zext.b	a4,a5
 782:	10ec6863          	bltu	s8,a4,892 <vprintf+0x19e>
 786:	00271793          	slli	a5,a4,0x2
 78a:	97e6                	add	a5,a5,s9
 78c:	439c                	lw	a5,0(a5)
 78e:	97e6                	add	a5,a5,s9
 790:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 792:	008b0913          	addi	s2,s6,8
 796:	4685                	li	a3,1
 798:	4629                	li	a2,10
 79a:	000b2583          	lw	a1,0(s6)
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	eaa080e7          	jalr	-342(ra) # 64a <printint>
 7a8:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	b765                	j	754 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ae:	008b0913          	addi	s2,s6,8
 7b2:	4681                	li	a3,0
 7b4:	4629                	li	a2,10
 7b6:	000b2583          	lw	a1,0(s6)
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e8e080e7          	jalr	-370(ra) # 64a <printint>
 7c4:	8b4a                	mv	s6,s2
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b771                	j	754 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7ca:	008b0913          	addi	s2,s6,8
 7ce:	4681                	li	a3,0
 7d0:	866a                	mv	a2,s10
 7d2:	000b2583          	lw	a1,0(s6)
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e72080e7          	jalr	-398(ra) # 64a <printint>
 7e0:	8b4a                	mv	s6,s2
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	bf85                	j	754 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7e6:	008b0793          	addi	a5,s6,8
 7ea:	f8f43423          	sd	a5,-120(s0)
 7ee:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7f2:	03000593          	li	a1,48
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	e30080e7          	jalr	-464(ra) # 628 <putc>
  putc(fd, 'x');
 800:	07800593          	li	a1,120
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e22080e7          	jalr	-478(ra) # 628 <putc>
 80e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 810:	03c9d793          	srli	a5,s3,0x3c
 814:	97de                	add	a5,a5,s7
 816:	0007c583          	lbu	a1,0(a5)
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e0c080e7          	jalr	-500(ra) # 628 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 824:	0992                	slli	s3,s3,0x4
 826:	397d                	addiw	s2,s2,-1
 828:	fe0914e3          	bnez	s2,810 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 82c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 830:	4981                	li	s3,0
 832:	b70d                	j	754 <vprintf+0x60>
        s = va_arg(ap, char*);
 834:	008b0913          	addi	s2,s6,8
 838:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 83c:	02098163          	beqz	s3,85e <vprintf+0x16a>
        while(*s != 0){
 840:	0009c583          	lbu	a1,0(s3)
 844:	c5ad                	beqz	a1,8ae <vprintf+0x1ba>
          putc(fd, *s);
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	de0080e7          	jalr	-544(ra) # 628 <putc>
          s++;
 850:	0985                	addi	s3,s3,1
        while(*s != 0){
 852:	0009c583          	lbu	a1,0(s3)
 856:	f9e5                	bnez	a1,846 <vprintf+0x152>
        s = va_arg(ap, char*);
 858:	8b4a                	mv	s6,s2
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bde5                	j	754 <vprintf+0x60>
          s = "(null)";
 85e:	00000997          	auipc	s3,0x0
 862:	2ba98993          	addi	s3,s3,698 # b18 <malloc+0x160>
        while(*s != 0){
 866:	85ee                	mv	a1,s11
 868:	bff9                	j	846 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 86a:	008b0913          	addi	s2,s6,8
 86e:	000b4583          	lbu	a1,0(s6)
 872:	8556                	mv	a0,s5
 874:	00000097          	auipc	ra,0x0
 878:	db4080e7          	jalr	-588(ra) # 628 <putc>
 87c:	8b4a                	mv	s6,s2
      state = 0;
 87e:	4981                	li	s3,0
 880:	bdd1                	j	754 <vprintf+0x60>
        putc(fd, c);
 882:	85d2                	mv	a1,s4
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	da2080e7          	jalr	-606(ra) # 628 <putc>
      state = 0;
 88e:	4981                	li	s3,0
 890:	b5d1                	j	754 <vprintf+0x60>
        putc(fd, '%');
 892:	85d2                	mv	a1,s4
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	d92080e7          	jalr	-622(ra) # 628 <putc>
        putc(fd, c);
 89e:	85ca                	mv	a1,s2
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	d86080e7          	jalr	-634(ra) # 628 <putc>
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	b565                	j	754 <vprintf+0x60>
        s = va_arg(ap, char*);
 8ae:	8b4a                	mv	s6,s2
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b54d                	j	754 <vprintf+0x60>
    }
  }
}
 8b4:	70e6                	ld	ra,120(sp)
 8b6:	7446                	ld	s0,112(sp)
 8b8:	74a6                	ld	s1,104(sp)
 8ba:	7906                	ld	s2,96(sp)
 8bc:	69e6                	ld	s3,88(sp)
 8be:	6a46                	ld	s4,80(sp)
 8c0:	6aa6                	ld	s5,72(sp)
 8c2:	6b06                	ld	s6,64(sp)
 8c4:	7be2                	ld	s7,56(sp)
 8c6:	7c42                	ld	s8,48(sp)
 8c8:	7ca2                	ld	s9,40(sp)
 8ca:	7d02                	ld	s10,32(sp)
 8cc:	6de2                	ld	s11,24(sp)
 8ce:	6109                	addi	sp,sp,128
 8d0:	8082                	ret

00000000000008d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8d2:	715d                	addi	sp,sp,-80
 8d4:	ec06                	sd	ra,24(sp)
 8d6:	e822                	sd	s0,16(sp)
 8d8:	1000                	addi	s0,sp,32
 8da:	e010                	sd	a2,0(s0)
 8dc:	e414                	sd	a3,8(s0)
 8de:	e818                	sd	a4,16(s0)
 8e0:	ec1c                	sd	a5,24(s0)
 8e2:	03043023          	sd	a6,32(s0)
 8e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ea:	8622                	mv	a2,s0
 8ec:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8f0:	00000097          	auipc	ra,0x0
 8f4:	e04080e7          	jalr	-508(ra) # 6f4 <vprintf>
}
 8f8:	60e2                	ld	ra,24(sp)
 8fa:	6442                	ld	s0,16(sp)
 8fc:	6161                	addi	sp,sp,80
 8fe:	8082                	ret

0000000000000900 <printf>:

void
printf(const char *fmt, ...)
{
 900:	711d                	addi	sp,sp,-96
 902:	ec06                	sd	ra,24(sp)
 904:	e822                	sd	s0,16(sp)
 906:	1000                	addi	s0,sp,32
 908:	e40c                	sd	a1,8(s0)
 90a:	e810                	sd	a2,16(s0)
 90c:	ec14                	sd	a3,24(s0)
 90e:	f018                	sd	a4,32(s0)
 910:	f41c                	sd	a5,40(s0)
 912:	03043823          	sd	a6,48(s0)
 916:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 91a:	00840613          	addi	a2,s0,8
 91e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 922:	85aa                	mv	a1,a0
 924:	4505                	li	a0,1
 926:	00000097          	auipc	ra,0x0
 92a:	dce080e7          	jalr	-562(ra) # 6f4 <vprintf>
}
 92e:	60e2                	ld	ra,24(sp)
 930:	6442                	ld	s0,16(sp)
 932:	6125                	addi	sp,sp,96
 934:	8082                	ret

0000000000000936 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 936:	1141                	addi	sp,sp,-16
 938:	e422                	sd	s0,8(sp)
 93a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 93c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 940:	00000797          	auipc	a5,0x0
 944:	2607b783          	ld	a5,608(a5) # ba0 <freep>
 948:	a02d                	j	972 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 94a:	4618                	lw	a4,8(a2)
 94c:	9f2d                	addw	a4,a4,a1
 94e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 952:	6398                	ld	a4,0(a5)
 954:	6310                	ld	a2,0(a4)
 956:	a83d                	j	994 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 958:	ff852703          	lw	a4,-8(a0)
 95c:	9f31                	addw	a4,a4,a2
 95e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 960:	ff053683          	ld	a3,-16(a0)
 964:	a091                	j	9a8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 966:	6398                	ld	a4,0(a5)
 968:	00e7e463          	bltu	a5,a4,970 <free+0x3a>
 96c:	00e6ea63          	bltu	a3,a4,980 <free+0x4a>
{
 970:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 972:	fed7fae3          	bgeu	a5,a3,966 <free+0x30>
 976:	6398                	ld	a4,0(a5)
 978:	00e6e463          	bltu	a3,a4,980 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97c:	fee7eae3          	bltu	a5,a4,970 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 980:	ff852583          	lw	a1,-8(a0)
 984:	6390                	ld	a2,0(a5)
 986:	02059813          	slli	a6,a1,0x20
 98a:	01c85713          	srli	a4,a6,0x1c
 98e:	9736                	add	a4,a4,a3
 990:	fae60de3          	beq	a2,a4,94a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 994:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 998:	4790                	lw	a2,8(a5)
 99a:	02061593          	slli	a1,a2,0x20
 99e:	01c5d713          	srli	a4,a1,0x1c
 9a2:	973e                	add	a4,a4,a5
 9a4:	fae68ae3          	beq	a3,a4,958 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9a8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9aa:	00000717          	auipc	a4,0x0
 9ae:	1ef73b23          	sd	a5,502(a4) # ba0 <freep>
}
 9b2:	6422                	ld	s0,8(sp)
 9b4:	0141                	addi	sp,sp,16
 9b6:	8082                	ret

00000000000009b8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b8:	7139                	addi	sp,sp,-64
 9ba:	fc06                	sd	ra,56(sp)
 9bc:	f822                	sd	s0,48(sp)
 9be:	f426                	sd	s1,40(sp)
 9c0:	f04a                	sd	s2,32(sp)
 9c2:	ec4e                	sd	s3,24(sp)
 9c4:	e852                	sd	s4,16(sp)
 9c6:	e456                	sd	s5,8(sp)
 9c8:	e05a                	sd	s6,0(sp)
 9ca:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9cc:	02051493          	slli	s1,a0,0x20
 9d0:	9081                	srli	s1,s1,0x20
 9d2:	04bd                	addi	s1,s1,15
 9d4:	8091                	srli	s1,s1,0x4
 9d6:	00148a1b          	addiw	s4,s1,1
 9da:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9dc:	00000517          	auipc	a0,0x0
 9e0:	1c453503          	ld	a0,452(a0) # ba0 <freep>
 9e4:	c515                	beqz	a0,a10 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e8:	4798                	lw	a4,8(a5)
 9ea:	04977163          	bgeu	a4,s1,a2c <malloc+0x74>
 9ee:	89d2                	mv	s3,s4
 9f0:	000a071b          	sext.w	a4,s4
 9f4:	6685                	lui	a3,0x1
 9f6:	00d77363          	bgeu	a4,a3,9fc <malloc+0x44>
 9fa:	6985                	lui	s3,0x1
 9fc:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 a00:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a04:	00000917          	auipc	s2,0x0
 a08:	19c90913          	addi	s2,s2,412 # ba0 <freep>
  if(p == (char*)-1)
 a0c:	5afd                	li	s5,-1
 a0e:	a8a5                	j	a86 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 a10:	00000797          	auipc	a5,0x0
 a14:	19078793          	addi	a5,a5,400 # ba0 <freep>
 a18:	00000717          	auipc	a4,0x0
 a1c:	19070713          	addi	a4,a4,400 # ba8 <base>
 a20:	e398                	sd	a4,0(a5)
 a22:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 a24:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a28:	87ba                	mv	a5,a4
 a2a:	b7d1                	j	9ee <malloc+0x36>
      if(p->s.size == nunits)
 a2c:	02e48c63          	beq	s1,a4,a64 <malloc+0xac>
        p->s.size -= nunits;
 a30:	4147073b          	subw	a4,a4,s4
 a34:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a36:	02071693          	slli	a3,a4,0x20
 a3a:	01c6d713          	srli	a4,a3,0x1c
 a3e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a40:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a44:	00000717          	auipc	a4,0x0
 a48:	14a73e23          	sd	a0,348(a4) # ba0 <freep>
      return (void*)(p + 1);
 a4c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a50:	70e2                	ld	ra,56(sp)
 a52:	7442                	ld	s0,48(sp)
 a54:	74a2                	ld	s1,40(sp)
 a56:	7902                	ld	s2,32(sp)
 a58:	69e2                	ld	s3,24(sp)
 a5a:	6a42                	ld	s4,16(sp)
 a5c:	6aa2                	ld	s5,8(sp)
 a5e:	6b02                	ld	s6,0(sp)
 a60:	6121                	addi	sp,sp,64
 a62:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a64:	6398                	ld	a4,0(a5)
 a66:	e118                	sd	a4,0(a0)
 a68:	bff1                	j	a44 <malloc+0x8c>
  hp->s.size = nu;
 a6a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a6e:	0541                	addi	a0,a0,16
 a70:	00000097          	auipc	ra,0x0
 a74:	ec6080e7          	jalr	-314(ra) # 936 <free>
  return freep;
 a78:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a7c:	d971                	beqz	a0,a50 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a7e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a80:	4798                	lw	a4,8(a5)
 a82:	fa9775e3          	bgeu	a4,s1,a2c <malloc+0x74>
    if(p == freep)
 a86:	00093703          	ld	a4,0(s2)
 a8a:	853e                	mv	a0,a5
 a8c:	fef719e3          	bne	a4,a5,a7e <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a90:	854e                	mv	a0,s3
 a92:	00000097          	auipc	ra,0x0
 a96:	95e080e7          	jalr	-1698(ra) # 3f0 <sbrk>
  if(p == (char*)-1)
 a9a:	fd5518e3          	bne	a0,s5,a6a <malloc+0xb2>
        return 0;
 a9e:	4501                	li	a0,0
 aa0:	bf45                	j	a50 <malloc+0x98>
