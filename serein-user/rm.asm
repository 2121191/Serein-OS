
serein-user/_rm：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/fcntl.h"
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
  10:	02a7d163          	bge	a5,a0,32 <main+0x32>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	02091793          	slli	a5,s2,0x20
  20:	01d7d913          	srli	s2,a5,0x1d
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(remove(argv[i]) < 0){
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  28:	00001997          	auipc	s3,0x1
  2c:	a4898993          	addi	s3,s3,-1464 # a70 <malloc+0x104>
  30:	a015                	j	54 <main+0x54>
    fprintf(2, "Usage: rm files...\n");
  32:	00001597          	auipc	a1,0x1
  36:	a2658593          	addi	a1,a1,-1498 # a58 <malloc+0xec>
  3a:	4509                	li	a0,2
  3c:	00001097          	auipc	ra,0x1
  40:	84a080e7          	jalr	-1974(ra) # 886 <fprintf>
    exit(1);
  44:	4505                	li	a0,1
  46:	00000097          	auipc	ra,0x0
  4a:	2ee080e7          	jalr	750(ra) # 334 <exit>
  for(i = 1; i < argc; i++){
  4e:	04a1                	addi	s1,s1,8
  50:	03248163          	beq	s1,s2,72 <main+0x72>
    if(remove(argv[i]) < 0){
  54:	6088                	ld	a0,0(s1)
  56:	00000097          	auipc	ra,0x0
  5a:	386080e7          	jalr	902(ra) # 3dc <remove>
  5e:	fe0558e3          	bgez	a0,4e <main+0x4e>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  62:	6090                	ld	a2,0(s1)
  64:	85ce                	mv	a1,s3
  66:	4509                	li	a0,2
  68:	00001097          	auipc	ra,0x1
  6c:	81e080e7          	jalr	-2018(ra) # 886 <fprintf>
  70:	bff9                	j	4e <main+0x4e>
    }
  }

  exit(0);
  72:	4501                	li	a0,0
  74:	00000097          	auipc	ra,0x0
  78:	2c0080e7          	jalr	704(ra) # 334 <exit>

000000000000007c <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  82:	87aa                	mv	a5,a0
  84:	0585                	addi	a1,a1,1
  86:	0785                	addi	a5,a5,1
  88:	fff5c703          	lbu	a4,-1(a1)
  8c:	fee78fa3          	sb	a4,-1(a5)
  90:	fb75                	bnez	a4,84 <strcpy+0x8>
    ;
  return os;
}
  92:	6422                	ld	s0,8(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <strcat>:

char*
strcat(char *s, const char *t)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e422                	sd	s0,8(sp)
  9c:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  9e:	00054783          	lbu	a5,0(a0)
  a2:	c385                	beqz	a5,c2 <strcat+0x2a>
  a4:	87aa                	mv	a5,a0
    s++;
  a6:	0785                	addi	a5,a5,1
  while(*s)
  a8:	0007c703          	lbu	a4,0(a5)
  ac:	ff6d                	bnez	a4,a6 <strcat+0xe>
  while((*s++ = *t++))
  ae:	0585                	addi	a1,a1,1
  b0:	0785                	addi	a5,a5,1
  b2:	fff5c703          	lbu	a4,-1(a1)
  b6:	fee78fa3          	sb	a4,-1(a5)
  ba:	fb75                	bnez	a4,ae <strcat+0x16>
    ;
  return os;
}
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret
  while(*s)
  c2:	87aa                	mv	a5,a0
  c4:	b7ed                	j	ae <strcat+0x16>

00000000000000c6 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e422                	sd	s0,8(sp)
  ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	cb91                	beqz	a5,e4 <strcmp+0x1e>
  d2:	0005c703          	lbu	a4,0(a1)
  d6:	00f71763          	bne	a4,a5,e4 <strcmp+0x1e>
    p++, q++;
  da:	0505                	addi	a0,a0,1
  dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  de:	00054783          	lbu	a5,0(a0)
  e2:	fbe5                	bnez	a5,d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  e4:	0005c503          	lbu	a0,0(a1)
}
  e8:	40a7853b          	subw	a0,a5,a0
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strlen>:

uint
strlen(const char *s)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f8:	00054783          	lbu	a5,0(a0)
  fc:	cf91                	beqz	a5,118 <strlen+0x26>
  fe:	0505                	addi	a0,a0,1
 100:	87aa                	mv	a5,a0
 102:	4685                	li	a3,1
 104:	9e89                	subw	a3,a3,a0
 106:	00f6853b          	addw	a0,a3,a5
 10a:	0785                	addi	a5,a5,1
 10c:	fff7c703          	lbu	a4,-1(a5)
 110:	fb7d                	bnez	a4,106 <strlen+0x14>
    ;
  return n;
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret
  for(n = 0; s[n]; n++)
 118:	4501                	li	a0,0
 11a:	bfe5                	j	112 <strlen+0x20>

000000000000011c <memset>:

void*
memset(void *dst, int c, uint n)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 122:	ca19                	beqz	a2,138 <memset+0x1c>
 124:	87aa                	mv	a5,a0
 126:	1602                	slli	a2,a2,0x20
 128:	9201                	srli	a2,a2,0x20
 12a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 132:	0785                	addi	a5,a5,1
 134:	fee79de3          	bne	a5,a4,12e <memset+0x12>
  }
  return dst;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strchr>:

char*
strchr(const char *s, char c)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  for(; *s; s++)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb99                	beqz	a5,15e <strchr+0x20>
    if(*s == c)
 14a:	00f58763          	beq	a1,a5,158 <strchr+0x1a>
  for(; *s; s++)
 14e:	0505                	addi	a0,a0,1
 150:	00054783          	lbu	a5,0(a0)
 154:	fbfd                	bnez	a5,14a <strchr+0xc>
      return (char*)s;
  return 0;
 156:	4501                	li	a0,0
}
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret
  return 0;
 15e:	4501                	li	a0,0
 160:	bfe5                	j	158 <strchr+0x1a>

0000000000000162 <gets>:

char*
gets(char *buf, int max)
{
 162:	711d                	addi	sp,sp,-96
 164:	ec86                	sd	ra,88(sp)
 166:	e8a2                	sd	s0,80(sp)
 168:	e4a6                	sd	s1,72(sp)
 16a:	e0ca                	sd	s2,64(sp)
 16c:	fc4e                	sd	s3,56(sp)
 16e:	f852                	sd	s4,48(sp)
 170:	f456                	sd	s5,40(sp)
 172:	f05a                	sd	s6,32(sp)
 174:	ec5e                	sd	s7,24(sp)
 176:	e862                	sd	s8,16(sp)
 178:	1080                	addi	s0,sp,96
 17a:	8baa                	mv	s7,a0
 17c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17e:	892a                	mv	s2,a0
 180:	4481                	li	s1,0
    cc = read(0, &c, 1);
 182:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 186:	4b29                	li	s6,10
 188:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 18a:	89a6                	mv	s3,s1
 18c:	2485                	addiw	s1,s1,1
 18e:	0344d763          	bge	s1,s4,1bc <gets+0x5a>
    cc = read(0, &c, 1);
 192:	4605                	li	a2,1
 194:	85d6                	mv	a1,s5
 196:	4501                	li	a0,0
 198:	00000097          	auipc	ra,0x0
 19c:	1b4080e7          	jalr	436(ra) # 34c <read>
    if(cc < 1)
 1a0:	00a05e63          	blez	a0,1bc <gets+0x5a>
    buf[i++] = c;
 1a4:	faf44783          	lbu	a5,-81(s0)
 1a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ac:	01678763          	beq	a5,s6,1ba <gets+0x58>
 1b0:	0905                	addi	s2,s2,1
 1b2:	fd879ce3          	bne	a5,s8,18a <gets+0x28>
  for(i=0; i+1 < max; ){
 1b6:	89a6                	mv	s3,s1
 1b8:	a011                	j	1bc <gets+0x5a>
 1ba:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1bc:	99de                	add	s3,s3,s7
 1be:	00098023          	sb	zero,0(s3)
  return buf;
}
 1c2:	855e                	mv	a0,s7
 1c4:	60e6                	ld	ra,88(sp)
 1c6:	6446                	ld	s0,80(sp)
 1c8:	64a6                	ld	s1,72(sp)
 1ca:	6906                	ld	s2,64(sp)
 1cc:	79e2                	ld	s3,56(sp)
 1ce:	7a42                	ld	s4,48(sp)
 1d0:	7aa2                	ld	s5,40(sp)
 1d2:	7b02                	ld	s6,32(sp)
 1d4:	6be2                	ld	s7,24(sp)
 1d6:	6c42                	ld	s8,16(sp)
 1d8:	6125                	addi	sp,sp,96
 1da:	8082                	ret

00000000000001dc <stat>:

int
stat(const char *n, struct stat *st)
{
 1dc:	1101                	addi	sp,sp,-32
 1de:	ec06                	sd	ra,24(sp)
 1e0:	e822                	sd	s0,16(sp)
 1e2:	e426                	sd	s1,8(sp)
 1e4:	e04a                	sd	s2,0(sp)
 1e6:	1000                	addi	s0,sp,32
 1e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ea:	4581                	li	a1,0
 1ec:	00000097          	auipc	ra,0x0
 1f0:	188080e7          	jalr	392(ra) # 374 <open>
  if(fd < 0)
 1f4:	02054563          	bltz	a0,21e <stat+0x42>
 1f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1fa:	85ca                	mv	a1,s2
 1fc:	00000097          	auipc	ra,0x0
 200:	180080e7          	jalr	384(ra) # 37c <fstat>
 204:	892a                	mv	s2,a0
  close(fd);
 206:	8526                	mv	a0,s1
 208:	00000097          	auipc	ra,0x0
 20c:	154080e7          	jalr	340(ra) # 35c <close>
  return r;
}
 210:	854a                	mv	a0,s2
 212:	60e2                	ld	ra,24(sp)
 214:	6442                	ld	s0,16(sp)
 216:	64a2                	ld	s1,8(sp)
 218:	6902                	ld	s2,0(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret
    return -1;
 21e:	597d                	li	s2,-1
 220:	bfc5                	j	210 <stat+0x34>

0000000000000222 <atoi>:

int
atoi(const char *s)
{
 222:	1141                	addi	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 228:	00054703          	lbu	a4,0(a0)
 22c:	02d00793          	li	a5,45
  int neg = 1;
 230:	4585                	li	a1,1
  if (*s == '-') {
 232:	04f70363          	beq	a4,a5,278 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 236:	00054703          	lbu	a4,0(a0)
 23a:	fd07079b          	addiw	a5,a4,-48
 23e:	0ff7f793          	zext.b	a5,a5
 242:	46a5                	li	a3,9
 244:	02f6ed63          	bltu	a3,a5,27e <atoi+0x5c>
  n = 0;
 248:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 24a:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 24c:	0505                	addi	a0,a0,1
 24e:	0026979b          	slliw	a5,a3,0x2
 252:	9fb5                	addw	a5,a5,a3
 254:	0017979b          	slliw	a5,a5,0x1
 258:	9fb9                	addw	a5,a5,a4
 25a:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 25e:	00054703          	lbu	a4,0(a0)
 262:	fd07079b          	addiw	a5,a4,-48
 266:	0ff7f793          	zext.b	a5,a5
 26a:	fef671e3          	bgeu	a2,a5,24c <atoi+0x2a>
  return n * neg;
}
 26e:	02d5853b          	mulw	a0,a1,a3
 272:	6422                	ld	s0,8(sp)
 274:	0141                	addi	sp,sp,16
 276:	8082                	ret
    s++;
 278:	0505                	addi	a0,a0,1
    neg = -1;
 27a:	55fd                	li	a1,-1
 27c:	bf6d                	j	236 <atoi+0x14>
  n = 0;
 27e:	4681                	li	a3,0
 280:	b7fd                	j	26e <atoi+0x4c>

0000000000000282 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 288:	02b57463          	bgeu	a0,a1,2b0 <memmove+0x2e>
    while(n-- > 0)
 28c:	00c05f63          	blez	a2,2aa <memmove+0x28>
 290:	1602                	slli	a2,a2,0x20
 292:	9201                	srli	a2,a2,0x20
 294:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 298:	872a                	mv	a4,a0
      *dst++ = *src++;
 29a:	0585                	addi	a1,a1,1
 29c:	0705                	addi	a4,a4,1
 29e:	fff5c683          	lbu	a3,-1(a1)
 2a2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a6:	fee79ae3          	bne	a5,a4,29a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2aa:	6422                	ld	s0,8(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret
    dst += n;
 2b0:	00c50733          	add	a4,a0,a2
    src += n;
 2b4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b6:	fec05ae3          	blez	a2,2aa <memmove+0x28>
 2ba:	fff6079b          	addiw	a5,a2,-1
 2be:	1782                	slli	a5,a5,0x20
 2c0:	9381                	srli	a5,a5,0x20
 2c2:	fff7c793          	not	a5,a5
 2c6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c8:	15fd                	addi	a1,a1,-1
 2ca:	177d                	addi	a4,a4,-1
 2cc:	0005c683          	lbu	a3,0(a1)
 2d0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d4:	fee79ae3          	bne	a5,a4,2c8 <memmove+0x46>
 2d8:	bfc9                	j	2aa <memmove+0x28>

00000000000002da <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2e0:	ca05                	beqz	a2,310 <memcmp+0x36>
 2e2:	fff6069b          	addiw	a3,a2,-1
 2e6:	1682                	slli	a3,a3,0x20
 2e8:	9281                	srli	a3,a3,0x20
 2ea:	0685                	addi	a3,a3,1
 2ec:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	0005c703          	lbu	a4,0(a1)
 2f6:	00e79863          	bne	a5,a4,306 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2fa:	0505                	addi	a0,a0,1
    p2++;
 2fc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fe:	fed518e3          	bne	a0,a3,2ee <memcmp+0x14>
  }
  return 0;
 302:	4501                	li	a0,0
 304:	a019                	j	30a <memcmp+0x30>
      return *p1 - *p2;
 306:	40e7853b          	subw	a0,a5,a4
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
  return 0;
 310:	4501                	li	a0,0
 312:	bfe5                	j	30a <memcmp+0x30>

0000000000000314 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 314:	1141                	addi	sp,sp,-16
 316:	e406                	sd	ra,8(sp)
 318:	e022                	sd	s0,0(sp)
 31a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 31c:	00000097          	auipc	ra,0x0
 320:	f66080e7          	jalr	-154(ra) # 282 <memmove>
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 32c:	4885                	li	a7,1
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <exit>:
.global exit
exit:
 li a7, SYS_exit
 334:	4889                	li	a7,2
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <wait>:
.global wait
wait:
 li a7, SYS_wait
 33c:	488d                	li	a7,3
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 344:	4891                	li	a7,4
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <read>:
.global read
read:
 li a7, SYS_read
 34c:	4895                	li	a7,5
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <write>:
.global write
write:
 li a7, SYS_write
 354:	48c1                	li	a7,16
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <close>:
.global close
close:
 li a7, SYS_close
 35c:	48d5                	li	a7,21
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <kill>:
.global kill
kill:
 li a7, SYS_kill
 364:	4899                	li	a7,6
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <exec>:
.global exec
exec:
 li a7, SYS_exec
 36c:	489d                	li	a7,7
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <open>:
.global open
open:
 li a7, SYS_open
 374:	48bd                	li	a7,15
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 37c:	48a1                	li	a7,8
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 384:	48d1                	li	a7,20
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38c:	48a5                	li	a7,9
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <dup>:
.global dup
dup:
 li a7, SYS_dup
 394:	48a9                	li	a7,10
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39c:	48ad                	li	a7,11
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a4:	48b1                	li	a7,12
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ac:	48b5                	li	a7,13
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b4:	48b9                	li	a7,14
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3bc:	48d9                	li	a7,22
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3c4:	48dd                	li	a7,23
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3cc:	48e1                	li	a7,24
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3d4:	48e5                	li	a7,25
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <remove>:
.global remove
remove:
 li a7, SYS_remove
 3dc:	48c5                	li	a7,17
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e4:	48c9                	li	a7,18
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3ec:	48cd                	li	a7,19
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <rename>:
.global rename
rename:
 li a7, SYS_rename
 3f4:	48e9                	li	a7,26
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 3fc:	48ed                	li	a7,27
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 404:	48f1                	li	a7,28
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 40c:	48f5                	li	a7,29
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 414:	48f9                	li	a7,30
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 41c:	48fd                	li	a7,31
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 424:	02000893          	li	a7,32
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 42e:	02100893          	li	a7,33
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 438:	02200893          	li	a7,34
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 442:	02300893          	li	a7,35
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 44c:	02400893          	li	a7,36
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 456:	02500893          	li	a7,37
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 460:	02600893          	li	a7,38
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 46a:	02700893          	li	a7,39
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 474:	02800893          	li	a7,40
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 47e:	02900893          	li	a7,41
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 488:	02a00893          	li	a7,42
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 492:	02b00893          	li	a7,43
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 49c:	02c00893          	li	a7,44
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4a6:	02d00893          	li	a7,45
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4b0:	02e00893          	li	a7,46
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4ba:	02f00893          	li	a7,47
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 4c4:	03000893          	li	a7,48
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 4ce:	03100893          	li	a7,49
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 4d8:	03200893          	li	a7,50
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 4e2:	03300893          	li	a7,51
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 4ec:	03400893          	li	a7,52
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 4f6:	03500893          	li	a7,53
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 500:	03600893          	li	a7,54
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 50a:	03700893          	li	a7,55
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 514:	03800893          	li	a7,56
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 51e:	03900893          	li	a7,57
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 528:	03a00893          	li	a7,58
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <poll>:
.global poll
poll:
 li a7, SYS_poll
 532:	03b00893          	li	a7,59
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 53c:	03c00893          	li	a7,60
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 546:	03d00893          	li	a7,61
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 550:	03e00893          	li	a7,62
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <clone>:
.global clone
clone:
 li a7, SYS_clone
 55a:	03f00893          	li	a7,63
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <futex>:
.global futex
futex:
 li a7, SYS_futex
 564:	04000893          	li	a7,64
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 56e:	04100893          	li	a7,65
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <halt>:
.global halt
halt:
 li a7, SYS_halt
 578:	04200893          	li	a7,66
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 582:	04300893          	li	a7,67
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <socket>:
.global socket
socket:
 li a7, SYS_socket
 58c:	04400893          	li	a7,68
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <bind>:
.global bind
bind:
 li a7, SYS_bind
 596:	04500893          	li	a7,69
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <listen>:
.global listen
listen:
 li a7, SYS_listen
 5a0:	04600893          	li	a7,70
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <accept>:
.global accept
accept:
 li a7, SYS_accept
 5aa:	04700893          	li	a7,71
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5b4:	04800893          	li	a7,72
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <send>:
.global send
send:
 li a7, SYS_send
 5be:	04900893          	li	a7,73
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5c8:	04a00893          	li	a7,74
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 5d2:	04b00893          	li	a7,75
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5dc:	1101                	addi	sp,sp,-32
 5de:	ec06                	sd	ra,24(sp)
 5e0:	e822                	sd	s0,16(sp)
 5e2:	1000                	addi	s0,sp,32
 5e4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e8:	4605                	li	a2,1
 5ea:	fef40593          	addi	a1,s0,-17
 5ee:	00000097          	auipc	ra,0x0
 5f2:	d66080e7          	jalr	-666(ra) # 354 <write>
}
 5f6:	60e2                	ld	ra,24(sp)
 5f8:	6442                	ld	s0,16(sp)
 5fa:	6105                	addi	sp,sp,32
 5fc:	8082                	ret

00000000000005fe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fe:	7139                	addi	sp,sp,-64
 600:	fc06                	sd	ra,56(sp)
 602:	f822                	sd	s0,48(sp)
 604:	f426                	sd	s1,40(sp)
 606:	f04a                	sd	s2,32(sp)
 608:	ec4e                	sd	s3,24(sp)
 60a:	0080                	addi	s0,sp,64
 60c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60e:	c299                	beqz	a3,614 <printint+0x16>
 610:	0805c863          	bltz	a1,6a0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 614:	2581                	sext.w	a1,a1
  neg = 0;
 616:	4881                	li	a7,0
  }

  i = 0;
 618:	fc040993          	addi	s3,s0,-64
  neg = 0;
 61c:	86ce                	mv	a3,s3
  i = 0;
 61e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 620:	2601                	sext.w	a2,a2
 622:	00000517          	auipc	a0,0x0
 626:	4ce50513          	addi	a0,a0,1230 # af0 <digits>
 62a:	883a                	mv	a6,a4
 62c:	2705                	addiw	a4,a4,1
 62e:	02c5f7bb          	remuw	a5,a1,a2
 632:	1782                	slli	a5,a5,0x20
 634:	9381                	srli	a5,a5,0x20
 636:	97aa                	add	a5,a5,a0
 638:	0007c783          	lbu	a5,0(a5)
 63c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 640:	0005879b          	sext.w	a5,a1
 644:	02c5d5bb          	divuw	a1,a1,a2
 648:	0685                	addi	a3,a3,1
 64a:	fec7f0e3          	bgeu	a5,a2,62a <printint+0x2c>
  if(neg)
 64e:	00088c63          	beqz	a7,666 <printint+0x68>
    buf[i++] = '-';
 652:	fd070793          	addi	a5,a4,-48
 656:	00878733          	add	a4,a5,s0
 65a:	02d00793          	li	a5,45
 65e:	fef70823          	sb	a5,-16(a4)
 662:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 666:	02e05663          	blez	a4,692 <printint+0x94>
 66a:	fc040913          	addi	s2,s0,-64
 66e:	993a                	add	s2,s2,a4
 670:	19fd                	addi	s3,s3,-1
 672:	99ba                	add	s3,s3,a4
 674:	377d                	addiw	a4,a4,-1
 676:	1702                	slli	a4,a4,0x20
 678:	9301                	srli	a4,a4,0x20
 67a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67e:	fff94583          	lbu	a1,-1(s2)
 682:	8526                	mv	a0,s1
 684:	00000097          	auipc	ra,0x0
 688:	f58080e7          	jalr	-168(ra) # 5dc <putc>
  while(--i >= 0)
 68c:	197d                	addi	s2,s2,-1
 68e:	ff3918e3          	bne	s2,s3,67e <printint+0x80>
}
 692:	70e2                	ld	ra,56(sp)
 694:	7442                	ld	s0,48(sp)
 696:	74a2                	ld	s1,40(sp)
 698:	7902                	ld	s2,32(sp)
 69a:	69e2                	ld	s3,24(sp)
 69c:	6121                	addi	sp,sp,64
 69e:	8082                	ret
    x = -xx;
 6a0:	40b005bb          	negw	a1,a1
    neg = 1;
 6a4:	4885                	li	a7,1
    x = -xx;
 6a6:	bf8d                	j	618 <printint+0x1a>

00000000000006a8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a8:	7119                	addi	sp,sp,-128
 6aa:	fc86                	sd	ra,120(sp)
 6ac:	f8a2                	sd	s0,112(sp)
 6ae:	f4a6                	sd	s1,104(sp)
 6b0:	f0ca                	sd	s2,96(sp)
 6b2:	ecce                	sd	s3,88(sp)
 6b4:	e8d2                	sd	s4,80(sp)
 6b6:	e4d6                	sd	s5,72(sp)
 6b8:	e0da                	sd	s6,64(sp)
 6ba:	fc5e                	sd	s7,56(sp)
 6bc:	f862                	sd	s8,48(sp)
 6be:	f466                	sd	s9,40(sp)
 6c0:	f06a                	sd	s10,32(sp)
 6c2:	ec6e                	sd	s11,24(sp)
 6c4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c6:	0005c903          	lbu	s2,0(a1)
 6ca:	18090f63          	beqz	s2,868 <vprintf+0x1c0>
 6ce:	8aaa                	mv	s5,a0
 6d0:	8b32                	mv	s6,a2
 6d2:	00158493          	addi	s1,a1,1
  state = 0;
 6d6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6d8:	02500a13          	li	s4,37
 6dc:	4c55                	li	s8,21
 6de:	00000c97          	auipc	s9,0x0
 6e2:	3bac8c93          	addi	s9,s9,954 # a98 <malloc+0x12c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6e6:	02800d93          	li	s11,40
  putc(fd, 'x');
 6ea:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ec:	00000b97          	auipc	s7,0x0
 6f0:	404b8b93          	addi	s7,s7,1028 # af0 <digits>
 6f4:	a839                	j	712 <vprintf+0x6a>
        putc(fd, c);
 6f6:	85ca                	mv	a1,s2
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	ee2080e7          	jalr	-286(ra) # 5dc <putc>
 702:	a019                	j	708 <vprintf+0x60>
    } else if(state == '%'){
 704:	01498d63          	beq	s3,s4,71e <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 708:	0485                	addi	s1,s1,1
 70a:	fff4c903          	lbu	s2,-1(s1)
 70e:	14090d63          	beqz	s2,868 <vprintf+0x1c0>
    if(state == 0){
 712:	fe0999e3          	bnez	s3,704 <vprintf+0x5c>
      if(c == '%'){
 716:	ff4910e3          	bne	s2,s4,6f6 <vprintf+0x4e>
        state = '%';
 71a:	89d2                	mv	s3,s4
 71c:	b7f5                	j	708 <vprintf+0x60>
      if(c == 'd'){
 71e:	11490c63          	beq	s2,s4,836 <vprintf+0x18e>
 722:	f9d9079b          	addiw	a5,s2,-99
 726:	0ff7f793          	zext.b	a5,a5
 72a:	10fc6e63          	bltu	s8,a5,846 <vprintf+0x19e>
 72e:	f9d9079b          	addiw	a5,s2,-99
 732:	0ff7f713          	zext.b	a4,a5
 736:	10ec6863          	bltu	s8,a4,846 <vprintf+0x19e>
 73a:	00271793          	slli	a5,a4,0x2
 73e:	97e6                	add	a5,a5,s9
 740:	439c                	lw	a5,0(a5)
 742:	97e6                	add	a5,a5,s9
 744:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 746:	008b0913          	addi	s2,s6,8
 74a:	4685                	li	a3,1
 74c:	4629                	li	a2,10
 74e:	000b2583          	lw	a1,0(s6)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	eaa080e7          	jalr	-342(ra) # 5fe <printint>
 75c:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 75e:	4981                	li	s3,0
 760:	b765                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 762:	008b0913          	addi	s2,s6,8
 766:	4681                	li	a3,0
 768:	4629                	li	a2,10
 76a:	000b2583          	lw	a1,0(s6)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e8e080e7          	jalr	-370(ra) # 5fe <printint>
 778:	8b4a                	mv	s6,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b771                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 77e:	008b0913          	addi	s2,s6,8
 782:	4681                	li	a3,0
 784:	866a                	mv	a2,s10
 786:	000b2583          	lw	a1,0(s6)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e72080e7          	jalr	-398(ra) # 5fe <printint>
 794:	8b4a                	mv	s6,s2
      state = 0;
 796:	4981                	li	s3,0
 798:	bf85                	j	708 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 79a:	008b0793          	addi	a5,s6,8
 79e:	f8f43423          	sd	a5,-120(s0)
 7a2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7a6:	03000593          	li	a1,48
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	e30080e7          	jalr	-464(ra) # 5dc <putc>
  putc(fd, 'x');
 7b4:	07800593          	li	a1,120
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e22080e7          	jalr	-478(ra) # 5dc <putc>
 7c2:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c4:	03c9d793          	srli	a5,s3,0x3c
 7c8:	97de                	add	a5,a5,s7
 7ca:	0007c583          	lbu	a1,0(a5)
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	e0c080e7          	jalr	-500(ra) # 5dc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d8:	0992                	slli	s3,s3,0x4
 7da:	397d                	addiw	s2,s2,-1
 7dc:	fe0914e3          	bnez	s2,7c4 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7e0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	b70d                	j	708 <vprintf+0x60>
        s = va_arg(ap, char*);
 7e8:	008b0913          	addi	s2,s6,8
 7ec:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7f0:	02098163          	beqz	s3,812 <vprintf+0x16a>
        while(*s != 0){
 7f4:	0009c583          	lbu	a1,0(s3)
 7f8:	c5ad                	beqz	a1,862 <vprintf+0x1ba>
          putc(fd, *s);
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	de0080e7          	jalr	-544(ra) # 5dc <putc>
          s++;
 804:	0985                	addi	s3,s3,1
        while(*s != 0){
 806:	0009c583          	lbu	a1,0(s3)
 80a:	f9e5                	bnez	a1,7fa <vprintf+0x152>
        s = va_arg(ap, char*);
 80c:	8b4a                	mv	s6,s2
      state = 0;
 80e:	4981                	li	s3,0
 810:	bde5                	j	708 <vprintf+0x60>
          s = "(null)";
 812:	00000997          	auipc	s3,0x0
 816:	27e98993          	addi	s3,s3,638 # a90 <malloc+0x124>
        while(*s != 0){
 81a:	85ee                	mv	a1,s11
 81c:	bff9                	j	7fa <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 81e:	008b0913          	addi	s2,s6,8
 822:	000b4583          	lbu	a1,0(s6)
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	db4080e7          	jalr	-588(ra) # 5dc <putc>
 830:	8b4a                	mv	s6,s2
      state = 0;
 832:	4981                	li	s3,0
 834:	bdd1                	j	708 <vprintf+0x60>
        putc(fd, c);
 836:	85d2                	mv	a1,s4
 838:	8556                	mv	a0,s5
 83a:	00000097          	auipc	ra,0x0
 83e:	da2080e7          	jalr	-606(ra) # 5dc <putc>
      state = 0;
 842:	4981                	li	s3,0
 844:	b5d1                	j	708 <vprintf+0x60>
        putc(fd, '%');
 846:	85d2                	mv	a1,s4
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	d92080e7          	jalr	-622(ra) # 5dc <putc>
        putc(fd, c);
 852:	85ca                	mv	a1,s2
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	d86080e7          	jalr	-634(ra) # 5dc <putc>
      state = 0;
 85e:	4981                	li	s3,0
 860:	b565                	j	708 <vprintf+0x60>
        s = va_arg(ap, char*);
 862:	8b4a                	mv	s6,s2
      state = 0;
 864:	4981                	li	s3,0
 866:	b54d                	j	708 <vprintf+0x60>
    }
  }
}
 868:	70e6                	ld	ra,120(sp)
 86a:	7446                	ld	s0,112(sp)
 86c:	74a6                	ld	s1,104(sp)
 86e:	7906                	ld	s2,96(sp)
 870:	69e6                	ld	s3,88(sp)
 872:	6a46                	ld	s4,80(sp)
 874:	6aa6                	ld	s5,72(sp)
 876:	6b06                	ld	s6,64(sp)
 878:	7be2                	ld	s7,56(sp)
 87a:	7c42                	ld	s8,48(sp)
 87c:	7ca2                	ld	s9,40(sp)
 87e:	7d02                	ld	s10,32(sp)
 880:	6de2                	ld	s11,24(sp)
 882:	6109                	addi	sp,sp,128
 884:	8082                	ret

0000000000000886 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 886:	715d                	addi	sp,sp,-80
 888:	ec06                	sd	ra,24(sp)
 88a:	e822                	sd	s0,16(sp)
 88c:	1000                	addi	s0,sp,32
 88e:	e010                	sd	a2,0(s0)
 890:	e414                	sd	a3,8(s0)
 892:	e818                	sd	a4,16(s0)
 894:	ec1c                	sd	a5,24(s0)
 896:	03043023          	sd	a6,32(s0)
 89a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89e:	8622                	mv	a2,s0
 8a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a4:	00000097          	auipc	ra,0x0
 8a8:	e04080e7          	jalr	-508(ra) # 6a8 <vprintf>
}
 8ac:	60e2                	ld	ra,24(sp)
 8ae:	6442                	ld	s0,16(sp)
 8b0:	6161                	addi	sp,sp,80
 8b2:	8082                	ret

00000000000008b4 <printf>:

void
printf(const char *fmt, ...)
{
 8b4:	711d                	addi	sp,sp,-96
 8b6:	ec06                	sd	ra,24(sp)
 8b8:	e822                	sd	s0,16(sp)
 8ba:	1000                	addi	s0,sp,32
 8bc:	e40c                	sd	a1,8(s0)
 8be:	e810                	sd	a2,16(s0)
 8c0:	ec14                	sd	a3,24(s0)
 8c2:	f018                	sd	a4,32(s0)
 8c4:	f41c                	sd	a5,40(s0)
 8c6:	03043823          	sd	a6,48(s0)
 8ca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ce:	00840613          	addi	a2,s0,8
 8d2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d6:	85aa                	mv	a1,a0
 8d8:	4505                	li	a0,1
 8da:	00000097          	auipc	ra,0x0
 8de:	dce080e7          	jalr	-562(ra) # 6a8 <vprintf>
}
 8e2:	60e2                	ld	ra,24(sp)
 8e4:	6442                	ld	s0,16(sp)
 8e6:	6125                	addi	sp,sp,96
 8e8:	8082                	ret

00000000000008ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ea:	1141                	addi	sp,sp,-16
 8ec:	e422                	sd	s0,8(sp)
 8ee:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f4:	00000797          	auipc	a5,0x0
 8f8:	2147b783          	ld	a5,532(a5) # b08 <freep>
 8fc:	a02d                	j	926 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fe:	4618                	lw	a4,8(a2)
 900:	9f2d                	addw	a4,a4,a1
 902:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 906:	6398                	ld	a4,0(a5)
 908:	6310                	ld	a2,0(a4)
 90a:	a83d                	j	948 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 90c:	ff852703          	lw	a4,-8(a0)
 910:	9f31                	addw	a4,a4,a2
 912:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 914:	ff053683          	ld	a3,-16(a0)
 918:	a091                	j	95c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91a:	6398                	ld	a4,0(a5)
 91c:	00e7e463          	bltu	a5,a4,924 <free+0x3a>
 920:	00e6ea63          	bltu	a3,a4,934 <free+0x4a>
{
 924:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 926:	fed7fae3          	bgeu	a5,a3,91a <free+0x30>
 92a:	6398                	ld	a4,0(a5)
 92c:	00e6e463          	bltu	a3,a4,934 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 930:	fee7eae3          	bltu	a5,a4,924 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 934:	ff852583          	lw	a1,-8(a0)
 938:	6390                	ld	a2,0(a5)
 93a:	02059813          	slli	a6,a1,0x20
 93e:	01c85713          	srli	a4,a6,0x1c
 942:	9736                	add	a4,a4,a3
 944:	fae60de3          	beq	a2,a4,8fe <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 948:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 94c:	4790                	lw	a2,8(a5)
 94e:	02061593          	slli	a1,a2,0x20
 952:	01c5d713          	srli	a4,a1,0x1c
 956:	973e                	add	a4,a4,a5
 958:	fae68ae3          	beq	a3,a4,90c <free+0x22>
    p->s.ptr = bp->s.ptr;
 95c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 95e:	00000717          	auipc	a4,0x0
 962:	1af73523          	sd	a5,426(a4) # b08 <freep>
}
 966:	6422                	ld	s0,8(sp)
 968:	0141                	addi	sp,sp,16
 96a:	8082                	ret

000000000000096c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 96c:	7139                	addi	sp,sp,-64
 96e:	fc06                	sd	ra,56(sp)
 970:	f822                	sd	s0,48(sp)
 972:	f426                	sd	s1,40(sp)
 974:	f04a                	sd	s2,32(sp)
 976:	ec4e                	sd	s3,24(sp)
 978:	e852                	sd	s4,16(sp)
 97a:	e456                	sd	s5,8(sp)
 97c:	e05a                	sd	s6,0(sp)
 97e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 980:	02051493          	slli	s1,a0,0x20
 984:	9081                	srli	s1,s1,0x20
 986:	04bd                	addi	s1,s1,15
 988:	8091                	srli	s1,s1,0x4
 98a:	00148a1b          	addiw	s4,s1,1
 98e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 990:	00000517          	auipc	a0,0x0
 994:	17853503          	ld	a0,376(a0) # b08 <freep>
 998:	c515                	beqz	a0,9c4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 99c:	4798                	lw	a4,8(a5)
 99e:	04977163          	bgeu	a4,s1,9e0 <malloc+0x74>
 9a2:	89d2                	mv	s3,s4
 9a4:	000a071b          	sext.w	a4,s4
 9a8:	6685                	lui	a3,0x1
 9aa:	00d77363          	bgeu	a4,a3,9b0 <malloc+0x44>
 9ae:	6985                	lui	s3,0x1
 9b0:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 9b4:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b8:	00000917          	auipc	s2,0x0
 9bc:	15090913          	addi	s2,s2,336 # b08 <freep>
  if(p == (char*)-1)
 9c0:	5afd                	li	s5,-1
 9c2:	a8a5                	j	a3a <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 9c4:	00000797          	auipc	a5,0x0
 9c8:	14478793          	addi	a5,a5,324 # b08 <freep>
 9cc:	00000717          	auipc	a4,0x0
 9d0:	14470713          	addi	a4,a4,324 # b10 <base>
 9d4:	e398                	sd	a4,0(a5)
 9d6:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 9d8:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9dc:	87ba                	mv	a5,a4
 9de:	b7d1                	j	9a2 <malloc+0x36>
      if(p->s.size == nunits)
 9e0:	02e48c63          	beq	s1,a4,a18 <malloc+0xac>
        p->s.size -= nunits;
 9e4:	4147073b          	subw	a4,a4,s4
 9e8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ea:	02071693          	slli	a3,a4,0x20
 9ee:	01c6d713          	srli	a4,a3,0x1c
 9f2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f4:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 9f8:	00000717          	auipc	a4,0x0
 9fc:	10a73823          	sd	a0,272(a4) # b08 <freep>
      return (void*)(p + 1);
 a00:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a04:	70e2                	ld	ra,56(sp)
 a06:	7442                	ld	s0,48(sp)
 a08:	74a2                	ld	s1,40(sp)
 a0a:	7902                	ld	s2,32(sp)
 a0c:	69e2                	ld	s3,24(sp)
 a0e:	6a42                	ld	s4,16(sp)
 a10:	6aa2                	ld	s5,8(sp)
 a12:	6b02                	ld	s6,0(sp)
 a14:	6121                	addi	sp,sp,64
 a16:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a18:	6398                	ld	a4,0(a5)
 a1a:	e118                	sd	a4,0(a0)
 a1c:	bff1                	j	9f8 <malloc+0x8c>
  hp->s.size = nu;
 a1e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a22:	0541                	addi	a0,a0,16
 a24:	00000097          	auipc	ra,0x0
 a28:	ec6080e7          	jalr	-314(ra) # 8ea <free>
  return freep;
 a2c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a30:	d971                	beqz	a0,a04 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a32:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a34:	4798                	lw	a4,8(a5)
 a36:	fa9775e3          	bgeu	a4,s1,9e0 <malloc+0x74>
    if(p == freep)
 a3a:	00093703          	ld	a4,0(s2)
 a3e:	853e                	mv	a0,a5
 a40:	fef719e3          	bne	a4,a5,a32 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a44:	854e                	mv	a0,s3
 a46:	00000097          	auipc	ra,0x0
 a4a:	95e080e7          	jalr	-1698(ra) # 3a4 <sbrk>
  if(p == (char*)-1)
 a4e:	fd5518e3          	bne	a0,s5,a1e <malloc+0xb2>
        return 0;
 a52:	4501                	li	a0,0
 a54:	bf45                	j	a04 <malloc+0x98>
