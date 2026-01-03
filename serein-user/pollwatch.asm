
serein-user/_pollwatch：     文件格式 elf64-littleriscv


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
       c:	b1b78793          	addi	a5,a5,-1253 # 36335b1b <__global_pointer$+0x363339d3>
      10:	fef42423          	sw	a5,-24(s0)
      14:	06d00793          	li	a5,109
      18:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      1c:	4615                	li	a2,5
      1e:	fe840593          	addi	a1,s0,-24
      22:	4509                	li	a0,2
      24:	00001097          	auipc	ra,0x1
      28:	c9e080e7          	jalr	-866(ra) # cc2 <write>
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
      40:	b1b78793          	addi	a5,a5,-1253 # 33335b1b <__global_pointer$+0x333339d3>
      44:	fef42423          	sw	a5,-24(s0)
      48:	06d00793          	li	a5,109
      4c:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      50:	4615                	li	a2,5
      52:	fe840593          	addi	a1,s0,-24
      56:	4509                	li	a0,2
      58:	00001097          	auipc	ra,0x1
      5c:	c6a080e7          	jalr	-918(ra) # cc2 <write>
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
      74:	b1b78793          	addi	a5,a5,-1253 # 32335b1b <__global_pointer$+0x323339d3>
      78:	fef42423          	sw	a5,-24(s0)
      7c:	06d00793          	li	a5,109
      80:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      84:	4615                	li	a2,5
      86:	fe840593          	addi	a1,s0,-24
      8a:	4509                	li	a0,2
      8c:	00001097          	auipc	ra,0x1
      90:	c36080e7          	jalr	-970(ra) # cc2 <write>
}
      94:	60e2                	ld	ra,24(sp)
      96:	6442                	ld	s0,16(sp)
      98:	6105                	addi	sp,sp,32
      9a:	8082                	ret

000000000000009c <color_reset>:
static void color_red(void) {
  char seq[] = {0x1b, '[', '3', '1', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_reset(void) {
      9c:	1101                	addi	sp,sp,-32
      9e:	ec06                	sd	ra,24(sp)
      a0:	e822                	sd	s0,16(sp)
      a2:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '0', 'm'};
      a4:	6d3067b7          	lui	a5,0x6d306
      a8:	b1b78793          	addi	a5,a5,-1253 # 6d305b1b <__global_pointer$+0x6d3039d3>
      ac:	fef42423          	sw	a5,-24(s0)
  write(2, seq, sizeof(seq));
      b0:	4611                	li	a2,4
      b2:	fe840593          	addi	a1,s0,-24
      b6:	4509                	li	a0,2
      b8:	00001097          	auipc	ra,0x1
      bc:	c0a080e7          	jalr	-1014(ra) # cc2 <write>
}
      c0:	60e2                	ld	ra,24(sp)
      c2:	6442                	ld	s0,16(sp)
      c4:	6105                	addi	sp,sp,32
      c6:	8082                	ret

00000000000000c8 <main>:
  
  fprintf(2, "  +----------------------------------------------------------+\n");
  fprintf(2, "  Active pipes: %d / %d\n", active_count, NUM_PIPES);
}

int main(int argc, char *argv[]) {
      c8:	716d                	addi	sp,sp,-272
      ca:	e606                	sd	ra,264(sp)
      cc:	e222                	sd	s0,256(sp)
      ce:	fda6                	sd	s1,248(sp)
      d0:	f9ca                	sd	s2,240(sp)
      d2:	f5ce                	sd	s3,232(sp)
      d4:	f1d2                	sd	s4,224(sp)
      d6:	edd6                	sd	s5,216(sp)
      d8:	e9da                	sd	s6,208(sp)
      da:	e5de                	sd	s7,200(sp)
      dc:	e1e2                	sd	s8,192(sp)
      de:	fd66                	sd	s9,184(sp)
      e0:	f96a                	sd	s10,176(sp)
      e2:	f56e                	sd	s11,168(sp)
      e4:	0a00                	addi	s0,sp,272
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
      e6:	4a3267b7          	lui	a5,0x4a326
      ea:	b1b78793          	addi	a5,a5,-1253 # 4a325b1b <__global_pointer$+0x4a3239d3>
      ee:	f2f42823          	sw	a5,-208(s0)
      f2:	6799                	lui	a5,0x6
      f4:	b1b78793          	addi	a5,a5,-1253 # 5b1b <__global_pointer$+0x39d3>
      f8:	f2f41a23          	sh	a5,-204(s0)
      fc:	04800793          	li	a5,72
     100:	f2f40b23          	sb	a5,-202(s0)
  write(2, seq, sizeof(seq));
     104:	461d                	li	a2,7
     106:	f3040593          	addi	a1,s0,-208
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	bb6080e7          	jalr	-1098(ra) # cc2 <write>
  cls();
  
  color_cyan();
     114:	00000097          	auipc	ra,0x0
     118:	eec080e7          	jalr	-276(ra) # 0 <color_cyan>
  fprintf(2, "+================================================================+\n");
     11c:	00001597          	auipc	a1,0x1
     120:	2b458593          	addi	a1,a1,692 # 13d0 <malloc+0xf6>
     124:	4509                	li	a0,2
     126:	00001097          	auipc	ra,0x1
     12a:	0ce080e7          	jalr	206(ra) # 11f4 <fprintf>
  fprintf(2, "|          I/O Multiplexing Demo - poll() Visualization         |\n");
     12e:	00001597          	auipc	a1,0x1
     132:	2ea58593          	addi	a1,a1,746 # 1418 <malloc+0x13e>
     136:	4509                	li	a0,2
     138:	00001097          	auipc	ra,0x1
     13c:	0bc080e7          	jalr	188(ra) # 11f4 <fprintf>
  fprintf(2, "|                       Serein OS V3.0                           |\n");
     140:	00001597          	auipc	a1,0x1
     144:	32058593          	addi	a1,a1,800 # 1460 <malloc+0x186>
     148:	4509                	li	a0,2
     14a:	00001097          	auipc	ra,0x1
     14e:	0aa080e7          	jalr	170(ra) # 11f4 <fprintf>
  fprintf(2, "+================================================================+\n");
     152:	00001597          	auipc	a1,0x1
     156:	27e58593          	addi	a1,a1,638 # 13d0 <malloc+0xf6>
     15a:	4509                	li	a0,2
     15c:	00001097          	auipc	ra,0x1
     160:	098080e7          	jalr	152(ra) # 11f4 <fprintf>
  color_reset();
     164:	00000097          	auipc	ra,0x0
     168:	f38080e7          	jalr	-200(ra) # 9c <color_reset>
  
  fprintf(2, "\n");
     16c:	00001597          	auipc	a1,0x1
     170:	63c58593          	addi	a1,a1,1596 # 17a8 <malloc+0x4ce>
     174:	4509                	li	a0,2
     176:	00001097          	auipc	ra,0x1
     17a:	07e080e7          	jalr	126(ra) # 11f4 <fprintf>
  fprintf(2, "  This demo shows poll() monitoring multiple pipes:\n\n");
     17e:	00001597          	auipc	a1,0x1
     182:	32a58593          	addi	a1,a1,810 # 14a8 <malloc+0x1ce>
     186:	4509                	li	a0,2
     188:	00001097          	auipc	ra,0x1
     18c:	06c080e7          	jalr	108(ra) # 11f4 <fprintf>
  
  for(int i = 0; i < NUM_PIPES; i++) {
     190:	00001917          	auipc	s2,0x1
     194:	71090913          	addi	s2,s2,1808 # 18a0 <pipe_intervals>
     198:	00001a17          	auipc	s4,0x1
     19c:	7b0a0a13          	addi	s4,s4,1968 # 1948 <pipes>
  fprintf(2, "  This demo shows poll() monitoring multiple pipes:\n\n");
     1a0:	00001497          	auipc	s1,0x1
     1a4:	78848493          	addi	s1,s1,1928 # 1928 <pipe_names>
    color_yellow();
    fprintf(2, "    Pipe %s: writes every %d ticks\n", 
     1a8:	00001997          	auipc	s3,0x1
     1ac:	33898993          	addi	s3,s3,824 # 14e0 <malloc+0x206>
    color_yellow();
     1b0:	00000097          	auipc	ra,0x0
     1b4:	e84080e7          	jalr	-380(ra) # 34 <color_yellow>
    fprintf(2, "    Pipe %s: writes every %d ticks\n", 
     1b8:	00092683          	lw	a3,0(s2)
     1bc:	6090                	ld	a2,0(s1)
     1be:	85ce                	mv	a1,s3
     1c0:	4509                	li	a0,2
     1c2:	00001097          	auipc	ra,0x1
     1c6:	032080e7          	jalr	50(ra) # 11f4 <fprintf>
            pipe_names[i], pipe_intervals[i]);
    color_reset();
     1ca:	00000097          	auipc	ra,0x0
     1ce:	ed2080e7          	jalr	-302(ra) # 9c <color_reset>
  for(int i = 0; i < NUM_PIPES; i++) {
     1d2:	04a1                	addi	s1,s1,8
     1d4:	0911                	addi	s2,s2,4
     1d6:	fd449de3          	bne	s1,s4,1b0 <main+0xe8>
  }
  
  fprintf(2, "\n");
     1da:	00001597          	auipc	a1,0x1
     1de:	5ce58593          	addi	a1,a1,1486 # 17a8 <malloc+0x4ce>
     1e2:	4509                	li	a0,2
     1e4:	00001097          	auipc	ra,0x1
     1e8:	010080e7          	jalr	16(ra) # 11f4 <fprintf>
  fprintf(2, "  Starting in 2 seconds... (Press Ctrl+C to exit)\n\n");
     1ec:	00001597          	auipc	a1,0x1
     1f0:	31c58593          	addi	a1,a1,796 # 1508 <malloc+0x22e>
     1f4:	4509                	li	a0,2
     1f6:	00001097          	auipc	ra,0x1
     1fa:	ffe080e7          	jalr	-2(ra) # 11f4 <fprintf>
  sleep(200);
     1fe:	0c800513          	li	a0,200
     202:	00001097          	auipc	ra,0x1
     206:	b18080e7          	jalr	-1256(ra) # d1a <sleep>
  for(int i = 0; i < NUM_PIPES; i++) {
     20a:	00001a17          	auipc	s4,0x1
     20e:	73ea0a13          	addi	s4,s4,1854 # 1948 <pipes>
  sleep(200);
     212:	8952                	mv	s2,s4
  for(int i = 0; i < NUM_PIPES; i++) {
     214:	4d81                	li	s11,0
     216:	4a91                	li	s5,4
    if(pipe(pipes[i]) < 0) {
     218:	854a                	mv	a0,s2
     21a:	00001097          	auipc	ra,0x1
     21e:	a98080e7          	jalr	-1384(ra) # cb2 <pipe>
     222:	08054b63          	bltz	a0,2b8 <main+0x1f0>
    int pid = fork();
     226:	00001097          	auipc	ra,0x1
     22a:	a74080e7          	jalr	-1420(ra) # c9a <fork>
     22e:	84aa                	mv	s1,a0
    if(pid < 0) {
     230:	0a054263          	bltz	a0,2d4 <main+0x20c>
    if(pid == 0) {
     234:	cd55                	beqz	a0,2f0 <main+0x228>
    close(pipes[i][1]);
     236:	00492503          	lw	a0,4(s2)
     23a:	00001097          	auipc	ra,0x1
     23e:	a90080e7          	jalr	-1392(ra) # cca <close>
  for(int i = 0; i < NUM_PIPES; i++) {
     242:	2d85                	addiw	s11,s11,1
     244:	0921                	addi	s2,s2,8
     246:	fd5d99e3          	bne	s11,s5,218 <main+0x150>
     24a:	f7040793          	addi	a5,s0,-144
     24e:	f0f43423          	sd	a5,-248(s0)
     252:	f9040c13          	addi	s8,s0,-112
  
  // 设置 pollfd 数组
  struct pollfd fds[NUM_PIPES];
  for(int i = 0; i < NUM_PIPES; i++) {
    fds[i].fd = pipes[i][0];  // 监控读端
    fds[i].events = POLLIN;   // 关注可读事件
     256:	4685                	li	a3,1
    fds[i].fd = pipes[i][0];  // 监控读端
     258:	000a2703          	lw	a4,0(s4)
     25c:	c398                	sw	a4,0(a5)
    fds[i].events = POLLIN;   // 关注可读事件
     25e:	00d79223          	sh	a3,4(a5)
    fds[i].revents = 0;
     262:	00079323          	sh	zero,6(a5)
  for(int i = 0; i < NUM_PIPES; i++) {
     266:	0a21                	addi	s4,s4,8
     268:	07a1                	addi	a5,a5,8
     26a:	ff8797e3          	bne	a5,s8,258 <main+0x190>
  
  int active_pipes = NUM_PIPES;
  int total_messages = 0;
  int round = 0;
  
  fprintf(2, "  Monitoring %d pipes with poll()...\n\n", NUM_PIPES);
     26e:	4611                	li	a2,4
     270:	00001597          	auipc	a1,0x1
     274:	30058593          	addi	a1,a1,768 # 1570 <malloc+0x296>
     278:	4509                	li	a0,2
     27a:	00001097          	auipc	ra,0x1
     27e:	f7a080e7          	jalr	-134(ra) # 11f4 <fprintf>
  int round = 0;
     282:	f2043023          	sd	zero,-224(s0)
  int total_messages = 0;
     286:	f0043823          	sd	zero,-240(s0)
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
     28a:	4a3267b7          	lui	a5,0x4a326
     28e:	b1b78793          	addi	a5,a5,-1253 # 4a325b1b <__global_pointer$+0x4a3239d3>
     292:	f0f43023          	sd	a5,-256(s0)
  write(2, seq, sizeof(seq));
     296:	f3040793          	addi	a5,s0,-208
     29a:	f2f43423          	sd	a5,-216(s0)
  char seq[] = {0x1b, '[', '3', '1', 'm'};
     29e:	313367b7          	lui	a5,0x31336
     2a2:	b1b78793          	addi	a5,a5,-1253 # 31335b1b <__global_pointer$+0x313339d3>
     2a6:	f0f43c23          	sd	a5,-232(s0)
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     2aa:	353367b7          	lui	a5,0x35336
     2ae:	b1b78793          	addi	a5,a5,-1253 # 35335b1b <__global_pointer$+0x353339d3>
     2b2:	eef43c23          	sd	a5,-264(s0)
     2b6:	ab7d                	j	874 <main+0x7ac>
      fprintf(2, "pollwatch: pipe failed\n");
     2b8:	00001597          	auipc	a1,0x1
     2bc:	28858593          	addi	a1,a1,648 # 1540 <malloc+0x266>
     2c0:	4509                	li	a0,2
     2c2:	00001097          	auipc	ra,0x1
     2c6:	f32080e7          	jalr	-206(ra) # 11f4 <fprintf>
      exit(1);
     2ca:	4505                	li	a0,1
     2cc:	00001097          	auipc	ra,0x1
     2d0:	9d6080e7          	jalr	-1578(ra) # ca2 <exit>
      fprintf(2, "pollwatch: fork failed\n");
     2d4:	00001597          	auipc	a1,0x1
     2d8:	28458593          	addi	a1,a1,644 # 1558 <malloc+0x27e>
     2dc:	4509                	li	a0,2
     2de:	00001097          	auipc	ra,0x1
     2e2:	f16080e7          	jalr	-234(ra) # 11f4 <fprintf>
      exit(1);
     2e6:	4505                	li	a0,1
     2e8:	00001097          	auipc	ra,0x1
     2ec:	9ba080e7          	jalr	-1606(ra) # ca2 <exit>
      close(pipes[i][0]);
     2f0:	003d9793          	slli	a5,s11,0x3
     2f4:	00001917          	auipc	s2,0x1
     2f8:	65490913          	addi	s2,s2,1620 # 1948 <pipes>
     2fc:	993e                	add	s2,s2,a5
     2fe:	00092503          	lw	a0,0(s2)
     302:	00001097          	auipc	ra,0x1
     306:	9c8080e7          	jalr	-1592(ra) # cca <close>
  int write_fd = pipes[pipe_idx][1];
     30a:	00492903          	lw	s2,4(s2)
  int interval = pipe_intervals[pipe_idx];
     30e:	002d9713          	slli	a4,s11,0x2
     312:	00001797          	auipc	a5,0x1
     316:	58e78793          	addi	a5,a5,1422 # 18a0 <pipe_intervals>
     31a:	97ba                	add	a5,a5,a4
     31c:	0007ab83          	lw	s7,0(a5)
    char *name = pipe_names[pipe_idx];
     320:	0d8e                	slli	s11,s11,0x3
     322:	00001997          	auipc	s3,0x1
     326:	60698993          	addi	s3,s3,1542 # 1928 <pipe_names>
     32a:	99ee                	add	s3,s3,s11
    while(*name) msg[len++] = *name++;
     32c:	f3040a93          	addi	s5,s0,-208
    msg[len++] = ':';
     330:	03a00c13          	li	s8,58
    if(count >= 10) msg[len++] = '0' + (count / 10);
     334:	4a29                	li	s4,10
    msg[len++] = '0' + (count % 10);
     336:	4b29                	li	s6,10
     338:	ad61                	j	9d0 <main+0x908>
    while(*name) msg[len++] = *name++;
     33a:	00fa8633          	add	a2,s5,a5
     33e:	00d60023          	sb	a3,0(a2)
     342:	0785                	addi	a5,a5,1
     344:	0007861b          	sext.w	a2,a5
     348:	00f586b3          	add	a3,a1,a5
     34c:	0006c683          	lbu	a3,0(a3)
     350:	f6ed                	bnez	a3,33a <main+0x272>
    msg[len++] = ':';
     352:	0016079b          	addiw	a5,a2,1
     356:	f9060693          	addi	a3,a2,-112
     35a:	96a2                	add	a3,a3,s0
     35c:	fb868023          	sb	s8,-96(a3)
    if(count >= 10) msg[len++] = '0' + (count / 10);
     360:	65449163          	bne	s1,s4,9a2 <main+0x8da>
     364:	f9078793          	addi	a5,a5,-112
     368:	97a2                	add	a5,a5,s0
     36a:	03100713          	li	a4,49
     36e:	fae78023          	sb	a4,-96(a5)
    msg[len++] = '0' + (count % 10);
     372:	0026079b          	addiw	a5,a2,2
     376:	f9078793          	addi	a5,a5,-112
     37a:	97a2                	add	a5,a5,s0
     37c:	03000713          	li	a4,48
     380:	fae78023          	sb	a4,-96(a5)
    msg[len++] = '\n';
     384:	0036079b          	addiw	a5,a2,3
     388:	f9078793          	addi	a5,a5,-112
     38c:	97a2                	add	a5,a5,s0
     38e:	4729                	li	a4,10
     390:	fae78023          	sb	a4,-96(a5)
    write(write_fd, msg, len);
     394:	2611                	addiw	a2,a2,4
     396:	f3040593          	addi	a1,s0,-208
     39a:	854a                	mv	a0,s2
     39c:	00001097          	auipc	ra,0x1
     3a0:	926080e7          	jalr	-1754(ra) # cc2 <write>
      close(write_fd);
     3a4:	854a                	mv	a0,s2
     3a6:	00001097          	auipc	ra,0x1
     3aa:	924080e7          	jalr	-1756(ra) # cca <close>
      exit(0);
     3ae:	4501                	li	a0,0
     3b0:	00001097          	auipc	ra,0x1
     3b4:	8f2080e7          	jalr	-1806(ra) # ca2 <exit>
    color_reset();
    
    fprintf(2, "\n");
    fprintf(2, "  Round %d | poll() returned: %d", round, ret);
    if(ret == 0) {
      color_yellow();
     3b8:	00000097          	auipc	ra,0x0
     3bc:	c7c080e7          	jalr	-900(ra) # 34 <color_yellow>
      fprintf(2, " (timeout)");
     3c0:	00001597          	auipc	a1,0x1
     3c4:	20058593          	addi	a1,a1,512 # 15c0 <malloc+0x2e6>
     3c8:	4509                	li	a0,2
     3ca:	00001097          	auipc	ra,0x1
     3ce:	e2a080e7          	jalr	-470(ra) # 11f4 <fprintf>
      color_reset();
     3d2:	00000097          	auipc	ra,0x0
     3d6:	cca080e7          	jalr	-822(ra) # 9c <color_reset>
     3da:	aba9                	j	934 <main+0x86c>
    } else if(ret > 0) {
      color_green();
     3dc:	00000097          	auipc	ra,0x0
     3e0:	c8c080e7          	jalr	-884(ra) # 68 <color_green>
      fprintf(2, " (%d fd%s ready)", ret, ret > 1 ? "s" : "");
     3e4:	4785                	li	a5,1
     3e6:	00001697          	auipc	a3,0x1
     3ea:	fe268693          	addi	a3,a3,-30 # 13c8 <malloc+0xee>
     3ee:	0377d163          	bge	a5,s7,410 <main+0x348>
     3f2:	865e                	mv	a2,s7
     3f4:	00001597          	auipc	a1,0x1
     3f8:	1dc58593          	addi	a1,a1,476 # 15d0 <malloc+0x2f6>
     3fc:	4509                	li	a0,2
     3fe:	00001097          	auipc	ra,0x1
     402:	df6080e7          	jalr	-522(ra) # 11f4 <fprintf>
      color_reset();
     406:	00000097          	auipc	ra,0x0
     40a:	c96080e7          	jalr	-874(ra) # 9c <color_reset>
     40e:	a31d                	j	934 <main+0x86c>
      fprintf(2, " (%d fd%s ready)", ret, ret > 1 ? "s" : "");
     410:	00001697          	auipc	a3,0x1
     414:	37068693          	addi	a3,a3,880 # 1780 <malloc+0x4a6>
     418:	bfe9                	j	3f2 <main+0x32a>
  char seq[] = {0x1b, '[', '3', '1', 'm'};
     41a:	f1843783          	ld	a5,-232(s0)
     41e:	f2f42823          	sw	a5,-208(s0)
     422:	06d00793          	li	a5,109
     426:	f2f40a23          	sb	a5,-204(s0)
  write(2, seq, sizeof(seq));
     42a:	4615                	li	a2,5
     42c:	f2843583          	ld	a1,-216(s0)
     430:	4509                	li	a0,2
     432:	00001097          	auipc	ra,0x1
     436:	890080e7          	jalr	-1904(ra) # cc2 <write>
      fprintf(2, "%s", pipe_names[i]);
     43a:	000b3483          	ld	s1,0(s6)
     43e:	8626                	mv	a2,s1
     440:	85e6                	mv	a1,s9
     442:	4509                	li	a0,2
     444:	00001097          	auipc	ra,0x1
     448:	db0080e7          	jalr	-592(ra) # 11f4 <fprintf>
      int namelen = strlen(pipe_names[i]);
     44c:	8526                	mv	a0,s1
     44e:	00000097          	auipc	ra,0x0
     452:	612080e7          	jalr	1554(ra) # a60 <strlen>
     456:	0005049b          	sext.w	s1,a0
      for(int p = namelen; p < 8; p++) fprintf(2, " ");
     45a:	479d                	li	a5,7
     45c:	0097cc63          	blt	a5,s1,474 <main+0x3ac>
     460:	49a1                	li	s3,8
     462:	85ca                	mv	a1,s2
     464:	4509                	li	a0,2
     466:	00001097          	auipc	ra,0x1
     46a:	d8e080e7          	jalr	-626(ra) # 11f4 <fprintf>
     46e:	2485                	addiw	s1,s1,1
     470:	ff3499e3          	bne	s1,s3,462 <main+0x39a>
      color_reset();
     474:	00000097          	auipc	ra,0x0
     478:	c28080e7          	jalr	-984(ra) # 9c <color_reset>
      fprintf(2, "  --   ----      [CLOSED]                     |\n");
     47c:	00001597          	auipc	a1,0x1
     480:	20c58593          	addi	a1,a1,524 # 1688 <malloc+0x3ae>
     484:	4509                	li	a0,2
     486:	00001097          	auipc	ra,0x1
     48a:	d6e080e7          	jalr	-658(ra) # 11f4 <fprintf>
      continue;
     48e:	a8a1                	j	4e6 <main+0x41e>
    else fprintf(2, " ");
     490:	85ca                	mv	a1,s2
     492:	4509                	li	a0,2
     494:	00001097          	auipc	ra,0x1
     498:	d60080e7          	jalr	-672(ra) # 11f4 <fprintf>
     49c:	a0f9                	j	56a <main+0x4a2>
      fprintf(2, "------");
     49e:	00001597          	auipc	a1,0x1
     4a2:	23a58593          	addi	a1,a1,570 # 16d8 <malloc+0x3fe>
     4a6:	4509                	li	a0,2
     4a8:	00001097          	auipc	ra,0x1
     4ac:	d4c080e7          	jalr	-692(ra) # 11f4 <fprintf>
     4b0:	a8ed                	j	5aa <main+0x4e2>
      color_green();
     4b2:	00000097          	auipc	ra,0x0
     4b6:	bb6080e7          	jalr	-1098(ra) # 68 <color_green>
      fprintf(2, "[DATA READY!]  ");
     4ba:	00001597          	auipc	a1,0x1
     4be:	22e58593          	addi	a1,a1,558 # 16e8 <malloc+0x40e>
     4c2:	4509                	li	a0,2
     4c4:	00001097          	auipc	ra,0x1
     4c8:	d30080e7          	jalr	-720(ra) # 11f4 <fprintf>
      color_reset();
     4cc:	00000097          	auipc	ra,0x0
     4d0:	bd0080e7          	jalr	-1072(ra) # 9c <color_reset>
    fprintf(2, "       |\n");
     4d4:	00001597          	auipc	a1,0x1
     4d8:	25458593          	addi	a1,a1,596 # 1728 <malloc+0x44e>
     4dc:	4509                	li	a0,2
     4de:	00001097          	auipc	ra,0x1
     4e2:	d16080e7          	jalr	-746(ra) # 11f4 <fprintf>
  for(int i = 0; i < NUM_PIPES; i++) {
     4e6:	0a21                	addi	s4,s4,8
     4e8:	0b21                	addi	s6,s6,8
     4ea:	178a0a63          	beq	s4,s8,65e <main+0x596>
    fprintf(2, "  |  ");
     4ee:	85ea                	mv	a1,s10
     4f0:	4509                	li	a0,2
     4f2:	00001097          	auipc	ra,0x1
     4f6:	d02080e7          	jalr	-766(ra) # 11f4 <fprintf>
    if(fds[i].fd < 0) {
     4fa:	8ad2                	mv	s5,s4
     4fc:	000a2783          	lw	a5,0(s4)
     500:	f007cde3          	bltz	a5,41a <main+0x352>
    color_cyan();
     504:	00000097          	auipc	ra,0x0
     508:	afc080e7          	jalr	-1284(ra) # 0 <color_cyan>
    fprintf(2, "%s", pipe_names[i]);
     50c:	000b3483          	ld	s1,0(s6)
     510:	8626                	mv	a2,s1
     512:	85e6                	mv	a1,s9
     514:	4509                	li	a0,2
     516:	00001097          	auipc	ra,0x1
     51a:	cde080e7          	jalr	-802(ra) # 11f4 <fprintf>
    int namelen = strlen(pipe_names[i]);
     51e:	8526                	mv	a0,s1
     520:	00000097          	auipc	ra,0x0
     524:	540080e7          	jalr	1344(ra) # a60 <strlen>
     528:	0005049b          	sext.w	s1,a0
    for(int p = namelen; p < 8; p++) fprintf(2, " ");
     52c:	479d                	li	a5,7
     52e:	0097cc63          	blt	a5,s1,546 <main+0x47e>
     532:	49a1                	li	s3,8
     534:	85ca                	mv	a1,s2
     536:	4509                	li	a0,2
     538:	00001097          	auipc	ra,0x1
     53c:	cbc080e7          	jalr	-836(ra) # 11f4 <fprintf>
     540:	2485                	addiw	s1,s1,1
     542:	ff3499e3          	bne	s1,s3,534 <main+0x46c>
    color_reset();
     546:	00000097          	auipc	ra,0x0
     54a:	b56080e7          	jalr	-1194(ra) # 9c <color_reset>
    if(fds[i].fd < 10) fprintf(2, "  ");
     54e:	000aa703          	lw	a4,0(s5)
     552:	47a5                	li	a5,9
     554:	f2e7cee3          	blt	a5,a4,490 <main+0x3c8>
     558:	00001597          	auipc	a1,0x1
     55c:	16858593          	addi	a1,a1,360 # 16c0 <malloc+0x3e6>
     560:	4509                	li	a0,2
     562:	00001097          	auipc	ra,0x1
     566:	c92080e7          	jalr	-878(ra) # 11f4 <fprintf>
    fprintf(2, "%d   ", fds[i].fd);
     56a:	000aa603          	lw	a2,0(s5)
     56e:	00001597          	auipc	a1,0x1
     572:	15a58593          	addi	a1,a1,346 # 16c8 <malloc+0x3ee>
     576:	4509                	li	a0,2
     578:	00001097          	auipc	ra,0x1
     57c:	c7c080e7          	jalr	-900(ra) # 11f4 <fprintf>
    if(fds[i].events & POLLIN) {
     580:	004ad783          	lhu	a5,4(s5)
     584:	8b85                	andi	a5,a5,1
     586:	df81                	beqz	a5,49e <main+0x3d6>
      color_yellow();
     588:	00000097          	auipc	ra,0x0
     58c:	aac080e7          	jalr	-1364(ra) # 34 <color_yellow>
      fprintf(2, "POLLIN");
     590:	00001597          	auipc	a1,0x1
     594:	14058593          	addi	a1,a1,320 # 16d0 <malloc+0x3f6>
     598:	4509                	li	a0,2
     59a:	00001097          	auipc	ra,0x1
     59e:	c5a080e7          	jalr	-934(ra) # 11f4 <fprintf>
      color_reset();
     5a2:	00000097          	auipc	ra,0x0
     5a6:	afa080e7          	jalr	-1286(ra) # 9c <color_reset>
    fprintf(2, "    ");
     5aa:	00001597          	auipc	a1,0x1
     5ae:	13658593          	addi	a1,a1,310 # 16e0 <malloc+0x406>
     5b2:	4509                	li	a0,2
     5b4:	00001097          	auipc	ra,0x1
     5b8:	c40080e7          	jalr	-960(ra) # 11f4 <fprintf>
    if(fds[i].revents & POLLIN) {
     5bc:	006ad783          	lhu	a5,6(s5)
     5c0:	0017f713          	andi	a4,a5,1
     5c4:	ee0717e3          	bnez	a4,4b2 <main+0x3ea>
    } else if(fds[i].revents & POLLHUP) {
     5c8:	0107f713          	andi	a4,a5,16
     5cc:	e329                	bnez	a4,60e <main+0x546>
    } else if(fds[i].revents & POLLERR) {
     5ce:	8ba1                	andi	a5,a5,8
     5d0:	cfad                	beqz	a5,64a <main+0x582>
  char seq[] = {0x1b, '[', '3', '1', 'm'};
     5d2:	f1843783          	ld	a5,-232(s0)
     5d6:	f2f42823          	sw	a5,-208(s0)
     5da:	06d00793          	li	a5,109
     5de:	f2f40a23          	sb	a5,-204(s0)
  write(2, seq, sizeof(seq));
     5e2:	4615                	li	a2,5
     5e4:	f2843583          	ld	a1,-216(s0)
     5e8:	4509                	li	a0,2
     5ea:	00000097          	auipc	ra,0x0
     5ee:	6d8080e7          	jalr	1752(ra) # cc2 <write>
      fprintf(2, "[ERROR]        ");
     5f2:	00001597          	auipc	a1,0x1
     5f6:	11658593          	addi	a1,a1,278 # 1708 <malloc+0x42e>
     5fa:	4509                	li	a0,2
     5fc:	00001097          	auipc	ra,0x1
     600:	bf8080e7          	jalr	-1032(ra) # 11f4 <fprintf>
      color_reset();
     604:	00000097          	auipc	ra,0x0
     608:	a98080e7          	jalr	-1384(ra) # 9c <color_reset>
     60c:	b5e1                	j	4d4 <main+0x40c>
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     60e:	ef843783          	ld	a5,-264(s0)
     612:	f2f42823          	sw	a5,-208(s0)
     616:	06d00793          	li	a5,109
     61a:	f2f40a23          	sb	a5,-204(s0)
  write(2, seq, sizeof(seq));
     61e:	4615                	li	a2,5
     620:	f2843583          	ld	a1,-216(s0)
     624:	4509                	li	a0,2
     626:	00000097          	auipc	ra,0x0
     62a:	69c080e7          	jalr	1692(ra) # cc2 <write>
      fprintf(2, "[HANGUP]       ");
     62e:	00001597          	auipc	a1,0x1
     632:	0ca58593          	addi	a1,a1,202 # 16f8 <malloc+0x41e>
     636:	4509                	li	a0,2
     638:	00001097          	auipc	ra,0x1
     63c:	bbc080e7          	jalr	-1092(ra) # 11f4 <fprintf>
      color_reset();
     640:	00000097          	auipc	ra,0x0
     644:	a5c080e7          	jalr	-1444(ra) # 9c <color_reset>
     648:	b571                	j	4d4 <main+0x40c>
      fprintf(2, "[waiting...]   ");
     64a:	00001597          	auipc	a1,0x1
     64e:	0ce58593          	addi	a1,a1,206 # 1718 <malloc+0x43e>
     652:	4509                	li	a0,2
     654:	00001097          	auipc	ra,0x1
     658:	ba0080e7          	jalr	-1120(ra) # 11f4 <fprintf>
     65c:	bda5                	j	4d4 <main+0x40c>
  fprintf(2, "  +----------------------------------------------------------+\n");
     65e:	00001597          	auipc	a1,0x1
     662:	f9258593          	addi	a1,a1,-110 # 15f0 <malloc+0x316>
     666:	4509                	li	a0,2
     668:	00001097          	auipc	ra,0x1
     66c:	b8c080e7          	jalr	-1140(ra) # 11f4 <fprintf>
  fprintf(2, "  Active pipes: %d / %d\n", active_count, NUM_PIPES);
     670:	4691                	li	a3,4
     672:	866e                	mv	a2,s11
     674:	00001597          	auipc	a1,0x1
     678:	0c458593          	addi	a1,a1,196 # 1738 <malloc+0x45e>
     67c:	4509                	li	a0,2
     67e:	00001097          	auipc	ra,0x1
     682:	b76080e7          	jalr	-1162(ra) # 11f4 <fprintf>
    
    // 打印状态面板
    print_pipe_status(fds, active_pipes);
    
    // 处理就绪的 fd
    if(ret > 0) {
     686:	0b704e63          	bgtz	s7,742 <main+0x67a>
          active_pipes--;
        }
      }
    }
    
    fprintf(2, "\n  Total messages received: %d\n", total_messages);
     68a:	f1043603          	ld	a2,-240(s0)
     68e:	00001597          	auipc	a1,0x1
     692:	12258593          	addi	a1,a1,290 # 17b0 <malloc+0x4d6>
     696:	4509                	li	a0,2
     698:	00001097          	auipc	ra,0x1
     69c:	b5c080e7          	jalr	-1188(ra) # 11f4 <fprintf>
    
    if(active_pipes > 0) {
     6a0:	1bb04b63          	bgtz	s11,856 <main+0x78e>
      fprintf(2, "  Waiting for more data...\n");
    }
    
    sleep(50);  // 短暂延迟便于观察
     6a4:	03200513          	li	a0,50
     6a8:	00000097          	auipc	ra,0x0
     6ac:	672080e7          	jalr	1650(ra) # d1a <sleep>
  }
  
  // 等待所有子进程
  for(int i = 0; i < NUM_PIPES; i++) {
    wait(0);
     6b0:	4501                	li	a0,0
     6b2:	00000097          	auipc	ra,0x0
     6b6:	5f8080e7          	jalr	1528(ra) # caa <wait>
     6ba:	4501                	li	a0,0
     6bc:	00000097          	auipc	ra,0x0
     6c0:	5ee080e7          	jalr	1518(ra) # caa <wait>
     6c4:	4501                	li	a0,0
     6c6:	00000097          	auipc	ra,0x0
     6ca:	5e4080e7          	jalr	1508(ra) # caa <wait>
     6ce:	4501                	li	a0,0
     6d0:	00000097          	auipc	ra,0x0
     6d4:	5da080e7          	jalr	1498(ra) # caa <wait>
  }
  
  fprintf(2, "\n");
     6d8:	00001597          	auipc	a1,0x1
     6dc:	0d058593          	addi	a1,a1,208 # 17a8 <malloc+0x4ce>
     6e0:	4509                	li	a0,2
     6e2:	00001097          	auipc	ra,0x1
     6e6:	b12080e7          	jalr	-1262(ra) # 11f4 <fprintf>
  color_green();
     6ea:	00000097          	auipc	ra,0x0
     6ee:	97e080e7          	jalr	-1666(ra) # 68 <color_green>
  fprintf(2, "  === Demo Complete! ===\n");
     6f2:	00001597          	auipc	a1,0x1
     6f6:	0fe58593          	addi	a1,a1,254 # 17f0 <malloc+0x516>
     6fa:	4509                	li	a0,2
     6fc:	00001097          	auipc	ra,0x1
     700:	af8080e7          	jalr	-1288(ra) # 11f4 <fprintf>
  color_reset();
     704:	00000097          	auipc	ra,0x0
     708:	998080e7          	jalr	-1640(ra) # 9c <color_reset>
  fprintf(2, "  All %d writers finished. Total messages: %d\n", NUM_PIPES, total_messages);
     70c:	f1043683          	ld	a3,-240(s0)
     710:	4611                	li	a2,4
     712:	00001597          	auipc	a1,0x1
     716:	0fe58593          	addi	a1,a1,254 # 1810 <malloc+0x536>
     71a:	4509                	li	a0,2
     71c:	00001097          	auipc	ra,0x1
     720:	ad8080e7          	jalr	-1320(ra) # 11f4 <fprintf>
  fprintf(2, "  poll() efficiently monitored %d pipes without blocking!\n\n", NUM_PIPES);
     724:	4611                	li	a2,4
     726:	00001597          	auipc	a1,0x1
     72a:	11a58593          	addi	a1,a1,282 # 1840 <malloc+0x566>
     72e:	4509                	li	a0,2
     730:	00001097          	auipc	ra,0x1
     734:	ac4080e7          	jalr	-1340(ra) # 11f4 <fprintf>
  
  exit(0);
     738:	4501                	li	a0,0
     73a:	00000097          	auipc	ra,0x0
     73e:	568080e7          	jalr	1384(ra) # ca2 <exit>
      fprintf(2, "\n  Events:\n");
     742:	00001597          	auipc	a1,0x1
     746:	01658593          	addi	a1,a1,22 # 1758 <malloc+0x47e>
     74a:	4509                	li	a0,2
     74c:	00001097          	auipc	ra,0x1
     750:	aa8080e7          	jalr	-1368(ra) # 11f4 <fprintf>
     754:	00001917          	auipc	s2,0x1
     758:	1d490913          	addi	s2,s2,468 # 1928 <pipe_names>
     75c:	f0843483          	ld	s1,-248(s0)
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     760:	06d00a93          	li	s5,109
          fprintf(2, "    [%s] Writer closed (POLLHUP)\n", pipe_names[i]);
     764:	00001b97          	auipc	s7,0x1
     768:	024b8b93          	addi	s7,s7,36 # 1788 <malloc+0x4ae>
          fds[i].fd = -1;  // 标记为不再监控
     76c:	5b7d                	li	s6,-1
     76e:	f3140c93          	addi	s9,s0,-207
              if(buf[j] == '\n') buf[j] = 0;
     772:	4a29                	li	s4,10
     774:	a049                	j	7f6 <main+0x72e>
          int n = read(fds[i].fd, buf, sizeof(buf) - 1);
     776:	03f00613          	li	a2,63
     77a:	f2843583          	ld	a1,-216(s0)
     77e:	00000097          	auipc	ra,0x0
     782:	53c080e7          	jalr	1340(ra) # cba <read>
          if(n > 0) {
     786:	08a05063          	blez	a0,806 <main+0x73e>
            buf[n] = 0;
     78a:	f9050793          	addi	a5,a0,-112
     78e:	97a2                	add	a5,a5,s0
     790:	fa078023          	sb	zero,-96(a5)
            for(int j = 0; j < n; j++) {
     794:	f3040793          	addi	a5,s0,-208
     798:	fff5071b          	addiw	a4,a0,-1
     79c:	1702                	slli	a4,a4,0x20
     79e:	9301                	srli	a4,a4,0x20
     7a0:	9766                	add	a4,a4,s9
     7a2:	a021                	j	7aa <main+0x6e2>
     7a4:	0785                	addi	a5,a5,1
     7a6:	00e78963          	beq	a5,a4,7b8 <main+0x6f0>
              if(buf[j] == '\n') buf[j] = 0;
     7aa:	0007c683          	lbu	a3,0(a5)
     7ae:	ff469be3          	bne	a3,s4,7a4 <main+0x6dc>
     7b2:	00078023          	sb	zero,0(a5)
     7b6:	b7fd                	j	7a4 <main+0x6dc>
            color_green();
     7b8:	00000097          	auipc	ra,0x0
     7bc:	8b0080e7          	jalr	-1872(ra) # 68 <color_green>
            fprintf(2, "    [%s] Received: \"%s\"\n", pipe_names[i], buf);
     7c0:	f2843683          	ld	a3,-216(s0)
     7c4:	00093603          	ld	a2,0(s2)
     7c8:	00001597          	auipc	a1,0x1
     7cc:	fa058593          	addi	a1,a1,-96 # 1768 <malloc+0x48e>
     7d0:	4509                	li	a0,2
     7d2:	00001097          	auipc	ra,0x1
     7d6:	a22080e7          	jalr	-1502(ra) # 11f4 <fprintf>
            color_reset();
     7da:	00000097          	auipc	ra,0x0
     7de:	8c2080e7          	jalr	-1854(ra) # 9c <color_reset>
            total_messages++;
     7e2:	f1043783          	ld	a5,-240(s0)
     7e6:	2785                	addiw	a5,a5,1
     7e8:	f0f43823          	sd	a5,-240(s0)
     7ec:	a829                	j	806 <main+0x73e>
      for(int i = 0; i < NUM_PIPES; i++) {
     7ee:	04a1                	addi	s1,s1,8
     7f0:	0921                	addi	s2,s2,8
     7f2:	e9848ce3          	beq	s1,s8,68a <main+0x5c2>
        if(fds[i].fd < 0) continue;
     7f6:	89a6                	mv	s3,s1
     7f8:	4088                	lw	a0,0(s1)
     7fa:	fe054ae3          	bltz	a0,7ee <main+0x726>
        if(fds[i].revents & POLLIN) {
     7fe:	0064d783          	lhu	a5,6(s1)
     802:	8b85                	andi	a5,a5,1
     804:	fbad                	bnez	a5,776 <main+0x6ae>
        if(fds[i].revents & POLLHUP) {
     806:	0069d783          	lhu	a5,6(s3)
     80a:	8bc1                	andi	a5,a5,16
     80c:	d3ed                	beqz	a5,7ee <main+0x726>
  char seq[] = {0x1b, '[', '3', '5', 'm'};
     80e:	ef843783          	ld	a5,-264(s0)
     812:	f2f42823          	sw	a5,-208(s0)
     816:	f3540a23          	sb	s5,-204(s0)
  write(2, seq, sizeof(seq));
     81a:	4615                	li	a2,5
     81c:	f2843583          	ld	a1,-216(s0)
     820:	4509                	li	a0,2
     822:	00000097          	auipc	ra,0x0
     826:	4a0080e7          	jalr	1184(ra) # cc2 <write>
          fprintf(2, "    [%s] Writer closed (POLLHUP)\n", pipe_names[i]);
     82a:	00093603          	ld	a2,0(s2)
     82e:	85de                	mv	a1,s7
     830:	4509                	li	a0,2
     832:	00001097          	auipc	ra,0x1
     836:	9c2080e7          	jalr	-1598(ra) # 11f4 <fprintf>
          color_reset();
     83a:	00000097          	auipc	ra,0x0
     83e:	862080e7          	jalr	-1950(ra) # 9c <color_reset>
          close(fds[i].fd);
     842:	0009a503          	lw	a0,0(s3)
     846:	00000097          	auipc	ra,0x0
     84a:	484080e7          	jalr	1156(ra) # cca <close>
          fds[i].fd = -1;  // 标记为不再监控
     84e:	0169a023          	sw	s6,0(s3)
          active_pipes--;
     852:	3dfd                	addiw	s11,s11,-1
     854:	bf69                	j	7ee <main+0x726>
      fprintf(2, "  Waiting for more data...\n");
     856:	00001597          	auipc	a1,0x1
     85a:	f7a58593          	addi	a1,a1,-134 # 17d0 <malloc+0x4f6>
     85e:	4509                	li	a0,2
     860:	00001097          	auipc	ra,0x1
     864:	994080e7          	jalr	-1644(ra) # 11f4 <fprintf>
    sleep(50);  // 短暂延迟便于观察
     868:	03200513          	li	a0,50
     86c:	00000097          	auipc	ra,0x0
     870:	4ae080e7          	jalr	1198(ra) # d1a <sleep>
    round++;
     874:	f2043783          	ld	a5,-224(s0)
     878:	0017849b          	addiw	s1,a5,1
     87c:	f2943023          	sd	s1,-224(s0)
    int ret = poll(fds, NUM_PIPES, 500);
     880:	1f400613          	li	a2,500
     884:	4591                	li	a1,4
     886:	f7040513          	addi	a0,s0,-144
     88a:	00000097          	auipc	ra,0x0
     88e:	616080e7          	jalr	1558(ra) # ea0 <poll>
     892:	8baa                	mv	s7,a0
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
     894:	f0043783          	ld	a5,-256(s0)
     898:	f2f42823          	sw	a5,-208(s0)
     89c:	6799                	lui	a5,0x6
     89e:	b1b78793          	addi	a5,a5,-1253 # 5b1b <__global_pointer$+0x39d3>
     8a2:	f2f41a23          	sh	a5,-204(s0)
     8a6:	04800793          	li	a5,72
     8aa:	f2f40b23          	sb	a5,-202(s0)
  write(2, seq, sizeof(seq));
     8ae:	461d                	li	a2,7
     8b0:	f2843583          	ld	a1,-216(s0)
     8b4:	4509                	li	a0,2
     8b6:	00000097          	auipc	ra,0x0
     8ba:	40c080e7          	jalr	1036(ra) # cc2 <write>
    color_cyan();
     8be:	fffff097          	auipc	ra,0xfffff
     8c2:	742080e7          	jalr	1858(ra) # 0 <color_cyan>
    fprintf(2, "+================================================================+\n");
     8c6:	00001597          	auipc	a1,0x1
     8ca:	b0a58593          	addi	a1,a1,-1270 # 13d0 <malloc+0xf6>
     8ce:	4509                	li	a0,2
     8d0:	00001097          	auipc	ra,0x1
     8d4:	924080e7          	jalr	-1756(ra) # 11f4 <fprintf>
    fprintf(2, "|          I/O Multiplexing Demo - poll() Visualization         |\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	b4058593          	addi	a1,a1,-1216 # 1418 <malloc+0x13e>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	912080e7          	jalr	-1774(ra) # 11f4 <fprintf>
    fprintf(2, "+================================================================+\n");
     8ea:	00001597          	auipc	a1,0x1
     8ee:	ae658593          	addi	a1,a1,-1306 # 13d0 <malloc+0xf6>
     8f2:	4509                	li	a0,2
     8f4:	00001097          	auipc	ra,0x1
     8f8:	900080e7          	jalr	-1792(ra) # 11f4 <fprintf>
    color_reset();
     8fc:	fffff097          	auipc	ra,0xfffff
     900:	7a0080e7          	jalr	1952(ra) # 9c <color_reset>
    fprintf(2, "\n");
     904:	00001597          	auipc	a1,0x1
     908:	ea458593          	addi	a1,a1,-348 # 17a8 <malloc+0x4ce>
     90c:	4509                	li	a0,2
     90e:	00001097          	auipc	ra,0x1
     912:	8e6080e7          	jalr	-1818(ra) # 11f4 <fprintf>
    fprintf(2, "  Round %d | poll() returned: %d", round, ret);
     916:	86de                	mv	a3,s7
     918:	8626                	mv	a2,s1
     91a:	00001597          	auipc	a1,0x1
     91e:	c7e58593          	addi	a1,a1,-898 # 1598 <malloc+0x2be>
     922:	4509                	li	a0,2
     924:	00001097          	auipc	ra,0x1
     928:	8d0080e7          	jalr	-1840(ra) # 11f4 <fprintf>
    if(ret == 0) {
     92c:	a80b86e3          	beqz	s7,3b8 <main+0x2f0>
    } else if(ret > 0) {
     930:	ab7046e3          	bgtz	s7,3dc <main+0x314>
    fprintf(2, "\n\n");
     934:	00001597          	auipc	a1,0x1
     938:	cb458593          	addi	a1,a1,-844 # 15e8 <malloc+0x30e>
     93c:	4509                	li	a0,2
     93e:	00001097          	auipc	ra,0x1
     942:	8b6080e7          	jalr	-1866(ra) # 11f4 <fprintf>
  fprintf(2, "  +----------------------------------------------------------+\n");
     946:	00001597          	auipc	a1,0x1
     94a:	caa58593          	addi	a1,a1,-854 # 15f0 <malloc+0x316>
     94e:	4509                	li	a0,2
     950:	00001097          	auipc	ra,0x1
     954:	8a4080e7          	jalr	-1884(ra) # 11f4 <fprintf>
  fprintf(2, "  |  PIPE     FD   EVENTS    STATUS                         |\n");
     958:	00001597          	auipc	a1,0x1
     95c:	cd858593          	addi	a1,a1,-808 # 1630 <malloc+0x356>
     960:	4509                	li	a0,2
     962:	00001097          	auipc	ra,0x1
     966:	892080e7          	jalr	-1902(ra) # 11f4 <fprintf>
  fprintf(2, "  +----------------------------------------------------------+\n");
     96a:	00001597          	auipc	a1,0x1
     96e:	c8658593          	addi	a1,a1,-890 # 15f0 <malloc+0x316>
     972:	4509                	li	a0,2
     974:	00001097          	auipc	ra,0x1
     978:	880080e7          	jalr	-1920(ra) # 11f4 <fprintf>
     97c:	00001b17          	auipc	s6,0x1
     980:	facb0b13          	addi	s6,s6,-84 # 1928 <pipe_names>
     984:	f0843a03          	ld	s4,-248(s0)
    fprintf(2, "  |  ");
     988:	00001d17          	auipc	s10,0x1
     98c:	ce8d0d13          	addi	s10,s10,-792 # 1670 <malloc+0x396>
    fprintf(2, "%s", pipe_names[i]);
     990:	00001c97          	auipc	s9,0x1
     994:	ce8c8c93          	addi	s9,s9,-792 # 1678 <malloc+0x39e>
    for(int p = namelen; p < 8; p++) fprintf(2, " ");
     998:	00001917          	auipc	s2,0x1
     99c:	ce890913          	addi	s2,s2,-792 # 1680 <malloc+0x3a6>
     9a0:	b6b9                	j	4ee <main+0x426>
    msg[len++] = '0' + (count % 10);
     9a2:	f9078793          	addi	a5,a5,-112
     9a6:	97a2                	add	a5,a5,s0
     9a8:	0367673b          	remw	a4,a4,s6
     9ac:	0307071b          	addiw	a4,a4,48
     9b0:	fae78023          	sb	a4,-96(a5)
    msg[len++] = '\n';
     9b4:	0026079b          	addiw	a5,a2,2
     9b8:	f9078793          	addi	a5,a5,-112
     9bc:	97a2                	add	a5,a5,s0
     9be:	fb478023          	sb	s4,-96(a5)
    write(write_fd, msg, len);
     9c2:	260d                	addiw	a2,a2,3
     9c4:	85d6                	mv	a1,s5
     9c6:	854a                	mv	a0,s2
     9c8:	00000097          	auipc	ra,0x0
     9cc:	2fa080e7          	jalr	762(ra) # cc2 <write>
    sleep(interval);
     9d0:	855e                	mv	a0,s7
     9d2:	00000097          	auipc	ra,0x0
     9d6:	348080e7          	jalr	840(ra) # d1a <sleep>
    count++;
     9da:	0014871b          	addiw	a4,s1,1
     9de:	0007049b          	sext.w	s1,a4
    char *name = pipe_names[pipe_idx];
     9e2:	0009b583          	ld	a1,0(s3)
    while(*name) msg[len++] = *name++;
     9e6:	4781                	li	a5,0
     9e8:	bab1                	j	344 <main+0x27c>

00000000000009ea <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
     9ea:	1141                	addi	sp,sp,-16
     9ec:	e422                	sd	s0,8(sp)
     9ee:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9f0:	87aa                	mv	a5,a0
     9f2:	0585                	addi	a1,a1,1
     9f4:	0785                	addi	a5,a5,1
     9f6:	fff5c703          	lbu	a4,-1(a1)
     9fa:	fee78fa3          	sb	a4,-1(a5)
     9fe:	fb75                	bnez	a4,9f2 <strcpy+0x8>
    ;
  return os;
}
     a00:	6422                	ld	s0,8(sp)
     a02:	0141                	addi	sp,sp,16
     a04:	8082                	ret

0000000000000a06 <strcat>:

char*
strcat(char *s, const char *t)
{
     a06:	1141                	addi	sp,sp,-16
     a08:	e422                	sd	s0,8(sp)
     a0a:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
     a0c:	00054783          	lbu	a5,0(a0)
     a10:	c385                	beqz	a5,a30 <strcat+0x2a>
     a12:	87aa                	mv	a5,a0
    s++;
     a14:	0785                	addi	a5,a5,1
  while(*s)
     a16:	0007c703          	lbu	a4,0(a5)
     a1a:	ff6d                	bnez	a4,a14 <strcat+0xe>
  while((*s++ = *t++))
     a1c:	0585                	addi	a1,a1,1
     a1e:	0785                	addi	a5,a5,1
     a20:	fff5c703          	lbu	a4,-1(a1)
     a24:	fee78fa3          	sb	a4,-1(a5)
     a28:	fb75                	bnez	a4,a1c <strcat+0x16>
    ;
  return os;
}
     a2a:	6422                	ld	s0,8(sp)
     a2c:	0141                	addi	sp,sp,16
     a2e:	8082                	ret
  while(*s)
     a30:	87aa                	mv	a5,a0
     a32:	b7ed                	j	a1c <strcat+0x16>

0000000000000a34 <strcmp>:


int
strcmp(const char *p, const char *q)
{
     a34:	1141                	addi	sp,sp,-16
     a36:	e422                	sd	s0,8(sp)
     a38:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     a3a:	00054783          	lbu	a5,0(a0)
     a3e:	cb91                	beqz	a5,a52 <strcmp+0x1e>
     a40:	0005c703          	lbu	a4,0(a1)
     a44:	00f71763          	bne	a4,a5,a52 <strcmp+0x1e>
    p++, q++;
     a48:	0505                	addi	a0,a0,1
     a4a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     a4c:	00054783          	lbu	a5,0(a0)
     a50:	fbe5                	bnez	a5,a40 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     a52:	0005c503          	lbu	a0,0(a1)
}
     a56:	40a7853b          	subw	a0,a5,a0
     a5a:	6422                	ld	s0,8(sp)
     a5c:	0141                	addi	sp,sp,16
     a5e:	8082                	ret

0000000000000a60 <strlen>:

uint
strlen(const char *s)
{
     a60:	1141                	addi	sp,sp,-16
     a62:	e422                	sd	s0,8(sp)
     a64:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a66:	00054783          	lbu	a5,0(a0)
     a6a:	cf91                	beqz	a5,a86 <strlen+0x26>
     a6c:	0505                	addi	a0,a0,1
     a6e:	87aa                	mv	a5,a0
     a70:	4685                	li	a3,1
     a72:	9e89                	subw	a3,a3,a0
     a74:	00f6853b          	addw	a0,a3,a5
     a78:	0785                	addi	a5,a5,1
     a7a:	fff7c703          	lbu	a4,-1(a5)
     a7e:	fb7d                	bnez	a4,a74 <strlen+0x14>
    ;
  return n;
}
     a80:	6422                	ld	s0,8(sp)
     a82:	0141                	addi	sp,sp,16
     a84:	8082                	ret
  for(n = 0; s[n]; n++)
     a86:	4501                	li	a0,0
     a88:	bfe5                	j	a80 <strlen+0x20>

0000000000000a8a <memset>:

void*
memset(void *dst, int c, uint n)
{
     a8a:	1141                	addi	sp,sp,-16
     a8c:	e422                	sd	s0,8(sp)
     a8e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a90:	ca19                	beqz	a2,aa6 <memset+0x1c>
     a92:	87aa                	mv	a5,a0
     a94:	1602                	slli	a2,a2,0x20
     a96:	9201                	srli	a2,a2,0x20
     a98:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a9c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     aa0:	0785                	addi	a5,a5,1
     aa2:	fee79de3          	bne	a5,a4,a9c <memset+0x12>
  }
  return dst;
}
     aa6:	6422                	ld	s0,8(sp)
     aa8:	0141                	addi	sp,sp,16
     aaa:	8082                	ret

0000000000000aac <strchr>:

char*
strchr(const char *s, char c)
{
     aac:	1141                	addi	sp,sp,-16
     aae:	e422                	sd	s0,8(sp)
     ab0:	0800                	addi	s0,sp,16
  for(; *s; s++)
     ab2:	00054783          	lbu	a5,0(a0)
     ab6:	cb99                	beqz	a5,acc <strchr+0x20>
    if(*s == c)
     ab8:	00f58763          	beq	a1,a5,ac6 <strchr+0x1a>
  for(; *s; s++)
     abc:	0505                	addi	a0,a0,1
     abe:	00054783          	lbu	a5,0(a0)
     ac2:	fbfd                	bnez	a5,ab8 <strchr+0xc>
      return (char*)s;
  return 0;
     ac4:	4501                	li	a0,0
}
     ac6:	6422                	ld	s0,8(sp)
     ac8:	0141                	addi	sp,sp,16
     aca:	8082                	ret
  return 0;
     acc:	4501                	li	a0,0
     ace:	bfe5                	j	ac6 <strchr+0x1a>

0000000000000ad0 <gets>:

char*
gets(char *buf, int max)
{
     ad0:	711d                	addi	sp,sp,-96
     ad2:	ec86                	sd	ra,88(sp)
     ad4:	e8a2                	sd	s0,80(sp)
     ad6:	e4a6                	sd	s1,72(sp)
     ad8:	e0ca                	sd	s2,64(sp)
     ada:	fc4e                	sd	s3,56(sp)
     adc:	f852                	sd	s4,48(sp)
     ade:	f456                	sd	s5,40(sp)
     ae0:	f05a                	sd	s6,32(sp)
     ae2:	ec5e                	sd	s7,24(sp)
     ae4:	e862                	sd	s8,16(sp)
     ae6:	1080                	addi	s0,sp,96
     ae8:	8baa                	mv	s7,a0
     aea:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     aec:	892a                	mv	s2,a0
     aee:	4481                	li	s1,0
    cc = read(0, &c, 1);
     af0:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     af4:	4b29                	li	s6,10
     af6:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     af8:	89a6                	mv	s3,s1
     afa:	2485                	addiw	s1,s1,1
     afc:	0344d763          	bge	s1,s4,b2a <gets+0x5a>
    cc = read(0, &c, 1);
     b00:	4605                	li	a2,1
     b02:	85d6                	mv	a1,s5
     b04:	4501                	li	a0,0
     b06:	00000097          	auipc	ra,0x0
     b0a:	1b4080e7          	jalr	436(ra) # cba <read>
    if(cc < 1)
     b0e:	00a05e63          	blez	a0,b2a <gets+0x5a>
    buf[i++] = c;
     b12:	faf44783          	lbu	a5,-81(s0)
     b16:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     b1a:	01678763          	beq	a5,s6,b28 <gets+0x58>
     b1e:	0905                	addi	s2,s2,1
     b20:	fd879ce3          	bne	a5,s8,af8 <gets+0x28>
  for(i=0; i+1 < max; ){
     b24:	89a6                	mv	s3,s1
     b26:	a011                	j	b2a <gets+0x5a>
     b28:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     b2a:	99de                	add	s3,s3,s7
     b2c:	00098023          	sb	zero,0(s3)
  return buf;
}
     b30:	855e                	mv	a0,s7
     b32:	60e6                	ld	ra,88(sp)
     b34:	6446                	ld	s0,80(sp)
     b36:	64a6                	ld	s1,72(sp)
     b38:	6906                	ld	s2,64(sp)
     b3a:	79e2                	ld	s3,56(sp)
     b3c:	7a42                	ld	s4,48(sp)
     b3e:	7aa2                	ld	s5,40(sp)
     b40:	7b02                	ld	s6,32(sp)
     b42:	6be2                	ld	s7,24(sp)
     b44:	6c42                	ld	s8,16(sp)
     b46:	6125                	addi	sp,sp,96
     b48:	8082                	ret

0000000000000b4a <stat>:

int
stat(const char *n, struct stat *st)
{
     b4a:	1101                	addi	sp,sp,-32
     b4c:	ec06                	sd	ra,24(sp)
     b4e:	e822                	sd	s0,16(sp)
     b50:	e426                	sd	s1,8(sp)
     b52:	e04a                	sd	s2,0(sp)
     b54:	1000                	addi	s0,sp,32
     b56:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b58:	4581                	li	a1,0
     b5a:	00000097          	auipc	ra,0x0
     b5e:	188080e7          	jalr	392(ra) # ce2 <open>
  if(fd < 0)
     b62:	02054563          	bltz	a0,b8c <stat+0x42>
     b66:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b68:	85ca                	mv	a1,s2
     b6a:	00000097          	auipc	ra,0x0
     b6e:	180080e7          	jalr	384(ra) # cea <fstat>
     b72:	892a                	mv	s2,a0
  close(fd);
     b74:	8526                	mv	a0,s1
     b76:	00000097          	auipc	ra,0x0
     b7a:	154080e7          	jalr	340(ra) # cca <close>
  return r;
}
     b7e:	854a                	mv	a0,s2
     b80:	60e2                	ld	ra,24(sp)
     b82:	6442                	ld	s0,16(sp)
     b84:	64a2                	ld	s1,8(sp)
     b86:	6902                	ld	s2,0(sp)
     b88:	6105                	addi	sp,sp,32
     b8a:	8082                	ret
    return -1;
     b8c:	597d                	li	s2,-1
     b8e:	bfc5                	j	b7e <stat+0x34>

0000000000000b90 <atoi>:

int
atoi(const char *s)
{
     b90:	1141                	addi	sp,sp,-16
     b92:	e422                	sd	s0,8(sp)
     b94:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
     b96:	00054703          	lbu	a4,0(a0)
     b9a:	02d00793          	li	a5,45
  int neg = 1;
     b9e:	4585                	li	a1,1
  if (*s == '-') {
     ba0:	04f70363          	beq	a4,a5,be6 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
     ba4:	00054703          	lbu	a4,0(a0)
     ba8:	fd07079b          	addiw	a5,a4,-48
     bac:	0ff7f793          	zext.b	a5,a5
     bb0:	46a5                	li	a3,9
     bb2:	02f6ed63          	bltu	a3,a5,bec <atoi+0x5c>
  n = 0;
     bb6:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
     bb8:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
     bba:	0505                	addi	a0,a0,1
     bbc:	0026979b          	slliw	a5,a3,0x2
     bc0:	9fb5                	addw	a5,a5,a3
     bc2:	0017979b          	slliw	a5,a5,0x1
     bc6:	9fb9                	addw	a5,a5,a4
     bc8:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
     bcc:	00054703          	lbu	a4,0(a0)
     bd0:	fd07079b          	addiw	a5,a4,-48
     bd4:	0ff7f793          	zext.b	a5,a5
     bd8:	fef671e3          	bgeu	a2,a5,bba <atoi+0x2a>
  return n * neg;
}
     bdc:	02d5853b          	mulw	a0,a1,a3
     be0:	6422                	ld	s0,8(sp)
     be2:	0141                	addi	sp,sp,16
     be4:	8082                	ret
    s++;
     be6:	0505                	addi	a0,a0,1
    neg = -1;
     be8:	55fd                	li	a1,-1
     bea:	bf6d                	j	ba4 <atoi+0x14>
  n = 0;
     bec:	4681                	li	a3,0
     bee:	b7fd                	j	bdc <atoi+0x4c>

0000000000000bf0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     bf0:	1141                	addi	sp,sp,-16
     bf2:	e422                	sd	s0,8(sp)
     bf4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     bf6:	02b57463          	bgeu	a0,a1,c1e <memmove+0x2e>
    while(n-- > 0)
     bfa:	00c05f63          	blez	a2,c18 <memmove+0x28>
     bfe:	1602                	slli	a2,a2,0x20
     c00:	9201                	srli	a2,a2,0x20
     c02:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     c06:	872a                	mv	a4,a0
      *dst++ = *src++;
     c08:	0585                	addi	a1,a1,1
     c0a:	0705                	addi	a4,a4,1
     c0c:	fff5c683          	lbu	a3,-1(a1)
     c10:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     c14:	fee79ae3          	bne	a5,a4,c08 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     c18:	6422                	ld	s0,8(sp)
     c1a:	0141                	addi	sp,sp,16
     c1c:	8082                	ret
    dst += n;
     c1e:	00c50733          	add	a4,a0,a2
    src += n;
     c22:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     c24:	fec05ae3          	blez	a2,c18 <memmove+0x28>
     c28:	fff6079b          	addiw	a5,a2,-1
     c2c:	1782                	slli	a5,a5,0x20
     c2e:	9381                	srli	a5,a5,0x20
     c30:	fff7c793          	not	a5,a5
     c34:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     c36:	15fd                	addi	a1,a1,-1
     c38:	177d                	addi	a4,a4,-1
     c3a:	0005c683          	lbu	a3,0(a1)
     c3e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     c42:	fee79ae3          	bne	a5,a4,c36 <memmove+0x46>
     c46:	bfc9                	j	c18 <memmove+0x28>

0000000000000c48 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     c48:	1141                	addi	sp,sp,-16
     c4a:	e422                	sd	s0,8(sp)
     c4c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     c4e:	ca05                	beqz	a2,c7e <memcmp+0x36>
     c50:	fff6069b          	addiw	a3,a2,-1
     c54:	1682                	slli	a3,a3,0x20
     c56:	9281                	srli	a3,a3,0x20
     c58:	0685                	addi	a3,a3,1
     c5a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     c5c:	00054783          	lbu	a5,0(a0)
     c60:	0005c703          	lbu	a4,0(a1)
     c64:	00e79863          	bne	a5,a4,c74 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     c68:	0505                	addi	a0,a0,1
    p2++;
     c6a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     c6c:	fed518e3          	bne	a0,a3,c5c <memcmp+0x14>
  }
  return 0;
     c70:	4501                	li	a0,0
     c72:	a019                	j	c78 <memcmp+0x30>
      return *p1 - *p2;
     c74:	40e7853b          	subw	a0,a5,a4
}
     c78:	6422                	ld	s0,8(sp)
     c7a:	0141                	addi	sp,sp,16
     c7c:	8082                	ret
  return 0;
     c7e:	4501                	li	a0,0
     c80:	bfe5                	j	c78 <memcmp+0x30>

0000000000000c82 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c82:	1141                	addi	sp,sp,-16
     c84:	e406                	sd	ra,8(sp)
     c86:	e022                	sd	s0,0(sp)
     c88:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c8a:	00000097          	auipc	ra,0x0
     c8e:	f66080e7          	jalr	-154(ra) # bf0 <memmove>
}
     c92:	60a2                	ld	ra,8(sp)
     c94:	6402                	ld	s0,0(sp)
     c96:	0141                	addi	sp,sp,16
     c98:	8082                	ret

0000000000000c9a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
     c9a:	4885                	li	a7,1
 ecall
     c9c:	00000073          	ecall
 ret
     ca0:	8082                	ret

0000000000000ca2 <exit>:
.global exit
exit:
 li a7, SYS_exit
     ca2:	4889                	li	a7,2
 ecall
     ca4:	00000073          	ecall
 ret
     ca8:	8082                	ret

0000000000000caa <wait>:
.global wait
wait:
 li a7, SYS_wait
     caa:	488d                	li	a7,3
 ecall
     cac:	00000073          	ecall
 ret
     cb0:	8082                	ret

0000000000000cb2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     cb2:	4891                	li	a7,4
 ecall
     cb4:	00000073          	ecall
 ret
     cb8:	8082                	ret

0000000000000cba <read>:
.global read
read:
 li a7, SYS_read
     cba:	4895                	li	a7,5
 ecall
     cbc:	00000073          	ecall
 ret
     cc0:	8082                	ret

0000000000000cc2 <write>:
.global write
write:
 li a7, SYS_write
     cc2:	48c1                	li	a7,16
 ecall
     cc4:	00000073          	ecall
 ret
     cc8:	8082                	ret

0000000000000cca <close>:
.global close
close:
 li a7, SYS_close
     cca:	48d5                	li	a7,21
 ecall
     ccc:	00000073          	ecall
 ret
     cd0:	8082                	ret

0000000000000cd2 <kill>:
.global kill
kill:
 li a7, SYS_kill
     cd2:	4899                	li	a7,6
 ecall
     cd4:	00000073          	ecall
 ret
     cd8:	8082                	ret

0000000000000cda <exec>:
.global exec
exec:
 li a7, SYS_exec
     cda:	489d                	li	a7,7
 ecall
     cdc:	00000073          	ecall
 ret
     ce0:	8082                	ret

0000000000000ce2 <open>:
.global open
open:
 li a7, SYS_open
     ce2:	48bd                	li	a7,15
 ecall
     ce4:	00000073          	ecall
 ret
     ce8:	8082                	ret

0000000000000cea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     cea:	48a1                	li	a7,8
 ecall
     cec:	00000073          	ecall
 ret
     cf0:	8082                	ret

0000000000000cf2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     cf2:	48d1                	li	a7,20
 ecall
     cf4:	00000073          	ecall
 ret
     cf8:	8082                	ret

0000000000000cfa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     cfa:	48a5                	li	a7,9
 ecall
     cfc:	00000073          	ecall
 ret
     d00:	8082                	ret

0000000000000d02 <dup>:
.global dup
dup:
 li a7, SYS_dup
     d02:	48a9                	li	a7,10
 ecall
     d04:	00000073          	ecall
 ret
     d08:	8082                	ret

0000000000000d0a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d0a:	48ad                	li	a7,11
 ecall
     d0c:	00000073          	ecall
 ret
     d10:	8082                	ret

0000000000000d12 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     d12:	48b1                	li	a7,12
 ecall
     d14:	00000073          	ecall
 ret
     d18:	8082                	ret

0000000000000d1a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     d1a:	48b5                	li	a7,13
 ecall
     d1c:	00000073          	ecall
 ret
     d20:	8082                	ret

0000000000000d22 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d22:	48b9                	li	a7,14
 ecall
     d24:	00000073          	ecall
 ret
     d28:	8082                	ret

0000000000000d2a <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
     d2a:	48d9                	li	a7,22
 ecall
     d2c:	00000073          	ecall
 ret
     d30:	8082                	ret

0000000000000d32 <dev>:
.global dev
dev:
 li a7, SYS_dev
     d32:	48dd                	li	a7,23
 ecall
     d34:	00000073          	ecall
 ret
     d38:	8082                	ret

0000000000000d3a <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
     d3a:	48e1                	li	a7,24
 ecall
     d3c:	00000073          	ecall
 ret
     d40:	8082                	ret

0000000000000d42 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     d42:	48e5                	li	a7,25
 ecall
     d44:	00000073          	ecall
 ret
     d48:	8082                	ret

0000000000000d4a <remove>:
.global remove
remove:
 li a7, SYS_remove
     d4a:	48c5                	li	a7,17
 ecall
     d4c:	00000073          	ecall
 ret
     d50:	8082                	ret

0000000000000d52 <trace>:
.global trace
trace:
 li a7, SYS_trace
     d52:	48c9                	li	a7,18
 ecall
     d54:	00000073          	ecall
 ret
     d58:	8082                	ret

0000000000000d5a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     d5a:	48cd                	li	a7,19
 ecall
     d5c:	00000073          	ecall
 ret
     d60:	8082                	ret

0000000000000d62 <rename>:
.global rename
rename:
 li a7, SYS_rename
     d62:	48e9                	li	a7,26
 ecall
     d64:	00000073          	ecall
 ret
     d68:	8082                	ret

0000000000000d6a <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
     d6a:	48ed                	li	a7,27
 ecall
     d6c:	00000073          	ecall
 ret
     d70:	8082                	ret

0000000000000d72 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
     d72:	48f1                	li	a7,28
 ecall
     d74:	00000073          	ecall
 ret
     d78:	8082                	ret

0000000000000d7a <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
     d7a:	48f5                	li	a7,29
 ecall
     d7c:	00000073          	ecall
 ret
     d80:	8082                	ret

0000000000000d82 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
     d82:	48f9                	li	a7,30
 ecall
     d84:	00000073          	ecall
 ret
     d88:	8082                	ret

0000000000000d8a <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
     d8a:	48fd                	li	a7,31
 ecall
     d8c:	00000073          	ecall
 ret
     d90:	8082                	ret

0000000000000d92 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
     d92:	02000893          	li	a7,32
 ecall
     d96:	00000073          	ecall
 ret
     d9a:	8082                	ret

0000000000000d9c <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     d9c:	02100893          	li	a7,33
 ecall
     da0:	00000073          	ecall
 ret
     da4:	8082                	ret

0000000000000da6 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
     da6:	02200893          	li	a7,34
 ecall
     daa:	00000073          	ecall
 ret
     dae:	8082                	ret

0000000000000db0 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
     db0:	02300893          	li	a7,35
 ecall
     db4:	00000073          	ecall
 ret
     db8:	8082                	ret

0000000000000dba <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
     dba:	02400893          	li	a7,36
 ecall
     dbe:	00000073          	ecall
 ret
     dc2:	8082                	ret

0000000000000dc4 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
     dc4:	02500893          	li	a7,37
 ecall
     dc8:	00000073          	ecall
 ret
     dcc:	8082                	ret

0000000000000dce <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
     dce:	02600893          	li	a7,38
 ecall
     dd2:	00000073          	ecall
 ret
     dd6:	8082                	ret

0000000000000dd8 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
     dd8:	02700893          	li	a7,39
 ecall
     ddc:	00000073          	ecall
 ret
     de0:	8082                	ret

0000000000000de2 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
     de2:	02800893          	li	a7,40
 ecall
     de6:	00000073          	ecall
 ret
     dea:	8082                	ret

0000000000000dec <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
     dec:	02900893          	li	a7,41
 ecall
     df0:	00000073          	ecall
 ret
     df4:	8082                	ret

0000000000000df6 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
     df6:	02a00893          	li	a7,42
 ecall
     dfa:	00000073          	ecall
 ret
     dfe:	8082                	ret

0000000000000e00 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
     e00:	02b00893          	li	a7,43
 ecall
     e04:	00000073          	ecall
 ret
     e08:	8082                	ret

0000000000000e0a <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
     e0a:	02c00893          	li	a7,44
 ecall
     e0e:	00000073          	ecall
 ret
     e12:	8082                	ret

0000000000000e14 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
     e14:	02d00893          	li	a7,45
 ecall
     e18:	00000073          	ecall
 ret
     e1c:	8082                	ret

0000000000000e1e <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
     e1e:	02e00893          	li	a7,46
 ecall
     e22:	00000073          	ecall
 ret
     e26:	8082                	ret

0000000000000e28 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
     e28:	02f00893          	li	a7,47
 ecall
     e2c:	00000073          	ecall
 ret
     e30:	8082                	ret

0000000000000e32 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
     e32:	03000893          	li	a7,48
 ecall
     e36:	00000073          	ecall
 ret
     e3a:	8082                	ret

0000000000000e3c <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
     e3c:	03100893          	li	a7,49
 ecall
     e40:	00000073          	ecall
 ret
     e44:	8082                	ret

0000000000000e46 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
     e46:	03200893          	li	a7,50
 ecall
     e4a:	00000073          	ecall
 ret
     e4e:	8082                	ret

0000000000000e50 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
     e50:	03300893          	li	a7,51
 ecall
     e54:	00000073          	ecall
 ret
     e58:	8082                	ret

0000000000000e5a <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
     e5a:	03400893          	li	a7,52
 ecall
     e5e:	00000073          	ecall
 ret
     e62:	8082                	ret

0000000000000e64 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
     e64:	03500893          	li	a7,53
 ecall
     e68:	00000073          	ecall
 ret
     e6c:	8082                	ret

0000000000000e6e <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
     e6e:	03600893          	li	a7,54
 ecall
     e72:	00000073          	ecall
 ret
     e76:	8082                	ret

0000000000000e78 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
     e78:	03700893          	li	a7,55
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
     e82:	03800893          	li	a7,56
 ecall
     e86:	00000073          	ecall
 ret
     e8a:	8082                	ret

0000000000000e8c <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
     e8c:	03900893          	li	a7,57
 ecall
     e90:	00000073          	ecall
 ret
     e94:	8082                	ret

0000000000000e96 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
     e96:	03a00893          	li	a7,58
 ecall
     e9a:	00000073          	ecall
 ret
     e9e:	8082                	ret

0000000000000ea0 <poll>:
.global poll
poll:
 li a7, SYS_poll
     ea0:	03b00893          	li	a7,59
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
     eaa:	03c00893          	li	a7,60
 ecall
     eae:	00000073          	ecall
 ret
     eb2:	8082                	ret

0000000000000eb4 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
     eb4:	03d00893          	li	a7,61
 ecall
     eb8:	00000073          	ecall
 ret
     ebc:	8082                	ret

0000000000000ebe <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
     ebe:	03e00893          	li	a7,62
 ecall
     ec2:	00000073          	ecall
 ret
     ec6:	8082                	ret

0000000000000ec8 <clone>:
.global clone
clone:
 li a7, SYS_clone
     ec8:	03f00893          	li	a7,63
 ecall
     ecc:	00000073          	ecall
 ret
     ed0:	8082                	ret

0000000000000ed2 <futex>:
.global futex
futex:
 li a7, SYS_futex
     ed2:	04000893          	li	a7,64
 ecall
     ed6:	00000073          	ecall
 ret
     eda:	8082                	ret

0000000000000edc <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
     edc:	04100893          	li	a7,65
 ecall
     ee0:	00000073          	ecall
 ret
     ee4:	8082                	ret

0000000000000ee6 <halt>:
.global halt
halt:
 li a7, SYS_halt
     ee6:	04200893          	li	a7,66
 ecall
     eea:	00000073          	ecall
 ret
     eee:	8082                	ret

0000000000000ef0 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
     ef0:	04300893          	li	a7,67
 ecall
     ef4:	00000073          	ecall
 ret
     ef8:	8082                	ret

0000000000000efa <socket>:
.global socket
socket:
 li a7, SYS_socket
     efa:	04400893          	li	a7,68
 ecall
     efe:	00000073          	ecall
 ret
     f02:	8082                	ret

0000000000000f04 <bind>:
.global bind
bind:
 li a7, SYS_bind
     f04:	04500893          	li	a7,69
 ecall
     f08:	00000073          	ecall
 ret
     f0c:	8082                	ret

0000000000000f0e <listen>:
.global listen
listen:
 li a7, SYS_listen
     f0e:	04600893          	li	a7,70
 ecall
     f12:	00000073          	ecall
 ret
     f16:	8082                	ret

0000000000000f18 <accept>:
.global accept
accept:
 li a7, SYS_accept
     f18:	04700893          	li	a7,71
 ecall
     f1c:	00000073          	ecall
 ret
     f20:	8082                	ret

0000000000000f22 <connect>:
.global connect
connect:
 li a7, SYS_connect
     f22:	04800893          	li	a7,72
 ecall
     f26:	00000073          	ecall
 ret
     f2a:	8082                	ret

0000000000000f2c <send>:
.global send
send:
 li a7, SYS_send
     f2c:	04900893          	li	a7,73
 ecall
     f30:	00000073          	ecall
 ret
     f34:	8082                	ret

0000000000000f36 <recv>:
.global recv
recv:
 li a7, SYS_recv
     f36:	04a00893          	li	a7,74
 ecall
     f3a:	00000073          	ecall
 ret
     f3e:	8082                	ret

0000000000000f40 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
     f40:	04b00893          	li	a7,75
 ecall
     f44:	00000073          	ecall
 ret
     f48:	8082                	ret

0000000000000f4a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f4a:	1101                	addi	sp,sp,-32
     f4c:	ec06                	sd	ra,24(sp)
     f4e:	e822                	sd	s0,16(sp)
     f50:	1000                	addi	s0,sp,32
     f52:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f56:	4605                	li	a2,1
     f58:	fef40593          	addi	a1,s0,-17
     f5c:	00000097          	auipc	ra,0x0
     f60:	d66080e7          	jalr	-666(ra) # cc2 <write>
}
     f64:	60e2                	ld	ra,24(sp)
     f66:	6442                	ld	s0,16(sp)
     f68:	6105                	addi	sp,sp,32
     f6a:	8082                	ret

0000000000000f6c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f6c:	7139                	addi	sp,sp,-64
     f6e:	fc06                	sd	ra,56(sp)
     f70:	f822                	sd	s0,48(sp)
     f72:	f426                	sd	s1,40(sp)
     f74:	f04a                	sd	s2,32(sp)
     f76:	ec4e                	sd	s3,24(sp)
     f78:	0080                	addi	s0,sp,64
     f7a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f7c:	c299                	beqz	a3,f82 <printint+0x16>
     f7e:	0805c863          	bltz	a1,100e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f82:	2581                	sext.w	a1,a1
  neg = 0;
     f84:	4881                	li	a7,0
  }

  i = 0;
     f86:	fc040993          	addi	s3,s0,-64
  neg = 0;
     f8a:	86ce                	mv	a3,s3
  i = 0;
     f8c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f8e:	2601                	sext.w	a2,a2
     f90:	00001517          	auipc	a0,0x1
     f94:	98050513          	addi	a0,a0,-1664 # 1910 <digits>
     f98:	883a                	mv	a6,a4
     f9a:	2705                	addiw	a4,a4,1
     f9c:	02c5f7bb          	remuw	a5,a1,a2
     fa0:	1782                	slli	a5,a5,0x20
     fa2:	9381                	srli	a5,a5,0x20
     fa4:	97aa                	add	a5,a5,a0
     fa6:	0007c783          	lbu	a5,0(a5)
     faa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     fae:	0005879b          	sext.w	a5,a1
     fb2:	02c5d5bb          	divuw	a1,a1,a2
     fb6:	0685                	addi	a3,a3,1
     fb8:	fec7f0e3          	bgeu	a5,a2,f98 <printint+0x2c>
  if(neg)
     fbc:	00088c63          	beqz	a7,fd4 <printint+0x68>
    buf[i++] = '-';
     fc0:	fd070793          	addi	a5,a4,-48
     fc4:	00878733          	add	a4,a5,s0
     fc8:	02d00793          	li	a5,45
     fcc:	fef70823          	sb	a5,-16(a4)
     fd0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     fd4:	02e05663          	blez	a4,1000 <printint+0x94>
     fd8:	fc040913          	addi	s2,s0,-64
     fdc:	993a                	add	s2,s2,a4
     fde:	19fd                	addi	s3,s3,-1
     fe0:	99ba                	add	s3,s3,a4
     fe2:	377d                	addiw	a4,a4,-1
     fe4:	1702                	slli	a4,a4,0x20
     fe6:	9301                	srli	a4,a4,0x20
     fe8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     fec:	fff94583          	lbu	a1,-1(s2)
     ff0:	8526                	mv	a0,s1
     ff2:	00000097          	auipc	ra,0x0
     ff6:	f58080e7          	jalr	-168(ra) # f4a <putc>
  while(--i >= 0)
     ffa:	197d                	addi	s2,s2,-1
     ffc:	ff3918e3          	bne	s2,s3,fec <printint+0x80>
}
    1000:	70e2                	ld	ra,56(sp)
    1002:	7442                	ld	s0,48(sp)
    1004:	74a2                	ld	s1,40(sp)
    1006:	7902                	ld	s2,32(sp)
    1008:	69e2                	ld	s3,24(sp)
    100a:	6121                	addi	sp,sp,64
    100c:	8082                	ret
    x = -xx;
    100e:	40b005bb          	negw	a1,a1
    neg = 1;
    1012:	4885                	li	a7,1
    x = -xx;
    1014:	bf8d                	j	f86 <printint+0x1a>

0000000000001016 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1016:	7119                	addi	sp,sp,-128
    1018:	fc86                	sd	ra,120(sp)
    101a:	f8a2                	sd	s0,112(sp)
    101c:	f4a6                	sd	s1,104(sp)
    101e:	f0ca                	sd	s2,96(sp)
    1020:	ecce                	sd	s3,88(sp)
    1022:	e8d2                	sd	s4,80(sp)
    1024:	e4d6                	sd	s5,72(sp)
    1026:	e0da                	sd	s6,64(sp)
    1028:	fc5e                	sd	s7,56(sp)
    102a:	f862                	sd	s8,48(sp)
    102c:	f466                	sd	s9,40(sp)
    102e:	f06a                	sd	s10,32(sp)
    1030:	ec6e                	sd	s11,24(sp)
    1032:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1034:	0005c903          	lbu	s2,0(a1)
    1038:	18090f63          	beqz	s2,11d6 <vprintf+0x1c0>
    103c:	8aaa                	mv	s5,a0
    103e:	8b32                	mv	s6,a2
    1040:	00158493          	addi	s1,a1,1
  state = 0;
    1044:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1046:	02500a13          	li	s4,37
    104a:	4c55                	li	s8,21
    104c:	00001c97          	auipc	s9,0x1
    1050:	86cc8c93          	addi	s9,s9,-1940 # 18b8 <pipe_intervals+0x18>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1054:	02800d93          	li	s11,40
  putc(fd, 'x');
    1058:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    105a:	00001b97          	auipc	s7,0x1
    105e:	8b6b8b93          	addi	s7,s7,-1866 # 1910 <digits>
    1062:	a839                	j	1080 <vprintf+0x6a>
        putc(fd, c);
    1064:	85ca                	mv	a1,s2
    1066:	8556                	mv	a0,s5
    1068:	00000097          	auipc	ra,0x0
    106c:	ee2080e7          	jalr	-286(ra) # f4a <putc>
    1070:	a019                	j	1076 <vprintf+0x60>
    } else if(state == '%'){
    1072:	01498d63          	beq	s3,s4,108c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    1076:	0485                	addi	s1,s1,1
    1078:	fff4c903          	lbu	s2,-1(s1)
    107c:	14090d63          	beqz	s2,11d6 <vprintf+0x1c0>
    if(state == 0){
    1080:	fe0999e3          	bnez	s3,1072 <vprintf+0x5c>
      if(c == '%'){
    1084:	ff4910e3          	bne	s2,s4,1064 <vprintf+0x4e>
        state = '%';
    1088:	89d2                	mv	s3,s4
    108a:	b7f5                	j	1076 <vprintf+0x60>
      if(c == 'd'){
    108c:	11490c63          	beq	s2,s4,11a4 <vprintf+0x18e>
    1090:	f9d9079b          	addiw	a5,s2,-99
    1094:	0ff7f793          	zext.b	a5,a5
    1098:	10fc6e63          	bltu	s8,a5,11b4 <vprintf+0x19e>
    109c:	f9d9079b          	addiw	a5,s2,-99
    10a0:	0ff7f713          	zext.b	a4,a5
    10a4:	10ec6863          	bltu	s8,a4,11b4 <vprintf+0x19e>
    10a8:	00271793          	slli	a5,a4,0x2
    10ac:	97e6                	add	a5,a5,s9
    10ae:	439c                	lw	a5,0(a5)
    10b0:	97e6                	add	a5,a5,s9
    10b2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    10b4:	008b0913          	addi	s2,s6,8
    10b8:	4685                	li	a3,1
    10ba:	4629                	li	a2,10
    10bc:	000b2583          	lw	a1,0(s6)
    10c0:	8556                	mv	a0,s5
    10c2:	00000097          	auipc	ra,0x0
    10c6:	eaa080e7          	jalr	-342(ra) # f6c <printint>
    10ca:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10cc:	4981                	li	s3,0
    10ce:	b765                	j	1076 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10d0:	008b0913          	addi	s2,s6,8
    10d4:	4681                	li	a3,0
    10d6:	4629                	li	a2,10
    10d8:	000b2583          	lw	a1,0(s6)
    10dc:	8556                	mv	a0,s5
    10de:	00000097          	auipc	ra,0x0
    10e2:	e8e080e7          	jalr	-370(ra) # f6c <printint>
    10e6:	8b4a                	mv	s6,s2
      state = 0;
    10e8:	4981                	li	s3,0
    10ea:	b771                	j	1076 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    10ec:	008b0913          	addi	s2,s6,8
    10f0:	4681                	li	a3,0
    10f2:	866a                	mv	a2,s10
    10f4:	000b2583          	lw	a1,0(s6)
    10f8:	8556                	mv	a0,s5
    10fa:	00000097          	auipc	ra,0x0
    10fe:	e72080e7          	jalr	-398(ra) # f6c <printint>
    1102:	8b4a                	mv	s6,s2
      state = 0;
    1104:	4981                	li	s3,0
    1106:	bf85                	j	1076 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1108:	008b0793          	addi	a5,s6,8
    110c:	f8f43423          	sd	a5,-120(s0)
    1110:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1114:	03000593          	li	a1,48
    1118:	8556                	mv	a0,s5
    111a:	00000097          	auipc	ra,0x0
    111e:	e30080e7          	jalr	-464(ra) # f4a <putc>
  putc(fd, 'x');
    1122:	07800593          	li	a1,120
    1126:	8556                	mv	a0,s5
    1128:	00000097          	auipc	ra,0x0
    112c:	e22080e7          	jalr	-478(ra) # f4a <putc>
    1130:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1132:	03c9d793          	srli	a5,s3,0x3c
    1136:	97de                	add	a5,a5,s7
    1138:	0007c583          	lbu	a1,0(a5)
    113c:	8556                	mv	a0,s5
    113e:	00000097          	auipc	ra,0x0
    1142:	e0c080e7          	jalr	-500(ra) # f4a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1146:	0992                	slli	s3,s3,0x4
    1148:	397d                	addiw	s2,s2,-1
    114a:	fe0914e3          	bnez	s2,1132 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    114e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    1152:	4981                	li	s3,0
    1154:	b70d                	j	1076 <vprintf+0x60>
        s = va_arg(ap, char*);
    1156:	008b0913          	addi	s2,s6,8
    115a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    115e:	02098163          	beqz	s3,1180 <vprintf+0x16a>
        while(*s != 0){
    1162:	0009c583          	lbu	a1,0(s3)
    1166:	c5ad                	beqz	a1,11d0 <vprintf+0x1ba>
          putc(fd, *s);
    1168:	8556                	mv	a0,s5
    116a:	00000097          	auipc	ra,0x0
    116e:	de0080e7          	jalr	-544(ra) # f4a <putc>
          s++;
    1172:	0985                	addi	s3,s3,1
        while(*s != 0){
    1174:	0009c583          	lbu	a1,0(s3)
    1178:	f9e5                	bnez	a1,1168 <vprintf+0x152>
        s = va_arg(ap, char*);
    117a:	8b4a                	mv	s6,s2
      state = 0;
    117c:	4981                	li	s3,0
    117e:	bde5                	j	1076 <vprintf+0x60>
          s = "(null)";
    1180:	00000997          	auipc	s3,0x0
    1184:	73098993          	addi	s3,s3,1840 # 18b0 <pipe_intervals+0x10>
        while(*s != 0){
    1188:	85ee                	mv	a1,s11
    118a:	bff9                	j	1168 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    118c:	008b0913          	addi	s2,s6,8
    1190:	000b4583          	lbu	a1,0(s6)
    1194:	8556                	mv	a0,s5
    1196:	00000097          	auipc	ra,0x0
    119a:	db4080e7          	jalr	-588(ra) # f4a <putc>
    119e:	8b4a                	mv	s6,s2
      state = 0;
    11a0:	4981                	li	s3,0
    11a2:	bdd1                	j	1076 <vprintf+0x60>
        putc(fd, c);
    11a4:	85d2                	mv	a1,s4
    11a6:	8556                	mv	a0,s5
    11a8:	00000097          	auipc	ra,0x0
    11ac:	da2080e7          	jalr	-606(ra) # f4a <putc>
      state = 0;
    11b0:	4981                	li	s3,0
    11b2:	b5d1                	j	1076 <vprintf+0x60>
        putc(fd, '%');
    11b4:	85d2                	mv	a1,s4
    11b6:	8556                	mv	a0,s5
    11b8:	00000097          	auipc	ra,0x0
    11bc:	d92080e7          	jalr	-622(ra) # f4a <putc>
        putc(fd, c);
    11c0:	85ca                	mv	a1,s2
    11c2:	8556                	mv	a0,s5
    11c4:	00000097          	auipc	ra,0x0
    11c8:	d86080e7          	jalr	-634(ra) # f4a <putc>
      state = 0;
    11cc:	4981                	li	s3,0
    11ce:	b565                	j	1076 <vprintf+0x60>
        s = va_arg(ap, char*);
    11d0:	8b4a                	mv	s6,s2
      state = 0;
    11d2:	4981                	li	s3,0
    11d4:	b54d                	j	1076 <vprintf+0x60>
    }
  }
}
    11d6:	70e6                	ld	ra,120(sp)
    11d8:	7446                	ld	s0,112(sp)
    11da:	74a6                	ld	s1,104(sp)
    11dc:	7906                	ld	s2,96(sp)
    11de:	69e6                	ld	s3,88(sp)
    11e0:	6a46                	ld	s4,80(sp)
    11e2:	6aa6                	ld	s5,72(sp)
    11e4:	6b06                	ld	s6,64(sp)
    11e6:	7be2                	ld	s7,56(sp)
    11e8:	7c42                	ld	s8,48(sp)
    11ea:	7ca2                	ld	s9,40(sp)
    11ec:	7d02                	ld	s10,32(sp)
    11ee:	6de2                	ld	s11,24(sp)
    11f0:	6109                	addi	sp,sp,128
    11f2:	8082                	ret

00000000000011f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11f4:	715d                	addi	sp,sp,-80
    11f6:	ec06                	sd	ra,24(sp)
    11f8:	e822                	sd	s0,16(sp)
    11fa:	1000                	addi	s0,sp,32
    11fc:	e010                	sd	a2,0(s0)
    11fe:	e414                	sd	a3,8(s0)
    1200:	e818                	sd	a4,16(s0)
    1202:	ec1c                	sd	a5,24(s0)
    1204:	03043023          	sd	a6,32(s0)
    1208:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    120c:	8622                	mv	a2,s0
    120e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1212:	00000097          	auipc	ra,0x0
    1216:	e04080e7          	jalr	-508(ra) # 1016 <vprintf>
}
    121a:	60e2                	ld	ra,24(sp)
    121c:	6442                	ld	s0,16(sp)
    121e:	6161                	addi	sp,sp,80
    1220:	8082                	ret

0000000000001222 <printf>:

void
printf(const char *fmt, ...)
{
    1222:	711d                	addi	sp,sp,-96
    1224:	ec06                	sd	ra,24(sp)
    1226:	e822                	sd	s0,16(sp)
    1228:	1000                	addi	s0,sp,32
    122a:	e40c                	sd	a1,8(s0)
    122c:	e810                	sd	a2,16(s0)
    122e:	ec14                	sd	a3,24(s0)
    1230:	f018                	sd	a4,32(s0)
    1232:	f41c                	sd	a5,40(s0)
    1234:	03043823          	sd	a6,48(s0)
    1238:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    123c:	00840613          	addi	a2,s0,8
    1240:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1244:	85aa                	mv	a1,a0
    1246:	4505                	li	a0,1
    1248:	00000097          	auipc	ra,0x0
    124c:	dce080e7          	jalr	-562(ra) # 1016 <vprintf>
}
    1250:	60e2                	ld	ra,24(sp)
    1252:	6442                	ld	s0,16(sp)
    1254:	6125                	addi	sp,sp,96
    1256:	8082                	ret

0000000000001258 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1258:	1141                	addi	sp,sp,-16
    125a:	e422                	sd	s0,8(sp)
    125c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    125e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1262:	00000797          	auipc	a5,0x0
    1266:	7067b783          	ld	a5,1798(a5) # 1968 <freep>
    126a:	a02d                	j	1294 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    126c:	4618                	lw	a4,8(a2)
    126e:	9f2d                	addw	a4,a4,a1
    1270:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1274:	6398                	ld	a4,0(a5)
    1276:	6310                	ld	a2,0(a4)
    1278:	a83d                	j	12b6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    127a:	ff852703          	lw	a4,-8(a0)
    127e:	9f31                	addw	a4,a4,a2
    1280:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1282:	ff053683          	ld	a3,-16(a0)
    1286:	a091                	j	12ca <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1288:	6398                	ld	a4,0(a5)
    128a:	00e7e463          	bltu	a5,a4,1292 <free+0x3a>
    128e:	00e6ea63          	bltu	a3,a4,12a2 <free+0x4a>
{
    1292:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1294:	fed7fae3          	bgeu	a5,a3,1288 <free+0x30>
    1298:	6398                	ld	a4,0(a5)
    129a:	00e6e463          	bltu	a3,a4,12a2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    129e:	fee7eae3          	bltu	a5,a4,1292 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    12a2:	ff852583          	lw	a1,-8(a0)
    12a6:	6390                	ld	a2,0(a5)
    12a8:	02059813          	slli	a6,a1,0x20
    12ac:	01c85713          	srli	a4,a6,0x1c
    12b0:	9736                	add	a4,a4,a3
    12b2:	fae60de3          	beq	a2,a4,126c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    12b6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12ba:	4790                	lw	a2,8(a5)
    12bc:	02061593          	slli	a1,a2,0x20
    12c0:	01c5d713          	srli	a4,a1,0x1c
    12c4:	973e                	add	a4,a4,a5
    12c6:	fae68ae3          	beq	a3,a4,127a <free+0x22>
    p->s.ptr = bp->s.ptr;
    12ca:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    12cc:	00000717          	auipc	a4,0x0
    12d0:	68f73e23          	sd	a5,1692(a4) # 1968 <freep>
}
    12d4:	6422                	ld	s0,8(sp)
    12d6:	0141                	addi	sp,sp,16
    12d8:	8082                	ret

00000000000012da <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12da:	7139                	addi	sp,sp,-64
    12dc:	fc06                	sd	ra,56(sp)
    12de:	f822                	sd	s0,48(sp)
    12e0:	f426                	sd	s1,40(sp)
    12e2:	f04a                	sd	s2,32(sp)
    12e4:	ec4e                	sd	s3,24(sp)
    12e6:	e852                	sd	s4,16(sp)
    12e8:	e456                	sd	s5,8(sp)
    12ea:	e05a                	sd	s6,0(sp)
    12ec:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12ee:	02051493          	slli	s1,a0,0x20
    12f2:	9081                	srli	s1,s1,0x20
    12f4:	04bd                	addi	s1,s1,15
    12f6:	8091                	srli	s1,s1,0x4
    12f8:	00148a1b          	addiw	s4,s1,1
    12fc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    12fe:	00000517          	auipc	a0,0x0
    1302:	66a53503          	ld	a0,1642(a0) # 1968 <freep>
    1306:	c515                	beqz	a0,1332 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1308:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    130a:	4798                	lw	a4,8(a5)
    130c:	04977163          	bgeu	a4,s1,134e <malloc+0x74>
    1310:	89d2                	mv	s3,s4
    1312:	000a071b          	sext.w	a4,s4
    1316:	6685                	lui	a3,0x1
    1318:	00d77363          	bgeu	a4,a3,131e <malloc+0x44>
    131c:	6985                	lui	s3,0x1
    131e:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    1322:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1326:	00000917          	auipc	s2,0x0
    132a:	64290913          	addi	s2,s2,1602 # 1968 <freep>
  if(p == (char*)-1)
    132e:	5afd                	li	s5,-1
    1330:	a8a5                	j	13a8 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    1332:	00000797          	auipc	a5,0x0
    1336:	63678793          	addi	a5,a5,1590 # 1968 <freep>
    133a:	00000717          	auipc	a4,0x0
    133e:	63670713          	addi	a4,a4,1590 # 1970 <base>
    1342:	e398                	sd	a4,0(a5)
    1344:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    1346:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    134a:	87ba                	mv	a5,a4
    134c:	b7d1                	j	1310 <malloc+0x36>
      if(p->s.size == nunits)
    134e:	02e48c63          	beq	s1,a4,1386 <malloc+0xac>
        p->s.size -= nunits;
    1352:	4147073b          	subw	a4,a4,s4
    1356:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1358:	02071693          	slli	a3,a4,0x20
    135c:	01c6d713          	srli	a4,a3,0x1c
    1360:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1362:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    1366:	00000717          	auipc	a4,0x0
    136a:	60a73123          	sd	a0,1538(a4) # 1968 <freep>
      return (void*)(p + 1);
    136e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1372:	70e2                	ld	ra,56(sp)
    1374:	7442                	ld	s0,48(sp)
    1376:	74a2                	ld	s1,40(sp)
    1378:	7902                	ld	s2,32(sp)
    137a:	69e2                	ld	s3,24(sp)
    137c:	6a42                	ld	s4,16(sp)
    137e:	6aa2                	ld	s5,8(sp)
    1380:	6b02                	ld	s6,0(sp)
    1382:	6121                	addi	sp,sp,64
    1384:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1386:	6398                	ld	a4,0(a5)
    1388:	e118                	sd	a4,0(a0)
    138a:	bff1                	j	1366 <malloc+0x8c>
  hp->s.size = nu;
    138c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1390:	0541                	addi	a0,a0,16
    1392:	00000097          	auipc	ra,0x0
    1396:	ec6080e7          	jalr	-314(ra) # 1258 <free>
  return freep;
    139a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    139e:	d971                	beqz	a0,1372 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13a2:	4798                	lw	a4,8(a5)
    13a4:	fa9775e3          	bgeu	a4,s1,134e <malloc+0x74>
    if(p == freep)
    13a8:	00093703          	ld	a4,0(s2)
    13ac:	853e                	mv	a0,a5
    13ae:	fef719e3          	bne	a4,a5,13a0 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    13b2:	854e                	mv	a0,s3
    13b4:	00000097          	auipc	ra,0x0
    13b8:	95e080e7          	jalr	-1698(ra) # d12 <sbrk>
  if(p == (char*)-1)
    13bc:	fd5518e3          	bne	a0,s5,138c <malloc+0xb2>
        return 0;
    13c0:	4501                	li	a0,0
    13c2:	bf45                	j	1372 <malloc+0x98>
