
serein-user/_sleep：     文件格式 elf64-littleriscv


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
    if (argc <= 1) {
   8:	4785                	li	a5,1
   a:	02a7d663          	bge	a5,a0,36 <main+0x36>
        fprintf(2, "Usage: sleep TIME\n");
        exit(1);
    }
    int time = atoi(argv[1]);
   e:	6588                	ld	a0,8(a1)
  10:	00000097          	auipc	ra,0x0
  14:	1fa080e7          	jalr	506(ra) # 20a <atoi>
    if (time == 0) {
  18:	ed0d                	bnez	a0,52 <main+0x52>
        fprintf(2, "Usage: sleep TIME\nTIME should be an integer larger than 0.\n");
  1a:	00001597          	auipc	a1,0x1
  1e:	a3e58593          	addi	a1,a1,-1474 # a58 <malloc+0x104>
  22:	4509                	li	a0,2
  24:	00001097          	auipc	ra,0x1
  28:	84a080e7          	jalr	-1974(ra) # 86e <fprintf>
        exit(1);
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	2ee080e7          	jalr	750(ra) # 31c <exit>
        fprintf(2, "Usage: sleep TIME\n");
  36:	00001597          	auipc	a1,0x1
  3a:	a0a58593          	addi	a1,a1,-1526 # a40 <malloc+0xec>
  3e:	4509                	li	a0,2
  40:	00001097          	auipc	ra,0x1
  44:	82e080e7          	jalr	-2002(ra) # 86e <fprintf>
        exit(1);
  48:	4505                	li	a0,1
  4a:	00000097          	auipc	ra,0x0
  4e:	2d2080e7          	jalr	722(ra) # 31c <exit>
    }
    sleep(time);
  52:	00000097          	auipc	ra,0x0
  56:	342080e7          	jalr	834(ra) # 394 <sleep>
    exit(0);
  5a:	4501                	li	a0,0
  5c:	00000097          	auipc	ra,0x0
  60:	2c0080e7          	jalr	704(ra) # 31c <exit>

0000000000000064 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0x8>
    ;
  return os;
}
  7a:	6422                	ld	s0,8(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcat>:

char*
strcat(char *s, const char *t)
{
  80:	1141                	addi	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  86:	00054783          	lbu	a5,0(a0)
  8a:	c385                	beqz	a5,aa <strcat+0x2a>
  8c:	87aa                	mv	a5,a0
    s++;
  8e:	0785                	addi	a5,a5,1
  while(*s)
  90:	0007c703          	lbu	a4,0(a5)
  94:	ff6d                	bnez	a4,8e <strcat+0xe>
  while((*s++ = *t++))
  96:	0585                	addi	a1,a1,1
  98:	0785                	addi	a5,a5,1
  9a:	fff5c703          	lbu	a4,-1(a1)
  9e:	fee78fa3          	sb	a4,-1(a5)
  a2:	fb75                	bnez	a4,96 <strcat+0x16>
    ;
  return os;
}
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	addi	sp,sp,16
  a8:	8082                	ret
  while(*s)
  aa:	87aa                	mv	a5,a0
  ac:	b7ed                	j	96 <strcat+0x16>

00000000000000ae <strcmp>:


int
strcmp(const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	cb91                	beqz	a5,cc <strcmp+0x1e>
  ba:	0005c703          	lbu	a4,0(a1)
  be:	00f71763          	bne	a4,a5,cc <strcmp+0x1e>
    p++, q++;
  c2:	0505                	addi	a0,a0,1
  c4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	fbe5                	bnez	a5,ba <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  cc:	0005c503          	lbu	a0,0(a1)
}
  d0:	40a7853b          	subw	a0,a5,a0
  d4:	6422                	ld	s0,8(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret

00000000000000da <strlen>:

uint
strlen(const char *s)
{
  da:	1141                	addi	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e0:	00054783          	lbu	a5,0(a0)
  e4:	cf91                	beqz	a5,100 <strlen+0x26>
  e6:	0505                	addi	a0,a0,1
  e8:	87aa                	mv	a5,a0
  ea:	4685                	li	a3,1
  ec:	9e89                	subw	a3,a3,a0
  ee:	00f6853b          	addw	a0,a3,a5
  f2:	0785                	addi	a5,a5,1
  f4:	fff7c703          	lbu	a4,-1(a5)
  f8:	fb7d                	bnez	a4,ee <strlen+0x14>
    ;
  return n;
}
  fa:	6422                	ld	s0,8(sp)
  fc:	0141                	addi	sp,sp,16
  fe:	8082                	ret
  for(n = 0; s[n]; n++)
 100:	4501                	li	a0,0
 102:	bfe5                	j	fa <strlen+0x20>

0000000000000104 <memset>:

void*
memset(void *dst, int c, uint n)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 10a:	ca19                	beqz	a2,120 <memset+0x1c>
 10c:	87aa                	mv	a5,a0
 10e:	1602                	slli	a2,a2,0x20
 110:	9201                	srli	a2,a2,0x20
 112:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 116:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 11a:	0785                	addi	a5,a5,1
 11c:	fee79de3          	bne	a5,a4,116 <memset+0x12>
  }
  return dst;
}
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret

0000000000000126 <strchr>:

char*
strchr(const char *s, char c)
{
 126:	1141                	addi	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 12c:	00054783          	lbu	a5,0(a0)
 130:	cb99                	beqz	a5,146 <strchr+0x20>
    if(*s == c)
 132:	00f58763          	beq	a1,a5,140 <strchr+0x1a>
  for(; *s; s++)
 136:	0505                	addi	a0,a0,1
 138:	00054783          	lbu	a5,0(a0)
 13c:	fbfd                	bnez	a5,132 <strchr+0xc>
      return (char*)s;
  return 0;
 13e:	4501                	li	a0,0
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret
  return 0;
 146:	4501                	li	a0,0
 148:	bfe5                	j	140 <strchr+0x1a>

000000000000014a <gets>:

char*
gets(char *buf, int max)
{
 14a:	711d                	addi	sp,sp,-96
 14c:	ec86                	sd	ra,88(sp)
 14e:	e8a2                	sd	s0,80(sp)
 150:	e4a6                	sd	s1,72(sp)
 152:	e0ca                	sd	s2,64(sp)
 154:	fc4e                	sd	s3,56(sp)
 156:	f852                	sd	s4,48(sp)
 158:	f456                	sd	s5,40(sp)
 15a:	f05a                	sd	s6,32(sp)
 15c:	ec5e                	sd	s7,24(sp)
 15e:	e862                	sd	s8,16(sp)
 160:	1080                	addi	s0,sp,96
 162:	8baa                	mv	s7,a0
 164:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 166:	892a                	mv	s2,a0
 168:	4481                	li	s1,0
    cc = read(0, &c, 1);
 16a:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16e:	4b29                	li	s6,10
 170:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 172:	89a6                	mv	s3,s1
 174:	2485                	addiw	s1,s1,1
 176:	0344d763          	bge	s1,s4,1a4 <gets+0x5a>
    cc = read(0, &c, 1);
 17a:	4605                	li	a2,1
 17c:	85d6                	mv	a1,s5
 17e:	4501                	li	a0,0
 180:	00000097          	auipc	ra,0x0
 184:	1b4080e7          	jalr	436(ra) # 334 <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x5a>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01678763          	beq	a5,s6,1a2 <gets+0x58>
 198:	0905                	addi	s2,s2,1
 19a:	fd879ce3          	bne	a5,s8,172 <gets+0x28>
  for(i=0; i+1 < max; ){
 19e:	89a6                	mv	s3,s1
 1a0:	a011                	j	1a4 <gets+0x5a>
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6c42                	ld	s8,16(sp)
 1c0:	6125                	addi	sp,sp,96
 1c2:	8082                	ret

00000000000001c4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c4:	1101                	addi	sp,sp,-32
 1c6:	ec06                	sd	ra,24(sp)
 1c8:	e822                	sd	s0,16(sp)
 1ca:	e426                	sd	s1,8(sp)
 1cc:	e04a                	sd	s2,0(sp)
 1ce:	1000                	addi	s0,sp,32
 1d0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d2:	4581                	li	a1,0
 1d4:	00000097          	auipc	ra,0x0
 1d8:	188080e7          	jalr	392(ra) # 35c <open>
  if(fd < 0)
 1dc:	02054563          	bltz	a0,206 <stat+0x42>
 1e0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e2:	85ca                	mv	a1,s2
 1e4:	00000097          	auipc	ra,0x0
 1e8:	180080e7          	jalr	384(ra) # 364 <fstat>
 1ec:	892a                	mv	s2,a0
  close(fd);
 1ee:	8526                	mv	a0,s1
 1f0:	00000097          	auipc	ra,0x0
 1f4:	154080e7          	jalr	340(ra) # 344 <close>
  return r;
}
 1f8:	854a                	mv	a0,s2
 1fa:	60e2                	ld	ra,24(sp)
 1fc:	6442                	ld	s0,16(sp)
 1fe:	64a2                	ld	s1,8(sp)
 200:	6902                	ld	s2,0(sp)
 202:	6105                	addi	sp,sp,32
 204:	8082                	ret
    return -1;
 206:	597d                	li	s2,-1
 208:	bfc5                	j	1f8 <stat+0x34>

000000000000020a <atoi>:

int
atoi(const char *s)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 210:	00054703          	lbu	a4,0(a0)
 214:	02d00793          	li	a5,45
  int neg = 1;
 218:	4585                	li	a1,1
  if (*s == '-') {
 21a:	04f70363          	beq	a4,a5,260 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 21e:	00054703          	lbu	a4,0(a0)
 222:	fd07079b          	addiw	a5,a4,-48
 226:	0ff7f793          	zext.b	a5,a5
 22a:	46a5                	li	a3,9
 22c:	02f6ed63          	bltu	a3,a5,266 <atoi+0x5c>
  n = 0;
 230:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 232:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 234:	0505                	addi	a0,a0,1
 236:	0026979b          	slliw	a5,a3,0x2
 23a:	9fb5                	addw	a5,a5,a3
 23c:	0017979b          	slliw	a5,a5,0x1
 240:	9fb9                	addw	a5,a5,a4
 242:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 246:	00054703          	lbu	a4,0(a0)
 24a:	fd07079b          	addiw	a5,a4,-48
 24e:	0ff7f793          	zext.b	a5,a5
 252:	fef671e3          	bgeu	a2,a5,234 <atoi+0x2a>
  return n * neg;
}
 256:	02d5853b          	mulw	a0,a1,a3
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
    s++;
 260:	0505                	addi	a0,a0,1
    neg = -1;
 262:	55fd                	li	a1,-1
 264:	bf6d                	j	21e <atoi+0x14>
  n = 0;
 266:	4681                	li	a3,0
 268:	b7fd                	j	256 <atoi+0x4c>

000000000000026a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 270:	02b57463          	bgeu	a0,a1,298 <memmove+0x2e>
    while(n-- > 0)
 274:	00c05f63          	blez	a2,292 <memmove+0x28>
 278:	1602                	slli	a2,a2,0x20
 27a:	9201                	srli	a2,a2,0x20
 27c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 280:	872a                	mv	a4,a0
      *dst++ = *src++;
 282:	0585                	addi	a1,a1,1
 284:	0705                	addi	a4,a4,1
 286:	fff5c683          	lbu	a3,-1(a1)
 28a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 28e:	fee79ae3          	bne	a5,a4,282 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 292:	6422                	ld	s0,8(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret
    dst += n;
 298:	00c50733          	add	a4,a0,a2
    src += n;
 29c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 29e:	fec05ae3          	blez	a2,292 <memmove+0x28>
 2a2:	fff6079b          	addiw	a5,a2,-1
 2a6:	1782                	slli	a5,a5,0x20
 2a8:	9381                	srli	a5,a5,0x20
 2aa:	fff7c793          	not	a5,a5
 2ae:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b0:	15fd                	addi	a1,a1,-1
 2b2:	177d                	addi	a4,a4,-1
 2b4:	0005c683          	lbu	a3,0(a1)
 2b8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2bc:	fee79ae3          	bne	a5,a4,2b0 <memmove+0x46>
 2c0:	bfc9                	j	292 <memmove+0x28>

00000000000002c2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c8:	ca05                	beqz	a2,2f8 <memcmp+0x36>
 2ca:	fff6069b          	addiw	a3,a2,-1
 2ce:	1682                	slli	a3,a3,0x20
 2d0:	9281                	srli	a3,a3,0x20
 2d2:	0685                	addi	a3,a3,1
 2d4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2d6:	00054783          	lbu	a5,0(a0)
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	00e79863          	bne	a5,a4,2ee <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2e2:	0505                	addi	a0,a0,1
    p2++;
 2e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e6:	fed518e3          	bne	a0,a3,2d6 <memcmp+0x14>
  }
  return 0;
 2ea:	4501                	li	a0,0
 2ec:	a019                	j	2f2 <memcmp+0x30>
      return *p1 - *p2;
 2ee:	40e7853b          	subw	a0,a5,a4
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  return 0;
 2f8:	4501                	li	a0,0
 2fa:	bfe5                	j	2f2 <memcmp+0x30>

00000000000002fc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 304:	00000097          	auipc	ra,0x0
 308:	f66080e7          	jalr	-154(ra) # 26a <memmove>
}
 30c:	60a2                	ld	ra,8(sp)
 30e:	6402                	ld	s0,0(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret

0000000000000314 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 314:	4885                	li	a7,1
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <exit>:
.global exit
exit:
 li a7, SYS_exit
 31c:	4889                	li	a7,2
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <wait>:
.global wait
wait:
 li a7, SYS_wait
 324:	488d                	li	a7,3
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 32c:	4891                	li	a7,4
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <read>:
.global read
read:
 li a7, SYS_read
 334:	4895                	li	a7,5
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <write>:
.global write
write:
 li a7, SYS_write
 33c:	48c1                	li	a7,16
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <close>:
.global close
close:
 li a7, SYS_close
 344:	48d5                	li	a7,21
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <kill>:
.global kill
kill:
 li a7, SYS_kill
 34c:	4899                	li	a7,6
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <exec>:
.global exec
exec:
 li a7, SYS_exec
 354:	489d                	li	a7,7
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <open>:
.global open
open:
 li a7, SYS_open
 35c:	48bd                	li	a7,15
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 364:	48a1                	li	a7,8
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 36c:	48d1                	li	a7,20
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 374:	48a5                	li	a7,9
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <dup>:
.global dup
dup:
 li a7, SYS_dup
 37c:	48a9                	li	a7,10
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 384:	48ad                	li	a7,11
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 38c:	48b1                	li	a7,12
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 394:	48b5                	li	a7,13
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 39c:	48b9                	li	a7,14
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3a4:	48d9                	li	a7,22
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <dev>:
.global dev
dev:
 li a7, SYS_dev
 3ac:	48dd                	li	a7,23
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3b4:	48e1                	li	a7,24
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3bc:	48e5                	li	a7,25
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <remove>:
.global remove
remove:
 li a7, SYS_remove
 3c4:	48c5                	li	a7,17
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <trace>:
.global trace
trace:
 li a7, SYS_trace
 3cc:	48c9                	li	a7,18
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3d4:	48cd                	li	a7,19
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <rename>:
.global rename
rename:
 li a7, SYS_rename
 3dc:	48e9                	li	a7,26
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 3e4:	48ed                	li	a7,27
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 3ec:	48f1                	li	a7,28
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 3f4:	48f5                	li	a7,29
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 3fc:	48f9                	li	a7,30
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 404:	48fd                	li	a7,31
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 40c:	02000893          	li	a7,32
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 416:	02100893          	li	a7,33
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 420:	02200893          	li	a7,34
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 42a:	02300893          	li	a7,35
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 434:	02400893          	li	a7,36
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 43e:	02500893          	li	a7,37
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 448:	02600893          	li	a7,38
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 452:	02700893          	li	a7,39
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 45c:	02800893          	li	a7,40
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 466:	02900893          	li	a7,41
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 470:	02a00893          	li	a7,42
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 47a:	02b00893          	li	a7,43
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 484:	02c00893          	li	a7,44
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 48e:	02d00893          	li	a7,45
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 498:	02e00893          	li	a7,46
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4a2:	02f00893          	li	a7,47
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 4ac:	03000893          	li	a7,48
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 4b6:	03100893          	li	a7,49
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 4c0:	03200893          	li	a7,50
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 4ca:	03300893          	li	a7,51
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 4d4:	03400893          	li	a7,52
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 4de:	03500893          	li	a7,53
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 4e8:	03600893          	li	a7,54
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 4f2:	03700893          	li	a7,55
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 4fc:	03800893          	li	a7,56
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 506:	03900893          	li	a7,57
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 510:	03a00893          	li	a7,58
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <poll>:
.global poll
poll:
 li a7, SYS_poll
 51a:	03b00893          	li	a7,59
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 524:	03c00893          	li	a7,60
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 52e:	03d00893          	li	a7,61
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 538:	03e00893          	li	a7,62
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <clone>:
.global clone
clone:
 li a7, SYS_clone
 542:	03f00893          	li	a7,63
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <futex>:
.global futex
futex:
 li a7, SYS_futex
 54c:	04000893          	li	a7,64
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 556:	04100893          	li	a7,65
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <halt>:
.global halt
halt:
 li a7, SYS_halt
 560:	04200893          	li	a7,66
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 56a:	04300893          	li	a7,67
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <socket>:
.global socket
socket:
 li a7, SYS_socket
 574:	04400893          	li	a7,68
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <bind>:
.global bind
bind:
 li a7, SYS_bind
 57e:	04500893          	li	a7,69
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <listen>:
.global listen
listen:
 li a7, SYS_listen
 588:	04600893          	li	a7,70
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <accept>:
.global accept
accept:
 li a7, SYS_accept
 592:	04700893          	li	a7,71
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <connect>:
.global connect
connect:
 li a7, SYS_connect
 59c:	04800893          	li	a7,72
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <send>:
.global send
send:
 li a7, SYS_send
 5a6:	04900893          	li	a7,73
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5b0:	04a00893          	li	a7,74
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 5ba:	04b00893          	li	a7,75
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c4:	1101                	addi	sp,sp,-32
 5c6:	ec06                	sd	ra,24(sp)
 5c8:	e822                	sd	s0,16(sp)
 5ca:	1000                	addi	s0,sp,32
 5cc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d0:	4605                	li	a2,1
 5d2:	fef40593          	addi	a1,s0,-17
 5d6:	00000097          	auipc	ra,0x0
 5da:	d66080e7          	jalr	-666(ra) # 33c <write>
}
 5de:	60e2                	ld	ra,24(sp)
 5e0:	6442                	ld	s0,16(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret

00000000000005e6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e6:	7139                	addi	sp,sp,-64
 5e8:	fc06                	sd	ra,56(sp)
 5ea:	f822                	sd	s0,48(sp)
 5ec:	f426                	sd	s1,40(sp)
 5ee:	f04a                	sd	s2,32(sp)
 5f0:	ec4e                	sd	s3,24(sp)
 5f2:	0080                	addi	s0,sp,64
 5f4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f6:	c299                	beqz	a3,5fc <printint+0x16>
 5f8:	0805c863          	bltz	a1,688 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fc:	2581                	sext.w	a1,a1
  neg = 0;
 5fe:	4881                	li	a7,0
  }

  i = 0;
 600:	fc040993          	addi	s3,s0,-64
  neg = 0;
 604:	86ce                	mv	a3,s3
  i = 0;
 606:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 608:	2601                	sext.w	a2,a2
 60a:	00000517          	auipc	a0,0x0
 60e:	4ee50513          	addi	a0,a0,1262 # af8 <digits>
 612:	883a                	mv	a6,a4
 614:	2705                	addiw	a4,a4,1
 616:	02c5f7bb          	remuw	a5,a1,a2
 61a:	1782                	slli	a5,a5,0x20
 61c:	9381                	srli	a5,a5,0x20
 61e:	97aa                	add	a5,a5,a0
 620:	0007c783          	lbu	a5,0(a5)
 624:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 628:	0005879b          	sext.w	a5,a1
 62c:	02c5d5bb          	divuw	a1,a1,a2
 630:	0685                	addi	a3,a3,1
 632:	fec7f0e3          	bgeu	a5,a2,612 <printint+0x2c>
  if(neg)
 636:	00088c63          	beqz	a7,64e <printint+0x68>
    buf[i++] = '-';
 63a:	fd070793          	addi	a5,a4,-48
 63e:	00878733          	add	a4,a5,s0
 642:	02d00793          	li	a5,45
 646:	fef70823          	sb	a5,-16(a4)
 64a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 64e:	02e05663          	blez	a4,67a <printint+0x94>
 652:	fc040913          	addi	s2,s0,-64
 656:	993a                	add	s2,s2,a4
 658:	19fd                	addi	s3,s3,-1
 65a:	99ba                	add	s3,s3,a4
 65c:	377d                	addiw	a4,a4,-1
 65e:	1702                	slli	a4,a4,0x20
 660:	9301                	srli	a4,a4,0x20
 662:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 666:	fff94583          	lbu	a1,-1(s2)
 66a:	8526                	mv	a0,s1
 66c:	00000097          	auipc	ra,0x0
 670:	f58080e7          	jalr	-168(ra) # 5c4 <putc>
  while(--i >= 0)
 674:	197d                	addi	s2,s2,-1
 676:	ff3918e3          	bne	s2,s3,666 <printint+0x80>
}
 67a:	70e2                	ld	ra,56(sp)
 67c:	7442                	ld	s0,48(sp)
 67e:	74a2                	ld	s1,40(sp)
 680:	7902                	ld	s2,32(sp)
 682:	69e2                	ld	s3,24(sp)
 684:	6121                	addi	sp,sp,64
 686:	8082                	ret
    x = -xx;
 688:	40b005bb          	negw	a1,a1
    neg = 1;
 68c:	4885                	li	a7,1
    x = -xx;
 68e:	bf8d                	j	600 <printint+0x1a>

0000000000000690 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 690:	7119                	addi	sp,sp,-128
 692:	fc86                	sd	ra,120(sp)
 694:	f8a2                	sd	s0,112(sp)
 696:	f4a6                	sd	s1,104(sp)
 698:	f0ca                	sd	s2,96(sp)
 69a:	ecce                	sd	s3,88(sp)
 69c:	e8d2                	sd	s4,80(sp)
 69e:	e4d6                	sd	s5,72(sp)
 6a0:	e0da                	sd	s6,64(sp)
 6a2:	fc5e                	sd	s7,56(sp)
 6a4:	f862                	sd	s8,48(sp)
 6a6:	f466                	sd	s9,40(sp)
 6a8:	f06a                	sd	s10,32(sp)
 6aa:	ec6e                	sd	s11,24(sp)
 6ac:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ae:	0005c903          	lbu	s2,0(a1)
 6b2:	18090f63          	beqz	s2,850 <vprintf+0x1c0>
 6b6:	8aaa                	mv	s5,a0
 6b8:	8b32                	mv	s6,a2
 6ba:	00158493          	addi	s1,a1,1
  state = 0;
 6be:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6c0:	02500a13          	li	s4,37
 6c4:	4c55                	li	s8,21
 6c6:	00000c97          	auipc	s9,0x0
 6ca:	3dac8c93          	addi	s9,s9,986 # aa0 <malloc+0x14c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6ce:	02800d93          	li	s11,40
  putc(fd, 'x');
 6d2:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d4:	00000b97          	auipc	s7,0x0
 6d8:	424b8b93          	addi	s7,s7,1060 # af8 <digits>
 6dc:	a839                	j	6fa <vprintf+0x6a>
        putc(fd, c);
 6de:	85ca                	mv	a1,s2
 6e0:	8556                	mv	a0,s5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	ee2080e7          	jalr	-286(ra) # 5c4 <putc>
 6ea:	a019                	j	6f0 <vprintf+0x60>
    } else if(state == '%'){
 6ec:	01498d63          	beq	s3,s4,706 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 6f0:	0485                	addi	s1,s1,1
 6f2:	fff4c903          	lbu	s2,-1(s1)
 6f6:	14090d63          	beqz	s2,850 <vprintf+0x1c0>
    if(state == 0){
 6fa:	fe0999e3          	bnez	s3,6ec <vprintf+0x5c>
      if(c == '%'){
 6fe:	ff4910e3          	bne	s2,s4,6de <vprintf+0x4e>
        state = '%';
 702:	89d2                	mv	s3,s4
 704:	b7f5                	j	6f0 <vprintf+0x60>
      if(c == 'd'){
 706:	11490c63          	beq	s2,s4,81e <vprintf+0x18e>
 70a:	f9d9079b          	addiw	a5,s2,-99
 70e:	0ff7f793          	zext.b	a5,a5
 712:	10fc6e63          	bltu	s8,a5,82e <vprintf+0x19e>
 716:	f9d9079b          	addiw	a5,s2,-99
 71a:	0ff7f713          	zext.b	a4,a5
 71e:	10ec6863          	bltu	s8,a4,82e <vprintf+0x19e>
 722:	00271793          	slli	a5,a4,0x2
 726:	97e6                	add	a5,a5,s9
 728:	439c                	lw	a5,0(a5)
 72a:	97e6                	add	a5,a5,s9
 72c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 72e:	008b0913          	addi	s2,s6,8
 732:	4685                	li	a3,1
 734:	4629                	li	a2,10
 736:	000b2583          	lw	a1,0(s6)
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	eaa080e7          	jalr	-342(ra) # 5e6 <printint>
 744:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 746:	4981                	li	s3,0
 748:	b765                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 74a:	008b0913          	addi	s2,s6,8
 74e:	4681                	li	a3,0
 750:	4629                	li	a2,10
 752:	000b2583          	lw	a1,0(s6)
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	e8e080e7          	jalr	-370(ra) # 5e6 <printint>
 760:	8b4a                	mv	s6,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	b771                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 766:	008b0913          	addi	s2,s6,8
 76a:	4681                	li	a3,0
 76c:	866a                	mv	a2,s10
 76e:	000b2583          	lw	a1,0(s6)
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	e72080e7          	jalr	-398(ra) # 5e6 <printint>
 77c:	8b4a                	mv	s6,s2
      state = 0;
 77e:	4981                	li	s3,0
 780:	bf85                	j	6f0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 782:	008b0793          	addi	a5,s6,8
 786:	f8f43423          	sd	a5,-120(s0)
 78a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 78e:	03000593          	li	a1,48
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	e30080e7          	jalr	-464(ra) # 5c4 <putc>
  putc(fd, 'x');
 79c:	07800593          	li	a1,120
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e22080e7          	jalr	-478(ra) # 5c4 <putc>
 7aa:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ac:	03c9d793          	srli	a5,s3,0x3c
 7b0:	97de                	add	a5,a5,s7
 7b2:	0007c583          	lbu	a1,0(a5)
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	e0c080e7          	jalr	-500(ra) # 5c4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c0:	0992                	slli	s3,s3,0x4
 7c2:	397d                	addiw	s2,s2,-1
 7c4:	fe0914e3          	bnez	s2,7ac <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7c8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b70d                	j	6f0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7d0:	008b0913          	addi	s2,s6,8
 7d4:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7d8:	02098163          	beqz	s3,7fa <vprintf+0x16a>
        while(*s != 0){
 7dc:	0009c583          	lbu	a1,0(s3)
 7e0:	c5ad                	beqz	a1,84a <vprintf+0x1ba>
          putc(fd, *s);
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	de0080e7          	jalr	-544(ra) # 5c4 <putc>
          s++;
 7ec:	0985                	addi	s3,s3,1
        while(*s != 0){
 7ee:	0009c583          	lbu	a1,0(s3)
 7f2:	f9e5                	bnez	a1,7e2 <vprintf+0x152>
        s = va_arg(ap, char*);
 7f4:	8b4a                	mv	s6,s2
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	bde5                	j	6f0 <vprintf+0x60>
          s = "(null)";
 7fa:	00000997          	auipc	s3,0x0
 7fe:	29e98993          	addi	s3,s3,670 # a98 <malloc+0x144>
        while(*s != 0){
 802:	85ee                	mv	a1,s11
 804:	bff9                	j	7e2 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 806:	008b0913          	addi	s2,s6,8
 80a:	000b4583          	lbu	a1,0(s6)
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	db4080e7          	jalr	-588(ra) # 5c4 <putc>
 818:	8b4a                	mv	s6,s2
      state = 0;
 81a:	4981                	li	s3,0
 81c:	bdd1                	j	6f0 <vprintf+0x60>
        putc(fd, c);
 81e:	85d2                	mv	a1,s4
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	da2080e7          	jalr	-606(ra) # 5c4 <putc>
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b5d1                	j	6f0 <vprintf+0x60>
        putc(fd, '%');
 82e:	85d2                	mv	a1,s4
 830:	8556                	mv	a0,s5
 832:	00000097          	auipc	ra,0x0
 836:	d92080e7          	jalr	-622(ra) # 5c4 <putc>
        putc(fd, c);
 83a:	85ca                	mv	a1,s2
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	d86080e7          	jalr	-634(ra) # 5c4 <putc>
      state = 0;
 846:	4981                	li	s3,0
 848:	b565                	j	6f0 <vprintf+0x60>
        s = va_arg(ap, char*);
 84a:	8b4a                	mv	s6,s2
      state = 0;
 84c:	4981                	li	s3,0
 84e:	b54d                	j	6f0 <vprintf+0x60>
    }
  }
}
 850:	70e6                	ld	ra,120(sp)
 852:	7446                	ld	s0,112(sp)
 854:	74a6                	ld	s1,104(sp)
 856:	7906                	ld	s2,96(sp)
 858:	69e6                	ld	s3,88(sp)
 85a:	6a46                	ld	s4,80(sp)
 85c:	6aa6                	ld	s5,72(sp)
 85e:	6b06                	ld	s6,64(sp)
 860:	7be2                	ld	s7,56(sp)
 862:	7c42                	ld	s8,48(sp)
 864:	7ca2                	ld	s9,40(sp)
 866:	7d02                	ld	s10,32(sp)
 868:	6de2                	ld	s11,24(sp)
 86a:	6109                	addi	sp,sp,128
 86c:	8082                	ret

000000000000086e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86e:	715d                	addi	sp,sp,-80
 870:	ec06                	sd	ra,24(sp)
 872:	e822                	sd	s0,16(sp)
 874:	1000                	addi	s0,sp,32
 876:	e010                	sd	a2,0(s0)
 878:	e414                	sd	a3,8(s0)
 87a:	e818                	sd	a4,16(s0)
 87c:	ec1c                	sd	a5,24(s0)
 87e:	03043023          	sd	a6,32(s0)
 882:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 886:	8622                	mv	a2,s0
 888:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 88c:	00000097          	auipc	ra,0x0
 890:	e04080e7          	jalr	-508(ra) # 690 <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6161                	addi	sp,sp,80
 89a:	8082                	ret

000000000000089c <printf>:

void
printf(const char *fmt, ...)
{
 89c:	711d                	addi	sp,sp,-96
 89e:	ec06                	sd	ra,24(sp)
 8a0:	e822                	sd	s0,16(sp)
 8a2:	1000                	addi	s0,sp,32
 8a4:	e40c                	sd	a1,8(s0)
 8a6:	e810                	sd	a2,16(s0)
 8a8:	ec14                	sd	a3,24(s0)
 8aa:	f018                	sd	a4,32(s0)
 8ac:	f41c                	sd	a5,40(s0)
 8ae:	03043823          	sd	a6,48(s0)
 8b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b6:	00840613          	addi	a2,s0,8
 8ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8be:	85aa                	mv	a1,a0
 8c0:	4505                	li	a0,1
 8c2:	00000097          	auipc	ra,0x0
 8c6:	dce080e7          	jalr	-562(ra) # 690 <vprintf>
}
 8ca:	60e2                	ld	ra,24(sp)
 8cc:	6442                	ld	s0,16(sp)
 8ce:	6125                	addi	sp,sp,96
 8d0:	8082                	ret

00000000000008d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d2:	1141                	addi	sp,sp,-16
 8d4:	e422                	sd	s0,8(sp)
 8d6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8dc:	00000797          	auipc	a5,0x0
 8e0:	2347b783          	ld	a5,564(a5) # b10 <freep>
 8e4:	a02d                	j	90e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e6:	4618                	lw	a4,8(a2)
 8e8:	9f2d                	addw	a4,a4,a1
 8ea:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ee:	6398                	ld	a4,0(a5)
 8f0:	6310                	ld	a2,0(a4)
 8f2:	a83d                	j	930 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f4:	ff852703          	lw	a4,-8(a0)
 8f8:	9f31                	addw	a4,a4,a2
 8fa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8fc:	ff053683          	ld	a3,-16(a0)
 900:	a091                	j	944 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 902:	6398                	ld	a4,0(a5)
 904:	00e7e463          	bltu	a5,a4,90c <free+0x3a>
 908:	00e6ea63          	bltu	a3,a4,91c <free+0x4a>
{
 90c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90e:	fed7fae3          	bgeu	a5,a3,902 <free+0x30>
 912:	6398                	ld	a4,0(a5)
 914:	00e6e463          	bltu	a3,a4,91c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 918:	fee7eae3          	bltu	a5,a4,90c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 91c:	ff852583          	lw	a1,-8(a0)
 920:	6390                	ld	a2,0(a5)
 922:	02059813          	slli	a6,a1,0x20
 926:	01c85713          	srli	a4,a6,0x1c
 92a:	9736                	add	a4,a4,a3
 92c:	fae60de3          	beq	a2,a4,8e6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 930:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 934:	4790                	lw	a2,8(a5)
 936:	02061593          	slli	a1,a2,0x20
 93a:	01c5d713          	srli	a4,a1,0x1c
 93e:	973e                	add	a4,a4,a5
 940:	fae68ae3          	beq	a3,a4,8f4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 944:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 946:	00000717          	auipc	a4,0x0
 94a:	1cf73523          	sd	a5,458(a4) # b10 <freep>
}
 94e:	6422                	ld	s0,8(sp)
 950:	0141                	addi	sp,sp,16
 952:	8082                	ret

0000000000000954 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 954:	7139                	addi	sp,sp,-64
 956:	fc06                	sd	ra,56(sp)
 958:	f822                	sd	s0,48(sp)
 95a:	f426                	sd	s1,40(sp)
 95c:	f04a                	sd	s2,32(sp)
 95e:	ec4e                	sd	s3,24(sp)
 960:	e852                	sd	s4,16(sp)
 962:	e456                	sd	s5,8(sp)
 964:	e05a                	sd	s6,0(sp)
 966:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 968:	02051493          	slli	s1,a0,0x20
 96c:	9081                	srli	s1,s1,0x20
 96e:	04bd                	addi	s1,s1,15
 970:	8091                	srli	s1,s1,0x4
 972:	00148a1b          	addiw	s4,s1,1
 976:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 978:	00000517          	auipc	a0,0x0
 97c:	19853503          	ld	a0,408(a0) # b10 <freep>
 980:	c515                	beqz	a0,9ac <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 982:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 984:	4798                	lw	a4,8(a5)
 986:	04977163          	bgeu	a4,s1,9c8 <malloc+0x74>
 98a:	89d2                	mv	s3,s4
 98c:	000a071b          	sext.w	a4,s4
 990:	6685                	lui	a3,0x1
 992:	00d77363          	bgeu	a4,a3,998 <malloc+0x44>
 996:	6985                	lui	s3,0x1
 998:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 99c:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a0:	00000917          	auipc	s2,0x0
 9a4:	17090913          	addi	s2,s2,368 # b10 <freep>
  if(p == (char*)-1)
 9a8:	5afd                	li	s5,-1
 9aa:	a8a5                	j	a22 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 9ac:	00000797          	auipc	a5,0x0
 9b0:	16478793          	addi	a5,a5,356 # b10 <freep>
 9b4:	00000717          	auipc	a4,0x0
 9b8:	16470713          	addi	a4,a4,356 # b18 <base>
 9bc:	e398                	sd	a4,0(a5)
 9be:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 9c0:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c4:	87ba                	mv	a5,a4
 9c6:	b7d1                	j	98a <malloc+0x36>
      if(p->s.size == nunits)
 9c8:	02e48c63          	beq	s1,a4,a00 <malloc+0xac>
        p->s.size -= nunits;
 9cc:	4147073b          	subw	a4,a4,s4
 9d0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d2:	02071693          	slli	a3,a4,0x20
 9d6:	01c6d713          	srli	a4,a3,0x1c
 9da:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9dc:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 9e0:	00000717          	auipc	a4,0x0
 9e4:	12a73823          	sd	a0,304(a4) # b10 <freep>
      return (void*)(p + 1);
 9e8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ec:	70e2                	ld	ra,56(sp)
 9ee:	7442                	ld	s0,48(sp)
 9f0:	74a2                	ld	s1,40(sp)
 9f2:	7902                	ld	s2,32(sp)
 9f4:	69e2                	ld	s3,24(sp)
 9f6:	6a42                	ld	s4,16(sp)
 9f8:	6aa2                	ld	s5,8(sp)
 9fa:	6b02                	ld	s6,0(sp)
 9fc:	6121                	addi	sp,sp,64
 9fe:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a00:	6398                	ld	a4,0(a5)
 a02:	e118                	sd	a4,0(a0)
 a04:	bff1                	j	9e0 <malloc+0x8c>
  hp->s.size = nu;
 a06:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a0a:	0541                	addi	a0,a0,16
 a0c:	00000097          	auipc	ra,0x0
 a10:	ec6080e7          	jalr	-314(ra) # 8d2 <free>
  return freep;
 a14:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a18:	d971                	beqz	a0,9ec <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1c:	4798                	lw	a4,8(a5)
 a1e:	fa9775e3          	bgeu	a4,s1,9c8 <malloc+0x74>
    if(p == freep)
 a22:	00093703          	ld	a4,0(s2)
 a26:	853e                	mv	a0,a5
 a28:	fef719e3          	bne	a4,a5,a1a <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a2c:	854e                	mv	a0,s3
 a2e:	00000097          	auipc	ra,0x0
 a32:	95e080e7          	jalr	-1698(ra) # 38c <sbrk>
  if(p == (char*)-1)
 a36:	fd5518e3          	bne	a0,s5,a06 <malloc+0xb2>
        return 0;
 a3a:	4501                	li	a0,0
 a3c:	bf45                	j	9ec <malloc+0x98>
