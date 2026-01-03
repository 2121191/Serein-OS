
serein-user/_stressload：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cpu_burn>:
#include "serein-user/user.h"

// 简单的 CPU 密集型工作
static void
cpu_burn(int id, int tickets)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  // 设置票数
  settickets(tickets);
   8:	852e                	mv	a0,a1
   a:	00000097          	auipc	ra,0x0
   e:	4f4080e7          	jalr	1268(ra) # 4fe <settickets>
  
  // 无限循环消耗 CPU
  volatile unsigned long counter = 0;
  12:	fe043423          	sd	zero,-24(s0)
  while(1) {
    counter++;
  16:	fe843783          	ld	a5,-24(s0)
  1a:	0785                	addi	a5,a5,1
  1c:	fef43423          	sd	a5,-24(s0)
    // 每隔一段时间让出 CPU，避免完全占用
    if((counter & 0xFFFFF) == 0) {
  20:	fe843783          	ld	a5,-24(s0)
  while(1) {
  24:	bfcd                	j	16 <cpu_burn+0x16>

0000000000000026 <main>:
  }
}

int
main(int argc, char *argv[])
{
  26:	1101                	addi	sp,sp,-32
  28:	ec06                	sd	ra,24(sp)
  2a:	e822                	sd	s0,16(sp)
  2c:	e426                	sd	s1,8(sp)
  2e:	e04a                	sd	s2,0(sp)
  30:	1000                	addi	s0,sp,32
  printf("=== Stride Scheduler Demo ===\n");
  32:	00001517          	auipc	a0,0x1
  36:	afe50513          	addi	a0,a0,-1282 # b30 <malloc+0xea>
  3a:	00001097          	auipc	ra,0x1
  3e:	954080e7          	jalr	-1708(ra) # 98e <printf>
  printf("Spawning 3 workers with different tickets...\n\n");
  42:	00001517          	auipc	a0,0x1
  46:	b0e50513          	addi	a0,a0,-1266 # b50 <malloc+0x10a>
  4a:	00001097          	auipc	ra,0x1
  4e:	944080e7          	jalr	-1724(ra) # 98e <printf>
  printf("  Worker 1: tickets = 10 (低优先级)\n");
  52:	00001517          	auipc	a0,0x1
  56:	b2e50513          	addi	a0,a0,-1234 # b80 <malloc+0x13a>
  5a:	00001097          	auipc	ra,0x1
  5e:	934080e7          	jalr	-1740(ra) # 98e <printf>
  printf("  Worker 2: tickets = 20 (中优先级)\n");
  62:	00001517          	auipc	a0,0x1
  66:	b4e50513          	addi	a0,a0,-1202 # bb0 <malloc+0x16a>
  6a:	00001097          	auipc	ra,0x1
  6e:	924080e7          	jalr	-1756(ra) # 98e <printf>
  printf("  Worker 3: tickets = 10 (低优先级)\n\n");
  72:	00001517          	auipc	a0,0x1
  76:	b6e50513          	addi	a0,a0,-1170 # be0 <malloc+0x19a>
  7a:	00001097          	auipc	ra,0x1
  7e:	914080e7          	jalr	-1772(ra) # 98e <printf>
  printf("预期结果: Worker 2 获得约 50%% CPU 时间, Worker 1 和 3 各约 25%%\n\n");
  82:	00001517          	auipc	a0,0x1
  86:	b8e50513          	addi	a0,a0,-1138 # c10 <malloc+0x1ca>
  8a:	00001097          	auipc	ra,0x1
  8e:	904080e7          	jalr	-1788(ra) # 98e <printf>
  printf("请在另一个终端运行 'procshow' 查看可视化效果\n");
  92:	00001517          	auipc	a0,0x1
  96:	bce50513          	addi	a0,a0,-1074 # c60 <malloc+0x21a>
  9a:	00001097          	auipc	ra,0x1
  9e:	8f4080e7          	jalr	-1804(ra) # 98e <printf>
  printf("按 Ctrl+C 可终止所有 worker\n\n");
  a2:	00001517          	auipc	a0,0x1
  a6:	bfe50513          	addi	a0,a0,-1026 # ca0 <malloc+0x25a>
  aa:	00001097          	auipc	ra,0x1
  ae:	8e4080e7          	jalr	-1820(ra) # 98e <printf>
  
  int pid1 = fork();
  b2:	00000097          	auipc	ra,0x0
  b6:	354080e7          	jalr	852(ra) # 406 <fork>
  if(pid1 == 0) {
  ba:	e519                	bnez	a0,c8 <main+0xa2>
    cpu_burn(1, 10);
  bc:	45a9                	li	a1,10
  be:	4505                	li	a0,1
  c0:	00000097          	auipc	ra,0x0
  c4:	f40080e7          	jalr	-192(ra) # 0 <cpu_burn>
  c8:	84aa                	mv	s1,a0
    exit(0);
  }
  
  int pid2 = fork();
  ca:	00000097          	auipc	ra,0x0
  ce:	33c080e7          	jalr	828(ra) # 406 <fork>
  d2:	892a                	mv	s2,a0
  if(pid2 == 0) {
  d4:	e519                	bnez	a0,e2 <main+0xbc>
    cpu_burn(2, 20);
  d6:	45d1                	li	a1,20
  d8:	4509                	li	a0,2
  da:	00000097          	auipc	ra,0x0
  de:	f26080e7          	jalr	-218(ra) # 0 <cpu_burn>
    exit(0);
  }
  
  int pid3 = fork();
  e2:	00000097          	auipc	ra,0x0
  e6:	324080e7          	jalr	804(ra) # 406 <fork>
  ea:	86aa                	mv	a3,a0
  if(pid3 == 0) {
  ec:	e519                	bnez	a0,fa <main+0xd4>
    cpu_burn(3, 10);
  ee:	45a9                	li	a1,10
  f0:	450d                	li	a0,3
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <cpu_burn>
    exit(0);
  }
  
  printf("Workers started: PIDs = %d, %d, %d\n", pid1, pid2, pid3);
  fa:	864a                	mv	a2,s2
  fc:	85a6                	mv	a1,s1
  fe:	00001517          	auipc	a0,0x1
 102:	bca50513          	addi	a0,a0,-1078 # cc8 <malloc+0x282>
 106:	00001097          	auipc	ra,0x1
 10a:	888080e7          	jalr	-1912(ra) # 98e <printf>
  printf("Parent waiting... (press Ctrl+C to stop)\n");
 10e:	00001517          	auipc	a0,0x1
 112:	be250513          	addi	a0,a0,-1054 # cf0 <malloc+0x2aa>
 116:	00001097          	auipc	ra,0x1
 11a:	878080e7          	jalr	-1928(ra) # 98e <printf>
  
  // 父进程等待
  wait(0);
 11e:	4501                	li	a0,0
 120:	00000097          	auipc	ra,0x0
 124:	2f6080e7          	jalr	758(ra) # 416 <wait>
  wait(0);
 128:	4501                	li	a0,0
 12a:	00000097          	auipc	ra,0x0
 12e:	2ec080e7          	jalr	748(ra) # 416 <wait>
  wait(0);
 132:	4501                	li	a0,0
 134:	00000097          	auipc	ra,0x0
 138:	2e2080e7          	jalr	738(ra) # 416 <wait>
  
  printf("All workers finished.\n");
 13c:	00001517          	auipc	a0,0x1
 140:	be450513          	addi	a0,a0,-1052 # d20 <malloc+0x2da>
 144:	00001097          	auipc	ra,0x1
 148:	84a080e7          	jalr	-1974(ra) # 98e <printf>
  exit(0);
 14c:	4501                	li	a0,0
 14e:	00000097          	auipc	ra,0x0
 152:	2c0080e7          	jalr	704(ra) # 40e <exit>

0000000000000156 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 156:	1141                	addi	sp,sp,-16
 158:	e422                	sd	s0,8(sp)
 15a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 15c:	87aa                	mv	a5,a0
 15e:	0585                	addi	a1,a1,1
 160:	0785                	addi	a5,a5,1
 162:	fff5c703          	lbu	a4,-1(a1)
 166:	fee78fa3          	sb	a4,-1(a5)
 16a:	fb75                	bnez	a4,15e <strcpy+0x8>
    ;
  return os;
}
 16c:	6422                	ld	s0,8(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret

0000000000000172 <strcat>:

char*
strcat(char *s, const char *t)
{
 172:	1141                	addi	sp,sp,-16
 174:	e422                	sd	s0,8(sp)
 176:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 178:	00054783          	lbu	a5,0(a0)
 17c:	c385                	beqz	a5,19c <strcat+0x2a>
 17e:	87aa                	mv	a5,a0
    s++;
 180:	0785                	addi	a5,a5,1
  while(*s)
 182:	0007c703          	lbu	a4,0(a5)
 186:	ff6d                	bnez	a4,180 <strcat+0xe>
  while((*s++ = *t++))
 188:	0585                	addi	a1,a1,1
 18a:	0785                	addi	a5,a5,1
 18c:	fff5c703          	lbu	a4,-1(a1)
 190:	fee78fa3          	sb	a4,-1(a5)
 194:	fb75                	bnez	a4,188 <strcat+0x16>
    ;
  return os;
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret
  while(*s)
 19c:	87aa                	mv	a5,a0
 19e:	b7ed                	j	188 <strcat+0x16>

00000000000001a0 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1a0:	1141                	addi	sp,sp,-16
 1a2:	e422                	sd	s0,8(sp)
 1a4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1a6:	00054783          	lbu	a5,0(a0)
 1aa:	cb91                	beqz	a5,1be <strcmp+0x1e>
 1ac:	0005c703          	lbu	a4,0(a1)
 1b0:	00f71763          	bne	a4,a5,1be <strcmp+0x1e>
    p++, q++;
 1b4:	0505                	addi	a0,a0,1
 1b6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	fbe5                	bnez	a5,1ac <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1be:	0005c503          	lbu	a0,0(a1)
}
 1c2:	40a7853b          	subw	a0,a5,a0
 1c6:	6422                	ld	s0,8(sp)
 1c8:	0141                	addi	sp,sp,16
 1ca:	8082                	ret

00000000000001cc <strlen>:

uint
strlen(const char *s)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	cf91                	beqz	a5,1f2 <strlen+0x26>
 1d8:	0505                	addi	a0,a0,1
 1da:	87aa                	mv	a5,a0
 1dc:	4685                	li	a3,1
 1de:	9e89                	subw	a3,a3,a0
 1e0:	00f6853b          	addw	a0,a3,a5
 1e4:	0785                	addi	a5,a5,1
 1e6:	fff7c703          	lbu	a4,-1(a5)
 1ea:	fb7d                	bnez	a4,1e0 <strlen+0x14>
    ;
  return n;
}
 1ec:	6422                	ld	s0,8(sp)
 1ee:	0141                	addi	sp,sp,16
 1f0:	8082                	ret
  for(n = 0; s[n]; n++)
 1f2:	4501                	li	a0,0
 1f4:	bfe5                	j	1ec <strlen+0x20>

00000000000001f6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f6:	1141                	addi	sp,sp,-16
 1f8:	e422                	sd	s0,8(sp)
 1fa:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1fc:	ca19                	beqz	a2,212 <memset+0x1c>
 1fe:	87aa                	mv	a5,a0
 200:	1602                	slli	a2,a2,0x20
 202:	9201                	srli	a2,a2,0x20
 204:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 208:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 20c:	0785                	addi	a5,a5,1
 20e:	fee79de3          	bne	a5,a4,208 <memset+0x12>
  }
  return dst;
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret

0000000000000218 <strchr>:

char*
strchr(const char *s, char c)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 21e:	00054783          	lbu	a5,0(a0)
 222:	cb99                	beqz	a5,238 <strchr+0x20>
    if(*s == c)
 224:	00f58763          	beq	a1,a5,232 <strchr+0x1a>
  for(; *s; s++)
 228:	0505                	addi	a0,a0,1
 22a:	00054783          	lbu	a5,0(a0)
 22e:	fbfd                	bnez	a5,224 <strchr+0xc>
      return (char*)s;
  return 0;
 230:	4501                	li	a0,0
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
  return 0;
 238:	4501                	li	a0,0
 23a:	bfe5                	j	232 <strchr+0x1a>

000000000000023c <gets>:

char*
gets(char *buf, int max)
{
 23c:	711d                	addi	sp,sp,-96
 23e:	ec86                	sd	ra,88(sp)
 240:	e8a2                	sd	s0,80(sp)
 242:	e4a6                	sd	s1,72(sp)
 244:	e0ca                	sd	s2,64(sp)
 246:	fc4e                	sd	s3,56(sp)
 248:	f852                	sd	s4,48(sp)
 24a:	f456                	sd	s5,40(sp)
 24c:	f05a                	sd	s6,32(sp)
 24e:	ec5e                	sd	s7,24(sp)
 250:	e862                	sd	s8,16(sp)
 252:	1080                	addi	s0,sp,96
 254:	8baa                	mv	s7,a0
 256:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 258:	892a                	mv	s2,a0
 25a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 25c:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 260:	4b29                	li	s6,10
 262:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 264:	89a6                	mv	s3,s1
 266:	2485                	addiw	s1,s1,1
 268:	0344d763          	bge	s1,s4,296 <gets+0x5a>
    cc = read(0, &c, 1);
 26c:	4605                	li	a2,1
 26e:	85d6                	mv	a1,s5
 270:	4501                	li	a0,0
 272:	00000097          	auipc	ra,0x0
 276:	1b4080e7          	jalr	436(ra) # 426 <read>
    if(cc < 1)
 27a:	00a05e63          	blez	a0,296 <gets+0x5a>
    buf[i++] = c;
 27e:	faf44783          	lbu	a5,-81(s0)
 282:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 286:	01678763          	beq	a5,s6,294 <gets+0x58>
 28a:	0905                	addi	s2,s2,1
 28c:	fd879ce3          	bne	a5,s8,264 <gets+0x28>
  for(i=0; i+1 < max; ){
 290:	89a6                	mv	s3,s1
 292:	a011                	j	296 <gets+0x5a>
 294:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 296:	99de                	add	s3,s3,s7
 298:	00098023          	sb	zero,0(s3)
  return buf;
}
 29c:	855e                	mv	a0,s7
 29e:	60e6                	ld	ra,88(sp)
 2a0:	6446                	ld	s0,80(sp)
 2a2:	64a6                	ld	s1,72(sp)
 2a4:	6906                	ld	s2,64(sp)
 2a6:	79e2                	ld	s3,56(sp)
 2a8:	7a42                	ld	s4,48(sp)
 2aa:	7aa2                	ld	s5,40(sp)
 2ac:	7b02                	ld	s6,32(sp)
 2ae:	6be2                	ld	s7,24(sp)
 2b0:	6c42                	ld	s8,16(sp)
 2b2:	6125                	addi	sp,sp,96
 2b4:	8082                	ret

00000000000002b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b6:	1101                	addi	sp,sp,-32
 2b8:	ec06                	sd	ra,24(sp)
 2ba:	e822                	sd	s0,16(sp)
 2bc:	e426                	sd	s1,8(sp)
 2be:	e04a                	sd	s2,0(sp)
 2c0:	1000                	addi	s0,sp,32
 2c2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c4:	4581                	li	a1,0
 2c6:	00000097          	auipc	ra,0x0
 2ca:	188080e7          	jalr	392(ra) # 44e <open>
  if(fd < 0)
 2ce:	02054563          	bltz	a0,2f8 <stat+0x42>
 2d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2d4:	85ca                	mv	a1,s2
 2d6:	00000097          	auipc	ra,0x0
 2da:	180080e7          	jalr	384(ra) # 456 <fstat>
 2de:	892a                	mv	s2,a0
  close(fd);
 2e0:	8526                	mv	a0,s1
 2e2:	00000097          	auipc	ra,0x0
 2e6:	154080e7          	jalr	340(ra) # 436 <close>
  return r;
}
 2ea:	854a                	mv	a0,s2
 2ec:	60e2                	ld	ra,24(sp)
 2ee:	6442                	ld	s0,16(sp)
 2f0:	64a2                	ld	s1,8(sp)
 2f2:	6902                	ld	s2,0(sp)
 2f4:	6105                	addi	sp,sp,32
 2f6:	8082                	ret
    return -1;
 2f8:	597d                	li	s2,-1
 2fa:	bfc5                	j	2ea <stat+0x34>

00000000000002fc <atoi>:

int
atoi(const char *s)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 302:	00054703          	lbu	a4,0(a0)
 306:	02d00793          	li	a5,45
  int neg = 1;
 30a:	4585                	li	a1,1
  if (*s == '-') {
 30c:	04f70363          	beq	a4,a5,352 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 310:	00054703          	lbu	a4,0(a0)
 314:	fd07079b          	addiw	a5,a4,-48
 318:	0ff7f793          	zext.b	a5,a5
 31c:	46a5                	li	a3,9
 31e:	02f6ed63          	bltu	a3,a5,358 <atoi+0x5c>
  n = 0;
 322:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 324:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 326:	0505                	addi	a0,a0,1
 328:	0026979b          	slliw	a5,a3,0x2
 32c:	9fb5                	addw	a5,a5,a3
 32e:	0017979b          	slliw	a5,a5,0x1
 332:	9fb9                	addw	a5,a5,a4
 334:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 338:	00054703          	lbu	a4,0(a0)
 33c:	fd07079b          	addiw	a5,a4,-48
 340:	0ff7f793          	zext.b	a5,a5
 344:	fef671e3          	bgeu	a2,a5,326 <atoi+0x2a>
  return n * neg;
}
 348:	02d5853b          	mulw	a0,a1,a3
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
    s++;
 352:	0505                	addi	a0,a0,1
    neg = -1;
 354:	55fd                	li	a1,-1
 356:	bf6d                	j	310 <atoi+0x14>
  n = 0;
 358:	4681                	li	a3,0
 35a:	b7fd                	j	348 <atoi+0x4c>

000000000000035c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 362:	02b57463          	bgeu	a0,a1,38a <memmove+0x2e>
    while(n-- > 0)
 366:	00c05f63          	blez	a2,384 <memmove+0x28>
 36a:	1602                	slli	a2,a2,0x20
 36c:	9201                	srli	a2,a2,0x20
 36e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 372:	872a                	mv	a4,a0
      *dst++ = *src++;
 374:	0585                	addi	a1,a1,1
 376:	0705                	addi	a4,a4,1
 378:	fff5c683          	lbu	a3,-1(a1)
 37c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 380:	fee79ae3          	bne	a5,a4,374 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
    dst += n;
 38a:	00c50733          	add	a4,a0,a2
    src += n;
 38e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 390:	fec05ae3          	blez	a2,384 <memmove+0x28>
 394:	fff6079b          	addiw	a5,a2,-1
 398:	1782                	slli	a5,a5,0x20
 39a:	9381                	srli	a5,a5,0x20
 39c:	fff7c793          	not	a5,a5
 3a0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3a2:	15fd                	addi	a1,a1,-1
 3a4:	177d                	addi	a4,a4,-1
 3a6:	0005c683          	lbu	a3,0(a1)
 3aa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3ae:	fee79ae3          	bne	a5,a4,3a2 <memmove+0x46>
 3b2:	bfc9                	j	384 <memmove+0x28>

00000000000003b4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3b4:	1141                	addi	sp,sp,-16
 3b6:	e422                	sd	s0,8(sp)
 3b8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ba:	ca05                	beqz	a2,3ea <memcmp+0x36>
 3bc:	fff6069b          	addiw	a3,a2,-1
 3c0:	1682                	slli	a3,a3,0x20
 3c2:	9281                	srli	a3,a3,0x20
 3c4:	0685                	addi	a3,a3,1
 3c6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3c8:	00054783          	lbu	a5,0(a0)
 3cc:	0005c703          	lbu	a4,0(a1)
 3d0:	00e79863          	bne	a5,a4,3e0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3d4:	0505                	addi	a0,a0,1
    p2++;
 3d6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3d8:	fed518e3          	bne	a0,a3,3c8 <memcmp+0x14>
  }
  return 0;
 3dc:	4501                	li	a0,0
 3de:	a019                	j	3e4 <memcmp+0x30>
      return *p1 - *p2;
 3e0:	40e7853b          	subw	a0,a5,a4
}
 3e4:	6422                	ld	s0,8(sp)
 3e6:	0141                	addi	sp,sp,16
 3e8:	8082                	ret
  return 0;
 3ea:	4501                	li	a0,0
 3ec:	bfe5                	j	3e4 <memcmp+0x30>

00000000000003ee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e406                	sd	ra,8(sp)
 3f2:	e022                	sd	s0,0(sp)
 3f4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3f6:	00000097          	auipc	ra,0x0
 3fa:	f66080e7          	jalr	-154(ra) # 35c <memmove>
}
 3fe:	60a2                	ld	ra,8(sp)
 400:	6402                	ld	s0,0(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret

0000000000000406 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 406:	4885                	li	a7,1
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <exit>:
.global exit
exit:
 li a7, SYS_exit
 40e:	4889                	li	a7,2
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <wait>:
.global wait
wait:
 li a7, SYS_wait
 416:	488d                	li	a7,3
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 41e:	4891                	li	a7,4
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <read>:
.global read
read:
 li a7, SYS_read
 426:	4895                	li	a7,5
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <write>:
.global write
write:
 li a7, SYS_write
 42e:	48c1                	li	a7,16
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <close>:
.global close
close:
 li a7, SYS_close
 436:	48d5                	li	a7,21
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <kill>:
.global kill
kill:
 li a7, SYS_kill
 43e:	4899                	li	a7,6
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <exec>:
.global exec
exec:
 li a7, SYS_exec
 446:	489d                	li	a7,7
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <open>:
.global open
open:
 li a7, SYS_open
 44e:	48bd                	li	a7,15
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 456:	48a1                	li	a7,8
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 45e:	48d1                	li	a7,20
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 466:	48a5                	li	a7,9
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <dup>:
.global dup
dup:
 li a7, SYS_dup
 46e:	48a9                	li	a7,10
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 476:	48ad                	li	a7,11
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 47e:	48b1                	li	a7,12
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 486:	48b5                	li	a7,13
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 48e:	48b9                	li	a7,14
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 496:	48d9                	li	a7,22
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <dev>:
.global dev
dev:
 li a7, SYS_dev
 49e:	48dd                	li	a7,23
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4a6:	48e1                	li	a7,24
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4ae:	48e5                	li	a7,25
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <remove>:
.global remove
remove:
 li a7, SYS_remove
 4b6:	48c5                	li	a7,17
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <trace>:
.global trace
trace:
 li a7, SYS_trace
 4be:	48c9                	li	a7,18
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 4c6:	48cd                	li	a7,19
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <rename>:
.global rename
rename:
 li a7, SYS_rename
 4ce:	48e9                	li	a7,26
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 4d6:	48ed                	li	a7,27
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 4de:	48f1                	li	a7,28
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 4e6:	48f5                	li	a7,29
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 4ee:	48f9                	li	a7,30
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 4f6:	48fd                	li	a7,31
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 4fe:	02000893          	li	a7,32
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 508:	02100893          	li	a7,33
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 512:	02200893          	li	a7,34
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 51c:	02300893          	li	a7,35
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 526:	02400893          	li	a7,36
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 530:	02500893          	li	a7,37
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 53a:	02600893          	li	a7,38
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 544:	02700893          	li	a7,39
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 54e:	02800893          	li	a7,40
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 558:	02900893          	li	a7,41
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 562:	02a00893          	li	a7,42
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 56c:	02b00893          	li	a7,43
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 576:	02c00893          	li	a7,44
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 580:	02d00893          	li	a7,45
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 58a:	02e00893          	li	a7,46
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 594:	02f00893          	li	a7,47
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 59e:	03000893          	li	a7,48
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 5a8:	03100893          	li	a7,49
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 5b2:	03200893          	li	a7,50
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 5bc:	03300893          	li	a7,51
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 5c6:	03400893          	li	a7,52
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 5d0:	03500893          	li	a7,53
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 5da:	03600893          	li	a7,54
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 5e4:	03700893          	li	a7,55
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 5ee:	03800893          	li	a7,56
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 5f8:	03900893          	li	a7,57
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 602:	03a00893          	li	a7,58
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <poll>:
.global poll
poll:
 li a7, SYS_poll
 60c:	03b00893          	li	a7,59
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 616:	03c00893          	li	a7,60
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 620:	03d00893          	li	a7,61
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 62a:	03e00893          	li	a7,62
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <clone>:
.global clone
clone:
 li a7, SYS_clone
 634:	03f00893          	li	a7,63
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <futex>:
.global futex
futex:
 li a7, SYS_futex
 63e:	04000893          	li	a7,64
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 648:	04100893          	li	a7,65
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <halt>:
.global halt
halt:
 li a7, SYS_halt
 652:	04200893          	li	a7,66
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 65c:	04300893          	li	a7,67
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <socket>:
.global socket
socket:
 li a7, SYS_socket
 666:	04400893          	li	a7,68
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <bind>:
.global bind
bind:
 li a7, SYS_bind
 670:	04500893          	li	a7,69
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <listen>:
.global listen
listen:
 li a7, SYS_listen
 67a:	04600893          	li	a7,70
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <accept>:
.global accept
accept:
 li a7, SYS_accept
 684:	04700893          	li	a7,71
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <connect>:
.global connect
connect:
 li a7, SYS_connect
 68e:	04800893          	li	a7,72
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <send>:
.global send
send:
 li a7, SYS_send
 698:	04900893          	li	a7,73
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6a2:	04a00893          	li	a7,74
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 6ac:	04b00893          	li	a7,75
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6b6:	1101                	addi	sp,sp,-32
 6b8:	ec06                	sd	ra,24(sp)
 6ba:	e822                	sd	s0,16(sp)
 6bc:	1000                	addi	s0,sp,32
 6be:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6c2:	4605                	li	a2,1
 6c4:	fef40593          	addi	a1,s0,-17
 6c8:	00000097          	auipc	ra,0x0
 6cc:	d66080e7          	jalr	-666(ra) # 42e <write>
}
 6d0:	60e2                	ld	ra,24(sp)
 6d2:	6442                	ld	s0,16(sp)
 6d4:	6105                	addi	sp,sp,32
 6d6:	8082                	ret

00000000000006d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6d8:	7139                	addi	sp,sp,-64
 6da:	fc06                	sd	ra,56(sp)
 6dc:	f822                	sd	s0,48(sp)
 6de:	f426                	sd	s1,40(sp)
 6e0:	f04a                	sd	s2,32(sp)
 6e2:	ec4e                	sd	s3,24(sp)
 6e4:	0080                	addi	s0,sp,64
 6e6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6e8:	c299                	beqz	a3,6ee <printint+0x16>
 6ea:	0805c863          	bltz	a1,77a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6ee:	2581                	sext.w	a1,a1
  neg = 0;
 6f0:	4881                	li	a7,0
  }

  i = 0;
 6f2:	fc040993          	addi	s3,s0,-64
  neg = 0;
 6f6:	86ce                	mv	a3,s3
  i = 0;
 6f8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6fa:	2601                	sext.w	a2,a2
 6fc:	00000517          	auipc	a0,0x0
 700:	69c50513          	addi	a0,a0,1692 # d98 <digits>
 704:	883a                	mv	a6,a4
 706:	2705                	addiw	a4,a4,1
 708:	02c5f7bb          	remuw	a5,a1,a2
 70c:	1782                	slli	a5,a5,0x20
 70e:	9381                	srli	a5,a5,0x20
 710:	97aa                	add	a5,a5,a0
 712:	0007c783          	lbu	a5,0(a5)
 716:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 71a:	0005879b          	sext.w	a5,a1
 71e:	02c5d5bb          	divuw	a1,a1,a2
 722:	0685                	addi	a3,a3,1
 724:	fec7f0e3          	bgeu	a5,a2,704 <printint+0x2c>
  if(neg)
 728:	00088c63          	beqz	a7,740 <printint+0x68>
    buf[i++] = '-';
 72c:	fd070793          	addi	a5,a4,-48
 730:	00878733          	add	a4,a5,s0
 734:	02d00793          	li	a5,45
 738:	fef70823          	sb	a5,-16(a4)
 73c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 740:	02e05663          	blez	a4,76c <printint+0x94>
 744:	fc040913          	addi	s2,s0,-64
 748:	993a                	add	s2,s2,a4
 74a:	19fd                	addi	s3,s3,-1
 74c:	99ba                	add	s3,s3,a4
 74e:	377d                	addiw	a4,a4,-1
 750:	1702                	slli	a4,a4,0x20
 752:	9301                	srli	a4,a4,0x20
 754:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 758:	fff94583          	lbu	a1,-1(s2)
 75c:	8526                	mv	a0,s1
 75e:	00000097          	auipc	ra,0x0
 762:	f58080e7          	jalr	-168(ra) # 6b6 <putc>
  while(--i >= 0)
 766:	197d                	addi	s2,s2,-1
 768:	ff3918e3          	bne	s2,s3,758 <printint+0x80>
}
 76c:	70e2                	ld	ra,56(sp)
 76e:	7442                	ld	s0,48(sp)
 770:	74a2                	ld	s1,40(sp)
 772:	7902                	ld	s2,32(sp)
 774:	69e2                	ld	s3,24(sp)
 776:	6121                	addi	sp,sp,64
 778:	8082                	ret
    x = -xx;
 77a:	40b005bb          	negw	a1,a1
    neg = 1;
 77e:	4885                	li	a7,1
    x = -xx;
 780:	bf8d                	j	6f2 <printint+0x1a>

0000000000000782 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 782:	7119                	addi	sp,sp,-128
 784:	fc86                	sd	ra,120(sp)
 786:	f8a2                	sd	s0,112(sp)
 788:	f4a6                	sd	s1,104(sp)
 78a:	f0ca                	sd	s2,96(sp)
 78c:	ecce                	sd	s3,88(sp)
 78e:	e8d2                	sd	s4,80(sp)
 790:	e4d6                	sd	s5,72(sp)
 792:	e0da                	sd	s6,64(sp)
 794:	fc5e                	sd	s7,56(sp)
 796:	f862                	sd	s8,48(sp)
 798:	f466                	sd	s9,40(sp)
 79a:	f06a                	sd	s10,32(sp)
 79c:	ec6e                	sd	s11,24(sp)
 79e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7a0:	0005c903          	lbu	s2,0(a1)
 7a4:	18090f63          	beqz	s2,942 <vprintf+0x1c0>
 7a8:	8aaa                	mv	s5,a0
 7aa:	8b32                	mv	s6,a2
 7ac:	00158493          	addi	s1,a1,1
  state = 0;
 7b0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7b2:	02500a13          	li	s4,37
 7b6:	4c55                	li	s8,21
 7b8:	00000c97          	auipc	s9,0x0
 7bc:	588c8c93          	addi	s9,s9,1416 # d40 <malloc+0x2fa>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7c0:	02800d93          	li	s11,40
  putc(fd, 'x');
 7c4:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c6:	00000b97          	auipc	s7,0x0
 7ca:	5d2b8b93          	addi	s7,s7,1490 # d98 <digits>
 7ce:	a839                	j	7ec <vprintf+0x6a>
        putc(fd, c);
 7d0:	85ca                	mv	a1,s2
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	ee2080e7          	jalr	-286(ra) # 6b6 <putc>
 7dc:	a019                	j	7e2 <vprintf+0x60>
    } else if(state == '%'){
 7de:	01498d63          	beq	s3,s4,7f8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 7e2:	0485                	addi	s1,s1,1
 7e4:	fff4c903          	lbu	s2,-1(s1)
 7e8:	14090d63          	beqz	s2,942 <vprintf+0x1c0>
    if(state == 0){
 7ec:	fe0999e3          	bnez	s3,7de <vprintf+0x5c>
      if(c == '%'){
 7f0:	ff4910e3          	bne	s2,s4,7d0 <vprintf+0x4e>
        state = '%';
 7f4:	89d2                	mv	s3,s4
 7f6:	b7f5                	j	7e2 <vprintf+0x60>
      if(c == 'd'){
 7f8:	11490c63          	beq	s2,s4,910 <vprintf+0x18e>
 7fc:	f9d9079b          	addiw	a5,s2,-99
 800:	0ff7f793          	zext.b	a5,a5
 804:	10fc6e63          	bltu	s8,a5,920 <vprintf+0x19e>
 808:	f9d9079b          	addiw	a5,s2,-99
 80c:	0ff7f713          	zext.b	a4,a5
 810:	10ec6863          	bltu	s8,a4,920 <vprintf+0x19e>
 814:	00271793          	slli	a5,a4,0x2
 818:	97e6                	add	a5,a5,s9
 81a:	439c                	lw	a5,0(a5)
 81c:	97e6                	add	a5,a5,s9
 81e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 820:	008b0913          	addi	s2,s6,8
 824:	4685                	li	a3,1
 826:	4629                	li	a2,10
 828:	000b2583          	lw	a1,0(s6)
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	eaa080e7          	jalr	-342(ra) # 6d8 <printint>
 836:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 838:	4981                	li	s3,0
 83a:	b765                	j	7e2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 83c:	008b0913          	addi	s2,s6,8
 840:	4681                	li	a3,0
 842:	4629                	li	a2,10
 844:	000b2583          	lw	a1,0(s6)
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	e8e080e7          	jalr	-370(ra) # 6d8 <printint>
 852:	8b4a                	mv	s6,s2
      state = 0;
 854:	4981                	li	s3,0
 856:	b771                	j	7e2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 858:	008b0913          	addi	s2,s6,8
 85c:	4681                	li	a3,0
 85e:	866a                	mv	a2,s10
 860:	000b2583          	lw	a1,0(s6)
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	e72080e7          	jalr	-398(ra) # 6d8 <printint>
 86e:	8b4a                	mv	s6,s2
      state = 0;
 870:	4981                	li	s3,0
 872:	bf85                	j	7e2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 874:	008b0793          	addi	a5,s6,8
 878:	f8f43423          	sd	a5,-120(s0)
 87c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 880:	03000593          	li	a1,48
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	e30080e7          	jalr	-464(ra) # 6b6 <putc>
  putc(fd, 'x');
 88e:	07800593          	li	a1,120
 892:	8556                	mv	a0,s5
 894:	00000097          	auipc	ra,0x0
 898:	e22080e7          	jalr	-478(ra) # 6b6 <putc>
 89c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 89e:	03c9d793          	srli	a5,s3,0x3c
 8a2:	97de                	add	a5,a5,s7
 8a4:	0007c583          	lbu	a1,0(a5)
 8a8:	8556                	mv	a0,s5
 8aa:	00000097          	auipc	ra,0x0
 8ae:	e0c080e7          	jalr	-500(ra) # 6b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8b2:	0992                	slli	s3,s3,0x4
 8b4:	397d                	addiw	s2,s2,-1
 8b6:	fe0914e3          	bnez	s2,89e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 8ba:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	b70d                	j	7e2 <vprintf+0x60>
        s = va_arg(ap, char*);
 8c2:	008b0913          	addi	s2,s6,8
 8c6:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 8ca:	02098163          	beqz	s3,8ec <vprintf+0x16a>
        while(*s != 0){
 8ce:	0009c583          	lbu	a1,0(s3)
 8d2:	c5ad                	beqz	a1,93c <vprintf+0x1ba>
          putc(fd, *s);
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	de0080e7          	jalr	-544(ra) # 6b6 <putc>
          s++;
 8de:	0985                	addi	s3,s3,1
        while(*s != 0){
 8e0:	0009c583          	lbu	a1,0(s3)
 8e4:	f9e5                	bnez	a1,8d4 <vprintf+0x152>
        s = va_arg(ap, char*);
 8e6:	8b4a                	mv	s6,s2
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bde5                	j	7e2 <vprintf+0x60>
          s = "(null)";
 8ec:	00000997          	auipc	s3,0x0
 8f0:	44c98993          	addi	s3,s3,1100 # d38 <malloc+0x2f2>
        while(*s != 0){
 8f4:	85ee                	mv	a1,s11
 8f6:	bff9                	j	8d4 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 8f8:	008b0913          	addi	s2,s6,8
 8fc:	000b4583          	lbu	a1,0(s6)
 900:	8556                	mv	a0,s5
 902:	00000097          	auipc	ra,0x0
 906:	db4080e7          	jalr	-588(ra) # 6b6 <putc>
 90a:	8b4a                	mv	s6,s2
      state = 0;
 90c:	4981                	li	s3,0
 90e:	bdd1                	j	7e2 <vprintf+0x60>
        putc(fd, c);
 910:	85d2                	mv	a1,s4
 912:	8556                	mv	a0,s5
 914:	00000097          	auipc	ra,0x0
 918:	da2080e7          	jalr	-606(ra) # 6b6 <putc>
      state = 0;
 91c:	4981                	li	s3,0
 91e:	b5d1                	j	7e2 <vprintf+0x60>
        putc(fd, '%');
 920:	85d2                	mv	a1,s4
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	d92080e7          	jalr	-622(ra) # 6b6 <putc>
        putc(fd, c);
 92c:	85ca                	mv	a1,s2
 92e:	8556                	mv	a0,s5
 930:	00000097          	auipc	ra,0x0
 934:	d86080e7          	jalr	-634(ra) # 6b6 <putc>
      state = 0;
 938:	4981                	li	s3,0
 93a:	b565                	j	7e2 <vprintf+0x60>
        s = va_arg(ap, char*);
 93c:	8b4a                	mv	s6,s2
      state = 0;
 93e:	4981                	li	s3,0
 940:	b54d                	j	7e2 <vprintf+0x60>
    }
  }
}
 942:	70e6                	ld	ra,120(sp)
 944:	7446                	ld	s0,112(sp)
 946:	74a6                	ld	s1,104(sp)
 948:	7906                	ld	s2,96(sp)
 94a:	69e6                	ld	s3,88(sp)
 94c:	6a46                	ld	s4,80(sp)
 94e:	6aa6                	ld	s5,72(sp)
 950:	6b06                	ld	s6,64(sp)
 952:	7be2                	ld	s7,56(sp)
 954:	7c42                	ld	s8,48(sp)
 956:	7ca2                	ld	s9,40(sp)
 958:	7d02                	ld	s10,32(sp)
 95a:	6de2                	ld	s11,24(sp)
 95c:	6109                	addi	sp,sp,128
 95e:	8082                	ret

0000000000000960 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 960:	715d                	addi	sp,sp,-80
 962:	ec06                	sd	ra,24(sp)
 964:	e822                	sd	s0,16(sp)
 966:	1000                	addi	s0,sp,32
 968:	e010                	sd	a2,0(s0)
 96a:	e414                	sd	a3,8(s0)
 96c:	e818                	sd	a4,16(s0)
 96e:	ec1c                	sd	a5,24(s0)
 970:	03043023          	sd	a6,32(s0)
 974:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 978:	8622                	mv	a2,s0
 97a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 97e:	00000097          	auipc	ra,0x0
 982:	e04080e7          	jalr	-508(ra) # 782 <vprintf>
}
 986:	60e2                	ld	ra,24(sp)
 988:	6442                	ld	s0,16(sp)
 98a:	6161                	addi	sp,sp,80
 98c:	8082                	ret

000000000000098e <printf>:

void
printf(const char *fmt, ...)
{
 98e:	711d                	addi	sp,sp,-96
 990:	ec06                	sd	ra,24(sp)
 992:	e822                	sd	s0,16(sp)
 994:	1000                	addi	s0,sp,32
 996:	e40c                	sd	a1,8(s0)
 998:	e810                	sd	a2,16(s0)
 99a:	ec14                	sd	a3,24(s0)
 99c:	f018                	sd	a4,32(s0)
 99e:	f41c                	sd	a5,40(s0)
 9a0:	03043823          	sd	a6,48(s0)
 9a4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9a8:	00840613          	addi	a2,s0,8
 9ac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9b0:	85aa                	mv	a1,a0
 9b2:	4505                	li	a0,1
 9b4:	00000097          	auipc	ra,0x0
 9b8:	dce080e7          	jalr	-562(ra) # 782 <vprintf>
}
 9bc:	60e2                	ld	ra,24(sp)
 9be:	6442                	ld	s0,16(sp)
 9c0:	6125                	addi	sp,sp,96
 9c2:	8082                	ret

00000000000009c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9c4:	1141                	addi	sp,sp,-16
 9c6:	e422                	sd	s0,8(sp)
 9c8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ca:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ce:	00000797          	auipc	a5,0x0
 9d2:	3e27b783          	ld	a5,994(a5) # db0 <freep>
 9d6:	a02d                	j	a00 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9d8:	4618                	lw	a4,8(a2)
 9da:	9f2d                	addw	a4,a4,a1
 9dc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e0:	6398                	ld	a4,0(a5)
 9e2:	6310                	ld	a2,0(a4)
 9e4:	a83d                	j	a22 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9e6:	ff852703          	lw	a4,-8(a0)
 9ea:	9f31                	addw	a4,a4,a2
 9ec:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9ee:	ff053683          	ld	a3,-16(a0)
 9f2:	a091                	j	a36 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f4:	6398                	ld	a4,0(a5)
 9f6:	00e7e463          	bltu	a5,a4,9fe <free+0x3a>
 9fa:	00e6ea63          	bltu	a3,a4,a0e <free+0x4a>
{
 9fe:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a00:	fed7fae3          	bgeu	a5,a3,9f4 <free+0x30>
 a04:	6398                	ld	a4,0(a5)
 a06:	00e6e463          	bltu	a3,a4,a0e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0a:	fee7eae3          	bltu	a5,a4,9fe <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a0e:	ff852583          	lw	a1,-8(a0)
 a12:	6390                	ld	a2,0(a5)
 a14:	02059813          	slli	a6,a1,0x20
 a18:	01c85713          	srli	a4,a6,0x1c
 a1c:	9736                	add	a4,a4,a3
 a1e:	fae60de3          	beq	a2,a4,9d8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a22:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a26:	4790                	lw	a2,8(a5)
 a28:	02061593          	slli	a1,a2,0x20
 a2c:	01c5d713          	srli	a4,a1,0x1c
 a30:	973e                	add	a4,a4,a5
 a32:	fae68ae3          	beq	a3,a4,9e6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a36:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a38:	00000717          	auipc	a4,0x0
 a3c:	36f73c23          	sd	a5,888(a4) # db0 <freep>
}
 a40:	6422                	ld	s0,8(sp)
 a42:	0141                	addi	sp,sp,16
 a44:	8082                	ret

0000000000000a46 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a46:	7139                	addi	sp,sp,-64
 a48:	fc06                	sd	ra,56(sp)
 a4a:	f822                	sd	s0,48(sp)
 a4c:	f426                	sd	s1,40(sp)
 a4e:	f04a                	sd	s2,32(sp)
 a50:	ec4e                	sd	s3,24(sp)
 a52:	e852                	sd	s4,16(sp)
 a54:	e456                	sd	s5,8(sp)
 a56:	e05a                	sd	s6,0(sp)
 a58:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5a:	02051493          	slli	s1,a0,0x20
 a5e:	9081                	srli	s1,s1,0x20
 a60:	04bd                	addi	s1,s1,15
 a62:	8091                	srli	s1,s1,0x4
 a64:	00148a1b          	addiw	s4,s1,1
 a68:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a6a:	00000517          	auipc	a0,0x0
 a6e:	34653503          	ld	a0,838(a0) # db0 <freep>
 a72:	c515                	beqz	a0,a9e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a74:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a76:	4798                	lw	a4,8(a5)
 a78:	04977163          	bgeu	a4,s1,aba <malloc+0x74>
 a7c:	89d2                	mv	s3,s4
 a7e:	000a071b          	sext.w	a4,s4
 a82:	6685                	lui	a3,0x1
 a84:	00d77363          	bgeu	a4,a3,a8a <malloc+0x44>
 a88:	6985                	lui	s3,0x1
 a8a:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 a8e:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a92:	00000917          	auipc	s2,0x0
 a96:	31e90913          	addi	s2,s2,798 # db0 <freep>
  if(p == (char*)-1)
 a9a:	5afd                	li	s5,-1
 a9c:	a8a5                	j	b14 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 a9e:	00000797          	auipc	a5,0x0
 aa2:	31278793          	addi	a5,a5,786 # db0 <freep>
 aa6:	00000717          	auipc	a4,0x0
 aaa:	31270713          	addi	a4,a4,786 # db8 <base>
 aae:	e398                	sd	a4,0(a5)
 ab0:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 ab2:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab6:	87ba                	mv	a5,a4
 ab8:	b7d1                	j	a7c <malloc+0x36>
      if(p->s.size == nunits)
 aba:	02e48c63          	beq	s1,a4,af2 <malloc+0xac>
        p->s.size -= nunits;
 abe:	4147073b          	subw	a4,a4,s4
 ac2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ac4:	02071693          	slli	a3,a4,0x20
 ac8:	01c6d713          	srli	a4,a3,0x1c
 acc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ace:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 ad2:	00000717          	auipc	a4,0x0
 ad6:	2ca73f23          	sd	a0,734(a4) # db0 <freep>
      return (void*)(p + 1);
 ada:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ade:	70e2                	ld	ra,56(sp)
 ae0:	7442                	ld	s0,48(sp)
 ae2:	74a2                	ld	s1,40(sp)
 ae4:	7902                	ld	s2,32(sp)
 ae6:	69e2                	ld	s3,24(sp)
 ae8:	6a42                	ld	s4,16(sp)
 aea:	6aa2                	ld	s5,8(sp)
 aec:	6b02                	ld	s6,0(sp)
 aee:	6121                	addi	sp,sp,64
 af0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 af2:	6398                	ld	a4,0(a5)
 af4:	e118                	sd	a4,0(a0)
 af6:	bff1                	j	ad2 <malloc+0x8c>
  hp->s.size = nu;
 af8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 afc:	0541                	addi	a0,a0,16
 afe:	00000097          	auipc	ra,0x0
 b02:	ec6080e7          	jalr	-314(ra) # 9c4 <free>
  return freep;
 b06:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b0a:	d971                	beqz	a0,ade <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b0e:	4798                	lw	a4,8(a5)
 b10:	fa9775e3          	bgeu	a4,s1,aba <malloc+0x74>
    if(p == freep)
 b14:	00093703          	ld	a4,0(s2)
 b18:	853e                	mv	a0,a5
 b1a:	fef719e3          	bne	a4,a5,b0c <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 b1e:	854e                	mv	a0,s3
 b20:	00000097          	auipc	ra,0x0
 b24:	95e080e7          	jalr	-1698(ra) # 47e <sbrk>
  if(p == (char*)-1)
 b28:	fd5518e3          	bne	a0,s5,af8 <malloc+0xb2>
        return 0;
 b2c:	4501                	li	a0,0
 b2e:	bf45                	j	ade <malloc+0x98>
