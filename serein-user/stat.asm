
serein-user/_stat：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
   0:	7135                	addi	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	e14a                	sd	s2,128(sp)
   a:	fcce                	sd	s3,120(sp)
   c:	f8d2                	sd	s4,112(sp)
   e:	f4d6                	sd	s5,104(sp)
  10:	f0da                	sd	s6,96(sp)
  12:	ecde                	sd	s7,88(sp)
  14:	e8e2                	sd	s8,80(sp)
  16:	e4e6                	sd	s9,72(sp)
  18:	e0ea                	sd	s10,64(sp)
  1a:	1100                	addi	s0,sp,160
  struct stat st;
  int i;

  if(argc <= 1){
  1c:	4785                	li	a5,1
  1e:	04a7d263          	bge	a5,a0,62 <main+0x62>
  22:	00858493          	addi	s1,a1,8
  26:	ffe5091b          	addiw	s2,a0,-2
  2a:	02091793          	slli	a5,s2,0x20
  2e:	01d7d913          	srli	s2,a5,0x1d
  32:	05c1                	addi	a1,a1,16
  34:	992e                	add	s2,s2,a1
    fprintf(2, "usage: stat file...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(stat(argv[i], &st) < 0){
  36:	f6040993          	addi	s3,s0,-160
      fprintf(2, "stat: cannot stat %s\n", argv[i]);
      continue;
    }
    printf("%s:\n", argv[i]);
  3a:	00001c97          	auipc	s9,0x1
  3e:	b1ec8c93          	addi	s9,s9,-1250 # b58 <malloc+0x120>
    printf("  type: ");
  42:	00001c17          	auipc	s8,0x1
  46:	b1ec0c13          	addi	s8,s8,-1250 # b60 <malloc+0x128>
    if(st.type == T_DIR) printf("directory\n");
  4a:	4b85                	li	s7,1
    else if(st.type == T_FILE) printf("file\n");
    else if(st.type == T_DEVICE) printf("device\n");
    else printf("unknown(%d)\n", st.type);
    printf("  size: %d bytes\n", st.size);
  4c:	00001b17          	auipc	s6,0x1
  50:	b54b0b13          	addi	s6,s6,-1196 # ba0 <malloc+0x168>
    printf("  dev: %d\n", st.dev);
  54:	00001a97          	auipc	s5,0x1
  58:	b64a8a93          	addi	s5,s5,-1180 # bb8 <malloc+0x180>
    else if(st.type == T_FILE) printf("file\n");
  5c:	4a09                	li	s4,2
    else if(st.type == T_DEVICE) printf("device\n");
  5e:	4d0d                	li	s10,3
  60:	a069                	j	ea <main+0xea>
    fprintf(2, "usage: stat file...\n");
  62:	00001597          	auipc	a1,0x1
  66:	ac658593          	addi	a1,a1,-1338 # b28 <malloc+0xf0>
  6a:	4509                	li	a0,2
  6c:	00001097          	auipc	ra,0x1
  70:	8e6080e7          	jalr	-1818(ra) # 952 <fprintf>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	38a080e7          	jalr	906(ra) # 400 <exit>
      fprintf(2, "stat: cannot stat %s\n", argv[i]);
  7e:	6090                	ld	a2,0(s1)
  80:	00001597          	auipc	a1,0x1
  84:	ac058593          	addi	a1,a1,-1344 # b40 <malloc+0x108>
  88:	8552                	mv	a0,s4
  8a:	00001097          	auipc	ra,0x1
  8e:	8c8080e7          	jalr	-1848(ra) # 952 <fprintf>
      continue;
  92:	a889                	j	e4 <main+0xe4>
    if(st.type == T_DIR) printf("directory\n");
  94:	00001517          	auipc	a0,0x1
  98:	adc50513          	addi	a0,a0,-1316 # b70 <malloc+0x138>
  9c:	00001097          	auipc	ra,0x1
  a0:	8e4080e7          	jalr	-1820(ra) # 980 <printf>
  a4:	a015                	j	c8 <main+0xc8>
    else if(st.type == T_FILE) printf("file\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	ada50513          	addi	a0,a0,-1318 # b80 <malloc+0x148>
  ae:	00001097          	auipc	ra,0x1
  b2:	8d2080e7          	jalr	-1838(ra) # 980 <printf>
  b6:	a809                	j	c8 <main+0xc8>
    else if(st.type == T_DEVICE) printf("device\n");
  b8:	00001517          	auipc	a0,0x1
  bc:	ad050513          	addi	a0,a0,-1328 # b88 <malloc+0x150>
  c0:	00001097          	auipc	ra,0x1
  c4:	8c0080e7          	jalr	-1856(ra) # 980 <printf>
    printf("  size: %d bytes\n", st.size);
  c8:	f9043583          	ld	a1,-112(s0)
  cc:	855a                	mv	a0,s6
  ce:	00001097          	auipc	ra,0x1
  d2:	8b2080e7          	jalr	-1870(ra) # 980 <printf>
    printf("  dev: %d\n", st.dev);
  d6:	f8442583          	lw	a1,-124(s0)
  da:	8556                	mv	a0,s5
  dc:	00001097          	auipc	ra,0x1
  e0:	8a4080e7          	jalr	-1884(ra) # 980 <printf>
  for(i = 1; i < argc; i++){
  e4:	04a1                	addi	s1,s1,8
  e6:	05248c63          	beq	s1,s2,13e <main+0x13e>
    if(stat(argv[i], &st) < 0){
  ea:	85ce                	mv	a1,s3
  ec:	6088                	ld	a0,0(s1)
  ee:	00000097          	auipc	ra,0x0
  f2:	1ba080e7          	jalr	442(ra) # 2a8 <stat>
  f6:	f80544e3          	bltz	a0,7e <main+0x7e>
    printf("%s:\n", argv[i]);
  fa:	608c                	ld	a1,0(s1)
  fc:	8566                	mv	a0,s9
  fe:	00001097          	auipc	ra,0x1
 102:	882080e7          	jalr	-1918(ra) # 980 <printf>
    printf("  type: ");
 106:	8562                	mv	a0,s8
 108:	00001097          	auipc	ra,0x1
 10c:	878080e7          	jalr	-1928(ra) # 980 <printf>
    if(st.type == T_DIR) printf("directory\n");
 110:	f8841583          	lh	a1,-120(s0)
 114:	0005879b          	sext.w	a5,a1
 118:	f7778ee3          	beq	a5,s7,94 <main+0x94>
    else if(st.type == T_FILE) printf("file\n");
 11c:	0005879b          	sext.w	a5,a1
 120:	f94783e3          	beq	a5,s4,a6 <main+0xa6>
    else if(st.type == T_DEVICE) printf("device\n");
 124:	0005879b          	sext.w	a5,a1
 128:	f9a788e3          	beq	a5,s10,b8 <main+0xb8>
    else printf("unknown(%d)\n", st.type);
 12c:	00001517          	auipc	a0,0x1
 130:	a6450513          	addi	a0,a0,-1436 # b90 <malloc+0x158>
 134:	00001097          	auipc	ra,0x1
 138:	84c080e7          	jalr	-1972(ra) # 980 <printf>
 13c:	b771                	j	c8 <main+0xc8>
  }
  exit(0);
 13e:	4501                	li	a0,0
 140:	00000097          	auipc	ra,0x0
 144:	2c0080e7          	jalr	704(ra) # 400 <exit>

0000000000000148 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e422                	sd	s0,8(sp)
 14c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14e:	87aa                	mv	a5,a0
 150:	0585                	addi	a1,a1,1
 152:	0785                	addi	a5,a5,1
 154:	fff5c703          	lbu	a4,-1(a1)
 158:	fee78fa3          	sb	a4,-1(a5)
 15c:	fb75                	bnez	a4,150 <strcpy+0x8>
    ;
  return os;
}
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strcat>:

char*
strcat(char *s, const char *t)
{
 164:	1141                	addi	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 16a:	00054783          	lbu	a5,0(a0)
 16e:	c385                	beqz	a5,18e <strcat+0x2a>
 170:	87aa                	mv	a5,a0
    s++;
 172:	0785                	addi	a5,a5,1
  while(*s)
 174:	0007c703          	lbu	a4,0(a5)
 178:	ff6d                	bnez	a4,172 <strcat+0xe>
  while((*s++ = *t++))
 17a:	0585                	addi	a1,a1,1
 17c:	0785                	addi	a5,a5,1
 17e:	fff5c703          	lbu	a4,-1(a1)
 182:	fee78fa3          	sb	a4,-1(a5)
 186:	fb75                	bnez	a4,17a <strcat+0x16>
    ;
  return os;
}
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret
  while(*s)
 18e:	87aa                	mv	a5,a0
 190:	b7ed                	j	17a <strcat+0x16>

0000000000000192 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 192:	1141                	addi	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 198:	00054783          	lbu	a5,0(a0)
 19c:	cb91                	beqz	a5,1b0 <strcmp+0x1e>
 19e:	0005c703          	lbu	a4,0(a1)
 1a2:	00f71763          	bne	a4,a5,1b0 <strcmp+0x1e>
    p++, q++;
 1a6:	0505                	addi	a0,a0,1
 1a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1aa:	00054783          	lbu	a5,0(a0)
 1ae:	fbe5                	bnez	a5,19e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1b0:	0005c503          	lbu	a0,0(a1)
}
 1b4:	40a7853b          	subw	a0,a5,a0
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strlen>:

uint
strlen(const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	cf91                	beqz	a5,1e4 <strlen+0x26>
 1ca:	0505                	addi	a0,a0,1
 1cc:	87aa                	mv	a5,a0
 1ce:	4685                	li	a3,1
 1d0:	9e89                	subw	a3,a3,a0
 1d2:	00f6853b          	addw	a0,a3,a5
 1d6:	0785                	addi	a5,a5,1
 1d8:	fff7c703          	lbu	a4,-1(a5)
 1dc:	fb7d                	bnez	a4,1d2 <strlen+0x14>
    ;
  return n;
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
  for(n = 0; s[n]; n++)
 1e4:	4501                	li	a0,0
 1e6:	bfe5                	j	1de <strlen+0x20>

00000000000001e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ee:	ca19                	beqz	a2,204 <memset+0x1c>
 1f0:	87aa                	mv	a5,a0
 1f2:	1602                	slli	a2,a2,0x20
 1f4:	9201                	srli	a2,a2,0x20
 1f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1fe:	0785                	addi	a5,a5,1
 200:	fee79de3          	bne	a5,a4,1fa <memset+0x12>
  }
  return dst;
}
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret

000000000000020a <strchr>:

char*
strchr(const char *s, char c)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 210:	00054783          	lbu	a5,0(a0)
 214:	cb99                	beqz	a5,22a <strchr+0x20>
    if(*s == c)
 216:	00f58763          	beq	a1,a5,224 <strchr+0x1a>
  for(; *s; s++)
 21a:	0505                	addi	a0,a0,1
 21c:	00054783          	lbu	a5,0(a0)
 220:	fbfd                	bnez	a5,216 <strchr+0xc>
      return (char*)s;
  return 0;
 222:	4501                	li	a0,0
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  return 0;
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <strchr+0x1a>

000000000000022e <gets>:

char*
gets(char *buf, int max)
{
 22e:	711d                	addi	sp,sp,-96
 230:	ec86                	sd	ra,88(sp)
 232:	e8a2                	sd	s0,80(sp)
 234:	e4a6                	sd	s1,72(sp)
 236:	e0ca                	sd	s2,64(sp)
 238:	fc4e                	sd	s3,56(sp)
 23a:	f852                	sd	s4,48(sp)
 23c:	f456                	sd	s5,40(sp)
 23e:	f05a                	sd	s6,32(sp)
 240:	ec5e                	sd	s7,24(sp)
 242:	e862                	sd	s8,16(sp)
 244:	1080                	addi	s0,sp,96
 246:	8baa                	mv	s7,a0
 248:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24a:	892a                	mv	s2,a0
 24c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 24e:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 252:	4b29                	li	s6,10
 254:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 256:	89a6                	mv	s3,s1
 258:	2485                	addiw	s1,s1,1
 25a:	0344d763          	bge	s1,s4,288 <gets+0x5a>
    cc = read(0, &c, 1);
 25e:	4605                	li	a2,1
 260:	85d6                	mv	a1,s5
 262:	4501                	li	a0,0
 264:	00000097          	auipc	ra,0x0
 268:	1b4080e7          	jalr	436(ra) # 418 <read>
    if(cc < 1)
 26c:	00a05e63          	blez	a0,288 <gets+0x5a>
    buf[i++] = c;
 270:	faf44783          	lbu	a5,-81(s0)
 274:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 278:	01678763          	beq	a5,s6,286 <gets+0x58>
 27c:	0905                	addi	s2,s2,1
 27e:	fd879ce3          	bne	a5,s8,256 <gets+0x28>
  for(i=0; i+1 < max; ){
 282:	89a6                	mv	s3,s1
 284:	a011                	j	288 <gets+0x5a>
 286:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 288:	99de                	add	s3,s3,s7
 28a:	00098023          	sb	zero,0(s3)
  return buf;
}
 28e:	855e                	mv	a0,s7
 290:	60e6                	ld	ra,88(sp)
 292:	6446                	ld	s0,80(sp)
 294:	64a6                	ld	s1,72(sp)
 296:	6906                	ld	s2,64(sp)
 298:	79e2                	ld	s3,56(sp)
 29a:	7a42                	ld	s4,48(sp)
 29c:	7aa2                	ld	s5,40(sp)
 29e:	7b02                	ld	s6,32(sp)
 2a0:	6be2                	ld	s7,24(sp)
 2a2:	6c42                	ld	s8,16(sp)
 2a4:	6125                	addi	sp,sp,96
 2a6:	8082                	ret

00000000000002a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a8:	1101                	addi	sp,sp,-32
 2aa:	ec06                	sd	ra,24(sp)
 2ac:	e822                	sd	s0,16(sp)
 2ae:	e426                	sd	s1,8(sp)
 2b0:	e04a                	sd	s2,0(sp)
 2b2:	1000                	addi	s0,sp,32
 2b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	4581                	li	a1,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	188080e7          	jalr	392(ra) # 440 <open>
  if(fd < 0)
 2c0:	02054563          	bltz	a0,2ea <stat+0x42>
 2c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c6:	85ca                	mv	a1,s2
 2c8:	00000097          	auipc	ra,0x0
 2cc:	180080e7          	jalr	384(ra) # 448 <fstat>
 2d0:	892a                	mv	s2,a0
  close(fd);
 2d2:	8526                	mv	a0,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	154080e7          	jalr	340(ra) # 428 <close>
  return r;
}
 2dc:	854a                	mv	a0,s2
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	64a2                	ld	s1,8(sp)
 2e4:	6902                	ld	s2,0(sp)
 2e6:	6105                	addi	sp,sp,32
 2e8:	8082                	ret
    return -1;
 2ea:	597d                	li	s2,-1
 2ec:	bfc5                	j	2dc <stat+0x34>

00000000000002ee <atoi>:

int
atoi(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 2f4:	00054703          	lbu	a4,0(a0)
 2f8:	02d00793          	li	a5,45
  int neg = 1;
 2fc:	4585                	li	a1,1
  if (*s == '-') {
 2fe:	04f70363          	beq	a4,a5,344 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 302:	00054703          	lbu	a4,0(a0)
 306:	fd07079b          	addiw	a5,a4,-48
 30a:	0ff7f793          	zext.b	a5,a5
 30e:	46a5                	li	a3,9
 310:	02f6ed63          	bltu	a3,a5,34a <atoi+0x5c>
  n = 0;
 314:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 316:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 318:	0505                	addi	a0,a0,1
 31a:	0026979b          	slliw	a5,a3,0x2
 31e:	9fb5                	addw	a5,a5,a3
 320:	0017979b          	slliw	a5,a5,0x1
 324:	9fb9                	addw	a5,a5,a4
 326:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 32a:	00054703          	lbu	a4,0(a0)
 32e:	fd07079b          	addiw	a5,a4,-48
 332:	0ff7f793          	zext.b	a5,a5
 336:	fef671e3          	bgeu	a2,a5,318 <atoi+0x2a>
  return n * neg;
}
 33a:	02d5853b          	mulw	a0,a1,a3
 33e:	6422                	ld	s0,8(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret
    s++;
 344:	0505                	addi	a0,a0,1
    neg = -1;
 346:	55fd                	li	a1,-1
 348:	bf6d                	j	302 <atoi+0x14>
  n = 0;
 34a:	4681                	li	a3,0
 34c:	b7fd                	j	33a <atoi+0x4c>

000000000000034e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 354:	02b57463          	bgeu	a0,a1,37c <memmove+0x2e>
    while(n-- > 0)
 358:	00c05f63          	blez	a2,376 <memmove+0x28>
 35c:	1602                	slli	a2,a2,0x20
 35e:	9201                	srli	a2,a2,0x20
 360:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 364:	872a                	mv	a4,a0
      *dst++ = *src++;
 366:	0585                	addi	a1,a1,1
 368:	0705                	addi	a4,a4,1
 36a:	fff5c683          	lbu	a3,-1(a1)
 36e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 372:	fee79ae3          	bne	a5,a4,366 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret
    dst += n;
 37c:	00c50733          	add	a4,a0,a2
    src += n;
 380:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 382:	fec05ae3          	blez	a2,376 <memmove+0x28>
 386:	fff6079b          	addiw	a5,a2,-1
 38a:	1782                	slli	a5,a5,0x20
 38c:	9381                	srli	a5,a5,0x20
 38e:	fff7c793          	not	a5,a5
 392:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 394:	15fd                	addi	a1,a1,-1
 396:	177d                	addi	a4,a4,-1
 398:	0005c683          	lbu	a3,0(a1)
 39c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3a0:	fee79ae3          	bne	a5,a4,394 <memmove+0x46>
 3a4:	bfc9                	j	376 <memmove+0x28>

00000000000003a6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3a6:	1141                	addi	sp,sp,-16
 3a8:	e422                	sd	s0,8(sp)
 3aa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ac:	ca05                	beqz	a2,3dc <memcmp+0x36>
 3ae:	fff6069b          	addiw	a3,a2,-1
 3b2:	1682                	slli	a3,a3,0x20
 3b4:	9281                	srli	a3,a3,0x20
 3b6:	0685                	addi	a3,a3,1
 3b8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3ba:	00054783          	lbu	a5,0(a0)
 3be:	0005c703          	lbu	a4,0(a1)
 3c2:	00e79863          	bne	a5,a4,3d2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3c6:	0505                	addi	a0,a0,1
    p2++;
 3c8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3ca:	fed518e3          	bne	a0,a3,3ba <memcmp+0x14>
  }
  return 0;
 3ce:	4501                	li	a0,0
 3d0:	a019                	j	3d6 <memcmp+0x30>
      return *p1 - *p2;
 3d2:	40e7853b          	subw	a0,a5,a4
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret
  return 0;
 3dc:	4501                	li	a0,0
 3de:	bfe5                	j	3d6 <memcmp+0x30>

00000000000003e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3e0:	1141                	addi	sp,sp,-16
 3e2:	e406                	sd	ra,8(sp)
 3e4:	e022                	sd	s0,0(sp)
 3e6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3e8:	00000097          	auipc	ra,0x0
 3ec:	f66080e7          	jalr	-154(ra) # 34e <memmove>
}
 3f0:	60a2                	ld	ra,8(sp)
 3f2:	6402                	ld	s0,0(sp)
 3f4:	0141                	addi	sp,sp,16
 3f6:	8082                	ret

00000000000003f8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 3f8:	4885                	li	a7,1
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <exit>:
.global exit
exit:
 li a7, SYS_exit
 400:	4889                	li	a7,2
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <wait>:
.global wait
wait:
 li a7, SYS_wait
 408:	488d                	li	a7,3
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 410:	4891                	li	a7,4
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <read>:
.global read
read:
 li a7, SYS_read
 418:	4895                	li	a7,5
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <write>:
.global write
write:
 li a7, SYS_write
 420:	48c1                	li	a7,16
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <close>:
.global close
close:
 li a7, SYS_close
 428:	48d5                	li	a7,21
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <kill>:
.global kill
kill:
 li a7, SYS_kill
 430:	4899                	li	a7,6
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <exec>:
.global exec
exec:
 li a7, SYS_exec
 438:	489d                	li	a7,7
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <open>:
.global open
open:
 li a7, SYS_open
 440:	48bd                	li	a7,15
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 448:	48a1                	li	a7,8
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 450:	48d1                	li	a7,20
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 458:	48a5                	li	a7,9
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <dup>:
.global dup
dup:
 li a7, SYS_dup
 460:	48a9                	li	a7,10
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 468:	48ad                	li	a7,11
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 470:	48b1                	li	a7,12
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 478:	48b5                	li	a7,13
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 480:	48b9                	li	a7,14
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 488:	48d9                	li	a7,22
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <dev>:
.global dev
dev:
 li a7, SYS_dev
 490:	48dd                	li	a7,23
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 498:	48e1                	li	a7,24
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4a0:	48e5                	li	a7,25
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <remove>:
.global remove
remove:
 li a7, SYS_remove
 4a8:	48c5                	li	a7,17
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 4b0:	48c9                	li	a7,18
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 4b8:	48cd                	li	a7,19
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <rename>:
.global rename
rename:
 li a7, SYS_rename
 4c0:	48e9                	li	a7,26
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 4c8:	48ed                	li	a7,27
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 4d0:	48f1                	li	a7,28
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 4d8:	48f5                	li	a7,29
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 4e0:	48f9                	li	a7,30
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 4e8:	48fd                	li	a7,31
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 4f0:	02000893          	li	a7,32
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 4fa:	02100893          	li	a7,33
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 504:	02200893          	li	a7,34
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 50e:	02300893          	li	a7,35
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 518:	02400893          	li	a7,36
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 522:	02500893          	li	a7,37
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 52c:	02600893          	li	a7,38
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 536:	02700893          	li	a7,39
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 540:	02800893          	li	a7,40
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 54a:	02900893          	li	a7,41
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 554:	02a00893          	li	a7,42
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 55e:	02b00893          	li	a7,43
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 568:	02c00893          	li	a7,44
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 572:	02d00893          	li	a7,45
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 57c:	02e00893          	li	a7,46
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 586:	02f00893          	li	a7,47
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 590:	03000893          	li	a7,48
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 59a:	03100893          	li	a7,49
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 5a4:	03200893          	li	a7,50
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 5ae:	03300893          	li	a7,51
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 5b8:	03400893          	li	a7,52
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 5c2:	03500893          	li	a7,53
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 5cc:	03600893          	li	a7,54
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 5d6:	03700893          	li	a7,55
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 5e0:	03800893          	li	a7,56
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 5ea:	03900893          	li	a7,57
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 5f4:	03a00893          	li	a7,58
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <poll>:
.global poll
poll:
 li a7, SYS_poll
 5fe:	03b00893          	li	a7,59
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 608:	03c00893          	li	a7,60
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 612:	03d00893          	li	a7,61
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 61c:	03e00893          	li	a7,62
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <clone>:
.global clone
clone:
 li a7, SYS_clone
 626:	03f00893          	li	a7,63
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <futex>:
.global futex
futex:
 li a7, SYS_futex
 630:	04000893          	li	a7,64
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 63a:	04100893          	li	a7,65
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <halt>:
.global halt
halt:
 li a7, SYS_halt
 644:	04200893          	li	a7,66
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 64e:	04300893          	li	a7,67
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <socket>:
.global socket
socket:
 li a7, SYS_socket
 658:	04400893          	li	a7,68
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <bind>:
.global bind
bind:
 li a7, SYS_bind
 662:	04500893          	li	a7,69
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <listen>:
.global listen
listen:
 li a7, SYS_listen
 66c:	04600893          	li	a7,70
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <accept>:
.global accept
accept:
 li a7, SYS_accept
 676:	04700893          	li	a7,71
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <connect>:
.global connect
connect:
 li a7, SYS_connect
 680:	04800893          	li	a7,72
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <send>:
.global send
send:
 li a7, SYS_send
 68a:	04900893          	li	a7,73
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <recv>:
.global recv
recv:
 li a7, SYS_recv
 694:	04a00893          	li	a7,74
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 69e:	04b00893          	li	a7,75
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6a8:	1101                	addi	sp,sp,-32
 6aa:	ec06                	sd	ra,24(sp)
 6ac:	e822                	sd	s0,16(sp)
 6ae:	1000                	addi	s0,sp,32
 6b0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6b4:	4605                	li	a2,1
 6b6:	fef40593          	addi	a1,s0,-17
 6ba:	00000097          	auipc	ra,0x0
 6be:	d66080e7          	jalr	-666(ra) # 420 <write>
}
 6c2:	60e2                	ld	ra,24(sp)
 6c4:	6442                	ld	s0,16(sp)
 6c6:	6105                	addi	sp,sp,32
 6c8:	8082                	ret

00000000000006ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6ca:	7139                	addi	sp,sp,-64
 6cc:	fc06                	sd	ra,56(sp)
 6ce:	f822                	sd	s0,48(sp)
 6d0:	f426                	sd	s1,40(sp)
 6d2:	f04a                	sd	s2,32(sp)
 6d4:	ec4e                	sd	s3,24(sp)
 6d6:	0080                	addi	s0,sp,64
 6d8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6da:	c299                	beqz	a3,6e0 <printint+0x16>
 6dc:	0805c863          	bltz	a1,76c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6e0:	2581                	sext.w	a1,a1
  neg = 0;
 6e2:	4881                	li	a7,0
  }

  i = 0;
 6e4:	fc040993          	addi	s3,s0,-64
  neg = 0;
 6e8:	86ce                	mv	a3,s3
  i = 0;
 6ea:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6ec:	2601                	sext.w	a2,a2
 6ee:	00000517          	auipc	a0,0x0
 6f2:	53a50513          	addi	a0,a0,1338 # c28 <digits>
 6f6:	883a                	mv	a6,a4
 6f8:	2705                	addiw	a4,a4,1
 6fa:	02c5f7bb          	remuw	a5,a1,a2
 6fe:	1782                	slli	a5,a5,0x20
 700:	9381                	srli	a5,a5,0x20
 702:	97aa                	add	a5,a5,a0
 704:	0007c783          	lbu	a5,0(a5)
 708:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 70c:	0005879b          	sext.w	a5,a1
 710:	02c5d5bb          	divuw	a1,a1,a2
 714:	0685                	addi	a3,a3,1
 716:	fec7f0e3          	bgeu	a5,a2,6f6 <printint+0x2c>
  if(neg)
 71a:	00088c63          	beqz	a7,732 <printint+0x68>
    buf[i++] = '-';
 71e:	fd070793          	addi	a5,a4,-48
 722:	00878733          	add	a4,a5,s0
 726:	02d00793          	li	a5,45
 72a:	fef70823          	sb	a5,-16(a4)
 72e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 732:	02e05663          	blez	a4,75e <printint+0x94>
 736:	fc040913          	addi	s2,s0,-64
 73a:	993a                	add	s2,s2,a4
 73c:	19fd                	addi	s3,s3,-1
 73e:	99ba                	add	s3,s3,a4
 740:	377d                	addiw	a4,a4,-1
 742:	1702                	slli	a4,a4,0x20
 744:	9301                	srli	a4,a4,0x20
 746:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 74a:	fff94583          	lbu	a1,-1(s2)
 74e:	8526                	mv	a0,s1
 750:	00000097          	auipc	ra,0x0
 754:	f58080e7          	jalr	-168(ra) # 6a8 <putc>
  while(--i >= 0)
 758:	197d                	addi	s2,s2,-1
 75a:	ff3918e3          	bne	s2,s3,74a <printint+0x80>
}
 75e:	70e2                	ld	ra,56(sp)
 760:	7442                	ld	s0,48(sp)
 762:	74a2                	ld	s1,40(sp)
 764:	7902                	ld	s2,32(sp)
 766:	69e2                	ld	s3,24(sp)
 768:	6121                	addi	sp,sp,64
 76a:	8082                	ret
    x = -xx;
 76c:	40b005bb          	negw	a1,a1
    neg = 1;
 770:	4885                	li	a7,1
    x = -xx;
 772:	bf8d                	j	6e4 <printint+0x1a>

0000000000000774 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 774:	7119                	addi	sp,sp,-128
 776:	fc86                	sd	ra,120(sp)
 778:	f8a2                	sd	s0,112(sp)
 77a:	f4a6                	sd	s1,104(sp)
 77c:	f0ca                	sd	s2,96(sp)
 77e:	ecce                	sd	s3,88(sp)
 780:	e8d2                	sd	s4,80(sp)
 782:	e4d6                	sd	s5,72(sp)
 784:	e0da                	sd	s6,64(sp)
 786:	fc5e                	sd	s7,56(sp)
 788:	f862                	sd	s8,48(sp)
 78a:	f466                	sd	s9,40(sp)
 78c:	f06a                	sd	s10,32(sp)
 78e:	ec6e                	sd	s11,24(sp)
 790:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 792:	0005c903          	lbu	s2,0(a1)
 796:	18090f63          	beqz	s2,934 <vprintf+0x1c0>
 79a:	8aaa                	mv	s5,a0
 79c:	8b32                	mv	s6,a2
 79e:	00158493          	addi	s1,a1,1
  state = 0;
 7a2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7a4:	02500a13          	li	s4,37
 7a8:	4c55                	li	s8,21
 7aa:	00000c97          	auipc	s9,0x0
 7ae:	426c8c93          	addi	s9,s9,1062 # bd0 <malloc+0x198>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7b2:	02800d93          	li	s11,40
  putc(fd, 'x');
 7b6:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b8:	00000b97          	auipc	s7,0x0
 7bc:	470b8b93          	addi	s7,s7,1136 # c28 <digits>
 7c0:	a839                	j	7de <vprintf+0x6a>
        putc(fd, c);
 7c2:	85ca                	mv	a1,s2
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	ee2080e7          	jalr	-286(ra) # 6a8 <putc>
 7ce:	a019                	j	7d4 <vprintf+0x60>
    } else if(state == '%'){
 7d0:	01498d63          	beq	s3,s4,7ea <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 7d4:	0485                	addi	s1,s1,1
 7d6:	fff4c903          	lbu	s2,-1(s1)
 7da:	14090d63          	beqz	s2,934 <vprintf+0x1c0>
    if(state == 0){
 7de:	fe0999e3          	bnez	s3,7d0 <vprintf+0x5c>
      if(c == '%'){
 7e2:	ff4910e3          	bne	s2,s4,7c2 <vprintf+0x4e>
        state = '%';
 7e6:	89d2                	mv	s3,s4
 7e8:	b7f5                	j	7d4 <vprintf+0x60>
      if(c == 'd'){
 7ea:	11490c63          	beq	s2,s4,902 <vprintf+0x18e>
 7ee:	f9d9079b          	addiw	a5,s2,-99
 7f2:	0ff7f793          	zext.b	a5,a5
 7f6:	10fc6e63          	bltu	s8,a5,912 <vprintf+0x19e>
 7fa:	f9d9079b          	addiw	a5,s2,-99
 7fe:	0ff7f713          	zext.b	a4,a5
 802:	10ec6863          	bltu	s8,a4,912 <vprintf+0x19e>
 806:	00271793          	slli	a5,a4,0x2
 80a:	97e6                	add	a5,a5,s9
 80c:	439c                	lw	a5,0(a5)
 80e:	97e6                	add	a5,a5,s9
 810:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 812:	008b0913          	addi	s2,s6,8
 816:	4685                	li	a3,1
 818:	4629                	li	a2,10
 81a:	000b2583          	lw	a1,0(s6)
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	eaa080e7          	jalr	-342(ra) # 6ca <printint>
 828:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b765                	j	7d4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 82e:	008b0913          	addi	s2,s6,8
 832:	4681                	li	a3,0
 834:	4629                	li	a2,10
 836:	000b2583          	lw	a1,0(s6)
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	e8e080e7          	jalr	-370(ra) # 6ca <printint>
 844:	8b4a                	mv	s6,s2
      state = 0;
 846:	4981                	li	s3,0
 848:	b771                	j	7d4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 84a:	008b0913          	addi	s2,s6,8
 84e:	4681                	li	a3,0
 850:	866a                	mv	a2,s10
 852:	000b2583          	lw	a1,0(s6)
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e72080e7          	jalr	-398(ra) # 6ca <printint>
 860:	8b4a                	mv	s6,s2
      state = 0;
 862:	4981                	li	s3,0
 864:	bf85                	j	7d4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 866:	008b0793          	addi	a5,s6,8
 86a:	f8f43423          	sd	a5,-120(s0)
 86e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 872:	03000593          	li	a1,48
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	e30080e7          	jalr	-464(ra) # 6a8 <putc>
  putc(fd, 'x');
 880:	07800593          	li	a1,120
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	e22080e7          	jalr	-478(ra) # 6a8 <putc>
 88e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 890:	03c9d793          	srli	a5,s3,0x3c
 894:	97de                	add	a5,a5,s7
 896:	0007c583          	lbu	a1,0(a5)
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	e0c080e7          	jalr	-500(ra) # 6a8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8a4:	0992                	slli	s3,s3,0x4
 8a6:	397d                	addiw	s2,s2,-1
 8a8:	fe0914e3          	bnez	s2,890 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 8ac:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b70d                	j	7d4 <vprintf+0x60>
        s = va_arg(ap, char*);
 8b4:	008b0913          	addi	s2,s6,8
 8b8:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 8bc:	02098163          	beqz	s3,8de <vprintf+0x16a>
        while(*s != 0){
 8c0:	0009c583          	lbu	a1,0(s3)
 8c4:	c5ad                	beqz	a1,92e <vprintf+0x1ba>
          putc(fd, *s);
 8c6:	8556                	mv	a0,s5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	de0080e7          	jalr	-544(ra) # 6a8 <putc>
          s++;
 8d0:	0985                	addi	s3,s3,1
        while(*s != 0){
 8d2:	0009c583          	lbu	a1,0(s3)
 8d6:	f9e5                	bnez	a1,8c6 <vprintf+0x152>
        s = va_arg(ap, char*);
 8d8:	8b4a                	mv	s6,s2
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	bde5                	j	7d4 <vprintf+0x60>
          s = "(null)";
 8de:	00000997          	auipc	s3,0x0
 8e2:	2ea98993          	addi	s3,s3,746 # bc8 <malloc+0x190>
        while(*s != 0){
 8e6:	85ee                	mv	a1,s11
 8e8:	bff9                	j	8c6 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 8ea:	008b0913          	addi	s2,s6,8
 8ee:	000b4583          	lbu	a1,0(s6)
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	db4080e7          	jalr	-588(ra) # 6a8 <putc>
 8fc:	8b4a                	mv	s6,s2
      state = 0;
 8fe:	4981                	li	s3,0
 900:	bdd1                	j	7d4 <vprintf+0x60>
        putc(fd, c);
 902:	85d2                	mv	a1,s4
 904:	8556                	mv	a0,s5
 906:	00000097          	auipc	ra,0x0
 90a:	da2080e7          	jalr	-606(ra) # 6a8 <putc>
      state = 0;
 90e:	4981                	li	s3,0
 910:	b5d1                	j	7d4 <vprintf+0x60>
        putc(fd, '%');
 912:	85d2                	mv	a1,s4
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	d92080e7          	jalr	-622(ra) # 6a8 <putc>
        putc(fd, c);
 91e:	85ca                	mv	a1,s2
 920:	8556                	mv	a0,s5
 922:	00000097          	auipc	ra,0x0
 926:	d86080e7          	jalr	-634(ra) # 6a8 <putc>
      state = 0;
 92a:	4981                	li	s3,0
 92c:	b565                	j	7d4 <vprintf+0x60>
        s = va_arg(ap, char*);
 92e:	8b4a                	mv	s6,s2
      state = 0;
 930:	4981                	li	s3,0
 932:	b54d                	j	7d4 <vprintf+0x60>
    }
  }
}
 934:	70e6                	ld	ra,120(sp)
 936:	7446                	ld	s0,112(sp)
 938:	74a6                	ld	s1,104(sp)
 93a:	7906                	ld	s2,96(sp)
 93c:	69e6                	ld	s3,88(sp)
 93e:	6a46                	ld	s4,80(sp)
 940:	6aa6                	ld	s5,72(sp)
 942:	6b06                	ld	s6,64(sp)
 944:	7be2                	ld	s7,56(sp)
 946:	7c42                	ld	s8,48(sp)
 948:	7ca2                	ld	s9,40(sp)
 94a:	7d02                	ld	s10,32(sp)
 94c:	6de2                	ld	s11,24(sp)
 94e:	6109                	addi	sp,sp,128
 950:	8082                	ret

0000000000000952 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 952:	715d                	addi	sp,sp,-80
 954:	ec06                	sd	ra,24(sp)
 956:	e822                	sd	s0,16(sp)
 958:	1000                	addi	s0,sp,32
 95a:	e010                	sd	a2,0(s0)
 95c:	e414                	sd	a3,8(s0)
 95e:	e818                	sd	a4,16(s0)
 960:	ec1c                	sd	a5,24(s0)
 962:	03043023          	sd	a6,32(s0)
 966:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 96a:	8622                	mv	a2,s0
 96c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 970:	00000097          	auipc	ra,0x0
 974:	e04080e7          	jalr	-508(ra) # 774 <vprintf>
}
 978:	60e2                	ld	ra,24(sp)
 97a:	6442                	ld	s0,16(sp)
 97c:	6161                	addi	sp,sp,80
 97e:	8082                	ret

0000000000000980 <printf>:

void
printf(const char *fmt, ...)
{
 980:	711d                	addi	sp,sp,-96
 982:	ec06                	sd	ra,24(sp)
 984:	e822                	sd	s0,16(sp)
 986:	1000                	addi	s0,sp,32
 988:	e40c                	sd	a1,8(s0)
 98a:	e810                	sd	a2,16(s0)
 98c:	ec14                	sd	a3,24(s0)
 98e:	f018                	sd	a4,32(s0)
 990:	f41c                	sd	a5,40(s0)
 992:	03043823          	sd	a6,48(s0)
 996:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 99a:	00840613          	addi	a2,s0,8
 99e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9a2:	85aa                	mv	a1,a0
 9a4:	4505                	li	a0,1
 9a6:	00000097          	auipc	ra,0x0
 9aa:	dce080e7          	jalr	-562(ra) # 774 <vprintf>
}
 9ae:	60e2                	ld	ra,24(sp)
 9b0:	6442                	ld	s0,16(sp)
 9b2:	6125                	addi	sp,sp,96
 9b4:	8082                	ret

00000000000009b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9b6:	1141                	addi	sp,sp,-16
 9b8:	e422                	sd	s0,8(sp)
 9ba:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9bc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c0:	00000797          	auipc	a5,0x0
 9c4:	2807b783          	ld	a5,640(a5) # c40 <freep>
 9c8:	a02d                	j	9f2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9ca:	4618                	lw	a4,8(a2)
 9cc:	9f2d                	addw	a4,a4,a1
 9ce:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d2:	6398                	ld	a4,0(a5)
 9d4:	6310                	ld	a2,0(a4)
 9d6:	a83d                	j	a14 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9d8:	ff852703          	lw	a4,-8(a0)
 9dc:	9f31                	addw	a4,a4,a2
 9de:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9e0:	ff053683          	ld	a3,-16(a0)
 9e4:	a091                	j	a28 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e6:	6398                	ld	a4,0(a5)
 9e8:	00e7e463          	bltu	a5,a4,9f0 <free+0x3a>
 9ec:	00e6ea63          	bltu	a3,a4,a00 <free+0x4a>
{
 9f0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f2:	fed7fae3          	bgeu	a5,a3,9e6 <free+0x30>
 9f6:	6398                	ld	a4,0(a5)
 9f8:	00e6e463          	bltu	a3,a4,a00 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9fc:	fee7eae3          	bltu	a5,a4,9f0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a00:	ff852583          	lw	a1,-8(a0)
 a04:	6390                	ld	a2,0(a5)
 a06:	02059813          	slli	a6,a1,0x20
 a0a:	01c85713          	srli	a4,a6,0x1c
 a0e:	9736                	add	a4,a4,a3
 a10:	fae60de3          	beq	a2,a4,9ca <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a14:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a18:	4790                	lw	a2,8(a5)
 a1a:	02061593          	slli	a1,a2,0x20
 a1e:	01c5d713          	srli	a4,a1,0x1c
 a22:	973e                	add	a4,a4,a5
 a24:	fae68ae3          	beq	a3,a4,9d8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a28:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a2a:	00000717          	auipc	a4,0x0
 a2e:	20f73b23          	sd	a5,534(a4) # c40 <freep>
}
 a32:	6422                	ld	s0,8(sp)
 a34:	0141                	addi	sp,sp,16
 a36:	8082                	ret

0000000000000a38 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a38:	7139                	addi	sp,sp,-64
 a3a:	fc06                	sd	ra,56(sp)
 a3c:	f822                	sd	s0,48(sp)
 a3e:	f426                	sd	s1,40(sp)
 a40:	f04a                	sd	s2,32(sp)
 a42:	ec4e                	sd	s3,24(sp)
 a44:	e852                	sd	s4,16(sp)
 a46:	e456                	sd	s5,8(sp)
 a48:	e05a                	sd	s6,0(sp)
 a4a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a4c:	02051493          	slli	s1,a0,0x20
 a50:	9081                	srli	s1,s1,0x20
 a52:	04bd                	addi	s1,s1,15
 a54:	8091                	srli	s1,s1,0x4
 a56:	00148a1b          	addiw	s4,s1,1
 a5a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a5c:	00000517          	auipc	a0,0x0
 a60:	1e453503          	ld	a0,484(a0) # c40 <freep>
 a64:	c515                	beqz	a0,a90 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a66:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a68:	4798                	lw	a4,8(a5)
 a6a:	04977163          	bgeu	a4,s1,aac <malloc+0x74>
 a6e:	89d2                	mv	s3,s4
 a70:	000a071b          	sext.w	a4,s4
 a74:	6685                	lui	a3,0x1
 a76:	00d77363          	bgeu	a4,a3,a7c <malloc+0x44>
 a7a:	6985                	lui	s3,0x1
 a7c:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 a80:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a84:	00000917          	auipc	s2,0x0
 a88:	1bc90913          	addi	s2,s2,444 # c40 <freep>
  if(p == (char*)-1)
 a8c:	5afd                	li	s5,-1
 a8e:	a8a5                	j	b06 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 a90:	00000797          	auipc	a5,0x0
 a94:	1b078793          	addi	a5,a5,432 # c40 <freep>
 a98:	00000717          	auipc	a4,0x0
 a9c:	1b070713          	addi	a4,a4,432 # c48 <base>
 aa0:	e398                	sd	a4,0(a5)
 aa2:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 aa4:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa8:	87ba                	mv	a5,a4
 aaa:	b7d1                	j	a6e <malloc+0x36>
      if(p->s.size == nunits)
 aac:	02e48c63          	beq	s1,a4,ae4 <malloc+0xac>
        p->s.size -= nunits;
 ab0:	4147073b          	subw	a4,a4,s4
 ab4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ab6:	02071693          	slli	a3,a4,0x20
 aba:	01c6d713          	srli	a4,a3,0x1c
 abe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ac0:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 ac4:	00000717          	auipc	a4,0x0
 ac8:	16a73e23          	sd	a0,380(a4) # c40 <freep>
      return (void*)(p + 1);
 acc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ad0:	70e2                	ld	ra,56(sp)
 ad2:	7442                	ld	s0,48(sp)
 ad4:	74a2                	ld	s1,40(sp)
 ad6:	7902                	ld	s2,32(sp)
 ad8:	69e2                	ld	s3,24(sp)
 ada:	6a42                	ld	s4,16(sp)
 adc:	6aa2                	ld	s5,8(sp)
 ade:	6b02                	ld	s6,0(sp)
 ae0:	6121                	addi	sp,sp,64
 ae2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ae4:	6398                	ld	a4,0(a5)
 ae6:	e118                	sd	a4,0(a0)
 ae8:	bff1                	j	ac4 <malloc+0x8c>
  hp->s.size = nu;
 aea:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aee:	0541                	addi	a0,a0,16
 af0:	00000097          	auipc	ra,0x0
 af4:	ec6080e7          	jalr	-314(ra) # 9b6 <free>
  return freep;
 af8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 afc:	d971                	beqz	a0,ad0 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 afe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b00:	4798                	lw	a4,8(a5)
 b02:	fa9775e3          	bgeu	a4,s1,aac <malloc+0x74>
    if(p == freep)
 b06:	00093703          	ld	a4,0(s2)
 b0a:	853e                	mv	a0,a5
 b0c:	fef719e3          	bne	a4,a5,afe <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 b10:	854e                	mv	a0,s3
 b12:	00000097          	auipc	ra,0x0
 b16:	95e080e7          	jalr	-1698(ra) # 470 <sbrk>
  if(p == (char*)-1)
 b1a:	fd5518e3          	bne	a0,s5,aea <malloc+0xb2>
        return 0;
 b1e:	4501                	li	a0,0
 b20:	bf45                	j	ad0 <malloc+0x98>
