
serein-user/_mkdir：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7d763          	bge	a5,a0,3e <main+0x3e>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	02091793          	slli	a5,s2,0x20
  20:	01d7d913          	srli	s2,a5,0x1d
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  28:	6088                	ld	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	356080e7          	jalr	854(ra) # 380 <mkdir>
  32:	02054463          	bltz	a0,5a <main+0x5a>
  for(i = 1; i < argc; i++){
  36:	04a1                	addi	s1,s1,8
  38:	ff2498e3          	bne	s1,s2,28 <main+0x28>
  3c:	a80d                	j	6e <main+0x6e>
    fprintf(2, "Usage: mkdir files...\n");
  3e:	00001597          	auipc	a1,0x1
  42:	a1a58593          	addi	a1,a1,-1510 # a58 <malloc+0xf0>
  46:	4509                	li	a0,2
  48:	00001097          	auipc	ra,0x1
  4c:	83a080e7          	jalr	-1990(ra) # 882 <fprintf>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	2de080e7          	jalr	734(ra) # 330 <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	6090                	ld	a2,0(s1)
  5c:	00001597          	auipc	a1,0x1
  60:	a1458593          	addi	a1,a1,-1516 # a70 <malloc+0x108>
  64:	4509                	li	a0,2
  66:	00001097          	auipc	ra,0x1
  6a:	81c080e7          	jalr	-2020(ra) # 882 <fprintf>
      break;
    }
  }

  exit(0);
  6e:	4501                	li	a0,0
  70:	00000097          	auipc	ra,0x0
  74:	2c0080e7          	jalr	704(ra) # 330 <exit>

0000000000000078 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7e:	87aa                	mv	a5,a0
  80:	0585                	addi	a1,a1,1
  82:	0785                	addi	a5,a5,1
  84:	fff5c703          	lbu	a4,-1(a1)
  88:	fee78fa3          	sb	a4,-1(a5)
  8c:	fb75                	bnez	a4,80 <strcpy+0x8>
    ;
  return os;
}
  8e:	6422                	ld	s0,8(sp)
  90:	0141                	addi	sp,sp,16
  92:	8082                	ret

0000000000000094 <strcat>:

char*
strcat(char *s, const char *t)
{
  94:	1141                	addi	sp,sp,-16
  96:	e422                	sd	s0,8(sp)
  98:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	c385                	beqz	a5,be <strcat+0x2a>
  a0:	87aa                	mv	a5,a0
    s++;
  a2:	0785                	addi	a5,a5,1
  while(*s)
  a4:	0007c703          	lbu	a4,0(a5)
  a8:	ff6d                	bnez	a4,a2 <strcat+0xe>
  while((*s++ = *t++))
  aa:	0585                	addi	a1,a1,1
  ac:	0785                	addi	a5,a5,1
  ae:	fff5c703          	lbu	a4,-1(a1)
  b2:	fee78fa3          	sb	a4,-1(a5)
  b6:	fb75                	bnez	a4,aa <strcat+0x16>
    ;
  return os;
}
  b8:	6422                	ld	s0,8(sp)
  ba:	0141                	addi	sp,sp,16
  bc:	8082                	ret
  while(*s)
  be:	87aa                	mv	a5,a0
  c0:	b7ed                	j	aa <strcat+0x16>

00000000000000c2 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cb91                	beqz	a5,e0 <strcmp+0x1e>
  ce:	0005c703          	lbu	a4,0(a1)
  d2:	00f71763          	bne	a4,a5,e0 <strcmp+0x1e>
    p++, q++;
  d6:	0505                	addi	a0,a0,1
  d8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  da:	00054783          	lbu	a5,0(a0)
  de:	fbe5                	bnez	a5,ce <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  e0:	0005c503          	lbu	a0,0(a1)
}
  e4:	40a7853b          	subw	a0,a5,a0
  e8:	6422                	ld	s0,8(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strlen>:

uint
strlen(const char *s)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e422                	sd	s0,8(sp)
  f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	cf91                	beqz	a5,114 <strlen+0x26>
  fa:	0505                	addi	a0,a0,1
  fc:	87aa                	mv	a5,a0
  fe:	4685                	li	a3,1
 100:	9e89                	subw	a3,a3,a0
 102:	00f6853b          	addw	a0,a3,a5
 106:	0785                	addi	a5,a5,1
 108:	fff7c703          	lbu	a4,-1(a5)
 10c:	fb7d                	bnez	a4,102 <strlen+0x14>
    ;
  return n;
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret
  for(n = 0; s[n]; n++)
 114:	4501                	li	a0,0
 116:	bfe5                	j	10e <strlen+0x20>

0000000000000118 <memset>:

void*
memset(void *dst, int c, uint n)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e422                	sd	s0,8(sp)
 11c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 11e:	ca19                	beqz	a2,134 <memset+0x1c>
 120:	87aa                	mv	a5,a0
 122:	1602                	slli	a2,a2,0x20
 124:	9201                	srli	a2,a2,0x20
 126:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 12e:	0785                	addi	a5,a5,1
 130:	fee79de3          	bne	a5,a4,12a <memset+0x12>
  }
  return dst;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret

000000000000013a <strchr>:

char*
strchr(const char *s, char c)
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 140:	00054783          	lbu	a5,0(a0)
 144:	cb99                	beqz	a5,15a <strchr+0x20>
    if(*s == c)
 146:	00f58763          	beq	a1,a5,154 <strchr+0x1a>
  for(; *s; s++)
 14a:	0505                	addi	a0,a0,1
 14c:	00054783          	lbu	a5,0(a0)
 150:	fbfd                	bnez	a5,146 <strchr+0xc>
      return (char*)s;
  return 0;
 152:	4501                	li	a0,0
}
 154:	6422                	ld	s0,8(sp)
 156:	0141                	addi	sp,sp,16
 158:	8082                	ret
  return 0;
 15a:	4501                	li	a0,0
 15c:	bfe5                	j	154 <strchr+0x1a>

000000000000015e <gets>:

char*
gets(char *buf, int max)
{
 15e:	711d                	addi	sp,sp,-96
 160:	ec86                	sd	ra,88(sp)
 162:	e8a2                	sd	s0,80(sp)
 164:	e4a6                	sd	s1,72(sp)
 166:	e0ca                	sd	s2,64(sp)
 168:	fc4e                	sd	s3,56(sp)
 16a:	f852                	sd	s4,48(sp)
 16c:	f456                	sd	s5,40(sp)
 16e:	f05a                	sd	s6,32(sp)
 170:	ec5e                	sd	s7,24(sp)
 172:	e862                	sd	s8,16(sp)
 174:	1080                	addi	s0,sp,96
 176:	8baa                	mv	s7,a0
 178:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17a:	892a                	mv	s2,a0
 17c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 17e:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 182:	4b29                	li	s6,10
 184:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 186:	89a6                	mv	s3,s1
 188:	2485                	addiw	s1,s1,1
 18a:	0344d763          	bge	s1,s4,1b8 <gets+0x5a>
    cc = read(0, &c, 1);
 18e:	4605                	li	a2,1
 190:	85d6                	mv	a1,s5
 192:	4501                	li	a0,0
 194:	00000097          	auipc	ra,0x0
 198:	1b4080e7          	jalr	436(ra) # 348 <read>
    if(cc < 1)
 19c:	00a05e63          	blez	a0,1b8 <gets+0x5a>
    buf[i++] = c;
 1a0:	faf44783          	lbu	a5,-81(s0)
 1a4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a8:	01678763          	beq	a5,s6,1b6 <gets+0x58>
 1ac:	0905                	addi	s2,s2,1
 1ae:	fd879ce3          	bne	a5,s8,186 <gets+0x28>
  for(i=0; i+1 < max; ){
 1b2:	89a6                	mv	s3,s1
 1b4:	a011                	j	1b8 <gets+0x5a>
 1b6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b8:	99de                	add	s3,s3,s7
 1ba:	00098023          	sb	zero,0(s3)
  return buf;
}
 1be:	855e                	mv	a0,s7
 1c0:	60e6                	ld	ra,88(sp)
 1c2:	6446                	ld	s0,80(sp)
 1c4:	64a6                	ld	s1,72(sp)
 1c6:	6906                	ld	s2,64(sp)
 1c8:	79e2                	ld	s3,56(sp)
 1ca:	7a42                	ld	s4,48(sp)
 1cc:	7aa2                	ld	s5,40(sp)
 1ce:	7b02                	ld	s6,32(sp)
 1d0:	6be2                	ld	s7,24(sp)
 1d2:	6c42                	ld	s8,16(sp)
 1d4:	6125                	addi	sp,sp,96
 1d6:	8082                	ret

00000000000001d8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d8:	1101                	addi	sp,sp,-32
 1da:	ec06                	sd	ra,24(sp)
 1dc:	e822                	sd	s0,16(sp)
 1de:	e426                	sd	s1,8(sp)
 1e0:	e04a                	sd	s2,0(sp)
 1e2:	1000                	addi	s0,sp,32
 1e4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	4581                	li	a1,0
 1e8:	00000097          	auipc	ra,0x0
 1ec:	188080e7          	jalr	392(ra) # 370 <open>
  if(fd < 0)
 1f0:	02054563          	bltz	a0,21a <stat+0x42>
 1f4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1f6:	85ca                	mv	a1,s2
 1f8:	00000097          	auipc	ra,0x0
 1fc:	180080e7          	jalr	384(ra) # 378 <fstat>
 200:	892a                	mv	s2,a0
  close(fd);
 202:	8526                	mv	a0,s1
 204:	00000097          	auipc	ra,0x0
 208:	154080e7          	jalr	340(ra) # 358 <close>
  return r;
}
 20c:	854a                	mv	a0,s2
 20e:	60e2                	ld	ra,24(sp)
 210:	6442                	ld	s0,16(sp)
 212:	64a2                	ld	s1,8(sp)
 214:	6902                	ld	s2,0(sp)
 216:	6105                	addi	sp,sp,32
 218:	8082                	ret
    return -1;
 21a:	597d                	li	s2,-1
 21c:	bfc5                	j	20c <stat+0x34>

000000000000021e <atoi>:

int
atoi(const char *s)
{
 21e:	1141                	addi	sp,sp,-16
 220:	e422                	sd	s0,8(sp)
 222:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 224:	00054703          	lbu	a4,0(a0)
 228:	02d00793          	li	a5,45
  int neg = 1;
 22c:	4585                	li	a1,1
  if (*s == '-') {
 22e:	04f70363          	beq	a4,a5,274 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 232:	00054703          	lbu	a4,0(a0)
 236:	fd07079b          	addiw	a5,a4,-48
 23a:	0ff7f793          	zext.b	a5,a5
 23e:	46a5                	li	a3,9
 240:	02f6ed63          	bltu	a3,a5,27a <atoi+0x5c>
  n = 0;
 244:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 246:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 248:	0505                	addi	a0,a0,1
 24a:	0026979b          	slliw	a5,a3,0x2
 24e:	9fb5                	addw	a5,a5,a3
 250:	0017979b          	slliw	a5,a5,0x1
 254:	9fb9                	addw	a5,a5,a4
 256:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 25a:	00054703          	lbu	a4,0(a0)
 25e:	fd07079b          	addiw	a5,a4,-48
 262:	0ff7f793          	zext.b	a5,a5
 266:	fef671e3          	bgeu	a2,a5,248 <atoi+0x2a>
  return n * neg;
}
 26a:	02d5853b          	mulw	a0,a1,a3
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret
    s++;
 274:	0505                	addi	a0,a0,1
    neg = -1;
 276:	55fd                	li	a1,-1
 278:	bf6d                	j	232 <atoi+0x14>
  n = 0;
 27a:	4681                	li	a3,0
 27c:	b7fd                	j	26a <atoi+0x4c>

000000000000027e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 284:	02b57463          	bgeu	a0,a1,2ac <memmove+0x2e>
    while(n-- > 0)
 288:	00c05f63          	blez	a2,2a6 <memmove+0x28>
 28c:	1602                	slli	a2,a2,0x20
 28e:	9201                	srli	a2,a2,0x20
 290:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 294:	872a                	mv	a4,a0
      *dst++ = *src++;
 296:	0585                	addi	a1,a1,1
 298:	0705                	addi	a4,a4,1
 29a:	fff5c683          	lbu	a3,-1(a1)
 29e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a2:	fee79ae3          	bne	a5,a4,296 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
    dst += n;
 2ac:	00c50733          	add	a4,a0,a2
    src += n;
 2b0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b2:	fec05ae3          	blez	a2,2a6 <memmove+0x28>
 2b6:	fff6079b          	addiw	a5,a2,-1
 2ba:	1782                	slli	a5,a5,0x20
 2bc:	9381                	srli	a5,a5,0x20
 2be:	fff7c793          	not	a5,a5
 2c2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c4:	15fd                	addi	a1,a1,-1
 2c6:	177d                	addi	a4,a4,-1
 2c8:	0005c683          	lbu	a3,0(a1)
 2cc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x46>
 2d4:	bfc9                	j	2a6 <memmove+0x28>

00000000000002d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2dc:	ca05                	beqz	a2,30c <memcmp+0x36>
 2de:	fff6069b          	addiw	a3,a2,-1
 2e2:	1682                	slli	a3,a3,0x20
 2e4:	9281                	srli	a3,a3,0x20
 2e6:	0685                	addi	a3,a3,1
 2e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	0005c703          	lbu	a4,0(a1)
 2f2:	00e79863          	bne	a5,a4,302 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f6:	0505                	addi	a0,a0,1
    p2++;
 2f8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fa:	fed518e3          	bne	a0,a3,2ea <memcmp+0x14>
  }
  return 0;
 2fe:	4501                	li	a0,0
 300:	a019                	j	306 <memcmp+0x30>
      return *p1 - *p2;
 302:	40e7853b          	subw	a0,a5,a4
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  return 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <memcmp+0x30>

0000000000000310 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 318:	00000097          	auipc	ra,0x0
 31c:	f66080e7          	jalr	-154(ra) # 27e <memmove>
}
 320:	60a2                	ld	ra,8(sp)
 322:	6402                	ld	s0,0(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret

0000000000000328 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 328:	4885                	li	a7,1
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <exit>:
.global exit
exit:
 li a7, SYS_exit
 330:	4889                	li	a7,2
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <wait>:
.global wait
wait:
 li a7, SYS_wait
 338:	488d                	li	a7,3
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 340:	4891                	li	a7,4
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <read>:
.global read
read:
 li a7, SYS_read
 348:	4895                	li	a7,5
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <write>:
.global write
write:
 li a7, SYS_write
 350:	48c1                	li	a7,16
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <close>:
.global close
close:
 li a7, SYS_close
 358:	48d5                	li	a7,21
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <kill>:
.global kill
kill:
 li a7, SYS_kill
 360:	4899                	li	a7,6
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <exec>:
.global exec
exec:
 li a7, SYS_exec
 368:	489d                	li	a7,7
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <open>:
.global open
open:
 li a7, SYS_open
 370:	48bd                	li	a7,15
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 378:	48a1                	li	a7,8
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 380:	48d1                	li	a7,20
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 388:	48a5                	li	a7,9
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <dup>:
.global dup
dup:
 li a7, SYS_dup
 390:	48a9                	li	a7,10
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 398:	48ad                	li	a7,11
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a0:	48b1                	li	a7,12
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a8:	48b5                	li	a7,13
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b0:	48b9                	li	a7,14
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3b8:	48d9                	li	a7,22
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3c0:	48dd                	li	a7,23
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3c8:	48e1                	li	a7,24
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3d0:	48e5                	li	a7,25
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <remove>:
.global remove
remove:
 li a7, SYS_remove
 3d8:	48c5                	li	a7,17
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e0:	48c9                	li	a7,18
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3e8:	48cd                	li	a7,19
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <rename>:
.global rename
rename:
 li a7, SYS_rename
 3f0:	48e9                	li	a7,26
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 3f8:	48ed                	li	a7,27
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 400:	48f1                	li	a7,28
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 408:	48f5                	li	a7,29
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 410:	48f9                	li	a7,30
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 418:	48fd                	li	a7,31
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 420:	02000893          	li	a7,32
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 42a:	02100893          	li	a7,33
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 434:	02200893          	li	a7,34
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 43e:	02300893          	li	a7,35
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 448:	02400893          	li	a7,36
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 452:	02500893          	li	a7,37
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 45c:	02600893          	li	a7,38
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 466:	02700893          	li	a7,39
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 470:	02800893          	li	a7,40
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 47a:	02900893          	li	a7,41
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 484:	02a00893          	li	a7,42
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 48e:	02b00893          	li	a7,43
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 498:	02c00893          	li	a7,44
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4a2:	02d00893          	li	a7,45
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4ac:	02e00893          	li	a7,46
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4b6:	02f00893          	li	a7,47
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 4c0:	03000893          	li	a7,48
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 4ca:	03100893          	li	a7,49
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 4d4:	03200893          	li	a7,50
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 4de:	03300893          	li	a7,51
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 4e8:	03400893          	li	a7,52
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 4f2:	03500893          	li	a7,53
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 4fc:	03600893          	li	a7,54
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 506:	03700893          	li	a7,55
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 510:	03800893          	li	a7,56
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 51a:	03900893          	li	a7,57
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 524:	03a00893          	li	a7,58
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <poll>:
.global poll
poll:
 li a7, SYS_poll
 52e:	03b00893          	li	a7,59
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 538:	03c00893          	li	a7,60
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 542:	03d00893          	li	a7,61
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 54c:	03e00893          	li	a7,62
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <clone>:
.global clone
clone:
 li a7, SYS_clone
 556:	03f00893          	li	a7,63
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <futex>:
.global futex
futex:
 li a7, SYS_futex
 560:	04000893          	li	a7,64
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 56a:	04100893          	li	a7,65
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <halt>:
.global halt
halt:
 li a7, SYS_halt
 574:	04200893          	li	a7,66
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 57e:	04300893          	li	a7,67
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <socket>:
.global socket
socket:
 li a7, SYS_socket
 588:	04400893          	li	a7,68
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <bind>:
.global bind
bind:
 li a7, SYS_bind
 592:	04500893          	li	a7,69
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <listen>:
.global listen
listen:
 li a7, SYS_listen
 59c:	04600893          	li	a7,70
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5a6:	04700893          	li	a7,71
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5b0:	04800893          	li	a7,72
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <send>:
.global send
send:
 li a7, SYS_send
 5ba:	04900893          	li	a7,73
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5c4:	04a00893          	li	a7,74
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 5ce:	04b00893          	li	a7,75
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d8:	1101                	addi	sp,sp,-32
 5da:	ec06                	sd	ra,24(sp)
 5dc:	e822                	sd	s0,16(sp)
 5de:	1000                	addi	s0,sp,32
 5e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e4:	4605                	li	a2,1
 5e6:	fef40593          	addi	a1,s0,-17
 5ea:	00000097          	auipc	ra,0x0
 5ee:	d66080e7          	jalr	-666(ra) # 350 <write>
}
 5f2:	60e2                	ld	ra,24(sp)
 5f4:	6442                	ld	s0,16(sp)
 5f6:	6105                	addi	sp,sp,32
 5f8:	8082                	ret

00000000000005fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fa:	7139                	addi	sp,sp,-64
 5fc:	fc06                	sd	ra,56(sp)
 5fe:	f822                	sd	s0,48(sp)
 600:	f426                	sd	s1,40(sp)
 602:	f04a                	sd	s2,32(sp)
 604:	ec4e                	sd	s3,24(sp)
 606:	0080                	addi	s0,sp,64
 608:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60a:	c299                	beqz	a3,610 <printint+0x16>
 60c:	0805c863          	bltz	a1,69c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 610:	2581                	sext.w	a1,a1
  neg = 0;
 612:	4881                	li	a7,0
  }

  i = 0;
 614:	fc040993          	addi	s3,s0,-64
  neg = 0;
 618:	86ce                	mv	a3,s3
  i = 0;
 61a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 61c:	2601                	sext.w	a2,a2
 61e:	00000517          	auipc	a0,0x0
 622:	4d250513          	addi	a0,a0,1234 # af0 <digits>
 626:	883a                	mv	a6,a4
 628:	2705                	addiw	a4,a4,1
 62a:	02c5f7bb          	remuw	a5,a1,a2
 62e:	1782                	slli	a5,a5,0x20
 630:	9381                	srli	a5,a5,0x20
 632:	97aa                	add	a5,a5,a0
 634:	0007c783          	lbu	a5,0(a5)
 638:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 63c:	0005879b          	sext.w	a5,a1
 640:	02c5d5bb          	divuw	a1,a1,a2
 644:	0685                	addi	a3,a3,1
 646:	fec7f0e3          	bgeu	a5,a2,626 <printint+0x2c>
  if(neg)
 64a:	00088c63          	beqz	a7,662 <printint+0x68>
    buf[i++] = '-';
 64e:	fd070793          	addi	a5,a4,-48
 652:	00878733          	add	a4,a5,s0
 656:	02d00793          	li	a5,45
 65a:	fef70823          	sb	a5,-16(a4)
 65e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 662:	02e05663          	blez	a4,68e <printint+0x94>
 666:	fc040913          	addi	s2,s0,-64
 66a:	993a                	add	s2,s2,a4
 66c:	19fd                	addi	s3,s3,-1
 66e:	99ba                	add	s3,s3,a4
 670:	377d                	addiw	a4,a4,-1
 672:	1702                	slli	a4,a4,0x20
 674:	9301                	srli	a4,a4,0x20
 676:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67a:	fff94583          	lbu	a1,-1(s2)
 67e:	8526                	mv	a0,s1
 680:	00000097          	auipc	ra,0x0
 684:	f58080e7          	jalr	-168(ra) # 5d8 <putc>
  while(--i >= 0)
 688:	197d                	addi	s2,s2,-1
 68a:	ff3918e3          	bne	s2,s3,67a <printint+0x80>
}
 68e:	70e2                	ld	ra,56(sp)
 690:	7442                	ld	s0,48(sp)
 692:	74a2                	ld	s1,40(sp)
 694:	7902                	ld	s2,32(sp)
 696:	69e2                	ld	s3,24(sp)
 698:	6121                	addi	sp,sp,64
 69a:	8082                	ret
    x = -xx;
 69c:	40b005bb          	negw	a1,a1
    neg = 1;
 6a0:	4885                	li	a7,1
    x = -xx;
 6a2:	bf8d                	j	614 <printint+0x1a>

00000000000006a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a4:	7119                	addi	sp,sp,-128
 6a6:	fc86                	sd	ra,120(sp)
 6a8:	f8a2                	sd	s0,112(sp)
 6aa:	f4a6                	sd	s1,104(sp)
 6ac:	f0ca                	sd	s2,96(sp)
 6ae:	ecce                	sd	s3,88(sp)
 6b0:	e8d2                	sd	s4,80(sp)
 6b2:	e4d6                	sd	s5,72(sp)
 6b4:	e0da                	sd	s6,64(sp)
 6b6:	fc5e                	sd	s7,56(sp)
 6b8:	f862                	sd	s8,48(sp)
 6ba:	f466                	sd	s9,40(sp)
 6bc:	f06a                	sd	s10,32(sp)
 6be:	ec6e                	sd	s11,24(sp)
 6c0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c2:	0005c903          	lbu	s2,0(a1)
 6c6:	18090f63          	beqz	s2,864 <vprintf+0x1c0>
 6ca:	8aaa                	mv	s5,a0
 6cc:	8b32                	mv	s6,a2
 6ce:	00158493          	addi	s1,a1,1
  state = 0;
 6d2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6d4:	02500a13          	li	s4,37
 6d8:	4c55                	li	s8,21
 6da:	00000c97          	auipc	s9,0x0
 6de:	3bec8c93          	addi	s9,s9,958 # a98 <malloc+0x130>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6e2:	02800d93          	li	s11,40
  putc(fd, 'x');
 6e6:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e8:	00000b97          	auipc	s7,0x0
 6ec:	408b8b93          	addi	s7,s7,1032 # af0 <digits>
 6f0:	a839                	j	70e <vprintf+0x6a>
        putc(fd, c);
 6f2:	85ca                	mv	a1,s2
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	ee2080e7          	jalr	-286(ra) # 5d8 <putc>
 6fe:	a019                	j	704 <vprintf+0x60>
    } else if(state == '%'){
 700:	01498d63          	beq	s3,s4,71a <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 704:	0485                	addi	s1,s1,1
 706:	fff4c903          	lbu	s2,-1(s1)
 70a:	14090d63          	beqz	s2,864 <vprintf+0x1c0>
    if(state == 0){
 70e:	fe0999e3          	bnez	s3,700 <vprintf+0x5c>
      if(c == '%'){
 712:	ff4910e3          	bne	s2,s4,6f2 <vprintf+0x4e>
        state = '%';
 716:	89d2                	mv	s3,s4
 718:	b7f5                	j	704 <vprintf+0x60>
      if(c == 'd'){
 71a:	11490c63          	beq	s2,s4,832 <vprintf+0x18e>
 71e:	f9d9079b          	addiw	a5,s2,-99
 722:	0ff7f793          	zext.b	a5,a5
 726:	10fc6e63          	bltu	s8,a5,842 <vprintf+0x19e>
 72a:	f9d9079b          	addiw	a5,s2,-99
 72e:	0ff7f713          	zext.b	a4,a5
 732:	10ec6863          	bltu	s8,a4,842 <vprintf+0x19e>
 736:	00271793          	slli	a5,a4,0x2
 73a:	97e6                	add	a5,a5,s9
 73c:	439c                	lw	a5,0(a5)
 73e:	97e6                	add	a5,a5,s9
 740:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 742:	008b0913          	addi	s2,s6,8
 746:	4685                	li	a3,1
 748:	4629                	li	a2,10
 74a:	000b2583          	lw	a1,0(s6)
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	eaa080e7          	jalr	-342(ra) # 5fa <printint>
 758:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 75a:	4981                	li	s3,0
 75c:	b765                	j	704 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75e:	008b0913          	addi	s2,s6,8
 762:	4681                	li	a3,0
 764:	4629                	li	a2,10
 766:	000b2583          	lw	a1,0(s6)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e8e080e7          	jalr	-370(ra) # 5fa <printint>
 774:	8b4a                	mv	s6,s2
      state = 0;
 776:	4981                	li	s3,0
 778:	b771                	j	704 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 77a:	008b0913          	addi	s2,s6,8
 77e:	4681                	li	a3,0
 780:	866a                	mv	a2,s10
 782:	000b2583          	lw	a1,0(s6)
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	e72080e7          	jalr	-398(ra) # 5fa <printint>
 790:	8b4a                	mv	s6,s2
      state = 0;
 792:	4981                	li	s3,0
 794:	bf85                	j	704 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 796:	008b0793          	addi	a5,s6,8
 79a:	f8f43423          	sd	a5,-120(s0)
 79e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7a2:	03000593          	li	a1,48
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e30080e7          	jalr	-464(ra) # 5d8 <putc>
  putc(fd, 'x');
 7b0:	07800593          	li	a1,120
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	e22080e7          	jalr	-478(ra) # 5d8 <putc>
 7be:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c0:	03c9d793          	srli	a5,s3,0x3c
 7c4:	97de                	add	a5,a5,s7
 7c6:	0007c583          	lbu	a1,0(a5)
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	e0c080e7          	jalr	-500(ra) # 5d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d4:	0992                	slli	s3,s3,0x4
 7d6:	397d                	addiw	s2,s2,-1
 7d8:	fe0914e3          	bnez	s2,7c0 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7dc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	b70d                	j	704 <vprintf+0x60>
        s = va_arg(ap, char*);
 7e4:	008b0913          	addi	s2,s6,8
 7e8:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7ec:	02098163          	beqz	s3,80e <vprintf+0x16a>
        while(*s != 0){
 7f0:	0009c583          	lbu	a1,0(s3)
 7f4:	c5ad                	beqz	a1,85e <vprintf+0x1ba>
          putc(fd, *s);
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	de0080e7          	jalr	-544(ra) # 5d8 <putc>
          s++;
 800:	0985                	addi	s3,s3,1
        while(*s != 0){
 802:	0009c583          	lbu	a1,0(s3)
 806:	f9e5                	bnez	a1,7f6 <vprintf+0x152>
        s = va_arg(ap, char*);
 808:	8b4a                	mv	s6,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bde5                	j	704 <vprintf+0x60>
          s = "(null)";
 80e:	00000997          	auipc	s3,0x0
 812:	28298993          	addi	s3,s3,642 # a90 <malloc+0x128>
        while(*s != 0){
 816:	85ee                	mv	a1,s11
 818:	bff9                	j	7f6 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 81a:	008b0913          	addi	s2,s6,8
 81e:	000b4583          	lbu	a1,0(s6)
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	db4080e7          	jalr	-588(ra) # 5d8 <putc>
 82c:	8b4a                	mv	s6,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bdd1                	j	704 <vprintf+0x60>
        putc(fd, c);
 832:	85d2                	mv	a1,s4
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	da2080e7          	jalr	-606(ra) # 5d8 <putc>
      state = 0;
 83e:	4981                	li	s3,0
 840:	b5d1                	j	704 <vprintf+0x60>
        putc(fd, '%');
 842:	85d2                	mv	a1,s4
 844:	8556                	mv	a0,s5
 846:	00000097          	auipc	ra,0x0
 84a:	d92080e7          	jalr	-622(ra) # 5d8 <putc>
        putc(fd, c);
 84e:	85ca                	mv	a1,s2
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	d86080e7          	jalr	-634(ra) # 5d8 <putc>
      state = 0;
 85a:	4981                	li	s3,0
 85c:	b565                	j	704 <vprintf+0x60>
        s = va_arg(ap, char*);
 85e:	8b4a                	mv	s6,s2
      state = 0;
 860:	4981                	li	s3,0
 862:	b54d                	j	704 <vprintf+0x60>
    }
  }
}
 864:	70e6                	ld	ra,120(sp)
 866:	7446                	ld	s0,112(sp)
 868:	74a6                	ld	s1,104(sp)
 86a:	7906                	ld	s2,96(sp)
 86c:	69e6                	ld	s3,88(sp)
 86e:	6a46                	ld	s4,80(sp)
 870:	6aa6                	ld	s5,72(sp)
 872:	6b06                	ld	s6,64(sp)
 874:	7be2                	ld	s7,56(sp)
 876:	7c42                	ld	s8,48(sp)
 878:	7ca2                	ld	s9,40(sp)
 87a:	7d02                	ld	s10,32(sp)
 87c:	6de2                	ld	s11,24(sp)
 87e:	6109                	addi	sp,sp,128
 880:	8082                	ret

0000000000000882 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 882:	715d                	addi	sp,sp,-80
 884:	ec06                	sd	ra,24(sp)
 886:	e822                	sd	s0,16(sp)
 888:	1000                	addi	s0,sp,32
 88a:	e010                	sd	a2,0(s0)
 88c:	e414                	sd	a3,8(s0)
 88e:	e818                	sd	a4,16(s0)
 890:	ec1c                	sd	a5,24(s0)
 892:	03043023          	sd	a6,32(s0)
 896:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89a:	8622                	mv	a2,s0
 89c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a0:	00000097          	auipc	ra,0x0
 8a4:	e04080e7          	jalr	-508(ra) # 6a4 <vprintf>
}
 8a8:	60e2                	ld	ra,24(sp)
 8aa:	6442                	ld	s0,16(sp)
 8ac:	6161                	addi	sp,sp,80
 8ae:	8082                	ret

00000000000008b0 <printf>:

void
printf(const char *fmt, ...)
{
 8b0:	711d                	addi	sp,sp,-96
 8b2:	ec06                	sd	ra,24(sp)
 8b4:	e822                	sd	s0,16(sp)
 8b6:	1000                	addi	s0,sp,32
 8b8:	e40c                	sd	a1,8(s0)
 8ba:	e810                	sd	a2,16(s0)
 8bc:	ec14                	sd	a3,24(s0)
 8be:	f018                	sd	a4,32(s0)
 8c0:	f41c                	sd	a5,40(s0)
 8c2:	03043823          	sd	a6,48(s0)
 8c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	00840613          	addi	a2,s0,8
 8ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d2:	85aa                	mv	a1,a0
 8d4:	4505                	li	a0,1
 8d6:	00000097          	auipc	ra,0x0
 8da:	dce080e7          	jalr	-562(ra) # 6a4 <vprintf>
}
 8de:	60e2                	ld	ra,24(sp)
 8e0:	6442                	ld	s0,16(sp)
 8e2:	6125                	addi	sp,sp,96
 8e4:	8082                	ret

00000000000008e6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e6:	1141                	addi	sp,sp,-16
 8e8:	e422                	sd	s0,8(sp)
 8ea:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ec:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	00000797          	auipc	a5,0x0
 8f4:	2187b783          	ld	a5,536(a5) # b08 <freep>
 8f8:	a02d                	j	922 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fa:	4618                	lw	a4,8(a2)
 8fc:	9f2d                	addw	a4,a4,a1
 8fe:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 902:	6398                	ld	a4,0(a5)
 904:	6310                	ld	a2,0(a4)
 906:	a83d                	j	944 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 908:	ff852703          	lw	a4,-8(a0)
 90c:	9f31                	addw	a4,a4,a2
 90e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 910:	ff053683          	ld	a3,-16(a0)
 914:	a091                	j	958 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 916:	6398                	ld	a4,0(a5)
 918:	00e7e463          	bltu	a5,a4,920 <free+0x3a>
 91c:	00e6ea63          	bltu	a3,a4,930 <free+0x4a>
{
 920:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 922:	fed7fae3          	bgeu	a5,a3,916 <free+0x30>
 926:	6398                	ld	a4,0(a5)
 928:	00e6e463          	bltu	a3,a4,930 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92c:	fee7eae3          	bltu	a5,a4,920 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 930:	ff852583          	lw	a1,-8(a0)
 934:	6390                	ld	a2,0(a5)
 936:	02059813          	slli	a6,a1,0x20
 93a:	01c85713          	srli	a4,a6,0x1c
 93e:	9736                	add	a4,a4,a3
 940:	fae60de3          	beq	a2,a4,8fa <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 944:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 948:	4790                	lw	a2,8(a5)
 94a:	02061593          	slli	a1,a2,0x20
 94e:	01c5d713          	srli	a4,a1,0x1c
 952:	973e                	add	a4,a4,a5
 954:	fae68ae3          	beq	a3,a4,908 <free+0x22>
    p->s.ptr = bp->s.ptr;
 958:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 95a:	00000717          	auipc	a4,0x0
 95e:	1af73723          	sd	a5,430(a4) # b08 <freep>
}
 962:	6422                	ld	s0,8(sp)
 964:	0141                	addi	sp,sp,16
 966:	8082                	ret

0000000000000968 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 968:	7139                	addi	sp,sp,-64
 96a:	fc06                	sd	ra,56(sp)
 96c:	f822                	sd	s0,48(sp)
 96e:	f426                	sd	s1,40(sp)
 970:	f04a                	sd	s2,32(sp)
 972:	ec4e                	sd	s3,24(sp)
 974:	e852                	sd	s4,16(sp)
 976:	e456                	sd	s5,8(sp)
 978:	e05a                	sd	s6,0(sp)
 97a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 97c:	02051493          	slli	s1,a0,0x20
 980:	9081                	srli	s1,s1,0x20
 982:	04bd                	addi	s1,s1,15
 984:	8091                	srli	s1,s1,0x4
 986:	00148a1b          	addiw	s4,s1,1
 98a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 98c:	00000517          	auipc	a0,0x0
 990:	17c53503          	ld	a0,380(a0) # b08 <freep>
 994:	c515                	beqz	a0,9c0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 996:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 998:	4798                	lw	a4,8(a5)
 99a:	04977163          	bgeu	a4,s1,9dc <malloc+0x74>
 99e:	89d2                	mv	s3,s4
 9a0:	000a071b          	sext.w	a4,s4
 9a4:	6685                	lui	a3,0x1
 9a6:	00d77363          	bgeu	a4,a3,9ac <malloc+0x44>
 9aa:	6985                	lui	s3,0x1
 9ac:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 9b0:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b4:	00000917          	auipc	s2,0x0
 9b8:	15490913          	addi	s2,s2,340 # b08 <freep>
  if(p == (char*)-1)
 9bc:	5afd                	li	s5,-1
 9be:	a8a5                	j	a36 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 9c0:	00000797          	auipc	a5,0x0
 9c4:	14878793          	addi	a5,a5,328 # b08 <freep>
 9c8:	00000717          	auipc	a4,0x0
 9cc:	14870713          	addi	a4,a4,328 # b10 <base>
 9d0:	e398                	sd	a4,0(a5)
 9d2:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 9d4:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d8:	87ba                	mv	a5,a4
 9da:	b7d1                	j	99e <malloc+0x36>
      if(p->s.size == nunits)
 9dc:	02e48c63          	beq	s1,a4,a14 <malloc+0xac>
        p->s.size -= nunits;
 9e0:	4147073b          	subw	a4,a4,s4
 9e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e6:	02071693          	slli	a3,a4,0x20
 9ea:	01c6d713          	srli	a4,a3,0x1c
 9ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f0:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 9f4:	00000717          	auipc	a4,0x0
 9f8:	10a73a23          	sd	a0,276(a4) # b08 <freep>
      return (void*)(p + 1);
 9fc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a00:	70e2                	ld	ra,56(sp)
 a02:	7442                	ld	s0,48(sp)
 a04:	74a2                	ld	s1,40(sp)
 a06:	7902                	ld	s2,32(sp)
 a08:	69e2                	ld	s3,24(sp)
 a0a:	6a42                	ld	s4,16(sp)
 a0c:	6aa2                	ld	s5,8(sp)
 a0e:	6b02                	ld	s6,0(sp)
 a10:	6121                	addi	sp,sp,64
 a12:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a14:	6398                	ld	a4,0(a5)
 a16:	e118                	sd	a4,0(a0)
 a18:	bff1                	j	9f4 <malloc+0x8c>
  hp->s.size = nu;
 a1a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a1e:	0541                	addi	a0,a0,16
 a20:	00000097          	auipc	ra,0x0
 a24:	ec6080e7          	jalr	-314(ra) # 8e6 <free>
  return freep;
 a28:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a2c:	d971                	beqz	a0,a00 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a2e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a30:	4798                	lw	a4,8(a5)
 a32:	fa9775e3          	bgeu	a4,s1,9dc <malloc+0x74>
    if(p == freep)
 a36:	00093703          	ld	a4,0(s2)
 a3a:	853e                	mv	a0,a5
 a3c:	fef719e3          	bne	a4,a5,a2e <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a40:	854e                	mv	a0,s3
 a42:	00000097          	auipc	ra,0x0
 a46:	95e080e7          	jalr	-1698(ra) # 3a0 <sbrk>
  if(p == (char*)-1)
 a4a:	fd5518e3          	bne	a0,s5,a1a <malloc+0xb2>
        return 0;
 a4e:	4501                	li	a0,0
 a50:	bf45                	j	a00 <malloc+0x98>
