
serein-user/_consoletest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

// 注意：这个结构体必须与你在 kernel/include/sysinfo.h 和 serein-user/user.h
// 中定义的结构体完全一致。

int main(void)
{
   0:	7151                	addi	sp,sp,-240
   2:	f586                	sd	ra,232(sp)
   4:	f1a2                	sd	s0,224(sp)
   6:	1980                	addi	s0,sp,240
  struct sysinfo info_before, info_after;
  char buf[2]; // 用于清空输入行，避免影响后续命令

  // 1. 获取初始的丢弃字符数
  if (sysinfo(&info_before) < 0) {
   8:	f8840513          	addi	a0,s0,-120
   c:	00000097          	auipc	ra,0x0
  10:	44e080e7          	jalr	1102(ra) # 45a <sysinfo>
  14:	08054863          	bltz	a0,a4 <main+0xa4>
    printf("ERROR: sysinfo call failed.\n");
    exit(-1);
  }
  printf("Initial dropped characters: %d\n", info_before.dropped);
  18:	fe843583          	ld	a1,-24(s0)
  1c:	00001517          	auipc	a0,0x1
  20:	acc50513          	addi	a0,a0,-1332 # ae8 <malloc+0x10e>
  24:	00001097          	auipc	ra,0x1
  28:	8fe080e7          	jalr	-1794(ra) # 922 <printf>

  // 2. 提示用户进行操作
  printf("\n>>> Please paste a very long line of text (more than 128 chars) right now.\n");
  2c:	00001517          	auipc	a0,0x1
  30:	adc50513          	addi	a0,a0,-1316 # b08 <malloc+0x12e>
  34:	00001097          	auipc	ra,0x1
  38:	8ee080e7          	jalr	-1810(ra) # 922 <printf>
  printf(">>> Then press Enter.\n");
  3c:	00001517          	auipc	a0,0x1
  40:	b1c50513          	addi	a0,a0,-1252 # b58 <malloc+0x17e>
  44:	00001097          	auipc	ra,0x1
  48:	8de080e7          	jalr	-1826(ra) # 922 <printf>

  // 3. 等待用户输入，这个gets()会消耗掉用户粘贴的并按回车后的那一行输入
  gets(buf, sizeof(buf));
  4c:	4589                	li	a1,2
  4e:	f1840513          	addi	a0,s0,-232
  52:	00000097          	auipc	ra,0x0
  56:	17e080e7          	jalr	382(ra) # 1d0 <gets>

  // 4. 再次获取 sysinfo，查看丢弃字符数的变化
  if (sysinfo(&info_after) < 0) {
  5a:	f2040513          	addi	a0,s0,-224
  5e:	00000097          	auipc	ra,0x0
  62:	3fc080e7          	jalr	1020(ra) # 45a <sysinfo>
  66:	04054c63          	bltz	a0,be <main+0xbe>
    printf("ERROR: sysinfo call failed.\n");
    exit(-1);
  }
  printf("\nFinal dropped characters: %d\n", info_after.dropped);
  6a:	f8043583          	ld	a1,-128(s0)
  6e:	00001517          	auipc	a0,0x1
  72:	b0250513          	addi	a0,a0,-1278 # b70 <malloc+0x196>
  76:	00001097          	auipc	ra,0x1
  7a:	8ac080e7          	jalr	-1876(ra) # 922 <printf>

  // 5. 验证结果
  if (info_after.dropped > info_before.dropped) {
  7e:	f8043703          	ld	a4,-128(s0)
  82:	fe843783          	ld	a5,-24(s0)
  86:	04e7f963          	bgeu	a5,a4,d8 <main+0xd8>
    printf("\nSUCCESS: Dropped character count increased correctly!\n");
  8a:	00001517          	auipc	a0,0x1
  8e:	b0650513          	addi	a0,a0,-1274 # b90 <malloc+0x1b6>
  92:	00001097          	auipc	ra,0x1
  96:	890080e7          	jalr	-1904(ra) # 922 <printf>
  } else {
    printf("\nNOTE: No characters were dropped. Try pasting more text, or faster.\n");
  }

  exit(0);
  9a:	4501                	li	a0,0
  9c:	00000097          	auipc	ra,0x0
  a0:	306080e7          	jalr	774(ra) # 3a2 <exit>
    printf("ERROR: sysinfo call failed.\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	a2450513          	addi	a0,a0,-1500 # ac8 <malloc+0xee>
  ac:	00001097          	auipc	ra,0x1
  b0:	876080e7          	jalr	-1930(ra) # 922 <printf>
    exit(-1);
  b4:	557d                	li	a0,-1
  b6:	00000097          	auipc	ra,0x0
  ba:	2ec080e7          	jalr	748(ra) # 3a2 <exit>
    printf("ERROR: sysinfo call failed.\n");
  be:	00001517          	auipc	a0,0x1
  c2:	a0a50513          	addi	a0,a0,-1526 # ac8 <malloc+0xee>
  c6:	00001097          	auipc	ra,0x1
  ca:	85c080e7          	jalr	-1956(ra) # 922 <printf>
    exit(-1);
  ce:	557d                	li	a0,-1
  d0:	00000097          	auipc	ra,0x0
  d4:	2d2080e7          	jalr	722(ra) # 3a2 <exit>
    printf("\nNOTE: No characters were dropped. Try pasting more text, or faster.\n");
  d8:	00001517          	auipc	a0,0x1
  dc:	af050513          	addi	a0,a0,-1296 # bc8 <malloc+0x1ee>
  e0:	00001097          	auipc	ra,0x1
  e4:	842080e7          	jalr	-1982(ra) # 922 <printf>
  e8:	bf4d                	j	9a <main+0x9a>

00000000000000ea <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  ea:	1141                	addi	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f0:	87aa                	mv	a5,a0
  f2:	0585                	addi	a1,a1,1
  f4:	0785                	addi	a5,a5,1
  f6:	fff5c703          	lbu	a4,-1(a1)
  fa:	fee78fa3          	sb	a4,-1(a5)
  fe:	fb75                	bnez	a4,f2 <strcpy+0x8>
    ;
  return os;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strcat>:

char*
strcat(char *s, const char *t)
{
 106:	1141                	addi	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 10c:	00054783          	lbu	a5,0(a0)
 110:	c385                	beqz	a5,130 <strcat+0x2a>
 112:	87aa                	mv	a5,a0
    s++;
 114:	0785                	addi	a5,a5,1
  while(*s)
 116:	0007c703          	lbu	a4,0(a5)
 11a:	ff6d                	bnez	a4,114 <strcat+0xe>
  while((*s++ = *t++))
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcat+0x16>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret
  while(*s)
 130:	87aa                	mv	a5,a0
 132:	b7ed                	j	11c <strcat+0x16>

0000000000000134 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 134:	1141                	addi	sp,sp,-16
 136:	e422                	sd	s0,8(sp)
 138:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cb91                	beqz	a5,152 <strcmp+0x1e>
 140:	0005c703          	lbu	a4,0(a1)
 144:	00f71763          	bne	a4,a5,152 <strcmp+0x1e>
    p++, q++;
 148:	0505                	addi	a0,a0,1
 14a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 14c:	00054783          	lbu	a5,0(a0)
 150:	fbe5                	bnez	a5,140 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 152:	0005c503          	lbu	a0,0(a1)
}
 156:	40a7853b          	subw	a0,a5,a0
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret

0000000000000160 <strlen>:

uint
strlen(const char *s)
{
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 166:	00054783          	lbu	a5,0(a0)
 16a:	cf91                	beqz	a5,186 <strlen+0x26>
 16c:	0505                	addi	a0,a0,1
 16e:	87aa                	mv	a5,a0
 170:	4685                	li	a3,1
 172:	9e89                	subw	a3,a3,a0
 174:	00f6853b          	addw	a0,a3,a5
 178:	0785                	addi	a5,a5,1
 17a:	fff7c703          	lbu	a4,-1(a5)
 17e:	fb7d                	bnez	a4,174 <strlen+0x14>
    ;
  return n;
}
 180:	6422                	ld	s0,8(sp)
 182:	0141                	addi	sp,sp,16
 184:	8082                	ret
  for(n = 0; s[n]; n++)
 186:	4501                	li	a0,0
 188:	bfe5                	j	180 <strlen+0x20>

000000000000018a <memset>:

void*
memset(void *dst, int c, uint n)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 190:	ca19                	beqz	a2,1a6 <memset+0x1c>
 192:	87aa                	mv	a5,a0
 194:	1602                	slli	a2,a2,0x20
 196:	9201                	srli	a2,a2,0x20
 198:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 19c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1a0:	0785                	addi	a5,a5,1
 1a2:	fee79de3          	bne	a5,a4,19c <memset+0x12>
  }
  return dst;
}
 1a6:	6422                	ld	s0,8(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <strchr>:

char*
strchr(const char *s, char c)
{
 1ac:	1141                	addi	sp,sp,-16
 1ae:	e422                	sd	s0,8(sp)
 1b0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b2:	00054783          	lbu	a5,0(a0)
 1b6:	cb99                	beqz	a5,1cc <strchr+0x20>
    if(*s == c)
 1b8:	00f58763          	beq	a1,a5,1c6 <strchr+0x1a>
  for(; *s; s++)
 1bc:	0505                	addi	a0,a0,1
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	fbfd                	bnez	a5,1b8 <strchr+0xc>
      return (char*)s;
  return 0;
 1c4:	4501                	li	a0,0
}
 1c6:	6422                	ld	s0,8(sp)
 1c8:	0141                	addi	sp,sp,16
 1ca:	8082                	ret
  return 0;
 1cc:	4501                	li	a0,0
 1ce:	bfe5                	j	1c6 <strchr+0x1a>

00000000000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	711d                	addi	sp,sp,-96
 1d2:	ec86                	sd	ra,88(sp)
 1d4:	e8a2                	sd	s0,80(sp)
 1d6:	e4a6                	sd	s1,72(sp)
 1d8:	e0ca                	sd	s2,64(sp)
 1da:	fc4e                	sd	s3,56(sp)
 1dc:	f852                	sd	s4,48(sp)
 1de:	f456                	sd	s5,40(sp)
 1e0:	f05a                	sd	s6,32(sp)
 1e2:	ec5e                	sd	s7,24(sp)
 1e4:	e862                	sd	s8,16(sp)
 1e6:	1080                	addi	s0,sp,96
 1e8:	8baa                	mv	s7,a0
 1ea:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ec:	892a                	mv	s2,a0
 1ee:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1f0:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f4:	4b29                	li	s6,10
 1f6:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1f8:	89a6                	mv	s3,s1
 1fa:	2485                	addiw	s1,s1,1
 1fc:	0344d763          	bge	s1,s4,22a <gets+0x5a>
    cc = read(0, &c, 1);
 200:	4605                	li	a2,1
 202:	85d6                	mv	a1,s5
 204:	4501                	li	a0,0
 206:	00000097          	auipc	ra,0x0
 20a:	1b4080e7          	jalr	436(ra) # 3ba <read>
    if(cc < 1)
 20e:	00a05e63          	blez	a0,22a <gets+0x5a>
    buf[i++] = c;
 212:	faf44783          	lbu	a5,-81(s0)
 216:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 21a:	01678763          	beq	a5,s6,228 <gets+0x58>
 21e:	0905                	addi	s2,s2,1
 220:	fd879ce3          	bne	a5,s8,1f8 <gets+0x28>
  for(i=0; i+1 < max; ){
 224:	89a6                	mv	s3,s1
 226:	a011                	j	22a <gets+0x5a>
 228:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 22a:	99de                	add	s3,s3,s7
 22c:	00098023          	sb	zero,0(s3)
  return buf;
}
 230:	855e                	mv	a0,s7
 232:	60e6                	ld	ra,88(sp)
 234:	6446                	ld	s0,80(sp)
 236:	64a6                	ld	s1,72(sp)
 238:	6906                	ld	s2,64(sp)
 23a:	79e2                	ld	s3,56(sp)
 23c:	7a42                	ld	s4,48(sp)
 23e:	7aa2                	ld	s5,40(sp)
 240:	7b02                	ld	s6,32(sp)
 242:	6be2                	ld	s7,24(sp)
 244:	6c42                	ld	s8,16(sp)
 246:	6125                	addi	sp,sp,96
 248:	8082                	ret

000000000000024a <stat>:

int
stat(const char *n, struct stat *st)
{
 24a:	1101                	addi	sp,sp,-32
 24c:	ec06                	sd	ra,24(sp)
 24e:	e822                	sd	s0,16(sp)
 250:	e426                	sd	s1,8(sp)
 252:	e04a                	sd	s2,0(sp)
 254:	1000                	addi	s0,sp,32
 256:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	4581                	li	a1,0
 25a:	00000097          	auipc	ra,0x0
 25e:	188080e7          	jalr	392(ra) # 3e2 <open>
  if(fd < 0)
 262:	02054563          	bltz	a0,28c <stat+0x42>
 266:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 268:	85ca                	mv	a1,s2
 26a:	00000097          	auipc	ra,0x0
 26e:	180080e7          	jalr	384(ra) # 3ea <fstat>
 272:	892a                	mv	s2,a0
  close(fd);
 274:	8526                	mv	a0,s1
 276:	00000097          	auipc	ra,0x0
 27a:	154080e7          	jalr	340(ra) # 3ca <close>
  return r;
}
 27e:	854a                	mv	a0,s2
 280:	60e2                	ld	ra,24(sp)
 282:	6442                	ld	s0,16(sp)
 284:	64a2                	ld	s1,8(sp)
 286:	6902                	ld	s2,0(sp)
 288:	6105                	addi	sp,sp,32
 28a:	8082                	ret
    return -1;
 28c:	597d                	li	s2,-1
 28e:	bfc5                	j	27e <stat+0x34>

0000000000000290 <atoi>:

int
atoi(const char *s)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 296:	00054703          	lbu	a4,0(a0)
 29a:	02d00793          	li	a5,45
  int neg = 1;
 29e:	4585                	li	a1,1
  if (*s == '-') {
 2a0:	04f70363          	beq	a4,a5,2e6 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 2a4:	00054703          	lbu	a4,0(a0)
 2a8:	fd07079b          	addiw	a5,a4,-48
 2ac:	0ff7f793          	zext.b	a5,a5
 2b0:	46a5                	li	a3,9
 2b2:	02f6ed63          	bltu	a3,a5,2ec <atoi+0x5c>
  n = 0;
 2b6:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 2b8:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 2ba:	0505                	addi	a0,a0,1
 2bc:	0026979b          	slliw	a5,a3,0x2
 2c0:	9fb5                	addw	a5,a5,a3
 2c2:	0017979b          	slliw	a5,a5,0x1
 2c6:	9fb9                	addw	a5,a5,a4
 2c8:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 2cc:	00054703          	lbu	a4,0(a0)
 2d0:	fd07079b          	addiw	a5,a4,-48
 2d4:	0ff7f793          	zext.b	a5,a5
 2d8:	fef671e3          	bgeu	a2,a5,2ba <atoi+0x2a>
  return n * neg;
}
 2dc:	02d5853b          	mulw	a0,a1,a3
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
    s++;
 2e6:	0505                	addi	a0,a0,1
    neg = -1;
 2e8:	55fd                	li	a1,-1
 2ea:	bf6d                	j	2a4 <atoi+0x14>
  n = 0;
 2ec:	4681                	li	a3,0
 2ee:	b7fd                	j	2dc <atoi+0x4c>

00000000000002f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2f6:	02b57463          	bgeu	a0,a1,31e <memmove+0x2e>
    while(n-- > 0)
 2fa:	00c05f63          	blez	a2,318 <memmove+0x28>
 2fe:	1602                	slli	a2,a2,0x20
 300:	9201                	srli	a2,a2,0x20
 302:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 306:	872a                	mv	a4,a0
      *dst++ = *src++;
 308:	0585                	addi	a1,a1,1
 30a:	0705                	addi	a4,a4,1
 30c:	fff5c683          	lbu	a3,-1(a1)
 310:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 314:	fee79ae3          	bne	a5,a4,308 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	addi	sp,sp,16
 31c:	8082                	ret
    dst += n;
 31e:	00c50733          	add	a4,a0,a2
    src += n;
 322:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 324:	fec05ae3          	blez	a2,318 <memmove+0x28>
 328:	fff6079b          	addiw	a5,a2,-1
 32c:	1782                	slli	a5,a5,0x20
 32e:	9381                	srli	a5,a5,0x20
 330:	fff7c793          	not	a5,a5
 334:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 336:	15fd                	addi	a1,a1,-1
 338:	177d                	addi	a4,a4,-1
 33a:	0005c683          	lbu	a3,0(a1)
 33e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 342:	fee79ae3          	bne	a5,a4,336 <memmove+0x46>
 346:	bfc9                	j	318 <memmove+0x28>

0000000000000348 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e422                	sd	s0,8(sp)
 34c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 34e:	ca05                	beqz	a2,37e <memcmp+0x36>
 350:	fff6069b          	addiw	a3,a2,-1
 354:	1682                	slli	a3,a3,0x20
 356:	9281                	srli	a3,a3,0x20
 358:	0685                	addi	a3,a3,1
 35a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 35c:	00054783          	lbu	a5,0(a0)
 360:	0005c703          	lbu	a4,0(a1)
 364:	00e79863          	bne	a5,a4,374 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 368:	0505                	addi	a0,a0,1
    p2++;
 36a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 36c:	fed518e3          	bne	a0,a3,35c <memcmp+0x14>
  }
  return 0;
 370:	4501                	li	a0,0
 372:	a019                	j	378 <memcmp+0x30>
      return *p1 - *p2;
 374:	40e7853b          	subw	a0,a5,a4
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret
  return 0;
 37e:	4501                	li	a0,0
 380:	bfe5                	j	378 <memcmp+0x30>

0000000000000382 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 382:	1141                	addi	sp,sp,-16
 384:	e406                	sd	ra,8(sp)
 386:	e022                	sd	s0,0(sp)
 388:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 38a:	00000097          	auipc	ra,0x0
 38e:	f66080e7          	jalr	-154(ra) # 2f0 <memmove>
}
 392:	60a2                	ld	ra,8(sp)
 394:	6402                	ld	s0,0(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 39a:	4885                	li	a7,1
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3a2:	4889                	li	a7,2
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <wait>:
.global wait
wait:
 li a7, SYS_wait
 3aa:	488d                	li	a7,3
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3b2:	4891                	li	a7,4
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <read>:
.global read
read:
 li a7, SYS_read
 3ba:	4895                	li	a7,5
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <write>:
.global write
write:
 li a7, SYS_write
 3c2:	48c1                	li	a7,16
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <close>:
.global close
close:
 li a7, SYS_close
 3ca:	48d5                	li	a7,21
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3d2:	4899                	li	a7,6
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <exec>:
.global exec
exec:
 li a7, SYS_exec
 3da:	489d                	li	a7,7
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <open>:
.global open
open:
 li a7, SYS_open
 3e2:	48bd                	li	a7,15
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ea:	48a1                	li	a7,8
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f2:	48d1                	li	a7,20
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fa:	48a5                	li	a7,9
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <dup>:
.global dup
dup:
 li a7, SYS_dup
 402:	48a9                	li	a7,10
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40a:	48ad                	li	a7,11
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 412:	48b1                	li	a7,12
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 41a:	48b5                	li	a7,13
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 422:	48b9                	li	a7,14
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 42a:	48d9                	li	a7,22
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <dev>:
.global dev
dev:
 li a7, SYS_dev
 432:	48dd                	li	a7,23
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 43a:	48e1                	li	a7,24
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 442:	48e5                	li	a7,25
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <remove>:
.global remove
remove:
 li a7, SYS_remove
 44a:	48c5                	li	a7,17
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <trace>:
.global trace
trace:
 li a7, SYS_trace
 452:	48c9                	li	a7,18
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 45a:	48cd                	li	a7,19
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <rename>:
.global rename
rename:
 li a7, SYS_rename
 462:	48e9                	li	a7,26
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 46a:	48ed                	li	a7,27
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 472:	48f1                	li	a7,28
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 47a:	48f5                	li	a7,29
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 482:	48f9                	li	a7,30
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 48a:	48fd                	li	a7,31
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 492:	02000893          	li	a7,32
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 49c:	02100893          	li	a7,33
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 4a6:	02200893          	li	a7,34
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 4b0:	02300893          	li	a7,35
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 4ba:	02400893          	li	a7,36
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4c4:	02500893          	li	a7,37
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4ce:	02600893          	li	a7,38
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 4d8:	02700893          	li	a7,39
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 4e2:	02800893          	li	a7,40
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 4ec:	02900893          	li	a7,41
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 4f6:	02a00893          	li	a7,42
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 500:	02b00893          	li	a7,43
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 50a:	02c00893          	li	a7,44
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 514:	02d00893          	li	a7,45
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 51e:	02e00893          	li	a7,46
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 528:	02f00893          	li	a7,47
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 532:	03000893          	li	a7,48
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 53c:	03100893          	li	a7,49
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 546:	03200893          	li	a7,50
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 550:	03300893          	li	a7,51
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 55a:	03400893          	li	a7,52
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 564:	03500893          	li	a7,53
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 56e:	03600893          	li	a7,54
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 578:	03700893          	li	a7,55
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 582:	03800893          	li	a7,56
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 58c:	03900893          	li	a7,57
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 596:	03a00893          	li	a7,58
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <poll>:
.global poll
poll:
 li a7, SYS_poll
 5a0:	03b00893          	li	a7,59
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 5aa:	03c00893          	li	a7,60
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 5b4:	03d00893          	li	a7,61
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 5be:	03e00893          	li	a7,62
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <clone>:
.global clone
clone:
 li a7, SYS_clone
 5c8:	03f00893          	li	a7,63
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <futex>:
.global futex
futex:
 li a7, SYS_futex
 5d2:	04000893          	li	a7,64
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 5dc:	04100893          	li	a7,65
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <halt>:
.global halt
halt:
 li a7, SYS_halt
 5e6:	04200893          	li	a7,66
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 5f0:	04300893          	li	a7,67
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <socket>:
.global socket
socket:
 li a7, SYS_socket
 5fa:	04400893          	li	a7,68
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <bind>:
.global bind
bind:
 li a7, SYS_bind
 604:	04500893          	li	a7,69
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <listen>:
.global listen
listen:
 li a7, SYS_listen
 60e:	04600893          	li	a7,70
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <accept>:
.global accept
accept:
 li a7, SYS_accept
 618:	04700893          	li	a7,71
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <connect>:
.global connect
connect:
 li a7, SYS_connect
 622:	04800893          	li	a7,72
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <send>:
.global send
send:
 li a7, SYS_send
 62c:	04900893          	li	a7,73
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <recv>:
.global recv
recv:
 li a7, SYS_recv
 636:	04a00893          	li	a7,74
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 640:	04b00893          	li	a7,75
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 64a:	1101                	addi	sp,sp,-32
 64c:	ec06                	sd	ra,24(sp)
 64e:	e822                	sd	s0,16(sp)
 650:	1000                	addi	s0,sp,32
 652:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 656:	4605                	li	a2,1
 658:	fef40593          	addi	a1,s0,-17
 65c:	00000097          	auipc	ra,0x0
 660:	d66080e7          	jalr	-666(ra) # 3c2 <write>
}
 664:	60e2                	ld	ra,24(sp)
 666:	6442                	ld	s0,16(sp)
 668:	6105                	addi	sp,sp,32
 66a:	8082                	ret

000000000000066c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 66c:	7139                	addi	sp,sp,-64
 66e:	fc06                	sd	ra,56(sp)
 670:	f822                	sd	s0,48(sp)
 672:	f426                	sd	s1,40(sp)
 674:	f04a                	sd	s2,32(sp)
 676:	ec4e                	sd	s3,24(sp)
 678:	0080                	addi	s0,sp,64
 67a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 67c:	c299                	beqz	a3,682 <printint+0x16>
 67e:	0805c863          	bltz	a1,70e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 682:	2581                	sext.w	a1,a1
  neg = 0;
 684:	4881                	li	a7,0
  }

  i = 0;
 686:	fc040993          	addi	s3,s0,-64
  neg = 0;
 68a:	86ce                	mv	a3,s3
  i = 0;
 68c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 68e:	2601                	sext.w	a2,a2
 690:	00000517          	auipc	a0,0x0
 694:	5e050513          	addi	a0,a0,1504 # c70 <digits>
 698:	883a                	mv	a6,a4
 69a:	2705                	addiw	a4,a4,1
 69c:	02c5f7bb          	remuw	a5,a1,a2
 6a0:	1782                	slli	a5,a5,0x20
 6a2:	9381                	srli	a5,a5,0x20
 6a4:	97aa                	add	a5,a5,a0
 6a6:	0007c783          	lbu	a5,0(a5)
 6aa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ae:	0005879b          	sext.w	a5,a1
 6b2:	02c5d5bb          	divuw	a1,a1,a2
 6b6:	0685                	addi	a3,a3,1
 6b8:	fec7f0e3          	bgeu	a5,a2,698 <printint+0x2c>
  if(neg)
 6bc:	00088c63          	beqz	a7,6d4 <printint+0x68>
    buf[i++] = '-';
 6c0:	fd070793          	addi	a5,a4,-48
 6c4:	00878733          	add	a4,a5,s0
 6c8:	02d00793          	li	a5,45
 6cc:	fef70823          	sb	a5,-16(a4)
 6d0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6d4:	02e05663          	blez	a4,700 <printint+0x94>
 6d8:	fc040913          	addi	s2,s0,-64
 6dc:	993a                	add	s2,s2,a4
 6de:	19fd                	addi	s3,s3,-1
 6e0:	99ba                	add	s3,s3,a4
 6e2:	377d                	addiw	a4,a4,-1
 6e4:	1702                	slli	a4,a4,0x20
 6e6:	9301                	srli	a4,a4,0x20
 6e8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ec:	fff94583          	lbu	a1,-1(s2)
 6f0:	8526                	mv	a0,s1
 6f2:	00000097          	auipc	ra,0x0
 6f6:	f58080e7          	jalr	-168(ra) # 64a <putc>
  while(--i >= 0)
 6fa:	197d                	addi	s2,s2,-1
 6fc:	ff3918e3          	bne	s2,s3,6ec <printint+0x80>
}
 700:	70e2                	ld	ra,56(sp)
 702:	7442                	ld	s0,48(sp)
 704:	74a2                	ld	s1,40(sp)
 706:	7902                	ld	s2,32(sp)
 708:	69e2                	ld	s3,24(sp)
 70a:	6121                	addi	sp,sp,64
 70c:	8082                	ret
    x = -xx;
 70e:	40b005bb          	negw	a1,a1
    neg = 1;
 712:	4885                	li	a7,1
    x = -xx;
 714:	bf8d                	j	686 <printint+0x1a>

0000000000000716 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 716:	7119                	addi	sp,sp,-128
 718:	fc86                	sd	ra,120(sp)
 71a:	f8a2                	sd	s0,112(sp)
 71c:	f4a6                	sd	s1,104(sp)
 71e:	f0ca                	sd	s2,96(sp)
 720:	ecce                	sd	s3,88(sp)
 722:	e8d2                	sd	s4,80(sp)
 724:	e4d6                	sd	s5,72(sp)
 726:	e0da                	sd	s6,64(sp)
 728:	fc5e                	sd	s7,56(sp)
 72a:	f862                	sd	s8,48(sp)
 72c:	f466                	sd	s9,40(sp)
 72e:	f06a                	sd	s10,32(sp)
 730:	ec6e                	sd	s11,24(sp)
 732:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 734:	0005c903          	lbu	s2,0(a1)
 738:	18090f63          	beqz	s2,8d6 <vprintf+0x1c0>
 73c:	8aaa                	mv	s5,a0
 73e:	8b32                	mv	s6,a2
 740:	00158493          	addi	s1,a1,1
  state = 0;
 744:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 746:	02500a13          	li	s4,37
 74a:	4c55                	li	s8,21
 74c:	00000c97          	auipc	s9,0x0
 750:	4ccc8c93          	addi	s9,s9,1228 # c18 <malloc+0x23e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 754:	02800d93          	li	s11,40
  putc(fd, 'x');
 758:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75a:	00000b97          	auipc	s7,0x0
 75e:	516b8b93          	addi	s7,s7,1302 # c70 <digits>
 762:	a839                	j	780 <vprintf+0x6a>
        putc(fd, c);
 764:	85ca                	mv	a1,s2
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	ee2080e7          	jalr	-286(ra) # 64a <putc>
 770:	a019                	j	776 <vprintf+0x60>
    } else if(state == '%'){
 772:	01498d63          	beq	s3,s4,78c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 776:	0485                	addi	s1,s1,1
 778:	fff4c903          	lbu	s2,-1(s1)
 77c:	14090d63          	beqz	s2,8d6 <vprintf+0x1c0>
    if(state == 0){
 780:	fe0999e3          	bnez	s3,772 <vprintf+0x5c>
      if(c == '%'){
 784:	ff4910e3          	bne	s2,s4,764 <vprintf+0x4e>
        state = '%';
 788:	89d2                	mv	s3,s4
 78a:	b7f5                	j	776 <vprintf+0x60>
      if(c == 'd'){
 78c:	11490c63          	beq	s2,s4,8a4 <vprintf+0x18e>
 790:	f9d9079b          	addiw	a5,s2,-99
 794:	0ff7f793          	zext.b	a5,a5
 798:	10fc6e63          	bltu	s8,a5,8b4 <vprintf+0x19e>
 79c:	f9d9079b          	addiw	a5,s2,-99
 7a0:	0ff7f713          	zext.b	a4,a5
 7a4:	10ec6863          	bltu	s8,a4,8b4 <vprintf+0x19e>
 7a8:	00271793          	slli	a5,a4,0x2
 7ac:	97e6                	add	a5,a5,s9
 7ae:	439c                	lw	a5,0(a5)
 7b0:	97e6                	add	a5,a5,s9
 7b2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7b4:	008b0913          	addi	s2,s6,8
 7b8:	4685                	li	a3,1
 7ba:	4629                	li	a2,10
 7bc:	000b2583          	lw	a1,0(s6)
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	eaa080e7          	jalr	-342(ra) # 66c <printint>
 7ca:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b765                	j	776 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d0:	008b0913          	addi	s2,s6,8
 7d4:	4681                	li	a3,0
 7d6:	4629                	li	a2,10
 7d8:	000b2583          	lw	a1,0(s6)
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	e8e080e7          	jalr	-370(ra) # 66c <printint>
 7e6:	8b4a                	mv	s6,s2
      state = 0;
 7e8:	4981                	li	s3,0
 7ea:	b771                	j	776 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7ec:	008b0913          	addi	s2,s6,8
 7f0:	4681                	li	a3,0
 7f2:	866a                	mv	a2,s10
 7f4:	000b2583          	lw	a1,0(s6)
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e72080e7          	jalr	-398(ra) # 66c <printint>
 802:	8b4a                	mv	s6,s2
      state = 0;
 804:	4981                	li	s3,0
 806:	bf85                	j	776 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 808:	008b0793          	addi	a5,s6,8
 80c:	f8f43423          	sd	a5,-120(s0)
 810:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 814:	03000593          	li	a1,48
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	e30080e7          	jalr	-464(ra) # 64a <putc>
  putc(fd, 'x');
 822:	07800593          	li	a1,120
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	e22080e7          	jalr	-478(ra) # 64a <putc>
 830:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 832:	03c9d793          	srli	a5,s3,0x3c
 836:	97de                	add	a5,a5,s7
 838:	0007c583          	lbu	a1,0(a5)
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	e0c080e7          	jalr	-500(ra) # 64a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 846:	0992                	slli	s3,s3,0x4
 848:	397d                	addiw	s2,s2,-1
 84a:	fe0914e3          	bnez	s2,832 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 84e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 852:	4981                	li	s3,0
 854:	b70d                	j	776 <vprintf+0x60>
        s = va_arg(ap, char*);
 856:	008b0913          	addi	s2,s6,8
 85a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 85e:	02098163          	beqz	s3,880 <vprintf+0x16a>
        while(*s != 0){
 862:	0009c583          	lbu	a1,0(s3)
 866:	c5ad                	beqz	a1,8d0 <vprintf+0x1ba>
          putc(fd, *s);
 868:	8556                	mv	a0,s5
 86a:	00000097          	auipc	ra,0x0
 86e:	de0080e7          	jalr	-544(ra) # 64a <putc>
          s++;
 872:	0985                	addi	s3,s3,1
        while(*s != 0){
 874:	0009c583          	lbu	a1,0(s3)
 878:	f9e5                	bnez	a1,868 <vprintf+0x152>
        s = va_arg(ap, char*);
 87a:	8b4a                	mv	s6,s2
      state = 0;
 87c:	4981                	li	s3,0
 87e:	bde5                	j	776 <vprintf+0x60>
          s = "(null)";
 880:	00000997          	auipc	s3,0x0
 884:	39098993          	addi	s3,s3,912 # c10 <malloc+0x236>
        while(*s != 0){
 888:	85ee                	mv	a1,s11
 88a:	bff9                	j	868 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 88c:	008b0913          	addi	s2,s6,8
 890:	000b4583          	lbu	a1,0(s6)
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	db4080e7          	jalr	-588(ra) # 64a <putc>
 89e:	8b4a                	mv	s6,s2
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	bdd1                	j	776 <vprintf+0x60>
        putc(fd, c);
 8a4:	85d2                	mv	a1,s4
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	da2080e7          	jalr	-606(ra) # 64a <putc>
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b5d1                	j	776 <vprintf+0x60>
        putc(fd, '%');
 8b4:	85d2                	mv	a1,s4
 8b6:	8556                	mv	a0,s5
 8b8:	00000097          	auipc	ra,0x0
 8bc:	d92080e7          	jalr	-622(ra) # 64a <putc>
        putc(fd, c);
 8c0:	85ca                	mv	a1,s2
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	d86080e7          	jalr	-634(ra) # 64a <putc>
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	b565                	j	776 <vprintf+0x60>
        s = va_arg(ap, char*);
 8d0:	8b4a                	mv	s6,s2
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	b54d                	j	776 <vprintf+0x60>
    }
  }
}
 8d6:	70e6                	ld	ra,120(sp)
 8d8:	7446                	ld	s0,112(sp)
 8da:	74a6                	ld	s1,104(sp)
 8dc:	7906                	ld	s2,96(sp)
 8de:	69e6                	ld	s3,88(sp)
 8e0:	6a46                	ld	s4,80(sp)
 8e2:	6aa6                	ld	s5,72(sp)
 8e4:	6b06                	ld	s6,64(sp)
 8e6:	7be2                	ld	s7,56(sp)
 8e8:	7c42                	ld	s8,48(sp)
 8ea:	7ca2                	ld	s9,40(sp)
 8ec:	7d02                	ld	s10,32(sp)
 8ee:	6de2                	ld	s11,24(sp)
 8f0:	6109                	addi	sp,sp,128
 8f2:	8082                	ret

00000000000008f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f4:	715d                	addi	sp,sp,-80
 8f6:	ec06                	sd	ra,24(sp)
 8f8:	e822                	sd	s0,16(sp)
 8fa:	1000                	addi	s0,sp,32
 8fc:	e010                	sd	a2,0(s0)
 8fe:	e414                	sd	a3,8(s0)
 900:	e818                	sd	a4,16(s0)
 902:	ec1c                	sd	a5,24(s0)
 904:	03043023          	sd	a6,32(s0)
 908:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90c:	8622                	mv	a2,s0
 90e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 912:	00000097          	auipc	ra,0x0
 916:	e04080e7          	jalr	-508(ra) # 716 <vprintf>
}
 91a:	60e2                	ld	ra,24(sp)
 91c:	6442                	ld	s0,16(sp)
 91e:	6161                	addi	sp,sp,80
 920:	8082                	ret

0000000000000922 <printf>:

void
printf(const char *fmt, ...)
{
 922:	711d                	addi	sp,sp,-96
 924:	ec06                	sd	ra,24(sp)
 926:	e822                	sd	s0,16(sp)
 928:	1000                	addi	s0,sp,32
 92a:	e40c                	sd	a1,8(s0)
 92c:	e810                	sd	a2,16(s0)
 92e:	ec14                	sd	a3,24(s0)
 930:	f018                	sd	a4,32(s0)
 932:	f41c                	sd	a5,40(s0)
 934:	03043823          	sd	a6,48(s0)
 938:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 93c:	00840613          	addi	a2,s0,8
 940:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 944:	85aa                	mv	a1,a0
 946:	4505                	li	a0,1
 948:	00000097          	auipc	ra,0x0
 94c:	dce080e7          	jalr	-562(ra) # 716 <vprintf>
}
 950:	60e2                	ld	ra,24(sp)
 952:	6442                	ld	s0,16(sp)
 954:	6125                	addi	sp,sp,96
 956:	8082                	ret

0000000000000958 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 958:	1141                	addi	sp,sp,-16
 95a:	e422                	sd	s0,8(sp)
 95c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 95e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 962:	00000797          	auipc	a5,0x0
 966:	3267b783          	ld	a5,806(a5) # c88 <freep>
 96a:	a02d                	j	994 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 96c:	4618                	lw	a4,8(a2)
 96e:	9f2d                	addw	a4,a4,a1
 970:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 974:	6398                	ld	a4,0(a5)
 976:	6310                	ld	a2,0(a4)
 978:	a83d                	j	9b6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 97a:	ff852703          	lw	a4,-8(a0)
 97e:	9f31                	addw	a4,a4,a2
 980:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 982:	ff053683          	ld	a3,-16(a0)
 986:	a091                	j	9ca <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 988:	6398                	ld	a4,0(a5)
 98a:	00e7e463          	bltu	a5,a4,992 <free+0x3a>
 98e:	00e6ea63          	bltu	a3,a4,9a2 <free+0x4a>
{
 992:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 994:	fed7fae3          	bgeu	a5,a3,988 <free+0x30>
 998:	6398                	ld	a4,0(a5)
 99a:	00e6e463          	bltu	a3,a4,9a2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 99e:	fee7eae3          	bltu	a5,a4,992 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9a2:	ff852583          	lw	a1,-8(a0)
 9a6:	6390                	ld	a2,0(a5)
 9a8:	02059813          	slli	a6,a1,0x20
 9ac:	01c85713          	srli	a4,a6,0x1c
 9b0:	9736                	add	a4,a4,a3
 9b2:	fae60de3          	beq	a2,a4,96c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9b6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9ba:	4790                	lw	a2,8(a5)
 9bc:	02061593          	slli	a1,a2,0x20
 9c0:	01c5d713          	srli	a4,a1,0x1c
 9c4:	973e                	add	a4,a4,a5
 9c6:	fae68ae3          	beq	a3,a4,97a <free+0x22>
    p->s.ptr = bp->s.ptr;
 9ca:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9cc:	00000717          	auipc	a4,0x0
 9d0:	2af73e23          	sd	a5,700(a4) # c88 <freep>
}
 9d4:	6422                	ld	s0,8(sp)
 9d6:	0141                	addi	sp,sp,16
 9d8:	8082                	ret

00000000000009da <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9da:	7139                	addi	sp,sp,-64
 9dc:	fc06                	sd	ra,56(sp)
 9de:	f822                	sd	s0,48(sp)
 9e0:	f426                	sd	s1,40(sp)
 9e2:	f04a                	sd	s2,32(sp)
 9e4:	ec4e                	sd	s3,24(sp)
 9e6:	e852                	sd	s4,16(sp)
 9e8:	e456                	sd	s5,8(sp)
 9ea:	e05a                	sd	s6,0(sp)
 9ec:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ee:	02051493          	slli	s1,a0,0x20
 9f2:	9081                	srli	s1,s1,0x20
 9f4:	04bd                	addi	s1,s1,15
 9f6:	8091                	srli	s1,s1,0x4
 9f8:	00148a1b          	addiw	s4,s1,1
 9fc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9fe:	00000517          	auipc	a0,0x0
 a02:	28a53503          	ld	a0,650(a0) # c88 <freep>
 a06:	c515                	beqz	a0,a32 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a08:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a0a:	4798                	lw	a4,8(a5)
 a0c:	04977163          	bgeu	a4,s1,a4e <malloc+0x74>
 a10:	89d2                	mv	s3,s4
 a12:	000a071b          	sext.w	a4,s4
 a16:	6685                	lui	a3,0x1
 a18:	00d77363          	bgeu	a4,a3,a1e <malloc+0x44>
 a1c:	6985                	lui	s3,0x1
 a1e:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 a22:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a26:	00000917          	auipc	s2,0x0
 a2a:	26290913          	addi	s2,s2,610 # c88 <freep>
  if(p == (char*)-1)
 a2e:	5afd                	li	s5,-1
 a30:	a8a5                	j	aa8 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 a32:	00000797          	auipc	a5,0x0
 a36:	25678793          	addi	a5,a5,598 # c88 <freep>
 a3a:	00000717          	auipc	a4,0x0
 a3e:	25670713          	addi	a4,a4,598 # c90 <base>
 a42:	e398                	sd	a4,0(a5)
 a44:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 a46:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a4a:	87ba                	mv	a5,a4
 a4c:	b7d1                	j	a10 <malloc+0x36>
      if(p->s.size == nunits)
 a4e:	02e48c63          	beq	s1,a4,a86 <malloc+0xac>
        p->s.size -= nunits;
 a52:	4147073b          	subw	a4,a4,s4
 a56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a58:	02071693          	slli	a3,a4,0x20
 a5c:	01c6d713          	srli	a4,a3,0x1c
 a60:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a62:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 a66:	00000717          	auipc	a4,0x0
 a6a:	22a73123          	sd	a0,546(a4) # c88 <freep>
      return (void*)(p + 1);
 a6e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a72:	70e2                	ld	ra,56(sp)
 a74:	7442                	ld	s0,48(sp)
 a76:	74a2                	ld	s1,40(sp)
 a78:	7902                	ld	s2,32(sp)
 a7a:	69e2                	ld	s3,24(sp)
 a7c:	6a42                	ld	s4,16(sp)
 a7e:	6aa2                	ld	s5,8(sp)
 a80:	6b02                	ld	s6,0(sp)
 a82:	6121                	addi	sp,sp,64
 a84:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a86:	6398                	ld	a4,0(a5)
 a88:	e118                	sd	a4,0(a0)
 a8a:	bff1                	j	a66 <malloc+0x8c>
  hp->s.size = nu;
 a8c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a90:	0541                	addi	a0,a0,16
 a92:	00000097          	auipc	ra,0x0
 a96:	ec6080e7          	jalr	-314(ra) # 958 <free>
  return freep;
 a9a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a9e:	d971                	beqz	a0,a72 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aa2:	4798                	lw	a4,8(a5)
 aa4:	fa9775e3          	bgeu	a4,s1,a4e <malloc+0x74>
    if(p == freep)
 aa8:	00093703          	ld	a4,0(s2)
 aac:	853e                	mv	a0,a5
 aae:	fef719e3          	bne	a4,a5,aa0 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 ab2:	854e                	mv	a0,s3
 ab4:	00000097          	auipc	ra,0x0
 ab8:	95e080e7          	jalr	-1698(ra) # 412 <sbrk>
  if(p == (char*)-1)
 abc:	fd5518e3          	bne	a0,s5,a8c <malloc+0xb2>
        return 0;
 ac0:	4501                	li	a0,0
 ac2:	bf45                	j	a72 <malloc+0x98>
