
serein-user/_cp：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <usage>:

#define BUFSIZE 512

void
usage(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  printf("usage: cp src dst\n");
   8:	00001517          	auipc	a0,0x1
   c:	b7850513          	addi	a0,a0,-1160 # b80 <malloc+0xea>
  10:	00001097          	auipc	ra,0x1
  14:	9ce080e7          	jalr	-1586(ra) # 9de <printf>
  exit(1);
  18:	4505                	li	a0,1
  1a:	00000097          	auipc	ra,0x0
  1e:	444080e7          	jalr	1092(ra) # 45e <exit>

0000000000000022 <main>:
}

int
main(int argc, char *argv[])
{
  22:	dc010113          	addi	sp,sp,-576
  26:	22113c23          	sd	ra,568(sp)
  2a:	22813823          	sd	s0,560(sp)
  2e:	22913423          	sd	s1,552(sp)
  32:	23213023          	sd	s2,544(sp)
  36:	21313c23          	sd	s3,536(sp)
  3a:	21413823          	sd	s4,528(sp)
  3e:	21513423          	sd	s5,520(sp)
  42:	21613023          	sd	s6,512(sp)
  46:	0480                	addi	s0,sp,576
  if(argc != 3){
  48:	478d                	li	a5,3
  4a:	00f50663          	beq	a0,a5,56 <main+0x34>
    usage();
  4e:	00000097          	auipc	ra,0x0
  52:	fb2080e7          	jalr	-78(ra) # 0 <usage>
  }

  char *src = argv[1];
  56:	6584                	ld	s1,8(a1)
  char *dst = argv[2];
  58:	0105b903          	ld	s2,16(a1)

  if(strcmp(src, dst) == 0){
  5c:	85ca                	mv	a1,s2
  5e:	8526                	mv	a0,s1
  60:	00000097          	auipc	ra,0x0
  64:	190080e7          	jalr	400(ra) # 1f0 <strcmp>
  68:	ed11                	bnez	a0,84 <main+0x62>
    printf("cp: source and destination are the same\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	b2e50513          	addi	a0,a0,-1234 # b98 <malloc+0x102>
  72:	00001097          	auipc	ra,0x1
  76:	96c080e7          	jalr	-1684(ra) # 9de <printf>
    exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	3e2080e7          	jalr	994(ra) # 45e <exit>
  }

  int fd_src = open(src, 0);
  84:	4581                	li	a1,0
  86:	8526                	mv	a0,s1
  88:	00000097          	auipc	ra,0x0
  8c:	416080e7          	jalr	1046(ra) # 49e <open>
  90:	8aaa                	mv	s5,a0
  if(fd_src < 0){
  92:	04054a63          	bltz	a0,e6 <main+0xc4>
    printf("cp: cannot open %s\n", src);
    exit(1);
  }

  int fd_dst = open(dst, O_CREATE | O_WRONLY | O_TRUNC);
  96:	60100593          	li	a1,1537
  9a:	854a                	mv	a0,s2
  9c:	00000097          	auipc	ra,0x0
  a0:	402080e7          	jalr	1026(ra) # 49e <open>
  a4:	89aa                	mv	s3,a0
  if(fd_dst < 0){
  a6:	04054e63          	bltz	a0,102 <main+0xe0>
    exit(1);
  }

  char buf[BUFSIZE];
  int n;
  while((n = read(fd_src, buf, sizeof(buf))) > 0){
  aa:	dc040a13          	addi	s4,s0,-576
    int written = 0;
  ae:	4b01                	li	s6,0
  while((n = read(fd_src, buf, sizeof(buf))) > 0){
  b0:	20000613          	li	a2,512
  b4:	85d2                	mv	a1,s4
  b6:	8556                	mv	a0,s5
  b8:	00000097          	auipc	ra,0x0
  bc:	3be080e7          	jalr	958(ra) # 476 <read>
  c0:	892a                	mv	s2,a0
  c2:	08a05a63          	blez	a0,156 <main+0x134>
    int written = 0;
  c6:	84da                	mv	s1,s6
    while(written < n){
      int m = write(fd_dst, buf + written, n - written);
  c8:	4099063b          	subw	a2,s2,s1
  cc:	009a05b3          	add	a1,s4,s1
  d0:	854e                	mv	a0,s3
  d2:	00000097          	auipc	ra,0x0
  d6:	3ac080e7          	jalr	940(ra) # 47e <write>
      if(m < 0){
  da:	04054763          	bltz	a0,128 <main+0x106>
        printf("cp: write error\n");
        close(fd_src);
        close(fd_dst);
        exit(1);
      }
      written += m;
  de:	9ca9                	addw	s1,s1,a0
    while(written < n){
  e0:	ff24c4e3          	blt	s1,s2,c8 <main+0xa6>
  e4:	b7f1                	j	b0 <main+0x8e>
    printf("cp: cannot open %s\n", src);
  e6:	85a6                	mv	a1,s1
  e8:	00001517          	auipc	a0,0x1
  ec:	ae050513          	addi	a0,a0,-1312 # bc8 <malloc+0x132>
  f0:	00001097          	auipc	ra,0x1
  f4:	8ee080e7          	jalr	-1810(ra) # 9de <printf>
    exit(1);
  f8:	4505                	li	a0,1
  fa:	00000097          	auipc	ra,0x0
  fe:	364080e7          	jalr	868(ra) # 45e <exit>
    printf("cp: cannot create %s\n", dst);
 102:	85ca                	mv	a1,s2
 104:	00001517          	auipc	a0,0x1
 108:	adc50513          	addi	a0,a0,-1316 # be0 <malloc+0x14a>
 10c:	00001097          	auipc	ra,0x1
 110:	8d2080e7          	jalr	-1838(ra) # 9de <printf>
    close(fd_src);
 114:	8556                	mv	a0,s5
 116:	00000097          	auipc	ra,0x0
 11a:	370080e7          	jalr	880(ra) # 486 <close>
    exit(1);
 11e:	4505                	li	a0,1
 120:	00000097          	auipc	ra,0x0
 124:	33e080e7          	jalr	830(ra) # 45e <exit>
        printf("cp: write error\n");
 128:	00001517          	auipc	a0,0x1
 12c:	ad050513          	addi	a0,a0,-1328 # bf8 <malloc+0x162>
 130:	00001097          	auipc	ra,0x1
 134:	8ae080e7          	jalr	-1874(ra) # 9de <printf>
        close(fd_src);
 138:	8556                	mv	a0,s5
 13a:	00000097          	auipc	ra,0x0
 13e:	34c080e7          	jalr	844(ra) # 486 <close>
        close(fd_dst);
 142:	854e                	mv	a0,s3
 144:	00000097          	auipc	ra,0x0
 148:	342080e7          	jalr	834(ra) # 486 <close>
        exit(1);
 14c:	4505                	li	a0,1
 14e:	00000097          	auipc	ra,0x0
 152:	310080e7          	jalr	784(ra) # 45e <exit>
    }
  }

  if(n < 0){
 156:	02054163          	bltz	a0,178 <main+0x156>
    close(fd_src);
    close(fd_dst);
    exit(1);
  }

  close(fd_src);
 15a:	8556                	mv	a0,s5
 15c:	00000097          	auipc	ra,0x0
 160:	32a080e7          	jalr	810(ra) # 486 <close>
  close(fd_dst);
 164:	854e                	mv	a0,s3
 166:	00000097          	auipc	ra,0x0
 16a:	320080e7          	jalr	800(ra) # 486 <close>
  exit(0);
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	2ee080e7          	jalr	750(ra) # 45e <exit>
    printf("cp: read error\n");
 178:	00001517          	auipc	a0,0x1
 17c:	a9850513          	addi	a0,a0,-1384 # c10 <malloc+0x17a>
 180:	00001097          	auipc	ra,0x1
 184:	85e080e7          	jalr	-1954(ra) # 9de <printf>
    close(fd_src);
 188:	8556                	mv	a0,s5
 18a:	00000097          	auipc	ra,0x0
 18e:	2fc080e7          	jalr	764(ra) # 486 <close>
    close(fd_dst);
 192:	854e                	mv	a0,s3
 194:	00000097          	auipc	ra,0x0
 198:	2f2080e7          	jalr	754(ra) # 486 <close>
    exit(1);
 19c:	4505                	li	a0,1
 19e:	00000097          	auipc	ra,0x0
 1a2:	2c0080e7          	jalr	704(ra) # 45e <exit>

00000000000001a6 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1a6:	1141                	addi	sp,sp,-16
 1a8:	e422                	sd	s0,8(sp)
 1aa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ac:	87aa                	mv	a5,a0
 1ae:	0585                	addi	a1,a1,1
 1b0:	0785                	addi	a5,a5,1
 1b2:	fff5c703          	lbu	a4,-1(a1)
 1b6:	fee78fa3          	sb	a4,-1(a5)
 1ba:	fb75                	bnez	a4,1ae <strcpy+0x8>
    ;
  return os;
}
 1bc:	6422                	ld	s0,8(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret

00000000000001c2 <strcat>:

char*
strcat(char *s, const char *t)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	c385                	beqz	a5,1ec <strcat+0x2a>
 1ce:	87aa                	mv	a5,a0
    s++;
 1d0:	0785                	addi	a5,a5,1
  while(*s)
 1d2:	0007c703          	lbu	a4,0(a5)
 1d6:	ff6d                	bnez	a4,1d0 <strcat+0xe>
  while((*s++ = *t++))
 1d8:	0585                	addi	a1,a1,1
 1da:	0785                	addi	a5,a5,1
 1dc:	fff5c703          	lbu	a4,-1(a1)
 1e0:	fee78fa3          	sb	a4,-1(a5)
 1e4:	fb75                	bnez	a4,1d8 <strcat+0x16>
    ;
  return os;
}
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	addi	sp,sp,16
 1ea:	8082                	ret
  while(*s)
 1ec:	87aa                	mv	a5,a0
 1ee:	b7ed                	j	1d8 <strcat+0x16>

00000000000001f0 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	cb91                	beqz	a5,20e <strcmp+0x1e>
 1fc:	0005c703          	lbu	a4,0(a1)
 200:	00f71763          	bne	a4,a5,20e <strcmp+0x1e>
    p++, q++;
 204:	0505                	addi	a0,a0,1
 206:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 208:	00054783          	lbu	a5,0(a0)
 20c:	fbe5                	bnez	a5,1fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 20e:	0005c503          	lbu	a0,0(a1)
}
 212:	40a7853b          	subw	a0,a5,a0
 216:	6422                	ld	s0,8(sp)
 218:	0141                	addi	sp,sp,16
 21a:	8082                	ret

000000000000021c <strlen>:

uint
strlen(const char *s)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 222:	00054783          	lbu	a5,0(a0)
 226:	cf91                	beqz	a5,242 <strlen+0x26>
 228:	0505                	addi	a0,a0,1
 22a:	87aa                	mv	a5,a0
 22c:	4685                	li	a3,1
 22e:	9e89                	subw	a3,a3,a0
 230:	00f6853b          	addw	a0,a3,a5
 234:	0785                	addi	a5,a5,1
 236:	fff7c703          	lbu	a4,-1(a5)
 23a:	fb7d                	bnez	a4,230 <strlen+0x14>
    ;
  return n;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  for(n = 0; s[n]; n++)
 242:	4501                	li	a0,0
 244:	bfe5                	j	23c <strlen+0x20>

0000000000000246 <memset>:

void*
memset(void *dst, int c, uint n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24c:	ca19                	beqz	a2,262 <memset+0x1c>
 24e:	87aa                	mv	a5,a0
 250:	1602                	slli	a2,a2,0x20
 252:	9201                	srli	a2,a2,0x20
 254:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 258:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25c:	0785                	addi	a5,a5,1
 25e:	fee79de3          	bne	a5,a4,258 <memset+0x12>
  }
  return dst;
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret

0000000000000268 <strchr>:

char*
strchr(const char *s, char c)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 26e:	00054783          	lbu	a5,0(a0)
 272:	cb99                	beqz	a5,288 <strchr+0x20>
    if(*s == c)
 274:	00f58763          	beq	a1,a5,282 <strchr+0x1a>
  for(; *s; s++)
 278:	0505                	addi	a0,a0,1
 27a:	00054783          	lbu	a5,0(a0)
 27e:	fbfd                	bnez	a5,274 <strchr+0xc>
      return (char*)s;
  return 0;
 280:	4501                	li	a0,0
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret
  return 0;
 288:	4501                	li	a0,0
 28a:	bfe5                	j	282 <strchr+0x1a>

000000000000028c <gets>:

char*
gets(char *buf, int max)
{
 28c:	711d                	addi	sp,sp,-96
 28e:	ec86                	sd	ra,88(sp)
 290:	e8a2                	sd	s0,80(sp)
 292:	e4a6                	sd	s1,72(sp)
 294:	e0ca                	sd	s2,64(sp)
 296:	fc4e                	sd	s3,56(sp)
 298:	f852                	sd	s4,48(sp)
 29a:	f456                	sd	s5,40(sp)
 29c:	f05a                	sd	s6,32(sp)
 29e:	ec5e                	sd	s7,24(sp)
 2a0:	e862                	sd	s8,16(sp)
 2a2:	1080                	addi	s0,sp,96
 2a4:	8baa                	mv	s7,a0
 2a6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a8:	892a                	mv	s2,a0
 2aa:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2ac:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b0:	4b29                	li	s6,10
 2b2:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2b4:	89a6                	mv	s3,s1
 2b6:	2485                	addiw	s1,s1,1
 2b8:	0344d763          	bge	s1,s4,2e6 <gets+0x5a>
    cc = read(0, &c, 1);
 2bc:	4605                	li	a2,1
 2be:	85d6                	mv	a1,s5
 2c0:	4501                	li	a0,0
 2c2:	00000097          	auipc	ra,0x0
 2c6:	1b4080e7          	jalr	436(ra) # 476 <read>
    if(cc < 1)
 2ca:	00a05e63          	blez	a0,2e6 <gets+0x5a>
    buf[i++] = c;
 2ce:	faf44783          	lbu	a5,-81(s0)
 2d2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2d6:	01678763          	beq	a5,s6,2e4 <gets+0x58>
 2da:	0905                	addi	s2,s2,1
 2dc:	fd879ce3          	bne	a5,s8,2b4 <gets+0x28>
  for(i=0; i+1 < max; ){
 2e0:	89a6                	mv	s3,s1
 2e2:	a011                	j	2e6 <gets+0x5a>
 2e4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2e6:	99de                	add	s3,s3,s7
 2e8:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ec:	855e                	mv	a0,s7
 2ee:	60e6                	ld	ra,88(sp)
 2f0:	6446                	ld	s0,80(sp)
 2f2:	64a6                	ld	s1,72(sp)
 2f4:	6906                	ld	s2,64(sp)
 2f6:	79e2                	ld	s3,56(sp)
 2f8:	7a42                	ld	s4,48(sp)
 2fa:	7aa2                	ld	s5,40(sp)
 2fc:	7b02                	ld	s6,32(sp)
 2fe:	6be2                	ld	s7,24(sp)
 300:	6c42                	ld	s8,16(sp)
 302:	6125                	addi	sp,sp,96
 304:	8082                	ret

0000000000000306 <stat>:

int
stat(const char *n, struct stat *st)
{
 306:	1101                	addi	sp,sp,-32
 308:	ec06                	sd	ra,24(sp)
 30a:	e822                	sd	s0,16(sp)
 30c:	e426                	sd	s1,8(sp)
 30e:	e04a                	sd	s2,0(sp)
 310:	1000                	addi	s0,sp,32
 312:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 314:	4581                	li	a1,0
 316:	00000097          	auipc	ra,0x0
 31a:	188080e7          	jalr	392(ra) # 49e <open>
  if(fd < 0)
 31e:	02054563          	bltz	a0,348 <stat+0x42>
 322:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 324:	85ca                	mv	a1,s2
 326:	00000097          	auipc	ra,0x0
 32a:	180080e7          	jalr	384(ra) # 4a6 <fstat>
 32e:	892a                	mv	s2,a0
  close(fd);
 330:	8526                	mv	a0,s1
 332:	00000097          	auipc	ra,0x0
 336:	154080e7          	jalr	340(ra) # 486 <close>
  return r;
}
 33a:	854a                	mv	a0,s2
 33c:	60e2                	ld	ra,24(sp)
 33e:	6442                	ld	s0,16(sp)
 340:	64a2                	ld	s1,8(sp)
 342:	6902                	ld	s2,0(sp)
 344:	6105                	addi	sp,sp,32
 346:	8082                	ret
    return -1;
 348:	597d                	li	s2,-1
 34a:	bfc5                	j	33a <stat+0x34>

000000000000034c <atoi>:

int
atoi(const char *s)
{
 34c:	1141                	addi	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 352:	00054703          	lbu	a4,0(a0)
 356:	02d00793          	li	a5,45
  int neg = 1;
 35a:	4585                	li	a1,1
  if (*s == '-') {
 35c:	04f70363          	beq	a4,a5,3a2 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 360:	00054703          	lbu	a4,0(a0)
 364:	fd07079b          	addiw	a5,a4,-48
 368:	0ff7f793          	zext.b	a5,a5
 36c:	46a5                	li	a3,9
 36e:	02f6ed63          	bltu	a3,a5,3a8 <atoi+0x5c>
  n = 0;
 372:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 374:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 376:	0505                	addi	a0,a0,1
 378:	0026979b          	slliw	a5,a3,0x2
 37c:	9fb5                	addw	a5,a5,a3
 37e:	0017979b          	slliw	a5,a5,0x1
 382:	9fb9                	addw	a5,a5,a4
 384:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 388:	00054703          	lbu	a4,0(a0)
 38c:	fd07079b          	addiw	a5,a4,-48
 390:	0ff7f793          	zext.b	a5,a5
 394:	fef671e3          	bgeu	a2,a5,376 <atoi+0x2a>
  return n * neg;
}
 398:	02d5853b          	mulw	a0,a1,a3
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
    s++;
 3a2:	0505                	addi	a0,a0,1
    neg = -1;
 3a4:	55fd                	li	a1,-1
 3a6:	bf6d                	j	360 <atoi+0x14>
  n = 0;
 3a8:	4681                	li	a3,0
 3aa:	b7fd                	j	398 <atoi+0x4c>

00000000000003ac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b2:	02b57463          	bgeu	a0,a1,3da <memmove+0x2e>
    while(n-- > 0)
 3b6:	00c05f63          	blez	a2,3d4 <memmove+0x28>
 3ba:	1602                	slli	a2,a2,0x20
 3bc:	9201                	srli	a2,a2,0x20
 3be:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 3c4:	0585                	addi	a1,a1,1
 3c6:	0705                	addi	a4,a4,1
 3c8:	fff5c683          	lbu	a3,-1(a1)
 3cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d0:	fee79ae3          	bne	a5,a4,3c4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3d4:	6422                	ld	s0,8(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret
    dst += n;
 3da:	00c50733          	add	a4,a0,a2
    src += n;
 3de:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e0:	fec05ae3          	blez	a2,3d4 <memmove+0x28>
 3e4:	fff6079b          	addiw	a5,a2,-1
 3e8:	1782                	slli	a5,a5,0x20
 3ea:	9381                	srli	a5,a5,0x20
 3ec:	fff7c793          	not	a5,a5
 3f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f2:	15fd                	addi	a1,a1,-1
 3f4:	177d                	addi	a4,a4,-1
 3f6:	0005c683          	lbu	a3,0(a1)
 3fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3fe:	fee79ae3          	bne	a5,a4,3f2 <memmove+0x46>
 402:	bfc9                	j	3d4 <memmove+0x28>

0000000000000404 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 404:	1141                	addi	sp,sp,-16
 406:	e422                	sd	s0,8(sp)
 408:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 40a:	ca05                	beqz	a2,43a <memcmp+0x36>
 40c:	fff6069b          	addiw	a3,a2,-1
 410:	1682                	slli	a3,a3,0x20
 412:	9281                	srli	a3,a3,0x20
 414:	0685                	addi	a3,a3,1
 416:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 418:	00054783          	lbu	a5,0(a0)
 41c:	0005c703          	lbu	a4,0(a1)
 420:	00e79863          	bne	a5,a4,430 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 424:	0505                	addi	a0,a0,1
    p2++;
 426:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 428:	fed518e3          	bne	a0,a3,418 <memcmp+0x14>
  }
  return 0;
 42c:	4501                	li	a0,0
 42e:	a019                	j	434 <memcmp+0x30>
      return *p1 - *p2;
 430:	40e7853b          	subw	a0,a5,a4
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret
  return 0;
 43a:	4501                	li	a0,0
 43c:	bfe5                	j	434 <memcmp+0x30>

000000000000043e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 43e:	1141                	addi	sp,sp,-16
 440:	e406                	sd	ra,8(sp)
 442:	e022                	sd	s0,0(sp)
 444:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 446:	00000097          	auipc	ra,0x0
 44a:	f66080e7          	jalr	-154(ra) # 3ac <memmove>
}
 44e:	60a2                	ld	ra,8(sp)
 450:	6402                	ld	s0,0(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret

0000000000000456 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 456:	4885                	li	a7,1
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <exit>:
.global exit
exit:
 li a7, SYS_exit
 45e:	4889                	li	a7,2
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <wait>:
.global wait
wait:
 li a7, SYS_wait
 466:	488d                	li	a7,3
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 46e:	4891                	li	a7,4
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <read>:
.global read
read:
 li a7, SYS_read
 476:	4895                	li	a7,5
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <write>:
.global write
write:
 li a7, SYS_write
 47e:	48c1                	li	a7,16
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <close>:
.global close
close:
 li a7, SYS_close
 486:	48d5                	li	a7,21
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <kill>:
.global kill
kill:
 li a7, SYS_kill
 48e:	4899                	li	a7,6
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <exec>:
.global exec
exec:
 li a7, SYS_exec
 496:	489d                	li	a7,7
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <open>:
.global open
open:
 li a7, SYS_open
 49e:	48bd                	li	a7,15
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4a6:	48a1                	li	a7,8
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ae:	48d1                	li	a7,20
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b6:	48a5                	li	a7,9
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <dup>:
.global dup
dup:
 li a7, SYS_dup
 4be:	48a9                	li	a7,10
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c6:	48ad                	li	a7,11
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ce:	48b1                	li	a7,12
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d6:	48b5                	li	a7,13
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4de:	48b9                	li	a7,14
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 4e6:	48d9                	li	a7,22
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <dev>:
.global dev
dev:
 li a7, SYS_dev
 4ee:	48dd                	li	a7,23
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4f6:	48e1                	li	a7,24
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4fe:	48e5                	li	a7,25
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <remove>:
.global remove
remove:
 li a7, SYS_remove
 506:	48c5                	li	a7,17
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <trace>:
.global trace
trace:
 li a7, SYS_trace
 50e:	48c9                	li	a7,18
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 516:	48cd                	li	a7,19
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <rename>:
.global rename
rename:
 li a7, SYS_rename
 51e:	48e9                	li	a7,26
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 526:	48ed                	li	a7,27
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 52e:	48f1                	li	a7,28
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 536:	48f5                	li	a7,29
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 53e:	48f9                	li	a7,30
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 546:	48fd                	li	a7,31
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 54e:	02000893          	li	a7,32
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 558:	02100893          	li	a7,33
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 562:	02200893          	li	a7,34
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 56c:	02300893          	li	a7,35
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 576:	02400893          	li	a7,36
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 580:	02500893          	li	a7,37
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 58a:	02600893          	li	a7,38
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 594:	02700893          	li	a7,39
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 59e:	02800893          	li	a7,40
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 5a8:	02900893          	li	a7,41
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 5b2:	02a00893          	li	a7,42
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 5bc:	02b00893          	li	a7,43
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 5c6:	02c00893          	li	a7,44
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 5d0:	02d00893          	li	a7,45
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 5da:	02e00893          	li	a7,46
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 5e4:	02f00893          	li	a7,47
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 5ee:	03000893          	li	a7,48
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 5f8:	03100893          	li	a7,49
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 602:	03200893          	li	a7,50
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 60c:	03300893          	li	a7,51
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 616:	03400893          	li	a7,52
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 620:	03500893          	li	a7,53
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 62a:	03600893          	li	a7,54
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 634:	03700893          	li	a7,55
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 63e:	03800893          	li	a7,56
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 648:	03900893          	li	a7,57
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 652:	03a00893          	li	a7,58
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <poll>:
.global poll
poll:
 li a7, SYS_poll
 65c:	03b00893          	li	a7,59
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 666:	03c00893          	li	a7,60
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 670:	03d00893          	li	a7,61
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 67a:	03e00893          	li	a7,62
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <clone>:
.global clone
clone:
 li a7, SYS_clone
 684:	03f00893          	li	a7,63
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <futex>:
.global futex
futex:
 li a7, SYS_futex
 68e:	04000893          	li	a7,64
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 698:	04100893          	li	a7,65
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <halt>:
.global halt
halt:
 li a7, SYS_halt
 6a2:	04200893          	li	a7,66
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 6ac:	04300893          	li	a7,67
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6b6:	04400893          	li	a7,68
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6c0:	04500893          	li	a7,69
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <listen>:
.global listen
listen:
 li a7, SYS_listen
 6ca:	04600893          	li	a7,70
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <accept>:
.global accept
accept:
 li a7, SYS_accept
 6d4:	04700893          	li	a7,71
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <connect>:
.global connect
connect:
 li a7, SYS_connect
 6de:	04800893          	li	a7,72
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <send>:
.global send
send:
 li a7, SYS_send
 6e8:	04900893          	li	a7,73
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6f2:	04a00893          	li	a7,74
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 6fc:	04b00893          	li	a7,75
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 706:	1101                	addi	sp,sp,-32
 708:	ec06                	sd	ra,24(sp)
 70a:	e822                	sd	s0,16(sp)
 70c:	1000                	addi	s0,sp,32
 70e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 712:	4605                	li	a2,1
 714:	fef40593          	addi	a1,s0,-17
 718:	00000097          	auipc	ra,0x0
 71c:	d66080e7          	jalr	-666(ra) # 47e <write>
}
 720:	60e2                	ld	ra,24(sp)
 722:	6442                	ld	s0,16(sp)
 724:	6105                	addi	sp,sp,32
 726:	8082                	ret

0000000000000728 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 728:	7139                	addi	sp,sp,-64
 72a:	fc06                	sd	ra,56(sp)
 72c:	f822                	sd	s0,48(sp)
 72e:	f426                	sd	s1,40(sp)
 730:	f04a                	sd	s2,32(sp)
 732:	ec4e                	sd	s3,24(sp)
 734:	0080                	addi	s0,sp,64
 736:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 738:	c299                	beqz	a3,73e <printint+0x16>
 73a:	0805c863          	bltz	a1,7ca <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 73e:	2581                	sext.w	a1,a1
  neg = 0;
 740:	4881                	li	a7,0
  }

  i = 0;
 742:	fc040993          	addi	s3,s0,-64
  neg = 0;
 746:	86ce                	mv	a3,s3
  i = 0;
 748:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 74a:	2601                	sext.w	a2,a2
 74c:	00000517          	auipc	a0,0x0
 750:	53450513          	addi	a0,a0,1332 # c80 <digits>
 754:	883a                	mv	a6,a4
 756:	2705                	addiw	a4,a4,1
 758:	02c5f7bb          	remuw	a5,a1,a2
 75c:	1782                	slli	a5,a5,0x20
 75e:	9381                	srli	a5,a5,0x20
 760:	97aa                	add	a5,a5,a0
 762:	0007c783          	lbu	a5,0(a5)
 766:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 76a:	0005879b          	sext.w	a5,a1
 76e:	02c5d5bb          	divuw	a1,a1,a2
 772:	0685                	addi	a3,a3,1
 774:	fec7f0e3          	bgeu	a5,a2,754 <printint+0x2c>
  if(neg)
 778:	00088c63          	beqz	a7,790 <printint+0x68>
    buf[i++] = '-';
 77c:	fd070793          	addi	a5,a4,-48
 780:	00878733          	add	a4,a5,s0
 784:	02d00793          	li	a5,45
 788:	fef70823          	sb	a5,-16(a4)
 78c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 790:	02e05663          	blez	a4,7bc <printint+0x94>
 794:	fc040913          	addi	s2,s0,-64
 798:	993a                	add	s2,s2,a4
 79a:	19fd                	addi	s3,s3,-1
 79c:	99ba                	add	s3,s3,a4
 79e:	377d                	addiw	a4,a4,-1
 7a0:	1702                	slli	a4,a4,0x20
 7a2:	9301                	srli	a4,a4,0x20
 7a4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7a8:	fff94583          	lbu	a1,-1(s2)
 7ac:	8526                	mv	a0,s1
 7ae:	00000097          	auipc	ra,0x0
 7b2:	f58080e7          	jalr	-168(ra) # 706 <putc>
  while(--i >= 0)
 7b6:	197d                	addi	s2,s2,-1
 7b8:	ff3918e3          	bne	s2,s3,7a8 <printint+0x80>
}
 7bc:	70e2                	ld	ra,56(sp)
 7be:	7442                	ld	s0,48(sp)
 7c0:	74a2                	ld	s1,40(sp)
 7c2:	7902                	ld	s2,32(sp)
 7c4:	69e2                	ld	s3,24(sp)
 7c6:	6121                	addi	sp,sp,64
 7c8:	8082                	ret
    x = -xx;
 7ca:	40b005bb          	negw	a1,a1
    neg = 1;
 7ce:	4885                	li	a7,1
    x = -xx;
 7d0:	bf8d                	j	742 <printint+0x1a>

00000000000007d2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7d2:	7119                	addi	sp,sp,-128
 7d4:	fc86                	sd	ra,120(sp)
 7d6:	f8a2                	sd	s0,112(sp)
 7d8:	f4a6                	sd	s1,104(sp)
 7da:	f0ca                	sd	s2,96(sp)
 7dc:	ecce                	sd	s3,88(sp)
 7de:	e8d2                	sd	s4,80(sp)
 7e0:	e4d6                	sd	s5,72(sp)
 7e2:	e0da                	sd	s6,64(sp)
 7e4:	fc5e                	sd	s7,56(sp)
 7e6:	f862                	sd	s8,48(sp)
 7e8:	f466                	sd	s9,40(sp)
 7ea:	f06a                	sd	s10,32(sp)
 7ec:	ec6e                	sd	s11,24(sp)
 7ee:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7f0:	0005c903          	lbu	s2,0(a1)
 7f4:	18090f63          	beqz	s2,992 <vprintf+0x1c0>
 7f8:	8aaa                	mv	s5,a0
 7fa:	8b32                	mv	s6,a2
 7fc:	00158493          	addi	s1,a1,1
  state = 0;
 800:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 802:	02500a13          	li	s4,37
 806:	4c55                	li	s8,21
 808:	00000c97          	auipc	s9,0x0
 80c:	420c8c93          	addi	s9,s9,1056 # c28 <malloc+0x192>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 810:	02800d93          	li	s11,40
  putc(fd, 'x');
 814:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 816:	00000b97          	auipc	s7,0x0
 81a:	46ab8b93          	addi	s7,s7,1130 # c80 <digits>
 81e:	a839                	j	83c <vprintf+0x6a>
        putc(fd, c);
 820:	85ca                	mv	a1,s2
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	ee2080e7          	jalr	-286(ra) # 706 <putc>
 82c:	a019                	j	832 <vprintf+0x60>
    } else if(state == '%'){
 82e:	01498d63          	beq	s3,s4,848 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 832:	0485                	addi	s1,s1,1
 834:	fff4c903          	lbu	s2,-1(s1)
 838:	14090d63          	beqz	s2,992 <vprintf+0x1c0>
    if(state == 0){
 83c:	fe0999e3          	bnez	s3,82e <vprintf+0x5c>
      if(c == '%'){
 840:	ff4910e3          	bne	s2,s4,820 <vprintf+0x4e>
        state = '%';
 844:	89d2                	mv	s3,s4
 846:	b7f5                	j	832 <vprintf+0x60>
      if(c == 'd'){
 848:	11490c63          	beq	s2,s4,960 <vprintf+0x18e>
 84c:	f9d9079b          	addiw	a5,s2,-99
 850:	0ff7f793          	zext.b	a5,a5
 854:	10fc6e63          	bltu	s8,a5,970 <vprintf+0x19e>
 858:	f9d9079b          	addiw	a5,s2,-99
 85c:	0ff7f713          	zext.b	a4,a5
 860:	10ec6863          	bltu	s8,a4,970 <vprintf+0x19e>
 864:	00271793          	slli	a5,a4,0x2
 868:	97e6                	add	a5,a5,s9
 86a:	439c                	lw	a5,0(a5)
 86c:	97e6                	add	a5,a5,s9
 86e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 870:	008b0913          	addi	s2,s6,8
 874:	4685                	li	a3,1
 876:	4629                	li	a2,10
 878:	000b2583          	lw	a1,0(s6)
 87c:	8556                	mv	a0,s5
 87e:	00000097          	auipc	ra,0x0
 882:	eaa080e7          	jalr	-342(ra) # 728 <printint>
 886:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 888:	4981                	li	s3,0
 88a:	b765                	j	832 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88c:	008b0913          	addi	s2,s6,8
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	000b2583          	lw	a1,0(s6)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	e8e080e7          	jalr	-370(ra) # 728 <printint>
 8a2:	8b4a                	mv	s6,s2
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b771                	j	832 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8a8:	008b0913          	addi	s2,s6,8
 8ac:	4681                	li	a3,0
 8ae:	866a                	mv	a2,s10
 8b0:	000b2583          	lw	a1,0(s6)
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	e72080e7          	jalr	-398(ra) # 728 <printint>
 8be:	8b4a                	mv	s6,s2
      state = 0;
 8c0:	4981                	li	s3,0
 8c2:	bf85                	j	832 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8c4:	008b0793          	addi	a5,s6,8
 8c8:	f8f43423          	sd	a5,-120(s0)
 8cc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8d0:	03000593          	li	a1,48
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	e30080e7          	jalr	-464(ra) # 706 <putc>
  putc(fd, 'x');
 8de:	07800593          	li	a1,120
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	e22080e7          	jalr	-478(ra) # 706 <putc>
 8ec:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8ee:	03c9d793          	srli	a5,s3,0x3c
 8f2:	97de                	add	a5,a5,s7
 8f4:	0007c583          	lbu	a1,0(a5)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e0c080e7          	jalr	-500(ra) # 706 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 902:	0992                	slli	s3,s3,0x4
 904:	397d                	addiw	s2,s2,-1
 906:	fe0914e3          	bnez	s2,8ee <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 90a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 90e:	4981                	li	s3,0
 910:	b70d                	j	832 <vprintf+0x60>
        s = va_arg(ap, char*);
 912:	008b0913          	addi	s2,s6,8
 916:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 91a:	02098163          	beqz	s3,93c <vprintf+0x16a>
        while(*s != 0){
 91e:	0009c583          	lbu	a1,0(s3)
 922:	c5ad                	beqz	a1,98c <vprintf+0x1ba>
          putc(fd, *s);
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	de0080e7          	jalr	-544(ra) # 706 <putc>
          s++;
 92e:	0985                	addi	s3,s3,1
        while(*s != 0){
 930:	0009c583          	lbu	a1,0(s3)
 934:	f9e5                	bnez	a1,924 <vprintf+0x152>
        s = va_arg(ap, char*);
 936:	8b4a                	mv	s6,s2
      state = 0;
 938:	4981                	li	s3,0
 93a:	bde5                	j	832 <vprintf+0x60>
          s = "(null)";
 93c:	00000997          	auipc	s3,0x0
 940:	2e498993          	addi	s3,s3,740 # c20 <malloc+0x18a>
        while(*s != 0){
 944:	85ee                	mv	a1,s11
 946:	bff9                	j	924 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 948:	008b0913          	addi	s2,s6,8
 94c:	000b4583          	lbu	a1,0(s6)
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	db4080e7          	jalr	-588(ra) # 706 <putc>
 95a:	8b4a                	mv	s6,s2
      state = 0;
 95c:	4981                	li	s3,0
 95e:	bdd1                	j	832 <vprintf+0x60>
        putc(fd, c);
 960:	85d2                	mv	a1,s4
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	da2080e7          	jalr	-606(ra) # 706 <putc>
      state = 0;
 96c:	4981                	li	s3,0
 96e:	b5d1                	j	832 <vprintf+0x60>
        putc(fd, '%');
 970:	85d2                	mv	a1,s4
 972:	8556                	mv	a0,s5
 974:	00000097          	auipc	ra,0x0
 978:	d92080e7          	jalr	-622(ra) # 706 <putc>
        putc(fd, c);
 97c:	85ca                	mv	a1,s2
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	d86080e7          	jalr	-634(ra) # 706 <putc>
      state = 0;
 988:	4981                	li	s3,0
 98a:	b565                	j	832 <vprintf+0x60>
        s = va_arg(ap, char*);
 98c:	8b4a                	mv	s6,s2
      state = 0;
 98e:	4981                	li	s3,0
 990:	b54d                	j	832 <vprintf+0x60>
    }
  }
}
 992:	70e6                	ld	ra,120(sp)
 994:	7446                	ld	s0,112(sp)
 996:	74a6                	ld	s1,104(sp)
 998:	7906                	ld	s2,96(sp)
 99a:	69e6                	ld	s3,88(sp)
 99c:	6a46                	ld	s4,80(sp)
 99e:	6aa6                	ld	s5,72(sp)
 9a0:	6b06                	ld	s6,64(sp)
 9a2:	7be2                	ld	s7,56(sp)
 9a4:	7c42                	ld	s8,48(sp)
 9a6:	7ca2                	ld	s9,40(sp)
 9a8:	7d02                	ld	s10,32(sp)
 9aa:	6de2                	ld	s11,24(sp)
 9ac:	6109                	addi	sp,sp,128
 9ae:	8082                	ret

00000000000009b0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9b0:	715d                	addi	sp,sp,-80
 9b2:	ec06                	sd	ra,24(sp)
 9b4:	e822                	sd	s0,16(sp)
 9b6:	1000                	addi	s0,sp,32
 9b8:	e010                	sd	a2,0(s0)
 9ba:	e414                	sd	a3,8(s0)
 9bc:	e818                	sd	a4,16(s0)
 9be:	ec1c                	sd	a5,24(s0)
 9c0:	03043023          	sd	a6,32(s0)
 9c4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9c8:	8622                	mv	a2,s0
 9ca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9ce:	00000097          	auipc	ra,0x0
 9d2:	e04080e7          	jalr	-508(ra) # 7d2 <vprintf>
}
 9d6:	60e2                	ld	ra,24(sp)
 9d8:	6442                	ld	s0,16(sp)
 9da:	6161                	addi	sp,sp,80
 9dc:	8082                	ret

00000000000009de <printf>:

void
printf(const char *fmt, ...)
{
 9de:	711d                	addi	sp,sp,-96
 9e0:	ec06                	sd	ra,24(sp)
 9e2:	e822                	sd	s0,16(sp)
 9e4:	1000                	addi	s0,sp,32
 9e6:	e40c                	sd	a1,8(s0)
 9e8:	e810                	sd	a2,16(s0)
 9ea:	ec14                	sd	a3,24(s0)
 9ec:	f018                	sd	a4,32(s0)
 9ee:	f41c                	sd	a5,40(s0)
 9f0:	03043823          	sd	a6,48(s0)
 9f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9f8:	00840613          	addi	a2,s0,8
 9fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a00:	85aa                	mv	a1,a0
 a02:	4505                	li	a0,1
 a04:	00000097          	auipc	ra,0x0
 a08:	dce080e7          	jalr	-562(ra) # 7d2 <vprintf>
}
 a0c:	60e2                	ld	ra,24(sp)
 a0e:	6442                	ld	s0,16(sp)
 a10:	6125                	addi	sp,sp,96
 a12:	8082                	ret

0000000000000a14 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a14:	1141                	addi	sp,sp,-16
 a16:	e422                	sd	s0,8(sp)
 a18:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a1a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a1e:	00000797          	auipc	a5,0x0
 a22:	27a7b783          	ld	a5,634(a5) # c98 <freep>
 a26:	a02d                	j	a50 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a28:	4618                	lw	a4,8(a2)
 a2a:	9f2d                	addw	a4,a4,a1
 a2c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a30:	6398                	ld	a4,0(a5)
 a32:	6310                	ld	a2,0(a4)
 a34:	a83d                	j	a72 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a36:	ff852703          	lw	a4,-8(a0)
 a3a:	9f31                	addw	a4,a4,a2
 a3c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a3e:	ff053683          	ld	a3,-16(a0)
 a42:	a091                	j	a86 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a44:	6398                	ld	a4,0(a5)
 a46:	00e7e463          	bltu	a5,a4,a4e <free+0x3a>
 a4a:	00e6ea63          	bltu	a3,a4,a5e <free+0x4a>
{
 a4e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a50:	fed7fae3          	bgeu	a5,a3,a44 <free+0x30>
 a54:	6398                	ld	a4,0(a5)
 a56:	00e6e463          	bltu	a3,a4,a5e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5a:	fee7eae3          	bltu	a5,a4,a4e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a5e:	ff852583          	lw	a1,-8(a0)
 a62:	6390                	ld	a2,0(a5)
 a64:	02059813          	slli	a6,a1,0x20
 a68:	01c85713          	srli	a4,a6,0x1c
 a6c:	9736                	add	a4,a4,a3
 a6e:	fae60de3          	beq	a2,a4,a28 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a72:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a76:	4790                	lw	a2,8(a5)
 a78:	02061593          	slli	a1,a2,0x20
 a7c:	01c5d713          	srli	a4,a1,0x1c
 a80:	973e                	add	a4,a4,a5
 a82:	fae68ae3          	beq	a3,a4,a36 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a86:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a88:	00000717          	auipc	a4,0x0
 a8c:	20f73823          	sd	a5,528(a4) # c98 <freep>
}
 a90:	6422                	ld	s0,8(sp)
 a92:	0141                	addi	sp,sp,16
 a94:	8082                	ret

0000000000000a96 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a96:	7139                	addi	sp,sp,-64
 a98:	fc06                	sd	ra,56(sp)
 a9a:	f822                	sd	s0,48(sp)
 a9c:	f426                	sd	s1,40(sp)
 a9e:	f04a                	sd	s2,32(sp)
 aa0:	ec4e                	sd	s3,24(sp)
 aa2:	e852                	sd	s4,16(sp)
 aa4:	e456                	sd	s5,8(sp)
 aa6:	e05a                	sd	s6,0(sp)
 aa8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aaa:	02051493          	slli	s1,a0,0x20
 aae:	9081                	srli	s1,s1,0x20
 ab0:	04bd                	addi	s1,s1,15
 ab2:	8091                	srli	s1,s1,0x4
 ab4:	00148a1b          	addiw	s4,s1,1
 ab8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 aba:	00000517          	auipc	a0,0x0
 abe:	1de53503          	ld	a0,478(a0) # c98 <freep>
 ac2:	c515                	beqz	a0,aee <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac6:	4798                	lw	a4,8(a5)
 ac8:	04977163          	bgeu	a4,s1,b0a <malloc+0x74>
 acc:	89d2                	mv	s3,s4
 ace:	000a071b          	sext.w	a4,s4
 ad2:	6685                	lui	a3,0x1
 ad4:	00d77363          	bgeu	a4,a3,ada <malloc+0x44>
 ad8:	6985                	lui	s3,0x1
 ada:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 ade:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae2:	00000917          	auipc	s2,0x0
 ae6:	1b690913          	addi	s2,s2,438 # c98 <freep>
  if(p == (char*)-1)
 aea:	5afd                	li	s5,-1
 aec:	a8a5                	j	b64 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 aee:	00000797          	auipc	a5,0x0
 af2:	1aa78793          	addi	a5,a5,426 # c98 <freep>
 af6:	00000717          	auipc	a4,0x0
 afa:	1aa70713          	addi	a4,a4,426 # ca0 <base>
 afe:	e398                	sd	a4,0(a5)
 b00:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 b02:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b06:	87ba                	mv	a5,a4
 b08:	b7d1                	j	acc <malloc+0x36>
      if(p->s.size == nunits)
 b0a:	02e48c63          	beq	s1,a4,b42 <malloc+0xac>
        p->s.size -= nunits;
 b0e:	4147073b          	subw	a4,a4,s4
 b12:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b14:	02071693          	slli	a3,a4,0x20
 b18:	01c6d713          	srli	a4,a3,0x1c
 b1c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b1e:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 b22:	00000717          	auipc	a4,0x0
 b26:	16a73b23          	sd	a0,374(a4) # c98 <freep>
      return (void*)(p + 1);
 b2a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b2e:	70e2                	ld	ra,56(sp)
 b30:	7442                	ld	s0,48(sp)
 b32:	74a2                	ld	s1,40(sp)
 b34:	7902                	ld	s2,32(sp)
 b36:	69e2                	ld	s3,24(sp)
 b38:	6a42                	ld	s4,16(sp)
 b3a:	6aa2                	ld	s5,8(sp)
 b3c:	6b02                	ld	s6,0(sp)
 b3e:	6121                	addi	sp,sp,64
 b40:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b42:	6398                	ld	a4,0(a5)
 b44:	e118                	sd	a4,0(a0)
 b46:	bff1                	j	b22 <malloc+0x8c>
  hp->s.size = nu;
 b48:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b4c:	0541                	addi	a0,a0,16
 b4e:	00000097          	auipc	ra,0x0
 b52:	ec6080e7          	jalr	-314(ra) # a14 <free>
  return freep;
 b56:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b5a:	d971                	beqz	a0,b2e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b5c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b5e:	4798                	lw	a4,8(a5)
 b60:	fa9775e3          	bgeu	a4,s1,b0a <malloc+0x74>
    if(p == freep)
 b64:	00093703          	ld	a4,0(s2)
 b68:	853e                	mv	a0,a5
 b6a:	fef719e3          	bne	a4,a5,b5c <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 b6e:	854e                	mv	a0,s3
 b70:	00000097          	auipc	ra,0x0
 b74:	95e080e7          	jalr	-1698(ra) # 4ce <sbrk>
  if(p == (char*)-1)
 b78:	fd5518e3          	bne	a0,s5,b48 <malloc+0xb2>
        return 0;
 b7c:	4501                	li	a0,0
 b7e:	bf45                	j	b2e <malloc+0x98>
