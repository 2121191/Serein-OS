
serein-user/_kallocstat：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	0100                	addi	s0,sp,128
  struct sysinfo info;
  if(sysinfo(&info) < 0){
   8:	f8840513          	addi	a0,s0,-120
   c:	00000097          	auipc	ra,0x0
  10:	404080e7          	jalr	1028(ra) # 410 <sysinfo>
  14:	06054963          	bltz	a0,86 <main+0x86>
  printf("freemem=%d bytes, nproc=%d\n", (int)info->freemem, (int)info->nproc);
  18:	f9042603          	lw	a2,-112(s0)
  1c:	f8842583          	lw	a1,-120(s0)
  20:	00001517          	auipc	a0,0x1
  24:	a8050513          	addi	a0,a0,-1408 # aa0 <malloc+0x110>
  28:	00001097          	auipc	ra,0x1
  2c:	8b0080e7          	jalr	-1872(ra) # 8d8 <printf>
  printf("per-cpu kalloc stats:\n");
  30:	00001517          	auipc	a0,0x1
  34:	a9050513          	addi	a0,a0,-1392 # ac0 <malloc+0x130>
  38:	00001097          	auipc	ra,0x1
  3c:	8a0080e7          	jalr	-1888(ra) # 8d8 <printf>
    printf("  cpu%d: alloc=%d free=%d steal=%d\n",
  40:	fc842703          	lw	a4,-56(s0)
  44:	fc042683          	lw	a3,-64(s0)
  48:	fb842603          	lw	a2,-72(s0)
  4c:	4581                	li	a1,0
  4e:	00001517          	auipc	a0,0x1
  52:	a8a50513          	addi	a0,a0,-1398 # ad8 <malloc+0x148>
  56:	00001097          	auipc	ra,0x1
  5a:	882080e7          	jalr	-1918(ra) # 8d8 <printf>
  5e:	fe042703          	lw	a4,-32(s0)
  62:	fd842683          	lw	a3,-40(s0)
  66:	fd042603          	lw	a2,-48(s0)
  6a:	4585                	li	a1,1
  6c:	00001517          	auipc	a0,0x1
  70:	a6c50513          	addi	a0,a0,-1428 # ad8 <malloc+0x148>
  74:	00001097          	auipc	ra,0x1
  78:	864080e7          	jalr	-1948(ra) # 8d8 <printf>
    printf("kallocstat: sysinfo failed\n");
    exit(1);
  }
  print_kalloc_stats(&info);
  exit(0);
  7c:	4501                	li	a0,0
  7e:	00000097          	auipc	ra,0x0
  82:	2da080e7          	jalr	730(ra) # 358 <exit>
    printf("kallocstat: sysinfo failed\n");
  86:	00001517          	auipc	a0,0x1
  8a:	9fa50513          	addi	a0,a0,-1542 # a80 <malloc+0xf0>
  8e:	00001097          	auipc	ra,0x1
  92:	84a080e7          	jalr	-1974(ra) # 8d8 <printf>
    exit(1);
  96:	4505                	li	a0,1
  98:	00000097          	auipc	ra,0x0
  9c:	2c0080e7          	jalr	704(ra) # 358 <exit>

00000000000000a0 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a6:	87aa                	mv	a5,a0
  a8:	0585                	addi	a1,a1,1
  aa:	0785                	addi	a5,a5,1
  ac:	fff5c703          	lbu	a4,-1(a1)
  b0:	fee78fa3          	sb	a4,-1(a5)
  b4:	fb75                	bnez	a4,a8 <strcpy+0x8>
    ;
  return os;
}
  b6:	6422                	ld	s0,8(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret

00000000000000bc <strcat>:

char*
strcat(char *s, const char *t)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e422                	sd	s0,8(sp)
  c0:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  c2:	00054783          	lbu	a5,0(a0)
  c6:	c385                	beqz	a5,e6 <strcat+0x2a>
  c8:	87aa                	mv	a5,a0
    s++;
  ca:	0785                	addi	a5,a5,1
  while(*s)
  cc:	0007c703          	lbu	a4,0(a5)
  d0:	ff6d                	bnez	a4,ca <strcat+0xe>
  while((*s++ = *t++))
  d2:	0585                	addi	a1,a1,1
  d4:	0785                	addi	a5,a5,1
  d6:	fff5c703          	lbu	a4,-1(a1)
  da:	fee78fa3          	sb	a4,-1(a5)
  de:	fb75                	bnez	a4,d2 <strcat+0x16>
    ;
  return os;
}
  e0:	6422                	ld	s0,8(sp)
  e2:	0141                	addi	sp,sp,16
  e4:	8082                	ret
  while(*s)
  e6:	87aa                	mv	a5,a0
  e8:	b7ed                	j	d2 <strcat+0x16>

00000000000000ea <strcmp>:


int
strcmp(const char *p, const char *q)
{
  ea:	1141                	addi	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f0:	00054783          	lbu	a5,0(a0)
  f4:	cb91                	beqz	a5,108 <strcmp+0x1e>
  f6:	0005c703          	lbu	a4,0(a1)
  fa:	00f71763          	bne	a4,a5,108 <strcmp+0x1e>
    p++, q++;
  fe:	0505                	addi	a0,a0,1
 100:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 102:	00054783          	lbu	a5,0(a0)
 106:	fbe5                	bnez	a5,f6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 108:	0005c503          	lbu	a0,0(a1)
}
 10c:	40a7853b          	subw	a0,a5,a0
 110:	6422                	ld	s0,8(sp)
 112:	0141                	addi	sp,sp,16
 114:	8082                	ret

0000000000000116 <strlen>:

uint
strlen(const char *s)
{
 116:	1141                	addi	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 11c:	00054783          	lbu	a5,0(a0)
 120:	cf91                	beqz	a5,13c <strlen+0x26>
 122:	0505                	addi	a0,a0,1
 124:	87aa                	mv	a5,a0
 126:	4685                	li	a3,1
 128:	9e89                	subw	a3,a3,a0
 12a:	00f6853b          	addw	a0,a3,a5
 12e:	0785                	addi	a5,a5,1
 130:	fff7c703          	lbu	a4,-1(a5)
 134:	fb7d                	bnez	a4,12a <strlen+0x14>
    ;
  return n;
}
 136:	6422                	ld	s0,8(sp)
 138:	0141                	addi	sp,sp,16
 13a:	8082                	ret
  for(n = 0; s[n]; n++)
 13c:	4501                	li	a0,0
 13e:	bfe5                	j	136 <strlen+0x20>

0000000000000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	1141                	addi	sp,sp,-16
 142:	e422                	sd	s0,8(sp)
 144:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 146:	ca19                	beqz	a2,15c <memset+0x1c>
 148:	87aa                	mv	a5,a0
 14a:	1602                	slli	a2,a2,0x20
 14c:	9201                	srli	a2,a2,0x20
 14e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 152:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 156:	0785                	addi	a5,a5,1
 158:	fee79de3          	bne	a5,a4,152 <memset+0x12>
  }
  return dst;
}
 15c:	6422                	ld	s0,8(sp)
 15e:	0141                	addi	sp,sp,16
 160:	8082                	ret

0000000000000162 <strchr>:

char*
strchr(const char *s, char c)
{
 162:	1141                	addi	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	addi	s0,sp,16
  for(; *s; s++)
 168:	00054783          	lbu	a5,0(a0)
 16c:	cb99                	beqz	a5,182 <strchr+0x20>
    if(*s == c)
 16e:	00f58763          	beq	a1,a5,17c <strchr+0x1a>
  for(; *s; s++)
 172:	0505                	addi	a0,a0,1
 174:	00054783          	lbu	a5,0(a0)
 178:	fbfd                	bnez	a5,16e <strchr+0xc>
      return (char*)s;
  return 0;
 17a:	4501                	li	a0,0
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  return 0;
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strchr+0x1a>

0000000000000186 <gets>:

char*
gets(char *buf, int max)
{
 186:	711d                	addi	sp,sp,-96
 188:	ec86                	sd	ra,88(sp)
 18a:	e8a2                	sd	s0,80(sp)
 18c:	e4a6                	sd	s1,72(sp)
 18e:	e0ca                	sd	s2,64(sp)
 190:	fc4e                	sd	s3,56(sp)
 192:	f852                	sd	s4,48(sp)
 194:	f456                	sd	s5,40(sp)
 196:	f05a                	sd	s6,32(sp)
 198:	ec5e                	sd	s7,24(sp)
 19a:	e862                	sd	s8,16(sp)
 19c:	1080                	addi	s0,sp,96
 19e:	8baa                	mv	s7,a0
 1a0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a2:	892a                	mv	s2,a0
 1a4:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1a6:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1aa:	4b29                	li	s6,10
 1ac:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1ae:	89a6                	mv	s3,s1
 1b0:	2485                	addiw	s1,s1,1
 1b2:	0344d763          	bge	s1,s4,1e0 <gets+0x5a>
    cc = read(0, &c, 1);
 1b6:	4605                	li	a2,1
 1b8:	85d6                	mv	a1,s5
 1ba:	4501                	li	a0,0
 1bc:	00000097          	auipc	ra,0x0
 1c0:	1b4080e7          	jalr	436(ra) # 370 <read>
    if(cc < 1)
 1c4:	00a05e63          	blez	a0,1e0 <gets+0x5a>
    buf[i++] = c;
 1c8:	faf44783          	lbu	a5,-81(s0)
 1cc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1d0:	01678763          	beq	a5,s6,1de <gets+0x58>
 1d4:	0905                	addi	s2,s2,1
 1d6:	fd879ce3          	bne	a5,s8,1ae <gets+0x28>
  for(i=0; i+1 < max; ){
 1da:	89a6                	mv	s3,s1
 1dc:	a011                	j	1e0 <gets+0x5a>
 1de:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1e0:	99de                	add	s3,s3,s7
 1e2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e6:	855e                	mv	a0,s7
 1e8:	60e6                	ld	ra,88(sp)
 1ea:	6446                	ld	s0,80(sp)
 1ec:	64a6                	ld	s1,72(sp)
 1ee:	6906                	ld	s2,64(sp)
 1f0:	79e2                	ld	s3,56(sp)
 1f2:	7a42                	ld	s4,48(sp)
 1f4:	7aa2                	ld	s5,40(sp)
 1f6:	7b02                	ld	s6,32(sp)
 1f8:	6be2                	ld	s7,24(sp)
 1fa:	6c42                	ld	s8,16(sp)
 1fc:	6125                	addi	sp,sp,96
 1fe:	8082                	ret

0000000000000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	1101                	addi	sp,sp,-32
 202:	ec06                	sd	ra,24(sp)
 204:	e822                	sd	s0,16(sp)
 206:	e426                	sd	s1,8(sp)
 208:	e04a                	sd	s2,0(sp)
 20a:	1000                	addi	s0,sp,32
 20c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20e:	4581                	li	a1,0
 210:	00000097          	auipc	ra,0x0
 214:	188080e7          	jalr	392(ra) # 398 <open>
  if(fd < 0)
 218:	02054563          	bltz	a0,242 <stat+0x42>
 21c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 21e:	85ca                	mv	a1,s2
 220:	00000097          	auipc	ra,0x0
 224:	180080e7          	jalr	384(ra) # 3a0 <fstat>
 228:	892a                	mv	s2,a0
  close(fd);
 22a:	8526                	mv	a0,s1
 22c:	00000097          	auipc	ra,0x0
 230:	154080e7          	jalr	340(ra) # 380 <close>
  return r;
}
 234:	854a                	mv	a0,s2
 236:	60e2                	ld	ra,24(sp)
 238:	6442                	ld	s0,16(sp)
 23a:	64a2                	ld	s1,8(sp)
 23c:	6902                	ld	s2,0(sp)
 23e:	6105                	addi	sp,sp,32
 240:	8082                	ret
    return -1;
 242:	597d                	li	s2,-1
 244:	bfc5                	j	234 <stat+0x34>

0000000000000246 <atoi>:

int
atoi(const char *s)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 24c:	00054703          	lbu	a4,0(a0)
 250:	02d00793          	li	a5,45
  int neg = 1;
 254:	4585                	li	a1,1
  if (*s == '-') {
 256:	04f70363          	beq	a4,a5,29c <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 25a:	00054703          	lbu	a4,0(a0)
 25e:	fd07079b          	addiw	a5,a4,-48
 262:	0ff7f793          	zext.b	a5,a5
 266:	46a5                	li	a3,9
 268:	02f6ed63          	bltu	a3,a5,2a2 <atoi+0x5c>
  n = 0;
 26c:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 26e:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 270:	0505                	addi	a0,a0,1
 272:	0026979b          	slliw	a5,a3,0x2
 276:	9fb5                	addw	a5,a5,a3
 278:	0017979b          	slliw	a5,a5,0x1
 27c:	9fb9                	addw	a5,a5,a4
 27e:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 282:	00054703          	lbu	a4,0(a0)
 286:	fd07079b          	addiw	a5,a4,-48
 28a:	0ff7f793          	zext.b	a5,a5
 28e:	fef671e3          	bgeu	a2,a5,270 <atoi+0x2a>
  return n * neg;
}
 292:	02d5853b          	mulw	a0,a1,a3
 296:	6422                	ld	s0,8(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret
    s++;
 29c:	0505                	addi	a0,a0,1
    neg = -1;
 29e:	55fd                	li	a1,-1
 2a0:	bf6d                	j	25a <atoi+0x14>
  n = 0;
 2a2:	4681                	li	a3,0
 2a4:	b7fd                	j	292 <atoi+0x4c>

00000000000002a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ac:	02b57463          	bgeu	a0,a1,2d4 <memmove+0x2e>
    while(n-- > 0)
 2b0:	00c05f63          	blez	a2,2ce <memmove+0x28>
 2b4:	1602                	slli	a2,a2,0x20
 2b6:	9201                	srli	a2,a2,0x20
 2b8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2bc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2be:	0585                	addi	a1,a1,1
 2c0:	0705                	addi	a4,a4,1
 2c2:	fff5c683          	lbu	a3,-1(a1)
 2c6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ca:	fee79ae3          	bne	a5,a4,2be <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret
    dst += n;
 2d4:	00c50733          	add	a4,a0,a2
    src += n;
 2d8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2da:	fec05ae3          	blez	a2,2ce <memmove+0x28>
 2de:	fff6079b          	addiw	a5,a2,-1
 2e2:	1782                	slli	a5,a5,0x20
 2e4:	9381                	srli	a5,a5,0x20
 2e6:	fff7c793          	not	a5,a5
 2ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ec:	15fd                	addi	a1,a1,-1
 2ee:	177d                	addi	a4,a4,-1
 2f0:	0005c683          	lbu	a3,0(a1)
 2f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f8:	fee79ae3          	bne	a5,a4,2ec <memmove+0x46>
 2fc:	bfc9                	j	2ce <memmove+0x28>

00000000000002fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 304:	ca05                	beqz	a2,334 <memcmp+0x36>
 306:	fff6069b          	addiw	a3,a2,-1
 30a:	1682                	slli	a3,a3,0x20
 30c:	9281                	srli	a3,a3,0x20
 30e:	0685                	addi	a3,a3,1
 310:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 312:	00054783          	lbu	a5,0(a0)
 316:	0005c703          	lbu	a4,0(a1)
 31a:	00e79863          	bne	a5,a4,32a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 31e:	0505                	addi	a0,a0,1
    p2++;
 320:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 322:	fed518e3          	bne	a0,a3,312 <memcmp+0x14>
  }
  return 0;
 326:	4501                	li	a0,0
 328:	a019                	j	32e <memcmp+0x30>
      return *p1 - *p2;
 32a:	40e7853b          	subw	a0,a5,a4
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  return 0;
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <memcmp+0x30>

0000000000000338 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 340:	00000097          	auipc	ra,0x0
 344:	f66080e7          	jalr	-154(ra) # 2a6 <memmove>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 350:	4885                	li	a7,1
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <exit>:
.global exit
exit:
 li a7, SYS_exit
 358:	4889                	li	a7,2
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <wait>:
.global wait
wait:
 li a7, SYS_wait
 360:	488d                	li	a7,3
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 368:	4891                	li	a7,4
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <read>:
.global read
read:
 li a7, SYS_read
 370:	4895                	li	a7,5
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <write>:
.global write
write:
 li a7, SYS_write
 378:	48c1                	li	a7,16
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <close>:
.global close
close:
 li a7, SYS_close
 380:	48d5                	li	a7,21
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <kill>:
.global kill
kill:
 li a7, SYS_kill
 388:	4899                	li	a7,6
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <exec>:
.global exec
exec:
 li a7, SYS_exec
 390:	489d                	li	a7,7
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <open>:
.global open
open:
 li a7, SYS_open
 398:	48bd                	li	a7,15
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3a0:	48a1                	li	a7,8
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a8:	48d1                	li	a7,20
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b0:	48a5                	li	a7,9
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b8:	48a9                	li	a7,10
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c0:	48ad                	li	a7,11
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c8:	48b1                	li	a7,12
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d0:	48b5                	li	a7,13
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d8:	48b9                	li	a7,14
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3e0:	48d9                	li	a7,22
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3e8:	48dd                	li	a7,23
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3f0:	48e1                	li	a7,24
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3f8:	48e5                	li	a7,25
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <remove>:
.global remove
remove:
 li a7, SYS_remove
 400:	48c5                	li	a7,17
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <trace>:
.global trace
trace:
 li a7, SYS_trace
 408:	48c9                	li	a7,18
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 410:	48cd                	li	a7,19
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <rename>:
.global rename
rename:
 li a7, SYS_rename
 418:	48e9                	li	a7,26
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 420:	48ed                	li	a7,27
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 428:	48f1                	li	a7,28
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 430:	48f5                	li	a7,29
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 438:	48f9                	li	a7,30
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 440:	48fd                	li	a7,31
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 448:	02000893          	li	a7,32
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 452:	02100893          	li	a7,33
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 45c:	02200893          	li	a7,34
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 466:	02300893          	li	a7,35
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 470:	02400893          	li	a7,36
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 47a:	02500893          	li	a7,37
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 484:	02600893          	li	a7,38
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 48e:	02700893          	li	a7,39
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 498:	02800893          	li	a7,40
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 4a2:	02900893          	li	a7,41
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 4ac:	02a00893          	li	a7,42
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 4b6:	02b00893          	li	a7,43
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 4c0:	02c00893          	li	a7,44
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 4ca:	02d00893          	li	a7,45
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 4d4:	02e00893          	li	a7,46
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4de:	02f00893          	li	a7,47
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 4e8:	03000893          	li	a7,48
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 4f2:	03100893          	li	a7,49
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 4fc:	03200893          	li	a7,50
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 506:	03300893          	li	a7,51
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 510:	03400893          	li	a7,52
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 51a:	03500893          	li	a7,53
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 524:	03600893          	li	a7,54
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 52e:	03700893          	li	a7,55
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 538:	03800893          	li	a7,56
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 542:	03900893          	li	a7,57
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 54c:	03a00893          	li	a7,58
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <poll>:
.global poll
poll:
 li a7, SYS_poll
 556:	03b00893          	li	a7,59
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 560:	03c00893          	li	a7,60
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 56a:	03d00893          	li	a7,61
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 574:	03e00893          	li	a7,62
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <clone>:
.global clone
clone:
 li a7, SYS_clone
 57e:	03f00893          	li	a7,63
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <futex>:
.global futex
futex:
 li a7, SYS_futex
 588:	04000893          	li	a7,64
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 592:	04100893          	li	a7,65
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <halt>:
.global halt
halt:
 li a7, SYS_halt
 59c:	04200893          	li	a7,66
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 5a6:	04300893          	li	a7,67
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <socket>:
.global socket
socket:
 li a7, SYS_socket
 5b0:	04400893          	li	a7,68
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <bind>:
.global bind
bind:
 li a7, SYS_bind
 5ba:	04500893          	li	a7,69
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <listen>:
.global listen
listen:
 li a7, SYS_listen
 5c4:	04600893          	li	a7,70
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <accept>:
.global accept
accept:
 li a7, SYS_accept
 5ce:	04700893          	li	a7,71
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5d8:	04800893          	li	a7,72
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <send>:
.global send
send:
 li a7, SYS_send
 5e2:	04900893          	li	a7,73
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <recv>:
.global recv
recv:
 li a7, SYS_recv
 5ec:	04a00893          	li	a7,74
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 5f6:	04b00893          	li	a7,75
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 600:	1101                	addi	sp,sp,-32
 602:	ec06                	sd	ra,24(sp)
 604:	e822                	sd	s0,16(sp)
 606:	1000                	addi	s0,sp,32
 608:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 60c:	4605                	li	a2,1
 60e:	fef40593          	addi	a1,s0,-17
 612:	00000097          	auipc	ra,0x0
 616:	d66080e7          	jalr	-666(ra) # 378 <write>
}
 61a:	60e2                	ld	ra,24(sp)
 61c:	6442                	ld	s0,16(sp)
 61e:	6105                	addi	sp,sp,32
 620:	8082                	ret

0000000000000622 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 622:	7139                	addi	sp,sp,-64
 624:	fc06                	sd	ra,56(sp)
 626:	f822                	sd	s0,48(sp)
 628:	f426                	sd	s1,40(sp)
 62a:	f04a                	sd	s2,32(sp)
 62c:	ec4e                	sd	s3,24(sp)
 62e:	0080                	addi	s0,sp,64
 630:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 632:	c299                	beqz	a3,638 <printint+0x16>
 634:	0805c863          	bltz	a1,6c4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 638:	2581                	sext.w	a1,a1
  neg = 0;
 63a:	4881                	li	a7,0
  }

  i = 0;
 63c:	fc040993          	addi	s3,s0,-64
  neg = 0;
 640:	86ce                	mv	a3,s3
  i = 0;
 642:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 644:	2601                	sext.w	a2,a2
 646:	00000517          	auipc	a0,0x0
 64a:	51a50513          	addi	a0,a0,1306 # b60 <digits>
 64e:	883a                	mv	a6,a4
 650:	2705                	addiw	a4,a4,1
 652:	02c5f7bb          	remuw	a5,a1,a2
 656:	1782                	slli	a5,a5,0x20
 658:	9381                	srli	a5,a5,0x20
 65a:	97aa                	add	a5,a5,a0
 65c:	0007c783          	lbu	a5,0(a5)
 660:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 664:	0005879b          	sext.w	a5,a1
 668:	02c5d5bb          	divuw	a1,a1,a2
 66c:	0685                	addi	a3,a3,1
 66e:	fec7f0e3          	bgeu	a5,a2,64e <printint+0x2c>
  if(neg)
 672:	00088c63          	beqz	a7,68a <printint+0x68>
    buf[i++] = '-';
 676:	fd070793          	addi	a5,a4,-48
 67a:	00878733          	add	a4,a5,s0
 67e:	02d00793          	li	a5,45
 682:	fef70823          	sb	a5,-16(a4)
 686:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 68a:	02e05663          	blez	a4,6b6 <printint+0x94>
 68e:	fc040913          	addi	s2,s0,-64
 692:	993a                	add	s2,s2,a4
 694:	19fd                	addi	s3,s3,-1
 696:	99ba                	add	s3,s3,a4
 698:	377d                	addiw	a4,a4,-1
 69a:	1702                	slli	a4,a4,0x20
 69c:	9301                	srli	a4,a4,0x20
 69e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6a2:	fff94583          	lbu	a1,-1(s2)
 6a6:	8526                	mv	a0,s1
 6a8:	00000097          	auipc	ra,0x0
 6ac:	f58080e7          	jalr	-168(ra) # 600 <putc>
  while(--i >= 0)
 6b0:	197d                	addi	s2,s2,-1
 6b2:	ff3918e3          	bne	s2,s3,6a2 <printint+0x80>
}
 6b6:	70e2                	ld	ra,56(sp)
 6b8:	7442                	ld	s0,48(sp)
 6ba:	74a2                	ld	s1,40(sp)
 6bc:	7902                	ld	s2,32(sp)
 6be:	69e2                	ld	s3,24(sp)
 6c0:	6121                	addi	sp,sp,64
 6c2:	8082                	ret
    x = -xx;
 6c4:	40b005bb          	negw	a1,a1
    neg = 1;
 6c8:	4885                	li	a7,1
    x = -xx;
 6ca:	bf8d                	j	63c <printint+0x1a>

00000000000006cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6cc:	7119                	addi	sp,sp,-128
 6ce:	fc86                	sd	ra,120(sp)
 6d0:	f8a2                	sd	s0,112(sp)
 6d2:	f4a6                	sd	s1,104(sp)
 6d4:	f0ca                	sd	s2,96(sp)
 6d6:	ecce                	sd	s3,88(sp)
 6d8:	e8d2                	sd	s4,80(sp)
 6da:	e4d6                	sd	s5,72(sp)
 6dc:	e0da                	sd	s6,64(sp)
 6de:	fc5e                	sd	s7,56(sp)
 6e0:	f862                	sd	s8,48(sp)
 6e2:	f466                	sd	s9,40(sp)
 6e4:	f06a                	sd	s10,32(sp)
 6e6:	ec6e                	sd	s11,24(sp)
 6e8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ea:	0005c903          	lbu	s2,0(a1)
 6ee:	18090f63          	beqz	s2,88c <vprintf+0x1c0>
 6f2:	8aaa                	mv	s5,a0
 6f4:	8b32                	mv	s6,a2
 6f6:	00158493          	addi	s1,a1,1
  state = 0;
 6fa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6fc:	02500a13          	li	s4,37
 700:	4c55                	li	s8,21
 702:	00000c97          	auipc	s9,0x0
 706:	406c8c93          	addi	s9,s9,1030 # b08 <malloc+0x178>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 70a:	02800d93          	li	s11,40
  putc(fd, 'x');
 70e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 710:	00000b97          	auipc	s7,0x0
 714:	450b8b93          	addi	s7,s7,1104 # b60 <digits>
 718:	a839                	j	736 <vprintf+0x6a>
        putc(fd, c);
 71a:	85ca                	mv	a1,s2
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	ee2080e7          	jalr	-286(ra) # 600 <putc>
 726:	a019                	j	72c <vprintf+0x60>
    } else if(state == '%'){
 728:	01498d63          	beq	s3,s4,742 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 72c:	0485                	addi	s1,s1,1
 72e:	fff4c903          	lbu	s2,-1(s1)
 732:	14090d63          	beqz	s2,88c <vprintf+0x1c0>
    if(state == 0){
 736:	fe0999e3          	bnez	s3,728 <vprintf+0x5c>
      if(c == '%'){
 73a:	ff4910e3          	bne	s2,s4,71a <vprintf+0x4e>
        state = '%';
 73e:	89d2                	mv	s3,s4
 740:	b7f5                	j	72c <vprintf+0x60>
      if(c == 'd'){
 742:	11490c63          	beq	s2,s4,85a <vprintf+0x18e>
 746:	f9d9079b          	addiw	a5,s2,-99
 74a:	0ff7f793          	zext.b	a5,a5
 74e:	10fc6e63          	bltu	s8,a5,86a <vprintf+0x19e>
 752:	f9d9079b          	addiw	a5,s2,-99
 756:	0ff7f713          	zext.b	a4,a5
 75a:	10ec6863          	bltu	s8,a4,86a <vprintf+0x19e>
 75e:	00271793          	slli	a5,a4,0x2
 762:	97e6                	add	a5,a5,s9
 764:	439c                	lw	a5,0(a5)
 766:	97e6                	add	a5,a5,s9
 768:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 76a:	008b0913          	addi	s2,s6,8
 76e:	4685                	li	a3,1
 770:	4629                	li	a2,10
 772:	000b2583          	lw	a1,0(s6)
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	eaa080e7          	jalr	-342(ra) # 622 <printint>
 780:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 782:	4981                	li	s3,0
 784:	b765                	j	72c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 786:	008b0913          	addi	s2,s6,8
 78a:	4681                	li	a3,0
 78c:	4629                	li	a2,10
 78e:	000b2583          	lw	a1,0(s6)
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	e8e080e7          	jalr	-370(ra) # 622 <printint>
 79c:	8b4a                	mv	s6,s2
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	b771                	j	72c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7a2:	008b0913          	addi	s2,s6,8
 7a6:	4681                	li	a3,0
 7a8:	866a                	mv	a2,s10
 7aa:	000b2583          	lw	a1,0(s6)
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e72080e7          	jalr	-398(ra) # 622 <printint>
 7b8:	8b4a                	mv	s6,s2
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bf85                	j	72c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7be:	008b0793          	addi	a5,s6,8
 7c2:	f8f43423          	sd	a5,-120(s0)
 7c6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7ca:	03000593          	li	a1,48
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	e30080e7          	jalr	-464(ra) # 600 <putc>
  putc(fd, 'x');
 7d8:	07800593          	li	a1,120
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	e22080e7          	jalr	-478(ra) # 600 <putc>
 7e6:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7e8:	03c9d793          	srli	a5,s3,0x3c
 7ec:	97de                	add	a5,a5,s7
 7ee:	0007c583          	lbu	a1,0(a5)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	e0c080e7          	jalr	-500(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7fc:	0992                	slli	s3,s3,0x4
 7fe:	397d                	addiw	s2,s2,-1
 800:	fe0914e3          	bnez	s2,7e8 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 804:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 808:	4981                	li	s3,0
 80a:	b70d                	j	72c <vprintf+0x60>
        s = va_arg(ap, char*);
 80c:	008b0913          	addi	s2,s6,8
 810:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 814:	02098163          	beqz	s3,836 <vprintf+0x16a>
        while(*s != 0){
 818:	0009c583          	lbu	a1,0(s3)
 81c:	c5ad                	beqz	a1,886 <vprintf+0x1ba>
          putc(fd, *s);
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	de0080e7          	jalr	-544(ra) # 600 <putc>
          s++;
 828:	0985                	addi	s3,s3,1
        while(*s != 0){
 82a:	0009c583          	lbu	a1,0(s3)
 82e:	f9e5                	bnez	a1,81e <vprintf+0x152>
        s = va_arg(ap, char*);
 830:	8b4a                	mv	s6,s2
      state = 0;
 832:	4981                	li	s3,0
 834:	bde5                	j	72c <vprintf+0x60>
          s = "(null)";
 836:	00000997          	auipc	s3,0x0
 83a:	2ca98993          	addi	s3,s3,714 # b00 <malloc+0x170>
        while(*s != 0){
 83e:	85ee                	mv	a1,s11
 840:	bff9                	j	81e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 842:	008b0913          	addi	s2,s6,8
 846:	000b4583          	lbu	a1,0(s6)
 84a:	8556                	mv	a0,s5
 84c:	00000097          	auipc	ra,0x0
 850:	db4080e7          	jalr	-588(ra) # 600 <putc>
 854:	8b4a                	mv	s6,s2
      state = 0;
 856:	4981                	li	s3,0
 858:	bdd1                	j	72c <vprintf+0x60>
        putc(fd, c);
 85a:	85d2                	mv	a1,s4
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	da2080e7          	jalr	-606(ra) # 600 <putc>
      state = 0;
 866:	4981                	li	s3,0
 868:	b5d1                	j	72c <vprintf+0x60>
        putc(fd, '%');
 86a:	85d2                	mv	a1,s4
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	d92080e7          	jalr	-622(ra) # 600 <putc>
        putc(fd, c);
 876:	85ca                	mv	a1,s2
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	d86080e7          	jalr	-634(ra) # 600 <putc>
      state = 0;
 882:	4981                	li	s3,0
 884:	b565                	j	72c <vprintf+0x60>
        s = va_arg(ap, char*);
 886:	8b4a                	mv	s6,s2
      state = 0;
 888:	4981                	li	s3,0
 88a:	b54d                	j	72c <vprintf+0x60>
    }
  }
}
 88c:	70e6                	ld	ra,120(sp)
 88e:	7446                	ld	s0,112(sp)
 890:	74a6                	ld	s1,104(sp)
 892:	7906                	ld	s2,96(sp)
 894:	69e6                	ld	s3,88(sp)
 896:	6a46                	ld	s4,80(sp)
 898:	6aa6                	ld	s5,72(sp)
 89a:	6b06                	ld	s6,64(sp)
 89c:	7be2                	ld	s7,56(sp)
 89e:	7c42                	ld	s8,48(sp)
 8a0:	7ca2                	ld	s9,40(sp)
 8a2:	7d02                	ld	s10,32(sp)
 8a4:	6de2                	ld	s11,24(sp)
 8a6:	6109                	addi	sp,sp,128
 8a8:	8082                	ret

00000000000008aa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8aa:	715d                	addi	sp,sp,-80
 8ac:	ec06                	sd	ra,24(sp)
 8ae:	e822                	sd	s0,16(sp)
 8b0:	1000                	addi	s0,sp,32
 8b2:	e010                	sd	a2,0(s0)
 8b4:	e414                	sd	a3,8(s0)
 8b6:	e818                	sd	a4,16(s0)
 8b8:	ec1c                	sd	a5,24(s0)
 8ba:	03043023          	sd	a6,32(s0)
 8be:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8c2:	8622                	mv	a2,s0
 8c4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8c8:	00000097          	auipc	ra,0x0
 8cc:	e04080e7          	jalr	-508(ra) # 6cc <vprintf>
}
 8d0:	60e2                	ld	ra,24(sp)
 8d2:	6442                	ld	s0,16(sp)
 8d4:	6161                	addi	sp,sp,80
 8d6:	8082                	ret

00000000000008d8 <printf>:

void
printf(const char *fmt, ...)
{
 8d8:	711d                	addi	sp,sp,-96
 8da:	ec06                	sd	ra,24(sp)
 8dc:	e822                	sd	s0,16(sp)
 8de:	1000                	addi	s0,sp,32
 8e0:	e40c                	sd	a1,8(s0)
 8e2:	e810                	sd	a2,16(s0)
 8e4:	ec14                	sd	a3,24(s0)
 8e6:	f018                	sd	a4,32(s0)
 8e8:	f41c                	sd	a5,40(s0)
 8ea:	03043823          	sd	a6,48(s0)
 8ee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8f2:	00840613          	addi	a2,s0,8
 8f6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8fa:	85aa                	mv	a1,a0
 8fc:	4505                	li	a0,1
 8fe:	00000097          	auipc	ra,0x0
 902:	dce080e7          	jalr	-562(ra) # 6cc <vprintf>
}
 906:	60e2                	ld	ra,24(sp)
 908:	6442                	ld	s0,16(sp)
 90a:	6125                	addi	sp,sp,96
 90c:	8082                	ret

000000000000090e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 90e:	1141                	addi	sp,sp,-16
 910:	e422                	sd	s0,8(sp)
 912:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 914:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 918:	00000797          	auipc	a5,0x0
 91c:	2607b783          	ld	a5,608(a5) # b78 <freep>
 920:	a02d                	j	94a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 922:	4618                	lw	a4,8(a2)
 924:	9f2d                	addw	a4,a4,a1
 926:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 92a:	6398                	ld	a4,0(a5)
 92c:	6310                	ld	a2,0(a4)
 92e:	a83d                	j	96c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 930:	ff852703          	lw	a4,-8(a0)
 934:	9f31                	addw	a4,a4,a2
 936:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 938:	ff053683          	ld	a3,-16(a0)
 93c:	a091                	j	980 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93e:	6398                	ld	a4,0(a5)
 940:	00e7e463          	bltu	a5,a4,948 <free+0x3a>
 944:	00e6ea63          	bltu	a3,a4,958 <free+0x4a>
{
 948:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94a:	fed7fae3          	bgeu	a5,a3,93e <free+0x30>
 94e:	6398                	ld	a4,0(a5)
 950:	00e6e463          	bltu	a3,a4,958 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 954:	fee7eae3          	bltu	a5,a4,948 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 958:	ff852583          	lw	a1,-8(a0)
 95c:	6390                	ld	a2,0(a5)
 95e:	02059813          	slli	a6,a1,0x20
 962:	01c85713          	srli	a4,a6,0x1c
 966:	9736                	add	a4,a4,a3
 968:	fae60de3          	beq	a2,a4,922 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 96c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 970:	4790                	lw	a2,8(a5)
 972:	02061593          	slli	a1,a2,0x20
 976:	01c5d713          	srli	a4,a1,0x1c
 97a:	973e                	add	a4,a4,a5
 97c:	fae68ae3          	beq	a3,a4,930 <free+0x22>
    p->s.ptr = bp->s.ptr;
 980:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 982:	00000717          	auipc	a4,0x0
 986:	1ef73b23          	sd	a5,502(a4) # b78 <freep>
}
 98a:	6422                	ld	s0,8(sp)
 98c:	0141                	addi	sp,sp,16
 98e:	8082                	ret

0000000000000990 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 990:	7139                	addi	sp,sp,-64
 992:	fc06                	sd	ra,56(sp)
 994:	f822                	sd	s0,48(sp)
 996:	f426                	sd	s1,40(sp)
 998:	f04a                	sd	s2,32(sp)
 99a:	ec4e                	sd	s3,24(sp)
 99c:	e852                	sd	s4,16(sp)
 99e:	e456                	sd	s5,8(sp)
 9a0:	e05a                	sd	s6,0(sp)
 9a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a4:	02051493          	slli	s1,a0,0x20
 9a8:	9081                	srli	s1,s1,0x20
 9aa:	04bd                	addi	s1,s1,15
 9ac:	8091                	srli	s1,s1,0x4
 9ae:	00148a1b          	addiw	s4,s1,1
 9b2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9b4:	00000517          	auipc	a0,0x0
 9b8:	1c453503          	ld	a0,452(a0) # b78 <freep>
 9bc:	c515                	beqz	a0,9e8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c0:	4798                	lw	a4,8(a5)
 9c2:	04977163          	bgeu	a4,s1,a04 <malloc+0x74>
 9c6:	89d2                	mv	s3,s4
 9c8:	000a071b          	sext.w	a4,s4
 9cc:	6685                	lui	a3,0x1
 9ce:	00d77363          	bgeu	a4,a3,9d4 <malloc+0x44>
 9d2:	6985                	lui	s3,0x1
 9d4:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 9d8:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9dc:	00000917          	auipc	s2,0x0
 9e0:	19c90913          	addi	s2,s2,412 # b78 <freep>
  if(p == (char*)-1)
 9e4:	5afd                	li	s5,-1
 9e6:	a8a5                	j	a5e <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 9e8:	00000797          	auipc	a5,0x0
 9ec:	19078793          	addi	a5,a5,400 # b78 <freep>
 9f0:	00000717          	auipc	a4,0x0
 9f4:	19070713          	addi	a4,a4,400 # b80 <base>
 9f8:	e398                	sd	a4,0(a5)
 9fa:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 9fc:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a00:	87ba                	mv	a5,a4
 a02:	b7d1                	j	9c6 <malloc+0x36>
      if(p->s.size == nunits)
 a04:	02e48c63          	beq	s1,a4,a3c <malloc+0xac>
        p->s.size -= nunits;
 a08:	4147073b          	subw	a4,a4,s4
 a0c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a0e:	02071693          	slli	a3,a4,0x20
 a12:	01c6d713          	srli	a4,a3,0x1c
 a16:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a18:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a1c:	00000717          	auipc	a4,0x0
 a20:	14a73e23          	sd	a0,348(a4) # b78 <freep>
      return (void*)(p + 1);
 a24:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a28:	70e2                	ld	ra,56(sp)
 a2a:	7442                	ld	s0,48(sp)
 a2c:	74a2                	ld	s1,40(sp)
 a2e:	7902                	ld	s2,32(sp)
 a30:	69e2                	ld	s3,24(sp)
 a32:	6a42                	ld	s4,16(sp)
 a34:	6aa2                	ld	s5,8(sp)
 a36:	6b02                	ld	s6,0(sp)
 a38:	6121                	addi	sp,sp,64
 a3a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a3c:	6398                	ld	a4,0(a5)
 a3e:	e118                	sd	a4,0(a0)
 a40:	bff1                	j	a1c <malloc+0x8c>
  hp->s.size = nu;
 a42:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a46:	0541                	addi	a0,a0,16
 a48:	00000097          	auipc	ra,0x0
 a4c:	ec6080e7          	jalr	-314(ra) # 90e <free>
  return freep;
 a50:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a54:	d971                	beqz	a0,a28 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a56:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a58:	4798                	lw	a4,8(a5)
 a5a:	fa9775e3          	bgeu	a4,s1,a04 <malloc+0x74>
    if(p == freep)
 a5e:	00093703          	ld	a4,0(s2)
 a62:	853e                	mv	a0,a5
 a64:	fef719e3          	bne	a4,a5,a56 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 a68:	854e                	mv	a0,s3
 a6a:	00000097          	auipc	ra,0x0
 a6e:	95e080e7          	jalr	-1698(ra) # 3c8 <sbrk>
  if(p == (char*)-1)
 a72:	fd5518e3          	bne	a0,s5,a42 <malloc+0xb2>
        return 0;
 a76:	4501                	li	a0,0
 a78:	bf45                	j	a28 <malloc+0x98>
