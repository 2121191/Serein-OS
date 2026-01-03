
serein-user/_vmstat：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print_sysinfo_mem>:
#include "kernel/include/sysinfo.h"
#include "user.h"

static void
print_sysinfo_mem(const char *tag)
{
   0:	7135                	addi	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	e14a                	sd	s2,128(sp)
   a:	fcce                	sd	s3,120(sp)
   c:	1100                	addi	s0,sp,160
   e:	892a                	mv	s2,a0
  struct sysinfo info;
  if(sysinfo(&info) < 0){
  10:	f6840513          	addi	a0,s0,-152
  14:	00000097          	auipc	ra,0x0
  18:	780080e7          	jalr	1920(ra) # 794 <sysinfo>
  1c:	06054f63          	bltz	a0,9a <print_sysinfo_mem+0x9a>
    printf("sysinfo failed\n");
    return;
  }

  uint total_kb = 128U * 1024U; // 128MB
  uint free_kb = (uint)(info.freemem / 1024);
  20:	f6843483          	ld	s1,-152(s0)
  24:	80a9                	srli	s1,s1,0xa
  26:	0004879b          	sext.w	a5,s1
  uint used_kb = (total_kb > free_kb) ? (total_kb - free_kb) : 0;
  2a:	00020737          	lui	a4,0x20
  2e:	4981                	li	s3,0
  30:	00e7f663          	bgeu	a5,a4,3c <print_sysinfo_mem+0x3c>
  34:	000209b7          	lui	s3,0x20
  38:	40f989bb          	subw	s3,s3,a5
  int used_percent = (total_kb == 0) ? 0 : (int)((used_kb * 100U) / total_kb);

  printf("\n[%s]\n", tag);
  3c:	85ca                	mv	a1,s2
  3e:	00001517          	auipc	a0,0x1
  42:	dc250513          	addi	a0,a0,-574 # e00 <malloc+0xec>
  46:	00001097          	auipc	ra,0x1
  4a:	c16080e7          	jalr	-1002(ra) # c5c <printf>
  int used_percent = (total_kb == 0) ? 0 : (int)((used_kb * 100U) / total_kb);
  4e:	06400793          	li	a5,100
  52:	033787bb          	mulw	a5,a5,s3
  printf("tick=%d proc=%d free=%dKB used=%dKB (%d%%)\n",
  56:	0117d79b          	srliw	a5,a5,0x11
  5a:	874e                	mv	a4,s3
  5c:	0004869b          	sext.w	a3,s1
  60:	f7042603          	lw	a2,-144(s0)
  64:	f7842583          	lw	a1,-136(s0)
  68:	00001517          	auipc	a0,0x1
  6c:	da050513          	addi	a0,a0,-608 # e08 <malloc+0xf4>
  70:	00001097          	auipc	ra,0x1
  74:	bec080e7          	jalr	-1044(ra) # c5c <printf>
         (int)info.uptime,
         (int)info.nproc,
         (int)free_kb,
         (int)used_kb,
         used_percent);
  printf("events: cow_faults=%d\n", (int)info.cow_pages);
  78:	f8042583          	lw	a1,-128(s0)
  7c:	00001517          	auipc	a0,0x1
  80:	dbc50513          	addi	a0,a0,-580 # e38 <malloc+0x124>
  84:	00001097          	auipc	ra,0x1
  88:	bd8080e7          	jalr	-1064(ra) # c5c <printf>
}
  8c:	60ea                	ld	ra,152(sp)
  8e:	644a                	ld	s0,144(sp)
  90:	64aa                	ld	s1,136(sp)
  92:	690a                	ld	s2,128(sp)
  94:	79e6                	ld	s3,120(sp)
  96:	610d                	addi	sp,sp,160
  98:	8082                	ret
    printf("sysinfo failed\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	f3650513          	addi	a0,a0,-202 # fd0 <malloc+0x2bc>
  a2:	00001097          	auipc	ra,0x1
  a6:	bba080e7          	jalr	-1094(ra) # c5c <printf>
    return;
  aa:	b7cd                	j	8c <print_sysinfo_mem+0x8c>

00000000000000ac <main>:
  }
}

int
main(int argc, char *argv[])
{
  ac:	7169                	addi	sp,sp,-304
  ae:	f606                	sd	ra,296(sp)
  b0:	f222                	sd	s0,288(sp)
  b2:	ee26                	sd	s1,280(sp)
  b4:	ea4a                	sd	s2,272(sp)
  b6:	e64e                	sd	s3,264(sp)
  b8:	e252                	sd	s4,256(sp)
  ba:	fdd6                	sd	s5,248(sp)
  bc:	f9da                	sd	s6,240(sp)
  be:	f5de                	sd	s7,232(sp)
  c0:	f1e2                	sd	s8,224(sp)
  c2:	ede6                	sd	s9,216(sp)
  c4:	e9ea                	sd	s10,208(sp)
  c6:	1a00                	addi	s0,sp,304
  // 无参数：跑测试，且显示 mem 输出
  if(argc == 1){
  c8:	4785                	li	a5,1
  ca:	0cf50263          	beq	a0,a5,18e <main+0xe2>
  ce:	84aa                	mv	s1,a0
  d0:	89ae                	mv	s3,a1

  // 有参数：监控模式，不输出 mem 详细信息（只输出表格）
  int delay_sec = 1;
  int rounds = 10;

  if(argc >= 2){
  d2:	4785                	li	a5,1
  int delay_sec = 1;
  d4:	4a05                	li	s4,1
  if(argc >= 2){
  d6:	20a7c863          	blt	a5,a0,2e6 <main+0x23a>
    delay_sec = atoi(argv[1]);
    if(delay_sec <= 0) delay_sec = 1;
  }
  if(argc >= 3){
  da:	4789                	li	a5,2
  int rounds = 10;
  dc:	4929                	li	s2,10
  if(argc >= 3){
  de:	2297c063          	blt	a5,s1,2fe <main+0x252>
  for(uint i = 0; i < sizeof(prev); i++)
  e2:	ed040793          	addi	a5,s0,-304
  e6:	f3840713          	addi	a4,s0,-200
    ((char*)&prev)[i] = 0;
  ea:	00078023          	sb	zero,0(a5)
  for(uint i = 0; i < sizeof(prev); i++)
  ee:	0785                	addi	a5,a5,1
  f0:	fee79de3          	bne	a5,a4,ea <main+0x3e>
  if(sysinfo(&prev) < 0){
  f4:	ed040513          	addi	a0,s0,-304
  f8:	00000097          	auipc	ra,0x0
  fc:	69c080e7          	jalr	1692(ra) # 794 <sysinfo>
 100:	20054c63          	bltz	a0,318 <main+0x26c>
  printf("vmstat monitor: use vmstat [sec] [n]\n");
 104:	00001517          	auipc	a0,0x1
 108:	edc50513          	addi	a0,a0,-292 # fe0 <malloc+0x2cc>
 10c:	00001097          	auipc	ra,0x1
 110:	b50080e7          	jalr	-1200(ra) # c5c <printf>
  printf("%-6s %-7s %-6s %-5s %-5s\n",
 114:	00001797          	auipc	a5,0x1
 118:	ef478793          	addi	a5,a5,-268 # 1008 <malloc+0x2f4>
 11c:	00001717          	auipc	a4,0x1
 120:	ef470713          	addi	a4,a4,-268 # 1010 <malloc+0x2fc>
 124:	00001697          	auipc	a3,0x1
 128:	ef468693          	addi	a3,a3,-268 # 1018 <malloc+0x304>
 12c:	00001617          	auipc	a2,0x1
 130:	ef460613          	addi	a2,a2,-268 # 1020 <malloc+0x30c>
 134:	00001597          	auipc	a1,0x1
 138:	ef458593          	addi	a1,a1,-268 # 1028 <malloc+0x314>
 13c:	00001517          	auipc	a0,0x1
 140:	ef450513          	addi	a0,a0,-268 # 1030 <malloc+0x31c>
 144:	00001097          	auipc	ra,0x1
 148:	b18080e7          	jalr	-1256(ra) # c5c <printf>
  printf("--------------------------------\n");
 14c:	00001517          	auipc	a0,0x1
 150:	f0450513          	addi	a0,a0,-252 # 1050 <malloc+0x33c>
 154:	00001097          	auipc	ra,0x1
 158:	b08080e7          	jalr	-1272(ra) # c5c <printf>
  while(rounds-- > 0){
 15c:	397d                	addiw	s2,s2,-1
 15e:	06400c93          	li	s9,100
 162:	034c8cbb          	mulw	s9,s9,s4
    if(sysinfo(&cur) < 0){
 166:	f3840c13          	addi	s8,s0,-200
    uint used_kb = (total_kb > free_kb) ? (total_kb - free_kb) : 0;
 16a:	00020bb7          	lui	s7,0x20
 16e:	4b01                	li	s6,0
 170:	00020d37          	lui	s10,0x20
    int used_percent = (total_kb == 0) ? 0 : (int)((used_kb * 100U) / total_kb);
 174:	06400a93          	li	s5,100
    printf("%-6d %-7d %3d%%   %-5d %-5d\n",
 178:	00001a17          	auipc	s4,0x1
 17c:	f00a0a13          	addi	s4,s4,-256 # 1078 <malloc+0x364>
    printf("       kalloc delta: cpu0 %d/%d/%d  cpu1 %d/%d/%d\n",
 180:	00001997          	auipc	s3,0x1
 184:	f1898993          	addi	s3,s3,-232 # 1098 <malloc+0x384>
    prev = cur;
 188:	f9840493          	addi	s1,s0,-104
 18c:	a4bd                	j	3fa <main+0x34e>
  printf("Running memory tests (lazy alloc + COW)...\n");
 18e:	00001517          	auipc	a0,0x1
 192:	cc250513          	addi	a0,a0,-830 # e50 <malloc+0x13c>
 196:	00001097          	auipc	ra,0x1
 19a:	ac6080e7          	jalr	-1338(ra) # c5c <printf>
  print_sysinfo_mem("initial state");
 19e:	00001517          	auipc	a0,0x1
 1a2:	ce250513          	addi	a0,a0,-798 # e80 <malloc+0x16c>
 1a6:	00000097          	auipc	ra,0x0
 1aa:	e5a080e7          	jalr	-422(ra) # 0 <print_sysinfo_mem>
  printf("\n=== Testing Lazy Allocation ===\n");
 1ae:	00001517          	auipc	a0,0x1
 1b2:	ce250513          	addi	a0,a0,-798 # e90 <malloc+0x17c>
 1b6:	00001097          	auipc	ra,0x1
 1ba:	aa6080e7          	jalr	-1370(ra) # c5c <printf>
  printf("sbrk(%d KB) without touching...\n", (np * 4096) / 1024);
 1be:	04000593          	li	a1,64
 1c2:	00001517          	auipc	a0,0x1
 1c6:	cf650513          	addi	a0,a0,-778 # eb8 <malloc+0x1a4>
 1ca:	00001097          	auipc	ra,0x1
 1ce:	a92080e7          	jalr	-1390(ra) # c5c <printf>
  char *p = sbrk(np * 4096);
 1d2:	6541                	lui	a0,0x10
 1d4:	00000097          	auipc	ra,0x0
 1d8:	578080e7          	jalr	1400(ra) # 74c <sbrk>
 1dc:	84aa                	mv	s1,a0
  if(p == (char*)-1){
 1de:	57fd                	li	a5,-1
 1e0:	0cf50363          	beq	a0,a5,2a6 <main+0x1fa>
  print_sysinfo_mem("after sbrk (before touch)");
 1e4:	00001517          	auipc	a0,0x1
 1e8:	d0c50513          	addi	a0,a0,-756 # ef0 <malloc+0x1dc>
 1ec:	00000097          	auipc	ra,0x0
 1f0:	e14080e7          	jalr	-492(ra) # 0 <print_sysinfo_mem>
  printf("touching pages...\n");
 1f4:	00001517          	auipc	a0,0x1
 1f8:	d1c50513          	addi	a0,a0,-740 # f10 <malloc+0x1fc>
 1fc:	00001097          	auipc	ra,0x1
 200:	a60080e7          	jalr	-1440(ra) # c5c <printf>
  for(int i = 0; i < np; i++)
 204:	8926                	mv	s2,s1
  printf("touching pages...\n");
 206:	8726                	mv	a4,s1
  for(int i = 0; i < np; i++)
 208:	4781                	li	a5,0
 20a:	6605                	lui	a2,0x1
 20c:	46c1                	li	a3,16
    p[i * 4096] = (char)i;
 20e:	00f70023          	sb	a5,0(a4)
  for(int i = 0; i < np; i++)
 212:	2785                	addiw	a5,a5,1
 214:	9732                	add	a4,a4,a2
 216:	fed79ce3          	bne	a5,a3,20e <main+0x162>
  print_sysinfo_mem("after touching pages");
 21a:	00001517          	auipc	a0,0x1
 21e:	d0e50513          	addi	a0,a0,-754 # f28 <malloc+0x214>
 222:	00000097          	auipc	ra,0x0
 226:	dde080e7          	jalr	-546(ra) # 0 <print_sysinfo_mem>
  printf("\n=== Testing Copy-on-Write ===\n");
 22a:	00001517          	auipc	a0,0x1
 22e:	d1650513          	addi	a0,a0,-746 # f40 <malloc+0x22c>
 232:	00001097          	auipc	ra,0x1
 236:	a2a080e7          	jalr	-1494(ra) # c5c <printf>
  printf("forking...\n");
 23a:	00001517          	auipc	a0,0x1
 23e:	d2650513          	addi	a0,a0,-730 # f60 <malloc+0x24c>
 242:	00001097          	auipc	ra,0x1
 246:	a1a080e7          	jalr	-1510(ra) # c5c <printf>
  int pid = fork();
 24a:	00000097          	auipc	ra,0x0
 24e:	48a080e7          	jalr	1162(ra) # 6d4 <fork>
  if(pid < 0){
 252:	06054363          	bltz	a0,2b8 <main+0x20c>
  if(pid == 0){
 256:	c935                	beqz	a0,2ca <main+0x21e>
  wait(0);
 258:	4501                	li	a0,0
 25a:	00000097          	auipc	ra,0x0
 25e:	48a080e7          	jalr	1162(ra) # 6e4 <wait>
  print_sysinfo_mem("parent after child COW");
 262:	00001517          	auipc	a0,0x1
 266:	d1e50513          	addi	a0,a0,-738 # f80 <malloc+0x26c>
 26a:	00000097          	auipc	ra,0x0
 26e:	d96080e7          	jalr	-618(ra) # 0 <print_sysinfo_mem>
  sbrk(-np * 4096);
 272:	7541                	lui	a0,0xffff0
 274:	00000097          	auipc	ra,0x0
 278:	4d8080e7          	jalr	1240(ra) # 74c <sbrk>
  print_sysinfo_mem("after sbrk(-size)");
 27c:	00001517          	auipc	a0,0x1
 280:	d1c50513          	addi	a0,a0,-740 # f98 <malloc+0x284>
 284:	00000097          	auipc	ra,0x0
 288:	d7c080e7          	jalr	-644(ra) # 0 <print_sysinfo_mem>
  printf("\nTests completed.\n");
 28c:	00001517          	auipc	a0,0x1
 290:	d2450513          	addi	a0,a0,-732 # fb0 <malloc+0x29c>
 294:	00001097          	auipc	ra,0x1
 298:	9c8080e7          	jalr	-1592(ra) # c5c <printf>
    exit(0);
 29c:	4501                	li	a0,0
 29e:	00000097          	auipc	ra,0x0
 2a2:	43e080e7          	jalr	1086(ra) # 6dc <exit>
    printf("sbrk failed\n");
 2a6:	00001517          	auipc	a0,0x1
 2aa:	c3a50513          	addi	a0,a0,-966 # ee0 <malloc+0x1cc>
 2ae:	00001097          	auipc	ra,0x1
 2b2:	9ae080e7          	jalr	-1618(ra) # c5c <printf>
    return;
 2b6:	b7dd                	j	29c <main+0x1f0>
    printf("fork failed\n");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	cb850513          	addi	a0,a0,-840 # f70 <malloc+0x25c>
 2c0:	00001097          	auipc	ra,0x1
 2c4:	99c080e7          	jalr	-1636(ra) # c5c <printf>
    return;
 2c8:	bfd1                	j	29c <main+0x1f0>
 2ca:	4785                	li	a5,1
    for(int i = 0; i < np; i++)
 2cc:	6685                	lui	a3,0x1
 2ce:	4745                	li	a4,17
      p[i * 4096] = (char)(i + 1);
 2d0:	00f90023          	sb	a5,0(s2)
    for(int i = 0; i < np; i++)
 2d4:	0785                	addi	a5,a5,1
 2d6:	9936                	add	s2,s2,a3
 2d8:	fee79ce3          	bne	a5,a4,2d0 <main+0x224>
    exit(0);
 2dc:	4501                	li	a0,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	3fe080e7          	jalr	1022(ra) # 6dc <exit>
    delay_sec = atoi(argv[1]);
 2e6:	6588                	ld	a0,8(a1)
 2e8:	00000097          	auipc	ra,0x0
 2ec:	2e2080e7          	jalr	738(ra) # 5ca <atoi>
    if(delay_sec <= 0) delay_sec = 1;
 2f0:	8a2a                	mv	s4,a0
 2f2:	00a05463          	blez	a0,2fa <main+0x24e>
 2f6:	2a01                	sext.w	s4,s4
 2f8:	b3cd                	j	da <main+0x2e>
 2fa:	4a05                	li	s4,1
 2fc:	bfed                	j	2f6 <main+0x24a>
    rounds = atoi(argv[2]);
 2fe:	0109b503          	ld	a0,16(s3)
 302:	00000097          	auipc	ra,0x0
 306:	2c8080e7          	jalr	712(ra) # 5ca <atoi>
    if(rounds <= 0) rounds = 1;
 30a:	892a                	mv	s2,a0
 30c:	00a05463          	blez	a0,314 <main+0x268>
 310:	2901                	sext.w	s2,s2
 312:	bbc1                	j	e2 <main+0x36>
 314:	4905                	li	s2,1
 316:	bfed                	j	310 <main+0x264>
    printf("vmstat: sysinfo failed\n");
 318:	00001517          	auipc	a0,0x1
 31c:	cb050513          	addi	a0,a0,-848 # fc8 <malloc+0x2b4>
 320:	00001097          	auipc	ra,0x1
 324:	93c080e7          	jalr	-1732(ra) # c5c <printf>
    exit(1);
 328:	4505                	li	a0,1
 32a:	00000097          	auipc	ra,0x0
 32e:	3b2080e7          	jalr	946(ra) # 6dc <exit>
      printf("vmstat: sysinfo failed\n");
 332:	00001517          	auipc	a0,0x1
 336:	c9650513          	addi	a0,a0,-874 # fc8 <malloc+0x2b4>
 33a:	00001097          	auipc	ra,0x1
 33e:	922080e7          	jalr	-1758(ra) # c5c <printf>
      exit(1);
 342:	4505                	li	a0,1
 344:	00000097          	auipc	ra,0x0
 348:	398080e7          	jalr	920(ra) # 6dc <exit>
    uint used_kb = (total_kb > free_kb) ? (total_kb - free_kb) : 0;
 34c:	40fd06bb          	subw	a3,s10,a5
    int used_percent = (total_kb == 0) ? 0 : (int)((used_kb * 100U) / total_kb);
 350:	02da86bb          	mulw	a3,s5,a3
    printf("%-6d %-7d %3d%%   %-5d %-5d\n",
 354:	f5042783          	lw	a5,-176(s0)
 358:	f4042703          	lw	a4,-192(s0)
 35c:	0116d69b          	srliw	a3,a3,0x11
 360:	2601                	sext.w	a2,a2
 362:	f4842583          	lw	a1,-184(s0)
 366:	8552                	mv	a0,s4
 368:	00001097          	auipc	ra,0x1
 36c:	8f4080e7          	jalr	-1804(ra) # c5c <printf>
    printf("       kalloc delta: cpu0 %d/%d/%d  cpu1 %d/%d/%d\n",
 370:	f9043803          	ld	a6,-112(s0)
 374:	f2843783          	ld	a5,-216(s0)
 378:	40f8083b          	subw	a6,a6,a5
 37c:	f8843703          	ld	a4,-120(s0)
 380:	f2043783          	ld	a5,-224(s0)
 384:	40f707bb          	subw	a5,a4,a5
 388:	f8043683          	ld	a3,-128(s0)
 38c:	f1843703          	ld	a4,-232(s0)
 390:	40e6873b          	subw	a4,a3,a4
 394:	f7843603          	ld	a2,-136(s0)
 398:	f1043683          	ld	a3,-240(s0)
 39c:	40d606bb          	subw	a3,a2,a3
 3a0:	f7043583          	ld	a1,-144(s0)
 3a4:	f0843603          	ld	a2,-248(s0)
 3a8:	40c5863b          	subw	a2,a1,a2
 3ac:	f6843503          	ld	a0,-152(s0)
 3b0:	f0043583          	ld	a1,-256(s0)
 3b4:	40b505bb          	subw	a1,a0,a1
 3b8:	854e                	mv	a0,s3
 3ba:	00001097          	auipc	ra,0x1
 3be:	8a2080e7          	jalr	-1886(ra) # c5c <printf>
    prev = cur;
 3c2:	f3840793          	addi	a5,s0,-200
 3c6:	ed040713          	addi	a4,s0,-304
 3ca:	6388                	ld	a0,0(a5)
 3cc:	678c                	ld	a1,8(a5)
 3ce:	6b90                	ld	a2,16(a5)
 3d0:	6f94                	ld	a3,24(a5)
 3d2:	e308                	sd	a0,0(a4)
 3d4:	e70c                	sd	a1,8(a4)
 3d6:	eb10                	sd	a2,16(a4)
 3d8:	ef14                	sd	a3,24(a4)
 3da:	02078793          	addi	a5,a5,32
 3de:	02070713          	addi	a4,a4,32
 3e2:	fe9794e3          	bne	a5,s1,3ca <main+0x31e>
 3e6:	639c                	ld	a5,0(a5)
 3e8:	e31c                	sd	a5,0(a4)
    if(rounds > 0)
 3ea:	02090863          	beqz	s2,41a <main+0x36e>
      sleep(delay_sec * 100);
 3ee:	8566                	mv	a0,s9
 3f0:	00000097          	auipc	ra,0x0
 3f4:	364080e7          	jalr	868(ra) # 754 <sleep>
  while(rounds-- > 0){
 3f8:	397d                	addiw	s2,s2,-1
    if(sysinfo(&cur) < 0){
 3fa:	8562                	mv	a0,s8
 3fc:	00000097          	auipc	ra,0x0
 400:	398080e7          	jalr	920(ra) # 794 <sysinfo>
 404:	f20547e3          	bltz	a0,332 <main+0x286>
    uint free_kb = (uint)(cur.freemem / 1024);
 408:	f3843603          	ld	a2,-200(s0)
 40c:	8229                	srli	a2,a2,0xa
 40e:	0006079b          	sext.w	a5,a2
    uint used_kb = (total_kb > free_kb) ? (total_kb - free_kb) : 0;
 412:	86da                	mv	a3,s6
 414:	f377fee3          	bgeu	a5,s7,350 <main+0x2a4>
 418:	bf15                	j	34c <main+0x2a0>
  }

  monitor_vmstat(delay_sec, rounds);
  exit(0);
 41a:	4501                	li	a0,0
 41c:	00000097          	auipc	ra,0x0
 420:	2c0080e7          	jalr	704(ra) # 6dc <exit>

0000000000000424 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 424:	1141                	addi	sp,sp,-16
 426:	e422                	sd	s0,8(sp)
 428:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 42a:	87aa                	mv	a5,a0
 42c:	0585                	addi	a1,a1,1
 42e:	0785                	addi	a5,a5,1
 430:	fff5c703          	lbu	a4,-1(a1)
 434:	fee78fa3          	sb	a4,-1(a5)
 438:	fb75                	bnez	a4,42c <strcpy+0x8>
    ;
  return os;
}
 43a:	6422                	ld	s0,8(sp)
 43c:	0141                	addi	sp,sp,16
 43e:	8082                	ret

0000000000000440 <strcat>:

char*
strcat(char *s, const char *t)
{
 440:	1141                	addi	sp,sp,-16
 442:	e422                	sd	s0,8(sp)
 444:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 446:	00054783          	lbu	a5,0(a0)
 44a:	c385                	beqz	a5,46a <strcat+0x2a>
 44c:	87aa                	mv	a5,a0
    s++;
 44e:	0785                	addi	a5,a5,1
  while(*s)
 450:	0007c703          	lbu	a4,0(a5)
 454:	ff6d                	bnez	a4,44e <strcat+0xe>
  while((*s++ = *t++))
 456:	0585                	addi	a1,a1,1
 458:	0785                	addi	a5,a5,1
 45a:	fff5c703          	lbu	a4,-1(a1)
 45e:	fee78fa3          	sb	a4,-1(a5)
 462:	fb75                	bnez	a4,456 <strcat+0x16>
    ;
  return os;
}
 464:	6422                	ld	s0,8(sp)
 466:	0141                	addi	sp,sp,16
 468:	8082                	ret
  while(*s)
 46a:	87aa                	mv	a5,a0
 46c:	b7ed                	j	456 <strcat+0x16>

000000000000046e <strcmp>:


int
strcmp(const char *p, const char *q)
{
 46e:	1141                	addi	sp,sp,-16
 470:	e422                	sd	s0,8(sp)
 472:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 474:	00054783          	lbu	a5,0(a0)
 478:	cb91                	beqz	a5,48c <strcmp+0x1e>
 47a:	0005c703          	lbu	a4,0(a1)
 47e:	00f71763          	bne	a4,a5,48c <strcmp+0x1e>
    p++, q++;
 482:	0505                	addi	a0,a0,1
 484:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 486:	00054783          	lbu	a5,0(a0)
 48a:	fbe5                	bnez	a5,47a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 48c:	0005c503          	lbu	a0,0(a1)
}
 490:	40a7853b          	subw	a0,a5,a0
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret

000000000000049a <strlen>:

uint
strlen(const char *s)
{
 49a:	1141                	addi	sp,sp,-16
 49c:	e422                	sd	s0,8(sp)
 49e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4a0:	00054783          	lbu	a5,0(a0)
 4a4:	cf91                	beqz	a5,4c0 <strlen+0x26>
 4a6:	0505                	addi	a0,a0,1
 4a8:	87aa                	mv	a5,a0
 4aa:	4685                	li	a3,1
 4ac:	9e89                	subw	a3,a3,a0
 4ae:	00f6853b          	addw	a0,a3,a5
 4b2:	0785                	addi	a5,a5,1
 4b4:	fff7c703          	lbu	a4,-1(a5)
 4b8:	fb7d                	bnez	a4,4ae <strlen+0x14>
    ;
  return n;
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
  for(n = 0; s[n]; n++)
 4c0:	4501                	li	a0,0
 4c2:	bfe5                	j	4ba <strlen+0x20>

00000000000004c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e422                	sd	s0,8(sp)
 4c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4ca:	ca19                	beqz	a2,4e0 <memset+0x1c>
 4cc:	87aa                	mv	a5,a0
 4ce:	1602                	slli	a2,a2,0x20
 4d0:	9201                	srli	a2,a2,0x20
 4d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4da:	0785                	addi	a5,a5,1
 4dc:	fee79de3          	bne	a5,a4,4d6 <memset+0x12>
  }
  return dst;
}
 4e0:	6422                	ld	s0,8(sp)
 4e2:	0141                	addi	sp,sp,16
 4e4:	8082                	ret

00000000000004e6 <strchr>:

char*
strchr(const char *s, char c)
{
 4e6:	1141                	addi	sp,sp,-16
 4e8:	e422                	sd	s0,8(sp)
 4ea:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4ec:	00054783          	lbu	a5,0(a0)
 4f0:	cb99                	beqz	a5,506 <strchr+0x20>
    if(*s == c)
 4f2:	00f58763          	beq	a1,a5,500 <strchr+0x1a>
  for(; *s; s++)
 4f6:	0505                	addi	a0,a0,1
 4f8:	00054783          	lbu	a5,0(a0)
 4fc:	fbfd                	bnez	a5,4f2 <strchr+0xc>
      return (char*)s;
  return 0;
 4fe:	4501                	li	a0,0
}
 500:	6422                	ld	s0,8(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret
  return 0;
 506:	4501                	li	a0,0
 508:	bfe5                	j	500 <strchr+0x1a>

000000000000050a <gets>:

char*
gets(char *buf, int max)
{
 50a:	711d                	addi	sp,sp,-96
 50c:	ec86                	sd	ra,88(sp)
 50e:	e8a2                	sd	s0,80(sp)
 510:	e4a6                	sd	s1,72(sp)
 512:	e0ca                	sd	s2,64(sp)
 514:	fc4e                	sd	s3,56(sp)
 516:	f852                	sd	s4,48(sp)
 518:	f456                	sd	s5,40(sp)
 51a:	f05a                	sd	s6,32(sp)
 51c:	ec5e                	sd	s7,24(sp)
 51e:	e862                	sd	s8,16(sp)
 520:	1080                	addi	s0,sp,96
 522:	8baa                	mv	s7,a0
 524:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 526:	892a                	mv	s2,a0
 528:	4481                	li	s1,0
    cc = read(0, &c, 1);
 52a:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 52e:	4b29                	li	s6,10
 530:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 532:	89a6                	mv	s3,s1
 534:	2485                	addiw	s1,s1,1
 536:	0344d763          	bge	s1,s4,564 <gets+0x5a>
    cc = read(0, &c, 1);
 53a:	4605                	li	a2,1
 53c:	85d6                	mv	a1,s5
 53e:	4501                	li	a0,0
 540:	00000097          	auipc	ra,0x0
 544:	1b4080e7          	jalr	436(ra) # 6f4 <read>
    if(cc < 1)
 548:	00a05e63          	blez	a0,564 <gets+0x5a>
    buf[i++] = c;
 54c:	faf44783          	lbu	a5,-81(s0)
 550:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 554:	01678763          	beq	a5,s6,562 <gets+0x58>
 558:	0905                	addi	s2,s2,1
 55a:	fd879ce3          	bne	a5,s8,532 <gets+0x28>
  for(i=0; i+1 < max; ){
 55e:	89a6                	mv	s3,s1
 560:	a011                	j	564 <gets+0x5a>
 562:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 564:	99de                	add	s3,s3,s7
 566:	00098023          	sb	zero,0(s3)
  return buf;
}
 56a:	855e                	mv	a0,s7
 56c:	60e6                	ld	ra,88(sp)
 56e:	6446                	ld	s0,80(sp)
 570:	64a6                	ld	s1,72(sp)
 572:	6906                	ld	s2,64(sp)
 574:	79e2                	ld	s3,56(sp)
 576:	7a42                	ld	s4,48(sp)
 578:	7aa2                	ld	s5,40(sp)
 57a:	7b02                	ld	s6,32(sp)
 57c:	6be2                	ld	s7,24(sp)
 57e:	6c42                	ld	s8,16(sp)
 580:	6125                	addi	sp,sp,96
 582:	8082                	ret

0000000000000584 <stat>:

int
stat(const char *n, struct stat *st)
{
 584:	1101                	addi	sp,sp,-32
 586:	ec06                	sd	ra,24(sp)
 588:	e822                	sd	s0,16(sp)
 58a:	e426                	sd	s1,8(sp)
 58c:	e04a                	sd	s2,0(sp)
 58e:	1000                	addi	s0,sp,32
 590:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 592:	4581                	li	a1,0
 594:	00000097          	auipc	ra,0x0
 598:	188080e7          	jalr	392(ra) # 71c <open>
  if(fd < 0)
 59c:	02054563          	bltz	a0,5c6 <stat+0x42>
 5a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5a2:	85ca                	mv	a1,s2
 5a4:	00000097          	auipc	ra,0x0
 5a8:	180080e7          	jalr	384(ra) # 724 <fstat>
 5ac:	892a                	mv	s2,a0
  close(fd);
 5ae:	8526                	mv	a0,s1
 5b0:	00000097          	auipc	ra,0x0
 5b4:	154080e7          	jalr	340(ra) # 704 <close>
  return r;
}
 5b8:	854a                	mv	a0,s2
 5ba:	60e2                	ld	ra,24(sp)
 5bc:	6442                	ld	s0,16(sp)
 5be:	64a2                	ld	s1,8(sp)
 5c0:	6902                	ld	s2,0(sp)
 5c2:	6105                	addi	sp,sp,32
 5c4:	8082                	ret
    return -1;
 5c6:	597d                	li	s2,-1
 5c8:	bfc5                	j	5b8 <stat+0x34>

00000000000005ca <atoi>:

int
atoi(const char *s)
{
 5ca:	1141                	addi	sp,sp,-16
 5cc:	e422                	sd	s0,8(sp)
 5ce:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 5d0:	00054703          	lbu	a4,0(a0)
 5d4:	02d00793          	li	a5,45
  int neg = 1;
 5d8:	4585                	li	a1,1
  if (*s == '-') {
 5da:	04f70363          	beq	a4,a5,620 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 5de:	00054703          	lbu	a4,0(a0)
 5e2:	fd07079b          	addiw	a5,a4,-48
 5e6:	0ff7f793          	zext.b	a5,a5
 5ea:	46a5                	li	a3,9
 5ec:	02f6ed63          	bltu	a3,a5,626 <atoi+0x5c>
  n = 0;
 5f0:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 5f2:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 5f4:	0505                	addi	a0,a0,1
 5f6:	0026979b          	slliw	a5,a3,0x2
 5fa:	9fb5                	addw	a5,a5,a3
 5fc:	0017979b          	slliw	a5,a5,0x1
 600:	9fb9                	addw	a5,a5,a4
 602:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 606:	00054703          	lbu	a4,0(a0)
 60a:	fd07079b          	addiw	a5,a4,-48
 60e:	0ff7f793          	zext.b	a5,a5
 612:	fef671e3          	bgeu	a2,a5,5f4 <atoi+0x2a>
  return n * neg;
}
 616:	02d5853b          	mulw	a0,a1,a3
 61a:	6422                	ld	s0,8(sp)
 61c:	0141                	addi	sp,sp,16
 61e:	8082                	ret
    s++;
 620:	0505                	addi	a0,a0,1
    neg = -1;
 622:	55fd                	li	a1,-1
 624:	bf6d                	j	5de <atoi+0x14>
  n = 0;
 626:	4681                	li	a3,0
 628:	b7fd                	j	616 <atoi+0x4c>

000000000000062a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 62a:	1141                	addi	sp,sp,-16
 62c:	e422                	sd	s0,8(sp)
 62e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 630:	02b57463          	bgeu	a0,a1,658 <memmove+0x2e>
    while(n-- > 0)
 634:	00c05f63          	blez	a2,652 <memmove+0x28>
 638:	1602                	slli	a2,a2,0x20
 63a:	9201                	srli	a2,a2,0x20
 63c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 640:	872a                	mv	a4,a0
      *dst++ = *src++;
 642:	0585                	addi	a1,a1,1
 644:	0705                	addi	a4,a4,1
 646:	fff5c683          	lbu	a3,-1(a1)
 64a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 64e:	fee79ae3          	bne	a5,a4,642 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 652:	6422                	ld	s0,8(sp)
 654:	0141                	addi	sp,sp,16
 656:	8082                	ret
    dst += n;
 658:	00c50733          	add	a4,a0,a2
    src += n;
 65c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 65e:	fec05ae3          	blez	a2,652 <memmove+0x28>
 662:	fff6079b          	addiw	a5,a2,-1 # fff <malloc+0x2eb>
 666:	1782                	slli	a5,a5,0x20
 668:	9381                	srli	a5,a5,0x20
 66a:	fff7c793          	not	a5,a5
 66e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 670:	15fd                	addi	a1,a1,-1
 672:	177d                	addi	a4,a4,-1
 674:	0005c683          	lbu	a3,0(a1)
 678:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 67c:	fee79ae3          	bne	a5,a4,670 <memmove+0x46>
 680:	bfc9                	j	652 <memmove+0x28>

0000000000000682 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 682:	1141                	addi	sp,sp,-16
 684:	e422                	sd	s0,8(sp)
 686:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 688:	ca05                	beqz	a2,6b8 <memcmp+0x36>
 68a:	fff6069b          	addiw	a3,a2,-1
 68e:	1682                	slli	a3,a3,0x20
 690:	9281                	srli	a3,a3,0x20
 692:	0685                	addi	a3,a3,1 # 1001 <malloc+0x2ed>
 694:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 696:	00054783          	lbu	a5,0(a0)
 69a:	0005c703          	lbu	a4,0(a1)
 69e:	00e79863          	bne	a5,a4,6ae <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 6a2:	0505                	addi	a0,a0,1
    p2++;
 6a4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 6a6:	fed518e3          	bne	a0,a3,696 <memcmp+0x14>
  }
  return 0;
 6aa:	4501                	li	a0,0
 6ac:	a019                	j	6b2 <memcmp+0x30>
      return *p1 - *p2;
 6ae:	40e7853b          	subw	a0,a5,a4
}
 6b2:	6422                	ld	s0,8(sp)
 6b4:	0141                	addi	sp,sp,16
 6b6:	8082                	ret
  return 0;
 6b8:	4501                	li	a0,0
 6ba:	bfe5                	j	6b2 <memcmp+0x30>

00000000000006bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6bc:	1141                	addi	sp,sp,-16
 6be:	e406                	sd	ra,8(sp)
 6c0:	e022                	sd	s0,0(sp)
 6c2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6c4:	00000097          	auipc	ra,0x0
 6c8:	f66080e7          	jalr	-154(ra) # 62a <memmove>
}
 6cc:	60a2                	ld	ra,8(sp)
 6ce:	6402                	ld	s0,0(sp)
 6d0:	0141                	addi	sp,sp,16
 6d2:	8082                	ret

00000000000006d4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 6d4:	4885                	li	a7,1
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 6dc:	4889                	li	a7,2
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6e4:	488d                	li	a7,3
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6ec:	4891                	li	a7,4
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <read>:
.global read
read:
 li a7, SYS_read
 6f4:	4895                	li	a7,5
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <write>:
.global write
write:
 li a7, SYS_write
 6fc:	48c1                	li	a7,16
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <close>:
.global close
close:
 li a7, SYS_close
 704:	48d5                	li	a7,21
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <kill>:
.global kill
kill:
 li a7, SYS_kill
 70c:	4899                	li	a7,6
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <exec>:
.global exec
exec:
 li a7, SYS_exec
 714:	489d                	li	a7,7
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <open>:
.global open
open:
 li a7, SYS_open
 71c:	48bd                	li	a7,15
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 724:	48a1                	li	a7,8
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 72c:	48d1                	li	a7,20
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 734:	48a5                	li	a7,9
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <dup>:
.global dup
dup:
 li a7, SYS_dup
 73c:	48a9                	li	a7,10
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 744:	48ad                	li	a7,11
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 74c:	48b1                	li	a7,12
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 754:	48b5                	li	a7,13
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 75c:	48b9                	li	a7,14
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 764:	48d9                	li	a7,22
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <dev>:
.global dev
dev:
 li a7, SYS_dev
 76c:	48dd                	li	a7,23
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 774:	48e1                	li	a7,24
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 77c:	48e5                	li	a7,25
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <remove>:
.global remove
remove:
 li a7, SYS_remove
 784:	48c5                	li	a7,17
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <trace>:
.global trace
trace:
 li a7, SYS_trace
 78c:	48c9                	li	a7,18
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 794:	48cd                	li	a7,19
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <rename>:
.global rename
rename:
 li a7, SYS_rename
 79c:	48e9                	li	a7,26
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 7a4:	48ed                	li	a7,27
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 7ac:	48f1                	li	a7,28
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 7b4:	48f5                	li	a7,29
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 7bc:	48f9                	li	a7,30
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 7c4:	48fd                	li	a7,31
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 7cc:	02000893          	li	a7,32
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 7d6:	02100893          	li	a7,33
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 7e0:	02200893          	li	a7,34
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 7ea:	02300893          	li	a7,35
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 7f4:	02400893          	li	a7,36
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 7fe:	02500893          	li	a7,37
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 808:	02600893          	li	a7,38
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 812:	02700893          	li	a7,39
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 81c:	02800893          	li	a7,40
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 826:	02900893          	li	a7,41
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 830:	02a00893          	li	a7,42
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 83a:	02b00893          	li	a7,43
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 844:	02c00893          	li	a7,44
 ecall
 848:	00000073          	ecall
 ret
 84c:	8082                	ret

000000000000084e <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 84e:	02d00893          	li	a7,45
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 858:	02e00893          	li	a7,46
 ecall
 85c:	00000073          	ecall
 ret
 860:	8082                	ret

0000000000000862 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 862:	02f00893          	li	a7,47
 ecall
 866:	00000073          	ecall
 ret
 86a:	8082                	ret

000000000000086c <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 86c:	03000893          	li	a7,48
 ecall
 870:	00000073          	ecall
 ret
 874:	8082                	ret

0000000000000876 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 876:	03100893          	li	a7,49
 ecall
 87a:	00000073          	ecall
 ret
 87e:	8082                	ret

0000000000000880 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 880:	03200893          	li	a7,50
 ecall
 884:	00000073          	ecall
 ret
 888:	8082                	ret

000000000000088a <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 88a:	03300893          	li	a7,51
 ecall
 88e:	00000073          	ecall
 ret
 892:	8082                	ret

0000000000000894 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 894:	03400893          	li	a7,52
 ecall
 898:	00000073          	ecall
 ret
 89c:	8082                	ret

000000000000089e <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 89e:	03500893          	li	a7,53
 ecall
 8a2:	00000073          	ecall
 ret
 8a6:	8082                	ret

00000000000008a8 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 8a8:	03600893          	li	a7,54
 ecall
 8ac:	00000073          	ecall
 ret
 8b0:	8082                	ret

00000000000008b2 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 8b2:	03700893          	li	a7,55
 ecall
 8b6:	00000073          	ecall
 ret
 8ba:	8082                	ret

00000000000008bc <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 8bc:	03800893          	li	a7,56
 ecall
 8c0:	00000073          	ecall
 ret
 8c4:	8082                	ret

00000000000008c6 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 8c6:	03900893          	li	a7,57
 ecall
 8ca:	00000073          	ecall
 ret
 8ce:	8082                	ret

00000000000008d0 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 8d0:	03a00893          	li	a7,58
 ecall
 8d4:	00000073          	ecall
 ret
 8d8:	8082                	ret

00000000000008da <poll>:
.global poll
poll:
 li a7, SYS_poll
 8da:	03b00893          	li	a7,59
 ecall
 8de:	00000073          	ecall
 ret
 8e2:	8082                	ret

00000000000008e4 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 8e4:	03c00893          	li	a7,60
 ecall
 8e8:	00000073          	ecall
 ret
 8ec:	8082                	ret

00000000000008ee <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 8ee:	03d00893          	li	a7,61
 ecall
 8f2:	00000073          	ecall
 ret
 8f6:	8082                	ret

00000000000008f8 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 8f8:	03e00893          	li	a7,62
 ecall
 8fc:	00000073          	ecall
 ret
 900:	8082                	ret

0000000000000902 <clone>:
.global clone
clone:
 li a7, SYS_clone
 902:	03f00893          	li	a7,63
 ecall
 906:	00000073          	ecall
 ret
 90a:	8082                	ret

000000000000090c <futex>:
.global futex
futex:
 li a7, SYS_futex
 90c:	04000893          	li	a7,64
 ecall
 910:	00000073          	ecall
 ret
 914:	8082                	ret

0000000000000916 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 916:	04100893          	li	a7,65
 ecall
 91a:	00000073          	ecall
 ret
 91e:	8082                	ret

0000000000000920 <halt>:
.global halt
halt:
 li a7, SYS_halt
 920:	04200893          	li	a7,66
 ecall
 924:	00000073          	ecall
 ret
 928:	8082                	ret

000000000000092a <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 92a:	04300893          	li	a7,67
 ecall
 92e:	00000073          	ecall
 ret
 932:	8082                	ret

0000000000000934 <socket>:
.global socket
socket:
 li a7, SYS_socket
 934:	04400893          	li	a7,68
 ecall
 938:	00000073          	ecall
 ret
 93c:	8082                	ret

000000000000093e <bind>:
.global bind
bind:
 li a7, SYS_bind
 93e:	04500893          	li	a7,69
 ecall
 942:	00000073          	ecall
 ret
 946:	8082                	ret

0000000000000948 <listen>:
.global listen
listen:
 li a7, SYS_listen
 948:	04600893          	li	a7,70
 ecall
 94c:	00000073          	ecall
 ret
 950:	8082                	ret

0000000000000952 <accept>:
.global accept
accept:
 li a7, SYS_accept
 952:	04700893          	li	a7,71
 ecall
 956:	00000073          	ecall
 ret
 95a:	8082                	ret

000000000000095c <connect>:
.global connect
connect:
 li a7, SYS_connect
 95c:	04800893          	li	a7,72
 ecall
 960:	00000073          	ecall
 ret
 964:	8082                	ret

0000000000000966 <send>:
.global send
send:
 li a7, SYS_send
 966:	04900893          	li	a7,73
 ecall
 96a:	00000073          	ecall
 ret
 96e:	8082                	ret

0000000000000970 <recv>:
.global recv
recv:
 li a7, SYS_recv
 970:	04a00893          	li	a7,74
 ecall
 974:	00000073          	ecall
 ret
 978:	8082                	ret

000000000000097a <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 97a:	04b00893          	li	a7,75
 ecall
 97e:	00000073          	ecall
 ret
 982:	8082                	ret

0000000000000984 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 984:	1101                	addi	sp,sp,-32
 986:	ec06                	sd	ra,24(sp)
 988:	e822                	sd	s0,16(sp)
 98a:	1000                	addi	s0,sp,32
 98c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 990:	4605                	li	a2,1
 992:	fef40593          	addi	a1,s0,-17
 996:	00000097          	auipc	ra,0x0
 99a:	d66080e7          	jalr	-666(ra) # 6fc <write>
}
 99e:	60e2                	ld	ra,24(sp)
 9a0:	6442                	ld	s0,16(sp)
 9a2:	6105                	addi	sp,sp,32
 9a4:	8082                	ret

00000000000009a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 9a6:	7139                	addi	sp,sp,-64
 9a8:	fc06                	sd	ra,56(sp)
 9aa:	f822                	sd	s0,48(sp)
 9ac:	f426                	sd	s1,40(sp)
 9ae:	f04a                	sd	s2,32(sp)
 9b0:	ec4e                	sd	s3,24(sp)
 9b2:	0080                	addi	s0,sp,64
 9b4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 9b6:	c299                	beqz	a3,9bc <printint+0x16>
 9b8:	0805c863          	bltz	a1,a48 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 9bc:	2581                	sext.w	a1,a1
  neg = 0;
 9be:	4881                	li	a7,0
  }

  i = 0;
 9c0:	fc040993          	addi	s3,s0,-64
  neg = 0;
 9c4:	86ce                	mv	a3,s3
  i = 0;
 9c6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 9c8:	2601                	sext.w	a2,a2
 9ca:	00000517          	auipc	a0,0x0
 9ce:	76650513          	addi	a0,a0,1894 # 1130 <digits>
 9d2:	883a                	mv	a6,a4
 9d4:	2705                	addiw	a4,a4,1
 9d6:	02c5f7bb          	remuw	a5,a1,a2
 9da:	1782                	slli	a5,a5,0x20
 9dc:	9381                	srli	a5,a5,0x20
 9de:	97aa                	add	a5,a5,a0
 9e0:	0007c783          	lbu	a5,0(a5)
 9e4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 9e8:	0005879b          	sext.w	a5,a1
 9ec:	02c5d5bb          	divuw	a1,a1,a2
 9f0:	0685                	addi	a3,a3,1
 9f2:	fec7f0e3          	bgeu	a5,a2,9d2 <printint+0x2c>
  if(neg)
 9f6:	00088c63          	beqz	a7,a0e <printint+0x68>
    buf[i++] = '-';
 9fa:	fd070793          	addi	a5,a4,-48
 9fe:	00878733          	add	a4,a5,s0
 a02:	02d00793          	li	a5,45
 a06:	fef70823          	sb	a5,-16(a4)
 a0a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a0e:	02e05663          	blez	a4,a3a <printint+0x94>
 a12:	fc040913          	addi	s2,s0,-64
 a16:	993a                	add	s2,s2,a4
 a18:	19fd                	addi	s3,s3,-1
 a1a:	99ba                	add	s3,s3,a4
 a1c:	377d                	addiw	a4,a4,-1
 a1e:	1702                	slli	a4,a4,0x20
 a20:	9301                	srli	a4,a4,0x20
 a22:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a26:	fff94583          	lbu	a1,-1(s2)
 a2a:	8526                	mv	a0,s1
 a2c:	00000097          	auipc	ra,0x0
 a30:	f58080e7          	jalr	-168(ra) # 984 <putc>
  while(--i >= 0)
 a34:	197d                	addi	s2,s2,-1
 a36:	ff3918e3          	bne	s2,s3,a26 <printint+0x80>
}
 a3a:	70e2                	ld	ra,56(sp)
 a3c:	7442                	ld	s0,48(sp)
 a3e:	74a2                	ld	s1,40(sp)
 a40:	7902                	ld	s2,32(sp)
 a42:	69e2                	ld	s3,24(sp)
 a44:	6121                	addi	sp,sp,64
 a46:	8082                	ret
    x = -xx;
 a48:	40b005bb          	negw	a1,a1
    neg = 1;
 a4c:	4885                	li	a7,1
    x = -xx;
 a4e:	bf8d                	j	9c0 <printint+0x1a>

0000000000000a50 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 a50:	7119                	addi	sp,sp,-128
 a52:	fc86                	sd	ra,120(sp)
 a54:	f8a2                	sd	s0,112(sp)
 a56:	f4a6                	sd	s1,104(sp)
 a58:	f0ca                	sd	s2,96(sp)
 a5a:	ecce                	sd	s3,88(sp)
 a5c:	e8d2                	sd	s4,80(sp)
 a5e:	e4d6                	sd	s5,72(sp)
 a60:	e0da                	sd	s6,64(sp)
 a62:	fc5e                	sd	s7,56(sp)
 a64:	f862                	sd	s8,48(sp)
 a66:	f466                	sd	s9,40(sp)
 a68:	f06a                	sd	s10,32(sp)
 a6a:	ec6e                	sd	s11,24(sp)
 a6c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 a6e:	0005c903          	lbu	s2,0(a1)
 a72:	18090f63          	beqz	s2,c10 <vprintf+0x1c0>
 a76:	8aaa                	mv	s5,a0
 a78:	8b32                	mv	s6,a2
 a7a:	00158493          	addi	s1,a1,1
  state = 0;
 a7e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 a80:	02500a13          	li	s4,37
 a84:	4c55                	li	s8,21
 a86:	00000c97          	auipc	s9,0x0
 a8a:	652c8c93          	addi	s9,s9,1618 # 10d8 <malloc+0x3c4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a8e:	02800d93          	li	s11,40
  putc(fd, 'x');
 a92:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a94:	00000b97          	auipc	s7,0x0
 a98:	69cb8b93          	addi	s7,s7,1692 # 1130 <digits>
 a9c:	a839                	j	aba <vprintf+0x6a>
        putc(fd, c);
 a9e:	85ca                	mv	a1,s2
 aa0:	8556                	mv	a0,s5
 aa2:	00000097          	auipc	ra,0x0
 aa6:	ee2080e7          	jalr	-286(ra) # 984 <putc>
 aaa:	a019                	j	ab0 <vprintf+0x60>
    } else if(state == '%'){
 aac:	01498d63          	beq	s3,s4,ac6 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 ab0:	0485                	addi	s1,s1,1
 ab2:	fff4c903          	lbu	s2,-1(s1)
 ab6:	14090d63          	beqz	s2,c10 <vprintf+0x1c0>
    if(state == 0){
 aba:	fe0999e3          	bnez	s3,aac <vprintf+0x5c>
      if(c == '%'){
 abe:	ff4910e3          	bne	s2,s4,a9e <vprintf+0x4e>
        state = '%';
 ac2:	89d2                	mv	s3,s4
 ac4:	b7f5                	j	ab0 <vprintf+0x60>
      if(c == 'd'){
 ac6:	11490c63          	beq	s2,s4,bde <vprintf+0x18e>
 aca:	f9d9079b          	addiw	a5,s2,-99
 ace:	0ff7f793          	zext.b	a5,a5
 ad2:	10fc6e63          	bltu	s8,a5,bee <vprintf+0x19e>
 ad6:	f9d9079b          	addiw	a5,s2,-99
 ada:	0ff7f713          	zext.b	a4,a5
 ade:	10ec6863          	bltu	s8,a4,bee <vprintf+0x19e>
 ae2:	00271793          	slli	a5,a4,0x2
 ae6:	97e6                	add	a5,a5,s9
 ae8:	439c                	lw	a5,0(a5)
 aea:	97e6                	add	a5,a5,s9
 aec:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 aee:	008b0913          	addi	s2,s6,8
 af2:	4685                	li	a3,1
 af4:	4629                	li	a2,10
 af6:	000b2583          	lw	a1,0(s6)
 afa:	8556                	mv	a0,s5
 afc:	00000097          	auipc	ra,0x0
 b00:	eaa080e7          	jalr	-342(ra) # 9a6 <printint>
 b04:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b06:	4981                	li	s3,0
 b08:	b765                	j	ab0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b0a:	008b0913          	addi	s2,s6,8
 b0e:	4681                	li	a3,0
 b10:	4629                	li	a2,10
 b12:	000b2583          	lw	a1,0(s6)
 b16:	8556                	mv	a0,s5
 b18:	00000097          	auipc	ra,0x0
 b1c:	e8e080e7          	jalr	-370(ra) # 9a6 <printint>
 b20:	8b4a                	mv	s6,s2
      state = 0;
 b22:	4981                	li	s3,0
 b24:	b771                	j	ab0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 b26:	008b0913          	addi	s2,s6,8
 b2a:	4681                	li	a3,0
 b2c:	866a                	mv	a2,s10
 b2e:	000b2583          	lw	a1,0(s6)
 b32:	8556                	mv	a0,s5
 b34:	00000097          	auipc	ra,0x0
 b38:	e72080e7          	jalr	-398(ra) # 9a6 <printint>
 b3c:	8b4a                	mv	s6,s2
      state = 0;
 b3e:	4981                	li	s3,0
 b40:	bf85                	j	ab0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 b42:	008b0793          	addi	a5,s6,8
 b46:	f8f43423          	sd	a5,-120(s0)
 b4a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 b4e:	03000593          	li	a1,48
 b52:	8556                	mv	a0,s5
 b54:	00000097          	auipc	ra,0x0
 b58:	e30080e7          	jalr	-464(ra) # 984 <putc>
  putc(fd, 'x');
 b5c:	07800593          	li	a1,120
 b60:	8556                	mv	a0,s5
 b62:	00000097          	auipc	ra,0x0
 b66:	e22080e7          	jalr	-478(ra) # 984 <putc>
 b6a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b6c:	03c9d793          	srli	a5,s3,0x3c
 b70:	97de                	add	a5,a5,s7
 b72:	0007c583          	lbu	a1,0(a5)
 b76:	8556                	mv	a0,s5
 b78:	00000097          	auipc	ra,0x0
 b7c:	e0c080e7          	jalr	-500(ra) # 984 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b80:	0992                	slli	s3,s3,0x4
 b82:	397d                	addiw	s2,s2,-1
 b84:	fe0914e3          	bnez	s2,b6c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 b88:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 b8c:	4981                	li	s3,0
 b8e:	b70d                	j	ab0 <vprintf+0x60>
        s = va_arg(ap, char*);
 b90:	008b0913          	addi	s2,s6,8
 b94:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 b98:	02098163          	beqz	s3,bba <vprintf+0x16a>
        while(*s != 0){
 b9c:	0009c583          	lbu	a1,0(s3)
 ba0:	c5ad                	beqz	a1,c0a <vprintf+0x1ba>
          putc(fd, *s);
 ba2:	8556                	mv	a0,s5
 ba4:	00000097          	auipc	ra,0x0
 ba8:	de0080e7          	jalr	-544(ra) # 984 <putc>
          s++;
 bac:	0985                	addi	s3,s3,1
        while(*s != 0){
 bae:	0009c583          	lbu	a1,0(s3)
 bb2:	f9e5                	bnez	a1,ba2 <vprintf+0x152>
        s = va_arg(ap, char*);
 bb4:	8b4a                	mv	s6,s2
      state = 0;
 bb6:	4981                	li	s3,0
 bb8:	bde5                	j	ab0 <vprintf+0x60>
          s = "(null)";
 bba:	00000997          	auipc	s3,0x0
 bbe:	51698993          	addi	s3,s3,1302 # 10d0 <malloc+0x3bc>
        while(*s != 0){
 bc2:	85ee                	mv	a1,s11
 bc4:	bff9                	j	ba2 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 bc6:	008b0913          	addi	s2,s6,8
 bca:	000b4583          	lbu	a1,0(s6)
 bce:	8556                	mv	a0,s5
 bd0:	00000097          	auipc	ra,0x0
 bd4:	db4080e7          	jalr	-588(ra) # 984 <putc>
 bd8:	8b4a                	mv	s6,s2
      state = 0;
 bda:	4981                	li	s3,0
 bdc:	bdd1                	j	ab0 <vprintf+0x60>
        putc(fd, c);
 bde:	85d2                	mv	a1,s4
 be0:	8556                	mv	a0,s5
 be2:	00000097          	auipc	ra,0x0
 be6:	da2080e7          	jalr	-606(ra) # 984 <putc>
      state = 0;
 bea:	4981                	li	s3,0
 bec:	b5d1                	j	ab0 <vprintf+0x60>
        putc(fd, '%');
 bee:	85d2                	mv	a1,s4
 bf0:	8556                	mv	a0,s5
 bf2:	00000097          	auipc	ra,0x0
 bf6:	d92080e7          	jalr	-622(ra) # 984 <putc>
        putc(fd, c);
 bfa:	85ca                	mv	a1,s2
 bfc:	8556                	mv	a0,s5
 bfe:	00000097          	auipc	ra,0x0
 c02:	d86080e7          	jalr	-634(ra) # 984 <putc>
      state = 0;
 c06:	4981                	li	s3,0
 c08:	b565                	j	ab0 <vprintf+0x60>
        s = va_arg(ap, char*);
 c0a:	8b4a                	mv	s6,s2
      state = 0;
 c0c:	4981                	li	s3,0
 c0e:	b54d                	j	ab0 <vprintf+0x60>
    }
  }
}
 c10:	70e6                	ld	ra,120(sp)
 c12:	7446                	ld	s0,112(sp)
 c14:	74a6                	ld	s1,104(sp)
 c16:	7906                	ld	s2,96(sp)
 c18:	69e6                	ld	s3,88(sp)
 c1a:	6a46                	ld	s4,80(sp)
 c1c:	6aa6                	ld	s5,72(sp)
 c1e:	6b06                	ld	s6,64(sp)
 c20:	7be2                	ld	s7,56(sp)
 c22:	7c42                	ld	s8,48(sp)
 c24:	7ca2                	ld	s9,40(sp)
 c26:	7d02                	ld	s10,32(sp)
 c28:	6de2                	ld	s11,24(sp)
 c2a:	6109                	addi	sp,sp,128
 c2c:	8082                	ret

0000000000000c2e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c2e:	715d                	addi	sp,sp,-80
 c30:	ec06                	sd	ra,24(sp)
 c32:	e822                	sd	s0,16(sp)
 c34:	1000                	addi	s0,sp,32
 c36:	e010                	sd	a2,0(s0)
 c38:	e414                	sd	a3,8(s0)
 c3a:	e818                	sd	a4,16(s0)
 c3c:	ec1c                	sd	a5,24(s0)
 c3e:	03043023          	sd	a6,32(s0)
 c42:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c46:	8622                	mv	a2,s0
 c48:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c4c:	00000097          	auipc	ra,0x0
 c50:	e04080e7          	jalr	-508(ra) # a50 <vprintf>
}
 c54:	60e2                	ld	ra,24(sp)
 c56:	6442                	ld	s0,16(sp)
 c58:	6161                	addi	sp,sp,80
 c5a:	8082                	ret

0000000000000c5c <printf>:

void
printf(const char *fmt, ...)
{
 c5c:	711d                	addi	sp,sp,-96
 c5e:	ec06                	sd	ra,24(sp)
 c60:	e822                	sd	s0,16(sp)
 c62:	1000                	addi	s0,sp,32
 c64:	e40c                	sd	a1,8(s0)
 c66:	e810                	sd	a2,16(s0)
 c68:	ec14                	sd	a3,24(s0)
 c6a:	f018                	sd	a4,32(s0)
 c6c:	f41c                	sd	a5,40(s0)
 c6e:	03043823          	sd	a6,48(s0)
 c72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c76:	00840613          	addi	a2,s0,8
 c7a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c7e:	85aa                	mv	a1,a0
 c80:	4505                	li	a0,1
 c82:	00000097          	auipc	ra,0x0
 c86:	dce080e7          	jalr	-562(ra) # a50 <vprintf>
}
 c8a:	60e2                	ld	ra,24(sp)
 c8c:	6442                	ld	s0,16(sp)
 c8e:	6125                	addi	sp,sp,96
 c90:	8082                	ret

0000000000000c92 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c92:	1141                	addi	sp,sp,-16
 c94:	e422                	sd	s0,8(sp)
 c96:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c98:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c9c:	00000797          	auipc	a5,0x0
 ca0:	4ac7b783          	ld	a5,1196(a5) # 1148 <freep>
 ca4:	a02d                	j	cce <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ca6:	4618                	lw	a4,8(a2)
 ca8:	9f2d                	addw	a4,a4,a1
 caa:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 cae:	6398                	ld	a4,0(a5)
 cb0:	6310                	ld	a2,0(a4)
 cb2:	a83d                	j	cf0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 cb4:	ff852703          	lw	a4,-8(a0)
 cb8:	9f31                	addw	a4,a4,a2
 cba:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 cbc:	ff053683          	ld	a3,-16(a0)
 cc0:	a091                	j	d04 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cc2:	6398                	ld	a4,0(a5)
 cc4:	00e7e463          	bltu	a5,a4,ccc <free+0x3a>
 cc8:	00e6ea63          	bltu	a3,a4,cdc <free+0x4a>
{
 ccc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cce:	fed7fae3          	bgeu	a5,a3,cc2 <free+0x30>
 cd2:	6398                	ld	a4,0(a5)
 cd4:	00e6e463          	bltu	a3,a4,cdc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cd8:	fee7eae3          	bltu	a5,a4,ccc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 cdc:	ff852583          	lw	a1,-8(a0)
 ce0:	6390                	ld	a2,0(a5)
 ce2:	02059813          	slli	a6,a1,0x20
 ce6:	01c85713          	srli	a4,a6,0x1c
 cea:	9736                	add	a4,a4,a3
 cec:	fae60de3          	beq	a2,a4,ca6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 cf0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 cf4:	4790                	lw	a2,8(a5)
 cf6:	02061593          	slli	a1,a2,0x20
 cfa:	01c5d713          	srli	a4,a1,0x1c
 cfe:	973e                	add	a4,a4,a5
 d00:	fae68ae3          	beq	a3,a4,cb4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 d04:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 d06:	00000717          	auipc	a4,0x0
 d0a:	44f73123          	sd	a5,1090(a4) # 1148 <freep>
}
 d0e:	6422                	ld	s0,8(sp)
 d10:	0141                	addi	sp,sp,16
 d12:	8082                	ret

0000000000000d14 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d14:	7139                	addi	sp,sp,-64
 d16:	fc06                	sd	ra,56(sp)
 d18:	f822                	sd	s0,48(sp)
 d1a:	f426                	sd	s1,40(sp)
 d1c:	f04a                	sd	s2,32(sp)
 d1e:	ec4e                	sd	s3,24(sp)
 d20:	e852                	sd	s4,16(sp)
 d22:	e456                	sd	s5,8(sp)
 d24:	e05a                	sd	s6,0(sp)
 d26:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d28:	02051493          	slli	s1,a0,0x20
 d2c:	9081                	srli	s1,s1,0x20
 d2e:	04bd                	addi	s1,s1,15
 d30:	8091                	srli	s1,s1,0x4
 d32:	00148a1b          	addiw	s4,s1,1
 d36:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 d38:	00000517          	auipc	a0,0x0
 d3c:	41053503          	ld	a0,1040(a0) # 1148 <freep>
 d40:	c515                	beqz	a0,d6c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d42:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d44:	4798                	lw	a4,8(a5)
 d46:	04977163          	bgeu	a4,s1,d88 <malloc+0x74>
 d4a:	89d2                	mv	s3,s4
 d4c:	000a071b          	sext.w	a4,s4
 d50:	6685                	lui	a3,0x1
 d52:	00d77363          	bgeu	a4,a3,d58 <malloc+0x44>
 d56:	6985                	lui	s3,0x1
 d58:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 d5c:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d60:	00000917          	auipc	s2,0x0
 d64:	3e890913          	addi	s2,s2,1000 # 1148 <freep>
  if(p == (char*)-1)
 d68:	5afd                	li	s5,-1
 d6a:	a8a5                	j	de2 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 d6c:	00000797          	auipc	a5,0x0
 d70:	3dc78793          	addi	a5,a5,988 # 1148 <freep>
 d74:	00000717          	auipc	a4,0x0
 d78:	3dc70713          	addi	a4,a4,988 # 1150 <base>
 d7c:	e398                	sd	a4,0(a5)
 d7e:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 d80:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d84:	87ba                	mv	a5,a4
 d86:	b7d1                	j	d4a <malloc+0x36>
      if(p->s.size == nunits)
 d88:	02e48c63          	beq	s1,a4,dc0 <malloc+0xac>
        p->s.size -= nunits;
 d8c:	4147073b          	subw	a4,a4,s4
 d90:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d92:	02071693          	slli	a3,a4,0x20
 d96:	01c6d713          	srli	a4,a3,0x1c
 d9a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d9c:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 da0:	00000717          	auipc	a4,0x0
 da4:	3aa73423          	sd	a0,936(a4) # 1148 <freep>
      return (void*)(p + 1);
 da8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 dac:	70e2                	ld	ra,56(sp)
 dae:	7442                	ld	s0,48(sp)
 db0:	74a2                	ld	s1,40(sp)
 db2:	7902                	ld	s2,32(sp)
 db4:	69e2                	ld	s3,24(sp)
 db6:	6a42                	ld	s4,16(sp)
 db8:	6aa2                	ld	s5,8(sp)
 dba:	6b02                	ld	s6,0(sp)
 dbc:	6121                	addi	sp,sp,64
 dbe:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 dc0:	6398                	ld	a4,0(a5)
 dc2:	e118                	sd	a4,0(a0)
 dc4:	bff1                	j	da0 <malloc+0x8c>
  hp->s.size = nu;
 dc6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 dca:	0541                	addi	a0,a0,16
 dcc:	00000097          	auipc	ra,0x0
 dd0:	ec6080e7          	jalr	-314(ra) # c92 <free>
  return freep;
 dd4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 dd8:	d971                	beqz	a0,dac <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dda:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ddc:	4798                	lw	a4,8(a5)
 dde:	fa9775e3          	bgeu	a4,s1,d88 <malloc+0x74>
    if(p == freep)
 de2:	00093703          	ld	a4,0(s2)
 de6:	853e                	mv	a0,a5
 de8:	fef719e3          	bne	a4,a5,dda <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 dec:	854e                	mv	a0,s3
 dee:	00000097          	auipc	ra,0x0
 df2:	95e080e7          	jalr	-1698(ra) # 74c <sbrk>
  if(p == (char*)-1)
 df6:	fd5518e3          	bne	a0,s5,dc6 <malloc+0xb2>
        return 0;
 dfa:	4501                	li	a0,0
 dfc:	bf45                	j	dac <malloc+0x98>
