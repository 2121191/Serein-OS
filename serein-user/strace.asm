
serein-user/_strace：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
   0:	712d                	addi	sp,sp,-288
   2:	ee06                	sd	ra,280(sp)
   4:	ea22                	sd	s0,272(sp)
   6:	e626                	sd	s1,264(sp)
   8:	e24a                	sd	s2,256(sp)
   a:	1200                	addi	s0,sp,288
   c:	892e                	mv	s2,a1
  int i;
  char *nargv[MAXARG];

  if(argc < 3 /*|| (argv[1][0] < '0' || argv[1][0] > '9')*/){
   e:	4789                	li	a5,2
  10:	02a7c163          	blt	a5,a0,32 <main+0x32>
    fprintf(2, "usage: %s MASK COMMAND\n", argv[0]);
  14:	6190                	ld	a2,0(a1)
  16:	00001597          	auipc	a1,0x1
  1a:	a8a58593          	addi	a1,a1,-1398 # aa0 <malloc+0xee>
  1e:	4509                	li	a0,2
  20:	00001097          	auipc	ra,0x1
  24:	8ac080e7          	jalr	-1876(ra) # 8cc <fprintf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	00000097          	auipc	ra,0x0
  2e:	350080e7          	jalr	848(ra) # 37a <exit>
  32:	84aa                	mv	s1,a0
  }

  if (trace(atoi(argv[1])) < 0) {
  34:	6588                	ld	a0,8(a1)
  36:	00000097          	auipc	ra,0x0
  3a:	232080e7          	jalr	562(ra) # 268 <atoi>
  3e:	00000097          	auipc	ra,0x0
  42:	3ec080e7          	jalr	1004(ra) # 42a <trace>
  46:	04054e63          	bltz	a0,a2 <main+0xa2>
  4a:	01090793          	addi	a5,s2,16
  4e:	ee040713          	addi	a4,s0,-288
  52:	ffd4869b          	addiw	a3,s1,-3
  56:	02069613          	slli	a2,a3,0x20
  5a:	01d65693          	srli	a3,a2,0x1d
  5e:	96be                	add	a3,a3,a5
  60:	10090593          	addi	a1,s2,256
    fprintf(2, "%s: strace failed\n", argv[0]);
    exit(1);
  }
  
  for(i = 2; i < argc && i < MAXARG; i++){
    nargv[i-2] = argv[i];
  64:	6390                	ld	a2,0(a5)
  66:	e310                	sd	a2,0(a4)
  for(i = 2; i < argc && i < MAXARG; i++){
  68:	00d78663          	beq	a5,a3,74 <main+0x74>
  6c:	07a1                	addi	a5,a5,8
  6e:	0721                	addi	a4,a4,8
  70:	feb79ae3          	bne	a5,a1,64 <main+0x64>
  }
  exec(nargv[0], nargv);  
  74:	ee040593          	addi	a1,s0,-288
  78:	ee043503          	ld	a0,-288(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	336080e7          	jalr	822(ra) # 3b2 <exec>
  printf("strace: exec %s fail\n", nargv[0]);
  84:	ee043583          	ld	a1,-288(s0)
  88:	00001517          	auipc	a0,0x1
  8c:	a4850513          	addi	a0,a0,-1464 # ad0 <malloc+0x11e>
  90:	00001097          	auipc	ra,0x1
  94:	86a080e7          	jalr	-1942(ra) # 8fa <printf>
  exit(0);
  98:	4501                	li	a0,0
  9a:	00000097          	auipc	ra,0x0
  9e:	2e0080e7          	jalr	736(ra) # 37a <exit>
    fprintf(2, "%s: strace failed\n", argv[0]);
  a2:	00093603          	ld	a2,0(s2)
  a6:	00001597          	auipc	a1,0x1
  aa:	a1258593          	addi	a1,a1,-1518 # ab8 <malloc+0x106>
  ae:	4509                	li	a0,2
  b0:	00001097          	auipc	ra,0x1
  b4:	81c080e7          	jalr	-2020(ra) # 8cc <fprintf>
    exit(1);
  b8:	4505                	li	a0,1
  ba:	00000097          	auipc	ra,0x0
  be:	2c0080e7          	jalr	704(ra) # 37a <exit>

00000000000000c2 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c8:	87aa                	mv	a5,a0
  ca:	0585                	addi	a1,a1,1
  cc:	0785                	addi	a5,a5,1
  ce:	fff5c703          	lbu	a4,-1(a1)
  d2:	fee78fa3          	sb	a4,-1(a5)
  d6:	fb75                	bnez	a4,ca <strcpy+0x8>
    ;
  return os;
}
  d8:	6422                	ld	s0,8(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <strcat>:

char*
strcat(char *s, const char *t)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e422                	sd	s0,8(sp)
  e2:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  e4:	00054783          	lbu	a5,0(a0)
  e8:	c385                	beqz	a5,108 <strcat+0x2a>
  ea:	87aa                	mv	a5,a0
    s++;
  ec:	0785                	addi	a5,a5,1
  while(*s)
  ee:	0007c703          	lbu	a4,0(a5)
  f2:	ff6d                	bnez	a4,ec <strcat+0xe>
  while((*s++ = *t++))
  f4:	0585                	addi	a1,a1,1
  f6:	0785                	addi	a5,a5,1
  f8:	fff5c703          	lbu	a4,-1(a1)
  fc:	fee78fa3          	sb	a4,-1(a5)
 100:	fb75                	bnez	a4,f4 <strcat+0x16>
    ;
  return os;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  while(*s)
 108:	87aa                	mv	a5,a0
 10a:	b7ed                	j	f4 <strcat+0x16>

000000000000010c <strcmp>:


int
strcmp(const char *p, const char *q)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 112:	00054783          	lbu	a5,0(a0)
 116:	cb91                	beqz	a5,12a <strcmp+0x1e>
 118:	0005c703          	lbu	a4,0(a1)
 11c:	00f71763          	bne	a4,a5,12a <strcmp+0x1e>
    p++, q++;
 120:	0505                	addi	a0,a0,1
 122:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 124:	00054783          	lbu	a5,0(a0)
 128:	fbe5                	bnez	a5,118 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 12a:	0005c503          	lbu	a0,0(a1)
}
 12e:	40a7853b          	subw	a0,a5,a0
 132:	6422                	ld	s0,8(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret

0000000000000138 <strlen>:

uint
strlen(const char *s)
{
 138:	1141                	addi	sp,sp,-16
 13a:	e422                	sd	s0,8(sp)
 13c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf91                	beqz	a5,15e <strlen+0x26>
 144:	0505                	addi	a0,a0,1
 146:	87aa                	mv	a5,a0
 148:	4685                	li	a3,1
 14a:	9e89                	subw	a3,a3,a0
 14c:	00f6853b          	addw	a0,a3,a5
 150:	0785                	addi	a5,a5,1
 152:	fff7c703          	lbu	a4,-1(a5)
 156:	fb7d                	bnez	a4,14c <strlen+0x14>
    ;
  return n;
}
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret
  for(n = 0; s[n]; n++)
 15e:	4501                	li	a0,0
 160:	bfe5                	j	158 <strlen+0x20>

0000000000000162 <memset>:

void*
memset(void *dst, int c, uint n)
{
 162:	1141                	addi	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 168:	ca19                	beqz	a2,17e <memset+0x1c>
 16a:	87aa                	mv	a5,a0
 16c:	1602                	slli	a2,a2,0x20
 16e:	9201                	srli	a2,a2,0x20
 170:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 174:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 178:	0785                	addi	a5,a5,1
 17a:	fee79de3          	bne	a5,a4,174 <memset+0x12>
  }
  return dst;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	addi	sp,sp,16
 182:	8082                	ret

0000000000000184 <strchr>:

char*
strchr(const char *s, char c)
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
  for(; *s; s++)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	cb99                	beqz	a5,1a4 <strchr+0x20>
    if(*s == c)
 190:	00f58763          	beq	a1,a5,19e <strchr+0x1a>
  for(; *s; s++)
 194:	0505                	addi	a0,a0,1
 196:	00054783          	lbu	a5,0(a0)
 19a:	fbfd                	bnez	a5,190 <strchr+0xc>
      return (char*)s;
  return 0;
 19c:	4501                	li	a0,0
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret
  return 0;
 1a4:	4501                	li	a0,0
 1a6:	bfe5                	j	19e <strchr+0x1a>

00000000000001a8 <gets>:

char*
gets(char *buf, int max)
{
 1a8:	711d                	addi	sp,sp,-96
 1aa:	ec86                	sd	ra,88(sp)
 1ac:	e8a2                	sd	s0,80(sp)
 1ae:	e4a6                	sd	s1,72(sp)
 1b0:	e0ca                	sd	s2,64(sp)
 1b2:	fc4e                	sd	s3,56(sp)
 1b4:	f852                	sd	s4,48(sp)
 1b6:	f456                	sd	s5,40(sp)
 1b8:	f05a                	sd	s6,32(sp)
 1ba:	ec5e                	sd	s7,24(sp)
 1bc:	e862                	sd	s8,16(sp)
 1be:	1080                	addi	s0,sp,96
 1c0:	8baa                	mv	s7,a0
 1c2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c4:	892a                	mv	s2,a0
 1c6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1c8:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1cc:	4b29                	li	s6,10
 1ce:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1d0:	89a6                	mv	s3,s1
 1d2:	2485                	addiw	s1,s1,1
 1d4:	0344d763          	bge	s1,s4,202 <gets+0x5a>
    cc = read(0, &c, 1);
 1d8:	4605                	li	a2,1
 1da:	85d6                	mv	a1,s5
 1dc:	4501                	li	a0,0
 1de:	00000097          	auipc	ra,0x0
 1e2:	1b4080e7          	jalr	436(ra) # 392 <read>
    if(cc < 1)
 1e6:	00a05e63          	blez	a0,202 <gets+0x5a>
    buf[i++] = c;
 1ea:	faf44783          	lbu	a5,-81(s0)
 1ee:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f2:	01678763          	beq	a5,s6,200 <gets+0x58>
 1f6:	0905                	addi	s2,s2,1
 1f8:	fd879ce3          	bne	a5,s8,1d0 <gets+0x28>
  for(i=0; i+1 < max; ){
 1fc:	89a6                	mv	s3,s1
 1fe:	a011                	j	202 <gets+0x5a>
 200:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 202:	99de                	add	s3,s3,s7
 204:	00098023          	sb	zero,0(s3)
  return buf;
}
 208:	855e                	mv	a0,s7
 20a:	60e6                	ld	ra,88(sp)
 20c:	6446                	ld	s0,80(sp)
 20e:	64a6                	ld	s1,72(sp)
 210:	6906                	ld	s2,64(sp)
 212:	79e2                	ld	s3,56(sp)
 214:	7a42                	ld	s4,48(sp)
 216:	7aa2                	ld	s5,40(sp)
 218:	7b02                	ld	s6,32(sp)
 21a:	6be2                	ld	s7,24(sp)
 21c:	6c42                	ld	s8,16(sp)
 21e:	6125                	addi	sp,sp,96
 220:	8082                	ret

0000000000000222 <stat>:

int
stat(const char *n, struct stat *st)
{
 222:	1101                	addi	sp,sp,-32
 224:	ec06                	sd	ra,24(sp)
 226:	e822                	sd	s0,16(sp)
 228:	e426                	sd	s1,8(sp)
 22a:	e04a                	sd	s2,0(sp)
 22c:	1000                	addi	s0,sp,32
 22e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 230:	4581                	li	a1,0
 232:	00000097          	auipc	ra,0x0
 236:	188080e7          	jalr	392(ra) # 3ba <open>
  if(fd < 0)
 23a:	02054563          	bltz	a0,264 <stat+0x42>
 23e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 240:	85ca                	mv	a1,s2
 242:	00000097          	auipc	ra,0x0
 246:	180080e7          	jalr	384(ra) # 3c2 <fstat>
 24a:	892a                	mv	s2,a0
  close(fd);
 24c:	8526                	mv	a0,s1
 24e:	00000097          	auipc	ra,0x0
 252:	154080e7          	jalr	340(ra) # 3a2 <close>
  return r;
}
 256:	854a                	mv	a0,s2
 258:	60e2                	ld	ra,24(sp)
 25a:	6442                	ld	s0,16(sp)
 25c:	64a2                	ld	s1,8(sp)
 25e:	6902                	ld	s2,0(sp)
 260:	6105                	addi	sp,sp,32
 262:	8082                	ret
    return -1;
 264:	597d                	li	s2,-1
 266:	bfc5                	j	256 <stat+0x34>

0000000000000268 <atoi>:

int
atoi(const char *s)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 26e:	00054703          	lbu	a4,0(a0)
 272:	02d00793          	li	a5,45
  int neg = 1;
 276:	4585                	li	a1,1
  if (*s == '-') {
 278:	04f70363          	beq	a4,a5,2be <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 27c:	00054703          	lbu	a4,0(a0)
 280:	fd07079b          	addiw	a5,a4,-48
 284:	0ff7f793          	zext.b	a5,a5
 288:	46a5                	li	a3,9
 28a:	02f6ed63          	bltu	a3,a5,2c4 <atoi+0x5c>
  n = 0;
 28e:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 290:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 292:	0505                	addi	a0,a0,1
 294:	0026979b          	slliw	a5,a3,0x2
 298:	9fb5                	addw	a5,a5,a3
 29a:	0017979b          	slliw	a5,a5,0x1
 29e:	9fb9                	addw	a5,a5,a4
 2a0:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 2a4:	00054703          	lbu	a4,0(a0)
 2a8:	fd07079b          	addiw	a5,a4,-48
 2ac:	0ff7f793          	zext.b	a5,a5
 2b0:	fef671e3          	bgeu	a2,a5,292 <atoi+0x2a>
  return n * neg;
}
 2b4:	02d5853b          	mulw	a0,a1,a3
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret
    s++;
 2be:	0505                	addi	a0,a0,1
    neg = -1;
 2c0:	55fd                	li	a1,-1
 2c2:	bf6d                	j	27c <atoi+0x14>
  n = 0;
 2c4:	4681                	li	a3,0
 2c6:	b7fd                	j	2b4 <atoi+0x4c>

00000000000002c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ce:	02b57463          	bgeu	a0,a1,2f6 <memmove+0x2e>
    while(n-- > 0)
 2d2:	00c05f63          	blez	a2,2f0 <memmove+0x28>
 2d6:	1602                	slli	a2,a2,0x20
 2d8:	9201                	srli	a2,a2,0x20
 2da:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2de:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e0:	0585                	addi	a1,a1,1
 2e2:	0705                	addi	a4,a4,1
 2e4:	fff5c683          	lbu	a3,-1(a1)
 2e8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ec:	fee79ae3          	bne	a5,a4,2e0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
    dst += n;
 2f6:	00c50733          	add	a4,a0,a2
    src += n;
 2fa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2fc:	fec05ae3          	blez	a2,2f0 <memmove+0x28>
 300:	fff6079b          	addiw	a5,a2,-1
 304:	1782                	slli	a5,a5,0x20
 306:	9381                	srli	a5,a5,0x20
 308:	fff7c793          	not	a5,a5
 30c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 30e:	15fd                	addi	a1,a1,-1
 310:	177d                	addi	a4,a4,-1
 312:	0005c683          	lbu	a3,0(a1)
 316:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 31a:	fee79ae3          	bne	a5,a4,30e <memmove+0x46>
 31e:	bfc9                	j	2f0 <memmove+0x28>

0000000000000320 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 326:	ca05                	beqz	a2,356 <memcmp+0x36>
 328:	fff6069b          	addiw	a3,a2,-1
 32c:	1682                	slli	a3,a3,0x20
 32e:	9281                	srli	a3,a3,0x20
 330:	0685                	addi	a3,a3,1
 332:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 334:	00054783          	lbu	a5,0(a0)
 338:	0005c703          	lbu	a4,0(a1)
 33c:	00e79863          	bne	a5,a4,34c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 340:	0505                	addi	a0,a0,1
    p2++;
 342:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 344:	fed518e3          	bne	a0,a3,334 <memcmp+0x14>
  }
  return 0;
 348:	4501                	li	a0,0
 34a:	a019                	j	350 <memcmp+0x30>
      return *p1 - *p2;
 34c:	40e7853b          	subw	a0,a5,a4
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret
  return 0;
 356:	4501                	li	a0,0
 358:	bfe5                	j	350 <memcmp+0x30>

000000000000035a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 35a:	1141                	addi	sp,sp,-16
 35c:	e406                	sd	ra,8(sp)
 35e:	e022                	sd	s0,0(sp)
 360:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 362:	00000097          	auipc	ra,0x0
 366:	f66080e7          	jalr	-154(ra) # 2c8 <memmove>
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret

0000000000000372 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 372:	4885                	li	a7,1
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exit>:
.global exit
exit:
 li a7, SYS_exit
 37a:	4889                	li	a7,2
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <wait>:
.global wait
wait:
 li a7, SYS_wait
 382:	488d                	li	a7,3
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 38a:	4891                	li	a7,4
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <read>:
.global read
read:
 li a7, SYS_read
 392:	4895                	li	a7,5
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <write>:
.global write
write:
 li a7, SYS_write
 39a:	48c1                	li	a7,16
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <close>:
.global close
close:
 li a7, SYS_close
 3a2:	48d5                	li	a7,21
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <kill>:
.global kill
kill:
 li a7, SYS_kill
 3aa:	4899                	li	a7,6
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b2:	489d                	li	a7,7
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <open>:
.global open
open:
 li a7, SYS_open
 3ba:	48bd                	li	a7,15
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3c2:	48a1                	li	a7,8
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ca:	48d1                	li	a7,20
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d2:	48a5                	li	a7,9
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <dup>:
.global dup
dup:
 li a7, SYS_dup
 3da:	48a9                	li	a7,10
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e2:	48ad                	li	a7,11
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ea:	48b1                	li	a7,12
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3f2:	48b5                	li	a7,13
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3fa:	48b9                	li	a7,14
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 402:	48d9                	li	a7,22
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <dev>:
.global dev
dev:
 li a7, SYS_dev
 40a:	48dd                	li	a7,23
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 412:	48e1                	li	a7,24
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 41a:	48e5                	li	a7,25
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <remove>:
.global remove
remove:
 li a7, SYS_remove
 422:	48c5                	li	a7,17
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <trace>:
.global trace
trace:
 li a7, SYS_trace
 42a:	48c9                	li	a7,18
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 432:	48cd                	li	a7,19
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <rename>:
.global rename
rename:
 li a7, SYS_rename
 43a:	48e9                	li	a7,26
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 442:	48ed                	li	a7,27
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 44a:	48f1                	li	a7,28
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 452:	48f5                	li	a7,29
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 45a:	48f9                	li	a7,30
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 462:	48fd                	li	a7,31
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 46a:	02000893          	li	a7,32
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 474:	02100893          	li	a7,33
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 47e:	02200893          	li	a7,34
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 488:	02300893          	li	a7,35
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 492:	02400893          	li	a7,36
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 49c:	02500893          	li	a7,37
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4a6:	02600893          	li	a7,38
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 4b0:	02700893          	li	a7,39
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 4ba:	02800893          	li	a7,40
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 4c4:	02900893          	li	a7,41
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 4ce:	02a00893          	li	a7,42
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 4d8:	02b00893          	li	a7,43
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 4e2:	02c00893          	li	a7,44
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4ec:	02d00893          	li	a7,45
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4f6:	02e00893          	li	a7,46
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 500:	02f00893          	li	a7,47
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 50a:	03000893          	li	a7,48
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 514:	03100893          	li	a7,49
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 51e:	03200893          	li	a7,50
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 528:	03300893          	li	a7,51
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 532:	03400893          	li	a7,52
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 53c:	03500893          	li	a7,53
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 546:	03600893          	li	a7,54
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 550:	03700893          	li	a7,55
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 55a:	03800893          	li	a7,56
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 564:	03900893          	li	a7,57
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 56e:	03a00893          	li	a7,58
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <poll>:
.global poll
poll:
 li a7, SYS_poll
 578:	03b00893          	li	a7,59
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 582:	03c00893          	li	a7,60
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 58c:	03d00893          	li	a7,61
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 596:	03e00893          	li	a7,62
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <clone>:
.global clone
clone:
 li a7, SYS_clone
 5a0:	03f00893          	li	a7,63
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <futex>:
.global futex
futex:
 li a7, SYS_futex
 5aa:	04000893          	li	a7,64
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 5b4:	04100893          	li	a7,65
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <halt>:
.global halt
halt:
 li a7, SYS_halt
 5be:	04200893          	li	a7,66
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 5c8:	04300893          	li	a7,67
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <socket>:
.global socket
socket:
 li a7, SYS_socket
 5d2:	04400893          	li	a7,68
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <bind>:
.global bind
bind:
 li a7, SYS_bind
 5dc:	04500893          	li	a7,69
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <listen>:
.global listen
listen:
 li a7, SYS_listen
 5e6:	04600893          	li	a7,70
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5f0:	04700893          	li	a7,71
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <connect>:
.global connect
connect:
 li a7, SYS_connect
 5fa:	04800893          	li	a7,72
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <send>:
.global send
send:
 li a7, SYS_send
 604:	04900893          	li	a7,73
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <recv>:
.global recv
recv:
 li a7, SYS_recv
 60e:	04a00893          	li	a7,74
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 618:	04b00893          	li	a7,75
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 622:	1101                	addi	sp,sp,-32
 624:	ec06                	sd	ra,24(sp)
 626:	e822                	sd	s0,16(sp)
 628:	1000                	addi	s0,sp,32
 62a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 62e:	4605                	li	a2,1
 630:	fef40593          	addi	a1,s0,-17
 634:	00000097          	auipc	ra,0x0
 638:	d66080e7          	jalr	-666(ra) # 39a <write>
}
 63c:	60e2                	ld	ra,24(sp)
 63e:	6442                	ld	s0,16(sp)
 640:	6105                	addi	sp,sp,32
 642:	8082                	ret

0000000000000644 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 644:	7139                	addi	sp,sp,-64
 646:	fc06                	sd	ra,56(sp)
 648:	f822                	sd	s0,48(sp)
 64a:	f426                	sd	s1,40(sp)
 64c:	f04a                	sd	s2,32(sp)
 64e:	ec4e                	sd	s3,24(sp)
 650:	0080                	addi	s0,sp,64
 652:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 654:	c299                	beqz	a3,65a <printint+0x16>
 656:	0805c863          	bltz	a1,6e6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65a:	2581                	sext.w	a1,a1
  neg = 0;
 65c:	4881                	li	a7,0
  }

  i = 0;
 65e:	fc040993          	addi	s3,s0,-64
  neg = 0;
 662:	86ce                	mv	a3,s3
  i = 0;
 664:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 666:	2601                	sext.w	a2,a2
 668:	00000517          	auipc	a0,0x0
 66c:	4e050513          	addi	a0,a0,1248 # b48 <digits>
 670:	883a                	mv	a6,a4
 672:	2705                	addiw	a4,a4,1
 674:	02c5f7bb          	remuw	a5,a1,a2
 678:	1782                	slli	a5,a5,0x20
 67a:	9381                	srli	a5,a5,0x20
 67c:	97aa                	add	a5,a5,a0
 67e:	0007c783          	lbu	a5,0(a5)
 682:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 686:	0005879b          	sext.w	a5,a1
 68a:	02c5d5bb          	divuw	a1,a1,a2
 68e:	0685                	addi	a3,a3,1
 690:	fec7f0e3          	bgeu	a5,a2,670 <printint+0x2c>
  if(neg)
 694:	00088c63          	beqz	a7,6ac <printint+0x68>
    buf[i++] = '-';
 698:	fd070793          	addi	a5,a4,-48
 69c:	00878733          	add	a4,a5,s0
 6a0:	02d00793          	li	a5,45
 6a4:	fef70823          	sb	a5,-16(a4)
 6a8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6ac:	02e05663          	blez	a4,6d8 <printint+0x94>
 6b0:	fc040913          	addi	s2,s0,-64
 6b4:	993a                	add	s2,s2,a4
 6b6:	19fd                	addi	s3,s3,-1
 6b8:	99ba                	add	s3,s3,a4
 6ba:	377d                	addiw	a4,a4,-1
 6bc:	1702                	slli	a4,a4,0x20
 6be:	9301                	srli	a4,a4,0x20
 6c0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6c4:	fff94583          	lbu	a1,-1(s2)
 6c8:	8526                	mv	a0,s1
 6ca:	00000097          	auipc	ra,0x0
 6ce:	f58080e7          	jalr	-168(ra) # 622 <putc>
  while(--i >= 0)
 6d2:	197d                	addi	s2,s2,-1
 6d4:	ff3918e3          	bne	s2,s3,6c4 <printint+0x80>
}
 6d8:	70e2                	ld	ra,56(sp)
 6da:	7442                	ld	s0,48(sp)
 6dc:	74a2                	ld	s1,40(sp)
 6de:	7902                	ld	s2,32(sp)
 6e0:	69e2                	ld	s3,24(sp)
 6e2:	6121                	addi	sp,sp,64
 6e4:	8082                	ret
    x = -xx;
 6e6:	40b005bb          	negw	a1,a1
    neg = 1;
 6ea:	4885                	li	a7,1
    x = -xx;
 6ec:	bf8d                	j	65e <printint+0x1a>

00000000000006ee <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ee:	7119                	addi	sp,sp,-128
 6f0:	fc86                	sd	ra,120(sp)
 6f2:	f8a2                	sd	s0,112(sp)
 6f4:	f4a6                	sd	s1,104(sp)
 6f6:	f0ca                	sd	s2,96(sp)
 6f8:	ecce                	sd	s3,88(sp)
 6fa:	e8d2                	sd	s4,80(sp)
 6fc:	e4d6                	sd	s5,72(sp)
 6fe:	e0da                	sd	s6,64(sp)
 700:	fc5e                	sd	s7,56(sp)
 702:	f862                	sd	s8,48(sp)
 704:	f466                	sd	s9,40(sp)
 706:	f06a                	sd	s10,32(sp)
 708:	ec6e                	sd	s11,24(sp)
 70a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 70c:	0005c903          	lbu	s2,0(a1)
 710:	18090f63          	beqz	s2,8ae <vprintf+0x1c0>
 714:	8aaa                	mv	s5,a0
 716:	8b32                	mv	s6,a2
 718:	00158493          	addi	s1,a1,1
  state = 0;
 71c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 71e:	02500a13          	li	s4,37
 722:	4c55                	li	s8,21
 724:	00000c97          	auipc	s9,0x0
 728:	3ccc8c93          	addi	s9,s9,972 # af0 <malloc+0x13e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 72c:	02800d93          	li	s11,40
  putc(fd, 'x');
 730:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 732:	00000b97          	auipc	s7,0x0
 736:	416b8b93          	addi	s7,s7,1046 # b48 <digits>
 73a:	a839                	j	758 <vprintf+0x6a>
        putc(fd, c);
 73c:	85ca                	mv	a1,s2
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	ee2080e7          	jalr	-286(ra) # 622 <putc>
 748:	a019                	j	74e <vprintf+0x60>
    } else if(state == '%'){
 74a:	01498d63          	beq	s3,s4,764 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 74e:	0485                	addi	s1,s1,1
 750:	fff4c903          	lbu	s2,-1(s1)
 754:	14090d63          	beqz	s2,8ae <vprintf+0x1c0>
    if(state == 0){
 758:	fe0999e3          	bnez	s3,74a <vprintf+0x5c>
      if(c == '%'){
 75c:	ff4910e3          	bne	s2,s4,73c <vprintf+0x4e>
        state = '%';
 760:	89d2                	mv	s3,s4
 762:	b7f5                	j	74e <vprintf+0x60>
      if(c == 'd'){
 764:	11490c63          	beq	s2,s4,87c <vprintf+0x18e>
 768:	f9d9079b          	addiw	a5,s2,-99
 76c:	0ff7f793          	zext.b	a5,a5
 770:	10fc6e63          	bltu	s8,a5,88c <vprintf+0x19e>
 774:	f9d9079b          	addiw	a5,s2,-99
 778:	0ff7f713          	zext.b	a4,a5
 77c:	10ec6863          	bltu	s8,a4,88c <vprintf+0x19e>
 780:	00271793          	slli	a5,a4,0x2
 784:	97e6                	add	a5,a5,s9
 786:	439c                	lw	a5,0(a5)
 788:	97e6                	add	a5,a5,s9
 78a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 78c:	008b0913          	addi	s2,s6,8
 790:	4685                	li	a3,1
 792:	4629                	li	a2,10
 794:	000b2583          	lw	a1,0(s6)
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	eaa080e7          	jalr	-342(ra) # 644 <printint>
 7a2:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	b765                	j	74e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a8:	008b0913          	addi	s2,s6,8
 7ac:	4681                	li	a3,0
 7ae:	4629                	li	a2,10
 7b0:	000b2583          	lw	a1,0(s6)
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	e8e080e7          	jalr	-370(ra) # 644 <printint>
 7be:	8b4a                	mv	s6,s2
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	b771                	j	74e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7c4:	008b0913          	addi	s2,s6,8
 7c8:	4681                	li	a3,0
 7ca:	866a                	mv	a2,s10
 7cc:	000b2583          	lw	a1,0(s6)
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	e72080e7          	jalr	-398(ra) # 644 <printint>
 7da:	8b4a                	mv	s6,s2
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bf85                	j	74e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7e0:	008b0793          	addi	a5,s6,8
 7e4:	f8f43423          	sd	a5,-120(s0)
 7e8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7ec:	03000593          	li	a1,48
 7f0:	8556                	mv	a0,s5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	e30080e7          	jalr	-464(ra) # 622 <putc>
  putc(fd, 'x');
 7fa:	07800593          	li	a1,120
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	e22080e7          	jalr	-478(ra) # 622 <putc>
 808:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 80a:	03c9d793          	srli	a5,s3,0x3c
 80e:	97de                	add	a5,a5,s7
 810:	0007c583          	lbu	a1,0(a5)
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	e0c080e7          	jalr	-500(ra) # 622 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 81e:	0992                	slli	s3,s3,0x4
 820:	397d                	addiw	s2,s2,-1
 822:	fe0914e3          	bnez	s2,80a <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 826:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b70d                	j	74e <vprintf+0x60>
        s = va_arg(ap, char*);
 82e:	008b0913          	addi	s2,s6,8
 832:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 836:	02098163          	beqz	s3,858 <vprintf+0x16a>
        while(*s != 0){
 83a:	0009c583          	lbu	a1,0(s3)
 83e:	c5ad                	beqz	a1,8a8 <vprintf+0x1ba>
          putc(fd, *s);
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	de0080e7          	jalr	-544(ra) # 622 <putc>
          s++;
 84a:	0985                	addi	s3,s3,1
        while(*s != 0){
 84c:	0009c583          	lbu	a1,0(s3)
 850:	f9e5                	bnez	a1,840 <vprintf+0x152>
        s = va_arg(ap, char*);
 852:	8b4a                	mv	s6,s2
      state = 0;
 854:	4981                	li	s3,0
 856:	bde5                	j	74e <vprintf+0x60>
          s = "(null)";
 858:	00000997          	auipc	s3,0x0
 85c:	29098993          	addi	s3,s3,656 # ae8 <malloc+0x136>
        while(*s != 0){
 860:	85ee                	mv	a1,s11
 862:	bff9                	j	840 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 864:	008b0913          	addi	s2,s6,8
 868:	000b4583          	lbu	a1,0(s6)
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	db4080e7          	jalr	-588(ra) # 622 <putc>
 876:	8b4a                	mv	s6,s2
      state = 0;
 878:	4981                	li	s3,0
 87a:	bdd1                	j	74e <vprintf+0x60>
        putc(fd, c);
 87c:	85d2                	mv	a1,s4
 87e:	8556                	mv	a0,s5
 880:	00000097          	auipc	ra,0x0
 884:	da2080e7          	jalr	-606(ra) # 622 <putc>
      state = 0;
 888:	4981                	li	s3,0
 88a:	b5d1                	j	74e <vprintf+0x60>
        putc(fd, '%');
 88c:	85d2                	mv	a1,s4
 88e:	8556                	mv	a0,s5
 890:	00000097          	auipc	ra,0x0
 894:	d92080e7          	jalr	-622(ra) # 622 <putc>
        putc(fd, c);
 898:	85ca                	mv	a1,s2
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	d86080e7          	jalr	-634(ra) # 622 <putc>
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b565                	j	74e <vprintf+0x60>
        s = va_arg(ap, char*);
 8a8:	8b4a                	mv	s6,s2
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	b54d                	j	74e <vprintf+0x60>
    }
  }
}
 8ae:	70e6                	ld	ra,120(sp)
 8b0:	7446                	ld	s0,112(sp)
 8b2:	74a6                	ld	s1,104(sp)
 8b4:	7906                	ld	s2,96(sp)
 8b6:	69e6                	ld	s3,88(sp)
 8b8:	6a46                	ld	s4,80(sp)
 8ba:	6aa6                	ld	s5,72(sp)
 8bc:	6b06                	ld	s6,64(sp)
 8be:	7be2                	ld	s7,56(sp)
 8c0:	7c42                	ld	s8,48(sp)
 8c2:	7ca2                	ld	s9,40(sp)
 8c4:	7d02                	ld	s10,32(sp)
 8c6:	6de2                	ld	s11,24(sp)
 8c8:	6109                	addi	sp,sp,128
 8ca:	8082                	ret

00000000000008cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8cc:	715d                	addi	sp,sp,-80
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	e010                	sd	a2,0(s0)
 8d6:	e414                	sd	a3,8(s0)
 8d8:	e818                	sd	a4,16(s0)
 8da:	ec1c                	sd	a5,24(s0)
 8dc:	03043023          	sd	a6,32(s0)
 8e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e4:	8622                	mv	a2,s0
 8e6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ea:	00000097          	auipc	ra,0x0
 8ee:	e04080e7          	jalr	-508(ra) # 6ee <vprintf>
}
 8f2:	60e2                	ld	ra,24(sp)
 8f4:	6442                	ld	s0,16(sp)
 8f6:	6161                	addi	sp,sp,80
 8f8:	8082                	ret

00000000000008fa <printf>:

void
printf(const char *fmt, ...)
{
 8fa:	711d                	addi	sp,sp,-96
 8fc:	ec06                	sd	ra,24(sp)
 8fe:	e822                	sd	s0,16(sp)
 900:	1000                	addi	s0,sp,32
 902:	e40c                	sd	a1,8(s0)
 904:	e810                	sd	a2,16(s0)
 906:	ec14                	sd	a3,24(s0)
 908:	f018                	sd	a4,32(s0)
 90a:	f41c                	sd	a5,40(s0)
 90c:	03043823          	sd	a6,48(s0)
 910:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 914:	00840613          	addi	a2,s0,8
 918:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91c:	85aa                	mv	a1,a0
 91e:	4505                	li	a0,1
 920:	00000097          	auipc	ra,0x0
 924:	dce080e7          	jalr	-562(ra) # 6ee <vprintf>
}
 928:	60e2                	ld	ra,24(sp)
 92a:	6442                	ld	s0,16(sp)
 92c:	6125                	addi	sp,sp,96
 92e:	8082                	ret

0000000000000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	1141                	addi	sp,sp,-16
 932:	e422                	sd	s0,8(sp)
 934:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 936:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	00000797          	auipc	a5,0x0
 93e:	2267b783          	ld	a5,550(a5) # b60 <freep>
 942:	a02d                	j	96c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 944:	4618                	lw	a4,8(a2)
 946:	9f2d                	addw	a4,a4,a1
 948:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94c:	6398                	ld	a4,0(a5)
 94e:	6310                	ld	a2,0(a4)
 950:	a83d                	j	98e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 952:	ff852703          	lw	a4,-8(a0)
 956:	9f31                	addw	a4,a4,a2
 958:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 95a:	ff053683          	ld	a3,-16(a0)
 95e:	a091                	j	9a2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	6398                	ld	a4,0(a5)
 962:	00e7e463          	bltu	a5,a4,96a <free+0x3a>
 966:	00e6ea63          	bltu	a3,a4,97a <free+0x4a>
{
 96a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96c:	fed7fae3          	bgeu	a5,a3,960 <free+0x30>
 970:	6398                	ld	a4,0(a5)
 972:	00e6e463          	bltu	a3,a4,97a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 976:	fee7eae3          	bltu	a5,a4,96a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 97a:	ff852583          	lw	a1,-8(a0)
 97e:	6390                	ld	a2,0(a5)
 980:	02059813          	slli	a6,a1,0x20
 984:	01c85713          	srli	a4,a6,0x1c
 988:	9736                	add	a4,a4,a3
 98a:	fae60de3          	beq	a2,a4,944 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 98e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 992:	4790                	lw	a2,8(a5)
 994:	02061593          	slli	a1,a2,0x20
 998:	01c5d713          	srli	a4,a1,0x1c
 99c:	973e                	add	a4,a4,a5
 99e:	fae68ae3          	beq	a3,a4,952 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9a2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	1af73e23          	sd	a5,444(a4) # b60 <freep>
}
 9ac:	6422                	ld	s0,8(sp)
 9ae:	0141                	addi	sp,sp,16
 9b0:	8082                	ret

00000000000009b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b2:	7139                	addi	sp,sp,-64
 9b4:	fc06                	sd	ra,56(sp)
 9b6:	f822                	sd	s0,48(sp)
 9b8:	f426                	sd	s1,40(sp)
 9ba:	f04a                	sd	s2,32(sp)
 9bc:	ec4e                	sd	s3,24(sp)
 9be:	e852                	sd	s4,16(sp)
 9c0:	e456                	sd	s5,8(sp)
 9c2:	e05a                	sd	s6,0(sp)
 9c4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c6:	02051493          	slli	s1,a0,0x20
 9ca:	9081                	srli	s1,s1,0x20
 9cc:	04bd                	addi	s1,s1,15
 9ce:	8091                	srli	s1,s1,0x4
 9d0:	00148a1b          	addiw	s4,s1,1
 9d4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9d6:	00000517          	auipc	a0,0x0
 9da:	18a53503          	ld	a0,394(a0) # b60 <freep>
 9de:	c515                	beqz	a0,a0a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e2:	4798                	lw	a4,8(a5)
 9e4:	04977163          	bgeu	a4,s1,a26 <malloc+0x74>
 9e8:	89d2                	mv	s3,s4
 9ea:	000a071b          	sext.w	a4,s4
 9ee:	6685                	lui	a3,0x1
 9f0:	00d77363          	bgeu	a4,a3,9f6 <malloc+0x44>
 9f4:	6985                	lui	s3,0x1
 9f6:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 9fa:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9fe:	00000917          	auipc	s2,0x0
 a02:	16290913          	addi	s2,s2,354 # b60 <freep>
  if(p == (char*)-1)
 a06:	5afd                	li	s5,-1
 a08:	a8a5                	j	a80 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 a0a:	00000797          	auipc	a5,0x0
 a0e:	15678793          	addi	a5,a5,342 # b60 <freep>
 a12:	00000717          	auipc	a4,0x0
 a16:	15670713          	addi	a4,a4,342 # b68 <base>
 a1a:	e398                	sd	a4,0(a5)
 a1c:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 a1e:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a22:	87ba                	mv	a5,a4
 a24:	b7d1                	j	9e8 <malloc+0x36>
      if(p->s.size == nunits)
 a26:	02e48c63          	beq	s1,a4,a5e <malloc+0xac>
        p->s.size -= nunits;
 a2a:	4147073b          	subw	a4,a4,s4
 a2e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a30:	02071693          	slli	a3,a4,0x20
 a34:	01c6d713          	srli	a4,a3,0x1c
 a38:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a3a:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a3e:	00000717          	auipc	a4,0x0
 a42:	12a73123          	sd	a0,290(a4) # b60 <freep>
      return (void*)(p + 1);
 a46:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a4a:	70e2                	ld	ra,56(sp)
 a4c:	7442                	ld	s0,48(sp)
 a4e:	74a2                	ld	s1,40(sp)
 a50:	7902                	ld	s2,32(sp)
 a52:	69e2                	ld	s3,24(sp)
 a54:	6a42                	ld	s4,16(sp)
 a56:	6aa2                	ld	s5,8(sp)
 a58:	6b02                	ld	s6,0(sp)
 a5a:	6121                	addi	sp,sp,64
 a5c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a5e:	6398                	ld	a4,0(a5)
 a60:	e118                	sd	a4,0(a0)
 a62:	bff1                	j	a3e <malloc+0x8c>
  hp->s.size = nu;
 a64:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a68:	0541                	addi	a0,a0,16
 a6a:	00000097          	auipc	ra,0x0
 a6e:	ec6080e7          	jalr	-314(ra) # 930 <free>
  return freep;
 a72:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a76:	d971                	beqz	a0,a4a <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a78:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a7a:	4798                	lw	a4,8(a5)
 a7c:	fa9775e3          	bgeu	a4,s1,a26 <malloc+0x74>
    if(p == freep)
 a80:	00093703          	ld	a4,0(s2)
 a84:	853e                	mv	a0,a5
 a86:	fef719e3          	bne	a4,a5,a78 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a8a:	854e                	mv	a0,s3
 a8c:	00000097          	auipc	ra,0x0
 a90:	95e080e7          	jalr	-1698(ra) # 3ea <sbrk>
  if(p == (char*)-1)
 a94:	fd5518e3          	bne	a0,s5,a64 <malloc+0xb2>
        return 0;
 a98:	4501                	li	a0,0
 a9a:	bf45                	j	a4a <malloc+0x98>
