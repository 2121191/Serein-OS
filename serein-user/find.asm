
serein-user/_find：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "serein-user/user.h"

static char path[512];

void find(char *filename)
{
   0:	7175                	addi	sp,sp,-144
   2:	e506                	sd	ra,136(sp)
   4:	e122                	sd	s0,128(sp)
   6:	fca6                	sd	s1,120(sp)
   8:	f8ca                	sd	s2,112(sp)
   a:	f4ce                	sd	s3,104(sp)
   c:	f0d2                	sd	s4,96(sp)
   e:	ecd6                	sd	s5,88(sp)
  10:	e8da                	sd	s6,80(sp)
  12:	e4de                	sd	s7,72(sp)
  14:	e0e2                	sd	s8,64(sp)
  16:	0900                	addi	s0,sp,144
  18:	8a2a                	mv	s4,a0
    int fd;
    struct stat st;
    if ((fd = open(path, O_RDONLY)) < 0) {
  1a:	4581                	li	a1,0
  1c:	00001517          	auipc	a0,0x1
  20:	cbc50513          	addi	a0,a0,-836 # cd8 <path>
  24:	00000097          	auipc	ra,0x0
  28:	4da080e7          	jalr	1242(ra) # 4fe <open>
  2c:	04054163          	bltz	a0,6e <find+0x6e>
  30:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if (fstat(fd, &st) < 0) {
  32:	f7040593          	addi	a1,s0,-144
  36:	00000097          	auipc	ra,0x0
  3a:	4d0080e7          	jalr	1232(ra) # 506 <fstat>
  3e:	04054663          	bltz	a0,8a <find+0x8a>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if (st.type != T_DIR) {
  42:	f9841703          	lh	a4,-104(s0)
  46:	4785                	li	a5,1
  48:	06f70463          	beq	a4,a5,b0 <find+0xb0>
        close(fd);
  4c:	8526                	mv	a0,s1
  4e:	00000097          	auipc	ra,0x0
  52:	498080e7          	jalr	1176(ra) # 4e6 <close>
        }
        find(filename);
    }
    close(fd);
    return;
}
  56:	60aa                	ld	ra,136(sp)
  58:	640a                	ld	s0,128(sp)
  5a:	74e6                	ld	s1,120(sp)
  5c:	7946                	ld	s2,112(sp)
  5e:	79a6                	ld	s3,104(sp)
  60:	7a06                	ld	s4,96(sp)
  62:	6ae6                	ld	s5,88(sp)
  64:	6b46                	ld	s6,80(sp)
  66:	6ba6                	ld	s7,72(sp)
  68:	6c06                	ld	s8,64(sp)
  6a:	6149                	addi	sp,sp,144
  6c:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  6e:	00001617          	auipc	a2,0x1
  72:	c6a60613          	addi	a2,a2,-918 # cd8 <path>
  76:	00001597          	auipc	a1,0x1
  7a:	b6a58593          	addi	a1,a1,-1174 # be0 <malloc+0xea>
  7e:	4509                	li	a0,2
  80:	00001097          	auipc	ra,0x1
  84:	990080e7          	jalr	-1648(ra) # a10 <fprintf>
        return;
  88:	b7f9                	j	56 <find+0x56>
        fprintf(2, "find: cannot stat %s\n", path);
  8a:	00001617          	auipc	a2,0x1
  8e:	c4e60613          	addi	a2,a2,-946 # cd8 <path>
  92:	00001597          	auipc	a1,0x1
  96:	b6658593          	addi	a1,a1,-1178 # bf8 <malloc+0x102>
  9a:	4509                	li	a0,2
  9c:	00001097          	auipc	ra,0x1
  a0:	974080e7          	jalr	-1676(ra) # a10 <fprintf>
        close(fd);
  a4:	8526                	mv	a0,s1
  a6:	00000097          	auipc	ra,0x0
  aa:	440080e7          	jalr	1088(ra) # 4e6 <close>
        return;
  ae:	b765                	j	56 <find+0x56>
    if (strlen(path) + 255 + 2 > sizeof(path)) {
  b0:	00001517          	auipc	a0,0x1
  b4:	c2850513          	addi	a0,a0,-984 # cd8 <path>
  b8:	00000097          	auipc	ra,0x0
  bc:	1c4080e7          	jalr	452(ra) # 27c <strlen>
  c0:	1015051b          	addiw	a0,a0,257
  c4:	20000793          	li	a5,512
  c8:	0aa7e863          	bltu	a5,a0,178 <find+0x178>
    char *p = path + strlen(path) - 1;
  cc:	00001917          	auipc	s2,0x1
  d0:	c0c90913          	addi	s2,s2,-1012 # cd8 <path>
  d4:	854a                	mv	a0,s2
  d6:	00000097          	auipc	ra,0x0
  da:	1a6080e7          	jalr	422(ra) # 27c <strlen>
  de:	1502                	slli	a0,a0,0x20
  e0:	9101                	srli	a0,a0,0x20
  e2:	fff50793          	addi	a5,a0,-1
  e6:	993e                	add	s2,s2,a5
    if (*p != '/') {
  e8:	00094703          	lbu	a4,0(s2)
  ec:	02f00793          	li	a5,47
  f0:	00f70963          	beq	a4,a5,102 <find+0x102>
        *++p = '/';
  f4:	00f900a3          	sb	a5,1(s2)
  f8:	00001917          	auipc	s2,0x1
  fc:	be090913          	addi	s2,s2,-1056 # cd8 <path>
 100:	992a                	add	s2,s2,a0
    p++;
 102:	0905                	addi	s2,s2,1
    while (readdir(fd, &st)) {
 104:	f7040993          	addi	s3,s0,-144
        if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0) {
 108:	00001a97          	auipc	s5,0x1
 10c:	b20a8a93          	addi	s5,s5,-1248 # c28 <malloc+0x132>
 110:	00001b17          	auipc	s6,0x1
 114:	b20b0b13          	addi	s6,s6,-1248 # c30 <malloc+0x13a>
            fprintf(1, "%s\n", path);
 118:	00001c17          	auipc	s8,0x1
 11c:	bc0c0c13          	addi	s8,s8,-1088 # cd8 <path>
 120:	00001b97          	auipc	s7,0x1
 124:	b18b8b93          	addi	s7,s7,-1256 # c38 <malloc+0x142>
    while (readdir(fd, &st)) {
 128:	85ce                	mv	a1,s3
 12a:	8526                	mv	a0,s1
 12c:	00000097          	auipc	ra,0x0
 130:	42a080e7          	jalr	1066(ra) # 556 <readdir>
 134:	c92d                	beqz	a0,1a6 <find+0x1a6>
        strcpy(p, st.name);
 136:	85ce                	mv	a1,s3
 138:	854a                	mv	a0,s2
 13a:	00000097          	auipc	ra,0x0
 13e:	0cc080e7          	jalr	204(ra) # 206 <strcpy>
        if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0) {
 142:	85d6                	mv	a1,s5
 144:	854a                	mv	a0,s2
 146:	00000097          	auipc	ra,0x0
 14a:	10a080e7          	jalr	266(ra) # 250 <strcmp>
 14e:	dd69                	beqz	a0,128 <find+0x128>
 150:	85da                	mv	a1,s6
 152:	854a                	mv	a0,s2
 154:	00000097          	auipc	ra,0x0
 158:	0fc080e7          	jalr	252(ra) # 250 <strcmp>
 15c:	d571                	beqz	a0,128 <find+0x128>
        if (strcmp(p, filename) == 0) {
 15e:	85d2                	mv	a1,s4
 160:	854a                	mv	a0,s2
 162:	00000097          	auipc	ra,0x0
 166:	0ee080e7          	jalr	238(ra) # 250 <strcmp>
 16a:	c515                	beqz	a0,196 <find+0x196>
        find(filename);
 16c:	8552                	mv	a0,s4
 16e:	00000097          	auipc	ra,0x0
 172:	e92080e7          	jalr	-366(ra) # 0 <find>
 176:	bf4d                	j	128 <find+0x128>
        fprintf(2, "find: path too long\n");
 178:	00001597          	auipc	a1,0x1
 17c:	a9858593          	addi	a1,a1,-1384 # c10 <malloc+0x11a>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	88e080e7          	jalr	-1906(ra) # a10 <fprintf>
        close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	35a080e7          	jalr	858(ra) # 4e6 <close>
        return;
 194:	b5c9                	j	56 <find+0x56>
            fprintf(1, "%s\n", path);
 196:	8662                	mv	a2,s8
 198:	85de                	mv	a1,s7
 19a:	4505                	li	a0,1
 19c:	00001097          	auipc	ra,0x1
 1a0:	874080e7          	jalr	-1932(ra) # a10 <fprintf>
 1a4:	b7e1                	j	16c <find+0x16c>
    close(fd);
 1a6:	8526                	mv	a0,s1
 1a8:	00000097          	auipc	ra,0x0
 1ac:	33e080e7          	jalr	830(ra) # 4e6 <close>
    return;
 1b0:	b55d                	j	56 <find+0x56>

00000000000001b2 <main>:


int main(int argc, char *argv[])
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec06                	sd	ra,24(sp)
 1b6:	e822                	sd	s0,16(sp)
 1b8:	e426                	sd	s1,8(sp)
 1ba:	1000                	addi	s0,sp,32
    if (argc < 3) {
 1bc:	4789                	li	a5,2
 1be:	02a7c063          	blt	a5,a0,1de <main+0x2c>
        fprintf(2, "Usage: find DIR FILENAME\n");
 1c2:	00001597          	auipc	a1,0x1
 1c6:	a7e58593          	addi	a1,a1,-1410 # c40 <malloc+0x14a>
 1ca:	4509                	li	a0,2
 1cc:	00001097          	auipc	ra,0x1
 1d0:	844080e7          	jalr	-1980(ra) # a10 <fprintf>
        exit(0);
 1d4:	4501                	li	a0,0
 1d6:	00000097          	auipc	ra,0x0
 1da:	2e8080e7          	jalr	744(ra) # 4be <exit>
 1de:	84ae                	mv	s1,a1
    } else {
        strcpy(path, argv[1]);
 1e0:	658c                	ld	a1,8(a1)
 1e2:	00001517          	auipc	a0,0x1
 1e6:	af650513          	addi	a0,a0,-1290 # cd8 <path>
 1ea:	00000097          	auipc	ra,0x0
 1ee:	01c080e7          	jalr	28(ra) # 206 <strcpy>
        find(argv[2]);
 1f2:	6888                	ld	a0,16(s1)
 1f4:	00000097          	auipc	ra,0x0
 1f8:	e0c080e7          	jalr	-500(ra) # 0 <find>
    }
    exit(0);
 1fc:	4501                	li	a0,0
 1fe:	00000097          	auipc	ra,0x0
 202:	2c0080e7          	jalr	704(ra) # 4be <exit>

0000000000000206 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 20c:	87aa                	mv	a5,a0
 20e:	0585                	addi	a1,a1,1
 210:	0785                	addi	a5,a5,1
 212:	fff5c703          	lbu	a4,-1(a1)
 216:	fee78fa3          	sb	a4,-1(a5)
 21a:	fb75                	bnez	a4,20e <strcpy+0x8>
    ;
  return os;
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	addi	sp,sp,16
 220:	8082                	ret

0000000000000222 <strcat>:

char*
strcat(char *s, const char *t)
{
 222:	1141                	addi	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 228:	00054783          	lbu	a5,0(a0)
 22c:	c385                	beqz	a5,24c <strcat+0x2a>
 22e:	87aa                	mv	a5,a0
    s++;
 230:	0785                	addi	a5,a5,1
  while(*s)
 232:	0007c703          	lbu	a4,0(a5)
 236:	ff6d                	bnez	a4,230 <strcat+0xe>
  while((*s++ = *t++))
 238:	0585                	addi	a1,a1,1
 23a:	0785                	addi	a5,a5,1
 23c:	fff5c703          	lbu	a4,-1(a1)
 240:	fee78fa3          	sb	a4,-1(a5)
 244:	fb75                	bnez	a4,238 <strcat+0x16>
    ;
  return os;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	addi	sp,sp,16
 24a:	8082                	ret
  while(*s)
 24c:	87aa                	mv	a5,a0
 24e:	b7ed                	j	238 <strcat+0x16>

0000000000000250 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 250:	1141                	addi	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 256:	00054783          	lbu	a5,0(a0)
 25a:	cb91                	beqz	a5,26e <strcmp+0x1e>
 25c:	0005c703          	lbu	a4,0(a1)
 260:	00f71763          	bne	a4,a5,26e <strcmp+0x1e>
    p++, q++;
 264:	0505                	addi	a0,a0,1
 266:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 268:	00054783          	lbu	a5,0(a0)
 26c:	fbe5                	bnez	a5,25c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 26e:	0005c503          	lbu	a0,0(a1)
}
 272:	40a7853b          	subw	a0,a5,a0
 276:	6422                	ld	s0,8(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret

000000000000027c <strlen>:

uint
strlen(const char *s)
{
 27c:	1141                	addi	sp,sp,-16
 27e:	e422                	sd	s0,8(sp)
 280:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 282:	00054783          	lbu	a5,0(a0)
 286:	cf91                	beqz	a5,2a2 <strlen+0x26>
 288:	0505                	addi	a0,a0,1
 28a:	87aa                	mv	a5,a0
 28c:	4685                	li	a3,1
 28e:	9e89                	subw	a3,a3,a0
 290:	00f6853b          	addw	a0,a3,a5
 294:	0785                	addi	a5,a5,1
 296:	fff7c703          	lbu	a4,-1(a5)
 29a:	fb7d                	bnez	a4,290 <strlen+0x14>
    ;
  return n;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  for(n = 0; s[n]; n++)
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <strlen+0x20>

00000000000002a6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ac:	ca19                	beqz	a2,2c2 <memset+0x1c>
 2ae:	87aa                	mv	a5,a0
 2b0:	1602                	slli	a2,a2,0x20
 2b2:	9201                	srli	a2,a2,0x20
 2b4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2b8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2bc:	0785                	addi	a5,a5,1
 2be:	fee79de3          	bne	a5,a4,2b8 <memset+0x12>
  }
  return dst;
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret

00000000000002c8 <strchr>:

char*
strchr(const char *s, char c)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	cb99                	beqz	a5,2e8 <strchr+0x20>
    if(*s == c)
 2d4:	00f58763          	beq	a1,a5,2e2 <strchr+0x1a>
  for(; *s; s++)
 2d8:	0505                	addi	a0,a0,1
 2da:	00054783          	lbu	a5,0(a0)
 2de:	fbfd                	bnez	a5,2d4 <strchr+0xc>
      return (char*)s;
  return 0;
 2e0:	4501                	li	a0,0
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret
  return 0;
 2e8:	4501                	li	a0,0
 2ea:	bfe5                	j	2e2 <strchr+0x1a>

00000000000002ec <gets>:

char*
gets(char *buf, int max)
{
 2ec:	711d                	addi	sp,sp,-96
 2ee:	ec86                	sd	ra,88(sp)
 2f0:	e8a2                	sd	s0,80(sp)
 2f2:	e4a6                	sd	s1,72(sp)
 2f4:	e0ca                	sd	s2,64(sp)
 2f6:	fc4e                	sd	s3,56(sp)
 2f8:	f852                	sd	s4,48(sp)
 2fa:	f456                	sd	s5,40(sp)
 2fc:	f05a                	sd	s6,32(sp)
 2fe:	ec5e                	sd	s7,24(sp)
 300:	e862                	sd	s8,16(sp)
 302:	1080                	addi	s0,sp,96
 304:	8baa                	mv	s7,a0
 306:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 308:	892a                	mv	s2,a0
 30a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 30c:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 310:	4b29                	li	s6,10
 312:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 314:	89a6                	mv	s3,s1
 316:	2485                	addiw	s1,s1,1
 318:	0344d763          	bge	s1,s4,346 <gets+0x5a>
    cc = read(0, &c, 1);
 31c:	4605                	li	a2,1
 31e:	85d6                	mv	a1,s5
 320:	4501                	li	a0,0
 322:	00000097          	auipc	ra,0x0
 326:	1b4080e7          	jalr	436(ra) # 4d6 <read>
    if(cc < 1)
 32a:	00a05e63          	blez	a0,346 <gets+0x5a>
    buf[i++] = c;
 32e:	faf44783          	lbu	a5,-81(s0)
 332:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 336:	01678763          	beq	a5,s6,344 <gets+0x58>
 33a:	0905                	addi	s2,s2,1
 33c:	fd879ce3          	bne	a5,s8,314 <gets+0x28>
  for(i=0; i+1 < max; ){
 340:	89a6                	mv	s3,s1
 342:	a011                	j	346 <gets+0x5a>
 344:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 346:	99de                	add	s3,s3,s7
 348:	00098023          	sb	zero,0(s3)
  return buf;
}
 34c:	855e                	mv	a0,s7
 34e:	60e6                	ld	ra,88(sp)
 350:	6446                	ld	s0,80(sp)
 352:	64a6                	ld	s1,72(sp)
 354:	6906                	ld	s2,64(sp)
 356:	79e2                	ld	s3,56(sp)
 358:	7a42                	ld	s4,48(sp)
 35a:	7aa2                	ld	s5,40(sp)
 35c:	7b02                	ld	s6,32(sp)
 35e:	6be2                	ld	s7,24(sp)
 360:	6c42                	ld	s8,16(sp)
 362:	6125                	addi	sp,sp,96
 364:	8082                	ret

0000000000000366 <stat>:

int
stat(const char *n, struct stat *st)
{
 366:	1101                	addi	sp,sp,-32
 368:	ec06                	sd	ra,24(sp)
 36a:	e822                	sd	s0,16(sp)
 36c:	e426                	sd	s1,8(sp)
 36e:	e04a                	sd	s2,0(sp)
 370:	1000                	addi	s0,sp,32
 372:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 374:	4581                	li	a1,0
 376:	00000097          	auipc	ra,0x0
 37a:	188080e7          	jalr	392(ra) # 4fe <open>
  if(fd < 0)
 37e:	02054563          	bltz	a0,3a8 <stat+0x42>
 382:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 384:	85ca                	mv	a1,s2
 386:	00000097          	auipc	ra,0x0
 38a:	180080e7          	jalr	384(ra) # 506 <fstat>
 38e:	892a                	mv	s2,a0
  close(fd);
 390:	8526                	mv	a0,s1
 392:	00000097          	auipc	ra,0x0
 396:	154080e7          	jalr	340(ra) # 4e6 <close>
  return r;
}
 39a:	854a                	mv	a0,s2
 39c:	60e2                	ld	ra,24(sp)
 39e:	6442                	ld	s0,16(sp)
 3a0:	64a2                	ld	s1,8(sp)
 3a2:	6902                	ld	s2,0(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret
    return -1;
 3a8:	597d                	li	s2,-1
 3aa:	bfc5                	j	39a <stat+0x34>

00000000000003ac <atoi>:

int
atoi(const char *s)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 3b2:	00054703          	lbu	a4,0(a0)
 3b6:	02d00793          	li	a5,45
  int neg = 1;
 3ba:	4585                	li	a1,1
  if (*s == '-') {
 3bc:	04f70363          	beq	a4,a5,402 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 3c0:	00054703          	lbu	a4,0(a0)
 3c4:	fd07079b          	addiw	a5,a4,-48
 3c8:	0ff7f793          	zext.b	a5,a5
 3cc:	46a5                	li	a3,9
 3ce:	02f6ed63          	bltu	a3,a5,408 <atoi+0x5c>
  n = 0;
 3d2:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 3d4:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 3d6:	0505                	addi	a0,a0,1
 3d8:	0026979b          	slliw	a5,a3,0x2
 3dc:	9fb5                	addw	a5,a5,a3
 3de:	0017979b          	slliw	a5,a5,0x1
 3e2:	9fb9                	addw	a5,a5,a4
 3e4:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 3e8:	00054703          	lbu	a4,0(a0)
 3ec:	fd07079b          	addiw	a5,a4,-48
 3f0:	0ff7f793          	zext.b	a5,a5
 3f4:	fef671e3          	bgeu	a2,a5,3d6 <atoi+0x2a>
  return n * neg;
}
 3f8:	02d5853b          	mulw	a0,a1,a3
 3fc:	6422                	ld	s0,8(sp)
 3fe:	0141                	addi	sp,sp,16
 400:	8082                	ret
    s++;
 402:	0505                	addi	a0,a0,1
    neg = -1;
 404:	55fd                	li	a1,-1
 406:	bf6d                	j	3c0 <atoi+0x14>
  n = 0;
 408:	4681                	li	a3,0
 40a:	b7fd                	j	3f8 <atoi+0x4c>

000000000000040c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 412:	02b57463          	bgeu	a0,a1,43a <memmove+0x2e>
    while(n-- > 0)
 416:	00c05f63          	blez	a2,434 <memmove+0x28>
 41a:	1602                	slli	a2,a2,0x20
 41c:	9201                	srli	a2,a2,0x20
 41e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 422:	872a                	mv	a4,a0
      *dst++ = *src++;
 424:	0585                	addi	a1,a1,1
 426:	0705                	addi	a4,a4,1
 428:	fff5c683          	lbu	a3,-1(a1)
 42c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 430:	fee79ae3          	bne	a5,a4,424 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret
    dst += n;
 43a:	00c50733          	add	a4,a0,a2
    src += n;
 43e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 440:	fec05ae3          	blez	a2,434 <memmove+0x28>
 444:	fff6079b          	addiw	a5,a2,-1
 448:	1782                	slli	a5,a5,0x20
 44a:	9381                	srli	a5,a5,0x20
 44c:	fff7c793          	not	a5,a5
 450:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 452:	15fd                	addi	a1,a1,-1
 454:	177d                	addi	a4,a4,-1
 456:	0005c683          	lbu	a3,0(a1)
 45a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 45e:	fee79ae3          	bne	a5,a4,452 <memmove+0x46>
 462:	bfc9                	j	434 <memmove+0x28>

0000000000000464 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 464:	1141                	addi	sp,sp,-16
 466:	e422                	sd	s0,8(sp)
 468:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 46a:	ca05                	beqz	a2,49a <memcmp+0x36>
 46c:	fff6069b          	addiw	a3,a2,-1
 470:	1682                	slli	a3,a3,0x20
 472:	9281                	srli	a3,a3,0x20
 474:	0685                	addi	a3,a3,1
 476:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 478:	00054783          	lbu	a5,0(a0)
 47c:	0005c703          	lbu	a4,0(a1)
 480:	00e79863          	bne	a5,a4,490 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 484:	0505                	addi	a0,a0,1
    p2++;
 486:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 488:	fed518e3          	bne	a0,a3,478 <memcmp+0x14>
  }
  return 0;
 48c:	4501                	li	a0,0
 48e:	a019                	j	494 <memcmp+0x30>
      return *p1 - *p2;
 490:	40e7853b          	subw	a0,a5,a4
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
  return 0;
 49a:	4501                	li	a0,0
 49c:	bfe5                	j	494 <memcmp+0x30>

000000000000049e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e406                	sd	ra,8(sp)
 4a2:	e022                	sd	s0,0(sp)
 4a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4a6:	00000097          	auipc	ra,0x0
 4aa:	f66080e7          	jalr	-154(ra) # 40c <memmove>
}
 4ae:	60a2                	ld	ra,8(sp)
 4b0:	6402                	ld	s0,0(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret

00000000000004b6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 4b6:	4885                	li	a7,1
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <exit>:
.global exit
exit:
 li a7, SYS_exit
 4be:	4889                	li	a7,2
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c6:	488d                	li	a7,3
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ce:	4891                	li	a7,4
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <read>:
.global read
read:
 li a7, SYS_read
 4d6:	4895                	li	a7,5
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <write>:
.global write
write:
 li a7, SYS_write
 4de:	48c1                	li	a7,16
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <close>:
.global close
close:
 li a7, SYS_close
 4e6:	48d5                	li	a7,21
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ee:	4899                	li	a7,6
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f6:	489d                	li	a7,7
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <open>:
.global open
open:
 li a7, SYS_open
 4fe:	48bd                	li	a7,15
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 506:	48a1                	li	a7,8
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 50e:	48d1                	li	a7,20
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 516:	48a5                	li	a7,9
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <dup>:
.global dup
dup:
 li a7, SYS_dup
 51e:	48a9                	li	a7,10
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 526:	48ad                	li	a7,11
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 52e:	48b1                	li	a7,12
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 536:	48b5                	li	a7,13
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 53e:	48b9                	li	a7,14
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 546:	48d9                	li	a7,22
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <dev>:
.global dev
dev:
 li a7, SYS_dev
 54e:	48dd                	li	a7,23
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 556:	48e1                	li	a7,24
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 55e:	48e5                	li	a7,25
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <remove>:
.global remove
remove:
 li a7, SYS_remove
 566:	48c5                	li	a7,17
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <trace>:
.global trace
trace:
 li a7, SYS_trace
 56e:	48c9                	li	a7,18
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 576:	48cd                	li	a7,19
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <rename>:
.global rename
rename:
 li a7, SYS_rename
 57e:	48e9                	li	a7,26
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 586:	48ed                	li	a7,27
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 58e:	48f1                	li	a7,28
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 596:	48f5                	li	a7,29
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 59e:	48f9                	li	a7,30
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 5a6:	48fd                	li	a7,31
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 5ae:	02000893          	li	a7,32
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 5b8:	02100893          	li	a7,33
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 5c2:	02200893          	li	a7,34
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 5cc:	02300893          	li	a7,35
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 5d6:	02400893          	li	a7,36
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 5e0:	02500893          	li	a7,37
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 5ea:	02600893          	li	a7,38
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 5f4:	02700893          	li	a7,39
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 5fe:	02800893          	li	a7,40
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 608:	02900893          	li	a7,41
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 612:	02a00893          	li	a7,42
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 61c:	02b00893          	li	a7,43
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 626:	02c00893          	li	a7,44
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 630:	02d00893          	li	a7,45
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 63a:	02e00893          	li	a7,46
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 644:	02f00893          	li	a7,47
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 64e:	03000893          	li	a7,48
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 658:	03100893          	li	a7,49
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 662:	03200893          	li	a7,50
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 66c:	03300893          	li	a7,51
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 676:	03400893          	li	a7,52
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 680:	03500893          	li	a7,53
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 68a:	03600893          	li	a7,54
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 694:	03700893          	li	a7,55
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 69e:	03800893          	li	a7,56
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 6a8:	03900893          	li	a7,57
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 6b2:	03a00893          	li	a7,58
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <poll>:
.global poll
poll:
 li a7, SYS_poll
 6bc:	03b00893          	li	a7,59
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 6c6:	03c00893          	li	a7,60
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 6d0:	03d00893          	li	a7,61
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 6da:	03e00893          	li	a7,62
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <clone>:
.global clone
clone:
 li a7, SYS_clone
 6e4:	03f00893          	li	a7,63
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <futex>:
.global futex
futex:
 li a7, SYS_futex
 6ee:	04000893          	li	a7,64
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 6f8:	04100893          	li	a7,65
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <halt>:
.global halt
halt:
 li a7, SYS_halt
 702:	04200893          	li	a7,66
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 70c:	04300893          	li	a7,67
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <socket>:
.global socket
socket:
 li a7, SYS_socket
 716:	04400893          	li	a7,68
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <bind>:
.global bind
bind:
 li a7, SYS_bind
 720:	04500893          	li	a7,69
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <listen>:
.global listen
listen:
 li a7, SYS_listen
 72a:	04600893          	li	a7,70
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <accept>:
.global accept
accept:
 li a7, SYS_accept
 734:	04700893          	li	a7,71
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <connect>:
.global connect
connect:
 li a7, SYS_connect
 73e:	04800893          	li	a7,72
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <send>:
.global send
send:
 li a7, SYS_send
 748:	04900893          	li	a7,73
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <recv>:
.global recv
recv:
 li a7, SYS_recv
 752:	04a00893          	li	a7,74
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 75c:	04b00893          	li	a7,75
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 766:	1101                	addi	sp,sp,-32
 768:	ec06                	sd	ra,24(sp)
 76a:	e822                	sd	s0,16(sp)
 76c:	1000                	addi	s0,sp,32
 76e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 772:	4605                	li	a2,1
 774:	fef40593          	addi	a1,s0,-17
 778:	00000097          	auipc	ra,0x0
 77c:	d66080e7          	jalr	-666(ra) # 4de <write>
}
 780:	60e2                	ld	ra,24(sp)
 782:	6442                	ld	s0,16(sp)
 784:	6105                	addi	sp,sp,32
 786:	8082                	ret

0000000000000788 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 788:	7139                	addi	sp,sp,-64
 78a:	fc06                	sd	ra,56(sp)
 78c:	f822                	sd	s0,48(sp)
 78e:	f426                	sd	s1,40(sp)
 790:	f04a                	sd	s2,32(sp)
 792:	ec4e                	sd	s3,24(sp)
 794:	0080                	addi	s0,sp,64
 796:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 798:	c299                	beqz	a3,79e <printint+0x16>
 79a:	0805c863          	bltz	a1,82a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 79e:	2581                	sext.w	a1,a1
  neg = 0;
 7a0:	4881                	li	a7,0
  }

  i = 0;
 7a2:	fc040993          	addi	s3,s0,-64
  neg = 0;
 7a6:	86ce                	mv	a3,s3
  i = 0;
 7a8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7aa:	2601                	sext.w	a2,a2
 7ac:	00000517          	auipc	a0,0x0
 7b0:	51450513          	addi	a0,a0,1300 # cc0 <digits>
 7b4:	883a                	mv	a6,a4
 7b6:	2705                	addiw	a4,a4,1
 7b8:	02c5f7bb          	remuw	a5,a1,a2
 7bc:	1782                	slli	a5,a5,0x20
 7be:	9381                	srli	a5,a5,0x20
 7c0:	97aa                	add	a5,a5,a0
 7c2:	0007c783          	lbu	a5,0(a5)
 7c6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7ca:	0005879b          	sext.w	a5,a1
 7ce:	02c5d5bb          	divuw	a1,a1,a2
 7d2:	0685                	addi	a3,a3,1
 7d4:	fec7f0e3          	bgeu	a5,a2,7b4 <printint+0x2c>
  if(neg)
 7d8:	00088c63          	beqz	a7,7f0 <printint+0x68>
    buf[i++] = '-';
 7dc:	fd070793          	addi	a5,a4,-48
 7e0:	00878733          	add	a4,a5,s0
 7e4:	02d00793          	li	a5,45
 7e8:	fef70823          	sb	a5,-16(a4)
 7ec:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7f0:	02e05663          	blez	a4,81c <printint+0x94>
 7f4:	fc040913          	addi	s2,s0,-64
 7f8:	993a                	add	s2,s2,a4
 7fa:	19fd                	addi	s3,s3,-1
 7fc:	99ba                	add	s3,s3,a4
 7fe:	377d                	addiw	a4,a4,-1
 800:	1702                	slli	a4,a4,0x20
 802:	9301                	srli	a4,a4,0x20
 804:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 808:	fff94583          	lbu	a1,-1(s2)
 80c:	8526                	mv	a0,s1
 80e:	00000097          	auipc	ra,0x0
 812:	f58080e7          	jalr	-168(ra) # 766 <putc>
  while(--i >= 0)
 816:	197d                	addi	s2,s2,-1
 818:	ff3918e3          	bne	s2,s3,808 <printint+0x80>
}
 81c:	70e2                	ld	ra,56(sp)
 81e:	7442                	ld	s0,48(sp)
 820:	74a2                	ld	s1,40(sp)
 822:	7902                	ld	s2,32(sp)
 824:	69e2                	ld	s3,24(sp)
 826:	6121                	addi	sp,sp,64
 828:	8082                	ret
    x = -xx;
 82a:	40b005bb          	negw	a1,a1
    neg = 1;
 82e:	4885                	li	a7,1
    x = -xx;
 830:	bf8d                	j	7a2 <printint+0x1a>

0000000000000832 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 832:	7119                	addi	sp,sp,-128
 834:	fc86                	sd	ra,120(sp)
 836:	f8a2                	sd	s0,112(sp)
 838:	f4a6                	sd	s1,104(sp)
 83a:	f0ca                	sd	s2,96(sp)
 83c:	ecce                	sd	s3,88(sp)
 83e:	e8d2                	sd	s4,80(sp)
 840:	e4d6                	sd	s5,72(sp)
 842:	e0da                	sd	s6,64(sp)
 844:	fc5e                	sd	s7,56(sp)
 846:	f862                	sd	s8,48(sp)
 848:	f466                	sd	s9,40(sp)
 84a:	f06a                	sd	s10,32(sp)
 84c:	ec6e                	sd	s11,24(sp)
 84e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 850:	0005c903          	lbu	s2,0(a1)
 854:	18090f63          	beqz	s2,9f2 <vprintf+0x1c0>
 858:	8aaa                	mv	s5,a0
 85a:	8b32                	mv	s6,a2
 85c:	00158493          	addi	s1,a1,1
  state = 0;
 860:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 862:	02500a13          	li	s4,37
 866:	4c55                	li	s8,21
 868:	00000c97          	auipc	s9,0x0
 86c:	400c8c93          	addi	s9,s9,1024 # c68 <malloc+0x172>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 870:	02800d93          	li	s11,40
  putc(fd, 'x');
 874:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 876:	00000b97          	auipc	s7,0x0
 87a:	44ab8b93          	addi	s7,s7,1098 # cc0 <digits>
 87e:	a839                	j	89c <vprintf+0x6a>
        putc(fd, c);
 880:	85ca                	mv	a1,s2
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	ee2080e7          	jalr	-286(ra) # 766 <putc>
 88c:	a019                	j	892 <vprintf+0x60>
    } else if(state == '%'){
 88e:	01498d63          	beq	s3,s4,8a8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 892:	0485                	addi	s1,s1,1
 894:	fff4c903          	lbu	s2,-1(s1)
 898:	14090d63          	beqz	s2,9f2 <vprintf+0x1c0>
    if(state == 0){
 89c:	fe0999e3          	bnez	s3,88e <vprintf+0x5c>
      if(c == '%'){
 8a0:	ff4910e3          	bne	s2,s4,880 <vprintf+0x4e>
        state = '%';
 8a4:	89d2                	mv	s3,s4
 8a6:	b7f5                	j	892 <vprintf+0x60>
      if(c == 'd'){
 8a8:	11490c63          	beq	s2,s4,9c0 <vprintf+0x18e>
 8ac:	f9d9079b          	addiw	a5,s2,-99
 8b0:	0ff7f793          	zext.b	a5,a5
 8b4:	10fc6e63          	bltu	s8,a5,9d0 <vprintf+0x19e>
 8b8:	f9d9079b          	addiw	a5,s2,-99
 8bc:	0ff7f713          	zext.b	a4,a5
 8c0:	10ec6863          	bltu	s8,a4,9d0 <vprintf+0x19e>
 8c4:	00271793          	slli	a5,a4,0x2
 8c8:	97e6                	add	a5,a5,s9
 8ca:	439c                	lw	a5,0(a5)
 8cc:	97e6                	add	a5,a5,s9
 8ce:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8d0:	008b0913          	addi	s2,s6,8
 8d4:	4685                	li	a3,1
 8d6:	4629                	li	a2,10
 8d8:	000b2583          	lw	a1,0(s6)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	eaa080e7          	jalr	-342(ra) # 788 <printint>
 8e6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	b765                	j	892 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ec:	008b0913          	addi	s2,s6,8
 8f0:	4681                	li	a3,0
 8f2:	4629                	li	a2,10
 8f4:	000b2583          	lw	a1,0(s6)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e8e080e7          	jalr	-370(ra) # 788 <printint>
 902:	8b4a                	mv	s6,s2
      state = 0;
 904:	4981                	li	s3,0
 906:	b771                	j	892 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 908:	008b0913          	addi	s2,s6,8
 90c:	4681                	li	a3,0
 90e:	866a                	mv	a2,s10
 910:	000b2583          	lw	a1,0(s6)
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	e72080e7          	jalr	-398(ra) # 788 <printint>
 91e:	8b4a                	mv	s6,s2
      state = 0;
 920:	4981                	li	s3,0
 922:	bf85                	j	892 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 924:	008b0793          	addi	a5,s6,8
 928:	f8f43423          	sd	a5,-120(s0)
 92c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 930:	03000593          	li	a1,48
 934:	8556                	mv	a0,s5
 936:	00000097          	auipc	ra,0x0
 93a:	e30080e7          	jalr	-464(ra) # 766 <putc>
  putc(fd, 'x');
 93e:	07800593          	li	a1,120
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	e22080e7          	jalr	-478(ra) # 766 <putc>
 94c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 94e:	03c9d793          	srli	a5,s3,0x3c
 952:	97de                	add	a5,a5,s7
 954:	0007c583          	lbu	a1,0(a5)
 958:	8556                	mv	a0,s5
 95a:	00000097          	auipc	ra,0x0
 95e:	e0c080e7          	jalr	-500(ra) # 766 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 962:	0992                	slli	s3,s3,0x4
 964:	397d                	addiw	s2,s2,-1
 966:	fe0914e3          	bnez	s2,94e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 96a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 96e:	4981                	li	s3,0
 970:	b70d                	j	892 <vprintf+0x60>
        s = va_arg(ap, char*);
 972:	008b0913          	addi	s2,s6,8
 976:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 97a:	02098163          	beqz	s3,99c <vprintf+0x16a>
        while(*s != 0){
 97e:	0009c583          	lbu	a1,0(s3)
 982:	c5ad                	beqz	a1,9ec <vprintf+0x1ba>
          putc(fd, *s);
 984:	8556                	mv	a0,s5
 986:	00000097          	auipc	ra,0x0
 98a:	de0080e7          	jalr	-544(ra) # 766 <putc>
          s++;
 98e:	0985                	addi	s3,s3,1
        while(*s != 0){
 990:	0009c583          	lbu	a1,0(s3)
 994:	f9e5                	bnez	a1,984 <vprintf+0x152>
        s = va_arg(ap, char*);
 996:	8b4a                	mv	s6,s2
      state = 0;
 998:	4981                	li	s3,0
 99a:	bde5                	j	892 <vprintf+0x60>
          s = "(null)";
 99c:	00000997          	auipc	s3,0x0
 9a0:	2c498993          	addi	s3,s3,708 # c60 <malloc+0x16a>
        while(*s != 0){
 9a4:	85ee                	mv	a1,s11
 9a6:	bff9                	j	984 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 9a8:	008b0913          	addi	s2,s6,8
 9ac:	000b4583          	lbu	a1,0(s6)
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	db4080e7          	jalr	-588(ra) # 766 <putc>
 9ba:	8b4a                	mv	s6,s2
      state = 0;
 9bc:	4981                	li	s3,0
 9be:	bdd1                	j	892 <vprintf+0x60>
        putc(fd, c);
 9c0:	85d2                	mv	a1,s4
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	da2080e7          	jalr	-606(ra) # 766 <putc>
      state = 0;
 9cc:	4981                	li	s3,0
 9ce:	b5d1                	j	892 <vprintf+0x60>
        putc(fd, '%');
 9d0:	85d2                	mv	a1,s4
 9d2:	8556                	mv	a0,s5
 9d4:	00000097          	auipc	ra,0x0
 9d8:	d92080e7          	jalr	-622(ra) # 766 <putc>
        putc(fd, c);
 9dc:	85ca                	mv	a1,s2
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	d86080e7          	jalr	-634(ra) # 766 <putc>
      state = 0;
 9e8:	4981                	li	s3,0
 9ea:	b565                	j	892 <vprintf+0x60>
        s = va_arg(ap, char*);
 9ec:	8b4a                	mv	s6,s2
      state = 0;
 9ee:	4981                	li	s3,0
 9f0:	b54d                	j	892 <vprintf+0x60>
    }
  }
}
 9f2:	70e6                	ld	ra,120(sp)
 9f4:	7446                	ld	s0,112(sp)
 9f6:	74a6                	ld	s1,104(sp)
 9f8:	7906                	ld	s2,96(sp)
 9fa:	69e6                	ld	s3,88(sp)
 9fc:	6a46                	ld	s4,80(sp)
 9fe:	6aa6                	ld	s5,72(sp)
 a00:	6b06                	ld	s6,64(sp)
 a02:	7be2                	ld	s7,56(sp)
 a04:	7c42                	ld	s8,48(sp)
 a06:	7ca2                	ld	s9,40(sp)
 a08:	7d02                	ld	s10,32(sp)
 a0a:	6de2                	ld	s11,24(sp)
 a0c:	6109                	addi	sp,sp,128
 a0e:	8082                	ret

0000000000000a10 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a10:	715d                	addi	sp,sp,-80
 a12:	ec06                	sd	ra,24(sp)
 a14:	e822                	sd	s0,16(sp)
 a16:	1000                	addi	s0,sp,32
 a18:	e010                	sd	a2,0(s0)
 a1a:	e414                	sd	a3,8(s0)
 a1c:	e818                	sd	a4,16(s0)
 a1e:	ec1c                	sd	a5,24(s0)
 a20:	03043023          	sd	a6,32(s0)
 a24:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a28:	8622                	mv	a2,s0
 a2a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a2e:	00000097          	auipc	ra,0x0
 a32:	e04080e7          	jalr	-508(ra) # 832 <vprintf>
}
 a36:	60e2                	ld	ra,24(sp)
 a38:	6442                	ld	s0,16(sp)
 a3a:	6161                	addi	sp,sp,80
 a3c:	8082                	ret

0000000000000a3e <printf>:

void
printf(const char *fmt, ...)
{
 a3e:	711d                	addi	sp,sp,-96
 a40:	ec06                	sd	ra,24(sp)
 a42:	e822                	sd	s0,16(sp)
 a44:	1000                	addi	s0,sp,32
 a46:	e40c                	sd	a1,8(s0)
 a48:	e810                	sd	a2,16(s0)
 a4a:	ec14                	sd	a3,24(s0)
 a4c:	f018                	sd	a4,32(s0)
 a4e:	f41c                	sd	a5,40(s0)
 a50:	03043823          	sd	a6,48(s0)
 a54:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a58:	00840613          	addi	a2,s0,8
 a5c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a60:	85aa                	mv	a1,a0
 a62:	4505                	li	a0,1
 a64:	00000097          	auipc	ra,0x0
 a68:	dce080e7          	jalr	-562(ra) # 832 <vprintf>
}
 a6c:	60e2                	ld	ra,24(sp)
 a6e:	6442                	ld	s0,16(sp)
 a70:	6125                	addi	sp,sp,96
 a72:	8082                	ret

0000000000000a74 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a74:	1141                	addi	sp,sp,-16
 a76:	e422                	sd	s0,8(sp)
 a78:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a7a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a7e:	00000797          	auipc	a5,0x0
 a82:	45a7b783          	ld	a5,1114(a5) # ed8 <freep>
 a86:	a02d                	j	ab0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a88:	4618                	lw	a4,8(a2)
 a8a:	9f2d                	addw	a4,a4,a1
 a8c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a90:	6398                	ld	a4,0(a5)
 a92:	6310                	ld	a2,0(a4)
 a94:	a83d                	j	ad2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a96:	ff852703          	lw	a4,-8(a0)
 a9a:	9f31                	addw	a4,a4,a2
 a9c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a9e:	ff053683          	ld	a3,-16(a0)
 aa2:	a091                	j	ae6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa4:	6398                	ld	a4,0(a5)
 aa6:	00e7e463          	bltu	a5,a4,aae <free+0x3a>
 aaa:	00e6ea63          	bltu	a3,a4,abe <free+0x4a>
{
 aae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab0:	fed7fae3          	bgeu	a5,a3,aa4 <free+0x30>
 ab4:	6398                	ld	a4,0(a5)
 ab6:	00e6e463          	bltu	a3,a4,abe <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aba:	fee7eae3          	bltu	a5,a4,aae <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 abe:	ff852583          	lw	a1,-8(a0)
 ac2:	6390                	ld	a2,0(a5)
 ac4:	02059813          	slli	a6,a1,0x20
 ac8:	01c85713          	srli	a4,a6,0x1c
 acc:	9736                	add	a4,a4,a3
 ace:	fae60de3          	beq	a2,a4,a88 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ad2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ad6:	4790                	lw	a2,8(a5)
 ad8:	02061593          	slli	a1,a2,0x20
 adc:	01c5d713          	srli	a4,a1,0x1c
 ae0:	973e                	add	a4,a4,a5
 ae2:	fae68ae3          	beq	a3,a4,a96 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ae6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ae8:	00000717          	auipc	a4,0x0
 aec:	3ef73823          	sd	a5,1008(a4) # ed8 <freep>
}
 af0:	6422                	ld	s0,8(sp)
 af2:	0141                	addi	sp,sp,16
 af4:	8082                	ret

0000000000000af6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 af6:	7139                	addi	sp,sp,-64
 af8:	fc06                	sd	ra,56(sp)
 afa:	f822                	sd	s0,48(sp)
 afc:	f426                	sd	s1,40(sp)
 afe:	f04a                	sd	s2,32(sp)
 b00:	ec4e                	sd	s3,24(sp)
 b02:	e852                	sd	s4,16(sp)
 b04:	e456                	sd	s5,8(sp)
 b06:	e05a                	sd	s6,0(sp)
 b08:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b0a:	02051493          	slli	s1,a0,0x20
 b0e:	9081                	srli	s1,s1,0x20
 b10:	04bd                	addi	s1,s1,15
 b12:	8091                	srli	s1,s1,0x4
 b14:	00148a1b          	addiw	s4,s1,1
 b18:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b1a:	00000517          	auipc	a0,0x0
 b1e:	3be53503          	ld	a0,958(a0) # ed8 <freep>
 b22:	c515                	beqz	a0,b4e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b24:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b26:	4798                	lw	a4,8(a5)
 b28:	04977163          	bgeu	a4,s1,b6a <malloc+0x74>
 b2c:	89d2                	mv	s3,s4
 b2e:	000a071b          	sext.w	a4,s4
 b32:	6685                	lui	a3,0x1
 b34:	00d77363          	bgeu	a4,a3,b3a <malloc+0x44>
 b38:	6985                	lui	s3,0x1
 b3a:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 b3e:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b42:	00000917          	auipc	s2,0x0
 b46:	39690913          	addi	s2,s2,918 # ed8 <freep>
  if(p == (char*)-1)
 b4a:	5afd                	li	s5,-1
 b4c:	a8a5                	j	bc4 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 b4e:	00000797          	auipc	a5,0x0
 b52:	38a78793          	addi	a5,a5,906 # ed8 <freep>
 b56:	00000717          	auipc	a4,0x0
 b5a:	38a70713          	addi	a4,a4,906 # ee0 <base>
 b5e:	e398                	sd	a4,0(a5)
 b60:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 b62:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b66:	87ba                	mv	a5,a4
 b68:	b7d1                	j	b2c <malloc+0x36>
      if(p->s.size == nunits)
 b6a:	02e48c63          	beq	s1,a4,ba2 <malloc+0xac>
        p->s.size -= nunits;
 b6e:	4147073b          	subw	a4,a4,s4
 b72:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b74:	02071693          	slli	a3,a4,0x20
 b78:	01c6d713          	srli	a4,a3,0x1c
 b7c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b7e:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 b82:	00000717          	auipc	a4,0x0
 b86:	34a73b23          	sd	a0,854(a4) # ed8 <freep>
      return (void*)(p + 1);
 b8a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b8e:	70e2                	ld	ra,56(sp)
 b90:	7442                	ld	s0,48(sp)
 b92:	74a2                	ld	s1,40(sp)
 b94:	7902                	ld	s2,32(sp)
 b96:	69e2                	ld	s3,24(sp)
 b98:	6a42                	ld	s4,16(sp)
 b9a:	6aa2                	ld	s5,8(sp)
 b9c:	6b02                	ld	s6,0(sp)
 b9e:	6121                	addi	sp,sp,64
 ba0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ba2:	6398                	ld	a4,0(a5)
 ba4:	e118                	sd	a4,0(a0)
 ba6:	bff1                	j	b82 <malloc+0x8c>
  hp->s.size = nu;
 ba8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bac:	0541                	addi	a0,a0,16
 bae:	00000097          	auipc	ra,0x0
 bb2:	ec6080e7          	jalr	-314(ra) # a74 <free>
  return freep;
 bb6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bba:	d971                	beqz	a0,b8e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bbc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bbe:	4798                	lw	a4,8(a5)
 bc0:	fa9775e3          	bgeu	a4,s1,b6a <malloc+0x74>
    if(p == freep)
 bc4:	00093703          	ld	a4,0(s2)
 bc8:	853e                	mv	a0,a5
 bca:	fef719e3          	bne	a4,a5,bbc <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 bce:	854e                	mv	a0,s3
 bd0:	00000097          	auipc	ra,0x0
 bd4:	95e080e7          	jalr	-1698(ra) # 52e <sbrk>
  if(p == (char*)-1)
 bd8:	fd5518e3          	bne	a0,s5,ba8 <malloc+0xb2>
        return 0;
 bdc:	4501                	li	a0,0
 bde:	bf45                	j	b8e <malloc+0x98>
