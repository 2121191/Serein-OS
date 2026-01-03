
serein-user/_timer：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
// serein-user/timer.c
#include "kernel/include/param.h"
#include "serein-user/user.h"

int main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  if(argc <= 1){
   c:	4785                	li	a5,1
   e:	04a7d563          	bge	a5,a0,58 <main+0x58>
  12:	84ae                	mv	s1,a1
    exit(1);
  }

  int HZ = 390000000 / INTERVAL; // typically 200

  uint64 t0 = uptime();
  14:	00000097          	auipc	ra,0x0
  18:	438080e7          	jalr	1080(ra) # 44c <uptime>
  1c:	892a                	mv	s2,a0
  int pid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	3a6080e7          	jalr	934(ra) # 3c4 <fork>
  if(pid < 0){
  26:	04054763          	bltz	a0,74 <main+0x74>
    fprintf(2, "timer: fork failed\n");
    exit(1);
  }
  if(pid == 0){
  2a:	e13d                	bnez	a0,90 <main+0x90>
    exec(argv[1], &argv[1]);
  2c:	00848593          	addi	a1,s1,8
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	3d2080e7          	jalr	978(ra) # 404 <exec>
    fprintf(2, "exec %s failed\n", argv[1]);
  3a:	6490                	ld	a2,8(s1)
  3c:	00001597          	auipc	a1,0x1
  40:	aec58593          	addi	a1,a1,-1300 # b28 <malloc+0x124>
  44:	4509                	li	a0,2
  46:	00001097          	auipc	ra,0x1
  4a:	8d8080e7          	jalr	-1832(ra) # 91e <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	00000097          	auipc	ra,0x0
  54:	37c080e7          	jalr	892(ra) # 3cc <exit>
    fprintf(2, "usage: timer command [args...]\n");
  58:	00001597          	auipc	a1,0x1
  5c:	a9858593          	addi	a1,a1,-1384 # af0 <malloc+0xec>
  60:	4509                	li	a0,2
  62:	00001097          	auipc	ra,0x1
  66:	8bc080e7          	jalr	-1860(ra) # 91e <fprintf>
    exit(1);
  6a:	4505                	li	a0,1
  6c:	00000097          	auipc	ra,0x0
  70:	360080e7          	jalr	864(ra) # 3cc <exit>
    fprintf(2, "timer: fork failed\n");
  74:	00001597          	auipc	a1,0x1
  78:	a9c58593          	addi	a1,a1,-1380 # b10 <malloc+0x10c>
  7c:	4509                	li	a0,2
  7e:	00001097          	auipc	ra,0x1
  82:	8a0080e7          	jalr	-1888(ra) # 91e <fprintf>
    exit(1);
  86:	4505                	li	a0,1
  88:	00000097          	auipc	ra,0x0
  8c:	344080e7          	jalr	836(ra) # 3cc <exit>
  } else {
    wait(0);
  90:	4501                	li	a0,0
  92:	00000097          	auipc	ra,0x0
  96:	342080e7          	jalr	834(ra) # 3d4 <wait>
    uint64 t1 = uptime();
  9a:	00000097          	auipc	ra,0x0
  9e:	3b2080e7          	jalr	946(ra) # 44c <uptime>
    uint64 dt = t1 - t0;
  a2:	412506b3          	sub	a3,a0,s2
    int total_ms = (int)(dt * 1000 / HZ);
  a6:	3e800613          	li	a2,1000
  aa:	02c68633          	mul	a2,a3,a2
  ae:	0c800793          	li	a5,200
  b2:	02f65633          	divu	a2,a2,a5
    int secs = total_ms / 1000;
  b6:	3e800793          	li	a5,1000
  ba:	02f645bb          	divw	a1,a2,a5
    int msecs = total_ms % 1000;
  be:	02f6663b          	remw	a2,a2,a5
    // manual zero-pad milliseconds to 3 digits (since %03d unsupported)
    if (msecs < 10)
  c2:	47a5                	li	a5,9
  c4:	02c7d463          	bge	a5,a2,ec <main+0xec>
      printf("real %d.00%d s (%d ticks)\n", secs, msecs, (int)dt);
    else if (msecs < 100)
  c8:	06300793          	li	a5,99
  cc:	02c7ca63          	blt	a5,a2,100 <main+0x100>
      printf("real %d.0%d s (%d ticks)\n", secs, msecs, (int)dt);
  d0:	2681                	sext.w	a3,a3
  d2:	00001517          	auipc	a0,0x1
  d6:	a8650513          	addi	a0,a0,-1402 # b58 <malloc+0x154>
  da:	00001097          	auipc	ra,0x1
  de:	872080e7          	jalr	-1934(ra) # 94c <printf>
    else
      printf("real %d.%d s (%d ticks)\n", secs, msecs, (int)dt);
    exit(0);
  e2:	4501                	li	a0,0
  e4:	00000097          	auipc	ra,0x0
  e8:	2e8080e7          	jalr	744(ra) # 3cc <exit>
      printf("real %d.00%d s (%d ticks)\n", secs, msecs, (int)dt);
  ec:	2681                	sext.w	a3,a3
  ee:	00001517          	auipc	a0,0x1
  f2:	a4a50513          	addi	a0,a0,-1462 # b38 <malloc+0x134>
  f6:	00001097          	auipc	ra,0x1
  fa:	856080e7          	jalr	-1962(ra) # 94c <printf>
  fe:	b7d5                	j	e2 <main+0xe2>
      printf("real %d.%d s (%d ticks)\n", secs, msecs, (int)dt);
 100:	2681                	sext.w	a3,a3
 102:	00001517          	auipc	a0,0x1
 106:	a7650513          	addi	a0,a0,-1418 # b78 <malloc+0x174>
 10a:	00001097          	auipc	ra,0x1
 10e:	842080e7          	jalr	-1982(ra) # 94c <printf>
 112:	bfc1                	j	e2 <main+0xe2>

0000000000000114 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0x8>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strcat>:

char*
strcat(char *s, const char *t)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 136:	00054783          	lbu	a5,0(a0)
 13a:	c385                	beqz	a5,15a <strcat+0x2a>
 13c:	87aa                	mv	a5,a0
    s++;
 13e:	0785                	addi	a5,a5,1
  while(*s)
 140:	0007c703          	lbu	a4,0(a5)
 144:	ff6d                	bnez	a4,13e <strcat+0xe>
  while((*s++ = *t++))
 146:	0585                	addi	a1,a1,1
 148:	0785                	addi	a5,a5,1
 14a:	fff5c703          	lbu	a4,-1(a1)
 14e:	fee78fa3          	sb	a4,-1(a5)
 152:	fb75                	bnez	a4,146 <strcat+0x16>
    ;
  return os;
}
 154:	6422                	ld	s0,8(sp)
 156:	0141                	addi	sp,sp,16
 158:	8082                	ret
  while(*s)
 15a:	87aa                	mv	a5,a0
 15c:	b7ed                	j	146 <strcat+0x16>

000000000000015e <strcmp>:


int
strcmp(const char *p, const char *q)
{
 15e:	1141                	addi	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 164:	00054783          	lbu	a5,0(a0)
 168:	cb91                	beqz	a5,17c <strcmp+0x1e>
 16a:	0005c703          	lbu	a4,0(a1)
 16e:	00f71763          	bne	a4,a5,17c <strcmp+0x1e>
    p++, q++;
 172:	0505                	addi	a0,a0,1
 174:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 176:	00054783          	lbu	a5,0(a0)
 17a:	fbe5                	bnez	a5,16a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 17c:	0005c503          	lbu	a0,0(a1)
}
 180:	40a7853b          	subw	a0,a5,a0
 184:	6422                	ld	s0,8(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret

000000000000018a <strlen>:

uint
strlen(const char *s)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 190:	00054783          	lbu	a5,0(a0)
 194:	cf91                	beqz	a5,1b0 <strlen+0x26>
 196:	0505                	addi	a0,a0,1
 198:	87aa                	mv	a5,a0
 19a:	4685                	li	a3,1
 19c:	9e89                	subw	a3,a3,a0
 19e:	00f6853b          	addw	a0,a3,a5
 1a2:	0785                	addi	a5,a5,1
 1a4:	fff7c703          	lbu	a4,-1(a5)
 1a8:	fb7d                	bnez	a4,19e <strlen+0x14>
    ;
  return n;
}
 1aa:	6422                	ld	s0,8(sp)
 1ac:	0141                	addi	sp,sp,16
 1ae:	8082                	ret
  for(n = 0; s[n]; n++)
 1b0:	4501                	li	a0,0
 1b2:	bfe5                	j	1aa <strlen+0x20>

00000000000001b4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ba:	ca19                	beqz	a2,1d0 <memset+0x1c>
 1bc:	87aa                	mv	a5,a0
 1be:	1602                	slli	a2,a2,0x20
 1c0:	9201                	srli	a2,a2,0x20
 1c2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1c6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ca:	0785                	addi	a5,a5,1
 1cc:	fee79de3          	bne	a5,a4,1c6 <memset+0x12>
  }
  return dst;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret

00000000000001d6 <strchr>:

char*
strchr(const char *s, char c)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1dc:	00054783          	lbu	a5,0(a0)
 1e0:	cb99                	beqz	a5,1f6 <strchr+0x20>
    if(*s == c)
 1e2:	00f58763          	beq	a1,a5,1f0 <strchr+0x1a>
  for(; *s; s++)
 1e6:	0505                	addi	a0,a0,1
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	fbfd                	bnez	a5,1e2 <strchr+0xc>
      return (char*)s;
  return 0;
 1ee:	4501                	li	a0,0
}
 1f0:	6422                	ld	s0,8(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret
  return 0;
 1f6:	4501                	li	a0,0
 1f8:	bfe5                	j	1f0 <strchr+0x1a>

00000000000001fa <gets>:

char*
gets(char *buf, int max)
{
 1fa:	711d                	addi	sp,sp,-96
 1fc:	ec86                	sd	ra,88(sp)
 1fe:	e8a2                	sd	s0,80(sp)
 200:	e4a6                	sd	s1,72(sp)
 202:	e0ca                	sd	s2,64(sp)
 204:	fc4e                	sd	s3,56(sp)
 206:	f852                	sd	s4,48(sp)
 208:	f456                	sd	s5,40(sp)
 20a:	f05a                	sd	s6,32(sp)
 20c:	ec5e                	sd	s7,24(sp)
 20e:	e862                	sd	s8,16(sp)
 210:	1080                	addi	s0,sp,96
 212:	8baa                	mv	s7,a0
 214:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	892a                	mv	s2,a0
 218:	4481                	li	s1,0
    cc = read(0, &c, 1);
 21a:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21e:	4b29                	li	s6,10
 220:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 222:	89a6                	mv	s3,s1
 224:	2485                	addiw	s1,s1,1
 226:	0344d763          	bge	s1,s4,254 <gets+0x5a>
    cc = read(0, &c, 1);
 22a:	4605                	li	a2,1
 22c:	85d6                	mv	a1,s5
 22e:	4501                	li	a0,0
 230:	00000097          	auipc	ra,0x0
 234:	1b4080e7          	jalr	436(ra) # 3e4 <read>
    if(cc < 1)
 238:	00a05e63          	blez	a0,254 <gets+0x5a>
    buf[i++] = c;
 23c:	faf44783          	lbu	a5,-81(s0)
 240:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 244:	01678763          	beq	a5,s6,252 <gets+0x58>
 248:	0905                	addi	s2,s2,1
 24a:	fd879ce3          	bne	a5,s8,222 <gets+0x28>
  for(i=0; i+1 < max; ){
 24e:	89a6                	mv	s3,s1
 250:	a011                	j	254 <gets+0x5a>
 252:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 254:	99de                	add	s3,s3,s7
 256:	00098023          	sb	zero,0(s3)
  return buf;
}
 25a:	855e                	mv	a0,s7
 25c:	60e6                	ld	ra,88(sp)
 25e:	6446                	ld	s0,80(sp)
 260:	64a6                	ld	s1,72(sp)
 262:	6906                	ld	s2,64(sp)
 264:	79e2                	ld	s3,56(sp)
 266:	7a42                	ld	s4,48(sp)
 268:	7aa2                	ld	s5,40(sp)
 26a:	7b02                	ld	s6,32(sp)
 26c:	6be2                	ld	s7,24(sp)
 26e:	6c42                	ld	s8,16(sp)
 270:	6125                	addi	sp,sp,96
 272:	8082                	ret

0000000000000274 <stat>:

int
stat(const char *n, struct stat *st)
{
 274:	1101                	addi	sp,sp,-32
 276:	ec06                	sd	ra,24(sp)
 278:	e822                	sd	s0,16(sp)
 27a:	e426                	sd	s1,8(sp)
 27c:	e04a                	sd	s2,0(sp)
 27e:	1000                	addi	s0,sp,32
 280:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 282:	4581                	li	a1,0
 284:	00000097          	auipc	ra,0x0
 288:	188080e7          	jalr	392(ra) # 40c <open>
  if(fd < 0)
 28c:	02054563          	bltz	a0,2b6 <stat+0x42>
 290:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 292:	85ca                	mv	a1,s2
 294:	00000097          	auipc	ra,0x0
 298:	180080e7          	jalr	384(ra) # 414 <fstat>
 29c:	892a                	mv	s2,a0
  close(fd);
 29e:	8526                	mv	a0,s1
 2a0:	00000097          	auipc	ra,0x0
 2a4:	154080e7          	jalr	340(ra) # 3f4 <close>
  return r;
}
 2a8:	854a                	mv	a0,s2
 2aa:	60e2                	ld	ra,24(sp)
 2ac:	6442                	ld	s0,16(sp)
 2ae:	64a2                	ld	s1,8(sp)
 2b0:	6902                	ld	s2,0(sp)
 2b2:	6105                	addi	sp,sp,32
 2b4:	8082                	ret
    return -1;
 2b6:	597d                	li	s2,-1
 2b8:	bfc5                	j	2a8 <stat+0x34>

00000000000002ba <atoi>:

int
atoi(const char *s)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 2c0:	00054703          	lbu	a4,0(a0)
 2c4:	02d00793          	li	a5,45
  int neg = 1;
 2c8:	4585                	li	a1,1
  if (*s == '-') {
 2ca:	04f70363          	beq	a4,a5,310 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 2ce:	00054703          	lbu	a4,0(a0)
 2d2:	fd07079b          	addiw	a5,a4,-48
 2d6:	0ff7f793          	zext.b	a5,a5
 2da:	46a5                	li	a3,9
 2dc:	02f6ed63          	bltu	a3,a5,316 <atoi+0x5c>
  n = 0;
 2e0:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 2e2:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 2e4:	0505                	addi	a0,a0,1
 2e6:	0026979b          	slliw	a5,a3,0x2
 2ea:	9fb5                	addw	a5,a5,a3
 2ec:	0017979b          	slliw	a5,a5,0x1
 2f0:	9fb9                	addw	a5,a5,a4
 2f2:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 2f6:	00054703          	lbu	a4,0(a0)
 2fa:	fd07079b          	addiw	a5,a4,-48
 2fe:	0ff7f793          	zext.b	a5,a5
 302:	fef671e3          	bgeu	a2,a5,2e4 <atoi+0x2a>
  return n * neg;
}
 306:	02d5853b          	mulw	a0,a1,a3
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    s++;
 310:	0505                	addi	a0,a0,1
    neg = -1;
 312:	55fd                	li	a1,-1
 314:	bf6d                	j	2ce <atoi+0x14>
  n = 0;
 316:	4681                	li	a3,0
 318:	b7fd                	j	306 <atoi+0x4c>

000000000000031a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 320:	02b57463          	bgeu	a0,a1,348 <memmove+0x2e>
    while(n-- > 0)
 324:	00c05f63          	blez	a2,342 <memmove+0x28>
 328:	1602                	slli	a2,a2,0x20
 32a:	9201                	srli	a2,a2,0x20
 32c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 330:	872a                	mv	a4,a0
      *dst++ = *src++;
 332:	0585                	addi	a1,a1,1
 334:	0705                	addi	a4,a4,1
 336:	fff5c683          	lbu	a3,-1(a1)
 33a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33e:	fee79ae3          	bne	a5,a4,332 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 342:	6422                	ld	s0,8(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret
    dst += n;
 348:	00c50733          	add	a4,a0,a2
    src += n;
 34c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 34e:	fec05ae3          	blez	a2,342 <memmove+0x28>
 352:	fff6079b          	addiw	a5,a2,-1
 356:	1782                	slli	a5,a5,0x20
 358:	9381                	srli	a5,a5,0x20
 35a:	fff7c793          	not	a5,a5
 35e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 360:	15fd                	addi	a1,a1,-1
 362:	177d                	addi	a4,a4,-1
 364:	0005c683          	lbu	a3,0(a1)
 368:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 36c:	fee79ae3          	bne	a5,a4,360 <memmove+0x46>
 370:	bfc9                	j	342 <memmove+0x28>

0000000000000372 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 372:	1141                	addi	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 378:	ca05                	beqz	a2,3a8 <memcmp+0x36>
 37a:	fff6069b          	addiw	a3,a2,-1
 37e:	1682                	slli	a3,a3,0x20
 380:	9281                	srli	a3,a3,0x20
 382:	0685                	addi	a3,a3,1
 384:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 386:	00054783          	lbu	a5,0(a0)
 38a:	0005c703          	lbu	a4,0(a1)
 38e:	00e79863          	bne	a5,a4,39e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 392:	0505                	addi	a0,a0,1
    p2++;
 394:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 396:	fed518e3          	bne	a0,a3,386 <memcmp+0x14>
  }
  return 0;
 39a:	4501                	li	a0,0
 39c:	a019                	j	3a2 <memcmp+0x30>
      return *p1 - *p2;
 39e:	40e7853b          	subw	a0,a5,a4
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret
  return 0;
 3a8:	4501                	li	a0,0
 3aa:	bfe5                	j	3a2 <memcmp+0x30>

00000000000003ac <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e406                	sd	ra,8(sp)
 3b0:	e022                	sd	s0,0(sp)
 3b2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3b4:	00000097          	auipc	ra,0x0
 3b8:	f66080e7          	jalr	-154(ra) # 31a <memmove>
}
 3bc:	60a2                	ld	ra,8(sp)
 3be:	6402                	ld	s0,0(sp)
 3c0:	0141                	addi	sp,sp,16
 3c2:	8082                	ret

00000000000003c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 3c4:	4885                	li	a7,1
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3cc:	4889                	li	a7,2
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d4:	488d                	li	a7,3
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3dc:	4891                	li	a7,4
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <read>:
.global read
read:
 li a7, SYS_read
 3e4:	4895                	li	a7,5
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <write>:
.global write
write:
 li a7, SYS_write
 3ec:	48c1                	li	a7,16
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <close>:
.global close
close:
 li a7, SYS_close
 3f4:	48d5                	li	a7,21
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fc:	4899                	li	a7,6
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <exec>:
.global exec
exec:
 li a7, SYS_exec
 404:	489d                	li	a7,7
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <open>:
.global open
open:
 li a7, SYS_open
 40c:	48bd                	li	a7,15
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 414:	48a1                	li	a7,8
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41c:	48d1                	li	a7,20
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 424:	48a5                	li	a7,9
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <dup>:
.global dup
dup:
 li a7, SYS_dup
 42c:	48a9                	li	a7,10
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 434:	48ad                	li	a7,11
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43c:	48b1                	li	a7,12
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 444:	48b5                	li	a7,13
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44c:	48b9                	li	a7,14
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 454:	48d9                	li	a7,22
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <dev>:
.global dev
dev:
 li a7, SYS_dev
 45c:	48dd                	li	a7,23
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 464:	48e1                	li	a7,24
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 46c:	48e5                	li	a7,25
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <remove>:
.global remove
remove:
 li a7, SYS_remove
 474:	48c5                	li	a7,17
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <trace>:
.global trace
trace:
 li a7, SYS_trace
 47c:	48c9                	li	a7,18
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 484:	48cd                	li	a7,19
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <rename>:
.global rename
rename:
 li a7, SYS_rename
 48c:	48e9                	li	a7,26
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 494:	48ed                	li	a7,27
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 49c:	48f1                	li	a7,28
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 4a4:	48f5                	li	a7,29
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 4ac:	48f9                	li	a7,30
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 4b4:	48fd                	li	a7,31
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 4bc:	02000893          	li	a7,32
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 4c6:	02100893          	li	a7,33
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 4d0:	02200893          	li	a7,34
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 4da:	02300893          	li	a7,35
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 4e4:	02400893          	li	a7,36
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4ee:	02500893          	li	a7,37
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4f8:	02600893          	li	a7,38
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 502:	02700893          	li	a7,39
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 50c:	02800893          	li	a7,40
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 516:	02900893          	li	a7,41
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 520:	02a00893          	li	a7,42
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 52a:	02b00893          	li	a7,43
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 534:	02c00893          	li	a7,44
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 53e:	02d00893          	li	a7,45
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 548:	02e00893          	li	a7,46
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 552:	02f00893          	li	a7,47
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 55c:	03000893          	li	a7,48
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 566:	03100893          	li	a7,49
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 570:	03200893          	li	a7,50
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 57a:	03300893          	li	a7,51
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 584:	03400893          	li	a7,52
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 58e:	03500893          	li	a7,53
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 598:	03600893          	li	a7,54
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 5a2:	03700893          	li	a7,55
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 5ac:	03800893          	li	a7,56
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 5b6:	03900893          	li	a7,57
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 5c0:	03a00893          	li	a7,58
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <poll>:
.global poll
poll:
 li a7, SYS_poll
 5ca:	03b00893          	li	a7,59
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 5d4:	03c00893          	li	a7,60
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 5de:	03d00893          	li	a7,61
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 5e8:	03e00893          	li	a7,62
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <clone>:
.global clone
clone:
 li a7, SYS_clone
 5f2:	03f00893          	li	a7,63
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <futex>:
.global futex
futex:
 li a7, SYS_futex
 5fc:	04000893          	li	a7,64
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 606:	04100893          	li	a7,65
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <halt>:
.global halt
halt:
 li a7, SYS_halt
 610:	04200893          	li	a7,66
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 61a:	04300893          	li	a7,67
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <socket>:
.global socket
socket:
 li a7, SYS_socket
 624:	04400893          	li	a7,68
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <bind>:
.global bind
bind:
 li a7, SYS_bind
 62e:	04500893          	li	a7,69
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <listen>:
.global listen
listen:
 li a7, SYS_listen
 638:	04600893          	li	a7,70
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <accept>:
.global accept
accept:
 li a7, SYS_accept
 642:	04700893          	li	a7,71
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <connect>:
.global connect
connect:
 li a7, SYS_connect
 64c:	04800893          	li	a7,72
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <send>:
.global send
send:
 li a7, SYS_send
 656:	04900893          	li	a7,73
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <recv>:
.global recv
recv:
 li a7, SYS_recv
 660:	04a00893          	li	a7,74
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 66a:	04b00893          	li	a7,75
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 674:	1101                	addi	sp,sp,-32
 676:	ec06                	sd	ra,24(sp)
 678:	e822                	sd	s0,16(sp)
 67a:	1000                	addi	s0,sp,32
 67c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 680:	4605                	li	a2,1
 682:	fef40593          	addi	a1,s0,-17
 686:	00000097          	auipc	ra,0x0
 68a:	d66080e7          	jalr	-666(ra) # 3ec <write>
}
 68e:	60e2                	ld	ra,24(sp)
 690:	6442                	ld	s0,16(sp)
 692:	6105                	addi	sp,sp,32
 694:	8082                	ret

0000000000000696 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 696:	7139                	addi	sp,sp,-64
 698:	fc06                	sd	ra,56(sp)
 69a:	f822                	sd	s0,48(sp)
 69c:	f426                	sd	s1,40(sp)
 69e:	f04a                	sd	s2,32(sp)
 6a0:	ec4e                	sd	s3,24(sp)
 6a2:	0080                	addi	s0,sp,64
 6a4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6a6:	c299                	beqz	a3,6ac <printint+0x16>
 6a8:	0805c863          	bltz	a1,738 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6ac:	2581                	sext.w	a1,a1
  neg = 0;
 6ae:	4881                	li	a7,0
  }

  i = 0;
 6b0:	fc040993          	addi	s3,s0,-64
  neg = 0;
 6b4:	86ce                	mv	a3,s3
  i = 0;
 6b6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6b8:	2601                	sext.w	a2,a2
 6ba:	00000517          	auipc	a0,0x0
 6be:	53e50513          	addi	a0,a0,1342 # bf8 <digits>
 6c2:	883a                	mv	a6,a4
 6c4:	2705                	addiw	a4,a4,1
 6c6:	02c5f7bb          	remuw	a5,a1,a2
 6ca:	1782                	slli	a5,a5,0x20
 6cc:	9381                	srli	a5,a5,0x20
 6ce:	97aa                	add	a5,a5,a0
 6d0:	0007c783          	lbu	a5,0(a5)
 6d4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6d8:	0005879b          	sext.w	a5,a1
 6dc:	02c5d5bb          	divuw	a1,a1,a2
 6e0:	0685                	addi	a3,a3,1
 6e2:	fec7f0e3          	bgeu	a5,a2,6c2 <printint+0x2c>
  if(neg)
 6e6:	00088c63          	beqz	a7,6fe <printint+0x68>
    buf[i++] = '-';
 6ea:	fd070793          	addi	a5,a4,-48
 6ee:	00878733          	add	a4,a5,s0
 6f2:	02d00793          	li	a5,45
 6f6:	fef70823          	sb	a5,-16(a4)
 6fa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6fe:	02e05663          	blez	a4,72a <printint+0x94>
 702:	fc040913          	addi	s2,s0,-64
 706:	993a                	add	s2,s2,a4
 708:	19fd                	addi	s3,s3,-1
 70a:	99ba                	add	s3,s3,a4
 70c:	377d                	addiw	a4,a4,-1
 70e:	1702                	slli	a4,a4,0x20
 710:	9301                	srli	a4,a4,0x20
 712:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 716:	fff94583          	lbu	a1,-1(s2)
 71a:	8526                	mv	a0,s1
 71c:	00000097          	auipc	ra,0x0
 720:	f58080e7          	jalr	-168(ra) # 674 <putc>
  while(--i >= 0)
 724:	197d                	addi	s2,s2,-1
 726:	ff3918e3          	bne	s2,s3,716 <printint+0x80>
}
 72a:	70e2                	ld	ra,56(sp)
 72c:	7442                	ld	s0,48(sp)
 72e:	74a2                	ld	s1,40(sp)
 730:	7902                	ld	s2,32(sp)
 732:	69e2                	ld	s3,24(sp)
 734:	6121                	addi	sp,sp,64
 736:	8082                	ret
    x = -xx;
 738:	40b005bb          	negw	a1,a1
    neg = 1;
 73c:	4885                	li	a7,1
    x = -xx;
 73e:	bf8d                	j	6b0 <printint+0x1a>

0000000000000740 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 740:	7119                	addi	sp,sp,-128
 742:	fc86                	sd	ra,120(sp)
 744:	f8a2                	sd	s0,112(sp)
 746:	f4a6                	sd	s1,104(sp)
 748:	f0ca                	sd	s2,96(sp)
 74a:	ecce                	sd	s3,88(sp)
 74c:	e8d2                	sd	s4,80(sp)
 74e:	e4d6                	sd	s5,72(sp)
 750:	e0da                	sd	s6,64(sp)
 752:	fc5e                	sd	s7,56(sp)
 754:	f862                	sd	s8,48(sp)
 756:	f466                	sd	s9,40(sp)
 758:	f06a                	sd	s10,32(sp)
 75a:	ec6e                	sd	s11,24(sp)
 75c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 75e:	0005c903          	lbu	s2,0(a1)
 762:	18090f63          	beqz	s2,900 <vprintf+0x1c0>
 766:	8aaa                	mv	s5,a0
 768:	8b32                	mv	s6,a2
 76a:	00158493          	addi	s1,a1,1
  state = 0;
 76e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 770:	02500a13          	li	s4,37
 774:	4c55                	li	s8,21
 776:	00000c97          	auipc	s9,0x0
 77a:	42ac8c93          	addi	s9,s9,1066 # ba0 <malloc+0x19c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 77e:	02800d93          	li	s11,40
  putc(fd, 'x');
 782:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 784:	00000b97          	auipc	s7,0x0
 788:	474b8b93          	addi	s7,s7,1140 # bf8 <digits>
 78c:	a839                	j	7aa <vprintf+0x6a>
        putc(fd, c);
 78e:	85ca                	mv	a1,s2
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	ee2080e7          	jalr	-286(ra) # 674 <putc>
 79a:	a019                	j	7a0 <vprintf+0x60>
    } else if(state == '%'){
 79c:	01498d63          	beq	s3,s4,7b6 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 7a0:	0485                	addi	s1,s1,1
 7a2:	fff4c903          	lbu	s2,-1(s1)
 7a6:	14090d63          	beqz	s2,900 <vprintf+0x1c0>
    if(state == 0){
 7aa:	fe0999e3          	bnez	s3,79c <vprintf+0x5c>
      if(c == '%'){
 7ae:	ff4910e3          	bne	s2,s4,78e <vprintf+0x4e>
        state = '%';
 7b2:	89d2                	mv	s3,s4
 7b4:	b7f5                	j	7a0 <vprintf+0x60>
      if(c == 'd'){
 7b6:	11490c63          	beq	s2,s4,8ce <vprintf+0x18e>
 7ba:	f9d9079b          	addiw	a5,s2,-99
 7be:	0ff7f793          	zext.b	a5,a5
 7c2:	10fc6e63          	bltu	s8,a5,8de <vprintf+0x19e>
 7c6:	f9d9079b          	addiw	a5,s2,-99
 7ca:	0ff7f713          	zext.b	a4,a5
 7ce:	10ec6863          	bltu	s8,a4,8de <vprintf+0x19e>
 7d2:	00271793          	slli	a5,a4,0x2
 7d6:	97e6                	add	a5,a5,s9
 7d8:	439c                	lw	a5,0(a5)
 7da:	97e6                	add	a5,a5,s9
 7dc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7de:	008b0913          	addi	s2,s6,8
 7e2:	4685                	li	a3,1
 7e4:	4629                	li	a2,10
 7e6:	000b2583          	lw	a1,0(s6)
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	eaa080e7          	jalr	-342(ra) # 696 <printint>
 7f4:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	b765                	j	7a0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fa:	008b0913          	addi	s2,s6,8
 7fe:	4681                	li	a3,0
 800:	4629                	li	a2,10
 802:	000b2583          	lw	a1,0(s6)
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	e8e080e7          	jalr	-370(ra) # 696 <printint>
 810:	8b4a                	mv	s6,s2
      state = 0;
 812:	4981                	li	s3,0
 814:	b771                	j	7a0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 816:	008b0913          	addi	s2,s6,8
 81a:	4681                	li	a3,0
 81c:	866a                	mv	a2,s10
 81e:	000b2583          	lw	a1,0(s6)
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	e72080e7          	jalr	-398(ra) # 696 <printint>
 82c:	8b4a                	mv	s6,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bf85                	j	7a0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 832:	008b0793          	addi	a5,s6,8
 836:	f8f43423          	sd	a5,-120(s0)
 83a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 83e:	03000593          	li	a1,48
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	e30080e7          	jalr	-464(ra) # 674 <putc>
  putc(fd, 'x');
 84c:	07800593          	li	a1,120
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	e22080e7          	jalr	-478(ra) # 674 <putc>
 85a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 85c:	03c9d793          	srli	a5,s3,0x3c
 860:	97de                	add	a5,a5,s7
 862:	0007c583          	lbu	a1,0(a5)
 866:	8556                	mv	a0,s5
 868:	00000097          	auipc	ra,0x0
 86c:	e0c080e7          	jalr	-500(ra) # 674 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 870:	0992                	slli	s3,s3,0x4
 872:	397d                	addiw	s2,s2,-1
 874:	fe0914e3          	bnez	s2,85c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 878:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 87c:	4981                	li	s3,0
 87e:	b70d                	j	7a0 <vprintf+0x60>
        s = va_arg(ap, char*);
 880:	008b0913          	addi	s2,s6,8
 884:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 888:	02098163          	beqz	s3,8aa <vprintf+0x16a>
        while(*s != 0){
 88c:	0009c583          	lbu	a1,0(s3)
 890:	c5ad                	beqz	a1,8fa <vprintf+0x1ba>
          putc(fd, *s);
 892:	8556                	mv	a0,s5
 894:	00000097          	auipc	ra,0x0
 898:	de0080e7          	jalr	-544(ra) # 674 <putc>
          s++;
 89c:	0985                	addi	s3,s3,1
        while(*s != 0){
 89e:	0009c583          	lbu	a1,0(s3)
 8a2:	f9e5                	bnez	a1,892 <vprintf+0x152>
        s = va_arg(ap, char*);
 8a4:	8b4a                	mv	s6,s2
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	bde5                	j	7a0 <vprintf+0x60>
          s = "(null)";
 8aa:	00000997          	auipc	s3,0x0
 8ae:	2ee98993          	addi	s3,s3,750 # b98 <malloc+0x194>
        while(*s != 0){
 8b2:	85ee                	mv	a1,s11
 8b4:	bff9                	j	892 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 8b6:	008b0913          	addi	s2,s6,8
 8ba:	000b4583          	lbu	a1,0(s6)
 8be:	8556                	mv	a0,s5
 8c0:	00000097          	auipc	ra,0x0
 8c4:	db4080e7          	jalr	-588(ra) # 674 <putc>
 8c8:	8b4a                	mv	s6,s2
      state = 0;
 8ca:	4981                	li	s3,0
 8cc:	bdd1                	j	7a0 <vprintf+0x60>
        putc(fd, c);
 8ce:	85d2                	mv	a1,s4
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	da2080e7          	jalr	-606(ra) # 674 <putc>
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	b5d1                	j	7a0 <vprintf+0x60>
        putc(fd, '%');
 8de:	85d2                	mv	a1,s4
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	d92080e7          	jalr	-622(ra) # 674 <putc>
        putc(fd, c);
 8ea:	85ca                	mv	a1,s2
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	d86080e7          	jalr	-634(ra) # 674 <putc>
      state = 0;
 8f6:	4981                	li	s3,0
 8f8:	b565                	j	7a0 <vprintf+0x60>
        s = va_arg(ap, char*);
 8fa:	8b4a                	mv	s6,s2
      state = 0;
 8fc:	4981                	li	s3,0
 8fe:	b54d                	j	7a0 <vprintf+0x60>
    }
  }
}
 900:	70e6                	ld	ra,120(sp)
 902:	7446                	ld	s0,112(sp)
 904:	74a6                	ld	s1,104(sp)
 906:	7906                	ld	s2,96(sp)
 908:	69e6                	ld	s3,88(sp)
 90a:	6a46                	ld	s4,80(sp)
 90c:	6aa6                	ld	s5,72(sp)
 90e:	6b06                	ld	s6,64(sp)
 910:	7be2                	ld	s7,56(sp)
 912:	7c42                	ld	s8,48(sp)
 914:	7ca2                	ld	s9,40(sp)
 916:	7d02                	ld	s10,32(sp)
 918:	6de2                	ld	s11,24(sp)
 91a:	6109                	addi	sp,sp,128
 91c:	8082                	ret

000000000000091e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 91e:	715d                	addi	sp,sp,-80
 920:	ec06                	sd	ra,24(sp)
 922:	e822                	sd	s0,16(sp)
 924:	1000                	addi	s0,sp,32
 926:	e010                	sd	a2,0(s0)
 928:	e414                	sd	a3,8(s0)
 92a:	e818                	sd	a4,16(s0)
 92c:	ec1c                	sd	a5,24(s0)
 92e:	03043023          	sd	a6,32(s0)
 932:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 936:	8622                	mv	a2,s0
 938:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 93c:	00000097          	auipc	ra,0x0
 940:	e04080e7          	jalr	-508(ra) # 740 <vprintf>
}
 944:	60e2                	ld	ra,24(sp)
 946:	6442                	ld	s0,16(sp)
 948:	6161                	addi	sp,sp,80
 94a:	8082                	ret

000000000000094c <printf>:

void
printf(const char *fmt, ...)
{
 94c:	711d                	addi	sp,sp,-96
 94e:	ec06                	sd	ra,24(sp)
 950:	e822                	sd	s0,16(sp)
 952:	1000                	addi	s0,sp,32
 954:	e40c                	sd	a1,8(s0)
 956:	e810                	sd	a2,16(s0)
 958:	ec14                	sd	a3,24(s0)
 95a:	f018                	sd	a4,32(s0)
 95c:	f41c                	sd	a5,40(s0)
 95e:	03043823          	sd	a6,48(s0)
 962:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 966:	00840613          	addi	a2,s0,8
 96a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 96e:	85aa                	mv	a1,a0
 970:	4505                	li	a0,1
 972:	00000097          	auipc	ra,0x0
 976:	dce080e7          	jalr	-562(ra) # 740 <vprintf>
}
 97a:	60e2                	ld	ra,24(sp)
 97c:	6442                	ld	s0,16(sp)
 97e:	6125                	addi	sp,sp,96
 980:	8082                	ret

0000000000000982 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 982:	1141                	addi	sp,sp,-16
 984:	e422                	sd	s0,8(sp)
 986:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 988:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98c:	00000797          	auipc	a5,0x0
 990:	2847b783          	ld	a5,644(a5) # c10 <freep>
 994:	a02d                	j	9be <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 996:	4618                	lw	a4,8(a2)
 998:	9f2d                	addw	a4,a4,a1
 99a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 99e:	6398                	ld	a4,0(a5)
 9a0:	6310                	ld	a2,0(a4)
 9a2:	a83d                	j	9e0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a4:	ff852703          	lw	a4,-8(a0)
 9a8:	9f31                	addw	a4,a4,a2
 9aa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9ac:	ff053683          	ld	a3,-16(a0)
 9b0:	a091                	j	9f4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b2:	6398                	ld	a4,0(a5)
 9b4:	00e7e463          	bltu	a5,a4,9bc <free+0x3a>
 9b8:	00e6ea63          	bltu	a3,a4,9cc <free+0x4a>
{
 9bc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9be:	fed7fae3          	bgeu	a5,a3,9b2 <free+0x30>
 9c2:	6398                	ld	a4,0(a5)
 9c4:	00e6e463          	bltu	a3,a4,9cc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c8:	fee7eae3          	bltu	a5,a4,9bc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9cc:	ff852583          	lw	a1,-8(a0)
 9d0:	6390                	ld	a2,0(a5)
 9d2:	02059813          	slli	a6,a1,0x20
 9d6:	01c85713          	srli	a4,a6,0x1c
 9da:	9736                	add	a4,a4,a3
 9dc:	fae60de3          	beq	a2,a4,996 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9e0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9e4:	4790                	lw	a2,8(a5)
 9e6:	02061593          	slli	a1,a2,0x20
 9ea:	01c5d713          	srli	a4,a1,0x1c
 9ee:	973e                	add	a4,a4,a5
 9f0:	fae68ae3          	beq	a3,a4,9a4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9f4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9f6:	00000717          	auipc	a4,0x0
 9fa:	20f73d23          	sd	a5,538(a4) # c10 <freep>
}
 9fe:	6422                	ld	s0,8(sp)
 a00:	0141                	addi	sp,sp,16
 a02:	8082                	ret

0000000000000a04 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a04:	7139                	addi	sp,sp,-64
 a06:	fc06                	sd	ra,56(sp)
 a08:	f822                	sd	s0,48(sp)
 a0a:	f426                	sd	s1,40(sp)
 a0c:	f04a                	sd	s2,32(sp)
 a0e:	ec4e                	sd	s3,24(sp)
 a10:	e852                	sd	s4,16(sp)
 a12:	e456                	sd	s5,8(sp)
 a14:	e05a                	sd	s6,0(sp)
 a16:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a18:	02051493          	slli	s1,a0,0x20
 a1c:	9081                	srli	s1,s1,0x20
 a1e:	04bd                	addi	s1,s1,15
 a20:	8091                	srli	s1,s1,0x4
 a22:	00148a1b          	addiw	s4,s1,1
 a26:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a28:	00000517          	auipc	a0,0x0
 a2c:	1e853503          	ld	a0,488(a0) # c10 <freep>
 a30:	c515                	beqz	a0,a5c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a32:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a34:	4798                	lw	a4,8(a5)
 a36:	04977163          	bgeu	a4,s1,a78 <malloc+0x74>
 a3a:	89d2                	mv	s3,s4
 a3c:	000a071b          	sext.w	a4,s4
 a40:	6685                	lui	a3,0x1
 a42:	00d77363          	bgeu	a4,a3,a48 <malloc+0x44>
 a46:	6985                	lui	s3,0x1
 a48:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 a4c:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a50:	00000917          	auipc	s2,0x0
 a54:	1c090913          	addi	s2,s2,448 # c10 <freep>
  if(p == (char*)-1)
 a58:	5afd                	li	s5,-1
 a5a:	a8a5                	j	ad2 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 a5c:	00000797          	auipc	a5,0x0
 a60:	1b478793          	addi	a5,a5,436 # c10 <freep>
 a64:	00000717          	auipc	a4,0x0
 a68:	1b470713          	addi	a4,a4,436 # c18 <base>
 a6c:	e398                	sd	a4,0(a5)
 a6e:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 a70:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a74:	87ba                	mv	a5,a4
 a76:	b7d1                	j	a3a <malloc+0x36>
      if(p->s.size == nunits)
 a78:	02e48c63          	beq	s1,a4,ab0 <malloc+0xac>
        p->s.size -= nunits;
 a7c:	4147073b          	subw	a4,a4,s4
 a80:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a82:	02071693          	slli	a3,a4,0x20
 a86:	01c6d713          	srli	a4,a3,0x1c
 a8a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a8c:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a90:	00000717          	auipc	a4,0x0
 a94:	18a73023          	sd	a0,384(a4) # c10 <freep>
      return (void*)(p + 1);
 a98:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a9c:	70e2                	ld	ra,56(sp)
 a9e:	7442                	ld	s0,48(sp)
 aa0:	74a2                	ld	s1,40(sp)
 aa2:	7902                	ld	s2,32(sp)
 aa4:	69e2                	ld	s3,24(sp)
 aa6:	6a42                	ld	s4,16(sp)
 aa8:	6aa2                	ld	s5,8(sp)
 aaa:	6b02                	ld	s6,0(sp)
 aac:	6121                	addi	sp,sp,64
 aae:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ab0:	6398                	ld	a4,0(a5)
 ab2:	e118                	sd	a4,0(a0)
 ab4:	bff1                	j	a90 <malloc+0x8c>
  hp->s.size = nu;
 ab6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aba:	0541                	addi	a0,a0,16
 abc:	00000097          	auipc	ra,0x0
 ac0:	ec6080e7          	jalr	-314(ra) # 982 <free>
  return freep;
 ac4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ac8:	d971                	beqz	a0,a9c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 acc:	4798                	lw	a4,8(a5)
 ace:	fa9775e3          	bgeu	a4,s1,a78 <malloc+0x74>
    if(p == freep)
 ad2:	00093703          	ld	a4,0(s2)
 ad6:	853e                	mv	a0,a5
 ad8:	fef719e3          	bne	a4,a5,aca <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 adc:	854e                	mv	a0,s3
 ade:	00000097          	auipc	ra,0x0
 ae2:	95e080e7          	jalr	-1698(ra) # 43c <sbrk>
  if(p == (char*)-1)
 ae6:	fd5518e3          	bne	a0,s5,ab6 <malloc+0xb2>
        return 0;
 aea:	4501                	li	a0,0
 aec:	bf45                	j	a9c <malloc+0x98>
