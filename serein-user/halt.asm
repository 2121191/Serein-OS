
serein-user/_halt：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  halt();
   8:	00000097          	auipc	ra,0x0
   c:	50e080e7          	jalr	1294(ra) # 516 <halt>
  exit(0);
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	2c0080e7          	jalr	704(ra) # 2d2 <exit>

000000000000001a <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  1a:	1141                	addi	sp,sp,-16
  1c:	e422                	sd	s0,8(sp)
  1e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  20:	87aa                	mv	a5,a0
  22:	0585                	addi	a1,a1,1
  24:	0785                	addi	a5,a5,1
  26:	fff5c703          	lbu	a4,-1(a1)
  2a:	fee78fa3          	sb	a4,-1(a5)
  2e:	fb75                	bnez	a4,22 <strcpy+0x8>
    ;
  return os;
}
  30:	6422                	ld	s0,8(sp)
  32:	0141                	addi	sp,sp,16
  34:	8082                	ret

0000000000000036 <strcat>:

char*
strcat(char *s, const char *t)
{
  36:	1141                	addi	sp,sp,-16
  38:	e422                	sd	s0,8(sp)
  3a:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  3c:	00054783          	lbu	a5,0(a0)
  40:	c385                	beqz	a5,60 <strcat+0x2a>
  42:	87aa                	mv	a5,a0
    s++;
  44:	0785                	addi	a5,a5,1
  while(*s)
  46:	0007c703          	lbu	a4,0(a5)
  4a:	ff6d                	bnez	a4,44 <strcat+0xe>
  while((*s++ = *t++))
  4c:	0585                	addi	a1,a1,1
  4e:	0785                	addi	a5,a5,1
  50:	fff5c703          	lbu	a4,-1(a1)
  54:	fee78fa3          	sb	a4,-1(a5)
  58:	fb75                	bnez	a4,4c <strcat+0x16>
    ;
  return os;
}
  5a:	6422                	ld	s0,8(sp)
  5c:	0141                	addi	sp,sp,16
  5e:	8082                	ret
  while(*s)
  60:	87aa                	mv	a5,a0
  62:	b7ed                	j	4c <strcat+0x16>

0000000000000064 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  6a:	00054783          	lbu	a5,0(a0)
  6e:	cb91                	beqz	a5,82 <strcmp+0x1e>
  70:	0005c703          	lbu	a4,0(a1)
  74:	00f71763          	bne	a4,a5,82 <strcmp+0x1e>
    p++, q++;
  78:	0505                	addi	a0,a0,1
  7a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  7c:	00054783          	lbu	a5,0(a0)
  80:	fbe5                	bnez	a5,70 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  82:	0005c503          	lbu	a0,0(a1)
}
  86:	40a7853b          	subw	a0,a5,a0
  8a:	6422                	ld	s0,8(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret

0000000000000090 <strlen>:

uint
strlen(const char *s)
{
  90:	1141                	addi	sp,sp,-16
  92:	e422                	sd	s0,8(sp)
  94:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  96:	00054783          	lbu	a5,0(a0)
  9a:	cf91                	beqz	a5,b6 <strlen+0x26>
  9c:	0505                	addi	a0,a0,1
  9e:	87aa                	mv	a5,a0
  a0:	4685                	li	a3,1
  a2:	9e89                	subw	a3,a3,a0
  a4:	00f6853b          	addw	a0,a3,a5
  a8:	0785                	addi	a5,a5,1
  aa:	fff7c703          	lbu	a4,-1(a5)
  ae:	fb7d                	bnez	a4,a4 <strlen+0x14>
    ;
  return n;
}
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret
  for(n = 0; s[n]; n++)
  b6:	4501                	li	a0,0
  b8:	bfe5                	j	b0 <strlen+0x20>

00000000000000ba <memset>:

void*
memset(void *dst, int c, uint n)
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e422                	sd	s0,8(sp)
  be:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  c0:	ca19                	beqz	a2,d6 <memset+0x1c>
  c2:	87aa                	mv	a5,a0
  c4:	1602                	slli	a2,a2,0x20
  c6:	9201                	srli	a2,a2,0x20
  c8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  d0:	0785                	addi	a5,a5,1
  d2:	fee79de3          	bne	a5,a4,cc <memset+0x12>
  }
  return dst;
}
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret

00000000000000dc <strchr>:

char*
strchr(const char *s, char c)
{
  dc:	1141                	addi	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	addi	s0,sp,16
  for(; *s; s++)
  e2:	00054783          	lbu	a5,0(a0)
  e6:	cb99                	beqz	a5,fc <strchr+0x20>
    if(*s == c)
  e8:	00f58763          	beq	a1,a5,f6 <strchr+0x1a>
  for(; *s; s++)
  ec:	0505                	addi	a0,a0,1
  ee:	00054783          	lbu	a5,0(a0)
  f2:	fbfd                	bnez	a5,e8 <strchr+0xc>
      return (char*)s;
  return 0;
  f4:	4501                	li	a0,0
}
  f6:	6422                	ld	s0,8(sp)
  f8:	0141                	addi	sp,sp,16
  fa:	8082                	ret
  return 0;
  fc:	4501                	li	a0,0
  fe:	bfe5                	j	f6 <strchr+0x1a>

0000000000000100 <gets>:

char*
gets(char *buf, int max)
{
 100:	711d                	addi	sp,sp,-96
 102:	ec86                	sd	ra,88(sp)
 104:	e8a2                	sd	s0,80(sp)
 106:	e4a6                	sd	s1,72(sp)
 108:	e0ca                	sd	s2,64(sp)
 10a:	fc4e                	sd	s3,56(sp)
 10c:	f852                	sd	s4,48(sp)
 10e:	f456                	sd	s5,40(sp)
 110:	f05a                	sd	s6,32(sp)
 112:	ec5e                	sd	s7,24(sp)
 114:	e862                	sd	s8,16(sp)
 116:	1080                	addi	s0,sp,96
 118:	8baa                	mv	s7,a0
 11a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11c:	892a                	mv	s2,a0
 11e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 120:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 124:	4b29                	li	s6,10
 126:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 128:	89a6                	mv	s3,s1
 12a:	2485                	addiw	s1,s1,1
 12c:	0344d763          	bge	s1,s4,15a <gets+0x5a>
    cc = read(0, &c, 1);
 130:	4605                	li	a2,1
 132:	85d6                	mv	a1,s5
 134:	4501                	li	a0,0
 136:	00000097          	auipc	ra,0x0
 13a:	1b4080e7          	jalr	436(ra) # 2ea <read>
    if(cc < 1)
 13e:	00a05e63          	blez	a0,15a <gets+0x5a>
    buf[i++] = c;
 142:	faf44783          	lbu	a5,-81(s0)
 146:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 14a:	01678763          	beq	a5,s6,158 <gets+0x58>
 14e:	0905                	addi	s2,s2,1
 150:	fd879ce3          	bne	a5,s8,128 <gets+0x28>
  for(i=0; i+1 < max; ){
 154:	89a6                	mv	s3,s1
 156:	a011                	j	15a <gets+0x5a>
 158:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 15a:	99de                	add	s3,s3,s7
 15c:	00098023          	sb	zero,0(s3)
  return buf;
}
 160:	855e                	mv	a0,s7
 162:	60e6                	ld	ra,88(sp)
 164:	6446                	ld	s0,80(sp)
 166:	64a6                	ld	s1,72(sp)
 168:	6906                	ld	s2,64(sp)
 16a:	79e2                	ld	s3,56(sp)
 16c:	7a42                	ld	s4,48(sp)
 16e:	7aa2                	ld	s5,40(sp)
 170:	7b02                	ld	s6,32(sp)
 172:	6be2                	ld	s7,24(sp)
 174:	6c42                	ld	s8,16(sp)
 176:	6125                	addi	sp,sp,96
 178:	8082                	ret

000000000000017a <stat>:

int
stat(const char *n, struct stat *st)
{
 17a:	1101                	addi	sp,sp,-32
 17c:	ec06                	sd	ra,24(sp)
 17e:	e822                	sd	s0,16(sp)
 180:	e426                	sd	s1,8(sp)
 182:	e04a                	sd	s2,0(sp)
 184:	1000                	addi	s0,sp,32
 186:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 188:	4581                	li	a1,0
 18a:	00000097          	auipc	ra,0x0
 18e:	188080e7          	jalr	392(ra) # 312 <open>
  if(fd < 0)
 192:	02054563          	bltz	a0,1bc <stat+0x42>
 196:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 198:	85ca                	mv	a1,s2
 19a:	00000097          	auipc	ra,0x0
 19e:	180080e7          	jalr	384(ra) # 31a <fstat>
 1a2:	892a                	mv	s2,a0
  close(fd);
 1a4:	8526                	mv	a0,s1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	154080e7          	jalr	340(ra) # 2fa <close>
  return r;
}
 1ae:	854a                	mv	a0,s2
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	64a2                	ld	s1,8(sp)
 1b6:	6902                	ld	s2,0(sp)
 1b8:	6105                	addi	sp,sp,32
 1ba:	8082                	ret
    return -1;
 1bc:	597d                	li	s2,-1
 1be:	bfc5                	j	1ae <stat+0x34>

00000000000001c0 <atoi>:

int
atoi(const char *s)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 1c6:	00054703          	lbu	a4,0(a0)
 1ca:	02d00793          	li	a5,45
  int neg = 1;
 1ce:	4585                	li	a1,1
  if (*s == '-') {
 1d0:	04f70363          	beq	a4,a5,216 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 1d4:	00054703          	lbu	a4,0(a0)
 1d8:	fd07079b          	addiw	a5,a4,-48
 1dc:	0ff7f793          	zext.b	a5,a5
 1e0:	46a5                	li	a3,9
 1e2:	02f6ed63          	bltu	a3,a5,21c <atoi+0x5c>
  n = 0;
 1e6:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 1e8:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 1ea:	0505                	addi	a0,a0,1
 1ec:	0026979b          	slliw	a5,a3,0x2
 1f0:	9fb5                	addw	a5,a5,a3
 1f2:	0017979b          	slliw	a5,a5,0x1
 1f6:	9fb9                	addw	a5,a5,a4
 1f8:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 1fc:	00054703          	lbu	a4,0(a0)
 200:	fd07079b          	addiw	a5,a4,-48
 204:	0ff7f793          	zext.b	a5,a5
 208:	fef671e3          	bgeu	a2,a5,1ea <atoi+0x2a>
  return n * neg;
}
 20c:	02d5853b          	mulw	a0,a1,a3
 210:	6422                	ld	s0,8(sp)
 212:	0141                	addi	sp,sp,16
 214:	8082                	ret
    s++;
 216:	0505                	addi	a0,a0,1
    neg = -1;
 218:	55fd                	li	a1,-1
 21a:	bf6d                	j	1d4 <atoi+0x14>
  n = 0;
 21c:	4681                	li	a3,0
 21e:	b7fd                	j	20c <atoi+0x4c>

0000000000000220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 220:	1141                	addi	sp,sp,-16
 222:	e422                	sd	s0,8(sp)
 224:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 226:	02b57463          	bgeu	a0,a1,24e <memmove+0x2e>
    while(n-- > 0)
 22a:	00c05f63          	blez	a2,248 <memmove+0x28>
 22e:	1602                	slli	a2,a2,0x20
 230:	9201                	srli	a2,a2,0x20
 232:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 236:	872a                	mv	a4,a0
      *dst++ = *src++;
 238:	0585                	addi	a1,a1,1
 23a:	0705                	addi	a4,a4,1
 23c:	fff5c683          	lbu	a3,-1(a1)
 240:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 244:	fee79ae3          	bne	a5,a4,238 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
    dst += n;
 24e:	00c50733          	add	a4,a0,a2
    src += n;
 252:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 254:	fec05ae3          	blez	a2,248 <memmove+0x28>
 258:	fff6079b          	addiw	a5,a2,-1
 25c:	1782                	slli	a5,a5,0x20
 25e:	9381                	srli	a5,a5,0x20
 260:	fff7c793          	not	a5,a5
 264:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 266:	15fd                	addi	a1,a1,-1
 268:	177d                	addi	a4,a4,-1
 26a:	0005c683          	lbu	a3,0(a1)
 26e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 272:	fee79ae3          	bne	a5,a4,266 <memmove+0x46>
 276:	bfc9                	j	248 <memmove+0x28>

0000000000000278 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 278:	1141                	addi	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 27e:	ca05                	beqz	a2,2ae <memcmp+0x36>
 280:	fff6069b          	addiw	a3,a2,-1
 284:	1682                	slli	a3,a3,0x20
 286:	9281                	srli	a3,a3,0x20
 288:	0685                	addi	a3,a3,1
 28a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 28c:	00054783          	lbu	a5,0(a0)
 290:	0005c703          	lbu	a4,0(a1)
 294:	00e79863          	bne	a5,a4,2a4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 298:	0505                	addi	a0,a0,1
    p2++;
 29a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 29c:	fed518e3          	bne	a0,a3,28c <memcmp+0x14>
  }
  return 0;
 2a0:	4501                	li	a0,0
 2a2:	a019                	j	2a8 <memcmp+0x30>
      return *p1 - *p2;
 2a4:	40e7853b          	subw	a0,a5,a4
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
  return 0;
 2ae:	4501                	li	a0,0
 2b0:	bfe5                	j	2a8 <memcmp+0x30>

00000000000002b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ba:	00000097          	auipc	ra,0x0
 2be:	f66080e7          	jalr	-154(ra) # 220 <memmove>
}
 2c2:	60a2                	ld	ra,8(sp)
 2c4:	6402                	ld	s0,0(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 2ca:	4885                	li	a7,1
 ecall
 2cc:	00000073          	ecall
 ret
 2d0:	8082                	ret

00000000000002d2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2d2:	4889                	li	a7,2
 ecall
 2d4:	00000073          	ecall
 ret
 2d8:	8082                	ret

00000000000002da <wait>:
.global wait
wait:
 li a7, SYS_wait
 2da:	488d                	li	a7,3
 ecall
 2dc:	00000073          	ecall
 ret
 2e0:	8082                	ret

00000000000002e2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2e2:	4891                	li	a7,4
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <read>:
.global read
read:
 li a7, SYS_read
 2ea:	4895                	li	a7,5
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <write>:
.global write
write:
 li a7, SYS_write
 2f2:	48c1                	li	a7,16
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <close>:
.global close
close:
 li a7, SYS_close
 2fa:	48d5                	li	a7,21
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <kill>:
.global kill
kill:
 li a7, SYS_kill
 302:	4899                	li	a7,6
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <exec>:
.global exec
exec:
 li a7, SYS_exec
 30a:	489d                	li	a7,7
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <open>:
.global open
open:
 li a7, SYS_open
 312:	48bd                	li	a7,15
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 31a:	48a1                	li	a7,8
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 322:	48d1                	li	a7,20
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 32a:	48a5                	li	a7,9
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <dup>:
.global dup
dup:
 li a7, SYS_dup
 332:	48a9                	li	a7,10
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 33a:	48ad                	li	a7,11
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 342:	48b1                	li	a7,12
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 34a:	48b5                	li	a7,13
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 352:	48b9                	li	a7,14
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 35a:	48d9                	li	a7,22
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <dev>:
.global dev
dev:
 li a7, SYS_dev
 362:	48dd                	li	a7,23
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 36a:	48e1                	li	a7,24
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 372:	48e5                	li	a7,25
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <remove>:
.global remove
remove:
 li a7, SYS_remove
 37a:	48c5                	li	a7,17
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <trace>:
.global trace
trace:
 li a7, SYS_trace
 382:	48c9                	li	a7,18
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 38a:	48cd                	li	a7,19
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <rename>:
.global rename
rename:
 li a7, SYS_rename
 392:	48e9                	li	a7,26
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 39a:	48ed                	li	a7,27
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 3a2:	48f1                	li	a7,28
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 3aa:	48f5                	li	a7,29
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 3b2:	48f9                	li	a7,30
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 3ba:	48fd                	li	a7,31
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 3c2:	02000893          	li	a7,32
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 3cc:	02100893          	li	a7,33
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 3d6:	02200893          	li	a7,34
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 3e0:	02300893          	li	a7,35
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 3ea:	02400893          	li	a7,36
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 3f4:	02500893          	li	a7,37
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 3fe:	02600893          	li	a7,38
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 408:	02700893          	li	a7,39
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 412:	02800893          	li	a7,40
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 41c:	02900893          	li	a7,41
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 426:	02a00893          	li	a7,42
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 430:	02b00893          	li	a7,43
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 43a:	02c00893          	li	a7,44
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 444:	02d00893          	li	a7,45
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 44e:	02e00893          	li	a7,46
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 458:	02f00893          	li	a7,47
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 462:	03000893          	li	a7,48
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 46c:	03100893          	li	a7,49
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 476:	03200893          	li	a7,50
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 480:	03300893          	li	a7,51
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 48a:	03400893          	li	a7,52
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 494:	03500893          	li	a7,53
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 49e:	03600893          	li	a7,54
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 4a8:	03700893          	li	a7,55
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 4b2:	03800893          	li	a7,56
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 4bc:	03900893          	li	a7,57
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 4c6:	03a00893          	li	a7,58
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <poll>:
.global poll
poll:
 li a7, SYS_poll
 4d0:	03b00893          	li	a7,59
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 4da:	03c00893          	li	a7,60
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 4e4:	03d00893          	li	a7,61
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 4ee:	03e00893          	li	a7,62
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4f8:	03f00893          	li	a7,63
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <futex>:
.global futex
futex:
 li a7, SYS_futex
 502:	04000893          	li	a7,64
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 50c:	04100893          	li	a7,65
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <halt>:
.global halt
halt:
 li a7, SYS_halt
 516:	04200893          	li	a7,66
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 520:	04300893          	li	a7,67
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <socket>:
.global socket
socket:
 li a7, SYS_socket
 52a:	04400893          	li	a7,68
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <bind>:
.global bind
bind:
 li a7, SYS_bind
 534:	04500893          	li	a7,69
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <listen>:
.global listen
listen:
 li a7, SYS_listen
 53e:	04600893          	li	a7,70
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <accept>:
.global accept
accept:
 li a7, SYS_accept
 548:	04700893          	li	a7,71
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <connect>:
.global connect
connect:
 li a7, SYS_connect
 552:	04800893          	li	a7,72
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <send>:
.global send
send:
 li a7, SYS_send
 55c:	04900893          	li	a7,73
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <recv>:
.global recv
recv:
 li a7, SYS_recv
 566:	04a00893          	li	a7,74
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 570:	04b00893          	li	a7,75
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 57a:	1101                	addi	sp,sp,-32
 57c:	ec06                	sd	ra,24(sp)
 57e:	e822                	sd	s0,16(sp)
 580:	1000                	addi	s0,sp,32
 582:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 586:	4605                	li	a2,1
 588:	fef40593          	addi	a1,s0,-17
 58c:	00000097          	auipc	ra,0x0
 590:	d66080e7          	jalr	-666(ra) # 2f2 <write>
}
 594:	60e2                	ld	ra,24(sp)
 596:	6442                	ld	s0,16(sp)
 598:	6105                	addi	sp,sp,32
 59a:	8082                	ret

000000000000059c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 59c:	7139                	addi	sp,sp,-64
 59e:	fc06                	sd	ra,56(sp)
 5a0:	f822                	sd	s0,48(sp)
 5a2:	f426                	sd	s1,40(sp)
 5a4:	f04a                	sd	s2,32(sp)
 5a6:	ec4e                	sd	s3,24(sp)
 5a8:	0080                	addi	s0,sp,64
 5aa:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ac:	c299                	beqz	a3,5b2 <printint+0x16>
 5ae:	0805c863          	bltz	a1,63e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b2:	2581                	sext.w	a1,a1
  neg = 0;
 5b4:	4881                	li	a7,0
  }

  i = 0;
 5b6:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5ba:	86ce                	mv	a3,s3
  i = 0;
 5bc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5be:	2601                	sext.w	a2,a2
 5c0:	00000517          	auipc	a0,0x0
 5c4:	49850513          	addi	a0,a0,1176 # a58 <digits>
 5c8:	883a                	mv	a6,a4
 5ca:	2705                	addiw	a4,a4,1
 5cc:	02c5f7bb          	remuw	a5,a1,a2
 5d0:	1782                	slli	a5,a5,0x20
 5d2:	9381                	srli	a5,a5,0x20
 5d4:	97aa                	add	a5,a5,a0
 5d6:	0007c783          	lbu	a5,0(a5)
 5da:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5de:	0005879b          	sext.w	a5,a1
 5e2:	02c5d5bb          	divuw	a1,a1,a2
 5e6:	0685                	addi	a3,a3,1
 5e8:	fec7f0e3          	bgeu	a5,a2,5c8 <printint+0x2c>
  if(neg)
 5ec:	00088c63          	beqz	a7,604 <printint+0x68>
    buf[i++] = '-';
 5f0:	fd070793          	addi	a5,a4,-48
 5f4:	00878733          	add	a4,a5,s0
 5f8:	02d00793          	li	a5,45
 5fc:	fef70823          	sb	a5,-16(a4)
 600:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 604:	02e05663          	blez	a4,630 <printint+0x94>
 608:	fc040913          	addi	s2,s0,-64
 60c:	993a                	add	s2,s2,a4
 60e:	19fd                	addi	s3,s3,-1
 610:	99ba                	add	s3,s3,a4
 612:	377d                	addiw	a4,a4,-1
 614:	1702                	slli	a4,a4,0x20
 616:	9301                	srli	a4,a4,0x20
 618:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 61c:	fff94583          	lbu	a1,-1(s2)
 620:	8526                	mv	a0,s1
 622:	00000097          	auipc	ra,0x0
 626:	f58080e7          	jalr	-168(ra) # 57a <putc>
  while(--i >= 0)
 62a:	197d                	addi	s2,s2,-1
 62c:	ff3918e3          	bne	s2,s3,61c <printint+0x80>
}
 630:	70e2                	ld	ra,56(sp)
 632:	7442                	ld	s0,48(sp)
 634:	74a2                	ld	s1,40(sp)
 636:	7902                	ld	s2,32(sp)
 638:	69e2                	ld	s3,24(sp)
 63a:	6121                	addi	sp,sp,64
 63c:	8082                	ret
    x = -xx;
 63e:	40b005bb          	negw	a1,a1
    neg = 1;
 642:	4885                	li	a7,1
    x = -xx;
 644:	bf8d                	j	5b6 <printint+0x1a>

0000000000000646 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 646:	7119                	addi	sp,sp,-128
 648:	fc86                	sd	ra,120(sp)
 64a:	f8a2                	sd	s0,112(sp)
 64c:	f4a6                	sd	s1,104(sp)
 64e:	f0ca                	sd	s2,96(sp)
 650:	ecce                	sd	s3,88(sp)
 652:	e8d2                	sd	s4,80(sp)
 654:	e4d6                	sd	s5,72(sp)
 656:	e0da                	sd	s6,64(sp)
 658:	fc5e                	sd	s7,56(sp)
 65a:	f862                	sd	s8,48(sp)
 65c:	f466                	sd	s9,40(sp)
 65e:	f06a                	sd	s10,32(sp)
 660:	ec6e                	sd	s11,24(sp)
 662:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 664:	0005c903          	lbu	s2,0(a1)
 668:	18090f63          	beqz	s2,806 <vprintf+0x1c0>
 66c:	8aaa                	mv	s5,a0
 66e:	8b32                	mv	s6,a2
 670:	00158493          	addi	s1,a1,1
  state = 0;
 674:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 676:	02500a13          	li	s4,37
 67a:	4c55                	li	s8,21
 67c:	00000c97          	auipc	s9,0x0
 680:	384c8c93          	addi	s9,s9,900 # a00 <malloc+0xf6>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 684:	02800d93          	li	s11,40
  putc(fd, 'x');
 688:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 68a:	00000b97          	auipc	s7,0x0
 68e:	3ceb8b93          	addi	s7,s7,974 # a58 <digits>
 692:	a839                	j	6b0 <vprintf+0x6a>
        putc(fd, c);
 694:	85ca                	mv	a1,s2
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	ee2080e7          	jalr	-286(ra) # 57a <putc>
 6a0:	a019                	j	6a6 <vprintf+0x60>
    } else if(state == '%'){
 6a2:	01498d63          	beq	s3,s4,6bc <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 6a6:	0485                	addi	s1,s1,1
 6a8:	fff4c903          	lbu	s2,-1(s1)
 6ac:	14090d63          	beqz	s2,806 <vprintf+0x1c0>
    if(state == 0){
 6b0:	fe0999e3          	bnez	s3,6a2 <vprintf+0x5c>
      if(c == '%'){
 6b4:	ff4910e3          	bne	s2,s4,694 <vprintf+0x4e>
        state = '%';
 6b8:	89d2                	mv	s3,s4
 6ba:	b7f5                	j	6a6 <vprintf+0x60>
      if(c == 'd'){
 6bc:	11490c63          	beq	s2,s4,7d4 <vprintf+0x18e>
 6c0:	f9d9079b          	addiw	a5,s2,-99
 6c4:	0ff7f793          	zext.b	a5,a5
 6c8:	10fc6e63          	bltu	s8,a5,7e4 <vprintf+0x19e>
 6cc:	f9d9079b          	addiw	a5,s2,-99
 6d0:	0ff7f713          	zext.b	a4,a5
 6d4:	10ec6863          	bltu	s8,a4,7e4 <vprintf+0x19e>
 6d8:	00271793          	slli	a5,a4,0x2
 6dc:	97e6                	add	a5,a5,s9
 6de:	439c                	lw	a5,0(a5)
 6e0:	97e6                	add	a5,a5,s9
 6e2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6e4:	008b0913          	addi	s2,s6,8
 6e8:	4685                	li	a3,1
 6ea:	4629                	li	a2,10
 6ec:	000b2583          	lw	a1,0(s6)
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	eaa080e7          	jalr	-342(ra) # 59c <printint>
 6fa:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	b765                	j	6a6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 700:	008b0913          	addi	s2,s6,8
 704:	4681                	li	a3,0
 706:	4629                	li	a2,10
 708:	000b2583          	lw	a1,0(s6)
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	e8e080e7          	jalr	-370(ra) # 59c <printint>
 716:	8b4a                	mv	s6,s2
      state = 0;
 718:	4981                	li	s3,0
 71a:	b771                	j	6a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 71c:	008b0913          	addi	s2,s6,8
 720:	4681                	li	a3,0
 722:	866a                	mv	a2,s10
 724:	000b2583          	lw	a1,0(s6)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e72080e7          	jalr	-398(ra) # 59c <printint>
 732:	8b4a                	mv	s6,s2
      state = 0;
 734:	4981                	li	s3,0
 736:	bf85                	j	6a6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 738:	008b0793          	addi	a5,s6,8
 73c:	f8f43423          	sd	a5,-120(s0)
 740:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 744:	03000593          	li	a1,48
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e30080e7          	jalr	-464(ra) # 57a <putc>
  putc(fd, 'x');
 752:	07800593          	li	a1,120
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	e22080e7          	jalr	-478(ra) # 57a <putc>
 760:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 762:	03c9d793          	srli	a5,s3,0x3c
 766:	97de                	add	a5,a5,s7
 768:	0007c583          	lbu	a1,0(a5)
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	e0c080e7          	jalr	-500(ra) # 57a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 776:	0992                	slli	s3,s3,0x4
 778:	397d                	addiw	s2,s2,-1
 77a:	fe0914e3          	bnez	s2,762 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 77e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 782:	4981                	li	s3,0
 784:	b70d                	j	6a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 786:	008b0913          	addi	s2,s6,8
 78a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 78e:	02098163          	beqz	s3,7b0 <vprintf+0x16a>
        while(*s != 0){
 792:	0009c583          	lbu	a1,0(s3)
 796:	c5ad                	beqz	a1,800 <vprintf+0x1ba>
          putc(fd, *s);
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	de0080e7          	jalr	-544(ra) # 57a <putc>
          s++;
 7a2:	0985                	addi	s3,s3,1
        while(*s != 0){
 7a4:	0009c583          	lbu	a1,0(s3)
 7a8:	f9e5                	bnez	a1,798 <vprintf+0x152>
        s = va_arg(ap, char*);
 7aa:	8b4a                	mv	s6,s2
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	bde5                	j	6a6 <vprintf+0x60>
          s = "(null)";
 7b0:	00000997          	auipc	s3,0x0
 7b4:	24898993          	addi	s3,s3,584 # 9f8 <malloc+0xee>
        while(*s != 0){
 7b8:	85ee                	mv	a1,s11
 7ba:	bff9                	j	798 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 7bc:	008b0913          	addi	s2,s6,8
 7c0:	000b4583          	lbu	a1,0(s6)
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	db4080e7          	jalr	-588(ra) # 57a <putc>
 7ce:	8b4a                	mv	s6,s2
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	bdd1                	j	6a6 <vprintf+0x60>
        putc(fd, c);
 7d4:	85d2                	mv	a1,s4
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	da2080e7          	jalr	-606(ra) # 57a <putc>
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	b5d1                	j	6a6 <vprintf+0x60>
        putc(fd, '%');
 7e4:	85d2                	mv	a1,s4
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	d92080e7          	jalr	-622(ra) # 57a <putc>
        putc(fd, c);
 7f0:	85ca                	mv	a1,s2
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	d86080e7          	jalr	-634(ra) # 57a <putc>
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	b565                	j	6a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 800:	8b4a                	mv	s6,s2
      state = 0;
 802:	4981                	li	s3,0
 804:	b54d                	j	6a6 <vprintf+0x60>
    }
  }
}
 806:	70e6                	ld	ra,120(sp)
 808:	7446                	ld	s0,112(sp)
 80a:	74a6                	ld	s1,104(sp)
 80c:	7906                	ld	s2,96(sp)
 80e:	69e6                	ld	s3,88(sp)
 810:	6a46                	ld	s4,80(sp)
 812:	6aa6                	ld	s5,72(sp)
 814:	6b06                	ld	s6,64(sp)
 816:	7be2                	ld	s7,56(sp)
 818:	7c42                	ld	s8,48(sp)
 81a:	7ca2                	ld	s9,40(sp)
 81c:	7d02                	ld	s10,32(sp)
 81e:	6de2                	ld	s11,24(sp)
 820:	6109                	addi	sp,sp,128
 822:	8082                	ret

0000000000000824 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 824:	715d                	addi	sp,sp,-80
 826:	ec06                	sd	ra,24(sp)
 828:	e822                	sd	s0,16(sp)
 82a:	1000                	addi	s0,sp,32
 82c:	e010                	sd	a2,0(s0)
 82e:	e414                	sd	a3,8(s0)
 830:	e818                	sd	a4,16(s0)
 832:	ec1c                	sd	a5,24(s0)
 834:	03043023          	sd	a6,32(s0)
 838:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 83c:	8622                	mv	a2,s0
 83e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 842:	00000097          	auipc	ra,0x0
 846:	e04080e7          	jalr	-508(ra) # 646 <vprintf>
}
 84a:	60e2                	ld	ra,24(sp)
 84c:	6442                	ld	s0,16(sp)
 84e:	6161                	addi	sp,sp,80
 850:	8082                	ret

0000000000000852 <printf>:

void
printf(const char *fmt, ...)
{
 852:	711d                	addi	sp,sp,-96
 854:	ec06                	sd	ra,24(sp)
 856:	e822                	sd	s0,16(sp)
 858:	1000                	addi	s0,sp,32
 85a:	e40c                	sd	a1,8(s0)
 85c:	e810                	sd	a2,16(s0)
 85e:	ec14                	sd	a3,24(s0)
 860:	f018                	sd	a4,32(s0)
 862:	f41c                	sd	a5,40(s0)
 864:	03043823          	sd	a6,48(s0)
 868:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86c:	00840613          	addi	a2,s0,8
 870:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 874:	85aa                	mv	a1,a0
 876:	4505                	li	a0,1
 878:	00000097          	auipc	ra,0x0
 87c:	dce080e7          	jalr	-562(ra) # 646 <vprintf>
}
 880:	60e2                	ld	ra,24(sp)
 882:	6442                	ld	s0,16(sp)
 884:	6125                	addi	sp,sp,96
 886:	8082                	ret

0000000000000888 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 888:	1141                	addi	sp,sp,-16
 88a:	e422                	sd	s0,8(sp)
 88c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 892:	00000797          	auipc	a5,0x0
 896:	1de7b783          	ld	a5,478(a5) # a70 <freep>
 89a:	a02d                	j	8c4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 89c:	4618                	lw	a4,8(a2)
 89e:	9f2d                	addw	a4,a4,a1
 8a0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a4:	6398                	ld	a4,0(a5)
 8a6:	6310                	ld	a2,0(a4)
 8a8:	a83d                	j	8e6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8aa:	ff852703          	lw	a4,-8(a0)
 8ae:	9f31                	addw	a4,a4,a2
 8b0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8b2:	ff053683          	ld	a3,-16(a0)
 8b6:	a091                	j	8fa <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b8:	6398                	ld	a4,0(a5)
 8ba:	00e7e463          	bltu	a5,a4,8c2 <free+0x3a>
 8be:	00e6ea63          	bltu	a3,a4,8d2 <free+0x4a>
{
 8c2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c4:	fed7fae3          	bgeu	a5,a3,8b8 <free+0x30>
 8c8:	6398                	ld	a4,0(a5)
 8ca:	00e6e463          	bltu	a3,a4,8d2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ce:	fee7eae3          	bltu	a5,a4,8c2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8d2:	ff852583          	lw	a1,-8(a0)
 8d6:	6390                	ld	a2,0(a5)
 8d8:	02059813          	slli	a6,a1,0x20
 8dc:	01c85713          	srli	a4,a6,0x1c
 8e0:	9736                	add	a4,a4,a3
 8e2:	fae60de3          	beq	a2,a4,89c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ea:	4790                	lw	a2,8(a5)
 8ec:	02061593          	slli	a1,a2,0x20
 8f0:	01c5d713          	srli	a4,a1,0x1c
 8f4:	973e                	add	a4,a4,a5
 8f6:	fae68ae3          	beq	a3,a4,8aa <free+0x22>
    p->s.ptr = bp->s.ptr;
 8fa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8fc:	00000717          	auipc	a4,0x0
 900:	16f73a23          	sd	a5,372(a4) # a70 <freep>
}
 904:	6422                	ld	s0,8(sp)
 906:	0141                	addi	sp,sp,16
 908:	8082                	ret

000000000000090a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 90a:	7139                	addi	sp,sp,-64
 90c:	fc06                	sd	ra,56(sp)
 90e:	f822                	sd	s0,48(sp)
 910:	f426                	sd	s1,40(sp)
 912:	f04a                	sd	s2,32(sp)
 914:	ec4e                	sd	s3,24(sp)
 916:	e852                	sd	s4,16(sp)
 918:	e456                	sd	s5,8(sp)
 91a:	e05a                	sd	s6,0(sp)
 91c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 91e:	02051493          	slli	s1,a0,0x20
 922:	9081                	srli	s1,s1,0x20
 924:	04bd                	addi	s1,s1,15
 926:	8091                	srli	s1,s1,0x4
 928:	00148a1b          	addiw	s4,s1,1
 92c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 92e:	00000517          	auipc	a0,0x0
 932:	14253503          	ld	a0,322(a0) # a70 <freep>
 936:	c515                	beqz	a0,962 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 938:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93a:	4798                	lw	a4,8(a5)
 93c:	04977163          	bgeu	a4,s1,97e <malloc+0x74>
 940:	89d2                	mv	s3,s4
 942:	000a071b          	sext.w	a4,s4
 946:	6685                	lui	a3,0x1
 948:	00d77363          	bgeu	a4,a3,94e <malloc+0x44>
 94c:	6985                	lui	s3,0x1
 94e:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 952:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 956:	00000917          	auipc	s2,0x0
 95a:	11a90913          	addi	s2,s2,282 # a70 <freep>
  if(p == (char*)-1)
 95e:	5afd                	li	s5,-1
 960:	a8a5                	j	9d8 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 962:	00000797          	auipc	a5,0x0
 966:	10e78793          	addi	a5,a5,270 # a70 <freep>
 96a:	00000717          	auipc	a4,0x0
 96e:	10e70713          	addi	a4,a4,270 # a78 <base>
 972:	e398                	sd	a4,0(a5)
 974:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 976:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97a:	87ba                	mv	a5,a4
 97c:	b7d1                	j	940 <malloc+0x36>
      if(p->s.size == nunits)
 97e:	02e48c63          	beq	s1,a4,9b6 <malloc+0xac>
        p->s.size -= nunits;
 982:	4147073b          	subw	a4,a4,s4
 986:	c798                	sw	a4,8(a5)
        p += p->s.size;
 988:	02071693          	slli	a3,a4,0x20
 98c:	01c6d713          	srli	a4,a3,0x1c
 990:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 992:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 996:	00000717          	auipc	a4,0x0
 99a:	0ca73d23          	sd	a0,218(a4) # a70 <freep>
      return (void*)(p + 1);
 99e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9a2:	70e2                	ld	ra,56(sp)
 9a4:	7442                	ld	s0,48(sp)
 9a6:	74a2                	ld	s1,40(sp)
 9a8:	7902                	ld	s2,32(sp)
 9aa:	69e2                	ld	s3,24(sp)
 9ac:	6a42                	ld	s4,16(sp)
 9ae:	6aa2                	ld	s5,8(sp)
 9b0:	6b02                	ld	s6,0(sp)
 9b2:	6121                	addi	sp,sp,64
 9b4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9b6:	6398                	ld	a4,0(a5)
 9b8:	e118                	sd	a4,0(a0)
 9ba:	bff1                	j	996 <malloc+0x8c>
  hp->s.size = nu;
 9bc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c0:	0541                	addi	a0,a0,16
 9c2:	00000097          	auipc	ra,0x0
 9c6:	ec6080e7          	jalr	-314(ra) # 888 <free>
  return freep;
 9ca:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9ce:	d971                	beqz	a0,9a2 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d2:	4798                	lw	a4,8(a5)
 9d4:	fa9775e3          	bgeu	a4,s1,97e <malloc+0x74>
    if(p == freep)
 9d8:	00093703          	ld	a4,0(s2)
 9dc:	853e                	mv	a0,a5
 9de:	fef719e3          	bne	a4,a5,9d0 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 9e2:	854e                	mv	a0,s3
 9e4:	00000097          	auipc	ra,0x0
 9e8:	95e080e7          	jalr	-1698(ra) # 342 <sbrk>
  if(p == (char*)-1)
 9ec:	fd5518e3          	bne	a0,s5,9bc <malloc+0xb2>
        return 0;
 9f0:	4501                	li	a0,0
 9f2:	bf45                	j	9a2 <malloc+0x98>
