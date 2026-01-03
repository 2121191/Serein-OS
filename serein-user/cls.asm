
serein-user/_cls：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/types.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  // 创建一个局部字符数组，包含 ANSI 转义序列
  // 0x1b 是 ESC 键的 ASCII 码（27）
  // "[2J" 是清除整个屏幕的 ANSI 转义码
  // "[H" 是将光标移动到左上角（1行1列）的 ANSI 转义码
  // '\n' 是换行符（回车），将光标移动到下一行行首
  char seq[] = {0x1b,'[','2','J', 0x1b,'[','H', '\n'};
   8:	00001797          	auipc	a5,0x1
   c:	a007b783          	ld	a5,-1536(a5) # a08 <malloc+0xea>
  10:	fef43423          	sd	a5,-24(s0)
  
  // 将清屏序列写入标准输出（文件描述符1）
  // seq: 要写入的数据的起始地址
  // sizeof(seq): 要写入的字节数（现在是8个字节）
  write(1, seq, sizeof(seq));
  14:	4621                	li	a2,8
  16:	fe840593          	addi	a1,s0,-24
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	2ea080e7          	jalr	746(ra) # 306 <write>
  
  // 正常退出程序，返回状态码0
  exit(0);
  24:	4501                	li	a0,0
  26:	00000097          	auipc	ra,0x0
  2a:	2c0080e7          	jalr	704(ra) # 2e6 <exit>

000000000000002e <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
  2e:	1141                	addi	sp,sp,-16
  30:	e422                	sd	s0,8(sp)
  32:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  34:	87aa                	mv	a5,a0
  36:	0585                	addi	a1,a1,1
  38:	0785                	addi	a5,a5,1
  3a:	fff5c703          	lbu	a4,-1(a1)
  3e:	fee78fa3          	sb	a4,-1(a5)
  42:	fb75                	bnez	a4,36 <strcpy+0x8>
    ;
  return os;
}
  44:	6422                	ld	s0,8(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcat>:

char*
strcat(char *s, const char *t)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e422                	sd	s0,8(sp)
  4e:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  50:	00054783          	lbu	a5,0(a0)
  54:	c385                	beqz	a5,74 <strcat+0x2a>
  56:	87aa                	mv	a5,a0
    s++;
  58:	0785                	addi	a5,a5,1
  while(*s)
  5a:	0007c703          	lbu	a4,0(a5)
  5e:	ff6d                	bnez	a4,58 <strcat+0xe>
  while((*s++ = *t++))
  60:	0585                	addi	a1,a1,1
  62:	0785                	addi	a5,a5,1
  64:	fff5c703          	lbu	a4,-1(a1)
  68:	fee78fa3          	sb	a4,-1(a5)
  6c:	fb75                	bnez	a4,60 <strcat+0x16>
    ;
  return os;
}
  6e:	6422                	ld	s0,8(sp)
  70:	0141                	addi	sp,sp,16
  72:	8082                	ret
  while(*s)
  74:	87aa                	mv	a5,a0
  76:	b7ed                	j	60 <strcat+0x16>

0000000000000078 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  7e:	00054783          	lbu	a5,0(a0)
  82:	cb91                	beqz	a5,96 <strcmp+0x1e>
  84:	0005c703          	lbu	a4,0(a1)
  88:	00f71763          	bne	a4,a5,96 <strcmp+0x1e>
    p++, q++;
  8c:	0505                	addi	a0,a0,1
  8e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	fbe5                	bnez	a5,84 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  96:	0005c503          	lbu	a0,0(a1)
}
  9a:	40a7853b          	subw	a0,a5,a0
  9e:	6422                	ld	s0,8(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret

00000000000000a4 <strlen>:

uint
strlen(const char *s)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e422                	sd	s0,8(sp)
  a8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  aa:	00054783          	lbu	a5,0(a0)
  ae:	cf91                	beqz	a5,ca <strlen+0x26>
  b0:	0505                	addi	a0,a0,1
  b2:	87aa                	mv	a5,a0
  b4:	4685                	li	a3,1
  b6:	9e89                	subw	a3,a3,a0
  b8:	00f6853b          	addw	a0,a3,a5
  bc:	0785                	addi	a5,a5,1
  be:	fff7c703          	lbu	a4,-1(a5)
  c2:	fb7d                	bnez	a4,b8 <strlen+0x14>
    ;
  return n;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret
  for(n = 0; s[n]; n++)
  ca:	4501                	li	a0,0
  cc:	bfe5                	j	c4 <strlen+0x20>

00000000000000ce <memset>:

void*
memset(void *dst, int c, uint n)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d4:	ca19                	beqz	a2,ea <memset+0x1c>
  d6:	87aa                	mv	a5,a0
  d8:	1602                	slli	a2,a2,0x20
  da:	9201                	srli	a2,a2,0x20
  dc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e4:	0785                	addi	a5,a5,1
  e6:	fee79de3          	bne	a5,a4,e0 <memset+0x12>
  }
  return dst;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret

00000000000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	1141                	addi	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	addi	s0,sp,16
  for(; *s; s++)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb99                	beqz	a5,110 <strchr+0x20>
    if(*s == c)
  fc:	00f58763          	beq	a1,a5,10a <strchr+0x1a>
  for(; *s; s++)
 100:	0505                	addi	a0,a0,1
 102:	00054783          	lbu	a5,0(a0)
 106:	fbfd                	bnez	a5,fc <strchr+0xc>
      return (char*)s;
  return 0;
 108:	4501                	li	a0,0
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret
  return 0;
 110:	4501                	li	a0,0
 112:	bfe5                	j	10a <strchr+0x1a>

0000000000000114 <gets>:

char*
gets(char *buf, int max)
{
 114:	711d                	addi	sp,sp,-96
 116:	ec86                	sd	ra,88(sp)
 118:	e8a2                	sd	s0,80(sp)
 11a:	e4a6                	sd	s1,72(sp)
 11c:	e0ca                	sd	s2,64(sp)
 11e:	fc4e                	sd	s3,56(sp)
 120:	f852                	sd	s4,48(sp)
 122:	f456                	sd	s5,40(sp)
 124:	f05a                	sd	s6,32(sp)
 126:	ec5e                	sd	s7,24(sp)
 128:	e862                	sd	s8,16(sp)
 12a:	1080                	addi	s0,sp,96
 12c:	8baa                	mv	s7,a0
 12e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 130:	892a                	mv	s2,a0
 132:	4481                	li	s1,0
    cc = read(0, &c, 1);
 134:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 138:	4b29                	li	s6,10
 13a:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 13c:	89a6                	mv	s3,s1
 13e:	2485                	addiw	s1,s1,1
 140:	0344d763          	bge	s1,s4,16e <gets+0x5a>
    cc = read(0, &c, 1);
 144:	4605                	li	a2,1
 146:	85d6                	mv	a1,s5
 148:	4501                	li	a0,0
 14a:	00000097          	auipc	ra,0x0
 14e:	1b4080e7          	jalr	436(ra) # 2fe <read>
    if(cc < 1)
 152:	00a05e63          	blez	a0,16e <gets+0x5a>
    buf[i++] = c;
 156:	faf44783          	lbu	a5,-81(s0)
 15a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15e:	01678763          	beq	a5,s6,16c <gets+0x58>
 162:	0905                	addi	s2,s2,1
 164:	fd879ce3          	bne	a5,s8,13c <gets+0x28>
  for(i=0; i+1 < max; ){
 168:	89a6                	mv	s3,s1
 16a:	a011                	j	16e <gets+0x5a>
 16c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 16e:	99de                	add	s3,s3,s7
 170:	00098023          	sb	zero,0(s3)
  return buf;
}
 174:	855e                	mv	a0,s7
 176:	60e6                	ld	ra,88(sp)
 178:	6446                	ld	s0,80(sp)
 17a:	64a6                	ld	s1,72(sp)
 17c:	6906                	ld	s2,64(sp)
 17e:	79e2                	ld	s3,56(sp)
 180:	7a42                	ld	s4,48(sp)
 182:	7aa2                	ld	s5,40(sp)
 184:	7b02                	ld	s6,32(sp)
 186:	6be2                	ld	s7,24(sp)
 188:	6c42                	ld	s8,16(sp)
 18a:	6125                	addi	sp,sp,96
 18c:	8082                	ret

000000000000018e <stat>:

int
stat(const char *n, struct stat *st)
{
 18e:	1101                	addi	sp,sp,-32
 190:	ec06                	sd	ra,24(sp)
 192:	e822                	sd	s0,16(sp)
 194:	e426                	sd	s1,8(sp)
 196:	e04a                	sd	s2,0(sp)
 198:	1000                	addi	s0,sp,32
 19a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19c:	4581                	li	a1,0
 19e:	00000097          	auipc	ra,0x0
 1a2:	188080e7          	jalr	392(ra) # 326 <open>
  if(fd < 0)
 1a6:	02054563          	bltz	a0,1d0 <stat+0x42>
 1aa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ac:	85ca                	mv	a1,s2
 1ae:	00000097          	auipc	ra,0x0
 1b2:	180080e7          	jalr	384(ra) # 32e <fstat>
 1b6:	892a                	mv	s2,a0
  close(fd);
 1b8:	8526                	mv	a0,s1
 1ba:	00000097          	auipc	ra,0x0
 1be:	154080e7          	jalr	340(ra) # 30e <close>
  return r;
}
 1c2:	854a                	mv	a0,s2
 1c4:	60e2                	ld	ra,24(sp)
 1c6:	6442                	ld	s0,16(sp)
 1c8:	64a2                	ld	s1,8(sp)
 1ca:	6902                	ld	s2,0(sp)
 1cc:	6105                	addi	sp,sp,32
 1ce:	8082                	ret
    return -1;
 1d0:	597d                	li	s2,-1
 1d2:	bfc5                	j	1c2 <stat+0x34>

00000000000001d4 <atoi>:

int
atoi(const char *s)
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 1da:	00054703          	lbu	a4,0(a0)
 1de:	02d00793          	li	a5,45
  int neg = 1;
 1e2:	4585                	li	a1,1
  if (*s == '-') {
 1e4:	04f70363          	beq	a4,a5,22a <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 1e8:	00054703          	lbu	a4,0(a0)
 1ec:	fd07079b          	addiw	a5,a4,-48
 1f0:	0ff7f793          	zext.b	a5,a5
 1f4:	46a5                	li	a3,9
 1f6:	02f6ed63          	bltu	a3,a5,230 <atoi+0x5c>
  n = 0;
 1fa:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 1fc:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 1fe:	0505                	addi	a0,a0,1
 200:	0026979b          	slliw	a5,a3,0x2
 204:	9fb5                	addw	a5,a5,a3
 206:	0017979b          	slliw	a5,a5,0x1
 20a:	9fb9                	addw	a5,a5,a4
 20c:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 210:	00054703          	lbu	a4,0(a0)
 214:	fd07079b          	addiw	a5,a4,-48
 218:	0ff7f793          	zext.b	a5,a5
 21c:	fef671e3          	bgeu	a2,a5,1fe <atoi+0x2a>
  return n * neg;
}
 220:	02d5853b          	mulw	a0,a1,a3
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
    s++;
 22a:	0505                	addi	a0,a0,1
    neg = -1;
 22c:	55fd                	li	a1,-1
 22e:	bf6d                	j	1e8 <atoi+0x14>
  n = 0;
 230:	4681                	li	a3,0
 232:	b7fd                	j	220 <atoi+0x4c>

0000000000000234 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 234:	1141                	addi	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23a:	02b57463          	bgeu	a0,a1,262 <memmove+0x2e>
    while(n-- > 0)
 23e:	00c05f63          	blez	a2,25c <memmove+0x28>
 242:	1602                	slli	a2,a2,0x20
 244:	9201                	srli	a2,a2,0x20
 246:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24a:	872a                	mv	a4,a0
      *dst++ = *src++;
 24c:	0585                	addi	a1,a1,1
 24e:	0705                	addi	a4,a4,1
 250:	fff5c683          	lbu	a3,-1(a1)
 254:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 258:	fee79ae3          	bne	a5,a4,24c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25c:	6422                	ld	s0,8(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret
    dst += n;
 262:	00c50733          	add	a4,a0,a2
    src += n;
 266:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 268:	fec05ae3          	blez	a2,25c <memmove+0x28>
 26c:	fff6079b          	addiw	a5,a2,-1
 270:	1782                	slli	a5,a5,0x20
 272:	9381                	srli	a5,a5,0x20
 274:	fff7c793          	not	a5,a5
 278:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27a:	15fd                	addi	a1,a1,-1
 27c:	177d                	addi	a4,a4,-1
 27e:	0005c683          	lbu	a3,0(a1)
 282:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x46>
 28a:	bfc9                	j	25c <memmove+0x28>

000000000000028c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28c:	1141                	addi	sp,sp,-16
 28e:	e422                	sd	s0,8(sp)
 290:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 292:	ca05                	beqz	a2,2c2 <memcmp+0x36>
 294:	fff6069b          	addiw	a3,a2,-1
 298:	1682                	slli	a3,a3,0x20
 29a:	9281                	srli	a3,a3,0x20
 29c:	0685                	addi	a3,a3,1
 29e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00e79863          	bne	a5,a4,2b8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ac:	0505                	addi	a0,a0,1
    p2++;
 2ae:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b0:	fed518e3          	bne	a0,a3,2a0 <memcmp+0x14>
  }
  return 0;
 2b4:	4501                	li	a0,0
 2b6:	a019                	j	2bc <memcmp+0x30>
      return *p1 - *p2;
 2b8:	40e7853b          	subw	a0,a5,a4
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <memcmp+0x30>

00000000000002c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ce:	00000097          	auipc	ra,0x0
 2d2:	f66080e7          	jalr	-154(ra) # 234 <memmove>
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 2de:	4885                	li	a7,1
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e6:	4889                	li	a7,2
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ee:	488d                	li	a7,3
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f6:	4891                	li	a7,4
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <read>:
.global read
read:
 li a7, SYS_read
 2fe:	4895                	li	a7,5
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <write>:
.global write
write:
 li a7, SYS_write
 306:	48c1                	li	a7,16
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <close>:
.global close
close:
 li a7, SYS_close
 30e:	48d5                	li	a7,21
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <kill>:
.global kill
kill:
 li a7, SYS_kill
 316:	4899                	li	a7,6
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <exec>:
.global exec
exec:
 li a7, SYS_exec
 31e:	489d                	li	a7,7
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <open>:
.global open
open:
 li a7, SYS_open
 326:	48bd                	li	a7,15
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 32e:	48a1                	li	a7,8
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 336:	48d1                	li	a7,20
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 33e:	48a5                	li	a7,9
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <dup>:
.global dup
dup:
 li a7, SYS_dup
 346:	48a9                	li	a7,10
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 34e:	48ad                	li	a7,11
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 356:	48b1                	li	a7,12
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 35e:	48b5                	li	a7,13
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 366:	48b9                	li	a7,14
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 36e:	48d9                	li	a7,22
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <dev>:
.global dev
dev:
 li a7, SYS_dev
 376:	48dd                	li	a7,23
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 37e:	48e1                	li	a7,24
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 386:	48e5                	li	a7,25
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <remove>:
.global remove
remove:
 li a7, SYS_remove
 38e:	48c5                	li	a7,17
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <trace>:
.global trace
trace:
 li a7, SYS_trace
 396:	48c9                	li	a7,18
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 39e:	48cd                	li	a7,19
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <rename>:
.global rename
rename:
 li a7, SYS_rename
 3a6:	48e9                	li	a7,26
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 3ae:	48ed                	li	a7,27
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 3b6:	48f1                	li	a7,28
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 3be:	48f5                	li	a7,29
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 3c6:	48f9                	li	a7,30
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 3ce:	48fd                	li	a7,31
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 3d6:	02000893          	li	a7,32
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 3e0:	02100893          	li	a7,33
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 3ea:	02200893          	li	a7,34
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 3f4:	02300893          	li	a7,35
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 3fe:	02400893          	li	a7,36
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 408:	02500893          	li	a7,37
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 412:	02600893          	li	a7,38
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 41c:	02700893          	li	a7,39
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 426:	02800893          	li	a7,40
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 430:	02900893          	li	a7,41
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 43a:	02a00893          	li	a7,42
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 444:	02b00893          	li	a7,43
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 44e:	02c00893          	li	a7,44
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 458:	02d00893          	li	a7,45
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 462:	02e00893          	li	a7,46
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 46c:	02f00893          	li	a7,47
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 476:	03000893          	li	a7,48
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 480:	03100893          	li	a7,49
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 48a:	03200893          	li	a7,50
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 494:	03300893          	li	a7,51
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 49e:	03400893          	li	a7,52
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 4a8:	03500893          	li	a7,53
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 4b2:	03600893          	li	a7,54
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 4bc:	03700893          	li	a7,55
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 4c6:	03800893          	li	a7,56
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 4d0:	03900893          	li	a7,57
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 4da:	03a00893          	li	a7,58
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <poll>:
.global poll
poll:
 li a7, SYS_poll
 4e4:	03b00893          	li	a7,59
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 4ee:	03c00893          	li	a7,60
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 4f8:	03d00893          	li	a7,61
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 502:	03e00893          	li	a7,62
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <clone>:
.global clone
clone:
 li a7, SYS_clone
 50c:	03f00893          	li	a7,63
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <futex>:
.global futex
futex:
 li a7, SYS_futex
 516:	04000893          	li	a7,64
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 520:	04100893          	li	a7,65
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <halt>:
.global halt
halt:
 li a7, SYS_halt
 52a:	04200893          	li	a7,66
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 534:	04300893          	li	a7,67
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <socket>:
.global socket
socket:
 li a7, SYS_socket
 53e:	04400893          	li	a7,68
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <bind>:
.global bind
bind:
 li a7, SYS_bind
 548:	04500893          	li	a7,69
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <listen>:
.global listen
listen:
 li a7, SYS_listen
 552:	04600893          	li	a7,70
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <accept>:
.global accept
accept:
 li a7, SYS_accept
 55c:	04700893          	li	a7,71
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <connect>:
.global connect
connect:
 li a7, SYS_connect
 566:	04800893          	li	a7,72
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <send>:
.global send
send:
 li a7, SYS_send
 570:	04900893          	li	a7,73
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <recv>:
.global recv
recv:
 li a7, SYS_recv
 57a:	04a00893          	li	a7,74
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 584:	04b00893          	li	a7,75
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58e:	1101                	addi	sp,sp,-32
 590:	ec06                	sd	ra,24(sp)
 592:	e822                	sd	s0,16(sp)
 594:	1000                	addi	s0,sp,32
 596:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 59a:	4605                	li	a2,1
 59c:	fef40593          	addi	a1,s0,-17
 5a0:	00000097          	auipc	ra,0x0
 5a4:	d66080e7          	jalr	-666(ra) # 306 <write>
}
 5a8:	60e2                	ld	ra,24(sp)
 5aa:	6442                	ld	s0,16(sp)
 5ac:	6105                	addi	sp,sp,32
 5ae:	8082                	ret

00000000000005b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	7139                	addi	sp,sp,-64
 5b2:	fc06                	sd	ra,56(sp)
 5b4:	f822                	sd	s0,48(sp)
 5b6:	f426                	sd	s1,40(sp)
 5b8:	f04a                	sd	s2,32(sp)
 5ba:	ec4e                	sd	s3,24(sp)
 5bc:	0080                	addi	s0,sp,64
 5be:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c0:	c299                	beqz	a3,5c6 <printint+0x16>
 5c2:	0805c863          	bltz	a1,652 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c6:	2581                	sext.w	a1,a1
  neg = 0;
 5c8:	4881                	li	a7,0
  }

  i = 0;
 5ca:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5ce:	86ce                	mv	a3,s3
  i = 0;
 5d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5d2:	2601                	sext.w	a2,a2
 5d4:	00000517          	auipc	a0,0x0
 5d8:	4a450513          	addi	a0,a0,1188 # a78 <digits>
 5dc:	883a                	mv	a6,a4
 5de:	2705                	addiw	a4,a4,1
 5e0:	02c5f7bb          	remuw	a5,a1,a2
 5e4:	1782                	slli	a5,a5,0x20
 5e6:	9381                	srli	a5,a5,0x20
 5e8:	97aa                	add	a5,a5,a0
 5ea:	0007c783          	lbu	a5,0(a5)
 5ee:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5f2:	0005879b          	sext.w	a5,a1
 5f6:	02c5d5bb          	divuw	a1,a1,a2
 5fa:	0685                	addi	a3,a3,1
 5fc:	fec7f0e3          	bgeu	a5,a2,5dc <printint+0x2c>
  if(neg)
 600:	00088c63          	beqz	a7,618 <printint+0x68>
    buf[i++] = '-';
 604:	fd070793          	addi	a5,a4,-48
 608:	00878733          	add	a4,a5,s0
 60c:	02d00793          	li	a5,45
 610:	fef70823          	sb	a5,-16(a4)
 614:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 618:	02e05663          	blez	a4,644 <printint+0x94>
 61c:	fc040913          	addi	s2,s0,-64
 620:	993a                	add	s2,s2,a4
 622:	19fd                	addi	s3,s3,-1
 624:	99ba                	add	s3,s3,a4
 626:	377d                	addiw	a4,a4,-1
 628:	1702                	slli	a4,a4,0x20
 62a:	9301                	srli	a4,a4,0x20
 62c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 630:	fff94583          	lbu	a1,-1(s2)
 634:	8526                	mv	a0,s1
 636:	00000097          	auipc	ra,0x0
 63a:	f58080e7          	jalr	-168(ra) # 58e <putc>
  while(--i >= 0)
 63e:	197d                	addi	s2,s2,-1
 640:	ff3918e3          	bne	s2,s3,630 <printint+0x80>
}
 644:	70e2                	ld	ra,56(sp)
 646:	7442                	ld	s0,48(sp)
 648:	74a2                	ld	s1,40(sp)
 64a:	7902                	ld	s2,32(sp)
 64c:	69e2                	ld	s3,24(sp)
 64e:	6121                	addi	sp,sp,64
 650:	8082                	ret
    x = -xx;
 652:	40b005bb          	negw	a1,a1
    neg = 1;
 656:	4885                	li	a7,1
    x = -xx;
 658:	bf8d                	j	5ca <printint+0x1a>

000000000000065a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 65a:	7119                	addi	sp,sp,-128
 65c:	fc86                	sd	ra,120(sp)
 65e:	f8a2                	sd	s0,112(sp)
 660:	f4a6                	sd	s1,104(sp)
 662:	f0ca                	sd	s2,96(sp)
 664:	ecce                	sd	s3,88(sp)
 666:	e8d2                	sd	s4,80(sp)
 668:	e4d6                	sd	s5,72(sp)
 66a:	e0da                	sd	s6,64(sp)
 66c:	fc5e                	sd	s7,56(sp)
 66e:	f862                	sd	s8,48(sp)
 670:	f466                	sd	s9,40(sp)
 672:	f06a                	sd	s10,32(sp)
 674:	ec6e                	sd	s11,24(sp)
 676:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 678:	0005c903          	lbu	s2,0(a1)
 67c:	18090f63          	beqz	s2,81a <vprintf+0x1c0>
 680:	8aaa                	mv	s5,a0
 682:	8b32                	mv	s6,a2
 684:	00158493          	addi	s1,a1,1
  state = 0;
 688:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 68a:	02500a13          	li	s4,37
 68e:	4c55                	li	s8,21
 690:	00000c97          	auipc	s9,0x0
 694:	390c8c93          	addi	s9,s9,912 # a20 <malloc+0x102>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 698:	02800d93          	li	s11,40
  putc(fd, 'x');
 69c:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69e:	00000b97          	auipc	s7,0x0
 6a2:	3dab8b93          	addi	s7,s7,986 # a78 <digits>
 6a6:	a839                	j	6c4 <vprintf+0x6a>
        putc(fd, c);
 6a8:	85ca                	mv	a1,s2
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	ee2080e7          	jalr	-286(ra) # 58e <putc>
 6b4:	a019                	j	6ba <vprintf+0x60>
    } else if(state == '%'){
 6b6:	01498d63          	beq	s3,s4,6d0 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 6ba:	0485                	addi	s1,s1,1
 6bc:	fff4c903          	lbu	s2,-1(s1)
 6c0:	14090d63          	beqz	s2,81a <vprintf+0x1c0>
    if(state == 0){
 6c4:	fe0999e3          	bnez	s3,6b6 <vprintf+0x5c>
      if(c == '%'){
 6c8:	ff4910e3          	bne	s2,s4,6a8 <vprintf+0x4e>
        state = '%';
 6cc:	89d2                	mv	s3,s4
 6ce:	b7f5                	j	6ba <vprintf+0x60>
      if(c == 'd'){
 6d0:	11490c63          	beq	s2,s4,7e8 <vprintf+0x18e>
 6d4:	f9d9079b          	addiw	a5,s2,-99
 6d8:	0ff7f793          	zext.b	a5,a5
 6dc:	10fc6e63          	bltu	s8,a5,7f8 <vprintf+0x19e>
 6e0:	f9d9079b          	addiw	a5,s2,-99
 6e4:	0ff7f713          	zext.b	a4,a5
 6e8:	10ec6863          	bltu	s8,a4,7f8 <vprintf+0x19e>
 6ec:	00271793          	slli	a5,a4,0x2
 6f0:	97e6                	add	a5,a5,s9
 6f2:	439c                	lw	a5,0(a5)
 6f4:	97e6                	add	a5,a5,s9
 6f6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6f8:	008b0913          	addi	s2,s6,8
 6fc:	4685                	li	a3,1
 6fe:	4629                	li	a2,10
 700:	000b2583          	lw	a1,0(s6)
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	eaa080e7          	jalr	-342(ra) # 5b0 <printint>
 70e:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 710:	4981                	li	s3,0
 712:	b765                	j	6ba <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 714:	008b0913          	addi	s2,s6,8
 718:	4681                	li	a3,0
 71a:	4629                	li	a2,10
 71c:	000b2583          	lw	a1,0(s6)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	e8e080e7          	jalr	-370(ra) # 5b0 <printint>
 72a:	8b4a                	mv	s6,s2
      state = 0;
 72c:	4981                	li	s3,0
 72e:	b771                	j	6ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 730:	008b0913          	addi	s2,s6,8
 734:	4681                	li	a3,0
 736:	866a                	mv	a2,s10
 738:	000b2583          	lw	a1,0(s6)
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e72080e7          	jalr	-398(ra) # 5b0 <printint>
 746:	8b4a                	mv	s6,s2
      state = 0;
 748:	4981                	li	s3,0
 74a:	bf85                	j	6ba <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 74c:	008b0793          	addi	a5,s6,8
 750:	f8f43423          	sd	a5,-120(s0)
 754:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 758:	03000593          	li	a1,48
 75c:	8556                	mv	a0,s5
 75e:	00000097          	auipc	ra,0x0
 762:	e30080e7          	jalr	-464(ra) # 58e <putc>
  putc(fd, 'x');
 766:	07800593          	li	a1,120
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e22080e7          	jalr	-478(ra) # 58e <putc>
 774:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 776:	03c9d793          	srli	a5,s3,0x3c
 77a:	97de                	add	a5,a5,s7
 77c:	0007c583          	lbu	a1,0(a5)
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	e0c080e7          	jalr	-500(ra) # 58e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78a:	0992                	slli	s3,s3,0x4
 78c:	397d                	addiw	s2,s2,-1
 78e:	fe0914e3          	bnez	s2,776 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 792:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 796:	4981                	li	s3,0
 798:	b70d                	j	6ba <vprintf+0x60>
        s = va_arg(ap, char*);
 79a:	008b0913          	addi	s2,s6,8
 79e:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7a2:	02098163          	beqz	s3,7c4 <vprintf+0x16a>
        while(*s != 0){
 7a6:	0009c583          	lbu	a1,0(s3)
 7aa:	c5ad                	beqz	a1,814 <vprintf+0x1ba>
          putc(fd, *s);
 7ac:	8556                	mv	a0,s5
 7ae:	00000097          	auipc	ra,0x0
 7b2:	de0080e7          	jalr	-544(ra) # 58e <putc>
          s++;
 7b6:	0985                	addi	s3,s3,1
        while(*s != 0){
 7b8:	0009c583          	lbu	a1,0(s3)
 7bc:	f9e5                	bnez	a1,7ac <vprintf+0x152>
        s = va_arg(ap, char*);
 7be:	8b4a                	mv	s6,s2
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	bde5                	j	6ba <vprintf+0x60>
          s = "(null)";
 7c4:	00000997          	auipc	s3,0x0
 7c8:	25498993          	addi	s3,s3,596 # a18 <malloc+0xfa>
        while(*s != 0){
 7cc:	85ee                	mv	a1,s11
 7ce:	bff9                	j	7ac <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 7d0:	008b0913          	addi	s2,s6,8
 7d4:	000b4583          	lbu	a1,0(s6)
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	db4080e7          	jalr	-588(ra) # 58e <putc>
 7e2:	8b4a                	mv	s6,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	bdd1                	j	6ba <vprintf+0x60>
        putc(fd, c);
 7e8:	85d2                	mv	a1,s4
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	da2080e7          	jalr	-606(ra) # 58e <putc>
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b5d1                	j	6ba <vprintf+0x60>
        putc(fd, '%');
 7f8:	85d2                	mv	a1,s4
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	d92080e7          	jalr	-622(ra) # 58e <putc>
        putc(fd, c);
 804:	85ca                	mv	a1,s2
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	d86080e7          	jalr	-634(ra) # 58e <putc>
      state = 0;
 810:	4981                	li	s3,0
 812:	b565                	j	6ba <vprintf+0x60>
        s = va_arg(ap, char*);
 814:	8b4a                	mv	s6,s2
      state = 0;
 816:	4981                	li	s3,0
 818:	b54d                	j	6ba <vprintf+0x60>
    }
  }
}
 81a:	70e6                	ld	ra,120(sp)
 81c:	7446                	ld	s0,112(sp)
 81e:	74a6                	ld	s1,104(sp)
 820:	7906                	ld	s2,96(sp)
 822:	69e6                	ld	s3,88(sp)
 824:	6a46                	ld	s4,80(sp)
 826:	6aa6                	ld	s5,72(sp)
 828:	6b06                	ld	s6,64(sp)
 82a:	7be2                	ld	s7,56(sp)
 82c:	7c42                	ld	s8,48(sp)
 82e:	7ca2                	ld	s9,40(sp)
 830:	7d02                	ld	s10,32(sp)
 832:	6de2                	ld	s11,24(sp)
 834:	6109                	addi	sp,sp,128
 836:	8082                	ret

0000000000000838 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 838:	715d                	addi	sp,sp,-80
 83a:	ec06                	sd	ra,24(sp)
 83c:	e822                	sd	s0,16(sp)
 83e:	1000                	addi	s0,sp,32
 840:	e010                	sd	a2,0(s0)
 842:	e414                	sd	a3,8(s0)
 844:	e818                	sd	a4,16(s0)
 846:	ec1c                	sd	a5,24(s0)
 848:	03043023          	sd	a6,32(s0)
 84c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 850:	8622                	mv	a2,s0
 852:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 856:	00000097          	auipc	ra,0x0
 85a:	e04080e7          	jalr	-508(ra) # 65a <vprintf>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6161                	addi	sp,sp,80
 864:	8082                	ret

0000000000000866 <printf>:

void
printf(const char *fmt, ...)
{
 866:	711d                	addi	sp,sp,-96
 868:	ec06                	sd	ra,24(sp)
 86a:	e822                	sd	s0,16(sp)
 86c:	1000                	addi	s0,sp,32
 86e:	e40c                	sd	a1,8(s0)
 870:	e810                	sd	a2,16(s0)
 872:	ec14                	sd	a3,24(s0)
 874:	f018                	sd	a4,32(s0)
 876:	f41c                	sd	a5,40(s0)
 878:	03043823          	sd	a6,48(s0)
 87c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 880:	00840613          	addi	a2,s0,8
 884:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 888:	85aa                	mv	a1,a0
 88a:	4505                	li	a0,1
 88c:	00000097          	auipc	ra,0x0
 890:	dce080e7          	jalr	-562(ra) # 65a <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6125                	addi	sp,sp,96
 89a:	8082                	ret

000000000000089c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89c:	1141                	addi	sp,sp,-16
 89e:	e422                	sd	s0,8(sp)
 8a0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	00000797          	auipc	a5,0x0
 8aa:	1ea7b783          	ld	a5,490(a5) # a90 <freep>
 8ae:	a02d                	j	8d8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8b0:	4618                	lw	a4,8(a2)
 8b2:	9f2d                	addw	a4,a4,a1
 8b4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b8:	6398                	ld	a4,0(a5)
 8ba:	6310                	ld	a2,0(a4)
 8bc:	a83d                	j	8fa <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8be:	ff852703          	lw	a4,-8(a0)
 8c2:	9f31                	addw	a4,a4,a2
 8c4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8c6:	ff053683          	ld	a3,-16(a0)
 8ca:	a091                	j	90e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8cc:	6398                	ld	a4,0(a5)
 8ce:	00e7e463          	bltu	a5,a4,8d6 <free+0x3a>
 8d2:	00e6ea63          	bltu	a3,a4,8e6 <free+0x4a>
{
 8d6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d8:	fed7fae3          	bgeu	a5,a3,8cc <free+0x30>
 8dc:	6398                	ld	a4,0(a5)
 8de:	00e6e463          	bltu	a3,a4,8e6 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e2:	fee7eae3          	bltu	a5,a4,8d6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8e6:	ff852583          	lw	a1,-8(a0)
 8ea:	6390                	ld	a2,0(a5)
 8ec:	02059813          	slli	a6,a1,0x20
 8f0:	01c85713          	srli	a4,a6,0x1c
 8f4:	9736                	add	a4,a4,a3
 8f6:	fae60de3          	beq	a2,a4,8b0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8fa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8fe:	4790                	lw	a2,8(a5)
 900:	02061593          	slli	a1,a2,0x20
 904:	01c5d713          	srli	a4,a1,0x1c
 908:	973e                	add	a4,a4,a5
 90a:	fae68ae3          	beq	a3,a4,8be <free+0x22>
    p->s.ptr = bp->s.ptr;
 90e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 910:	00000717          	auipc	a4,0x0
 914:	18f73023          	sd	a5,384(a4) # a90 <freep>
}
 918:	6422                	ld	s0,8(sp)
 91a:	0141                	addi	sp,sp,16
 91c:	8082                	ret

000000000000091e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 91e:	7139                	addi	sp,sp,-64
 920:	fc06                	sd	ra,56(sp)
 922:	f822                	sd	s0,48(sp)
 924:	f426                	sd	s1,40(sp)
 926:	f04a                	sd	s2,32(sp)
 928:	ec4e                	sd	s3,24(sp)
 92a:	e852                	sd	s4,16(sp)
 92c:	e456                	sd	s5,8(sp)
 92e:	e05a                	sd	s6,0(sp)
 930:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 932:	02051493          	slli	s1,a0,0x20
 936:	9081                	srli	s1,s1,0x20
 938:	04bd                	addi	s1,s1,15
 93a:	8091                	srli	s1,s1,0x4
 93c:	00148a1b          	addiw	s4,s1,1
 940:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 942:	00000517          	auipc	a0,0x0
 946:	14e53503          	ld	a0,334(a0) # a90 <freep>
 94a:	c515                	beqz	a0,976 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 94c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94e:	4798                	lw	a4,8(a5)
 950:	04977163          	bgeu	a4,s1,992 <malloc+0x74>
 954:	89d2                	mv	s3,s4
 956:	000a071b          	sext.w	a4,s4
 95a:	6685                	lui	a3,0x1
 95c:	00d77363          	bgeu	a4,a3,962 <malloc+0x44>
 960:	6985                	lui	s3,0x1
 962:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 966:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 96a:	00000917          	auipc	s2,0x0
 96e:	12690913          	addi	s2,s2,294 # a90 <freep>
  if(p == (char*)-1)
 972:	5afd                	li	s5,-1
 974:	a8a5                	j	9ec <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 976:	00000797          	auipc	a5,0x0
 97a:	11a78793          	addi	a5,a5,282 # a90 <freep>
 97e:	00000717          	auipc	a4,0x0
 982:	11a70713          	addi	a4,a4,282 # a98 <base>
 986:	e398                	sd	a4,0(a5)
 988:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 98a:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98e:	87ba                	mv	a5,a4
 990:	b7d1                	j	954 <malloc+0x36>
      if(p->s.size == nunits)
 992:	02e48c63          	beq	s1,a4,9ca <malloc+0xac>
        p->s.size -= nunits;
 996:	4147073b          	subw	a4,a4,s4
 99a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 99c:	02071693          	slli	a3,a4,0x20
 9a0:	01c6d713          	srli	a4,a3,0x1c
 9a4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a6:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 9aa:	00000717          	auipc	a4,0x0
 9ae:	0ea73323          	sd	a0,230(a4) # a90 <freep>
      return (void*)(p + 1);
 9b2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9b6:	70e2                	ld	ra,56(sp)
 9b8:	7442                	ld	s0,48(sp)
 9ba:	74a2                	ld	s1,40(sp)
 9bc:	7902                	ld	s2,32(sp)
 9be:	69e2                	ld	s3,24(sp)
 9c0:	6a42                	ld	s4,16(sp)
 9c2:	6aa2                	ld	s5,8(sp)
 9c4:	6b02                	ld	s6,0(sp)
 9c6:	6121                	addi	sp,sp,64
 9c8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9ca:	6398                	ld	a4,0(a5)
 9cc:	e118                	sd	a4,0(a0)
 9ce:	bff1                	j	9aa <malloc+0x8c>
  hp->s.size = nu;
 9d0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9d4:	0541                	addi	a0,a0,16
 9d6:	00000097          	auipc	ra,0x0
 9da:	ec6080e7          	jalr	-314(ra) # 89c <free>
  return freep;
 9de:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9e2:	d971                	beqz	a0,9b6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e6:	4798                	lw	a4,8(a5)
 9e8:	fa9775e3          	bgeu	a4,s1,992 <malloc+0x74>
    if(p == freep)
 9ec:	00093703          	ld	a4,0(s2)
 9f0:	853e                	mv	a0,a5
 9f2:	fef719e3          	bne	a4,a5,9e4 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 9f6:	854e                	mv	a0,s3
 9f8:	00000097          	auipc	ra,0x0
 9fc:	95e080e7          	jalr	-1698(ra) # 356 <sbrk>
  if(p == (char*)-1)
 a00:	fd5518e3          	bne	a0,s5,9d0 <malloc+0xb2>
        return 0;
 a04:	4501                	li	a0,0
 a06:	bf45                	j	9b6 <malloc+0x98>
