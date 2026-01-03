
serein-user/_ipcband：     文件格式 elf64-littleriscv


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
       c:	b1b78793          	addi	a5,a5,-1253 # 36335b1b <__global_pointer$+0x36333c12>
      10:	fef42423          	sw	a5,-24(s0)
      14:	06d00793          	li	a5,109
      18:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      1c:	4615                	li	a2,5
      1e:	fe840593          	addi	a1,s0,-24
      22:	4509                	li	a0,2
      24:	00001097          	auipc	ra,0x1
      28:	b88080e7          	jalr	-1144(ra) # bac <write>
}
      2c:	60e2                	ld	ra,24(sp)
      2e:	6442                	ld	s0,16(sp)
      30:	6105                	addi	sp,sp,32
      32:	8082                	ret

0000000000000034 <color_green>:
static void color_green(void) {
      34:	1101                	addi	sp,sp,-32
      36:	ec06                	sd	ra,24(sp)
      38:	e822                	sd	s0,16(sp)
      3a:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '2', 'm'};
      3c:	323367b7          	lui	a5,0x32336
      40:	b1b78793          	addi	a5,a5,-1253 # 32335b1b <__global_pointer$+0x32333c12>
      44:	fef42423          	sw	a5,-24(s0)
      48:	06d00793          	li	a5,109
      4c:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      50:	4615                	li	a2,5
      52:	fe840593          	addi	a1,s0,-24
      56:	4509                	li	a0,2
      58:	00001097          	auipc	ra,0x1
      5c:	b54080e7          	jalr	-1196(ra) # bac <write>
}
      60:	60e2                	ld	ra,24(sp)
      62:	6442                	ld	s0,16(sp)
      64:	6105                	addi	sp,sp,32
      66:	8082                	ret

0000000000000068 <color_reset>:

static void color_reset(void) {
      68:	1101                	addi	sp,sp,-32
      6a:	ec06                	sd	ra,24(sp)
      6c:	e822                	sd	s0,16(sp)
      6e:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '0', 'm'};
      70:	6d3067b7          	lui	a5,0x6d306
      74:	b1b78793          	addi	a5,a5,-1253 # 6d305b1b <__global_pointer$+0x6d303c12>
      78:	fef42423          	sw	a5,-24(s0)
  write(2, seq, sizeof(seq));
      7c:	4611                	li	a2,4
      7e:	fe840593          	addi	a1,s0,-24
      82:	4509                	li	a0,2
      84:	00001097          	auipc	ra,0x1
      88:	b28080e7          	jalr	-1240(ra) # bac <write>
}
      8c:	60e2                	ld	ra,24(sp)
      8e:	6442                	ld	s0,16(sp)
      90:	6105                	addi	sp,sp,32
      92:	8082                	ret

0000000000000094 <main>:
    fprintf(2, "Consumer\n");
    color_reset();
  }
}

int main(int argc, char *argv[]) {
      94:	7115                	addi	sp,sp,-224
      96:	ed86                	sd	ra,216(sp)
      98:	e9a2                	sd	s0,208(sp)
      9a:	e5a6                	sd	s1,200(sp)
      9c:	e1ca                	sd	s2,192(sp)
      9e:	fd4e                	sd	s3,184(sp)
      a0:	f952                	sd	s4,176(sp)
      a2:	f556                	sd	s5,168(sp)
      a4:	f15a                	sd	s6,160(sp)
      a6:	ed5e                	sd	s7,152(sp)
      a8:	e962                	sd	s8,144(sp)
      aa:	e566                	sd	s9,136(sp)
      ac:	e16a                	sd	s10,128(sp)
      ae:	fcee                	sd	s11,120(sp)
      b0:	1180                	addi	s0,sp,224
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
      b2:	4a3267b7          	lui	a5,0x4a326
      b6:	b1b78793          	addi	a5,a5,-1253 # 4a325b1b <__global_pointer$+0x4a323c12>
      ba:	f2f42823          	sw	a5,-208(s0)
      be:	6799                	lui	a5,0x6
      c0:	b1b78793          	addi	a5,a5,-1253 # 5b1b <__global_pointer$+0x3c12>
      c4:	f2f41a23          	sh	a5,-204(s0)
      c8:	04800793          	li	a5,72
      cc:	f2f40b23          	sb	a5,-202(s0)
  write(2, seq, sizeof(seq));
      d0:	461d                	li	a2,7
      d2:	f3040493          	addi	s1,s0,-208
      d6:	85a6                	mv	a1,s1
      d8:	4509                	li	a0,2
      da:	00001097          	auipc	ra,0x1
      de:	ad2080e7          	jalr	-1326(ra) # bac <write>
  cls();
  
  color_cyan();
      e2:	00000097          	auipc	ra,0x0
      e6:	f1e080e7          	jalr	-226(ra) # 0 <color_cyan>
  fprintf(2, "+================================================================+\n");
      ea:	00001597          	auipc	a1,0x1
      ee:	1c658593          	addi	a1,a1,454 # 12b0 <malloc+0xec>
      f2:	4509                	li	a0,2
      f4:	00001097          	auipc	ra,0x1
      f8:	fea080e7          	jalr	-22(ra) # 10de <fprintf>
  fprintf(2, "|              IPC Orchestra - Serein OS V3.0                    |\n");
      fc:	00001597          	auipc	a1,0x1
     100:	1fc58593          	addi	a1,a1,508 # 12f8 <malloc+0x134>
     104:	4509                	li	a0,2
     106:	00001097          	auipc	ra,0x1
     10a:	fd8080e7          	jalr	-40(ra) # 10de <fprintf>
  fprintf(2, "|    Producer-Consumer with Shared Memory + Semaphores          |\n");
     10e:	00001597          	auipc	a1,0x1
     112:	23258593          	addi	a1,a1,562 # 1340 <malloc+0x17c>
     116:	4509                	li	a0,2
     118:	00001097          	auipc	ra,0x1
     11c:	fc6080e7          	jalr	-58(ra) # 10de <fprintf>
  fprintf(2, "+================================================================+\n");
     120:	00001597          	auipc	a1,0x1
     124:	19058593          	addi	a1,a1,400 # 12b0 <malloc+0xec>
     128:	4509                	li	a0,2
     12a:	00001097          	auipc	ra,0x1
     12e:	fb4080e7          	jalr	-76(ra) # 10de <fprintf>
  color_reset();
     132:	00000097          	auipc	ra,0x0
     136:	f36080e7          	jalr	-202(ra) # 68 <color_reset>
  
  fprintf(2, "\n");
     13a:	00001597          	auipc	a1,0x1
     13e:	51e58593          	addi	a1,a1,1310 # 1658 <malloc+0x494>
     142:	4509                	li	a0,2
     144:	00001097          	auipc	ra,0x1
     148:	f9a080e7          	jalr	-102(ra) # 10de <fprintf>
  fprintf(2, "  This demo shows IPC mechanisms working together:\n");
     14c:	00001597          	auipc	a1,0x1
     150:	23c58593          	addi	a1,a1,572 # 1388 <malloc+0x1c4>
     154:	4509                	li	a0,2
     156:	00001097          	auipc	ra,0x1
     15a:	f88080e7          	jalr	-120(ra) # 10de <fprintf>
  char seq[] = {0x1b, '[', '3', '3', 'm'};
     15e:	333367b7          	lui	a5,0x33336
     162:	b1b78793          	addi	a5,a5,-1253 # 33335b1b <__global_pointer$+0x33333c12>
     166:	f2f42823          	sw	a5,-208(s0)
     16a:	06d00793          	li	a5,109
     16e:	f2f40a23          	sb	a5,-204(s0)
  write(2, seq, sizeof(seq));
     172:	4615                	li	a2,5
     174:	85a6                	mv	a1,s1
     176:	4509                	li	a0,2
     178:	00001097          	auipc	ra,0x1
     17c:	a34080e7          	jalr	-1484(ra) # bac <write>
  color_yellow();fprintf(2, "    - Shared Memory: ");color_reset();fprintf(2, "Data buffer between processes\n");
     180:	00001597          	auipc	a1,0x1
     184:	24058593          	addi	a1,a1,576 # 13c0 <malloc+0x1fc>
     188:	4509                	li	a0,2
     18a:	00001097          	auipc	ra,0x1
     18e:	f54080e7          	jalr	-172(ra) # 10de <fprintf>
     192:	00000097          	auipc	ra,0x0
     196:	ed6080e7          	jalr	-298(ra) # 68 <color_reset>
     19a:	00001597          	auipc	a1,0x1
     19e:	23e58593          	addi	a1,a1,574 # 13d8 <malloc+0x214>
     1a2:	4509                	li	a0,2
     1a4:	00001097          	auipc	ra,0x1
     1a8:	f3a080e7          	jalr	-198(ra) # 10de <fprintf>
  color_cyan();fprintf(2, "    - Semaphores:    ");color_reset();fprintf(2, "Synchronization (empty/full/mutex)\n");
     1ac:	00000097          	auipc	ra,0x0
     1b0:	e54080e7          	jalr	-428(ra) # 0 <color_cyan>
     1b4:	00001597          	auipc	a1,0x1
     1b8:	24458593          	addi	a1,a1,580 # 13f8 <malloc+0x234>
     1bc:	4509                	li	a0,2
     1be:	00001097          	auipc	ra,0x1
     1c2:	f20080e7          	jalr	-224(ra) # 10de <fprintf>
     1c6:	00000097          	auipc	ra,0x0
     1ca:	ea2080e7          	jalr	-350(ra) # 68 <color_reset>
     1ce:	00001597          	auipc	a1,0x1
     1d2:	24258593          	addi	a1,a1,578 # 1410 <malloc+0x24c>
     1d6:	4509                	li	a0,2
     1d8:	00001097          	auipc	ra,0x1
     1dc:	f06080e7          	jalr	-250(ra) # 10de <fprintf>
  color_green();fprintf(2, "    - Pipes:         ");color_reset();fprintf(2, "Status reporting\n");
     1e0:	00000097          	auipc	ra,0x0
     1e4:	e54080e7          	jalr	-428(ra) # 34 <color_green>
     1e8:	00001597          	auipc	a1,0x1
     1ec:	25058593          	addi	a1,a1,592 # 1438 <malloc+0x274>
     1f0:	4509                	li	a0,2
     1f2:	00001097          	auipc	ra,0x1
     1f6:	eec080e7          	jalr	-276(ra) # 10de <fprintf>
     1fa:	00000097          	auipc	ra,0x0
     1fe:	e6e080e7          	jalr	-402(ra) # 68 <color_reset>
     202:	00001597          	auipc	a1,0x1
     206:	24e58593          	addi	a1,a1,590 # 1450 <malloc+0x28c>
     20a:	4509                	li	a0,2
     20c:	00001097          	auipc	ra,0x1
     210:	ed2080e7          	jalr	-302(ra) # 10de <fprintf>
  fprintf(2, "\n");
     214:	00001597          	auipc	a1,0x1
     218:	44458593          	addi	a1,a1,1092 # 1658 <malloc+0x494>
     21c:	4509                	li	a0,2
     21e:	00001097          	auipc	ra,0x1
     222:	ec0080e7          	jalr	-320(ra) # 10de <fprintf>
  fprintf(2, "  Starting in 2 seconds... (Press Ctrl+C to exit)\n\n");
     226:	00001597          	auipc	a1,0x1
     22a:	24258593          	addi	a1,a1,578 # 1468 <malloc+0x2a4>
     22e:	4509                	li	a0,2
     230:	00001097          	auipc	ra,0x1
     234:	eae080e7          	jalr	-338(ra) # 10de <fprintf>
  sleep(200);
     238:	0c800513          	li	a0,200
     23c:	00001097          	auipc	ra,0x1
     240:	9c8080e7          	jalr	-1592(ra) # c04 <sleep>
  
  // 创建信号量
  sem_empty = sem_open(BUFFER_SIZE);  // 初始有 BUFFER_SIZE 个空槽
     244:	4521                	li	a0,8
     246:	00001097          	auipc	ra,0x1
     24a:	a0e080e7          	jalr	-1522(ra) # c54 <sem_open>
     24e:	00001497          	auipc	s1,0x1
     252:	4c248493          	addi	s1,s1,1218 # 1710 <sem_empty>
     256:	c088                	sw	a0,0(s1)
  sem_full = sem_open(0);             // 初始没有满槽
     258:	4501                	li	a0,0
     25a:	00001097          	auipc	ra,0x1
     25e:	9fa080e7          	jalr	-1542(ra) # c54 <sem_open>
     262:	c0c8                	sw	a0,4(s1)
  sem_mutex = sem_open(1);            // 互斥锁
     264:	4505                	li	a0,1
     266:	00001097          	auipc	ra,0x1
     26a:	9ee080e7          	jalr	-1554(ra) # c54 <sem_open>
     26e:	c488                	sw	a0,8(s1)
  
  if(sem_empty < 0 || sem_full < 0 || sem_mutex < 0) {
     270:	409c                	lw	a5,0(s1)
     272:	40d8                	lw	a4,4(s1)
     274:	8fd9                	or	a5,a5,a4
     276:	8d5d                	or	a0,a0,a5
     278:	2501                	sext.w	a0,a0
     27a:	0c054a63          	bltz	a0,34e <main+0x2ba>
    fprintf(2, "ipcband: sem_open failed\n");
    exit(1);
  }
  
  // 创建共享内存
  shm_id = shmcreate("ipcband_shm", sizeof(struct shared_data));
     27e:	03400593          	li	a1,52
     282:	00001517          	auipc	a0,0x1
     286:	23e50513          	addi	a0,a0,574 # 14c0 <malloc+0x2fc>
     28a:	00001097          	auipc	ra,0x1
     28e:	a10080e7          	jalr	-1520(ra) # c9a <shmcreate>
     292:	00001797          	auipc	a5,0x1
     296:	48a7a523          	sw	a0,1162(a5) # 171c <shm_id>
  if(shm_id < 0) {
     29a:	0c054863          	bltz	a0,36a <main+0x2d6>
    fprintf(2, "ipcband: shmcreate failed\n");
    exit(1);
  }
  
  shm_addr = shmattach(shm_id);
     29e:	00001097          	auipc	ra,0x1
     2a2:	a10080e7          	jalr	-1520(ra) # cae <shmattach>
     2a6:	00001797          	auipc	a5,0x1
     2aa:	46a7bd23          	sd	a0,1146(a5) # 1720 <shm_addr>
  if(shm_addr == 0) {
     2ae:	cd61                	beqz	a0,386 <main+0x2f2>
    fprintf(2, "ipcband: shmattach failed\n");
    exit(1);
  }
  shm = (struct shared_data *)shm_addr;
     2b0:	00001797          	auipc	a5,0x1
     2b4:	46a7bc23          	sd	a0,1144(a5) # 1728 <shm>
  
  // 初始化共享数据
  shm->producer_count = 0;
     2b8:	00052023          	sw	zero,0(a0)
  shm->consumer_count = 0;
     2bc:	00052223          	sw	zero,4(a0)
  shm->head = 0;
     2c0:	02052423          	sw	zero,40(a0)
  shm->tail = 0;
     2c4:	02052623          	sw	zero,44(a0)
  shm->done = 0;
     2c8:	02052823          	sw	zero,48(a0)
  for(int i = 0; i < BUFFER_SIZE; i++) {
    shm->buffer[i] = 0;
     2cc:	00052423          	sw	zero,8(a0)
     2d0:	00052623          	sw	zero,12(a0)
     2d4:	00052823          	sw	zero,16(a0)
     2d8:	00052a23          	sw	zero,20(a0)
     2dc:	00052c23          	sw	zero,24(a0)
     2e0:	00052e23          	sw	zero,28(a0)
     2e4:	02052023          	sw	zero,32(a0)
     2e8:	02052223          	sw	zero,36(a0)
  }
  
  // 创建报告管道
  if(pipe(report_pipe) < 0) {
     2ec:	00001517          	auipc	a0,0x1
     2f0:	44450513          	addi	a0,a0,1092 # 1730 <report_pipe>
     2f4:	00001097          	auipc	ra,0x1
     2f8:	8a8080e7          	jalr	-1880(ra) # b9c <pipe>
     2fc:	0a054363          	bltz	a0,3a2 <main+0x30e>
    fprintf(2, "ipcband: pipe failed\n");
    exit(1);
  }
  
  // 启动生产者
  int producer_pid = fork();
     300:	00001097          	auipc	ra,0x1
     304:	884080e7          	jalr	-1916(ra) # b84 <fork>
     308:	84aa                	mv	s1,a0
  if(producer_pid == 0) {
     30a:	18051e63          	bnez	a0,4a6 <main+0x412>
    close(report_pipe[0]);
     30e:	00001497          	auipc	s1,0x1
     312:	40248493          	addi	s1,s1,1026 # 1710 <sem_empty>
     316:	5088                	lw	a0,32(s1)
     318:	00001097          	auipc	ra,0x1
     31c:	89c080e7          	jalr	-1892(ra) # bb4 <close>
    // 子进程需要重新 attach 共享内存
    shm_addr = shmattach(shm_id);
     320:	44c8                	lw	a0,12(s1)
     322:	00001097          	auipc	ra,0x1
     326:	98c080e7          	jalr	-1652(ra) # cae <shmattach>
     32a:	e888                	sd	a0,16(s1)
    shm = (struct shared_data *)shm_addr;
     32c:	ec88                	sd	a0,24(s1)
  for(int i = 1; i <= NUM_ITEMS; i++) {
     32e:	4485                	li	s1,1
    sem_wait(sem_empty);
     330:	00001917          	auipc	s2,0x1
     334:	3e090913          	addi	s2,s2,992 # 1710 <sem_empty>
    shm->head = (shm->head + 1) % BUFFER_SIZE;
     338:	4ca1                	li	s9,8
    msg[len++] = 'P';
     33a:	05000c13          	li	s8,80
    msg[len++] = ':';
     33e:	03a00b93          	li	s7,58
    if(i >= 10) msg[len++] = '0' + (i / 10);
     342:	4b25                	li	s6,9
    msg[len++] = ':';
     344:	4a89                	li	s5,2
    if(i >= 10) msg[len++] = '0' + (i / 10);
     346:	49a9                	li	s3,10
    write(report_pipe[1], msg, len);
     348:	f3040a13          	addi	s4,s0,-208
     34c:	a0e1                	j	414 <main+0x380>
    fprintf(2, "ipcband: sem_open failed\n");
     34e:	00001597          	auipc	a1,0x1
     352:	15258593          	addi	a1,a1,338 # 14a0 <malloc+0x2dc>
     356:	4509                	li	a0,2
     358:	00001097          	auipc	ra,0x1
     35c:	d86080e7          	jalr	-634(ra) # 10de <fprintf>
    exit(1);
     360:	4505                	li	a0,1
     362:	00001097          	auipc	ra,0x1
     366:	82a080e7          	jalr	-2006(ra) # b8c <exit>
    fprintf(2, "ipcband: shmcreate failed\n");
     36a:	00001597          	auipc	a1,0x1
     36e:	16658593          	addi	a1,a1,358 # 14d0 <malloc+0x30c>
     372:	4509                	li	a0,2
     374:	00001097          	auipc	ra,0x1
     378:	d6a080e7          	jalr	-662(ra) # 10de <fprintf>
    exit(1);
     37c:	4505                	li	a0,1
     37e:	00001097          	auipc	ra,0x1
     382:	80e080e7          	jalr	-2034(ra) # b8c <exit>
    fprintf(2, "ipcband: shmattach failed\n");
     386:	00001597          	auipc	a1,0x1
     38a:	16a58593          	addi	a1,a1,362 # 14f0 <malloc+0x32c>
     38e:	4509                	li	a0,2
     390:	00001097          	auipc	ra,0x1
     394:	d4e080e7          	jalr	-690(ra) # 10de <fprintf>
    exit(1);
     398:	4505                	li	a0,1
     39a:	00000097          	auipc	ra,0x0
     39e:	7f2080e7          	jalr	2034(ra) # b8c <exit>
    fprintf(2, "ipcband: pipe failed\n");
     3a2:	00001597          	auipc	a1,0x1
     3a6:	16e58593          	addi	a1,a1,366 # 1510 <malloc+0x34c>
     3aa:	4509                	li	a0,2
     3ac:	00001097          	auipc	ra,0x1
     3b0:	d32080e7          	jalr	-718(ra) # 10de <fprintf>
    exit(1);
     3b4:	4505                	li	a0,1
     3b6:	00000097          	auipc	ra,0x0
     3ba:	7d6080e7          	jalr	2006(ra) # b8c <exit>
    msg[len++] = '0' + (i % 10);
     3be:	f9060793          	addi	a5,a2,-112
     3c2:	00878733          	add	a4,a5,s0
     3c6:	0334e7bb          	remw	a5,s1,s3
     3ca:	0307879b          	addiw	a5,a5,48
     3ce:	faf70023          	sb	a5,-96(a4)
    msg[len++] = '\n';
     3d2:	87ba                	mv	a5,a4
     3d4:	4729                	li	a4,10
     3d6:	fae780a3          	sb	a4,-95(a5)
    write(report_pipe[1], msg, len);
     3da:	0609                	addi	a2,a2,2
     3dc:	85d2                	mv	a1,s4
     3de:	02492503          	lw	a0,36(s2)
     3e2:	00000097          	auipc	ra,0x0
     3e6:	7ca080e7          	jalr	1994(ra) # bac <write>
    sem_post(sem_mutex);
     3ea:	00892503          	lw	a0,8(s2)
     3ee:	00001097          	auipc	ra,0x1
     3f2:	876080e7          	jalr	-1930(ra) # c64 <sem_post>
    sem_post(sem_full);
     3f6:	00492503          	lw	a0,4(s2)
     3fa:	00001097          	auipc	ra,0x1
     3fe:	86a080e7          	jalr	-1942(ra) # c64 <sem_post>
    sleep(30);  // 生产间隔
     402:	4579                	li	a0,30
     404:	00001097          	auipc	ra,0x1
     408:	800080e7          	jalr	-2048(ra) # c04 <sleep>
  for(int i = 1; i <= NUM_ITEMS; i++) {
     40c:	2485                	addiw	s1,s1,1
     40e:	47d5                	li	a5,21
     410:	04f48b63          	beq	s1,a5,466 <main+0x3d2>
    sem_wait(sem_empty);
     414:	00092503          	lw	a0,0(s2)
     418:	00001097          	auipc	ra,0x1
     41c:	844080e7          	jalr	-1980(ra) # c5c <sem_wait>
    sem_wait(sem_mutex);
     420:	00892503          	lw	a0,8(s2)
     424:	00001097          	auipc	ra,0x1
     428:	838080e7          	jalr	-1992(ra) # c5c <sem_wait>
    shm->buffer[shm->head] = i;
     42c:	01893703          	ld	a4,24(s2)
     430:	571c                	lw	a5,40(a4)
     432:	00279693          	slli	a3,a5,0x2
     436:	96ba                	add	a3,a3,a4
     438:	c684                	sw	s1,8(a3)
    shm->head = (shm->head + 1) % BUFFER_SIZE;
     43a:	2785                	addiw	a5,a5,1
     43c:	0397e7bb          	remw	a5,a5,s9
     440:	d71c                	sw	a5,40(a4)
    shm->producer_count++;
     442:	431c                	lw	a5,0(a4)
     444:	2785                	addiw	a5,a5,1
     446:	c31c                	sw	a5,0(a4)
    msg[len++] = 'P';
     448:	f3840823          	sb	s8,-208(s0)
    msg[len++] = ':';
     44c:	f37408a3          	sb	s7,-207(s0)
     450:	8656                	mv	a2,s5
    if(i >= 10) msg[len++] = '0' + (i / 10);
     452:	f69b56e3          	bge	s6,s1,3be <main+0x32a>
     456:	0334c7bb          	divw	a5,s1,s3
     45a:	0307879b          	addiw	a5,a5,48
     45e:	f2f40923          	sb	a5,-206(s0)
     462:	460d                	li	a2,3
     464:	bfa9                	j	3be <main+0x32a>
  sem_wait(sem_mutex);
     466:	00001497          	auipc	s1,0x1
     46a:	2aa48493          	addi	s1,s1,682 # 1710 <sem_empty>
     46e:	4488                	lw	a0,8(s1)
     470:	00000097          	auipc	ra,0x0
     474:	7ec080e7          	jalr	2028(ra) # c5c <sem_wait>
  shm->done = 1;
     478:	6c9c                	ld	a5,24(s1)
     47a:	4705                	li	a4,1
     47c:	db98                	sw	a4,48(a5)
  sem_post(sem_mutex);
     47e:	4488                	lw	a0,8(s1)
     480:	00000097          	auipc	ra,0x0
     484:	7e4080e7          	jalr	2020(ra) # c64 <sem_post>
  sem_post(sem_full);  // 唤醒可能在等待的消费者
     488:	40c8                	lw	a0,4(s1)
     48a:	00000097          	auipc	ra,0x0
     48e:	7da080e7          	jalr	2010(ra) # c64 <sem_post>
  close(report_pipe[1]);
     492:	50c8                	lw	a0,36(s1)
     494:	00000097          	auipc	ra,0x0
     498:	720080e7          	jalr	1824(ra) # bb4 <close>
  exit(0);
     49c:	4501                	li	a0,0
     49e:	00000097          	auipc	ra,0x0
     4a2:	6ee080e7          	jalr	1774(ra) # b8c <exit>
    producer_process();
  }
  
  // 启动消费者
  int consumer_pid = fork();
     4a6:	00000097          	auipc	ra,0x0
     4aa:	6de080e7          	jalr	1758(ra) # b84 <fork>
     4ae:	892a                	mv	s2,a0
  if(consumer_pid == 0) {
     4b0:	10051163          	bnez	a0,5b2 <main+0x51e>
    close(report_pipe[0]);
     4b4:	00001497          	auipc	s1,0x1
     4b8:	25c48493          	addi	s1,s1,604 # 1710 <sem_empty>
     4bc:	5088                	lw	a0,32(s1)
     4be:	00000097          	auipc	ra,0x0
     4c2:	6f6080e7          	jalr	1782(ra) # bb4 <close>
    // 子进程需要重新 attach 共享内存
    shm_addr = shmattach(shm_id);
     4c6:	44c8                	lw	a0,12(s1)
     4c8:	00000097          	auipc	ra,0x0
     4cc:	7e6080e7          	jalr	2022(ra) # cae <shmattach>
     4d0:	e888                	sd	a0,16(s1)
    shm = (struct shared_data *)shm_addr;
     4d2:	ec88                	sd	a0,24(s1)
    shm->tail = (shm->tail + 1) % BUFFER_SIZE;
     4d4:	4c21                	li	s8,8
    msg[len++] = 'C';
     4d6:	04300b93          	li	s7,67
    msg[len++] = ':';
     4da:	03a00b13          	li	s6,58
    if(data >= 10) msg[len++] = '0' + (data / 10);
     4de:	4aa5                	li	s5,9
    msg[len++] = ':';
     4e0:	4a09                	li	s4,2
    if(data >= 10) msg[len++] = '0' + (data / 10);
     4e2:	4929                	li	s2,10
    write(report_pipe[1], msg, len);
     4e4:	f3040993          	addi	s3,s0,-208
     4e8:	a049                	j	56a <main+0x4d6>
    int data = shm->buffer[shm->tail];
     4ea:	57d4                	lw	a3,44(a5)
     4ec:	00269713          	slli	a4,a3,0x2
     4f0:	973e                	add	a4,a4,a5
     4f2:	4718                	lw	a4,8(a4)
    shm->tail = (shm->tail + 1) % BUFFER_SIZE;
     4f4:	2685                	addiw	a3,a3,1
     4f6:	0386e6bb          	remw	a3,a3,s8
     4fa:	d7d4                	sw	a3,44(a5)
    shm->consumer_count++;
     4fc:	43d4                	lw	a3,4(a5)
     4fe:	2685                	addiw	a3,a3,1
     500:	c3d4                	sw	a3,4(a5)
    msg[len++] = 'C';
     502:	f3740823          	sb	s7,-208(s0)
    msg[len++] = ':';
     506:	f36408a3          	sb	s6,-207(s0)
     50a:	8652                	mv	a2,s4
    if(data >= 10) msg[len++] = '0' + (data / 10);
     50c:	00ead963          	bge	s5,a4,51e <main+0x48a>
     510:	032747bb          	divw	a5,a4,s2
     514:	0307879b          	addiw	a5,a5,48
     518:	f2f40923          	sb	a5,-206(s0)
     51c:	460d                	li	a2,3
    msg[len++] = '0' + (data % 10);
     51e:	f9060793          	addi	a5,a2,-112
     522:	97a2                	add	a5,a5,s0
     524:	0327673b          	remw	a4,a4,s2
     528:	0307071b          	addiw	a4,a4,48
     52c:	fae78023          	sb	a4,-96(a5)
    msg[len++] = '\n';
     530:	f9060793          	addi	a5,a2,-112
     534:	97a2                	add	a5,a5,s0
     536:	4729                	li	a4,10
     538:	fae780a3          	sb	a4,-95(a5)
    write(report_pipe[1], msg, len);
     53c:	0609                	addi	a2,a2,2
     53e:	85ce                	mv	a1,s3
     540:	50c8                	lw	a0,36(s1)
     542:	00000097          	auipc	ra,0x0
     546:	66a080e7          	jalr	1642(ra) # bac <write>
    sem_post(sem_mutex);
     54a:	4488                	lw	a0,8(s1)
     54c:	00000097          	auipc	ra,0x0
     550:	718080e7          	jalr	1816(ra) # c64 <sem_post>
    sem_post(sem_empty);
     554:	4088                	lw	a0,0(s1)
     556:	00000097          	auipc	ra,0x0
     55a:	70e080e7          	jalr	1806(ra) # c64 <sem_post>
    sleep(50);  // 消费间隔（比生产慢，测试缓冲）
     55e:	03200513          	li	a0,50
     562:	00000097          	auipc	ra,0x0
     566:	6a2080e7          	jalr	1698(ra) # c04 <sleep>
    sem_wait(sem_full);
     56a:	40c8                	lw	a0,4(s1)
     56c:	00000097          	auipc	ra,0x0
     570:	6f0080e7          	jalr	1776(ra) # c5c <sem_wait>
    sem_wait(sem_mutex);
     574:	4488                	lw	a0,8(s1)
     576:	00000097          	auipc	ra,0x0
     57a:	6e6080e7          	jalr	1766(ra) # c5c <sem_wait>
    if(shm->done && shm->head == shm->tail) {
     57e:	6c9c                	ld	a5,24(s1)
     580:	5b98                	lw	a4,48(a5)
     582:	d725                	beqz	a4,4ea <main+0x456>
     584:	5794                	lw	a3,40(a5)
     586:	57d8                	lw	a4,44(a5)
     588:	f6e691e3          	bne	a3,a4,4ea <main+0x456>
      sem_post(sem_mutex);
     58c:	00001497          	auipc	s1,0x1
     590:	18448493          	addi	s1,s1,388 # 1710 <sem_empty>
     594:	4488                	lw	a0,8(s1)
     596:	00000097          	auipc	ra,0x0
     59a:	6ce080e7          	jalr	1742(ra) # c64 <sem_post>
  close(report_pipe[1]);
     59e:	50c8                	lw	a0,36(s1)
     5a0:	00000097          	auipc	ra,0x0
     5a4:	614080e7          	jalr	1556(ra) # bb4 <close>
  exit(0);
     5a8:	4501                	li	a0,0
     5aa:	00000097          	auipc	ra,0x0
     5ae:	5e2080e7          	jalr	1506(ra) # b8c <exit>
    consumer_process();
  }
  
  // 父进程：关闭写端，监控状态
  close(report_pipe[1]);
     5b2:	00001517          	auipc	a0,0x1
     5b6:	18252503          	lw	a0,386(a0) # 1734 <report_pipe+0x4>
     5ba:	00000097          	auipc	ra,0x0
     5be:	5fa080e7          	jalr	1530(ra) # bb4 <close>
  
  fprintf(2, "  Producer (%d) and Consumer (%d) started!\n\n", 
     5c2:	86ca                	mv	a3,s2
     5c4:	8626                	mv	a2,s1
     5c6:	00001597          	auipc	a1,0x1
     5ca:	f6258593          	addi	a1,a1,-158 # 1528 <malloc+0x364>
     5ce:	4509                	li	a0,2
     5d0:	00001097          	auipc	ra,0x1
     5d4:	b0e080e7          	jalr	-1266(ra) # 10de <fprintf>
          producer_pid, consumer_pid);
  
  // 监控循环
  char buf[64];
  int events = 0;
     5d8:	4b81                	li	s7,0
  
  while(1) {
    int n = read(report_pipe[0], buf, sizeof(buf) - 1);
     5da:	f5040c93          	addi	s9,s0,-176
     5de:	00001b17          	auipc	s6,0x1
     5e2:	132b0b13          	addi	s6,s6,306 # 1710 <sem_empty>
     5e6:	f5340d13          	addi	s10,s0,-173
  char seq[] = {0x1b, '[', '3', '3', 'm'};
     5ea:	333367b7          	lui	a5,0x33336
     5ee:	b1b78793          	addi	a5,a5,-1253 # 33335b1b <__global_pointer$+0x33333c12>
     5f2:	f2f43423          	sd	a5,-216(s0)
  write(2, seq, sizeof(seq));
     5f6:	f3040d93          	addi	s11,s0,-208
      fprintf(2, ".");
     5fa:	00001a97          	auipc	s5,0x1
     5fe:	fcea8a93          	addi	s5,s5,-50 # 15c8 <malloc+0x404>
      fprintf(2, "#");
     602:	00001c17          	auipc	s8,0x1
     606:	fbec0c13          	addi	s8,s8,-66 # 15c0 <malloc+0x3fc>
     60a:	a8e5                	j	702 <main+0x66e>
    
    buf[n] = 0;
    
    // 解析事件
    char type = buf[0];
    int data = 0;
     60c:	4901                	li	s2,0
     60e:	aaa9                	j	768 <main+0x6d4>
  char seq[] = {0x1b, '[', '3', '3', 'm'};
     610:	f2843783          	ld	a5,-216(s0)
     614:	f2f42823          	sw	a5,-208(s0)
     618:	06d00793          	li	a5,109
     61c:	f2f40a23          	sb	a5,-204(s0)
  write(2, seq, sizeof(seq));
     620:	4615                	li	a2,5
     622:	85ee                	mv	a1,s11
     624:	4509                	li	a0,2
     626:	00000097          	auipc	ra,0x0
     62a:	586080e7          	jalr	1414(ra) # bac <write>
    fprintf(2, "  Producer ");
     62e:	00001597          	auipc	a1,0x1
     632:	f3a58593          	addi	a1,a1,-198 # 1568 <malloc+0x3a4>
     636:	4509                	li	a0,2
     638:	00001097          	auipc	ra,0x1
     63c:	aa6080e7          	jalr	-1370(ra) # 10de <fprintf>
    color_reset();
     640:	00000097          	auipc	ra,0x0
     644:	a28080e7          	jalr	-1496(ra) # 68 <color_reset>
    fprintf(2, "---[%d]---> ", data);
     648:	864a                	mv	a2,s2
     64a:	00001597          	auipc	a1,0x1
     64e:	f2e58593          	addi	a1,a1,-210 # 1578 <malloc+0x3b4>
     652:	4509                	li	a0,2
     654:	00001097          	auipc	ra,0x1
     658:	a8a080e7          	jalr	-1398(ra) # 10de <fprintf>
    color_green();
     65c:	00000097          	auipc	ra,0x0
     660:	9d8080e7          	jalr	-1576(ra) # 34 <color_green>
    fprintf(2, "Buffer\n");
     664:	00001597          	auipc	a1,0x1
     668:	f2458593          	addi	a1,a1,-220 # 1588 <malloc+0x3c4>
     66c:	4509                	li	a0,2
     66e:	00001097          	auipc	ra,0x1
     672:	a70080e7          	jalr	-1424(ra) # 10de <fprintf>
    color_reset();
     676:	00000097          	auipc	ra,0x0
     67a:	9f2080e7          	jalr	-1550(ra) # 68 <color_reset>
     67e:	a285                	j	7de <main+0x74a>
    } else if(head < tail) {
     680:	0129d663          	bge	s3,s2,68c <main+0x5f8>
      slot_has_data = (i >= tail || i < head);
     684:	0324d363          	bge	s1,s2,6aa <main+0x616>
     688:	0334c163          	blt	s1,s3,6aa <main+0x616>
      fprintf(2, ".");
     68c:	85d6                	mv	a1,s5
     68e:	4509                	li	a0,2
     690:	00001097          	auipc	ra,0x1
     694:	a4e080e7          	jalr	-1458(ra) # 10de <fprintf>
  for(int i = 0; i < BUFFER_SIZE; i++) {
     698:	2485                	addiw	s1,s1,1
     69a:	03448763          	beq	s1,s4,6c8 <main+0x634>
    if(head > tail) {
     69e:	ff3951e3          	bge	s2,s3,680 <main+0x5ec>
      slot_has_data = (i >= tail && i < head);
     6a2:	ff24c5e3          	blt	s1,s2,68c <main+0x5f8>
     6a6:	ff34d3e3          	bge	s1,s3,68c <main+0x5f8>
      color_green();
     6aa:	00000097          	auipc	ra,0x0
     6ae:	98a080e7          	jalr	-1654(ra) # 34 <color_green>
      fprintf(2, "#");
     6b2:	85e2                	mv	a1,s8
     6b4:	4509                	li	a0,2
     6b6:	00001097          	auipc	ra,0x1
     6ba:	a28080e7          	jalr	-1496(ra) # 10de <fprintf>
      color_reset();
     6be:	00000097          	auipc	ra,0x0
     6c2:	9aa080e7          	jalr	-1622(ra) # 68 <color_reset>
     6c6:	bfc9                	j	698 <main+0x604>
  fprintf(2, "]  head=%d tail=%d\n", head, tail);
     6c8:	86ca                	mv	a3,s2
     6ca:	864e                	mv	a2,s3
     6cc:	00001597          	auipc	a1,0x1
     6d0:	f0458593          	addi	a1,a1,-252 # 15d0 <malloc+0x40c>
     6d4:	4509                	li	a0,2
     6d6:	00001097          	auipc	ra,0x1
     6da:	a08080e7          	jalr	-1528(ra) # 10de <fprintf>
    // 显示状态
    fprintf(2, "  Event %d: ", events);
    print_data_flow(type, data);
    print_buffer_status(shm->head, shm->tail, shm->buffer);
    fprintf(2, "  Produced: %d  Consumed: %d\n\n", 
            shm->producer_count, shm->consumer_count);
     6de:	018b3783          	ld	a5,24(s6)
    fprintf(2, "  Produced: %d  Consumed: %d\n\n", 
     6e2:	43d4                	lw	a3,4(a5)
     6e4:	4390                	lw	a2,0(a5)
     6e6:	00001597          	auipc	a1,0x1
     6ea:	f0258593          	addi	a1,a1,-254 # 15e8 <malloc+0x424>
     6ee:	4509                	li	a0,2
     6f0:	00001097          	auipc	ra,0x1
     6f4:	9ee080e7          	jalr	-1554(ra) # 10de <fprintf>
    
    sleep(10);
     6f8:	4529                	li	a0,10
     6fa:	00000097          	auipc	ra,0x0
     6fe:	50a080e7          	jalr	1290(ra) # c04 <sleep>
    int n = read(report_pipe[0], buf, sizeof(buf) - 1);
     702:	03f00613          	li	a2,63
     706:	85e6                	mv	a1,s9
     708:	020b2503          	lw	a0,32(s6)
     70c:	00000097          	auipc	ra,0x0
     710:	498080e7          	jalr	1176(ra) # ba4 <read>
    if(n <= 0) break;
     714:	0ea05763          	blez	a0,802 <main+0x76e>
    buf[n] = 0;
     718:	f9050793          	addi	a5,a0,-112
     71c:	97a2                	add	a5,a5,s0
     71e:	fc078023          	sb	zero,-64(a5)
    char type = buf[0];
     722:	f5044483          	lbu	s1,-176(s0)
    for(int i = 2; i < n && buf[i] >= '0' && buf[i] <= '9'; i++) {
     726:	4789                	li	a5,2
     728:	eea7d2e3          	bge	a5,a0,60c <main+0x578>
     72c:	f5240693          	addi	a3,s0,-174
     730:	ffd5061b          	addiw	a2,a0,-3
     734:	1602                	slli	a2,a2,0x20
     736:	9201                	srli	a2,a2,0x20
     738:	966a                	add	a2,a2,s10
    int data = 0;
     73a:	4901                	li	s2,0
    for(int i = 2; i < n && buf[i] >= '0' && buf[i] <= '9'; i++) {
     73c:	45a5                	li	a1,9
     73e:	0006c703          	lbu	a4,0(a3)
     742:	fd07079b          	addiw	a5,a4,-48
     746:	0ff7f793          	zext.b	a5,a5
     74a:	00f5ef63          	bltu	a1,a5,768 <main+0x6d4>
      data = data * 10 + (buf[i] - '0');
     74e:	0029179b          	slliw	a5,s2,0x2
     752:	012787bb          	addw	a5,a5,s2
     756:	0017979b          	slliw	a5,a5,0x1
     75a:	fd07071b          	addiw	a4,a4,-48
     75e:	00f7093b          	addw	s2,a4,a5
    for(int i = 2; i < n && buf[i] >= '0' && buf[i] <= '9'; i++) {
     762:	0685                	addi	a3,a3,1
     764:	fcc69de3          	bne	a3,a2,73e <main+0x6aa>
    events++;
     768:	2b85                	addiw	s7,s7,1
    fprintf(2, "  Event %d: ", events);
     76a:	865e                	mv	a2,s7
     76c:	00001597          	auipc	a1,0x1
     770:	dec58593          	addi	a1,a1,-532 # 1558 <malloc+0x394>
     774:	4509                	li	a0,2
     776:	00001097          	auipc	ra,0x1
     77a:	968080e7          	jalr	-1688(ra) # 10de <fprintf>
  if(type == 'P') {
     77e:	05000793          	li	a5,80
     782:	e8f487e3          	beq	s1,a5,610 <main+0x57c>
    color_green();
     786:	00000097          	auipc	ra,0x0
     78a:	8ae080e7          	jalr	-1874(ra) # 34 <color_green>
    fprintf(2, "  Buffer ");
     78e:	00001597          	auipc	a1,0x1
     792:	e0258593          	addi	a1,a1,-510 # 1590 <malloc+0x3cc>
     796:	4509                	li	a0,2
     798:	00001097          	auipc	ra,0x1
     79c:	946080e7          	jalr	-1722(ra) # 10de <fprintf>
    color_reset();
     7a0:	00000097          	auipc	ra,0x0
     7a4:	8c8080e7          	jalr	-1848(ra) # 68 <color_reset>
    fprintf(2, "---[%d]---> ", data);
     7a8:	864a                	mv	a2,s2
     7aa:	00001597          	auipc	a1,0x1
     7ae:	dce58593          	addi	a1,a1,-562 # 1578 <malloc+0x3b4>
     7b2:	4509                	li	a0,2
     7b4:	00001097          	auipc	ra,0x1
     7b8:	92a080e7          	jalr	-1750(ra) # 10de <fprintf>
    color_cyan();
     7bc:	00000097          	auipc	ra,0x0
     7c0:	844080e7          	jalr	-1980(ra) # 0 <color_cyan>
    fprintf(2, "Consumer\n");
     7c4:	00001597          	auipc	a1,0x1
     7c8:	ddc58593          	addi	a1,a1,-548 # 15a0 <malloc+0x3dc>
     7cc:	4509                	li	a0,2
     7ce:	00001097          	auipc	ra,0x1
     7d2:	910080e7          	jalr	-1776(ra) # 10de <fprintf>
    color_reset();
     7d6:	00000097          	auipc	ra,0x0
     7da:	892080e7          	jalr	-1902(ra) # 68 <color_reset>
    print_buffer_status(shm->head, shm->tail, shm->buffer);
     7de:	018b3783          	ld	a5,24(s6)
     7e2:	0287a983          	lw	s3,40(a5)
     7e6:	02c7a903          	lw	s2,44(a5)
  fprintf(2, "  Buffer: [");
     7ea:	00001597          	auipc	a1,0x1
     7ee:	dc658593          	addi	a1,a1,-570 # 15b0 <malloc+0x3ec>
     7f2:	4509                	li	a0,2
     7f4:	00001097          	auipc	ra,0x1
     7f8:	8ea080e7          	jalr	-1814(ra) # 10de <fprintf>
  for(int i = 0; i < BUFFER_SIZE; i++) {
     7fc:	4481                	li	s1,0
     7fe:	4a21                	li	s4,8
     800:	bd79                	j	69e <main+0x60a>
  }
  
  // 等待子进程
  wait(0);
     802:	4501                	li	a0,0
     804:	00000097          	auipc	ra,0x0
     808:	390080e7          	jalr	912(ra) # b94 <wait>
  wait(0);
     80c:	4501                	li	a0,0
     80e:	00000097          	auipc	ra,0x0
     812:	386080e7          	jalr	902(ra) # b94 <wait>
  
  // 保存统计信息（在 detach 前）
  int final_produced = shm->producer_count;
     816:	00001497          	auipc	s1,0x1
     81a:	efa48493          	addi	s1,s1,-262 # 1710 <sem_empty>
     81e:	6c9c                	ld	a5,24(s1)
     820:	0007a903          	lw	s2,0(a5)
  int final_consumed = shm->consumer_count;
     824:	0047a983          	lw	s3,4(a5)
  
  // 清理
  close(report_pipe[0]);
     828:	5088                	lw	a0,32(s1)
     82a:	00000097          	auipc	ra,0x0
     82e:	38a080e7          	jalr	906(ra) # bb4 <close>
  shmdetach(shm_addr, sizeof(struct shared_data));
     832:	03400593          	li	a1,52
     836:	6888                	ld	a0,16(s1)
     838:	00000097          	auipc	ra,0x0
     83c:	480080e7          	jalr	1152(ra) # cb8 <shmdetach>
  shmunlink("ipcband_shm");
     840:	00001517          	auipc	a0,0x1
     844:	c8050513          	addi	a0,a0,-896 # 14c0 <malloc+0x2fc>
     848:	00000097          	auipc	ra,0x0
     84c:	47a080e7          	jalr	1146(ra) # cc2 <shmunlink>
  sem_close(sem_empty);
     850:	4088                	lw	a0,0(s1)
     852:	00000097          	auipc	ra,0x0
     856:	41a080e7          	jalr	1050(ra) # c6c <sem_close>
  sem_close(sem_full);
     85a:	40c8                	lw	a0,4(s1)
     85c:	00000097          	auipc	ra,0x0
     860:	410080e7          	jalr	1040(ra) # c6c <sem_close>
  sem_close(sem_mutex);
     864:	4488                	lw	a0,8(s1)
     866:	00000097          	auipc	ra,0x0
     86a:	406080e7          	jalr	1030(ra) # c6c <sem_close>
  
  fprintf(2, "\n");
     86e:	00001597          	auipc	a1,0x1
     872:	dea58593          	addi	a1,a1,-534 # 1658 <malloc+0x494>
     876:	4509                	li	a0,2
     878:	00001097          	auipc	ra,0x1
     87c:	866080e7          	jalr	-1946(ra) # 10de <fprintf>
  color_green();
     880:	fffff097          	auipc	ra,0xfffff
     884:	7b4080e7          	jalr	1972(ra) # 34 <color_green>
  fprintf(2, "  === IPC Orchestra Complete! ===\n");
     888:	00001597          	auipc	a1,0x1
     88c:	d8058593          	addi	a1,a1,-640 # 1608 <malloc+0x444>
     890:	4509                	li	a0,2
     892:	00001097          	auipc	ra,0x1
     896:	84c080e7          	jalr	-1972(ra) # 10de <fprintf>
  color_reset();
     89a:	fffff097          	auipc	ra,0xfffff
     89e:	7ce080e7          	jalr	1998(ra) # 68 <color_reset>
  fprintf(2, "  Total produced: %d  Total consumed: %d\n", 
     8a2:	86ce                	mv	a3,s3
     8a4:	864a                	mv	a2,s2
     8a6:	00001597          	auipc	a1,0x1
     8aa:	d8a58593          	addi	a1,a1,-630 # 1630 <malloc+0x46c>
     8ae:	4509                	li	a0,2
     8b0:	00001097          	auipc	ra,0x1
     8b4:	82e080e7          	jalr	-2002(ra) # 10de <fprintf>
          final_produced, final_consumed);
  fprintf(2, "  All IPC mechanisms worked together harmoniously!\n\n");
     8b8:	00001597          	auipc	a1,0x1
     8bc:	da858593          	addi	a1,a1,-600 # 1660 <malloc+0x49c>
     8c0:	4509                	li	a0,2
     8c2:	00001097          	auipc	ra,0x1
     8c6:	81c080e7          	jalr	-2020(ra) # 10de <fprintf>
  
  exit(0);
     8ca:	4501                	li	a0,0
     8cc:	00000097          	auipc	ra,0x0
     8d0:	2c0080e7          	jalr	704(ra) # b8c <exit>

00000000000008d4 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
     8d4:	1141                	addi	sp,sp,-16
     8d6:	e422                	sd	s0,8(sp)
     8d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8da:	87aa                	mv	a5,a0
     8dc:	0585                	addi	a1,a1,1
     8de:	0785                	addi	a5,a5,1
     8e0:	fff5c703          	lbu	a4,-1(a1)
     8e4:	fee78fa3          	sb	a4,-1(a5)
     8e8:	fb75                	bnez	a4,8dc <strcpy+0x8>
    ;
  return os;
}
     8ea:	6422                	ld	s0,8(sp)
     8ec:	0141                	addi	sp,sp,16
     8ee:	8082                	ret

00000000000008f0 <strcat>:

char*
strcat(char *s, const char *t)
{
     8f0:	1141                	addi	sp,sp,-16
     8f2:	e422                	sd	s0,8(sp)
     8f4:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
     8f6:	00054783          	lbu	a5,0(a0)
     8fa:	c385                	beqz	a5,91a <strcat+0x2a>
     8fc:	87aa                	mv	a5,a0
    s++;
     8fe:	0785                	addi	a5,a5,1
  while(*s)
     900:	0007c703          	lbu	a4,0(a5)
     904:	ff6d                	bnez	a4,8fe <strcat+0xe>
  while((*s++ = *t++))
     906:	0585                	addi	a1,a1,1
     908:	0785                	addi	a5,a5,1
     90a:	fff5c703          	lbu	a4,-1(a1)
     90e:	fee78fa3          	sb	a4,-1(a5)
     912:	fb75                	bnez	a4,906 <strcat+0x16>
    ;
  return os;
}
     914:	6422                	ld	s0,8(sp)
     916:	0141                	addi	sp,sp,16
     918:	8082                	ret
  while(*s)
     91a:	87aa                	mv	a5,a0
     91c:	b7ed                	j	906 <strcat+0x16>

000000000000091e <strcmp>:


int
strcmp(const char *p, const char *q)
{
     91e:	1141                	addi	sp,sp,-16
     920:	e422                	sd	s0,8(sp)
     922:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     924:	00054783          	lbu	a5,0(a0)
     928:	cb91                	beqz	a5,93c <strcmp+0x1e>
     92a:	0005c703          	lbu	a4,0(a1)
     92e:	00f71763          	bne	a4,a5,93c <strcmp+0x1e>
    p++, q++;
     932:	0505                	addi	a0,a0,1
     934:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     936:	00054783          	lbu	a5,0(a0)
     93a:	fbe5                	bnez	a5,92a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     93c:	0005c503          	lbu	a0,0(a1)
}
     940:	40a7853b          	subw	a0,a5,a0
     944:	6422                	ld	s0,8(sp)
     946:	0141                	addi	sp,sp,16
     948:	8082                	ret

000000000000094a <strlen>:

uint
strlen(const char *s)
{
     94a:	1141                	addi	sp,sp,-16
     94c:	e422                	sd	s0,8(sp)
     94e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     950:	00054783          	lbu	a5,0(a0)
     954:	cf91                	beqz	a5,970 <strlen+0x26>
     956:	0505                	addi	a0,a0,1
     958:	87aa                	mv	a5,a0
     95a:	4685                	li	a3,1
     95c:	9e89                	subw	a3,a3,a0
     95e:	00f6853b          	addw	a0,a3,a5
     962:	0785                	addi	a5,a5,1
     964:	fff7c703          	lbu	a4,-1(a5)
     968:	fb7d                	bnez	a4,95e <strlen+0x14>
    ;
  return n;
}
     96a:	6422                	ld	s0,8(sp)
     96c:	0141                	addi	sp,sp,16
     96e:	8082                	ret
  for(n = 0; s[n]; n++)
     970:	4501                	li	a0,0
     972:	bfe5                	j	96a <strlen+0x20>

0000000000000974 <memset>:

void*
memset(void *dst, int c, uint n)
{
     974:	1141                	addi	sp,sp,-16
     976:	e422                	sd	s0,8(sp)
     978:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     97a:	ca19                	beqz	a2,990 <memset+0x1c>
     97c:	87aa                	mv	a5,a0
     97e:	1602                	slli	a2,a2,0x20
     980:	9201                	srli	a2,a2,0x20
     982:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     986:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     98a:	0785                	addi	a5,a5,1
     98c:	fee79de3          	bne	a5,a4,986 <memset+0x12>
  }
  return dst;
}
     990:	6422                	ld	s0,8(sp)
     992:	0141                	addi	sp,sp,16
     994:	8082                	ret

0000000000000996 <strchr>:

char*
strchr(const char *s, char c)
{
     996:	1141                	addi	sp,sp,-16
     998:	e422                	sd	s0,8(sp)
     99a:	0800                	addi	s0,sp,16
  for(; *s; s++)
     99c:	00054783          	lbu	a5,0(a0)
     9a0:	cb99                	beqz	a5,9b6 <strchr+0x20>
    if(*s == c)
     9a2:	00f58763          	beq	a1,a5,9b0 <strchr+0x1a>
  for(; *s; s++)
     9a6:	0505                	addi	a0,a0,1
     9a8:	00054783          	lbu	a5,0(a0)
     9ac:	fbfd                	bnez	a5,9a2 <strchr+0xc>
      return (char*)s;
  return 0;
     9ae:	4501                	li	a0,0
}
     9b0:	6422                	ld	s0,8(sp)
     9b2:	0141                	addi	sp,sp,16
     9b4:	8082                	ret
  return 0;
     9b6:	4501                	li	a0,0
     9b8:	bfe5                	j	9b0 <strchr+0x1a>

00000000000009ba <gets>:

char*
gets(char *buf, int max)
{
     9ba:	711d                	addi	sp,sp,-96
     9bc:	ec86                	sd	ra,88(sp)
     9be:	e8a2                	sd	s0,80(sp)
     9c0:	e4a6                	sd	s1,72(sp)
     9c2:	e0ca                	sd	s2,64(sp)
     9c4:	fc4e                	sd	s3,56(sp)
     9c6:	f852                	sd	s4,48(sp)
     9c8:	f456                	sd	s5,40(sp)
     9ca:	f05a                	sd	s6,32(sp)
     9cc:	ec5e                	sd	s7,24(sp)
     9ce:	e862                	sd	s8,16(sp)
     9d0:	1080                	addi	s0,sp,96
     9d2:	8baa                	mv	s7,a0
     9d4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9d6:	892a                	mv	s2,a0
     9d8:	4481                	li	s1,0
    cc = read(0, &c, 1);
     9da:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9de:	4b29                	li	s6,10
     9e0:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     9e2:	89a6                	mv	s3,s1
     9e4:	2485                	addiw	s1,s1,1
     9e6:	0344d763          	bge	s1,s4,a14 <gets+0x5a>
    cc = read(0, &c, 1);
     9ea:	4605                	li	a2,1
     9ec:	85d6                	mv	a1,s5
     9ee:	4501                	li	a0,0
     9f0:	00000097          	auipc	ra,0x0
     9f4:	1b4080e7          	jalr	436(ra) # ba4 <read>
    if(cc < 1)
     9f8:	00a05e63          	blez	a0,a14 <gets+0x5a>
    buf[i++] = c;
     9fc:	faf44783          	lbu	a5,-81(s0)
     a00:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     a04:	01678763          	beq	a5,s6,a12 <gets+0x58>
     a08:	0905                	addi	s2,s2,1
     a0a:	fd879ce3          	bne	a5,s8,9e2 <gets+0x28>
  for(i=0; i+1 < max; ){
     a0e:	89a6                	mv	s3,s1
     a10:	a011                	j	a14 <gets+0x5a>
     a12:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     a14:	99de                	add	s3,s3,s7
     a16:	00098023          	sb	zero,0(s3)
  return buf;
}
     a1a:	855e                	mv	a0,s7
     a1c:	60e6                	ld	ra,88(sp)
     a1e:	6446                	ld	s0,80(sp)
     a20:	64a6                	ld	s1,72(sp)
     a22:	6906                	ld	s2,64(sp)
     a24:	79e2                	ld	s3,56(sp)
     a26:	7a42                	ld	s4,48(sp)
     a28:	7aa2                	ld	s5,40(sp)
     a2a:	7b02                	ld	s6,32(sp)
     a2c:	6be2                	ld	s7,24(sp)
     a2e:	6c42                	ld	s8,16(sp)
     a30:	6125                	addi	sp,sp,96
     a32:	8082                	ret

0000000000000a34 <stat>:

int
stat(const char *n, struct stat *st)
{
     a34:	1101                	addi	sp,sp,-32
     a36:	ec06                	sd	ra,24(sp)
     a38:	e822                	sd	s0,16(sp)
     a3a:	e426                	sd	s1,8(sp)
     a3c:	e04a                	sd	s2,0(sp)
     a3e:	1000                	addi	s0,sp,32
     a40:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a42:	4581                	li	a1,0
     a44:	00000097          	auipc	ra,0x0
     a48:	188080e7          	jalr	392(ra) # bcc <open>
  if(fd < 0)
     a4c:	02054563          	bltz	a0,a76 <stat+0x42>
     a50:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a52:	85ca                	mv	a1,s2
     a54:	00000097          	auipc	ra,0x0
     a58:	180080e7          	jalr	384(ra) # bd4 <fstat>
     a5c:	892a                	mv	s2,a0
  close(fd);
     a5e:	8526                	mv	a0,s1
     a60:	00000097          	auipc	ra,0x0
     a64:	154080e7          	jalr	340(ra) # bb4 <close>
  return r;
}
     a68:	854a                	mv	a0,s2
     a6a:	60e2                	ld	ra,24(sp)
     a6c:	6442                	ld	s0,16(sp)
     a6e:	64a2                	ld	s1,8(sp)
     a70:	6902                	ld	s2,0(sp)
     a72:	6105                	addi	sp,sp,32
     a74:	8082                	ret
    return -1;
     a76:	597d                	li	s2,-1
     a78:	bfc5                	j	a68 <stat+0x34>

0000000000000a7a <atoi>:

int
atoi(const char *s)
{
     a7a:	1141                	addi	sp,sp,-16
     a7c:	e422                	sd	s0,8(sp)
     a7e:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
     a80:	00054703          	lbu	a4,0(a0)
     a84:	02d00793          	li	a5,45
  int neg = 1;
     a88:	4585                	li	a1,1
  if (*s == '-') {
     a8a:	04f70363          	beq	a4,a5,ad0 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
     a8e:	00054703          	lbu	a4,0(a0)
     a92:	fd07079b          	addiw	a5,a4,-48
     a96:	0ff7f793          	zext.b	a5,a5
     a9a:	46a5                	li	a3,9
     a9c:	02f6ed63          	bltu	a3,a5,ad6 <atoi+0x5c>
  n = 0;
     aa0:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
     aa2:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
     aa4:	0505                	addi	a0,a0,1
     aa6:	0026979b          	slliw	a5,a3,0x2
     aaa:	9fb5                	addw	a5,a5,a3
     aac:	0017979b          	slliw	a5,a5,0x1
     ab0:	9fb9                	addw	a5,a5,a4
     ab2:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
     ab6:	00054703          	lbu	a4,0(a0)
     aba:	fd07079b          	addiw	a5,a4,-48
     abe:	0ff7f793          	zext.b	a5,a5
     ac2:	fef671e3          	bgeu	a2,a5,aa4 <atoi+0x2a>
  return n * neg;
}
     ac6:	02d5853b          	mulw	a0,a1,a3
     aca:	6422                	ld	s0,8(sp)
     acc:	0141                	addi	sp,sp,16
     ace:	8082                	ret
    s++;
     ad0:	0505                	addi	a0,a0,1
    neg = -1;
     ad2:	55fd                	li	a1,-1
     ad4:	bf6d                	j	a8e <atoi+0x14>
  n = 0;
     ad6:	4681                	li	a3,0
     ad8:	b7fd                	j	ac6 <atoi+0x4c>

0000000000000ada <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ada:	1141                	addi	sp,sp,-16
     adc:	e422                	sd	s0,8(sp)
     ade:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     ae0:	02b57463          	bgeu	a0,a1,b08 <memmove+0x2e>
    while(n-- > 0)
     ae4:	00c05f63          	blez	a2,b02 <memmove+0x28>
     ae8:	1602                	slli	a2,a2,0x20
     aea:	9201                	srli	a2,a2,0x20
     aec:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     af0:	872a                	mv	a4,a0
      *dst++ = *src++;
     af2:	0585                	addi	a1,a1,1
     af4:	0705                	addi	a4,a4,1
     af6:	fff5c683          	lbu	a3,-1(a1)
     afa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     afe:	fee79ae3          	bne	a5,a4,af2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b02:	6422                	ld	s0,8(sp)
     b04:	0141                	addi	sp,sp,16
     b06:	8082                	ret
    dst += n;
     b08:	00c50733          	add	a4,a0,a2
    src += n;
     b0c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     b0e:	fec05ae3          	blez	a2,b02 <memmove+0x28>
     b12:	fff6079b          	addiw	a5,a2,-1
     b16:	1782                	slli	a5,a5,0x20
     b18:	9381                	srli	a5,a5,0x20
     b1a:	fff7c793          	not	a5,a5
     b1e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     b20:	15fd                	addi	a1,a1,-1
     b22:	177d                	addi	a4,a4,-1
     b24:	0005c683          	lbu	a3,0(a1)
     b28:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     b2c:	fee79ae3          	bne	a5,a4,b20 <memmove+0x46>
     b30:	bfc9                	j	b02 <memmove+0x28>

0000000000000b32 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     b32:	1141                	addi	sp,sp,-16
     b34:	e422                	sd	s0,8(sp)
     b36:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     b38:	ca05                	beqz	a2,b68 <memcmp+0x36>
     b3a:	fff6069b          	addiw	a3,a2,-1
     b3e:	1682                	slli	a3,a3,0x20
     b40:	9281                	srli	a3,a3,0x20
     b42:	0685                	addi	a3,a3,1
     b44:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b46:	00054783          	lbu	a5,0(a0)
     b4a:	0005c703          	lbu	a4,0(a1)
     b4e:	00e79863          	bne	a5,a4,b5e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b52:	0505                	addi	a0,a0,1
    p2++;
     b54:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b56:	fed518e3          	bne	a0,a3,b46 <memcmp+0x14>
  }
  return 0;
     b5a:	4501                	li	a0,0
     b5c:	a019                	j	b62 <memcmp+0x30>
      return *p1 - *p2;
     b5e:	40e7853b          	subw	a0,a5,a4
}
     b62:	6422                	ld	s0,8(sp)
     b64:	0141                	addi	sp,sp,16
     b66:	8082                	ret
  return 0;
     b68:	4501                	li	a0,0
     b6a:	bfe5                	j	b62 <memcmp+0x30>

0000000000000b6c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b6c:	1141                	addi	sp,sp,-16
     b6e:	e406                	sd	ra,8(sp)
     b70:	e022                	sd	s0,0(sp)
     b72:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     b74:	00000097          	auipc	ra,0x0
     b78:	f66080e7          	jalr	-154(ra) # ada <memmove>
}
     b7c:	60a2                	ld	ra,8(sp)
     b7e:	6402                	ld	s0,0(sp)
     b80:	0141                	addi	sp,sp,16
     b82:	8082                	ret

0000000000000b84 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
     b84:	4885                	li	a7,1
 ecall
     b86:	00000073          	ecall
 ret
     b8a:	8082                	ret

0000000000000b8c <exit>:
.global exit
exit:
 li a7, SYS_exit
     b8c:	4889                	li	a7,2
 ecall
     b8e:	00000073          	ecall
 ret
     b92:	8082                	ret

0000000000000b94 <wait>:
.global wait
wait:
 li a7, SYS_wait
     b94:	488d                	li	a7,3
 ecall
     b96:	00000073          	ecall
 ret
     b9a:	8082                	ret

0000000000000b9c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b9c:	4891                	li	a7,4
 ecall
     b9e:	00000073          	ecall
 ret
     ba2:	8082                	ret

0000000000000ba4 <read>:
.global read
read:
 li a7, SYS_read
     ba4:	4895                	li	a7,5
 ecall
     ba6:	00000073          	ecall
 ret
     baa:	8082                	ret

0000000000000bac <write>:
.global write
write:
 li a7, SYS_write
     bac:	48c1                	li	a7,16
 ecall
     bae:	00000073          	ecall
 ret
     bb2:	8082                	ret

0000000000000bb4 <close>:
.global close
close:
 li a7, SYS_close
     bb4:	48d5                	li	a7,21
 ecall
     bb6:	00000073          	ecall
 ret
     bba:	8082                	ret

0000000000000bbc <kill>:
.global kill
kill:
 li a7, SYS_kill
     bbc:	4899                	li	a7,6
 ecall
     bbe:	00000073          	ecall
 ret
     bc2:	8082                	ret

0000000000000bc4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     bc4:	489d                	li	a7,7
 ecall
     bc6:	00000073          	ecall
 ret
     bca:	8082                	ret

0000000000000bcc <open>:
.global open
open:
 li a7, SYS_open
     bcc:	48bd                	li	a7,15
 ecall
     bce:	00000073          	ecall
 ret
     bd2:	8082                	ret

0000000000000bd4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     bd4:	48a1                	li	a7,8
 ecall
     bd6:	00000073          	ecall
 ret
     bda:	8082                	ret

0000000000000bdc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     bdc:	48d1                	li	a7,20
 ecall
     bde:	00000073          	ecall
 ret
     be2:	8082                	ret

0000000000000be4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     be4:	48a5                	li	a7,9
 ecall
     be6:	00000073          	ecall
 ret
     bea:	8082                	ret

0000000000000bec <dup>:
.global dup
dup:
 li a7, SYS_dup
     bec:	48a9                	li	a7,10
 ecall
     bee:	00000073          	ecall
 ret
     bf2:	8082                	ret

0000000000000bf4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     bf4:	48ad                	li	a7,11
 ecall
     bf6:	00000073          	ecall
 ret
     bfa:	8082                	ret

0000000000000bfc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     bfc:	48b1                	li	a7,12
 ecall
     bfe:	00000073          	ecall
 ret
     c02:	8082                	ret

0000000000000c04 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     c04:	48b5                	li	a7,13
 ecall
     c06:	00000073          	ecall
 ret
     c0a:	8082                	ret

0000000000000c0c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c0c:	48b9                	li	a7,14
 ecall
     c0e:	00000073          	ecall
 ret
     c12:	8082                	ret

0000000000000c14 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
     c14:	48d9                	li	a7,22
 ecall
     c16:	00000073          	ecall
 ret
     c1a:	8082                	ret

0000000000000c1c <dev>:
.global dev
dev:
 li a7, SYS_dev
     c1c:	48dd                	li	a7,23
 ecall
     c1e:	00000073          	ecall
 ret
     c22:	8082                	ret

0000000000000c24 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
     c24:	48e1                	li	a7,24
 ecall
     c26:	00000073          	ecall
 ret
     c2a:	8082                	ret

0000000000000c2c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     c2c:	48e5                	li	a7,25
 ecall
     c2e:	00000073          	ecall
 ret
     c32:	8082                	ret

0000000000000c34 <remove>:
.global remove
remove:
 li a7, SYS_remove
     c34:	48c5                	li	a7,17
 ecall
     c36:	00000073          	ecall
 ret
     c3a:	8082                	ret

0000000000000c3c <trace>:
.global trace
trace:
 li a7, SYS_trace
     c3c:	48c9                	li	a7,18
 ecall
     c3e:	00000073          	ecall
 ret
     c42:	8082                	ret

0000000000000c44 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     c44:	48cd                	li	a7,19
 ecall
     c46:	00000073          	ecall
 ret
     c4a:	8082                	ret

0000000000000c4c <rename>:
.global rename
rename:
 li a7, SYS_rename
     c4c:	48e9                	li	a7,26
 ecall
     c4e:	00000073          	ecall
 ret
     c52:	8082                	ret

0000000000000c54 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
     c54:	48ed                	li	a7,27
 ecall
     c56:	00000073          	ecall
 ret
     c5a:	8082                	ret

0000000000000c5c <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
     c5c:	48f1                	li	a7,28
 ecall
     c5e:	00000073          	ecall
 ret
     c62:	8082                	ret

0000000000000c64 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
     c64:	48f5                	li	a7,29
 ecall
     c66:	00000073          	ecall
 ret
     c6a:	8082                	ret

0000000000000c6c <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
     c6c:	48f9                	li	a7,30
 ecall
     c6e:	00000073          	ecall
 ret
     c72:	8082                	ret

0000000000000c74 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
     c74:	48fd                	li	a7,31
 ecall
     c76:	00000073          	ecall
 ret
     c7a:	8082                	ret

0000000000000c7c <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
     c7c:	02000893          	li	a7,32
 ecall
     c80:	00000073          	ecall
 ret
     c84:	8082                	ret

0000000000000c86 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     c86:	02100893          	li	a7,33
 ecall
     c8a:	00000073          	ecall
 ret
     c8e:	8082                	ret

0000000000000c90 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
     c90:	02200893          	li	a7,34
 ecall
     c94:	00000073          	ecall
 ret
     c98:	8082                	ret

0000000000000c9a <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
     c9a:	02300893          	li	a7,35
 ecall
     c9e:	00000073          	ecall
 ret
     ca2:	8082                	ret

0000000000000ca4 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
     ca4:	02400893          	li	a7,36
 ecall
     ca8:	00000073          	ecall
 ret
     cac:	8082                	ret

0000000000000cae <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
     cae:	02500893          	li	a7,37
 ecall
     cb2:	00000073          	ecall
 ret
     cb6:	8082                	ret

0000000000000cb8 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
     cb8:	02600893          	li	a7,38
 ecall
     cbc:	00000073          	ecall
 ret
     cc0:	8082                	ret

0000000000000cc2 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
     cc2:	02700893          	li	a7,39
 ecall
     cc6:	00000073          	ecall
 ret
     cca:	8082                	ret

0000000000000ccc <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
     ccc:	02800893          	li	a7,40
 ecall
     cd0:	00000073          	ecall
 ret
     cd4:	8082                	ret

0000000000000cd6 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
     cd6:	02900893          	li	a7,41
 ecall
     cda:	00000073          	ecall
 ret
     cde:	8082                	ret

0000000000000ce0 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
     ce0:	02a00893          	li	a7,42
 ecall
     ce4:	00000073          	ecall
 ret
     ce8:	8082                	ret

0000000000000cea <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
     cea:	02b00893          	li	a7,43
 ecall
     cee:	00000073          	ecall
 ret
     cf2:	8082                	ret

0000000000000cf4 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
     cf4:	02c00893          	li	a7,44
 ecall
     cf8:	00000073          	ecall
 ret
     cfc:	8082                	ret

0000000000000cfe <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
     cfe:	02d00893          	li	a7,45
 ecall
     d02:	00000073          	ecall
 ret
     d06:	8082                	ret

0000000000000d08 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
     d08:	02e00893          	li	a7,46
 ecall
     d0c:	00000073          	ecall
 ret
     d10:	8082                	ret

0000000000000d12 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
     d12:	02f00893          	li	a7,47
 ecall
     d16:	00000073          	ecall
 ret
     d1a:	8082                	ret

0000000000000d1c <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
     d1c:	03000893          	li	a7,48
 ecall
     d20:	00000073          	ecall
 ret
     d24:	8082                	ret

0000000000000d26 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
     d26:	03100893          	li	a7,49
 ecall
     d2a:	00000073          	ecall
 ret
     d2e:	8082                	ret

0000000000000d30 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
     d30:	03200893          	li	a7,50
 ecall
     d34:	00000073          	ecall
 ret
     d38:	8082                	ret

0000000000000d3a <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
     d3a:	03300893          	li	a7,51
 ecall
     d3e:	00000073          	ecall
 ret
     d42:	8082                	ret

0000000000000d44 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
     d44:	03400893          	li	a7,52
 ecall
     d48:	00000073          	ecall
 ret
     d4c:	8082                	ret

0000000000000d4e <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
     d4e:	03500893          	li	a7,53
 ecall
     d52:	00000073          	ecall
 ret
     d56:	8082                	ret

0000000000000d58 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
     d58:	03600893          	li	a7,54
 ecall
     d5c:	00000073          	ecall
 ret
     d60:	8082                	ret

0000000000000d62 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
     d62:	03700893          	li	a7,55
 ecall
     d66:	00000073          	ecall
 ret
     d6a:	8082                	ret

0000000000000d6c <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
     d6c:	03800893          	li	a7,56
 ecall
     d70:	00000073          	ecall
 ret
     d74:	8082                	ret

0000000000000d76 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
     d76:	03900893          	li	a7,57
 ecall
     d7a:	00000073          	ecall
 ret
     d7e:	8082                	ret

0000000000000d80 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
     d80:	03a00893          	li	a7,58
 ecall
     d84:	00000073          	ecall
 ret
     d88:	8082                	ret

0000000000000d8a <poll>:
.global poll
poll:
 li a7, SYS_poll
     d8a:	03b00893          	li	a7,59
 ecall
     d8e:	00000073          	ecall
 ret
     d92:	8082                	ret

0000000000000d94 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
     d94:	03c00893          	li	a7,60
 ecall
     d98:	00000073          	ecall
 ret
     d9c:	8082                	ret

0000000000000d9e <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
     d9e:	03d00893          	li	a7,61
 ecall
     da2:	00000073          	ecall
 ret
     da6:	8082                	ret

0000000000000da8 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
     da8:	03e00893          	li	a7,62
 ecall
     dac:	00000073          	ecall
 ret
     db0:	8082                	ret

0000000000000db2 <clone>:
.global clone
clone:
 li a7, SYS_clone
     db2:	03f00893          	li	a7,63
 ecall
     db6:	00000073          	ecall
 ret
     dba:	8082                	ret

0000000000000dbc <futex>:
.global futex
futex:
 li a7, SYS_futex
     dbc:	04000893          	li	a7,64
 ecall
     dc0:	00000073          	ecall
 ret
     dc4:	8082                	ret

0000000000000dc6 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
     dc6:	04100893          	li	a7,65
 ecall
     dca:	00000073          	ecall
 ret
     dce:	8082                	ret

0000000000000dd0 <halt>:
.global halt
halt:
 li a7, SYS_halt
     dd0:	04200893          	li	a7,66
 ecall
     dd4:	00000073          	ecall
 ret
     dd8:	8082                	ret

0000000000000dda <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
     dda:	04300893          	li	a7,67
 ecall
     dde:	00000073          	ecall
 ret
     de2:	8082                	ret

0000000000000de4 <socket>:
.global socket
socket:
 li a7, SYS_socket
     de4:	04400893          	li	a7,68
 ecall
     de8:	00000073          	ecall
 ret
     dec:	8082                	ret

0000000000000dee <bind>:
.global bind
bind:
 li a7, SYS_bind
     dee:	04500893          	li	a7,69
 ecall
     df2:	00000073          	ecall
 ret
     df6:	8082                	ret

0000000000000df8 <listen>:
.global listen
listen:
 li a7, SYS_listen
     df8:	04600893          	li	a7,70
 ecall
     dfc:	00000073          	ecall
 ret
     e00:	8082                	ret

0000000000000e02 <accept>:
.global accept
accept:
 li a7, SYS_accept
     e02:	04700893          	li	a7,71
 ecall
     e06:	00000073          	ecall
 ret
     e0a:	8082                	ret

0000000000000e0c <connect>:
.global connect
connect:
 li a7, SYS_connect
     e0c:	04800893          	li	a7,72
 ecall
     e10:	00000073          	ecall
 ret
     e14:	8082                	ret

0000000000000e16 <send>:
.global send
send:
 li a7, SYS_send
     e16:	04900893          	li	a7,73
 ecall
     e1a:	00000073          	ecall
 ret
     e1e:	8082                	ret

0000000000000e20 <recv>:
.global recv
recv:
 li a7, SYS_recv
     e20:	04a00893          	li	a7,74
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
     e2a:	04b00893          	li	a7,75
 ecall
     e2e:	00000073          	ecall
 ret
     e32:	8082                	ret

0000000000000e34 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e34:	1101                	addi	sp,sp,-32
     e36:	ec06                	sd	ra,24(sp)
     e38:	e822                	sd	s0,16(sp)
     e3a:	1000                	addi	s0,sp,32
     e3c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e40:	4605                	li	a2,1
     e42:	fef40593          	addi	a1,s0,-17
     e46:	00000097          	auipc	ra,0x0
     e4a:	d66080e7          	jalr	-666(ra) # bac <write>
}
     e4e:	60e2                	ld	ra,24(sp)
     e50:	6442                	ld	s0,16(sp)
     e52:	6105                	addi	sp,sp,32
     e54:	8082                	ret

0000000000000e56 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     e56:	7139                	addi	sp,sp,-64
     e58:	fc06                	sd	ra,56(sp)
     e5a:	f822                	sd	s0,48(sp)
     e5c:	f426                	sd	s1,40(sp)
     e5e:	f04a                	sd	s2,32(sp)
     e60:	ec4e                	sd	s3,24(sp)
     e62:	0080                	addi	s0,sp,64
     e64:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e66:	c299                	beqz	a3,e6c <printint+0x16>
     e68:	0805c863          	bltz	a1,ef8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e6c:	2581                	sext.w	a1,a1
  neg = 0;
     e6e:	4881                	li	a7,0
  }

  i = 0;
     e70:	fc040993          	addi	s3,s0,-64
  neg = 0;
     e74:	86ce                	mv	a3,s3
  i = 0;
     e76:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     e78:	2601                	sext.w	a2,a2
     e7a:	00001517          	auipc	a0,0x1
     e7e:	87e50513          	addi	a0,a0,-1922 # 16f8 <digits>
     e82:	883a                	mv	a6,a4
     e84:	2705                	addiw	a4,a4,1
     e86:	02c5f7bb          	remuw	a5,a1,a2
     e8a:	1782                	slli	a5,a5,0x20
     e8c:	9381                	srli	a5,a5,0x20
     e8e:	97aa                	add	a5,a5,a0
     e90:	0007c783          	lbu	a5,0(a5)
     e94:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     e98:	0005879b          	sext.w	a5,a1
     e9c:	02c5d5bb          	divuw	a1,a1,a2
     ea0:	0685                	addi	a3,a3,1
     ea2:	fec7f0e3          	bgeu	a5,a2,e82 <printint+0x2c>
  if(neg)
     ea6:	00088c63          	beqz	a7,ebe <printint+0x68>
    buf[i++] = '-';
     eaa:	fd070793          	addi	a5,a4,-48
     eae:	00878733          	add	a4,a5,s0
     eb2:	02d00793          	li	a5,45
     eb6:	fef70823          	sb	a5,-16(a4)
     eba:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     ebe:	02e05663          	blez	a4,eea <printint+0x94>
     ec2:	fc040913          	addi	s2,s0,-64
     ec6:	993a                	add	s2,s2,a4
     ec8:	19fd                	addi	s3,s3,-1
     eca:	99ba                	add	s3,s3,a4
     ecc:	377d                	addiw	a4,a4,-1
     ece:	1702                	slli	a4,a4,0x20
     ed0:	9301                	srli	a4,a4,0x20
     ed2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     ed6:	fff94583          	lbu	a1,-1(s2)
     eda:	8526                	mv	a0,s1
     edc:	00000097          	auipc	ra,0x0
     ee0:	f58080e7          	jalr	-168(ra) # e34 <putc>
  while(--i >= 0)
     ee4:	197d                	addi	s2,s2,-1
     ee6:	ff3918e3          	bne	s2,s3,ed6 <printint+0x80>
}
     eea:	70e2                	ld	ra,56(sp)
     eec:	7442                	ld	s0,48(sp)
     eee:	74a2                	ld	s1,40(sp)
     ef0:	7902                	ld	s2,32(sp)
     ef2:	69e2                	ld	s3,24(sp)
     ef4:	6121                	addi	sp,sp,64
     ef6:	8082                	ret
    x = -xx;
     ef8:	40b005bb          	negw	a1,a1
    neg = 1;
     efc:	4885                	li	a7,1
    x = -xx;
     efe:	bf8d                	j	e70 <printint+0x1a>

0000000000000f00 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f00:	7119                	addi	sp,sp,-128
     f02:	fc86                	sd	ra,120(sp)
     f04:	f8a2                	sd	s0,112(sp)
     f06:	f4a6                	sd	s1,104(sp)
     f08:	f0ca                	sd	s2,96(sp)
     f0a:	ecce                	sd	s3,88(sp)
     f0c:	e8d2                	sd	s4,80(sp)
     f0e:	e4d6                	sd	s5,72(sp)
     f10:	e0da                	sd	s6,64(sp)
     f12:	fc5e                	sd	s7,56(sp)
     f14:	f862                	sd	s8,48(sp)
     f16:	f466                	sd	s9,40(sp)
     f18:	f06a                	sd	s10,32(sp)
     f1a:	ec6e                	sd	s11,24(sp)
     f1c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f1e:	0005c903          	lbu	s2,0(a1)
     f22:	18090f63          	beqz	s2,10c0 <vprintf+0x1c0>
     f26:	8aaa                	mv	s5,a0
     f28:	8b32                	mv	s6,a2
     f2a:	00158493          	addi	s1,a1,1
  state = 0;
     f2e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f30:	02500a13          	li	s4,37
     f34:	4c55                	li	s8,21
     f36:	00000c97          	auipc	s9,0x0
     f3a:	76ac8c93          	addi	s9,s9,1898 # 16a0 <malloc+0x4dc>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     f3e:	02800d93          	li	s11,40
  putc(fd, 'x');
     f42:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f44:	00000b97          	auipc	s7,0x0
     f48:	7b4b8b93          	addi	s7,s7,1972 # 16f8 <digits>
     f4c:	a839                	j	f6a <vprintf+0x6a>
        putc(fd, c);
     f4e:	85ca                	mv	a1,s2
     f50:	8556                	mv	a0,s5
     f52:	00000097          	auipc	ra,0x0
     f56:	ee2080e7          	jalr	-286(ra) # e34 <putc>
     f5a:	a019                	j	f60 <vprintf+0x60>
    } else if(state == '%'){
     f5c:	01498d63          	beq	s3,s4,f76 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
     f60:	0485                	addi	s1,s1,1
     f62:	fff4c903          	lbu	s2,-1(s1)
     f66:	14090d63          	beqz	s2,10c0 <vprintf+0x1c0>
    if(state == 0){
     f6a:	fe0999e3          	bnez	s3,f5c <vprintf+0x5c>
      if(c == '%'){
     f6e:	ff4910e3          	bne	s2,s4,f4e <vprintf+0x4e>
        state = '%';
     f72:	89d2                	mv	s3,s4
     f74:	b7f5                	j	f60 <vprintf+0x60>
      if(c == 'd'){
     f76:	11490c63          	beq	s2,s4,108e <vprintf+0x18e>
     f7a:	f9d9079b          	addiw	a5,s2,-99
     f7e:	0ff7f793          	zext.b	a5,a5
     f82:	10fc6e63          	bltu	s8,a5,109e <vprintf+0x19e>
     f86:	f9d9079b          	addiw	a5,s2,-99
     f8a:	0ff7f713          	zext.b	a4,a5
     f8e:	10ec6863          	bltu	s8,a4,109e <vprintf+0x19e>
     f92:	00271793          	slli	a5,a4,0x2
     f96:	97e6                	add	a5,a5,s9
     f98:	439c                	lw	a5,0(a5)
     f9a:	97e6                	add	a5,a5,s9
     f9c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     f9e:	008b0913          	addi	s2,s6,8
     fa2:	4685                	li	a3,1
     fa4:	4629                	li	a2,10
     fa6:	000b2583          	lw	a1,0(s6)
     faa:	8556                	mv	a0,s5
     fac:	00000097          	auipc	ra,0x0
     fb0:	eaa080e7          	jalr	-342(ra) # e56 <printint>
     fb4:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fb6:	4981                	li	s3,0
     fb8:	b765                	j	f60 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fba:	008b0913          	addi	s2,s6,8
     fbe:	4681                	li	a3,0
     fc0:	4629                	li	a2,10
     fc2:	000b2583          	lw	a1,0(s6)
     fc6:	8556                	mv	a0,s5
     fc8:	00000097          	auipc	ra,0x0
     fcc:	e8e080e7          	jalr	-370(ra) # e56 <printint>
     fd0:	8b4a                	mv	s6,s2
      state = 0;
     fd2:	4981                	li	s3,0
     fd4:	b771                	j	f60 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
     fd6:	008b0913          	addi	s2,s6,8
     fda:	4681                	li	a3,0
     fdc:	866a                	mv	a2,s10
     fde:	000b2583          	lw	a1,0(s6)
     fe2:	8556                	mv	a0,s5
     fe4:	00000097          	auipc	ra,0x0
     fe8:	e72080e7          	jalr	-398(ra) # e56 <printint>
     fec:	8b4a                	mv	s6,s2
      state = 0;
     fee:	4981                	li	s3,0
     ff0:	bf85                	j	f60 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
     ff2:	008b0793          	addi	a5,s6,8
     ff6:	f8f43423          	sd	a5,-120(s0)
     ffa:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
     ffe:	03000593          	li	a1,48
    1002:	8556                	mv	a0,s5
    1004:	00000097          	auipc	ra,0x0
    1008:	e30080e7          	jalr	-464(ra) # e34 <putc>
  putc(fd, 'x');
    100c:	07800593          	li	a1,120
    1010:	8556                	mv	a0,s5
    1012:	00000097          	auipc	ra,0x0
    1016:	e22080e7          	jalr	-478(ra) # e34 <putc>
    101a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    101c:	03c9d793          	srli	a5,s3,0x3c
    1020:	97de                	add	a5,a5,s7
    1022:	0007c583          	lbu	a1,0(a5)
    1026:	8556                	mv	a0,s5
    1028:	00000097          	auipc	ra,0x0
    102c:	e0c080e7          	jalr	-500(ra) # e34 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1030:	0992                	slli	s3,s3,0x4
    1032:	397d                	addiw	s2,s2,-1
    1034:	fe0914e3          	bnez	s2,101c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    1038:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    103c:	4981                	li	s3,0
    103e:	b70d                	j	f60 <vprintf+0x60>
        s = va_arg(ap, char*);
    1040:	008b0913          	addi	s2,s6,8
    1044:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    1048:	02098163          	beqz	s3,106a <vprintf+0x16a>
        while(*s != 0){
    104c:	0009c583          	lbu	a1,0(s3)
    1050:	c5ad                	beqz	a1,10ba <vprintf+0x1ba>
          putc(fd, *s);
    1052:	8556                	mv	a0,s5
    1054:	00000097          	auipc	ra,0x0
    1058:	de0080e7          	jalr	-544(ra) # e34 <putc>
          s++;
    105c:	0985                	addi	s3,s3,1
        while(*s != 0){
    105e:	0009c583          	lbu	a1,0(s3)
    1062:	f9e5                	bnez	a1,1052 <vprintf+0x152>
        s = va_arg(ap, char*);
    1064:	8b4a                	mv	s6,s2
      state = 0;
    1066:	4981                	li	s3,0
    1068:	bde5                	j	f60 <vprintf+0x60>
          s = "(null)";
    106a:	00000997          	auipc	s3,0x0
    106e:	62e98993          	addi	s3,s3,1582 # 1698 <malloc+0x4d4>
        while(*s != 0){
    1072:	85ee                	mv	a1,s11
    1074:	bff9                	j	1052 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    1076:	008b0913          	addi	s2,s6,8
    107a:	000b4583          	lbu	a1,0(s6)
    107e:	8556                	mv	a0,s5
    1080:	00000097          	auipc	ra,0x0
    1084:	db4080e7          	jalr	-588(ra) # e34 <putc>
    1088:	8b4a                	mv	s6,s2
      state = 0;
    108a:	4981                	li	s3,0
    108c:	bdd1                	j	f60 <vprintf+0x60>
        putc(fd, c);
    108e:	85d2                	mv	a1,s4
    1090:	8556                	mv	a0,s5
    1092:	00000097          	auipc	ra,0x0
    1096:	da2080e7          	jalr	-606(ra) # e34 <putc>
      state = 0;
    109a:	4981                	li	s3,0
    109c:	b5d1                	j	f60 <vprintf+0x60>
        putc(fd, '%');
    109e:	85d2                	mv	a1,s4
    10a0:	8556                	mv	a0,s5
    10a2:	00000097          	auipc	ra,0x0
    10a6:	d92080e7          	jalr	-622(ra) # e34 <putc>
        putc(fd, c);
    10aa:	85ca                	mv	a1,s2
    10ac:	8556                	mv	a0,s5
    10ae:	00000097          	auipc	ra,0x0
    10b2:	d86080e7          	jalr	-634(ra) # e34 <putc>
      state = 0;
    10b6:	4981                	li	s3,0
    10b8:	b565                	j	f60 <vprintf+0x60>
        s = va_arg(ap, char*);
    10ba:	8b4a                	mv	s6,s2
      state = 0;
    10bc:	4981                	li	s3,0
    10be:	b54d                	j	f60 <vprintf+0x60>
    }
  }
}
    10c0:	70e6                	ld	ra,120(sp)
    10c2:	7446                	ld	s0,112(sp)
    10c4:	74a6                	ld	s1,104(sp)
    10c6:	7906                	ld	s2,96(sp)
    10c8:	69e6                	ld	s3,88(sp)
    10ca:	6a46                	ld	s4,80(sp)
    10cc:	6aa6                	ld	s5,72(sp)
    10ce:	6b06                	ld	s6,64(sp)
    10d0:	7be2                	ld	s7,56(sp)
    10d2:	7c42                	ld	s8,48(sp)
    10d4:	7ca2                	ld	s9,40(sp)
    10d6:	7d02                	ld	s10,32(sp)
    10d8:	6de2                	ld	s11,24(sp)
    10da:	6109                	addi	sp,sp,128
    10dc:	8082                	ret

00000000000010de <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10de:	715d                	addi	sp,sp,-80
    10e0:	ec06                	sd	ra,24(sp)
    10e2:	e822                	sd	s0,16(sp)
    10e4:	1000                	addi	s0,sp,32
    10e6:	e010                	sd	a2,0(s0)
    10e8:	e414                	sd	a3,8(s0)
    10ea:	e818                	sd	a4,16(s0)
    10ec:	ec1c                	sd	a5,24(s0)
    10ee:	03043023          	sd	a6,32(s0)
    10f2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    10f6:	8622                	mv	a2,s0
    10f8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    10fc:	00000097          	auipc	ra,0x0
    1100:	e04080e7          	jalr	-508(ra) # f00 <vprintf>
}
    1104:	60e2                	ld	ra,24(sp)
    1106:	6442                	ld	s0,16(sp)
    1108:	6161                	addi	sp,sp,80
    110a:	8082                	ret

000000000000110c <printf>:

void
printf(const char *fmt, ...)
{
    110c:	711d                	addi	sp,sp,-96
    110e:	ec06                	sd	ra,24(sp)
    1110:	e822                	sd	s0,16(sp)
    1112:	1000                	addi	s0,sp,32
    1114:	e40c                	sd	a1,8(s0)
    1116:	e810                	sd	a2,16(s0)
    1118:	ec14                	sd	a3,24(s0)
    111a:	f018                	sd	a4,32(s0)
    111c:	f41c                	sd	a5,40(s0)
    111e:	03043823          	sd	a6,48(s0)
    1122:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1126:	00840613          	addi	a2,s0,8
    112a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    112e:	85aa                	mv	a1,a0
    1130:	4505                	li	a0,1
    1132:	00000097          	auipc	ra,0x0
    1136:	dce080e7          	jalr	-562(ra) # f00 <vprintf>
}
    113a:	60e2                	ld	ra,24(sp)
    113c:	6442                	ld	s0,16(sp)
    113e:	6125                	addi	sp,sp,96
    1140:	8082                	ret

0000000000001142 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1142:	1141                	addi	sp,sp,-16
    1144:	e422                	sd	s0,8(sp)
    1146:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1148:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    114c:	00000797          	auipc	a5,0x0
    1150:	5ec7b783          	ld	a5,1516(a5) # 1738 <freep>
    1154:	a02d                	j	117e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1156:	4618                	lw	a4,8(a2)
    1158:	9f2d                	addw	a4,a4,a1
    115a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    115e:	6398                	ld	a4,0(a5)
    1160:	6310                	ld	a2,0(a4)
    1162:	a83d                	j	11a0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1164:	ff852703          	lw	a4,-8(a0)
    1168:	9f31                	addw	a4,a4,a2
    116a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    116c:	ff053683          	ld	a3,-16(a0)
    1170:	a091                	j	11b4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1172:	6398                	ld	a4,0(a5)
    1174:	00e7e463          	bltu	a5,a4,117c <free+0x3a>
    1178:	00e6ea63          	bltu	a3,a4,118c <free+0x4a>
{
    117c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    117e:	fed7fae3          	bgeu	a5,a3,1172 <free+0x30>
    1182:	6398                	ld	a4,0(a5)
    1184:	00e6e463          	bltu	a3,a4,118c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1188:	fee7eae3          	bltu	a5,a4,117c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    118c:	ff852583          	lw	a1,-8(a0)
    1190:	6390                	ld	a2,0(a5)
    1192:	02059813          	slli	a6,a1,0x20
    1196:	01c85713          	srli	a4,a6,0x1c
    119a:	9736                	add	a4,a4,a3
    119c:	fae60de3          	beq	a2,a4,1156 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    11a0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    11a4:	4790                	lw	a2,8(a5)
    11a6:	02061593          	slli	a1,a2,0x20
    11aa:	01c5d713          	srli	a4,a1,0x1c
    11ae:	973e                	add	a4,a4,a5
    11b0:	fae68ae3          	beq	a3,a4,1164 <free+0x22>
    p->s.ptr = bp->s.ptr;
    11b4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    11b6:	00000717          	auipc	a4,0x0
    11ba:	58f73123          	sd	a5,1410(a4) # 1738 <freep>
}
    11be:	6422                	ld	s0,8(sp)
    11c0:	0141                	addi	sp,sp,16
    11c2:	8082                	ret

00000000000011c4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11c4:	7139                	addi	sp,sp,-64
    11c6:	fc06                	sd	ra,56(sp)
    11c8:	f822                	sd	s0,48(sp)
    11ca:	f426                	sd	s1,40(sp)
    11cc:	f04a                	sd	s2,32(sp)
    11ce:	ec4e                	sd	s3,24(sp)
    11d0:	e852                	sd	s4,16(sp)
    11d2:	e456                	sd	s5,8(sp)
    11d4:	e05a                	sd	s6,0(sp)
    11d6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11d8:	02051493          	slli	s1,a0,0x20
    11dc:	9081                	srli	s1,s1,0x20
    11de:	04bd                	addi	s1,s1,15
    11e0:	8091                	srli	s1,s1,0x4
    11e2:	00148a1b          	addiw	s4,s1,1
    11e6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    11e8:	00000517          	auipc	a0,0x0
    11ec:	55053503          	ld	a0,1360(a0) # 1738 <freep>
    11f0:	c515                	beqz	a0,121c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11f4:	4798                	lw	a4,8(a5)
    11f6:	04977163          	bgeu	a4,s1,1238 <malloc+0x74>
    11fa:	89d2                	mv	s3,s4
    11fc:	000a071b          	sext.w	a4,s4
    1200:	6685                	lui	a3,0x1
    1202:	00d77363          	bgeu	a4,a3,1208 <malloc+0x44>
    1206:	6985                	lui	s3,0x1
    1208:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    120c:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1210:	00000917          	auipc	s2,0x0
    1214:	52890913          	addi	s2,s2,1320 # 1738 <freep>
  if(p == (char*)-1)
    1218:	5afd                	li	s5,-1
    121a:	a8a5                	j	1292 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    121c:	00000797          	auipc	a5,0x0
    1220:	51c78793          	addi	a5,a5,1308 # 1738 <freep>
    1224:	00000717          	auipc	a4,0x0
    1228:	51c70713          	addi	a4,a4,1308 # 1740 <base>
    122c:	e398                	sd	a4,0(a5)
    122e:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    1230:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1234:	87ba                	mv	a5,a4
    1236:	b7d1                	j	11fa <malloc+0x36>
      if(p->s.size == nunits)
    1238:	02e48c63          	beq	s1,a4,1270 <malloc+0xac>
        p->s.size -= nunits;
    123c:	4147073b          	subw	a4,a4,s4
    1240:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1242:	02071693          	slli	a3,a4,0x20
    1246:	01c6d713          	srli	a4,a3,0x1c
    124a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    124c:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    1250:	00000717          	auipc	a4,0x0
    1254:	4ea73423          	sd	a0,1256(a4) # 1738 <freep>
      return (void*)(p + 1);
    1258:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    125c:	70e2                	ld	ra,56(sp)
    125e:	7442                	ld	s0,48(sp)
    1260:	74a2                	ld	s1,40(sp)
    1262:	7902                	ld	s2,32(sp)
    1264:	69e2                	ld	s3,24(sp)
    1266:	6a42                	ld	s4,16(sp)
    1268:	6aa2                	ld	s5,8(sp)
    126a:	6b02                	ld	s6,0(sp)
    126c:	6121                	addi	sp,sp,64
    126e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1270:	6398                	ld	a4,0(a5)
    1272:	e118                	sd	a4,0(a0)
    1274:	bff1                	j	1250 <malloc+0x8c>
  hp->s.size = nu;
    1276:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    127a:	0541                	addi	a0,a0,16
    127c:	00000097          	auipc	ra,0x0
    1280:	ec6080e7          	jalr	-314(ra) # 1142 <free>
  return freep;
    1284:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1288:	d971                	beqz	a0,125c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    128a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    128c:	4798                	lw	a4,8(a5)
    128e:	fa9775e3          	bgeu	a4,s1,1238 <malloc+0x74>
    if(p == freep)
    1292:	00093703          	ld	a4,0(s2)
    1296:	853e                	mv	a0,a5
    1298:	fef719e3          	bne	a4,a5,128a <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    129c:	854e                	mv	a0,s3
    129e:	00000097          	auipc	ra,0x0
    12a2:	95e080e7          	jalr	-1698(ra) # bfc <sbrk>
  if(p == (char*)-1)
    12a6:	fd5518e3          	bne	a0,s5,1276 <malloc+0xb2>
        return 0;
    12aa:	4501                	li	a0,0
    12ac:	bf45                	j	125c <malloc+0x98>
