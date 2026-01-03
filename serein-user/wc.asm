
serein-user/_wc：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4981                	li	s3,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  2e:	00001d97          	auipc	s11,0x1
  32:	c33d8d93          	addi	s11,s11,-973 # c61 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	b50a0a13          	addi	s4,s4,-1200 # b88 <malloc+0xf0>
        inword = 0;
  40:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	224080e7          	jalr	548(ra) # 26a <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	89da                	mv	s3,s6
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	01248d63          	beq	s1,s2,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2b85                	addiw	s7,s7,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0997e3          	bnez	s3,52 <wc+0x52>
        w++;
  68:	2c05                	addiw	s8,s8,1
        inword = 1;
  6a:	4985                	li	s3,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ac8cbb          	addw	s9,s9,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	00001597          	auipc	a1,0x1
  7a:	bea58593          	addi	a1,a1,-1046 # c60 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	3f6080e7          	jalr	1014(ra) # 478 <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
    for(i=0; i<n; i++){
  8e:	00001497          	auipc	s1,0x1
  92:	bd248493          	addi	s1,s1,-1070 # c60 <buf>
  96:	00050d1b          	sext.w	s10,a0
  9a:	fff5091b          	addiw	s2,a0,-1
  9e:	1902                	slli	s2,s2,0x20
  a0:	02095913          	srli	s2,s2,0x20
  a4:	996e                	add	s2,s2,s11
  a6:	bf4d                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  a8:	02054e63          	bltz	a0,e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d\t%d\t%d\t%s\n", l, w, c, name);
  ac:	f8043703          	ld	a4,-128(s0)
  b0:	86e6                	mv	a3,s9
  b2:	8662                	mv	a2,s8
  b4:	85de                	mv	a1,s7
  b6:	00001517          	auipc	a0,0x1
  ba:	aea50513          	addi	a0,a0,-1302 # ba0 <malloc+0x108>
  be:	00001097          	auipc	ra,0x1
  c2:	922080e7          	jalr	-1758(ra) # 9e0 <printf>
}
  c6:	70e6                	ld	ra,120(sp)
  c8:	7446                	ld	s0,112(sp)
  ca:	74a6                	ld	s1,104(sp)
  cc:	7906                	ld	s2,96(sp)
  ce:	69e6                	ld	s3,88(sp)
  d0:	6a46                	ld	s4,80(sp)
  d2:	6aa6                	ld	s5,72(sp)
  d4:	6b06                	ld	s6,64(sp)
  d6:	7be2                	ld	s7,56(sp)
  d8:	7c42                	ld	s8,48(sp)
  da:	7ca2                	ld	s9,40(sp)
  dc:	7d02                	ld	s10,32(sp)
  de:	6de2                	ld	s11,24(sp)
  e0:	6109                	addi	sp,sp,128
  e2:	8082                	ret
    printf("wc: read error\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	aac50513          	addi	a0,a0,-1364 # b90 <malloc+0xf8>
  ec:	00001097          	auipc	ra,0x1
  f0:	8f4080e7          	jalr	-1804(ra) # 9e0 <printf>
    exit(1);
  f4:	4505                	li	a0,1
  f6:	00000097          	auipc	ra,0x0
  fa:	36a080e7          	jalr	874(ra) # 460 <exit>

00000000000000fe <main>:

int
main(int argc, char *argv[])
{
  fe:	7179                	addi	sp,sp,-48
 100:	f406                	sd	ra,40(sp)
 102:	f022                	sd	s0,32(sp)
 104:	ec26                	sd	s1,24(sp)
 106:	e84a                	sd	s2,16(sp)
 108:	e44e                	sd	s3,8(sp)
 10a:	e052                	sd	s4,0(sp)
 10c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
 10e:	4785                	li	a5,1
 110:	06a7d063          	bge	a5,a0,170 <main+0x72>
 114:	89aa                	mv	s3,a0
 116:	892e                	mv	s2,a1
    wc(0, "");
    exit(0);
  }

  printf("LINE\tWORD\tBYTE\tFILE\n");
 118:	00001517          	auipc	a0,0x1
 11c:	aa050513          	addi	a0,a0,-1376 # bb8 <malloc+0x120>
 120:	00001097          	auipc	ra,0x1
 124:	8c0080e7          	jalr	-1856(ra) # 9e0 <printf>
  for(i = 1; i < argc; i++){
 128:	00890493          	addi	s1,s2,8
 12c:	39f9                	addiw	s3,s3,-2
 12e:	02099793          	slli	a5,s3,0x20
 132:	01d7d993          	srli	s3,a5,0x1d
 136:	0941                	addi	s2,s2,16
 138:	99ca                	add	s3,s3,s2
    if((fd = open(argv[i], 0)) < 0){
 13a:	4581                	li	a1,0
 13c:	6088                	ld	a0,0(s1)
 13e:	00000097          	auipc	ra,0x0
 142:	362080e7          	jalr	866(ra) # 4a0 <open>
 146:	892a                	mv	s2,a0
 148:	04054263          	bltz	a0,18c <main+0x8e>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 14c:	608c                	ld	a1,0(s1)
 14e:	00000097          	auipc	ra,0x0
 152:	eb2080e7          	jalr	-334(ra) # 0 <wc>
    close(fd);
 156:	854a                	mv	a0,s2
 158:	00000097          	auipc	ra,0x0
 15c:	330080e7          	jalr	816(ra) # 488 <close>
  for(i = 1; i < argc; i++){
 160:	04a1                	addi	s1,s1,8
 162:	fd349ce3          	bne	s1,s3,13a <main+0x3c>
  }
  exit(0);
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	2f8080e7          	jalr	760(ra) # 460 <exit>
    wc(0, "");
 170:	00001597          	auipc	a1,0x1
 174:	a4058593          	addi	a1,a1,-1472 # bb0 <malloc+0x118>
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	e86080e7          	jalr	-378(ra) # 0 <wc>
    exit(0);
 182:	4501                	li	a0,0
 184:	00000097          	auipc	ra,0x0
 188:	2dc080e7          	jalr	732(ra) # 460 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 18c:	608c                	ld	a1,0(s1)
 18e:	00001517          	auipc	a0,0x1
 192:	a4250513          	addi	a0,a0,-1470 # bd0 <malloc+0x138>
 196:	00001097          	auipc	ra,0x1
 19a:	84a080e7          	jalr	-1974(ra) # 9e0 <printf>
      exit(1);
 19e:	4505                	li	a0,1
 1a0:	00000097          	auipc	ra,0x0
 1a4:	2c0080e7          	jalr	704(ra) # 460 <exit>

00000000000001a8 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ae:	87aa                	mv	a5,a0
 1b0:	0585                	addi	a1,a1,1
 1b2:	0785                	addi	a5,a5,1
 1b4:	fff5c703          	lbu	a4,-1(a1)
 1b8:	fee78fa3          	sb	a4,-1(a5)
 1bc:	fb75                	bnez	a4,1b0 <strcpy+0x8>
    ;
  return os;
}
 1be:	6422                	ld	s0,8(sp)
 1c0:	0141                	addi	sp,sp,16
 1c2:	8082                	ret

00000000000001c4 <strcat>:

char*
strcat(char *s, const char *t)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	c385                	beqz	a5,1ee <strcat+0x2a>
 1d0:	87aa                	mv	a5,a0
    s++;
 1d2:	0785                	addi	a5,a5,1
  while(*s)
 1d4:	0007c703          	lbu	a4,0(a5)
 1d8:	ff6d                	bnez	a4,1d2 <strcat+0xe>
  while((*s++ = *t++))
 1da:	0585                	addi	a1,a1,1
 1dc:	0785                	addi	a5,a5,1
 1de:	fff5c703          	lbu	a4,-1(a1)
 1e2:	fee78fa3          	sb	a4,-1(a5)
 1e6:	fb75                	bnez	a4,1da <strcat+0x16>
    ;
  return os;
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret
  while(*s)
 1ee:	87aa                	mv	a5,a0
 1f0:	b7ed                	j	1da <strcat+0x16>

00000000000001f2 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	cb91                	beqz	a5,210 <strcmp+0x1e>
 1fe:	0005c703          	lbu	a4,0(a1)
 202:	00f71763          	bne	a4,a5,210 <strcmp+0x1e>
    p++, q++;
 206:	0505                	addi	a0,a0,1
 208:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 20a:	00054783          	lbu	a5,0(a0)
 20e:	fbe5                	bnez	a5,1fe <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 210:	0005c503          	lbu	a0,0(a1)
}
 214:	40a7853b          	subw	a0,a5,a0
 218:	6422                	ld	s0,8(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret

000000000000021e <strlen>:

uint
strlen(const char *s)
{
 21e:	1141                	addi	sp,sp,-16
 220:	e422                	sd	s0,8(sp)
 222:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 224:	00054783          	lbu	a5,0(a0)
 228:	cf91                	beqz	a5,244 <strlen+0x26>
 22a:	0505                	addi	a0,a0,1
 22c:	87aa                	mv	a5,a0
 22e:	4685                	li	a3,1
 230:	9e89                	subw	a3,a3,a0
 232:	00f6853b          	addw	a0,a3,a5
 236:	0785                	addi	a5,a5,1
 238:	fff7c703          	lbu	a4,-1(a5)
 23c:	fb7d                	bnez	a4,232 <strlen+0x14>
    ;
  return n;
}
 23e:	6422                	ld	s0,8(sp)
 240:	0141                	addi	sp,sp,16
 242:	8082                	ret
  for(n = 0; s[n]; n++)
 244:	4501                	li	a0,0
 246:	bfe5                	j	23e <strlen+0x20>

0000000000000248 <memset>:

void*
memset(void *dst, int c, uint n)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24e:	ca19                	beqz	a2,264 <memset+0x1c>
 250:	87aa                	mv	a5,a0
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 25a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25e:	0785                	addi	a5,a5,1
 260:	fee79de3          	bne	a5,a4,25a <memset+0x12>
  }
  return dst;
}
 264:	6422                	ld	s0,8(sp)
 266:	0141                	addi	sp,sp,16
 268:	8082                	ret

000000000000026a <strchr>:

char*
strchr(const char *s, char c)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 270:	00054783          	lbu	a5,0(a0)
 274:	cb99                	beqz	a5,28a <strchr+0x20>
    if(*s == c)
 276:	00f58763          	beq	a1,a5,284 <strchr+0x1a>
  for(; *s; s++)
 27a:	0505                	addi	a0,a0,1
 27c:	00054783          	lbu	a5,0(a0)
 280:	fbfd                	bnez	a5,276 <strchr+0xc>
      return (char*)s;
  return 0;
 282:	4501                	li	a0,0
}
 284:	6422                	ld	s0,8(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret
  return 0;
 28a:	4501                	li	a0,0
 28c:	bfe5                	j	284 <strchr+0x1a>

000000000000028e <gets>:

char*
gets(char *buf, int max)
{
 28e:	711d                	addi	sp,sp,-96
 290:	ec86                	sd	ra,88(sp)
 292:	e8a2                	sd	s0,80(sp)
 294:	e4a6                	sd	s1,72(sp)
 296:	e0ca                	sd	s2,64(sp)
 298:	fc4e                	sd	s3,56(sp)
 29a:	f852                	sd	s4,48(sp)
 29c:	f456                	sd	s5,40(sp)
 29e:	f05a                	sd	s6,32(sp)
 2a0:	ec5e                	sd	s7,24(sp)
 2a2:	e862                	sd	s8,16(sp)
 2a4:	1080                	addi	s0,sp,96
 2a6:	8baa                	mv	s7,a0
 2a8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2aa:	892a                	mv	s2,a0
 2ac:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2ae:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b2:	4b29                	li	s6,10
 2b4:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2b6:	89a6                	mv	s3,s1
 2b8:	2485                	addiw	s1,s1,1
 2ba:	0344d763          	bge	s1,s4,2e8 <gets+0x5a>
    cc = read(0, &c, 1);
 2be:	4605                	li	a2,1
 2c0:	85d6                	mv	a1,s5
 2c2:	4501                	li	a0,0
 2c4:	00000097          	auipc	ra,0x0
 2c8:	1b4080e7          	jalr	436(ra) # 478 <read>
    if(cc < 1)
 2cc:	00a05e63          	blez	a0,2e8 <gets+0x5a>
    buf[i++] = c;
 2d0:	faf44783          	lbu	a5,-81(s0)
 2d4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2d8:	01678763          	beq	a5,s6,2e6 <gets+0x58>
 2dc:	0905                	addi	s2,s2,1
 2de:	fd879ce3          	bne	a5,s8,2b6 <gets+0x28>
  for(i=0; i+1 < max; ){
 2e2:	89a6                	mv	s3,s1
 2e4:	a011                	j	2e8 <gets+0x5a>
 2e6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2e8:	99de                	add	s3,s3,s7
 2ea:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ee:	855e                	mv	a0,s7
 2f0:	60e6                	ld	ra,88(sp)
 2f2:	6446                	ld	s0,80(sp)
 2f4:	64a6                	ld	s1,72(sp)
 2f6:	6906                	ld	s2,64(sp)
 2f8:	79e2                	ld	s3,56(sp)
 2fa:	7a42                	ld	s4,48(sp)
 2fc:	7aa2                	ld	s5,40(sp)
 2fe:	7b02                	ld	s6,32(sp)
 300:	6be2                	ld	s7,24(sp)
 302:	6c42                	ld	s8,16(sp)
 304:	6125                	addi	sp,sp,96
 306:	8082                	ret

0000000000000308 <stat>:

int
stat(const char *n, struct stat *st)
{
 308:	1101                	addi	sp,sp,-32
 30a:	ec06                	sd	ra,24(sp)
 30c:	e822                	sd	s0,16(sp)
 30e:	e426                	sd	s1,8(sp)
 310:	e04a                	sd	s2,0(sp)
 312:	1000                	addi	s0,sp,32
 314:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	4581                	li	a1,0
 318:	00000097          	auipc	ra,0x0
 31c:	188080e7          	jalr	392(ra) # 4a0 <open>
  if(fd < 0)
 320:	02054563          	bltz	a0,34a <stat+0x42>
 324:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 326:	85ca                	mv	a1,s2
 328:	00000097          	auipc	ra,0x0
 32c:	180080e7          	jalr	384(ra) # 4a8 <fstat>
 330:	892a                	mv	s2,a0
  close(fd);
 332:	8526                	mv	a0,s1
 334:	00000097          	auipc	ra,0x0
 338:	154080e7          	jalr	340(ra) # 488 <close>
  return r;
}
 33c:	854a                	mv	a0,s2
 33e:	60e2                	ld	ra,24(sp)
 340:	6442                	ld	s0,16(sp)
 342:	64a2                	ld	s1,8(sp)
 344:	6902                	ld	s2,0(sp)
 346:	6105                	addi	sp,sp,32
 348:	8082                	ret
    return -1;
 34a:	597d                	li	s2,-1
 34c:	bfc5                	j	33c <stat+0x34>

000000000000034e <atoi>:

int
atoi(const char *s)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 354:	00054703          	lbu	a4,0(a0)
 358:	02d00793          	li	a5,45
  int neg = 1;
 35c:	4585                	li	a1,1
  if (*s == '-') {
 35e:	04f70363          	beq	a4,a5,3a4 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 362:	00054703          	lbu	a4,0(a0)
 366:	fd07079b          	addiw	a5,a4,-48
 36a:	0ff7f793          	zext.b	a5,a5
 36e:	46a5                	li	a3,9
 370:	02f6ed63          	bltu	a3,a5,3aa <atoi+0x5c>
  n = 0;
 374:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 376:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 378:	0505                	addi	a0,a0,1
 37a:	0026979b          	slliw	a5,a3,0x2
 37e:	9fb5                	addw	a5,a5,a3
 380:	0017979b          	slliw	a5,a5,0x1
 384:	9fb9                	addw	a5,a5,a4
 386:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 38a:	00054703          	lbu	a4,0(a0)
 38e:	fd07079b          	addiw	a5,a4,-48
 392:	0ff7f793          	zext.b	a5,a5
 396:	fef671e3          	bgeu	a2,a5,378 <atoi+0x2a>
  return n * neg;
}
 39a:	02d5853b          	mulw	a0,a1,a3
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
    s++;
 3a4:	0505                	addi	a0,a0,1
    neg = -1;
 3a6:	55fd                	li	a1,-1
 3a8:	bf6d                	j	362 <atoi+0x14>
  n = 0;
 3aa:	4681                	li	a3,0
 3ac:	b7fd                	j	39a <atoi+0x4c>

00000000000003ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b4:	02b57463          	bgeu	a0,a1,3dc <memmove+0x2e>
    while(n-- > 0)
 3b8:	00c05f63          	blez	a2,3d6 <memmove+0x28>
 3bc:	1602                	slli	a2,a2,0x20
 3be:	9201                	srli	a2,a2,0x20
 3c0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3c4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3c6:	0585                	addi	a1,a1,1
 3c8:	0705                	addi	a4,a4,1
 3ca:	fff5c683          	lbu	a3,-1(a1)
 3ce:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d2:	fee79ae3          	bne	a5,a4,3c6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret
    dst += n;
 3dc:	00c50733          	add	a4,a0,a2
    src += n;
 3e0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e2:	fec05ae3          	blez	a2,3d6 <memmove+0x28>
 3e6:	fff6079b          	addiw	a5,a2,-1
 3ea:	1782                	slli	a5,a5,0x20
 3ec:	9381                	srli	a5,a5,0x20
 3ee:	fff7c793          	not	a5,a5
 3f2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f4:	15fd                	addi	a1,a1,-1
 3f6:	177d                	addi	a4,a4,-1
 3f8:	0005c683          	lbu	a3,0(a1)
 3fc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 400:	fee79ae3          	bne	a5,a4,3f4 <memmove+0x46>
 404:	bfc9                	j	3d6 <memmove+0x28>

0000000000000406 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 406:	1141                	addi	sp,sp,-16
 408:	e422                	sd	s0,8(sp)
 40a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 40c:	ca05                	beqz	a2,43c <memcmp+0x36>
 40e:	fff6069b          	addiw	a3,a2,-1
 412:	1682                	slli	a3,a3,0x20
 414:	9281                	srli	a3,a3,0x20
 416:	0685                	addi	a3,a3,1
 418:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 41a:	00054783          	lbu	a5,0(a0)
 41e:	0005c703          	lbu	a4,0(a1)
 422:	00e79863          	bne	a5,a4,432 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 426:	0505                	addi	a0,a0,1
    p2++;
 428:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 42a:	fed518e3          	bne	a0,a3,41a <memcmp+0x14>
  }
  return 0;
 42e:	4501                	li	a0,0
 430:	a019                	j	436 <memcmp+0x30>
      return *p1 - *p2;
 432:	40e7853b          	subw	a0,a5,a4
}
 436:	6422                	ld	s0,8(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret
  return 0;
 43c:	4501                	li	a0,0
 43e:	bfe5                	j	436 <memcmp+0x30>

0000000000000440 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 440:	1141                	addi	sp,sp,-16
 442:	e406                	sd	ra,8(sp)
 444:	e022                	sd	s0,0(sp)
 446:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 448:	00000097          	auipc	ra,0x0
 44c:	f66080e7          	jalr	-154(ra) # 3ae <memmove>
}
 450:	60a2                	ld	ra,8(sp)
 452:	6402                	ld	s0,0(sp)
 454:	0141                	addi	sp,sp,16
 456:	8082                	ret

0000000000000458 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 458:	4885                	li	a7,1
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <exit>:
.global exit
exit:
 li a7, SYS_exit
 460:	4889                	li	a7,2
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <wait>:
.global wait
wait:
 li a7, SYS_wait
 468:	488d                	li	a7,3
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 470:	4891                	li	a7,4
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <read>:
.global read
read:
 li a7, SYS_read
 478:	4895                	li	a7,5
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <write>:
.global write
write:
 li a7, SYS_write
 480:	48c1                	li	a7,16
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <close>:
.global close
close:
 li a7, SYS_close
 488:	48d5                	li	a7,21
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <kill>:
.global kill
kill:
 li a7, SYS_kill
 490:	4899                	li	a7,6
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <exec>:
.global exec
exec:
 li a7, SYS_exec
 498:	489d                	li	a7,7
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <open>:
.global open
open:
 li a7, SYS_open
 4a0:	48bd                	li	a7,15
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4a8:	48a1                	li	a7,8
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b0:	48d1                	li	a7,20
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b8:	48a5                	li	a7,9
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c0:	48a9                	li	a7,10
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c8:	48ad                	li	a7,11
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4d0:	48b1                	li	a7,12
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d8:	48b5                	li	a7,13
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e0:	48b9                	li	a7,14
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 4e8:	48d9                	li	a7,22
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <dev>:
.global dev
dev:
 li a7, SYS_dev
 4f0:	48dd                	li	a7,23
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4f8:	48e1                	li	a7,24
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 500:	48e5                	li	a7,25
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <remove>:
.global remove
remove:
 li a7, SYS_remove
 508:	48c5                	li	a7,17
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <trace>:
.global trace
trace:
 li a7, SYS_trace
 510:	48c9                	li	a7,18
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 518:	48cd                	li	a7,19
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <rename>:
.global rename
rename:
 li a7, SYS_rename
 520:	48e9                	li	a7,26
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 528:	48ed                	li	a7,27
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 530:	48f1                	li	a7,28
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 538:	48f5                	li	a7,29
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 540:	48f9                	li	a7,30
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 548:	48fd                	li	a7,31
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 550:	02000893          	li	a7,32
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 55a:	02100893          	li	a7,33
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 564:	02200893          	li	a7,34
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 56e:	02300893          	li	a7,35
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 578:	02400893          	li	a7,36
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 582:	02500893          	li	a7,37
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 58c:	02600893          	li	a7,38
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 596:	02700893          	li	a7,39
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 5a0:	02800893          	li	a7,40
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 5aa:	02900893          	li	a7,41
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 5b4:	02a00893          	li	a7,42
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 5be:	02b00893          	li	a7,43
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 5c8:	02c00893          	li	a7,44
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 5d2:	02d00893          	li	a7,45
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 5dc:	02e00893          	li	a7,46
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 5e6:	02f00893          	li	a7,47
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 5f0:	03000893          	li	a7,48
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 5fa:	03100893          	li	a7,49
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 604:	03200893          	li	a7,50
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 60e:	03300893          	li	a7,51
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 618:	03400893          	li	a7,52
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 622:	03500893          	li	a7,53
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 62c:	03600893          	li	a7,54
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 636:	03700893          	li	a7,55
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 640:	03800893          	li	a7,56
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 64a:	03900893          	li	a7,57
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 654:	03a00893          	li	a7,58
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <poll>:
.global poll
poll:
 li a7, SYS_poll
 65e:	03b00893          	li	a7,59
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 668:	03c00893          	li	a7,60
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 672:	03d00893          	li	a7,61
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 67c:	03e00893          	li	a7,62
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <clone>:
.global clone
clone:
 li a7, SYS_clone
 686:	03f00893          	li	a7,63
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <futex>:
.global futex
futex:
 li a7, SYS_futex
 690:	04000893          	li	a7,64
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 69a:	04100893          	li	a7,65
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <halt>:
.global halt
halt:
 li a7, SYS_halt
 6a4:	04200893          	li	a7,66
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 6ae:	04300893          	li	a7,67
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6b8:	04400893          	li	a7,68
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6c2:	04500893          	li	a7,69
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <listen>:
.global listen
listen:
 li a7, SYS_listen
 6cc:	04600893          	li	a7,70
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <accept>:
.global accept
accept:
 li a7, SYS_accept
 6d6:	04700893          	li	a7,71
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <connect>:
.global connect
connect:
 li a7, SYS_connect
 6e0:	04800893          	li	a7,72
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <send>:
.global send
send:
 li a7, SYS_send
 6ea:	04900893          	li	a7,73
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6f4:	04a00893          	li	a7,74
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 6fe:	04b00893          	li	a7,75
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 708:	1101                	addi	sp,sp,-32
 70a:	ec06                	sd	ra,24(sp)
 70c:	e822                	sd	s0,16(sp)
 70e:	1000                	addi	s0,sp,32
 710:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 714:	4605                	li	a2,1
 716:	fef40593          	addi	a1,s0,-17
 71a:	00000097          	auipc	ra,0x0
 71e:	d66080e7          	jalr	-666(ra) # 480 <write>
}
 722:	60e2                	ld	ra,24(sp)
 724:	6442                	ld	s0,16(sp)
 726:	6105                	addi	sp,sp,32
 728:	8082                	ret

000000000000072a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 72a:	7139                	addi	sp,sp,-64
 72c:	fc06                	sd	ra,56(sp)
 72e:	f822                	sd	s0,48(sp)
 730:	f426                	sd	s1,40(sp)
 732:	f04a                	sd	s2,32(sp)
 734:	ec4e                	sd	s3,24(sp)
 736:	0080                	addi	s0,sp,64
 738:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 73a:	c299                	beqz	a3,740 <printint+0x16>
 73c:	0805c863          	bltz	a1,7cc <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 740:	2581                	sext.w	a1,a1
  neg = 0;
 742:	4881                	li	a7,0
  }

  i = 0;
 744:	fc040993          	addi	s3,s0,-64
  neg = 0;
 748:	86ce                	mv	a3,s3
  i = 0;
 74a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 74c:	2601                	sext.w	a2,a2
 74e:	00000517          	auipc	a0,0x0
 752:	4fa50513          	addi	a0,a0,1274 # c48 <digits>
 756:	883a                	mv	a6,a4
 758:	2705                	addiw	a4,a4,1
 75a:	02c5f7bb          	remuw	a5,a1,a2
 75e:	1782                	slli	a5,a5,0x20
 760:	9381                	srli	a5,a5,0x20
 762:	97aa                	add	a5,a5,a0
 764:	0007c783          	lbu	a5,0(a5)
 768:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 76c:	0005879b          	sext.w	a5,a1
 770:	02c5d5bb          	divuw	a1,a1,a2
 774:	0685                	addi	a3,a3,1
 776:	fec7f0e3          	bgeu	a5,a2,756 <printint+0x2c>
  if(neg)
 77a:	00088c63          	beqz	a7,792 <printint+0x68>
    buf[i++] = '-';
 77e:	fd070793          	addi	a5,a4,-48
 782:	00878733          	add	a4,a5,s0
 786:	02d00793          	li	a5,45
 78a:	fef70823          	sb	a5,-16(a4)
 78e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 792:	02e05663          	blez	a4,7be <printint+0x94>
 796:	fc040913          	addi	s2,s0,-64
 79a:	993a                	add	s2,s2,a4
 79c:	19fd                	addi	s3,s3,-1
 79e:	99ba                	add	s3,s3,a4
 7a0:	377d                	addiw	a4,a4,-1
 7a2:	1702                	slli	a4,a4,0x20
 7a4:	9301                	srli	a4,a4,0x20
 7a6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7aa:	fff94583          	lbu	a1,-1(s2)
 7ae:	8526                	mv	a0,s1
 7b0:	00000097          	auipc	ra,0x0
 7b4:	f58080e7          	jalr	-168(ra) # 708 <putc>
  while(--i >= 0)
 7b8:	197d                	addi	s2,s2,-1
 7ba:	ff3918e3          	bne	s2,s3,7aa <printint+0x80>
}
 7be:	70e2                	ld	ra,56(sp)
 7c0:	7442                	ld	s0,48(sp)
 7c2:	74a2                	ld	s1,40(sp)
 7c4:	7902                	ld	s2,32(sp)
 7c6:	69e2                	ld	s3,24(sp)
 7c8:	6121                	addi	sp,sp,64
 7ca:	8082                	ret
    x = -xx;
 7cc:	40b005bb          	negw	a1,a1
    neg = 1;
 7d0:	4885                	li	a7,1
    x = -xx;
 7d2:	bf8d                	j	744 <printint+0x1a>

00000000000007d4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7d4:	7119                	addi	sp,sp,-128
 7d6:	fc86                	sd	ra,120(sp)
 7d8:	f8a2                	sd	s0,112(sp)
 7da:	f4a6                	sd	s1,104(sp)
 7dc:	f0ca                	sd	s2,96(sp)
 7de:	ecce                	sd	s3,88(sp)
 7e0:	e8d2                	sd	s4,80(sp)
 7e2:	e4d6                	sd	s5,72(sp)
 7e4:	e0da                	sd	s6,64(sp)
 7e6:	fc5e                	sd	s7,56(sp)
 7e8:	f862                	sd	s8,48(sp)
 7ea:	f466                	sd	s9,40(sp)
 7ec:	f06a                	sd	s10,32(sp)
 7ee:	ec6e                	sd	s11,24(sp)
 7f0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7f2:	0005c903          	lbu	s2,0(a1)
 7f6:	18090f63          	beqz	s2,994 <vprintf+0x1c0>
 7fa:	8aaa                	mv	s5,a0
 7fc:	8b32                	mv	s6,a2
 7fe:	00158493          	addi	s1,a1,1
  state = 0;
 802:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 804:	02500a13          	li	s4,37
 808:	4c55                	li	s8,21
 80a:	00000c97          	auipc	s9,0x0
 80e:	3e6c8c93          	addi	s9,s9,998 # bf0 <malloc+0x158>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 812:	02800d93          	li	s11,40
  putc(fd, 'x');
 816:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 818:	00000b97          	auipc	s7,0x0
 81c:	430b8b93          	addi	s7,s7,1072 # c48 <digits>
 820:	a839                	j	83e <vprintf+0x6a>
        putc(fd, c);
 822:	85ca                	mv	a1,s2
 824:	8556                	mv	a0,s5
 826:	00000097          	auipc	ra,0x0
 82a:	ee2080e7          	jalr	-286(ra) # 708 <putc>
 82e:	a019                	j	834 <vprintf+0x60>
    } else if(state == '%'){
 830:	01498d63          	beq	s3,s4,84a <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 834:	0485                	addi	s1,s1,1
 836:	fff4c903          	lbu	s2,-1(s1)
 83a:	14090d63          	beqz	s2,994 <vprintf+0x1c0>
    if(state == 0){
 83e:	fe0999e3          	bnez	s3,830 <vprintf+0x5c>
      if(c == '%'){
 842:	ff4910e3          	bne	s2,s4,822 <vprintf+0x4e>
        state = '%';
 846:	89d2                	mv	s3,s4
 848:	b7f5                	j	834 <vprintf+0x60>
      if(c == 'd'){
 84a:	11490c63          	beq	s2,s4,962 <vprintf+0x18e>
 84e:	f9d9079b          	addiw	a5,s2,-99
 852:	0ff7f793          	zext.b	a5,a5
 856:	10fc6e63          	bltu	s8,a5,972 <vprintf+0x19e>
 85a:	f9d9079b          	addiw	a5,s2,-99
 85e:	0ff7f713          	zext.b	a4,a5
 862:	10ec6863          	bltu	s8,a4,972 <vprintf+0x19e>
 866:	00271793          	slli	a5,a4,0x2
 86a:	97e6                	add	a5,a5,s9
 86c:	439c                	lw	a5,0(a5)
 86e:	97e6                	add	a5,a5,s9
 870:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 872:	008b0913          	addi	s2,s6,8
 876:	4685                	li	a3,1
 878:	4629                	li	a2,10
 87a:	000b2583          	lw	a1,0(s6)
 87e:	8556                	mv	a0,s5
 880:	00000097          	auipc	ra,0x0
 884:	eaa080e7          	jalr	-342(ra) # 72a <printint>
 888:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 88a:	4981                	li	s3,0
 88c:	b765                	j	834 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88e:	008b0913          	addi	s2,s6,8
 892:	4681                	li	a3,0
 894:	4629                	li	a2,10
 896:	000b2583          	lw	a1,0(s6)
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	e8e080e7          	jalr	-370(ra) # 72a <printint>
 8a4:	8b4a                	mv	s6,s2
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	b771                	j	834 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8aa:	008b0913          	addi	s2,s6,8
 8ae:	4681                	li	a3,0
 8b0:	866a                	mv	a2,s10
 8b2:	000b2583          	lw	a1,0(s6)
 8b6:	8556                	mv	a0,s5
 8b8:	00000097          	auipc	ra,0x0
 8bc:	e72080e7          	jalr	-398(ra) # 72a <printint>
 8c0:	8b4a                	mv	s6,s2
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bf85                	j	834 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8c6:	008b0793          	addi	a5,s6,8
 8ca:	f8f43423          	sd	a5,-120(s0)
 8ce:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8d2:	03000593          	li	a1,48
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	e30080e7          	jalr	-464(ra) # 708 <putc>
  putc(fd, 'x');
 8e0:	07800593          	li	a1,120
 8e4:	8556                	mv	a0,s5
 8e6:	00000097          	auipc	ra,0x0
 8ea:	e22080e7          	jalr	-478(ra) # 708 <putc>
 8ee:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f0:	03c9d793          	srli	a5,s3,0x3c
 8f4:	97de                	add	a5,a5,s7
 8f6:	0007c583          	lbu	a1,0(a5)
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	e0c080e7          	jalr	-500(ra) # 708 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 904:	0992                	slli	s3,s3,0x4
 906:	397d                	addiw	s2,s2,-1
 908:	fe0914e3          	bnez	s2,8f0 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 90c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 910:	4981                	li	s3,0
 912:	b70d                	j	834 <vprintf+0x60>
        s = va_arg(ap, char*);
 914:	008b0913          	addi	s2,s6,8
 918:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 91c:	02098163          	beqz	s3,93e <vprintf+0x16a>
        while(*s != 0){
 920:	0009c583          	lbu	a1,0(s3)
 924:	c5ad                	beqz	a1,98e <vprintf+0x1ba>
          putc(fd, *s);
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	de0080e7          	jalr	-544(ra) # 708 <putc>
          s++;
 930:	0985                	addi	s3,s3,1
        while(*s != 0){
 932:	0009c583          	lbu	a1,0(s3)
 936:	f9e5                	bnez	a1,926 <vprintf+0x152>
        s = va_arg(ap, char*);
 938:	8b4a                	mv	s6,s2
      state = 0;
 93a:	4981                	li	s3,0
 93c:	bde5                	j	834 <vprintf+0x60>
          s = "(null)";
 93e:	00000997          	auipc	s3,0x0
 942:	2aa98993          	addi	s3,s3,682 # be8 <malloc+0x150>
        while(*s != 0){
 946:	85ee                	mv	a1,s11
 948:	bff9                	j	926 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 94a:	008b0913          	addi	s2,s6,8
 94e:	000b4583          	lbu	a1,0(s6)
 952:	8556                	mv	a0,s5
 954:	00000097          	auipc	ra,0x0
 958:	db4080e7          	jalr	-588(ra) # 708 <putc>
 95c:	8b4a                	mv	s6,s2
      state = 0;
 95e:	4981                	li	s3,0
 960:	bdd1                	j	834 <vprintf+0x60>
        putc(fd, c);
 962:	85d2                	mv	a1,s4
 964:	8556                	mv	a0,s5
 966:	00000097          	auipc	ra,0x0
 96a:	da2080e7          	jalr	-606(ra) # 708 <putc>
      state = 0;
 96e:	4981                	li	s3,0
 970:	b5d1                	j	834 <vprintf+0x60>
        putc(fd, '%');
 972:	85d2                	mv	a1,s4
 974:	8556                	mv	a0,s5
 976:	00000097          	auipc	ra,0x0
 97a:	d92080e7          	jalr	-622(ra) # 708 <putc>
        putc(fd, c);
 97e:	85ca                	mv	a1,s2
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	d86080e7          	jalr	-634(ra) # 708 <putc>
      state = 0;
 98a:	4981                	li	s3,0
 98c:	b565                	j	834 <vprintf+0x60>
        s = va_arg(ap, char*);
 98e:	8b4a                	mv	s6,s2
      state = 0;
 990:	4981                	li	s3,0
 992:	b54d                	j	834 <vprintf+0x60>
    }
  }
}
 994:	70e6                	ld	ra,120(sp)
 996:	7446                	ld	s0,112(sp)
 998:	74a6                	ld	s1,104(sp)
 99a:	7906                	ld	s2,96(sp)
 99c:	69e6                	ld	s3,88(sp)
 99e:	6a46                	ld	s4,80(sp)
 9a0:	6aa6                	ld	s5,72(sp)
 9a2:	6b06                	ld	s6,64(sp)
 9a4:	7be2                	ld	s7,56(sp)
 9a6:	7c42                	ld	s8,48(sp)
 9a8:	7ca2                	ld	s9,40(sp)
 9aa:	7d02                	ld	s10,32(sp)
 9ac:	6de2                	ld	s11,24(sp)
 9ae:	6109                	addi	sp,sp,128
 9b0:	8082                	ret

00000000000009b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9b2:	715d                	addi	sp,sp,-80
 9b4:	ec06                	sd	ra,24(sp)
 9b6:	e822                	sd	s0,16(sp)
 9b8:	1000                	addi	s0,sp,32
 9ba:	e010                	sd	a2,0(s0)
 9bc:	e414                	sd	a3,8(s0)
 9be:	e818                	sd	a4,16(s0)
 9c0:	ec1c                	sd	a5,24(s0)
 9c2:	03043023          	sd	a6,32(s0)
 9c6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ca:	8622                	mv	a2,s0
 9cc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9d0:	00000097          	auipc	ra,0x0
 9d4:	e04080e7          	jalr	-508(ra) # 7d4 <vprintf>
}
 9d8:	60e2                	ld	ra,24(sp)
 9da:	6442                	ld	s0,16(sp)
 9dc:	6161                	addi	sp,sp,80
 9de:	8082                	ret

00000000000009e0 <printf>:

void
printf(const char *fmt, ...)
{
 9e0:	711d                	addi	sp,sp,-96
 9e2:	ec06                	sd	ra,24(sp)
 9e4:	e822                	sd	s0,16(sp)
 9e6:	1000                	addi	s0,sp,32
 9e8:	e40c                	sd	a1,8(s0)
 9ea:	e810                	sd	a2,16(s0)
 9ec:	ec14                	sd	a3,24(s0)
 9ee:	f018                	sd	a4,32(s0)
 9f0:	f41c                	sd	a5,40(s0)
 9f2:	03043823          	sd	a6,48(s0)
 9f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9fa:	00840613          	addi	a2,s0,8
 9fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a02:	85aa                	mv	a1,a0
 a04:	4505                	li	a0,1
 a06:	00000097          	auipc	ra,0x0
 a0a:	dce080e7          	jalr	-562(ra) # 7d4 <vprintf>
}
 a0e:	60e2                	ld	ra,24(sp)
 a10:	6442                	ld	s0,16(sp)
 a12:	6125                	addi	sp,sp,96
 a14:	8082                	ret

0000000000000a16 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a16:	1141                	addi	sp,sp,-16
 a18:	e422                	sd	s0,8(sp)
 a1a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a1c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a20:	00000797          	auipc	a5,0x0
 a24:	4407b783          	ld	a5,1088(a5) # e60 <freep>
 a28:	a02d                	j	a52 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a2a:	4618                	lw	a4,8(a2)
 a2c:	9f2d                	addw	a4,a4,a1
 a2e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a32:	6398                	ld	a4,0(a5)
 a34:	6310                	ld	a2,0(a4)
 a36:	a83d                	j	a74 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a38:	ff852703          	lw	a4,-8(a0)
 a3c:	9f31                	addw	a4,a4,a2
 a3e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a40:	ff053683          	ld	a3,-16(a0)
 a44:	a091                	j	a88 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a46:	6398                	ld	a4,0(a5)
 a48:	00e7e463          	bltu	a5,a4,a50 <free+0x3a>
 a4c:	00e6ea63          	bltu	a3,a4,a60 <free+0x4a>
{
 a50:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a52:	fed7fae3          	bgeu	a5,a3,a46 <free+0x30>
 a56:	6398                	ld	a4,0(a5)
 a58:	00e6e463          	bltu	a3,a4,a60 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5c:	fee7eae3          	bltu	a5,a4,a50 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a60:	ff852583          	lw	a1,-8(a0)
 a64:	6390                	ld	a2,0(a5)
 a66:	02059813          	slli	a6,a1,0x20
 a6a:	01c85713          	srli	a4,a6,0x1c
 a6e:	9736                	add	a4,a4,a3
 a70:	fae60de3          	beq	a2,a4,a2a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a74:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a78:	4790                	lw	a2,8(a5)
 a7a:	02061593          	slli	a1,a2,0x20
 a7e:	01c5d713          	srli	a4,a1,0x1c
 a82:	973e                	add	a4,a4,a5
 a84:	fae68ae3          	beq	a3,a4,a38 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a88:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a8a:	00000717          	auipc	a4,0x0
 a8e:	3cf73b23          	sd	a5,982(a4) # e60 <freep>
}
 a92:	6422                	ld	s0,8(sp)
 a94:	0141                	addi	sp,sp,16
 a96:	8082                	ret

0000000000000a98 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a98:	7139                	addi	sp,sp,-64
 a9a:	fc06                	sd	ra,56(sp)
 a9c:	f822                	sd	s0,48(sp)
 a9e:	f426                	sd	s1,40(sp)
 aa0:	f04a                	sd	s2,32(sp)
 aa2:	ec4e                	sd	s3,24(sp)
 aa4:	e852                	sd	s4,16(sp)
 aa6:	e456                	sd	s5,8(sp)
 aa8:	e05a                	sd	s6,0(sp)
 aaa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aac:	02051493          	slli	s1,a0,0x20
 ab0:	9081                	srli	s1,s1,0x20
 ab2:	04bd                	addi	s1,s1,15
 ab4:	8091                	srli	s1,s1,0x4
 ab6:	00148a1b          	addiw	s4,s1,1
 aba:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 abc:	00000517          	auipc	a0,0x0
 ac0:	3a453503          	ld	a0,932(a0) # e60 <freep>
 ac4:	c515                	beqz	a0,af0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac8:	4798                	lw	a4,8(a5)
 aca:	04977163          	bgeu	a4,s1,b0c <malloc+0x74>
 ace:	89d2                	mv	s3,s4
 ad0:	000a071b          	sext.w	a4,s4
 ad4:	6685                	lui	a3,0x1
 ad6:	00d77363          	bgeu	a4,a3,adc <malloc+0x44>
 ada:	6985                	lui	s3,0x1
 adc:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 ae0:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae4:	00000917          	auipc	s2,0x0
 ae8:	37c90913          	addi	s2,s2,892 # e60 <freep>
  if(p == (char*)-1)
 aec:	5afd                	li	s5,-1
 aee:	a8a5                	j	b66 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 af0:	00000797          	auipc	a5,0x0
 af4:	37078793          	addi	a5,a5,880 # e60 <freep>
 af8:	00000717          	auipc	a4,0x0
 afc:	37070713          	addi	a4,a4,880 # e68 <base>
 b00:	e398                	sd	a4,0(a5)
 b02:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 b04:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b08:	87ba                	mv	a5,a4
 b0a:	b7d1                	j	ace <malloc+0x36>
      if(p->s.size == nunits)
 b0c:	02e48c63          	beq	s1,a4,b44 <malloc+0xac>
        p->s.size -= nunits;
 b10:	4147073b          	subw	a4,a4,s4
 b14:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b16:	02071693          	slli	a3,a4,0x20
 b1a:	01c6d713          	srli	a4,a3,0x1c
 b1e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b20:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 b24:	00000717          	auipc	a4,0x0
 b28:	32a73e23          	sd	a0,828(a4) # e60 <freep>
      return (void*)(p + 1);
 b2c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b30:	70e2                	ld	ra,56(sp)
 b32:	7442                	ld	s0,48(sp)
 b34:	74a2                	ld	s1,40(sp)
 b36:	7902                	ld	s2,32(sp)
 b38:	69e2                	ld	s3,24(sp)
 b3a:	6a42                	ld	s4,16(sp)
 b3c:	6aa2                	ld	s5,8(sp)
 b3e:	6b02                	ld	s6,0(sp)
 b40:	6121                	addi	sp,sp,64
 b42:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b44:	6398                	ld	a4,0(a5)
 b46:	e118                	sd	a4,0(a0)
 b48:	bff1                	j	b24 <malloc+0x8c>
  hp->s.size = nu;
 b4a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b4e:	0541                	addi	a0,a0,16
 b50:	00000097          	auipc	ra,0x0
 b54:	ec6080e7          	jalr	-314(ra) # a16 <free>
  return freep;
 b58:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b5c:	d971                	beqz	a0,b30 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b5e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b60:	4798                	lw	a4,8(a5)
 b62:	fa9775e3          	bgeu	a4,s1,b0c <malloc+0x74>
    if(p == freep)
 b66:	00093703          	ld	a4,0(s2)
 b6a:	853e                	mv	a0,a5
 b6c:	fef719e3          	bne	a4,a5,b5e <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 b70:	854e                	mv	a0,s3
 b72:	00000097          	auipc	ra,0x0
 b76:	95e080e7          	jalr	-1698(ra) # 4d0 <sbrk>
  if(p == (char*)-1)
 b7a:	fd5518e3          	bne	a0,s5,b4a <malloc+0xb2>
        return 0;
 b7e:	4501                	li	a0,0
 b80:	bf45                	j	b30 <malloc+0x98>
