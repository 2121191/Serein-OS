
serein-user/_head：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <usage>:
  }
}

static void
usage(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  fprintf(2, "usage: head [-n N] [file ...]\n");
   8:	00001597          	auipc	a1,0x1
   c:	c5858593          	addi	a1,a1,-936 # c60 <malloc+0xf0>
  10:	4509                	li	a0,2
  12:	00001097          	auipc	ra,0x1
  16:	a78080e7          	jalr	-1416(ra) # a8a <fprintf>
  exit(1);
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	51c080e7          	jalr	1308(ra) # 538 <exit>

0000000000000024 <headfd>:
{
  24:	db010113          	addi	sp,sp,-592
  28:	24113423          	sd	ra,584(sp)
  2c:	24813023          	sd	s0,576(sp)
  30:	22913c23          	sd	s1,568(sp)
  34:	23213823          	sd	s2,560(sp)
  38:	23313423          	sd	s3,552(sp)
  3c:	23413023          	sd	s4,544(sp)
  40:	21513c23          	sd	s5,536(sp)
  44:	21613823          	sd	s6,528(sp)
  48:	21713423          	sd	s7,520(sp)
  4c:	21813023          	sd	s8,512(sp)
  50:	0c80                	addi	s0,sp,592
  52:	8b2a                	mv	s6,a0
  54:	8aae                	mv	s5,a1
  int lines = 0;
  56:	4981                	li	s3,0
  while((r = read(fd, buf, sizeof(buf))) > 0){
  58:	db040b93          	addi	s7,s0,-592
  5c:	db140c13          	addi	s8,s0,-591
      if(buf[i] == '\n' && ++lines >= n)
  60:	4a29                	li	s4,10
  while((r = read(fd, buf, sizeof(buf))) > 0){
  62:	20000613          	li	a2,512
  66:	85de                	mv	a1,s7
  68:	855a                	mv	a0,s6
  6a:	00000097          	auipc	ra,0x0
  6e:	4e6080e7          	jalr	1254(ra) # 550 <read>
  72:	08a05463          	blez	a0,fa <headfd+0xd6>
  76:	db040493          	addi	s1,s0,-592
  7a:	fff5091b          	addiw	s2,a0,-1
  7e:	1902                	slli	s2,s2,0x20
  80:	02095913          	srli	s2,s2,0x20
  84:	9962                	add	s2,s2,s8
  86:	a015                	j	aa <headfd+0x86>
        fprintf(2, "head: write error\n");
  88:	00001597          	auipc	a1,0x1
  8c:	bf858593          	addi	a1,a1,-1032 # c80 <malloc+0x110>
  90:	4509                	li	a0,2
  92:	00001097          	auipc	ra,0x1
  96:	9f8080e7          	jalr	-1544(ra) # a8a <fprintf>
        exit(1);
  9a:	4505                	li	a0,1
  9c:	00000097          	auipc	ra,0x0
  a0:	49c080e7          	jalr	1180(ra) # 538 <exit>
    for(i = 0; i < r; i++){
  a4:	0485                	addi	s1,s1,1
  a6:	fb248ee3          	beq	s1,s2,62 <headfd+0x3e>
      if(write(1, &buf[i], 1) != 1){
  aa:	4605                	li	a2,1
  ac:	85a6                	mv	a1,s1
  ae:	4505                	li	a0,1
  b0:	00000097          	auipc	ra,0x0
  b4:	4a8080e7          	jalr	1192(ra) # 558 <write>
  b8:	4785                	li	a5,1
  ba:	fcf517e3          	bne	a0,a5,88 <headfd+0x64>
      if(buf[i] == '\n' && ++lines >= n)
  be:	0004c783          	lbu	a5,0(s1)
  c2:	ff4791e3          	bne	a5,s4,a4 <headfd+0x80>
  c6:	2985                	addiw	s3,s3,1
  c8:	fd59cee3          	blt	s3,s5,a4 <headfd+0x80>
}
  cc:	24813083          	ld	ra,584(sp)
  d0:	24013403          	ld	s0,576(sp)
  d4:	23813483          	ld	s1,568(sp)
  d8:	23013903          	ld	s2,560(sp)
  dc:	22813983          	ld	s3,552(sp)
  e0:	22013a03          	ld	s4,544(sp)
  e4:	21813a83          	ld	s5,536(sp)
  e8:	21013b03          	ld	s6,528(sp)
  ec:	20813b83          	ld	s7,520(sp)
  f0:	20013c03          	ld	s8,512(sp)
  f4:	25010113          	addi	sp,sp,592
  f8:	8082                	ret
  if(r < 0){
  fa:	fc0559e3          	bgez	a0,cc <headfd+0xa8>
    fprintf(2, "head: read error\n");
  fe:	00001597          	auipc	a1,0x1
 102:	b9a58593          	addi	a1,a1,-1126 # c98 <malloc+0x128>
 106:	4509                	li	a0,2
 108:	00001097          	auipc	ra,0x1
 10c:	982080e7          	jalr	-1662(ra) # a8a <fprintf>
    exit(1);
 110:	4505                	li	a0,1
 112:	00000097          	auipc	ra,0x0
 116:	426080e7          	jalr	1062(ra) # 538 <exit>

000000000000011a <main>:
}

int main(int argc, char *argv[])
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	e06a                	sd	s10,0(sp)
 134:	1080                	addi	s0,sp,96
  int n = DEF_N;
  int i = 1;
  int firstFile = 1;

  if(argc > 1){
 136:	4785                	li	a5,1
 138:	0aa7d563          	bge	a5,a0,1e2 <main+0xc8>
 13c:	8a2a                	mv	s4,a0
 13e:	892e                	mv	s2,a1
    // parse -n N or -N or -nN
    if(argv[1][0] == '-'){
 140:	6588                	ld	a0,8(a1)
 142:	00054703          	lbu	a4,0(a0)
 146:	02d00793          	li	a5,45
 14a:	02f70263          	beq	a4,a5,16e <main+0x54>
 14e:	4985                	li	s3,1
 150:	4ba9                	li	s7,10
  if(i >= argc){
    headfd(0, n);
    exit(0);
  }

  for(; i < argc; i++){
 152:	00399793          	slli	a5,s3,0x3
 156:	993e                	add	s2,s2,a5
  int firstFile = 1;
 158:	4b05                	li	s6,1
    int fd = open(argv[i], 0);
    if(fd < 0){
      fprintf(2, "head: cannot open %s\n", argv[i]);
      exit(1);
    }
    if(argc - i > 1) { // 当有多个文件时，打印文件头
 15a:	4c05                	li	s8,1
      if(!firstFile) printf("\n");
      printf("==> %s <==\n", argv[i]);
 15c:	00001c97          	auipc	s9,0x1
 160:	b6cc8c93          	addi	s9,s9,-1172 # cc8 <malloc+0x158>
      if(!firstFile) printf("\n");
 164:	00001d17          	auipc	s10,0x1
 168:	b44d0d13          	addi	s10,s10,-1212 # ca8 <malloc+0x138>
 16c:	a8f1                	j	248 <main+0x12e>
      if(argv[1][1] == 'n'){
 16e:	00154783          	lbu	a5,1(a0)
 172:	06e00713          	li	a4,110
 176:	00e78c63          	beq	a5,a4,18e <main+0x74>
      } else if(argv[1][1] >= '0' && argv[1][1] <= '9'){
 17a:	fd07879b          	addiw	a5,a5,-48
 17e:	0ff7f793          	zext.b	a5,a5
 182:	4725                	li	a4,9
 184:	02f77f63          	bgeu	a4,a5,1c2 <main+0xa8>
 188:	4985                	li	s3,1
 18a:	4ba9                	li	s7,10
 18c:	b7d9                	j	152 <main+0x38>
        if(argv[1][2]){ // -nN
 18e:	00254783          	lbu	a5,2(a0)
 192:	eb81                	bnez	a5,1a2 <main+0x88>
          if(argc < 3) usage();
 194:	4789                	li	a5,2
 196:	0147ce63          	blt	a5,s4,1b2 <main+0x98>
 19a:	00000097          	auipc	ra,0x0
 19e:	e66080e7          	jalr	-410(ra) # 0 <usage>
          n = atoi(argv[1] + 2);
 1a2:	0509                	addi	a0,a0,2
 1a4:	00000097          	auipc	ra,0x0
 1a8:	282080e7          	jalr	642(ra) # 426 <atoi>
 1ac:	8baa                	mv	s7,a0
          i = 2;
 1ae:	4989                	li	s3,2
 1b0:	a005                	j	1d0 <main+0xb6>
          n = atoi(argv[2]);
 1b2:	6988                	ld	a0,16(a1)
 1b4:	00000097          	auipc	ra,0x0
 1b8:	272080e7          	jalr	626(ra) # 426 <atoi>
 1bc:	8baa                	mv	s7,a0
          i = 3;
 1be:	498d                	li	s3,3
 1c0:	a801                	j	1d0 <main+0xb6>
        n = atoi(argv[1] + 1); // -N
 1c2:	0505                	addi	a0,a0,1
 1c4:	00000097          	auipc	ra,0x0
 1c8:	262080e7          	jalr	610(ra) # 426 <atoi>
 1cc:	8baa                	mv	s7,a0
        i = 2;
 1ce:	4989                	li	s3,2
    if(n <= 0) usage();
 1d0:	01705563          	blez	s7,1da <main+0xc0>
  if(i >= argc){
 1d4:	f749cfe3          	blt	s3,s4,152 <main+0x38>
 1d8:	a031                	j	1e4 <main+0xca>
    if(n <= 0) usage();
 1da:	00000097          	auipc	ra,0x0
 1de:	e26080e7          	jalr	-474(ra) # 0 <usage>
  int n = DEF_N;
 1e2:	4ba9                	li	s7,10
    headfd(0, n);
 1e4:	85de                	mv	a1,s7
 1e6:	4501                	li	a0,0
 1e8:	00000097          	auipc	ra,0x0
 1ec:	e3c080e7          	jalr	-452(ra) # 24 <headfd>
    exit(0);
 1f0:	4501                	li	a0,0
 1f2:	00000097          	auipc	ra,0x0
 1f6:	346080e7          	jalr	838(ra) # 538 <exit>
      fprintf(2, "head: cannot open %s\n", argv[i]);
 1fa:	00093603          	ld	a2,0(s2)
 1fe:	00001597          	auipc	a1,0x1
 202:	ab258593          	addi	a1,a1,-1358 # cb0 <malloc+0x140>
 206:	4509                	li	a0,2
 208:	00001097          	auipc	ra,0x1
 20c:	882080e7          	jalr	-1918(ra) # a8a <fprintf>
      exit(1);
 210:	4505                	li	a0,1
 212:	00000097          	auipc	ra,0x0
 216:	326080e7          	jalr	806(ra) # 538 <exit>
      printf("==> %s <==\n", argv[i]);
 21a:	000ab583          	ld	a1,0(s5)
 21e:	8566                	mv	a0,s9
 220:	00001097          	auipc	ra,0x1
 224:	898080e7          	jalr	-1896(ra) # ab8 <printf>
      firstFile = 0;
 228:	4b01                	li	s6,0
    }
    headfd(fd, n);
 22a:	85de                	mv	a1,s7
 22c:	8526                	mv	a0,s1
 22e:	00000097          	auipc	ra,0x0
 232:	df6080e7          	jalr	-522(ra) # 24 <headfd>
    close(fd);
 236:	8526                	mv	a0,s1
 238:	00000097          	auipc	ra,0x0
 23c:	328080e7          	jalr	808(ra) # 560 <close>
  for(; i < argc; i++){
 240:	2985                	addiw	s3,s3,1
 242:	0921                	addi	s2,s2,8
 244:	0349d963          	bge	s3,s4,276 <main+0x15c>
    int fd = open(argv[i], 0);
 248:	8aca                	mv	s5,s2
 24a:	4581                	li	a1,0
 24c:	00093503          	ld	a0,0(s2)
 250:	00000097          	auipc	ra,0x0
 254:	328080e7          	jalr	808(ra) # 578 <open>
 258:	84aa                	mv	s1,a0
    if(fd < 0){
 25a:	fa0540e3          	bltz	a0,1fa <main+0xe0>
    if(argc - i > 1) { // 当有多个文件时，打印文件头
 25e:	413a07bb          	subw	a5,s4,s3
 262:	fcfc54e3          	bge	s8,a5,22a <main+0x110>
      if(!firstFile) printf("\n");
 266:	fa0b1ae3          	bnez	s6,21a <main+0x100>
 26a:	856a                	mv	a0,s10
 26c:	00001097          	auipc	ra,0x1
 270:	84c080e7          	jalr	-1972(ra) # ab8 <printf>
 274:	b75d                	j	21a <main+0x100>
  }
  exit(0);
 276:	4501                	li	a0,0
 278:	00000097          	auipc	ra,0x0
 27c:	2c0080e7          	jalr	704(ra) # 538 <exit>

0000000000000280 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 280:	1141                	addi	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 286:	87aa                	mv	a5,a0
 288:	0585                	addi	a1,a1,1
 28a:	0785                	addi	a5,a5,1
 28c:	fff5c703          	lbu	a4,-1(a1)
 290:	fee78fa3          	sb	a4,-1(a5)
 294:	fb75                	bnez	a4,288 <strcpy+0x8>
    ;
  return os;
}
 296:	6422                	ld	s0,8(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret

000000000000029c <strcat>:

char*
strcat(char *s, const char *t)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	c385                	beqz	a5,2c6 <strcat+0x2a>
 2a8:	87aa                	mv	a5,a0
    s++;
 2aa:	0785                	addi	a5,a5,1
  while(*s)
 2ac:	0007c703          	lbu	a4,0(a5)
 2b0:	ff6d                	bnez	a4,2aa <strcat+0xe>
  while((*s++ = *t++))
 2b2:	0585                	addi	a1,a1,1
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff5c703          	lbu	a4,-1(a1)
 2ba:	fee78fa3          	sb	a4,-1(a5)
 2be:	fb75                	bnez	a4,2b2 <strcat+0x16>
    ;
  return os;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret
  while(*s)
 2c6:	87aa                	mv	a5,a0
 2c8:	b7ed                	j	2b2 <strcat+0x16>

00000000000002ca <strcmp>:


int
strcmp(const char *p, const char *q)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	cb91                	beqz	a5,2e8 <strcmp+0x1e>
 2d6:	0005c703          	lbu	a4,0(a1)
 2da:	00f71763          	bne	a4,a5,2e8 <strcmp+0x1e>
    p++, q++;
 2de:	0505                	addi	a0,a0,1
 2e0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	fbe5                	bnez	a5,2d6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2e8:	0005c503          	lbu	a0,0(a1)
}
 2ec:	40a7853b          	subw	a0,a5,a0
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strlen>:

uint
strlen(const char *s)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2fc:	00054783          	lbu	a5,0(a0)
 300:	cf91                	beqz	a5,31c <strlen+0x26>
 302:	0505                	addi	a0,a0,1
 304:	87aa                	mv	a5,a0
 306:	4685                	li	a3,1
 308:	9e89                	subw	a3,a3,a0
 30a:	00f6853b          	addw	a0,a3,a5
 30e:	0785                	addi	a5,a5,1
 310:	fff7c703          	lbu	a4,-1(a5)
 314:	fb7d                	bnez	a4,30a <strlen+0x14>
    ;
  return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  for(n = 0; s[n]; n++)
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <strlen+0x20>

0000000000000320 <memset>:

void*
memset(void *dst, int c, uint n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 326:	ca19                	beqz	a2,33c <memset+0x1c>
 328:	87aa                	mv	a5,a0
 32a:	1602                	slli	a2,a2,0x20
 32c:	9201                	srli	a2,a2,0x20
 32e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 332:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 336:	0785                	addi	a5,a5,1
 338:	fee79de3          	bne	a5,a4,332 <memset+0x12>
  }
  return dst;
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strchr>:

char*
strchr(const char *s, char c)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  for(; *s; s++)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cb99                	beqz	a5,362 <strchr+0x20>
    if(*s == c)
 34e:	00f58763          	beq	a1,a5,35c <strchr+0x1a>
  for(; *s; s++)
 352:	0505                	addi	a0,a0,1
 354:	00054783          	lbu	a5,0(a0)
 358:	fbfd                	bnez	a5,34e <strchr+0xc>
      return (char*)s;
  return 0;
 35a:	4501                	li	a0,0
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
  return 0;
 362:	4501                	li	a0,0
 364:	bfe5                	j	35c <strchr+0x1a>

0000000000000366 <gets>:

char*
gets(char *buf, int max)
{
 366:	711d                	addi	sp,sp,-96
 368:	ec86                	sd	ra,88(sp)
 36a:	e8a2                	sd	s0,80(sp)
 36c:	e4a6                	sd	s1,72(sp)
 36e:	e0ca                	sd	s2,64(sp)
 370:	fc4e                	sd	s3,56(sp)
 372:	f852                	sd	s4,48(sp)
 374:	f456                	sd	s5,40(sp)
 376:	f05a                	sd	s6,32(sp)
 378:	ec5e                	sd	s7,24(sp)
 37a:	e862                	sd	s8,16(sp)
 37c:	1080                	addi	s0,sp,96
 37e:	8baa                	mv	s7,a0
 380:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 382:	892a                	mv	s2,a0
 384:	4481                	li	s1,0
    cc = read(0, &c, 1);
 386:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 38a:	4b29                	li	s6,10
 38c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 38e:	89a6                	mv	s3,s1
 390:	2485                	addiw	s1,s1,1
 392:	0344d763          	bge	s1,s4,3c0 <gets+0x5a>
    cc = read(0, &c, 1);
 396:	4605                	li	a2,1
 398:	85d6                	mv	a1,s5
 39a:	4501                	li	a0,0
 39c:	00000097          	auipc	ra,0x0
 3a0:	1b4080e7          	jalr	436(ra) # 550 <read>
    if(cc < 1)
 3a4:	00a05e63          	blez	a0,3c0 <gets+0x5a>
    buf[i++] = c;
 3a8:	faf44783          	lbu	a5,-81(s0)
 3ac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3b0:	01678763          	beq	a5,s6,3be <gets+0x58>
 3b4:	0905                	addi	s2,s2,1
 3b6:	fd879ce3          	bne	a5,s8,38e <gets+0x28>
  for(i=0; i+1 < max; ){
 3ba:	89a6                	mv	s3,s1
 3bc:	a011                	j	3c0 <gets+0x5a>
 3be:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3c0:	99de                	add	s3,s3,s7
 3c2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3c6:	855e                	mv	a0,s7
 3c8:	60e6                	ld	ra,88(sp)
 3ca:	6446                	ld	s0,80(sp)
 3cc:	64a6                	ld	s1,72(sp)
 3ce:	6906                	ld	s2,64(sp)
 3d0:	79e2                	ld	s3,56(sp)
 3d2:	7a42                	ld	s4,48(sp)
 3d4:	7aa2                	ld	s5,40(sp)
 3d6:	7b02                	ld	s6,32(sp)
 3d8:	6be2                	ld	s7,24(sp)
 3da:	6c42                	ld	s8,16(sp)
 3dc:	6125                	addi	sp,sp,96
 3de:	8082                	ret

00000000000003e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e0:	1101                	addi	sp,sp,-32
 3e2:	ec06                	sd	ra,24(sp)
 3e4:	e822                	sd	s0,16(sp)
 3e6:	e426                	sd	s1,8(sp)
 3e8:	e04a                	sd	s2,0(sp)
 3ea:	1000                	addi	s0,sp,32
 3ec:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ee:	4581                	li	a1,0
 3f0:	00000097          	auipc	ra,0x0
 3f4:	188080e7          	jalr	392(ra) # 578 <open>
  if(fd < 0)
 3f8:	02054563          	bltz	a0,422 <stat+0x42>
 3fc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3fe:	85ca                	mv	a1,s2
 400:	00000097          	auipc	ra,0x0
 404:	180080e7          	jalr	384(ra) # 580 <fstat>
 408:	892a                	mv	s2,a0
  close(fd);
 40a:	8526                	mv	a0,s1
 40c:	00000097          	auipc	ra,0x0
 410:	154080e7          	jalr	340(ra) # 560 <close>
  return r;
}
 414:	854a                	mv	a0,s2
 416:	60e2                	ld	ra,24(sp)
 418:	6442                	ld	s0,16(sp)
 41a:	64a2                	ld	s1,8(sp)
 41c:	6902                	ld	s2,0(sp)
 41e:	6105                	addi	sp,sp,32
 420:	8082                	ret
    return -1;
 422:	597d                	li	s2,-1
 424:	bfc5                	j	414 <stat+0x34>

0000000000000426 <atoi>:

int
atoi(const char *s)
{
 426:	1141                	addi	sp,sp,-16
 428:	e422                	sd	s0,8(sp)
 42a:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 42c:	00054703          	lbu	a4,0(a0)
 430:	02d00793          	li	a5,45
  int neg = 1;
 434:	4585                	li	a1,1
  if (*s == '-') {
 436:	04f70363          	beq	a4,a5,47c <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 43a:	00054703          	lbu	a4,0(a0)
 43e:	fd07079b          	addiw	a5,a4,-48
 442:	0ff7f793          	zext.b	a5,a5
 446:	46a5                	li	a3,9
 448:	02f6ed63          	bltu	a3,a5,482 <atoi+0x5c>
  n = 0;
 44c:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 44e:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 450:	0505                	addi	a0,a0,1
 452:	0026979b          	slliw	a5,a3,0x2
 456:	9fb5                	addw	a5,a5,a3
 458:	0017979b          	slliw	a5,a5,0x1
 45c:	9fb9                	addw	a5,a5,a4
 45e:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 462:	00054703          	lbu	a4,0(a0)
 466:	fd07079b          	addiw	a5,a4,-48
 46a:	0ff7f793          	zext.b	a5,a5
 46e:	fef671e3          	bgeu	a2,a5,450 <atoi+0x2a>
  return n * neg;
}
 472:	02d5853b          	mulw	a0,a1,a3
 476:	6422                	ld	s0,8(sp)
 478:	0141                	addi	sp,sp,16
 47a:	8082                	ret
    s++;
 47c:	0505                	addi	a0,a0,1
    neg = -1;
 47e:	55fd                	li	a1,-1
 480:	bf6d                	j	43a <atoi+0x14>
  n = 0;
 482:	4681                	li	a3,0
 484:	b7fd                	j	472 <atoi+0x4c>

0000000000000486 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 48c:	02b57463          	bgeu	a0,a1,4b4 <memmove+0x2e>
    while(n-- > 0)
 490:	00c05f63          	blez	a2,4ae <memmove+0x28>
 494:	1602                	slli	a2,a2,0x20
 496:	9201                	srli	a2,a2,0x20
 498:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 49c:	872a                	mv	a4,a0
      *dst++ = *src++;
 49e:	0585                	addi	a1,a1,1
 4a0:	0705                	addi	a4,a4,1
 4a2:	fff5c683          	lbu	a3,-1(a1)
 4a6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4aa:	fee79ae3          	bne	a5,a4,49e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ae:	6422                	ld	s0,8(sp)
 4b0:	0141                	addi	sp,sp,16
 4b2:	8082                	ret
    dst += n;
 4b4:	00c50733          	add	a4,a0,a2
    src += n;
 4b8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4ba:	fec05ae3          	blez	a2,4ae <memmove+0x28>
 4be:	fff6079b          	addiw	a5,a2,-1
 4c2:	1782                	slli	a5,a5,0x20
 4c4:	9381                	srli	a5,a5,0x20
 4c6:	fff7c793          	not	a5,a5
 4ca:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4cc:	15fd                	addi	a1,a1,-1
 4ce:	177d                	addi	a4,a4,-1
 4d0:	0005c683          	lbu	a3,0(a1)
 4d4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4d8:	fee79ae3          	bne	a5,a4,4cc <memmove+0x46>
 4dc:	bfc9                	j	4ae <memmove+0x28>

00000000000004de <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e4:	ca05                	beqz	a2,514 <memcmp+0x36>
 4e6:	fff6069b          	addiw	a3,a2,-1
 4ea:	1682                	slli	a3,a3,0x20
 4ec:	9281                	srli	a3,a3,0x20
 4ee:	0685                	addi	a3,a3,1
 4f0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4f2:	00054783          	lbu	a5,0(a0)
 4f6:	0005c703          	lbu	a4,0(a1)
 4fa:	00e79863          	bne	a5,a4,50a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4fe:	0505                	addi	a0,a0,1
    p2++;
 500:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 502:	fed518e3          	bne	a0,a3,4f2 <memcmp+0x14>
  }
  return 0;
 506:	4501                	li	a0,0
 508:	a019                	j	50e <memcmp+0x30>
      return *p1 - *p2;
 50a:	40e7853b          	subw	a0,a5,a4
}
 50e:	6422                	ld	s0,8(sp)
 510:	0141                	addi	sp,sp,16
 512:	8082                	ret
  return 0;
 514:	4501                	li	a0,0
 516:	bfe5                	j	50e <memcmp+0x30>

0000000000000518 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 518:	1141                	addi	sp,sp,-16
 51a:	e406                	sd	ra,8(sp)
 51c:	e022                	sd	s0,0(sp)
 51e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 520:	00000097          	auipc	ra,0x0
 524:	f66080e7          	jalr	-154(ra) # 486 <memmove>
}
 528:	60a2                	ld	ra,8(sp)
 52a:	6402                	ld	s0,0(sp)
 52c:	0141                	addi	sp,sp,16
 52e:	8082                	ret

0000000000000530 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 530:	4885                	li	a7,1
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <exit>:
.global exit
exit:
 li a7, SYS_exit
 538:	4889                	li	a7,2
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <wait>:
.global wait
wait:
 li a7, SYS_wait
 540:	488d                	li	a7,3
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 548:	4891                	li	a7,4
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <read>:
.global read
read:
 li a7, SYS_read
 550:	4895                	li	a7,5
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <write>:
.global write
write:
 li a7, SYS_write
 558:	48c1                	li	a7,16
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <close>:
.global close
close:
 li a7, SYS_close
 560:	48d5                	li	a7,21
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <kill>:
.global kill
kill:
 li a7, SYS_kill
 568:	4899                	li	a7,6
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <exec>:
.global exec
exec:
 li a7, SYS_exec
 570:	489d                	li	a7,7
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <open>:
.global open
open:
 li a7, SYS_open
 578:	48bd                	li	a7,15
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 580:	48a1                	li	a7,8
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 588:	48d1                	li	a7,20
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 590:	48a5                	li	a7,9
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <dup>:
.global dup
dup:
 li a7, SYS_dup
 598:	48a9                	li	a7,10
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a0:	48ad                	li	a7,11
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a8:	48b1                	li	a7,12
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b0:	48b5                	li	a7,13
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b8:	48b9                	li	a7,14
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 5c0:	48d9                	li	a7,22
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <dev>:
.global dev
dev:
 li a7, SYS_dev
 5c8:	48dd                	li	a7,23
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 5d0:	48e1                	li	a7,24
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 5d8:	48e5                	li	a7,25
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <remove>:
.global remove
remove:
 li a7, SYS_remove
 5e0:	48c5                	li	a7,17
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5e8:	48c9                	li	a7,18
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 5f0:	48cd                	li	a7,19
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <rename>:
.global rename
rename:
 li a7, SYS_rename
 5f8:	48e9                	li	a7,26
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 600:	48ed                	li	a7,27
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 608:	48f1                	li	a7,28
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 610:	48f5                	li	a7,29
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 618:	48f9                	li	a7,30
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 620:	48fd                	li	a7,31
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 628:	02000893          	li	a7,32
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 632:	02100893          	li	a7,33
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 63c:	02200893          	li	a7,34
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 646:	02300893          	li	a7,35
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 650:	02400893          	li	a7,36
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 65a:	02500893          	li	a7,37
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 664:	02600893          	li	a7,38
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 66e:	02700893          	li	a7,39
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 678:	02800893          	li	a7,40
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 682:	02900893          	li	a7,41
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 68c:	02a00893          	li	a7,42
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 696:	02b00893          	li	a7,43
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 6a0:	02c00893          	li	a7,44
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 6aa:	02d00893          	li	a7,45
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 6b4:	02e00893          	li	a7,46
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 6be:	02f00893          	li	a7,47
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 6c8:	03000893          	li	a7,48
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 6d2:	03100893          	li	a7,49
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 6dc:	03200893          	li	a7,50
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 6e6:	03300893          	li	a7,51
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 6f0:	03400893          	li	a7,52
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 6fa:	03500893          	li	a7,53
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 704:	03600893          	li	a7,54
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 70e:	03700893          	li	a7,55
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 718:	03800893          	li	a7,56
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 722:	03900893          	li	a7,57
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 72c:	03a00893          	li	a7,58
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <poll>:
.global poll
poll:
 li a7, SYS_poll
 736:	03b00893          	li	a7,59
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 740:	03c00893          	li	a7,60
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 74a:	03d00893          	li	a7,61
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 754:	03e00893          	li	a7,62
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <clone>:
.global clone
clone:
 li a7, SYS_clone
 75e:	03f00893          	li	a7,63
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <futex>:
.global futex
futex:
 li a7, SYS_futex
 768:	04000893          	li	a7,64
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 772:	04100893          	li	a7,65
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <halt>:
.global halt
halt:
 li a7, SYS_halt
 77c:	04200893          	li	a7,66
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 786:	04300893          	li	a7,67
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <socket>:
.global socket
socket:
 li a7, SYS_socket
 790:	04400893          	li	a7,68
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <bind>:
.global bind
bind:
 li a7, SYS_bind
 79a:	04500893          	li	a7,69
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <listen>:
.global listen
listen:
 li a7, SYS_listen
 7a4:	04600893          	li	a7,70
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <accept>:
.global accept
accept:
 li a7, SYS_accept
 7ae:	04700893          	li	a7,71
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 7b8:	04800893          	li	a7,72
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <send>:
.global send
send:
 li a7, SYS_send
 7c2:	04900893          	li	a7,73
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <recv>:
.global recv
recv:
 li a7, SYS_recv
 7cc:	04a00893          	li	a7,74
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 7d6:	04b00893          	li	a7,75
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7e0:	1101                	addi	sp,sp,-32
 7e2:	ec06                	sd	ra,24(sp)
 7e4:	e822                	sd	s0,16(sp)
 7e6:	1000                	addi	s0,sp,32
 7e8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7ec:	4605                	li	a2,1
 7ee:	fef40593          	addi	a1,s0,-17
 7f2:	00000097          	auipc	ra,0x0
 7f6:	d66080e7          	jalr	-666(ra) # 558 <write>
}
 7fa:	60e2                	ld	ra,24(sp)
 7fc:	6442                	ld	s0,16(sp)
 7fe:	6105                	addi	sp,sp,32
 800:	8082                	ret

0000000000000802 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 802:	7139                	addi	sp,sp,-64
 804:	fc06                	sd	ra,56(sp)
 806:	f822                	sd	s0,48(sp)
 808:	f426                	sd	s1,40(sp)
 80a:	f04a                	sd	s2,32(sp)
 80c:	ec4e                	sd	s3,24(sp)
 80e:	0080                	addi	s0,sp,64
 810:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 812:	c299                	beqz	a3,818 <printint+0x16>
 814:	0805c863          	bltz	a1,8a4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 818:	2581                	sext.w	a1,a1
  neg = 0;
 81a:	4881                	li	a7,0
  }

  i = 0;
 81c:	fc040993          	addi	s3,s0,-64
  neg = 0;
 820:	86ce                	mv	a3,s3
  i = 0;
 822:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 824:	2601                	sext.w	a2,a2
 826:	00000517          	auipc	a0,0x0
 82a:	51250513          	addi	a0,a0,1298 # d38 <digits>
 82e:	883a                	mv	a6,a4
 830:	2705                	addiw	a4,a4,1
 832:	02c5f7bb          	remuw	a5,a1,a2
 836:	1782                	slli	a5,a5,0x20
 838:	9381                	srli	a5,a5,0x20
 83a:	97aa                	add	a5,a5,a0
 83c:	0007c783          	lbu	a5,0(a5)
 840:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 844:	0005879b          	sext.w	a5,a1
 848:	02c5d5bb          	divuw	a1,a1,a2
 84c:	0685                	addi	a3,a3,1
 84e:	fec7f0e3          	bgeu	a5,a2,82e <printint+0x2c>
  if(neg)
 852:	00088c63          	beqz	a7,86a <printint+0x68>
    buf[i++] = '-';
 856:	fd070793          	addi	a5,a4,-48
 85a:	00878733          	add	a4,a5,s0
 85e:	02d00793          	li	a5,45
 862:	fef70823          	sb	a5,-16(a4)
 866:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 86a:	02e05663          	blez	a4,896 <printint+0x94>
 86e:	fc040913          	addi	s2,s0,-64
 872:	993a                	add	s2,s2,a4
 874:	19fd                	addi	s3,s3,-1
 876:	99ba                	add	s3,s3,a4
 878:	377d                	addiw	a4,a4,-1
 87a:	1702                	slli	a4,a4,0x20
 87c:	9301                	srli	a4,a4,0x20
 87e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 882:	fff94583          	lbu	a1,-1(s2)
 886:	8526                	mv	a0,s1
 888:	00000097          	auipc	ra,0x0
 88c:	f58080e7          	jalr	-168(ra) # 7e0 <putc>
  while(--i >= 0)
 890:	197d                	addi	s2,s2,-1
 892:	ff3918e3          	bne	s2,s3,882 <printint+0x80>
}
 896:	70e2                	ld	ra,56(sp)
 898:	7442                	ld	s0,48(sp)
 89a:	74a2                	ld	s1,40(sp)
 89c:	7902                	ld	s2,32(sp)
 89e:	69e2                	ld	s3,24(sp)
 8a0:	6121                	addi	sp,sp,64
 8a2:	8082                	ret
    x = -xx;
 8a4:	40b005bb          	negw	a1,a1
    neg = 1;
 8a8:	4885                	li	a7,1
    x = -xx;
 8aa:	bf8d                	j	81c <printint+0x1a>

00000000000008ac <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8ac:	7119                	addi	sp,sp,-128
 8ae:	fc86                	sd	ra,120(sp)
 8b0:	f8a2                	sd	s0,112(sp)
 8b2:	f4a6                	sd	s1,104(sp)
 8b4:	f0ca                	sd	s2,96(sp)
 8b6:	ecce                	sd	s3,88(sp)
 8b8:	e8d2                	sd	s4,80(sp)
 8ba:	e4d6                	sd	s5,72(sp)
 8bc:	e0da                	sd	s6,64(sp)
 8be:	fc5e                	sd	s7,56(sp)
 8c0:	f862                	sd	s8,48(sp)
 8c2:	f466                	sd	s9,40(sp)
 8c4:	f06a                	sd	s10,32(sp)
 8c6:	ec6e                	sd	s11,24(sp)
 8c8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8ca:	0005c903          	lbu	s2,0(a1)
 8ce:	18090f63          	beqz	s2,a6c <vprintf+0x1c0>
 8d2:	8aaa                	mv	s5,a0
 8d4:	8b32                	mv	s6,a2
 8d6:	00158493          	addi	s1,a1,1
  state = 0;
 8da:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8dc:	02500a13          	li	s4,37
 8e0:	4c55                	li	s8,21
 8e2:	00000c97          	auipc	s9,0x0
 8e6:	3fec8c93          	addi	s9,s9,1022 # ce0 <malloc+0x170>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8ea:	02800d93          	li	s11,40
  putc(fd, 'x');
 8ee:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f0:	00000b97          	auipc	s7,0x0
 8f4:	448b8b93          	addi	s7,s7,1096 # d38 <digits>
 8f8:	a839                	j	916 <vprintf+0x6a>
        putc(fd, c);
 8fa:	85ca                	mv	a1,s2
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	ee2080e7          	jalr	-286(ra) # 7e0 <putc>
 906:	a019                	j	90c <vprintf+0x60>
    } else if(state == '%'){
 908:	01498d63          	beq	s3,s4,922 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 90c:	0485                	addi	s1,s1,1
 90e:	fff4c903          	lbu	s2,-1(s1)
 912:	14090d63          	beqz	s2,a6c <vprintf+0x1c0>
    if(state == 0){
 916:	fe0999e3          	bnez	s3,908 <vprintf+0x5c>
      if(c == '%'){
 91a:	ff4910e3          	bne	s2,s4,8fa <vprintf+0x4e>
        state = '%';
 91e:	89d2                	mv	s3,s4
 920:	b7f5                	j	90c <vprintf+0x60>
      if(c == 'd'){
 922:	11490c63          	beq	s2,s4,a3a <vprintf+0x18e>
 926:	f9d9079b          	addiw	a5,s2,-99
 92a:	0ff7f793          	zext.b	a5,a5
 92e:	10fc6e63          	bltu	s8,a5,a4a <vprintf+0x19e>
 932:	f9d9079b          	addiw	a5,s2,-99
 936:	0ff7f713          	zext.b	a4,a5
 93a:	10ec6863          	bltu	s8,a4,a4a <vprintf+0x19e>
 93e:	00271793          	slli	a5,a4,0x2
 942:	97e6                	add	a5,a5,s9
 944:	439c                	lw	a5,0(a5)
 946:	97e6                	add	a5,a5,s9
 948:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 94a:	008b0913          	addi	s2,s6,8
 94e:	4685                	li	a3,1
 950:	4629                	li	a2,10
 952:	000b2583          	lw	a1,0(s6)
 956:	8556                	mv	a0,s5
 958:	00000097          	auipc	ra,0x0
 95c:	eaa080e7          	jalr	-342(ra) # 802 <printint>
 960:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 962:	4981                	li	s3,0
 964:	b765                	j	90c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 966:	008b0913          	addi	s2,s6,8
 96a:	4681                	li	a3,0
 96c:	4629                	li	a2,10
 96e:	000b2583          	lw	a1,0(s6)
 972:	8556                	mv	a0,s5
 974:	00000097          	auipc	ra,0x0
 978:	e8e080e7          	jalr	-370(ra) # 802 <printint>
 97c:	8b4a                	mv	s6,s2
      state = 0;
 97e:	4981                	li	s3,0
 980:	b771                	j	90c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 982:	008b0913          	addi	s2,s6,8
 986:	4681                	li	a3,0
 988:	866a                	mv	a2,s10
 98a:	000b2583          	lw	a1,0(s6)
 98e:	8556                	mv	a0,s5
 990:	00000097          	auipc	ra,0x0
 994:	e72080e7          	jalr	-398(ra) # 802 <printint>
 998:	8b4a                	mv	s6,s2
      state = 0;
 99a:	4981                	li	s3,0
 99c:	bf85                	j	90c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 99e:	008b0793          	addi	a5,s6,8
 9a2:	f8f43423          	sd	a5,-120(s0)
 9a6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 9aa:	03000593          	li	a1,48
 9ae:	8556                	mv	a0,s5
 9b0:	00000097          	auipc	ra,0x0
 9b4:	e30080e7          	jalr	-464(ra) # 7e0 <putc>
  putc(fd, 'x');
 9b8:	07800593          	li	a1,120
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	e22080e7          	jalr	-478(ra) # 7e0 <putc>
 9c6:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9c8:	03c9d793          	srli	a5,s3,0x3c
 9cc:	97de                	add	a5,a5,s7
 9ce:	0007c583          	lbu	a1,0(a5)
 9d2:	8556                	mv	a0,s5
 9d4:	00000097          	auipc	ra,0x0
 9d8:	e0c080e7          	jalr	-500(ra) # 7e0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9dc:	0992                	slli	s3,s3,0x4
 9de:	397d                	addiw	s2,s2,-1
 9e0:	fe0914e3          	bnez	s2,9c8 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 9e4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 9e8:	4981                	li	s3,0
 9ea:	b70d                	j	90c <vprintf+0x60>
        s = va_arg(ap, char*);
 9ec:	008b0913          	addi	s2,s6,8
 9f0:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 9f4:	02098163          	beqz	s3,a16 <vprintf+0x16a>
        while(*s != 0){
 9f8:	0009c583          	lbu	a1,0(s3)
 9fc:	c5ad                	beqz	a1,a66 <vprintf+0x1ba>
          putc(fd, *s);
 9fe:	8556                	mv	a0,s5
 a00:	00000097          	auipc	ra,0x0
 a04:	de0080e7          	jalr	-544(ra) # 7e0 <putc>
          s++;
 a08:	0985                	addi	s3,s3,1
        while(*s != 0){
 a0a:	0009c583          	lbu	a1,0(s3)
 a0e:	f9e5                	bnez	a1,9fe <vprintf+0x152>
        s = va_arg(ap, char*);
 a10:	8b4a                	mv	s6,s2
      state = 0;
 a12:	4981                	li	s3,0
 a14:	bde5                	j	90c <vprintf+0x60>
          s = "(null)";
 a16:	00000997          	auipc	s3,0x0
 a1a:	2c298993          	addi	s3,s3,706 # cd8 <malloc+0x168>
        while(*s != 0){
 a1e:	85ee                	mv	a1,s11
 a20:	bff9                	j	9fe <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 a22:	008b0913          	addi	s2,s6,8
 a26:	000b4583          	lbu	a1,0(s6)
 a2a:	8556                	mv	a0,s5
 a2c:	00000097          	auipc	ra,0x0
 a30:	db4080e7          	jalr	-588(ra) # 7e0 <putc>
 a34:	8b4a                	mv	s6,s2
      state = 0;
 a36:	4981                	li	s3,0
 a38:	bdd1                	j	90c <vprintf+0x60>
        putc(fd, c);
 a3a:	85d2                	mv	a1,s4
 a3c:	8556                	mv	a0,s5
 a3e:	00000097          	auipc	ra,0x0
 a42:	da2080e7          	jalr	-606(ra) # 7e0 <putc>
      state = 0;
 a46:	4981                	li	s3,0
 a48:	b5d1                	j	90c <vprintf+0x60>
        putc(fd, '%');
 a4a:	85d2                	mv	a1,s4
 a4c:	8556                	mv	a0,s5
 a4e:	00000097          	auipc	ra,0x0
 a52:	d92080e7          	jalr	-622(ra) # 7e0 <putc>
        putc(fd, c);
 a56:	85ca                	mv	a1,s2
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	d86080e7          	jalr	-634(ra) # 7e0 <putc>
      state = 0;
 a62:	4981                	li	s3,0
 a64:	b565                	j	90c <vprintf+0x60>
        s = va_arg(ap, char*);
 a66:	8b4a                	mv	s6,s2
      state = 0;
 a68:	4981                	li	s3,0
 a6a:	b54d                	j	90c <vprintf+0x60>
    }
  }
}
 a6c:	70e6                	ld	ra,120(sp)
 a6e:	7446                	ld	s0,112(sp)
 a70:	74a6                	ld	s1,104(sp)
 a72:	7906                	ld	s2,96(sp)
 a74:	69e6                	ld	s3,88(sp)
 a76:	6a46                	ld	s4,80(sp)
 a78:	6aa6                	ld	s5,72(sp)
 a7a:	6b06                	ld	s6,64(sp)
 a7c:	7be2                	ld	s7,56(sp)
 a7e:	7c42                	ld	s8,48(sp)
 a80:	7ca2                	ld	s9,40(sp)
 a82:	7d02                	ld	s10,32(sp)
 a84:	6de2                	ld	s11,24(sp)
 a86:	6109                	addi	sp,sp,128
 a88:	8082                	ret

0000000000000a8a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a8a:	715d                	addi	sp,sp,-80
 a8c:	ec06                	sd	ra,24(sp)
 a8e:	e822                	sd	s0,16(sp)
 a90:	1000                	addi	s0,sp,32
 a92:	e010                	sd	a2,0(s0)
 a94:	e414                	sd	a3,8(s0)
 a96:	e818                	sd	a4,16(s0)
 a98:	ec1c                	sd	a5,24(s0)
 a9a:	03043023          	sd	a6,32(s0)
 a9e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa2:	8622                	mv	a2,s0
 aa4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aa8:	00000097          	auipc	ra,0x0
 aac:	e04080e7          	jalr	-508(ra) # 8ac <vprintf>
}
 ab0:	60e2                	ld	ra,24(sp)
 ab2:	6442                	ld	s0,16(sp)
 ab4:	6161                	addi	sp,sp,80
 ab6:	8082                	ret

0000000000000ab8 <printf>:

void
printf(const char *fmt, ...)
{
 ab8:	711d                	addi	sp,sp,-96
 aba:	ec06                	sd	ra,24(sp)
 abc:	e822                	sd	s0,16(sp)
 abe:	1000                	addi	s0,sp,32
 ac0:	e40c                	sd	a1,8(s0)
 ac2:	e810                	sd	a2,16(s0)
 ac4:	ec14                	sd	a3,24(s0)
 ac6:	f018                	sd	a4,32(s0)
 ac8:	f41c                	sd	a5,40(s0)
 aca:	03043823          	sd	a6,48(s0)
 ace:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ad2:	00840613          	addi	a2,s0,8
 ad6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ada:	85aa                	mv	a1,a0
 adc:	4505                	li	a0,1
 ade:	00000097          	auipc	ra,0x0
 ae2:	dce080e7          	jalr	-562(ra) # 8ac <vprintf>
}
 ae6:	60e2                	ld	ra,24(sp)
 ae8:	6442                	ld	s0,16(sp)
 aea:	6125                	addi	sp,sp,96
 aec:	8082                	ret

0000000000000aee <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aee:	1141                	addi	sp,sp,-16
 af0:	e422                	sd	s0,8(sp)
 af2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 af4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af8:	00000797          	auipc	a5,0x0
 afc:	2587b783          	ld	a5,600(a5) # d50 <freep>
 b00:	a02d                	j	b2a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b02:	4618                	lw	a4,8(a2)
 b04:	9f2d                	addw	a4,a4,a1
 b06:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b0a:	6398                	ld	a4,0(a5)
 b0c:	6310                	ld	a2,0(a4)
 b0e:	a83d                	j	b4c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b10:	ff852703          	lw	a4,-8(a0)
 b14:	9f31                	addw	a4,a4,a2
 b16:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b18:	ff053683          	ld	a3,-16(a0)
 b1c:	a091                	j	b60 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b1e:	6398                	ld	a4,0(a5)
 b20:	00e7e463          	bltu	a5,a4,b28 <free+0x3a>
 b24:	00e6ea63          	bltu	a3,a4,b38 <free+0x4a>
{
 b28:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2a:	fed7fae3          	bgeu	a5,a3,b1e <free+0x30>
 b2e:	6398                	ld	a4,0(a5)
 b30:	00e6e463          	bltu	a3,a4,b38 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b34:	fee7eae3          	bltu	a5,a4,b28 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b38:	ff852583          	lw	a1,-8(a0)
 b3c:	6390                	ld	a2,0(a5)
 b3e:	02059813          	slli	a6,a1,0x20
 b42:	01c85713          	srli	a4,a6,0x1c
 b46:	9736                	add	a4,a4,a3
 b48:	fae60de3          	beq	a2,a4,b02 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b4c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b50:	4790                	lw	a2,8(a5)
 b52:	02061593          	slli	a1,a2,0x20
 b56:	01c5d713          	srli	a4,a1,0x1c
 b5a:	973e                	add	a4,a4,a5
 b5c:	fae68ae3          	beq	a3,a4,b10 <free+0x22>
    p->s.ptr = bp->s.ptr;
 b60:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b62:	00000717          	auipc	a4,0x0
 b66:	1ef73723          	sd	a5,494(a4) # d50 <freep>
}
 b6a:	6422                	ld	s0,8(sp)
 b6c:	0141                	addi	sp,sp,16
 b6e:	8082                	ret

0000000000000b70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b70:	7139                	addi	sp,sp,-64
 b72:	fc06                	sd	ra,56(sp)
 b74:	f822                	sd	s0,48(sp)
 b76:	f426                	sd	s1,40(sp)
 b78:	f04a                	sd	s2,32(sp)
 b7a:	ec4e                	sd	s3,24(sp)
 b7c:	e852                	sd	s4,16(sp)
 b7e:	e456                	sd	s5,8(sp)
 b80:	e05a                	sd	s6,0(sp)
 b82:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b84:	02051493          	slli	s1,a0,0x20
 b88:	9081                	srli	s1,s1,0x20
 b8a:	04bd                	addi	s1,s1,15
 b8c:	8091                	srli	s1,s1,0x4
 b8e:	00148a1b          	addiw	s4,s1,1
 b92:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b94:	00000517          	auipc	a0,0x0
 b98:	1bc53503          	ld	a0,444(a0) # d50 <freep>
 b9c:	c515                	beqz	a0,bc8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b9e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ba0:	4798                	lw	a4,8(a5)
 ba2:	04977163          	bgeu	a4,s1,be4 <malloc+0x74>
 ba6:	89d2                	mv	s3,s4
 ba8:	000a071b          	sext.w	a4,s4
 bac:	6685                	lui	a3,0x1
 bae:	00d77363          	bgeu	a4,a3,bb4 <malloc+0x44>
 bb2:	6985                	lui	s3,0x1
 bb4:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 bb8:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bbc:	00000917          	auipc	s2,0x0
 bc0:	19490913          	addi	s2,s2,404 # d50 <freep>
  if(p == (char*)-1)
 bc4:	5afd                	li	s5,-1
 bc6:	a8a5                	j	c3e <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 bc8:	00000797          	auipc	a5,0x0
 bcc:	18878793          	addi	a5,a5,392 # d50 <freep>
 bd0:	00000717          	auipc	a4,0x0
 bd4:	18870713          	addi	a4,a4,392 # d58 <base>
 bd8:	e398                	sd	a4,0(a5)
 bda:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 bdc:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be0:	87ba                	mv	a5,a4
 be2:	b7d1                	j	ba6 <malloc+0x36>
      if(p->s.size == nunits)
 be4:	02e48c63          	beq	s1,a4,c1c <malloc+0xac>
        p->s.size -= nunits;
 be8:	4147073b          	subw	a4,a4,s4
 bec:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bee:	02071693          	slli	a3,a4,0x20
 bf2:	01c6d713          	srli	a4,a3,0x1c
 bf6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bf8:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 bfc:	00000717          	auipc	a4,0x0
 c00:	14a73a23          	sd	a0,340(a4) # d50 <freep>
      return (void*)(p + 1);
 c04:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c08:	70e2                	ld	ra,56(sp)
 c0a:	7442                	ld	s0,48(sp)
 c0c:	74a2                	ld	s1,40(sp)
 c0e:	7902                	ld	s2,32(sp)
 c10:	69e2                	ld	s3,24(sp)
 c12:	6a42                	ld	s4,16(sp)
 c14:	6aa2                	ld	s5,8(sp)
 c16:	6b02                	ld	s6,0(sp)
 c18:	6121                	addi	sp,sp,64
 c1a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c1c:	6398                	ld	a4,0(a5)
 c1e:	e118                	sd	a4,0(a0)
 c20:	bff1                	j	bfc <malloc+0x8c>
  hp->s.size = nu;
 c22:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c26:	0541                	addi	a0,a0,16
 c28:	00000097          	auipc	ra,0x0
 c2c:	ec6080e7          	jalr	-314(ra) # aee <free>
  return freep;
 c30:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c34:	d971                	beqz	a0,c08 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c36:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c38:	4798                	lw	a4,8(a5)
 c3a:	fa9775e3          	bgeu	a4,s1,be4 <malloc+0x74>
    if(p == freep)
 c3e:	00093703          	ld	a4,0(s2)
 c42:	853e                	mv	a0,a5
 c44:	fef719e3          	bne	a4,a5,c36 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 c48:	854e                	mv	a0,s3
 c4a:	00000097          	auipc	ra,0x0
 c4e:	95e080e7          	jalr	-1698(ra) # 5a8 <sbrk>
  if(p == (char*)-1)
 c52:	fd5518e3          	bne	a0,s5,c22 <malloc+0xb2>
        return 0;
 c56:	4501                	li	a0,0
 c58:	bf45                	j	c08 <malloc+0x98>
