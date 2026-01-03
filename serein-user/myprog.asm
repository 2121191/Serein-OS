
serein-user/_myprog：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
// serein-user/myprog.c
#include "user.h"

int main(int argc, char **argv)
{
   0:	7135                	addi	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	1100                	addi	s0,sp,160
  printf("myprog: hello from pid %d\n", getpid());
   a:	00000097          	auipc	ra,0x0
   e:	474080e7          	jalr	1140(ra) # 47e <getpid>
  12:	85aa                	mv	a1,a0
  14:	00001517          	auipc	a0,0x1
  18:	b2450513          	addi	a0,a0,-1244 # b38 <malloc+0xea>
  1c:	00001097          	auipc	ra,0x1
  20:	97a080e7          	jalr	-1670(ra) # 996 <printf>

  // 测试：创建并写文件
  int fd = open("testfile.txt", O_CREATE | O_RDWR);
  24:	20200593          	li	a1,514
  28:	00001517          	auipc	a0,0x1
  2c:	b3050513          	addi	a0,a0,-1232 # b58 <malloc+0x10a>
  30:	00000097          	auipc	ra,0x0
  34:	426080e7          	jalr	1062(ra) # 456 <open>
  if (fd < 0) {
  38:	0a054163          	bltz	a0,da <main+0xda>
  3c:	84aa                	mv	s1,a0
    printf("myprog: open create failed\n");
    exit(1);
  }
  char *msg = "Hello Serein OS!\n";
  write(fd, msg, strlen(msg));
  3e:	00001517          	auipc	a0,0x1
  42:	b4a50513          	addi	a0,a0,-1206 # b88 <malloc+0x13a>
  46:	00000097          	auipc	ra,0x0
  4a:	18e080e7          	jalr	398(ra) # 1d4 <strlen>
  4e:	0005061b          	sext.w	a2,a0
  52:	00001597          	auipc	a1,0x1
  56:	b3658593          	addi	a1,a1,-1226 # b88 <malloc+0x13a>
  5a:	8526                	mv	a0,s1
  5c:	00000097          	auipc	ra,0x0
  60:	3da080e7          	jalr	986(ra) # 436 <write>
  close(fd);
  64:	8526                	mv	a0,s1
  66:	00000097          	auipc	ra,0x0
  6a:	3d8080e7          	jalr	984(ra) # 43e <close>

  // 测试：读取文件内容
  fd = open("testfile.txt", O_RDONLY);
  6e:	4581                	li	a1,0
  70:	00001517          	auipc	a0,0x1
  74:	ae850513          	addi	a0,a0,-1304 # b58 <malloc+0x10a>
  78:	00000097          	auipc	ra,0x0
  7c:	3de080e7          	jalr	990(ra) # 456 <open>
  80:	84aa                	mv	s1,a0
  if (fd >= 0) {
  82:	08054a63          	bltz	a0,116 <main+0x116>
    char buf[128];
    int n = read(fd, buf, sizeof(buf) - 1);
  86:	07f00613          	li	a2,127
  8a:	f6040593          	addi	a1,s0,-160
  8e:	00000097          	auipc	ra,0x0
  92:	3a0080e7          	jalr	928(ra) # 42e <read>
    if (n > 0) {
  96:	04a04f63          	bgtz	a0,f4 <main+0xf4>
      buf[n] = 0;
      printf("myprog: read -> %s", buf);
    }
    close(fd);
  9a:	8526                	mv	a0,s1
  9c:	00000097          	auipc	ra,0x0
  a0:	3a2080e7          	jalr	930(ra) # 43e <close>
  } else {
    printf("myprog: open read failed\n");
  }

  // 测试：fork/wait
  int pid = fork();
  a4:	00000097          	auipc	ra,0x0
  a8:	36a080e7          	jalr	874(ra) # 40e <fork>
  ac:	84aa                	mv	s1,a0
  if (pid == 0) {
  ae:	cd2d                	beqz	a0,128 <main+0x128>
    // child
    printf("myprog: child pid %d\n", getpid());
    exit(0);
  } else if (pid > 0) {
  b0:	08a05e63          	blez	a0,14c <main+0x14c>
    wait(0);
  b4:	4501                	li	a0,0
  b6:	00000097          	auipc	ra,0x0
  ba:	368080e7          	jalr	872(ra) # 41e <wait>
    printf("myprog: parent, child %d finished\n", pid);
  be:	85a6                	mv	a1,s1
  c0:	00001517          	auipc	a0,0x1
  c4:	b3050513          	addi	a0,a0,-1232 # bf0 <malloc+0x1a2>
  c8:	00001097          	auipc	ra,0x1
  cc:	8ce080e7          	jalr	-1842(ra) # 996 <printf>
  } else {
    printf("myprog: fork failed\n");
  }

  exit(0);
  d0:	4501                	li	a0,0
  d2:	00000097          	auipc	ra,0x0
  d6:	344080e7          	jalr	836(ra) # 416 <exit>
    printf("myprog: open create failed\n");
  da:	00001517          	auipc	a0,0x1
  de:	a8e50513          	addi	a0,a0,-1394 # b68 <malloc+0x11a>
  e2:	00001097          	auipc	ra,0x1
  e6:	8b4080e7          	jalr	-1868(ra) # 996 <printf>
    exit(1);
  ea:	4505                	li	a0,1
  ec:	00000097          	auipc	ra,0x0
  f0:	32a080e7          	jalr	810(ra) # 416 <exit>
      buf[n] = 0;
  f4:	fe050793          	addi	a5,a0,-32
  f8:	00878533          	add	a0,a5,s0
  fc:	f8050023          	sb	zero,-128(a0)
      printf("myprog: read -> %s", buf);
 100:	f6040593          	addi	a1,s0,-160
 104:	00001517          	auipc	a0,0x1
 108:	a9c50513          	addi	a0,a0,-1380 # ba0 <malloc+0x152>
 10c:	00001097          	auipc	ra,0x1
 110:	88a080e7          	jalr	-1910(ra) # 996 <printf>
 114:	b759                	j	9a <main+0x9a>
    printf("myprog: open read failed\n");
 116:	00001517          	auipc	a0,0x1
 11a:	aa250513          	addi	a0,a0,-1374 # bb8 <malloc+0x16a>
 11e:	00001097          	auipc	ra,0x1
 122:	878080e7          	jalr	-1928(ra) # 996 <printf>
 126:	bfbd                	j	a4 <main+0xa4>
    printf("myprog: child pid %d\n", getpid());
 128:	00000097          	auipc	ra,0x0
 12c:	356080e7          	jalr	854(ra) # 47e <getpid>
 130:	85aa                	mv	a1,a0
 132:	00001517          	auipc	a0,0x1
 136:	aa650513          	addi	a0,a0,-1370 # bd8 <malloc+0x18a>
 13a:	00001097          	auipc	ra,0x1
 13e:	85c080e7          	jalr	-1956(ra) # 996 <printf>
    exit(0);
 142:	4501                	li	a0,0
 144:	00000097          	auipc	ra,0x0
 148:	2d2080e7          	jalr	722(ra) # 416 <exit>
    printf("myprog: fork failed\n");
 14c:	00001517          	auipc	a0,0x1
 150:	acc50513          	addi	a0,a0,-1332 # c18 <malloc+0x1ca>
 154:	00001097          	auipc	ra,0x1
 158:	842080e7          	jalr	-1982(ra) # 996 <printf>
 15c:	bf95                	j	d0 <main+0xd0>

000000000000015e <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 15e:	1141                	addi	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 164:	87aa                	mv	a5,a0
 166:	0585                	addi	a1,a1,1
 168:	0785                	addi	a5,a5,1
 16a:	fff5c703          	lbu	a4,-1(a1)
 16e:	fee78fa3          	sb	a4,-1(a5)
 172:	fb75                	bnez	a4,166 <strcpy+0x8>
    ;
  return os;
}
 174:	6422                	ld	s0,8(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strcat>:

char*
strcat(char *s, const char *t)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 180:	00054783          	lbu	a5,0(a0)
 184:	c385                	beqz	a5,1a4 <strcat+0x2a>
 186:	87aa                	mv	a5,a0
    s++;
 188:	0785                	addi	a5,a5,1
  while(*s)
 18a:	0007c703          	lbu	a4,0(a5)
 18e:	ff6d                	bnez	a4,188 <strcat+0xe>
  while((*s++ = *t++))
 190:	0585                	addi	a1,a1,1
 192:	0785                	addi	a5,a5,1
 194:	fff5c703          	lbu	a4,-1(a1)
 198:	fee78fa3          	sb	a4,-1(a5)
 19c:	fb75                	bnez	a4,190 <strcat+0x16>
    ;
  return os;
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret
  while(*s)
 1a4:	87aa                	mv	a5,a0
 1a6:	b7ed                	j	190 <strcat+0x16>

00000000000001a8 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1ae:	00054783          	lbu	a5,0(a0)
 1b2:	cb91                	beqz	a5,1c6 <strcmp+0x1e>
 1b4:	0005c703          	lbu	a4,0(a1)
 1b8:	00f71763          	bne	a4,a5,1c6 <strcmp+0x1e>
    p++, q++;
 1bc:	0505                	addi	a0,a0,1
 1be:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	fbe5                	bnez	a5,1b4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1c6:	0005c503          	lbu	a0,0(a1)
}
 1ca:	40a7853b          	subw	a0,a5,a0
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret

00000000000001d4 <strlen>:

uint
strlen(const char *s)
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1da:	00054783          	lbu	a5,0(a0)
 1de:	cf91                	beqz	a5,1fa <strlen+0x26>
 1e0:	0505                	addi	a0,a0,1
 1e2:	87aa                	mv	a5,a0
 1e4:	4685                	li	a3,1
 1e6:	9e89                	subw	a3,a3,a0
 1e8:	00f6853b          	addw	a0,a3,a5
 1ec:	0785                	addi	a5,a5,1
 1ee:	fff7c703          	lbu	a4,-1(a5)
 1f2:	fb7d                	bnez	a4,1e8 <strlen+0x14>
    ;
  return n;
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret
  for(n = 0; s[n]; n++)
 1fa:	4501                	li	a0,0
 1fc:	bfe5                	j	1f4 <strlen+0x20>

00000000000001fe <memset>:

void*
memset(void *dst, int c, uint n)
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 204:	ca19                	beqz	a2,21a <memset+0x1c>
 206:	87aa                	mv	a5,a0
 208:	1602                	slli	a2,a2,0x20
 20a:	9201                	srli	a2,a2,0x20
 20c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 210:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 214:	0785                	addi	a5,a5,1
 216:	fee79de3          	bne	a5,a4,210 <memset+0x12>
  }
  return dst;
}
 21a:	6422                	ld	s0,8(sp)
 21c:	0141                	addi	sp,sp,16
 21e:	8082                	ret

0000000000000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	1141                	addi	sp,sp,-16
 222:	e422                	sd	s0,8(sp)
 224:	0800                	addi	s0,sp,16
  for(; *s; s++)
 226:	00054783          	lbu	a5,0(a0)
 22a:	cb99                	beqz	a5,240 <strchr+0x20>
    if(*s == c)
 22c:	00f58763          	beq	a1,a5,23a <strchr+0x1a>
  for(; *s; s++)
 230:	0505                	addi	a0,a0,1
 232:	00054783          	lbu	a5,0(a0)
 236:	fbfd                	bnez	a5,22c <strchr+0xc>
      return (char*)s;
  return 0;
 238:	4501                	li	a0,0
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
  return 0;
 240:	4501                	li	a0,0
 242:	bfe5                	j	23a <strchr+0x1a>

0000000000000244 <gets>:

char*
gets(char *buf, int max)
{
 244:	711d                	addi	sp,sp,-96
 246:	ec86                	sd	ra,88(sp)
 248:	e8a2                	sd	s0,80(sp)
 24a:	e4a6                	sd	s1,72(sp)
 24c:	e0ca                	sd	s2,64(sp)
 24e:	fc4e                	sd	s3,56(sp)
 250:	f852                	sd	s4,48(sp)
 252:	f456                	sd	s5,40(sp)
 254:	f05a                	sd	s6,32(sp)
 256:	ec5e                	sd	s7,24(sp)
 258:	e862                	sd	s8,16(sp)
 25a:	1080                	addi	s0,sp,96
 25c:	8baa                	mv	s7,a0
 25e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 260:	892a                	mv	s2,a0
 262:	4481                	li	s1,0
    cc = read(0, &c, 1);
 264:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 268:	4b29                	li	s6,10
 26a:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 26c:	89a6                	mv	s3,s1
 26e:	2485                	addiw	s1,s1,1
 270:	0344d763          	bge	s1,s4,29e <gets+0x5a>
    cc = read(0, &c, 1);
 274:	4605                	li	a2,1
 276:	85d6                	mv	a1,s5
 278:	4501                	li	a0,0
 27a:	00000097          	auipc	ra,0x0
 27e:	1b4080e7          	jalr	436(ra) # 42e <read>
    if(cc < 1)
 282:	00a05e63          	blez	a0,29e <gets+0x5a>
    buf[i++] = c;
 286:	faf44783          	lbu	a5,-81(s0)
 28a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 28e:	01678763          	beq	a5,s6,29c <gets+0x58>
 292:	0905                	addi	s2,s2,1
 294:	fd879ce3          	bne	a5,s8,26c <gets+0x28>
  for(i=0; i+1 < max; ){
 298:	89a6                	mv	s3,s1
 29a:	a011                	j	29e <gets+0x5a>
 29c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 29e:	99de                	add	s3,s3,s7
 2a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2a4:	855e                	mv	a0,s7
 2a6:	60e6                	ld	ra,88(sp)
 2a8:	6446                	ld	s0,80(sp)
 2aa:	64a6                	ld	s1,72(sp)
 2ac:	6906                	ld	s2,64(sp)
 2ae:	79e2                	ld	s3,56(sp)
 2b0:	7a42                	ld	s4,48(sp)
 2b2:	7aa2                	ld	s5,40(sp)
 2b4:	7b02                	ld	s6,32(sp)
 2b6:	6be2                	ld	s7,24(sp)
 2b8:	6c42                	ld	s8,16(sp)
 2ba:	6125                	addi	sp,sp,96
 2bc:	8082                	ret

00000000000002be <stat>:

int
stat(const char *n, struct stat *st)
{
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e426                	sd	s1,8(sp)
 2c6:	e04a                	sd	s2,0(sp)
 2c8:	1000                	addi	s0,sp,32
 2ca:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2cc:	4581                	li	a1,0
 2ce:	00000097          	auipc	ra,0x0
 2d2:	188080e7          	jalr	392(ra) # 456 <open>
  if(fd < 0)
 2d6:	02054563          	bltz	a0,300 <stat+0x42>
 2da:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2dc:	85ca                	mv	a1,s2
 2de:	00000097          	auipc	ra,0x0
 2e2:	180080e7          	jalr	384(ra) # 45e <fstat>
 2e6:	892a                	mv	s2,a0
  close(fd);
 2e8:	8526                	mv	a0,s1
 2ea:	00000097          	auipc	ra,0x0
 2ee:	154080e7          	jalr	340(ra) # 43e <close>
  return r;
}
 2f2:	854a                	mv	a0,s2
 2f4:	60e2                	ld	ra,24(sp)
 2f6:	6442                	ld	s0,16(sp)
 2f8:	64a2                	ld	s1,8(sp)
 2fa:	6902                	ld	s2,0(sp)
 2fc:	6105                	addi	sp,sp,32
 2fe:	8082                	ret
    return -1;
 300:	597d                	li	s2,-1
 302:	bfc5                	j	2f2 <stat+0x34>

0000000000000304 <atoi>:

int
atoi(const char *s)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 30a:	00054703          	lbu	a4,0(a0)
 30e:	02d00793          	li	a5,45
  int neg = 1;
 312:	4585                	li	a1,1
  if (*s == '-') {
 314:	04f70363          	beq	a4,a5,35a <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 318:	00054703          	lbu	a4,0(a0)
 31c:	fd07079b          	addiw	a5,a4,-48
 320:	0ff7f793          	zext.b	a5,a5
 324:	46a5                	li	a3,9
 326:	02f6ed63          	bltu	a3,a5,360 <atoi+0x5c>
  n = 0;
 32a:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 32c:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 32e:	0505                	addi	a0,a0,1
 330:	0026979b          	slliw	a5,a3,0x2
 334:	9fb5                	addw	a5,a5,a3
 336:	0017979b          	slliw	a5,a5,0x1
 33a:	9fb9                	addw	a5,a5,a4
 33c:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 340:	00054703          	lbu	a4,0(a0)
 344:	fd07079b          	addiw	a5,a4,-48
 348:	0ff7f793          	zext.b	a5,a5
 34c:	fef671e3          	bgeu	a2,a5,32e <atoi+0x2a>
  return n * neg;
}
 350:	02d5853b          	mulw	a0,a1,a3
 354:	6422                	ld	s0,8(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret
    s++;
 35a:	0505                	addi	a0,a0,1
    neg = -1;
 35c:	55fd                	li	a1,-1
 35e:	bf6d                	j	318 <atoi+0x14>
  n = 0;
 360:	4681                	li	a3,0
 362:	b7fd                	j	350 <atoi+0x4c>

0000000000000364 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 36a:	02b57463          	bgeu	a0,a1,392 <memmove+0x2e>
    while(n-- > 0)
 36e:	00c05f63          	blez	a2,38c <memmove+0x28>
 372:	1602                	slli	a2,a2,0x20
 374:	9201                	srli	a2,a2,0x20
 376:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 37a:	872a                	mv	a4,a0
      *dst++ = *src++;
 37c:	0585                	addi	a1,a1,1
 37e:	0705                	addi	a4,a4,1
 380:	fff5c683          	lbu	a3,-1(a1)
 384:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 388:	fee79ae3          	bne	a5,a4,37c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
    dst += n;
 392:	00c50733          	add	a4,a0,a2
    src += n;
 396:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 398:	fec05ae3          	blez	a2,38c <memmove+0x28>
 39c:	fff6079b          	addiw	a5,a2,-1
 3a0:	1782                	slli	a5,a5,0x20
 3a2:	9381                	srli	a5,a5,0x20
 3a4:	fff7c793          	not	a5,a5
 3a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3aa:	15fd                	addi	a1,a1,-1
 3ac:	177d                	addi	a4,a4,-1
 3ae:	0005c683          	lbu	a3,0(a1)
 3b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3b6:	fee79ae3          	bne	a5,a4,3aa <memmove+0x46>
 3ba:	bfc9                	j	38c <memmove+0x28>

00000000000003bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3bc:	1141                	addi	sp,sp,-16
 3be:	e422                	sd	s0,8(sp)
 3c0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c2:	ca05                	beqz	a2,3f2 <memcmp+0x36>
 3c4:	fff6069b          	addiw	a3,a2,-1
 3c8:	1682                	slli	a3,a3,0x20
 3ca:	9281                	srli	a3,a3,0x20
 3cc:	0685                	addi	a3,a3,1
 3ce:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d0:	00054783          	lbu	a5,0(a0)
 3d4:	0005c703          	lbu	a4,0(a1)
 3d8:	00e79863          	bne	a5,a4,3e8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3dc:	0505                	addi	a0,a0,1
    p2++;
 3de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3e0:	fed518e3          	bne	a0,a3,3d0 <memcmp+0x14>
  }
  return 0;
 3e4:	4501                	li	a0,0
 3e6:	a019                	j	3ec <memcmp+0x30>
      return *p1 - *p2;
 3e8:	40e7853b          	subw	a0,a5,a4
}
 3ec:	6422                	ld	s0,8(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret
  return 0;
 3f2:	4501                	li	a0,0
 3f4:	bfe5                	j	3ec <memcmp+0x30>

00000000000003f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e406                	sd	ra,8(sp)
 3fa:	e022                	sd	s0,0(sp)
 3fc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3fe:	00000097          	auipc	ra,0x0
 402:	f66080e7          	jalr	-154(ra) # 364 <memmove>
}
 406:	60a2                	ld	ra,8(sp)
 408:	6402                	ld	s0,0(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret

000000000000040e <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 40e:	4885                	li	a7,1
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <exit>:
.global exit
exit:
 li a7, SYS_exit
 416:	4889                	li	a7,2
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <wait>:
.global wait
wait:
 li a7, SYS_wait
 41e:	488d                	li	a7,3
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 426:	4891                	li	a7,4
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <read>:
.global read
read:
 li a7, SYS_read
 42e:	4895                	li	a7,5
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <write>:
.global write
write:
 li a7, SYS_write
 436:	48c1                	li	a7,16
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <close>:
.global close
close:
 li a7, SYS_close
 43e:	48d5                	li	a7,21
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <kill>:
.global kill
kill:
 li a7, SYS_kill
 446:	4899                	li	a7,6
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <exec>:
.global exec
exec:
 li a7, SYS_exec
 44e:	489d                	li	a7,7
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <open>:
.global open
open:
 li a7, SYS_open
 456:	48bd                	li	a7,15
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 45e:	48a1                	li	a7,8
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 466:	48d1                	li	a7,20
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 46e:	48a5                	li	a7,9
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <dup>:
.global dup
dup:
 li a7, SYS_dup
 476:	48a9                	li	a7,10
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 47e:	48ad                	li	a7,11
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 486:	48b1                	li	a7,12
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 48e:	48b5                	li	a7,13
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 496:	48b9                	li	a7,14
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 49e:	48d9                	li	a7,22
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <dev>:
.global dev
dev:
 li a7, SYS_dev
 4a6:	48dd                	li	a7,23
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4ae:	48e1                	li	a7,24
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4b6:	48e5                	li	a7,25
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <remove>:
.global remove
remove:
 li a7, SYS_remove
 4be:	48c5                	li	a7,17
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 4c6:	48c9                	li	a7,18
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 4ce:	48cd                	li	a7,19
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <rename>:
.global rename
rename:
 li a7, SYS_rename
 4d6:	48e9                	li	a7,26
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 4de:	48ed                	li	a7,27
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 4e6:	48f1                	li	a7,28
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 4ee:	48f5                	li	a7,29
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 4f6:	48f9                	li	a7,30
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 4fe:	48fd                	li	a7,31
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 506:	02000893          	li	a7,32
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 510:	02100893          	li	a7,33
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 51a:	02200893          	li	a7,34
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 524:	02300893          	li	a7,35
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 52e:	02400893          	li	a7,36
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 538:	02500893          	li	a7,37
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 542:	02600893          	li	a7,38
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 54c:	02700893          	li	a7,39
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 556:	02800893          	li	a7,40
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 560:	02900893          	li	a7,41
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 56a:	02a00893          	li	a7,42
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 574:	02b00893          	li	a7,43
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 57e:	02c00893          	li	a7,44
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 588:	02d00893          	li	a7,45
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 592:	02e00893          	li	a7,46
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 59c:	02f00893          	li	a7,47
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 5a6:	03000893          	li	a7,48
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 5b0:	03100893          	li	a7,49
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 5ba:	03200893          	li	a7,50
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 5c4:	03300893          	li	a7,51
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 5ce:	03400893          	li	a7,52
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 5d8:	03500893          	li	a7,53
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 5e2:	03600893          	li	a7,54
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 5ec:	03700893          	li	a7,55
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 5f6:	03800893          	li	a7,56
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 600:	03900893          	li	a7,57
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 60a:	03a00893          	li	a7,58
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <poll>:
.global poll
poll:
 li a7, SYS_poll
 614:	03b00893          	li	a7,59
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 61e:	03c00893          	li	a7,60
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 628:	03d00893          	li	a7,61
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 632:	03e00893          	li	a7,62
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <clone>:
.global clone
clone:
 li a7, SYS_clone
 63c:	03f00893          	li	a7,63
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <futex>:
.global futex
futex:
 li a7, SYS_futex
 646:	04000893          	li	a7,64
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 650:	04100893          	li	a7,65
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <halt>:
.global halt
halt:
 li a7, SYS_halt
 65a:	04200893          	li	a7,66
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 664:	04300893          	li	a7,67
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <socket>:
.global socket
socket:
 li a7, SYS_socket
 66e:	04400893          	li	a7,68
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <bind>:
.global bind
bind:
 li a7, SYS_bind
 678:	04500893          	li	a7,69
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <listen>:
.global listen
listen:
 li a7, SYS_listen
 682:	04600893          	li	a7,70
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <accept>:
.global accept
accept:
 li a7, SYS_accept
 68c:	04700893          	li	a7,71
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <connect>:
.global connect
connect:
 li a7, SYS_connect
 696:	04800893          	li	a7,72
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <send>:
.global send
send:
 li a7, SYS_send
 6a0:	04900893          	li	a7,73
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <recv>:
.global recv
recv:
 li a7, SYS_recv
 6aa:	04a00893          	li	a7,74
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 6b4:	04b00893          	li	a7,75
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6be:	1101                	addi	sp,sp,-32
 6c0:	ec06                	sd	ra,24(sp)
 6c2:	e822                	sd	s0,16(sp)
 6c4:	1000                	addi	s0,sp,32
 6c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6ca:	4605                	li	a2,1
 6cc:	fef40593          	addi	a1,s0,-17
 6d0:	00000097          	auipc	ra,0x0
 6d4:	d66080e7          	jalr	-666(ra) # 436 <write>
}
 6d8:	60e2                	ld	ra,24(sp)
 6da:	6442                	ld	s0,16(sp)
 6dc:	6105                	addi	sp,sp,32
 6de:	8082                	ret

00000000000006e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6e0:	7139                	addi	sp,sp,-64
 6e2:	fc06                	sd	ra,56(sp)
 6e4:	f822                	sd	s0,48(sp)
 6e6:	f426                	sd	s1,40(sp)
 6e8:	f04a                	sd	s2,32(sp)
 6ea:	ec4e                	sd	s3,24(sp)
 6ec:	0080                	addi	s0,sp,64
 6ee:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6f0:	c299                	beqz	a3,6f6 <printint+0x16>
 6f2:	0805c863          	bltz	a1,782 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6f6:	2581                	sext.w	a1,a1
  neg = 0;
 6f8:	4881                	li	a7,0
  }

  i = 0;
 6fa:	fc040993          	addi	s3,s0,-64
  neg = 0;
 6fe:	86ce                	mv	a3,s3
  i = 0;
 700:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 702:	2601                	sext.w	a2,a2
 704:	00000517          	auipc	a0,0x0
 708:	58c50513          	addi	a0,a0,1420 # c90 <digits>
 70c:	883a                	mv	a6,a4
 70e:	2705                	addiw	a4,a4,1
 710:	02c5f7bb          	remuw	a5,a1,a2
 714:	1782                	slli	a5,a5,0x20
 716:	9381                	srli	a5,a5,0x20
 718:	97aa                	add	a5,a5,a0
 71a:	0007c783          	lbu	a5,0(a5)
 71e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 722:	0005879b          	sext.w	a5,a1
 726:	02c5d5bb          	divuw	a1,a1,a2
 72a:	0685                	addi	a3,a3,1
 72c:	fec7f0e3          	bgeu	a5,a2,70c <printint+0x2c>
  if(neg)
 730:	00088c63          	beqz	a7,748 <printint+0x68>
    buf[i++] = '-';
 734:	fd070793          	addi	a5,a4,-48
 738:	00878733          	add	a4,a5,s0
 73c:	02d00793          	li	a5,45
 740:	fef70823          	sb	a5,-16(a4)
 744:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 748:	02e05663          	blez	a4,774 <printint+0x94>
 74c:	fc040913          	addi	s2,s0,-64
 750:	993a                	add	s2,s2,a4
 752:	19fd                	addi	s3,s3,-1
 754:	99ba                	add	s3,s3,a4
 756:	377d                	addiw	a4,a4,-1
 758:	1702                	slli	a4,a4,0x20
 75a:	9301                	srli	a4,a4,0x20
 75c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 760:	fff94583          	lbu	a1,-1(s2)
 764:	8526                	mv	a0,s1
 766:	00000097          	auipc	ra,0x0
 76a:	f58080e7          	jalr	-168(ra) # 6be <putc>
  while(--i >= 0)
 76e:	197d                	addi	s2,s2,-1
 770:	ff3918e3          	bne	s2,s3,760 <printint+0x80>
}
 774:	70e2                	ld	ra,56(sp)
 776:	7442                	ld	s0,48(sp)
 778:	74a2                	ld	s1,40(sp)
 77a:	7902                	ld	s2,32(sp)
 77c:	69e2                	ld	s3,24(sp)
 77e:	6121                	addi	sp,sp,64
 780:	8082                	ret
    x = -xx;
 782:	40b005bb          	negw	a1,a1
    neg = 1;
 786:	4885                	li	a7,1
    x = -xx;
 788:	bf8d                	j	6fa <printint+0x1a>

000000000000078a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 78a:	7119                	addi	sp,sp,-128
 78c:	fc86                	sd	ra,120(sp)
 78e:	f8a2                	sd	s0,112(sp)
 790:	f4a6                	sd	s1,104(sp)
 792:	f0ca                	sd	s2,96(sp)
 794:	ecce                	sd	s3,88(sp)
 796:	e8d2                	sd	s4,80(sp)
 798:	e4d6                	sd	s5,72(sp)
 79a:	e0da                	sd	s6,64(sp)
 79c:	fc5e                	sd	s7,56(sp)
 79e:	f862                	sd	s8,48(sp)
 7a0:	f466                	sd	s9,40(sp)
 7a2:	f06a                	sd	s10,32(sp)
 7a4:	ec6e                	sd	s11,24(sp)
 7a6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7a8:	0005c903          	lbu	s2,0(a1)
 7ac:	18090f63          	beqz	s2,94a <vprintf+0x1c0>
 7b0:	8aaa                	mv	s5,a0
 7b2:	8b32                	mv	s6,a2
 7b4:	00158493          	addi	s1,a1,1
  state = 0;
 7b8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7ba:	02500a13          	li	s4,37
 7be:	4c55                	li	s8,21
 7c0:	00000c97          	auipc	s9,0x0
 7c4:	478c8c93          	addi	s9,s9,1144 # c38 <malloc+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7c8:	02800d93          	li	s11,40
  putc(fd, 'x');
 7cc:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ce:	00000b97          	auipc	s7,0x0
 7d2:	4c2b8b93          	addi	s7,s7,1218 # c90 <digits>
 7d6:	a839                	j	7f4 <vprintf+0x6a>
        putc(fd, c);
 7d8:	85ca                	mv	a1,s2
 7da:	8556                	mv	a0,s5
 7dc:	00000097          	auipc	ra,0x0
 7e0:	ee2080e7          	jalr	-286(ra) # 6be <putc>
 7e4:	a019                	j	7ea <vprintf+0x60>
    } else if(state == '%'){
 7e6:	01498d63          	beq	s3,s4,800 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 7ea:	0485                	addi	s1,s1,1
 7ec:	fff4c903          	lbu	s2,-1(s1)
 7f0:	14090d63          	beqz	s2,94a <vprintf+0x1c0>
    if(state == 0){
 7f4:	fe0999e3          	bnez	s3,7e6 <vprintf+0x5c>
      if(c == '%'){
 7f8:	ff4910e3          	bne	s2,s4,7d8 <vprintf+0x4e>
        state = '%';
 7fc:	89d2                	mv	s3,s4
 7fe:	b7f5                	j	7ea <vprintf+0x60>
      if(c == 'd'){
 800:	11490c63          	beq	s2,s4,918 <vprintf+0x18e>
 804:	f9d9079b          	addiw	a5,s2,-99
 808:	0ff7f793          	zext.b	a5,a5
 80c:	10fc6e63          	bltu	s8,a5,928 <vprintf+0x19e>
 810:	f9d9079b          	addiw	a5,s2,-99
 814:	0ff7f713          	zext.b	a4,a5
 818:	10ec6863          	bltu	s8,a4,928 <vprintf+0x19e>
 81c:	00271793          	slli	a5,a4,0x2
 820:	97e6                	add	a5,a5,s9
 822:	439c                	lw	a5,0(a5)
 824:	97e6                	add	a5,a5,s9
 826:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 828:	008b0913          	addi	s2,s6,8
 82c:	4685                	li	a3,1
 82e:	4629                	li	a2,10
 830:	000b2583          	lw	a1,0(s6)
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	eaa080e7          	jalr	-342(ra) # 6e0 <printint>
 83e:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 840:	4981                	li	s3,0
 842:	b765                	j	7ea <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 844:	008b0913          	addi	s2,s6,8
 848:	4681                	li	a3,0
 84a:	4629                	li	a2,10
 84c:	000b2583          	lw	a1,0(s6)
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	e8e080e7          	jalr	-370(ra) # 6e0 <printint>
 85a:	8b4a                	mv	s6,s2
      state = 0;
 85c:	4981                	li	s3,0
 85e:	b771                	j	7ea <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 860:	008b0913          	addi	s2,s6,8
 864:	4681                	li	a3,0
 866:	866a                	mv	a2,s10
 868:	000b2583          	lw	a1,0(s6)
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	e72080e7          	jalr	-398(ra) # 6e0 <printint>
 876:	8b4a                	mv	s6,s2
      state = 0;
 878:	4981                	li	s3,0
 87a:	bf85                	j	7ea <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 87c:	008b0793          	addi	a5,s6,8
 880:	f8f43423          	sd	a5,-120(s0)
 884:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 888:	03000593          	li	a1,48
 88c:	8556                	mv	a0,s5
 88e:	00000097          	auipc	ra,0x0
 892:	e30080e7          	jalr	-464(ra) # 6be <putc>
  putc(fd, 'x');
 896:	07800593          	li	a1,120
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	e22080e7          	jalr	-478(ra) # 6be <putc>
 8a4:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8a6:	03c9d793          	srli	a5,s3,0x3c
 8aa:	97de                	add	a5,a5,s7
 8ac:	0007c583          	lbu	a1,0(a5)
 8b0:	8556                	mv	a0,s5
 8b2:	00000097          	auipc	ra,0x0
 8b6:	e0c080e7          	jalr	-500(ra) # 6be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ba:	0992                	slli	s3,s3,0x4
 8bc:	397d                	addiw	s2,s2,-1
 8be:	fe0914e3          	bnez	s2,8a6 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 8c2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8c6:	4981                	li	s3,0
 8c8:	b70d                	j	7ea <vprintf+0x60>
        s = va_arg(ap, char*);
 8ca:	008b0913          	addi	s2,s6,8
 8ce:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 8d2:	02098163          	beqz	s3,8f4 <vprintf+0x16a>
        while(*s != 0){
 8d6:	0009c583          	lbu	a1,0(s3)
 8da:	c5ad                	beqz	a1,944 <vprintf+0x1ba>
          putc(fd, *s);
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	de0080e7          	jalr	-544(ra) # 6be <putc>
          s++;
 8e6:	0985                	addi	s3,s3,1
        while(*s != 0){
 8e8:	0009c583          	lbu	a1,0(s3)
 8ec:	f9e5                	bnez	a1,8dc <vprintf+0x152>
        s = va_arg(ap, char*);
 8ee:	8b4a                	mv	s6,s2
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	bde5                	j	7ea <vprintf+0x60>
          s = "(null)";
 8f4:	00000997          	auipc	s3,0x0
 8f8:	33c98993          	addi	s3,s3,828 # c30 <malloc+0x1e2>
        while(*s != 0){
 8fc:	85ee                	mv	a1,s11
 8fe:	bff9                	j	8dc <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 900:	008b0913          	addi	s2,s6,8
 904:	000b4583          	lbu	a1,0(s6)
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	db4080e7          	jalr	-588(ra) # 6be <putc>
 912:	8b4a                	mv	s6,s2
      state = 0;
 914:	4981                	li	s3,0
 916:	bdd1                	j	7ea <vprintf+0x60>
        putc(fd, c);
 918:	85d2                	mv	a1,s4
 91a:	8556                	mv	a0,s5
 91c:	00000097          	auipc	ra,0x0
 920:	da2080e7          	jalr	-606(ra) # 6be <putc>
      state = 0;
 924:	4981                	li	s3,0
 926:	b5d1                	j	7ea <vprintf+0x60>
        putc(fd, '%');
 928:	85d2                	mv	a1,s4
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	d92080e7          	jalr	-622(ra) # 6be <putc>
        putc(fd, c);
 934:	85ca                	mv	a1,s2
 936:	8556                	mv	a0,s5
 938:	00000097          	auipc	ra,0x0
 93c:	d86080e7          	jalr	-634(ra) # 6be <putc>
      state = 0;
 940:	4981                	li	s3,0
 942:	b565                	j	7ea <vprintf+0x60>
        s = va_arg(ap, char*);
 944:	8b4a                	mv	s6,s2
      state = 0;
 946:	4981                	li	s3,0
 948:	b54d                	j	7ea <vprintf+0x60>
    }
  }
}
 94a:	70e6                	ld	ra,120(sp)
 94c:	7446                	ld	s0,112(sp)
 94e:	74a6                	ld	s1,104(sp)
 950:	7906                	ld	s2,96(sp)
 952:	69e6                	ld	s3,88(sp)
 954:	6a46                	ld	s4,80(sp)
 956:	6aa6                	ld	s5,72(sp)
 958:	6b06                	ld	s6,64(sp)
 95a:	7be2                	ld	s7,56(sp)
 95c:	7c42                	ld	s8,48(sp)
 95e:	7ca2                	ld	s9,40(sp)
 960:	7d02                	ld	s10,32(sp)
 962:	6de2                	ld	s11,24(sp)
 964:	6109                	addi	sp,sp,128
 966:	8082                	ret

0000000000000968 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 968:	715d                	addi	sp,sp,-80
 96a:	ec06                	sd	ra,24(sp)
 96c:	e822                	sd	s0,16(sp)
 96e:	1000                	addi	s0,sp,32
 970:	e010                	sd	a2,0(s0)
 972:	e414                	sd	a3,8(s0)
 974:	e818                	sd	a4,16(s0)
 976:	ec1c                	sd	a5,24(s0)
 978:	03043023          	sd	a6,32(s0)
 97c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 980:	8622                	mv	a2,s0
 982:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 986:	00000097          	auipc	ra,0x0
 98a:	e04080e7          	jalr	-508(ra) # 78a <vprintf>
}
 98e:	60e2                	ld	ra,24(sp)
 990:	6442                	ld	s0,16(sp)
 992:	6161                	addi	sp,sp,80
 994:	8082                	ret

0000000000000996 <printf>:

void
printf(const char *fmt, ...)
{
 996:	711d                	addi	sp,sp,-96
 998:	ec06                	sd	ra,24(sp)
 99a:	e822                	sd	s0,16(sp)
 99c:	1000                	addi	s0,sp,32
 99e:	e40c                	sd	a1,8(s0)
 9a0:	e810                	sd	a2,16(s0)
 9a2:	ec14                	sd	a3,24(s0)
 9a4:	f018                	sd	a4,32(s0)
 9a6:	f41c                	sd	a5,40(s0)
 9a8:	03043823          	sd	a6,48(s0)
 9ac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9b0:	00840613          	addi	a2,s0,8
 9b4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9b8:	85aa                	mv	a1,a0
 9ba:	4505                	li	a0,1
 9bc:	00000097          	auipc	ra,0x0
 9c0:	dce080e7          	jalr	-562(ra) # 78a <vprintf>
}
 9c4:	60e2                	ld	ra,24(sp)
 9c6:	6442                	ld	s0,16(sp)
 9c8:	6125                	addi	sp,sp,96
 9ca:	8082                	ret

00000000000009cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9cc:	1141                	addi	sp,sp,-16
 9ce:	e422                	sd	s0,8(sp)
 9d0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9d2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d6:	00000797          	auipc	a5,0x0
 9da:	2d27b783          	ld	a5,722(a5) # ca8 <freep>
 9de:	a02d                	j	a08 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e0:	4618                	lw	a4,8(a2)
 9e2:	9f2d                	addw	a4,a4,a1
 9e4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e8:	6398                	ld	a4,0(a5)
 9ea:	6310                	ld	a2,0(a4)
 9ec:	a83d                	j	a2a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9ee:	ff852703          	lw	a4,-8(a0)
 9f2:	9f31                	addw	a4,a4,a2
 9f4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9f6:	ff053683          	ld	a3,-16(a0)
 9fa:	a091                	j	a3e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9fc:	6398                	ld	a4,0(a5)
 9fe:	00e7e463          	bltu	a5,a4,a06 <free+0x3a>
 a02:	00e6ea63          	bltu	a3,a4,a16 <free+0x4a>
{
 a06:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a08:	fed7fae3          	bgeu	a5,a3,9fc <free+0x30>
 a0c:	6398                	ld	a4,0(a5)
 a0e:	00e6e463          	bltu	a3,a4,a16 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a12:	fee7eae3          	bltu	a5,a4,a06 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a16:	ff852583          	lw	a1,-8(a0)
 a1a:	6390                	ld	a2,0(a5)
 a1c:	02059813          	slli	a6,a1,0x20
 a20:	01c85713          	srli	a4,a6,0x1c
 a24:	9736                	add	a4,a4,a3
 a26:	fae60de3          	beq	a2,a4,9e0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a2a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a2e:	4790                	lw	a2,8(a5)
 a30:	02061593          	slli	a1,a2,0x20
 a34:	01c5d713          	srli	a4,a1,0x1c
 a38:	973e                	add	a4,a4,a5
 a3a:	fae68ae3          	beq	a3,a4,9ee <free+0x22>
    p->s.ptr = bp->s.ptr;
 a3e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a40:	00000717          	auipc	a4,0x0
 a44:	26f73423          	sd	a5,616(a4) # ca8 <freep>
}
 a48:	6422                	ld	s0,8(sp)
 a4a:	0141                	addi	sp,sp,16
 a4c:	8082                	ret

0000000000000a4e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a4e:	7139                	addi	sp,sp,-64
 a50:	fc06                	sd	ra,56(sp)
 a52:	f822                	sd	s0,48(sp)
 a54:	f426                	sd	s1,40(sp)
 a56:	f04a                	sd	s2,32(sp)
 a58:	ec4e                	sd	s3,24(sp)
 a5a:	e852                	sd	s4,16(sp)
 a5c:	e456                	sd	s5,8(sp)
 a5e:	e05a                	sd	s6,0(sp)
 a60:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a62:	02051493          	slli	s1,a0,0x20
 a66:	9081                	srli	s1,s1,0x20
 a68:	04bd                	addi	s1,s1,15
 a6a:	8091                	srli	s1,s1,0x4
 a6c:	00148a1b          	addiw	s4,s1,1
 a70:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a72:	00000517          	auipc	a0,0x0
 a76:	23653503          	ld	a0,566(a0) # ca8 <freep>
 a7a:	c515                	beqz	a0,aa6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a7c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a7e:	4798                	lw	a4,8(a5)
 a80:	04977163          	bgeu	a4,s1,ac2 <malloc+0x74>
 a84:	89d2                	mv	s3,s4
 a86:	000a071b          	sext.w	a4,s4
 a8a:	6685                	lui	a3,0x1
 a8c:	00d77363          	bgeu	a4,a3,a92 <malloc+0x44>
 a90:	6985                	lui	s3,0x1
 a92:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 a96:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a9a:	00000917          	auipc	s2,0x0
 a9e:	20e90913          	addi	s2,s2,526 # ca8 <freep>
  if(p == (char*)-1)
 aa2:	5afd                	li	s5,-1
 aa4:	a8a5                	j	b1c <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 aa6:	00000797          	auipc	a5,0x0
 aaa:	20278793          	addi	a5,a5,514 # ca8 <freep>
 aae:	00000717          	auipc	a4,0x0
 ab2:	20270713          	addi	a4,a4,514 # cb0 <base>
 ab6:	e398                	sd	a4,0(a5)
 ab8:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 aba:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 abe:	87ba                	mv	a5,a4
 ac0:	b7d1                	j	a84 <malloc+0x36>
      if(p->s.size == nunits)
 ac2:	02e48c63          	beq	s1,a4,afa <malloc+0xac>
        p->s.size -= nunits;
 ac6:	4147073b          	subw	a4,a4,s4
 aca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 acc:	02071693          	slli	a3,a4,0x20
 ad0:	01c6d713          	srli	a4,a3,0x1c
 ad4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ad6:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 ada:	00000717          	auipc	a4,0x0
 ade:	1ca73723          	sd	a0,462(a4) # ca8 <freep>
      return (void*)(p + 1);
 ae2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ae6:	70e2                	ld	ra,56(sp)
 ae8:	7442                	ld	s0,48(sp)
 aea:	74a2                	ld	s1,40(sp)
 aec:	7902                	ld	s2,32(sp)
 aee:	69e2                	ld	s3,24(sp)
 af0:	6a42                	ld	s4,16(sp)
 af2:	6aa2                	ld	s5,8(sp)
 af4:	6b02                	ld	s6,0(sp)
 af6:	6121                	addi	sp,sp,64
 af8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 afa:	6398                	ld	a4,0(a5)
 afc:	e118                	sd	a4,0(a0)
 afe:	bff1                	j	ada <malloc+0x8c>
  hp->s.size = nu;
 b00:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b04:	0541                	addi	a0,a0,16
 b06:	00000097          	auipc	ra,0x0
 b0a:	ec6080e7          	jalr	-314(ra) # 9cc <free>
  return freep;
 b0e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b12:	d971                	beqz	a0,ae6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b14:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b16:	4798                	lw	a4,8(a5)
 b18:	fa9775e3          	bgeu	a4,s1,ac2 <malloc+0x74>
    if(p == freep)
 b1c:	00093703          	ld	a4,0(s2)
 b20:	853e                	mv	a0,a5
 b22:	fef719e3          	bne	a4,a5,b14 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 b26:	854e                	mv	a0,s3
 b28:	00000097          	auipc	ra,0x0
 b2c:	95e080e7          	jalr	-1698(ra) # 486 <sbrk>
  if(p == (char*)-1)
 b30:	fd5518e3          	bne	a0,s5,b00 <malloc+0xb2>
        return 0;
 b34:	4501                	li	a0,0
 b36:	bf45                	j	ae6 <malloc+0x98>
