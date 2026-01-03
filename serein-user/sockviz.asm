
serein-user/_sockviz：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <add_worker>:
// Process Management
#define MAX_WORKERS 8
static int workers[MAX_WORKERS];
static int worker_count = 0;

static void add_worker(int pid) {
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
    if(worker_count < MAX_WORKERS) workers[worker_count++] = pid;
       6:	00001797          	auipc	a5,0x1
       a:	65a7a783          	lw	a5,1626(a5) # 1660 <worker_count>
       e:	471d                	li	a4,7
      10:	00f74c63          	blt	a4,a5,28 <add_worker+0x28>
      14:	00001717          	auipc	a4,0x1
      18:	64c70713          	addi	a4,a4,1612 # 1660 <worker_count>
      1c:	0017869b          	addiw	a3,a5,1
      20:	c314                	sw	a3,0(a4)
      22:	078a                	slli	a5,a5,0x2
      24:	973e                	add	a4,a4,a5
      26:	c708                	sw	a0,8(a4)
}
      28:	6422                	ld	s0,8(sp)
      2a:	0141                	addi	sp,sp,16
      2c:	8082                	ret

000000000000002e <print_padded_int>:
static void print_padded_int(int n, int width) {
      2e:	7179                	addi	sp,sp,-48
      30:	f406                	sd	ra,40(sp)
      32:	f022                	sd	s0,32(sp)
      34:	ec26                	sd	s1,24(sp)
      36:	e84a                	sd	s2,16(sp)
      38:	e44e                	sd	s3,8(sp)
      3a:	1800                	addi	s0,sp,48
      3c:	892a                	mv	s2,a0
      3e:	89ae                	mv	s3,a1
    fprintf(2, "%d", n);
      40:	862a                	mv	a2,a0
      42:	00001597          	auipc	a1,0x1
      46:	23e58593          	addi	a1,a1,574 # 1280 <malloc+0xea>
      4a:	4509                	li	a0,2
      4c:	00001097          	auipc	ra,0x1
      50:	064080e7          	jalr	100(ra) # 10b0 <fprintf>
    if(temp == 0) digits = 1;
      54:	02091963          	bnez	s2,86 <print_padded_int+0x58>
      58:	4485                	li	s1,1
    while(digits < width) { fprintf(2, " "); digits++; }
      5a:	00001917          	auipc	s2,0x1
      5e:	22e90913          	addi	s2,s2,558 # 1288 <malloc+0xf2>
      62:	0134db63          	bge	s1,s3,78 <print_padded_int+0x4a>
      66:	85ca                	mv	a1,s2
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	046080e7          	jalr	70(ra) # 10b0 <fprintf>
      72:	2485                	addiw	s1,s1,1
      74:	fe9999e3          	bne	s3,s1,66 <print_padded_int+0x38>
}
      78:	70a2                	ld	ra,40(sp)
      7a:	7402                	ld	s0,32(sp)
      7c:	64e2                	ld	s1,24(sp)
      7e:	6942                	ld	s2,16(sp)
      80:	69a2                	ld	s3,8(sp)
      82:	6145                	addi	sp,sp,48
      84:	8082                	ret
    int temp = n, digits = 0;
      86:	4481                	li	s1,0
    else { if(temp < 0) { digits++; temp = -temp; } while(temp > 0) { temp /= 10; digits++; } }
      88:	00094b63          	bltz	s2,9e <print_padded_int+0x70>
      8c:	46a9                	li	a3,10
      8e:	4725                	li	a4,9
      90:	87ca                	mv	a5,s2
      92:	02d9493b          	divw	s2,s2,a3
      96:	2485                	addiw	s1,s1,1
      98:	fef74ce3          	blt	a4,a5,90 <print_padded_int+0x62>
      9c:	bf7d                	j	5a <print_padded_int+0x2c>
      9e:	4120093b          	negw	s2,s2
      a2:	4485                	li	s1,1
      a4:	b7e5                	j	8c <print_padded_int+0x5e>

00000000000000a6 <color_reset>:
static void color_reset(void) { fprintf(2, "\033[0m"); }
      a6:	1141                	addi	sp,sp,-16
      a8:	e406                	sd	ra,8(sp)
      aa:	e022                	sd	s0,0(sp)
      ac:	0800                	addi	s0,sp,16
      ae:	00001597          	auipc	a1,0x1
      b2:	1e258593          	addi	a1,a1,482 # 1290 <malloc+0xfa>
      b6:	4509                	li	a0,2
      b8:	00001097          	auipc	ra,0x1
      bc:	ff8080e7          	jalr	-8(ra) # 10b0 <fprintf>
      c0:	60a2                	ld	ra,8(sp)
      c2:	6402                	ld	s0,0(sp)
      c4:	0141                	addi	sp,sp,16
      c6:	8082                	ret

00000000000000c8 <print_padded_str>:
static void print_padded_str(char *s, int width) {
      c8:	7179                	addi	sp,sp,-48
      ca:	f406                	sd	ra,40(sp)
      cc:	f022                	sd	s0,32(sp)
      ce:	ec26                	sd	s1,24(sp)
      d0:	e84a                	sd	s2,16(sp)
      d2:	e44e                	sd	s3,8(sp)
      d4:	1800                	addi	s0,sp,48
      d6:	84aa                	mv	s1,a0
      d8:	892e                	mv	s2,a1
    fprintf(2, "%s", s);
      da:	862a                	mv	a2,a0
      dc:	00001597          	auipc	a1,0x1
      e0:	1bc58593          	addi	a1,a1,444 # 1298 <malloc+0x102>
      e4:	4509                	li	a0,2
      e6:	00001097          	auipc	ra,0x1
      ea:	fca080e7          	jalr	-54(ra) # 10b0 <fprintf>
    int len = strlen(s);
      ee:	8526                	mv	a0,s1
      f0:	00001097          	auipc	ra,0x1
      f4:	82c080e7          	jalr	-2004(ra) # 91c <strlen>
      f8:	0005049b          	sext.w	s1,a0
    while(len < width) { fprintf(2, " "); len++; }
      fc:	0124df63          	bge	s1,s2,11a <print_padded_str+0x52>
     100:	00001997          	auipc	s3,0x1
     104:	18898993          	addi	s3,s3,392 # 1288 <malloc+0xf2>
     108:	85ce                	mv	a1,s3
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	fa4080e7          	jalr	-92(ra) # 10b0 <fprintf>
     114:	2485                	addiw	s1,s1,1
     116:	fe9919e3          	bne	s2,s1,108 <print_padded_str+0x40>
}
     11a:	70a2                	ld	ra,40(sp)
     11c:	7402                	ld	s0,32(sp)
     11e:	64e2                	ld	s1,24(sp)
     120:	6942                	ld	s2,16(sp)
     122:	69a2                	ld	s3,8(sp)
     124:	6145                	addi	sp,sp,48
     126:	8082                	ret

0000000000000128 <main>:
    // Client 2: Pulser (Lifecycle)
    if((pid = fork()) == 0) { demo_client_pulse(); exit(0); }
    add_worker(pid);
}

int main(int argc, char *argv[]) {
     128:	7129                	addi	sp,sp,-320
     12a:	fe06                	sd	ra,312(sp)
     12c:	fa22                	sd	s0,304(sp)
     12e:	f626                	sd	s1,296(sp)
     130:	f24a                	sd	s2,288(sp)
     132:	ee4e                	sd	s3,280(sp)
     134:	ea52                	sd	s4,272(sp)
     136:	e656                	sd	s5,264(sp)
     138:	e25a                	sd	s6,256(sp)
     13a:	fdde                	sd	s7,248(sp)
     13c:	f9e2                	sd	s8,240(sp)
     13e:	f5e6                	sd	s9,232(sp)
     140:	f1ea                	sd	s10,224(sp)
     142:	edee                	sd	s11,216(sp)
     144:	0280                	addi	s0,sp,320
    int demo = 0;
    int rounds = 30;

    if(argc > 1 && strcmp(argv[1], "demo") == 0) demo = 1;
     146:	4785                	li	a5,1
    int rounds = 30;
     148:	4779                	li	a4,30
     14a:	ece43c23          	sd	a4,-296(s0)
    int demo = 0;
     14e:	ec043423          	sd	zero,-312(s0)
    if(argc > 1 && strcmp(argv[1], "demo") == 0) demo = 1;
     152:	04a7c763          	blt	a5,a0,1a0 <main+0x78>
    if(demo) {
        fprintf(2, "Initializing rich demo environment...\n");
        start_demo();
    }

    struct sock_stat *stats = malloc(sizeof(struct sock_stat) * MAX_SOCKS);
     156:	6511                	lui	a0,0x4
     158:	f0050513          	addi	a0,a0,-256 # 3f00 <__global_pointer$+0x20a7>
     15c:	00001097          	auipc	ra,0x1
     160:	03a080e7          	jalr	58(ra) # 1196 <malloc>
     164:	eca43823          	sd	a0,-304(s0)
    if(!stats) exit(1);
     168:	2a050b63          	beqz	a0,41e <main+0x2f6>

    for(int r = 0; r <= rounds; r++) {
     16c:	4d01                	li	s10,0
     16e:	ed843703          	ld	a4,-296(s0)
     172:	6e074263          	bltz	a4,856 <main+0x72e>
        print_padded_int(n, 3);
        fprintf(2, "          |\n");
        
        fprintf(2, "+================================================================+\n");
        color_reset();
        fprintf(2, "\n");
     176:	00001a97          	auipc	s5,0x1
     17a:	2faa8a93          	addi	s5,s5,762 # 1470 <malloc+0x2da>
     17e:	18650793          	addi	a5,a0,390
     182:	ecf43023          	sd	a5,-320(s0)
        fprintf(2, "  ----   ---    -----      ------   -----               ------\n");

        for(int i = 0; i < n; i++) {
            struct sock_stat *s = &stats[i];
            
            fprintf(2, "  ");
     186:	00001b17          	auipc	s6,0x1
     18a:	372b0b13          	addi	s6,s6,882 # 14f8 <malloc+0x362>
            
            if(s->type == SOCK_STREAM) fprintf(2, "STRM   "); else fprintf(2, "DGRM   ");
     18e:	00001c97          	auipc	s9,0x1
     192:	37ac8c93          	addi	s9,s9,890 # 1508 <malloc+0x372>
            if(s->domain == AF_INET)   fprintf(2, "INET   "); else fprintf(2, "UNIX   ");
     196:	00001c17          	auipc	s8,0x1
     19a:	382c0c13          	addi	s8,s8,898 # 1518 <malloc+0x382>
     19e:	abb1                	j	6fa <main+0x5d2>
     1a0:	84aa                	mv	s1,a0
     1a2:	892e                	mv	s2,a1
    if(argc > 1 && strcmp(argv[1], "demo") == 0) demo = 1;
     1a4:	00001597          	auipc	a1,0x1
     1a8:	0fc58593          	addi	a1,a1,252 # 12a0 <malloc+0x10a>
     1ac:	00893503          	ld	a0,8(s2)
     1b0:	00000097          	auipc	ra,0x0
     1b4:	740080e7          	jalr	1856(ra) # 8f0 <strcmp>
     1b8:	89aa                	mv	s3,a0
    int demo = 0;
     1ba:	00153793          	seqz	a5,a0
     1be:	ecf43423          	sd	a5,-312(s0)
    if(argc > 2) rounds = atoi(argv[2]);
     1c2:	4789                	li	a5,2
    int rounds = 30;
     1c4:	4779                	li	a4,30
     1c6:	ece43c23          	sd	a4,-296(s0)
    if(argc > 2) rounds = atoi(argv[2]);
     1ca:	0097da63          	bge	a5,s1,1de <main+0xb6>
     1ce:	01093503          	ld	a0,16(s2)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	87a080e7          	jalr	-1926(ra) # a4c <atoi>
     1da:	eca43c23          	sd	a0,-296(s0)
    if(demo) {
     1de:	f6099ce3          	bnez	s3,156 <main+0x2e>
        fprintf(2, "Initializing rich demo environment...\n");
     1e2:	00001597          	auipc	a1,0x1
     1e6:	0c658593          	addi	a1,a1,198 # 12a8 <malloc+0x112>
     1ea:	4509                	li	a0,2
     1ec:	00001097          	auipc	ra,0x1
     1f0:	ec4080e7          	jalr	-316(ra) # 10b0 <fprintf>
    if((pid = fork()) == 0) { demo_server(); exit(0); }
     1f4:	00001097          	auipc	ra,0x1
     1f8:	962080e7          	jalr	-1694(ra) # b56 <fork>
     1fc:	cd1d                	beqz	a0,23a <main+0x112>
    add_worker(pid);
     1fe:	00000097          	auipc	ra,0x0
     202:	e02080e7          	jalr	-510(ra) # 0 <add_worker>
    sleep(10); // Wait for server bind
     206:	4529                	li	a0,10
     208:	00001097          	auipc	ra,0x1
     20c:	9ce080e7          	jalr	-1586(ra) # bd6 <sleep>
    if((pid = fork()) == 0) { demo_client_stream(); exit(0); }
     210:	00001097          	auipc	ra,0x1
     214:	946080e7          	jalr	-1722(ra) # b56 <fork>
     218:	10050b63          	beqz	a0,32e <main+0x206>
    add_worker(pid);
     21c:	00000097          	auipc	ra,0x0
     220:	de4080e7          	jalr	-540(ra) # 0 <add_worker>
    if((pid = fork()) == 0) { demo_client_pulse(); exit(0); }
     224:	00001097          	auipc	ra,0x1
     228:	932080e7          	jalr	-1742(ra) # b56 <fork>
     22c:	16050963          	beqz	a0,39e <main+0x276>
    add_worker(pid);
     230:	00000097          	auipc	ra,0x0
     234:	dd0080e7          	jalr	-560(ra) # 0 <add_worker>
}
     238:	bf39                	j	156 <main+0x2e>
    int s = socket(AF_UNIX, SOCK_STREAM, 0);
     23a:	4601                	li	a2,0
     23c:	4585                	li	a1,1
     23e:	4505                	li	a0,1
     240:	00001097          	auipc	ra,0x1
     244:	b76080e7          	jalr	-1162(ra) # db6 <socket>
     248:	89aa                	mv	s3,a0
    addr.family = AF_UNIX;
     24a:	4785                	li	a5,1
     24c:	f2f41023          	sh	a5,-224(s0)
    strcpy(addr.path, DEMO_PATH);
     250:	00001597          	auipc	a1,0x1
     254:	08058593          	addi	a1,a1,128 # 12d0 <malloc+0x13a>
     258:	f2240513          	addi	a0,s0,-222
     25c:	00000097          	auipc	ra,0x0
     260:	64a080e7          	jalr	1610(ra) # 8a6 <strcpy>
    remove(DEMO_PATH);
     264:	00001517          	auipc	a0,0x1
     268:	06c50513          	addi	a0,a0,108 # 12d0 <malloc+0x13a>
     26c:	00001097          	auipc	ra,0x1
     270:	99a080e7          	jalr	-1638(ra) # c06 <remove>
    if(bind(s, (struct sockaddr*)&addr, sizeof(addr)) < 0) exit(1);
     274:	06e00613          	li	a2,110
     278:	f2040593          	addi	a1,s0,-224
     27c:	854e                	mv	a0,s3
     27e:	00001097          	auipc	ra,0x1
     282:	b42080e7          	jalr	-1214(ra) # dc0 <bind>
     286:	00054963          	bltz	a0,298 <main+0x170>
    listen(s, 5);
     28a:	4595                	li	a1,5
     28c:	854e                	mv	a0,s3
     28e:	00001097          	auipc	ra,0x1
     292:	b3c080e7          	jalr	-1220(ra) # dca <listen>
     296:	a0a5                	j	2fe <main+0x1d6>
    if(bind(s, (struct sockaddr*)&addr, sizeof(addr)) < 0) exit(1);
     298:	4505                	li	a0,1
     29a:	00001097          	auipc	ra,0x1
     29e:	8c4080e7          	jalr	-1852(ra) # b5e <exit>
                    sleep(5); 
     2a2:	4515                	li	a0,5
     2a4:	00001097          	auipc	ra,0x1
     2a8:	932080e7          	jalr	-1742(ra) # bd6 <sleep>
                while((n = read(c, buf, sizeof(buf))) > 0) {
     2ac:	04000613          	li	a2,64
     2b0:	85d6                	mv	a1,s5
     2b2:	8526                	mv	a0,s1
     2b4:	00001097          	auipc	ra,0x1
     2b8:	8c2080e7          	jalr	-1854(ra) # b76 <read>
     2bc:	87aa                	mv	a5,a0
     2be:	02a05163          	blez	a0,2e0 <main+0x1b8>
                    total += n;
     2c2:	00f907bb          	addw	a5,s2,a5
     2c6:	0007891b          	sext.w	s2,a5
                    if(total % 10 == 0) write(c, "ACK", 3);
     2ca:	0347e7bb          	remw	a5,a5,s4
     2ce:	fbf1                	bnez	a5,2a2 <main+0x17a>
     2d0:	460d                	li	a2,3
     2d2:	85ce                	mv	a1,s3
     2d4:	8526                	mv	a0,s1
     2d6:	00001097          	auipc	ra,0x1
     2da:	8a8080e7          	jalr	-1880(ra) # b7e <write>
     2de:	b7d1                	j	2a2 <main+0x17a>
                close(c);
     2e0:	8526                	mv	a0,s1
     2e2:	00001097          	auipc	ra,0x1
     2e6:	8a4080e7          	jalr	-1884(ra) # b86 <close>
                exit(0);
     2ea:	4501                	li	a0,0
     2ec:	00001097          	auipc	ra,0x1
     2f0:	872080e7          	jalr	-1934(ra) # b5e <exit>
            close(c);
     2f4:	8526                	mv	a0,s1
     2f6:	00001097          	auipc	ra,0x1
     2fa:	890080e7          	jalr	-1904(ra) # b86 <close>
        int c = accept(s, 0, 0);
     2fe:	4601                	li	a2,0
     300:	4581                	li	a1,0
     302:	854e                	mv	a0,s3
     304:	00001097          	auipc	ra,0x1
     308:	ad0080e7          	jalr	-1328(ra) # dd4 <accept>
     30c:	84aa                	mv	s1,a0
        if(c >= 0) {
     30e:	fe0548e3          	bltz	a0,2fe <main+0x1d6>
            int pid = fork();
     312:	00001097          	auipc	ra,0x1
     316:	844080e7          	jalr	-1980(ra) # b56 <fork>
     31a:	892a                	mv	s2,a0
            if(pid == 0) {
     31c:	fd61                	bnez	a0,2f4 <main+0x1cc>
                while((n = read(c, buf, sizeof(buf))) > 0) {
     31e:	ee040a93          	addi	s5,s0,-288
                    if(total % 10 == 0) write(c, "ACK", 3);
     322:	4a29                	li	s4,10
     324:	00001997          	auipc	s3,0x1
     328:	fbc98993          	addi	s3,s3,-68 # 12e0 <malloc+0x14a>
     32c:	b741                	j	2ac <main+0x184>
    int c = socket(AF_UNIX, SOCK_STREAM, 0);
     32e:	4601                	li	a2,0
     330:	4585                	li	a1,1
     332:	4505                	li	a0,1
     334:	00001097          	auipc	ra,0x1
     338:	a82080e7          	jalr	-1406(ra) # db6 <socket>
     33c:	84aa                	mv	s1,a0
    addr.family = AF_UNIX;
     33e:	4785                	li	a5,1
     340:	f2f41023          	sh	a5,-224(s0)
    strcpy(addr.path, DEMO_PATH);
     344:	00001597          	auipc	a1,0x1
     348:	f8c58593          	addi	a1,a1,-116 # 12d0 <malloc+0x13a>
     34c:	f2240513          	addi	a0,s0,-222
     350:	00000097          	auipc	ra,0x0
     354:	556080e7          	jalr	1366(ra) # 8a6 <strcpy>
    while(connect(c, (struct sockaddr*)&addr, sizeof(addr)) < 0) sleep(10);
     358:	f2040913          	addi	s2,s0,-224
     35c:	a031                	j	368 <main+0x240>
     35e:	4529                	li	a0,10
     360:	00001097          	auipc	ra,0x1
     364:	876080e7          	jalr	-1930(ra) # bd6 <sleep>
     368:	06e00613          	li	a2,110
     36c:	85ca                	mv	a1,s2
     36e:	8526                	mv	a0,s1
     370:	00001097          	auipc	ra,0x1
     374:	a6e080e7          	jalr	-1426(ra) # dde <connect>
     378:	fe0543e3          	bltz	a0,35e <main+0x236>
        write(c, "STREAM", 6);
     37c:	00001917          	auipc	s2,0x1
     380:	f6c90913          	addi	s2,s2,-148 # 12e8 <malloc+0x152>
     384:	4619                	li	a2,6
     386:	85ca                	mv	a1,s2
     388:	8526                	mv	a0,s1
     38a:	00000097          	auipc	ra,0x0
     38e:	7f4080e7          	jalr	2036(ra) # b7e <write>
        sleep(2); // Fast
     392:	4509                	li	a0,2
     394:	00001097          	auipc	ra,0x1
     398:	842080e7          	jalr	-1982(ra) # bd6 <sleep>
    while(1) {
     39c:	b7e5                	j	384 <main+0x25c>
    addr.family = AF_UNIX;
     39e:	4785                	li	a5,1
     3a0:	f2f41023          	sh	a5,-224(s0)
    strcpy(addr.path, DEMO_PATH);
     3a4:	00001597          	auipc	a1,0x1
     3a8:	f2c58593          	addi	a1,a1,-212 # 12d0 <malloc+0x13a>
     3ac:	f2240513          	addi	a0,s0,-222
     3b0:	00000097          	auipc	ra,0x0
     3b4:	4f6080e7          	jalr	1270(ra) # 8a6 <strcpy>
        if(connect(c, (struct sockaddr*)&addr, sizeof(addr)) == 0) {
     3b8:	f2040a93          	addi	s5,s0,-224
     3bc:	4995                	li	s3,5
                write(c, "BURST", 5);
     3be:	00001a17          	auipc	s4,0x1
     3c2:	f32a0a13          	addi	s4,s4,-206 # 12f0 <malloc+0x15a>
     3c6:	a031                	j	3d2 <main+0x2aa>
        sleep(30); // Sleep 3s
     3c8:	4579                	li	a0,30
     3ca:	00001097          	auipc	ra,0x1
     3ce:	80c080e7          	jalr	-2036(ra) # bd6 <sleep>
        int c = socket(AF_UNIX, SOCK_STREAM, 0);
     3d2:	4601                	li	a2,0
     3d4:	4585                	li	a1,1
     3d6:	4505                	li	a0,1
     3d8:	00001097          	auipc	ra,0x1
     3dc:	9de080e7          	jalr	-1570(ra) # db6 <socket>
     3e0:	84aa                	mv	s1,a0
        if(connect(c, (struct sockaddr*)&addr, sizeof(addr)) == 0) {
     3e2:	06e00613          	li	a2,110
     3e6:	85d6                	mv	a1,s5
     3e8:	00001097          	auipc	ra,0x1
     3ec:	9f6080e7          	jalr	-1546(ra) # dde <connect>
     3f0:	fd61                	bnez	a0,3c8 <main+0x2a0>
     3f2:	894e                	mv	s2,s3
                write(c, "BURST", 5);
     3f4:	864e                	mv	a2,s3
     3f6:	85d2                	mv	a1,s4
     3f8:	8526                	mv	a0,s1
     3fa:	00000097          	auipc	ra,0x0
     3fe:	784080e7          	jalr	1924(ra) # b7e <write>
                sleep(2);
     402:	4509                	li	a0,2
     404:	00000097          	auipc	ra,0x0
     408:	7d2080e7          	jalr	2002(ra) # bd6 <sleep>
            for(int k=0; k<5; k++) {
     40c:	397d                	addiw	s2,s2,-1
     40e:	fe0913e3          	bnez	s2,3f4 <main+0x2cc>
            close(c);
     412:	8526                	mv	a0,s1
     414:	00000097          	auipc	ra,0x0
     418:	772080e7          	jalr	1906(ra) # b86 <close>
     41c:	b775                	j	3c8 <main+0x2a0>
    if(!stats) exit(1);
     41e:	4505                	li	a0,1
     420:	00000097          	auipc	ra,0x0
     424:	73e080e7          	jalr	1854(ra) # b5e <exit>
static void color_yellow(void) { fprintf(2, "\033[33m"); }
     428:	00001597          	auipc	a1,0x1
     42c:	00058593          	mv	a1,a1
     430:	4509                	li	a0,2
     432:	00001097          	auipc	ra,0x1
     436:	c7e080e7          	jalr	-898(ra) # 10b0 <fprintf>
            fprintf(2, "  [DEMO] 1. Streamer (RECV_Q High)   2. Pulser (Connect/Close) \n\n");
     43a:	00001597          	auipc	a1,0x1
     43e:	ff658593          	addi	a1,a1,-10 # 1430 <malloc+0x29a>
     442:	4509                	li	a0,2
     444:	00001097          	auipc	ra,0x1
     448:	c6c080e7          	jalr	-916(ra) # 10b0 <fprintf>
            color_reset();
     44c:	00000097          	auipc	ra,0x0
     450:	c5a080e7          	jalr	-934(ra) # a6 <color_reset>
     454:	a67d                	j	802 <main+0x6da>
            if(s->type == SOCK_STREAM) fprintf(2, "STRM   "); else fprintf(2, "DGRM   ");
     456:	00001597          	auipc	a1,0x1
     45a:	0aa58593          	addi	a1,a1,170 # 1500 <malloc+0x36a>
     45e:	4509                	li	a0,2
     460:	00001097          	auipc	ra,0x1
     464:	c50080e7          	jalr	-944(ra) # 10b0 <fprintf>
     468:	a21d                	j	58e <main+0x466>
            if(s->domain == AF_INET)   fprintf(2, "INET   "); else fprintf(2, "UNIX   ");
     46a:	85ee                	mv	a1,s11
     46c:	4509                	li	a0,2
     46e:	00001097          	auipc	ra,0x1
     472:	c42080e7          	jalr	-958(ra) # 10b0 <fprintf>
     476:	a23d                	j	5a4 <main+0x47c>
static void color_yellow(void) { fprintf(2, "\033[33m"); }
     478:	00001597          	auipc	a1,0x1
     47c:	fb058593          	addi	a1,a1,-80 # 1428 <malloc+0x292>
     480:	4509                	li	a0,2
     482:	00001097          	auipc	ra,0x1
     486:	c2e080e7          	jalr	-978(ra) # 10b0 <fprintf>

            if(s->state == 1) { // LISTEN
                color_yellow(); print_padded_str("LISTEN     ", 11); color_reset();
     48a:	45ad                	li	a1,11
     48c:	00001517          	auipc	a0,0x1
     490:	09450513          	addi	a0,a0,148 # 1520 <malloc+0x38a>
     494:	00000097          	auipc	ra,0x0
     498:	c34080e7          	jalr	-972(ra) # c8 <print_padded_str>
     49c:	00000097          	auipc	ra,0x0
     4a0:	c0a080e7          	jalr	-1014(ra) # a6 <color_reset>
     4a4:	a089                	j	4e6 <main+0x3be>
static void color_green(void) { fprintf(2, "\033[32m"); }
     4a6:	00001597          	auipc	a1,0x1
     4aa:	08a58593          	addi	a1,a1,138 # 1530 <malloc+0x39a>
     4ae:	4509                	li	a0,2
     4b0:	00001097          	auipc	ra,0x1
     4b4:	c00080e7          	jalr	-1024(ra) # 10b0 <fprintf>
            } else if(s->state == 3) { // ESTAB
                color_green(); print_padded_str("ESTAB      ", 11); color_reset();
     4b8:	45ad                	li	a1,11
     4ba:	00001517          	auipc	a0,0x1
     4be:	07e50513          	addi	a0,a0,126 # 1538 <malloc+0x3a2>
     4c2:	00000097          	auipc	ra,0x0
     4c6:	c06080e7          	jalr	-1018(ra) # c8 <print_padded_str>
     4ca:	00000097          	auipc	ra,0x0
     4ce:	bdc080e7          	jalr	-1060(ra) # a6 <color_reset>
     4d2:	a811                	j	4e6 <main+0x3be>
            } else {
                if(s->state==0) print_padded_str("UNCONN     ", 11);
     4d4:	45ad                	li	a1,11
     4d6:	00001517          	auipc	a0,0x1
     4da:	07250513          	addi	a0,a0,114 # 1548 <malloc+0x3b2>
     4de:	00000097          	auipc	ra,0x0
     4e2:	bea080e7          	jalr	-1046(ra) # c8 <print_padded_str>
                else if(s->state==2) print_padded_str("CONNG      ", 11);
                else print_padded_str("DISCON     ", 11);
            }

            if(s->recv_usage > 0) {
     4e6:	06e4a783          	lw	a5,110(s1)
     4ea:	cbfd                	beqz	a5,5e0 <main+0x4b8>
static void color_red(void) { fprintf(2, "\033[31m"); }
     4ec:	00001597          	auipc	a1,0x1
     4f0:	08c58593          	addi	a1,a1,140 # 1578 <malloc+0x3e2>
     4f4:	4509                	li	a0,2
     4f6:	00001097          	auipc	ra,0x1
     4fa:	bba080e7          	jalr	-1094(ra) # 10b0 <fprintf>
                 color_red(); print_padded_int(s->recv_usage, 6); color_reset();
     4fe:	4599                	li	a1,6
     500:	06e4a503          	lw	a0,110(s1)
     504:	00000097          	auipc	ra,0x0
     508:	b2a080e7          	jalr	-1238(ra) # 2e <print_padded_int>
     50c:	00000097          	auipc	ra,0x0
     510:	b9a080e7          	jalr	-1126(ra) # a6 <color_reset>
            } else {
                 print_padded_int(0, 6);
            }
            fprintf(2, "   ");
     514:	00001597          	auipc	a1,0x1
     518:	02c58593          	addi	a1,a1,44 # 1540 <malloc+0x3aa>
     51c:	4509                	li	a0,2
     51e:	00001097          	auipc	ra,0x1
     522:	b92080e7          	jalr	-1134(ra) # 10b0 <fprintf>

            // Local
             if(s->domain == AF_INET) {
     526:	f7a4a703          	lw	a4,-134(s1)
     52a:	4789                	li	a5,2
     52c:	0cf70163          	beq	a4,a5,5ee <main+0x4c6>
                    fprintf(2, "%d.%d.%d.%d:%d", 
                        s->laddr&0xff, (s->laddr>>8)&0xff, (s->laddr>>16)&0xff, (s->laddr>>24)&0xff, s->lport);
                    fprintf(2, "   ");
                }
            } else {
                if(s->lpath[0]) print_padded_str(s->lpath, 20);
     530:	f8c4c783          	lbu	a5,-116(s1)
     534:	10078b63          	beqz	a5,64a <main+0x522>
     538:	45d1                	li	a1,20
     53a:	f8c90513          	addi	a0,s2,-116
     53e:	00000097          	auipc	ra,0x0
     542:	b8a080e7          	jalr	-1142(ra) # c8 <print_padded_str>
                else print_padded_str("(unbound)", 20);
            }
            
            // Remote
            if(s->domain == AF_INET) {
     546:	f7a4a703          	lw	a4,-134(s1)
     54a:	4789                	li	a5,2
     54c:	10f70963          	beq	a4,a5,65e <main+0x536>
                 if(s->raddr) {
                    fprintf(2, "-> %d.%d.%d.%d:%d", 
                        s->raddr&0xff, (s->raddr>>8)&0xff, (s->raddr>>16)&0xff, (s->raddr>>24)&0xff, s->rport);
                 }
            } else {
                 if(s->rpath[0]) fprintf(2, "-> %s", s->rpath);
     550:	0004c783          	lbu	a5,0(s1)
     554:	14079163          	bnez	a5,696 <main+0x56e>
            }
            fprintf(2, "\n");
     558:	85d6                	mv	a1,s5
     55a:	4509                	li	a0,2
     55c:	00001097          	auipc	ra,0x1
     560:	b54080e7          	jalr	-1196(ra) # 10b0 <fprintf>
        for(int i = 0; i < n; i++) {
     564:	0fc90913          	addi	s2,s2,252
     568:	15490263          	beq	s2,s4,6ac <main+0x584>
            fprintf(2, "  ");
     56c:	85da                	mv	a1,s6
     56e:	4509                	li	a0,2
     570:	00001097          	auipc	ra,0x1
     574:	b40080e7          	jalr	-1216(ra) # 10b0 <fprintf>
            if(s->type == SOCK_STREAM) fprintf(2, "STRM   "); else fprintf(2, "DGRM   ");
     578:	84ca                	mv	s1,s2
     57a:	f7e92783          	lw	a5,-130(s2)
     57e:	ed378ce3          	beq	a5,s3,456 <main+0x32e>
     582:	85e6                	mv	a1,s9
     584:	4509                	li	a0,2
     586:	00001097          	auipc	ra,0x1
     58a:	b2a080e7          	jalr	-1238(ra) # 10b0 <fprintf>
            if(s->domain == AF_INET)   fprintf(2, "INET   "); else fprintf(2, "UNIX   ");
     58e:	f7a4a703          	lw	a4,-134(s1)
     592:	4789                	li	a5,2
     594:	ecf70be3          	beq	a4,a5,46a <main+0x342>
     598:	85e2                	mv	a1,s8
     59a:	4509                	li	a0,2
     59c:	00001097          	auipc	ra,0x1
     5a0:	b14080e7          	jalr	-1260(ra) # 10b0 <fprintf>
            if(s->state == 1) { // LISTEN
     5a4:	f824a783          	lw	a5,-126(s1)
     5a8:	ed3788e3          	beq	a5,s3,478 <main+0x350>
            } else if(s->state == 3) { // ESTAB
     5ac:	ef778de3          	beq	a5,s7,4a6 <main+0x37e>
                if(s->state==0) print_padded_str("UNCONN     ", 11);
     5b0:	d395                	beqz	a5,4d4 <main+0x3ac>
                else if(s->state==2) print_padded_str("CONNG      ", 11);
     5b2:	4709                	li	a4,2
     5b4:	00e78c63          	beq	a5,a4,5cc <main+0x4a4>
                else print_padded_str("DISCON     ", 11);
     5b8:	45ad                	li	a1,11
     5ba:	00001517          	auipc	a0,0x1
     5be:	fae50513          	addi	a0,a0,-82 # 1568 <malloc+0x3d2>
     5c2:	00000097          	auipc	ra,0x0
     5c6:	b06080e7          	jalr	-1274(ra) # c8 <print_padded_str>
     5ca:	bf31                	j	4e6 <main+0x3be>
                else if(s->state==2) print_padded_str("CONNG      ", 11);
     5cc:	45ad                	li	a1,11
     5ce:	00001517          	auipc	a0,0x1
     5d2:	f8a50513          	addi	a0,a0,-118 # 1558 <malloc+0x3c2>
     5d6:	00000097          	auipc	ra,0x0
     5da:	af2080e7          	jalr	-1294(ra) # c8 <print_padded_str>
     5de:	b721                	j	4e6 <main+0x3be>
                 print_padded_int(0, 6);
     5e0:	4599                	li	a1,6
     5e2:	4501                	li	a0,0
     5e4:	00000097          	auipc	ra,0x0
     5e8:	a4a080e7          	jalr	-1462(ra) # 2e <print_padded_int>
     5ec:	b725                	j	514 <main+0x3ec>
                if(s->laddr == 0) print_padded_str("*:*", 20);
     5ee:	f864a603          	lw	a2,-122(s1)
     5f2:	ea19                	bnez	a2,608 <main+0x4e0>
     5f4:	45d1                	li	a1,20
     5f6:	00001517          	auipc	a0,0x1
     5fa:	f8a50513          	addi	a0,a0,-118 # 1580 <malloc+0x3ea>
     5fe:	00000097          	auipc	ra,0x0
     602:	aca080e7          	jalr	-1334(ra) # c8 <print_padded_str>
     606:	b781                	j	546 <main+0x41e>
                        s->laddr&0xff, (s->laddr>>8)&0xff, (s->laddr>>16)&0xff, (s->laddr>>24)&0xff, s->lport);
     608:	0106571b          	srliw	a4,a2,0x10
     60c:	0086569b          	srliw	a3,a2,0x8
                    fprintf(2, "%d.%d.%d.%d:%d", 
     610:	f8a4d803          	lhu	a6,-118(s1)
     614:	0186579b          	srliw	a5,a2,0x18
     618:	0ff77713          	zext.b	a4,a4
     61c:	0ff6f693          	zext.b	a3,a3
     620:	0ff67613          	zext.b	a2,a2
     624:	00001597          	auipc	a1,0x1
     628:	f6458593          	addi	a1,a1,-156 # 1588 <malloc+0x3f2>
     62c:	4509                	li	a0,2
     62e:	00001097          	auipc	ra,0x1
     632:	a82080e7          	jalr	-1406(ra) # 10b0 <fprintf>
                    fprintf(2, "   ");
     636:	00001597          	auipc	a1,0x1
     63a:	f0a58593          	addi	a1,a1,-246 # 1540 <malloc+0x3aa>
     63e:	4509                	li	a0,2
     640:	00001097          	auipc	ra,0x1
     644:	a70080e7          	jalr	-1424(ra) # 10b0 <fprintf>
     648:	bdfd                	j	546 <main+0x41e>
                else print_padded_str("(unbound)", 20);
     64a:	45d1                	li	a1,20
     64c:	00001517          	auipc	a0,0x1
     650:	f4c50513          	addi	a0,a0,-180 # 1598 <malloc+0x402>
     654:	00000097          	auipc	ra,0x0
     658:	a74080e7          	jalr	-1420(ra) # c8 <print_padded_str>
     65c:	b5ed                	j	546 <main+0x41e>
                 if(s->raddr) {
     65e:	ffa4a603          	lw	a2,-6(s1)
     662:	ee060be3          	beqz	a2,558 <main+0x430>
                        s->raddr&0xff, (s->raddr>>8)&0xff, (s->raddr>>16)&0xff, (s->raddr>>24)&0xff, s->rport);
     666:	0106571b          	srliw	a4,a2,0x10
     66a:	0086569b          	srliw	a3,a2,0x8
                    fprintf(2, "-> %d.%d.%d.%d:%d", 
     66e:	ffe4d803          	lhu	a6,-2(s1)
     672:	0186579b          	srliw	a5,a2,0x18
     676:	0ff77713          	zext.b	a4,a4
     67a:	0ff6f693          	zext.b	a3,a3
     67e:	0ff67613          	zext.b	a2,a2
     682:	00001597          	auipc	a1,0x1
     686:	f2658593          	addi	a1,a1,-218 # 15a8 <malloc+0x412>
     68a:	4509                	li	a0,2
     68c:	00001097          	auipc	ra,0x1
     690:	a24080e7          	jalr	-1500(ra) # 10b0 <fprintf>
     694:	b5d1                	j	558 <main+0x430>
                 if(s->rpath[0]) fprintf(2, "-> %s", s->rpath);
     696:	8626                	mv	a2,s1
     698:	00001597          	auipc	a1,0x1
     69c:	f2858593          	addi	a1,a1,-216 # 15c0 <malloc+0x42a>
     6a0:	4509                	li	a0,2
     6a2:	00001097          	auipc	ra,0x1
     6a6:	a0e080e7          	jalr	-1522(ra) # 10b0 <fprintf>
     6aa:	b57d                	j	558 <main+0x430>
        }
        
        fprintf(2, "\n");
     6ac:	85d6                	mv	a1,s5
     6ae:	4509                	li	a0,2
     6b0:	00001097          	auipc	ra,0x1
     6b4:	a00080e7          	jalr	-1536(ra) # 10b0 <fprintf>
static void color_cyan(void) { fprintf(2, "\033[36m"); }
     6b8:	00001597          	auipc	a1,0x1
     6bc:	c4858593          	addi	a1,a1,-952 # 1300 <malloc+0x16a>
     6c0:	4509                	li	a0,2
     6c2:	00001097          	auipc	ra,0x1
     6c6:	9ee080e7          	jalr	-1554(ra) # 10b0 <fprintf>
        color_cyan();
        fprintf(2, "  Press Ctrl+C to exit.\n");
     6ca:	00001597          	auipc	a1,0x1
     6ce:	efe58593          	addi	a1,a1,-258 # 15c8 <malloc+0x432>
     6d2:	4509                	li	a0,2
     6d4:	00001097          	auipc	ra,0x1
     6d8:	9dc080e7          	jalr	-1572(ra) # 10b0 <fprintf>
        color_reset();
     6dc:	00000097          	auipc	ra,0x0
     6e0:	9ca080e7          	jalr	-1590(ra) # a6 <color_reset>
        
        sleep(50);
     6e4:	03200513          	li	a0,50
     6e8:	00000097          	auipc	ra,0x0
     6ec:	4ee080e7          	jalr	1262(ra) # bd6 <sleep>
    for(int r = 0; r <= rounds; r++) {
     6f0:	2d05                	addiw	s10,s10,1
     6f2:	ed843783          	ld	a5,-296(s0)
     6f6:	17a7c063          	blt	a5,s10,856 <main+0x72e>
        int n = netstat(stats, MAX_SOCKS);
     6fa:	04000593          	li	a1,64
     6fe:	ed043503          	ld	a0,-304(s0)
     702:	00000097          	auipc	ra,0x0
     706:	6fa080e7          	jalr	1786(ra) # dfc <netstat>
     70a:	84aa                	mv	s1,a0
static void cls(void) { fprintf(2, "\033[2J\033[H"); }
     70c:	00001597          	auipc	a1,0x1
     710:	bec58593          	addi	a1,a1,-1044 # 12f8 <malloc+0x162>
     714:	4509                	li	a0,2
     716:	00001097          	auipc	ra,0x1
     71a:	99a080e7          	jalr	-1638(ra) # 10b0 <fprintf>
static void color_cyan(void) { fprintf(2, "\033[36m"); }
     71e:	00001597          	auipc	a1,0x1
     722:	be258593          	addi	a1,a1,-1054 # 1300 <malloc+0x16a>
     726:	4509                	li	a0,2
     728:	00001097          	auipc	ra,0x1
     72c:	988080e7          	jalr	-1656(ra) # 10b0 <fprintf>
        fprintf(2, "+================================================================+\n");
     730:	00001597          	auipc	a1,0x1
     734:	bd858593          	addi	a1,a1,-1064 # 1308 <malloc+0x172>
     738:	4509                	li	a0,2
     73a:	00001097          	auipc	ra,0x1
     73e:	976080e7          	jalr	-1674(ra) # 10b0 <fprintf>
        fprintf(2, "|             Serein Socket Monitor (sockviz) v3.1               |\n");
     742:	00001597          	auipc	a1,0x1
     746:	c0e58593          	addi	a1,a1,-1010 # 1350 <malloc+0x1ba>
     74a:	4509                	li	a0,2
     74c:	00001097          	auipc	ra,0x1
     750:	964080e7          	jalr	-1692(ra) # 10b0 <fprintf>
        fprintf(2, "|                                                                |\n");
     754:	00001597          	auipc	a1,0x1
     758:	c4458593          	addi	a1,a1,-956 # 1398 <malloc+0x202>
     75c:	4509                	li	a0,2
     75e:	00001097          	auipc	ra,0x1
     762:	952080e7          	jalr	-1710(ra) # 10b0 <fprintf>
        fprintf(2, "|  Rounds: ");
     766:	00001597          	auipc	a1,0x1
     76a:	c7a58593          	addi	a1,a1,-902 # 13e0 <malloc+0x24a>
     76e:	4509                	li	a0,2
     770:	00001097          	auipc	ra,0x1
     774:	940080e7          	jalr	-1728(ra) # 10b0 <fprintf>
        print_padded_int(r, 3);
     778:	458d                	li	a1,3
     77a:	856a                	mv	a0,s10
     77c:	00000097          	auipc	ra,0x0
     780:	8b2080e7          	jalr	-1870(ra) # 2e <print_padded_int>
        fprintf(2, " / ");
     784:	00001597          	auipc	a1,0x1
     788:	c6c58593          	addi	a1,a1,-916 # 13f0 <malloc+0x25a>
     78c:	4509                	li	a0,2
     78e:	00001097          	auipc	ra,0x1
     792:	922080e7          	jalr	-1758(ra) # 10b0 <fprintf>
        print_padded_int(rounds, 3);
     796:	458d                	li	a1,3
     798:	ed843503          	ld	a0,-296(s0)
     79c:	00000097          	auipc	ra,0x0
     7a0:	892080e7          	jalr	-1902(ra) # 2e <print_padded_int>
        fprintf(2, "              Active Sockets: ");
     7a4:	00001597          	auipc	a1,0x1
     7a8:	c5458593          	addi	a1,a1,-940 # 13f8 <malloc+0x262>
     7ac:	4509                	li	a0,2
     7ae:	00001097          	auipc	ra,0x1
     7b2:	902080e7          	jalr	-1790(ra) # 10b0 <fprintf>
        print_padded_int(n, 3);
     7b6:	458d                	li	a1,3
     7b8:	8526                	mv	a0,s1
     7ba:	00000097          	auipc	ra,0x0
     7be:	874080e7          	jalr	-1932(ra) # 2e <print_padded_int>
        fprintf(2, "          |\n");
     7c2:	00001597          	auipc	a1,0x1
     7c6:	c5658593          	addi	a1,a1,-938 # 1418 <malloc+0x282>
     7ca:	4509                	li	a0,2
     7cc:	00001097          	auipc	ra,0x1
     7d0:	8e4080e7          	jalr	-1820(ra) # 10b0 <fprintf>
        fprintf(2, "+================================================================+\n");
     7d4:	00001597          	auipc	a1,0x1
     7d8:	b3458593          	addi	a1,a1,-1228 # 1308 <malloc+0x172>
     7dc:	4509                	li	a0,2
     7de:	00001097          	auipc	ra,0x1
     7e2:	8d2080e7          	jalr	-1838(ra) # 10b0 <fprintf>
        color_reset();
     7e6:	00000097          	auipc	ra,0x0
     7ea:	8c0080e7          	jalr	-1856(ra) # a6 <color_reset>
        fprintf(2, "\n");
     7ee:	85d6                	mv	a1,s5
     7f0:	4509                	li	a0,2
     7f2:	00001097          	auipc	ra,0x1
     7f6:	8be080e7          	jalr	-1858(ra) # 10b0 <fprintf>
        if(demo) {
     7fa:	ec843783          	ld	a5,-312(s0)
     7fe:	c20795e3          	bnez	a5,428 <main+0x300>
        fprintf(2, "  TYPE   DOM    STATE      RECV_Q   LOCAL               REMOTE\n");
     802:	00001597          	auipc	a1,0x1
     806:	c7658593          	addi	a1,a1,-906 # 1478 <malloc+0x2e2>
     80a:	4509                	li	a0,2
     80c:	00001097          	auipc	ra,0x1
     810:	8a4080e7          	jalr	-1884(ra) # 10b0 <fprintf>
        fprintf(2, "  ----   ---    -----      ------   -----               ------\n");
     814:	00001597          	auipc	a1,0x1
     818:	ca458593          	addi	a1,a1,-860 # 14b8 <malloc+0x322>
     81c:	4509                	li	a0,2
     81e:	00001097          	auipc	ra,0x1
     822:	892080e7          	jalr	-1902(ra) # 10b0 <fprintf>
        for(int i = 0; i < n; i++) {
     826:	e89053e3          	blez	s1,6ac <main+0x584>
     82a:	ed043783          	ld	a5,-304(s0)
     82e:	08a78913          	addi	s2,a5,138
     832:	34fd                	addiw	s1,s1,-1
     834:	1482                	slli	s1,s1,0x20
     836:	9081                	srli	s1,s1,0x20
     838:	00649a13          	slli	s4,s1,0x6
     83c:	409a0a33          	sub	s4,s4,s1
     840:	0a0a                	slli	s4,s4,0x2
     842:	ec043783          	ld	a5,-320(s0)
     846:	9a3e                	add	s4,s4,a5
            if(s->type == SOCK_STREAM) fprintf(2, "STRM   "); else fprintf(2, "DGRM   ");
     848:	4985                	li	s3,1
            if(s->domain == AF_INET)   fprintf(2, "INET   "); else fprintf(2, "UNIX   ");
     84a:	00001d97          	auipc	s11,0x1
     84e:	cc6d8d93          	addi	s11,s11,-826 # 1510 <malloc+0x37a>
            } else if(s->state == 3) { // ESTAB
     852:	4b8d                	li	s7,3
     854:	bb21                	j	56c <main+0x444>
    for(int i = 0; i < worker_count; i++) kill(workers[i]);
     856:	00001797          	auipc	a5,0x1
     85a:	e0a7a783          	lw	a5,-502(a5) # 1660 <worker_count>
     85e:	02f05763          	blez	a5,88c <main+0x764>
     862:	00001917          	auipc	s2,0x1
     866:	e0690913          	addi	s2,s2,-506 # 1668 <workers>
     86a:	4481                	li	s1,0
     86c:	00001997          	auipc	s3,0x1
     870:	df498993          	addi	s3,s3,-524 # 1660 <worker_count>
     874:	00092503          	lw	a0,0(s2)
     878:	00000097          	auipc	ra,0x0
     87c:	316080e7          	jalr	790(ra) # b8e <kill>
     880:	2485                	addiw	s1,s1,1
     882:	0911                	addi	s2,s2,4
     884:	0009a783          	lw	a5,0(s3)
     888:	fef4c6e3          	blt	s1,a5,874 <main+0x74c>
    }
    
    // Kill demo workers
    kill_workers();
    while(wait(0) != -1);
     88c:	54fd                	li	s1,-1
     88e:	4501                	li	a0,0
     890:	00000097          	auipc	ra,0x0
     894:	2d6080e7          	jalr	726(ra) # b66 <wait>
     898:	fe951be3          	bne	a0,s1,88e <main+0x766>
    exit(0);
     89c:	4501                	li	a0,0
     89e:	00000097          	auipc	ra,0x0
     8a2:	2c0080e7          	jalr	704(ra) # b5e <exit>

00000000000008a6 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
     8a6:	1141                	addi	sp,sp,-16
     8a8:	e422                	sd	s0,8(sp)
     8aa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8ac:	87aa                	mv	a5,a0
     8ae:	0585                	addi	a1,a1,1
     8b0:	0785                	addi	a5,a5,1
     8b2:	fff5c703          	lbu	a4,-1(a1)
     8b6:	fee78fa3          	sb	a4,-1(a5)
     8ba:	fb75                	bnez	a4,8ae <strcpy+0x8>
    ;
  return os;
}
     8bc:	6422                	ld	s0,8(sp)
     8be:	0141                	addi	sp,sp,16
     8c0:	8082                	ret

00000000000008c2 <strcat>:

char*
strcat(char *s, const char *t)
{
     8c2:	1141                	addi	sp,sp,-16
     8c4:	e422                	sd	s0,8(sp)
     8c6:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
     8c8:	00054783          	lbu	a5,0(a0)
     8cc:	c385                	beqz	a5,8ec <strcat+0x2a>
     8ce:	87aa                	mv	a5,a0
    s++;
     8d0:	0785                	addi	a5,a5,1
  while(*s)
     8d2:	0007c703          	lbu	a4,0(a5)
     8d6:	ff6d                	bnez	a4,8d0 <strcat+0xe>
  while((*s++ = *t++))
     8d8:	0585                	addi	a1,a1,1
     8da:	0785                	addi	a5,a5,1
     8dc:	fff5c703          	lbu	a4,-1(a1)
     8e0:	fee78fa3          	sb	a4,-1(a5)
     8e4:	fb75                	bnez	a4,8d8 <strcat+0x16>
    ;
  return os;
}
     8e6:	6422                	ld	s0,8(sp)
     8e8:	0141                	addi	sp,sp,16
     8ea:	8082                	ret
  while(*s)
     8ec:	87aa                	mv	a5,a0
     8ee:	b7ed                	j	8d8 <strcat+0x16>

00000000000008f0 <strcmp>:


int
strcmp(const char *p, const char *q)
{
     8f0:	1141                	addi	sp,sp,-16
     8f2:	e422                	sd	s0,8(sp)
     8f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     8f6:	00054783          	lbu	a5,0(a0)
     8fa:	cb91                	beqz	a5,90e <strcmp+0x1e>
     8fc:	0005c703          	lbu	a4,0(a1)
     900:	00f71763          	bne	a4,a5,90e <strcmp+0x1e>
    p++, q++;
     904:	0505                	addi	a0,a0,1
     906:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     908:	00054783          	lbu	a5,0(a0)
     90c:	fbe5                	bnez	a5,8fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     90e:	0005c503          	lbu	a0,0(a1)
}
     912:	40a7853b          	subw	a0,a5,a0
     916:	6422                	ld	s0,8(sp)
     918:	0141                	addi	sp,sp,16
     91a:	8082                	ret

000000000000091c <strlen>:

uint
strlen(const char *s)
{
     91c:	1141                	addi	sp,sp,-16
     91e:	e422                	sd	s0,8(sp)
     920:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     922:	00054783          	lbu	a5,0(a0)
     926:	cf91                	beqz	a5,942 <strlen+0x26>
     928:	0505                	addi	a0,a0,1
     92a:	87aa                	mv	a5,a0
     92c:	4685                	li	a3,1
     92e:	9e89                	subw	a3,a3,a0
     930:	00f6853b          	addw	a0,a3,a5
     934:	0785                	addi	a5,a5,1
     936:	fff7c703          	lbu	a4,-1(a5)
     93a:	fb7d                	bnez	a4,930 <strlen+0x14>
    ;
  return n;
}
     93c:	6422                	ld	s0,8(sp)
     93e:	0141                	addi	sp,sp,16
     940:	8082                	ret
  for(n = 0; s[n]; n++)
     942:	4501                	li	a0,0
     944:	bfe5                	j	93c <strlen+0x20>

0000000000000946 <memset>:

void*
memset(void *dst, int c, uint n)
{
     946:	1141                	addi	sp,sp,-16
     948:	e422                	sd	s0,8(sp)
     94a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     94c:	ca19                	beqz	a2,962 <memset+0x1c>
     94e:	87aa                	mv	a5,a0
     950:	1602                	slli	a2,a2,0x20
     952:	9201                	srli	a2,a2,0x20
     954:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     958:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     95c:	0785                	addi	a5,a5,1
     95e:	fee79de3          	bne	a5,a4,958 <memset+0x12>
  }
  return dst;
}
     962:	6422                	ld	s0,8(sp)
     964:	0141                	addi	sp,sp,16
     966:	8082                	ret

0000000000000968 <strchr>:

char*
strchr(const char *s, char c)
{
     968:	1141                	addi	sp,sp,-16
     96a:	e422                	sd	s0,8(sp)
     96c:	0800                	addi	s0,sp,16
  for(; *s; s++)
     96e:	00054783          	lbu	a5,0(a0)
     972:	cb99                	beqz	a5,988 <strchr+0x20>
    if(*s == c)
     974:	00f58763          	beq	a1,a5,982 <strchr+0x1a>
  for(; *s; s++)
     978:	0505                	addi	a0,a0,1
     97a:	00054783          	lbu	a5,0(a0)
     97e:	fbfd                	bnez	a5,974 <strchr+0xc>
      return (char*)s;
  return 0;
     980:	4501                	li	a0,0
}
     982:	6422                	ld	s0,8(sp)
     984:	0141                	addi	sp,sp,16
     986:	8082                	ret
  return 0;
     988:	4501                	li	a0,0
     98a:	bfe5                	j	982 <strchr+0x1a>

000000000000098c <gets>:

char*
gets(char *buf, int max)
{
     98c:	711d                	addi	sp,sp,-96
     98e:	ec86                	sd	ra,88(sp)
     990:	e8a2                	sd	s0,80(sp)
     992:	e4a6                	sd	s1,72(sp)
     994:	e0ca                	sd	s2,64(sp)
     996:	fc4e                	sd	s3,56(sp)
     998:	f852                	sd	s4,48(sp)
     99a:	f456                	sd	s5,40(sp)
     99c:	f05a                	sd	s6,32(sp)
     99e:	ec5e                	sd	s7,24(sp)
     9a0:	e862                	sd	s8,16(sp)
     9a2:	1080                	addi	s0,sp,96
     9a4:	8baa                	mv	s7,a0
     9a6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9a8:	892a                	mv	s2,a0
     9aa:	4481                	li	s1,0
    cc = read(0, &c, 1);
     9ac:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9b0:	4b29                	li	s6,10
     9b2:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     9b4:	89a6                	mv	s3,s1
     9b6:	2485                	addiw	s1,s1,1
     9b8:	0344d763          	bge	s1,s4,9e6 <gets+0x5a>
    cc = read(0, &c, 1);
     9bc:	4605                	li	a2,1
     9be:	85d6                	mv	a1,s5
     9c0:	4501                	li	a0,0
     9c2:	00000097          	auipc	ra,0x0
     9c6:	1b4080e7          	jalr	436(ra) # b76 <read>
    if(cc < 1)
     9ca:	00a05e63          	blez	a0,9e6 <gets+0x5a>
    buf[i++] = c;
     9ce:	faf44783          	lbu	a5,-81(s0)
     9d2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9d6:	01678763          	beq	a5,s6,9e4 <gets+0x58>
     9da:	0905                	addi	s2,s2,1
     9dc:	fd879ce3          	bne	a5,s8,9b4 <gets+0x28>
  for(i=0; i+1 < max; ){
     9e0:	89a6                	mv	s3,s1
     9e2:	a011                	j	9e6 <gets+0x5a>
     9e4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     9e6:	99de                	add	s3,s3,s7
     9e8:	00098023          	sb	zero,0(s3)
  return buf;
}
     9ec:	855e                	mv	a0,s7
     9ee:	60e6                	ld	ra,88(sp)
     9f0:	6446                	ld	s0,80(sp)
     9f2:	64a6                	ld	s1,72(sp)
     9f4:	6906                	ld	s2,64(sp)
     9f6:	79e2                	ld	s3,56(sp)
     9f8:	7a42                	ld	s4,48(sp)
     9fa:	7aa2                	ld	s5,40(sp)
     9fc:	7b02                	ld	s6,32(sp)
     9fe:	6be2                	ld	s7,24(sp)
     a00:	6c42                	ld	s8,16(sp)
     a02:	6125                	addi	sp,sp,96
     a04:	8082                	ret

0000000000000a06 <stat>:

int
stat(const char *n, struct stat *st)
{
     a06:	1101                	addi	sp,sp,-32
     a08:	ec06                	sd	ra,24(sp)
     a0a:	e822                	sd	s0,16(sp)
     a0c:	e426                	sd	s1,8(sp)
     a0e:	e04a                	sd	s2,0(sp)
     a10:	1000                	addi	s0,sp,32
     a12:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a14:	4581                	li	a1,0
     a16:	00000097          	auipc	ra,0x0
     a1a:	188080e7          	jalr	392(ra) # b9e <open>
  if(fd < 0)
     a1e:	02054563          	bltz	a0,a48 <stat+0x42>
     a22:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a24:	85ca                	mv	a1,s2
     a26:	00000097          	auipc	ra,0x0
     a2a:	180080e7          	jalr	384(ra) # ba6 <fstat>
     a2e:	892a                	mv	s2,a0
  close(fd);
     a30:	8526                	mv	a0,s1
     a32:	00000097          	auipc	ra,0x0
     a36:	154080e7          	jalr	340(ra) # b86 <close>
  return r;
}
     a3a:	854a                	mv	a0,s2
     a3c:	60e2                	ld	ra,24(sp)
     a3e:	6442                	ld	s0,16(sp)
     a40:	64a2                	ld	s1,8(sp)
     a42:	6902                	ld	s2,0(sp)
     a44:	6105                	addi	sp,sp,32
     a46:	8082                	ret
    return -1;
     a48:	597d                	li	s2,-1
     a4a:	bfc5                	j	a3a <stat+0x34>

0000000000000a4c <atoi>:

int
atoi(const char *s)
{
     a4c:	1141                	addi	sp,sp,-16
     a4e:	e422                	sd	s0,8(sp)
     a50:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
     a52:	00054703          	lbu	a4,0(a0)
     a56:	02d00793          	li	a5,45
  int neg = 1;
     a5a:	4585                	li	a1,1
  if (*s == '-') {
     a5c:	04f70363          	beq	a4,a5,aa2 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
     a60:	00054703          	lbu	a4,0(a0)
     a64:	fd07079b          	addiw	a5,a4,-48
     a68:	0ff7f793          	zext.b	a5,a5
     a6c:	46a5                	li	a3,9
     a6e:	02f6ed63          	bltu	a3,a5,aa8 <atoi+0x5c>
  n = 0;
     a72:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
     a74:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
     a76:	0505                	addi	a0,a0,1
     a78:	0026979b          	slliw	a5,a3,0x2
     a7c:	9fb5                	addw	a5,a5,a3
     a7e:	0017979b          	slliw	a5,a5,0x1
     a82:	9fb9                	addw	a5,a5,a4
     a84:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
     a88:	00054703          	lbu	a4,0(a0)
     a8c:	fd07079b          	addiw	a5,a4,-48
     a90:	0ff7f793          	zext.b	a5,a5
     a94:	fef671e3          	bgeu	a2,a5,a76 <atoi+0x2a>
  return n * neg;
}
     a98:	02d5853b          	mulw	a0,a1,a3
     a9c:	6422                	ld	s0,8(sp)
     a9e:	0141                	addi	sp,sp,16
     aa0:	8082                	ret
    s++;
     aa2:	0505                	addi	a0,a0,1
    neg = -1;
     aa4:	55fd                	li	a1,-1
     aa6:	bf6d                	j	a60 <atoi+0x14>
  n = 0;
     aa8:	4681                	li	a3,0
     aaa:	b7fd                	j	a98 <atoi+0x4c>

0000000000000aac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     aac:	1141                	addi	sp,sp,-16
     aae:	e422                	sd	s0,8(sp)
     ab0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     ab2:	02b57463          	bgeu	a0,a1,ada <memmove+0x2e>
    while(n-- > 0)
     ab6:	00c05f63          	blez	a2,ad4 <memmove+0x28>
     aba:	1602                	slli	a2,a2,0x20
     abc:	9201                	srli	a2,a2,0x20
     abe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     ac2:	872a                	mv	a4,a0
      *dst++ = *src++;
     ac4:	0585                	addi	a1,a1,1
     ac6:	0705                	addi	a4,a4,1
     ac8:	fff5c683          	lbu	a3,-1(a1)
     acc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ad0:	fee79ae3          	bne	a5,a4,ac4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ad4:	6422                	ld	s0,8(sp)
     ad6:	0141                	addi	sp,sp,16
     ad8:	8082                	ret
    dst += n;
     ada:	00c50733          	add	a4,a0,a2
    src += n;
     ade:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ae0:	fec05ae3          	blez	a2,ad4 <memmove+0x28>
     ae4:	fff6079b          	addiw	a5,a2,-1
     ae8:	1782                	slli	a5,a5,0x20
     aea:	9381                	srli	a5,a5,0x20
     aec:	fff7c793          	not	a5,a5
     af0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     af2:	15fd                	addi	a1,a1,-1
     af4:	177d                	addi	a4,a4,-1
     af6:	0005c683          	lbu	a3,0(a1)
     afa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     afe:	fee79ae3          	bne	a5,a4,af2 <memmove+0x46>
     b02:	bfc9                	j	ad4 <memmove+0x28>

0000000000000b04 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     b04:	1141                	addi	sp,sp,-16
     b06:	e422                	sd	s0,8(sp)
     b08:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     b0a:	ca05                	beqz	a2,b3a <memcmp+0x36>
     b0c:	fff6069b          	addiw	a3,a2,-1
     b10:	1682                	slli	a3,a3,0x20
     b12:	9281                	srli	a3,a3,0x20
     b14:	0685                	addi	a3,a3,1
     b16:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b18:	00054783          	lbu	a5,0(a0)
     b1c:	0005c703          	lbu	a4,0(a1)
     b20:	00e79863          	bne	a5,a4,b30 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b24:	0505                	addi	a0,a0,1
    p2++;
     b26:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b28:	fed518e3          	bne	a0,a3,b18 <memcmp+0x14>
  }
  return 0;
     b2c:	4501                	li	a0,0
     b2e:	a019                	j	b34 <memcmp+0x30>
      return *p1 - *p2;
     b30:	40e7853b          	subw	a0,a5,a4
}
     b34:	6422                	ld	s0,8(sp)
     b36:	0141                	addi	sp,sp,16
     b38:	8082                	ret
  return 0;
     b3a:	4501                	li	a0,0
     b3c:	bfe5                	j	b34 <memcmp+0x30>

0000000000000b3e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b3e:	1141                	addi	sp,sp,-16
     b40:	e406                	sd	ra,8(sp)
     b42:	e022                	sd	s0,0(sp)
     b44:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     b46:	00000097          	auipc	ra,0x0
     b4a:	f66080e7          	jalr	-154(ra) # aac <memmove>
}
     b4e:	60a2                	ld	ra,8(sp)
     b50:	6402                	ld	s0,0(sp)
     b52:	0141                	addi	sp,sp,16
     b54:	8082                	ret

0000000000000b56 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
     b56:	4885                	li	a7,1
 ecall
     b58:	00000073          	ecall
 ret
     b5c:	8082                	ret

0000000000000b5e <exit>:
.global exit
exit:
 li a7, SYS_exit
     b5e:	4889                	li	a7,2
 ecall
     b60:	00000073          	ecall
 ret
     b64:	8082                	ret

0000000000000b66 <wait>:
.global wait
wait:
 li a7, SYS_wait
     b66:	488d                	li	a7,3
 ecall
     b68:	00000073          	ecall
 ret
     b6c:	8082                	ret

0000000000000b6e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b6e:	4891                	li	a7,4
 ecall
     b70:	00000073          	ecall
 ret
     b74:	8082                	ret

0000000000000b76 <read>:
.global read
read:
 li a7, SYS_read
     b76:	4895                	li	a7,5
 ecall
     b78:	00000073          	ecall
 ret
     b7c:	8082                	ret

0000000000000b7e <write>:
.global write
write:
 li a7, SYS_write
     b7e:	48c1                	li	a7,16
 ecall
     b80:	00000073          	ecall
 ret
     b84:	8082                	ret

0000000000000b86 <close>:
.global close
close:
 li a7, SYS_close
     b86:	48d5                	li	a7,21
 ecall
     b88:	00000073          	ecall
 ret
     b8c:	8082                	ret

0000000000000b8e <kill>:
.global kill
kill:
 li a7, SYS_kill
     b8e:	4899                	li	a7,6
 ecall
     b90:	00000073          	ecall
 ret
     b94:	8082                	ret

0000000000000b96 <exec>:
.global exec
exec:
 li a7, SYS_exec
     b96:	489d                	li	a7,7
 ecall
     b98:	00000073          	ecall
 ret
     b9c:	8082                	ret

0000000000000b9e <open>:
.global open
open:
 li a7, SYS_open
     b9e:	48bd                	li	a7,15
 ecall
     ba0:	00000073          	ecall
 ret
     ba4:	8082                	ret

0000000000000ba6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ba6:	48a1                	li	a7,8
 ecall
     ba8:	00000073          	ecall
 ret
     bac:	8082                	ret

0000000000000bae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     bae:	48d1                	li	a7,20
 ecall
     bb0:	00000073          	ecall
 ret
     bb4:	8082                	ret

0000000000000bb6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     bb6:	48a5                	li	a7,9
 ecall
     bb8:	00000073          	ecall
 ret
     bbc:	8082                	ret

0000000000000bbe <dup>:
.global dup
dup:
 li a7, SYS_dup
     bbe:	48a9                	li	a7,10
 ecall
     bc0:	00000073          	ecall
 ret
     bc4:	8082                	ret

0000000000000bc6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     bc6:	48ad                	li	a7,11
 ecall
     bc8:	00000073          	ecall
 ret
     bcc:	8082                	ret

0000000000000bce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     bce:	48b1                	li	a7,12
 ecall
     bd0:	00000073          	ecall
 ret
     bd4:	8082                	ret

0000000000000bd6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     bd6:	48b5                	li	a7,13
 ecall
     bd8:	00000073          	ecall
 ret
     bdc:	8082                	ret

0000000000000bde <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     bde:	48b9                	li	a7,14
 ecall
     be0:	00000073          	ecall
 ret
     be4:	8082                	ret

0000000000000be6 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
     be6:	48d9                	li	a7,22
 ecall
     be8:	00000073          	ecall
 ret
     bec:	8082                	ret

0000000000000bee <dev>:
.global dev
dev:
 li a7, SYS_dev
     bee:	48dd                	li	a7,23
 ecall
     bf0:	00000073          	ecall
 ret
     bf4:	8082                	ret

0000000000000bf6 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
     bf6:	48e1                	li	a7,24
 ecall
     bf8:	00000073          	ecall
 ret
     bfc:	8082                	ret

0000000000000bfe <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     bfe:	48e5                	li	a7,25
 ecall
     c00:	00000073          	ecall
 ret
     c04:	8082                	ret

0000000000000c06 <remove>:
.global remove
remove:
 li a7, SYS_remove
     c06:	48c5                	li	a7,17
 ecall
     c08:	00000073          	ecall
 ret
     c0c:	8082                	ret

0000000000000c0e <trace>:
.global trace
trace:
 li a7, SYS_trace
     c0e:	48c9                	li	a7,18
 ecall
     c10:	00000073          	ecall
 ret
     c14:	8082                	ret

0000000000000c16 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     c16:	48cd                	li	a7,19
 ecall
     c18:	00000073          	ecall
 ret
     c1c:	8082                	ret

0000000000000c1e <rename>:
.global rename
rename:
 li a7, SYS_rename
     c1e:	48e9                	li	a7,26
 ecall
     c20:	00000073          	ecall
 ret
     c24:	8082                	ret

0000000000000c26 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
     c26:	48ed                	li	a7,27
 ecall
     c28:	00000073          	ecall
 ret
     c2c:	8082                	ret

0000000000000c2e <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
     c2e:	48f1                	li	a7,28
 ecall
     c30:	00000073          	ecall
 ret
     c34:	8082                	ret

0000000000000c36 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
     c36:	48f5                	li	a7,29
 ecall
     c38:	00000073          	ecall
 ret
     c3c:	8082                	ret

0000000000000c3e <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
     c3e:	48f9                	li	a7,30
 ecall
     c40:	00000073          	ecall
 ret
     c44:	8082                	ret

0000000000000c46 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
     c46:	48fd                	li	a7,31
 ecall
     c48:	00000073          	ecall
 ret
     c4c:	8082                	ret

0000000000000c4e <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
     c4e:	02000893          	li	a7,32
 ecall
     c52:	00000073          	ecall
 ret
     c56:	8082                	ret

0000000000000c58 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     c58:	02100893          	li	a7,33
 ecall
     c5c:	00000073          	ecall
 ret
     c60:	8082                	ret

0000000000000c62 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
     c62:	02200893          	li	a7,34
 ecall
     c66:	00000073          	ecall
 ret
     c6a:	8082                	ret

0000000000000c6c <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
     c6c:	02300893          	li	a7,35
 ecall
     c70:	00000073          	ecall
 ret
     c74:	8082                	ret

0000000000000c76 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
     c76:	02400893          	li	a7,36
 ecall
     c7a:	00000073          	ecall
 ret
     c7e:	8082                	ret

0000000000000c80 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
     c80:	02500893          	li	a7,37
 ecall
     c84:	00000073          	ecall
 ret
     c88:	8082                	ret

0000000000000c8a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
     c8a:	02600893          	li	a7,38
 ecall
     c8e:	00000073          	ecall
 ret
     c92:	8082                	ret

0000000000000c94 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
     c94:	02700893          	li	a7,39
 ecall
     c98:	00000073          	ecall
 ret
     c9c:	8082                	ret

0000000000000c9e <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
     c9e:	02800893          	li	a7,40
 ecall
     ca2:	00000073          	ecall
 ret
     ca6:	8082                	ret

0000000000000ca8 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
     ca8:	02900893          	li	a7,41
 ecall
     cac:	00000073          	ecall
 ret
     cb0:	8082                	ret

0000000000000cb2 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
     cb2:	02a00893          	li	a7,42
 ecall
     cb6:	00000073          	ecall
 ret
     cba:	8082                	ret

0000000000000cbc <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
     cbc:	02b00893          	li	a7,43
 ecall
     cc0:	00000073          	ecall
 ret
     cc4:	8082                	ret

0000000000000cc6 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
     cc6:	02c00893          	li	a7,44
 ecall
     cca:	00000073          	ecall
 ret
     cce:	8082                	ret

0000000000000cd0 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
     cd0:	02d00893          	li	a7,45
 ecall
     cd4:	00000073          	ecall
 ret
     cd8:	8082                	ret

0000000000000cda <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
     cda:	02e00893          	li	a7,46
 ecall
     cde:	00000073          	ecall
 ret
     ce2:	8082                	ret

0000000000000ce4 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
     ce4:	02f00893          	li	a7,47
 ecall
     ce8:	00000073          	ecall
 ret
     cec:	8082                	ret

0000000000000cee <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
     cee:	03000893          	li	a7,48
 ecall
     cf2:	00000073          	ecall
 ret
     cf6:	8082                	ret

0000000000000cf8 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
     cf8:	03100893          	li	a7,49
 ecall
     cfc:	00000073          	ecall
 ret
     d00:	8082                	ret

0000000000000d02 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
     d02:	03200893          	li	a7,50
 ecall
     d06:	00000073          	ecall
 ret
     d0a:	8082                	ret

0000000000000d0c <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
     d0c:	03300893          	li	a7,51
 ecall
     d10:	00000073          	ecall
 ret
     d14:	8082                	ret

0000000000000d16 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
     d16:	03400893          	li	a7,52
 ecall
     d1a:	00000073          	ecall
 ret
     d1e:	8082                	ret

0000000000000d20 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
     d20:	03500893          	li	a7,53
 ecall
     d24:	00000073          	ecall
 ret
     d28:	8082                	ret

0000000000000d2a <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
     d2a:	03600893          	li	a7,54
 ecall
     d2e:	00000073          	ecall
 ret
     d32:	8082                	ret

0000000000000d34 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
     d34:	03700893          	li	a7,55
 ecall
     d38:	00000073          	ecall
 ret
     d3c:	8082                	ret

0000000000000d3e <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
     d3e:	03800893          	li	a7,56
 ecall
     d42:	00000073          	ecall
 ret
     d46:	8082                	ret

0000000000000d48 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
     d48:	03900893          	li	a7,57
 ecall
     d4c:	00000073          	ecall
 ret
     d50:	8082                	ret

0000000000000d52 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
     d52:	03a00893          	li	a7,58
 ecall
     d56:	00000073          	ecall
 ret
     d5a:	8082                	ret

0000000000000d5c <poll>:
.global poll
poll:
 li a7, SYS_poll
     d5c:	03b00893          	li	a7,59
 ecall
     d60:	00000073          	ecall
 ret
     d64:	8082                	ret

0000000000000d66 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
     d66:	03c00893          	li	a7,60
 ecall
     d6a:	00000073          	ecall
 ret
     d6e:	8082                	ret

0000000000000d70 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
     d70:	03d00893          	li	a7,61
 ecall
     d74:	00000073          	ecall
 ret
     d78:	8082                	ret

0000000000000d7a <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
     d7a:	03e00893          	li	a7,62
 ecall
     d7e:	00000073          	ecall
 ret
     d82:	8082                	ret

0000000000000d84 <clone>:
.global clone
clone:
 li a7, SYS_clone
     d84:	03f00893          	li	a7,63
 ecall
     d88:	00000073          	ecall
 ret
     d8c:	8082                	ret

0000000000000d8e <futex>:
.global futex
futex:
 li a7, SYS_futex
     d8e:	04000893          	li	a7,64
 ecall
     d92:	00000073          	ecall
 ret
     d96:	8082                	ret

0000000000000d98 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
     d98:	04100893          	li	a7,65
 ecall
     d9c:	00000073          	ecall
 ret
     da0:	8082                	ret

0000000000000da2 <halt>:
.global halt
halt:
 li a7, SYS_halt
     da2:	04200893          	li	a7,66
 ecall
     da6:	00000073          	ecall
 ret
     daa:	8082                	ret

0000000000000dac <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
     dac:	04300893          	li	a7,67
 ecall
     db0:	00000073          	ecall
 ret
     db4:	8082                	ret

0000000000000db6 <socket>:
.global socket
socket:
 li a7, SYS_socket
     db6:	04400893          	li	a7,68
 ecall
     dba:	00000073          	ecall
 ret
     dbe:	8082                	ret

0000000000000dc0 <bind>:
.global bind
bind:
 li a7, SYS_bind
     dc0:	04500893          	li	a7,69
 ecall
     dc4:	00000073          	ecall
 ret
     dc8:	8082                	ret

0000000000000dca <listen>:
.global listen
listen:
 li a7, SYS_listen
     dca:	04600893          	li	a7,70
 ecall
     dce:	00000073          	ecall
 ret
     dd2:	8082                	ret

0000000000000dd4 <accept>:
.global accept
accept:
 li a7, SYS_accept
     dd4:	04700893          	li	a7,71
 ecall
     dd8:	00000073          	ecall
 ret
     ddc:	8082                	ret

0000000000000dde <connect>:
.global connect
connect:
 li a7, SYS_connect
     dde:	04800893          	li	a7,72
 ecall
     de2:	00000073          	ecall
 ret
     de6:	8082                	ret

0000000000000de8 <send>:
.global send
send:
 li a7, SYS_send
     de8:	04900893          	li	a7,73
 ecall
     dec:	00000073          	ecall
 ret
     df0:	8082                	ret

0000000000000df2 <recv>:
.global recv
recv:
 li a7, SYS_recv
     df2:	04a00893          	li	a7,74
 ecall
     df6:	00000073          	ecall
 ret
     dfa:	8082                	ret

0000000000000dfc <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
     dfc:	04b00893          	li	a7,75
 ecall
     e00:	00000073          	ecall
 ret
     e04:	8082                	ret

0000000000000e06 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e06:	1101                	addi	sp,sp,-32
     e08:	ec06                	sd	ra,24(sp)
     e0a:	e822                	sd	s0,16(sp)
     e0c:	1000                	addi	s0,sp,32
     e0e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e12:	4605                	li	a2,1
     e14:	fef40593          	addi	a1,s0,-17
     e18:	00000097          	auipc	ra,0x0
     e1c:	d66080e7          	jalr	-666(ra) # b7e <write>
}
     e20:	60e2                	ld	ra,24(sp)
     e22:	6442                	ld	s0,16(sp)
     e24:	6105                	addi	sp,sp,32
     e26:	8082                	ret

0000000000000e28 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     e28:	7139                	addi	sp,sp,-64
     e2a:	fc06                	sd	ra,56(sp)
     e2c:	f822                	sd	s0,48(sp)
     e2e:	f426                	sd	s1,40(sp)
     e30:	f04a                	sd	s2,32(sp)
     e32:	ec4e                	sd	s3,24(sp)
     e34:	0080                	addi	s0,sp,64
     e36:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e38:	c299                	beqz	a3,e3e <printint+0x16>
     e3a:	0805c863          	bltz	a1,eca <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e3e:	2581                	sext.w	a1,a1
  neg = 0;
     e40:	4881                	li	a7,0
  }

  i = 0;
     e42:	fc040993          	addi	s3,s0,-64
  neg = 0;
     e46:	86ce                	mv	a3,s3
  i = 0;
     e48:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     e4a:	2601                	sext.w	a2,a2
     e4c:	00000517          	auipc	a0,0x0
     e50:	7fc50513          	addi	a0,a0,2044 # 1648 <digits>
     e54:	883a                	mv	a6,a4
     e56:	2705                	addiw	a4,a4,1
     e58:	02c5f7bb          	remuw	a5,a1,a2
     e5c:	1782                	slli	a5,a5,0x20
     e5e:	9381                	srli	a5,a5,0x20
     e60:	97aa                	add	a5,a5,a0
     e62:	0007c783          	lbu	a5,0(a5)
     e66:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     e6a:	0005879b          	sext.w	a5,a1
     e6e:	02c5d5bb          	divuw	a1,a1,a2
     e72:	0685                	addi	a3,a3,1
     e74:	fec7f0e3          	bgeu	a5,a2,e54 <printint+0x2c>
  if(neg)
     e78:	00088c63          	beqz	a7,e90 <printint+0x68>
    buf[i++] = '-';
     e7c:	fd070793          	addi	a5,a4,-48
     e80:	00878733          	add	a4,a5,s0
     e84:	02d00793          	li	a5,45
     e88:	fef70823          	sb	a5,-16(a4)
     e8c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     e90:	02e05663          	blez	a4,ebc <printint+0x94>
     e94:	fc040913          	addi	s2,s0,-64
     e98:	993a                	add	s2,s2,a4
     e9a:	19fd                	addi	s3,s3,-1
     e9c:	99ba                	add	s3,s3,a4
     e9e:	377d                	addiw	a4,a4,-1
     ea0:	1702                	slli	a4,a4,0x20
     ea2:	9301                	srli	a4,a4,0x20
     ea4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     ea8:	fff94583          	lbu	a1,-1(s2)
     eac:	8526                	mv	a0,s1
     eae:	00000097          	auipc	ra,0x0
     eb2:	f58080e7          	jalr	-168(ra) # e06 <putc>
  while(--i >= 0)
     eb6:	197d                	addi	s2,s2,-1
     eb8:	ff3918e3          	bne	s2,s3,ea8 <printint+0x80>
}
     ebc:	70e2                	ld	ra,56(sp)
     ebe:	7442                	ld	s0,48(sp)
     ec0:	74a2                	ld	s1,40(sp)
     ec2:	7902                	ld	s2,32(sp)
     ec4:	69e2                	ld	s3,24(sp)
     ec6:	6121                	addi	sp,sp,64
     ec8:	8082                	ret
    x = -xx;
     eca:	40b005bb          	negw	a1,a1
    neg = 1;
     ece:	4885                	li	a7,1
    x = -xx;
     ed0:	bf8d                	j	e42 <printint+0x1a>

0000000000000ed2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     ed2:	7119                	addi	sp,sp,-128
     ed4:	fc86                	sd	ra,120(sp)
     ed6:	f8a2                	sd	s0,112(sp)
     ed8:	f4a6                	sd	s1,104(sp)
     eda:	f0ca                	sd	s2,96(sp)
     edc:	ecce                	sd	s3,88(sp)
     ede:	e8d2                	sd	s4,80(sp)
     ee0:	e4d6                	sd	s5,72(sp)
     ee2:	e0da                	sd	s6,64(sp)
     ee4:	fc5e                	sd	s7,56(sp)
     ee6:	f862                	sd	s8,48(sp)
     ee8:	f466                	sd	s9,40(sp)
     eea:	f06a                	sd	s10,32(sp)
     eec:	ec6e                	sd	s11,24(sp)
     eee:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     ef0:	0005c903          	lbu	s2,0(a1)
     ef4:	18090f63          	beqz	s2,1092 <vprintf+0x1c0>
     ef8:	8aaa                	mv	s5,a0
     efa:	8b32                	mv	s6,a2
     efc:	00158493          	addi	s1,a1,1
  state = 0;
     f00:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f02:	02500a13          	li	s4,37
     f06:	4c55                	li	s8,21
     f08:	00000c97          	auipc	s9,0x0
     f0c:	6e8c8c93          	addi	s9,s9,1768 # 15f0 <malloc+0x45a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     f10:	02800d93          	li	s11,40
  putc(fd, 'x');
     f14:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f16:	00000b97          	auipc	s7,0x0
     f1a:	732b8b93          	addi	s7,s7,1842 # 1648 <digits>
     f1e:	a839                	j	f3c <vprintf+0x6a>
        putc(fd, c);
     f20:	85ca                	mv	a1,s2
     f22:	8556                	mv	a0,s5
     f24:	00000097          	auipc	ra,0x0
     f28:	ee2080e7          	jalr	-286(ra) # e06 <putc>
     f2c:	a019                	j	f32 <vprintf+0x60>
    } else if(state == '%'){
     f2e:	01498d63          	beq	s3,s4,f48 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
     f32:	0485                	addi	s1,s1,1
     f34:	fff4c903          	lbu	s2,-1(s1)
     f38:	14090d63          	beqz	s2,1092 <vprintf+0x1c0>
    if(state == 0){
     f3c:	fe0999e3          	bnez	s3,f2e <vprintf+0x5c>
      if(c == '%'){
     f40:	ff4910e3          	bne	s2,s4,f20 <vprintf+0x4e>
        state = '%';
     f44:	89d2                	mv	s3,s4
     f46:	b7f5                	j	f32 <vprintf+0x60>
      if(c == 'd'){
     f48:	11490c63          	beq	s2,s4,1060 <vprintf+0x18e>
     f4c:	f9d9079b          	addiw	a5,s2,-99
     f50:	0ff7f793          	zext.b	a5,a5
     f54:	10fc6e63          	bltu	s8,a5,1070 <vprintf+0x19e>
     f58:	f9d9079b          	addiw	a5,s2,-99
     f5c:	0ff7f713          	zext.b	a4,a5
     f60:	10ec6863          	bltu	s8,a4,1070 <vprintf+0x19e>
     f64:	00271793          	slli	a5,a4,0x2
     f68:	97e6                	add	a5,a5,s9
     f6a:	439c                	lw	a5,0(a5)
     f6c:	97e6                	add	a5,a5,s9
     f6e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     f70:	008b0913          	addi	s2,s6,8
     f74:	4685                	li	a3,1
     f76:	4629                	li	a2,10
     f78:	000b2583          	lw	a1,0(s6)
     f7c:	8556                	mv	a0,s5
     f7e:	00000097          	auipc	ra,0x0
     f82:	eaa080e7          	jalr	-342(ra) # e28 <printint>
     f86:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f88:	4981                	li	s3,0
     f8a:	b765                	j	f32 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f8c:	008b0913          	addi	s2,s6,8
     f90:	4681                	li	a3,0
     f92:	4629                	li	a2,10
     f94:	000b2583          	lw	a1,0(s6)
     f98:	8556                	mv	a0,s5
     f9a:	00000097          	auipc	ra,0x0
     f9e:	e8e080e7          	jalr	-370(ra) # e28 <printint>
     fa2:	8b4a                	mv	s6,s2
      state = 0;
     fa4:	4981                	li	s3,0
     fa6:	b771                	j	f32 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
     fa8:	008b0913          	addi	s2,s6,8
     fac:	4681                	li	a3,0
     fae:	866a                	mv	a2,s10
     fb0:	000b2583          	lw	a1,0(s6)
     fb4:	8556                	mv	a0,s5
     fb6:	00000097          	auipc	ra,0x0
     fba:	e72080e7          	jalr	-398(ra) # e28 <printint>
     fbe:	8b4a                	mv	s6,s2
      state = 0;
     fc0:	4981                	li	s3,0
     fc2:	bf85                	j	f32 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
     fc4:	008b0793          	addi	a5,s6,8
     fc8:	f8f43423          	sd	a5,-120(s0)
     fcc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
     fd0:	03000593          	li	a1,48
     fd4:	8556                	mv	a0,s5
     fd6:	00000097          	auipc	ra,0x0
     fda:	e30080e7          	jalr	-464(ra) # e06 <putc>
  putc(fd, 'x');
     fde:	07800593          	li	a1,120
     fe2:	8556                	mv	a0,s5
     fe4:	00000097          	auipc	ra,0x0
     fe8:	e22080e7          	jalr	-478(ra) # e06 <putc>
     fec:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fee:	03c9d793          	srli	a5,s3,0x3c
     ff2:	97de                	add	a5,a5,s7
     ff4:	0007c583          	lbu	a1,0(a5)
     ff8:	8556                	mv	a0,s5
     ffa:	00000097          	auipc	ra,0x0
     ffe:	e0c080e7          	jalr	-500(ra) # e06 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1002:	0992                	slli	s3,s3,0x4
    1004:	397d                	addiw	s2,s2,-1
    1006:	fe0914e3          	bnez	s2,fee <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    100a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    100e:	4981                	li	s3,0
    1010:	b70d                	j	f32 <vprintf+0x60>
        s = va_arg(ap, char*);
    1012:	008b0913          	addi	s2,s6,8
    1016:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    101a:	02098163          	beqz	s3,103c <vprintf+0x16a>
        while(*s != 0){
    101e:	0009c583          	lbu	a1,0(s3)
    1022:	c5ad                	beqz	a1,108c <vprintf+0x1ba>
          putc(fd, *s);
    1024:	8556                	mv	a0,s5
    1026:	00000097          	auipc	ra,0x0
    102a:	de0080e7          	jalr	-544(ra) # e06 <putc>
          s++;
    102e:	0985                	addi	s3,s3,1
        while(*s != 0){
    1030:	0009c583          	lbu	a1,0(s3)
    1034:	f9e5                	bnez	a1,1024 <vprintf+0x152>
        s = va_arg(ap, char*);
    1036:	8b4a                	mv	s6,s2
      state = 0;
    1038:	4981                	li	s3,0
    103a:	bde5                	j	f32 <vprintf+0x60>
          s = "(null)";
    103c:	00000997          	auipc	s3,0x0
    1040:	5ac98993          	addi	s3,s3,1452 # 15e8 <malloc+0x452>
        while(*s != 0){
    1044:	85ee                	mv	a1,s11
    1046:	bff9                	j	1024 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    1048:	008b0913          	addi	s2,s6,8
    104c:	000b4583          	lbu	a1,0(s6)
    1050:	8556                	mv	a0,s5
    1052:	00000097          	auipc	ra,0x0
    1056:	db4080e7          	jalr	-588(ra) # e06 <putc>
    105a:	8b4a                	mv	s6,s2
      state = 0;
    105c:	4981                	li	s3,0
    105e:	bdd1                	j	f32 <vprintf+0x60>
        putc(fd, c);
    1060:	85d2                	mv	a1,s4
    1062:	8556                	mv	a0,s5
    1064:	00000097          	auipc	ra,0x0
    1068:	da2080e7          	jalr	-606(ra) # e06 <putc>
      state = 0;
    106c:	4981                	li	s3,0
    106e:	b5d1                	j	f32 <vprintf+0x60>
        putc(fd, '%');
    1070:	85d2                	mv	a1,s4
    1072:	8556                	mv	a0,s5
    1074:	00000097          	auipc	ra,0x0
    1078:	d92080e7          	jalr	-622(ra) # e06 <putc>
        putc(fd, c);
    107c:	85ca                	mv	a1,s2
    107e:	8556                	mv	a0,s5
    1080:	00000097          	auipc	ra,0x0
    1084:	d86080e7          	jalr	-634(ra) # e06 <putc>
      state = 0;
    1088:	4981                	li	s3,0
    108a:	b565                	j	f32 <vprintf+0x60>
        s = va_arg(ap, char*);
    108c:	8b4a                	mv	s6,s2
      state = 0;
    108e:	4981                	li	s3,0
    1090:	b54d                	j	f32 <vprintf+0x60>
    }
  }
}
    1092:	70e6                	ld	ra,120(sp)
    1094:	7446                	ld	s0,112(sp)
    1096:	74a6                	ld	s1,104(sp)
    1098:	7906                	ld	s2,96(sp)
    109a:	69e6                	ld	s3,88(sp)
    109c:	6a46                	ld	s4,80(sp)
    109e:	6aa6                	ld	s5,72(sp)
    10a0:	6b06                	ld	s6,64(sp)
    10a2:	7be2                	ld	s7,56(sp)
    10a4:	7c42                	ld	s8,48(sp)
    10a6:	7ca2                	ld	s9,40(sp)
    10a8:	7d02                	ld	s10,32(sp)
    10aa:	6de2                	ld	s11,24(sp)
    10ac:	6109                	addi	sp,sp,128
    10ae:	8082                	ret

00000000000010b0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10b0:	715d                	addi	sp,sp,-80
    10b2:	ec06                	sd	ra,24(sp)
    10b4:	e822                	sd	s0,16(sp)
    10b6:	1000                	addi	s0,sp,32
    10b8:	e010                	sd	a2,0(s0)
    10ba:	e414                	sd	a3,8(s0)
    10bc:	e818                	sd	a4,16(s0)
    10be:	ec1c                	sd	a5,24(s0)
    10c0:	03043023          	sd	a6,32(s0)
    10c4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    10c8:	8622                	mv	a2,s0
    10ca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    10ce:	00000097          	auipc	ra,0x0
    10d2:	e04080e7          	jalr	-508(ra) # ed2 <vprintf>
}
    10d6:	60e2                	ld	ra,24(sp)
    10d8:	6442                	ld	s0,16(sp)
    10da:	6161                	addi	sp,sp,80
    10dc:	8082                	ret

00000000000010de <printf>:

void
printf(const char *fmt, ...)
{
    10de:	711d                	addi	sp,sp,-96
    10e0:	ec06                	sd	ra,24(sp)
    10e2:	e822                	sd	s0,16(sp)
    10e4:	1000                	addi	s0,sp,32
    10e6:	e40c                	sd	a1,8(s0)
    10e8:	e810                	sd	a2,16(s0)
    10ea:	ec14                	sd	a3,24(s0)
    10ec:	f018                	sd	a4,32(s0)
    10ee:	f41c                	sd	a5,40(s0)
    10f0:	03043823          	sd	a6,48(s0)
    10f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    10f8:	00840613          	addi	a2,s0,8
    10fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1100:	85aa                	mv	a1,a0
    1102:	4505                	li	a0,1
    1104:	00000097          	auipc	ra,0x0
    1108:	dce080e7          	jalr	-562(ra) # ed2 <vprintf>
}
    110c:	60e2                	ld	ra,24(sp)
    110e:	6442                	ld	s0,16(sp)
    1110:	6125                	addi	sp,sp,96
    1112:	8082                	ret

0000000000001114 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1114:	1141                	addi	sp,sp,-16
    1116:	e422                	sd	s0,8(sp)
    1118:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    111a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    111e:	00000797          	auipc	a5,0x0
    1122:	56a7b783          	ld	a5,1386(a5) # 1688 <freep>
    1126:	a02d                	j	1150 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1128:	4618                	lw	a4,8(a2)
    112a:	9f2d                	addw	a4,a4,a1
    112c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1130:	6398                	ld	a4,0(a5)
    1132:	6310                	ld	a2,0(a4)
    1134:	a83d                	j	1172 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1136:	ff852703          	lw	a4,-8(a0)
    113a:	9f31                	addw	a4,a4,a2
    113c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    113e:	ff053683          	ld	a3,-16(a0)
    1142:	a091                	j	1186 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1144:	6398                	ld	a4,0(a5)
    1146:	00e7e463          	bltu	a5,a4,114e <free+0x3a>
    114a:	00e6ea63          	bltu	a3,a4,115e <free+0x4a>
{
    114e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1150:	fed7fae3          	bgeu	a5,a3,1144 <free+0x30>
    1154:	6398                	ld	a4,0(a5)
    1156:	00e6e463          	bltu	a3,a4,115e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    115a:	fee7eae3          	bltu	a5,a4,114e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    115e:	ff852583          	lw	a1,-8(a0)
    1162:	6390                	ld	a2,0(a5)
    1164:	02059813          	slli	a6,a1,0x20
    1168:	01c85713          	srli	a4,a6,0x1c
    116c:	9736                	add	a4,a4,a3
    116e:	fae60de3          	beq	a2,a4,1128 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1172:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1176:	4790                	lw	a2,8(a5)
    1178:	02061593          	slli	a1,a2,0x20
    117c:	01c5d713          	srli	a4,a1,0x1c
    1180:	973e                	add	a4,a4,a5
    1182:	fae68ae3          	beq	a3,a4,1136 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1186:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1188:	00000717          	auipc	a4,0x0
    118c:	50f73023          	sd	a5,1280(a4) # 1688 <freep>
}
    1190:	6422                	ld	s0,8(sp)
    1192:	0141                	addi	sp,sp,16
    1194:	8082                	ret

0000000000001196 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1196:	7139                	addi	sp,sp,-64
    1198:	fc06                	sd	ra,56(sp)
    119a:	f822                	sd	s0,48(sp)
    119c:	f426                	sd	s1,40(sp)
    119e:	f04a                	sd	s2,32(sp)
    11a0:	ec4e                	sd	s3,24(sp)
    11a2:	e852                	sd	s4,16(sp)
    11a4:	e456                	sd	s5,8(sp)
    11a6:	e05a                	sd	s6,0(sp)
    11a8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11aa:	02051493          	slli	s1,a0,0x20
    11ae:	9081                	srli	s1,s1,0x20
    11b0:	04bd                	addi	s1,s1,15
    11b2:	8091                	srli	s1,s1,0x4
    11b4:	00148a1b          	addiw	s4,s1,1
    11b8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    11ba:	00000517          	auipc	a0,0x0
    11be:	4ce53503          	ld	a0,1230(a0) # 1688 <freep>
    11c2:	c515                	beqz	a0,11ee <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11c6:	4798                	lw	a4,8(a5)
    11c8:	04977163          	bgeu	a4,s1,120a <malloc+0x74>
    11cc:	89d2                	mv	s3,s4
    11ce:	000a071b          	sext.w	a4,s4
    11d2:	6685                	lui	a3,0x1
    11d4:	00d77363          	bgeu	a4,a3,11da <malloc+0x44>
    11d8:	6985                	lui	s3,0x1
    11da:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    11de:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11e2:	00000917          	auipc	s2,0x0
    11e6:	4a690913          	addi	s2,s2,1190 # 1688 <freep>
  if(p == (char*)-1)
    11ea:	5afd                	li	s5,-1
    11ec:	a8a5                	j	1264 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    11ee:	00000797          	auipc	a5,0x0
    11f2:	49a78793          	addi	a5,a5,1178 # 1688 <freep>
    11f6:	00000717          	auipc	a4,0x0
    11fa:	49a70713          	addi	a4,a4,1178 # 1690 <base>
    11fe:	e398                	sd	a4,0(a5)
    1200:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    1202:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1206:	87ba                	mv	a5,a4
    1208:	b7d1                	j	11cc <malloc+0x36>
      if(p->s.size == nunits)
    120a:	02e48c63          	beq	s1,a4,1242 <malloc+0xac>
        p->s.size -= nunits;
    120e:	4147073b          	subw	a4,a4,s4
    1212:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1214:	02071693          	slli	a3,a4,0x20
    1218:	01c6d713          	srli	a4,a3,0x1c
    121c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    121e:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    1222:	00000717          	auipc	a4,0x0
    1226:	46a73323          	sd	a0,1126(a4) # 1688 <freep>
      return (void*)(p + 1);
    122a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    122e:	70e2                	ld	ra,56(sp)
    1230:	7442                	ld	s0,48(sp)
    1232:	74a2                	ld	s1,40(sp)
    1234:	7902                	ld	s2,32(sp)
    1236:	69e2                	ld	s3,24(sp)
    1238:	6a42                	ld	s4,16(sp)
    123a:	6aa2                	ld	s5,8(sp)
    123c:	6b02                	ld	s6,0(sp)
    123e:	6121                	addi	sp,sp,64
    1240:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1242:	6398                	ld	a4,0(a5)
    1244:	e118                	sd	a4,0(a0)
    1246:	bff1                	j	1222 <malloc+0x8c>
  hp->s.size = nu;
    1248:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    124c:	0541                	addi	a0,a0,16
    124e:	00000097          	auipc	ra,0x0
    1252:	ec6080e7          	jalr	-314(ra) # 1114 <free>
  return freep;
    1256:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    125a:	d971                	beqz	a0,122e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    125c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    125e:	4798                	lw	a4,8(a5)
    1260:	fa9775e3          	bgeu	a4,s1,120a <malloc+0x74>
    if(p == freep)
    1264:	00093703          	ld	a4,0(s2)
    1268:	853e                	mv	a0,a5
    126a:	fef719e3          	bne	a4,a5,125c <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    126e:	854e                	mv	a0,s3
    1270:	00000097          	auipc	ra,0x0
    1274:	95e080e7          	jalr	-1698(ra) # bce <sbrk>
  if(p == (char*)-1)
    1278:	fd5518e3          	bne	a0,s5,1248 <malloc+0xb2>
        return 0;
    127c:	4501                	li	a0,0
    127e:	bf45                	j	122e <malloc+0x98>
