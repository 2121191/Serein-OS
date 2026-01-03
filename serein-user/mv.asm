
serein-user/_mv：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/fcntl.h"
#include "kernel/include/param.h"
#include "serein-user/user.h"

int main(int argc, char *argv[])
{
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	24913c23          	sd	s1,600(sp)
  10:	25213823          	sd	s2,592(sp)
  14:	1c80                	addi	s0,sp,624
    if (argc < 3) {
  16:	4789                	li	a5,2
  18:	02a7c063          	blt	a5,a0,38 <main+0x38>
        fprintf(2, "Usage: mv old_name new_name\n");
  1c:	00001597          	auipc	a1,0x1
  20:	b6c58593          	addi	a1,a1,-1172 # b88 <malloc+0xee>
  24:	4509                	li	a0,2
  26:	00001097          	auipc	ra,0x1
  2a:	98e080e7          	jalr	-1650(ra) # 9b4 <fprintf>
        exit(1);
  2e:	4505                	li	a0,1
  30:	00000097          	auipc	ra,0x0
  34:	432080e7          	jalr	1074(ra) # 462 <exit>
  38:	84ae                	mv	s1,a1
    }

    char src[MAXPATH];
    char dst[MAXPATH];
    strcpy(src, argv[1]);
  3a:	658c                	ld	a1,8(a1)
  3c:	ed840513          	addi	a0,s0,-296
  40:	00000097          	auipc	ra,0x0
  44:	16a080e7          	jalr	362(ra) # 1aa <strcpy>
    strcpy(dst, argv[2]);
  48:	688c                	ld	a1,16(s1)
  4a:	dd040493          	addi	s1,s0,-560
  4e:	8526                	mv	a0,s1
  50:	00000097          	auipc	ra,0x0
  54:	15a080e7          	jalr	346(ra) # 1aa <strcpy>
    int fd = open(dst, O_RDONLY);
  58:	4581                	li	a1,0
  5a:	8526                	mv	a0,s1
  5c:	00000097          	auipc	ra,0x0
  60:	446080e7          	jalr	1094(ra) # 4a2 <open>
  64:	84aa                	mv	s1,a0
    if (fd >= 0) {
  66:	0e054763          	bltz	a0,154 <main+0x154>
        struct stat st;
        fstat(fd, &st);
  6a:	d9040593          	addi	a1,s0,-624
  6e:	00000097          	auipc	ra,0x0
  72:	43c080e7          	jalr	1084(ra) # 4aa <fstat>
        close(fd);
  76:	8526                	mv	a0,s1
  78:	00000097          	auipc	ra,0x0
  7c:	412080e7          	jalr	1042(ra) # 48a <close>
        if (st.type == T_DIR) {
  80:	db841703          	lh	a4,-584(s0)
  84:	4785                	li	a5,1
  86:	02f70263          	beq	a4,a5,aa <main+0xaa>
                    fprintf(2, "mv: fail! final dst path too long (exceed MAX=%d)!\n", MAXPATH);
                    exit(-1);
                }
            }
        } else {
            fprintf(2, "mv: fail! %s exists!\n", dst);
  8a:	dd040613          	addi	a2,s0,-560
  8e:	00001597          	auipc	a1,0x1
  92:	b5258593          	addi	a1,a1,-1198 # be0 <malloc+0x146>
  96:	4509                	li	a0,2
  98:	00001097          	auipc	ra,0x1
  9c:	91c080e7          	jalr	-1764(ra) # 9b4 <fprintf>
            exit(-1);
  a0:	557d                	li	a0,-1
  a2:	00000097          	auipc	ra,0x0
  a6:	3c0080e7          	jalr	960(ra) # 462 <exit>
            for (ps = src + strlen(src) - 1; ps >= src; ps--) { // trim '/' in tail
  aa:	ed840493          	addi	s1,s0,-296
  ae:	8526                	mv	a0,s1
  b0:	00000097          	auipc	ra,0x0
  b4:	170080e7          	jalr	368(ra) # 220 <strlen>
  b8:	02051793          	slli	a5,a0,0x20
  bc:	9381                	srli	a5,a5,0x20
  be:	17fd                	addi	a5,a5,-1
  c0:	97a6                	add	a5,a5,s1
  c2:	0297ec63          	bltu	a5,s1,fa <main+0xfa>
                if (*ps != '/') {
  c6:	02f00693          	li	a3,47
            for (ps = src + strlen(src) - 1; ps >= src; ps--) { // trim '/' in tail
  ca:	8626                	mv	a2,s1
                if (*ps != '/') {
  cc:	0007c703          	lbu	a4,0(a5)
  d0:	00d71663          	bne	a4,a3,dc <main+0xdc>
            for (ps = src + strlen(src) - 1; ps >= src; ps--) { // trim '/' in tail
  d4:	17fd                	addi	a5,a5,-1
  d6:	fec7fbe3          	bgeu	a5,a2,cc <main+0xcc>
  da:	a005                	j	fa <main+0xfa>
                    *(ps + 1) = '\0';
  dc:	000780a3          	sb	zero,1(a5)
            for (; ps >= src && *ps != '/'; ps--);
  e0:	02f00693          	li	a3,47
  e4:	ed840613          	addi	a2,s0,-296
  e8:	00c7e963          	bltu	a5,a2,fa <main+0xfa>
  ec:	0007c703          	lbu	a4,0(a5)
  f0:	00d70563          	beq	a4,a3,fa <main+0xfa>
  f4:	17fd                	addi	a5,a5,-1
  f6:	fec7fbe3          	bgeu	a5,a2,ec <main+0xec>
            ps++;
  fa:	00178493          	addi	s1,a5,1
            pd = dst + strlen(dst);
  fe:	dd040913          	addi	s2,s0,-560
 102:	854a                	mv	a0,s2
 104:	00000097          	auipc	ra,0x0
 108:	11c080e7          	jalr	284(ra) # 220 <strlen>
 10c:	1502                	slli	a0,a0,0x20
 10e:	9101                	srli	a0,a0,0x20
 110:	992a                	add	s2,s2,a0
            *pd++ = '/';
 112:	00190793          	addi	a5,s2,1
 116:	02f00713          	li	a4,47
 11a:	00e90023          	sb	a4,0(s2)
                if (pd >= dst + MAXPATH) {
 11e:	ed440693          	addi	a3,s0,-300
            while (*ps) {
 122:	0004c703          	lbu	a4,0(s1)
 126:	c71d                	beqz	a4,154 <main+0x154>
                *pd++ = *ps++;
 128:	0485                	addi	s1,s1,1
 12a:	0785                	addi	a5,a5,1
 12c:	fee78fa3          	sb	a4,-1(a5)
                if (pd >= dst + MAXPATH) {
 130:	fed7e9e3          	bltu	a5,a3,122 <main+0x122>
                    fprintf(2, "mv: fail! final dst path too long (exceed MAX=%d)!\n", MAXPATH);
 134:	10400613          	li	a2,260
 138:	00001597          	auipc	a1,0x1
 13c:	a7058593          	addi	a1,a1,-1424 # ba8 <malloc+0x10e>
 140:	4509                	li	a0,2
 142:	00001097          	auipc	ra,0x1
 146:	872080e7          	jalr	-1934(ra) # 9b4 <fprintf>
                    exit(-1);
 14a:	557d                	li	a0,-1
 14c:	00000097          	auipc	ra,0x0
 150:	316080e7          	jalr	790(ra) # 462 <exit>
        }
    }
    printf("moving [%s] to [%s]\n", src, dst);
 154:	dd040913          	addi	s2,s0,-560
 158:	864a                	mv	a2,s2
 15a:	ed840493          	addi	s1,s0,-296
 15e:	85a6                	mv	a1,s1
 160:	00001517          	auipc	a0,0x1
 164:	a9850513          	addi	a0,a0,-1384 # bf8 <malloc+0x15e>
 168:	00001097          	auipc	ra,0x1
 16c:	87a080e7          	jalr	-1926(ra) # 9e2 <printf>
    if (rename(src, dst) < 0) {
 170:	85ca                	mv	a1,s2
 172:	8526                	mv	a0,s1
 174:	00000097          	auipc	ra,0x0
 178:	3ae080e7          	jalr	942(ra) # 522 <rename>
 17c:	00054763          	bltz	a0,18a <main+0x18a>
        fprintf(2, "mv: fail to rename %s to %s!\n", src, dst);
        exit(-1);
    }
    exit(0);
 180:	4501                	li	a0,0
 182:	00000097          	auipc	ra,0x0
 186:	2e0080e7          	jalr	736(ra) # 462 <exit>
        fprintf(2, "mv: fail to rename %s to %s!\n", src, dst);
 18a:	86ca                	mv	a3,s2
 18c:	8626                	mv	a2,s1
 18e:	00001597          	auipc	a1,0x1
 192:	a8258593          	addi	a1,a1,-1406 # c10 <malloc+0x176>
 196:	4509                	li	a0,2
 198:	00001097          	auipc	ra,0x1
 19c:	81c080e7          	jalr	-2020(ra) # 9b4 <fprintf>
        exit(-1);
 1a0:	557d                	li	a0,-1
 1a2:	00000097          	auipc	ra,0x0
 1a6:	2c0080e7          	jalr	704(ra) # 462 <exit>

00000000000001aa <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	87aa                	mv	a5,a0
 1b2:	0585                	addi	a1,a1,1
 1b4:	0785                	addi	a5,a5,1
 1b6:	fff5c703          	lbu	a4,-1(a1)
 1ba:	fee78fa3          	sb	a4,-1(a5)
 1be:	fb75                	bnez	a4,1b2 <strcpy+0x8>
    ;
  return os;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret

00000000000001c6 <strcat>:

char*
strcat(char *s, const char *t)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	c385                	beqz	a5,1f0 <strcat+0x2a>
 1d2:	87aa                	mv	a5,a0
    s++;
 1d4:	0785                	addi	a5,a5,1
  while(*s)
 1d6:	0007c703          	lbu	a4,0(a5)
 1da:	ff6d                	bnez	a4,1d4 <strcat+0xe>
  while((*s++ = *t++))
 1dc:	0585                	addi	a1,a1,1
 1de:	0785                	addi	a5,a5,1
 1e0:	fff5c703          	lbu	a4,-1(a1)
 1e4:	fee78fa3          	sb	a4,-1(a5)
 1e8:	fb75                	bnez	a4,1dc <strcat+0x16>
    ;
  return os;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret
  while(*s)
 1f0:	87aa                	mv	a5,a0
 1f2:	b7ed                	j	1dc <strcat+0x16>

00000000000001f4 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e422                	sd	s0,8(sp)
 1f8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1fa:	00054783          	lbu	a5,0(a0)
 1fe:	cb91                	beqz	a5,212 <strcmp+0x1e>
 200:	0005c703          	lbu	a4,0(a1)
 204:	00f71763          	bne	a4,a5,212 <strcmp+0x1e>
    p++, q++;
 208:	0505                	addi	a0,a0,1
 20a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 20c:	00054783          	lbu	a5,0(a0)
 210:	fbe5                	bnez	a5,200 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 212:	0005c503          	lbu	a0,0(a1)
}
 216:	40a7853b          	subw	a0,a5,a0
 21a:	6422                	ld	s0,8(sp)
 21c:	0141                	addi	sp,sp,16
 21e:	8082                	ret

0000000000000220 <strlen>:

uint
strlen(const char *s)
{
 220:	1141                	addi	sp,sp,-16
 222:	e422                	sd	s0,8(sp)
 224:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 226:	00054783          	lbu	a5,0(a0)
 22a:	cf91                	beqz	a5,246 <strlen+0x26>
 22c:	0505                	addi	a0,a0,1
 22e:	87aa                	mv	a5,a0
 230:	4685                	li	a3,1
 232:	9e89                	subw	a3,a3,a0
 234:	00f6853b          	addw	a0,a3,a5
 238:	0785                	addi	a5,a5,1
 23a:	fff7c703          	lbu	a4,-1(a5)
 23e:	fb7d                	bnez	a4,234 <strlen+0x14>
    ;
  return n;
}
 240:	6422                	ld	s0,8(sp)
 242:	0141                	addi	sp,sp,16
 244:	8082                	ret
  for(n = 0; s[n]; n++)
 246:	4501                	li	a0,0
 248:	bfe5                	j	240 <strlen+0x20>

000000000000024a <memset>:

void*
memset(void *dst, int c, uint n)
{
 24a:	1141                	addi	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 250:	ca19                	beqz	a2,266 <memset+0x1c>
 252:	87aa                	mv	a5,a0
 254:	1602                	slli	a2,a2,0x20
 256:	9201                	srli	a2,a2,0x20
 258:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 25c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 260:	0785                	addi	a5,a5,1
 262:	fee79de3          	bne	a5,a4,25c <memset+0x12>
  }
  return dst;
}
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret

000000000000026c <strchr>:

char*
strchr(const char *s, char c)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	addi	s0,sp,16
  for(; *s; s++)
 272:	00054783          	lbu	a5,0(a0)
 276:	cb99                	beqz	a5,28c <strchr+0x20>
    if(*s == c)
 278:	00f58763          	beq	a1,a5,286 <strchr+0x1a>
  for(; *s; s++)
 27c:	0505                	addi	a0,a0,1
 27e:	00054783          	lbu	a5,0(a0)
 282:	fbfd                	bnez	a5,278 <strchr+0xc>
      return (char*)s;
  return 0;
 284:	4501                	li	a0,0
}
 286:	6422                	ld	s0,8(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
  return 0;
 28c:	4501                	li	a0,0
 28e:	bfe5                	j	286 <strchr+0x1a>

0000000000000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	711d                	addi	sp,sp,-96
 292:	ec86                	sd	ra,88(sp)
 294:	e8a2                	sd	s0,80(sp)
 296:	e4a6                	sd	s1,72(sp)
 298:	e0ca                	sd	s2,64(sp)
 29a:	fc4e                	sd	s3,56(sp)
 29c:	f852                	sd	s4,48(sp)
 29e:	f456                	sd	s5,40(sp)
 2a0:	f05a                	sd	s6,32(sp)
 2a2:	ec5e                	sd	s7,24(sp)
 2a4:	e862                	sd	s8,16(sp)
 2a6:	1080                	addi	s0,sp,96
 2a8:	8baa                	mv	s7,a0
 2aa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ac:	892a                	mv	s2,a0
 2ae:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2b0:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b4:	4b29                	li	s6,10
 2b6:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2b8:	89a6                	mv	s3,s1
 2ba:	2485                	addiw	s1,s1,1
 2bc:	0344d763          	bge	s1,s4,2ea <gets+0x5a>
    cc = read(0, &c, 1);
 2c0:	4605                	li	a2,1
 2c2:	85d6                	mv	a1,s5
 2c4:	4501                	li	a0,0
 2c6:	00000097          	auipc	ra,0x0
 2ca:	1b4080e7          	jalr	436(ra) # 47a <read>
    if(cc < 1)
 2ce:	00a05e63          	blez	a0,2ea <gets+0x5a>
    buf[i++] = c;
 2d2:	faf44783          	lbu	a5,-81(s0)
 2d6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2da:	01678763          	beq	a5,s6,2e8 <gets+0x58>
 2de:	0905                	addi	s2,s2,1
 2e0:	fd879ce3          	bne	a5,s8,2b8 <gets+0x28>
  for(i=0; i+1 < max; ){
 2e4:	89a6                	mv	s3,s1
 2e6:	a011                	j	2ea <gets+0x5a>
 2e8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ea:	99de                	add	s3,s3,s7
 2ec:	00098023          	sb	zero,0(s3)
  return buf;
}
 2f0:	855e                	mv	a0,s7
 2f2:	60e6                	ld	ra,88(sp)
 2f4:	6446                	ld	s0,80(sp)
 2f6:	64a6                	ld	s1,72(sp)
 2f8:	6906                	ld	s2,64(sp)
 2fa:	79e2                	ld	s3,56(sp)
 2fc:	7a42                	ld	s4,48(sp)
 2fe:	7aa2                	ld	s5,40(sp)
 300:	7b02                	ld	s6,32(sp)
 302:	6be2                	ld	s7,24(sp)
 304:	6c42                	ld	s8,16(sp)
 306:	6125                	addi	sp,sp,96
 308:	8082                	ret

000000000000030a <stat>:

int
stat(const char *n, struct stat *st)
{
 30a:	1101                	addi	sp,sp,-32
 30c:	ec06                	sd	ra,24(sp)
 30e:	e822                	sd	s0,16(sp)
 310:	e426                	sd	s1,8(sp)
 312:	e04a                	sd	s2,0(sp)
 314:	1000                	addi	s0,sp,32
 316:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 318:	4581                	li	a1,0
 31a:	00000097          	auipc	ra,0x0
 31e:	188080e7          	jalr	392(ra) # 4a2 <open>
  if(fd < 0)
 322:	02054563          	bltz	a0,34c <stat+0x42>
 326:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 328:	85ca                	mv	a1,s2
 32a:	00000097          	auipc	ra,0x0
 32e:	180080e7          	jalr	384(ra) # 4aa <fstat>
 332:	892a                	mv	s2,a0
  close(fd);
 334:	8526                	mv	a0,s1
 336:	00000097          	auipc	ra,0x0
 33a:	154080e7          	jalr	340(ra) # 48a <close>
  return r;
}
 33e:	854a                	mv	a0,s2
 340:	60e2                	ld	ra,24(sp)
 342:	6442                	ld	s0,16(sp)
 344:	64a2                	ld	s1,8(sp)
 346:	6902                	ld	s2,0(sp)
 348:	6105                	addi	sp,sp,32
 34a:	8082                	ret
    return -1;
 34c:	597d                	li	s2,-1
 34e:	bfc5                	j	33e <stat+0x34>

0000000000000350 <atoi>:

int
atoi(const char *s)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 356:	00054703          	lbu	a4,0(a0)
 35a:	02d00793          	li	a5,45
  int neg = 1;
 35e:	4585                	li	a1,1
  if (*s == '-') {
 360:	04f70363          	beq	a4,a5,3a6 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 364:	00054703          	lbu	a4,0(a0)
 368:	fd07079b          	addiw	a5,a4,-48
 36c:	0ff7f793          	zext.b	a5,a5
 370:	46a5                	li	a3,9
 372:	02f6ed63          	bltu	a3,a5,3ac <atoi+0x5c>
  n = 0;
 376:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 378:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 37a:	0505                	addi	a0,a0,1
 37c:	0026979b          	slliw	a5,a3,0x2
 380:	9fb5                	addw	a5,a5,a3
 382:	0017979b          	slliw	a5,a5,0x1
 386:	9fb9                	addw	a5,a5,a4
 388:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 38c:	00054703          	lbu	a4,0(a0)
 390:	fd07079b          	addiw	a5,a4,-48
 394:	0ff7f793          	zext.b	a5,a5
 398:	fef671e3          	bgeu	a2,a5,37a <atoi+0x2a>
  return n * neg;
}
 39c:	02d5853b          	mulw	a0,a1,a3
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret
    s++;
 3a6:	0505                	addi	a0,a0,1
    neg = -1;
 3a8:	55fd                	li	a1,-1
 3aa:	bf6d                	j	364 <atoi+0x14>
  n = 0;
 3ac:	4681                	li	a3,0
 3ae:	b7fd                	j	39c <atoi+0x4c>

00000000000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	1141                	addi	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b6:	02b57463          	bgeu	a0,a1,3de <memmove+0x2e>
    while(n-- > 0)
 3ba:	00c05f63          	blez	a2,3d8 <memmove+0x28>
 3be:	1602                	slli	a2,a2,0x20
 3c0:	9201                	srli	a2,a2,0x20
 3c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 3c8:	0585                	addi	a1,a1,1
 3ca:	0705                	addi	a4,a4,1
 3cc:	fff5c683          	lbu	a3,-1(a1)
 3d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d4:	fee79ae3          	bne	a5,a4,3c8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3d8:	6422                	ld	s0,8(sp)
 3da:	0141                	addi	sp,sp,16
 3dc:	8082                	ret
    dst += n;
 3de:	00c50733          	add	a4,a0,a2
    src += n;
 3e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e4:	fec05ae3          	blez	a2,3d8 <memmove+0x28>
 3e8:	fff6079b          	addiw	a5,a2,-1
 3ec:	1782                	slli	a5,a5,0x20
 3ee:	9381                	srli	a5,a5,0x20
 3f0:	fff7c793          	not	a5,a5
 3f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f6:	15fd                	addi	a1,a1,-1
 3f8:	177d                	addi	a4,a4,-1
 3fa:	0005c683          	lbu	a3,0(a1)
 3fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 402:	fee79ae3          	bne	a5,a4,3f6 <memmove+0x46>
 406:	bfc9                	j	3d8 <memmove+0x28>

0000000000000408 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 408:	1141                	addi	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 40e:	ca05                	beqz	a2,43e <memcmp+0x36>
 410:	fff6069b          	addiw	a3,a2,-1
 414:	1682                	slli	a3,a3,0x20
 416:	9281                	srli	a3,a3,0x20
 418:	0685                	addi	a3,a3,1
 41a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 41c:	00054783          	lbu	a5,0(a0)
 420:	0005c703          	lbu	a4,0(a1)
 424:	00e79863          	bne	a5,a4,434 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 428:	0505                	addi	a0,a0,1
    p2++;
 42a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 42c:	fed518e3          	bne	a0,a3,41c <memcmp+0x14>
  }
  return 0;
 430:	4501                	li	a0,0
 432:	a019                	j	438 <memcmp+0x30>
      return *p1 - *p2;
 434:	40e7853b          	subw	a0,a5,a4
}
 438:	6422                	ld	s0,8(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret
  return 0;
 43e:	4501                	li	a0,0
 440:	bfe5                	j	438 <memcmp+0x30>

0000000000000442 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 442:	1141                	addi	sp,sp,-16
 444:	e406                	sd	ra,8(sp)
 446:	e022                	sd	s0,0(sp)
 448:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 44a:	00000097          	auipc	ra,0x0
 44e:	f66080e7          	jalr	-154(ra) # 3b0 <memmove>
}
 452:	60a2                	ld	ra,8(sp)
 454:	6402                	ld	s0,0(sp)
 456:	0141                	addi	sp,sp,16
 458:	8082                	ret

000000000000045a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 45a:	4885                	li	a7,1
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <exit>:
.global exit
exit:
 li a7, SYS_exit
 462:	4889                	li	a7,2
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <wait>:
.global wait
wait:
 li a7, SYS_wait
 46a:	488d                	li	a7,3
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 472:	4891                	li	a7,4
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <read>:
.global read
read:
 li a7, SYS_read
 47a:	4895                	li	a7,5
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <write>:
.global write
write:
 li a7, SYS_write
 482:	48c1                	li	a7,16
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <close>:
.global close
close:
 li a7, SYS_close
 48a:	48d5                	li	a7,21
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <kill>:
.global kill
kill:
 li a7, SYS_kill
 492:	4899                	li	a7,6
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <exec>:
.global exec
exec:
 li a7, SYS_exec
 49a:	489d                	li	a7,7
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <open>:
.global open
open:
 li a7, SYS_open
 4a2:	48bd                	li	a7,15
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4aa:	48a1                	li	a7,8
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b2:	48d1                	li	a7,20
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4ba:	48a5                	li	a7,9
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c2:	48a9                	li	a7,10
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4ca:	48ad                	li	a7,11
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4d2:	48b1                	li	a7,12
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4da:	48b5                	li	a7,13
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e2:	48b9                	li	a7,14
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 4ea:	48d9                	li	a7,22
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <dev>:
.global dev
dev:
 li a7, SYS_dev
 4f2:	48dd                	li	a7,23
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4fa:	48e1                	li	a7,24
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 502:	48e5                	li	a7,25
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <remove>:
.global remove
remove:
 li a7, SYS_remove
 50a:	48c5                	li	a7,17
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <trace>:
.global trace
trace:
 li a7, SYS_trace
 512:	48c9                	li	a7,18
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 51a:	48cd                	li	a7,19
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <rename>:
.global rename
rename:
 li a7, SYS_rename
 522:	48e9                	li	a7,26
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 52a:	48ed                	li	a7,27
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 532:	48f1                	li	a7,28
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 53a:	48f5                	li	a7,29
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 542:	48f9                	li	a7,30
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 54a:	48fd                	li	a7,31
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 552:	02000893          	li	a7,32
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 55c:	02100893          	li	a7,33
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 566:	02200893          	li	a7,34
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 570:	02300893          	li	a7,35
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 57a:	02400893          	li	a7,36
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 584:	02500893          	li	a7,37
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 58e:	02600893          	li	a7,38
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 598:	02700893          	li	a7,39
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 5a2:	02800893          	li	a7,40
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 5ac:	02900893          	li	a7,41
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 5b6:	02a00893          	li	a7,42
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 5c0:	02b00893          	li	a7,43
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 5ca:	02c00893          	li	a7,44
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 5d4:	02d00893          	li	a7,45
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 5de:	02e00893          	li	a7,46
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 5e8:	02f00893          	li	a7,47
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 5f2:	03000893          	li	a7,48
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 5fc:	03100893          	li	a7,49
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 606:	03200893          	li	a7,50
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 610:	03300893          	li	a7,51
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 61a:	03400893          	li	a7,52
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 624:	03500893          	li	a7,53
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 62e:	03600893          	li	a7,54
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 638:	03700893          	li	a7,55
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 642:	03800893          	li	a7,56
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 64c:	03900893          	li	a7,57
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 656:	03a00893          	li	a7,58
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <poll>:
.global poll
poll:
 li a7, SYS_poll
 660:	03b00893          	li	a7,59
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 66a:	03c00893          	li	a7,60
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 674:	03d00893          	li	a7,61
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 67e:	03e00893          	li	a7,62
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <clone>:
.global clone
clone:
 li a7, SYS_clone
 688:	03f00893          	li	a7,63
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <futex>:
.global futex
futex:
 li a7, SYS_futex
 692:	04000893          	li	a7,64
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 69c:	04100893          	li	a7,65
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <halt>:
.global halt
halt:
 li a7, SYS_halt
 6a6:	04200893          	li	a7,66
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 6b0:	04300893          	li	a7,67
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <socket>:
.global socket
socket:
 li a7, SYS_socket
 6ba:	04400893          	li	a7,68
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6c4:	04500893          	li	a7,69
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <listen>:
.global listen
listen:
 li a7, SYS_listen
 6ce:	04600893          	li	a7,70
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <accept>:
.global accept
accept:
 li a7, SYS_accept
 6d8:	04700893          	li	a7,71
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <connect>:
.global connect
connect:
 li a7, SYS_connect
 6e2:	04800893          	li	a7,72
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <send>:
.global send
send:
 li a7, SYS_send
 6ec:	04900893          	li	a7,73
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6f6:	04a00893          	li	a7,74
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 700:	04b00893          	li	a7,75
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 70a:	1101                	addi	sp,sp,-32
 70c:	ec06                	sd	ra,24(sp)
 70e:	e822                	sd	s0,16(sp)
 710:	1000                	addi	s0,sp,32
 712:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 716:	4605                	li	a2,1
 718:	fef40593          	addi	a1,s0,-17
 71c:	00000097          	auipc	ra,0x0
 720:	d66080e7          	jalr	-666(ra) # 482 <write>
}
 724:	60e2                	ld	ra,24(sp)
 726:	6442                	ld	s0,16(sp)
 728:	6105                	addi	sp,sp,32
 72a:	8082                	ret

000000000000072c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 72c:	7139                	addi	sp,sp,-64
 72e:	fc06                	sd	ra,56(sp)
 730:	f822                	sd	s0,48(sp)
 732:	f426                	sd	s1,40(sp)
 734:	f04a                	sd	s2,32(sp)
 736:	ec4e                	sd	s3,24(sp)
 738:	0080                	addi	s0,sp,64
 73a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 73c:	c299                	beqz	a3,742 <printint+0x16>
 73e:	0805c863          	bltz	a1,7ce <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 742:	2581                	sext.w	a1,a1
  neg = 0;
 744:	4881                	li	a7,0
  }

  i = 0;
 746:	fc040993          	addi	s3,s0,-64
  neg = 0;
 74a:	86ce                	mv	a3,s3
  i = 0;
 74c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 74e:	2601                	sext.w	a2,a2
 750:	00000517          	auipc	a0,0x0
 754:	54050513          	addi	a0,a0,1344 # c90 <digits>
 758:	883a                	mv	a6,a4
 75a:	2705                	addiw	a4,a4,1
 75c:	02c5f7bb          	remuw	a5,a1,a2
 760:	1782                	slli	a5,a5,0x20
 762:	9381                	srli	a5,a5,0x20
 764:	97aa                	add	a5,a5,a0
 766:	0007c783          	lbu	a5,0(a5)
 76a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 76e:	0005879b          	sext.w	a5,a1
 772:	02c5d5bb          	divuw	a1,a1,a2
 776:	0685                	addi	a3,a3,1
 778:	fec7f0e3          	bgeu	a5,a2,758 <printint+0x2c>
  if(neg)
 77c:	00088c63          	beqz	a7,794 <printint+0x68>
    buf[i++] = '-';
 780:	fd070793          	addi	a5,a4,-48
 784:	00878733          	add	a4,a5,s0
 788:	02d00793          	li	a5,45
 78c:	fef70823          	sb	a5,-16(a4)
 790:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 794:	02e05663          	blez	a4,7c0 <printint+0x94>
 798:	fc040913          	addi	s2,s0,-64
 79c:	993a                	add	s2,s2,a4
 79e:	19fd                	addi	s3,s3,-1
 7a0:	99ba                	add	s3,s3,a4
 7a2:	377d                	addiw	a4,a4,-1
 7a4:	1702                	slli	a4,a4,0x20
 7a6:	9301                	srli	a4,a4,0x20
 7a8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7ac:	fff94583          	lbu	a1,-1(s2)
 7b0:	8526                	mv	a0,s1
 7b2:	00000097          	auipc	ra,0x0
 7b6:	f58080e7          	jalr	-168(ra) # 70a <putc>
  while(--i >= 0)
 7ba:	197d                	addi	s2,s2,-1
 7bc:	ff3918e3          	bne	s2,s3,7ac <printint+0x80>
}
 7c0:	70e2                	ld	ra,56(sp)
 7c2:	7442                	ld	s0,48(sp)
 7c4:	74a2                	ld	s1,40(sp)
 7c6:	7902                	ld	s2,32(sp)
 7c8:	69e2                	ld	s3,24(sp)
 7ca:	6121                	addi	sp,sp,64
 7cc:	8082                	ret
    x = -xx;
 7ce:	40b005bb          	negw	a1,a1
    neg = 1;
 7d2:	4885                	li	a7,1
    x = -xx;
 7d4:	bf8d                	j	746 <printint+0x1a>

00000000000007d6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7d6:	7119                	addi	sp,sp,-128
 7d8:	fc86                	sd	ra,120(sp)
 7da:	f8a2                	sd	s0,112(sp)
 7dc:	f4a6                	sd	s1,104(sp)
 7de:	f0ca                	sd	s2,96(sp)
 7e0:	ecce                	sd	s3,88(sp)
 7e2:	e8d2                	sd	s4,80(sp)
 7e4:	e4d6                	sd	s5,72(sp)
 7e6:	e0da                	sd	s6,64(sp)
 7e8:	fc5e                	sd	s7,56(sp)
 7ea:	f862                	sd	s8,48(sp)
 7ec:	f466                	sd	s9,40(sp)
 7ee:	f06a                	sd	s10,32(sp)
 7f0:	ec6e                	sd	s11,24(sp)
 7f2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7f4:	0005c903          	lbu	s2,0(a1)
 7f8:	18090f63          	beqz	s2,996 <vprintf+0x1c0>
 7fc:	8aaa                	mv	s5,a0
 7fe:	8b32                	mv	s6,a2
 800:	00158493          	addi	s1,a1,1
  state = 0;
 804:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 806:	02500a13          	li	s4,37
 80a:	4c55                	li	s8,21
 80c:	00000c97          	auipc	s9,0x0
 810:	42cc8c93          	addi	s9,s9,1068 # c38 <malloc+0x19e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 814:	02800d93          	li	s11,40
  putc(fd, 'x');
 818:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 81a:	00000b97          	auipc	s7,0x0
 81e:	476b8b93          	addi	s7,s7,1142 # c90 <digits>
 822:	a839                	j	840 <vprintf+0x6a>
        putc(fd, c);
 824:	85ca                	mv	a1,s2
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	ee2080e7          	jalr	-286(ra) # 70a <putc>
 830:	a019                	j	836 <vprintf+0x60>
    } else if(state == '%'){
 832:	01498d63          	beq	s3,s4,84c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 836:	0485                	addi	s1,s1,1
 838:	fff4c903          	lbu	s2,-1(s1)
 83c:	14090d63          	beqz	s2,996 <vprintf+0x1c0>
    if(state == 0){
 840:	fe0999e3          	bnez	s3,832 <vprintf+0x5c>
      if(c == '%'){
 844:	ff4910e3          	bne	s2,s4,824 <vprintf+0x4e>
        state = '%';
 848:	89d2                	mv	s3,s4
 84a:	b7f5                	j	836 <vprintf+0x60>
      if(c == 'd'){
 84c:	11490c63          	beq	s2,s4,964 <vprintf+0x18e>
 850:	f9d9079b          	addiw	a5,s2,-99
 854:	0ff7f793          	zext.b	a5,a5
 858:	10fc6e63          	bltu	s8,a5,974 <vprintf+0x19e>
 85c:	f9d9079b          	addiw	a5,s2,-99
 860:	0ff7f713          	zext.b	a4,a5
 864:	10ec6863          	bltu	s8,a4,974 <vprintf+0x19e>
 868:	00271793          	slli	a5,a4,0x2
 86c:	97e6                	add	a5,a5,s9
 86e:	439c                	lw	a5,0(a5)
 870:	97e6                	add	a5,a5,s9
 872:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 874:	008b0913          	addi	s2,s6,8
 878:	4685                	li	a3,1
 87a:	4629                	li	a2,10
 87c:	000b2583          	lw	a1,0(s6)
 880:	8556                	mv	a0,s5
 882:	00000097          	auipc	ra,0x0
 886:	eaa080e7          	jalr	-342(ra) # 72c <printint>
 88a:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b765                	j	836 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 890:	008b0913          	addi	s2,s6,8
 894:	4681                	li	a3,0
 896:	4629                	li	a2,10
 898:	000b2583          	lw	a1,0(s6)
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	e8e080e7          	jalr	-370(ra) # 72c <printint>
 8a6:	8b4a                	mv	s6,s2
      state = 0;
 8a8:	4981                	li	s3,0
 8aa:	b771                	j	836 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8ac:	008b0913          	addi	s2,s6,8
 8b0:	4681                	li	a3,0
 8b2:	866a                	mv	a2,s10
 8b4:	000b2583          	lw	a1,0(s6)
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	e72080e7          	jalr	-398(ra) # 72c <printint>
 8c2:	8b4a                	mv	s6,s2
      state = 0;
 8c4:	4981                	li	s3,0
 8c6:	bf85                	j	836 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8c8:	008b0793          	addi	a5,s6,8
 8cc:	f8f43423          	sd	a5,-120(s0)
 8d0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8d4:	03000593          	li	a1,48
 8d8:	8556                	mv	a0,s5
 8da:	00000097          	auipc	ra,0x0
 8de:	e30080e7          	jalr	-464(ra) # 70a <putc>
  putc(fd, 'x');
 8e2:	07800593          	li	a1,120
 8e6:	8556                	mv	a0,s5
 8e8:	00000097          	auipc	ra,0x0
 8ec:	e22080e7          	jalr	-478(ra) # 70a <putc>
 8f0:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f2:	03c9d793          	srli	a5,s3,0x3c
 8f6:	97de                	add	a5,a5,s7
 8f8:	0007c583          	lbu	a1,0(a5)
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	e0c080e7          	jalr	-500(ra) # 70a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 906:	0992                	slli	s3,s3,0x4
 908:	397d                	addiw	s2,s2,-1
 90a:	fe0914e3          	bnez	s2,8f2 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 90e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 912:	4981                	li	s3,0
 914:	b70d                	j	836 <vprintf+0x60>
        s = va_arg(ap, char*);
 916:	008b0913          	addi	s2,s6,8
 91a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 91e:	02098163          	beqz	s3,940 <vprintf+0x16a>
        while(*s != 0){
 922:	0009c583          	lbu	a1,0(s3)
 926:	c5ad                	beqz	a1,990 <vprintf+0x1ba>
          putc(fd, *s);
 928:	8556                	mv	a0,s5
 92a:	00000097          	auipc	ra,0x0
 92e:	de0080e7          	jalr	-544(ra) # 70a <putc>
          s++;
 932:	0985                	addi	s3,s3,1
        while(*s != 0){
 934:	0009c583          	lbu	a1,0(s3)
 938:	f9e5                	bnez	a1,928 <vprintf+0x152>
        s = va_arg(ap, char*);
 93a:	8b4a                	mv	s6,s2
      state = 0;
 93c:	4981                	li	s3,0
 93e:	bde5                	j	836 <vprintf+0x60>
          s = "(null)";
 940:	00000997          	auipc	s3,0x0
 944:	2f098993          	addi	s3,s3,752 # c30 <malloc+0x196>
        while(*s != 0){
 948:	85ee                	mv	a1,s11
 94a:	bff9                	j	928 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 94c:	008b0913          	addi	s2,s6,8
 950:	000b4583          	lbu	a1,0(s6)
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	db4080e7          	jalr	-588(ra) # 70a <putc>
 95e:	8b4a                	mv	s6,s2
      state = 0;
 960:	4981                	li	s3,0
 962:	bdd1                	j	836 <vprintf+0x60>
        putc(fd, c);
 964:	85d2                	mv	a1,s4
 966:	8556                	mv	a0,s5
 968:	00000097          	auipc	ra,0x0
 96c:	da2080e7          	jalr	-606(ra) # 70a <putc>
      state = 0;
 970:	4981                	li	s3,0
 972:	b5d1                	j	836 <vprintf+0x60>
        putc(fd, '%');
 974:	85d2                	mv	a1,s4
 976:	8556                	mv	a0,s5
 978:	00000097          	auipc	ra,0x0
 97c:	d92080e7          	jalr	-622(ra) # 70a <putc>
        putc(fd, c);
 980:	85ca                	mv	a1,s2
 982:	8556                	mv	a0,s5
 984:	00000097          	auipc	ra,0x0
 988:	d86080e7          	jalr	-634(ra) # 70a <putc>
      state = 0;
 98c:	4981                	li	s3,0
 98e:	b565                	j	836 <vprintf+0x60>
        s = va_arg(ap, char*);
 990:	8b4a                	mv	s6,s2
      state = 0;
 992:	4981                	li	s3,0
 994:	b54d                	j	836 <vprintf+0x60>
    }
  }
}
 996:	70e6                	ld	ra,120(sp)
 998:	7446                	ld	s0,112(sp)
 99a:	74a6                	ld	s1,104(sp)
 99c:	7906                	ld	s2,96(sp)
 99e:	69e6                	ld	s3,88(sp)
 9a0:	6a46                	ld	s4,80(sp)
 9a2:	6aa6                	ld	s5,72(sp)
 9a4:	6b06                	ld	s6,64(sp)
 9a6:	7be2                	ld	s7,56(sp)
 9a8:	7c42                	ld	s8,48(sp)
 9aa:	7ca2                	ld	s9,40(sp)
 9ac:	7d02                	ld	s10,32(sp)
 9ae:	6de2                	ld	s11,24(sp)
 9b0:	6109                	addi	sp,sp,128
 9b2:	8082                	ret

00000000000009b4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9b4:	715d                	addi	sp,sp,-80
 9b6:	ec06                	sd	ra,24(sp)
 9b8:	e822                	sd	s0,16(sp)
 9ba:	1000                	addi	s0,sp,32
 9bc:	e010                	sd	a2,0(s0)
 9be:	e414                	sd	a3,8(s0)
 9c0:	e818                	sd	a4,16(s0)
 9c2:	ec1c                	sd	a5,24(s0)
 9c4:	03043023          	sd	a6,32(s0)
 9c8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9cc:	8622                	mv	a2,s0
 9ce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9d2:	00000097          	auipc	ra,0x0
 9d6:	e04080e7          	jalr	-508(ra) # 7d6 <vprintf>
}
 9da:	60e2                	ld	ra,24(sp)
 9dc:	6442                	ld	s0,16(sp)
 9de:	6161                	addi	sp,sp,80
 9e0:	8082                	ret

00000000000009e2 <printf>:

void
printf(const char *fmt, ...)
{
 9e2:	711d                	addi	sp,sp,-96
 9e4:	ec06                	sd	ra,24(sp)
 9e6:	e822                	sd	s0,16(sp)
 9e8:	1000                	addi	s0,sp,32
 9ea:	e40c                	sd	a1,8(s0)
 9ec:	e810                	sd	a2,16(s0)
 9ee:	ec14                	sd	a3,24(s0)
 9f0:	f018                	sd	a4,32(s0)
 9f2:	f41c                	sd	a5,40(s0)
 9f4:	03043823          	sd	a6,48(s0)
 9f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9fc:	00840613          	addi	a2,s0,8
 a00:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a04:	85aa                	mv	a1,a0
 a06:	4505                	li	a0,1
 a08:	00000097          	auipc	ra,0x0
 a0c:	dce080e7          	jalr	-562(ra) # 7d6 <vprintf>
}
 a10:	60e2                	ld	ra,24(sp)
 a12:	6442                	ld	s0,16(sp)
 a14:	6125                	addi	sp,sp,96
 a16:	8082                	ret

0000000000000a18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a18:	1141                	addi	sp,sp,-16
 a1a:	e422                	sd	s0,8(sp)
 a1c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a1e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a22:	00000797          	auipc	a5,0x0
 a26:	2867b783          	ld	a5,646(a5) # ca8 <freep>
 a2a:	a02d                	j	a54 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a2c:	4618                	lw	a4,8(a2)
 a2e:	9f2d                	addw	a4,a4,a1
 a30:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a34:	6398                	ld	a4,0(a5)
 a36:	6310                	ld	a2,0(a4)
 a38:	a83d                	j	a76 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a3a:	ff852703          	lw	a4,-8(a0)
 a3e:	9f31                	addw	a4,a4,a2
 a40:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a42:	ff053683          	ld	a3,-16(a0)
 a46:	a091                	j	a8a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a48:	6398                	ld	a4,0(a5)
 a4a:	00e7e463          	bltu	a5,a4,a52 <free+0x3a>
 a4e:	00e6ea63          	bltu	a3,a4,a62 <free+0x4a>
{
 a52:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a54:	fed7fae3          	bgeu	a5,a3,a48 <free+0x30>
 a58:	6398                	ld	a4,0(a5)
 a5a:	00e6e463          	bltu	a3,a4,a62 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5e:	fee7eae3          	bltu	a5,a4,a52 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a62:	ff852583          	lw	a1,-8(a0)
 a66:	6390                	ld	a2,0(a5)
 a68:	02059813          	slli	a6,a1,0x20
 a6c:	01c85713          	srli	a4,a6,0x1c
 a70:	9736                	add	a4,a4,a3
 a72:	fae60de3          	beq	a2,a4,a2c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a76:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a7a:	4790                	lw	a2,8(a5)
 a7c:	02061593          	slli	a1,a2,0x20
 a80:	01c5d713          	srli	a4,a1,0x1c
 a84:	973e                	add	a4,a4,a5
 a86:	fae68ae3          	beq	a3,a4,a3a <free+0x22>
    p->s.ptr = bp->s.ptr;
 a8a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a8c:	00000717          	auipc	a4,0x0
 a90:	20f73e23          	sd	a5,540(a4) # ca8 <freep>
}
 a94:	6422                	ld	s0,8(sp)
 a96:	0141                	addi	sp,sp,16
 a98:	8082                	ret

0000000000000a9a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a9a:	7139                	addi	sp,sp,-64
 a9c:	fc06                	sd	ra,56(sp)
 a9e:	f822                	sd	s0,48(sp)
 aa0:	f426                	sd	s1,40(sp)
 aa2:	f04a                	sd	s2,32(sp)
 aa4:	ec4e                	sd	s3,24(sp)
 aa6:	e852                	sd	s4,16(sp)
 aa8:	e456                	sd	s5,8(sp)
 aaa:	e05a                	sd	s6,0(sp)
 aac:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aae:	02051493          	slli	s1,a0,0x20
 ab2:	9081                	srli	s1,s1,0x20
 ab4:	04bd                	addi	s1,s1,15
 ab6:	8091                	srli	s1,s1,0x4
 ab8:	00148a1b          	addiw	s4,s1,1
 abc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 abe:	00000517          	auipc	a0,0x0
 ac2:	1ea53503          	ld	a0,490(a0) # ca8 <freep>
 ac6:	c515                	beqz	a0,af2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aca:	4798                	lw	a4,8(a5)
 acc:	04977163          	bgeu	a4,s1,b0e <malloc+0x74>
 ad0:	89d2                	mv	s3,s4
 ad2:	000a071b          	sext.w	a4,s4
 ad6:	6685                	lui	a3,0x1
 ad8:	00d77363          	bgeu	a4,a3,ade <malloc+0x44>
 adc:	6985                	lui	s3,0x1
 ade:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 ae2:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae6:	00000917          	auipc	s2,0x0
 aea:	1c290913          	addi	s2,s2,450 # ca8 <freep>
  if(p == (char*)-1)
 aee:	5afd                	li	s5,-1
 af0:	a8a5                	j	b68 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 af2:	00000797          	auipc	a5,0x0
 af6:	1b678793          	addi	a5,a5,438 # ca8 <freep>
 afa:	00000717          	auipc	a4,0x0
 afe:	1b670713          	addi	a4,a4,438 # cb0 <base>
 b02:	e398                	sd	a4,0(a5)
 b04:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 b06:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0a:	87ba                	mv	a5,a4
 b0c:	b7d1                	j	ad0 <malloc+0x36>
      if(p->s.size == nunits)
 b0e:	02e48c63          	beq	s1,a4,b46 <malloc+0xac>
        p->s.size -= nunits;
 b12:	4147073b          	subw	a4,a4,s4
 b16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b18:	02071693          	slli	a3,a4,0x20
 b1c:	01c6d713          	srli	a4,a3,0x1c
 b20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b22:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 b26:	00000717          	auipc	a4,0x0
 b2a:	18a73123          	sd	a0,386(a4) # ca8 <freep>
      return (void*)(p + 1);
 b2e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b32:	70e2                	ld	ra,56(sp)
 b34:	7442                	ld	s0,48(sp)
 b36:	74a2                	ld	s1,40(sp)
 b38:	7902                	ld	s2,32(sp)
 b3a:	69e2                	ld	s3,24(sp)
 b3c:	6a42                	ld	s4,16(sp)
 b3e:	6aa2                	ld	s5,8(sp)
 b40:	6b02                	ld	s6,0(sp)
 b42:	6121                	addi	sp,sp,64
 b44:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b46:	6398                	ld	a4,0(a5)
 b48:	e118                	sd	a4,0(a0)
 b4a:	bff1                	j	b26 <malloc+0x8c>
  hp->s.size = nu;
 b4c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b50:	0541                	addi	a0,a0,16
 b52:	00000097          	auipc	ra,0x0
 b56:	ec6080e7          	jalr	-314(ra) # a18 <free>
  return freep;
 b5a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b5e:	d971                	beqz	a0,b32 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b60:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b62:	4798                	lw	a4,8(a5)
 b64:	fa9775e3          	bgeu	a4,s1,b0e <malloc+0x74>
    if(p == freep)
 b68:	00093703          	ld	a4,0(s2)
 b6c:	853e                	mv	a0,a5
 b6e:	fef719e3          	bne	a4,a5,b60 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 b72:	854e                	mv	a0,s3
 b74:	00000097          	auipc	ra,0x0
 b78:	95e080e7          	jalr	-1698(ra) # 4d2 <sbrk>
  if(p == (char*)-1)
 b7c:	fd5518e3          	bne	a0,s5,b4c <malloc+0xb2>
        return 0;
 b80:	4501                	li	a0,0
 b82:	bf45                	j	b32 <malloc+0x98>
