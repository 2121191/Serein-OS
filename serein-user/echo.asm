
serein-user/_echo：     文件格式 elf64-littleriscv


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
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	02099793          	slli	a5,s3,0x20
  22:	01d7d993          	srli	s3,a5,0x1d
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	a36a0a13          	addi	s4,s4,-1482 # a60 <malloc+0xec>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	0c2080e7          	jalr	194(ra) # fa <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	314080e7          	jalr	788(ra) # 35c <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	300080e7          	jalr	768(ra) # 35c <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	a0058593          	addi	a1,a1,-1536 # a68 <malloc+0xf4>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	2ea080e7          	jalr	746(ra) # 35c <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	2c0080e7          	jalr	704(ra) # 33c <exit>

0000000000000084 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  84:	1141                	addi	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	87aa                	mv	a5,a0
  8c:	0585                	addi	a1,a1,1
  8e:	0785                	addi	a5,a5,1
  90:	fff5c703          	lbu	a4,-1(a1)
  94:	fee78fa3          	sb	a4,-1(a5)
  98:	fb75                	bnez	a4,8c <strcpy+0x8>
    ;
  return os;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret

00000000000000a0 <strcat>:

char*
strcat(char *s, const char *t)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	c385                	beqz	a5,ca <strcat+0x2a>
  ac:	87aa                	mv	a5,a0
    s++;
  ae:	0785                	addi	a5,a5,1
  while(*s)
  b0:	0007c703          	lbu	a4,0(a5)
  b4:	ff6d                	bnez	a4,ae <strcat+0xe>
  while((*s++ = *t++))
  b6:	0585                	addi	a1,a1,1
  b8:	0785                	addi	a5,a5,1
  ba:	fff5c703          	lbu	a4,-1(a1)
  be:	fee78fa3          	sb	a4,-1(a5)
  c2:	fb75                	bnez	a4,b6 <strcat+0x16>
    ;
  return os;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret
  while(*s)
  ca:	87aa                	mv	a5,a0
  cc:	b7ed                	j	b6 <strcat+0x16>

00000000000000ce <strcmp>:


int
strcmp(const char *p, const char *q)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  d4:	00054783          	lbu	a5,0(a0)
  d8:	cb91                	beqz	a5,ec <strcmp+0x1e>
  da:	0005c703          	lbu	a4,0(a1)
  de:	00f71763          	bne	a4,a5,ec <strcmp+0x1e>
    p++, q++;
  e2:	0505                	addi	a0,a0,1
  e4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	fbe5                	bnez	a5,da <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ec:	0005c503          	lbu	a0,0(a1)
}
  f0:	40a7853b          	subw	a0,a5,a0
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret

00000000000000fa <strlen>:

uint
strlen(const char *s)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 100:	00054783          	lbu	a5,0(a0)
 104:	cf91                	beqz	a5,120 <strlen+0x26>
 106:	0505                	addi	a0,a0,1
 108:	87aa                	mv	a5,a0
 10a:	4685                	li	a3,1
 10c:	9e89                	subw	a3,a3,a0
 10e:	00f6853b          	addw	a0,a3,a5
 112:	0785                	addi	a5,a5,1
 114:	fff7c703          	lbu	a4,-1(a5)
 118:	fb7d                	bnez	a4,10e <strlen+0x14>
    ;
  return n;
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret
  for(n = 0; s[n]; n++)
 120:	4501                	li	a0,0
 122:	bfe5                	j	11a <strlen+0x20>

0000000000000124 <memset>:

void*
memset(void *dst, int c, uint n)
{
 124:	1141                	addi	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 12a:	ca19                	beqz	a2,140 <memset+0x1c>
 12c:	87aa                	mv	a5,a0
 12e:	1602                	slli	a2,a2,0x20
 130:	9201                	srli	a2,a2,0x20
 132:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 136:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 13a:	0785                	addi	a5,a5,1
 13c:	fee79de3          	bne	a5,a4,136 <memset+0x12>
  }
  return dst;
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret

0000000000000146 <strchr>:

char*
strchr(const char *s, char c)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 14c:	00054783          	lbu	a5,0(a0)
 150:	cb99                	beqz	a5,166 <strchr+0x20>
    if(*s == c)
 152:	00f58763          	beq	a1,a5,160 <strchr+0x1a>
  for(; *s; s++)
 156:	0505                	addi	a0,a0,1
 158:	00054783          	lbu	a5,0(a0)
 15c:	fbfd                	bnez	a5,152 <strchr+0xc>
      return (char*)s;
  return 0;
 15e:	4501                	li	a0,0
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret
  return 0;
 166:	4501                	li	a0,0
 168:	bfe5                	j	160 <strchr+0x1a>

000000000000016a <gets>:

char*
gets(char *buf, int max)
{
 16a:	711d                	addi	sp,sp,-96
 16c:	ec86                	sd	ra,88(sp)
 16e:	e8a2                	sd	s0,80(sp)
 170:	e4a6                	sd	s1,72(sp)
 172:	e0ca                	sd	s2,64(sp)
 174:	fc4e                	sd	s3,56(sp)
 176:	f852                	sd	s4,48(sp)
 178:	f456                	sd	s5,40(sp)
 17a:	f05a                	sd	s6,32(sp)
 17c:	ec5e                	sd	s7,24(sp)
 17e:	e862                	sd	s8,16(sp)
 180:	1080                	addi	s0,sp,96
 182:	8baa                	mv	s7,a0
 184:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 186:	892a                	mv	s2,a0
 188:	4481                	li	s1,0
    cc = read(0, &c, 1);
 18a:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 18e:	4b29                	li	s6,10
 190:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 192:	89a6                	mv	s3,s1
 194:	2485                	addiw	s1,s1,1
 196:	0344d763          	bge	s1,s4,1c4 <gets+0x5a>
    cc = read(0, &c, 1);
 19a:	4605                	li	a2,1
 19c:	85d6                	mv	a1,s5
 19e:	4501                	li	a0,0
 1a0:	00000097          	auipc	ra,0x0
 1a4:	1b4080e7          	jalr	436(ra) # 354 <read>
    if(cc < 1)
 1a8:	00a05e63          	blez	a0,1c4 <gets+0x5a>
    buf[i++] = c;
 1ac:	faf44783          	lbu	a5,-81(s0)
 1b0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1b4:	01678763          	beq	a5,s6,1c2 <gets+0x58>
 1b8:	0905                	addi	s2,s2,1
 1ba:	fd879ce3          	bne	a5,s8,192 <gets+0x28>
  for(i=0; i+1 < max; ){
 1be:	89a6                	mv	s3,s1
 1c0:	a011                	j	1c4 <gets+0x5a>
 1c2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1c4:	99de                	add	s3,s3,s7
 1c6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1ca:	855e                	mv	a0,s7
 1cc:	60e6                	ld	ra,88(sp)
 1ce:	6446                	ld	s0,80(sp)
 1d0:	64a6                	ld	s1,72(sp)
 1d2:	6906                	ld	s2,64(sp)
 1d4:	79e2                	ld	s3,56(sp)
 1d6:	7a42                	ld	s4,48(sp)
 1d8:	7aa2                	ld	s5,40(sp)
 1da:	7b02                	ld	s6,32(sp)
 1dc:	6be2                	ld	s7,24(sp)
 1de:	6c42                	ld	s8,16(sp)
 1e0:	6125                	addi	sp,sp,96
 1e2:	8082                	ret

00000000000001e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e4:	1101                	addi	sp,sp,-32
 1e6:	ec06                	sd	ra,24(sp)
 1e8:	e822                	sd	s0,16(sp)
 1ea:	e426                	sd	s1,8(sp)
 1ec:	e04a                	sd	s2,0(sp)
 1ee:	1000                	addi	s0,sp,32
 1f0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f2:	4581                	li	a1,0
 1f4:	00000097          	auipc	ra,0x0
 1f8:	188080e7          	jalr	392(ra) # 37c <open>
  if(fd < 0)
 1fc:	02054563          	bltz	a0,226 <stat+0x42>
 200:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 202:	85ca                	mv	a1,s2
 204:	00000097          	auipc	ra,0x0
 208:	180080e7          	jalr	384(ra) # 384 <fstat>
 20c:	892a                	mv	s2,a0
  close(fd);
 20e:	8526                	mv	a0,s1
 210:	00000097          	auipc	ra,0x0
 214:	154080e7          	jalr	340(ra) # 364 <close>
  return r;
}
 218:	854a                	mv	a0,s2
 21a:	60e2                	ld	ra,24(sp)
 21c:	6442                	ld	s0,16(sp)
 21e:	64a2                	ld	s1,8(sp)
 220:	6902                	ld	s2,0(sp)
 222:	6105                	addi	sp,sp,32
 224:	8082                	ret
    return -1;
 226:	597d                	li	s2,-1
 228:	bfc5                	j	218 <stat+0x34>

000000000000022a <atoi>:

int
atoi(const char *s)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 230:	00054703          	lbu	a4,0(a0)
 234:	02d00793          	li	a5,45
  int neg = 1;
 238:	4585                	li	a1,1
  if (*s == '-') {
 23a:	04f70363          	beq	a4,a5,280 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 23e:	00054703          	lbu	a4,0(a0)
 242:	fd07079b          	addiw	a5,a4,-48
 246:	0ff7f793          	zext.b	a5,a5
 24a:	46a5                	li	a3,9
 24c:	02f6ed63          	bltu	a3,a5,286 <atoi+0x5c>
  n = 0;
 250:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 252:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 254:	0505                	addi	a0,a0,1
 256:	0026979b          	slliw	a5,a3,0x2
 25a:	9fb5                	addw	a5,a5,a3
 25c:	0017979b          	slliw	a5,a5,0x1
 260:	9fb9                	addw	a5,a5,a4
 262:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 266:	00054703          	lbu	a4,0(a0)
 26a:	fd07079b          	addiw	a5,a4,-48
 26e:	0ff7f793          	zext.b	a5,a5
 272:	fef671e3          	bgeu	a2,a5,254 <atoi+0x2a>
  return n * neg;
}
 276:	02d5853b          	mulw	a0,a1,a3
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
    s++;
 280:	0505                	addi	a0,a0,1
    neg = -1;
 282:	55fd                	li	a1,-1
 284:	bf6d                	j	23e <atoi+0x14>
  n = 0;
 286:	4681                	li	a3,0
 288:	b7fd                	j	276 <atoi+0x4c>

000000000000028a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e422                	sd	s0,8(sp)
 28e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 290:	02b57463          	bgeu	a0,a1,2b8 <memmove+0x2e>
    while(n-- > 0)
 294:	00c05f63          	blez	a2,2b2 <memmove+0x28>
 298:	1602                	slli	a2,a2,0x20
 29a:	9201                	srli	a2,a2,0x20
 29c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2a2:	0585                	addi	a1,a1,1
 2a4:	0705                	addi	a4,a4,1
 2a6:	fff5c683          	lbu	a3,-1(a1)
 2aa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ae:	fee79ae3          	bne	a5,a4,2a2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2b2:	6422                	ld	s0,8(sp)
 2b4:	0141                	addi	sp,sp,16
 2b6:	8082                	ret
    dst += n;
 2b8:	00c50733          	add	a4,a0,a2
    src += n;
 2bc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2be:	fec05ae3          	blez	a2,2b2 <memmove+0x28>
 2c2:	fff6079b          	addiw	a5,a2,-1
 2c6:	1782                	slli	a5,a5,0x20
 2c8:	9381                	srli	a5,a5,0x20
 2ca:	fff7c793          	not	a5,a5
 2ce:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d0:	15fd                	addi	a1,a1,-1
 2d2:	177d                	addi	a4,a4,-1
 2d4:	0005c683          	lbu	a3,0(a1)
 2d8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2dc:	fee79ae3          	bne	a5,a4,2d0 <memmove+0x46>
 2e0:	bfc9                	j	2b2 <memmove+0x28>

00000000000002e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2e8:	ca05                	beqz	a2,318 <memcmp+0x36>
 2ea:	fff6069b          	addiw	a3,a2,-1
 2ee:	1682                	slli	a3,a3,0x20
 2f0:	9281                	srli	a3,a3,0x20
 2f2:	0685                	addi	a3,a3,1
 2f4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2f6:	00054783          	lbu	a5,0(a0)
 2fa:	0005c703          	lbu	a4,0(a1)
 2fe:	00e79863          	bne	a5,a4,30e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 302:	0505                	addi	a0,a0,1
    p2++;
 304:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 306:	fed518e3          	bne	a0,a3,2f6 <memcmp+0x14>
  }
  return 0;
 30a:	4501                	li	a0,0
 30c:	a019                	j	312 <memcmp+0x30>
      return *p1 - *p2;
 30e:	40e7853b          	subw	a0,a5,a4
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret
  return 0;
 318:	4501                	li	a0,0
 31a:	bfe5                	j	312 <memcmp+0x30>

000000000000031c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e406                	sd	ra,8(sp)
 320:	e022                	sd	s0,0(sp)
 322:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 324:	00000097          	auipc	ra,0x0
 328:	f66080e7          	jalr	-154(ra) # 28a <memmove>
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret

0000000000000334 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 334:	4885                	li	a7,1
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <exit>:
.global exit
exit:
 li a7, SYS_exit
 33c:	4889                	li	a7,2
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <wait>:
.global wait
wait:
 li a7, SYS_wait
 344:	488d                	li	a7,3
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 34c:	4891                	li	a7,4
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <read>:
.global read
read:
 li a7, SYS_read
 354:	4895                	li	a7,5
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <write>:
.global write
write:
 li a7, SYS_write
 35c:	48c1                	li	a7,16
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <close>:
.global close
close:
 li a7, SYS_close
 364:	48d5                	li	a7,21
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <kill>:
.global kill
kill:
 li a7, SYS_kill
 36c:	4899                	li	a7,6
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <exec>:
.global exec
exec:
 li a7, SYS_exec
 374:	489d                	li	a7,7
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <open>:
.global open
open:
 li a7, SYS_open
 37c:	48bd                	li	a7,15
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 384:	48a1                	li	a7,8
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 38c:	48d1                	li	a7,20
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 394:	48a5                	li	a7,9
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <dup>:
.global dup
dup:
 li a7, SYS_dup
 39c:	48a9                	li	a7,10
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a4:	48ad                	li	a7,11
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ac:	48b1                	li	a7,12
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b4:	48b5                	li	a7,13
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3bc:	48b9                	li	a7,14
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3c4:	48d9                	li	a7,22
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <dev>:
.global dev
dev:
 li a7, SYS_dev
 3cc:	48dd                	li	a7,23
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3d4:	48e1                	li	a7,24
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3dc:	48e5                	li	a7,25
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <remove>:
.global remove
remove:
 li a7, SYS_remove
 3e4:	48c5                	li	a7,17
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <trace>:
.global trace
trace:
 li a7, SYS_trace
 3ec:	48c9                	li	a7,18
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3f4:	48cd                	li	a7,19
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <rename>:
.global rename
rename:
 li a7, SYS_rename
 3fc:	48e9                	li	a7,26
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 404:	48ed                	li	a7,27
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 40c:	48f1                	li	a7,28
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 414:	48f5                	li	a7,29
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 41c:	48f9                	li	a7,30
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 424:	48fd                	li	a7,31
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 42c:	02000893          	li	a7,32
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 436:	02100893          	li	a7,33
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 440:	02200893          	li	a7,34
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 44a:	02300893          	li	a7,35
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 454:	02400893          	li	a7,36
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 45e:	02500893          	li	a7,37
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 468:	02600893          	li	a7,38
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 472:	02700893          	li	a7,39
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 47c:	02800893          	li	a7,40
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 486:	02900893          	li	a7,41
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 490:	02a00893          	li	a7,42
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 49a:	02b00893          	li	a7,43
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 4a4:	02c00893          	li	a7,44
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4ae:	02d00893          	li	a7,45
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4b8:	02e00893          	li	a7,46
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4c2:	02f00893          	li	a7,47
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 4cc:	03000893          	li	a7,48
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 4d6:	03100893          	li	a7,49
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 4e0:	03200893          	li	a7,50
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 4ea:	03300893          	li	a7,51
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 4f4:	03400893          	li	a7,52
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 4fe:	03500893          	li	a7,53
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 508:	03600893          	li	a7,54
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 512:	03700893          	li	a7,55
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 51c:	03800893          	li	a7,56
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 526:	03900893          	li	a7,57
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 530:	03a00893          	li	a7,58
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <poll>:
.global poll
poll:
 li a7, SYS_poll
 53a:	03b00893          	li	a7,59
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 544:	03c00893          	li	a7,60
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 54e:	03d00893          	li	a7,61
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 558:	03e00893          	li	a7,62
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <clone>:
.global clone
clone:
 li a7, SYS_clone
 562:	03f00893          	li	a7,63
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <futex>:
.global futex
futex:
 li a7, SYS_futex
 56c:	04000893          	li	a7,64
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 576:	04100893          	li	a7,65
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <halt>:
.global halt
halt:
 li a7, SYS_halt
 580:	04200893          	li	a7,66
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 58a:	04300893          	li	a7,67
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <socket>:
.global socket
socket:
 li a7, SYS_socket
 594:	04400893          	li	a7,68
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <bind>:
.global bind
bind:
 li a7, SYS_bind
 59e:	04500893          	li	a7,69
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <listen>:
.global listen
listen:
 li a7, SYS_listen
 5a8:	04600893          	li	a7,70
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5b2:	04700893          	li	a7,71
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <connect>:
.global connect
connect:
 li a7, SYS_connect
 5bc:	04800893          	li	a7,72
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <send>:
.global send
send:
 li a7, SYS_send
 5c6:	04900893          	li	a7,73
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5d0:	04a00893          	li	a7,74
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 5da:	04b00893          	li	a7,75
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5e4:	1101                	addi	sp,sp,-32
 5e6:	ec06                	sd	ra,24(sp)
 5e8:	e822                	sd	s0,16(sp)
 5ea:	1000                	addi	s0,sp,32
 5ec:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5f0:	4605                	li	a2,1
 5f2:	fef40593          	addi	a1,s0,-17
 5f6:	00000097          	auipc	ra,0x0
 5fa:	d66080e7          	jalr	-666(ra) # 35c <write>
}
 5fe:	60e2                	ld	ra,24(sp)
 600:	6442                	ld	s0,16(sp)
 602:	6105                	addi	sp,sp,32
 604:	8082                	ret

0000000000000606 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 606:	7139                	addi	sp,sp,-64
 608:	fc06                	sd	ra,56(sp)
 60a:	f822                	sd	s0,48(sp)
 60c:	f426                	sd	s1,40(sp)
 60e:	f04a                	sd	s2,32(sp)
 610:	ec4e                	sd	s3,24(sp)
 612:	0080                	addi	s0,sp,64
 614:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 616:	c299                	beqz	a3,61c <printint+0x16>
 618:	0805c863          	bltz	a1,6a8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 61c:	2581                	sext.w	a1,a1
  neg = 0;
 61e:	4881                	li	a7,0
  }

  i = 0;
 620:	fc040993          	addi	s3,s0,-64
  neg = 0;
 624:	86ce                	mv	a3,s3
  i = 0;
 626:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 628:	2601                	sext.w	a2,a2
 62a:	00000517          	auipc	a0,0x0
 62e:	4a650513          	addi	a0,a0,1190 # ad0 <digits>
 632:	883a                	mv	a6,a4
 634:	2705                	addiw	a4,a4,1
 636:	02c5f7bb          	remuw	a5,a1,a2
 63a:	1782                	slli	a5,a5,0x20
 63c:	9381                	srli	a5,a5,0x20
 63e:	97aa                	add	a5,a5,a0
 640:	0007c783          	lbu	a5,0(a5)
 644:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 648:	0005879b          	sext.w	a5,a1
 64c:	02c5d5bb          	divuw	a1,a1,a2
 650:	0685                	addi	a3,a3,1
 652:	fec7f0e3          	bgeu	a5,a2,632 <printint+0x2c>
  if(neg)
 656:	00088c63          	beqz	a7,66e <printint+0x68>
    buf[i++] = '-';
 65a:	fd070793          	addi	a5,a4,-48
 65e:	00878733          	add	a4,a5,s0
 662:	02d00793          	li	a5,45
 666:	fef70823          	sb	a5,-16(a4)
 66a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 66e:	02e05663          	blez	a4,69a <printint+0x94>
 672:	fc040913          	addi	s2,s0,-64
 676:	993a                	add	s2,s2,a4
 678:	19fd                	addi	s3,s3,-1
 67a:	99ba                	add	s3,s3,a4
 67c:	377d                	addiw	a4,a4,-1
 67e:	1702                	slli	a4,a4,0x20
 680:	9301                	srli	a4,a4,0x20
 682:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 686:	fff94583          	lbu	a1,-1(s2)
 68a:	8526                	mv	a0,s1
 68c:	00000097          	auipc	ra,0x0
 690:	f58080e7          	jalr	-168(ra) # 5e4 <putc>
  while(--i >= 0)
 694:	197d                	addi	s2,s2,-1
 696:	ff3918e3          	bne	s2,s3,686 <printint+0x80>
}
 69a:	70e2                	ld	ra,56(sp)
 69c:	7442                	ld	s0,48(sp)
 69e:	74a2                	ld	s1,40(sp)
 6a0:	7902                	ld	s2,32(sp)
 6a2:	69e2                	ld	s3,24(sp)
 6a4:	6121                	addi	sp,sp,64
 6a6:	8082                	ret
    x = -xx;
 6a8:	40b005bb          	negw	a1,a1
    neg = 1;
 6ac:	4885                	li	a7,1
    x = -xx;
 6ae:	bf8d                	j	620 <printint+0x1a>

00000000000006b0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6b0:	7119                	addi	sp,sp,-128
 6b2:	fc86                	sd	ra,120(sp)
 6b4:	f8a2                	sd	s0,112(sp)
 6b6:	f4a6                	sd	s1,104(sp)
 6b8:	f0ca                	sd	s2,96(sp)
 6ba:	ecce                	sd	s3,88(sp)
 6bc:	e8d2                	sd	s4,80(sp)
 6be:	e4d6                	sd	s5,72(sp)
 6c0:	e0da                	sd	s6,64(sp)
 6c2:	fc5e                	sd	s7,56(sp)
 6c4:	f862                	sd	s8,48(sp)
 6c6:	f466                	sd	s9,40(sp)
 6c8:	f06a                	sd	s10,32(sp)
 6ca:	ec6e                	sd	s11,24(sp)
 6cc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ce:	0005c903          	lbu	s2,0(a1)
 6d2:	18090f63          	beqz	s2,870 <vprintf+0x1c0>
 6d6:	8aaa                	mv	s5,a0
 6d8:	8b32                	mv	s6,a2
 6da:	00158493          	addi	s1,a1,1
  state = 0;
 6de:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6e0:	02500a13          	li	s4,37
 6e4:	4c55                	li	s8,21
 6e6:	00000c97          	auipc	s9,0x0
 6ea:	392c8c93          	addi	s9,s9,914 # a78 <malloc+0x104>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6ee:	02800d93          	li	s11,40
  putc(fd, 'x');
 6f2:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f4:	00000b97          	auipc	s7,0x0
 6f8:	3dcb8b93          	addi	s7,s7,988 # ad0 <digits>
 6fc:	a839                	j	71a <vprintf+0x6a>
        putc(fd, c);
 6fe:	85ca                	mv	a1,s2
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	ee2080e7          	jalr	-286(ra) # 5e4 <putc>
 70a:	a019                	j	710 <vprintf+0x60>
    } else if(state == '%'){
 70c:	01498d63          	beq	s3,s4,726 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 710:	0485                	addi	s1,s1,1
 712:	fff4c903          	lbu	s2,-1(s1)
 716:	14090d63          	beqz	s2,870 <vprintf+0x1c0>
    if(state == 0){
 71a:	fe0999e3          	bnez	s3,70c <vprintf+0x5c>
      if(c == '%'){
 71e:	ff4910e3          	bne	s2,s4,6fe <vprintf+0x4e>
        state = '%';
 722:	89d2                	mv	s3,s4
 724:	b7f5                	j	710 <vprintf+0x60>
      if(c == 'd'){
 726:	11490c63          	beq	s2,s4,83e <vprintf+0x18e>
 72a:	f9d9079b          	addiw	a5,s2,-99
 72e:	0ff7f793          	zext.b	a5,a5
 732:	10fc6e63          	bltu	s8,a5,84e <vprintf+0x19e>
 736:	f9d9079b          	addiw	a5,s2,-99
 73a:	0ff7f713          	zext.b	a4,a5
 73e:	10ec6863          	bltu	s8,a4,84e <vprintf+0x19e>
 742:	00271793          	slli	a5,a4,0x2
 746:	97e6                	add	a5,a5,s9
 748:	439c                	lw	a5,0(a5)
 74a:	97e6                	add	a5,a5,s9
 74c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 74e:	008b0913          	addi	s2,s6,8
 752:	4685                	li	a3,1
 754:	4629                	li	a2,10
 756:	000b2583          	lw	a1,0(s6)
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	eaa080e7          	jalr	-342(ra) # 606 <printint>
 764:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 766:	4981                	li	s3,0
 768:	b765                	j	710 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76a:	008b0913          	addi	s2,s6,8
 76e:	4681                	li	a3,0
 770:	4629                	li	a2,10
 772:	000b2583          	lw	a1,0(s6)
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	e8e080e7          	jalr	-370(ra) # 606 <printint>
 780:	8b4a                	mv	s6,s2
      state = 0;
 782:	4981                	li	s3,0
 784:	b771                	j	710 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 786:	008b0913          	addi	s2,s6,8
 78a:	4681                	li	a3,0
 78c:	866a                	mv	a2,s10
 78e:	000b2583          	lw	a1,0(s6)
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	e72080e7          	jalr	-398(ra) # 606 <printint>
 79c:	8b4a                	mv	s6,s2
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	bf85                	j	710 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7a2:	008b0793          	addi	a5,s6,8
 7a6:	f8f43423          	sd	a5,-120(s0)
 7aa:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7ae:	03000593          	li	a1,48
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	e30080e7          	jalr	-464(ra) # 5e4 <putc>
  putc(fd, 'x');
 7bc:	07800593          	li	a1,120
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	e22080e7          	jalr	-478(ra) # 5e4 <putc>
 7ca:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7cc:	03c9d793          	srli	a5,s3,0x3c
 7d0:	97de                	add	a5,a5,s7
 7d2:	0007c583          	lbu	a1,0(a5)
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e0c080e7          	jalr	-500(ra) # 5e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e0:	0992                	slli	s3,s3,0x4
 7e2:	397d                	addiw	s2,s2,-1
 7e4:	fe0914e3          	bnez	s2,7cc <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7e8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	b70d                	j	710 <vprintf+0x60>
        s = va_arg(ap, char*);
 7f0:	008b0913          	addi	s2,s6,8
 7f4:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7f8:	02098163          	beqz	s3,81a <vprintf+0x16a>
        while(*s != 0){
 7fc:	0009c583          	lbu	a1,0(s3)
 800:	c5ad                	beqz	a1,86a <vprintf+0x1ba>
          putc(fd, *s);
 802:	8556                	mv	a0,s5
 804:	00000097          	auipc	ra,0x0
 808:	de0080e7          	jalr	-544(ra) # 5e4 <putc>
          s++;
 80c:	0985                	addi	s3,s3,1
        while(*s != 0){
 80e:	0009c583          	lbu	a1,0(s3)
 812:	f9e5                	bnez	a1,802 <vprintf+0x152>
        s = va_arg(ap, char*);
 814:	8b4a                	mv	s6,s2
      state = 0;
 816:	4981                	li	s3,0
 818:	bde5                	j	710 <vprintf+0x60>
          s = "(null)";
 81a:	00000997          	auipc	s3,0x0
 81e:	25698993          	addi	s3,s3,598 # a70 <malloc+0xfc>
        while(*s != 0){
 822:	85ee                	mv	a1,s11
 824:	bff9                	j	802 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 826:	008b0913          	addi	s2,s6,8
 82a:	000b4583          	lbu	a1,0(s6)
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	db4080e7          	jalr	-588(ra) # 5e4 <putc>
 838:	8b4a                	mv	s6,s2
      state = 0;
 83a:	4981                	li	s3,0
 83c:	bdd1                	j	710 <vprintf+0x60>
        putc(fd, c);
 83e:	85d2                	mv	a1,s4
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	da2080e7          	jalr	-606(ra) # 5e4 <putc>
      state = 0;
 84a:	4981                	li	s3,0
 84c:	b5d1                	j	710 <vprintf+0x60>
        putc(fd, '%');
 84e:	85d2                	mv	a1,s4
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	d92080e7          	jalr	-622(ra) # 5e4 <putc>
        putc(fd, c);
 85a:	85ca                	mv	a1,s2
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	d86080e7          	jalr	-634(ra) # 5e4 <putc>
      state = 0;
 866:	4981                	li	s3,0
 868:	b565                	j	710 <vprintf+0x60>
        s = va_arg(ap, char*);
 86a:	8b4a                	mv	s6,s2
      state = 0;
 86c:	4981                	li	s3,0
 86e:	b54d                	j	710 <vprintf+0x60>
    }
  }
}
 870:	70e6                	ld	ra,120(sp)
 872:	7446                	ld	s0,112(sp)
 874:	74a6                	ld	s1,104(sp)
 876:	7906                	ld	s2,96(sp)
 878:	69e6                	ld	s3,88(sp)
 87a:	6a46                	ld	s4,80(sp)
 87c:	6aa6                	ld	s5,72(sp)
 87e:	6b06                	ld	s6,64(sp)
 880:	7be2                	ld	s7,56(sp)
 882:	7c42                	ld	s8,48(sp)
 884:	7ca2                	ld	s9,40(sp)
 886:	7d02                	ld	s10,32(sp)
 888:	6de2                	ld	s11,24(sp)
 88a:	6109                	addi	sp,sp,128
 88c:	8082                	ret

000000000000088e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 88e:	715d                	addi	sp,sp,-80
 890:	ec06                	sd	ra,24(sp)
 892:	e822                	sd	s0,16(sp)
 894:	1000                	addi	s0,sp,32
 896:	e010                	sd	a2,0(s0)
 898:	e414                	sd	a3,8(s0)
 89a:	e818                	sd	a4,16(s0)
 89c:	ec1c                	sd	a5,24(s0)
 89e:	03043023          	sd	a6,32(s0)
 8a2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8a6:	8622                	mv	a2,s0
 8a8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ac:	00000097          	auipc	ra,0x0
 8b0:	e04080e7          	jalr	-508(ra) # 6b0 <vprintf>
}
 8b4:	60e2                	ld	ra,24(sp)
 8b6:	6442                	ld	s0,16(sp)
 8b8:	6161                	addi	sp,sp,80
 8ba:	8082                	ret

00000000000008bc <printf>:

void
printf(const char *fmt, ...)
{
 8bc:	711d                	addi	sp,sp,-96
 8be:	ec06                	sd	ra,24(sp)
 8c0:	e822                	sd	s0,16(sp)
 8c2:	1000                	addi	s0,sp,32
 8c4:	e40c                	sd	a1,8(s0)
 8c6:	e810                	sd	a2,16(s0)
 8c8:	ec14                	sd	a3,24(s0)
 8ca:	f018                	sd	a4,32(s0)
 8cc:	f41c                	sd	a5,40(s0)
 8ce:	03043823          	sd	a6,48(s0)
 8d2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8d6:	00840613          	addi	a2,s0,8
 8da:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8de:	85aa                	mv	a1,a0
 8e0:	4505                	li	a0,1
 8e2:	00000097          	auipc	ra,0x0
 8e6:	dce080e7          	jalr	-562(ra) # 6b0 <vprintf>
}
 8ea:	60e2                	ld	ra,24(sp)
 8ec:	6442                	ld	s0,16(sp)
 8ee:	6125                	addi	sp,sp,96
 8f0:	8082                	ret

00000000000008f2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f2:	1141                	addi	sp,sp,-16
 8f4:	e422                	sd	s0,8(sp)
 8f6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fc:	00000797          	auipc	a5,0x0
 900:	1ec7b783          	ld	a5,492(a5) # ae8 <freep>
 904:	a02d                	j	92e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 906:	4618                	lw	a4,8(a2)
 908:	9f2d                	addw	a4,a4,a1
 90a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 90e:	6398                	ld	a4,0(a5)
 910:	6310                	ld	a2,0(a4)
 912:	a83d                	j	950 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 914:	ff852703          	lw	a4,-8(a0)
 918:	9f31                	addw	a4,a4,a2
 91a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 91c:	ff053683          	ld	a3,-16(a0)
 920:	a091                	j	964 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 922:	6398                	ld	a4,0(a5)
 924:	00e7e463          	bltu	a5,a4,92c <free+0x3a>
 928:	00e6ea63          	bltu	a3,a4,93c <free+0x4a>
{
 92c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92e:	fed7fae3          	bgeu	a5,a3,922 <free+0x30>
 932:	6398                	ld	a4,0(a5)
 934:	00e6e463          	bltu	a3,a4,93c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 938:	fee7eae3          	bltu	a5,a4,92c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 93c:	ff852583          	lw	a1,-8(a0)
 940:	6390                	ld	a2,0(a5)
 942:	02059813          	slli	a6,a1,0x20
 946:	01c85713          	srli	a4,a6,0x1c
 94a:	9736                	add	a4,a4,a3
 94c:	fae60de3          	beq	a2,a4,906 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 950:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 954:	4790                	lw	a2,8(a5)
 956:	02061593          	slli	a1,a2,0x20
 95a:	01c5d713          	srli	a4,a1,0x1c
 95e:	973e                	add	a4,a4,a5
 960:	fae68ae3          	beq	a3,a4,914 <free+0x22>
    p->s.ptr = bp->s.ptr;
 964:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 966:	00000717          	auipc	a4,0x0
 96a:	18f73123          	sd	a5,386(a4) # ae8 <freep>
}
 96e:	6422                	ld	s0,8(sp)
 970:	0141                	addi	sp,sp,16
 972:	8082                	ret

0000000000000974 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 974:	7139                	addi	sp,sp,-64
 976:	fc06                	sd	ra,56(sp)
 978:	f822                	sd	s0,48(sp)
 97a:	f426                	sd	s1,40(sp)
 97c:	f04a                	sd	s2,32(sp)
 97e:	ec4e                	sd	s3,24(sp)
 980:	e852                	sd	s4,16(sp)
 982:	e456                	sd	s5,8(sp)
 984:	e05a                	sd	s6,0(sp)
 986:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 988:	02051493          	slli	s1,a0,0x20
 98c:	9081                	srli	s1,s1,0x20
 98e:	04bd                	addi	s1,s1,15
 990:	8091                	srli	s1,s1,0x4
 992:	00148a1b          	addiw	s4,s1,1
 996:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 998:	00000517          	auipc	a0,0x0
 99c:	15053503          	ld	a0,336(a0) # ae8 <freep>
 9a0:	c515                	beqz	a0,9cc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a4:	4798                	lw	a4,8(a5)
 9a6:	04977163          	bgeu	a4,s1,9e8 <malloc+0x74>
 9aa:	89d2                	mv	s3,s4
 9ac:	000a071b          	sext.w	a4,s4
 9b0:	6685                	lui	a3,0x1
 9b2:	00d77363          	bgeu	a4,a3,9b8 <malloc+0x44>
 9b6:	6985                	lui	s3,0x1
 9b8:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 9bc:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9c0:	00000917          	auipc	s2,0x0
 9c4:	12890913          	addi	s2,s2,296 # ae8 <freep>
  if(p == (char*)-1)
 9c8:	5afd                	li	s5,-1
 9ca:	a8a5                	j	a42 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 9cc:	00000797          	auipc	a5,0x0
 9d0:	11c78793          	addi	a5,a5,284 # ae8 <freep>
 9d4:	00000717          	auipc	a4,0x0
 9d8:	11c70713          	addi	a4,a4,284 # af0 <base>
 9dc:	e398                	sd	a4,0(a5)
 9de:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 9e0:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e4:	87ba                	mv	a5,a4
 9e6:	b7d1                	j	9aa <malloc+0x36>
      if(p->s.size == nunits)
 9e8:	02e48c63          	beq	s1,a4,a20 <malloc+0xac>
        p->s.size -= nunits;
 9ec:	4147073b          	subw	a4,a4,s4
 9f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9f2:	02071693          	slli	a3,a4,0x20
 9f6:	01c6d713          	srli	a4,a3,0x1c
 9fa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9fc:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a00:	00000717          	auipc	a4,0x0
 a04:	0ea73423          	sd	a0,232(a4) # ae8 <freep>
      return (void*)(p + 1);
 a08:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a0c:	70e2                	ld	ra,56(sp)
 a0e:	7442                	ld	s0,48(sp)
 a10:	74a2                	ld	s1,40(sp)
 a12:	7902                	ld	s2,32(sp)
 a14:	69e2                	ld	s3,24(sp)
 a16:	6a42                	ld	s4,16(sp)
 a18:	6aa2                	ld	s5,8(sp)
 a1a:	6b02                	ld	s6,0(sp)
 a1c:	6121                	addi	sp,sp,64
 a1e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a20:	6398                	ld	a4,0(a5)
 a22:	e118                	sd	a4,0(a0)
 a24:	bff1                	j	a00 <malloc+0x8c>
  hp->s.size = nu;
 a26:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a2a:	0541                	addi	a0,a0,16
 a2c:	00000097          	auipc	ra,0x0
 a30:	ec6080e7          	jalr	-314(ra) # 8f2 <free>
  return freep;
 a34:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a38:	d971                	beqz	a0,a0c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a3c:	4798                	lw	a4,8(a5)
 a3e:	fa9775e3          	bgeu	a4,s1,9e8 <malloc+0x74>
    if(p == freep)
 a42:	00093703          	ld	a4,0(s2)
 a46:	853e                	mv	a0,a5
 a48:	fef719e3          	bne	a4,a5,a3a <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a4c:	854e                	mv	a0,s3
 a4e:	00000097          	auipc	ra,0x0
 a52:	95e080e7          	jalr	-1698(ra) # 3ac <sbrk>
  if(p == (char*)-1)
 a56:	fd5518e3          	bne	a0,s5,a26 <malloc+0xb2>
        return 0;
 a5a:	4501                	li	a0,0
 a5c:	bf45                	j	a0c <malloc+0x98>
