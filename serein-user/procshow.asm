
serein-user/_procshow：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <color_cyan>:
static void color_yellow(void) {
  char seq[] = {0x1b, '[', '3', '3', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_cyan(void) {
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '6', 'm'};
       8:	363367b7          	lui	a5,0x36336
       c:	b1b78793          	addi	a5,a5,-1253 # 36335b1b <__global_pointer$+0x36333a3a>
      10:	fef42423          	sw	a5,-24(s0)
      14:	06d00793          	li	a5,109
      18:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      1c:	4615                	li	a2,5
      1e:	fe840593          	addi	a1,s0,-24
      22:	4509                	li	a0,2
      24:	00001097          	auipc	ra,0x1
      28:	c64080e7          	jalr	-924(ra) # c88 <write>
}
      2c:	60e2                	ld	ra,24(sp)
      2e:	6442                	ld	s0,16(sp)
      30:	6105                	addi	sp,sp,32
      32:	8082                	ret

0000000000000034 <color_yellow>:
static void color_yellow(void) {
      34:	1101                	addi	sp,sp,-32
      36:	ec06                	sd	ra,24(sp)
      38:	e822                	sd	s0,16(sp)
      3a:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '3', 'm'};
      3c:	333367b7          	lui	a5,0x33336
      40:	b1b78793          	addi	a5,a5,-1253 # 33335b1b <__global_pointer$+0x33333a3a>
      44:	fef42423          	sw	a5,-24(s0)
      48:	06d00793          	li	a5,109
      4c:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      50:	4615                	li	a2,5
      52:	fe840593          	addi	a1,s0,-24
      56:	4509                	li	a0,2
      58:	00001097          	auipc	ra,0x1
      5c:	c30080e7          	jalr	-976(ra) # c88 <write>
}
      60:	60e2                	ld	ra,24(sp)
      62:	6442                	ld	s0,16(sp)
      64:	6105                	addi	sp,sp,32
      66:	8082                	ret

0000000000000068 <color_green>:
static void color_green(void) {
      68:	1101                	addi	sp,sp,-32
      6a:	ec06                	sd	ra,24(sp)
      6c:	e822                	sd	s0,16(sp)
      6e:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '2', 'm'};
      70:	323367b7          	lui	a5,0x32336
      74:	b1b78793          	addi	a5,a5,-1253 # 32335b1b <__global_pointer$+0x32333a3a>
      78:	fef42423          	sw	a5,-24(s0)
      7c:	06d00793          	li	a5,109
      80:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      84:	4615                	li	a2,5
      86:	fe840593          	addi	a1,s0,-24
      8a:	4509                	li	a0,2
      8c:	00001097          	auipc	ra,0x1
      90:	bfc080e7          	jalr	-1028(ra) # c88 <write>
}
      94:	60e2                	ld	ra,24(sp)
      96:	6442                	ld	s0,16(sp)
      98:	6105                	addi	sp,sp,32
      9a:	8082                	ret

000000000000009c <color_reset>:
static void color_magenta(void) {
  char seq[] = {0x1b, '[', '3', '5', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_reset(void) {
      9c:	1101                	addi	sp,sp,-32
      9e:	ec06                	sd	ra,24(sp)
      a0:	e822                	sd	s0,16(sp)
      a2:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '0', 'm'};
      a4:	6d3067b7          	lui	a5,0x6d306
      a8:	b1b78793          	addi	a5,a5,-1253 # 6d305b1b <__global_pointer$+0x6d303a3a>
      ac:	fef42423          	sw	a5,-24(s0)
  write(2, seq, sizeof(seq));
      b0:	4611                	li	a2,4
      b2:	fe840593          	addi	a1,s0,-24
      b6:	4509                	li	a0,2
      b8:	00001097          	auipc	ra,0x1
      bc:	bd0080e7          	jalr	-1072(ra) # c88 <write>
}
      c0:	60e2                	ld	ra,24(sp)
      c2:	6442                	ld	s0,16(sp)
      c4:	6105                	addi	sp,sp,32
      c6:	8082                	ret

00000000000000c8 <kill_workers>:
  }
}

// 终止所有 worker
static void kill_workers(void) {
  for(int i = 0; i < num_workers; i++) {
      c8:	00002797          	auipc	a5,0x2
      cc:	8207a783          	lw	a5,-2016(a5) # 18e8 <num_workers>
      d0:	06f05663          	blez	a5,13c <kill_workers+0x74>
static void kill_workers(void) {
      d4:	7179                	addi	sp,sp,-48
      d6:	f406                	sd	ra,40(sp)
      d8:	f022                	sd	s0,32(sp)
      da:	ec26                	sd	s1,24(sp)
      dc:	e84a                	sd	s2,16(sp)
      de:	e44e                	sd	s3,8(sp)
      e0:	1800                	addi	s0,sp,48
      e2:	00002917          	auipc	s2,0x2
      e6:	80e90913          	addi	s2,s2,-2034 # 18f0 <worker_pids>
  for(int i = 0; i < num_workers; i++) {
      ea:	4481                	li	s1,0
      ec:	00001997          	auipc	s3,0x1
      f0:	7fc98993          	addi	s3,s3,2044 # 18e8 <num_workers>
    kill(worker_pids[i]);
      f4:	00092503          	lw	a0,0(s2)
      f8:	00001097          	auipc	ra,0x1
      fc:	ba0080e7          	jalr	-1120(ra) # c98 <kill>
  for(int i = 0; i < num_workers; i++) {
     100:	2485                	addiw	s1,s1,1
     102:	0009a783          	lw	a5,0(s3)
     106:	0911                	addi	s2,s2,4
     108:	fef4c6e3          	blt	s1,a5,f4 <kill_workers+0x2c>
  }
  for(int i = 0; i < num_workers; i++) {
     10c:	02f05163          	blez	a5,12e <kill_workers+0x66>
     110:	4481                	li	s1,0
     112:	00001917          	auipc	s2,0x1
     116:	7d690913          	addi	s2,s2,2006 # 18e8 <num_workers>
    wait(0);
     11a:	4501                	li	a0,0
     11c:	00001097          	auipc	ra,0x1
     120:	b54080e7          	jalr	-1196(ra) # c70 <wait>
  for(int i = 0; i < num_workers; i++) {
     124:	2485                	addiw	s1,s1,1
     126:	00092783          	lw	a5,0(s2)
     12a:	fef4c8e3          	blt	s1,a5,11a <kill_workers+0x52>
  }
}
     12e:	70a2                	ld	ra,40(sp)
     130:	7402                	ld	s0,32(sp)
     132:	64e2                	ld	s1,24(sp)
     134:	6942                	ld	s2,16(sp)
     136:	69a2                	ld	s3,8(sp)
     138:	6145                	addi	sp,sp,48
     13a:	8082                	ret
     13c:	8082                	ret

000000000000013e <main>:

int main(int argc, char *argv[]) {
     13e:	7119                	addi	sp,sp,-128
     140:	fc86                	sd	ra,120(sp)
     142:	f8a2                	sd	s0,112(sp)
     144:	f4a6                	sd	s1,104(sp)
     146:	f0ca                	sd	s2,96(sp)
     148:	ecce                	sd	s3,88(sp)
     14a:	e8d2                	sd	s4,80(sp)
     14c:	e4d6                	sd	s5,72(sp)
     14e:	e0da                	sd	s6,64(sp)
     150:	fc5e                	sd	s7,56(sp)
     152:	f862                	sd	s8,48(sp)
     154:	f466                	sd	s9,40(sp)
     156:	f06a                	sd	s10,32(sp)
     158:	ec6e                	sd	s11,24(sp)
     15a:	0100                	addi	s0,sp,128
     15c:	88010113          	addi	sp,sp,-1920
  int rounds = 10;  // 默认运行 10 轮
  
  if(argc >= 2) {
     160:	4705                	li	a4,1
  int rounds = 10;  // 默认运行 10 轮
     162:	46a9                	li	a3,10
     164:	80d43c23          	sd	a3,-2024(s0)
  if(argc >= 2) {
     168:	0ca74463          	blt	a4,a0,230 <main+0xf2>
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
     16c:	4a3267b7          	lui	a5,0x4a326
     170:	b1b78793          	addi	a5,a5,-1253 # 4a325b1b <__global_pointer$+0x4a323a3a>
     174:	86f42023          	sw	a5,-1952(s0)
     178:	6799                	lui	a5,0x6
     17a:	b1b78793          	addi	a5,a5,-1253 # 5b1b <__global_pointer$+0x3a3a>
     17e:	86f41223          	sh	a5,-1948(s0)
     182:	04800793          	li	a5,72
     186:	86f40323          	sb	a5,-1946(s0)
  write(2, seq, sizeof(seq));
     18a:	461d                	li	a2,7
     18c:	86040593          	addi	a1,s0,-1952
     190:	4509                	li	a0,2
     192:	00001097          	auipc	ra,0x1
     196:	af6080e7          	jalr	-1290(ra) # c88 <write>
  
  // 注意：Ctrl+C (SIGINT) 使用默认行为，会终止进程
  // worker 进程在同一进程组，也会被终止
  
  cls();
  color_cyan();
     19a:	00000097          	auipc	ra,0x0
     19e:	e66080e7          	jalr	-410(ra) # 0 <color_cyan>
  fprintf(2, "+================================================================+\n");
     1a2:	00001597          	auipc	a1,0x1
     1a6:	1ee58593          	addi	a1,a1,494 # 1390 <malloc+0xf0>
     1aa:	4509                	li	a0,2
     1ac:	00001097          	auipc	ra,0x1
     1b0:	00e080e7          	jalr	14(ra) # 11ba <fprintf>
  fprintf(2, "|            Stride Scheduler Visualization Demo                |\n");
     1b4:	00001597          	auipc	a1,0x1
     1b8:	22458593          	addi	a1,a1,548 # 13d8 <malloc+0x138>
     1bc:	4509                	li	a0,2
     1be:	00001097          	auipc	ra,0x1
     1c2:	ffc080e7          	jalr	-4(ra) # 11ba <fprintf>
  fprintf(2, "+================================================================+\n");
     1c6:	00001597          	auipc	a1,0x1
     1ca:	1ca58593          	addi	a1,a1,458 # 1390 <malloc+0xf0>
     1ce:	4509                	li	a0,2
     1d0:	00001097          	auipc	ra,0x1
     1d4:	fea080e7          	jalr	-22(ra) # 11ba <fprintf>
  color_reset();
     1d8:	00000097          	auipc	ra,0x0
     1dc:	ec4080e7          	jalr	-316(ra) # 9c <color_reset>
  fprintf(2, "\n");
     1e0:	00001597          	auipc	a1,0x1
     1e4:	27858593          	addi	a1,a1,632 # 1458 <malloc+0x1b8>
     1e8:	4509                	li	a0,2
     1ea:	00001097          	auipc	ra,0x1
     1ee:	fd0080e7          	jalr	-48(ra) # 11ba <fprintf>
  fprintf(2, "  Spawning %d CPU-bound workers with different tickets:\n\n", NUM_WORKERS);
     1f2:	4615                	li	a2,5
     1f4:	00001597          	auipc	a1,0x1
     1f8:	22c58593          	addi	a1,a1,556 # 1420 <malloc+0x180>
     1fc:	4509                	li	a0,2
     1fe:	00001097          	auipc	ra,0x1
     202:	fbc080e7          	jalr	-68(ra) # 11ba <fprintf>
     206:	00001997          	auipc	s3,0x1
     20a:	65298993          	addi	s3,s3,1618 # 1858 <worker_tickets>
     20e:	4905                	li	s2,1
  
  // 显示配置
  for(int i = 0; i < NUM_WORKERS; i++) {
    if(worker_tickets[i] >= 40) color_magenta();
     210:	02700a93          	li	s5,39
    else if(worker_tickets[i] >= 20) color_green();
     214:	4b4d                	li	s6,19
    else color_yellow();
    
    fprintf(2, "    Worker %d: tickets = %d", i+1, worker_tickets[i]);
     216:	00001a17          	auipc	s4,0x1
     21a:	24aa0a13          	addi	s4,s4,586 # 1460 <malloc+0x1c0>
    if(worker_tickets[i] == 40) fprintf(2, "  <-- 8x vs Worker1");
    else if(worker_tickets[i] == 20) fprintf(2, "  <-- 4x vs Worker1");
    else if(worker_tickets[i] == 10) fprintf(2, "  <-- 2x vs Worker1");
     21e:	4ca9                	li	s9,10
    else if(worker_tickets[i] == 5) fprintf(2, "  <-- baseline");
     220:	4b95                	li	s7,5
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     222:	353367b7          	lui	a5,0x35336
     226:	b1b78d13          	addi	s10,a5,-1253 # 35335b1b <__global_pointer$+0x35333a3a>
  write(2, seq, sizeof(seq));
     22a:	86040c13          	addi	s8,s0,-1952
     22e:	a849                	j	2c0 <main+0x182>
    rounds = atoi(argv[1]);
     230:	6588                	ld	a0,8(a1)
     232:	00001097          	auipc	ra,0x1
     236:	924080e7          	jalr	-1756(ra) # b56 <atoi>
    if(rounds <= 0) rounds = 10;
     23a:	4729                	li	a4,10
     23c:	80e43c23          	sd	a4,-2024(s0)
     240:	f2a056e3          	blez	a0,16c <main+0x2e>
    if(rounds > 30) rounds = 30;
     244:	872a                	mv	a4,a0
     246:	46f9                	li	a3,30
     248:	00a6d363          	bge	a3,a0,24e <main+0x110>
     24c:	4779                	li	a4,30
     24e:	0007079b          	sext.w	a5,a4
     252:	80f43c23          	sd	a5,-2024(s0)
     256:	bf19                	j	16c <main+0x2e>
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     258:	87a42023          	sw	s10,-1952(s0)
     25c:	06d00793          	li	a5,109
     260:	86f40223          	sb	a5,-1948(s0)
  write(2, seq, sizeof(seq));
     264:	865e                	mv	a2,s7
     266:	85e2                	mv	a1,s8
     268:	4509                	li	a0,2
     26a:	00001097          	auipc	ra,0x1
     26e:	a1e080e7          	jalr	-1506(ra) # c88 <write>
    fprintf(2, "    Worker %d: tickets = %d", i+1, worker_tickets[i]);
     272:	86a6                	mv	a3,s1
     274:	864a                	mv	a2,s2
     276:	85d2                	mv	a1,s4
     278:	4509                	li	a0,2
     27a:	00001097          	auipc	ra,0x1
     27e:	f40080e7          	jalr	-192(ra) # 11ba <fprintf>
    if(worker_tickets[i] == 40) fprintf(2, "  <-- 8x vs Worker1");
     282:	02800793          	li	a5,40
     286:	00f49b63          	bne	s1,a5,29c <main+0x15e>
     28a:	00001597          	auipc	a1,0x1
     28e:	1f658593          	addi	a1,a1,502 # 1480 <malloc+0x1e0>
     292:	4509                	li	a0,2
     294:	00001097          	auipc	ra,0x1
     298:	f26080e7          	jalr	-218(ra) # 11ba <fprintf>
    fprintf(2, "\n");
     29c:	00001597          	auipc	a1,0x1
     2a0:	1bc58593          	addi	a1,a1,444 # 1458 <malloc+0x1b8>
     2a4:	4509                	li	a0,2
     2a6:	00001097          	auipc	ra,0x1
     2aa:	f14080e7          	jalr	-236(ra) # 11ba <fprintf>
    color_reset();
     2ae:	00000097          	auipc	ra,0x0
     2b2:	dee080e7          	jalr	-530(ra) # 9c <color_reset>
  for(int i = 0; i < NUM_WORKERS; i++) {
     2b6:	0991                	addi	s3,s3,4
     2b8:	2905                	addiw	s2,s2,1
     2ba:	4799                	li	a5,6
     2bc:	08f90563          	beq	s2,a5,346 <main+0x208>
    if(worker_tickets[i] >= 40) color_magenta();
     2c0:	0009a483          	lw	s1,0(s3)
     2c4:	f89acae3          	blt	s5,s1,258 <main+0x11a>
    else if(worker_tickets[i] >= 20) color_green();
     2c8:	029b5b63          	bge	s6,s1,2fe <main+0x1c0>
     2cc:	00000097          	auipc	ra,0x0
     2d0:	d9c080e7          	jalr	-612(ra) # 68 <color_green>
    fprintf(2, "    Worker %d: tickets = %d", i+1, worker_tickets[i]);
     2d4:	86a6                	mv	a3,s1
     2d6:	864a                	mv	a2,s2
     2d8:	85d2                	mv	a1,s4
     2da:	4509                	li	a0,2
     2dc:	00001097          	auipc	ra,0x1
     2e0:	ede080e7          	jalr	-290(ra) # 11ba <fprintf>
    else if(worker_tickets[i] == 20) fprintf(2, "  <-- 4x vs Worker1");
     2e4:	47d1                	li	a5,20
     2e6:	faf49be3          	bne	s1,a5,29c <main+0x15e>
     2ea:	00001597          	auipc	a1,0x1
     2ee:	1ae58593          	addi	a1,a1,430 # 1498 <malloc+0x1f8>
     2f2:	4509                	li	a0,2
     2f4:	00001097          	auipc	ra,0x1
     2f8:	ec6080e7          	jalr	-314(ra) # 11ba <fprintf>
     2fc:	b745                	j	29c <main+0x15e>
    else color_yellow();
     2fe:	00000097          	auipc	ra,0x0
     302:	d36080e7          	jalr	-714(ra) # 34 <color_yellow>
    fprintf(2, "    Worker %d: tickets = %d", i+1, worker_tickets[i]);
     306:	86a6                	mv	a3,s1
     308:	864a                	mv	a2,s2
     30a:	85d2                	mv	a1,s4
     30c:	4509                	li	a0,2
     30e:	00001097          	auipc	ra,0x1
     312:	eac080e7          	jalr	-340(ra) # 11ba <fprintf>
    else if(worker_tickets[i] == 10) fprintf(2, "  <-- 2x vs Worker1");
     316:	01948e63          	beq	s1,s9,332 <main+0x1f4>
    else if(worker_tickets[i] == 5) fprintf(2, "  <-- baseline");
     31a:	f97491e3          	bne	s1,s7,29c <main+0x15e>
     31e:	00001597          	auipc	a1,0x1
     322:	1aa58593          	addi	a1,a1,426 # 14c8 <malloc+0x228>
     326:	4509                	li	a0,2
     328:	00001097          	auipc	ra,0x1
     32c:	e92080e7          	jalr	-366(ra) # 11ba <fprintf>
     330:	b7b5                	j	29c <main+0x15e>
    else if(worker_tickets[i] == 10) fprintf(2, "  <-- 2x vs Worker1");
     332:	00001597          	auipc	a1,0x1
     336:	17e58593          	addi	a1,a1,382 # 14b0 <malloc+0x210>
     33a:	4509                	li	a0,2
     33c:	00001097          	auipc	ra,0x1
     340:	e7e080e7          	jalr	-386(ra) # 11ba <fprintf>
     344:	bfa1                	j	29c <main+0x15e>
  }
  
  fprintf(2, "\n");
     346:	00001597          	auipc	a1,0x1
     34a:	11258593          	addi	a1,a1,274 # 1458 <malloc+0x1b8>
     34e:	4509                	li	a0,2
     350:	00001097          	auipc	ra,0x1
     354:	e6a080e7          	jalr	-406(ra) # 11ba <fprintf>
  fprintf(2, "  Expected: CPU time proportional to tickets (5:10:20:40:10)\n");
     358:	00001597          	auipc	a1,0x1
     35c:	18058593          	addi	a1,a1,384 # 14d8 <malloc+0x238>
     360:	4509                	li	a0,2
     362:	00001097          	auipc	ra,0x1
     366:	e58080e7          	jalr	-424(ra) # 11ba <fprintf>
  fprintf(2, "\n");
     36a:	00001597          	auipc	a1,0x1
     36e:	0ee58593          	addi	a1,a1,238 # 1458 <malloc+0x1b8>
     372:	4509                	li	a0,2
     374:	00001097          	auipc	ra,0x1
     378:	e46080e7          	jalr	-442(ra) # 11ba <fprintf>
  fprintf(2, "  Starting in 2 seconds... (auto-exit after %d rounds)\n", rounds);
     37c:	81843603          	ld	a2,-2024(s0)
     380:	00001597          	auipc	a1,0x1
     384:	19858593          	addi	a1,a1,408 # 1518 <malloc+0x278>
     388:	4509                	li	a0,2
     38a:	00001097          	auipc	ra,0x1
     38e:	e30080e7          	jalr	-464(ra) # 11ba <fprintf>
  fprintf(2, "\n");
     392:	00001597          	auipc	a1,0x1
     396:	0c658593          	addi	a1,a1,198 # 1458 <malloc+0x1b8>
     39a:	4509                	li	a0,2
     39c:	00001097          	auipc	ra,0x1
     3a0:	e1e080e7          	jalr	-482(ra) # 11ba <fprintf>
  
  sleep(200);
     3a4:	0c800513          	li	a0,200
     3a8:	00001097          	auipc	ra,0x1
     3ac:	938080e7          	jalr	-1736(ra) # ce0 <sleep>
  for(int i = 0; i < NUM_WORKERS; i++) {
     3b0:	4481                	li	s1,0
    worker_pids[num_workers++] = pid;
     3b2:	00001917          	auipc	s2,0x1
     3b6:	53690913          	addi	s2,s2,1334 # 18e8 <num_workers>
  for(int i = 0; i < NUM_WORKERS; i++) {
     3ba:	4995                	li	s3,5
    int pid = fork();
     3bc:	00001097          	auipc	ra,0x1
     3c0:	8a4080e7          	jalr	-1884(ra) # c60 <fork>
    if(pid == 0) {
     3c4:	c531                	beqz	a0,410 <main+0x2d2>
    worker_pids[num_workers++] = pid;
     3c6:	00092783          	lw	a5,0(s2)
     3ca:	0017871b          	addiw	a4,a5,1
     3ce:	00e92023          	sw	a4,0(s2)
     3d2:	078a                	slli	a5,a5,0x2
     3d4:	97ca                	add	a5,a5,s2
     3d6:	c788                	sw	a0,8(a5)
  for(int i = 0; i < NUM_WORKERS; i++) {
     3d8:	2485                	addiw	s1,s1,1
     3da:	ff3491e3          	bne	s1,s3,3bc <main+0x27e>
  
  // 启动 worker
  spawn_workers();
  fprintf(2, "  Workers spawned: PIDs = ");
     3de:	00001597          	auipc	a1,0x1
     3e2:	17258593          	addi	a1,a1,370 # 1550 <malloc+0x2b0>
     3e6:	4509                	li	a0,2
     3e8:	00001097          	auipc	ra,0x1
     3ec:	dd2080e7          	jalr	-558(ra) # 11ba <fprintf>
     3f0:	00001917          	auipc	s2,0x1
     3f4:	50090913          	addi	s2,s2,1280 # 18f0 <worker_pids>
     3f8:	4485                	li	s1,1
  for(int i = 0; i < NUM_WORKERS; i++) {
    fprintf(2, "%d", worker_pids[i]);
     3fa:	00001a17          	auipc	s4,0x1
     3fe:	176a0a13          	addi	s4,s4,374 # 1570 <malloc+0x2d0>
    if(i < NUM_WORKERS - 1) fprintf(2, ", ");
     402:	498d                	li	s3,3
  for(int i = 0; i < NUM_WORKERS; i++) {
     404:	4b11                	li	s6,4
    if(i < NUM_WORKERS - 1) fprintf(2, ", ");
     406:	00001a97          	auipc	s5,0x1
     40a:	172a8a93          	addi	s5,s5,370 # 1578 <malloc+0x2d8>
     40e:	a059                	j	494 <main+0x356>
      cpu_worker(worker_tickets[i]);
     410:	048a                	slli	s1,s1,0x2
     412:	00001797          	auipc	a5,0x1
     416:	44678793          	addi	a5,a5,1094 # 1858 <worker_tickets>
     41a:	97a6                	add	a5,a5,s1
  settickets(tickets);
     41c:	4388                	lw	a0,0(a5)
     41e:	00001097          	auipc	ra,0x1
     422:	93a080e7          	jalr	-1734(ra) # d58 <settickets>
  volatile unsigned long counter = 0;
     426:	86043023          	sd	zero,-1952(s0)
    counter++;
     42a:	86043783          	ld	a5,-1952(s0)
     42e:	0785                	addi	a5,a5,1
     430:	86f43023          	sd	a5,-1952(s0)
  while(1) {
     434:	bfdd                	j	42a <main+0x2ec>
  for(int i = 0; i < NUM_WORKERS; i++) {
     436:	0004879b          	sext.w	a5,s1
     43a:	04fb5b63          	bge	s6,a5,490 <main+0x352>
  }
  fprintf(2, "\n");
     43e:	00001597          	auipc	a1,0x1
     442:	01a58593          	addi	a1,a1,26 # 1458 <malloc+0x1b8>
     446:	4509                	li	a0,2
     448:	00001097          	auipc	ra,0x1
     44c:	d72080e7          	jalr	-654(ra) # 11ba <fprintf>
  sleep(100);
     450:	06400513          	li	a0,100
     454:	00001097          	auipc	ra,0x1
     458:	88c080e7          	jalr	-1908(ra) # ce0 <sleep>
  
  struct pstat ps;
  
  for(int r = 1; r <= rounds; r++) {
     45c:	81843783          	ld	a5,-2024(s0)
     460:	0007871b          	sext.w	a4,a5
     464:	80e43823          	sd	a4,-2032(s0)
     468:	2785                	addiw	a5,a5,1
     46a:	80f43423          	sd	a5,-2040(s0)
     46e:	4785                	li	a5,1
     470:	84f43023          	sd	a5,-1984(s0)
    unsigned long worker_ticks[NUM_WORKERS];
    for(int w = 0; w < NUM_WORKERS; w++) worker_ticks[w] = 0;
    
    for(int i = 0; i < NPROC; i++) {
      if(!ps.inuse[i]) continue;
      for(int w = 0; w < NUM_WORKERS; w++) {
     474:	4995                	li	s3,5
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
     476:	4a3267b7          	lui	a5,0x4a326
     47a:	b1b78793          	addi	a5,a5,-1253 # 4a325b1b <__global_pointer$+0x4a323a3a>
     47e:	80f43023          	sd	a5,-2048(s0)
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     482:	353367b7          	lui	a5,0x35336
     486:	b1b78793          	addi	a5,a5,-1253 # 35335b1b <__global_pointer$+0x35333a3a>
     48a:	82f43023          	sd	a5,-2016(s0)
     48e:	a65d                	j	834 <main+0x6f6>
     490:	0911                	addi	s2,s2,4
     492:	2485                	addiw	s1,s1,1
    fprintf(2, "%d", worker_pids[i]);
     494:	00092603          	lw	a2,0(s2)
     498:	85d2                	mv	a1,s4
     49a:	4509                	li	a0,2
     49c:	00001097          	auipc	ra,0x1
     4a0:	d1e080e7          	jalr	-738(ra) # 11ba <fprintf>
    if(i < NUM_WORKERS - 1) fprintf(2, ", ");
     4a4:	fff4879b          	addiw	a5,s1,-1
     4a8:	f8f9c7e3          	blt	s3,a5,436 <main+0x2f8>
     4ac:	85d6                	mv	a1,s5
     4ae:	4509                	li	a0,2
     4b0:	00001097          	auipc	ra,0x1
     4b4:	d0a080e7          	jalr	-758(ra) # 11ba <fprintf>
  for(int i = 0; i < NUM_WORKERS; i++) {
     4b8:	bfe1                	j	490 <main+0x352>
      fprintf(2, "procshow: getpinfo failed\n");
     4ba:	00001597          	auipc	a1,0x1
     4be:	0c658593          	addi	a1,a1,198 # 1580 <malloc+0x2e0>
     4c2:	4509                	li	a0,2
     4c4:	00001097          	auipc	ra,0x1
     4c8:	cf6080e7          	jalr	-778(ra) # 11ba <fprintf>
      kill_workers();
     4cc:	00000097          	auipc	ra,0x0
     4d0:	bfc080e7          	jalr	-1028(ra) # c8 <kill_workers>
      exit(1);
     4d4:	4505                	li	a0,1
     4d6:	00000097          	auipc	ra,0x0
     4da:	792080e7          	jalr	1938(ra) # c68 <exit>
        if(ps.pid[i] == worker_pids[w]) {
          worker_ticks[w] = ps.runticks[i];
     4de:	078e                	slli	a5,a5,0x3
     4e0:	f9078793          	addi	a5,a5,-112
     4e4:	97a2                	add	a5,a5,s0
     4e6:	6118                	ld	a4,0(a0)
     4e8:	8ce7b823          	sd	a4,-1840(a5)
    for(int i = 0; i < NPROC; i++) {
     4ec:	0691                	addi	a3,a3,4
     4ee:	0521                	addi	a0,a0,8
     4f0:	02d80363          	beq	a6,a3,516 <main+0x3d8>
      if(!ps.inuse[i]) continue;
     4f4:	429c                	lw	a5,0(a3)
     4f6:	dbfd                	beqz	a5,4ec <main+0x3ae>
        if(ps.pid[i] == worker_pids[w]) {
     4f8:	0c86a583          	lw	a1,200(a3)
     4fc:	00001717          	auipc	a4,0x1
     500:	3f470713          	addi	a4,a4,1012 # 18f0 <worker_pids>
      for(int w = 0; w < NUM_WORKERS; w++) {
     504:	87c6                	mv	a5,a7
        if(ps.pid[i] == worker_pids[w]) {
     506:	4310                	lw	a2,0(a4)
     508:	fcb60be3          	beq	a2,a1,4de <main+0x3a0>
      for(int w = 0; w < NUM_WORKERS; w++) {
     50c:	2785                	addiw	a5,a5,1
     50e:	0711                	addi	a4,a4,4
     510:	ff379be3          	bne	a5,s3,506 <main+0x3c8>
     514:	bfe1                	j	4ec <main+0x3ae>
    }
    
    // 计算最大值
    unsigned long max_ticks = 1;
    for(int w = 0; w < NUM_WORKERS; w++) {
      if(worker_ticks[w] > max_ticks) max_ticks = worker_ticks[w];
     516:	86043783          	ld	a5,-1952(s0)
     51a:	873e                	mv	a4,a5
     51c:	82f43423          	sd	a5,-2008(s0)
     520:	86843783          	ld	a5,-1944(s0)
     524:	00e7f363          	bgeu	a5,a4,52a <main+0x3ec>
     528:	87ba                	mv	a5,a4
     52a:	e391                	bnez	a5,52e <main+0x3f0>
     52c:	4785                	li	a5,1
     52e:	87043703          	ld	a4,-1936(s0)
     532:	00e7f363          	bgeu	a5,a4,538 <main+0x3fa>
     536:	87ba                	mv	a5,a4
     538:	87843703          	ld	a4,-1928(s0)
     53c:	00e7f363          	bgeu	a5,a4,542 <main+0x404>
     540:	87ba                	mv	a5,a4
     542:	88043703          	ld	a4,-1920(s0)
     546:	84f43423          	sd	a5,-1976(s0)
     54a:	00e7f463          	bgeu	a5,a4,552 <main+0x414>
     54e:	84e43423          	sd	a4,-1976(s0)
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
     552:	80043783          	ld	a5,-2048(s0)
     556:	84f42c23          	sw	a5,-1960(s0)
     55a:	6799                	lui	a5,0x6
     55c:	b1b78793          	addi	a5,a5,-1253 # 5b1b <__global_pointer$+0x3a3a>
     560:	84f41e23          	sh	a5,-1956(s0)
     564:	04800793          	li	a5,72
     568:	84f40f23          	sb	a5,-1954(s0)
  write(2, seq, sizeof(seq));
     56c:	461d                	li	a2,7
     56e:	85840593          	addi	a1,s0,-1960
     572:	4509                	li	a0,2
     574:	00000097          	auipc	ra,0x0
     578:	714080e7          	jalr	1812(ra) # c88 <write>
  color_cyan();
     57c:	00000097          	auipc	ra,0x0
     580:	a84080e7          	jalr	-1404(ra) # 0 <color_cyan>
  fprintf(2, "+================================================================+\n");
     584:	00001597          	auipc	a1,0x1
     588:	e0c58593          	addi	a1,a1,-500 # 1390 <malloc+0xf0>
     58c:	4509                	li	a0,2
     58e:	00001097          	auipc	ra,0x1
     592:	c2c080e7          	jalr	-980(ra) # 11ba <fprintf>
  fprintf(2, "|       Stride Scheduler Dashboard - Serein OS V3.0              |\n");
     596:	00001597          	auipc	a1,0x1
     59a:	00a58593          	addi	a1,a1,10 # 15a0 <malloc+0x300>
     59e:	4509                	li	a0,2
     5a0:	00001097          	auipc	ra,0x1
     5a4:	c1a080e7          	jalr	-998(ra) # 11ba <fprintf>
  fprintf(2, "|                     Round %d / %d                               |\n", round, total);
     5a8:	81843683          	ld	a3,-2024(s0)
     5ac:	84043603          	ld	a2,-1984(s0)
     5b0:	00001597          	auipc	a1,0x1
     5b4:	03858593          	addi	a1,a1,56 # 15e8 <malloc+0x348>
     5b8:	4509                	li	a0,2
     5ba:	00001097          	auipc	ra,0x1
     5be:	c00080e7          	jalr	-1024(ra) # 11ba <fprintf>
  fprintf(2, "+================================================================+\n");
     5c2:	00001597          	auipc	a1,0x1
     5c6:	dce58593          	addi	a1,a1,-562 # 1390 <malloc+0xf0>
     5ca:	4509                	li	a0,2
     5cc:	00001097          	auipc	ra,0x1
     5d0:	bee080e7          	jalr	-1042(ra) # 11ba <fprintf>
  color_reset();
     5d4:	00000097          	auipc	ra,0x0
     5d8:	ac8080e7          	jalr	-1336(ra) # 9c <color_reset>
    
    // 清屏并显示
    cls();
    print_header(r, rounds);
    
    fprintf(2, "\n");
     5dc:	00001597          	auipc	a1,0x1
     5e0:	e7c58593          	addi	a1,a1,-388 # 1458 <malloc+0x1b8>
     5e4:	4509                	li	a0,2
     5e6:	00001097          	auipc	ra,0x1
     5ea:	bd4080e7          	jalr	-1068(ra) # 11ba <fprintf>
    fprintf(2, "  WORKER  TICKETS   TICKS       RUNTIME BAR (proportional)\n");
     5ee:	00001597          	auipc	a1,0x1
     5f2:	04258593          	addi	a1,a1,66 # 1630 <malloc+0x390>
     5f6:	4509                	li	a0,2
     5f8:	00001097          	auipc	ra,0x1
     5fc:	bc2080e7          	jalr	-1086(ra) # 11ba <fprintf>
    fprintf(2, "  ------  -------   -----       ---------------------------\n");
     600:	00001597          	auipc	a1,0x1
     604:	07058593          	addi	a1,a1,112 # 1670 <malloc+0x3d0>
     608:	4509                	li	a0,2
     60a:	00001097          	auipc	ra,0x1
     60e:	bb0080e7          	jalr	-1104(ra) # 11ba <fprintf>
    
    for(int w = 0; w < NUM_WORKERS; w++) {
     612:	86040793          	addi	a5,s0,-1952
     616:	82f43c23          	sd	a5,-1992(s0)
    fprintf(2, "  ------  -------   -----       ---------------------------\n");
     61a:	8d3e                	mv	s10,a5
     61c:	00001c97          	auipc	s9,0x1
     620:	23cc8c93          	addi	s9,s9,572 # 1858 <worker_tickets>
     624:	4c05                	li	s8,1
      else if(worker_tickets[w] >= 20) color_green();
      else color_yellow();
      
      fprintf(2, "  W%d       %d", w+1, worker_tickets[w]);
      // 手动对齐
      if(worker_tickets[w] < 10) fprintf(2, " ");
     626:	4da5                	li	s11,9
  write(2, seq, sizeof(seq));
     628:	85840793          	addi	a5,s0,-1960
     62c:	82f43823          	sd	a5,-2000(s0)
    fprintf(2, "#");
     630:	00001b17          	auipc	s6,0x1
     634:	0a8b0b13          	addi	s6,s6,168 # 16d8 <malloc+0x438>
    fprintf(2, ".");
     638:	00001a97          	auipc	s5,0x1
     63c:	0a8a8a93          	addi	s5,s5,168 # 16e0 <malloc+0x440>
     640:	aa21                	j	758 <main+0x61a>
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     642:	82043783          	ld	a5,-2016(s0)
     646:	84f42c23          	sw	a5,-1960(s0)
     64a:	06d00793          	li	a5,109
     64e:	84f40e23          	sb	a5,-1956(s0)
  write(2, seq, sizeof(seq));
     652:	864e                	mv	a2,s3
     654:	83043583          	ld	a1,-2000(s0)
     658:	4509                	li	a0,2
     65a:	00000097          	auipc	ra,0x0
     65e:	62e080e7          	jalr	1582(ra) # c88 <write>
      fprintf(2, "  W%d       %d", w+1, worker_tickets[w]);
     662:	86a6                	mv	a3,s1
     664:	8662                	mv	a2,s8
     666:	00001597          	auipc	a1,0x1
     66a:	04a58593          	addi	a1,a1,74 # 16b0 <malloc+0x410>
     66e:	4509                	li	a0,2
     670:	00001097          	auipc	ra,0x1
     674:	b4a080e7          	jalr	-1206(ra) # 11ba <fprintf>
      fprintf(2, "       %l", worker_ticks[w]);
     678:	000d3b83          	ld	s7,0(s10)
     67c:	865e                	mv	a2,s7
     67e:	00001597          	auipc	a1,0x1
     682:	04a58593          	addi	a1,a1,74 # 16c8 <malloc+0x428>
     686:	4509                	li	a0,2
     688:	00001097          	auipc	ra,0x1
     68c:	b32080e7          	jalr	-1230(ra) # 11ba <fprintf>
      
      // 手动填充空格
      int spaces = 8;
      unsigned long temp = worker_ticks[w];
      while(temp >= 10) { temp /= 10; spaces--; }
     690:	117dfd63          	bgeu	s11,s7,7aa <main+0x66c>
      unsigned long temp = worker_ticks[w];
     694:	87de                	mv	a5,s7
      int spaces = 8;
     696:	44a1                	li	s1,8
      while(temp >= 10) { temp /= 10; spaces--; }
     698:	4629                	li	a2,10
     69a:	06300693          	li	a3,99
     69e:	873e                	mv	a4,a5
     6a0:	02c7d7b3          	divu	a5,a5,a2
     6a4:	34fd                	addiw	s1,s1,-1
     6a6:	fee6ece3          	bltu	a3,a4,69e <main+0x560>
      for(int s = 0; s < spaces; s++) fprintf(2, " ");
     6aa:	02905063          	blez	s1,6ca <main+0x58c>
      int spaces = 8;
     6ae:	4901                	li	s2,0
      for(int s = 0; s < spaces; s++) fprintf(2, " ");
     6b0:	00001a17          	auipc	s4,0x1
     6b4:	010a0a13          	addi	s4,s4,16 # 16c0 <malloc+0x420>
     6b8:	85d2                	mv	a1,s4
     6ba:	4509                	li	a0,2
     6bc:	00001097          	auipc	ra,0x1
     6c0:	afe080e7          	jalr	-1282(ra) # 11ba <fprintf>
     6c4:	2905                	addiw	s2,s2,1
     6c6:	fe9949e3          	blt	s2,s1,6b8 <main+0x57a>
      
      color_reset();
     6ca:	00000097          	auipc	ra,0x0
     6ce:	9d2080e7          	jalr	-1582(ra) # 9c <color_reset>
  int filled = (int)((value * width) / max);
     6d2:	003b9a13          	slli	s4,s7,0x3
     6d6:	417a0a33          	sub	s4,s4,s7
     6da:	0a0a                	slli	s4,s4,0x2
     6dc:	84843703          	ld	a4,-1976(s0)
     6e0:	87ba                	mv	a5,a4
     6e2:	e311                	bnez	a4,6e6 <main+0x5a8>
     6e4:	4785                	li	a5,1
     6e6:	02fa5a33          	divu	s4,s4,a5
     6ea:	2a01                	sext.w	s4,s4
  if(filled > width) filled = width;
     6ec:	84d2                	mv	s1,s4
     6ee:	47f1                	li	a5,28
     6f0:	0147d363          	bge	a5,s4,6f6 <main+0x5b8>
     6f4:	44f1                	li	s1,28
     6f6:	2481                	sext.w	s1,s1
  color_green();
     6f8:	00000097          	auipc	ra,0x0
     6fc:	970080e7          	jalr	-1680(ra) # 68 <color_green>
  for(int i = 0; i < filled; i++) {
     700:	01405c63          	blez	s4,718 <main+0x5da>
     704:	4901                	li	s2,0
    fprintf(2, "#");
     706:	85da                	mv	a1,s6
     708:	4509                	li	a0,2
     70a:	00001097          	auipc	ra,0x1
     70e:	ab0080e7          	jalr	-1360(ra) # 11ba <fprintf>
  for(int i = 0; i < filled; i++) {
     712:	2905                	addiw	s2,s2,1
     714:	fe9949e3          	blt	s2,s1,706 <main+0x5c8>
  color_reset();
     718:	00000097          	auipc	ra,0x0
     71c:	984080e7          	jalr	-1660(ra) # 9c <color_reset>
  for(int i = filled; i < width; i++) {
     720:	47ed                	li	a5,27
     722:	0147cc63          	blt	a5,s4,73a <main+0x5fc>
     726:	496d                	li	s2,27
    fprintf(2, ".");
     728:	85d6                	mv	a1,s5
     72a:	4509                	li	a0,2
     72c:	00001097          	auipc	ra,0x1
     730:	a8e080e7          	jalr	-1394(ra) # 11ba <fprintf>
  for(int i = filled; i < width; i++) {
     734:	2485                	addiw	s1,s1,1
     736:	fe9959e3          	bge	s2,s1,728 <main+0x5ea>
      print_bar(worker_ticks[w], max_ticks, 28);
      fprintf(2, "\n");
     73a:	00001597          	auipc	a1,0x1
     73e:	d1e58593          	addi	a1,a1,-738 # 1458 <malloc+0x1b8>
     742:	4509                	li	a0,2
     744:	00001097          	auipc	ra,0x1
     748:	a76080e7          	jalr	-1418(ra) # 11ba <fprintf>
    for(int w = 0; w < NUM_WORKERS; w++) {
     74c:	0c91                	addi	s9,s9,4
     74e:	2c05                	addiw	s8,s8,1
     750:	0d21                	addi	s10,s10,8
     752:	4799                	li	a5,6
     754:	04fc0d63          	beq	s8,a5,7ae <main+0x670>
      if(worker_tickets[w] >= 40) color_magenta();
     758:	000ca483          	lw	s1,0(s9)
     75c:	02700793          	li	a5,39
     760:	ee97c1e3          	blt	a5,s1,642 <main+0x504>
      else if(worker_tickets[w] >= 20) color_green();
     764:	47cd                	li	a5,19
     766:	0097d763          	bge	a5,s1,774 <main+0x636>
     76a:	00000097          	auipc	ra,0x0
     76e:	8fe080e7          	jalr	-1794(ra) # 68 <color_green>
     772:	bdc5                	j	662 <main+0x524>
      else color_yellow();
     774:	00000097          	auipc	ra,0x0
     778:	8c0080e7          	jalr	-1856(ra) # 34 <color_yellow>
      fprintf(2, "  W%d       %d", w+1, worker_tickets[w]);
     77c:	86a6                	mv	a3,s1
     77e:	8662                	mv	a2,s8
     780:	00001597          	auipc	a1,0x1
     784:	f3058593          	addi	a1,a1,-208 # 16b0 <malloc+0x410>
     788:	4509                	li	a0,2
     78a:	00001097          	auipc	ra,0x1
     78e:	a30080e7          	jalr	-1488(ra) # 11ba <fprintf>
      if(worker_tickets[w] < 10) fprintf(2, " ");
     792:	ee9dc3e3          	blt	s11,s1,678 <main+0x53a>
     796:	00001597          	auipc	a1,0x1
     79a:	f2a58593          	addi	a1,a1,-214 # 16c0 <malloc+0x420>
     79e:	4509                	li	a0,2
     7a0:	00001097          	auipc	ra,0x1
     7a4:	a1a080e7          	jalr	-1510(ra) # 11ba <fprintf>
     7a8:	bdc1                	j	678 <main+0x53a>
      int spaces = 8;
     7aa:	44a1                	li	s1,8
     7ac:	b709                	j	6ae <main+0x570>
    }
    
    fprintf(2, "\n");
     7ae:	00001597          	auipc	a1,0x1
     7b2:	caa58593          	addi	a1,a1,-854 # 1458 <malloc+0x1b8>
     7b6:	4509                	li	a0,2
     7b8:	00001097          	auipc	ra,0x1
     7bc:	a02080e7          	jalr	-1534(ra) # 11ba <fprintf>
    color_cyan();
     7c0:	00000097          	auipc	ra,0x0
     7c4:	840080e7          	jalr	-1984(ra) # 0 <color_cyan>
    fprintf(2, "  +------------------------------------------------------------+\n");
     7c8:	00001597          	auipc	a1,0x1
     7cc:	f2058593          	addi	a1,a1,-224 # 16e8 <malloc+0x448>
     7d0:	4509                	li	a0,2
     7d2:	00001097          	auipc	ra,0x1
     7d6:	9e8080e7          	jalr	-1560(ra) # 11ba <fprintf>
    color_reset();
     7da:	00000097          	auipc	ra,0x0
     7de:	8c2080e7          	jalr	-1854(ra) # 9c <color_reset>
    
    // 计算比例验证
    if(worker_ticks[0] > 0) {
     7e2:	82843783          	ld	a5,-2008(s0)
     7e6:	e3c9                	bnez	a5,868 <main+0x72a>
      }
      fprintf(2, "\n");
      fprintf(2, "  Expected:     W2=200%% W3=400%% W4=800%% W5=200%%\n");
    }
    
    fprintf(2, "\n");
     7e8:	00001597          	auipc	a1,0x1
     7ec:	c7058593          	addi	a1,a1,-912 # 1458 <malloc+0x1b8>
     7f0:	4509                	li	a0,2
     7f2:	00001097          	auipc	ra,0x1
     7f6:	9c8080e7          	jalr	-1592(ra) # 11ba <fprintf>
    fprintf(2, "  Auto-exit in %d rounds...\n", rounds - r);
     7fa:	81043703          	ld	a4,-2032(s0)
     7fe:	84043483          	ld	s1,-1984(s0)
     802:	4097063b          	subw	a2,a4,s1
     806:	00001597          	auipc	a1,0x1
     80a:	f8a58593          	addi	a1,a1,-118 # 1790 <malloc+0x4f0>
     80e:	4509                	li	a0,2
     810:	00001097          	auipc	ra,0x1
     814:	9aa080e7          	jalr	-1622(ra) # 11ba <fprintf>
    
    sleep(100);
     818:	06400513          	li	a0,100
     81c:	00000097          	auipc	ra,0x0
     820:	4c4080e7          	jalr	1220(ra) # ce0 <sleep>
  for(int r = 1; r <= rounds; r++) {
     824:	0014879b          	addiw	a5,s1,1
     828:	84f43023          	sd	a5,-1984(s0)
     82c:	80843703          	ld	a4,-2040(s0)
     830:	10e78b63          	beq	a5,a4,946 <main+0x808>
    if(getpinfo(&ps) < 0) {
     834:	88840513          	addi	a0,s0,-1912
     838:	00000097          	auipc	ra,0x0
     83c:	52a080e7          	jalr	1322(ra) # d62 <getpinfo>
     840:	c6054de3          	bltz	a0,4ba <main+0x37c>
    for(int w = 0; w < NUM_WORKERS; w++) worker_ticks[w] = 0;
     844:	86043023          	sd	zero,-1952(s0)
     848:	86043423          	sd	zero,-1944(s0)
     84c:	86043823          	sd	zero,-1936(s0)
     850:	86043c23          	sd	zero,-1928(s0)
     854:	88043023          	sd	zero,-1920(s0)
     858:	88840693          	addi	a3,s0,-1912
     85c:	ae040513          	addi	a0,s0,-1312
     860:	95040813          	addi	a6,s0,-1712
      for(int w = 0; w < NUM_WORKERS; w++) {
     864:	4881                	li	a7,0
     866:	b179                	j	4f4 <main+0x3b6>
      fprintf(2, "  Ratios vs W1: ");
     868:	00001597          	auipc	a1,0x1
     86c:	ec858593          	addi	a1,a1,-312 # 1730 <malloc+0x490>
     870:	4509                	li	a0,2
     872:	00001097          	auipc	ra,0x1
     876:	948080e7          	jalr	-1720(ra) # 11ba <fprintf>
     87a:	00001a17          	auipc	s4,0x1
     87e:	fdea0a13          	addi	s4,s4,-34 # 1858 <worker_tickets>
      for(int w = 1; w < NUM_WORKERS; w++) {
     882:	4a85                	li	s5,1
        int ratio = (int)((worker_ticks[w] * 100) / worker_ticks[0]);
     884:	06400b13          	li	s6,100
        int expected = (worker_tickets[w] * 100) / worker_tickets[0];
     888:	06400b93          	li	s7,100
     88c:	4c15                	li	s8,5
        fprintf(2, "W%d=%d%%", w+1, ratio);
     88e:	00001d17          	auipc	s10,0x1
     892:	ebad0d13          	addi	s10,s10,-326 # 1748 <malloc+0x4a8>
        if(w < NUM_WORKERS - 1) fprintf(2, " ");
     896:	4c8d                	li	s9,3
     898:	00001d97          	auipc	s11,0x1
     89c:	e28d8d93          	addi	s11,s11,-472 # 16c0 <malloc+0x420>
     8a0:	a0a1                	j	8e8 <main+0x7aa>
          color_yellow();
     8a2:	fffff097          	auipc	ra,0xfffff
     8a6:	792080e7          	jalr	1938(ra) # 34 <color_yellow>
        fprintf(2, "W%d=%d%%", w+1, ratio);
     8aa:	001a891b          	addiw	s2,s5,1
     8ae:	86a6                	mv	a3,s1
     8b0:	864a                	mv	a2,s2
     8b2:	85ea                	mv	a1,s10
     8b4:	4509                	li	a0,2
     8b6:	00001097          	auipc	ra,0x1
     8ba:	904080e7          	jalr	-1788(ra) # 11ba <fprintf>
        color_reset();
     8be:	fffff097          	auipc	ra,0xfffff
     8c2:	7de080e7          	jalr	2014(ra) # 9c <color_reset>
        if(w < NUM_WORKERS - 1) fprintf(2, " ");
     8c6:	015cc863          	blt	s9,s5,8d6 <main+0x798>
     8ca:	85ee                	mv	a1,s11
     8cc:	4509                	li	a0,2
     8ce:	00001097          	auipc	ra,0x1
     8d2:	8ec080e7          	jalr	-1812(ra) # 11ba <fprintf>
      for(int w = 1; w < NUM_WORKERS; w++) {
     8d6:	83843783          	ld	a5,-1992(s0)
     8da:	07a1                	addi	a5,a5,8
     8dc:	82f43c23          	sd	a5,-1992(s0)
     8e0:	0a11                	addi	s4,s4,4
     8e2:	03390f63          	beq	s2,s3,920 <main+0x7e2>
     8e6:	8aca                	mv	s5,s2
        int ratio = (int)((worker_ticks[w] * 100) / worker_ticks[0]);
     8e8:	83843783          	ld	a5,-1992(s0)
     8ec:	6784                	ld	s1,8(a5)
     8ee:	029b04b3          	mul	s1,s6,s1
     8f2:	82843783          	ld	a5,-2008(s0)
     8f6:	02f4d4b3          	divu	s1,s1,a5
     8fa:	2481                	sext.w	s1,s1
        int expected = (worker_tickets[w] * 100) / worker_tickets[0];
     8fc:	004a2783          	lw	a5,4(s4)
     900:	02fb87bb          	mulw	a5,s7,a5
     904:	0387c7bb          	divw	a5,a5,s8
        if(ratio >= expected - 20 && ratio <= expected + 20) {
     908:	fec7871b          	addiw	a4,a5,-20
     90c:	f8e4cbe3          	blt	s1,a4,8a2 <main+0x764>
     910:	27d1                	addiw	a5,a5,20
     912:	f897c8e3          	blt	a5,s1,8a2 <main+0x764>
          color_green();
     916:	fffff097          	auipc	ra,0xfffff
     91a:	752080e7          	jalr	1874(ra) # 68 <color_green>
     91e:	b771                	j	8aa <main+0x76c>
      fprintf(2, "\n");
     920:	00001597          	auipc	a1,0x1
     924:	b3858593          	addi	a1,a1,-1224 # 1458 <malloc+0x1b8>
     928:	4509                	li	a0,2
     92a:	00001097          	auipc	ra,0x1
     92e:	890080e7          	jalr	-1904(ra) # 11ba <fprintf>
      fprintf(2, "  Expected:     W2=200%% W3=400%% W4=800%% W5=200%%\n");
     932:	00001597          	auipc	a1,0x1
     936:	e2658593          	addi	a1,a1,-474 # 1758 <malloc+0x4b8>
     93a:	4509                	li	a0,2
     93c:	00001097          	auipc	ra,0x1
     940:	87e080e7          	jalr	-1922(ra) # 11ba <fprintf>
     944:	b555                	j	7e8 <main+0x6aa>
  }
  
  // 演示完成
  color_green();
     946:	fffff097          	auipc	ra,0xfffff
     94a:	722080e7          	jalr	1826(ra) # 68 <color_green>
  fprintf(2, "\n  === Demo Complete! ===\n");
     94e:	00001597          	auipc	a1,0x1
     952:	e6258593          	addi	a1,a1,-414 # 17b0 <malloc+0x510>
     956:	4509                	li	a0,2
     958:	00001097          	auipc	ra,0x1
     95c:	862080e7          	jalr	-1950(ra) # 11ba <fprintf>
  color_reset();
     960:	fffff097          	auipc	ra,0xfffff
     964:	73c080e7          	jalr	1852(ra) # 9c <color_reset>
  fprintf(2, "  Terminating workers...\n");
     968:	00001597          	auipc	a1,0x1
     96c:	e6858593          	addi	a1,a1,-408 # 17d0 <malloc+0x530>
     970:	4509                	li	a0,2
     972:	00001097          	auipc	ra,0x1
     976:	848080e7          	jalr	-1976(ra) # 11ba <fprintf>
  
  kill_workers();
     97a:	fffff097          	auipc	ra,0xfffff
     97e:	74e080e7          	jalr	1870(ra) # c8 <kill_workers>
  
  fprintf(2, "  The Stride scheduler ensures fair CPU distribution!\n");
     982:	00001597          	auipc	a1,0x1
     986:	e6e58593          	addi	a1,a1,-402 # 17f0 <malloc+0x550>
     98a:	4509                	li	a0,2
     98c:	00001097          	auipc	ra,0x1
     990:	82e080e7          	jalr	-2002(ra) # 11ba <fprintf>
  fprintf(2, "  (CPU time is proportional to ticket count)\n\n");
     994:	00001597          	auipc	a1,0x1
     998:	e9458593          	addi	a1,a1,-364 # 1828 <malloc+0x588>
     99c:	4509                	li	a0,2
     99e:	00001097          	auipc	ra,0x1
     9a2:	81c080e7          	jalr	-2020(ra) # 11ba <fprintf>
  
  exit(0);
     9a6:	4501                	li	a0,0
     9a8:	00000097          	auipc	ra,0x0
     9ac:	2c0080e7          	jalr	704(ra) # c68 <exit>

00000000000009b0 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
     9b0:	1141                	addi	sp,sp,-16
     9b2:	e422                	sd	s0,8(sp)
     9b4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9b6:	87aa                	mv	a5,a0
     9b8:	0585                	addi	a1,a1,1
     9ba:	0785                	addi	a5,a5,1
     9bc:	fff5c703          	lbu	a4,-1(a1)
     9c0:	fee78fa3          	sb	a4,-1(a5)
     9c4:	fb75                	bnez	a4,9b8 <strcpy+0x8>
    ;
  return os;
}
     9c6:	6422                	ld	s0,8(sp)
     9c8:	0141                	addi	sp,sp,16
     9ca:	8082                	ret

00000000000009cc <strcat>:

char*
strcat(char *s, const char *t)
{
     9cc:	1141                	addi	sp,sp,-16
     9ce:	e422                	sd	s0,8(sp)
     9d0:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
     9d2:	00054783          	lbu	a5,0(a0)
     9d6:	c385                	beqz	a5,9f6 <strcat+0x2a>
     9d8:	87aa                	mv	a5,a0
    s++;
     9da:	0785                	addi	a5,a5,1
  while(*s)
     9dc:	0007c703          	lbu	a4,0(a5)
     9e0:	ff6d                	bnez	a4,9da <strcat+0xe>
  while((*s++ = *t++))
     9e2:	0585                	addi	a1,a1,1
     9e4:	0785                	addi	a5,a5,1
     9e6:	fff5c703          	lbu	a4,-1(a1)
     9ea:	fee78fa3          	sb	a4,-1(a5)
     9ee:	fb75                	bnez	a4,9e2 <strcat+0x16>
    ;
  return os;
}
     9f0:	6422                	ld	s0,8(sp)
     9f2:	0141                	addi	sp,sp,16
     9f4:	8082                	ret
  while(*s)
     9f6:	87aa                	mv	a5,a0
     9f8:	b7ed                	j	9e2 <strcat+0x16>

00000000000009fa <strcmp>:


int
strcmp(const char *p, const char *q)
{
     9fa:	1141                	addi	sp,sp,-16
     9fc:	e422                	sd	s0,8(sp)
     9fe:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     a00:	00054783          	lbu	a5,0(a0)
     a04:	cb91                	beqz	a5,a18 <strcmp+0x1e>
     a06:	0005c703          	lbu	a4,0(a1)
     a0a:	00f71763          	bne	a4,a5,a18 <strcmp+0x1e>
    p++, q++;
     a0e:	0505                	addi	a0,a0,1
     a10:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     a12:	00054783          	lbu	a5,0(a0)
     a16:	fbe5                	bnez	a5,a06 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     a18:	0005c503          	lbu	a0,0(a1)
}
     a1c:	40a7853b          	subw	a0,a5,a0
     a20:	6422                	ld	s0,8(sp)
     a22:	0141                	addi	sp,sp,16
     a24:	8082                	ret

0000000000000a26 <strlen>:

uint
strlen(const char *s)
{
     a26:	1141                	addi	sp,sp,-16
     a28:	e422                	sd	s0,8(sp)
     a2a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a2c:	00054783          	lbu	a5,0(a0)
     a30:	cf91                	beqz	a5,a4c <strlen+0x26>
     a32:	0505                	addi	a0,a0,1
     a34:	87aa                	mv	a5,a0
     a36:	4685                	li	a3,1
     a38:	9e89                	subw	a3,a3,a0
     a3a:	00f6853b          	addw	a0,a3,a5
     a3e:	0785                	addi	a5,a5,1
     a40:	fff7c703          	lbu	a4,-1(a5)
     a44:	fb7d                	bnez	a4,a3a <strlen+0x14>
    ;
  return n;
}
     a46:	6422                	ld	s0,8(sp)
     a48:	0141                	addi	sp,sp,16
     a4a:	8082                	ret
  for(n = 0; s[n]; n++)
     a4c:	4501                	li	a0,0
     a4e:	bfe5                	j	a46 <strlen+0x20>

0000000000000a50 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a50:	1141                	addi	sp,sp,-16
     a52:	e422                	sd	s0,8(sp)
     a54:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a56:	ca19                	beqz	a2,a6c <memset+0x1c>
     a58:	87aa                	mv	a5,a0
     a5a:	1602                	slli	a2,a2,0x20
     a5c:	9201                	srli	a2,a2,0x20
     a5e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a62:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a66:	0785                	addi	a5,a5,1
     a68:	fee79de3          	bne	a5,a4,a62 <memset+0x12>
  }
  return dst;
}
     a6c:	6422                	ld	s0,8(sp)
     a6e:	0141                	addi	sp,sp,16
     a70:	8082                	ret

0000000000000a72 <strchr>:

char*
strchr(const char *s, char c)
{
     a72:	1141                	addi	sp,sp,-16
     a74:	e422                	sd	s0,8(sp)
     a76:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a78:	00054783          	lbu	a5,0(a0)
     a7c:	cb99                	beqz	a5,a92 <strchr+0x20>
    if(*s == c)
     a7e:	00f58763          	beq	a1,a5,a8c <strchr+0x1a>
  for(; *s; s++)
     a82:	0505                	addi	a0,a0,1
     a84:	00054783          	lbu	a5,0(a0)
     a88:	fbfd                	bnez	a5,a7e <strchr+0xc>
      return (char*)s;
  return 0;
     a8a:	4501                	li	a0,0
}
     a8c:	6422                	ld	s0,8(sp)
     a8e:	0141                	addi	sp,sp,16
     a90:	8082                	ret
  return 0;
     a92:	4501                	li	a0,0
     a94:	bfe5                	j	a8c <strchr+0x1a>

0000000000000a96 <gets>:

char*
gets(char *buf, int max)
{
     a96:	711d                	addi	sp,sp,-96
     a98:	ec86                	sd	ra,88(sp)
     a9a:	e8a2                	sd	s0,80(sp)
     a9c:	e4a6                	sd	s1,72(sp)
     a9e:	e0ca                	sd	s2,64(sp)
     aa0:	fc4e                	sd	s3,56(sp)
     aa2:	f852                	sd	s4,48(sp)
     aa4:	f456                	sd	s5,40(sp)
     aa6:	f05a                	sd	s6,32(sp)
     aa8:	ec5e                	sd	s7,24(sp)
     aaa:	e862                	sd	s8,16(sp)
     aac:	1080                	addi	s0,sp,96
     aae:	8baa                	mv	s7,a0
     ab0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ab2:	892a                	mv	s2,a0
     ab4:	4481                	li	s1,0
    cc = read(0, &c, 1);
     ab6:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     aba:	4b29                	li	s6,10
     abc:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     abe:	89a6                	mv	s3,s1
     ac0:	2485                	addiw	s1,s1,1
     ac2:	0344d763          	bge	s1,s4,af0 <gets+0x5a>
    cc = read(0, &c, 1);
     ac6:	4605                	li	a2,1
     ac8:	85d6                	mv	a1,s5
     aca:	4501                	li	a0,0
     acc:	00000097          	auipc	ra,0x0
     ad0:	1b4080e7          	jalr	436(ra) # c80 <read>
    if(cc < 1)
     ad4:	00a05e63          	blez	a0,af0 <gets+0x5a>
    buf[i++] = c;
     ad8:	faf44783          	lbu	a5,-81(s0)
     adc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     ae0:	01678763          	beq	a5,s6,aee <gets+0x58>
     ae4:	0905                	addi	s2,s2,1
     ae6:	fd879ce3          	bne	a5,s8,abe <gets+0x28>
  for(i=0; i+1 < max; ){
     aea:	89a6                	mv	s3,s1
     aec:	a011                	j	af0 <gets+0x5a>
     aee:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     af0:	99de                	add	s3,s3,s7
     af2:	00098023          	sb	zero,0(s3)
  return buf;
}
     af6:	855e                	mv	a0,s7
     af8:	60e6                	ld	ra,88(sp)
     afa:	6446                	ld	s0,80(sp)
     afc:	64a6                	ld	s1,72(sp)
     afe:	6906                	ld	s2,64(sp)
     b00:	79e2                	ld	s3,56(sp)
     b02:	7a42                	ld	s4,48(sp)
     b04:	7aa2                	ld	s5,40(sp)
     b06:	7b02                	ld	s6,32(sp)
     b08:	6be2                	ld	s7,24(sp)
     b0a:	6c42                	ld	s8,16(sp)
     b0c:	6125                	addi	sp,sp,96
     b0e:	8082                	ret

0000000000000b10 <stat>:

int
stat(const char *n, struct stat *st)
{
     b10:	1101                	addi	sp,sp,-32
     b12:	ec06                	sd	ra,24(sp)
     b14:	e822                	sd	s0,16(sp)
     b16:	e426                	sd	s1,8(sp)
     b18:	e04a                	sd	s2,0(sp)
     b1a:	1000                	addi	s0,sp,32
     b1c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b1e:	4581                	li	a1,0
     b20:	00000097          	auipc	ra,0x0
     b24:	188080e7          	jalr	392(ra) # ca8 <open>
  if(fd < 0)
     b28:	02054563          	bltz	a0,b52 <stat+0x42>
     b2c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b2e:	85ca                	mv	a1,s2
     b30:	00000097          	auipc	ra,0x0
     b34:	180080e7          	jalr	384(ra) # cb0 <fstat>
     b38:	892a                	mv	s2,a0
  close(fd);
     b3a:	8526                	mv	a0,s1
     b3c:	00000097          	auipc	ra,0x0
     b40:	154080e7          	jalr	340(ra) # c90 <close>
  return r;
}
     b44:	854a                	mv	a0,s2
     b46:	60e2                	ld	ra,24(sp)
     b48:	6442                	ld	s0,16(sp)
     b4a:	64a2                	ld	s1,8(sp)
     b4c:	6902                	ld	s2,0(sp)
     b4e:	6105                	addi	sp,sp,32
     b50:	8082                	ret
    return -1;
     b52:	597d                	li	s2,-1
     b54:	bfc5                	j	b44 <stat+0x34>

0000000000000b56 <atoi>:

int
atoi(const char *s)
{
     b56:	1141                	addi	sp,sp,-16
     b58:	e422                	sd	s0,8(sp)
     b5a:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
     b5c:	00054703          	lbu	a4,0(a0)
     b60:	02d00793          	li	a5,45
  int neg = 1;
     b64:	4585                	li	a1,1
  if (*s == '-') {
     b66:	04f70363          	beq	a4,a5,bac <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
     b6a:	00054703          	lbu	a4,0(a0)
     b6e:	fd07079b          	addiw	a5,a4,-48
     b72:	0ff7f793          	zext.b	a5,a5
     b76:	46a5                	li	a3,9
     b78:	02f6ed63          	bltu	a3,a5,bb2 <atoi+0x5c>
  n = 0;
     b7c:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
     b7e:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
     b80:	0505                	addi	a0,a0,1
     b82:	0026979b          	slliw	a5,a3,0x2
     b86:	9fb5                	addw	a5,a5,a3
     b88:	0017979b          	slliw	a5,a5,0x1
     b8c:	9fb9                	addw	a5,a5,a4
     b8e:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
     b92:	00054703          	lbu	a4,0(a0)
     b96:	fd07079b          	addiw	a5,a4,-48
     b9a:	0ff7f793          	zext.b	a5,a5
     b9e:	fef671e3          	bgeu	a2,a5,b80 <atoi+0x2a>
  return n * neg;
}
     ba2:	02d5853b          	mulw	a0,a1,a3
     ba6:	6422                	ld	s0,8(sp)
     ba8:	0141                	addi	sp,sp,16
     baa:	8082                	ret
    s++;
     bac:	0505                	addi	a0,a0,1
    neg = -1;
     bae:	55fd                	li	a1,-1
     bb0:	bf6d                	j	b6a <atoi+0x14>
  n = 0;
     bb2:	4681                	li	a3,0
     bb4:	b7fd                	j	ba2 <atoi+0x4c>

0000000000000bb6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     bb6:	1141                	addi	sp,sp,-16
     bb8:	e422                	sd	s0,8(sp)
     bba:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     bbc:	02b57463          	bgeu	a0,a1,be4 <memmove+0x2e>
    while(n-- > 0)
     bc0:	00c05f63          	blez	a2,bde <memmove+0x28>
     bc4:	1602                	slli	a2,a2,0x20
     bc6:	9201                	srli	a2,a2,0x20
     bc8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     bcc:	872a                	mv	a4,a0
      *dst++ = *src++;
     bce:	0585                	addi	a1,a1,1
     bd0:	0705                	addi	a4,a4,1
     bd2:	fff5c683          	lbu	a3,-1(a1)
     bd6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     bda:	fee79ae3          	bne	a5,a4,bce <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     bde:	6422                	ld	s0,8(sp)
     be0:	0141                	addi	sp,sp,16
     be2:	8082                	ret
    dst += n;
     be4:	00c50733          	add	a4,a0,a2
    src += n;
     be8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     bea:	fec05ae3          	blez	a2,bde <memmove+0x28>
     bee:	fff6079b          	addiw	a5,a2,-1
     bf2:	1782                	slli	a5,a5,0x20
     bf4:	9381                	srli	a5,a5,0x20
     bf6:	fff7c793          	not	a5,a5
     bfa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     bfc:	15fd                	addi	a1,a1,-1
     bfe:	177d                	addi	a4,a4,-1
     c00:	0005c683          	lbu	a3,0(a1)
     c04:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     c08:	fee79ae3          	bne	a5,a4,bfc <memmove+0x46>
     c0c:	bfc9                	j	bde <memmove+0x28>

0000000000000c0e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     c0e:	1141                	addi	sp,sp,-16
     c10:	e422                	sd	s0,8(sp)
     c12:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     c14:	ca05                	beqz	a2,c44 <memcmp+0x36>
     c16:	fff6069b          	addiw	a3,a2,-1
     c1a:	1682                	slli	a3,a3,0x20
     c1c:	9281                	srli	a3,a3,0x20
     c1e:	0685                	addi	a3,a3,1
     c20:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     c22:	00054783          	lbu	a5,0(a0)
     c26:	0005c703          	lbu	a4,0(a1)
     c2a:	00e79863          	bne	a5,a4,c3a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     c2e:	0505                	addi	a0,a0,1
    p2++;
     c30:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     c32:	fed518e3          	bne	a0,a3,c22 <memcmp+0x14>
  }
  return 0;
     c36:	4501                	li	a0,0
     c38:	a019                	j	c3e <memcmp+0x30>
      return *p1 - *p2;
     c3a:	40e7853b          	subw	a0,a5,a4
}
     c3e:	6422                	ld	s0,8(sp)
     c40:	0141                	addi	sp,sp,16
     c42:	8082                	ret
  return 0;
     c44:	4501                	li	a0,0
     c46:	bfe5                	j	c3e <memcmp+0x30>

0000000000000c48 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c48:	1141                	addi	sp,sp,-16
     c4a:	e406                	sd	ra,8(sp)
     c4c:	e022                	sd	s0,0(sp)
     c4e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c50:	00000097          	auipc	ra,0x0
     c54:	f66080e7          	jalr	-154(ra) # bb6 <memmove>
}
     c58:	60a2                	ld	ra,8(sp)
     c5a:	6402                	ld	s0,0(sp)
     c5c:	0141                	addi	sp,sp,16
     c5e:	8082                	ret

0000000000000c60 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
     c60:	4885                	li	a7,1
 ecall
     c62:	00000073          	ecall
 ret
     c66:	8082                	ret

0000000000000c68 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c68:	4889                	li	a7,2
 ecall
     c6a:	00000073          	ecall
 ret
     c6e:	8082                	ret

0000000000000c70 <wait>:
.global wait
wait:
 li a7, SYS_wait
     c70:	488d                	li	a7,3
 ecall
     c72:	00000073          	ecall
 ret
     c76:	8082                	ret

0000000000000c78 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c78:	4891                	li	a7,4
 ecall
     c7a:	00000073          	ecall
 ret
     c7e:	8082                	ret

0000000000000c80 <read>:
.global read
read:
 li a7, SYS_read
     c80:	4895                	li	a7,5
 ecall
     c82:	00000073          	ecall
 ret
     c86:	8082                	ret

0000000000000c88 <write>:
.global write
write:
 li a7, SYS_write
     c88:	48c1                	li	a7,16
 ecall
     c8a:	00000073          	ecall
 ret
     c8e:	8082                	ret

0000000000000c90 <close>:
.global close
close:
 li a7, SYS_close
     c90:	48d5                	li	a7,21
 ecall
     c92:	00000073          	ecall
 ret
     c96:	8082                	ret

0000000000000c98 <kill>:
.global kill
kill:
 li a7, SYS_kill
     c98:	4899                	li	a7,6
 ecall
     c9a:	00000073          	ecall
 ret
     c9e:	8082                	ret

0000000000000ca0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ca0:	489d                	li	a7,7
 ecall
     ca2:	00000073          	ecall
 ret
     ca6:	8082                	ret

0000000000000ca8 <open>:
.global open
open:
 li a7, SYS_open
     ca8:	48bd                	li	a7,15
 ecall
     caa:	00000073          	ecall
 ret
     cae:	8082                	ret

0000000000000cb0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     cb0:	48a1                	li	a7,8
 ecall
     cb2:	00000073          	ecall
 ret
     cb6:	8082                	ret

0000000000000cb8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     cb8:	48d1                	li	a7,20
 ecall
     cba:	00000073          	ecall
 ret
     cbe:	8082                	ret

0000000000000cc0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     cc0:	48a5                	li	a7,9
 ecall
     cc2:	00000073          	ecall
 ret
     cc6:	8082                	ret

0000000000000cc8 <dup>:
.global dup
dup:
 li a7, SYS_dup
     cc8:	48a9                	li	a7,10
 ecall
     cca:	00000073          	ecall
 ret
     cce:	8082                	ret

0000000000000cd0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     cd0:	48ad                	li	a7,11
 ecall
     cd2:	00000073          	ecall
 ret
     cd6:	8082                	ret

0000000000000cd8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     cd8:	48b1                	li	a7,12
 ecall
     cda:	00000073          	ecall
 ret
     cde:	8082                	ret

0000000000000ce0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     ce0:	48b5                	li	a7,13
 ecall
     ce2:	00000073          	ecall
 ret
     ce6:	8082                	ret

0000000000000ce8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ce8:	48b9                	li	a7,14
 ecall
     cea:	00000073          	ecall
 ret
     cee:	8082                	ret

0000000000000cf0 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
     cf0:	48d9                	li	a7,22
 ecall
     cf2:	00000073          	ecall
 ret
     cf6:	8082                	ret

0000000000000cf8 <dev>:
.global dev
dev:
 li a7, SYS_dev
     cf8:	48dd                	li	a7,23
 ecall
     cfa:	00000073          	ecall
 ret
     cfe:	8082                	ret

0000000000000d00 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
     d00:	48e1                	li	a7,24
 ecall
     d02:	00000073          	ecall
 ret
     d06:	8082                	ret

0000000000000d08 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     d08:	48e5                	li	a7,25
 ecall
     d0a:	00000073          	ecall
 ret
     d0e:	8082                	ret

0000000000000d10 <remove>:
.global remove
remove:
 li a7, SYS_remove
     d10:	48c5                	li	a7,17
 ecall
     d12:	00000073          	ecall
 ret
     d16:	8082                	ret

0000000000000d18 <trace>:
.global trace
trace:
 li a7, SYS_trace
     d18:	48c9                	li	a7,18
 ecall
     d1a:	00000073          	ecall
 ret
     d1e:	8082                	ret

0000000000000d20 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     d20:	48cd                	li	a7,19
 ecall
     d22:	00000073          	ecall
 ret
     d26:	8082                	ret

0000000000000d28 <rename>:
.global rename
rename:
 li a7, SYS_rename
     d28:	48e9                	li	a7,26
 ecall
     d2a:	00000073          	ecall
 ret
     d2e:	8082                	ret

0000000000000d30 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
     d30:	48ed                	li	a7,27
 ecall
     d32:	00000073          	ecall
 ret
     d36:	8082                	ret

0000000000000d38 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
     d38:	48f1                	li	a7,28
 ecall
     d3a:	00000073          	ecall
 ret
     d3e:	8082                	ret

0000000000000d40 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
     d40:	48f5                	li	a7,29
 ecall
     d42:	00000073          	ecall
 ret
     d46:	8082                	ret

0000000000000d48 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
     d48:	48f9                	li	a7,30
 ecall
     d4a:	00000073          	ecall
 ret
     d4e:	8082                	ret

0000000000000d50 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
     d50:	48fd                	li	a7,31
 ecall
     d52:	00000073          	ecall
 ret
     d56:	8082                	ret

0000000000000d58 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
     d58:	02000893          	li	a7,32
 ecall
     d5c:	00000073          	ecall
 ret
     d60:	8082                	ret

0000000000000d62 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     d62:	02100893          	li	a7,33
 ecall
     d66:	00000073          	ecall
 ret
     d6a:	8082                	ret

0000000000000d6c <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
     d6c:	02200893          	li	a7,34
 ecall
     d70:	00000073          	ecall
 ret
     d74:	8082                	ret

0000000000000d76 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
     d76:	02300893          	li	a7,35
 ecall
     d7a:	00000073          	ecall
 ret
     d7e:	8082                	ret

0000000000000d80 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
     d80:	02400893          	li	a7,36
 ecall
     d84:	00000073          	ecall
 ret
     d88:	8082                	ret

0000000000000d8a <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
     d8a:	02500893          	li	a7,37
 ecall
     d8e:	00000073          	ecall
 ret
     d92:	8082                	ret

0000000000000d94 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
     d94:	02600893          	li	a7,38
 ecall
     d98:	00000073          	ecall
 ret
     d9c:	8082                	ret

0000000000000d9e <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
     d9e:	02700893          	li	a7,39
 ecall
     da2:	00000073          	ecall
 ret
     da6:	8082                	ret

0000000000000da8 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
     da8:	02800893          	li	a7,40
 ecall
     dac:	00000073          	ecall
 ret
     db0:	8082                	ret

0000000000000db2 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
     db2:	02900893          	li	a7,41
 ecall
     db6:	00000073          	ecall
 ret
     dba:	8082                	ret

0000000000000dbc <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
     dbc:	02a00893          	li	a7,42
 ecall
     dc0:	00000073          	ecall
 ret
     dc4:	8082                	ret

0000000000000dc6 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
     dc6:	02b00893          	li	a7,43
 ecall
     dca:	00000073          	ecall
 ret
     dce:	8082                	ret

0000000000000dd0 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
     dd0:	02c00893          	li	a7,44
 ecall
     dd4:	00000073          	ecall
 ret
     dd8:	8082                	ret

0000000000000dda <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
     dda:	02d00893          	li	a7,45
 ecall
     dde:	00000073          	ecall
 ret
     de2:	8082                	ret

0000000000000de4 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
     de4:	02e00893          	li	a7,46
 ecall
     de8:	00000073          	ecall
 ret
     dec:	8082                	ret

0000000000000dee <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
     dee:	02f00893          	li	a7,47
 ecall
     df2:	00000073          	ecall
 ret
     df6:	8082                	ret

0000000000000df8 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
     df8:	03000893          	li	a7,48
 ecall
     dfc:	00000073          	ecall
 ret
     e00:	8082                	ret

0000000000000e02 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
     e02:	03100893          	li	a7,49
 ecall
     e06:	00000073          	ecall
 ret
     e0a:	8082                	ret

0000000000000e0c <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
     e0c:	03200893          	li	a7,50
 ecall
     e10:	00000073          	ecall
 ret
     e14:	8082                	ret

0000000000000e16 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
     e16:	03300893          	li	a7,51
 ecall
     e1a:	00000073          	ecall
 ret
     e1e:	8082                	ret

0000000000000e20 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
     e20:	03400893          	li	a7,52
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
     e2a:	03500893          	li	a7,53
 ecall
     e2e:	00000073          	ecall
 ret
     e32:	8082                	ret

0000000000000e34 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
     e34:	03600893          	li	a7,54
 ecall
     e38:	00000073          	ecall
 ret
     e3c:	8082                	ret

0000000000000e3e <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
     e3e:	03700893          	li	a7,55
 ecall
     e42:	00000073          	ecall
 ret
     e46:	8082                	ret

0000000000000e48 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
     e48:	03800893          	li	a7,56
 ecall
     e4c:	00000073          	ecall
 ret
     e50:	8082                	ret

0000000000000e52 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
     e52:	03900893          	li	a7,57
 ecall
     e56:	00000073          	ecall
 ret
     e5a:	8082                	ret

0000000000000e5c <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
     e5c:	03a00893          	li	a7,58
 ecall
     e60:	00000073          	ecall
 ret
     e64:	8082                	ret

0000000000000e66 <poll>:
.global poll
poll:
 li a7, SYS_poll
     e66:	03b00893          	li	a7,59
 ecall
     e6a:	00000073          	ecall
 ret
     e6e:	8082                	ret

0000000000000e70 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
     e70:	03c00893          	li	a7,60
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
     e7a:	03d00893          	li	a7,61
 ecall
     e7e:	00000073          	ecall
 ret
     e82:	8082                	ret

0000000000000e84 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
     e84:	03e00893          	li	a7,62
 ecall
     e88:	00000073          	ecall
 ret
     e8c:	8082                	ret

0000000000000e8e <clone>:
.global clone
clone:
 li a7, SYS_clone
     e8e:	03f00893          	li	a7,63
 ecall
     e92:	00000073          	ecall
 ret
     e96:	8082                	ret

0000000000000e98 <futex>:
.global futex
futex:
 li a7, SYS_futex
     e98:	04000893          	li	a7,64
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
     ea2:	04100893          	li	a7,65
 ecall
     ea6:	00000073          	ecall
 ret
     eaa:	8082                	ret

0000000000000eac <halt>:
.global halt
halt:
 li a7, SYS_halt
     eac:	04200893          	li	a7,66
 ecall
     eb0:	00000073          	ecall
 ret
     eb4:	8082                	ret

0000000000000eb6 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
     eb6:	04300893          	li	a7,67
 ecall
     eba:	00000073          	ecall
 ret
     ebe:	8082                	ret

0000000000000ec0 <socket>:
.global socket
socket:
 li a7, SYS_socket
     ec0:	04400893          	li	a7,68
 ecall
     ec4:	00000073          	ecall
 ret
     ec8:	8082                	ret

0000000000000eca <bind>:
.global bind
bind:
 li a7, SYS_bind
     eca:	04500893          	li	a7,69
 ecall
     ece:	00000073          	ecall
 ret
     ed2:	8082                	ret

0000000000000ed4 <listen>:
.global listen
listen:
 li a7, SYS_listen
     ed4:	04600893          	li	a7,70
 ecall
     ed8:	00000073          	ecall
 ret
     edc:	8082                	ret

0000000000000ede <accept>:
.global accept
accept:
 li a7, SYS_accept
     ede:	04700893          	li	a7,71
 ecall
     ee2:	00000073          	ecall
 ret
     ee6:	8082                	ret

0000000000000ee8 <connect>:
.global connect
connect:
 li a7, SYS_connect
     ee8:	04800893          	li	a7,72
 ecall
     eec:	00000073          	ecall
 ret
     ef0:	8082                	ret

0000000000000ef2 <send>:
.global send
send:
 li a7, SYS_send
     ef2:	04900893          	li	a7,73
 ecall
     ef6:	00000073          	ecall
 ret
     efa:	8082                	ret

0000000000000efc <recv>:
.global recv
recv:
 li a7, SYS_recv
     efc:	04a00893          	li	a7,74
 ecall
     f00:	00000073          	ecall
 ret
     f04:	8082                	ret

0000000000000f06 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
     f06:	04b00893          	li	a7,75
 ecall
     f0a:	00000073          	ecall
 ret
     f0e:	8082                	ret

0000000000000f10 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f10:	1101                	addi	sp,sp,-32
     f12:	ec06                	sd	ra,24(sp)
     f14:	e822                	sd	s0,16(sp)
     f16:	1000                	addi	s0,sp,32
     f18:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f1c:	4605                	li	a2,1
     f1e:	fef40593          	addi	a1,s0,-17
     f22:	00000097          	auipc	ra,0x0
     f26:	d66080e7          	jalr	-666(ra) # c88 <write>
}
     f2a:	60e2                	ld	ra,24(sp)
     f2c:	6442                	ld	s0,16(sp)
     f2e:	6105                	addi	sp,sp,32
     f30:	8082                	ret

0000000000000f32 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f32:	7139                	addi	sp,sp,-64
     f34:	fc06                	sd	ra,56(sp)
     f36:	f822                	sd	s0,48(sp)
     f38:	f426                	sd	s1,40(sp)
     f3a:	f04a                	sd	s2,32(sp)
     f3c:	ec4e                	sd	s3,24(sp)
     f3e:	0080                	addi	s0,sp,64
     f40:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f42:	c299                	beqz	a3,f48 <printint+0x16>
     f44:	0805c863          	bltz	a1,fd4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f48:	2581                	sext.w	a1,a1
  neg = 0;
     f4a:	4881                	li	a7,0
  }

  i = 0;
     f4c:	fc040993          	addi	s3,s0,-64
  neg = 0;
     f50:	86ce                	mv	a3,s3
  i = 0;
     f52:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f54:	2601                	sext.w	a2,a2
     f56:	00001517          	auipc	a0,0x1
     f5a:	97a50513          	addi	a0,a0,-1670 # 18d0 <digits>
     f5e:	883a                	mv	a6,a4
     f60:	2705                	addiw	a4,a4,1
     f62:	02c5f7bb          	remuw	a5,a1,a2
     f66:	1782                	slli	a5,a5,0x20
     f68:	9381                	srli	a5,a5,0x20
     f6a:	97aa                	add	a5,a5,a0
     f6c:	0007c783          	lbu	a5,0(a5)
     f70:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     f74:	0005879b          	sext.w	a5,a1
     f78:	02c5d5bb          	divuw	a1,a1,a2
     f7c:	0685                	addi	a3,a3,1
     f7e:	fec7f0e3          	bgeu	a5,a2,f5e <printint+0x2c>
  if(neg)
     f82:	00088c63          	beqz	a7,f9a <printint+0x68>
    buf[i++] = '-';
     f86:	fd070793          	addi	a5,a4,-48
     f8a:	00878733          	add	a4,a5,s0
     f8e:	02d00793          	li	a5,45
     f92:	fef70823          	sb	a5,-16(a4)
     f96:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     f9a:	02e05663          	blez	a4,fc6 <printint+0x94>
     f9e:	fc040913          	addi	s2,s0,-64
     fa2:	993a                	add	s2,s2,a4
     fa4:	19fd                	addi	s3,s3,-1
     fa6:	99ba                	add	s3,s3,a4
     fa8:	377d                	addiw	a4,a4,-1
     faa:	1702                	slli	a4,a4,0x20
     fac:	9301                	srli	a4,a4,0x20
     fae:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     fb2:	fff94583          	lbu	a1,-1(s2)
     fb6:	8526                	mv	a0,s1
     fb8:	00000097          	auipc	ra,0x0
     fbc:	f58080e7          	jalr	-168(ra) # f10 <putc>
  while(--i >= 0)
     fc0:	197d                	addi	s2,s2,-1
     fc2:	ff3918e3          	bne	s2,s3,fb2 <printint+0x80>
}
     fc6:	70e2                	ld	ra,56(sp)
     fc8:	7442                	ld	s0,48(sp)
     fca:	74a2                	ld	s1,40(sp)
     fcc:	7902                	ld	s2,32(sp)
     fce:	69e2                	ld	s3,24(sp)
     fd0:	6121                	addi	sp,sp,64
     fd2:	8082                	ret
    x = -xx;
     fd4:	40b005bb          	negw	a1,a1
    neg = 1;
     fd8:	4885                	li	a7,1
    x = -xx;
     fda:	bf8d                	j	f4c <printint+0x1a>

0000000000000fdc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     fdc:	7119                	addi	sp,sp,-128
     fde:	fc86                	sd	ra,120(sp)
     fe0:	f8a2                	sd	s0,112(sp)
     fe2:	f4a6                	sd	s1,104(sp)
     fe4:	f0ca                	sd	s2,96(sp)
     fe6:	ecce                	sd	s3,88(sp)
     fe8:	e8d2                	sd	s4,80(sp)
     fea:	e4d6                	sd	s5,72(sp)
     fec:	e0da                	sd	s6,64(sp)
     fee:	fc5e                	sd	s7,56(sp)
     ff0:	f862                	sd	s8,48(sp)
     ff2:	f466                	sd	s9,40(sp)
     ff4:	f06a                	sd	s10,32(sp)
     ff6:	ec6e                	sd	s11,24(sp)
     ff8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     ffa:	0005c903          	lbu	s2,0(a1)
     ffe:	18090f63          	beqz	s2,119c <vprintf+0x1c0>
    1002:	8aaa                	mv	s5,a0
    1004:	8b32                	mv	s6,a2
    1006:	00158493          	addi	s1,a1,1
  state = 0;
    100a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    100c:	02500a13          	li	s4,37
    1010:	4c55                	li	s8,21
    1012:	00001c97          	auipc	s9,0x1
    1016:	866c8c93          	addi	s9,s9,-1946 # 1878 <worker_tickets+0x20>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    101a:	02800d93          	li	s11,40
  putc(fd, 'x');
    101e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1020:	00001b97          	auipc	s7,0x1
    1024:	8b0b8b93          	addi	s7,s7,-1872 # 18d0 <digits>
    1028:	a839                	j	1046 <vprintf+0x6a>
        putc(fd, c);
    102a:	85ca                	mv	a1,s2
    102c:	8556                	mv	a0,s5
    102e:	00000097          	auipc	ra,0x0
    1032:	ee2080e7          	jalr	-286(ra) # f10 <putc>
    1036:	a019                	j	103c <vprintf+0x60>
    } else if(state == '%'){
    1038:	01498d63          	beq	s3,s4,1052 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    103c:	0485                	addi	s1,s1,1
    103e:	fff4c903          	lbu	s2,-1(s1)
    1042:	14090d63          	beqz	s2,119c <vprintf+0x1c0>
    if(state == 0){
    1046:	fe0999e3          	bnez	s3,1038 <vprintf+0x5c>
      if(c == '%'){
    104a:	ff4910e3          	bne	s2,s4,102a <vprintf+0x4e>
        state = '%';
    104e:	89d2                	mv	s3,s4
    1050:	b7f5                	j	103c <vprintf+0x60>
      if(c == 'd'){
    1052:	11490c63          	beq	s2,s4,116a <vprintf+0x18e>
    1056:	f9d9079b          	addiw	a5,s2,-99
    105a:	0ff7f793          	zext.b	a5,a5
    105e:	10fc6e63          	bltu	s8,a5,117a <vprintf+0x19e>
    1062:	f9d9079b          	addiw	a5,s2,-99
    1066:	0ff7f713          	zext.b	a4,a5
    106a:	10ec6863          	bltu	s8,a4,117a <vprintf+0x19e>
    106e:	00271793          	slli	a5,a4,0x2
    1072:	97e6                	add	a5,a5,s9
    1074:	439c                	lw	a5,0(a5)
    1076:	97e6                	add	a5,a5,s9
    1078:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    107a:	008b0913          	addi	s2,s6,8
    107e:	4685                	li	a3,1
    1080:	4629                	li	a2,10
    1082:	000b2583          	lw	a1,0(s6)
    1086:	8556                	mv	a0,s5
    1088:	00000097          	auipc	ra,0x0
    108c:	eaa080e7          	jalr	-342(ra) # f32 <printint>
    1090:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1092:	4981                	li	s3,0
    1094:	b765                	j	103c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1096:	008b0913          	addi	s2,s6,8
    109a:	4681                	li	a3,0
    109c:	4629                	li	a2,10
    109e:	000b2583          	lw	a1,0(s6)
    10a2:	8556                	mv	a0,s5
    10a4:	00000097          	auipc	ra,0x0
    10a8:	e8e080e7          	jalr	-370(ra) # f32 <printint>
    10ac:	8b4a                	mv	s6,s2
      state = 0;
    10ae:	4981                	li	s3,0
    10b0:	b771                	j	103c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    10b2:	008b0913          	addi	s2,s6,8
    10b6:	4681                	li	a3,0
    10b8:	866a                	mv	a2,s10
    10ba:	000b2583          	lw	a1,0(s6)
    10be:	8556                	mv	a0,s5
    10c0:	00000097          	auipc	ra,0x0
    10c4:	e72080e7          	jalr	-398(ra) # f32 <printint>
    10c8:	8b4a                	mv	s6,s2
      state = 0;
    10ca:	4981                	li	s3,0
    10cc:	bf85                	j	103c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    10ce:	008b0793          	addi	a5,s6,8
    10d2:	f8f43423          	sd	a5,-120(s0)
    10d6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    10da:	03000593          	li	a1,48
    10de:	8556                	mv	a0,s5
    10e0:	00000097          	auipc	ra,0x0
    10e4:	e30080e7          	jalr	-464(ra) # f10 <putc>
  putc(fd, 'x');
    10e8:	07800593          	li	a1,120
    10ec:	8556                	mv	a0,s5
    10ee:	00000097          	auipc	ra,0x0
    10f2:	e22080e7          	jalr	-478(ra) # f10 <putc>
    10f6:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10f8:	03c9d793          	srli	a5,s3,0x3c
    10fc:	97de                	add	a5,a5,s7
    10fe:	0007c583          	lbu	a1,0(a5)
    1102:	8556                	mv	a0,s5
    1104:	00000097          	auipc	ra,0x0
    1108:	e0c080e7          	jalr	-500(ra) # f10 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    110c:	0992                	slli	s3,s3,0x4
    110e:	397d                	addiw	s2,s2,-1
    1110:	fe0914e3          	bnez	s2,10f8 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    1114:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    1118:	4981                	li	s3,0
    111a:	b70d                	j	103c <vprintf+0x60>
        s = va_arg(ap, char*);
    111c:	008b0913          	addi	s2,s6,8
    1120:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    1124:	02098163          	beqz	s3,1146 <vprintf+0x16a>
        while(*s != 0){
    1128:	0009c583          	lbu	a1,0(s3)
    112c:	c5ad                	beqz	a1,1196 <vprintf+0x1ba>
          putc(fd, *s);
    112e:	8556                	mv	a0,s5
    1130:	00000097          	auipc	ra,0x0
    1134:	de0080e7          	jalr	-544(ra) # f10 <putc>
          s++;
    1138:	0985                	addi	s3,s3,1
        while(*s != 0){
    113a:	0009c583          	lbu	a1,0(s3)
    113e:	f9e5                	bnez	a1,112e <vprintf+0x152>
        s = va_arg(ap, char*);
    1140:	8b4a                	mv	s6,s2
      state = 0;
    1142:	4981                	li	s3,0
    1144:	bde5                	j	103c <vprintf+0x60>
          s = "(null)";
    1146:	00000997          	auipc	s3,0x0
    114a:	72a98993          	addi	s3,s3,1834 # 1870 <worker_tickets+0x18>
        while(*s != 0){
    114e:	85ee                	mv	a1,s11
    1150:	bff9                	j	112e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    1152:	008b0913          	addi	s2,s6,8
    1156:	000b4583          	lbu	a1,0(s6)
    115a:	8556                	mv	a0,s5
    115c:	00000097          	auipc	ra,0x0
    1160:	db4080e7          	jalr	-588(ra) # f10 <putc>
    1164:	8b4a                	mv	s6,s2
      state = 0;
    1166:	4981                	li	s3,0
    1168:	bdd1                	j	103c <vprintf+0x60>
        putc(fd, c);
    116a:	85d2                	mv	a1,s4
    116c:	8556                	mv	a0,s5
    116e:	00000097          	auipc	ra,0x0
    1172:	da2080e7          	jalr	-606(ra) # f10 <putc>
      state = 0;
    1176:	4981                	li	s3,0
    1178:	b5d1                	j	103c <vprintf+0x60>
        putc(fd, '%');
    117a:	85d2                	mv	a1,s4
    117c:	8556                	mv	a0,s5
    117e:	00000097          	auipc	ra,0x0
    1182:	d92080e7          	jalr	-622(ra) # f10 <putc>
        putc(fd, c);
    1186:	85ca                	mv	a1,s2
    1188:	8556                	mv	a0,s5
    118a:	00000097          	auipc	ra,0x0
    118e:	d86080e7          	jalr	-634(ra) # f10 <putc>
      state = 0;
    1192:	4981                	li	s3,0
    1194:	b565                	j	103c <vprintf+0x60>
        s = va_arg(ap, char*);
    1196:	8b4a                	mv	s6,s2
      state = 0;
    1198:	4981                	li	s3,0
    119a:	b54d                	j	103c <vprintf+0x60>
    }
  }
}
    119c:	70e6                	ld	ra,120(sp)
    119e:	7446                	ld	s0,112(sp)
    11a0:	74a6                	ld	s1,104(sp)
    11a2:	7906                	ld	s2,96(sp)
    11a4:	69e6                	ld	s3,88(sp)
    11a6:	6a46                	ld	s4,80(sp)
    11a8:	6aa6                	ld	s5,72(sp)
    11aa:	6b06                	ld	s6,64(sp)
    11ac:	7be2                	ld	s7,56(sp)
    11ae:	7c42                	ld	s8,48(sp)
    11b0:	7ca2                	ld	s9,40(sp)
    11b2:	7d02                	ld	s10,32(sp)
    11b4:	6de2                	ld	s11,24(sp)
    11b6:	6109                	addi	sp,sp,128
    11b8:	8082                	ret

00000000000011ba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11ba:	715d                	addi	sp,sp,-80
    11bc:	ec06                	sd	ra,24(sp)
    11be:	e822                	sd	s0,16(sp)
    11c0:	1000                	addi	s0,sp,32
    11c2:	e010                	sd	a2,0(s0)
    11c4:	e414                	sd	a3,8(s0)
    11c6:	e818                	sd	a4,16(s0)
    11c8:	ec1c                	sd	a5,24(s0)
    11ca:	03043023          	sd	a6,32(s0)
    11ce:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    11d2:	8622                	mv	a2,s0
    11d4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    11d8:	00000097          	auipc	ra,0x0
    11dc:	e04080e7          	jalr	-508(ra) # fdc <vprintf>
}
    11e0:	60e2                	ld	ra,24(sp)
    11e2:	6442                	ld	s0,16(sp)
    11e4:	6161                	addi	sp,sp,80
    11e6:	8082                	ret

00000000000011e8 <printf>:

void
printf(const char *fmt, ...)
{
    11e8:	711d                	addi	sp,sp,-96
    11ea:	ec06                	sd	ra,24(sp)
    11ec:	e822                	sd	s0,16(sp)
    11ee:	1000                	addi	s0,sp,32
    11f0:	e40c                	sd	a1,8(s0)
    11f2:	e810                	sd	a2,16(s0)
    11f4:	ec14                	sd	a3,24(s0)
    11f6:	f018                	sd	a4,32(s0)
    11f8:	f41c                	sd	a5,40(s0)
    11fa:	03043823          	sd	a6,48(s0)
    11fe:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1202:	00840613          	addi	a2,s0,8
    1206:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    120a:	85aa                	mv	a1,a0
    120c:	4505                	li	a0,1
    120e:	00000097          	auipc	ra,0x0
    1212:	dce080e7          	jalr	-562(ra) # fdc <vprintf>
}
    1216:	60e2                	ld	ra,24(sp)
    1218:	6442                	ld	s0,16(sp)
    121a:	6125                	addi	sp,sp,96
    121c:	8082                	ret

000000000000121e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    121e:	1141                	addi	sp,sp,-16
    1220:	e422                	sd	s0,8(sp)
    1222:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1224:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1228:	00000797          	auipc	a5,0x0
    122c:	6e07b783          	ld	a5,1760(a5) # 1908 <freep>
    1230:	a02d                	j	125a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1232:	4618                	lw	a4,8(a2)
    1234:	9f2d                	addw	a4,a4,a1
    1236:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    123a:	6398                	ld	a4,0(a5)
    123c:	6310                	ld	a2,0(a4)
    123e:	a83d                	j	127c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1240:	ff852703          	lw	a4,-8(a0)
    1244:	9f31                	addw	a4,a4,a2
    1246:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1248:	ff053683          	ld	a3,-16(a0)
    124c:	a091                	j	1290 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    124e:	6398                	ld	a4,0(a5)
    1250:	00e7e463          	bltu	a5,a4,1258 <free+0x3a>
    1254:	00e6ea63          	bltu	a3,a4,1268 <free+0x4a>
{
    1258:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    125a:	fed7fae3          	bgeu	a5,a3,124e <free+0x30>
    125e:	6398                	ld	a4,0(a5)
    1260:	00e6e463          	bltu	a3,a4,1268 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1264:	fee7eae3          	bltu	a5,a4,1258 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1268:	ff852583          	lw	a1,-8(a0)
    126c:	6390                	ld	a2,0(a5)
    126e:	02059813          	slli	a6,a1,0x20
    1272:	01c85713          	srli	a4,a6,0x1c
    1276:	9736                	add	a4,a4,a3
    1278:	fae60de3          	beq	a2,a4,1232 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    127c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1280:	4790                	lw	a2,8(a5)
    1282:	02061593          	slli	a1,a2,0x20
    1286:	01c5d713          	srli	a4,a1,0x1c
    128a:	973e                	add	a4,a4,a5
    128c:	fae68ae3          	beq	a3,a4,1240 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1290:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1292:	00000717          	auipc	a4,0x0
    1296:	66f73b23          	sd	a5,1654(a4) # 1908 <freep>
}
    129a:	6422                	ld	s0,8(sp)
    129c:	0141                	addi	sp,sp,16
    129e:	8082                	ret

00000000000012a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12a0:	7139                	addi	sp,sp,-64
    12a2:	fc06                	sd	ra,56(sp)
    12a4:	f822                	sd	s0,48(sp)
    12a6:	f426                	sd	s1,40(sp)
    12a8:	f04a                	sd	s2,32(sp)
    12aa:	ec4e                	sd	s3,24(sp)
    12ac:	e852                	sd	s4,16(sp)
    12ae:	e456                	sd	s5,8(sp)
    12b0:	e05a                	sd	s6,0(sp)
    12b2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12b4:	02051493          	slli	s1,a0,0x20
    12b8:	9081                	srli	s1,s1,0x20
    12ba:	04bd                	addi	s1,s1,15
    12bc:	8091                	srli	s1,s1,0x4
    12be:	00148a1b          	addiw	s4,s1,1
    12c2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    12c4:	00000517          	auipc	a0,0x0
    12c8:	64453503          	ld	a0,1604(a0) # 1908 <freep>
    12cc:	c515                	beqz	a0,12f8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12ce:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12d0:	4798                	lw	a4,8(a5)
    12d2:	04977163          	bgeu	a4,s1,1314 <malloc+0x74>
    12d6:	89d2                	mv	s3,s4
    12d8:	000a071b          	sext.w	a4,s4
    12dc:	6685                	lui	a3,0x1
    12de:	00d77363          	bgeu	a4,a3,12e4 <malloc+0x44>
    12e2:	6985                	lui	s3,0x1
    12e4:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    12e8:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12ec:	00000917          	auipc	s2,0x0
    12f0:	61c90913          	addi	s2,s2,1564 # 1908 <freep>
  if(p == (char*)-1)
    12f4:	5afd                	li	s5,-1
    12f6:	a8a5                	j	136e <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    12f8:	00000797          	auipc	a5,0x0
    12fc:	61078793          	addi	a5,a5,1552 # 1908 <freep>
    1300:	00000717          	auipc	a4,0x0
    1304:	61070713          	addi	a4,a4,1552 # 1910 <base>
    1308:	e398                	sd	a4,0(a5)
    130a:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    130c:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1310:	87ba                	mv	a5,a4
    1312:	b7d1                	j	12d6 <malloc+0x36>
      if(p->s.size == nunits)
    1314:	02e48c63          	beq	s1,a4,134c <malloc+0xac>
        p->s.size -= nunits;
    1318:	4147073b          	subw	a4,a4,s4
    131c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    131e:	02071693          	slli	a3,a4,0x20
    1322:	01c6d713          	srli	a4,a3,0x1c
    1326:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1328:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    132c:	00000717          	auipc	a4,0x0
    1330:	5ca73e23          	sd	a0,1500(a4) # 1908 <freep>
      return (void*)(p + 1);
    1334:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1338:	70e2                	ld	ra,56(sp)
    133a:	7442                	ld	s0,48(sp)
    133c:	74a2                	ld	s1,40(sp)
    133e:	7902                	ld	s2,32(sp)
    1340:	69e2                	ld	s3,24(sp)
    1342:	6a42                	ld	s4,16(sp)
    1344:	6aa2                	ld	s5,8(sp)
    1346:	6b02                	ld	s6,0(sp)
    1348:	6121                	addi	sp,sp,64
    134a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    134c:	6398                	ld	a4,0(a5)
    134e:	e118                	sd	a4,0(a0)
    1350:	bff1                	j	132c <malloc+0x8c>
  hp->s.size = nu;
    1352:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1356:	0541                	addi	a0,a0,16
    1358:	00000097          	auipc	ra,0x0
    135c:	ec6080e7          	jalr	-314(ra) # 121e <free>
  return freep;
    1360:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1364:	d971                	beqz	a0,1338 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1366:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1368:	4798                	lw	a4,8(a5)
    136a:	fa9775e3          	bgeu	a4,s1,1314 <malloc+0x74>
    if(p == freep)
    136e:	00093703          	ld	a4,0(s2)
    1372:	853e                	mv	a0,a5
    1374:	fef719e3          	bne	a4,a5,1366 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    1378:	854e                	mv	a0,s3
    137a:	00000097          	auipc	ra,0x0
    137e:	95e080e7          	jalr	-1698(ra) # cd8 <sbrk>
  if(p == (char*)-1)
    1382:	fd5518e3          	bne	a0,s5,1352 <malloc+0xb2>
        return 0;
    1386:	4501                	li	a0,0
    1388:	bf45                	j	1338 <malloc+0x98>
