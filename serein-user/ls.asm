
serein-user/_ls：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/include/stat.h"
#include "serein-user/user.h"

char*
fmtname(char *name)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	892a                	mv	s2,a0
  static char buf[STAT_MAX_NAME+1];
  int len = strlen(name);
  10:	00000097          	auipc	ra,0x0
  14:	24c080e7          	jalr	588(ra) # 25c <strlen>
  18:	0005049b          	sext.w	s1,a0

  // Return blank-padded name.
  if(len >= STAT_MAX_NAME)
  1c:	47fd                	li	a5,31
  1e:	0097da63          	bge	a5,s1,32 <fmtname+0x32>
    return name;
  memmove(buf, name, len);
  memset(buf + len, ' ', STAT_MAX_NAME - len);
  buf[STAT_MAX_NAME] = '\0';
  return buf;
}
  22:	854a                	mv	a0,s2
  24:	70a2                	ld	ra,40(sp)
  26:	7402                	ld	s0,32(sp)
  28:	64e2                	ld	s1,24(sp)
  2a:	6942                	ld	s2,16(sp)
  2c:	69a2                	ld	s3,8(sp)
  2e:	6145                	addi	sp,sp,48
  30:	8082                	ret
  memmove(buf, name, len);
  32:	00001997          	auipc	s3,0x1
  36:	c6e98993          	addi	s3,s3,-914 # ca0 <buf.0>
  3a:	8626                	mv	a2,s1
  3c:	85ca                	mv	a1,s2
  3e:	854e                	mv	a0,s3
  40:	00000097          	auipc	ra,0x0
  44:	3ac080e7          	jalr	940(ra) # 3ec <memmove>
  memset(buf + len, ' ', STAT_MAX_NAME - len);
  48:	02000613          	li	a2,32
  4c:	9e05                	subw	a2,a2,s1
  4e:	02000593          	li	a1,32
  52:	00998533          	add	a0,s3,s1
  56:	00000097          	auipc	ra,0x0
  5a:	230080e7          	jalr	560(ra) # 286 <memset>
  buf[STAT_MAX_NAME] = '\0';
  5e:	02098023          	sb	zero,32(s3)
  return buf;
  62:	894e                	mv	s2,s3
  64:	bf7d                	j	22 <fmtname+0x22>

0000000000000066 <ls>:

void
ls(char *path)
{
  66:	7175                	addi	sp,sp,-144
  68:	e506                	sd	ra,136(sp)
  6a:	e122                	sd	s0,128(sp)
  6c:	fca6                	sd	s1,120(sp)
  6e:	f8ca                	sd	s2,112(sp)
  70:	f4ce                	sd	s3,104(sp)
  72:	f0d2                	sd	s4,96(sp)
  74:	0900                	addi	s0,sp,144
  76:	892a                	mv	s2,a0
  int fd;
  struct stat st;
  char *types[] = {
  78:	f6043c23          	sd	zero,-136(s0)
  7c:	00001797          	auipc	a5,0x1
  80:	b4478793          	addi	a5,a5,-1212 # bc0 <malloc+0xea>
  84:	f8f43023          	sd	a5,-128(s0)
  88:	00001797          	auipc	a5,0x1
  8c:	b4078793          	addi	a5,a5,-1216 # bc8 <malloc+0xf2>
  90:	f8f43423          	sd	a5,-120(s0)
    [T_DIR]   "DIR ",
    [T_FILE]  "FILE",
  };

  if((fd = open(path, 0)) < 0){
  94:	4581                	li	a1,0
  96:	00000097          	auipc	ra,0x0
  9a:	448080e7          	jalr	1096(ra) # 4de <open>
  9e:	02054863          	bltz	a0,ce <ls+0x68>
  a2:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  a4:	f9040593          	addi	a1,s0,-112
  a8:	00000097          	auipc	ra,0x0
  ac:	43e080e7          	jalr	1086(ra) # 4e6 <fstat>
  b0:	02054a63          	bltz	a0,e4 <ls+0x7e>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  if (st.type == T_DIR){
  b4:	fb841703          	lh	a4,-72(s0)
  b8:	4785                	li	a5,1
  ba:	08f71f63          	bne	a4,a5,158 <ls+0xf2>
    while(readdir(fd, &st) == 1){
  be:	f9040913          	addi	s2,s0,-112
  c2:	4985                	li	s3,1
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
  c4:	00001a17          	auipc	s4,0x1
  c8:	b3ca0a13          	addi	s4,s4,-1220 # c00 <malloc+0x12a>
  cc:	a08d                	j	12e <ls+0xc8>
    fprintf(2, "ls: cannot open %s\n", path);
  ce:	864a                	mv	a2,s2
  d0:	00001597          	auipc	a1,0x1
  d4:	b0058593          	addi	a1,a1,-1280 # bd0 <malloc+0xfa>
  d8:	4509                	li	a0,2
  da:	00001097          	auipc	ra,0x1
  de:	916080e7          	jalr	-1770(ra) # 9f0 <fprintf>
    return;
  e2:	a09d                	j	148 <ls+0xe2>
    fprintf(2, "ls: cannot stat %s\n", path);
  e4:	864a                	mv	a2,s2
  e6:	00001597          	auipc	a1,0x1
  ea:	b0258593          	addi	a1,a1,-1278 # be8 <malloc+0x112>
  ee:	4509                	li	a0,2
  f0:	00001097          	auipc	ra,0x1
  f4:	900080e7          	jalr	-1792(ra) # 9f0 <fprintf>
    close(fd);
  f8:	8526                	mv	a0,s1
  fa:	00000097          	auipc	ra,0x0
  fe:	3cc080e7          	jalr	972(ra) # 4c6 <close>
    return;
 102:	a099                	j	148 <ls+0xe2>
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
 104:	854a                	mv	a0,s2
 106:	00000097          	auipc	ra,0x0
 10a:	efa080e7          	jalr	-262(ra) # 0 <fmtname>
 10e:	85aa                	mv	a1,a0
 110:	fb841783          	lh	a5,-72(s0)
 114:	078e                	slli	a5,a5,0x3
 116:	fd078793          	addi	a5,a5,-48
 11a:	97a2                	add	a5,a5,s0
 11c:	fc043683          	ld	a3,-64(s0)
 120:	fa87b603          	ld	a2,-88(a5)
 124:	8552                	mv	a0,s4
 126:	00001097          	auipc	ra,0x1
 12a:	8f8080e7          	jalr	-1800(ra) # a1e <printf>
    while(readdir(fd, &st) == 1){
 12e:	85ca                	mv	a1,s2
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	404080e7          	jalr	1028(ra) # 536 <readdir>
 13a:	fd3505e3          	beq	a0,s3,104 <ls+0x9e>
    }
  } else {
    printf("%s %s\t%l\n", fmtname(st.name), types[st.type], st.size);
  }
  close(fd);
 13e:	8526                	mv	a0,s1
 140:	00000097          	auipc	ra,0x0
 144:	386080e7          	jalr	902(ra) # 4c6 <close>
}
 148:	60aa                	ld	ra,136(sp)
 14a:	640a                	ld	s0,128(sp)
 14c:	74e6                	ld	s1,120(sp)
 14e:	7946                	ld	s2,112(sp)
 150:	79a6                	ld	s3,104(sp)
 152:	7a06                	ld	s4,96(sp)
 154:	6149                	addi	sp,sp,144
 156:	8082                	ret
    printf("%s %s\t%l\n", fmtname(st.name), types[st.type], st.size);
 158:	f9040513          	addi	a0,s0,-112
 15c:	00000097          	auipc	ra,0x0
 160:	ea4080e7          	jalr	-348(ra) # 0 <fmtname>
 164:	85aa                	mv	a1,a0
 166:	fb841783          	lh	a5,-72(s0)
 16a:	078e                	slli	a5,a5,0x3
 16c:	fd078793          	addi	a5,a5,-48
 170:	97a2                	add	a5,a5,s0
 172:	fc043683          	ld	a3,-64(s0)
 176:	fa87b603          	ld	a2,-88(a5)
 17a:	00001517          	auipc	a0,0x1
 17e:	a9650513          	addi	a0,a0,-1386 # c10 <malloc+0x13a>
 182:	00001097          	auipc	ra,0x1
 186:	89c080e7          	jalr	-1892(ra) # a1e <printf>
 18a:	bf55                	j	13e <ls+0xd8>

000000000000018c <main>:

int
main(int argc, char *argv[])
{
 18c:	1101                	addi	sp,sp,-32
 18e:	ec06                	sd	ra,24(sp)
 190:	e822                	sd	s0,16(sp)
 192:	e426                	sd	s1,8(sp)
 194:	e04a                	sd	s2,0(sp)
 196:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 198:	4785                	li	a5,1
 19a:	02a7d963          	bge	a5,a0,1cc <main+0x40>
 19e:	00858493          	addi	s1,a1,8
 1a2:	ffe5091b          	addiw	s2,a0,-2
 1a6:	02091793          	slli	a5,s2,0x20
 1aa:	01d7d913          	srli	s2,a5,0x1d
 1ae:	05c1                	addi	a1,a1,16
 1b0:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 1b2:	6088                	ld	a0,0(s1)
 1b4:	00000097          	auipc	ra,0x0
 1b8:	eb2080e7          	jalr	-334(ra) # 66 <ls>
  for(i=1; i<argc; i++)
 1bc:	04a1                	addi	s1,s1,8
 1be:	ff249ae3          	bne	s1,s2,1b2 <main+0x26>
  exit(0);
 1c2:	4501                	li	a0,0
 1c4:	00000097          	auipc	ra,0x0
 1c8:	2da080e7          	jalr	730(ra) # 49e <exit>
    ls(".");
 1cc:	00001517          	auipc	a0,0x1
 1d0:	a5450513          	addi	a0,a0,-1452 # c20 <malloc+0x14a>
 1d4:	00000097          	auipc	ra,0x0
 1d8:	e92080e7          	jalr	-366(ra) # 66 <ls>
    exit(0);
 1dc:	4501                	li	a0,0
 1de:	00000097          	auipc	ra,0x0
 1e2:	2c0080e7          	jalr	704(ra) # 49e <exit>

00000000000001e6 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ec:	87aa                	mv	a5,a0
 1ee:	0585                	addi	a1,a1,1
 1f0:	0785                	addi	a5,a5,1
 1f2:	fff5c703          	lbu	a4,-1(a1)
 1f6:	fee78fa3          	sb	a4,-1(a5)
 1fa:	fb75                	bnez	a4,1ee <strcpy+0x8>
    ;
  return os;
}
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret

0000000000000202 <strcat>:

char*
strcat(char *s, const char *t)
{
 202:	1141                	addi	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 208:	00054783          	lbu	a5,0(a0)
 20c:	c385                	beqz	a5,22c <strcat+0x2a>
 20e:	87aa                	mv	a5,a0
    s++;
 210:	0785                	addi	a5,a5,1
  while(*s)
 212:	0007c703          	lbu	a4,0(a5)
 216:	ff6d                	bnez	a4,210 <strcat+0xe>
  while((*s++ = *t++))
 218:	0585                	addi	a1,a1,1
 21a:	0785                	addi	a5,a5,1
 21c:	fff5c703          	lbu	a4,-1(a1)
 220:	fee78fa3          	sb	a4,-1(a5)
 224:	fb75                	bnez	a4,218 <strcat+0x16>
    ;
  return os;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	addi	sp,sp,16
 22a:	8082                	ret
  while(*s)
 22c:	87aa                	mv	a5,a0
 22e:	b7ed                	j	218 <strcat+0x16>

0000000000000230 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 236:	00054783          	lbu	a5,0(a0)
 23a:	cb91                	beqz	a5,24e <strcmp+0x1e>
 23c:	0005c703          	lbu	a4,0(a1)
 240:	00f71763          	bne	a4,a5,24e <strcmp+0x1e>
    p++, q++;
 244:	0505                	addi	a0,a0,1
 246:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbe5                	bnez	a5,23c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24e:	0005c503          	lbu	a0,0(a1)
}
 252:	40a7853b          	subw	a0,a5,a0
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <strlen>:

uint
strlen(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 262:	00054783          	lbu	a5,0(a0)
 266:	cf91                	beqz	a5,282 <strlen+0x26>
 268:	0505                	addi	a0,a0,1
 26a:	87aa                	mv	a5,a0
 26c:	4685                	li	a3,1
 26e:	9e89                	subw	a3,a3,a0
 270:	00f6853b          	addw	a0,a3,a5
 274:	0785                	addi	a5,a5,1
 276:	fff7c703          	lbu	a4,-1(a5)
 27a:	fb7d                	bnez	a4,270 <strlen+0x14>
    ;
  return n;
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
  for(n = 0; s[n]; n++)
 282:	4501                	li	a0,0
 284:	bfe5                	j	27c <strlen+0x20>

0000000000000286 <memset>:

void*
memset(void *dst, int c, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28c:	ca19                	beqz	a2,2a2 <memset+0x1c>
 28e:	87aa                	mv	a5,a0
 290:	1602                	slli	a2,a2,0x20
 292:	9201                	srli	a2,a2,0x20
 294:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 298:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 29c:	0785                	addi	a5,a5,1
 29e:	fee79de3          	bne	a5,a4,298 <memset+0x12>
  }
  return dst;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <strchr>:

char*
strchr(const char *s, char c)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	cb99                	beqz	a5,2c8 <strchr+0x20>
    if(*s == c)
 2b4:	00f58763          	beq	a1,a5,2c2 <strchr+0x1a>
  for(; *s; s++)
 2b8:	0505                	addi	a0,a0,1
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	fbfd                	bnez	a5,2b4 <strchr+0xc>
      return (char*)s;
  return 0;
 2c0:	4501                	li	a0,0
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret
  return 0;
 2c8:	4501                	li	a0,0
 2ca:	bfe5                	j	2c2 <strchr+0x1a>

00000000000002cc <gets>:

char*
gets(char *buf, int max)
{
 2cc:	711d                	addi	sp,sp,-96
 2ce:	ec86                	sd	ra,88(sp)
 2d0:	e8a2                	sd	s0,80(sp)
 2d2:	e4a6                	sd	s1,72(sp)
 2d4:	e0ca                	sd	s2,64(sp)
 2d6:	fc4e                	sd	s3,56(sp)
 2d8:	f852                	sd	s4,48(sp)
 2da:	f456                	sd	s5,40(sp)
 2dc:	f05a                	sd	s6,32(sp)
 2de:	ec5e                	sd	s7,24(sp)
 2e0:	e862                	sd	s8,16(sp)
 2e2:	1080                	addi	s0,sp,96
 2e4:	8baa                	mv	s7,a0
 2e6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e8:	892a                	mv	s2,a0
 2ea:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2ec:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2f0:	4b29                	li	s6,10
 2f2:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2f4:	89a6                	mv	s3,s1
 2f6:	2485                	addiw	s1,s1,1
 2f8:	0344d763          	bge	s1,s4,326 <gets+0x5a>
    cc = read(0, &c, 1);
 2fc:	4605                	li	a2,1
 2fe:	85d6                	mv	a1,s5
 300:	4501                	li	a0,0
 302:	00000097          	auipc	ra,0x0
 306:	1b4080e7          	jalr	436(ra) # 4b6 <read>
    if(cc < 1)
 30a:	00a05e63          	blez	a0,326 <gets+0x5a>
    buf[i++] = c;
 30e:	faf44783          	lbu	a5,-81(s0)
 312:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 316:	01678763          	beq	a5,s6,324 <gets+0x58>
 31a:	0905                	addi	s2,s2,1
 31c:	fd879ce3          	bne	a5,s8,2f4 <gets+0x28>
  for(i=0; i+1 < max; ){
 320:	89a6                	mv	s3,s1
 322:	a011                	j	326 <gets+0x5a>
 324:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 326:	99de                	add	s3,s3,s7
 328:	00098023          	sb	zero,0(s3)
  return buf;
}
 32c:	855e                	mv	a0,s7
 32e:	60e6                	ld	ra,88(sp)
 330:	6446                	ld	s0,80(sp)
 332:	64a6                	ld	s1,72(sp)
 334:	6906                	ld	s2,64(sp)
 336:	79e2                	ld	s3,56(sp)
 338:	7a42                	ld	s4,48(sp)
 33a:	7aa2                	ld	s5,40(sp)
 33c:	7b02                	ld	s6,32(sp)
 33e:	6be2                	ld	s7,24(sp)
 340:	6c42                	ld	s8,16(sp)
 342:	6125                	addi	sp,sp,96
 344:	8082                	ret

0000000000000346 <stat>:

int
stat(const char *n, struct stat *st)
{
 346:	1101                	addi	sp,sp,-32
 348:	ec06                	sd	ra,24(sp)
 34a:	e822                	sd	s0,16(sp)
 34c:	e426                	sd	s1,8(sp)
 34e:	e04a                	sd	s2,0(sp)
 350:	1000                	addi	s0,sp,32
 352:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 354:	4581                	li	a1,0
 356:	00000097          	auipc	ra,0x0
 35a:	188080e7          	jalr	392(ra) # 4de <open>
  if(fd < 0)
 35e:	02054563          	bltz	a0,388 <stat+0x42>
 362:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 364:	85ca                	mv	a1,s2
 366:	00000097          	auipc	ra,0x0
 36a:	180080e7          	jalr	384(ra) # 4e6 <fstat>
 36e:	892a                	mv	s2,a0
  close(fd);
 370:	8526                	mv	a0,s1
 372:	00000097          	auipc	ra,0x0
 376:	154080e7          	jalr	340(ra) # 4c6 <close>
  return r;
}
 37a:	854a                	mv	a0,s2
 37c:	60e2                	ld	ra,24(sp)
 37e:	6442                	ld	s0,16(sp)
 380:	64a2                	ld	s1,8(sp)
 382:	6902                	ld	s2,0(sp)
 384:	6105                	addi	sp,sp,32
 386:	8082                	ret
    return -1;
 388:	597d                	li	s2,-1
 38a:	bfc5                	j	37a <stat+0x34>

000000000000038c <atoi>:

int
atoi(const char *s)
{
 38c:	1141                	addi	sp,sp,-16
 38e:	e422                	sd	s0,8(sp)
 390:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 392:	00054703          	lbu	a4,0(a0)
 396:	02d00793          	li	a5,45
  int neg = 1;
 39a:	4585                	li	a1,1
  if (*s == '-') {
 39c:	04f70363          	beq	a4,a5,3e2 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 3a0:	00054703          	lbu	a4,0(a0)
 3a4:	fd07079b          	addiw	a5,a4,-48
 3a8:	0ff7f793          	zext.b	a5,a5
 3ac:	46a5                	li	a3,9
 3ae:	02f6ed63          	bltu	a3,a5,3e8 <atoi+0x5c>
  n = 0;
 3b2:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 3b4:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 3b6:	0505                	addi	a0,a0,1
 3b8:	0026979b          	slliw	a5,a3,0x2
 3bc:	9fb5                	addw	a5,a5,a3
 3be:	0017979b          	slliw	a5,a5,0x1
 3c2:	9fb9                	addw	a5,a5,a4
 3c4:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 3c8:	00054703          	lbu	a4,0(a0)
 3cc:	fd07079b          	addiw	a5,a4,-48
 3d0:	0ff7f793          	zext.b	a5,a5
 3d4:	fef671e3          	bgeu	a2,a5,3b6 <atoi+0x2a>
  return n * neg;
}
 3d8:	02d5853b          	mulw	a0,a1,a3
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret
    s++;
 3e2:	0505                	addi	a0,a0,1
    neg = -1;
 3e4:	55fd                	li	a1,-1
 3e6:	bf6d                	j	3a0 <atoi+0x14>
  n = 0;
 3e8:	4681                	li	a3,0
 3ea:	b7fd                	j	3d8 <atoi+0x4c>

00000000000003ec <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e422                	sd	s0,8(sp)
 3f0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f2:	02b57463          	bgeu	a0,a1,41a <memmove+0x2e>
    while(n-- > 0)
 3f6:	00c05f63          	blez	a2,414 <memmove+0x28>
 3fa:	1602                	slli	a2,a2,0x20
 3fc:	9201                	srli	a2,a2,0x20
 3fe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 402:	872a                	mv	a4,a0
      *dst++ = *src++;
 404:	0585                	addi	a1,a1,1
 406:	0705                	addi	a4,a4,1
 408:	fff5c683          	lbu	a3,-1(a1)
 40c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 410:	fee79ae3          	bne	a5,a4,404 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret
    dst += n;
 41a:	00c50733          	add	a4,a0,a2
    src += n;
 41e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 420:	fec05ae3          	blez	a2,414 <memmove+0x28>
 424:	fff6079b          	addiw	a5,a2,-1
 428:	1782                	slli	a5,a5,0x20
 42a:	9381                	srli	a5,a5,0x20
 42c:	fff7c793          	not	a5,a5
 430:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 432:	15fd                	addi	a1,a1,-1
 434:	177d                	addi	a4,a4,-1
 436:	0005c683          	lbu	a3,0(a1)
 43a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 43e:	fee79ae3          	bne	a5,a4,432 <memmove+0x46>
 442:	bfc9                	j	414 <memmove+0x28>

0000000000000444 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 444:	1141                	addi	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 44a:	ca05                	beqz	a2,47a <memcmp+0x36>
 44c:	fff6069b          	addiw	a3,a2,-1
 450:	1682                	slli	a3,a3,0x20
 452:	9281                	srli	a3,a3,0x20
 454:	0685                	addi	a3,a3,1
 456:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 458:	00054783          	lbu	a5,0(a0)
 45c:	0005c703          	lbu	a4,0(a1)
 460:	00e79863          	bne	a5,a4,470 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 464:	0505                	addi	a0,a0,1
    p2++;
 466:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 468:	fed518e3          	bne	a0,a3,458 <memcmp+0x14>
  }
  return 0;
 46c:	4501                	li	a0,0
 46e:	a019                	j	474 <memcmp+0x30>
      return *p1 - *p2;
 470:	40e7853b          	subw	a0,a5,a4
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
  return 0;
 47a:	4501                	li	a0,0
 47c:	bfe5                	j	474 <memcmp+0x30>

000000000000047e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e406                	sd	ra,8(sp)
 482:	e022                	sd	s0,0(sp)
 484:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 486:	00000097          	auipc	ra,0x0
 48a:	f66080e7          	jalr	-154(ra) # 3ec <memmove>
}
 48e:	60a2                	ld	ra,8(sp)
 490:	6402                	ld	s0,0(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret

0000000000000496 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 496:	4885                	li	a7,1
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <exit>:
.global exit
exit:
 li a7, SYS_exit
 49e:	4889                	li	a7,2
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4a6:	488d                	li	a7,3
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ae:	4891                	li	a7,4
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <read>:
.global read
read:
 li a7, SYS_read
 4b6:	4895                	li	a7,5
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <write>:
.global write
write:
 li a7, SYS_write
 4be:	48c1                	li	a7,16
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <close>:
.global close
close:
 li a7, SYS_close
 4c6:	48d5                	li	a7,21
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ce:	4899                	li	a7,6
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4d6:	489d                	li	a7,7
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <open>:
.global open
open:
 li a7, SYS_open
 4de:	48bd                	li	a7,15
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4e6:	48a1                	li	a7,8
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ee:	48d1                	li	a7,20
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f6:	48a5                	li	a7,9
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <dup>:
.global dup
dup:
 li a7, SYS_dup
 4fe:	48a9                	li	a7,10
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 506:	48ad                	li	a7,11
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 50e:	48b1                	li	a7,12
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 516:	48b5                	li	a7,13
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 51e:	48b9                	li	a7,14
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 526:	48d9                	li	a7,22
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <dev>:
.global dev
dev:
 li a7, SYS_dev
 52e:	48dd                	li	a7,23
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 536:	48e1                	li	a7,24
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 53e:	48e5                	li	a7,25
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <remove>:
.global remove
remove:
 li a7, SYS_remove
 546:	48c5                	li	a7,17
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <trace>:
.global trace
trace:
 li a7, SYS_trace
 54e:	48c9                	li	a7,18
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 556:	48cd                	li	a7,19
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <rename>:
.global rename
rename:
 li a7, SYS_rename
 55e:	48e9                	li	a7,26
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 566:	48ed                	li	a7,27
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 56e:	48f1                	li	a7,28
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 576:	48f5                	li	a7,29
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 57e:	48f9                	li	a7,30
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 586:	48fd                	li	a7,31
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 58e:	02000893          	li	a7,32
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 598:	02100893          	li	a7,33
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 5a2:	02200893          	li	a7,34
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 5ac:	02300893          	li	a7,35
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 5b6:	02400893          	li	a7,36
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 5c0:	02500893          	li	a7,37
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 5ca:	02600893          	li	a7,38
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 5d4:	02700893          	li	a7,39
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 5de:	02800893          	li	a7,40
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 5e8:	02900893          	li	a7,41
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 5f2:	02a00893          	li	a7,42
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 5fc:	02b00893          	li	a7,43
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 606:	02c00893          	li	a7,44
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 610:	02d00893          	li	a7,45
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 61a:	02e00893          	li	a7,46
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 624:	02f00893          	li	a7,47
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 62e:	03000893          	li	a7,48
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 638:	03100893          	li	a7,49
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 642:	03200893          	li	a7,50
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 64c:	03300893          	li	a7,51
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 656:	03400893          	li	a7,52
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 660:	03500893          	li	a7,53
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 66a:	03600893          	li	a7,54
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 674:	03700893          	li	a7,55
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 67e:	03800893          	li	a7,56
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 688:	03900893          	li	a7,57
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 692:	03a00893          	li	a7,58
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <poll>:
.global poll
poll:
 li a7, SYS_poll
 69c:	03b00893          	li	a7,59
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 6a6:	03c00893          	li	a7,60
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 6b0:	03d00893          	li	a7,61
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 6ba:	03e00893          	li	a7,62
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <clone>:
.global clone
clone:
 li a7, SYS_clone
 6c4:	03f00893          	li	a7,63
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <futex>:
.global futex
futex:
 li a7, SYS_futex
 6ce:	04000893          	li	a7,64
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 6d8:	04100893          	li	a7,65
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <halt>:
.global halt
halt:
 li a7, SYS_halt
 6e2:	04200893          	li	a7,66
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 6ec:	04300893          	li	a7,67
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6f6:	04400893          	li	a7,68
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <bind>:
.global bind
bind:
 li a7, SYS_bind
 700:	04500893          	li	a7,69
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <listen>:
.global listen
listen:
 li a7, SYS_listen
 70a:	04600893          	li	a7,70
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <accept>:
.global accept
accept:
 li a7, SYS_accept
 714:	04700893          	li	a7,71
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <connect>:
.global connect
connect:
 li a7, SYS_connect
 71e:	04800893          	li	a7,72
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <send>:
.global send
send:
 li a7, SYS_send
 728:	04900893          	li	a7,73
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <recv>:
.global recv
recv:
 li a7, SYS_recv
 732:	04a00893          	li	a7,74
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 73c:	04b00893          	li	a7,75
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 746:	1101                	addi	sp,sp,-32
 748:	ec06                	sd	ra,24(sp)
 74a:	e822                	sd	s0,16(sp)
 74c:	1000                	addi	s0,sp,32
 74e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 752:	4605                	li	a2,1
 754:	fef40593          	addi	a1,s0,-17
 758:	00000097          	auipc	ra,0x0
 75c:	d66080e7          	jalr	-666(ra) # 4be <write>
}
 760:	60e2                	ld	ra,24(sp)
 762:	6442                	ld	s0,16(sp)
 764:	6105                	addi	sp,sp,32
 766:	8082                	ret

0000000000000768 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 768:	7139                	addi	sp,sp,-64
 76a:	fc06                	sd	ra,56(sp)
 76c:	f822                	sd	s0,48(sp)
 76e:	f426                	sd	s1,40(sp)
 770:	f04a                	sd	s2,32(sp)
 772:	ec4e                	sd	s3,24(sp)
 774:	0080                	addi	s0,sp,64
 776:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 778:	c299                	beqz	a3,77e <printint+0x16>
 77a:	0805c863          	bltz	a1,80a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 77e:	2581                	sext.w	a1,a1
  neg = 0;
 780:	4881                	li	a7,0
  }

  i = 0;
 782:	fc040993          	addi	s3,s0,-64
  neg = 0;
 786:	86ce                	mv	a3,s3
  i = 0;
 788:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 78a:	2601                	sext.w	a2,a2
 78c:	00000517          	auipc	a0,0x0
 790:	4fc50513          	addi	a0,a0,1276 # c88 <digits>
 794:	883a                	mv	a6,a4
 796:	2705                	addiw	a4,a4,1
 798:	02c5f7bb          	remuw	a5,a1,a2
 79c:	1782                	slli	a5,a5,0x20
 79e:	9381                	srli	a5,a5,0x20
 7a0:	97aa                	add	a5,a5,a0
 7a2:	0007c783          	lbu	a5,0(a5)
 7a6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7aa:	0005879b          	sext.w	a5,a1
 7ae:	02c5d5bb          	divuw	a1,a1,a2
 7b2:	0685                	addi	a3,a3,1
 7b4:	fec7f0e3          	bgeu	a5,a2,794 <printint+0x2c>
  if(neg)
 7b8:	00088c63          	beqz	a7,7d0 <printint+0x68>
    buf[i++] = '-';
 7bc:	fd070793          	addi	a5,a4,-48
 7c0:	00878733          	add	a4,a5,s0
 7c4:	02d00793          	li	a5,45
 7c8:	fef70823          	sb	a5,-16(a4)
 7cc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7d0:	02e05663          	blez	a4,7fc <printint+0x94>
 7d4:	fc040913          	addi	s2,s0,-64
 7d8:	993a                	add	s2,s2,a4
 7da:	19fd                	addi	s3,s3,-1
 7dc:	99ba                	add	s3,s3,a4
 7de:	377d                	addiw	a4,a4,-1
 7e0:	1702                	slli	a4,a4,0x20
 7e2:	9301                	srli	a4,a4,0x20
 7e4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7e8:	fff94583          	lbu	a1,-1(s2)
 7ec:	8526                	mv	a0,s1
 7ee:	00000097          	auipc	ra,0x0
 7f2:	f58080e7          	jalr	-168(ra) # 746 <putc>
  while(--i >= 0)
 7f6:	197d                	addi	s2,s2,-1
 7f8:	ff3918e3          	bne	s2,s3,7e8 <printint+0x80>
}
 7fc:	70e2                	ld	ra,56(sp)
 7fe:	7442                	ld	s0,48(sp)
 800:	74a2                	ld	s1,40(sp)
 802:	7902                	ld	s2,32(sp)
 804:	69e2                	ld	s3,24(sp)
 806:	6121                	addi	sp,sp,64
 808:	8082                	ret
    x = -xx;
 80a:	40b005bb          	negw	a1,a1
    neg = 1;
 80e:	4885                	li	a7,1
    x = -xx;
 810:	bf8d                	j	782 <printint+0x1a>

0000000000000812 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 812:	7119                	addi	sp,sp,-128
 814:	fc86                	sd	ra,120(sp)
 816:	f8a2                	sd	s0,112(sp)
 818:	f4a6                	sd	s1,104(sp)
 81a:	f0ca                	sd	s2,96(sp)
 81c:	ecce                	sd	s3,88(sp)
 81e:	e8d2                	sd	s4,80(sp)
 820:	e4d6                	sd	s5,72(sp)
 822:	e0da                	sd	s6,64(sp)
 824:	fc5e                	sd	s7,56(sp)
 826:	f862                	sd	s8,48(sp)
 828:	f466                	sd	s9,40(sp)
 82a:	f06a                	sd	s10,32(sp)
 82c:	ec6e                	sd	s11,24(sp)
 82e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 830:	0005c903          	lbu	s2,0(a1)
 834:	18090f63          	beqz	s2,9d2 <vprintf+0x1c0>
 838:	8aaa                	mv	s5,a0
 83a:	8b32                	mv	s6,a2
 83c:	00158493          	addi	s1,a1,1
  state = 0;
 840:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 842:	02500a13          	li	s4,37
 846:	4c55                	li	s8,21
 848:	00000c97          	auipc	s9,0x0
 84c:	3e8c8c93          	addi	s9,s9,1000 # c30 <malloc+0x15a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 850:	02800d93          	li	s11,40
  putc(fd, 'x');
 854:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 856:	00000b97          	auipc	s7,0x0
 85a:	432b8b93          	addi	s7,s7,1074 # c88 <digits>
 85e:	a839                	j	87c <vprintf+0x6a>
        putc(fd, c);
 860:	85ca                	mv	a1,s2
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	ee2080e7          	jalr	-286(ra) # 746 <putc>
 86c:	a019                	j	872 <vprintf+0x60>
    } else if(state == '%'){
 86e:	01498d63          	beq	s3,s4,888 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 872:	0485                	addi	s1,s1,1
 874:	fff4c903          	lbu	s2,-1(s1)
 878:	14090d63          	beqz	s2,9d2 <vprintf+0x1c0>
    if(state == 0){
 87c:	fe0999e3          	bnez	s3,86e <vprintf+0x5c>
      if(c == '%'){
 880:	ff4910e3          	bne	s2,s4,860 <vprintf+0x4e>
        state = '%';
 884:	89d2                	mv	s3,s4
 886:	b7f5                	j	872 <vprintf+0x60>
      if(c == 'd'){
 888:	11490c63          	beq	s2,s4,9a0 <vprintf+0x18e>
 88c:	f9d9079b          	addiw	a5,s2,-99
 890:	0ff7f793          	zext.b	a5,a5
 894:	10fc6e63          	bltu	s8,a5,9b0 <vprintf+0x19e>
 898:	f9d9079b          	addiw	a5,s2,-99
 89c:	0ff7f713          	zext.b	a4,a5
 8a0:	10ec6863          	bltu	s8,a4,9b0 <vprintf+0x19e>
 8a4:	00271793          	slli	a5,a4,0x2
 8a8:	97e6                	add	a5,a5,s9
 8aa:	439c                	lw	a5,0(a5)
 8ac:	97e6                	add	a5,a5,s9
 8ae:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8b0:	008b0913          	addi	s2,s6,8
 8b4:	4685                	li	a3,1
 8b6:	4629                	li	a2,10
 8b8:	000b2583          	lw	a1,0(s6)
 8bc:	8556                	mv	a0,s5
 8be:	00000097          	auipc	ra,0x0
 8c2:	eaa080e7          	jalr	-342(ra) # 768 <printint>
 8c6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	b765                	j	872 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8cc:	008b0913          	addi	s2,s6,8
 8d0:	4681                	li	a3,0
 8d2:	4629                	li	a2,10
 8d4:	000b2583          	lw	a1,0(s6)
 8d8:	8556                	mv	a0,s5
 8da:	00000097          	auipc	ra,0x0
 8de:	e8e080e7          	jalr	-370(ra) # 768 <printint>
 8e2:	8b4a                	mv	s6,s2
      state = 0;
 8e4:	4981                	li	s3,0
 8e6:	b771                	j	872 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8e8:	008b0913          	addi	s2,s6,8
 8ec:	4681                	li	a3,0
 8ee:	866a                	mv	a2,s10
 8f0:	000b2583          	lw	a1,0(s6)
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	e72080e7          	jalr	-398(ra) # 768 <printint>
 8fe:	8b4a                	mv	s6,s2
      state = 0;
 900:	4981                	li	s3,0
 902:	bf85                	j	872 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 904:	008b0793          	addi	a5,s6,8
 908:	f8f43423          	sd	a5,-120(s0)
 90c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 910:	03000593          	li	a1,48
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	e30080e7          	jalr	-464(ra) # 746 <putc>
  putc(fd, 'x');
 91e:	07800593          	li	a1,120
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	e22080e7          	jalr	-478(ra) # 746 <putc>
 92c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 92e:	03c9d793          	srli	a5,s3,0x3c
 932:	97de                	add	a5,a5,s7
 934:	0007c583          	lbu	a1,0(a5)
 938:	8556                	mv	a0,s5
 93a:	00000097          	auipc	ra,0x0
 93e:	e0c080e7          	jalr	-500(ra) # 746 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 942:	0992                	slli	s3,s3,0x4
 944:	397d                	addiw	s2,s2,-1
 946:	fe0914e3          	bnez	s2,92e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 94a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 94e:	4981                	li	s3,0
 950:	b70d                	j	872 <vprintf+0x60>
        s = va_arg(ap, char*);
 952:	008b0913          	addi	s2,s6,8
 956:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 95a:	02098163          	beqz	s3,97c <vprintf+0x16a>
        while(*s != 0){
 95e:	0009c583          	lbu	a1,0(s3)
 962:	c5ad                	beqz	a1,9cc <vprintf+0x1ba>
          putc(fd, *s);
 964:	8556                	mv	a0,s5
 966:	00000097          	auipc	ra,0x0
 96a:	de0080e7          	jalr	-544(ra) # 746 <putc>
          s++;
 96e:	0985                	addi	s3,s3,1
        while(*s != 0){
 970:	0009c583          	lbu	a1,0(s3)
 974:	f9e5                	bnez	a1,964 <vprintf+0x152>
        s = va_arg(ap, char*);
 976:	8b4a                	mv	s6,s2
      state = 0;
 978:	4981                	li	s3,0
 97a:	bde5                	j	872 <vprintf+0x60>
          s = "(null)";
 97c:	00000997          	auipc	s3,0x0
 980:	2ac98993          	addi	s3,s3,684 # c28 <malloc+0x152>
        while(*s != 0){
 984:	85ee                	mv	a1,s11
 986:	bff9                	j	964 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 988:	008b0913          	addi	s2,s6,8
 98c:	000b4583          	lbu	a1,0(s6)
 990:	8556                	mv	a0,s5
 992:	00000097          	auipc	ra,0x0
 996:	db4080e7          	jalr	-588(ra) # 746 <putc>
 99a:	8b4a                	mv	s6,s2
      state = 0;
 99c:	4981                	li	s3,0
 99e:	bdd1                	j	872 <vprintf+0x60>
        putc(fd, c);
 9a0:	85d2                	mv	a1,s4
 9a2:	8556                	mv	a0,s5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	da2080e7          	jalr	-606(ra) # 746 <putc>
      state = 0;
 9ac:	4981                	li	s3,0
 9ae:	b5d1                	j	872 <vprintf+0x60>
        putc(fd, '%');
 9b0:	85d2                	mv	a1,s4
 9b2:	8556                	mv	a0,s5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	d92080e7          	jalr	-622(ra) # 746 <putc>
        putc(fd, c);
 9bc:	85ca                	mv	a1,s2
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	d86080e7          	jalr	-634(ra) # 746 <putc>
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	b565                	j	872 <vprintf+0x60>
        s = va_arg(ap, char*);
 9cc:	8b4a                	mv	s6,s2
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	b54d                	j	872 <vprintf+0x60>
    }
  }
}
 9d2:	70e6                	ld	ra,120(sp)
 9d4:	7446                	ld	s0,112(sp)
 9d6:	74a6                	ld	s1,104(sp)
 9d8:	7906                	ld	s2,96(sp)
 9da:	69e6                	ld	s3,88(sp)
 9dc:	6a46                	ld	s4,80(sp)
 9de:	6aa6                	ld	s5,72(sp)
 9e0:	6b06                	ld	s6,64(sp)
 9e2:	7be2                	ld	s7,56(sp)
 9e4:	7c42                	ld	s8,48(sp)
 9e6:	7ca2                	ld	s9,40(sp)
 9e8:	7d02                	ld	s10,32(sp)
 9ea:	6de2                	ld	s11,24(sp)
 9ec:	6109                	addi	sp,sp,128
 9ee:	8082                	ret

00000000000009f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f0:	715d                	addi	sp,sp,-80
 9f2:	ec06                	sd	ra,24(sp)
 9f4:	e822                	sd	s0,16(sp)
 9f6:	1000                	addi	s0,sp,32
 9f8:	e010                	sd	a2,0(s0)
 9fa:	e414                	sd	a3,8(s0)
 9fc:	e818                	sd	a4,16(s0)
 9fe:	ec1c                	sd	a5,24(s0)
 a00:	03043023          	sd	a6,32(s0)
 a04:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a08:	8622                	mv	a2,s0
 a0a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a0e:	00000097          	auipc	ra,0x0
 a12:	e04080e7          	jalr	-508(ra) # 812 <vprintf>
}
 a16:	60e2                	ld	ra,24(sp)
 a18:	6442                	ld	s0,16(sp)
 a1a:	6161                	addi	sp,sp,80
 a1c:	8082                	ret

0000000000000a1e <printf>:

void
printf(const char *fmt, ...)
{
 a1e:	711d                	addi	sp,sp,-96
 a20:	ec06                	sd	ra,24(sp)
 a22:	e822                	sd	s0,16(sp)
 a24:	1000                	addi	s0,sp,32
 a26:	e40c                	sd	a1,8(s0)
 a28:	e810                	sd	a2,16(s0)
 a2a:	ec14                	sd	a3,24(s0)
 a2c:	f018                	sd	a4,32(s0)
 a2e:	f41c                	sd	a5,40(s0)
 a30:	03043823          	sd	a6,48(s0)
 a34:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a38:	00840613          	addi	a2,s0,8
 a3c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a40:	85aa                	mv	a1,a0
 a42:	4505                	li	a0,1
 a44:	00000097          	auipc	ra,0x0
 a48:	dce080e7          	jalr	-562(ra) # 812 <vprintf>
}
 a4c:	60e2                	ld	ra,24(sp)
 a4e:	6442                	ld	s0,16(sp)
 a50:	6125                	addi	sp,sp,96
 a52:	8082                	ret

0000000000000a54 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a54:	1141                	addi	sp,sp,-16
 a56:	e422                	sd	s0,8(sp)
 a58:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a5a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a5e:	00000797          	auipc	a5,0x0
 a62:	26a7b783          	ld	a5,618(a5) # cc8 <freep>
 a66:	a02d                	j	a90 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a68:	4618                	lw	a4,8(a2)
 a6a:	9f2d                	addw	a4,a4,a1
 a6c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a70:	6398                	ld	a4,0(a5)
 a72:	6310                	ld	a2,0(a4)
 a74:	a83d                	j	ab2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a76:	ff852703          	lw	a4,-8(a0)
 a7a:	9f31                	addw	a4,a4,a2
 a7c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a7e:	ff053683          	ld	a3,-16(a0)
 a82:	a091                	j	ac6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a84:	6398                	ld	a4,0(a5)
 a86:	00e7e463          	bltu	a5,a4,a8e <free+0x3a>
 a8a:	00e6ea63          	bltu	a3,a4,a9e <free+0x4a>
{
 a8e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a90:	fed7fae3          	bgeu	a5,a3,a84 <free+0x30>
 a94:	6398                	ld	a4,0(a5)
 a96:	00e6e463          	bltu	a3,a4,a9e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9a:	fee7eae3          	bltu	a5,a4,a8e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a9e:	ff852583          	lw	a1,-8(a0)
 aa2:	6390                	ld	a2,0(a5)
 aa4:	02059813          	slli	a6,a1,0x20
 aa8:	01c85713          	srli	a4,a6,0x1c
 aac:	9736                	add	a4,a4,a3
 aae:	fae60de3          	beq	a2,a4,a68 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ab2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ab6:	4790                	lw	a2,8(a5)
 ab8:	02061593          	slli	a1,a2,0x20
 abc:	01c5d713          	srli	a4,a1,0x1c
 ac0:	973e                	add	a4,a4,a5
 ac2:	fae68ae3          	beq	a3,a4,a76 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ac6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ac8:	00000717          	auipc	a4,0x0
 acc:	20f73023          	sd	a5,512(a4) # cc8 <freep>
}
 ad0:	6422                	ld	s0,8(sp)
 ad2:	0141                	addi	sp,sp,16
 ad4:	8082                	ret

0000000000000ad6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ad6:	7139                	addi	sp,sp,-64
 ad8:	fc06                	sd	ra,56(sp)
 ada:	f822                	sd	s0,48(sp)
 adc:	f426                	sd	s1,40(sp)
 ade:	f04a                	sd	s2,32(sp)
 ae0:	ec4e                	sd	s3,24(sp)
 ae2:	e852                	sd	s4,16(sp)
 ae4:	e456                	sd	s5,8(sp)
 ae6:	e05a                	sd	s6,0(sp)
 ae8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aea:	02051493          	slli	s1,a0,0x20
 aee:	9081                	srli	s1,s1,0x20
 af0:	04bd                	addi	s1,s1,15
 af2:	8091                	srli	s1,s1,0x4
 af4:	00148a1b          	addiw	s4,s1,1
 af8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 afa:	00000517          	auipc	a0,0x0
 afe:	1ce53503          	ld	a0,462(a0) # cc8 <freep>
 b02:	c515                	beqz	a0,b2e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b04:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b06:	4798                	lw	a4,8(a5)
 b08:	04977163          	bgeu	a4,s1,b4a <malloc+0x74>
 b0c:	89d2                	mv	s3,s4
 b0e:	000a071b          	sext.w	a4,s4
 b12:	6685                	lui	a3,0x1
 b14:	00d77363          	bgeu	a4,a3,b1a <malloc+0x44>
 b18:	6985                	lui	s3,0x1
 b1a:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 b1e:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b22:	00000917          	auipc	s2,0x0
 b26:	1a690913          	addi	s2,s2,422 # cc8 <freep>
  if(p == (char*)-1)
 b2a:	5afd                	li	s5,-1
 b2c:	a8a5                	j	ba4 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 b2e:	00000797          	auipc	a5,0x0
 b32:	19a78793          	addi	a5,a5,410 # cc8 <freep>
 b36:	00000717          	auipc	a4,0x0
 b3a:	19a70713          	addi	a4,a4,410 # cd0 <base>
 b3e:	e398                	sd	a4,0(a5)
 b40:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 b42:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b46:	87ba                	mv	a5,a4
 b48:	b7d1                	j	b0c <malloc+0x36>
      if(p->s.size == nunits)
 b4a:	02e48c63          	beq	s1,a4,b82 <malloc+0xac>
        p->s.size -= nunits;
 b4e:	4147073b          	subw	a4,a4,s4
 b52:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b54:	02071693          	slli	a3,a4,0x20
 b58:	01c6d713          	srli	a4,a3,0x1c
 b5c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b5e:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 b62:	00000717          	auipc	a4,0x0
 b66:	16a73323          	sd	a0,358(a4) # cc8 <freep>
      return (void*)(p + 1);
 b6a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b6e:	70e2                	ld	ra,56(sp)
 b70:	7442                	ld	s0,48(sp)
 b72:	74a2                	ld	s1,40(sp)
 b74:	7902                	ld	s2,32(sp)
 b76:	69e2                	ld	s3,24(sp)
 b78:	6a42                	ld	s4,16(sp)
 b7a:	6aa2                	ld	s5,8(sp)
 b7c:	6b02                	ld	s6,0(sp)
 b7e:	6121                	addi	sp,sp,64
 b80:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b82:	6398                	ld	a4,0(a5)
 b84:	e118                	sd	a4,0(a0)
 b86:	bff1                	j	b62 <malloc+0x8c>
  hp->s.size = nu;
 b88:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b8c:	0541                	addi	a0,a0,16
 b8e:	00000097          	auipc	ra,0x0
 b92:	ec6080e7          	jalr	-314(ra) # a54 <free>
  return freep;
 b96:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b9a:	d971                	beqz	a0,b6e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b9c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b9e:	4798                	lw	a4,8(a5)
 ba0:	fa9775e3          	bgeu	a4,s1,b4a <malloc+0x74>
    if(p == freep)
 ba4:	00093703          	ld	a4,0(s2)
 ba8:	853e                	mv	a0,a5
 baa:	fef719e3          	bne	a4,a5,b9c <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 bae:	854e                	mv	a0,s3
 bb0:	00000097          	auipc	ra,0x0
 bb4:	95e080e7          	jalr	-1698(ra) # 50e <sbrk>
  if(p == (char*)-1)
 bb8:	fd5518e3          	bne	a0,s5,b88 <malloc+0xb2>
        return 0;
 bbc:	4501                	li	a0,0
 bbe:	bf45                	j	b6e <malloc+0x98>
