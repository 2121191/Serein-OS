
serein-user/_ps：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
  char name[NPROC][16];
};

int
main(int argc, char *argv[])
{
   0:	8b010113          	addi	sp,sp,-1872
   4:	74113423          	sd	ra,1864(sp)
   8:	74813023          	sd	s0,1856(sp)
   c:	72913c23          	sd	s1,1848(sp)
  10:	73213823          	sd	s2,1840(sp)
  14:	73313423          	sd	s3,1832(sp)
  18:	73413023          	sd	s4,1824(sp)
  1c:	71513c23          	sd	s5,1816(sp)
  20:	75010413          	addi	s0,sp,1872
  struct pstat ps;
  int i;
  
  if(getpinfo(&ps) < 0) {
  24:	8b840513          	addi	a0,s0,-1864
  28:	00000097          	auipc	ra,0x0
  2c:	434080e7          	jalr	1076(ra) # 45c <getpinfo>
  30:	02054763          	bltz	a0,5e <main+0x5e>
    printf("ps: getpinfo failed\n");
    exit(1);
  }
  
  printf("PID\tTICKETS\tTICKS\tNAME\n");
  34:	00001517          	auipc	a0,0x1
  38:	a6c50513          	addi	a0,a0,-1428 # aa0 <malloc+0x106>
  3c:	00001097          	auipc	ra,0x1
  40:	8a6080e7          	jalr	-1882(ra) # 8e2 <printf>
  for(i = 0; i < NPROC; i++) {
  44:	8b840493          	addi	s1,s0,-1864
  48:	b1040993          	addi	s3,s0,-1264
  4c:	ca040913          	addi	s2,s0,-864
  50:	98040a13          	addi	s4,s0,-1664
    if(ps.inuse[i]) {
      printf("%d\t%d\t%l\t%s\n", 
  54:	00001a97          	auipc	s5,0x1
  58:	a64a8a93          	addi	s5,s5,-1436 # ab8 <malloc+0x11e>
  5c:	a01d                	j	82 <main+0x82>
    printf("ps: getpinfo failed\n");
  5e:	00001517          	auipc	a0,0x1
  62:	a2a50513          	addi	a0,a0,-1494 # a88 <malloc+0xee>
  66:	00001097          	auipc	ra,0x1
  6a:	87c080e7          	jalr	-1924(ra) # 8e2 <printf>
    exit(1);
  6e:	4505                	li	a0,1
  70:	00000097          	auipc	ra,0x0
  74:	2f2080e7          	jalr	754(ra) # 362 <exit>
  for(i = 0; i < NPROC; i++) {
  78:	0491                	addi	s1,s1,4
  7a:	09a1                	addi	s3,s3,8
  7c:	0941                	addi	s2,s2,16
  7e:	03448163          	beq	s1,s4,a0 <main+0xa0>
    if(ps.inuse[i]) {
  82:	409c                	lw	a5,0(s1)
  84:	dbf5                	beqz	a5,78 <main+0x78>
      printf("%d\t%d\t%l\t%s\n", 
  86:	874a                	mv	a4,s2
  88:	0009b683          	ld	a3,0(s3)
  8c:	1904a603          	lw	a2,400(s1)
  90:	0c84a583          	lw	a1,200(s1)
  94:	8556                	mv	a0,s5
  96:	00001097          	auipc	ra,0x1
  9a:	84c080e7          	jalr	-1972(ra) # 8e2 <printf>
  9e:	bfe9                	j	78 <main+0x78>
             ps.runticks[i],
             ps.name[i]);
    }
  }
  
  exit(0);
  a0:	4501                	li	a0,0
  a2:	00000097          	auipc	ra,0x0
  a6:	2c0080e7          	jalr	704(ra) # 362 <exit>

00000000000000aa <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  b0:	87aa                	mv	a5,a0
  b2:	0585                	addi	a1,a1,1
  b4:	0785                	addi	a5,a5,1
  b6:	fff5c703          	lbu	a4,-1(a1)
  ba:	fee78fa3          	sb	a4,-1(a5)
  be:	fb75                	bnez	a4,b2 <strcpy+0x8>
    ;
  return os;
}
  c0:	6422                	ld	s0,8(sp)
  c2:	0141                	addi	sp,sp,16
  c4:	8082                	ret

00000000000000c6 <strcat>:

char*
strcat(char *s, const char *t)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e422                	sd	s0,8(sp)
  ca:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	c385                	beqz	a5,f0 <strcat+0x2a>
  d2:	87aa                	mv	a5,a0
    s++;
  d4:	0785                	addi	a5,a5,1
  while(*s)
  d6:	0007c703          	lbu	a4,0(a5)
  da:	ff6d                	bnez	a4,d4 <strcat+0xe>
  while((*s++ = *t++))
  dc:	0585                	addi	a1,a1,1
  de:	0785                	addi	a5,a5,1
  e0:	fff5c703          	lbu	a4,-1(a1)
  e4:	fee78fa3          	sb	a4,-1(a5)
  e8:	fb75                	bnez	a4,dc <strcat+0x16>
    ;
  return os;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  while(*s)
  f0:	87aa                	mv	a5,a0
  f2:	b7ed                	j	dc <strcat+0x16>

00000000000000f4 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cb91                	beqz	a5,112 <strcmp+0x1e>
 100:	0005c703          	lbu	a4,0(a1)
 104:	00f71763          	bne	a4,a5,112 <strcmp+0x1e>
    p++, q++;
 108:	0505                	addi	a0,a0,1
 10a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 10c:	00054783          	lbu	a5,0(a0)
 110:	fbe5                	bnez	a5,100 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 112:	0005c503          	lbu	a0,0(a1)
}
 116:	40a7853b          	subw	a0,a5,a0
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret

0000000000000120 <strlen>:

uint
strlen(const char *s)
{
 120:	1141                	addi	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cf91                	beqz	a5,146 <strlen+0x26>
 12c:	0505                	addi	a0,a0,1
 12e:	87aa                	mv	a5,a0
 130:	4685                	li	a3,1
 132:	9e89                	subw	a3,a3,a0
 134:	00f6853b          	addw	a0,a3,a5
 138:	0785                	addi	a5,a5,1
 13a:	fff7c703          	lbu	a4,-1(a5)
 13e:	fb7d                	bnez	a4,134 <strlen+0x14>
    ;
  return n;
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret
  for(n = 0; s[n]; n++)
 146:	4501                	li	a0,0
 148:	bfe5                	j	140 <strlen+0x20>

000000000000014a <memset>:

void*
memset(void *dst, int c, uint n)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e422                	sd	s0,8(sp)
 14e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 150:	ca19                	beqz	a2,166 <memset+0x1c>
 152:	87aa                	mv	a5,a0
 154:	1602                	slli	a2,a2,0x20
 156:	9201                	srli	a2,a2,0x20
 158:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 15c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 160:	0785                	addi	a5,a5,1
 162:	fee79de3          	bne	a5,a4,15c <memset+0x12>
  }
  return dst;
}
 166:	6422                	ld	s0,8(sp)
 168:	0141                	addi	sp,sp,16
 16a:	8082                	ret

000000000000016c <strchr>:

char*
strchr(const char *s, char c)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	addi	s0,sp,16
  for(; *s; s++)
 172:	00054783          	lbu	a5,0(a0)
 176:	cb99                	beqz	a5,18c <strchr+0x20>
    if(*s == c)
 178:	00f58763          	beq	a1,a5,186 <strchr+0x1a>
  for(; *s; s++)
 17c:	0505                	addi	a0,a0,1
 17e:	00054783          	lbu	a5,0(a0)
 182:	fbfd                	bnez	a5,178 <strchr+0xc>
      return (char*)s;
  return 0;
 184:	4501                	li	a0,0
}
 186:	6422                	ld	s0,8(sp)
 188:	0141                	addi	sp,sp,16
 18a:	8082                	ret
  return 0;
 18c:	4501                	li	a0,0
 18e:	bfe5                	j	186 <strchr+0x1a>

0000000000000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	711d                	addi	sp,sp,-96
 192:	ec86                	sd	ra,88(sp)
 194:	e8a2                	sd	s0,80(sp)
 196:	e4a6                	sd	s1,72(sp)
 198:	e0ca                	sd	s2,64(sp)
 19a:	fc4e                	sd	s3,56(sp)
 19c:	f852                	sd	s4,48(sp)
 19e:	f456                	sd	s5,40(sp)
 1a0:	f05a                	sd	s6,32(sp)
 1a2:	ec5e                	sd	s7,24(sp)
 1a4:	e862                	sd	s8,16(sp)
 1a6:	1080                	addi	s0,sp,96
 1a8:	8baa                	mv	s7,a0
 1aa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ac:	892a                	mv	s2,a0
 1ae:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1b0:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1b4:	4b29                	li	s6,10
 1b6:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1b8:	89a6                	mv	s3,s1
 1ba:	2485                	addiw	s1,s1,1
 1bc:	0344d763          	bge	s1,s4,1ea <gets+0x5a>
    cc = read(0, &c, 1);
 1c0:	4605                	li	a2,1
 1c2:	85d6                	mv	a1,s5
 1c4:	4501                	li	a0,0
 1c6:	00000097          	auipc	ra,0x0
 1ca:	1b4080e7          	jalr	436(ra) # 37a <read>
    if(cc < 1)
 1ce:	00a05e63          	blez	a0,1ea <gets+0x5a>
    buf[i++] = c;
 1d2:	faf44783          	lbu	a5,-81(s0)
 1d6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1da:	01678763          	beq	a5,s6,1e8 <gets+0x58>
 1de:	0905                	addi	s2,s2,1
 1e0:	fd879ce3          	bne	a5,s8,1b8 <gets+0x28>
  for(i=0; i+1 < max; ){
 1e4:	89a6                	mv	s3,s1
 1e6:	a011                	j	1ea <gets+0x5a>
 1e8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1ea:	99de                	add	s3,s3,s7
 1ec:	00098023          	sb	zero,0(s3)
  return buf;
}
 1f0:	855e                	mv	a0,s7
 1f2:	60e6                	ld	ra,88(sp)
 1f4:	6446                	ld	s0,80(sp)
 1f6:	64a6                	ld	s1,72(sp)
 1f8:	6906                	ld	s2,64(sp)
 1fa:	79e2                	ld	s3,56(sp)
 1fc:	7a42                	ld	s4,48(sp)
 1fe:	7aa2                	ld	s5,40(sp)
 200:	7b02                	ld	s6,32(sp)
 202:	6be2                	ld	s7,24(sp)
 204:	6c42                	ld	s8,16(sp)
 206:	6125                	addi	sp,sp,96
 208:	8082                	ret

000000000000020a <stat>:

int
stat(const char *n, struct stat *st)
{
 20a:	1101                	addi	sp,sp,-32
 20c:	ec06                	sd	ra,24(sp)
 20e:	e822                	sd	s0,16(sp)
 210:	e426                	sd	s1,8(sp)
 212:	e04a                	sd	s2,0(sp)
 214:	1000                	addi	s0,sp,32
 216:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 218:	4581                	li	a1,0
 21a:	00000097          	auipc	ra,0x0
 21e:	188080e7          	jalr	392(ra) # 3a2 <open>
  if(fd < 0)
 222:	02054563          	bltz	a0,24c <stat+0x42>
 226:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 228:	85ca                	mv	a1,s2
 22a:	00000097          	auipc	ra,0x0
 22e:	180080e7          	jalr	384(ra) # 3aa <fstat>
 232:	892a                	mv	s2,a0
  close(fd);
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	154080e7          	jalr	340(ra) # 38a <close>
  return r;
}
 23e:	854a                	mv	a0,s2
 240:	60e2                	ld	ra,24(sp)
 242:	6442                	ld	s0,16(sp)
 244:	64a2                	ld	s1,8(sp)
 246:	6902                	ld	s2,0(sp)
 248:	6105                	addi	sp,sp,32
 24a:	8082                	ret
    return -1;
 24c:	597d                	li	s2,-1
 24e:	bfc5                	j	23e <stat+0x34>

0000000000000250 <atoi>:

int
atoi(const char *s)
{
 250:	1141                	addi	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 256:	00054703          	lbu	a4,0(a0)
 25a:	02d00793          	li	a5,45
  int neg = 1;
 25e:	4585                	li	a1,1
  if (*s == '-') {
 260:	04f70363          	beq	a4,a5,2a6 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 264:	00054703          	lbu	a4,0(a0)
 268:	fd07079b          	addiw	a5,a4,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	46a5                	li	a3,9
 272:	02f6ed63          	bltu	a3,a5,2ac <atoi+0x5c>
  n = 0;
 276:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 278:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 27a:	0505                	addi	a0,a0,1
 27c:	0026979b          	slliw	a5,a3,0x2
 280:	9fb5                	addw	a5,a5,a3
 282:	0017979b          	slliw	a5,a5,0x1
 286:	9fb9                	addw	a5,a5,a4
 288:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 28c:	00054703          	lbu	a4,0(a0)
 290:	fd07079b          	addiw	a5,a4,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	fef671e3          	bgeu	a2,a5,27a <atoi+0x2a>
  return n * neg;
}
 29c:	02d5853b          	mulw	a0,a1,a3
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
    s++;
 2a6:	0505                	addi	a0,a0,1
    neg = -1;
 2a8:	55fd                	li	a1,-1
 2aa:	bf6d                	j	264 <atoi+0x14>
  n = 0;
 2ac:	4681                	li	a3,0
 2ae:	b7fd                	j	29c <atoi+0x4c>

00000000000002b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b0:	1141                	addi	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b6:	02b57463          	bgeu	a0,a1,2de <memmove+0x2e>
    while(n-- > 0)
 2ba:	00c05f63          	blez	a2,2d8 <memmove+0x28>
 2be:	1602                	slli	a2,a2,0x20
 2c0:	9201                	srli	a2,a2,0x20
 2c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c8:	0585                	addi	a1,a1,1
 2ca:	0705                	addi	a4,a4,1
 2cc:	fff5c683          	lbu	a3,-1(a1)
 2d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d4:	fee79ae3          	bne	a5,a4,2c8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
    dst += n;
 2de:	00c50733          	add	a4,a0,a2
    src += n;
 2e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2e4:	fec05ae3          	blez	a2,2d8 <memmove+0x28>
 2e8:	fff6079b          	addiw	a5,a2,-1
 2ec:	1782                	slli	a5,a5,0x20
 2ee:	9381                	srli	a5,a5,0x20
 2f0:	fff7c793          	not	a5,a5
 2f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f6:	15fd                	addi	a1,a1,-1
 2f8:	177d                	addi	a4,a4,-1
 2fa:	0005c683          	lbu	a3,0(a1)
 2fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 302:	fee79ae3          	bne	a5,a4,2f6 <memmove+0x46>
 306:	bfc9                	j	2d8 <memmove+0x28>

0000000000000308 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30e:	ca05                	beqz	a2,33e <memcmp+0x36>
 310:	fff6069b          	addiw	a3,a2,-1
 314:	1682                	slli	a3,a3,0x20
 316:	9281                	srli	a3,a3,0x20
 318:	0685                	addi	a3,a3,1
 31a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 31c:	00054783          	lbu	a5,0(a0)
 320:	0005c703          	lbu	a4,0(a1)
 324:	00e79863          	bne	a5,a4,334 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 328:	0505                	addi	a0,a0,1
    p2++;
 32a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 32c:	fed518e3          	bne	a0,a3,31c <memcmp+0x14>
  }
  return 0;
 330:	4501                	li	a0,0
 332:	a019                	j	338 <memcmp+0x30>
      return *p1 - *p2;
 334:	40e7853b          	subw	a0,a5,a4
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret
  return 0;
 33e:	4501                	li	a0,0
 340:	bfe5                	j	338 <memcmp+0x30>

0000000000000342 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 342:	1141                	addi	sp,sp,-16
 344:	e406                	sd	ra,8(sp)
 346:	e022                	sd	s0,0(sp)
 348:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 34a:	00000097          	auipc	ra,0x0
 34e:	f66080e7          	jalr	-154(ra) # 2b0 <memmove>
}
 352:	60a2                	ld	ra,8(sp)
 354:	6402                	ld	s0,0(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret

000000000000035a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 35a:	4885                	li	a7,1
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <exit>:
.global exit
exit:
 li a7, SYS_exit
 362:	4889                	li	a7,2
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <wait>:
.global wait
wait:
 li a7, SYS_wait
 36a:	488d                	li	a7,3
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 372:	4891                	li	a7,4
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <read>:
.global read
read:
 li a7, SYS_read
 37a:	4895                	li	a7,5
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <write>:
.global write
write:
 li a7, SYS_write
 382:	48c1                	li	a7,16
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <close>:
.global close
close:
 li a7, SYS_close
 38a:	48d5                	li	a7,21
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <kill>:
.global kill
kill:
 li a7, SYS_kill
 392:	4899                	li	a7,6
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <exec>:
.global exec
exec:
 li a7, SYS_exec
 39a:	489d                	li	a7,7
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <open>:
.global open
open:
 li a7, SYS_open
 3a2:	48bd                	li	a7,15
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3aa:	48a1                	li	a7,8
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3b2:	48d1                	li	a7,20
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ba:	48a5                	li	a7,9
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3c2:	48a9                	li	a7,10
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ca:	48ad                	li	a7,11
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3d2:	48b1                	li	a7,12
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3da:	48b5                	li	a7,13
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3e2:	48b9                	li	a7,14
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3ea:	48d9                	li	a7,22
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3f2:	48dd                	li	a7,23
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3fa:	48e1                	li	a7,24
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 402:	48e5                	li	a7,25
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <remove>:
.global remove
remove:
 li a7, SYS_remove
 40a:	48c5                	li	a7,17
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <trace>:
.global trace
trace:
 li a7, SYS_trace
 412:	48c9                	li	a7,18
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 41a:	48cd                	li	a7,19
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <rename>:
.global rename
rename:
 li a7, SYS_rename
 422:	48e9                	li	a7,26
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 42a:	48ed                	li	a7,27
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 432:	48f1                	li	a7,28
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 43a:	48f5                	li	a7,29
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 442:	48f9                	li	a7,30
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 44a:	48fd                	li	a7,31
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 452:	02000893          	li	a7,32
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 45c:	02100893          	li	a7,33
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 466:	02200893          	li	a7,34
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 470:	02300893          	li	a7,35
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 47a:	02400893          	li	a7,36
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 484:	02500893          	li	a7,37
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 48e:	02600893          	li	a7,38
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 498:	02700893          	li	a7,39
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 4a2:	02800893          	li	a7,40
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 4ac:	02900893          	li	a7,41
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 4b6:	02a00893          	li	a7,42
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 4c0:	02b00893          	li	a7,43
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 4ca:	02c00893          	li	a7,44
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4d4:	02d00893          	li	a7,45
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4de:	02e00893          	li	a7,46
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4e8:	02f00893          	li	a7,47
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 4f2:	03000893          	li	a7,48
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 4fc:	03100893          	li	a7,49
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 506:	03200893          	li	a7,50
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 510:	03300893          	li	a7,51
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 51a:	03400893          	li	a7,52
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 524:	03500893          	li	a7,53
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 52e:	03600893          	li	a7,54
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 538:	03700893          	li	a7,55
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 542:	03800893          	li	a7,56
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 54c:	03900893          	li	a7,57
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 556:	03a00893          	li	a7,58
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <poll>:
.global poll
poll:
 li a7, SYS_poll
 560:	03b00893          	li	a7,59
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 56a:	03c00893          	li	a7,60
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 574:	03d00893          	li	a7,61
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 57e:	03e00893          	li	a7,62
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <clone>:
.global clone
clone:
 li a7, SYS_clone
 588:	03f00893          	li	a7,63
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <futex>:
.global futex
futex:
 li a7, SYS_futex
 592:	04000893          	li	a7,64
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 59c:	04100893          	li	a7,65
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <halt>:
.global halt
halt:
 li a7, SYS_halt
 5a6:	04200893          	li	a7,66
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 5b0:	04300893          	li	a7,67
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <socket>:
.global socket
socket:
 li a7, SYS_socket
 5ba:	04400893          	li	a7,68
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5c4:	04500893          	li	a7,69
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <listen>:
.global listen
listen:
 li a7, SYS_listen
 5ce:	04600893          	li	a7,70
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5d8:	04700893          	li	a7,71
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5e2:	04800893          	li	a7,72
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <send>:
.global send
send:
 li a7, SYS_send
 5ec:	04900893          	li	a7,73
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5f6:	04a00893          	li	a7,74
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 600:	04b00893          	li	a7,75
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 60a:	1101                	addi	sp,sp,-32
 60c:	ec06                	sd	ra,24(sp)
 60e:	e822                	sd	s0,16(sp)
 610:	1000                	addi	s0,sp,32
 612:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 616:	4605                	li	a2,1
 618:	fef40593          	addi	a1,s0,-17
 61c:	00000097          	auipc	ra,0x0
 620:	d66080e7          	jalr	-666(ra) # 382 <write>
}
 624:	60e2                	ld	ra,24(sp)
 626:	6442                	ld	s0,16(sp)
 628:	6105                	addi	sp,sp,32
 62a:	8082                	ret

000000000000062c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 62c:	7139                	addi	sp,sp,-64
 62e:	fc06                	sd	ra,56(sp)
 630:	f822                	sd	s0,48(sp)
 632:	f426                	sd	s1,40(sp)
 634:	f04a                	sd	s2,32(sp)
 636:	ec4e                	sd	s3,24(sp)
 638:	0080                	addi	s0,sp,64
 63a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 63c:	c299                	beqz	a3,642 <printint+0x16>
 63e:	0805c863          	bltz	a1,6ce <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 642:	2581                	sext.w	a1,a1
  neg = 0;
 644:	4881                	li	a7,0
  }

  i = 0;
 646:	fc040993          	addi	s3,s0,-64
  neg = 0;
 64a:	86ce                	mv	a3,s3
  i = 0;
 64c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 64e:	2601                	sext.w	a2,a2
 650:	00000517          	auipc	a0,0x0
 654:	4d850513          	addi	a0,a0,1240 # b28 <digits>
 658:	883a                	mv	a6,a4
 65a:	2705                	addiw	a4,a4,1
 65c:	02c5f7bb          	remuw	a5,a1,a2
 660:	1782                	slli	a5,a5,0x20
 662:	9381                	srli	a5,a5,0x20
 664:	97aa                	add	a5,a5,a0
 666:	0007c783          	lbu	a5,0(a5)
 66a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 66e:	0005879b          	sext.w	a5,a1
 672:	02c5d5bb          	divuw	a1,a1,a2
 676:	0685                	addi	a3,a3,1
 678:	fec7f0e3          	bgeu	a5,a2,658 <printint+0x2c>
  if(neg)
 67c:	00088c63          	beqz	a7,694 <printint+0x68>
    buf[i++] = '-';
 680:	fd070793          	addi	a5,a4,-48
 684:	00878733          	add	a4,a5,s0
 688:	02d00793          	li	a5,45
 68c:	fef70823          	sb	a5,-16(a4)
 690:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 694:	02e05663          	blez	a4,6c0 <printint+0x94>
 698:	fc040913          	addi	s2,s0,-64
 69c:	993a                	add	s2,s2,a4
 69e:	19fd                	addi	s3,s3,-1
 6a0:	99ba                	add	s3,s3,a4
 6a2:	377d                	addiw	a4,a4,-1
 6a4:	1702                	slli	a4,a4,0x20
 6a6:	9301                	srli	a4,a4,0x20
 6a8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ac:	fff94583          	lbu	a1,-1(s2)
 6b0:	8526                	mv	a0,s1
 6b2:	00000097          	auipc	ra,0x0
 6b6:	f58080e7          	jalr	-168(ra) # 60a <putc>
  while(--i >= 0)
 6ba:	197d                	addi	s2,s2,-1
 6bc:	ff3918e3          	bne	s2,s3,6ac <printint+0x80>
}
 6c0:	70e2                	ld	ra,56(sp)
 6c2:	7442                	ld	s0,48(sp)
 6c4:	74a2                	ld	s1,40(sp)
 6c6:	7902                	ld	s2,32(sp)
 6c8:	69e2                	ld	s3,24(sp)
 6ca:	6121                	addi	sp,sp,64
 6cc:	8082                	ret
    x = -xx;
 6ce:	40b005bb          	negw	a1,a1
    neg = 1;
 6d2:	4885                	li	a7,1
    x = -xx;
 6d4:	bf8d                	j	646 <printint+0x1a>

00000000000006d6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6d6:	7119                	addi	sp,sp,-128
 6d8:	fc86                	sd	ra,120(sp)
 6da:	f8a2                	sd	s0,112(sp)
 6dc:	f4a6                	sd	s1,104(sp)
 6de:	f0ca                	sd	s2,96(sp)
 6e0:	ecce                	sd	s3,88(sp)
 6e2:	e8d2                	sd	s4,80(sp)
 6e4:	e4d6                	sd	s5,72(sp)
 6e6:	e0da                	sd	s6,64(sp)
 6e8:	fc5e                	sd	s7,56(sp)
 6ea:	f862                	sd	s8,48(sp)
 6ec:	f466                	sd	s9,40(sp)
 6ee:	f06a                	sd	s10,32(sp)
 6f0:	ec6e                	sd	s11,24(sp)
 6f2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6f4:	0005c903          	lbu	s2,0(a1)
 6f8:	18090f63          	beqz	s2,896 <vprintf+0x1c0>
 6fc:	8aaa                	mv	s5,a0
 6fe:	8b32                	mv	s6,a2
 700:	00158493          	addi	s1,a1,1
  state = 0;
 704:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 706:	02500a13          	li	s4,37
 70a:	4c55                	li	s8,21
 70c:	00000c97          	auipc	s9,0x0
 710:	3c4c8c93          	addi	s9,s9,964 # ad0 <malloc+0x136>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 714:	02800d93          	li	s11,40
  putc(fd, 'x');
 718:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71a:	00000b97          	auipc	s7,0x0
 71e:	40eb8b93          	addi	s7,s7,1038 # b28 <digits>
 722:	a839                	j	740 <vprintf+0x6a>
        putc(fd, c);
 724:	85ca                	mv	a1,s2
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	ee2080e7          	jalr	-286(ra) # 60a <putc>
 730:	a019                	j	736 <vprintf+0x60>
    } else if(state == '%'){
 732:	01498d63          	beq	s3,s4,74c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 736:	0485                	addi	s1,s1,1
 738:	fff4c903          	lbu	s2,-1(s1)
 73c:	14090d63          	beqz	s2,896 <vprintf+0x1c0>
    if(state == 0){
 740:	fe0999e3          	bnez	s3,732 <vprintf+0x5c>
      if(c == '%'){
 744:	ff4910e3          	bne	s2,s4,724 <vprintf+0x4e>
        state = '%';
 748:	89d2                	mv	s3,s4
 74a:	b7f5                	j	736 <vprintf+0x60>
      if(c == 'd'){
 74c:	11490c63          	beq	s2,s4,864 <vprintf+0x18e>
 750:	f9d9079b          	addiw	a5,s2,-99
 754:	0ff7f793          	zext.b	a5,a5
 758:	10fc6e63          	bltu	s8,a5,874 <vprintf+0x19e>
 75c:	f9d9079b          	addiw	a5,s2,-99
 760:	0ff7f713          	zext.b	a4,a5
 764:	10ec6863          	bltu	s8,a4,874 <vprintf+0x19e>
 768:	00271793          	slli	a5,a4,0x2
 76c:	97e6                	add	a5,a5,s9
 76e:	439c                	lw	a5,0(a5)
 770:	97e6                	add	a5,a5,s9
 772:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 774:	008b0913          	addi	s2,s6,8
 778:	4685                	li	a3,1
 77a:	4629                	li	a2,10
 77c:	000b2583          	lw	a1,0(s6)
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	eaa080e7          	jalr	-342(ra) # 62c <printint>
 78a:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 78c:	4981                	li	s3,0
 78e:	b765                	j	736 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 790:	008b0913          	addi	s2,s6,8
 794:	4681                	li	a3,0
 796:	4629                	li	a2,10
 798:	000b2583          	lw	a1,0(s6)
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	e8e080e7          	jalr	-370(ra) # 62c <printint>
 7a6:	8b4a                	mv	s6,s2
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b771                	j	736 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7ac:	008b0913          	addi	s2,s6,8
 7b0:	4681                	li	a3,0
 7b2:	866a                	mv	a2,s10
 7b4:	000b2583          	lw	a1,0(s6)
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e72080e7          	jalr	-398(ra) # 62c <printint>
 7c2:	8b4a                	mv	s6,s2
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	bf85                	j	736 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7c8:	008b0793          	addi	a5,s6,8
 7cc:	f8f43423          	sd	a5,-120(s0)
 7d0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7d4:	03000593          	li	a1,48
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	e30080e7          	jalr	-464(ra) # 60a <putc>
  putc(fd, 'x');
 7e2:	07800593          	li	a1,120
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	e22080e7          	jalr	-478(ra) # 60a <putc>
 7f0:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7f2:	03c9d793          	srli	a5,s3,0x3c
 7f6:	97de                	add	a5,a5,s7
 7f8:	0007c583          	lbu	a1,0(a5)
 7fc:	8556                	mv	a0,s5
 7fe:	00000097          	auipc	ra,0x0
 802:	e0c080e7          	jalr	-500(ra) # 60a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 806:	0992                	slli	s3,s3,0x4
 808:	397d                	addiw	s2,s2,-1
 80a:	fe0914e3          	bnez	s2,7f2 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 80e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 812:	4981                	li	s3,0
 814:	b70d                	j	736 <vprintf+0x60>
        s = va_arg(ap, char*);
 816:	008b0913          	addi	s2,s6,8
 81a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 81e:	02098163          	beqz	s3,840 <vprintf+0x16a>
        while(*s != 0){
 822:	0009c583          	lbu	a1,0(s3)
 826:	c5ad                	beqz	a1,890 <vprintf+0x1ba>
          putc(fd, *s);
 828:	8556                	mv	a0,s5
 82a:	00000097          	auipc	ra,0x0
 82e:	de0080e7          	jalr	-544(ra) # 60a <putc>
          s++;
 832:	0985                	addi	s3,s3,1
        while(*s != 0){
 834:	0009c583          	lbu	a1,0(s3)
 838:	f9e5                	bnez	a1,828 <vprintf+0x152>
        s = va_arg(ap, char*);
 83a:	8b4a                	mv	s6,s2
      state = 0;
 83c:	4981                	li	s3,0
 83e:	bde5                	j	736 <vprintf+0x60>
          s = "(null)";
 840:	00000997          	auipc	s3,0x0
 844:	28898993          	addi	s3,s3,648 # ac8 <malloc+0x12e>
        while(*s != 0){
 848:	85ee                	mv	a1,s11
 84a:	bff9                	j	828 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 84c:	008b0913          	addi	s2,s6,8
 850:	000b4583          	lbu	a1,0(s6)
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	db4080e7          	jalr	-588(ra) # 60a <putc>
 85e:	8b4a                	mv	s6,s2
      state = 0;
 860:	4981                	li	s3,0
 862:	bdd1                	j	736 <vprintf+0x60>
        putc(fd, c);
 864:	85d2                	mv	a1,s4
 866:	8556                	mv	a0,s5
 868:	00000097          	auipc	ra,0x0
 86c:	da2080e7          	jalr	-606(ra) # 60a <putc>
      state = 0;
 870:	4981                	li	s3,0
 872:	b5d1                	j	736 <vprintf+0x60>
        putc(fd, '%');
 874:	85d2                	mv	a1,s4
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	d92080e7          	jalr	-622(ra) # 60a <putc>
        putc(fd, c);
 880:	85ca                	mv	a1,s2
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	d86080e7          	jalr	-634(ra) # 60a <putc>
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b565                	j	736 <vprintf+0x60>
        s = va_arg(ap, char*);
 890:	8b4a                	mv	s6,s2
      state = 0;
 892:	4981                	li	s3,0
 894:	b54d                	j	736 <vprintf+0x60>
    }
  }
}
 896:	70e6                	ld	ra,120(sp)
 898:	7446                	ld	s0,112(sp)
 89a:	74a6                	ld	s1,104(sp)
 89c:	7906                	ld	s2,96(sp)
 89e:	69e6                	ld	s3,88(sp)
 8a0:	6a46                	ld	s4,80(sp)
 8a2:	6aa6                	ld	s5,72(sp)
 8a4:	6b06                	ld	s6,64(sp)
 8a6:	7be2                	ld	s7,56(sp)
 8a8:	7c42                	ld	s8,48(sp)
 8aa:	7ca2                	ld	s9,40(sp)
 8ac:	7d02                	ld	s10,32(sp)
 8ae:	6de2                	ld	s11,24(sp)
 8b0:	6109                	addi	sp,sp,128
 8b2:	8082                	ret

00000000000008b4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8b4:	715d                	addi	sp,sp,-80
 8b6:	ec06                	sd	ra,24(sp)
 8b8:	e822                	sd	s0,16(sp)
 8ba:	1000                	addi	s0,sp,32
 8bc:	e010                	sd	a2,0(s0)
 8be:	e414                	sd	a3,8(s0)
 8c0:	e818                	sd	a4,16(s0)
 8c2:	ec1c                	sd	a5,24(s0)
 8c4:	03043023          	sd	a6,32(s0)
 8c8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8cc:	8622                	mv	a2,s0
 8ce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8d2:	00000097          	auipc	ra,0x0
 8d6:	e04080e7          	jalr	-508(ra) # 6d6 <vprintf>
}
 8da:	60e2                	ld	ra,24(sp)
 8dc:	6442                	ld	s0,16(sp)
 8de:	6161                	addi	sp,sp,80
 8e0:	8082                	ret

00000000000008e2 <printf>:

void
printf(const char *fmt, ...)
{
 8e2:	711d                	addi	sp,sp,-96
 8e4:	ec06                	sd	ra,24(sp)
 8e6:	e822                	sd	s0,16(sp)
 8e8:	1000                	addi	s0,sp,32
 8ea:	e40c                	sd	a1,8(s0)
 8ec:	e810                	sd	a2,16(s0)
 8ee:	ec14                	sd	a3,24(s0)
 8f0:	f018                	sd	a4,32(s0)
 8f2:	f41c                	sd	a5,40(s0)
 8f4:	03043823          	sd	a6,48(s0)
 8f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8fc:	00840613          	addi	a2,s0,8
 900:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 904:	85aa                	mv	a1,a0
 906:	4505                	li	a0,1
 908:	00000097          	auipc	ra,0x0
 90c:	dce080e7          	jalr	-562(ra) # 6d6 <vprintf>
}
 910:	60e2                	ld	ra,24(sp)
 912:	6442                	ld	s0,16(sp)
 914:	6125                	addi	sp,sp,96
 916:	8082                	ret

0000000000000918 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 918:	1141                	addi	sp,sp,-16
 91a:	e422                	sd	s0,8(sp)
 91c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 91e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 922:	00000797          	auipc	a5,0x0
 926:	21e7b783          	ld	a5,542(a5) # b40 <freep>
 92a:	a02d                	j	954 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 92c:	4618                	lw	a4,8(a2)
 92e:	9f2d                	addw	a4,a4,a1
 930:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 934:	6398                	ld	a4,0(a5)
 936:	6310                	ld	a2,0(a4)
 938:	a83d                	j	976 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 93a:	ff852703          	lw	a4,-8(a0)
 93e:	9f31                	addw	a4,a4,a2
 940:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 942:	ff053683          	ld	a3,-16(a0)
 946:	a091                	j	98a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 948:	6398                	ld	a4,0(a5)
 94a:	00e7e463          	bltu	a5,a4,952 <free+0x3a>
 94e:	00e6ea63          	bltu	a3,a4,962 <free+0x4a>
{
 952:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 954:	fed7fae3          	bgeu	a5,a3,948 <free+0x30>
 958:	6398                	ld	a4,0(a5)
 95a:	00e6e463          	bltu	a3,a4,962 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95e:	fee7eae3          	bltu	a5,a4,952 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 962:	ff852583          	lw	a1,-8(a0)
 966:	6390                	ld	a2,0(a5)
 968:	02059813          	slli	a6,a1,0x20
 96c:	01c85713          	srli	a4,a6,0x1c
 970:	9736                	add	a4,a4,a3
 972:	fae60de3          	beq	a2,a4,92c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 976:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 97a:	4790                	lw	a2,8(a5)
 97c:	02061593          	slli	a1,a2,0x20
 980:	01c5d713          	srli	a4,a1,0x1c
 984:	973e                	add	a4,a4,a5
 986:	fae68ae3          	beq	a3,a4,93a <free+0x22>
    p->s.ptr = bp->s.ptr;
 98a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 98c:	00000717          	auipc	a4,0x0
 990:	1af73a23          	sd	a5,436(a4) # b40 <freep>
}
 994:	6422                	ld	s0,8(sp)
 996:	0141                	addi	sp,sp,16
 998:	8082                	ret

000000000000099a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 99a:	7139                	addi	sp,sp,-64
 99c:	fc06                	sd	ra,56(sp)
 99e:	f822                	sd	s0,48(sp)
 9a0:	f426                	sd	s1,40(sp)
 9a2:	f04a                	sd	s2,32(sp)
 9a4:	ec4e                	sd	s3,24(sp)
 9a6:	e852                	sd	s4,16(sp)
 9a8:	e456                	sd	s5,8(sp)
 9aa:	e05a                	sd	s6,0(sp)
 9ac:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ae:	02051493          	slli	s1,a0,0x20
 9b2:	9081                	srli	s1,s1,0x20
 9b4:	04bd                	addi	s1,s1,15
 9b6:	8091                	srli	s1,s1,0x4
 9b8:	00148a1b          	addiw	s4,s1,1
 9bc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9be:	00000517          	auipc	a0,0x0
 9c2:	18253503          	ld	a0,386(a0) # b40 <freep>
 9c6:	c515                	beqz	a0,9f2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ca:	4798                	lw	a4,8(a5)
 9cc:	04977163          	bgeu	a4,s1,a0e <malloc+0x74>
 9d0:	89d2                	mv	s3,s4
 9d2:	000a071b          	sext.w	a4,s4
 9d6:	6685                	lui	a3,0x1
 9d8:	00d77363          	bgeu	a4,a3,9de <malloc+0x44>
 9dc:	6985                	lui	s3,0x1
 9de:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 9e2:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9e6:	00000917          	auipc	s2,0x0
 9ea:	15a90913          	addi	s2,s2,346 # b40 <freep>
  if(p == (char*)-1)
 9ee:	5afd                	li	s5,-1
 9f0:	a8a5                	j	a68 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 9f2:	00000797          	auipc	a5,0x0
 9f6:	14e78793          	addi	a5,a5,334 # b40 <freep>
 9fa:	00000717          	auipc	a4,0x0
 9fe:	14e70713          	addi	a4,a4,334 # b48 <base>
 a02:	e398                	sd	a4,0(a5)
 a04:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 a06:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0a:	87ba                	mv	a5,a4
 a0c:	b7d1                	j	9d0 <malloc+0x36>
      if(p->s.size == nunits)
 a0e:	02e48c63          	beq	s1,a4,a46 <malloc+0xac>
        p->s.size -= nunits;
 a12:	4147073b          	subw	a4,a4,s4
 a16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a18:	02071693          	slli	a3,a4,0x20
 a1c:	01c6d713          	srli	a4,a3,0x1c
 a20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a22:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a26:	00000717          	auipc	a4,0x0
 a2a:	10a73d23          	sd	a0,282(a4) # b40 <freep>
      return (void*)(p + 1);
 a2e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a32:	70e2                	ld	ra,56(sp)
 a34:	7442                	ld	s0,48(sp)
 a36:	74a2                	ld	s1,40(sp)
 a38:	7902                	ld	s2,32(sp)
 a3a:	69e2                	ld	s3,24(sp)
 a3c:	6a42                	ld	s4,16(sp)
 a3e:	6aa2                	ld	s5,8(sp)
 a40:	6b02                	ld	s6,0(sp)
 a42:	6121                	addi	sp,sp,64
 a44:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a46:	6398                	ld	a4,0(a5)
 a48:	e118                	sd	a4,0(a0)
 a4a:	bff1                	j	a26 <malloc+0x8c>
  hp->s.size = nu;
 a4c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a50:	0541                	addi	a0,a0,16
 a52:	00000097          	auipc	ra,0x0
 a56:	ec6080e7          	jalr	-314(ra) # 918 <free>
  return freep;
 a5a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a5e:	d971                	beqz	a0,a32 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a60:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a62:	4798                	lw	a4,8(a5)
 a64:	fa9775e3          	bgeu	a4,s1,a0e <malloc+0x74>
    if(p == freep)
 a68:	00093703          	ld	a4,0(s2)
 a6c:	853e                	mv	a0,a5
 a6e:	fef719e3          	bne	a4,a5,a60 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a72:	854e                	mv	a0,s3
 a74:	00000097          	auipc	ra,0x0
 a78:	95e080e7          	jalr	-1698(ra) # 3d2 <sbrk>
  if(p == (char*)-1)
 a7c:	fd5518e3          	bne	a0,s5,a4c <malloc+0xb2>
        return 0;
 a80:	4501                	li	a0,0
 a82:	bf45                	j	a32 <malloc+0x98>
