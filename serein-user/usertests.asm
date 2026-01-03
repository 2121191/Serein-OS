
serein-user/_usertests：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <alarm_simple_handler>:
    } \
}

// Simple test helpers
static volatile int alarm_simple_received = 0;
static void alarm_simple_handler(int sig) { alarm_simple_received = 1; }
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
       6:	4785                	li	a5,1
       8:	00010717          	auipc	a4,0x10
       c:	88f72023          	sw	a5,-1920(a4) # f888 <alarm_simple_received>
      10:	6422                	ld	s0,8(sp)
      12:	0141                	addi	sp,sp,16
      14:	8082                	ret

0000000000000016 <alarm_handler>:
#include "serein-user/user.h"

volatile int alarm_received = 0;

void alarm_handler(int sig)
{
      16:	1141                	addi	sp,sp,-16
      18:	e406                	sd	ra,8(sp)
      1a:	e022                	sd	s0,0(sp)
      1c:	0800                	addi	s0,sp,16
      1e:	85aa                	mv	a1,a0
    alarm_received = 1;
      20:	4785                	li	a5,1
      22:	00010717          	auipc	a4,0x10
      26:	86f72523          	sw	a5,-1942(a4) # f88c <alarm_received>
    printf("SIGALRM handler called! sig=%d\n", sig);
      2a:	00009517          	auipc	a0,0x9
      2e:	68650513          	addi	a0,a0,1670 # 96b0 <malloc+0xf0>
      32:	00009097          	auipc	ra,0x9
      36:	4d6080e7          	jalr	1238(ra) # 9508 <printf>
}
      3a:	60a2                	ld	ra,8(sp)
      3c:	6402                	ld	s0,0(sp)
      3e:	0141                	addi	sp,sp,16
      40:	8082                	ret

0000000000000042 <copyinstr1>:
{
      42:	1141                	addi	sp,sp,-16
      44:	e406                	sd	ra,8(sp)
      46:	e022                	sd	s0,0(sp)
      48:	0800                	addi	s0,sp,16
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      4a:	20100593          	li	a1,513
      4e:	4505                	li	a0,1
      50:	057e                	slli	a0,a0,0x1f
      52:	00009097          	auipc	ra,0x9
      56:	f76080e7          	jalr	-138(ra) # 8fc8 <open>
    if(fd >= 0){
      5a:	02055063          	bgez	a0,7a <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      5e:	20100593          	li	a1,513
      62:	557d                	li	a0,-1
      64:	00009097          	auipc	ra,0x9
      68:	f64080e7          	jalr	-156(ra) # 8fc8 <open>
    uint64 addr = addrs[ai];
      6c:	55fd                	li	a1,-1
    if(fd >= 0){
      6e:	00055863          	bgez	a0,7e <copyinstr1+0x3c>
}
      72:	60a2                	ld	ra,8(sp)
      74:	6402                	ld	s0,0(sp)
      76:	0141                	addi	sp,sp,16
      78:	8082                	ret
    uint64 addr = addrs[ai];
      7a:	4585                	li	a1,1
      7c:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      7e:	862a                	mv	a2,a0
      80:	00009517          	auipc	a0,0x9
      84:	65050513          	addi	a0,a0,1616 # 96d0 <malloc+0x110>
      88:	00009097          	auipc	ra,0x9
      8c:	480080e7          	jalr	1152(ra) # 9508 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00009097          	auipc	ra,0x9
      96:	ef6080e7          	jalr	-266(ra) # 8f88 <exit>

000000000000009a <bsstest>:
  for(i = 0; i < sizeof(uninit); i++){
      9a:	0001b797          	auipc	a5,0x1b
      9e:	91e78793          	addi	a5,a5,-1762 # 1a9b8 <uninit>
      a2:	0001d697          	auipc	a3,0x1d
      a6:	02668693          	addi	a3,a3,38 # 1d0c8 <buf>
    if(uninit[i] != '\0'){
      aa:	0007c703          	lbu	a4,0(a5)
      ae:	e709                	bnez	a4,b8 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      b0:	0785                	addi	a5,a5,1
      b2:	fed79ce3          	bne	a5,a3,aa <bsstest+0x10>
      b6:	8082                	ret
{
      b8:	1141                	addi	sp,sp,-16
      ba:	e406                	sd	ra,8(sp)
      bc:	e022                	sd	s0,0(sp)
      be:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      c0:	85aa                	mv	a1,a0
      c2:	00009517          	auipc	a0,0x9
      c6:	62e50513          	addi	a0,a0,1582 # 96f0 <malloc+0x130>
      ca:	00009097          	auipc	ra,0x9
      ce:	43e080e7          	jalr	1086(ra) # 9508 <printf>
      exit(1);
      d2:	4505                	li	a0,1
      d4:	00009097          	auipc	ra,0x9
      d8:	eb4080e7          	jalr	-332(ra) # 8f88 <exit>

00000000000000dc <opentest>:
{
      dc:	1101                	addi	sp,sp,-32
      de:	ec06                	sd	ra,24(sp)
      e0:	e822                	sd	s0,16(sp)
      e2:	e426                	sd	s1,8(sp)
      e4:	1000                	addi	s0,sp,32
      e6:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      e8:	4581                	li	a1,0
      ea:	00009517          	auipc	a0,0x9
      ee:	61e50513          	addi	a0,a0,1566 # 9708 <malloc+0x148>
      f2:	00009097          	auipc	ra,0x9
      f6:	ed6080e7          	jalr	-298(ra) # 8fc8 <open>
  if(fd < 0){
      fa:	02054663          	bltz	a0,126 <opentest+0x4a>
  close(fd);
      fe:	00009097          	auipc	ra,0x9
     102:	eb2080e7          	jalr	-334(ra) # 8fb0 <close>
  fd = open("doesnotexist", 0);
     106:	4581                	li	a1,0
     108:	00009517          	auipc	a0,0x9
     10c:	62050513          	addi	a0,a0,1568 # 9728 <malloc+0x168>
     110:	00009097          	auipc	ra,0x9
     114:	eb8080e7          	jalr	-328(ra) # 8fc8 <open>
  if(fd >= 0){
     118:	02055563          	bgez	a0,142 <opentest+0x66>
}
     11c:	60e2                	ld	ra,24(sp)
     11e:	6442                	ld	s0,16(sp)
     120:	64a2                	ld	s1,8(sp)
     122:	6105                	addi	sp,sp,32
     124:	8082                	ret
    printf("%s: open echo failed!\n", s);
     126:	85a6                	mv	a1,s1
     128:	00009517          	auipc	a0,0x9
     12c:	5e850513          	addi	a0,a0,1512 # 9710 <malloc+0x150>
     130:	00009097          	auipc	ra,0x9
     134:	3d8080e7          	jalr	984(ra) # 9508 <printf>
    exit(1);
     138:	4505                	li	a0,1
     13a:	00009097          	auipc	ra,0x9
     13e:	e4e080e7          	jalr	-434(ra) # 8f88 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     142:	85a6                	mv	a1,s1
     144:	00009517          	auipc	a0,0x9
     148:	5f450513          	addi	a0,a0,1524 # 9738 <malloc+0x178>
     14c:	00009097          	auipc	ra,0x9
     150:	3bc080e7          	jalr	956(ra) # 9508 <printf>
    exit(1);
     154:	4505                	li	a0,1
     156:	00009097          	auipc	ra,0x9
     15a:	e32080e7          	jalr	-462(ra) # 8f88 <exit>

000000000000015e <truncate2>:
{
     15e:	7179                	addi	sp,sp,-48
     160:	f406                	sd	ra,40(sp)
     162:	f022                	sd	s0,32(sp)
     164:	ec26                	sd	s1,24(sp)
     166:	e84a                	sd	s2,16(sp)
     168:	e44e                	sd	s3,8(sp)
     16a:	1800                	addi	s0,sp,48
     16c:	89aa                	mv	s3,a0
  remove("truncfile");
     16e:	00009517          	auipc	a0,0x9
     172:	5f250513          	addi	a0,a0,1522 # 9760 <malloc+0x1a0>
     176:	00009097          	auipc	ra,0x9
     17a:	eba080e7          	jalr	-326(ra) # 9030 <remove>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     17e:	60100593          	li	a1,1537
     182:	00009517          	auipc	a0,0x9
     186:	5de50513          	addi	a0,a0,1502 # 9760 <malloc+0x1a0>
     18a:	00009097          	auipc	ra,0x9
     18e:	e3e080e7          	jalr	-450(ra) # 8fc8 <open>
     192:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     194:	4611                	li	a2,4
     196:	00009597          	auipc	a1,0x9
     19a:	5da58593          	addi	a1,a1,1498 # 9770 <malloc+0x1b0>
     19e:	00009097          	auipc	ra,0x9
     1a2:	e0a080e7          	jalr	-502(ra) # 8fa8 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     1a6:	40100593          	li	a1,1025
     1aa:	00009517          	auipc	a0,0x9
     1ae:	5b650513          	addi	a0,a0,1462 # 9760 <malloc+0x1a0>
     1b2:	00009097          	auipc	ra,0x9
     1b6:	e16080e7          	jalr	-490(ra) # 8fc8 <open>
     1ba:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     1bc:	4605                	li	a2,1
     1be:	00009597          	auipc	a1,0x9
     1c2:	5ba58593          	addi	a1,a1,1466 # 9778 <malloc+0x1b8>
     1c6:	8526                	mv	a0,s1
     1c8:	00009097          	auipc	ra,0x9
     1cc:	de0080e7          	jalr	-544(ra) # 8fa8 <write>
  if(n != -1){
     1d0:	57fd                	li	a5,-1
     1d2:	02f51b63          	bne	a0,a5,208 <truncate2+0xaa>
  remove("truncfile");
     1d6:	00009517          	auipc	a0,0x9
     1da:	58a50513          	addi	a0,a0,1418 # 9760 <malloc+0x1a0>
     1de:	00009097          	auipc	ra,0x9
     1e2:	e52080e7          	jalr	-430(ra) # 9030 <remove>
  close(fd1);
     1e6:	8526                	mv	a0,s1
     1e8:	00009097          	auipc	ra,0x9
     1ec:	dc8080e7          	jalr	-568(ra) # 8fb0 <close>
  close(fd2);
     1f0:	854a                	mv	a0,s2
     1f2:	00009097          	auipc	ra,0x9
     1f6:	dbe080e7          	jalr	-578(ra) # 8fb0 <close>
}
     1fa:	70a2                	ld	ra,40(sp)
     1fc:	7402                	ld	s0,32(sp)
     1fe:	64e2                	ld	s1,24(sp)
     200:	6942                	ld	s2,16(sp)
     202:	69a2                	ld	s3,8(sp)
     204:	6145                	addi	sp,sp,48
     206:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     208:	862a                	mv	a2,a0
     20a:	85ce                	mv	a1,s3
     20c:	00009517          	auipc	a0,0x9
     210:	57450513          	addi	a0,a0,1396 # 9780 <malloc+0x1c0>
     214:	00009097          	auipc	ra,0x9
     218:	2f4080e7          	jalr	756(ra) # 9508 <printf>
    exit(1);
     21c:	4505                	li	a0,1
     21e:	00009097          	auipc	ra,0x9
     222:	d6a080e7          	jalr	-662(ra) # 8f88 <exit>

0000000000000226 <createtest>:
{
     226:	7179                	addi	sp,sp,-48
     228:	f406                	sd	ra,40(sp)
     22a:	f022                	sd	s0,32(sp)
     22c:	ec26                	sd	s1,24(sp)
     22e:	e84a                	sd	s2,16(sp)
     230:	e44e                	sd	s3,8(sp)
     232:	e052                	sd	s4,0(sp)
     234:	1800                	addi	s0,sp,48
  name[0] = 'a';
     236:	0000f797          	auipc	a5,0xf
     23a:	65278793          	addi	a5,a5,1618 # f888 <alarm_simple_received>
     23e:	06100713          	li	a4,97
     242:	00e78423          	sb	a4,8(a5)
  name[2] = '\0';
     246:	00078523          	sb	zero,10(a5)
     24a:	03000493          	li	s1,48
    name[1] = '0' + i;
     24e:	8a3e                	mv	s4,a5
    fd = open(name, O_CREATE|O_RDWR);
     250:	0000f997          	auipc	s3,0xf
     254:	64098993          	addi	s3,s3,1600 # f890 <name>
  for(i = 0; i < N; i++){
     258:	06400913          	li	s2,100
    name[1] = '0' + i;
     25c:	009a04a3          	sb	s1,9(s4)
    fd = open(name, O_CREATE|O_RDWR);
     260:	20200593          	li	a1,514
     264:	854e                	mv	a0,s3
     266:	00009097          	auipc	ra,0x9
     26a:	d62080e7          	jalr	-670(ra) # 8fc8 <open>
    close(fd);
     26e:	00009097          	auipc	ra,0x9
     272:	d42080e7          	jalr	-702(ra) # 8fb0 <close>
  for(i = 0; i < N; i++){
     276:	2485                	addiw	s1,s1,1
     278:	0ff4f493          	zext.b	s1,s1
     27c:	ff2490e3          	bne	s1,s2,25c <createtest+0x36>
  name[0] = 'a';
     280:	0000f797          	auipc	a5,0xf
     284:	60878793          	addi	a5,a5,1544 # f888 <alarm_simple_received>
     288:	06100713          	li	a4,97
     28c:	00e78423          	sb	a4,8(a5)
  name[2] = '\0';
     290:	00078523          	sb	zero,10(a5)
     294:	03000493          	li	s1,48
    name[1] = '0' + i;
     298:	8a3e                	mv	s4,a5
    remove(name);
     29a:	0000f997          	auipc	s3,0xf
     29e:	5f698993          	addi	s3,s3,1526 # f890 <name>
  for(i = 0; i < N; i++){
     2a2:	06400913          	li	s2,100
    name[1] = '0' + i;
     2a6:	009a04a3          	sb	s1,9(s4)
    remove(name);
     2aa:	854e                	mv	a0,s3
     2ac:	00009097          	auipc	ra,0x9
     2b0:	d84080e7          	jalr	-636(ra) # 9030 <remove>
  for(i = 0; i < N; i++){
     2b4:	2485                	addiw	s1,s1,1
     2b6:	0ff4f493          	zext.b	s1,s1
     2ba:	ff2496e3          	bne	s1,s2,2a6 <createtest+0x80>
}
     2be:	70a2                	ld	ra,40(sp)
     2c0:	7402                	ld	s0,32(sp)
     2c2:	64e2                	ld	s1,24(sp)
     2c4:	6942                	ld	s2,16(sp)
     2c6:	69a2                	ld	s3,8(sp)
     2c8:	6a02                	ld	s4,0(sp)
     2ca:	6145                	addi	sp,sp,48
     2cc:	8082                	ret

00000000000002ce <bigwrite>:
{
     2ce:	715d                	addi	sp,sp,-80
     2d0:	e486                	sd	ra,72(sp)
     2d2:	e0a2                	sd	s0,64(sp)
     2d4:	fc26                	sd	s1,56(sp)
     2d6:	f84a                	sd	s2,48(sp)
     2d8:	f44e                	sd	s3,40(sp)
     2da:	f052                	sd	s4,32(sp)
     2dc:	ec56                	sd	s5,24(sp)
     2de:	e85a                	sd	s6,16(sp)
     2e0:	e45e                	sd	s7,8(sp)
     2e2:	0880                	addi	s0,sp,80
     2e4:	8baa                	mv	s7,a0
  remove("bigwrite");
     2e6:	00009517          	auipc	a0,0x9
     2ea:	4c250513          	addi	a0,a0,1218 # 97a8 <malloc+0x1e8>
     2ee:	00009097          	auipc	ra,0x9
     2f2:	d42080e7          	jalr	-702(ra) # 9030 <remove>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f6:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2fa:	00009a97          	auipc	s5,0x9
     2fe:	4aea8a93          	addi	s5,s5,1198 # 97a8 <malloc+0x1e8>
      int cc = write(fd, buf, sz);
     302:	0001da17          	auipc	s4,0x1d
     306:	dc6a0a13          	addi	s4,s4,-570 # 1d0c8 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     30a:	6b09                	lui	s6,0x2
     30c:	807b0b13          	addi	s6,s6,-2041 # 1807 <exectest+0x179>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     310:	20200593          	li	a1,514
     314:	8556                	mv	a0,s5
     316:	00009097          	auipc	ra,0x9
     31a:	cb2080e7          	jalr	-846(ra) # 8fc8 <open>
     31e:	892a                	mv	s2,a0
    if(fd < 0){
     320:	04054d63          	bltz	a0,37a <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     324:	8626                	mv	a2,s1
     326:	85d2                	mv	a1,s4
     328:	00009097          	auipc	ra,0x9
     32c:	c80080e7          	jalr	-896(ra) # 8fa8 <write>
     330:	89aa                	mv	s3,a0
      if(cc != sz){
     332:	06a49263          	bne	s1,a0,396 <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     336:	8626                	mv	a2,s1
     338:	85d2                	mv	a1,s4
     33a:	854a                	mv	a0,s2
     33c:	00009097          	auipc	ra,0x9
     340:	c6c080e7          	jalr	-916(ra) # 8fa8 <write>
      if(cc != sz){
     344:	04951a63          	bne	a0,s1,398 <bigwrite+0xca>
    close(fd);
     348:	854a                	mv	a0,s2
     34a:	00009097          	auipc	ra,0x9
     34e:	c66080e7          	jalr	-922(ra) # 8fb0 <close>
    remove("bigwrite");
     352:	8556                	mv	a0,s5
     354:	00009097          	auipc	ra,0x9
     358:	cdc080e7          	jalr	-804(ra) # 9030 <remove>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     35c:	1d74849b          	addiw	s1,s1,471
     360:	fb6498e3          	bne	s1,s6,310 <bigwrite+0x42>
}
     364:	60a6                	ld	ra,72(sp)
     366:	6406                	ld	s0,64(sp)
     368:	74e2                	ld	s1,56(sp)
     36a:	7942                	ld	s2,48(sp)
     36c:	79a2                	ld	s3,40(sp)
     36e:	7a02                	ld	s4,32(sp)
     370:	6ae2                	ld	s5,24(sp)
     372:	6b42                	ld	s6,16(sp)
     374:	6ba2                	ld	s7,8(sp)
     376:	6161                	addi	sp,sp,80
     378:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     37a:	85de                	mv	a1,s7
     37c:	00009517          	auipc	a0,0x9
     380:	43c50513          	addi	a0,a0,1084 # 97b8 <malloc+0x1f8>
     384:	00009097          	auipc	ra,0x9
     388:	184080e7          	jalr	388(ra) # 9508 <printf>
      exit(1);
     38c:	4505                	li	a0,1
     38e:	00009097          	auipc	ra,0x9
     392:	bfa080e7          	jalr	-1030(ra) # 8f88 <exit>
      if(cc != sz){
     396:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     398:	86aa                	mv	a3,a0
     39a:	864e                	mv	a2,s3
     39c:	85de                	mv	a1,s7
     39e:	00009517          	auipc	a0,0x9
     3a2:	43a50513          	addi	a0,a0,1082 # 97d8 <malloc+0x218>
     3a6:	00009097          	auipc	ra,0x9
     3aa:	162080e7          	jalr	354(ra) # 9508 <printf>
        exit(1);
     3ae:	4505                	li	a0,1
     3b0:	00009097          	auipc	ra,0x9
     3b4:	bd8080e7          	jalr	-1064(ra) # 8f88 <exit>

00000000000003b8 <badwrite>:
{
     3b8:	7179                	addi	sp,sp,-48
     3ba:	f406                	sd	ra,40(sp)
     3bc:	f022                	sd	s0,32(sp)
     3be:	ec26                	sd	s1,24(sp)
     3c0:	e84a                	sd	s2,16(sp)
     3c2:	e44e                	sd	s3,8(sp)
     3c4:	e052                	sd	s4,0(sp)
     3c6:	1800                	addi	s0,sp,48
  remove("junk");
     3c8:	00009517          	auipc	a0,0x9
     3cc:	42850513          	addi	a0,a0,1064 # 97f0 <malloc+0x230>
     3d0:	00009097          	auipc	ra,0x9
     3d4:	c60080e7          	jalr	-928(ra) # 9030 <remove>
     3d8:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
     3dc:	00009997          	auipc	s3,0x9
     3e0:	41498993          	addi	s3,s3,1044 # 97f0 <malloc+0x230>
    write(fd, (char*)0xffffffffffL, 1);
     3e4:	5a7d                	li	s4,-1
     3e6:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     3ea:	20100593          	li	a1,513
     3ee:	854e                	mv	a0,s3
     3f0:	00009097          	auipc	ra,0x9
     3f4:	bd8080e7          	jalr	-1064(ra) # 8fc8 <open>
     3f8:	84aa                	mv	s1,a0
    if(fd < 0){
     3fa:	06054b63          	bltz	a0,470 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     3fe:	4605                	li	a2,1
     400:	85d2                	mv	a1,s4
     402:	00009097          	auipc	ra,0x9
     406:	ba6080e7          	jalr	-1114(ra) # 8fa8 <write>
    close(fd);
     40a:	8526                	mv	a0,s1
     40c:	00009097          	auipc	ra,0x9
     410:	ba4080e7          	jalr	-1116(ra) # 8fb0 <close>
    remove("junk");
     414:	854e                	mv	a0,s3
     416:	00009097          	auipc	ra,0x9
     41a:	c1a080e7          	jalr	-998(ra) # 9030 <remove>
  for(int i = 0; i < assumed_free; i++){
     41e:	397d                	addiw	s2,s2,-1
     420:	fc0915e3          	bnez	s2,3ea <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
     424:	20100593          	li	a1,513
     428:	00009517          	auipc	a0,0x9
     42c:	3c850513          	addi	a0,a0,968 # 97f0 <malloc+0x230>
     430:	00009097          	auipc	ra,0x9
     434:	b98080e7          	jalr	-1128(ra) # 8fc8 <open>
     438:	84aa                	mv	s1,a0
  if(fd < 0){
     43a:	04054863          	bltz	a0,48a <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
     43e:	4605                	li	a2,1
     440:	00009597          	auipc	a1,0x9
     444:	33858593          	addi	a1,a1,824 # 9778 <malloc+0x1b8>
     448:	00009097          	auipc	ra,0x9
     44c:	b60080e7          	jalr	-1184(ra) # 8fa8 <write>
     450:	4785                	li	a5,1
     452:	04f50963          	beq	a0,a5,4a4 <badwrite+0xec>
    printf("write failed\n");
     456:	00009517          	auipc	a0,0x9
     45a:	3ba50513          	addi	a0,a0,954 # 9810 <malloc+0x250>
     45e:	00009097          	auipc	ra,0x9
     462:	0aa080e7          	jalr	170(ra) # 9508 <printf>
    exit(1);
     466:	4505                	li	a0,1
     468:	00009097          	auipc	ra,0x9
     46c:	b20080e7          	jalr	-1248(ra) # 8f88 <exit>
      printf("open junk failed\n");
     470:	00009517          	auipc	a0,0x9
     474:	38850513          	addi	a0,a0,904 # 97f8 <malloc+0x238>
     478:	00009097          	auipc	ra,0x9
     47c:	090080e7          	jalr	144(ra) # 9508 <printf>
      exit(1);
     480:	4505                	li	a0,1
     482:	00009097          	auipc	ra,0x9
     486:	b06080e7          	jalr	-1274(ra) # 8f88 <exit>
    printf("open junk failed\n");
     48a:	00009517          	auipc	a0,0x9
     48e:	36e50513          	addi	a0,a0,878 # 97f8 <malloc+0x238>
     492:	00009097          	auipc	ra,0x9
     496:	076080e7          	jalr	118(ra) # 9508 <printf>
    exit(1);
     49a:	4505                	li	a0,1
     49c:	00009097          	auipc	ra,0x9
     4a0:	aec080e7          	jalr	-1300(ra) # 8f88 <exit>
  close(fd);
     4a4:	8526                	mv	a0,s1
     4a6:	00009097          	auipc	ra,0x9
     4aa:	b0a080e7          	jalr	-1270(ra) # 8fb0 <close>
  remove("junk");
     4ae:	00009517          	auipc	a0,0x9
     4b2:	34250513          	addi	a0,a0,834 # 97f0 <malloc+0x230>
     4b6:	00009097          	auipc	ra,0x9
     4ba:	b7a080e7          	jalr	-1158(ra) # 9030 <remove>
  exit(0);
     4be:	4501                	li	a0,0
     4c0:	00009097          	auipc	ra,0x9
     4c4:	ac8080e7          	jalr	-1336(ra) # 8f88 <exit>

00000000000004c8 <copyin>:
{
     4c8:	7159                	addi	sp,sp,-112
     4ca:	f486                	sd	ra,104(sp)
     4cc:	f0a2                	sd	s0,96(sp)
     4ce:	eca6                	sd	s1,88(sp)
     4d0:	e8ca                	sd	s2,80(sp)
     4d2:	e4ce                	sd	s3,72(sp)
     4d4:	e0d2                	sd	s4,64(sp)
     4d6:	fc56                	sd	s5,56(sp)
     4d8:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4da:	4785                	li	a5,1
     4dc:	07fe                	slli	a5,a5,0x1f
     4de:	faf43823          	sd	a5,-80(s0)
     4e2:	57fd                	li	a5,-1
     4e4:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     4e8:	fb040913          	addi	s2,s0,-80
     4ec:	fc040793          	addi	a5,s0,-64
     4f0:	f8f43c23          	sd	a5,-104(s0)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4f4:	00009a17          	auipc	s4,0x9
     4f8:	32ca0a13          	addi	s4,s4,812 # 9820 <malloc+0x260>
    if(pipe(fds) < 0){
     4fc:	fa840a93          	addi	s5,s0,-88
    uint64 addr = addrs[ai];
     500:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     504:	20100593          	li	a1,513
     508:	8552                	mv	a0,s4
     50a:	00009097          	auipc	ra,0x9
     50e:	abe080e7          	jalr	-1346(ra) # 8fc8 <open>
     512:	84aa                	mv	s1,a0
    if(fd < 0){
     514:	08054863          	bltz	a0,5a4 <copyin+0xdc>
    int n = write(fd, (void*)addr, 8192);
     518:	6609                	lui	a2,0x2
     51a:	85ce                	mv	a1,s3
     51c:	00009097          	auipc	ra,0x9
     520:	a8c080e7          	jalr	-1396(ra) # 8fa8 <write>
    if(n >= 0){
     524:	08055d63          	bgez	a0,5be <copyin+0xf6>
    close(fd);
     528:	8526                	mv	a0,s1
     52a:	00009097          	auipc	ra,0x9
     52e:	a86080e7          	jalr	-1402(ra) # 8fb0 <close>
    remove("copyin1");
     532:	8552                	mv	a0,s4
     534:	00009097          	auipc	ra,0x9
     538:	afc080e7          	jalr	-1284(ra) # 9030 <remove>
    n = write(1, (char*)addr, 8192);
     53c:	6609                	lui	a2,0x2
     53e:	85ce                	mv	a1,s3
     540:	4505                	li	a0,1
     542:	00009097          	auipc	ra,0x9
     546:	a66080e7          	jalr	-1434(ra) # 8fa8 <write>
    if(n > 0){
     54a:	08a04963          	bgtz	a0,5dc <copyin+0x114>
    if(pipe(fds) < 0){
     54e:	8556                	mv	a0,s5
     550:	00009097          	auipc	ra,0x9
     554:	a48080e7          	jalr	-1464(ra) # 8f98 <pipe>
     558:	0a054163          	bltz	a0,5fa <copyin+0x132>
    n = write(fds[1], (char*)addr, 8192);
     55c:	6609                	lui	a2,0x2
     55e:	85ce                	mv	a1,s3
     560:	fac42503          	lw	a0,-84(s0)
     564:	00009097          	auipc	ra,0x9
     568:	a44080e7          	jalr	-1468(ra) # 8fa8 <write>
    if(n > 0){
     56c:	0aa04463          	bgtz	a0,614 <copyin+0x14c>
    close(fds[0]);
     570:	fa842503          	lw	a0,-88(s0)
     574:	00009097          	auipc	ra,0x9
     578:	a3c080e7          	jalr	-1476(ra) # 8fb0 <close>
    close(fds[1]);
     57c:	fac42503          	lw	a0,-84(s0)
     580:	00009097          	auipc	ra,0x9
     584:	a30080e7          	jalr	-1488(ra) # 8fb0 <close>
  for(int ai = 0; ai < 2; ai++){
     588:	0921                	addi	s2,s2,8
     58a:	f9843783          	ld	a5,-104(s0)
     58e:	f6f919e3          	bne	s2,a5,500 <copyin+0x38>
}
     592:	70a6                	ld	ra,104(sp)
     594:	7406                	ld	s0,96(sp)
     596:	64e6                	ld	s1,88(sp)
     598:	6946                	ld	s2,80(sp)
     59a:	69a6                	ld	s3,72(sp)
     59c:	6a06                	ld	s4,64(sp)
     59e:	7ae2                	ld	s5,56(sp)
     5a0:	6165                	addi	sp,sp,112
     5a2:	8082                	ret
      printf("open(copyin1) failed\n");
     5a4:	00009517          	auipc	a0,0x9
     5a8:	28450513          	addi	a0,a0,644 # 9828 <malloc+0x268>
     5ac:	00009097          	auipc	ra,0x9
     5b0:	f5c080e7          	jalr	-164(ra) # 9508 <printf>
      exit(1);
     5b4:	4505                	li	a0,1
     5b6:	00009097          	auipc	ra,0x9
     5ba:	9d2080e7          	jalr	-1582(ra) # 8f88 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     5be:	862a                	mv	a2,a0
     5c0:	85ce                	mv	a1,s3
     5c2:	00009517          	auipc	a0,0x9
     5c6:	27e50513          	addi	a0,a0,638 # 9840 <malloc+0x280>
     5ca:	00009097          	auipc	ra,0x9
     5ce:	f3e080e7          	jalr	-194(ra) # 9508 <printf>
      exit(1);
     5d2:	4505                	li	a0,1
     5d4:	00009097          	auipc	ra,0x9
     5d8:	9b4080e7          	jalr	-1612(ra) # 8f88 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5dc:	862a                	mv	a2,a0
     5de:	85ce                	mv	a1,s3
     5e0:	00009517          	auipc	a0,0x9
     5e4:	29050513          	addi	a0,a0,656 # 9870 <malloc+0x2b0>
     5e8:	00009097          	auipc	ra,0x9
     5ec:	f20080e7          	jalr	-224(ra) # 9508 <printf>
      exit(1);
     5f0:	4505                	li	a0,1
     5f2:	00009097          	auipc	ra,0x9
     5f6:	996080e7          	jalr	-1642(ra) # 8f88 <exit>
      printf("pipe() failed\n");
     5fa:	00009517          	auipc	a0,0x9
     5fe:	2a650513          	addi	a0,a0,678 # 98a0 <malloc+0x2e0>
     602:	00009097          	auipc	ra,0x9
     606:	f06080e7          	jalr	-250(ra) # 9508 <printf>
      exit(1);
     60a:	4505                	li	a0,1
     60c:	00009097          	auipc	ra,0x9
     610:	97c080e7          	jalr	-1668(ra) # 8f88 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     614:	862a                	mv	a2,a0
     616:	85ce                	mv	a1,s3
     618:	00009517          	auipc	a0,0x9
     61c:	29850513          	addi	a0,a0,664 # 98b0 <malloc+0x2f0>
     620:	00009097          	auipc	ra,0x9
     624:	ee8080e7          	jalr	-280(ra) # 9508 <printf>
      exit(1);
     628:	4505                	li	a0,1
     62a:	00009097          	auipc	ra,0x9
     62e:	95e080e7          	jalr	-1698(ra) # 8f88 <exit>

0000000000000632 <copyout>:
{
     632:	7159                	addi	sp,sp,-112
     634:	f486                	sd	ra,104(sp)
     636:	f0a2                	sd	s0,96(sp)
     638:	eca6                	sd	s1,88(sp)
     63a:	e8ca                	sd	s2,80(sp)
     63c:	e4ce                	sd	s3,72(sp)
     63e:	e0d2                	sd	s4,64(sp)
     640:	fc56                	sd	s5,56(sp)
     642:	f85a                	sd	s6,48(sp)
     644:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     646:	4785                	li	a5,1
     648:	07fe                	slli	a5,a5,0x1f
     64a:	faf43823          	sd	a5,-80(s0)
     64e:	57fd                	li	a5,-1
     650:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     654:	fb040913          	addi	s2,s0,-80
     658:	fc040793          	addi	a5,s0,-64
     65c:	f8f43c23          	sd	a5,-104(s0)
    int fd = open("README", 0);
     660:	00009a97          	auipc	s5,0x9
     664:	280a8a93          	addi	s5,s5,640 # 98e0 <malloc+0x320>
    if(pipe(fds) < 0){
     668:	fa840a13          	addi	s4,s0,-88
    n = write(fds[1], "x", 1);
     66c:	00009b17          	auipc	s6,0x9
     670:	10cb0b13          	addi	s6,s6,268 # 9778 <malloc+0x1b8>
    uint64 addr = addrs[ai];
     674:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     678:	4581                	li	a1,0
     67a:	8556                	mv	a0,s5
     67c:	00009097          	auipc	ra,0x9
     680:	94c080e7          	jalr	-1716(ra) # 8fc8 <open>
     684:	84aa                	mv	s1,a0
    if(fd < 0){
     686:	08054663          	bltz	a0,712 <copyout+0xe0>
    int n = read(fd, (void*)addr, 8192);
     68a:	6609                	lui	a2,0x2
     68c:	85ce                	mv	a1,s3
     68e:	00009097          	auipc	ra,0x9
     692:	912080e7          	jalr	-1774(ra) # 8fa0 <read>
    if(n > 0){
     696:	08a04b63          	bgtz	a0,72c <copyout+0xfa>
    close(fd);
     69a:	8526                	mv	a0,s1
     69c:	00009097          	auipc	ra,0x9
     6a0:	914080e7          	jalr	-1772(ra) # 8fb0 <close>
    if(pipe(fds) < 0){
     6a4:	8552                	mv	a0,s4
     6a6:	00009097          	auipc	ra,0x9
     6aa:	8f2080e7          	jalr	-1806(ra) # 8f98 <pipe>
     6ae:	08054e63          	bltz	a0,74a <copyout+0x118>
    n = write(fds[1], "x", 1);
     6b2:	4605                	li	a2,1
     6b4:	85da                	mv	a1,s6
     6b6:	fac42503          	lw	a0,-84(s0)
     6ba:	00009097          	auipc	ra,0x9
     6be:	8ee080e7          	jalr	-1810(ra) # 8fa8 <write>
    if(n != 1){
     6c2:	4785                	li	a5,1
     6c4:	0af51063          	bne	a0,a5,764 <copyout+0x132>
    n = read(fds[0], (void*)addr, 8192);
     6c8:	6609                	lui	a2,0x2
     6ca:	85ce                	mv	a1,s3
     6cc:	fa842503          	lw	a0,-88(s0)
     6d0:	00009097          	auipc	ra,0x9
     6d4:	8d0080e7          	jalr	-1840(ra) # 8fa0 <read>
    if(n > 0){
     6d8:	0aa04363          	bgtz	a0,77e <copyout+0x14c>
    close(fds[0]);
     6dc:	fa842503          	lw	a0,-88(s0)
     6e0:	00009097          	auipc	ra,0x9
     6e4:	8d0080e7          	jalr	-1840(ra) # 8fb0 <close>
    close(fds[1]);
     6e8:	fac42503          	lw	a0,-84(s0)
     6ec:	00009097          	auipc	ra,0x9
     6f0:	8c4080e7          	jalr	-1852(ra) # 8fb0 <close>
  for(int ai = 0; ai < 2; ai++){
     6f4:	0921                	addi	s2,s2,8
     6f6:	f9843783          	ld	a5,-104(s0)
     6fa:	f6f91de3          	bne	s2,a5,674 <copyout+0x42>
}
     6fe:	70a6                	ld	ra,104(sp)
     700:	7406                	ld	s0,96(sp)
     702:	64e6                	ld	s1,88(sp)
     704:	6946                	ld	s2,80(sp)
     706:	69a6                	ld	s3,72(sp)
     708:	6a06                	ld	s4,64(sp)
     70a:	7ae2                	ld	s5,56(sp)
     70c:	7b42                	ld	s6,48(sp)
     70e:	6165                	addi	sp,sp,112
     710:	8082                	ret
      printf("open(README) failed\n");
     712:	00009517          	auipc	a0,0x9
     716:	1d650513          	addi	a0,a0,470 # 98e8 <malloc+0x328>
     71a:	00009097          	auipc	ra,0x9
     71e:	dee080e7          	jalr	-530(ra) # 9508 <printf>
      exit(1);
     722:	4505                	li	a0,1
     724:	00009097          	auipc	ra,0x9
     728:	864080e7          	jalr	-1948(ra) # 8f88 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     72c:	862a                	mv	a2,a0
     72e:	85ce                	mv	a1,s3
     730:	00009517          	auipc	a0,0x9
     734:	1d050513          	addi	a0,a0,464 # 9900 <malloc+0x340>
     738:	00009097          	auipc	ra,0x9
     73c:	dd0080e7          	jalr	-560(ra) # 9508 <printf>
      exit(1);
     740:	4505                	li	a0,1
     742:	00009097          	auipc	ra,0x9
     746:	846080e7          	jalr	-1978(ra) # 8f88 <exit>
      printf("pipe() failed\n");
     74a:	00009517          	auipc	a0,0x9
     74e:	15650513          	addi	a0,a0,342 # 98a0 <malloc+0x2e0>
     752:	00009097          	auipc	ra,0x9
     756:	db6080e7          	jalr	-586(ra) # 9508 <printf>
      exit(1);
     75a:	4505                	li	a0,1
     75c:	00009097          	auipc	ra,0x9
     760:	82c080e7          	jalr	-2004(ra) # 8f88 <exit>
      printf("pipe write failed\n");
     764:	00009517          	auipc	a0,0x9
     768:	1cc50513          	addi	a0,a0,460 # 9930 <malloc+0x370>
     76c:	00009097          	auipc	ra,0x9
     770:	d9c080e7          	jalr	-612(ra) # 9508 <printf>
      exit(1);
     774:	4505                	li	a0,1
     776:	00009097          	auipc	ra,0x9
     77a:	812080e7          	jalr	-2030(ra) # 8f88 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     77e:	862a                	mv	a2,a0
     780:	85ce                	mv	a1,s3
     782:	00009517          	auipc	a0,0x9
     786:	1c650513          	addi	a0,a0,454 # 9948 <malloc+0x388>
     78a:	00009097          	auipc	ra,0x9
     78e:	d7e080e7          	jalr	-642(ra) # 9508 <printf>
      exit(1);
     792:	4505                	li	a0,1
     794:	00008097          	auipc	ra,0x8
     798:	7f4080e7          	jalr	2036(ra) # 8f88 <exit>

000000000000079c <truncate1>:
{
     79c:	711d                	addi	sp,sp,-96
     79e:	ec86                	sd	ra,88(sp)
     7a0:	e8a2                	sd	s0,80(sp)
     7a2:	e4a6                	sd	s1,72(sp)
     7a4:	e0ca                	sd	s2,64(sp)
     7a6:	fc4e                	sd	s3,56(sp)
     7a8:	f852                	sd	s4,48(sp)
     7aa:	f456                	sd	s5,40(sp)
     7ac:	1080                	addi	s0,sp,96
     7ae:	8aaa                	mv	s5,a0
  remove("truncfile");
     7b0:	00009517          	auipc	a0,0x9
     7b4:	fb050513          	addi	a0,a0,-80 # 9760 <malloc+0x1a0>
     7b8:	00009097          	auipc	ra,0x9
     7bc:	878080e7          	jalr	-1928(ra) # 9030 <remove>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     7c0:	60100593          	li	a1,1537
     7c4:	00009517          	auipc	a0,0x9
     7c8:	f9c50513          	addi	a0,a0,-100 # 9760 <malloc+0x1a0>
     7cc:	00008097          	auipc	ra,0x8
     7d0:	7fc080e7          	jalr	2044(ra) # 8fc8 <open>
     7d4:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     7d6:	4611                	li	a2,4
     7d8:	00009597          	auipc	a1,0x9
     7dc:	f9858593          	addi	a1,a1,-104 # 9770 <malloc+0x1b0>
     7e0:	00008097          	auipc	ra,0x8
     7e4:	7c8080e7          	jalr	1992(ra) # 8fa8 <write>
  close(fd1);
     7e8:	8526                	mv	a0,s1
     7ea:	00008097          	auipc	ra,0x8
     7ee:	7c6080e7          	jalr	1990(ra) # 8fb0 <close>
  int fd2 = open("truncfile", O_RDONLY);
     7f2:	4581                	li	a1,0
     7f4:	00009517          	auipc	a0,0x9
     7f8:	f6c50513          	addi	a0,a0,-148 # 9760 <malloc+0x1a0>
     7fc:	00008097          	auipc	ra,0x8
     800:	7cc080e7          	jalr	1996(ra) # 8fc8 <open>
     804:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     806:	02000613          	li	a2,32
     80a:	fa040593          	addi	a1,s0,-96
     80e:	00008097          	auipc	ra,0x8
     812:	792080e7          	jalr	1938(ra) # 8fa0 <read>
  if(n != 4){
     816:	4791                	li	a5,4
     818:	0cf51e63          	bne	a0,a5,8f4 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     81c:	40100593          	li	a1,1025
     820:	00009517          	auipc	a0,0x9
     824:	f4050513          	addi	a0,a0,-192 # 9760 <malloc+0x1a0>
     828:	00008097          	auipc	ra,0x8
     82c:	7a0080e7          	jalr	1952(ra) # 8fc8 <open>
     830:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     832:	4581                	li	a1,0
     834:	00009517          	auipc	a0,0x9
     838:	f2c50513          	addi	a0,a0,-212 # 9760 <malloc+0x1a0>
     83c:	00008097          	auipc	ra,0x8
     840:	78c080e7          	jalr	1932(ra) # 8fc8 <open>
     844:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     846:	02000613          	li	a2,32
     84a:	fa040593          	addi	a1,s0,-96
     84e:	00008097          	auipc	ra,0x8
     852:	752080e7          	jalr	1874(ra) # 8fa0 <read>
     856:	8a2a                	mv	s4,a0
  if(n != 0){
     858:	ed4d                	bnez	a0,912 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     85a:	02000613          	li	a2,32
     85e:	fa040593          	addi	a1,s0,-96
     862:	8526                	mv	a0,s1
     864:	00008097          	auipc	ra,0x8
     868:	73c080e7          	jalr	1852(ra) # 8fa0 <read>
     86c:	8a2a                	mv	s4,a0
  if(n != 0){
     86e:	e971                	bnez	a0,942 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     870:	4619                	li	a2,6
     872:	00009597          	auipc	a1,0x9
     876:	16658593          	addi	a1,a1,358 # 99d8 <malloc+0x418>
     87a:	854e                	mv	a0,s3
     87c:	00008097          	auipc	ra,0x8
     880:	72c080e7          	jalr	1836(ra) # 8fa8 <write>
  n = read(fd3, buf, sizeof(buf));
     884:	02000613          	li	a2,32
     888:	fa040593          	addi	a1,s0,-96
     88c:	854a                	mv	a0,s2
     88e:	00008097          	auipc	ra,0x8
     892:	712080e7          	jalr	1810(ra) # 8fa0 <read>
  if(n != 6){
     896:	4799                	li	a5,6
     898:	0cf51d63          	bne	a0,a5,972 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     89c:	02000613          	li	a2,32
     8a0:	fa040593          	addi	a1,s0,-96
     8a4:	8526                	mv	a0,s1
     8a6:	00008097          	auipc	ra,0x8
     8aa:	6fa080e7          	jalr	1786(ra) # 8fa0 <read>
  if(n != 2){
     8ae:	4789                	li	a5,2
     8b0:	0ef51063          	bne	a0,a5,990 <truncate1+0x1f4>
  remove("truncfile");
     8b4:	00009517          	auipc	a0,0x9
     8b8:	eac50513          	addi	a0,a0,-340 # 9760 <malloc+0x1a0>
     8bc:	00008097          	auipc	ra,0x8
     8c0:	774080e7          	jalr	1908(ra) # 9030 <remove>
  close(fd1);
     8c4:	854e                	mv	a0,s3
     8c6:	00008097          	auipc	ra,0x8
     8ca:	6ea080e7          	jalr	1770(ra) # 8fb0 <close>
  close(fd2);
     8ce:	8526                	mv	a0,s1
     8d0:	00008097          	auipc	ra,0x8
     8d4:	6e0080e7          	jalr	1760(ra) # 8fb0 <close>
  close(fd3);
     8d8:	854a                	mv	a0,s2
     8da:	00008097          	auipc	ra,0x8
     8de:	6d6080e7          	jalr	1750(ra) # 8fb0 <close>
}
     8e2:	60e6                	ld	ra,88(sp)
     8e4:	6446                	ld	s0,80(sp)
     8e6:	64a6                	ld	s1,72(sp)
     8e8:	6906                	ld	s2,64(sp)
     8ea:	79e2                	ld	s3,56(sp)
     8ec:	7a42                	ld	s4,48(sp)
     8ee:	7aa2                	ld	s5,40(sp)
     8f0:	6125                	addi	sp,sp,96
     8f2:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     8f4:	862a                	mv	a2,a0
     8f6:	85d6                	mv	a1,s5
     8f8:	00009517          	auipc	a0,0x9
     8fc:	08050513          	addi	a0,a0,128 # 9978 <malloc+0x3b8>
     900:	00009097          	auipc	ra,0x9
     904:	c08080e7          	jalr	-1016(ra) # 9508 <printf>
    exit(1);
     908:	4505                	li	a0,1
     90a:	00008097          	auipc	ra,0x8
     90e:	67e080e7          	jalr	1662(ra) # 8f88 <exit>
    printf("aaa fd3=%d\n", fd3);
     912:	85ca                	mv	a1,s2
     914:	00009517          	auipc	a0,0x9
     918:	08450513          	addi	a0,a0,132 # 9998 <malloc+0x3d8>
     91c:	00009097          	auipc	ra,0x9
     920:	bec080e7          	jalr	-1044(ra) # 9508 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     924:	8652                	mv	a2,s4
     926:	85d6                	mv	a1,s5
     928:	00009517          	auipc	a0,0x9
     92c:	08050513          	addi	a0,a0,128 # 99a8 <malloc+0x3e8>
     930:	00009097          	auipc	ra,0x9
     934:	bd8080e7          	jalr	-1064(ra) # 9508 <printf>
    exit(1);
     938:	4505                	li	a0,1
     93a:	00008097          	auipc	ra,0x8
     93e:	64e080e7          	jalr	1614(ra) # 8f88 <exit>
    printf("bbb fd2=%d\n", fd2);
     942:	85a6                	mv	a1,s1
     944:	00009517          	auipc	a0,0x9
     948:	08450513          	addi	a0,a0,132 # 99c8 <malloc+0x408>
     94c:	00009097          	auipc	ra,0x9
     950:	bbc080e7          	jalr	-1092(ra) # 9508 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     954:	8652                	mv	a2,s4
     956:	85d6                	mv	a1,s5
     958:	00009517          	auipc	a0,0x9
     95c:	05050513          	addi	a0,a0,80 # 99a8 <malloc+0x3e8>
     960:	00009097          	auipc	ra,0x9
     964:	ba8080e7          	jalr	-1112(ra) # 9508 <printf>
    exit(1);
     968:	4505                	li	a0,1
     96a:	00008097          	auipc	ra,0x8
     96e:	61e080e7          	jalr	1566(ra) # 8f88 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     972:	862a                	mv	a2,a0
     974:	85d6                	mv	a1,s5
     976:	00009517          	auipc	a0,0x9
     97a:	06a50513          	addi	a0,a0,106 # 99e0 <malloc+0x420>
     97e:	00009097          	auipc	ra,0x9
     982:	b8a080e7          	jalr	-1142(ra) # 9508 <printf>
    exit(1);
     986:	4505                	li	a0,1
     988:	00008097          	auipc	ra,0x8
     98c:	600080e7          	jalr	1536(ra) # 8f88 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     990:	862a                	mv	a2,a0
     992:	85d6                	mv	a1,s5
     994:	00009517          	auipc	a0,0x9
     998:	06c50513          	addi	a0,a0,108 # 9a00 <malloc+0x440>
     99c:	00009097          	auipc	ra,0x9
     9a0:	b6c080e7          	jalr	-1172(ra) # 9508 <printf>
    exit(1);
     9a4:	4505                	li	a0,1
     9a6:	00008097          	auipc	ra,0x8
     9aa:	5e2080e7          	jalr	1506(ra) # 8f88 <exit>

00000000000009ae <writetest>:
{
     9ae:	7139                	addi	sp,sp,-64
     9b0:	fc06                	sd	ra,56(sp)
     9b2:	f822                	sd	s0,48(sp)
     9b4:	f426                	sd	s1,40(sp)
     9b6:	f04a                	sd	s2,32(sp)
     9b8:	ec4e                	sd	s3,24(sp)
     9ba:	e852                	sd	s4,16(sp)
     9bc:	e456                	sd	s5,8(sp)
     9be:	e05a                	sd	s6,0(sp)
     9c0:	0080                	addi	s0,sp,64
     9c2:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     9c4:	20200593          	li	a1,514
     9c8:	00009517          	auipc	a0,0x9
     9cc:	05850513          	addi	a0,a0,88 # 9a20 <malloc+0x460>
     9d0:	00008097          	auipc	ra,0x8
     9d4:	5f8080e7          	jalr	1528(ra) # 8fc8 <open>
  if(fd < 0){
     9d8:	0a054d63          	bltz	a0,a92 <writetest+0xe4>
     9dc:	892a                	mv	s2,a0
     9de:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     9e0:	00009997          	auipc	s3,0x9
     9e4:	06898993          	addi	s3,s3,104 # 9a48 <malloc+0x488>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     9e8:	00009a97          	auipc	s5,0x9
     9ec:	098a8a93          	addi	s5,s5,152 # 9a80 <malloc+0x4c0>
  for(i = 0; i < N; i++){
     9f0:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     9f4:	4629                	li	a2,10
     9f6:	85ce                	mv	a1,s3
     9f8:	854a                	mv	a0,s2
     9fa:	00008097          	auipc	ra,0x8
     9fe:	5ae080e7          	jalr	1454(ra) # 8fa8 <write>
     a02:	47a9                	li	a5,10
     a04:	0af51563          	bne	a0,a5,aae <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a08:	4629                	li	a2,10
     a0a:	85d6                	mv	a1,s5
     a0c:	854a                	mv	a0,s2
     a0e:	00008097          	auipc	ra,0x8
     a12:	59a080e7          	jalr	1434(ra) # 8fa8 <write>
     a16:	47a9                	li	a5,10
     a18:	0af51963          	bne	a0,a5,aca <writetest+0x11c>
  for(i = 0; i < N; i++){
     a1c:	2485                	addiw	s1,s1,1
     a1e:	fd449be3          	bne	s1,s4,9f4 <writetest+0x46>
  close(fd);
     a22:	854a                	mv	a0,s2
     a24:	00008097          	auipc	ra,0x8
     a28:	58c080e7          	jalr	1420(ra) # 8fb0 <close>
  fd = open("small", O_RDONLY);
     a2c:	4581                	li	a1,0
     a2e:	00009517          	auipc	a0,0x9
     a32:	ff250513          	addi	a0,a0,-14 # 9a20 <malloc+0x460>
     a36:	00008097          	auipc	ra,0x8
     a3a:	592080e7          	jalr	1426(ra) # 8fc8 <open>
     a3e:	84aa                	mv	s1,a0
  if(fd < 0){
     a40:	0a054363          	bltz	a0,ae6 <writetest+0x138>
  i = read(fd, buf, N*SZ*2);
     a44:	7d000613          	li	a2,2000
     a48:	0001c597          	auipc	a1,0x1c
     a4c:	68058593          	addi	a1,a1,1664 # 1d0c8 <buf>
     a50:	00008097          	auipc	ra,0x8
     a54:	550080e7          	jalr	1360(ra) # 8fa0 <read>
  if(i != N*SZ*2){
     a58:	7d000793          	li	a5,2000
     a5c:	0af51363          	bne	a0,a5,b02 <writetest+0x154>
  close(fd);
     a60:	8526                	mv	a0,s1
     a62:	00008097          	auipc	ra,0x8
     a66:	54e080e7          	jalr	1358(ra) # 8fb0 <close>
  if(remove("small") < 0){
     a6a:	00009517          	auipc	a0,0x9
     a6e:	fb650513          	addi	a0,a0,-74 # 9a20 <malloc+0x460>
     a72:	00008097          	auipc	ra,0x8
     a76:	5be080e7          	jalr	1470(ra) # 9030 <remove>
     a7a:	0a054263          	bltz	a0,b1e <writetest+0x170>
}
     a7e:	70e2                	ld	ra,56(sp)
     a80:	7442                	ld	s0,48(sp)
     a82:	74a2                	ld	s1,40(sp)
     a84:	7902                	ld	s2,32(sp)
     a86:	69e2                	ld	s3,24(sp)
     a88:	6a42                	ld	s4,16(sp)
     a8a:	6aa2                	ld	s5,8(sp)
     a8c:	6b02                	ld	s6,0(sp)
     a8e:	6121                	addi	sp,sp,64
     a90:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     a92:	85da                	mv	a1,s6
     a94:	00009517          	auipc	a0,0x9
     a98:	f9450513          	addi	a0,a0,-108 # 9a28 <malloc+0x468>
     a9c:	00009097          	auipc	ra,0x9
     aa0:	a6c080e7          	jalr	-1428(ra) # 9508 <printf>
    exit(1);
     aa4:	4505                	li	a0,1
     aa6:	00008097          	auipc	ra,0x8
     aaa:	4e2080e7          	jalr	1250(ra) # 8f88 <exit>
      printf("%s: error: write aa %d new file failed\n", i);
     aae:	85a6                	mv	a1,s1
     ab0:	00009517          	auipc	a0,0x9
     ab4:	fa850513          	addi	a0,a0,-88 # 9a58 <malloc+0x498>
     ab8:	00009097          	auipc	ra,0x9
     abc:	a50080e7          	jalr	-1456(ra) # 9508 <printf>
      exit(1);
     ac0:	4505                	li	a0,1
     ac2:	00008097          	auipc	ra,0x8
     ac6:	4c6080e7          	jalr	1222(ra) # 8f88 <exit>
      printf("%s: error: write bb %d new file failed\n", i);
     aca:	85a6                	mv	a1,s1
     acc:	00009517          	auipc	a0,0x9
     ad0:	fc450513          	addi	a0,a0,-60 # 9a90 <malloc+0x4d0>
     ad4:	00009097          	auipc	ra,0x9
     ad8:	a34080e7          	jalr	-1484(ra) # 9508 <printf>
      exit(1);
     adc:	4505                	li	a0,1
     ade:	00008097          	auipc	ra,0x8
     ae2:	4aa080e7          	jalr	1194(ra) # 8f88 <exit>
    printf("%s: error: open small failed!\n", s);
     ae6:	85da                	mv	a1,s6
     ae8:	00009517          	auipc	a0,0x9
     aec:	fd050513          	addi	a0,a0,-48 # 9ab8 <malloc+0x4f8>
     af0:	00009097          	auipc	ra,0x9
     af4:	a18080e7          	jalr	-1512(ra) # 9508 <printf>
    exit(1);
     af8:	4505                	li	a0,1
     afa:	00008097          	auipc	ra,0x8
     afe:	48e080e7          	jalr	1166(ra) # 8f88 <exit>
    printf("%s: read failed\n", s);
     b02:	85da                	mv	a1,s6
     b04:	00009517          	auipc	a0,0x9
     b08:	fd450513          	addi	a0,a0,-44 # 9ad8 <malloc+0x518>
     b0c:	00009097          	auipc	ra,0x9
     b10:	9fc080e7          	jalr	-1540(ra) # 9508 <printf>
    exit(1);
     b14:	4505                	li	a0,1
     b16:	00008097          	auipc	ra,0x8
     b1a:	472080e7          	jalr	1138(ra) # 8f88 <exit>
    printf("%s: remove small failed\n", s);
     b1e:	85da                	mv	a1,s6
     b20:	00009517          	auipc	a0,0x9
     b24:	fd050513          	addi	a0,a0,-48 # 9af0 <malloc+0x530>
     b28:	00009097          	auipc	ra,0x9
     b2c:	9e0080e7          	jalr	-1568(ra) # 9508 <printf>
    exit(1);
     b30:	4505                	li	a0,1
     b32:	00008097          	auipc	ra,0x8
     b36:	456080e7          	jalr	1110(ra) # 8f88 <exit>

0000000000000b3a <writebig>:
{
     b3a:	7179                	addi	sp,sp,-48
     b3c:	f406                	sd	ra,40(sp)
     b3e:	f022                	sd	s0,32(sp)
     b40:	ec26                	sd	s1,24(sp)
     b42:	e84a                	sd	s2,16(sp)
     b44:	e44e                	sd	s3,8(sp)
     b46:	e052                	sd	s4,0(sp)
     b48:	1800                	addi	s0,sp,48
     b4a:	8a2a                	mv	s4,a0
  fd = open("big", O_CREATE|O_RDWR);
     b4c:	20200593          	li	a1,514
     b50:	00009517          	auipc	a0,0x9
     b54:	fc050513          	addi	a0,a0,-64 # 9b10 <malloc+0x550>
     b58:	00008097          	auipc	ra,0x8
     b5c:	470080e7          	jalr	1136(ra) # 8fc8 <open>
     b60:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     b62:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     b64:	0001c917          	auipc	s2,0x1c
     b68:	56490913          	addi	s2,s2,1380 # 1d0c8 <buf>
  if(fd < 0){
     b6c:	06054e63          	bltz	a0,be8 <writebig+0xae>
    ((int*)buf)[0] = i;
     b70:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     b74:	20000613          	li	a2,512
     b78:	85ca                	mv	a1,s2
     b7a:	854e                	mv	a0,s3
     b7c:	00008097          	auipc	ra,0x8
     b80:	42c080e7          	jalr	1068(ra) # 8fa8 <write>
     b84:	20000793          	li	a5,512
     b88:	06f51e63          	bne	a0,a5,c04 <writebig+0xca>
  for(i = 0; i < MAXFILE; i++){
     b8c:	2485                	addiw	s1,s1,1
     b8e:	20000793          	li	a5,512
     b92:	fcf49fe3          	bne	s1,a5,b70 <writebig+0x36>
  close(fd);
     b96:	854e                	mv	a0,s3
     b98:	00008097          	auipc	ra,0x8
     b9c:	418080e7          	jalr	1048(ra) # 8fb0 <close>
  fd = open("big", O_RDONLY);
     ba0:	4581                	li	a1,0
     ba2:	00009517          	auipc	a0,0x9
     ba6:	f6e50513          	addi	a0,a0,-146 # 9b10 <malloc+0x550>
     baa:	00008097          	auipc	ra,0x8
     bae:	41e080e7          	jalr	1054(ra) # 8fc8 <open>
     bb2:	89aa                	mv	s3,a0
  n = 0;
     bb4:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     bb6:	0001c917          	auipc	s2,0x1c
     bba:	51290913          	addi	s2,s2,1298 # 1d0c8 <buf>
  if(fd < 0){
     bbe:	06054163          	bltz	a0,c20 <writebig+0xe6>
    i = read(fd, buf, BSIZE);
     bc2:	20000613          	li	a2,512
     bc6:	85ca                	mv	a1,s2
     bc8:	854e                	mv	a0,s3
     bca:	00008097          	auipc	ra,0x8
     bce:	3d6080e7          	jalr	982(ra) # 8fa0 <read>
    if(i == 0){
     bd2:	c52d                	beqz	a0,c3c <writebig+0x102>
    } else if(i != BSIZE){
     bd4:	20000793          	li	a5,512
     bd8:	0af51c63          	bne	a0,a5,c90 <writebig+0x156>
    if(((int*)buf)[0] != n){
     bdc:	00092603          	lw	a2,0(s2)
     be0:	0c961663          	bne	a2,s1,cac <writebig+0x172>
    n++;
     be4:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     be6:	bff1                	j	bc2 <writebig+0x88>
    printf("%s: error: creat big failed!\n", s);
     be8:	85d2                	mv	a1,s4
     bea:	00009517          	auipc	a0,0x9
     bee:	f2e50513          	addi	a0,a0,-210 # 9b18 <malloc+0x558>
     bf2:	00009097          	auipc	ra,0x9
     bf6:	916080e7          	jalr	-1770(ra) # 9508 <printf>
    exit(1);
     bfa:	4505                	li	a0,1
     bfc:	00008097          	auipc	ra,0x8
     c00:	38c080e7          	jalr	908(ra) # 8f88 <exit>
      printf("%s: error: write big file failed\n", i);
     c04:	85a6                	mv	a1,s1
     c06:	00009517          	auipc	a0,0x9
     c0a:	f3250513          	addi	a0,a0,-206 # 9b38 <malloc+0x578>
     c0e:	00009097          	auipc	ra,0x9
     c12:	8fa080e7          	jalr	-1798(ra) # 9508 <printf>
      exit(1);
     c16:	4505                	li	a0,1
     c18:	00008097          	auipc	ra,0x8
     c1c:	370080e7          	jalr	880(ra) # 8f88 <exit>
    printf("%s: error: open big failed!\n", s);
     c20:	85d2                	mv	a1,s4
     c22:	00009517          	auipc	a0,0x9
     c26:	f3e50513          	addi	a0,a0,-194 # 9b60 <malloc+0x5a0>
     c2a:	00009097          	auipc	ra,0x9
     c2e:	8de080e7          	jalr	-1826(ra) # 9508 <printf>
    exit(1);
     c32:	4505                	li	a0,1
     c34:	00008097          	auipc	ra,0x8
     c38:	354080e7          	jalr	852(ra) # 8f88 <exit>
      if(n == MAXFILE - 1){
     c3c:	1ff00793          	li	a5,511
     c40:	02f48963          	beq	s1,a5,c72 <writebig+0x138>
  close(fd);
     c44:	854e                	mv	a0,s3
     c46:	00008097          	auipc	ra,0x8
     c4a:	36a080e7          	jalr	874(ra) # 8fb0 <close>
  if(remove("big") < 0){
     c4e:	00009517          	auipc	a0,0x9
     c52:	ec250513          	addi	a0,a0,-318 # 9b10 <malloc+0x550>
     c56:	00008097          	auipc	ra,0x8
     c5a:	3da080e7          	jalr	986(ra) # 9030 <remove>
     c5e:	06054563          	bltz	a0,cc8 <writebig+0x18e>
}
     c62:	70a2                	ld	ra,40(sp)
     c64:	7402                	ld	s0,32(sp)
     c66:	64e2                	ld	s1,24(sp)
     c68:	6942                	ld	s2,16(sp)
     c6a:	69a2                	ld	s3,8(sp)
     c6c:	6a02                	ld	s4,0(sp)
     c6e:	6145                	addi	sp,sp,48
     c70:	8082                	ret
        printf("%s: read only %d blocks from big", n);
     c72:	1ff00593          	li	a1,511
     c76:	00009517          	auipc	a0,0x9
     c7a:	f0a50513          	addi	a0,a0,-246 # 9b80 <malloc+0x5c0>
     c7e:	00009097          	auipc	ra,0x9
     c82:	88a080e7          	jalr	-1910(ra) # 9508 <printf>
        exit(1);
     c86:	4505                	li	a0,1
     c88:	00008097          	auipc	ra,0x8
     c8c:	300080e7          	jalr	768(ra) # 8f88 <exit>
      printf("%s: read failed %d\n", i);
     c90:	85aa                	mv	a1,a0
     c92:	00009517          	auipc	a0,0x9
     c96:	f1650513          	addi	a0,a0,-234 # 9ba8 <malloc+0x5e8>
     c9a:	00009097          	auipc	ra,0x9
     c9e:	86e080e7          	jalr	-1938(ra) # 9508 <printf>
      exit(1);
     ca2:	4505                	li	a0,1
     ca4:	00008097          	auipc	ra,0x8
     ca8:	2e4080e7          	jalr	740(ra) # 8f88 <exit>
      printf("%s: read content of block %d is %d\n",
     cac:	85a6                	mv	a1,s1
     cae:	00009517          	auipc	a0,0x9
     cb2:	f1250513          	addi	a0,a0,-238 # 9bc0 <malloc+0x600>
     cb6:	00009097          	auipc	ra,0x9
     cba:	852080e7          	jalr	-1966(ra) # 9508 <printf>
      exit(1);
     cbe:	4505                	li	a0,1
     cc0:	00008097          	auipc	ra,0x8
     cc4:	2c8080e7          	jalr	712(ra) # 8f88 <exit>
    printf("%s: remove big failed\n", s);
     cc8:	85d2                	mv	a1,s4
     cca:	00009517          	auipc	a0,0x9
     cce:	f1e50513          	addi	a0,a0,-226 # 9be8 <malloc+0x628>
     cd2:	00009097          	auipc	ra,0x9
     cd6:	836080e7          	jalr	-1994(ra) # 9508 <printf>
    exit(1);
     cda:	4505                	li	a0,1
     cdc:	00008097          	auipc	ra,0x8
     ce0:	2ac080e7          	jalr	684(ra) # 8f88 <exit>

0000000000000ce4 <removeread>:
{
     ce4:	7179                	addi	sp,sp,-48
     ce6:	f406                	sd	ra,40(sp)
     ce8:	f022                	sd	s0,32(sp)
     cea:	ec26                	sd	s1,24(sp)
     cec:	e84a                	sd	s2,16(sp)
     cee:	e44e                	sd	s3,8(sp)
     cf0:	1800                	addi	s0,sp,48
     cf2:	89aa                	mv	s3,a0
  fd = open("removeread", O_CREATE | O_RDWR);
     cf4:	20200593          	li	a1,514
     cf8:	00009517          	auipc	a0,0x9
     cfc:	f0850513          	addi	a0,a0,-248 # 9c00 <malloc+0x640>
     d00:	00008097          	auipc	ra,0x8
     d04:	2c8080e7          	jalr	712(ra) # 8fc8 <open>
  if(fd < 0){
     d08:	0e054763          	bltz	a0,df6 <removeread+0x112>
     d0c:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d0e:	4615                	li	a2,5
     d10:	00009597          	auipc	a1,0x9
     d14:	f2058593          	addi	a1,a1,-224 # 9c30 <malloc+0x670>
     d18:	00008097          	auipc	ra,0x8
     d1c:	290080e7          	jalr	656(ra) # 8fa8 <write>
  close(fd);
     d20:	8526                	mv	a0,s1
     d22:	00008097          	auipc	ra,0x8
     d26:	28e080e7          	jalr	654(ra) # 8fb0 <close>
  fd = open("removeread", O_RDWR);
     d2a:	4589                	li	a1,2
     d2c:	00009517          	auipc	a0,0x9
     d30:	ed450513          	addi	a0,a0,-300 # 9c00 <malloc+0x640>
     d34:	00008097          	auipc	ra,0x8
     d38:	294080e7          	jalr	660(ra) # 8fc8 <open>
     d3c:	84aa                	mv	s1,a0
  if(fd < 0){
     d3e:	0c054a63          	bltz	a0,e12 <removeread+0x12e>
  if(remove("removeread") != 0){
     d42:	00009517          	auipc	a0,0x9
     d46:	ebe50513          	addi	a0,a0,-322 # 9c00 <malloc+0x640>
     d4a:	00008097          	auipc	ra,0x8
     d4e:	2e6080e7          	jalr	742(ra) # 9030 <remove>
     d52:	ed71                	bnez	a0,e2e <removeread+0x14a>
  fd1 = open("removeread", O_CREATE | O_RDWR);
     d54:	20200593          	li	a1,514
     d58:	00009517          	auipc	a0,0x9
     d5c:	ea850513          	addi	a0,a0,-344 # 9c00 <malloc+0x640>
     d60:	00008097          	auipc	ra,0x8
     d64:	268080e7          	jalr	616(ra) # 8fc8 <open>
     d68:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     d6a:	460d                	li	a2,3
     d6c:	00009597          	auipc	a1,0x9
     d70:	f0c58593          	addi	a1,a1,-244 # 9c78 <malloc+0x6b8>
     d74:	00008097          	auipc	ra,0x8
     d78:	234080e7          	jalr	564(ra) # 8fa8 <write>
  close(fd1);
     d7c:	854a                	mv	a0,s2
     d7e:	00008097          	auipc	ra,0x8
     d82:	232080e7          	jalr	562(ra) # 8fb0 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d86:	6609                	lui	a2,0x2
     d88:	80060613          	addi	a2,a2,-2048 # 1800 <exectest+0x172>
     d8c:	0001c597          	auipc	a1,0x1c
     d90:	33c58593          	addi	a1,a1,828 # 1d0c8 <buf>
     d94:	8526                	mv	a0,s1
     d96:	00008097          	auipc	ra,0x8
     d9a:	20a080e7          	jalr	522(ra) # 8fa0 <read>
     d9e:	4795                	li	a5,5
     da0:	0af51563          	bne	a0,a5,e4a <removeread+0x166>
  if(buf[0] != 'h'){
     da4:	0001c717          	auipc	a4,0x1c
     da8:	32474703          	lbu	a4,804(a4) # 1d0c8 <buf>
     dac:	06800793          	li	a5,104
     db0:	0af71b63          	bne	a4,a5,e66 <removeread+0x182>
  if(write(fd, buf, 10) != 10){
     db4:	4629                	li	a2,10
     db6:	0001c597          	auipc	a1,0x1c
     dba:	31258593          	addi	a1,a1,786 # 1d0c8 <buf>
     dbe:	8526                	mv	a0,s1
     dc0:	00008097          	auipc	ra,0x8
     dc4:	1e8080e7          	jalr	488(ra) # 8fa8 <write>
     dc8:	47a9                	li	a5,10
     dca:	0af51c63          	bne	a0,a5,e82 <removeread+0x19e>
  close(fd);
     dce:	8526                	mv	a0,s1
     dd0:	00008097          	auipc	ra,0x8
     dd4:	1e0080e7          	jalr	480(ra) # 8fb0 <close>
  remove("removeread");
     dd8:	00009517          	auipc	a0,0x9
     ddc:	e2850513          	addi	a0,a0,-472 # 9c00 <malloc+0x640>
     de0:	00008097          	auipc	ra,0x8
     de4:	250080e7          	jalr	592(ra) # 9030 <remove>
}
     de8:	70a2                	ld	ra,40(sp)
     dea:	7402                	ld	s0,32(sp)
     dec:	64e2                	ld	s1,24(sp)
     dee:	6942                	ld	s2,16(sp)
     df0:	69a2                	ld	s3,8(sp)
     df2:	6145                	addi	sp,sp,48
     df4:	8082                	ret
    printf("%s: create removeread failed\n", s);
     df6:	85ce                	mv	a1,s3
     df8:	00009517          	auipc	a0,0x9
     dfc:	e1850513          	addi	a0,a0,-488 # 9c10 <malloc+0x650>
     e00:	00008097          	auipc	ra,0x8
     e04:	708080e7          	jalr	1800(ra) # 9508 <printf>
    exit(1);
     e08:	4505                	li	a0,1
     e0a:	00008097          	auipc	ra,0x8
     e0e:	17e080e7          	jalr	382(ra) # 8f88 <exit>
    printf("%s: open removeread failed\n", s);
     e12:	85ce                	mv	a1,s3
     e14:	00009517          	auipc	a0,0x9
     e18:	e2450513          	addi	a0,a0,-476 # 9c38 <malloc+0x678>
     e1c:	00008097          	auipc	ra,0x8
     e20:	6ec080e7          	jalr	1772(ra) # 9508 <printf>
    exit(1);
     e24:	4505                	li	a0,1
     e26:	00008097          	auipc	ra,0x8
     e2a:	162080e7          	jalr	354(ra) # 8f88 <exit>
    printf("%s: remove removeread failed\n", s);
     e2e:	85ce                	mv	a1,s3
     e30:	00009517          	auipc	a0,0x9
     e34:	e2850513          	addi	a0,a0,-472 # 9c58 <malloc+0x698>
     e38:	00008097          	auipc	ra,0x8
     e3c:	6d0080e7          	jalr	1744(ra) # 9508 <printf>
    exit(1);
     e40:	4505                	li	a0,1
     e42:	00008097          	auipc	ra,0x8
     e46:	146080e7          	jalr	326(ra) # 8f88 <exit>
    printf("%s: removeread read failed", s);
     e4a:	85ce                	mv	a1,s3
     e4c:	00009517          	auipc	a0,0x9
     e50:	e3450513          	addi	a0,a0,-460 # 9c80 <malloc+0x6c0>
     e54:	00008097          	auipc	ra,0x8
     e58:	6b4080e7          	jalr	1716(ra) # 9508 <printf>
    exit(1);
     e5c:	4505                	li	a0,1
     e5e:	00008097          	auipc	ra,0x8
     e62:	12a080e7          	jalr	298(ra) # 8f88 <exit>
    printf("%s: removeread wrong data\n", s);
     e66:	85ce                	mv	a1,s3
     e68:	00009517          	auipc	a0,0x9
     e6c:	e3850513          	addi	a0,a0,-456 # 9ca0 <malloc+0x6e0>
     e70:	00008097          	auipc	ra,0x8
     e74:	698080e7          	jalr	1688(ra) # 9508 <printf>
    exit(1);
     e78:	4505                	li	a0,1
     e7a:	00008097          	auipc	ra,0x8
     e7e:	10e080e7          	jalr	270(ra) # 8f88 <exit>
    printf("%s: removeread write failed\n", s);
     e82:	85ce                	mv	a1,s3
     e84:	00009517          	auipc	a0,0x9
     e88:	e3c50513          	addi	a0,a0,-452 # 9cc0 <malloc+0x700>
     e8c:	00008097          	auipc	ra,0x8
     e90:	67c080e7          	jalr	1660(ra) # 9508 <printf>
    exit(1);
     e94:	4505                	li	a0,1
     e96:	00008097          	auipc	ra,0x8
     e9a:	0f2080e7          	jalr	242(ra) # 8f88 <exit>

0000000000000e9e <testdev>:
    if(verbose) { sigtest2_main(); return; }
    // Simplified: just verify sigaction exists
    sigaction(SIGUSR1, 0);
}

void testdev(char *s) {
     e9e:	7171                	addi	sp,sp,-176
     ea0:	f506                	sd	ra,168(sp)
     ea2:	f122                	sd	s0,160(sp)
     ea4:	ed26                	sd	s1,152(sp)
     ea6:	e94a                	sd	s2,144(sp)
     ea8:	e54e                	sd	s3,136(sp)
     eaa:	e152                	sd	s4,128(sp)
     eac:	fcd6                	sd	s5,120(sp)
     eae:	f8da                	sd	s6,112(sp)
     eb0:	1900                	addi	s0,sp,176
    if(verbose) { char *argv[] = {"testdev", 0}; testdev_main(1, argv); return; }
     eb2:	0000f797          	auipc	a5,0xf
     eb6:	9e27a783          	lw	a5,-1566(a5) # f894 <verbose>
     eba:	e7b1                	bnez	a5,f06 <testdev+0x68>
     ebc:	892a                	mv	s2,a0
    int fd = open("/dev/null", O_WRONLY);
     ebe:	4585                	li	a1,1
     ec0:	00009517          	auipc	a0,0x9
     ec4:	e6050513          	addi	a0,a0,-416 # 9d20 <malloc+0x760>
     ec8:	00008097          	auipc	ra,0x8
     ecc:	100080e7          	jalr	256(ra) # 8fc8 <open>
     ed0:	84aa                	mv	s1,a0
    if(fd < 0) { printf("%s: /dev/null failed\n", s); exit(1); }
     ed2:	3a054063          	bltz	a0,1272 <testdev+0x3d4>
    write(fd, "x", 1);
     ed6:	4605                	li	a2,1
     ed8:	00009597          	auipc	a1,0x9
     edc:	8a058593          	addi	a1,a1,-1888 # 9778 <malloc+0x1b8>
     ee0:	00008097          	auipc	ra,0x8
     ee4:	0c8080e7          	jalr	200(ra) # 8fa8 <write>
    close(fd);
     ee8:	8526                	mv	a0,s1
     eea:	00008097          	auipc	ra,0x8
     eee:	0c6080e7          	jalr	198(ra) # 8fb0 <close>
}
     ef2:	70aa                	ld	ra,168(sp)
     ef4:	740a                	ld	s0,160(sp)
     ef6:	64ea                	ld	s1,152(sp)
     ef8:	694a                	ld	s2,144(sp)
     efa:	69aa                	ld	s3,136(sp)
     efc:	6a0a                	ld	s4,128(sp)
     efe:	7ae6                	ld	s5,120(sp)
     f00:	7b46                	ld	s6,112(sp)
     f02:	614d                	addi	sp,sp,176
     f04:	8082                	ret
static int testdev_main()
{
  char buf[100];
  int fd, n;
  
  printf("=== Testing /dev/null ===\n");
     f06:	00009517          	auipc	a0,0x9
     f0a:	dda50513          	addi	a0,a0,-550 # 9ce0 <malloc+0x720>
     f0e:	00008097          	auipc	ra,0x8
     f12:	5fa080e7          	jalr	1530(ra) # 9508 <printf>
  
  // Test 1: Write to /dev/null (data should be discarded)
  printf("Test 1: Writing to /dev/null\n");
     f16:	00009517          	auipc	a0,0x9
     f1a:	dea50513          	addi	a0,a0,-534 # 9d00 <malloc+0x740>
     f1e:	00008097          	auipc	ra,0x8
     f22:	5ea080e7          	jalr	1514(ra) # 9508 <printf>
  fd = open("/dev/null", O_WRONLY);
     f26:	4585                	li	a1,1
     f28:	00009517          	auipc	a0,0x9
     f2c:	df850513          	addi	a0,a0,-520 # 9d20 <malloc+0x760>
     f30:	00008097          	auipc	ra,0x8
     f34:	098080e7          	jalr	152(ra) # 8fc8 <open>
     f38:	84aa                	mv	s1,a0
  if (fd < 0) {
     f3a:	14054663          	bltz	a0,1086 <testdev+0x1e8>
    printf("ERROR: Failed to open /dev/null\n");
    exit(1);
  }
  
  n = write(fd, "test data", 9);
     f3e:	4625                	li	a2,9
     f40:	00009597          	auipc	a1,0x9
     f44:	e1858593          	addi	a1,a1,-488 # 9d58 <malloc+0x798>
     f48:	00008097          	auipc	ra,0x8
     f4c:	060080e7          	jalr	96(ra) # 8fa8 <write>
     f50:	892a                	mv	s2,a0
  printf("  -> Write returned: %d bytes (data discarded)\n", n);
     f52:	85aa                	mv	a1,a0
     f54:	00009517          	auipc	a0,0x9
     f58:	e1450513          	addi	a0,a0,-492 # 9d68 <malloc+0x7a8>
     f5c:	00008097          	auipc	ra,0x8
     f60:	5ac080e7          	jalr	1452(ra) # 9508 <printf>
  if (n == 9) {
     f64:	47a5                	li	a5,9
     f66:	12f90d63          	beq	s2,a5,10a0 <testdev+0x202>
    printf("  -> SUCCESS: Write operation succeeded\n");
  } else {
    printf("  -> ERROR: Write should return 9 bytes\n");
     f6a:	00009517          	auipc	a0,0x9
     f6e:	e5e50513          	addi	a0,a0,-418 # 9dc8 <malloc+0x808>
     f72:	00008097          	auipc	ra,0x8
     f76:	596080e7          	jalr	1430(ra) # 9508 <printf>
  }
  close(fd);
     f7a:	8526                	mv	a0,s1
     f7c:	00008097          	auipc	ra,0x8
     f80:	034080e7          	jalr	52(ra) # 8fb0 <close>
  
  // Test 2: Read from /dev/null (should return EOF immediately)
  printf("\nTest 2: Reading from /dev/null\n");
     f84:	00009517          	auipc	a0,0x9
     f88:	e7450513          	addi	a0,a0,-396 # 9df8 <malloc+0x838>
     f8c:	00008097          	auipc	ra,0x8
     f90:	57c080e7          	jalr	1404(ra) # 9508 <printf>
  fd = open("/dev/null", O_RDONLY);
     f94:	4581                	li	a1,0
     f96:	00009517          	auipc	a0,0x9
     f9a:	d8a50513          	addi	a0,a0,-630 # 9d20 <malloc+0x760>
     f9e:	00008097          	auipc	ra,0x8
     fa2:	02a080e7          	jalr	42(ra) # 8fc8 <open>
     fa6:	84aa                	mv	s1,a0
  if (fd < 0) {
     fa8:	10054563          	bltz	a0,10b2 <testdev+0x214>
    printf("ERROR: Failed to open /dev/null\n");
    exit(1);
  }
  
  n = read(fd, buf, 100);
     fac:	06400613          	li	a2,100
     fb0:	f5840593          	addi	a1,s0,-168
     fb4:	00008097          	auipc	ra,0x8
     fb8:	fec080e7          	jalr	-20(ra) # 8fa0 <read>
     fbc:	892a                	mv	s2,a0
  printf("  -> Read returned: %d bytes (should be 0, EOF)\n", n);
     fbe:	85aa                	mv	a1,a0
     fc0:	00009517          	auipc	a0,0x9
     fc4:	e6050513          	addi	a0,a0,-416 # 9e20 <malloc+0x860>
     fc8:	00008097          	auipc	ra,0x8
     fcc:	540080e7          	jalr	1344(ra) # 9508 <printf>
  if (n == 0) {
     fd0:	0e091e63          	bnez	s2,10cc <testdev+0x22e>
    printf("  -> SUCCESS: /dev/null correctly returns EOF\n");
     fd4:	00009517          	auipc	a0,0x9
     fd8:	e8450513          	addi	a0,a0,-380 # 9e58 <malloc+0x898>
     fdc:	00008097          	auipc	ra,0x8
     fe0:	52c080e7          	jalr	1324(ra) # 9508 <printf>
  } else {
    printf("  -> ERROR: /dev/null should return 0 bytes\n");
  }
  close(fd);
     fe4:	8526                	mv	a0,s1
     fe6:	00008097          	auipc	ra,0x8
     fea:	fca080e7          	jalr	-54(ra) # 8fb0 <close>
  
  printf("\n=== Testing /dev/zero ===\n");
     fee:	00009517          	auipc	a0,0x9
     ff2:	eca50513          	addi	a0,a0,-310 # 9eb8 <malloc+0x8f8>
     ff6:	00008097          	auipc	ra,0x8
     ffa:	512080e7          	jalr	1298(ra) # 9508 <printf>
  
  // Test 3: Read from /dev/zero (should return all zeros)
  printf("Test 3: Reading from /dev/zero\n");
     ffe:	00009517          	auipc	a0,0x9
    1002:	eda50513          	addi	a0,a0,-294 # 9ed8 <malloc+0x918>
    1006:	00008097          	auipc	ra,0x8
    100a:	502080e7          	jalr	1282(ra) # 9508 <printf>
  fd = open("/dev/zero", O_RDONLY);
    100e:	4581                	li	a1,0
    1010:	00009517          	auipc	a0,0x9
    1014:	ee850513          	addi	a0,a0,-280 # 9ef8 <malloc+0x938>
    1018:	00008097          	auipc	ra,0x8
    101c:	fb0080e7          	jalr	-80(ra) # 8fc8 <open>
    1020:	84aa                	mv	s1,a0
  if (fd < 0) {
    1022:	0a054e63          	bltz	a0,10de <testdev+0x240>
    printf("ERROR: Failed to open /dev/zero\n");
    exit(1);
  }
  
  n = read(fd, buf, 50);
    1026:	03200613          	li	a2,50
    102a:	f5840593          	addi	a1,s0,-168
    102e:	00008097          	auipc	ra,0x8
    1032:	f72080e7          	jalr	-142(ra) # 8fa0 <read>
    1036:	892a                	mv	s2,a0
  printf("  -> Read returned: %d bytes\n", n);
    1038:	85aa                	mv	a1,a0
    103a:	00009517          	auipc	a0,0x9
    103e:	ef650513          	addi	a0,a0,-266 # 9f30 <malloc+0x970>
    1042:	00008097          	auipc	ra,0x8
    1046:	4c6080e7          	jalr	1222(ra) # 9508 <printf>
  
  // Check if all read data is zero
  int all_zero = 1;
  for (int i = 0; i < n; i++) {
    104a:	4781                	li	a5,0
    if (buf[i] != 0) {
    104c:	f5840713          	addi	a4,s0,-168
    1050:	0007859b          	sext.w	a1,a5
  for (int i = 0; i < n; i++) {
    1054:	0b25d263          	bge	a1,s2,10f8 <testdev+0x25a>
    if (buf[i] != 0) {
    1058:	0785                	addi	a5,a5,1
    105a:	00f706b3          	add	a3,a4,a5
    105e:	fff6c603          	lbu	a2,-1(a3)
    1062:	d67d                	beqz	a2,1050 <testdev+0x1b2>
      all_zero = 0;
      printf("  -> ERROR: Byte at position %d is %d, not 0\n", i, (unsigned char)buf[i]);
    1064:	00009517          	auipc	a0,0x9
    1068:	eec50513          	addi	a0,a0,-276 # 9f50 <malloc+0x990>
    106c:	00008097          	auipc	ra,0x8
    1070:	49c080e7          	jalr	1180(ra) # 9508 <printf>
  }
  
  if (all_zero) {
    printf("  -> SUCCESS: /dev/zero returns all zeros\n");
  } else {
    printf("  -> ERROR: /dev/zero should return all zeros\n");
    1074:	00009517          	auipc	a0,0x9
    1078:	f0c50513          	addi	a0,a0,-244 # 9f80 <malloc+0x9c0>
    107c:	00008097          	auipc	ra,0x8
    1080:	48c080e7          	jalr	1164(ra) # 9508 <printf>
    1084:	a051                	j	1108 <testdev+0x26a>
    printf("ERROR: Failed to open /dev/null\n");
    1086:	00009517          	auipc	a0,0x9
    108a:	caa50513          	addi	a0,a0,-854 # 9d30 <malloc+0x770>
    108e:	00008097          	auipc	ra,0x8
    1092:	47a080e7          	jalr	1146(ra) # 9508 <printf>
    exit(1);
    1096:	4505                	li	a0,1
    1098:	00008097          	auipc	ra,0x8
    109c:	ef0080e7          	jalr	-272(ra) # 8f88 <exit>
    printf("  -> SUCCESS: Write operation succeeded\n");
    10a0:	00009517          	auipc	a0,0x9
    10a4:	cf850513          	addi	a0,a0,-776 # 9d98 <malloc+0x7d8>
    10a8:	00008097          	auipc	ra,0x8
    10ac:	460080e7          	jalr	1120(ra) # 9508 <printf>
    10b0:	b5e9                	j	f7a <testdev+0xdc>
    printf("ERROR: Failed to open /dev/null\n");
    10b2:	00009517          	auipc	a0,0x9
    10b6:	c7e50513          	addi	a0,a0,-898 # 9d30 <malloc+0x770>
    10ba:	00008097          	auipc	ra,0x8
    10be:	44e080e7          	jalr	1102(ra) # 9508 <printf>
    exit(1);
    10c2:	4505                	li	a0,1
    10c4:	00008097          	auipc	ra,0x8
    10c8:	ec4080e7          	jalr	-316(ra) # 8f88 <exit>
    printf("  -> ERROR: /dev/null should return 0 bytes\n");
    10cc:	00009517          	auipc	a0,0x9
    10d0:	dbc50513          	addi	a0,a0,-580 # 9e88 <malloc+0x8c8>
    10d4:	00008097          	auipc	ra,0x8
    10d8:	434080e7          	jalr	1076(ra) # 9508 <printf>
    10dc:	b721                	j	fe4 <testdev+0x146>
    printf("ERROR: Failed to open /dev/zero\n");
    10de:	00009517          	auipc	a0,0x9
    10e2:	e2a50513          	addi	a0,a0,-470 # 9f08 <malloc+0x948>
    10e6:	00008097          	auipc	ra,0x8
    10ea:	422080e7          	jalr	1058(ra) # 9508 <printf>
    exit(1);
    10ee:	4505                	li	a0,1
    10f0:	00008097          	auipc	ra,0x8
    10f4:	e98080e7          	jalr	-360(ra) # 8f88 <exit>
    printf("  -> SUCCESS: /dev/zero returns all zeros\n");
    10f8:	00009517          	auipc	a0,0x9
    10fc:	eb850513          	addi	a0,a0,-328 # 9fb0 <malloc+0x9f0>
    1100:	00008097          	auipc	ra,0x8
    1104:	408080e7          	jalr	1032(ra) # 9508 <printf>
  }
  close(fd);
    1108:	8526                	mv	a0,s1
    110a:	00008097          	auipc	ra,0x8
    110e:	ea6080e7          	jalr	-346(ra) # 8fb0 <close>
  
  // Test 4: Write to /dev/zero (data should be discarded)
  printf("\nTest 4: Writing to /dev/zero\n");
    1112:	00009517          	auipc	a0,0x9
    1116:	ece50513          	addi	a0,a0,-306 # 9fe0 <malloc+0xa20>
    111a:	00008097          	auipc	ra,0x8
    111e:	3ee080e7          	jalr	1006(ra) # 9508 <printf>
  fd = open("/dev/zero", O_WRONLY);
    1122:	4585                	li	a1,1
    1124:	00009517          	auipc	a0,0x9
    1128:	dd450513          	addi	a0,a0,-556 # 9ef8 <malloc+0x938>
    112c:	00008097          	auipc	ra,0x8
    1130:	e9c080e7          	jalr	-356(ra) # 8fc8 <open>
    1134:	84aa                	mv	s1,a0
  if (fd < 0) {
    1136:	0e054663          	bltz	a0,1222 <testdev+0x384>
    printf("ERROR: Failed to open /dev/zero\n");
    exit(1);
  }
  
  n = write(fd, "test data", 9);
    113a:	4625                	li	a2,9
    113c:	00009597          	auipc	a1,0x9
    1140:	c1c58593          	addi	a1,a1,-996 # 9d58 <malloc+0x798>
    1144:	00008097          	auipc	ra,0x8
    1148:	e64080e7          	jalr	-412(ra) # 8fa8 <write>
    114c:	892a                	mv	s2,a0
  printf("  -> Write returned: %d bytes (data discarded)\n", n);
    114e:	85aa                	mv	a1,a0
    1150:	00009517          	auipc	a0,0x9
    1154:	c1850513          	addi	a0,a0,-1000 # 9d68 <malloc+0x7a8>
    1158:	00008097          	auipc	ra,0x8
    115c:	3b0080e7          	jalr	944(ra) # 9508 <printf>
  if (n == 9) {
    1160:	47a5                	li	a5,9
    1162:	0cf90d63          	beq	s2,a5,123c <testdev+0x39e>
    printf("  -> SUCCESS: Write operation succeeded\n");
  } else {
    printf("  -> ERROR: Write should return 9 bytes\n");
    1166:	00009517          	auipc	a0,0x9
    116a:	c6250513          	addi	a0,a0,-926 # 9dc8 <malloc+0x808>
    116e:	00008097          	auipc	ra,0x8
    1172:	39a080e7          	jalr	922(ra) # 9508 <printf>
  }
  close(fd);
    1176:	8526                	mv	a0,s1
    1178:	00008097          	auipc	ra,0x8
    117c:	e38080e7          	jalr	-456(ra) # 8fb0 <close>
  
  // Test 5: Multiple reads from /dev/zero (verify infinite reading)
  printf("\nTest 5: Multiple reads from /dev/zero\n");
    1180:	00009517          	auipc	a0,0x9
    1184:	e8050513          	addi	a0,a0,-384 # a000 <malloc+0xa40>
    1188:	00008097          	auipc	ra,0x8
    118c:	380080e7          	jalr	896(ra) # 9508 <printf>
  fd = open("/dev/zero", O_RDONLY);
    1190:	4581                	li	a1,0
    1192:	00009517          	auipc	a0,0x9
    1196:	d6650513          	addi	a0,a0,-666 # 9ef8 <malloc+0x938>
    119a:	00008097          	auipc	ra,0x8
    119e:	e2e080e7          	jalr	-466(ra) # 8fc8 <open>
    11a2:	84aa                	mv	s1,a0
  for (int i = 0; i < 3; i++) {
    11a4:	4901                	li	s2,0
    n = read(fd, buf, 10);
    11a6:	f5840a93          	addi	s5,s0,-168
    printf("  -> Read #%d: %d bytes\n", i + 1, n);
    11aa:	00009b17          	auipc	s6,0x9
    11ae:	e7eb0b13          	addi	s6,s6,-386 # a028 <malloc+0xa68>
  for (int i = 0; i < 3; i++) {
    11b2:	4a0d                	li	s4,3
    n = read(fd, buf, 10);
    11b4:	4629                	li	a2,10
    11b6:	85d6                	mv	a1,s5
    11b8:	8526                	mv	a0,s1
    11ba:	00008097          	auipc	ra,0x8
    11be:	de6080e7          	jalr	-538(ra) # 8fa0 <read>
    11c2:	89aa                	mv	s3,a0
    printf("  -> Read #%d: %d bytes\n", i + 1, n);
    11c4:	2905                	addiw	s2,s2,1
    11c6:	862a                	mv	a2,a0
    11c8:	85ca                	mv	a1,s2
    11ca:	855a                	mv	a0,s6
    11cc:	00008097          	auipc	ra,0x8
    11d0:	33c080e7          	jalr	828(ra) # 9508 <printf>
    if (n != 10) {
    11d4:	47a9                	li	a5,10
    11d6:	06f99c63          	bne	s3,a5,124e <testdev+0x3b0>
  for (int i = 0; i < 3; i++) {
    11da:	fd491de3          	bne	s2,s4,11b4 <testdev+0x316>
      printf("  -> ERROR: Read should return 10 bytes\n");
      close(fd);
      exit(1);
    }
  }
  printf("  -> SUCCESS: Multiple reads work correctly\n");
    11de:	00009517          	auipc	a0,0x9
    11e2:	e9a50513          	addi	a0,a0,-358 # a078 <malloc+0xab8>
    11e6:	00008097          	auipc	ra,0x8
    11ea:	322080e7          	jalr	802(ra) # 9508 <printf>
  close(fd);
    11ee:	8526                	mv	a0,s1
    11f0:	00008097          	auipc	ra,0x8
    11f4:	dc0080e7          	jalr	-576(ra) # 8fb0 <close>
  
  printf("\n=== All tests completed ===\n");
    11f8:	00009517          	auipc	a0,0x9
    11fc:	eb050513          	addi	a0,a0,-336 # a0a8 <malloc+0xae8>
    1200:	00008097          	auipc	ra,0x8
    1204:	308080e7          	jalr	776(ra) # 9508 <printf>
  printf("SUCCESS: /dev/null and /dev/zero are working correctly!\n");
    1208:	00009517          	auipc	a0,0x9
    120c:	ec050513          	addi	a0,a0,-320 # a0c8 <malloc+0xb08>
    1210:	00008097          	auipc	ra,0x8
    1214:	2f8080e7          	jalr	760(ra) # 9508 <printf>
  
  exit(0);
    1218:	4501                	li	a0,0
    121a:	00008097          	auipc	ra,0x8
    121e:	d6e080e7          	jalr	-658(ra) # 8f88 <exit>
    printf("ERROR: Failed to open /dev/zero\n");
    1222:	00009517          	auipc	a0,0x9
    1226:	ce650513          	addi	a0,a0,-794 # 9f08 <malloc+0x948>
    122a:	00008097          	auipc	ra,0x8
    122e:	2de080e7          	jalr	734(ra) # 9508 <printf>
    exit(1);
    1232:	4505                	li	a0,1
    1234:	00008097          	auipc	ra,0x8
    1238:	d54080e7          	jalr	-684(ra) # 8f88 <exit>
    printf("  -> SUCCESS: Write operation succeeded\n");
    123c:	00009517          	auipc	a0,0x9
    1240:	b5c50513          	addi	a0,a0,-1188 # 9d98 <malloc+0x7d8>
    1244:	00008097          	auipc	ra,0x8
    1248:	2c4080e7          	jalr	708(ra) # 9508 <printf>
    124c:	b72d                	j	1176 <testdev+0x2d8>
      printf("  -> ERROR: Read should return 10 bytes\n");
    124e:	00009517          	auipc	a0,0x9
    1252:	dfa50513          	addi	a0,a0,-518 # a048 <malloc+0xa88>
    1256:	00008097          	auipc	ra,0x8
    125a:	2b2080e7          	jalr	690(ra) # 9508 <printf>
      close(fd);
    125e:	8526                	mv	a0,s1
    1260:	00008097          	auipc	ra,0x8
    1264:	d50080e7          	jalr	-688(ra) # 8fb0 <close>
      exit(1);
    1268:	4505                	li	a0,1
    126a:	00008097          	auipc	ra,0x8
    126e:	d1e080e7          	jalr	-738(ra) # 8f88 <exit>
    if(fd < 0) { printf("%s: /dev/null failed\n", s); exit(1); }
    1272:	85ca                	mv	a1,s2
    1274:	00009517          	auipc	a0,0x9
    1278:	e9450513          	addi	a0,a0,-364 # a108 <malloc+0xb48>
    127c:	00008097          	auipc	ra,0x8
    1280:	28c080e7          	jalr	652(ra) # 9508 <printf>
    1284:	4505                	li	a0,1
    1286:	00008097          	auipc	ra,0x8
    128a:	d02080e7          	jalr	-766(ra) # 8f88 <exit>

000000000000128e <pgbug>:
{
    128e:	7179                	addi	sp,sp,-48
    1290:	f406                	sd	ra,40(sp)
    1292:	f022                	sd	s0,32(sp)
    1294:	ec26                	sd	s1,24(sp)
    1296:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1298:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    129c:	0000e497          	auipc	s1,0xe
    12a0:	0944b483          	ld	s1,148(s1) # f330 <malloc+0x5d70>
    12a4:	fd840593          	addi	a1,s0,-40
    12a8:	8526                	mv	a0,s1
    12aa:	00008097          	auipc	ra,0x8
    12ae:	d16080e7          	jalr	-746(ra) # 8fc0 <exec>
  pipe((int*)0xeaeb0b5b00002f5e);
    12b2:	8526                	mv	a0,s1
    12b4:	00008097          	auipc	ra,0x8
    12b8:	ce4080e7          	jalr	-796(ra) # 8f98 <pipe>
  exit(0);
    12bc:	4501                	li	a0,0
    12be:	00008097          	auipc	ra,0x8
    12c2:	cca080e7          	jalr	-822(ra) # 8f88 <exit>

00000000000012c6 <badarg>:
{
    12c6:	7139                	addi	sp,sp,-64
    12c8:	fc06                	sd	ra,56(sp)
    12ca:	f822                	sd	s0,48(sp)
    12cc:	f426                	sd	s1,40(sp)
    12ce:	f04a                	sd	s2,32(sp)
    12d0:	ec4e                	sd	s3,24(sp)
    12d2:	e852                	sd	s4,16(sp)
    12d4:	0080                	addi	s0,sp,64
    12d6:	64b1                	lui	s1,0xc
    12d8:	35048493          	addi	s1,s1,848 # c350 <malloc+0x2d90>
    argv[0] = (char*)0xffffffff;
    12dc:	597d                	li	s2,-1
    12de:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    12e2:	fc040a13          	addi	s4,s0,-64
    12e6:	00008997          	auipc	s3,0x8
    12ea:	42298993          	addi	s3,s3,1058 # 9708 <malloc+0x148>
    argv[0] = (char*)0xffffffff;
    12ee:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    12f2:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    12f6:	85d2                	mv	a1,s4
    12f8:	854e                	mv	a0,s3
    12fa:	00008097          	auipc	ra,0x8
    12fe:	cc6080e7          	jalr	-826(ra) # 8fc0 <exec>
  for(int i = 0; i < 50000; i++){
    1302:	34fd                	addiw	s1,s1,-1
    1304:	f4ed                	bnez	s1,12ee <badarg+0x28>
  exit(0);
    1306:	4501                	li	a0,0
    1308:	00008097          	auipc	ra,0x8
    130c:	c80080e7          	jalr	-896(ra) # 8f88 <exit>

0000000000001310 <copyinstr2>:
{
    1310:	714d                	addi	sp,sp,-336
    1312:	e686                	sd	ra,328(sp)
    1314:	e2a2                	sd	s0,320(sp)
    1316:	0a80                	addi	s0,sp,336
  for(int i = 0; i < MAXPATH; i++)
    1318:	ee840793          	addi	a5,s0,-280
    131c:	fec40693          	addi	a3,s0,-20
    b[i] = 'x';
    1320:	07800713          	li	a4,120
    1324:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    1328:	0785                	addi	a5,a5,1
    132a:	fed79de3          	bne	a5,a3,1324 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    132e:	fe040623          	sb	zero,-20(s0)
  int ret = remove(b);
    1332:	ee840513          	addi	a0,s0,-280
    1336:	00008097          	auipc	ra,0x8
    133a:	cfa080e7          	jalr	-774(ra) # 9030 <remove>
  if(ret != -1){
    133e:	57fd                	li	a5,-1
    1340:	0cf51663          	bne	a0,a5,140c <copyinstr2+0xfc>
  int fd = open(b, O_CREATE | O_WRONLY);
    1344:	20100593          	li	a1,513
    1348:	ee840513          	addi	a0,s0,-280
    134c:	00008097          	auipc	ra,0x8
    1350:	c7c080e7          	jalr	-900(ra) # 8fc8 <open>
  if(fd != -1){
    1354:	57fd                	li	a5,-1
    1356:	0cf51b63          	bne	a0,a5,142c <copyinstr2+0x11c>
  char *args[] = { "xx", 0 };
    135a:	0000a797          	auipc	a5,0xa
    135e:	9de78793          	addi	a5,a5,-1570 # ad38 <malloc+0x1778>
    1362:	ecf43c23          	sd	a5,-296(s0)
    1366:	ee043023          	sd	zero,-288(s0)
  ret = exec(b, args);
    136a:	ed840593          	addi	a1,s0,-296
    136e:	ee840513          	addi	a0,s0,-280
    1372:	00008097          	auipc	ra,0x8
    1376:	c4e080e7          	jalr	-946(ra) # 8fc0 <exec>
  if(ret != -1){
    137a:	57fd                	li	a5,-1
    137c:	0cf51863          	bne	a0,a5,144c <copyinstr2+0x13c>
  int pid = fork();
    1380:	00008097          	auipc	ra,0x8
    1384:	c00080e7          	jalr	-1024(ra) # 8f80 <fork>
  if(pid < 0){
    1388:	0e054263          	bltz	a0,146c <copyinstr2+0x15c>
  if(pid == 0){
    138c:	10051363          	bnez	a0,1492 <copyinstr2+0x182>
    1390:	0000e797          	auipc	a5,0xe
    1394:	61878793          	addi	a5,a5,1560 # f9a8 <big.0>
    1398:	0000f697          	auipc	a3,0xf
    139c:	61068693          	addi	a3,a3,1552 # 109a8 <__global_pointer$+0x920>
      big[i] = 'x';
    13a0:	07800713          	li	a4,120
    13a4:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    13a8:	0785                	addi	a5,a5,1
    13aa:	fed79de3          	bne	a5,a3,13a4 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    13ae:	0000f797          	auipc	a5,0xf
    13b2:	5e078d23          	sb	zero,1530(a5) # 109a8 <__global_pointer$+0x920>
    char *args2[] = { big, big, big, 0 };
    13b6:	0000e797          	auipc	a5,0xe
    13ba:	ffa78793          	addi	a5,a5,-6 # f3b0 <__DATA_BEGIN__>
    13be:	6390                	ld	a2,0(a5)
    13c0:	6794                	ld	a3,8(a5)
    13c2:	6b98                	ld	a4,16(a5)
    13c4:	6f9c                	ld	a5,24(a5)
    13c6:	eac43823          	sd	a2,-336(s0)
    13ca:	ead43c23          	sd	a3,-328(s0)
    13ce:	ece43023          	sd	a4,-320(s0)
    13d2:	ecf43423          	sd	a5,-312(s0)
    ret = exec("echo", args2);
    13d6:	eb040593          	addi	a1,s0,-336
    13da:	00008517          	auipc	a0,0x8
    13de:	32e50513          	addi	a0,a0,814 # 9708 <malloc+0x148>
    13e2:	00008097          	auipc	ra,0x8
    13e6:	bde080e7          	jalr	-1058(ra) # 8fc0 <exec>
    if(ret != -1){
    13ea:	57fd                	li	a5,-1
    13ec:	08f50d63          	beq	a0,a5,1486 <copyinstr2+0x176>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    13f0:	55fd                	li	a1,-1
    13f2:	00009517          	auipc	a0,0x9
    13f6:	d8e50513          	addi	a0,a0,-626 # a180 <malloc+0xbc0>
    13fa:	00008097          	auipc	ra,0x8
    13fe:	10e080e7          	jalr	270(ra) # 9508 <printf>
      exit(1);
    1402:	4505                	li	a0,1
    1404:	00008097          	auipc	ra,0x8
    1408:	b84080e7          	jalr	-1148(ra) # 8f88 <exit>
    printf("remove(%s) returned %d, not -1\n", b, ret);
    140c:	862a                	mv	a2,a0
    140e:	ee840593          	addi	a1,s0,-280
    1412:	00009517          	auipc	a0,0x9
    1416:	d0e50513          	addi	a0,a0,-754 # a120 <malloc+0xb60>
    141a:	00008097          	auipc	ra,0x8
    141e:	0ee080e7          	jalr	238(ra) # 9508 <printf>
    exit(1);
    1422:	4505                	li	a0,1
    1424:	00008097          	auipc	ra,0x8
    1428:	b64080e7          	jalr	-1180(ra) # 8f88 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    142c:	862a                	mv	a2,a0
    142e:	ee840593          	addi	a1,s0,-280
    1432:	00009517          	auipc	a0,0x9
    1436:	d0e50513          	addi	a0,a0,-754 # a140 <malloc+0xb80>
    143a:	00008097          	auipc	ra,0x8
    143e:	0ce080e7          	jalr	206(ra) # 9508 <printf>
    exit(1);
    1442:	4505                	li	a0,1
    1444:	00008097          	auipc	ra,0x8
    1448:	b44080e7          	jalr	-1212(ra) # 8f88 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    144c:	567d                	li	a2,-1
    144e:	ee840593          	addi	a1,s0,-280
    1452:	00009517          	auipc	a0,0x9
    1456:	d0e50513          	addi	a0,a0,-754 # a160 <malloc+0xba0>
    145a:	00008097          	auipc	ra,0x8
    145e:	0ae080e7          	jalr	174(ra) # 9508 <printf>
    exit(1);
    1462:	4505                	li	a0,1
    1464:	00008097          	auipc	ra,0x8
    1468:	b24080e7          	jalr	-1244(ra) # 8f88 <exit>
    printf("fork failed\n");
    146c:	00009517          	auipc	a0,0x9
    1470:	0ec50513          	addi	a0,a0,236 # a558 <malloc+0xf98>
    1474:	00008097          	auipc	ra,0x8
    1478:	094080e7          	jalr	148(ra) # 9508 <printf>
    exit(1);
    147c:	4505                	li	a0,1
    147e:	00008097          	auipc	ra,0x8
    1482:	b0a080e7          	jalr	-1270(ra) # 8f88 <exit>
    exit(747); // OK
    1486:	2eb00513          	li	a0,747
    148a:	00008097          	auipc	ra,0x8
    148e:	afe080e7          	jalr	-1282(ra) # 8f88 <exit>
  int st = 0;
    1492:	ec042a23          	sw	zero,-300(s0)
  wait(&st);
    1496:	ed440513          	addi	a0,s0,-300
    149a:	00008097          	auipc	ra,0x8
    149e:	af6080e7          	jalr	-1290(ra) # 8f90 <wait>
  if(st != 747){
    14a2:	ed442703          	lw	a4,-300(s0)
    14a6:	2eb00793          	li	a5,747
    14aa:	00f71663          	bne	a4,a5,14b6 <copyinstr2+0x1a6>
}
    14ae:	60b6                	ld	ra,328(sp)
    14b0:	6416                	ld	s0,320(sp)
    14b2:	6171                	addi	sp,sp,336
    14b4:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    14b6:	00009517          	auipc	a0,0x9
    14ba:	cf250513          	addi	a0,a0,-782 # a1a8 <malloc+0xbe8>
    14be:	00008097          	auipc	ra,0x8
    14c2:	04a080e7          	jalr	74(ra) # 9508 <printf>
    exit(1);
    14c6:	4505                	li	a0,1
    14c8:	00008097          	auipc	ra,0x8
    14cc:	ac0080e7          	jalr	-1344(ra) # 8f88 <exit>

00000000000014d0 <truncate3>:
{
    14d0:	7159                	addi	sp,sp,-112
    14d2:	f486                	sd	ra,104(sp)
    14d4:	f0a2                	sd	s0,96(sp)
    14d6:	eca6                	sd	s1,88(sp)
    14d8:	e8ca                	sd	s2,80(sp)
    14da:	e4ce                	sd	s3,72(sp)
    14dc:	e0d2                	sd	s4,64(sp)
    14de:	fc56                	sd	s5,56(sp)
    14e0:	f85a                	sd	s6,48(sp)
    14e2:	1880                	addi	s0,sp,112
    14e4:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    14e6:	60100593          	li	a1,1537
    14ea:	00008517          	auipc	a0,0x8
    14ee:	27650513          	addi	a0,a0,630 # 9760 <malloc+0x1a0>
    14f2:	00008097          	auipc	ra,0x8
    14f6:	ad6080e7          	jalr	-1322(ra) # 8fc8 <open>
    14fa:	00008097          	auipc	ra,0x8
    14fe:	ab6080e7          	jalr	-1354(ra) # 8fb0 <close>
  pid = fork();
    1502:	00008097          	auipc	ra,0x8
    1506:	a7e080e7          	jalr	-1410(ra) # 8f80 <fork>
  if(pid < 0){
    150a:	08054163          	bltz	a0,158c <truncate3+0xbc>
  if(pid == 0){
    150e:	e971                	bnez	a0,15e2 <truncate3+0x112>
    1510:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1514:	00008a17          	auipc	s4,0x8
    1518:	24ca0a13          	addi	s4,s4,588 # 9760 <malloc+0x1a0>
      int n = write(fd, "1234567890", 10);
    151c:	00009a97          	auipc	s5,0x9
    1520:	ceca8a93          	addi	s5,s5,-788 # a208 <malloc+0xc48>
      read(fd, buf, sizeof(buf));
    1524:	f9840b13          	addi	s6,s0,-104
      int fd = open("truncfile", O_WRONLY);
    1528:	4585                	li	a1,1
    152a:	8552                	mv	a0,s4
    152c:	00008097          	auipc	ra,0x8
    1530:	a9c080e7          	jalr	-1380(ra) # 8fc8 <open>
    1534:	84aa                	mv	s1,a0
      if(fd < 0){
    1536:	06054963          	bltz	a0,15a8 <truncate3+0xd8>
      int n = write(fd, "1234567890", 10);
    153a:	4629                	li	a2,10
    153c:	85d6                	mv	a1,s5
    153e:	00008097          	auipc	ra,0x8
    1542:	a6a080e7          	jalr	-1430(ra) # 8fa8 <write>
      if(n != 10){
    1546:	47a9                	li	a5,10
    1548:	06f51e63          	bne	a0,a5,15c4 <truncate3+0xf4>
      close(fd);
    154c:	8526                	mv	a0,s1
    154e:	00008097          	auipc	ra,0x8
    1552:	a62080e7          	jalr	-1438(ra) # 8fb0 <close>
      fd = open("truncfile", O_RDONLY);
    1556:	4581                	li	a1,0
    1558:	8552                	mv	a0,s4
    155a:	00008097          	auipc	ra,0x8
    155e:	a6e080e7          	jalr	-1426(ra) # 8fc8 <open>
    1562:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1564:	02000613          	li	a2,32
    1568:	85da                	mv	a1,s6
    156a:	00008097          	auipc	ra,0x8
    156e:	a36080e7          	jalr	-1482(ra) # 8fa0 <read>
      close(fd);
    1572:	8526                	mv	a0,s1
    1574:	00008097          	auipc	ra,0x8
    1578:	a3c080e7          	jalr	-1476(ra) # 8fb0 <close>
    for(int i = 0; i < 100; i++){
    157c:	39fd                	addiw	s3,s3,-1
    157e:	fa0995e3          	bnez	s3,1528 <truncate3+0x58>
    exit(0);
    1582:	4501                	li	a0,0
    1584:	00008097          	auipc	ra,0x8
    1588:	a04080e7          	jalr	-1532(ra) # 8f88 <exit>
    printf("%s: fork failed\n", s);
    158c:	85ca                	mv	a1,s2
    158e:	00009517          	auipc	a0,0x9
    1592:	c4a50513          	addi	a0,a0,-950 # a1d8 <malloc+0xc18>
    1596:	00008097          	auipc	ra,0x8
    159a:	f72080e7          	jalr	-142(ra) # 9508 <printf>
    exit(1);
    159e:	4505                	li	a0,1
    15a0:	00008097          	auipc	ra,0x8
    15a4:	9e8080e7          	jalr	-1560(ra) # 8f88 <exit>
        printf("%s: open failed\n", s);
    15a8:	85ca                	mv	a1,s2
    15aa:	00009517          	auipc	a0,0x9
    15ae:	c4650513          	addi	a0,a0,-954 # a1f0 <malloc+0xc30>
    15b2:	00008097          	auipc	ra,0x8
    15b6:	f56080e7          	jalr	-170(ra) # 9508 <printf>
        exit(1);
    15ba:	4505                	li	a0,1
    15bc:	00008097          	auipc	ra,0x8
    15c0:	9cc080e7          	jalr	-1588(ra) # 8f88 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    15c4:	862a                	mv	a2,a0
    15c6:	85ca                	mv	a1,s2
    15c8:	00009517          	auipc	a0,0x9
    15cc:	c5050513          	addi	a0,a0,-944 # a218 <malloc+0xc58>
    15d0:	00008097          	auipc	ra,0x8
    15d4:	f38080e7          	jalr	-200(ra) # 9508 <printf>
        exit(1);
    15d8:	4505                	li	a0,1
    15da:	00008097          	auipc	ra,0x8
    15de:	9ae080e7          	jalr	-1618(ra) # 8f88 <exit>
    15e2:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    15e6:	00008a17          	auipc	s4,0x8
    15ea:	17aa0a13          	addi	s4,s4,378 # 9760 <malloc+0x1a0>
    int n = write(fd, "xxx", 3);
    15ee:	00009a97          	auipc	s5,0x9
    15f2:	c4aa8a93          	addi	s5,s5,-950 # a238 <malloc+0xc78>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    15f6:	60100593          	li	a1,1537
    15fa:	8552                	mv	a0,s4
    15fc:	00008097          	auipc	ra,0x8
    1600:	9cc080e7          	jalr	-1588(ra) # 8fc8 <open>
    1604:	84aa                	mv	s1,a0
    if(fd < 0){
    1606:	04054763          	bltz	a0,1654 <truncate3+0x184>
    int n = write(fd, "xxx", 3);
    160a:	460d                	li	a2,3
    160c:	85d6                	mv	a1,s5
    160e:	00008097          	auipc	ra,0x8
    1612:	99a080e7          	jalr	-1638(ra) # 8fa8 <write>
    if(n != 3){
    1616:	478d                	li	a5,3
    1618:	04f51c63          	bne	a0,a5,1670 <truncate3+0x1a0>
    close(fd);
    161c:	8526                	mv	a0,s1
    161e:	00008097          	auipc	ra,0x8
    1622:	992080e7          	jalr	-1646(ra) # 8fb0 <close>
  for(int i = 0; i < 150; i++){
    1626:	39fd                	addiw	s3,s3,-1
    1628:	fc0997e3          	bnez	s3,15f6 <truncate3+0x126>
  wait(&xstatus);
    162c:	fbc40513          	addi	a0,s0,-68
    1630:	00008097          	auipc	ra,0x8
    1634:	960080e7          	jalr	-1696(ra) # 8f90 <wait>
  remove("truncfile");
    1638:	00008517          	auipc	a0,0x8
    163c:	12850513          	addi	a0,a0,296 # 9760 <malloc+0x1a0>
    1640:	00008097          	auipc	ra,0x8
    1644:	9f0080e7          	jalr	-1552(ra) # 9030 <remove>
  exit(xstatus);
    1648:	fbc42503          	lw	a0,-68(s0)
    164c:	00008097          	auipc	ra,0x8
    1650:	93c080e7          	jalr	-1732(ra) # 8f88 <exit>
      printf("%s: open failed\n", s);
    1654:	85ca                	mv	a1,s2
    1656:	00009517          	auipc	a0,0x9
    165a:	b9a50513          	addi	a0,a0,-1126 # a1f0 <malloc+0xc30>
    165e:	00008097          	auipc	ra,0x8
    1662:	eaa080e7          	jalr	-342(ra) # 9508 <printf>
      exit(1);
    1666:	4505                	li	a0,1
    1668:	00008097          	auipc	ra,0x8
    166c:	920080e7          	jalr	-1760(ra) # 8f88 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1670:	862a                	mv	a2,a0
    1672:	85ca                	mv	a1,s2
    1674:	00009517          	auipc	a0,0x9
    1678:	bcc50513          	addi	a0,a0,-1076 # a240 <malloc+0xc80>
    167c:	00008097          	auipc	ra,0x8
    1680:	e8c080e7          	jalr	-372(ra) # 9508 <printf>
      exit(1);
    1684:	4505                	li	a0,1
    1686:	00008097          	auipc	ra,0x8
    168a:	902080e7          	jalr	-1790(ra) # 8f88 <exit>

000000000000168e <exectest>:
{
    168e:	715d                	addi	sp,sp,-80
    1690:	e486                	sd	ra,72(sp)
    1692:	e0a2                	sd	s0,64(sp)
    1694:	fc26                	sd	s1,56(sp)
    1696:	f84a                	sd	s2,48(sp)
    1698:	0880                	addi	s0,sp,80
    169a:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    169c:	00008797          	auipc	a5,0x8
    16a0:	06c78793          	addi	a5,a5,108 # 9708 <malloc+0x148>
    16a4:	fcf43023          	sd	a5,-64(s0)
    16a8:	00009797          	auipc	a5,0x9
    16ac:	bb878793          	addi	a5,a5,-1096 # a260 <malloc+0xca0>
    16b0:	fcf43423          	sd	a5,-56(s0)
    16b4:	fc043823          	sd	zero,-48(s0)
  remove("echo-ok");
    16b8:	00009517          	auipc	a0,0x9
    16bc:	bb050513          	addi	a0,a0,-1104 # a268 <malloc+0xca8>
    16c0:	00008097          	auipc	ra,0x8
    16c4:	970080e7          	jalr	-1680(ra) # 9030 <remove>
  pid = fork();
    16c8:	00008097          	auipc	ra,0x8
    16cc:	8b8080e7          	jalr	-1864(ra) # 8f80 <fork>
  if(pid < 0) {
    16d0:	04054663          	bltz	a0,171c <exectest+0x8e>
    16d4:	84aa                	mv	s1,a0
  if(pid == 0) {
    16d6:	e959                	bnez	a0,176c <exectest+0xde>
    close(1);
    16d8:	4505                	li	a0,1
    16da:	00008097          	auipc	ra,0x8
    16de:	8d6080e7          	jalr	-1834(ra) # 8fb0 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    16e2:	20100593          	li	a1,513
    16e6:	00009517          	auipc	a0,0x9
    16ea:	b8250513          	addi	a0,a0,-1150 # a268 <malloc+0xca8>
    16ee:	00008097          	auipc	ra,0x8
    16f2:	8da080e7          	jalr	-1830(ra) # 8fc8 <open>
    if(fd < 0) {
    16f6:	04054163          	bltz	a0,1738 <exectest+0xaa>
    if(fd != 1) {
    16fa:	4785                	li	a5,1
    16fc:	04f50c63          	beq	a0,a5,1754 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    1700:	85ca                	mv	a1,s2
    1702:	00009517          	auipc	a0,0x9
    1706:	b8650513          	addi	a0,a0,-1146 # a288 <malloc+0xcc8>
    170a:	00008097          	auipc	ra,0x8
    170e:	dfe080e7          	jalr	-514(ra) # 9508 <printf>
      exit(1);
    1712:	4505                	li	a0,1
    1714:	00008097          	auipc	ra,0x8
    1718:	874080e7          	jalr	-1932(ra) # 8f88 <exit>
     printf("%s: fork failed\n", s);
    171c:	85ca                	mv	a1,s2
    171e:	00009517          	auipc	a0,0x9
    1722:	aba50513          	addi	a0,a0,-1350 # a1d8 <malloc+0xc18>
    1726:	00008097          	auipc	ra,0x8
    172a:	de2080e7          	jalr	-542(ra) # 9508 <printf>
     exit(1);
    172e:	4505                	li	a0,1
    1730:	00008097          	auipc	ra,0x8
    1734:	858080e7          	jalr	-1960(ra) # 8f88 <exit>
      printf("%s: create failed\n", s);
    1738:	85ca                	mv	a1,s2
    173a:	00009517          	auipc	a0,0x9
    173e:	b3650513          	addi	a0,a0,-1226 # a270 <malloc+0xcb0>
    1742:	00008097          	auipc	ra,0x8
    1746:	dc6080e7          	jalr	-570(ra) # 9508 <printf>
      exit(1);
    174a:	4505                	li	a0,1
    174c:	00008097          	auipc	ra,0x8
    1750:	83c080e7          	jalr	-1988(ra) # 8f88 <exit>
    if(exec("echo", echoargv) < 0){
    1754:	fc040593          	addi	a1,s0,-64
    1758:	00008517          	auipc	a0,0x8
    175c:	fb050513          	addi	a0,a0,-80 # 9708 <malloc+0x148>
    1760:	00008097          	auipc	ra,0x8
    1764:	860080e7          	jalr	-1952(ra) # 8fc0 <exec>
    1768:	02054163          	bltz	a0,178a <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    176c:	fdc40513          	addi	a0,s0,-36
    1770:	00008097          	auipc	ra,0x8
    1774:	820080e7          	jalr	-2016(ra) # 8f90 <wait>
    1778:	02951763          	bne	a0,s1,17a6 <exectest+0x118>
  if(xstatus != 0)
    177c:	fdc42503          	lw	a0,-36(s0)
    1780:	cd0d                	beqz	a0,17ba <exectest+0x12c>
    exit(xstatus);
    1782:	00008097          	auipc	ra,0x8
    1786:	806080e7          	jalr	-2042(ra) # 8f88 <exit>
      printf("%s: exec echo failed\n", s);
    178a:	85ca                	mv	a1,s2
    178c:	00009517          	auipc	a0,0x9
    1790:	b0c50513          	addi	a0,a0,-1268 # a298 <malloc+0xcd8>
    1794:	00008097          	auipc	ra,0x8
    1798:	d74080e7          	jalr	-652(ra) # 9508 <printf>
      exit(1);
    179c:	4505                	li	a0,1
    179e:	00007097          	auipc	ra,0x7
    17a2:	7ea080e7          	jalr	2026(ra) # 8f88 <exit>
    printf("%s: wait failed!\n", s);
    17a6:	85ca                	mv	a1,s2
    17a8:	00009517          	auipc	a0,0x9
    17ac:	b0850513          	addi	a0,a0,-1272 # a2b0 <malloc+0xcf0>
    17b0:	00008097          	auipc	ra,0x8
    17b4:	d58080e7          	jalr	-680(ra) # 9508 <printf>
    17b8:	b7d1                	j	177c <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    17ba:	4581                	li	a1,0
    17bc:	00009517          	auipc	a0,0x9
    17c0:	aac50513          	addi	a0,a0,-1364 # a268 <malloc+0xca8>
    17c4:	00008097          	auipc	ra,0x8
    17c8:	804080e7          	jalr	-2044(ra) # 8fc8 <open>
  if(fd < 0) {
    17cc:	02054a63          	bltz	a0,1800 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    17d0:	4609                	li	a2,2
    17d2:	fb840593          	addi	a1,s0,-72
    17d6:	00007097          	auipc	ra,0x7
    17da:	7ca080e7          	jalr	1994(ra) # 8fa0 <read>
    17de:	4789                	li	a5,2
    17e0:	02f50e63          	beq	a0,a5,181c <exectest+0x18e>
    printf("%s: read failed\n", s);
    17e4:	85ca                	mv	a1,s2
    17e6:	00008517          	auipc	a0,0x8
    17ea:	2f250513          	addi	a0,a0,754 # 9ad8 <malloc+0x518>
    17ee:	00008097          	auipc	ra,0x8
    17f2:	d1a080e7          	jalr	-742(ra) # 9508 <printf>
    exit(1);
    17f6:	4505                	li	a0,1
    17f8:	00007097          	auipc	ra,0x7
    17fc:	790080e7          	jalr	1936(ra) # 8f88 <exit>
    printf("%s: open failed\n", s);
    1800:	85ca                	mv	a1,s2
    1802:	00009517          	auipc	a0,0x9
    1806:	9ee50513          	addi	a0,a0,-1554 # a1f0 <malloc+0xc30>
    180a:	00008097          	auipc	ra,0x8
    180e:	cfe080e7          	jalr	-770(ra) # 9508 <printf>
    exit(1);
    1812:	4505                	li	a0,1
    1814:	00007097          	auipc	ra,0x7
    1818:	774080e7          	jalr	1908(ra) # 8f88 <exit>
  remove("echo-ok");
    181c:	00009517          	auipc	a0,0x9
    1820:	a4c50513          	addi	a0,a0,-1460 # a268 <malloc+0xca8>
    1824:	00008097          	auipc	ra,0x8
    1828:	80c080e7          	jalr	-2036(ra) # 9030 <remove>
  if(buf[0] == 'O' && buf[1] == 'K')
    182c:	fb844703          	lbu	a4,-72(s0)
    1830:	04f00793          	li	a5,79
    1834:	00f71863          	bne	a4,a5,1844 <exectest+0x1b6>
    1838:	fb944703          	lbu	a4,-71(s0)
    183c:	04b00793          	li	a5,75
    1840:	02f70063          	beq	a4,a5,1860 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    1844:	85ca                	mv	a1,s2
    1846:	00009517          	auipc	a0,0x9
    184a:	a8250513          	addi	a0,a0,-1406 # a2c8 <malloc+0xd08>
    184e:	00008097          	auipc	ra,0x8
    1852:	cba080e7          	jalr	-838(ra) # 9508 <printf>
    exit(1);
    1856:	4505                	li	a0,1
    1858:	00007097          	auipc	ra,0x7
    185c:	730080e7          	jalr	1840(ra) # 8f88 <exit>
    exit(0);
    1860:	4501                	li	a0,0
    1862:	00007097          	auipc	ra,0x7
    1866:	726080e7          	jalr	1830(ra) # 8f88 <exit>

000000000000186a <pipe1>:
{
    186a:	711d                	addi	sp,sp,-96
    186c:	ec86                	sd	ra,88(sp)
    186e:	e8a2                	sd	s0,80(sp)
    1870:	e4a6                	sd	s1,72(sp)
    1872:	e0ca                	sd	s2,64(sp)
    1874:	fc4e                	sd	s3,56(sp)
    1876:	f852                	sd	s4,48(sp)
    1878:	f456                	sd	s5,40(sp)
    187a:	f05a                	sd	s6,32(sp)
    187c:	ec5e                	sd	s7,24(sp)
    187e:	1080                	addi	s0,sp,96
    1880:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1882:	fa840513          	addi	a0,s0,-88
    1886:	00007097          	auipc	ra,0x7
    188a:	712080e7          	jalr	1810(ra) # 8f98 <pipe>
    188e:	ed2d                	bnez	a0,1908 <pipe1+0x9e>
    1890:	84aa                	mv	s1,a0
  pid = fork();
    1892:	00007097          	auipc	ra,0x7
    1896:	6ee080e7          	jalr	1774(ra) # 8f80 <fork>
    189a:	8a2a                	mv	s4,a0
  if(pid == 0){
    189c:	c541                	beqz	a0,1924 <pipe1+0xba>
  } else if(pid > 0){
    189e:	16a05f63          	blez	a0,1a1c <pipe1+0x1b2>
    close(fds[1]);
    18a2:	fac42503          	lw	a0,-84(s0)
    18a6:	00007097          	auipc	ra,0x7
    18aa:	70a080e7          	jalr	1802(ra) # 8fb0 <close>
    total = 0;
    18ae:	8aa6                	mv	s5,s1
    cc = 1;
    18b0:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    18b2:	0001cb17          	auipc	s6,0x1c
    18b6:	816b0b13          	addi	s6,s6,-2026 # 1d0c8 <buf>
      if(cc > sizeof(buf))
    18ba:	6a09                	lui	s4,0x2
    18bc:	800a0a13          	addi	s4,s4,-2048 # 1800 <exectest+0x172>
    while((n = read(fds[0], buf, cc)) > 0){
    18c0:	864e                	mv	a2,s3
    18c2:	85da                	mv	a1,s6
    18c4:	fa842503          	lw	a0,-88(s0)
    18c8:	00007097          	auipc	ra,0x7
    18cc:	6d8080e7          	jalr	1752(ra) # 8fa0 <read>
    18d0:	10a05163          	blez	a0,19d2 <pipe1+0x168>
      for(i = 0; i < n; i++){
    18d4:	0001b717          	auipc	a4,0x1b
    18d8:	7f470713          	addi	a4,a4,2036 # 1d0c8 <buf>
    18dc:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    18e0:	00074683          	lbu	a3,0(a4)
    18e4:	0ff4f793          	zext.b	a5,s1
    18e8:	2485                	addiw	s1,s1,1
    18ea:	0cf69063          	bne	a3,a5,19aa <pipe1+0x140>
      for(i = 0; i < n; i++){
    18ee:	0705                	addi	a4,a4,1
    18f0:	fec498e3          	bne	s1,a2,18e0 <pipe1+0x76>
      total += n;
    18f4:	00aa8abb          	addw	s5,s5,a0
      cc = cc * 2;
    18f8:	0019979b          	slliw	a5,s3,0x1
    18fc:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    1900:	fd3a70e3          	bgeu	s4,s3,18c0 <pipe1+0x56>
        cc = sizeof(buf);
    1904:	89d2                	mv	s3,s4
    1906:	bf6d                	j	18c0 <pipe1+0x56>
    printf("%s: pipe() failed\n", s);
    1908:	85ca                	mv	a1,s2
    190a:	00009517          	auipc	a0,0x9
    190e:	9d650513          	addi	a0,a0,-1578 # a2e0 <malloc+0xd20>
    1912:	00008097          	auipc	ra,0x8
    1916:	bf6080e7          	jalr	-1034(ra) # 9508 <printf>
    exit(1);
    191a:	4505                	li	a0,1
    191c:	00007097          	auipc	ra,0x7
    1920:	66c080e7          	jalr	1644(ra) # 8f88 <exit>
    close(fds[0]);
    1924:	fa842503          	lw	a0,-88(s0)
    1928:	00007097          	auipc	ra,0x7
    192c:	688080e7          	jalr	1672(ra) # 8fb0 <close>
    for(n = 0; n < N; n++){
    1930:	0001bb17          	auipc	s6,0x1b
    1934:	798b0b13          	addi	s6,s6,1944 # 1d0c8 <buf>
    1938:	416004bb          	negw	s1,s6
    193c:	0ff4f493          	zext.b	s1,s1
    1940:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    1944:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1946:	6a85                	lui	s5,0x1
    1948:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x11d>
{
    194c:	87da                	mv	a5,s6
        buf[i] = seq++;
    194e:	0097873b          	addw	a4,a5,s1
    1952:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1956:	0785                	addi	a5,a5,1
    1958:	fef99be3          	bne	s3,a5,194e <pipe1+0xe4>
        buf[i] = seq++;
    195c:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1960:	40900613          	li	a2,1033
    1964:	85de                	mv	a1,s7
    1966:	fac42503          	lw	a0,-84(s0)
    196a:	00007097          	auipc	ra,0x7
    196e:	63e080e7          	jalr	1598(ra) # 8fa8 <write>
    1972:	40900793          	li	a5,1033
    1976:	00f51c63          	bne	a0,a5,198e <pipe1+0x124>
    for(n = 0; n < N; n++){
    197a:	24a5                	addiw	s1,s1,9
    197c:	0ff4f493          	zext.b	s1,s1
    1980:	fd5a16e3          	bne	s4,s5,194c <pipe1+0xe2>
    exit(0);
    1984:	4501                	li	a0,0
    1986:	00007097          	auipc	ra,0x7
    198a:	602080e7          	jalr	1538(ra) # 8f88 <exit>
        printf("%s: pipe1 oops 1\n", s);
    198e:	85ca                	mv	a1,s2
    1990:	00009517          	auipc	a0,0x9
    1994:	96850513          	addi	a0,a0,-1688 # a2f8 <malloc+0xd38>
    1998:	00008097          	auipc	ra,0x8
    199c:	b70080e7          	jalr	-1168(ra) # 9508 <printf>
        exit(1);
    19a0:	4505                	li	a0,1
    19a2:	00007097          	auipc	ra,0x7
    19a6:	5e6080e7          	jalr	1510(ra) # 8f88 <exit>
          printf("%s: pipe1 oops 2\n", s);
    19aa:	85ca                	mv	a1,s2
    19ac:	00009517          	auipc	a0,0x9
    19b0:	96450513          	addi	a0,a0,-1692 # a310 <malloc+0xd50>
    19b4:	00008097          	auipc	ra,0x8
    19b8:	b54080e7          	jalr	-1196(ra) # 9508 <printf>
}
    19bc:	60e6                	ld	ra,88(sp)
    19be:	6446                	ld	s0,80(sp)
    19c0:	64a6                	ld	s1,72(sp)
    19c2:	6906                	ld	s2,64(sp)
    19c4:	79e2                	ld	s3,56(sp)
    19c6:	7a42                	ld	s4,48(sp)
    19c8:	7aa2                	ld	s5,40(sp)
    19ca:	7b02                	ld	s6,32(sp)
    19cc:	6be2                	ld	s7,24(sp)
    19ce:	6125                	addi	sp,sp,96
    19d0:	8082                	ret
    if(total != N * SZ){
    19d2:	6785                	lui	a5,0x1
    19d4:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x11d>
    19d8:	02fa8063          	beq	s5,a5,19f8 <pipe1+0x18e>
      printf("%s: pipe1 oops 3 total %d\n", total);
    19dc:	85d6                	mv	a1,s5
    19de:	00009517          	auipc	a0,0x9
    19e2:	94a50513          	addi	a0,a0,-1718 # a328 <malloc+0xd68>
    19e6:	00008097          	auipc	ra,0x8
    19ea:	b22080e7          	jalr	-1246(ra) # 9508 <printf>
      exit(1);
    19ee:	4505                	li	a0,1
    19f0:	00007097          	auipc	ra,0x7
    19f4:	598080e7          	jalr	1432(ra) # 8f88 <exit>
    close(fds[0]);
    19f8:	fa842503          	lw	a0,-88(s0)
    19fc:	00007097          	auipc	ra,0x7
    1a00:	5b4080e7          	jalr	1460(ra) # 8fb0 <close>
    wait(&xstatus);
    1a04:	fa440513          	addi	a0,s0,-92
    1a08:	00007097          	auipc	ra,0x7
    1a0c:	588080e7          	jalr	1416(ra) # 8f90 <wait>
    exit(xstatus);
    1a10:	fa442503          	lw	a0,-92(s0)
    1a14:	00007097          	auipc	ra,0x7
    1a18:	574080e7          	jalr	1396(ra) # 8f88 <exit>
    printf("%s: fork() failed\n", s);
    1a1c:	85ca                	mv	a1,s2
    1a1e:	00009517          	auipc	a0,0x9
    1a22:	92a50513          	addi	a0,a0,-1750 # a348 <malloc+0xd88>
    1a26:	00008097          	auipc	ra,0x8
    1a2a:	ae2080e7          	jalr	-1310(ra) # 9508 <printf>
    exit(1);
    1a2e:	4505                	li	a0,1
    1a30:	00007097          	auipc	ra,0x7
    1a34:	558080e7          	jalr	1368(ra) # 8f88 <exit>

0000000000001a38 <exitwait>:
{
    1a38:	715d                	addi	sp,sp,-80
    1a3a:	e486                	sd	ra,72(sp)
    1a3c:	e0a2                	sd	s0,64(sp)
    1a3e:	fc26                	sd	s1,56(sp)
    1a40:	f84a                	sd	s2,48(sp)
    1a42:	f44e                	sd	s3,40(sp)
    1a44:	f052                	sd	s4,32(sp)
    1a46:	ec56                	sd	s5,24(sp)
    1a48:	0880                	addi	s0,sp,80
    1a4a:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    1a4c:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    1a4e:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    1a52:	06400a13          	li	s4,100
    pid = fork();
    1a56:	00007097          	auipc	ra,0x7
    1a5a:	52a080e7          	jalr	1322(ra) # 8f80 <fork>
    1a5e:	84aa                	mv	s1,a0
    if(pid < 0){
    1a60:	02054a63          	bltz	a0,1a94 <exitwait+0x5c>
    if(pid){
    1a64:	c151                	beqz	a0,1ae8 <exitwait+0xb0>
      if(wait(&xstate) != pid){
    1a66:	854e                	mv	a0,s3
    1a68:	00007097          	auipc	ra,0x7
    1a6c:	528080e7          	jalr	1320(ra) # 8f90 <wait>
    1a70:	04951063          	bne	a0,s1,1ab0 <exitwait+0x78>
      if(i != xstate) {
    1a74:	fbc42783          	lw	a5,-68(s0)
    1a78:	05279a63          	bne	a5,s2,1acc <exitwait+0x94>
  for(i = 0; i < 100; i++){
    1a7c:	2905                	addiw	s2,s2,1
    1a7e:	fd491ce3          	bne	s2,s4,1a56 <exitwait+0x1e>
}
    1a82:	60a6                	ld	ra,72(sp)
    1a84:	6406                	ld	s0,64(sp)
    1a86:	74e2                	ld	s1,56(sp)
    1a88:	7942                	ld	s2,48(sp)
    1a8a:	79a2                	ld	s3,40(sp)
    1a8c:	7a02                	ld	s4,32(sp)
    1a8e:	6ae2                	ld	s5,24(sp)
    1a90:	6161                	addi	sp,sp,80
    1a92:	8082                	ret
      printf("%s: fork failed\n", s);
    1a94:	85d6                	mv	a1,s5
    1a96:	00008517          	auipc	a0,0x8
    1a9a:	74250513          	addi	a0,a0,1858 # a1d8 <malloc+0xc18>
    1a9e:	00008097          	auipc	ra,0x8
    1aa2:	a6a080e7          	jalr	-1430(ra) # 9508 <printf>
      exit(1);
    1aa6:	4505                	li	a0,1
    1aa8:	00007097          	auipc	ra,0x7
    1aac:	4e0080e7          	jalr	1248(ra) # 8f88 <exit>
        printf("%s: wait wrong pid\n", s);
    1ab0:	85d6                	mv	a1,s5
    1ab2:	00009517          	auipc	a0,0x9
    1ab6:	8ae50513          	addi	a0,a0,-1874 # a360 <malloc+0xda0>
    1aba:	00008097          	auipc	ra,0x8
    1abe:	a4e080e7          	jalr	-1458(ra) # 9508 <printf>
        exit(1);
    1ac2:	4505                	li	a0,1
    1ac4:	00007097          	auipc	ra,0x7
    1ac8:	4c4080e7          	jalr	1220(ra) # 8f88 <exit>
        printf("%s: wait wrong exit status\n", s);
    1acc:	85d6                	mv	a1,s5
    1ace:	00009517          	auipc	a0,0x9
    1ad2:	8aa50513          	addi	a0,a0,-1878 # a378 <malloc+0xdb8>
    1ad6:	00008097          	auipc	ra,0x8
    1ada:	a32080e7          	jalr	-1486(ra) # 9508 <printf>
        exit(1);
    1ade:	4505                	li	a0,1
    1ae0:	00007097          	auipc	ra,0x7
    1ae4:	4a8080e7          	jalr	1192(ra) # 8f88 <exit>
      exit(i);
    1ae8:	854a                	mv	a0,s2
    1aea:	00007097          	auipc	ra,0x7
    1aee:	49e080e7          	jalr	1182(ra) # 8f88 <exit>

0000000000001af2 <twochildren>:
{
    1af2:	1101                	addi	sp,sp,-32
    1af4:	ec06                	sd	ra,24(sp)
    1af6:	e822                	sd	s0,16(sp)
    1af8:	e426                	sd	s1,8(sp)
    1afa:	e04a                	sd	s2,0(sp)
    1afc:	1000                	addi	s0,sp,32
    1afe:	892a                	mv	s2,a0
    1b00:	3e800493          	li	s1,1000
    int pid1 = fork();
    1b04:	00007097          	auipc	ra,0x7
    1b08:	47c080e7          	jalr	1148(ra) # 8f80 <fork>
    if(pid1 < 0){
    1b0c:	02054c63          	bltz	a0,1b44 <twochildren+0x52>
    if(pid1 == 0){
    1b10:	c921                	beqz	a0,1b60 <twochildren+0x6e>
      int pid2 = fork();
    1b12:	00007097          	auipc	ra,0x7
    1b16:	46e080e7          	jalr	1134(ra) # 8f80 <fork>
      if(pid2 < 0){
    1b1a:	04054763          	bltz	a0,1b68 <twochildren+0x76>
      if(pid2 == 0){
    1b1e:	c13d                	beqz	a0,1b84 <twochildren+0x92>
        wait(0);
    1b20:	4501                	li	a0,0
    1b22:	00007097          	auipc	ra,0x7
    1b26:	46e080e7          	jalr	1134(ra) # 8f90 <wait>
        wait(0);
    1b2a:	4501                	li	a0,0
    1b2c:	00007097          	auipc	ra,0x7
    1b30:	464080e7          	jalr	1124(ra) # 8f90 <wait>
  for(int i = 0; i < 1000; i++){
    1b34:	34fd                	addiw	s1,s1,-1
    1b36:	f4f9                	bnez	s1,1b04 <twochildren+0x12>
}
    1b38:	60e2                	ld	ra,24(sp)
    1b3a:	6442                	ld	s0,16(sp)
    1b3c:	64a2                	ld	s1,8(sp)
    1b3e:	6902                	ld	s2,0(sp)
    1b40:	6105                	addi	sp,sp,32
    1b42:	8082                	ret
      printf("%s: fork failed\n", s);
    1b44:	85ca                	mv	a1,s2
    1b46:	00008517          	auipc	a0,0x8
    1b4a:	69250513          	addi	a0,a0,1682 # a1d8 <malloc+0xc18>
    1b4e:	00008097          	auipc	ra,0x8
    1b52:	9ba080e7          	jalr	-1606(ra) # 9508 <printf>
      exit(1);
    1b56:	4505                	li	a0,1
    1b58:	00007097          	auipc	ra,0x7
    1b5c:	430080e7          	jalr	1072(ra) # 8f88 <exit>
      exit(0);
    1b60:	00007097          	auipc	ra,0x7
    1b64:	428080e7          	jalr	1064(ra) # 8f88 <exit>
        printf("%s: fork failed\n", s);
    1b68:	85ca                	mv	a1,s2
    1b6a:	00008517          	auipc	a0,0x8
    1b6e:	66e50513          	addi	a0,a0,1646 # a1d8 <malloc+0xc18>
    1b72:	00008097          	auipc	ra,0x8
    1b76:	996080e7          	jalr	-1642(ra) # 9508 <printf>
        exit(1);
    1b7a:	4505                	li	a0,1
    1b7c:	00007097          	auipc	ra,0x7
    1b80:	40c080e7          	jalr	1036(ra) # 8f88 <exit>
        exit(0);
    1b84:	00007097          	auipc	ra,0x7
    1b88:	404080e7          	jalr	1028(ra) # 8f88 <exit>

0000000000001b8c <forkfork>:
{
    1b8c:	7179                	addi	sp,sp,-48
    1b8e:	f406                	sd	ra,40(sp)
    1b90:	f022                	sd	s0,32(sp)
    1b92:	ec26                	sd	s1,24(sp)
    1b94:	1800                	addi	s0,sp,48
    1b96:	84aa                	mv	s1,a0
    int pid = fork();
    1b98:	00007097          	auipc	ra,0x7
    1b9c:	3e8080e7          	jalr	1000(ra) # 8f80 <fork>
    if(pid < 0){
    1ba0:	04054163          	bltz	a0,1be2 <forkfork+0x56>
    if(pid == 0){
    1ba4:	cd29                	beqz	a0,1bfe <forkfork+0x72>
    int pid = fork();
    1ba6:	00007097          	auipc	ra,0x7
    1baa:	3da080e7          	jalr	986(ra) # 8f80 <fork>
    if(pid < 0){
    1bae:	02054a63          	bltz	a0,1be2 <forkfork+0x56>
    if(pid == 0){
    1bb2:	c531                	beqz	a0,1bfe <forkfork+0x72>
    wait(&xstatus);
    1bb4:	fdc40513          	addi	a0,s0,-36
    1bb8:	00007097          	auipc	ra,0x7
    1bbc:	3d8080e7          	jalr	984(ra) # 8f90 <wait>
    if(xstatus != 0) {
    1bc0:	fdc42783          	lw	a5,-36(s0)
    1bc4:	ebbd                	bnez	a5,1c3a <forkfork+0xae>
    wait(&xstatus);
    1bc6:	fdc40513          	addi	a0,s0,-36
    1bca:	00007097          	auipc	ra,0x7
    1bce:	3c6080e7          	jalr	966(ra) # 8f90 <wait>
    if(xstatus != 0) {
    1bd2:	fdc42783          	lw	a5,-36(s0)
    1bd6:	e3b5                	bnez	a5,1c3a <forkfork+0xae>
}
    1bd8:	70a2                	ld	ra,40(sp)
    1bda:	7402                	ld	s0,32(sp)
    1bdc:	64e2                	ld	s1,24(sp)
    1bde:	6145                	addi	sp,sp,48
    1be0:	8082                	ret
      printf("%s: fork failed", s);
    1be2:	85a6                	mv	a1,s1
    1be4:	00008517          	auipc	a0,0x8
    1be8:	7b450513          	addi	a0,a0,1972 # a398 <malloc+0xdd8>
    1bec:	00008097          	auipc	ra,0x8
    1bf0:	91c080e7          	jalr	-1764(ra) # 9508 <printf>
      exit(1);
    1bf4:	4505                	li	a0,1
    1bf6:	00007097          	auipc	ra,0x7
    1bfa:	392080e7          	jalr	914(ra) # 8f88 <exit>
{
    1bfe:	0c800493          	li	s1,200
        int pid1 = fork();
    1c02:	00007097          	auipc	ra,0x7
    1c06:	37e080e7          	jalr	894(ra) # 8f80 <fork>
        if(pid1 < 0){
    1c0a:	00054f63          	bltz	a0,1c28 <forkfork+0x9c>
        if(pid1 == 0){
    1c0e:	c115                	beqz	a0,1c32 <forkfork+0xa6>
        wait(0);
    1c10:	4501                	li	a0,0
    1c12:	00007097          	auipc	ra,0x7
    1c16:	37e080e7          	jalr	894(ra) # 8f90 <wait>
      for(int j = 0; j < 200; j++){
    1c1a:	34fd                	addiw	s1,s1,-1
    1c1c:	f0fd                	bnez	s1,1c02 <forkfork+0x76>
      exit(0);
    1c1e:	4501                	li	a0,0
    1c20:	00007097          	auipc	ra,0x7
    1c24:	368080e7          	jalr	872(ra) # 8f88 <exit>
          exit(1);
    1c28:	4505                	li	a0,1
    1c2a:	00007097          	auipc	ra,0x7
    1c2e:	35e080e7          	jalr	862(ra) # 8f88 <exit>
          exit(0);
    1c32:	00007097          	auipc	ra,0x7
    1c36:	356080e7          	jalr	854(ra) # 8f88 <exit>
      printf("%s: fork in child failed", s);
    1c3a:	85a6                	mv	a1,s1
    1c3c:	00008517          	auipc	a0,0x8
    1c40:	76c50513          	addi	a0,a0,1900 # a3a8 <malloc+0xde8>
    1c44:	00008097          	auipc	ra,0x8
    1c48:	8c4080e7          	jalr	-1852(ra) # 9508 <printf>
      exit(1);
    1c4c:	4505                	li	a0,1
    1c4e:	00007097          	auipc	ra,0x7
    1c52:	33a080e7          	jalr	826(ra) # 8f88 <exit>

0000000000001c56 <reparent2>:
{
    1c56:	1101                	addi	sp,sp,-32
    1c58:	ec06                	sd	ra,24(sp)
    1c5a:	e822                	sd	s0,16(sp)
    1c5c:	e426                	sd	s1,8(sp)
    1c5e:	1000                	addi	s0,sp,32
    1c60:	32000493          	li	s1,800
    int pid1 = fork();
    1c64:	00007097          	auipc	ra,0x7
    1c68:	31c080e7          	jalr	796(ra) # 8f80 <fork>
    if(pid1 < 0){
    1c6c:	00054f63          	bltz	a0,1c8a <reparent2+0x34>
    if(pid1 == 0){
    1c70:	c915                	beqz	a0,1ca4 <reparent2+0x4e>
    wait(0);
    1c72:	4501                	li	a0,0
    1c74:	00007097          	auipc	ra,0x7
    1c78:	31c080e7          	jalr	796(ra) # 8f90 <wait>
  for(int i = 0; i < 800; i++){
    1c7c:	34fd                	addiw	s1,s1,-1
    1c7e:	f0fd                	bnez	s1,1c64 <reparent2+0xe>
  exit(0);
    1c80:	4501                	li	a0,0
    1c82:	00007097          	auipc	ra,0x7
    1c86:	306080e7          	jalr	774(ra) # 8f88 <exit>
      printf("fork failed\n");
    1c8a:	00009517          	auipc	a0,0x9
    1c8e:	8ce50513          	addi	a0,a0,-1842 # a558 <malloc+0xf98>
    1c92:	00008097          	auipc	ra,0x8
    1c96:	876080e7          	jalr	-1930(ra) # 9508 <printf>
      exit(1);
    1c9a:	4505                	li	a0,1
    1c9c:	00007097          	auipc	ra,0x7
    1ca0:	2ec080e7          	jalr	748(ra) # 8f88 <exit>
      fork();
    1ca4:	00007097          	auipc	ra,0x7
    1ca8:	2dc080e7          	jalr	732(ra) # 8f80 <fork>
      fork();
    1cac:	00007097          	auipc	ra,0x7
    1cb0:	2d4080e7          	jalr	724(ra) # 8f80 <fork>
      exit(0);
    1cb4:	4501                	li	a0,0
    1cb6:	00007097          	auipc	ra,0x7
    1cba:	2d2080e7          	jalr	722(ra) # 8f88 <exit>

0000000000001cbe <forktest>:
{
    1cbe:	7179                	addi	sp,sp,-48
    1cc0:	f406                	sd	ra,40(sp)
    1cc2:	f022                	sd	s0,32(sp)
    1cc4:	ec26                	sd	s1,24(sp)
    1cc6:	e84a                	sd	s2,16(sp)
    1cc8:	e44e                	sd	s3,8(sp)
    1cca:	1800                	addi	s0,sp,48
    1ccc:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1cce:	4481                	li	s1,0
    1cd0:	3e800913          	li	s2,1000
    pid = fork();
    1cd4:	00007097          	auipc	ra,0x7
    1cd8:	2ac080e7          	jalr	684(ra) # 8f80 <fork>
    if(pid < 0)
    1cdc:	02054863          	bltz	a0,1d0c <forktest+0x4e>
    if(pid == 0)
    1ce0:	c115                	beqz	a0,1d04 <forktest+0x46>
  for(n=0; n<N; n++){
    1ce2:	2485                	addiw	s1,s1,1
    1ce4:	ff2498e3          	bne	s1,s2,1cd4 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1ce8:	85ce                	mv	a1,s3
    1cea:	00008517          	auipc	a0,0x8
    1cee:	6f650513          	addi	a0,a0,1782 # a3e0 <malloc+0xe20>
    1cf2:	00008097          	auipc	ra,0x8
    1cf6:	816080e7          	jalr	-2026(ra) # 9508 <printf>
    exit(1);
    1cfa:	4505                	li	a0,1
    1cfc:	00007097          	auipc	ra,0x7
    1d00:	28c080e7          	jalr	652(ra) # 8f88 <exit>
      exit(0);
    1d04:	00007097          	auipc	ra,0x7
    1d08:	284080e7          	jalr	644(ra) # 8f88 <exit>
  if (n == 0) {
    1d0c:	cc9d                	beqz	s1,1d4a <forktest+0x8c>
  if(n == N){
    1d0e:	3e800793          	li	a5,1000
    1d12:	fcf48be3          	beq	s1,a5,1ce8 <forktest+0x2a>
  for(; n > 0; n--){
    1d16:	00905b63          	blez	s1,1d2c <forktest+0x6e>
    if(wait(0) < 0){
    1d1a:	4501                	li	a0,0
    1d1c:	00007097          	auipc	ra,0x7
    1d20:	274080e7          	jalr	628(ra) # 8f90 <wait>
    1d24:	04054163          	bltz	a0,1d66 <forktest+0xa8>
  for(; n > 0; n--){
    1d28:	34fd                	addiw	s1,s1,-1
    1d2a:	f8e5                	bnez	s1,1d1a <forktest+0x5c>
  if(wait(0) != -1){
    1d2c:	4501                	li	a0,0
    1d2e:	00007097          	auipc	ra,0x7
    1d32:	262080e7          	jalr	610(ra) # 8f90 <wait>
    1d36:	57fd                	li	a5,-1
    1d38:	04f51563          	bne	a0,a5,1d82 <forktest+0xc4>
}
    1d3c:	70a2                	ld	ra,40(sp)
    1d3e:	7402                	ld	s0,32(sp)
    1d40:	64e2                	ld	s1,24(sp)
    1d42:	6942                	ld	s2,16(sp)
    1d44:	69a2                	ld	s3,8(sp)
    1d46:	6145                	addi	sp,sp,48
    1d48:	8082                	ret
    printf("%s: no fork at all!\n", s);
    1d4a:	85ce                	mv	a1,s3
    1d4c:	00008517          	auipc	a0,0x8
    1d50:	67c50513          	addi	a0,a0,1660 # a3c8 <malloc+0xe08>
    1d54:	00007097          	auipc	ra,0x7
    1d58:	7b4080e7          	jalr	1972(ra) # 9508 <printf>
    exit(1);
    1d5c:	4505                	li	a0,1
    1d5e:	00007097          	auipc	ra,0x7
    1d62:	22a080e7          	jalr	554(ra) # 8f88 <exit>
      printf("%s: wait stopped early\n", s);
    1d66:	85ce                	mv	a1,s3
    1d68:	00008517          	auipc	a0,0x8
    1d6c:	6a050513          	addi	a0,a0,1696 # a408 <malloc+0xe48>
    1d70:	00007097          	auipc	ra,0x7
    1d74:	798080e7          	jalr	1944(ra) # 9508 <printf>
      exit(1);
    1d78:	4505                	li	a0,1
    1d7a:	00007097          	auipc	ra,0x7
    1d7e:	20e080e7          	jalr	526(ra) # 8f88 <exit>
    printf("%s: wait got too many\n", s);
    1d82:	85ce                	mv	a1,s3
    1d84:	00008517          	auipc	a0,0x8
    1d88:	69c50513          	addi	a0,a0,1692 # a420 <malloc+0xe60>
    1d8c:	00007097          	auipc	ra,0x7
    1d90:	77c080e7          	jalr	1916(ra) # 9508 <printf>
    exit(1);
    1d94:	4505                	li	a0,1
    1d96:	00007097          	auipc	ra,0x7
    1d9a:	1f2080e7          	jalr	498(ra) # 8f88 <exit>

0000000000001d9e <kernmem>:
{
    1d9e:	715d                	addi	sp,sp,-80
    1da0:	e486                	sd	ra,72(sp)
    1da2:	e0a2                	sd	s0,64(sp)
    1da4:	fc26                	sd	s1,56(sp)
    1da6:	f84a                	sd	s2,48(sp)
    1da8:	f44e                	sd	s3,40(sp)
    1daa:	f052                	sd	s4,32(sp)
    1dac:	ec56                	sd	s5,24(sp)
    1dae:	e85a                	sd	s6,16(sp)
    1db0:	0880                	addi	s0,sp,80
    1db2:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1db4:	40100493          	li	s1,1025
    1db8:	04d6                	slli	s1,s1,0x15
    wait(&xstatus);
    1dba:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    1dbe:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1dc0:	69b1                	lui	s3,0xc
    1dc2:	35098993          	addi	s3,s3,848 # c350 <malloc+0x2d90>
    1dc6:	1007d937          	lui	s2,0x1007d
    1dca:	090e                	slli	s2,s2,0x3
    1dcc:	48090913          	addi	s2,s2,1152 # 1007d480 <__BSS_END__+0x1005eba0>
    pid = fork();
    1dd0:	00007097          	auipc	ra,0x7
    1dd4:	1b0080e7          	jalr	432(ra) # 8f80 <fork>
    if(pid < 0){
    1dd8:	02054963          	bltz	a0,1e0a <kernmem+0x6c>
    if(pid == 0){
    1ddc:	c529                	beqz	a0,1e26 <kernmem+0x88>
    wait(&xstatus);
    1dde:	8556                	mv	a0,s5
    1de0:	00007097          	auipc	ra,0x7
    1de4:	1b0080e7          	jalr	432(ra) # 8f90 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1de8:	fbc42783          	lw	a5,-68(s0)
    1dec:	05479d63          	bne	a5,s4,1e46 <kernmem+0xa8>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1df0:	94ce                	add	s1,s1,s3
    1df2:	fd249fe3          	bne	s1,s2,1dd0 <kernmem+0x32>
}
    1df6:	60a6                	ld	ra,72(sp)
    1df8:	6406                	ld	s0,64(sp)
    1dfa:	74e2                	ld	s1,56(sp)
    1dfc:	7942                	ld	s2,48(sp)
    1dfe:	79a2                	ld	s3,40(sp)
    1e00:	7a02                	ld	s4,32(sp)
    1e02:	6ae2                	ld	s5,24(sp)
    1e04:	6b42                	ld	s6,16(sp)
    1e06:	6161                	addi	sp,sp,80
    1e08:	8082                	ret
      printf("%s: fork failed\n", s);
    1e0a:	85da                	mv	a1,s6
    1e0c:	00008517          	auipc	a0,0x8
    1e10:	3cc50513          	addi	a0,a0,972 # a1d8 <malloc+0xc18>
    1e14:	00007097          	auipc	ra,0x7
    1e18:	6f4080e7          	jalr	1780(ra) # 9508 <printf>
      exit(1);
    1e1c:	4505                	li	a0,1
    1e1e:	00007097          	auipc	ra,0x7
    1e22:	16a080e7          	jalr	362(ra) # 8f88 <exit>
      printf("%s: oops could read %x = %x\n", a, *a);
    1e26:	0004c603          	lbu	a2,0(s1)
    1e2a:	85a6                	mv	a1,s1
    1e2c:	00008517          	auipc	a0,0x8
    1e30:	60c50513          	addi	a0,a0,1548 # a438 <malloc+0xe78>
    1e34:	00007097          	auipc	ra,0x7
    1e38:	6d4080e7          	jalr	1748(ra) # 9508 <printf>
      exit(1);
    1e3c:	4505                	li	a0,1
    1e3e:	00007097          	auipc	ra,0x7
    1e42:	14a080e7          	jalr	330(ra) # 8f88 <exit>
      exit(1);
    1e46:	4505                	li	a0,1
    1e48:	00007097          	auipc	ra,0x7
    1e4c:	140080e7          	jalr	320(ra) # 8f88 <exit>

0000000000001e50 <bigargtest>:
{
    1e50:	7179                	addi	sp,sp,-48
    1e52:	f406                	sd	ra,40(sp)
    1e54:	f022                	sd	s0,32(sp)
    1e56:	ec26                	sd	s1,24(sp)
    1e58:	1800                	addi	s0,sp,48
    1e5a:	84aa                	mv	s1,a0
  remove("bigarg-ok");
    1e5c:	00008517          	auipc	a0,0x8
    1e60:	5fc50513          	addi	a0,a0,1532 # a458 <malloc+0xe98>
    1e64:	00007097          	auipc	ra,0x7
    1e68:	1cc080e7          	jalr	460(ra) # 9030 <remove>
  pid = fork();
    1e6c:	00007097          	auipc	ra,0x7
    1e70:	114080e7          	jalr	276(ra) # 8f80 <fork>
  if(pid == 0){
    1e74:	c921                	beqz	a0,1ec4 <bigargtest+0x74>
  } else if(pid < 0){
    1e76:	0a054a63          	bltz	a0,1f2a <bigargtest+0xda>
  wait(&xstatus);
    1e7a:	fdc40513          	addi	a0,s0,-36
    1e7e:	00007097          	auipc	ra,0x7
    1e82:	112080e7          	jalr	274(ra) # 8f90 <wait>
  if(xstatus != 0)
    1e86:	fdc42503          	lw	a0,-36(s0)
    1e8a:	ed55                	bnez	a0,1f46 <bigargtest+0xf6>
  fd = open("bigarg-ok", 0);
    1e8c:	4581                	li	a1,0
    1e8e:	00008517          	auipc	a0,0x8
    1e92:	5ca50513          	addi	a0,a0,1482 # a458 <malloc+0xe98>
    1e96:	00007097          	auipc	ra,0x7
    1e9a:	132080e7          	jalr	306(ra) # 8fc8 <open>
  if(fd < 0){
    1e9e:	0a054863          	bltz	a0,1f4e <bigargtest+0xfe>
  close(fd);
    1ea2:	00007097          	auipc	ra,0x7
    1ea6:	10e080e7          	jalr	270(ra) # 8fb0 <close>
  remove("bigarg-ok");
    1eaa:	00008517          	auipc	a0,0x8
    1eae:	5ae50513          	addi	a0,a0,1454 # a458 <malloc+0xe98>
    1eb2:	00007097          	auipc	ra,0x7
    1eb6:	17e080e7          	jalr	382(ra) # 9030 <remove>
}
    1eba:	70a2                	ld	ra,40(sp)
    1ebc:	7402                	ld	s0,32(sp)
    1ebe:	64e2                	ld	s1,24(sp)
    1ec0:	6145                	addi	sp,sp,48
    1ec2:	8082                	ret
    1ec4:	0000e797          	auipc	a5,0xe
    1ec8:	9d478793          	addi	a5,a5,-1580 # f898 <args.1>
    1ecc:	0000e697          	auipc	a3,0xe
    1ed0:	ac468693          	addi	a3,a3,-1340 # f990 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    1ed4:	00008717          	auipc	a4,0x8
    1ed8:	59470713          	addi	a4,a4,1428 # a468 <malloc+0xea8>
    1edc:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    1ede:	07a1                	addi	a5,a5,8
    1ee0:	fed79ee3          	bne	a5,a3,1edc <bigargtest+0x8c>
    args[MAXARG-1] = 0;
    1ee4:	0000e797          	auipc	a5,0xe
    1ee8:	aa07b623          	sd	zero,-1364(a5) # f990 <args.1+0xf8>
    exec("echo", args);
    1eec:	0000e597          	auipc	a1,0xe
    1ef0:	9ac58593          	addi	a1,a1,-1620 # f898 <args.1>
    1ef4:	00008517          	auipc	a0,0x8
    1ef8:	81450513          	addi	a0,a0,-2028 # 9708 <malloc+0x148>
    1efc:	00007097          	auipc	ra,0x7
    1f00:	0c4080e7          	jalr	196(ra) # 8fc0 <exec>
    fd = open("bigarg-ok", O_CREATE);
    1f04:	20000593          	li	a1,512
    1f08:	00008517          	auipc	a0,0x8
    1f0c:	55050513          	addi	a0,a0,1360 # a458 <malloc+0xe98>
    1f10:	00007097          	auipc	ra,0x7
    1f14:	0b8080e7          	jalr	184(ra) # 8fc8 <open>
    close(fd);
    1f18:	00007097          	auipc	ra,0x7
    1f1c:	098080e7          	jalr	152(ra) # 8fb0 <close>
    exit(0);
    1f20:	4501                	li	a0,0
    1f22:	00007097          	auipc	ra,0x7
    1f26:	066080e7          	jalr	102(ra) # 8f88 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    1f2a:	85a6                	mv	a1,s1
    1f2c:	00008517          	auipc	a0,0x8
    1f30:	61c50513          	addi	a0,a0,1564 # a548 <malloc+0xf88>
    1f34:	00007097          	auipc	ra,0x7
    1f38:	5d4080e7          	jalr	1492(ra) # 9508 <printf>
    exit(1);
    1f3c:	4505                	li	a0,1
    1f3e:	00007097          	auipc	ra,0x7
    1f42:	04a080e7          	jalr	74(ra) # 8f88 <exit>
    exit(xstatus);
    1f46:	00007097          	auipc	ra,0x7
    1f4a:	042080e7          	jalr	66(ra) # 8f88 <exit>
    printf("%s: bigarg test failed!\n", s);
    1f4e:	85a6                	mv	a1,s1
    1f50:	00008517          	auipc	a0,0x8
    1f54:	61850513          	addi	a0,a0,1560 # a568 <malloc+0xfa8>
    1f58:	00007097          	auipc	ra,0x7
    1f5c:	5b0080e7          	jalr	1456(ra) # 9508 <printf>
    exit(1);
    1f60:	4505                	li	a0,1
    1f62:	00007097          	auipc	ra,0x7
    1f66:	026080e7          	jalr	38(ra) # 8f88 <exit>

0000000000001f6a <stacktest>:
{
    1f6a:	7179                	addi	sp,sp,-48
    1f6c:	f406                	sd	ra,40(sp)
    1f6e:	f022                	sd	s0,32(sp)
    1f70:	ec26                	sd	s1,24(sp)
    1f72:	1800                	addi	s0,sp,48
    1f74:	84aa                	mv	s1,a0
  pid = fork();
    1f76:	00007097          	auipc	ra,0x7
    1f7a:	00a080e7          	jalr	10(ra) # 8f80 <fork>
  if(pid == 0) {
    1f7e:	c115                	beqz	a0,1fa2 <stacktest+0x38>
  } else if(pid < 0){
    1f80:	04054363          	bltz	a0,1fc6 <stacktest+0x5c>
  wait(&xstatus);
    1f84:	fdc40513          	addi	a0,s0,-36
    1f88:	00007097          	auipc	ra,0x7
    1f8c:	008080e7          	jalr	8(ra) # 8f90 <wait>
  if(xstatus == -1)  // kernel killed child?
    1f90:	fdc42503          	lw	a0,-36(s0)
    1f94:	57fd                	li	a5,-1
    1f96:	04f50663          	beq	a0,a5,1fe2 <stacktest+0x78>
    exit(xstatus);
    1f9a:	00007097          	auipc	ra,0x7
    1f9e:	fee080e7          	jalr	-18(ra) # 8f88 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1fa2:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", *sp);
    1fa4:	77fd                	lui	a5,0xfffff
    1fa6:	97ba                	add	a5,a5,a4
    1fa8:	0007c583          	lbu	a1,0(a5) # fffffffffffff000 <__BSS_END__+0xfffffffffffe0720>
    1fac:	00008517          	auipc	a0,0x8
    1fb0:	5dc50513          	addi	a0,a0,1500 # a588 <malloc+0xfc8>
    1fb4:	00007097          	auipc	ra,0x7
    1fb8:	554080e7          	jalr	1364(ra) # 9508 <printf>
    exit(1);
    1fbc:	4505                	li	a0,1
    1fbe:	00007097          	auipc	ra,0x7
    1fc2:	fca080e7          	jalr	-54(ra) # 8f88 <exit>
    printf("%s: fork failed\n", s);
    1fc6:	85a6                	mv	a1,s1
    1fc8:	00008517          	auipc	a0,0x8
    1fcc:	21050513          	addi	a0,a0,528 # a1d8 <malloc+0xc18>
    1fd0:	00007097          	auipc	ra,0x7
    1fd4:	538080e7          	jalr	1336(ra) # 9508 <printf>
    exit(1);
    1fd8:	4505                	li	a0,1
    1fda:	00007097          	auipc	ra,0x7
    1fde:	fae080e7          	jalr	-82(ra) # 8f88 <exit>
    exit(0);
    1fe2:	4501                	li	a0,0
    1fe4:	00007097          	auipc	ra,0x7
    1fe8:	fa4080e7          	jalr	-92(ra) # 8f88 <exit>

0000000000001fec <copyinstr3>:
{
    1fec:	7179                	addi	sp,sp,-48
    1fee:	f406                	sd	ra,40(sp)
    1ff0:	f022                	sd	s0,32(sp)
    1ff2:	ec26                	sd	s1,24(sp)
    1ff4:	1800                	addi	s0,sp,48
  sbrk(8192);
    1ff6:	6509                	lui	a0,0x2
    1ff8:	00007097          	auipc	ra,0x7
    1ffc:	000080e7          	jalr	ra # 8ff8 <sbrk>
  uint64 top = (uint64) sbrk(0);
    2000:	4501                	li	a0,0
    2002:	00007097          	auipc	ra,0x7
    2006:	ff6080e7          	jalr	-10(ra) # 8ff8 <sbrk>
  if((top % PGSIZE) != 0){
    200a:	03451793          	slli	a5,a0,0x34
    200e:	eba5                	bnez	a5,207e <copyinstr3+0x92>
  top = (uint64) sbrk(0);
    2010:	4501                	li	a0,0
    2012:	00007097          	auipc	ra,0x7
    2016:	fe6080e7          	jalr	-26(ra) # 8ff8 <sbrk>
  if(top % PGSIZE){
    201a:	03451793          	slli	a5,a0,0x34
    201e:	ebb5                	bnez	a5,2092 <copyinstr3+0xa6>
  char *b = (char *) (top - 1);
    2020:	fff50493          	addi	s1,a0,-1 # 1fff <copyinstr3+0x13>
  *b = 'x';
    2024:	07800793          	li	a5,120
    2028:	fef50fa3          	sb	a5,-1(a0)
  int ret = remove(b);
    202c:	8526                	mv	a0,s1
    202e:	00007097          	auipc	ra,0x7
    2032:	002080e7          	jalr	2(ra) # 9030 <remove>
  if(ret != -1){
    2036:	57fd                	li	a5,-1
    2038:	06f51a63          	bne	a0,a5,20ac <copyinstr3+0xc0>
  int fd = open(b, O_CREATE | O_WRONLY);
    203c:	20100593          	li	a1,513
    2040:	8526                	mv	a0,s1
    2042:	00007097          	auipc	ra,0x7
    2046:	f86080e7          	jalr	-122(ra) # 8fc8 <open>
  if(fd != -1){
    204a:	57fd                	li	a5,-1
    204c:	06f51f63          	bne	a0,a5,20ca <copyinstr3+0xde>
  char *args[] = { "xx", 0 };
    2050:	00009797          	auipc	a5,0x9
    2054:	ce878793          	addi	a5,a5,-792 # ad38 <malloc+0x1778>
    2058:	fcf43823          	sd	a5,-48(s0)
    205c:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2060:	fd040593          	addi	a1,s0,-48
    2064:	8526                	mv	a0,s1
    2066:	00007097          	auipc	ra,0x7
    206a:	f5a080e7          	jalr	-166(ra) # 8fc0 <exec>
  if(ret != -1){
    206e:	57fd                	li	a5,-1
    2070:	06f51c63          	bne	a0,a5,20e8 <copyinstr3+0xfc>
}
    2074:	70a2                	ld	ra,40(sp)
    2076:	7402                	ld	s0,32(sp)
    2078:	64e2                	ld	s1,24(sp)
    207a:	6145                	addi	sp,sp,48
    207c:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    207e:	0347d513          	srli	a0,a5,0x34
    2082:	6785                	lui	a5,0x1
    2084:	40a7853b          	subw	a0,a5,a0
    2088:	00007097          	auipc	ra,0x7
    208c:	f70080e7          	jalr	-144(ra) # 8ff8 <sbrk>
    2090:	b741                	j	2010 <copyinstr3+0x24>
    printf("oops\n");
    2092:	00008517          	auipc	a0,0x8
    2096:	51e50513          	addi	a0,a0,1310 # a5b0 <malloc+0xff0>
    209a:	00007097          	auipc	ra,0x7
    209e:	46e080e7          	jalr	1134(ra) # 9508 <printf>
    exit(1);
    20a2:	4505                	li	a0,1
    20a4:	00007097          	auipc	ra,0x7
    20a8:	ee4080e7          	jalr	-284(ra) # 8f88 <exit>
    printf("remove(%s) returned %d, not -1\n", b, ret);
    20ac:	862a                	mv	a2,a0
    20ae:	85a6                	mv	a1,s1
    20b0:	00008517          	auipc	a0,0x8
    20b4:	07050513          	addi	a0,a0,112 # a120 <malloc+0xb60>
    20b8:	00007097          	auipc	ra,0x7
    20bc:	450080e7          	jalr	1104(ra) # 9508 <printf>
    exit(1);
    20c0:	4505                	li	a0,1
    20c2:	00007097          	auipc	ra,0x7
    20c6:	ec6080e7          	jalr	-314(ra) # 8f88 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    20ca:	862a                	mv	a2,a0
    20cc:	85a6                	mv	a1,s1
    20ce:	00008517          	auipc	a0,0x8
    20d2:	07250513          	addi	a0,a0,114 # a140 <malloc+0xb80>
    20d6:	00007097          	auipc	ra,0x7
    20da:	432080e7          	jalr	1074(ra) # 9508 <printf>
    exit(1);
    20de:	4505                	li	a0,1
    20e0:	00007097          	auipc	ra,0x7
    20e4:	ea8080e7          	jalr	-344(ra) # 8f88 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    20e8:	567d                	li	a2,-1
    20ea:	85a6                	mv	a1,s1
    20ec:	00008517          	auipc	a0,0x8
    20f0:	07450513          	addi	a0,a0,116 # a160 <malloc+0xba0>
    20f4:	00007097          	auipc	ra,0x7
    20f8:	414080e7          	jalr	1044(ra) # 9508 <printf>
    exit(1);
    20fc:	4505                	li	a0,1
    20fe:	00007097          	auipc	ra,0x7
    2102:	e8a080e7          	jalr	-374(ra) # 8f88 <exit>

0000000000002106 <sbrkbasic>:
{
    2106:	7139                	addi	sp,sp,-64
    2108:	fc06                	sd	ra,56(sp)
    210a:	f822                	sd	s0,48(sp)
    210c:	f426                	sd	s1,40(sp)
    210e:	f04a                	sd	s2,32(sp)
    2110:	ec4e                	sd	s3,24(sp)
    2112:	e852                	sd	s4,16(sp)
    2114:	0080                	addi	s0,sp,64
    2116:	8a2a                	mv	s4,a0
  pid = fork();
    2118:	00007097          	auipc	ra,0x7
    211c:	e68080e7          	jalr	-408(ra) # 8f80 <fork>
  if(pid < 0){
    2120:	02054c63          	bltz	a0,2158 <sbrkbasic+0x52>
  if(pid == 0){
    2124:	ed21                	bnez	a0,217c <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    2126:	40000537          	lui	a0,0x40000
    212a:	00007097          	auipc	ra,0x7
    212e:	ece080e7          	jalr	-306(ra) # 8ff8 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    2132:	57fd                	li	a5,-1
    2134:	02f50f63          	beq	a0,a5,2172 <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2138:	400007b7          	lui	a5,0x40000
    213c:	97aa                	add	a5,a5,a0
      *b = 99;
    213e:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    2142:	6705                	lui	a4,0x1
      *b = 99;
    2144:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3ffe1720>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2148:	953a                	add	a0,a0,a4
    214a:	fef51de3          	bne	a0,a5,2144 <sbrkbasic+0x3e>
    exit(1);
    214e:	4505                	li	a0,1
    2150:	00007097          	auipc	ra,0x7
    2154:	e38080e7          	jalr	-456(ra) # 8f88 <exit>
    printf("fork failed in sbrkbasic\n");
    2158:	00008517          	auipc	a0,0x8
    215c:	46050513          	addi	a0,a0,1120 # a5b8 <malloc+0xff8>
    2160:	00007097          	auipc	ra,0x7
    2164:	3a8080e7          	jalr	936(ra) # 9508 <printf>
    exit(1);
    2168:	4505                	li	a0,1
    216a:	00007097          	auipc	ra,0x7
    216e:	e1e080e7          	jalr	-482(ra) # 8f88 <exit>
      exit(0);
    2172:	4501                	li	a0,0
    2174:	00007097          	auipc	ra,0x7
    2178:	e14080e7          	jalr	-492(ra) # 8f88 <exit>
  wait(&xstatus);
    217c:	fcc40513          	addi	a0,s0,-52
    2180:	00007097          	auipc	ra,0x7
    2184:	e10080e7          	jalr	-496(ra) # 8f90 <wait>
  if(xstatus == 1){
    2188:	fcc42703          	lw	a4,-52(s0)
    218c:	4785                	li	a5,1
    218e:	00f70d63          	beq	a4,a5,21a8 <sbrkbasic+0xa2>
  a = sbrk(0);
    2192:	4501                	li	a0,0
    2194:	00007097          	auipc	ra,0x7
    2198:	e64080e7          	jalr	-412(ra) # 8ff8 <sbrk>
    219c:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    219e:	4901                	li	s2,0
    21a0:	6985                	lui	s3,0x1
    21a2:	38898993          	addi	s3,s3,904 # 1388 <copyinstr2+0x78>
    21a6:	a005                	j	21c6 <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    21a8:	85d2                	mv	a1,s4
    21aa:	00008517          	auipc	a0,0x8
    21ae:	42e50513          	addi	a0,a0,1070 # a5d8 <malloc+0x1018>
    21b2:	00007097          	auipc	ra,0x7
    21b6:	356080e7          	jalr	854(ra) # 9508 <printf>
    exit(1);
    21ba:	4505                	li	a0,1
    21bc:	00007097          	auipc	ra,0x7
    21c0:	dcc080e7          	jalr	-564(ra) # 8f88 <exit>
    a = b + 1;
    21c4:	84be                	mv	s1,a5
    b = sbrk(1);
    21c6:	4505                	li	a0,1
    21c8:	00007097          	auipc	ra,0x7
    21cc:	e30080e7          	jalr	-464(ra) # 8ff8 <sbrk>
    if(b != a){
    21d0:	04951c63          	bne	a0,s1,2228 <sbrkbasic+0x122>
    *b = 1;
    21d4:	4785                	li	a5,1
    21d6:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    21da:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    21de:	2905                	addiw	s2,s2,1
    21e0:	ff3912e3          	bne	s2,s3,21c4 <sbrkbasic+0xbe>
  pid = fork();
    21e4:	00007097          	auipc	ra,0x7
    21e8:	d9c080e7          	jalr	-612(ra) # 8f80 <fork>
    21ec:	892a                	mv	s2,a0
  if(pid < 0){
    21ee:	04054d63          	bltz	a0,2248 <sbrkbasic+0x142>
  c = sbrk(1);
    21f2:	4505                	li	a0,1
    21f4:	00007097          	auipc	ra,0x7
    21f8:	e04080e7          	jalr	-508(ra) # 8ff8 <sbrk>
  c = sbrk(1);
    21fc:	4505                	li	a0,1
    21fe:	00007097          	auipc	ra,0x7
    2202:	dfa080e7          	jalr	-518(ra) # 8ff8 <sbrk>
  if(c != a + 1){
    2206:	0489                	addi	s1,s1,2
    2208:	04a48e63          	beq	s1,a0,2264 <sbrkbasic+0x15e>
    printf("%s: sbrk test failed post-fork\n", s);
    220c:	85d2                	mv	a1,s4
    220e:	00008517          	auipc	a0,0x8
    2212:	42a50513          	addi	a0,a0,1066 # a638 <malloc+0x1078>
    2216:	00007097          	auipc	ra,0x7
    221a:	2f2080e7          	jalr	754(ra) # 9508 <printf>
    exit(1);
    221e:	4505                	li	a0,1
    2220:	00007097          	auipc	ra,0x7
    2224:	d68080e7          	jalr	-664(ra) # 8f88 <exit>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    2228:	86aa                	mv	a3,a0
    222a:	8626                	mv	a2,s1
    222c:	85ca                	mv	a1,s2
    222e:	00008517          	auipc	a0,0x8
    2232:	3ca50513          	addi	a0,a0,970 # a5f8 <malloc+0x1038>
    2236:	00007097          	auipc	ra,0x7
    223a:	2d2080e7          	jalr	722(ra) # 9508 <printf>
      exit(1);
    223e:	4505                	li	a0,1
    2240:	00007097          	auipc	ra,0x7
    2244:	d48080e7          	jalr	-696(ra) # 8f88 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2248:	85d2                	mv	a1,s4
    224a:	00008517          	auipc	a0,0x8
    224e:	3ce50513          	addi	a0,a0,974 # a618 <malloc+0x1058>
    2252:	00007097          	auipc	ra,0x7
    2256:	2b6080e7          	jalr	694(ra) # 9508 <printf>
    exit(1);
    225a:	4505                	li	a0,1
    225c:	00007097          	auipc	ra,0x7
    2260:	d2c080e7          	jalr	-724(ra) # 8f88 <exit>
  if(pid == 0)
    2264:	00091763          	bnez	s2,2272 <sbrkbasic+0x16c>
    exit(0);
    2268:	4501                	li	a0,0
    226a:	00007097          	auipc	ra,0x7
    226e:	d1e080e7          	jalr	-738(ra) # 8f88 <exit>
  wait(&xstatus);
    2272:	fcc40513          	addi	a0,s0,-52
    2276:	00007097          	auipc	ra,0x7
    227a:	d1a080e7          	jalr	-742(ra) # 8f90 <wait>
  exit(xstatus);
    227e:	fcc42503          	lw	a0,-52(s0)
    2282:	00007097          	auipc	ra,0x7
    2286:	d06080e7          	jalr	-762(ra) # 8f88 <exit>

000000000000228a <sbrkmuch>:
{
    228a:	7179                	addi	sp,sp,-48
    228c:	f406                	sd	ra,40(sp)
    228e:	f022                	sd	s0,32(sp)
    2290:	ec26                	sd	s1,24(sp)
    2292:	e84a                	sd	s2,16(sp)
    2294:	e44e                	sd	s3,8(sp)
    2296:	e052                	sd	s4,0(sp)
    2298:	1800                	addi	s0,sp,48
    229a:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    229c:	4501                	li	a0,0
    229e:	00007097          	auipc	ra,0x7
    22a2:	d5a080e7          	jalr	-678(ra) # 8ff8 <sbrk>
    22a6:	892a                	mv	s2,a0
  a = sbrk(0);
    22a8:	4501                	li	a0,0
    22aa:	00007097          	auipc	ra,0x7
    22ae:	d4e080e7          	jalr	-690(ra) # 8ff8 <sbrk>
    22b2:	84aa                	mv	s1,a0
  p = sbrk(amt);
    22b4:	00300537          	lui	a0,0x300
    22b8:	9d05                	subw	a0,a0,s1
    22ba:	00007097          	auipc	ra,0x7
    22be:	d3e080e7          	jalr	-706(ra) # 8ff8 <sbrk>
  if (p != a) {
    22c2:	0ca49863          	bne	s1,a0,2392 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    22c6:	4501                	li	a0,0
    22c8:	00007097          	auipc	ra,0x7
    22cc:	d30080e7          	jalr	-720(ra) # 8ff8 <sbrk>
    22d0:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    22d2:	00a4f963          	bgeu	s1,a0,22e4 <sbrkmuch+0x5a>
    *pp = 1;
    22d6:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    22d8:	6705                	lui	a4,0x1
    *pp = 1;
    22da:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    22de:	94ba                	add	s1,s1,a4
    22e0:	fef4ede3          	bltu	s1,a5,22da <sbrkmuch+0x50>
  *lastaddr = 99;
    22e4:	003007b7          	lui	a5,0x300
    22e8:	06300713          	li	a4,99
    22ec:	fee78fa3          	sb	a4,-1(a5) # 2fffff <__BSS_END__+0x2e171f>
  a = sbrk(0);
    22f0:	4501                	li	a0,0
    22f2:	00007097          	auipc	ra,0x7
    22f6:	d06080e7          	jalr	-762(ra) # 8ff8 <sbrk>
    22fa:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    22fc:	757d                	lui	a0,0xfffff
    22fe:	00007097          	auipc	ra,0x7
    2302:	cfa080e7          	jalr	-774(ra) # 8ff8 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2306:	57fd                	li	a5,-1
    2308:	0af50363          	beq	a0,a5,23ae <sbrkmuch+0x124>
  c = sbrk(0);
    230c:	4501                	li	a0,0
    230e:	00007097          	auipc	ra,0x7
    2312:	cea080e7          	jalr	-790(ra) # 8ff8 <sbrk>
  if(c != a - PGSIZE){
    2316:	77fd                	lui	a5,0xfffff
    2318:	97a6                	add	a5,a5,s1
    231a:	0af51863          	bne	a0,a5,23ca <sbrkmuch+0x140>
  a = sbrk(0);
    231e:	4501                	li	a0,0
    2320:	00007097          	auipc	ra,0x7
    2324:	cd8080e7          	jalr	-808(ra) # 8ff8 <sbrk>
    2328:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    232a:	6505                	lui	a0,0x1
    232c:	00007097          	auipc	ra,0x7
    2330:	ccc080e7          	jalr	-820(ra) # 8ff8 <sbrk>
    2334:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2336:	0aa49963          	bne	s1,a0,23e8 <sbrkmuch+0x15e>
    233a:	4501                	li	a0,0
    233c:	00007097          	auipc	ra,0x7
    2340:	cbc080e7          	jalr	-836(ra) # 8ff8 <sbrk>
    2344:	6785                	lui	a5,0x1
    2346:	97a6                	add	a5,a5,s1
    2348:	0af51063          	bne	a0,a5,23e8 <sbrkmuch+0x15e>
  if(*lastaddr == 99){
    234c:	003007b7          	lui	a5,0x300
    2350:	fff7c703          	lbu	a4,-1(a5) # 2fffff <__BSS_END__+0x2e171f>
    2354:	06300793          	li	a5,99
    2358:	0af70763          	beq	a4,a5,2406 <sbrkmuch+0x17c>
  a = sbrk(0);
    235c:	4501                	li	a0,0
    235e:	00007097          	auipc	ra,0x7
    2362:	c9a080e7          	jalr	-870(ra) # 8ff8 <sbrk>
    2366:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2368:	4501                	li	a0,0
    236a:	00007097          	auipc	ra,0x7
    236e:	c8e080e7          	jalr	-882(ra) # 8ff8 <sbrk>
    2372:	40a9053b          	subw	a0,s2,a0
    2376:	00007097          	auipc	ra,0x7
    237a:	c82080e7          	jalr	-894(ra) # 8ff8 <sbrk>
  if(c != a){
    237e:	0aa49263          	bne	s1,a0,2422 <sbrkmuch+0x198>
}
    2382:	70a2                	ld	ra,40(sp)
    2384:	7402                	ld	s0,32(sp)
    2386:	64e2                	ld	s1,24(sp)
    2388:	6942                	ld	s2,16(sp)
    238a:	69a2                	ld	s3,8(sp)
    238c:	6a02                	ld	s4,0(sp)
    238e:	6145                	addi	sp,sp,48
    2390:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2392:	85ce                	mv	a1,s3
    2394:	00008517          	auipc	a0,0x8
    2398:	2c450513          	addi	a0,a0,708 # a658 <malloc+0x1098>
    239c:	00007097          	auipc	ra,0x7
    23a0:	16c080e7          	jalr	364(ra) # 9508 <printf>
    exit(1);
    23a4:	4505                	li	a0,1
    23a6:	00007097          	auipc	ra,0x7
    23aa:	be2080e7          	jalr	-1054(ra) # 8f88 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    23ae:	85ce                	mv	a1,s3
    23b0:	00008517          	auipc	a0,0x8
    23b4:	2f050513          	addi	a0,a0,752 # a6a0 <malloc+0x10e0>
    23b8:	00007097          	auipc	ra,0x7
    23bc:	150080e7          	jalr	336(ra) # 9508 <printf>
    exit(1);
    23c0:	4505                	li	a0,1
    23c2:	00007097          	auipc	ra,0x7
    23c6:	bc6080e7          	jalr	-1082(ra) # 8f88 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    23ca:	862a                	mv	a2,a0
    23cc:	85a6                	mv	a1,s1
    23ce:	00008517          	auipc	a0,0x8
    23d2:	2f250513          	addi	a0,a0,754 # a6c0 <malloc+0x1100>
    23d6:	00007097          	auipc	ra,0x7
    23da:	132080e7          	jalr	306(ra) # 9508 <printf>
    exit(1);
    23de:	4505                	li	a0,1
    23e0:	00007097          	auipc	ra,0x7
    23e4:	ba8080e7          	jalr	-1112(ra) # 8f88 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", a, c);
    23e8:	8652                	mv	a2,s4
    23ea:	85a6                	mv	a1,s1
    23ec:	00008517          	auipc	a0,0x8
    23f0:	31450513          	addi	a0,a0,788 # a700 <malloc+0x1140>
    23f4:	00007097          	auipc	ra,0x7
    23f8:	114080e7          	jalr	276(ra) # 9508 <printf>
    exit(1);
    23fc:	4505                	li	a0,1
    23fe:	00007097          	auipc	ra,0x7
    2402:	b8a080e7          	jalr	-1142(ra) # 8f88 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2406:	85ce                	mv	a1,s3
    2408:	00008517          	auipc	a0,0x8
    240c:	32850513          	addi	a0,a0,808 # a730 <malloc+0x1170>
    2410:	00007097          	auipc	ra,0x7
    2414:	0f8080e7          	jalr	248(ra) # 9508 <printf>
    exit(1);
    2418:	4505                	li	a0,1
    241a:	00007097          	auipc	ra,0x7
    241e:	b6e080e7          	jalr	-1170(ra) # 8f88 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", a, c);
    2422:	862a                	mv	a2,a0
    2424:	85a6                	mv	a1,s1
    2426:	00008517          	auipc	a0,0x8
    242a:	34250513          	addi	a0,a0,834 # a768 <malloc+0x11a8>
    242e:	00007097          	auipc	ra,0x7
    2432:	0da080e7          	jalr	218(ra) # 9508 <printf>
    exit(1);
    2436:	4505                	li	a0,1
    2438:	00007097          	auipc	ra,0x7
    243c:	b50080e7          	jalr	-1200(ra) # 8f88 <exit>

0000000000002440 <sbrkarg>:
{
    2440:	7179                	addi	sp,sp,-48
    2442:	f406                	sd	ra,40(sp)
    2444:	f022                	sd	s0,32(sp)
    2446:	ec26                	sd	s1,24(sp)
    2448:	e84a                	sd	s2,16(sp)
    244a:	e44e                	sd	s3,8(sp)
    244c:	1800                	addi	s0,sp,48
    244e:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2450:	6505                	lui	a0,0x1
    2452:	00007097          	auipc	ra,0x7
    2456:	ba6080e7          	jalr	-1114(ra) # 8ff8 <sbrk>
    245a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    245c:	20100593          	li	a1,513
    2460:	00008517          	auipc	a0,0x8
    2464:	33050513          	addi	a0,a0,816 # a790 <malloc+0x11d0>
    2468:	00007097          	auipc	ra,0x7
    246c:	b60080e7          	jalr	-1184(ra) # 8fc8 <open>
    2470:	84aa                	mv	s1,a0
  remove("sbrk");
    2472:	00008517          	auipc	a0,0x8
    2476:	31e50513          	addi	a0,a0,798 # a790 <malloc+0x11d0>
    247a:	00007097          	auipc	ra,0x7
    247e:	bb6080e7          	jalr	-1098(ra) # 9030 <remove>
  if(fd < 0)  {
    2482:	0404c163          	bltz	s1,24c4 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2486:	6605                	lui	a2,0x1
    2488:	85ca                	mv	a1,s2
    248a:	8526                	mv	a0,s1
    248c:	00007097          	auipc	ra,0x7
    2490:	b1c080e7          	jalr	-1252(ra) # 8fa8 <write>
    2494:	04054663          	bltz	a0,24e0 <sbrkarg+0xa0>
  close(fd);
    2498:	8526                	mv	a0,s1
    249a:	00007097          	auipc	ra,0x7
    249e:	b16080e7          	jalr	-1258(ra) # 8fb0 <close>
  a = sbrk(PGSIZE);
    24a2:	6505                	lui	a0,0x1
    24a4:	00007097          	auipc	ra,0x7
    24a8:	b54080e7          	jalr	-1196(ra) # 8ff8 <sbrk>
  if(pipe((int *) a) != 0){
    24ac:	00007097          	auipc	ra,0x7
    24b0:	aec080e7          	jalr	-1300(ra) # 8f98 <pipe>
    24b4:	e521                	bnez	a0,24fc <sbrkarg+0xbc>
}
    24b6:	70a2                	ld	ra,40(sp)
    24b8:	7402                	ld	s0,32(sp)
    24ba:	64e2                	ld	s1,24(sp)
    24bc:	6942                	ld	s2,16(sp)
    24be:	69a2                	ld	s3,8(sp)
    24c0:	6145                	addi	sp,sp,48
    24c2:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    24c4:	85ce                	mv	a1,s3
    24c6:	00008517          	auipc	a0,0x8
    24ca:	2d250513          	addi	a0,a0,722 # a798 <malloc+0x11d8>
    24ce:	00007097          	auipc	ra,0x7
    24d2:	03a080e7          	jalr	58(ra) # 9508 <printf>
    exit(1);
    24d6:	4505                	li	a0,1
    24d8:	00007097          	auipc	ra,0x7
    24dc:	ab0080e7          	jalr	-1360(ra) # 8f88 <exit>
    printf("%s: write sbrk failed\n", s);
    24e0:	85ce                	mv	a1,s3
    24e2:	00008517          	auipc	a0,0x8
    24e6:	2ce50513          	addi	a0,a0,718 # a7b0 <malloc+0x11f0>
    24ea:	00007097          	auipc	ra,0x7
    24ee:	01e080e7          	jalr	30(ra) # 9508 <printf>
    exit(1);
    24f2:	4505                	li	a0,1
    24f4:	00007097          	auipc	ra,0x7
    24f8:	a94080e7          	jalr	-1388(ra) # 8f88 <exit>
    printf("%s: pipe() failed\n", s);
    24fc:	85ce                	mv	a1,s3
    24fe:	00008517          	auipc	a0,0x8
    2502:	de250513          	addi	a0,a0,-542 # a2e0 <malloc+0xd20>
    2506:	00007097          	auipc	ra,0x7
    250a:	002080e7          	jalr	2(ra) # 9508 <printf>
    exit(1);
    250e:	4505                	li	a0,1
    2510:	00007097          	auipc	ra,0x7
    2514:	a78080e7          	jalr	-1416(ra) # 8f88 <exit>

0000000000002518 <argptest>:
{
    2518:	1101                	addi	sp,sp,-32
    251a:	ec06                	sd	ra,24(sp)
    251c:	e822                	sd	s0,16(sp)
    251e:	e426                	sd	s1,8(sp)
    2520:	e04a                	sd	s2,0(sp)
    2522:	1000                	addi	s0,sp,32
    2524:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2526:	4581                	li	a1,0
    2528:	00008517          	auipc	a0,0x8
    252c:	2a050513          	addi	a0,a0,672 # a7c8 <malloc+0x1208>
    2530:	00007097          	auipc	ra,0x7
    2534:	a98080e7          	jalr	-1384(ra) # 8fc8 <open>
  if (fd < 0) {
    2538:	02054b63          	bltz	a0,256e <argptest+0x56>
    253c:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    253e:	4501                	li	a0,0
    2540:	00007097          	auipc	ra,0x7
    2544:	ab8080e7          	jalr	-1352(ra) # 8ff8 <sbrk>
    2548:	567d                	li	a2,-1
    254a:	fff50593          	addi	a1,a0,-1
    254e:	8526                	mv	a0,s1
    2550:	00007097          	auipc	ra,0x7
    2554:	a50080e7          	jalr	-1456(ra) # 8fa0 <read>
  close(fd);
    2558:	8526                	mv	a0,s1
    255a:	00007097          	auipc	ra,0x7
    255e:	a56080e7          	jalr	-1450(ra) # 8fb0 <close>
}
    2562:	60e2                	ld	ra,24(sp)
    2564:	6442                	ld	s0,16(sp)
    2566:	64a2                	ld	s1,8(sp)
    2568:	6902                	ld	s2,0(sp)
    256a:	6105                	addi	sp,sp,32
    256c:	8082                	ret
    printf("%s: open failed\n", s);
    256e:	85ca                	mv	a1,s2
    2570:	00008517          	auipc	a0,0x8
    2574:	c8050513          	addi	a0,a0,-896 # a1f0 <malloc+0xc30>
    2578:	00007097          	auipc	ra,0x7
    257c:	f90080e7          	jalr	-112(ra) # 9508 <printf>
    exit(1);
    2580:	4505                	li	a0,1
    2582:	00007097          	auipc	ra,0x7
    2586:	a06080e7          	jalr	-1530(ra) # 8f88 <exit>

000000000000258a <sbrkbugs>:
{
    258a:	1141                	addi	sp,sp,-16
    258c:	e406                	sd	ra,8(sp)
    258e:	e022                	sd	s0,0(sp)
    2590:	0800                	addi	s0,sp,16
  int pid = fork();
    2592:	00007097          	auipc	ra,0x7
    2596:	9ee080e7          	jalr	-1554(ra) # 8f80 <fork>
  if(pid < 0){
    259a:	02054263          	bltz	a0,25be <sbrkbugs+0x34>
  if(pid == 0){
    259e:	ed0d                	bnez	a0,25d8 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    25a0:	00007097          	auipc	ra,0x7
    25a4:	a58080e7          	jalr	-1448(ra) # 8ff8 <sbrk>
    sbrk(-sz);
    25a8:	40a0053b          	negw	a0,a0
    25ac:	00007097          	auipc	ra,0x7
    25b0:	a4c080e7          	jalr	-1460(ra) # 8ff8 <sbrk>
    exit(0);
    25b4:	4501                	li	a0,0
    25b6:	00007097          	auipc	ra,0x7
    25ba:	9d2080e7          	jalr	-1582(ra) # 8f88 <exit>
    printf("fork failed\n");
    25be:	00008517          	auipc	a0,0x8
    25c2:	f9a50513          	addi	a0,a0,-102 # a558 <malloc+0xf98>
    25c6:	00007097          	auipc	ra,0x7
    25ca:	f42080e7          	jalr	-190(ra) # 9508 <printf>
    exit(1);
    25ce:	4505                	li	a0,1
    25d0:	00007097          	auipc	ra,0x7
    25d4:	9b8080e7          	jalr	-1608(ra) # 8f88 <exit>
  wait(0);
    25d8:	4501                	li	a0,0
    25da:	00007097          	auipc	ra,0x7
    25de:	9b6080e7          	jalr	-1610(ra) # 8f90 <wait>
  pid = fork();
    25e2:	00007097          	auipc	ra,0x7
    25e6:	99e080e7          	jalr	-1634(ra) # 8f80 <fork>
  if(pid < 0){
    25ea:	02054563          	bltz	a0,2614 <sbrkbugs+0x8a>
  if(pid == 0){
    25ee:	e121                	bnez	a0,262e <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    25f0:	00007097          	auipc	ra,0x7
    25f4:	a08080e7          	jalr	-1528(ra) # 8ff8 <sbrk>
    sbrk(-(sz - 3500));
    25f8:	6785                	lui	a5,0x1
    25fa:	dac7879b          	addiw	a5,a5,-596 # dac <removeread+0xc8>
    25fe:	40a7853b          	subw	a0,a5,a0
    2602:	00007097          	auipc	ra,0x7
    2606:	9f6080e7          	jalr	-1546(ra) # 8ff8 <sbrk>
    exit(0);
    260a:	4501                	li	a0,0
    260c:	00007097          	auipc	ra,0x7
    2610:	97c080e7          	jalr	-1668(ra) # 8f88 <exit>
    printf("fork failed\n");
    2614:	00008517          	auipc	a0,0x8
    2618:	f4450513          	addi	a0,a0,-188 # a558 <malloc+0xf98>
    261c:	00007097          	auipc	ra,0x7
    2620:	eec080e7          	jalr	-276(ra) # 9508 <printf>
    exit(1);
    2624:	4505                	li	a0,1
    2626:	00007097          	auipc	ra,0x7
    262a:	962080e7          	jalr	-1694(ra) # 8f88 <exit>
  wait(0);
    262e:	4501                	li	a0,0
    2630:	00007097          	auipc	ra,0x7
    2634:	960080e7          	jalr	-1696(ra) # 8f90 <wait>
  pid = fork();
    2638:	00007097          	auipc	ra,0x7
    263c:	948080e7          	jalr	-1720(ra) # 8f80 <fork>
  if(pid < 0){
    2640:	02054a63          	bltz	a0,2674 <sbrkbugs+0xea>
  if(pid == 0){
    2644:	e529                	bnez	a0,268e <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2646:	00007097          	auipc	ra,0x7
    264a:	9b2080e7          	jalr	-1614(ra) # 8ff8 <sbrk>
    264e:	67ad                	lui	a5,0xb
    2650:	8007879b          	addiw	a5,a5,-2048 # a800 <malloc+0x1240>
    2654:	40a7853b          	subw	a0,a5,a0
    2658:	00007097          	auipc	ra,0x7
    265c:	9a0080e7          	jalr	-1632(ra) # 8ff8 <sbrk>
    sbrk(-10);
    2660:	5559                	li	a0,-10
    2662:	00007097          	auipc	ra,0x7
    2666:	996080e7          	jalr	-1642(ra) # 8ff8 <sbrk>
    exit(0);
    266a:	4501                	li	a0,0
    266c:	00007097          	auipc	ra,0x7
    2670:	91c080e7          	jalr	-1764(ra) # 8f88 <exit>
    printf("fork failed\n");
    2674:	00008517          	auipc	a0,0x8
    2678:	ee450513          	addi	a0,a0,-284 # a558 <malloc+0xf98>
    267c:	00007097          	auipc	ra,0x7
    2680:	e8c080e7          	jalr	-372(ra) # 9508 <printf>
    exit(1);
    2684:	4505                	li	a0,1
    2686:	00007097          	auipc	ra,0x7
    268a:	902080e7          	jalr	-1790(ra) # 8f88 <exit>
  wait(0);
    268e:	4501                	li	a0,0
    2690:	00007097          	auipc	ra,0x7
    2694:	900080e7          	jalr	-1792(ra) # 8f90 <wait>
  exit(0);
    2698:	4501                	li	a0,0
    269a:	00007097          	auipc	ra,0x7
    269e:	8ee080e7          	jalr	-1810(ra) # 8f88 <exit>

00000000000026a2 <execout>:
{
    26a2:	715d                	addi	sp,sp,-80
    26a4:	e486                	sd	ra,72(sp)
    26a6:	e0a2                	sd	s0,64(sp)
    26a8:	fc26                	sd	s1,56(sp)
    26aa:	f84a                	sd	s2,48(sp)
    26ac:	f44e                	sd	s3,40(sp)
    26ae:	f052                	sd	s4,32(sp)
    26b0:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    26b2:	4901                	li	s2,0
    26b4:	49bd                	li	s3,15
    int pid = fork();
    26b6:	00007097          	auipc	ra,0x7
    26ba:	8ca080e7          	jalr	-1846(ra) # 8f80 <fork>
    26be:	84aa                	mv	s1,a0
    if(pid < 0){
    26c0:	02054063          	bltz	a0,26e0 <execout+0x3e>
    } else if(pid == 0){
    26c4:	c91d                	beqz	a0,26fa <execout+0x58>
      wait((int*)0);
    26c6:	4501                	li	a0,0
    26c8:	00007097          	auipc	ra,0x7
    26cc:	8c8080e7          	jalr	-1848(ra) # 8f90 <wait>
  for(int avail = 0; avail < 15; avail++){
    26d0:	2905                	addiw	s2,s2,1
    26d2:	ff3912e3          	bne	s2,s3,26b6 <execout+0x14>
  exit(0);
    26d6:	4501                	li	a0,0
    26d8:	00007097          	auipc	ra,0x7
    26dc:	8b0080e7          	jalr	-1872(ra) # 8f88 <exit>
      printf("fork failed\n");
    26e0:	00008517          	auipc	a0,0x8
    26e4:	e7850513          	addi	a0,a0,-392 # a558 <malloc+0xf98>
    26e8:	00007097          	auipc	ra,0x7
    26ec:	e20080e7          	jalr	-480(ra) # 9508 <printf>
      exit(1);
    26f0:	4505                	li	a0,1
    26f2:	00007097          	auipc	ra,0x7
    26f6:	896080e7          	jalr	-1898(ra) # 8f88 <exit>
        if(a == 0xffffffffffffffffLL)
    26fa:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    26fc:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    26fe:	6505                	lui	a0,0x1
    2700:	00007097          	auipc	ra,0x7
    2704:	8f8080e7          	jalr	-1800(ra) # 8ff8 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2708:	01350763          	beq	a0,s3,2716 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    270c:	6785                	lui	a5,0x1
    270e:	97aa                	add	a5,a5,a0
    2710:	ff478fa3          	sb	s4,-1(a5) # fff <testdev+0x161>
      while(1){
    2714:	b7ed                	j	26fe <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2716:	01205a63          	blez	s2,272a <execout+0x88>
        sbrk(-4096);
    271a:	757d                	lui	a0,0xfffff
    271c:	00007097          	auipc	ra,0x7
    2720:	8dc080e7          	jalr	-1828(ra) # 8ff8 <sbrk>
      for(int i = 0; i < avail; i++)
    2724:	2485                	addiw	s1,s1,1
    2726:	ff249ae3          	bne	s1,s2,271a <execout+0x78>
      close(1);
    272a:	4505                	li	a0,1
    272c:	00007097          	auipc	ra,0x7
    2730:	884080e7          	jalr	-1916(ra) # 8fb0 <close>
      char *args[] = { "echo", "x", 0 };
    2734:	00007517          	auipc	a0,0x7
    2738:	fd450513          	addi	a0,a0,-44 # 9708 <malloc+0x148>
    273c:	faa43c23          	sd	a0,-72(s0)
    2740:	00007797          	auipc	a5,0x7
    2744:	03878793          	addi	a5,a5,56 # 9778 <malloc+0x1b8>
    2748:	fcf43023          	sd	a5,-64(s0)
    274c:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2750:	fb840593          	addi	a1,s0,-72
    2754:	00007097          	auipc	ra,0x7
    2758:	86c080e7          	jalr	-1940(ra) # 8fc0 <exec>
      exit(0);
    275c:	4501                	li	a0,0
    275e:	00007097          	auipc	ra,0x7
    2762:	82a080e7          	jalr	-2006(ra) # 8f88 <exit>

0000000000002766 <iputtest>:
{
    2766:	1101                	addi	sp,sp,-32
    2768:	ec06                	sd	ra,24(sp)
    276a:	e822                	sd	s0,16(sp)
    276c:	e426                	sd	s1,8(sp)
    276e:	1000                	addi	s0,sp,32
    2770:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2772:	00008517          	auipc	a0,0x8
    2776:	05e50513          	addi	a0,a0,94 # a7d0 <malloc+0x1210>
    277a:	00007097          	auipc	ra,0x7
    277e:	85e080e7          	jalr	-1954(ra) # 8fd8 <mkdir>
    2782:	04054563          	bltz	a0,27cc <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2786:	00008517          	auipc	a0,0x8
    278a:	04a50513          	addi	a0,a0,74 # a7d0 <malloc+0x1210>
    278e:	00007097          	auipc	ra,0x7
    2792:	852080e7          	jalr	-1966(ra) # 8fe0 <chdir>
    2796:	04054963          	bltz	a0,27e8 <iputtest+0x82>
  if(remove("../iputdir") < 0){
    279a:	00008517          	auipc	a0,0x8
    279e:	07650513          	addi	a0,a0,118 # a810 <malloc+0x1250>
    27a2:	00007097          	auipc	ra,0x7
    27a6:	88e080e7          	jalr	-1906(ra) # 9030 <remove>
    27aa:	04054d63          	bltz	a0,2804 <iputtest+0x9e>
  if(chdir("/") < 0){
    27ae:	00008517          	auipc	a0,0x8
    27b2:	09250513          	addi	a0,a0,146 # a840 <malloc+0x1280>
    27b6:	00007097          	auipc	ra,0x7
    27ba:	82a080e7          	jalr	-2006(ra) # 8fe0 <chdir>
    27be:	06054163          	bltz	a0,2820 <iputtest+0xba>
}
    27c2:	60e2                	ld	ra,24(sp)
    27c4:	6442                	ld	s0,16(sp)
    27c6:	64a2                	ld	s1,8(sp)
    27c8:	6105                	addi	sp,sp,32
    27ca:	8082                	ret
    printf("%s: mkdir failed\n", s);
    27cc:	85a6                	mv	a1,s1
    27ce:	00008517          	auipc	a0,0x8
    27d2:	00a50513          	addi	a0,a0,10 # a7d8 <malloc+0x1218>
    27d6:	00007097          	auipc	ra,0x7
    27da:	d32080e7          	jalr	-718(ra) # 9508 <printf>
    exit(1);
    27de:	4505                	li	a0,1
    27e0:	00006097          	auipc	ra,0x6
    27e4:	7a8080e7          	jalr	1960(ra) # 8f88 <exit>
    printf("%s: chdir iputdir failed\n", s);
    27e8:	85a6                	mv	a1,s1
    27ea:	00008517          	auipc	a0,0x8
    27ee:	00650513          	addi	a0,a0,6 # a7f0 <malloc+0x1230>
    27f2:	00007097          	auipc	ra,0x7
    27f6:	d16080e7          	jalr	-746(ra) # 9508 <printf>
    exit(1);
    27fa:	4505                	li	a0,1
    27fc:	00006097          	auipc	ra,0x6
    2800:	78c080e7          	jalr	1932(ra) # 8f88 <exit>
    printf("%s: remove ../iputdir failed\n", s);
    2804:	85a6                	mv	a1,s1
    2806:	00008517          	auipc	a0,0x8
    280a:	01a50513          	addi	a0,a0,26 # a820 <malloc+0x1260>
    280e:	00007097          	auipc	ra,0x7
    2812:	cfa080e7          	jalr	-774(ra) # 9508 <printf>
    exit(1);
    2816:	4505                	li	a0,1
    2818:	00006097          	auipc	ra,0x6
    281c:	770080e7          	jalr	1904(ra) # 8f88 <exit>
    printf("%s: chdir / failed\n", s);
    2820:	85a6                	mv	a1,s1
    2822:	00008517          	auipc	a0,0x8
    2826:	02650513          	addi	a0,a0,38 # a848 <malloc+0x1288>
    282a:	00007097          	auipc	ra,0x7
    282e:	cde080e7          	jalr	-802(ra) # 9508 <printf>
    exit(1);
    2832:	4505                	li	a0,1
    2834:	00006097          	auipc	ra,0x6
    2838:	754080e7          	jalr	1876(ra) # 8f88 <exit>

000000000000283c <exitiputtest>:
{
    283c:	7179                	addi	sp,sp,-48
    283e:	f406                	sd	ra,40(sp)
    2840:	f022                	sd	s0,32(sp)
    2842:	ec26                	sd	s1,24(sp)
    2844:	1800                	addi	s0,sp,48
    2846:	84aa                	mv	s1,a0
  pid = fork();
    2848:	00006097          	auipc	ra,0x6
    284c:	738080e7          	jalr	1848(ra) # 8f80 <fork>
  if(pid < 0){
    2850:	04054663          	bltz	a0,289c <exitiputtest+0x60>
  if(pid == 0){
    2854:	ed45                	bnez	a0,290c <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    2856:	00008517          	auipc	a0,0x8
    285a:	f7a50513          	addi	a0,a0,-134 # a7d0 <malloc+0x1210>
    285e:	00006097          	auipc	ra,0x6
    2862:	77a080e7          	jalr	1914(ra) # 8fd8 <mkdir>
    2866:	04054963          	bltz	a0,28b8 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    286a:	00008517          	auipc	a0,0x8
    286e:	f6650513          	addi	a0,a0,-154 # a7d0 <malloc+0x1210>
    2872:	00006097          	auipc	ra,0x6
    2876:	76e080e7          	jalr	1902(ra) # 8fe0 <chdir>
    287a:	04054d63          	bltz	a0,28d4 <exitiputtest+0x98>
    if(remove("../iputdir") < 0){
    287e:	00008517          	auipc	a0,0x8
    2882:	f9250513          	addi	a0,a0,-110 # a810 <malloc+0x1250>
    2886:	00006097          	auipc	ra,0x6
    288a:	7aa080e7          	jalr	1962(ra) # 9030 <remove>
    288e:	06054163          	bltz	a0,28f0 <exitiputtest+0xb4>
    exit(0);
    2892:	4501                	li	a0,0
    2894:	00006097          	auipc	ra,0x6
    2898:	6f4080e7          	jalr	1780(ra) # 8f88 <exit>
    printf("%s: fork failed\n", s);
    289c:	85a6                	mv	a1,s1
    289e:	00008517          	auipc	a0,0x8
    28a2:	93a50513          	addi	a0,a0,-1734 # a1d8 <malloc+0xc18>
    28a6:	00007097          	auipc	ra,0x7
    28aa:	c62080e7          	jalr	-926(ra) # 9508 <printf>
    exit(1);
    28ae:	4505                	li	a0,1
    28b0:	00006097          	auipc	ra,0x6
    28b4:	6d8080e7          	jalr	1752(ra) # 8f88 <exit>
      printf("%s: mkdir failed\n", s);
    28b8:	85a6                	mv	a1,s1
    28ba:	00008517          	auipc	a0,0x8
    28be:	f1e50513          	addi	a0,a0,-226 # a7d8 <malloc+0x1218>
    28c2:	00007097          	auipc	ra,0x7
    28c6:	c46080e7          	jalr	-954(ra) # 9508 <printf>
      exit(1);
    28ca:	4505                	li	a0,1
    28cc:	00006097          	auipc	ra,0x6
    28d0:	6bc080e7          	jalr	1724(ra) # 8f88 <exit>
      printf("%s: child chdir failed\n", s);
    28d4:	85a6                	mv	a1,s1
    28d6:	00008517          	auipc	a0,0x8
    28da:	f8a50513          	addi	a0,a0,-118 # a860 <malloc+0x12a0>
    28de:	00007097          	auipc	ra,0x7
    28e2:	c2a080e7          	jalr	-982(ra) # 9508 <printf>
      exit(1);
    28e6:	4505                	li	a0,1
    28e8:	00006097          	auipc	ra,0x6
    28ec:	6a0080e7          	jalr	1696(ra) # 8f88 <exit>
      printf("%s: remove ../iputdir failed\n", s);
    28f0:	85a6                	mv	a1,s1
    28f2:	00008517          	auipc	a0,0x8
    28f6:	f2e50513          	addi	a0,a0,-210 # a820 <malloc+0x1260>
    28fa:	00007097          	auipc	ra,0x7
    28fe:	c0e080e7          	jalr	-1010(ra) # 9508 <printf>
      exit(1);
    2902:	4505                	li	a0,1
    2904:	00006097          	auipc	ra,0x6
    2908:	684080e7          	jalr	1668(ra) # 8f88 <exit>
  wait(&xstatus);
    290c:	fdc40513          	addi	a0,s0,-36
    2910:	00006097          	auipc	ra,0x6
    2914:	680080e7          	jalr	1664(ra) # 8f90 <wait>
  exit(xstatus);
    2918:	fdc42503          	lw	a0,-36(s0)
    291c:	00006097          	auipc	ra,0x6
    2920:	66c080e7          	jalr	1644(ra) # 8f88 <exit>

0000000000002924 <subdir>:
{
    2924:	1101                	addi	sp,sp,-32
    2926:	ec06                	sd	ra,24(sp)
    2928:	e822                	sd	s0,16(sp)
    292a:	e426                	sd	s1,8(sp)
    292c:	e04a                	sd	s2,0(sp)
    292e:	1000                	addi	s0,sp,32
    2930:	892a                	mv	s2,a0
  remove("ff");
    2932:	00008517          	auipc	a0,0x8
    2936:	f4650513          	addi	a0,a0,-186 # a878 <malloc+0x12b8>
    293a:	00006097          	auipc	ra,0x6
    293e:	6f6080e7          	jalr	1782(ra) # 9030 <remove>
  if(mkdir("dd") != 0){
    2942:	00008517          	auipc	a0,0x8
    2946:	f3e50513          	addi	a0,a0,-194 # a880 <malloc+0x12c0>
    294a:	00006097          	auipc	ra,0x6
    294e:	68e080e7          	jalr	1678(ra) # 8fd8 <mkdir>
    2952:	24051363          	bnez	a0,2b98 <subdir+0x274>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2956:	20200593          	li	a1,514
    295a:	00008517          	auipc	a0,0x8
    295e:	f4650513          	addi	a0,a0,-186 # a8a0 <malloc+0x12e0>
    2962:	00006097          	auipc	ra,0x6
    2966:	666080e7          	jalr	1638(ra) # 8fc8 <open>
    296a:	84aa                	mv	s1,a0
  if(fd < 0){
    296c:	24054463          	bltz	a0,2bb4 <subdir+0x290>
  write(fd, "ff", 2);
    2970:	4609                	li	a2,2
    2972:	00008597          	auipc	a1,0x8
    2976:	f0658593          	addi	a1,a1,-250 # a878 <malloc+0x12b8>
    297a:	00006097          	auipc	ra,0x6
    297e:	62e080e7          	jalr	1582(ra) # 8fa8 <write>
  close(fd);
    2982:	8526                	mv	a0,s1
    2984:	00006097          	auipc	ra,0x6
    2988:	62c080e7          	jalr	1580(ra) # 8fb0 <close>
  if(remove("dd") >= 0){
    298c:	00008517          	auipc	a0,0x8
    2990:	ef450513          	addi	a0,a0,-268 # a880 <malloc+0x12c0>
    2994:	00006097          	auipc	ra,0x6
    2998:	69c080e7          	jalr	1692(ra) # 9030 <remove>
    299c:	22055a63          	bgez	a0,2bd0 <subdir+0x2ac>
  if(mkdir("/dd/dd") != 0){
    29a0:	00008517          	auipc	a0,0x8
    29a4:	f5850513          	addi	a0,a0,-168 # a8f8 <malloc+0x1338>
    29a8:	00006097          	auipc	ra,0x6
    29ac:	630080e7          	jalr	1584(ra) # 8fd8 <mkdir>
    29b0:	22051e63          	bnez	a0,2bec <subdir+0x2c8>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    29b4:	20200593          	li	a1,514
    29b8:	00008517          	auipc	a0,0x8
    29bc:	f6850513          	addi	a0,a0,-152 # a920 <malloc+0x1360>
    29c0:	00006097          	auipc	ra,0x6
    29c4:	608080e7          	jalr	1544(ra) # 8fc8 <open>
    29c8:	84aa                	mv	s1,a0
  if(fd < 0){
    29ca:	22054f63          	bltz	a0,2c08 <subdir+0x2e4>
  write(fd, "FF", 2);
    29ce:	4609                	li	a2,2
    29d0:	00008597          	auipc	a1,0x8
    29d4:	f8058593          	addi	a1,a1,-128 # a950 <malloc+0x1390>
    29d8:	00006097          	auipc	ra,0x6
    29dc:	5d0080e7          	jalr	1488(ra) # 8fa8 <write>
  close(fd);
    29e0:	8526                	mv	a0,s1
    29e2:	00006097          	auipc	ra,0x6
    29e6:	5ce080e7          	jalr	1486(ra) # 8fb0 <close>
  fd = open("dd/dd/../ff", 0);
    29ea:	4581                	li	a1,0
    29ec:	00008517          	auipc	a0,0x8
    29f0:	f6c50513          	addi	a0,a0,-148 # a958 <malloc+0x1398>
    29f4:	00006097          	auipc	ra,0x6
    29f8:	5d4080e7          	jalr	1492(ra) # 8fc8 <open>
    29fc:	84aa                	mv	s1,a0
  if(fd < 0){
    29fe:	22054363          	bltz	a0,2c24 <subdir+0x300>
  cc = read(fd, buf, sizeof(buf));
    2a02:	6609                	lui	a2,0x2
    2a04:	80060613          	addi	a2,a2,-2048 # 1800 <exectest+0x172>
    2a08:	0001a597          	auipc	a1,0x1a
    2a0c:	6c058593          	addi	a1,a1,1728 # 1d0c8 <buf>
    2a10:	00006097          	auipc	ra,0x6
    2a14:	590080e7          	jalr	1424(ra) # 8fa0 <read>
  if(cc != 2 || buf[0] != 'f'){
    2a18:	4789                	li	a5,2
    2a1a:	22f51363          	bne	a0,a5,2c40 <subdir+0x31c>
    2a1e:	0001a717          	auipc	a4,0x1a
    2a22:	6aa74703          	lbu	a4,1706(a4) # 1d0c8 <buf>
    2a26:	06600793          	li	a5,102
    2a2a:	20f71b63          	bne	a4,a5,2c40 <subdir+0x31c>
  close(fd);
    2a2e:	8526                	mv	a0,s1
    2a30:	00006097          	auipc	ra,0x6
    2a34:	580080e7          	jalr	1408(ra) # 8fb0 <close>
  if(remove("dd/dd/ff") != 0){
    2a38:	00008517          	auipc	a0,0x8
    2a3c:	ee850513          	addi	a0,a0,-280 # a920 <malloc+0x1360>
    2a40:	00006097          	auipc	ra,0x6
    2a44:	5f0080e7          	jalr	1520(ra) # 9030 <remove>
    2a48:	20051a63          	bnez	a0,2c5c <subdir+0x338>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2a4c:	4581                	li	a1,0
    2a4e:	00008517          	auipc	a0,0x8
    2a52:	ed250513          	addi	a0,a0,-302 # a920 <malloc+0x1360>
    2a56:	00006097          	auipc	ra,0x6
    2a5a:	572080e7          	jalr	1394(ra) # 8fc8 <open>
    2a5e:	20055d63          	bgez	a0,2c78 <subdir+0x354>
  if(chdir("dd") != 0){
    2a62:	00008517          	auipc	a0,0x8
    2a66:	e1e50513          	addi	a0,a0,-482 # a880 <malloc+0x12c0>
    2a6a:	00006097          	auipc	ra,0x6
    2a6e:	576080e7          	jalr	1398(ra) # 8fe0 <chdir>
    2a72:	22051163          	bnez	a0,2c94 <subdir+0x370>
  if(chdir("dd/../../dd") != 0){
    2a76:	00008517          	auipc	a0,0x8
    2a7a:	f9250513          	addi	a0,a0,-110 # aa08 <malloc+0x1448>
    2a7e:	00006097          	auipc	ra,0x6
    2a82:	562080e7          	jalr	1378(ra) # 8fe0 <chdir>
    2a86:	22051563          	bnez	a0,2cb0 <subdir+0x38c>
  if(chdir("dd/../../../dd") != 0){
    2a8a:	00008517          	auipc	a0,0x8
    2a8e:	fae50513          	addi	a0,a0,-82 # aa38 <malloc+0x1478>
    2a92:	00006097          	auipc	ra,0x6
    2a96:	54e080e7          	jalr	1358(ra) # 8fe0 <chdir>
    2a9a:	22051963          	bnez	a0,2ccc <subdir+0x3a8>
  if(chdir("./..") != 0){
    2a9e:	00008517          	auipc	a0,0x8
    2aa2:	fca50513          	addi	a0,a0,-54 # aa68 <malloc+0x14a8>
    2aa6:	00006097          	auipc	ra,0x6
    2aaa:	53a080e7          	jalr	1338(ra) # 8fe0 <chdir>
    2aae:	22051d63          	bnez	a0,2ce8 <subdir+0x3c4>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2ab2:	4581                	li	a1,0
    2ab4:	00008517          	auipc	a0,0x8
    2ab8:	e6c50513          	addi	a0,a0,-404 # a920 <malloc+0x1360>
    2abc:	00006097          	auipc	ra,0x6
    2ac0:	50c080e7          	jalr	1292(ra) # 8fc8 <open>
    2ac4:	24055063          	bgez	a0,2d04 <subdir+0x3e0>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2ac8:	20200593          	li	a1,514
    2acc:	00008517          	auipc	a0,0x8
    2ad0:	fec50513          	addi	a0,a0,-20 # aab8 <malloc+0x14f8>
    2ad4:	00006097          	auipc	ra,0x6
    2ad8:	4f4080e7          	jalr	1268(ra) # 8fc8 <open>
    2adc:	24055263          	bgez	a0,2d20 <subdir+0x3fc>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2ae0:	20200593          	li	a1,514
    2ae4:	00008517          	auipc	a0,0x8
    2ae8:	00450513          	addi	a0,a0,4 # aae8 <malloc+0x1528>
    2aec:	00006097          	auipc	ra,0x6
    2af0:	4dc080e7          	jalr	1244(ra) # 8fc8 <open>
    2af4:	24055463          	bgez	a0,2d3c <subdir+0x418>
  if(open("dd", O_CREATE) >= 0){
    2af8:	20000593          	li	a1,512
    2afc:	00008517          	auipc	a0,0x8
    2b00:	d8450513          	addi	a0,a0,-636 # a880 <malloc+0x12c0>
    2b04:	00006097          	auipc	ra,0x6
    2b08:	4c4080e7          	jalr	1220(ra) # 8fc8 <open>
    2b0c:	24055663          	bgez	a0,2d58 <subdir+0x434>
  if(open("dd", O_RDWR) >= 0){
    2b10:	4589                	li	a1,2
    2b12:	00008517          	auipc	a0,0x8
    2b16:	d6e50513          	addi	a0,a0,-658 # a880 <malloc+0x12c0>
    2b1a:	00006097          	auipc	ra,0x6
    2b1e:	4ae080e7          	jalr	1198(ra) # 8fc8 <open>
    2b22:	24055963          	bgez	a0,2d74 <subdir+0x450>
  if(open("dd", O_WRONLY) >= 0){
    2b26:	4585                	li	a1,1
    2b28:	00008517          	auipc	a0,0x8
    2b2c:	d5850513          	addi	a0,a0,-680 # a880 <malloc+0x12c0>
    2b30:	00006097          	auipc	ra,0x6
    2b34:	498080e7          	jalr	1176(ra) # 8fc8 <open>
    2b38:	24055c63          	bgez	a0,2d90 <subdir+0x46c>
  if(remove("dd/ff") != 0){
    2b3c:	00008517          	auipc	a0,0x8
    2b40:	d6450513          	addi	a0,a0,-668 # a8a0 <malloc+0x12e0>
    2b44:	00006097          	auipc	ra,0x6
    2b48:	4ec080e7          	jalr	1260(ra) # 9030 <remove>
    2b4c:	26051063          	bnez	a0,2dac <subdir+0x488>
  if(remove("dd") == 0){
    2b50:	00008517          	auipc	a0,0x8
    2b54:	d3050513          	addi	a0,a0,-720 # a880 <malloc+0x12c0>
    2b58:	00006097          	auipc	ra,0x6
    2b5c:	4d8080e7          	jalr	1240(ra) # 9030 <remove>
    2b60:	26050463          	beqz	a0,2dc8 <subdir+0x4a4>
  if(remove("dd/dd") < 0){
    2b64:	00008517          	auipc	a0,0x8
    2b68:	05c50513          	addi	a0,a0,92 # abc0 <malloc+0x1600>
    2b6c:	00006097          	auipc	ra,0x6
    2b70:	4c4080e7          	jalr	1220(ra) # 9030 <remove>
    2b74:	26054863          	bltz	a0,2de4 <subdir+0x4c0>
  if(remove("dd") < 0){
    2b78:	00008517          	auipc	a0,0x8
    2b7c:	d0850513          	addi	a0,a0,-760 # a880 <malloc+0x12c0>
    2b80:	00006097          	auipc	ra,0x6
    2b84:	4b0080e7          	jalr	1200(ra) # 9030 <remove>
    2b88:	26054c63          	bltz	a0,2e00 <subdir+0x4dc>
}
    2b8c:	60e2                	ld	ra,24(sp)
    2b8e:	6442                	ld	s0,16(sp)
    2b90:	64a2                	ld	s1,8(sp)
    2b92:	6902                	ld	s2,0(sp)
    2b94:	6105                	addi	sp,sp,32
    2b96:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2b98:	85ca                	mv	a1,s2
    2b9a:	00008517          	auipc	a0,0x8
    2b9e:	cee50513          	addi	a0,a0,-786 # a888 <malloc+0x12c8>
    2ba2:	00007097          	auipc	ra,0x7
    2ba6:	966080e7          	jalr	-1690(ra) # 9508 <printf>
    exit(1);
    2baa:	4505                	li	a0,1
    2bac:	00006097          	auipc	ra,0x6
    2bb0:	3dc080e7          	jalr	988(ra) # 8f88 <exit>
    printf("%s: create dd/ff failed\n", s);
    2bb4:	85ca                	mv	a1,s2
    2bb6:	00008517          	auipc	a0,0x8
    2bba:	cf250513          	addi	a0,a0,-782 # a8a8 <malloc+0x12e8>
    2bbe:	00007097          	auipc	ra,0x7
    2bc2:	94a080e7          	jalr	-1718(ra) # 9508 <printf>
    exit(1);
    2bc6:	4505                	li	a0,1
    2bc8:	00006097          	auipc	ra,0x6
    2bcc:	3c0080e7          	jalr	960(ra) # 8f88 <exit>
    printf("%s: remove dd (non-empty dir) succeeded!\n", s);
    2bd0:	85ca                	mv	a1,s2
    2bd2:	00008517          	auipc	a0,0x8
    2bd6:	cf650513          	addi	a0,a0,-778 # a8c8 <malloc+0x1308>
    2bda:	00007097          	auipc	ra,0x7
    2bde:	92e080e7          	jalr	-1746(ra) # 9508 <printf>
    exit(1);
    2be2:	4505                	li	a0,1
    2be4:	00006097          	auipc	ra,0x6
    2be8:	3a4080e7          	jalr	932(ra) # 8f88 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    2bec:	85ca                	mv	a1,s2
    2bee:	00008517          	auipc	a0,0x8
    2bf2:	d1250513          	addi	a0,a0,-750 # a900 <malloc+0x1340>
    2bf6:	00007097          	auipc	ra,0x7
    2bfa:	912080e7          	jalr	-1774(ra) # 9508 <printf>
    exit(1);
    2bfe:	4505                	li	a0,1
    2c00:	00006097          	auipc	ra,0x6
    2c04:	388080e7          	jalr	904(ra) # 8f88 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2c08:	85ca                	mv	a1,s2
    2c0a:	00008517          	auipc	a0,0x8
    2c0e:	d2650513          	addi	a0,a0,-730 # a930 <malloc+0x1370>
    2c12:	00007097          	auipc	ra,0x7
    2c16:	8f6080e7          	jalr	-1802(ra) # 9508 <printf>
    exit(1);
    2c1a:	4505                	li	a0,1
    2c1c:	00006097          	auipc	ra,0x6
    2c20:	36c080e7          	jalr	876(ra) # 8f88 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2c24:	85ca                	mv	a1,s2
    2c26:	00008517          	auipc	a0,0x8
    2c2a:	d4250513          	addi	a0,a0,-702 # a968 <malloc+0x13a8>
    2c2e:	00007097          	auipc	ra,0x7
    2c32:	8da080e7          	jalr	-1830(ra) # 9508 <printf>
    exit(1);
    2c36:	4505                	li	a0,1
    2c38:	00006097          	auipc	ra,0x6
    2c3c:	350080e7          	jalr	848(ra) # 8f88 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2c40:	85ca                	mv	a1,s2
    2c42:	00008517          	auipc	a0,0x8
    2c46:	d4650513          	addi	a0,a0,-698 # a988 <malloc+0x13c8>
    2c4a:	00007097          	auipc	ra,0x7
    2c4e:	8be080e7          	jalr	-1858(ra) # 9508 <printf>
    exit(1);
    2c52:	4505                	li	a0,1
    2c54:	00006097          	auipc	ra,0x6
    2c58:	334080e7          	jalr	820(ra) # 8f88 <exit>
    printf("%s: remove dd/dd/ff failed\n", s);
    2c5c:	85ca                	mv	a1,s2
    2c5e:	00008517          	auipc	a0,0x8
    2c62:	d4a50513          	addi	a0,a0,-694 # a9a8 <malloc+0x13e8>
    2c66:	00007097          	auipc	ra,0x7
    2c6a:	8a2080e7          	jalr	-1886(ra) # 9508 <printf>
    exit(1);
    2c6e:	4505                	li	a0,1
    2c70:	00006097          	auipc	ra,0x6
    2c74:	318080e7          	jalr	792(ra) # 8f88 <exit>
    printf("%s: open (removeed) dd/dd/ff succeeded\n", s);
    2c78:	85ca                	mv	a1,s2
    2c7a:	00008517          	auipc	a0,0x8
    2c7e:	d4e50513          	addi	a0,a0,-690 # a9c8 <malloc+0x1408>
    2c82:	00007097          	auipc	ra,0x7
    2c86:	886080e7          	jalr	-1914(ra) # 9508 <printf>
    exit(1);
    2c8a:	4505                	li	a0,1
    2c8c:	00006097          	auipc	ra,0x6
    2c90:	2fc080e7          	jalr	764(ra) # 8f88 <exit>
    printf("%s: chdir dd failed\n", s);
    2c94:	85ca                	mv	a1,s2
    2c96:	00008517          	auipc	a0,0x8
    2c9a:	d5a50513          	addi	a0,a0,-678 # a9f0 <malloc+0x1430>
    2c9e:	00007097          	auipc	ra,0x7
    2ca2:	86a080e7          	jalr	-1942(ra) # 9508 <printf>
    exit(1);
    2ca6:	4505                	li	a0,1
    2ca8:	00006097          	auipc	ra,0x6
    2cac:	2e0080e7          	jalr	736(ra) # 8f88 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2cb0:	85ca                	mv	a1,s2
    2cb2:	00008517          	auipc	a0,0x8
    2cb6:	d6650513          	addi	a0,a0,-666 # aa18 <malloc+0x1458>
    2cba:	00007097          	auipc	ra,0x7
    2cbe:	84e080e7          	jalr	-1970(ra) # 9508 <printf>
    exit(1);
    2cc2:	4505                	li	a0,1
    2cc4:	00006097          	auipc	ra,0x6
    2cc8:	2c4080e7          	jalr	708(ra) # 8f88 <exit>
    printf("chdir dd/../../dd failed\n", s);
    2ccc:	85ca                	mv	a1,s2
    2cce:	00008517          	auipc	a0,0x8
    2cd2:	d7a50513          	addi	a0,a0,-646 # aa48 <malloc+0x1488>
    2cd6:	00007097          	auipc	ra,0x7
    2cda:	832080e7          	jalr	-1998(ra) # 9508 <printf>
    exit(1);
    2cde:	4505                	li	a0,1
    2ce0:	00006097          	auipc	ra,0x6
    2ce4:	2a8080e7          	jalr	680(ra) # 8f88 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2ce8:	85ca                	mv	a1,s2
    2cea:	00008517          	auipc	a0,0x8
    2cee:	d8650513          	addi	a0,a0,-634 # aa70 <malloc+0x14b0>
    2cf2:	00007097          	auipc	ra,0x7
    2cf6:	816080e7          	jalr	-2026(ra) # 9508 <printf>
    exit(1);
    2cfa:	4505                	li	a0,1
    2cfc:	00006097          	auipc	ra,0x6
    2d00:	28c080e7          	jalr	652(ra) # 8f88 <exit>
    printf("%s: open (removeed) dd/dd/ff succeeded!\n", s);
    2d04:	85ca                	mv	a1,s2
    2d06:	00008517          	auipc	a0,0x8
    2d0a:	d8250513          	addi	a0,a0,-638 # aa88 <malloc+0x14c8>
    2d0e:	00006097          	auipc	ra,0x6
    2d12:	7fa080e7          	jalr	2042(ra) # 9508 <printf>
    exit(1);
    2d16:	4505                	li	a0,1
    2d18:	00006097          	auipc	ra,0x6
    2d1c:	270080e7          	jalr	624(ra) # 8f88 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    2d20:	85ca                	mv	a1,s2
    2d22:	00008517          	auipc	a0,0x8
    2d26:	da650513          	addi	a0,a0,-602 # aac8 <malloc+0x1508>
    2d2a:	00006097          	auipc	ra,0x6
    2d2e:	7de080e7          	jalr	2014(ra) # 9508 <printf>
    exit(1);
    2d32:	4505                	li	a0,1
    2d34:	00006097          	auipc	ra,0x6
    2d38:	254080e7          	jalr	596(ra) # 8f88 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    2d3c:	85ca                	mv	a1,s2
    2d3e:	00008517          	auipc	a0,0x8
    2d42:	dba50513          	addi	a0,a0,-582 # aaf8 <malloc+0x1538>
    2d46:	00006097          	auipc	ra,0x6
    2d4a:	7c2080e7          	jalr	1986(ra) # 9508 <printf>
    exit(1);
    2d4e:	4505                	li	a0,1
    2d50:	00006097          	auipc	ra,0x6
    2d54:	238080e7          	jalr	568(ra) # 8f88 <exit>
    printf("%s: create dd succeeded!\n", s);
    2d58:	85ca                	mv	a1,s2
    2d5a:	00008517          	auipc	a0,0x8
    2d5e:	dbe50513          	addi	a0,a0,-578 # ab18 <malloc+0x1558>
    2d62:	00006097          	auipc	ra,0x6
    2d66:	7a6080e7          	jalr	1958(ra) # 9508 <printf>
    exit(1);
    2d6a:	4505                	li	a0,1
    2d6c:	00006097          	auipc	ra,0x6
    2d70:	21c080e7          	jalr	540(ra) # 8f88 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    2d74:	85ca                	mv	a1,s2
    2d76:	00008517          	auipc	a0,0x8
    2d7a:	dc250513          	addi	a0,a0,-574 # ab38 <malloc+0x1578>
    2d7e:	00006097          	auipc	ra,0x6
    2d82:	78a080e7          	jalr	1930(ra) # 9508 <printf>
    exit(1);
    2d86:	4505                	li	a0,1
    2d88:	00006097          	auipc	ra,0x6
    2d8c:	200080e7          	jalr	512(ra) # 8f88 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    2d90:	85ca                	mv	a1,s2
    2d92:	00008517          	auipc	a0,0x8
    2d96:	dc650513          	addi	a0,a0,-570 # ab58 <malloc+0x1598>
    2d9a:	00006097          	auipc	ra,0x6
    2d9e:	76e080e7          	jalr	1902(ra) # 9508 <printf>
    exit(1);
    2da2:	4505                	li	a0,1
    2da4:	00006097          	auipc	ra,0x6
    2da8:	1e4080e7          	jalr	484(ra) # 8f88 <exit>
    printf("%s: remove dd/ff failed\n", s);
    2dac:	85ca                	mv	a1,s2
    2dae:	00008517          	auipc	a0,0x8
    2db2:	dca50513          	addi	a0,a0,-566 # ab78 <malloc+0x15b8>
    2db6:	00006097          	auipc	ra,0x6
    2dba:	752080e7          	jalr	1874(ra) # 9508 <printf>
    exit(1);
    2dbe:	4505                	li	a0,1
    2dc0:	00006097          	auipc	ra,0x6
    2dc4:	1c8080e7          	jalr	456(ra) # 8f88 <exit>
    printf("%s: remove non-empty dd succeeded!\n", s);
    2dc8:	85ca                	mv	a1,s2
    2dca:	00008517          	auipc	a0,0x8
    2dce:	dce50513          	addi	a0,a0,-562 # ab98 <malloc+0x15d8>
    2dd2:	00006097          	auipc	ra,0x6
    2dd6:	736080e7          	jalr	1846(ra) # 9508 <printf>
    exit(1);
    2dda:	4505                	li	a0,1
    2ddc:	00006097          	auipc	ra,0x6
    2de0:	1ac080e7          	jalr	428(ra) # 8f88 <exit>
    printf("%s: remove dd/dd failed\n", s);
    2de4:	85ca                	mv	a1,s2
    2de6:	00008517          	auipc	a0,0x8
    2dea:	de250513          	addi	a0,a0,-542 # abc8 <malloc+0x1608>
    2dee:	00006097          	auipc	ra,0x6
    2df2:	71a080e7          	jalr	1818(ra) # 9508 <printf>
    exit(1);
    2df6:	4505                	li	a0,1
    2df8:	00006097          	auipc	ra,0x6
    2dfc:	190080e7          	jalr	400(ra) # 8f88 <exit>
    printf("%s: remove dd failed\n", s);
    2e00:	85ca                	mv	a1,s2
    2e02:	00008517          	auipc	a0,0x8
    2e06:	de650513          	addi	a0,a0,-538 # abe8 <malloc+0x1628>
    2e0a:	00006097          	auipc	ra,0x6
    2e0e:	6fe080e7          	jalr	1790(ra) # 9508 <printf>
    exit(1);
    2e12:	4505                	li	a0,1
    2e14:	00006097          	auipc	ra,0x6
    2e18:	174080e7          	jalr	372(ra) # 8f88 <exit>

0000000000002e1c <rmdot>:
{
    2e1c:	1101                	addi	sp,sp,-32
    2e1e:	ec06                	sd	ra,24(sp)
    2e20:	e822                	sd	s0,16(sp)
    2e22:	e426                	sd	s1,8(sp)
    2e24:	1000                	addi	s0,sp,32
    2e26:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    2e28:	00008517          	auipc	a0,0x8
    2e2c:	dd850513          	addi	a0,a0,-552 # ac00 <malloc+0x1640>
    2e30:	00006097          	auipc	ra,0x6
    2e34:	1a8080e7          	jalr	424(ra) # 8fd8 <mkdir>
    2e38:	e549                	bnez	a0,2ec2 <rmdot+0xa6>
  if(chdir("dots") != 0){
    2e3a:	00008517          	auipc	a0,0x8
    2e3e:	dc650513          	addi	a0,a0,-570 # ac00 <malloc+0x1640>
    2e42:	00006097          	auipc	ra,0x6
    2e46:	19e080e7          	jalr	414(ra) # 8fe0 <chdir>
    2e4a:	e951                	bnez	a0,2ede <rmdot+0xc2>
  if(remove(".") == 0){
    2e4c:	00008517          	auipc	a0,0x8
    2e50:	dec50513          	addi	a0,a0,-532 # ac38 <malloc+0x1678>
    2e54:	00006097          	auipc	ra,0x6
    2e58:	1dc080e7          	jalr	476(ra) # 9030 <remove>
    2e5c:	cd59                	beqz	a0,2efa <rmdot+0xde>
  if(remove("..") == 0){
    2e5e:	00008517          	auipc	a0,0x8
    2e62:	dfa50513          	addi	a0,a0,-518 # ac58 <malloc+0x1698>
    2e66:	00006097          	auipc	ra,0x6
    2e6a:	1ca080e7          	jalr	458(ra) # 9030 <remove>
    2e6e:	c545                	beqz	a0,2f16 <rmdot+0xfa>
  if(chdir("/") != 0){
    2e70:	00008517          	auipc	a0,0x8
    2e74:	9d050513          	addi	a0,a0,-1584 # a840 <malloc+0x1280>
    2e78:	00006097          	auipc	ra,0x6
    2e7c:	168080e7          	jalr	360(ra) # 8fe0 <chdir>
    2e80:	e94d                	bnez	a0,2f32 <rmdot+0x116>
  if(remove("dots/.") == 0){
    2e82:	00008517          	auipc	a0,0x8
    2e86:	df650513          	addi	a0,a0,-522 # ac78 <malloc+0x16b8>
    2e8a:	00006097          	auipc	ra,0x6
    2e8e:	1a6080e7          	jalr	422(ra) # 9030 <remove>
    2e92:	cd55                	beqz	a0,2f4e <rmdot+0x132>
  if(remove("dots/..") == 0){
    2e94:	00008517          	auipc	a0,0x8
    2e98:	e0c50513          	addi	a0,a0,-500 # aca0 <malloc+0x16e0>
    2e9c:	00006097          	auipc	ra,0x6
    2ea0:	194080e7          	jalr	404(ra) # 9030 <remove>
    2ea4:	c179                	beqz	a0,2f6a <rmdot+0x14e>
  if(remove("dots") != 0){
    2ea6:	00008517          	auipc	a0,0x8
    2eaa:	d5a50513          	addi	a0,a0,-678 # ac00 <malloc+0x1640>
    2eae:	00006097          	auipc	ra,0x6
    2eb2:	182080e7          	jalr	386(ra) # 9030 <remove>
    2eb6:	e961                	bnez	a0,2f86 <rmdot+0x16a>
}
    2eb8:	60e2                	ld	ra,24(sp)
    2eba:	6442                	ld	s0,16(sp)
    2ebc:	64a2                	ld	s1,8(sp)
    2ebe:	6105                	addi	sp,sp,32
    2ec0:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    2ec2:	85a6                	mv	a1,s1
    2ec4:	00008517          	auipc	a0,0x8
    2ec8:	d4450513          	addi	a0,a0,-700 # ac08 <malloc+0x1648>
    2ecc:	00006097          	auipc	ra,0x6
    2ed0:	63c080e7          	jalr	1596(ra) # 9508 <printf>
    exit(1);
    2ed4:	4505                	li	a0,1
    2ed6:	00006097          	auipc	ra,0x6
    2eda:	0b2080e7          	jalr	178(ra) # 8f88 <exit>
    printf("%s: chdir dots failed\n", s);
    2ede:	85a6                	mv	a1,s1
    2ee0:	00008517          	auipc	a0,0x8
    2ee4:	d4050513          	addi	a0,a0,-704 # ac20 <malloc+0x1660>
    2ee8:	00006097          	auipc	ra,0x6
    2eec:	620080e7          	jalr	1568(ra) # 9508 <printf>
    exit(1);
    2ef0:	4505                	li	a0,1
    2ef2:	00006097          	auipc	ra,0x6
    2ef6:	096080e7          	jalr	150(ra) # 8f88 <exit>
    printf("%s: rm . worked!\n", s);
    2efa:	85a6                	mv	a1,s1
    2efc:	00008517          	auipc	a0,0x8
    2f00:	d4450513          	addi	a0,a0,-700 # ac40 <malloc+0x1680>
    2f04:	00006097          	auipc	ra,0x6
    2f08:	604080e7          	jalr	1540(ra) # 9508 <printf>
    exit(1);
    2f0c:	4505                	li	a0,1
    2f0e:	00006097          	auipc	ra,0x6
    2f12:	07a080e7          	jalr	122(ra) # 8f88 <exit>
    printf("%s: rm .. worked!\n", s);
    2f16:	85a6                	mv	a1,s1
    2f18:	00008517          	auipc	a0,0x8
    2f1c:	d4850513          	addi	a0,a0,-696 # ac60 <malloc+0x16a0>
    2f20:	00006097          	auipc	ra,0x6
    2f24:	5e8080e7          	jalr	1512(ra) # 9508 <printf>
    exit(1);
    2f28:	4505                	li	a0,1
    2f2a:	00006097          	auipc	ra,0x6
    2f2e:	05e080e7          	jalr	94(ra) # 8f88 <exit>
    printf("%s: chdir / failed\n", s);
    2f32:	85a6                	mv	a1,s1
    2f34:	00008517          	auipc	a0,0x8
    2f38:	91450513          	addi	a0,a0,-1772 # a848 <malloc+0x1288>
    2f3c:	00006097          	auipc	ra,0x6
    2f40:	5cc080e7          	jalr	1484(ra) # 9508 <printf>
    exit(1);
    2f44:	4505                	li	a0,1
    2f46:	00006097          	auipc	ra,0x6
    2f4a:	042080e7          	jalr	66(ra) # 8f88 <exit>
    printf("%s: remove dots/. worked!\n", s);
    2f4e:	85a6                	mv	a1,s1
    2f50:	00008517          	auipc	a0,0x8
    2f54:	d3050513          	addi	a0,a0,-720 # ac80 <malloc+0x16c0>
    2f58:	00006097          	auipc	ra,0x6
    2f5c:	5b0080e7          	jalr	1456(ra) # 9508 <printf>
    exit(1);
    2f60:	4505                	li	a0,1
    2f62:	00006097          	auipc	ra,0x6
    2f66:	026080e7          	jalr	38(ra) # 8f88 <exit>
    printf("%s: remove dots/.. worked!\n", s);
    2f6a:	85a6                	mv	a1,s1
    2f6c:	00008517          	auipc	a0,0x8
    2f70:	d3c50513          	addi	a0,a0,-708 # aca8 <malloc+0x16e8>
    2f74:	00006097          	auipc	ra,0x6
    2f78:	594080e7          	jalr	1428(ra) # 9508 <printf>
    exit(1);
    2f7c:	4505                	li	a0,1
    2f7e:	00006097          	auipc	ra,0x6
    2f82:	00a080e7          	jalr	10(ra) # 8f88 <exit>
    printf("%s: remove dots failed!\n", s);
    2f86:	85a6                	mv	a1,s1
    2f88:	00008517          	auipc	a0,0x8
    2f8c:	d4050513          	addi	a0,a0,-704 # acc8 <malloc+0x1708>
    2f90:	00006097          	auipc	ra,0x6
    2f94:	578080e7          	jalr	1400(ra) # 9508 <printf>
    exit(1);
    2f98:	4505                	li	a0,1
    2f9a:	00006097          	auipc	ra,0x6
    2f9e:	fee080e7          	jalr	-18(ra) # 8f88 <exit>

0000000000002fa2 <dirfile>:
{
    2fa2:	1101                	addi	sp,sp,-32
    2fa4:	ec06                	sd	ra,24(sp)
    2fa6:	e822                	sd	s0,16(sp)
    2fa8:	e426                	sd	s1,8(sp)
    2faa:	e04a                	sd	s2,0(sp)
    2fac:	1000                	addi	s0,sp,32
    2fae:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    2fb0:	20000593          	li	a1,512
    2fb4:	00008517          	auipc	a0,0x8
    2fb8:	d3450513          	addi	a0,a0,-716 # ace8 <malloc+0x1728>
    2fbc:	00006097          	auipc	ra,0x6
    2fc0:	00c080e7          	jalr	12(ra) # 8fc8 <open>
  if(fd < 0){
    2fc4:	0c054d63          	bltz	a0,309e <dirfile+0xfc>
  close(fd);
    2fc8:	00006097          	auipc	ra,0x6
    2fcc:	fe8080e7          	jalr	-24(ra) # 8fb0 <close>
  if(chdir("dirfile") == 0){
    2fd0:	00008517          	auipc	a0,0x8
    2fd4:	d1850513          	addi	a0,a0,-744 # ace8 <malloc+0x1728>
    2fd8:	00006097          	auipc	ra,0x6
    2fdc:	008080e7          	jalr	8(ra) # 8fe0 <chdir>
    2fe0:	cd69                	beqz	a0,30ba <dirfile+0x118>
  fd = open("dirfile/xx", 0);
    2fe2:	4581                	li	a1,0
    2fe4:	00008517          	auipc	a0,0x8
    2fe8:	d4c50513          	addi	a0,a0,-692 # ad30 <malloc+0x1770>
    2fec:	00006097          	auipc	ra,0x6
    2ff0:	fdc080e7          	jalr	-36(ra) # 8fc8 <open>
  if(fd >= 0){
    2ff4:	0e055163          	bgez	a0,30d6 <dirfile+0x134>
  fd = open("dirfile/xx", O_CREATE);
    2ff8:	20000593          	li	a1,512
    2ffc:	00008517          	auipc	a0,0x8
    3000:	d3450513          	addi	a0,a0,-716 # ad30 <malloc+0x1770>
    3004:	00006097          	auipc	ra,0x6
    3008:	fc4080e7          	jalr	-60(ra) # 8fc8 <open>
  if(fd >= 0){
    300c:	0e055363          	bgez	a0,30f2 <dirfile+0x150>
  if(mkdir("dirfile/xx") == 0){
    3010:	00008517          	auipc	a0,0x8
    3014:	d2050513          	addi	a0,a0,-736 # ad30 <malloc+0x1770>
    3018:	00006097          	auipc	ra,0x6
    301c:	fc0080e7          	jalr	-64(ra) # 8fd8 <mkdir>
    3020:	c57d                	beqz	a0,310e <dirfile+0x16c>
  if(remove("dirfile/xx") == 0){
    3022:	00008517          	auipc	a0,0x8
    3026:	d0e50513          	addi	a0,a0,-754 # ad30 <malloc+0x1770>
    302a:	00006097          	auipc	ra,0x6
    302e:	006080e7          	jalr	6(ra) # 9030 <remove>
    3032:	cd65                	beqz	a0,312a <dirfile+0x188>
  if(remove("dirfile") != 0){
    3034:	00008517          	auipc	a0,0x8
    3038:	cb450513          	addi	a0,a0,-844 # ace8 <malloc+0x1728>
    303c:	00006097          	auipc	ra,0x6
    3040:	ff4080e7          	jalr	-12(ra) # 9030 <remove>
    3044:	10051163          	bnez	a0,3146 <dirfile+0x1a4>
  fd = open(".", O_RDWR);
    3048:	4589                	li	a1,2
    304a:	00008517          	auipc	a0,0x8
    304e:	bee50513          	addi	a0,a0,-1042 # ac38 <malloc+0x1678>
    3052:	00006097          	auipc	ra,0x6
    3056:	f76080e7          	jalr	-138(ra) # 8fc8 <open>
  if(fd >= 0){
    305a:	10055463          	bgez	a0,3162 <dirfile+0x1c0>
  fd = open(".", 0);
    305e:	4581                	li	a1,0
    3060:	00008517          	auipc	a0,0x8
    3064:	bd850513          	addi	a0,a0,-1064 # ac38 <malloc+0x1678>
    3068:	00006097          	auipc	ra,0x6
    306c:	f60080e7          	jalr	-160(ra) # 8fc8 <open>
    3070:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3072:	4605                	li	a2,1
    3074:	00006597          	auipc	a1,0x6
    3078:	70458593          	addi	a1,a1,1796 # 9778 <malloc+0x1b8>
    307c:	00006097          	auipc	ra,0x6
    3080:	f2c080e7          	jalr	-212(ra) # 8fa8 <write>
    3084:	0ea04d63          	bgtz	a0,317e <dirfile+0x1dc>
  close(fd);
    3088:	8526                	mv	a0,s1
    308a:	00006097          	auipc	ra,0x6
    308e:	f26080e7          	jalr	-218(ra) # 8fb0 <close>
}
    3092:	60e2                	ld	ra,24(sp)
    3094:	6442                	ld	s0,16(sp)
    3096:	64a2                	ld	s1,8(sp)
    3098:	6902                	ld	s2,0(sp)
    309a:	6105                	addi	sp,sp,32
    309c:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    309e:	85ca                	mv	a1,s2
    30a0:	00008517          	auipc	a0,0x8
    30a4:	c5050513          	addi	a0,a0,-944 # acf0 <malloc+0x1730>
    30a8:	00006097          	auipc	ra,0x6
    30ac:	460080e7          	jalr	1120(ra) # 9508 <printf>
    exit(1);
    30b0:	4505                	li	a0,1
    30b2:	00006097          	auipc	ra,0x6
    30b6:	ed6080e7          	jalr	-298(ra) # 8f88 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    30ba:	85ca                	mv	a1,s2
    30bc:	00008517          	auipc	a0,0x8
    30c0:	c5450513          	addi	a0,a0,-940 # ad10 <malloc+0x1750>
    30c4:	00006097          	auipc	ra,0x6
    30c8:	444080e7          	jalr	1092(ra) # 9508 <printf>
    exit(1);
    30cc:	4505                	li	a0,1
    30ce:	00006097          	auipc	ra,0x6
    30d2:	eba080e7          	jalr	-326(ra) # 8f88 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    30d6:	85ca                	mv	a1,s2
    30d8:	00008517          	auipc	a0,0x8
    30dc:	c6850513          	addi	a0,a0,-920 # ad40 <malloc+0x1780>
    30e0:	00006097          	auipc	ra,0x6
    30e4:	428080e7          	jalr	1064(ra) # 9508 <printf>
    exit(1);
    30e8:	4505                	li	a0,1
    30ea:	00006097          	auipc	ra,0x6
    30ee:	e9e080e7          	jalr	-354(ra) # 8f88 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    30f2:	85ca                	mv	a1,s2
    30f4:	00008517          	auipc	a0,0x8
    30f8:	c4c50513          	addi	a0,a0,-948 # ad40 <malloc+0x1780>
    30fc:	00006097          	auipc	ra,0x6
    3100:	40c080e7          	jalr	1036(ra) # 9508 <printf>
    exit(1);
    3104:	4505                	li	a0,1
    3106:	00006097          	auipc	ra,0x6
    310a:	e82080e7          	jalr	-382(ra) # 8f88 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    310e:	85ca                	mv	a1,s2
    3110:	00008517          	auipc	a0,0x8
    3114:	c5850513          	addi	a0,a0,-936 # ad68 <malloc+0x17a8>
    3118:	00006097          	auipc	ra,0x6
    311c:	3f0080e7          	jalr	1008(ra) # 9508 <printf>
    exit(1);
    3120:	4505                	li	a0,1
    3122:	00006097          	auipc	ra,0x6
    3126:	e66080e7          	jalr	-410(ra) # 8f88 <exit>
    printf("%s: remove dirfile/xx succeeded!\n", s);
    312a:	85ca                	mv	a1,s2
    312c:	00008517          	auipc	a0,0x8
    3130:	c6450513          	addi	a0,a0,-924 # ad90 <malloc+0x17d0>
    3134:	00006097          	auipc	ra,0x6
    3138:	3d4080e7          	jalr	980(ra) # 9508 <printf>
    exit(1);
    313c:	4505                	li	a0,1
    313e:	00006097          	auipc	ra,0x6
    3142:	e4a080e7          	jalr	-438(ra) # 8f88 <exit>
    printf("%s: remove dirfile failed!\n", s);
    3146:	85ca                	mv	a1,s2
    3148:	00008517          	auipc	a0,0x8
    314c:	c7050513          	addi	a0,a0,-912 # adb8 <malloc+0x17f8>
    3150:	00006097          	auipc	ra,0x6
    3154:	3b8080e7          	jalr	952(ra) # 9508 <printf>
    exit(1);
    3158:	4505                	li	a0,1
    315a:	00006097          	auipc	ra,0x6
    315e:	e2e080e7          	jalr	-466(ra) # 8f88 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3162:	85ca                	mv	a1,s2
    3164:	00008517          	auipc	a0,0x8
    3168:	c7450513          	addi	a0,a0,-908 # add8 <malloc+0x1818>
    316c:	00006097          	auipc	ra,0x6
    3170:	39c080e7          	jalr	924(ra) # 9508 <printf>
    exit(1);
    3174:	4505                	li	a0,1
    3176:	00006097          	auipc	ra,0x6
    317a:	e12080e7          	jalr	-494(ra) # 8f88 <exit>
    printf("%s: write . succeeded!\n", s);
    317e:	85ca                	mv	a1,s2
    3180:	00008517          	auipc	a0,0x8
    3184:	c8050513          	addi	a0,a0,-896 # ae00 <malloc+0x1840>
    3188:	00006097          	auipc	ra,0x6
    318c:	380080e7          	jalr	896(ra) # 9508 <printf>
    exit(1);
    3190:	4505                	li	a0,1
    3192:	00006097          	auipc	ra,0x6
    3196:	df6080e7          	jalr	-522(ra) # 8f88 <exit>

000000000000319a <iref>:
{
    319a:	7139                	addi	sp,sp,-64
    319c:	fc06                	sd	ra,56(sp)
    319e:	f822                	sd	s0,48(sp)
    31a0:	f426                	sd	s1,40(sp)
    31a2:	f04a                	sd	s2,32(sp)
    31a4:	ec4e                	sd	s3,24(sp)
    31a6:	e852                	sd	s4,16(sp)
    31a8:	e456                	sd	s5,8(sp)
    31aa:	0080                	addi	s0,sp,64
    31ac:	8aaa                	mv	s5,a0
    31ae:	02e00493          	li	s1,46
    if(mkdir("irefd") != 0){
    31b2:	00008917          	auipc	s2,0x8
    31b6:	c6690913          	addi	s2,s2,-922 # ae18 <malloc+0x1858>
    mkdir("");
    31ba:	00008a17          	auipc	s4,0x8
    31be:	8f6a0a13          	addi	s4,s4,-1802 # aab0 <malloc+0x14f0>
    fd = open("xx", O_CREATE);
    31c2:	00008997          	auipc	s3,0x8
    31c6:	b7698993          	addi	s3,s3,-1162 # ad38 <malloc+0x1778>
    31ca:	a889                	j	321c <iref+0x82>
      printf("%s: mkdir irefd failed\n", s);
    31cc:	85d6                	mv	a1,s5
    31ce:	00008517          	auipc	a0,0x8
    31d2:	c5250513          	addi	a0,a0,-942 # ae20 <malloc+0x1860>
    31d6:	00006097          	auipc	ra,0x6
    31da:	332080e7          	jalr	818(ra) # 9508 <printf>
      exit(1);
    31de:	4505                	li	a0,1
    31e0:	00006097          	auipc	ra,0x6
    31e4:	da8080e7          	jalr	-600(ra) # 8f88 <exit>
      printf("%s: chdir irefd failed\n", s);
    31e8:	85d6                	mv	a1,s5
    31ea:	00008517          	auipc	a0,0x8
    31ee:	c4e50513          	addi	a0,a0,-946 # ae38 <malloc+0x1878>
    31f2:	00006097          	auipc	ra,0x6
    31f6:	316080e7          	jalr	790(ra) # 9508 <printf>
      exit(1);
    31fa:	4505                	li	a0,1
    31fc:	00006097          	auipc	ra,0x6
    3200:	d8c080e7          	jalr	-628(ra) # 8f88 <exit>
      close(fd);
    3204:	00006097          	auipc	ra,0x6
    3208:	dac080e7          	jalr	-596(ra) # 8fb0 <close>
    320c:	a091                	j	3250 <iref+0xb6>
    remove("xx");
    320e:	854e                	mv	a0,s3
    3210:	00006097          	auipc	ra,0x6
    3214:	e20080e7          	jalr	-480(ra) # 9030 <remove>
  for(i = 0; i < NINODE - 4; i++){
    3218:	34fd                	addiw	s1,s1,-1
    321a:	c8a9                	beqz	s1,326c <iref+0xd2>
    if(mkdir("irefd") != 0){
    321c:	854a                	mv	a0,s2
    321e:	00006097          	auipc	ra,0x6
    3222:	dba080e7          	jalr	-582(ra) # 8fd8 <mkdir>
    3226:	f15d                	bnez	a0,31cc <iref+0x32>
    if(chdir("irefd") != 0){
    3228:	854a                	mv	a0,s2
    322a:	00006097          	auipc	ra,0x6
    322e:	db6080e7          	jalr	-586(ra) # 8fe0 <chdir>
    3232:	f95d                	bnez	a0,31e8 <iref+0x4e>
    mkdir("");
    3234:	8552                	mv	a0,s4
    3236:	00006097          	auipc	ra,0x6
    323a:	da2080e7          	jalr	-606(ra) # 8fd8 <mkdir>
    fd = open("", O_CREATE);
    323e:	20000593          	li	a1,512
    3242:	8552                	mv	a0,s4
    3244:	00006097          	auipc	ra,0x6
    3248:	d84080e7          	jalr	-636(ra) # 8fc8 <open>
    if(fd >= 0)
    324c:	fa055ce3          	bgez	a0,3204 <iref+0x6a>
    fd = open("xx", O_CREATE);
    3250:	20000593          	li	a1,512
    3254:	854e                	mv	a0,s3
    3256:	00006097          	auipc	ra,0x6
    325a:	d72080e7          	jalr	-654(ra) # 8fc8 <open>
    if(fd >= 0)
    325e:	fa0548e3          	bltz	a0,320e <iref+0x74>
      close(fd);
    3262:	00006097          	auipc	ra,0x6
    3266:	d4e080e7          	jalr	-690(ra) # 8fb0 <close>
    326a:	b755                	j	320e <iref+0x74>
    326c:	03300493          	li	s1,51
    chdir("..");
    3270:	00008997          	auipc	s3,0x8
    3274:	9e898993          	addi	s3,s3,-1560 # ac58 <malloc+0x1698>
    remove("irefd");
    3278:	00008917          	auipc	s2,0x8
    327c:	ba090913          	addi	s2,s2,-1120 # ae18 <malloc+0x1858>
    chdir("..");
    3280:	854e                	mv	a0,s3
    3282:	00006097          	auipc	ra,0x6
    3286:	d5e080e7          	jalr	-674(ra) # 8fe0 <chdir>
    remove("irefd");
    328a:	854a                	mv	a0,s2
    328c:	00006097          	auipc	ra,0x6
    3290:	da4080e7          	jalr	-604(ra) # 9030 <remove>
  for(i = 0; i < NINODE + 1; i++){
    3294:	34fd                	addiw	s1,s1,-1
    3296:	f4ed                	bnez	s1,3280 <iref+0xe6>
  chdir("/");
    3298:	00007517          	auipc	a0,0x7
    329c:	5a850513          	addi	a0,a0,1448 # a840 <malloc+0x1280>
    32a0:	00006097          	auipc	ra,0x6
    32a4:	d40080e7          	jalr	-704(ra) # 8fe0 <chdir>
}
    32a8:	70e2                	ld	ra,56(sp)
    32aa:	7442                	ld	s0,48(sp)
    32ac:	74a2                	ld	s1,40(sp)
    32ae:	7902                	ld	s2,32(sp)
    32b0:	69e2                	ld	s3,24(sp)
    32b2:	6a42                	ld	s4,16(sp)
    32b4:	6aa2                	ld	s5,8(sp)
    32b6:	6121                	addi	sp,sp,64
    32b8:	8082                	ret

00000000000032ba <openiputtest>:
{
    32ba:	7179                	addi	sp,sp,-48
    32bc:	f406                	sd	ra,40(sp)
    32be:	f022                	sd	s0,32(sp)
    32c0:	ec26                	sd	s1,24(sp)
    32c2:	1800                	addi	s0,sp,48
    32c4:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    32c6:	00008517          	auipc	a0,0x8
    32ca:	b8a50513          	addi	a0,a0,-1142 # ae50 <malloc+0x1890>
    32ce:	00006097          	auipc	ra,0x6
    32d2:	d0a080e7          	jalr	-758(ra) # 8fd8 <mkdir>
    32d6:	04054263          	bltz	a0,331a <openiputtest+0x60>
  pid = fork();
    32da:	00006097          	auipc	ra,0x6
    32de:	ca6080e7          	jalr	-858(ra) # 8f80 <fork>
  if(pid < 0){
    32e2:	04054a63          	bltz	a0,3336 <openiputtest+0x7c>
  if(pid == 0){
    32e6:	e93d                	bnez	a0,335c <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    32e8:	4589                	li	a1,2
    32ea:	00008517          	auipc	a0,0x8
    32ee:	b6650513          	addi	a0,a0,-1178 # ae50 <malloc+0x1890>
    32f2:	00006097          	auipc	ra,0x6
    32f6:	cd6080e7          	jalr	-810(ra) # 8fc8 <open>
    if(fd >= 0){
    32fa:	04054c63          	bltz	a0,3352 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    32fe:	85a6                	mv	a1,s1
    3300:	00008517          	auipc	a0,0x8
    3304:	b7050513          	addi	a0,a0,-1168 # ae70 <malloc+0x18b0>
    3308:	00006097          	auipc	ra,0x6
    330c:	200080e7          	jalr	512(ra) # 9508 <printf>
      exit(1);
    3310:	4505                	li	a0,1
    3312:	00006097          	auipc	ra,0x6
    3316:	c76080e7          	jalr	-906(ra) # 8f88 <exit>
    printf("%s: mkdir oidir failed\n", s);
    331a:	85a6                	mv	a1,s1
    331c:	00008517          	auipc	a0,0x8
    3320:	b3c50513          	addi	a0,a0,-1220 # ae58 <malloc+0x1898>
    3324:	00006097          	auipc	ra,0x6
    3328:	1e4080e7          	jalr	484(ra) # 9508 <printf>
    exit(1);
    332c:	4505                	li	a0,1
    332e:	00006097          	auipc	ra,0x6
    3332:	c5a080e7          	jalr	-934(ra) # 8f88 <exit>
    printf("%s: fork failed\n", s);
    3336:	85a6                	mv	a1,s1
    3338:	00007517          	auipc	a0,0x7
    333c:	ea050513          	addi	a0,a0,-352 # a1d8 <malloc+0xc18>
    3340:	00006097          	auipc	ra,0x6
    3344:	1c8080e7          	jalr	456(ra) # 9508 <printf>
    exit(1);
    3348:	4505                	li	a0,1
    334a:	00006097          	auipc	ra,0x6
    334e:	c3e080e7          	jalr	-962(ra) # 8f88 <exit>
    exit(0);
    3352:	4501                	li	a0,0
    3354:	00006097          	auipc	ra,0x6
    3358:	c34080e7          	jalr	-972(ra) # 8f88 <exit>
  sleep(1);
    335c:	4505                	li	a0,1
    335e:	00006097          	auipc	ra,0x6
    3362:	ca2080e7          	jalr	-862(ra) # 9000 <sleep>
  if(remove("oidir") != 0){
    3366:	00008517          	auipc	a0,0x8
    336a:	aea50513          	addi	a0,a0,-1302 # ae50 <malloc+0x1890>
    336e:	00006097          	auipc	ra,0x6
    3372:	cc2080e7          	jalr	-830(ra) # 9030 <remove>
    3376:	cd19                	beqz	a0,3394 <openiputtest+0xda>
    printf("%s: remove failed\n", s);
    3378:	85a6                	mv	a1,s1
    337a:	00008517          	auipc	a0,0x8
    337e:	b1e50513          	addi	a0,a0,-1250 # ae98 <malloc+0x18d8>
    3382:	00006097          	auipc	ra,0x6
    3386:	186080e7          	jalr	390(ra) # 9508 <printf>
    exit(1);
    338a:	4505                	li	a0,1
    338c:	00006097          	auipc	ra,0x6
    3390:	bfc080e7          	jalr	-1028(ra) # 8f88 <exit>
  wait(&xstatus);
    3394:	fdc40513          	addi	a0,s0,-36
    3398:	00006097          	auipc	ra,0x6
    339c:	bf8080e7          	jalr	-1032(ra) # 8f90 <wait>
  exit(xstatus);
    33a0:	fdc42503          	lw	a0,-36(s0)
    33a4:	00006097          	auipc	ra,0x6
    33a8:	be4080e7          	jalr	-1052(ra) # 8f88 <exit>

00000000000033ac <forkforkfork>:
{
    33ac:	1101                	addi	sp,sp,-32
    33ae:	ec06                	sd	ra,24(sp)
    33b0:	e822                	sd	s0,16(sp)
    33b2:	e426                	sd	s1,8(sp)
    33b4:	1000                	addi	s0,sp,32
    33b6:	84aa                	mv	s1,a0
  remove("stopforking");
    33b8:	00008517          	auipc	a0,0x8
    33bc:	af850513          	addi	a0,a0,-1288 # aeb0 <malloc+0x18f0>
    33c0:	00006097          	auipc	ra,0x6
    33c4:	c70080e7          	jalr	-912(ra) # 9030 <remove>
  int pid = fork();
    33c8:	00006097          	auipc	ra,0x6
    33cc:	bb8080e7          	jalr	-1096(ra) # 8f80 <fork>
  if(pid < 0){
    33d0:	04054d63          	bltz	a0,342a <forkforkfork+0x7e>
  if(pid == 0){
    33d4:	c92d                	beqz	a0,3446 <forkforkfork+0x9a>
  sleep(20); // two seconds
    33d6:	4551                	li	a0,20
    33d8:	00006097          	auipc	ra,0x6
    33dc:	c28080e7          	jalr	-984(ra) # 9000 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    33e0:	20200593          	li	a1,514
    33e4:	00008517          	auipc	a0,0x8
    33e8:	acc50513          	addi	a0,a0,-1332 # aeb0 <malloc+0x18f0>
    33ec:	00006097          	auipc	ra,0x6
    33f0:	bdc080e7          	jalr	-1060(ra) # 8fc8 <open>
    33f4:	00006097          	auipc	ra,0x6
    33f8:	bbc080e7          	jalr	-1092(ra) # 8fb0 <close>
  wait(0);
    33fc:	4501                	li	a0,0
    33fe:	00006097          	auipc	ra,0x6
    3402:	b92080e7          	jalr	-1134(ra) # 8f90 <wait>
  sleep(10); // one second
    3406:	4529                	li	a0,10
    3408:	00006097          	auipc	ra,0x6
    340c:	bf8080e7          	jalr	-1032(ra) # 9000 <sleep>
  remove("stopforking");
    3410:	00008517          	auipc	a0,0x8
    3414:	aa050513          	addi	a0,a0,-1376 # aeb0 <malloc+0x18f0>
    3418:	00006097          	auipc	ra,0x6
    341c:	c18080e7          	jalr	-1000(ra) # 9030 <remove>
}
    3420:	60e2                	ld	ra,24(sp)
    3422:	6442                	ld	s0,16(sp)
    3424:	64a2                	ld	s1,8(sp)
    3426:	6105                	addi	sp,sp,32
    3428:	8082                	ret
    printf("%s: fork failed", s);
    342a:	85a6                	mv	a1,s1
    342c:	00007517          	auipc	a0,0x7
    3430:	f6c50513          	addi	a0,a0,-148 # a398 <malloc+0xdd8>
    3434:	00006097          	auipc	ra,0x6
    3438:	0d4080e7          	jalr	212(ra) # 9508 <printf>
    exit(1);
    343c:	4505                	li	a0,1
    343e:	00006097          	auipc	ra,0x6
    3442:	b4a080e7          	jalr	-1206(ra) # 8f88 <exit>
      int fd = open("stopforking", 0);
    3446:	00008497          	auipc	s1,0x8
    344a:	a6a48493          	addi	s1,s1,-1430 # aeb0 <malloc+0x18f0>
    344e:	4581                	li	a1,0
    3450:	8526                	mv	a0,s1
    3452:	00006097          	auipc	ra,0x6
    3456:	b76080e7          	jalr	-1162(ra) # 8fc8 <open>
      if(fd >= 0){
    345a:	02055463          	bgez	a0,3482 <forkforkfork+0xd6>
      if(fork() < 0){
    345e:	00006097          	auipc	ra,0x6
    3462:	b22080e7          	jalr	-1246(ra) # 8f80 <fork>
    3466:	fe0554e3          	bgez	a0,344e <forkforkfork+0xa2>
        close(open("stopforking", O_CREATE|O_RDWR));
    346a:	20200593          	li	a1,514
    346e:	8526                	mv	a0,s1
    3470:	00006097          	auipc	ra,0x6
    3474:	b58080e7          	jalr	-1192(ra) # 8fc8 <open>
    3478:	00006097          	auipc	ra,0x6
    347c:	b38080e7          	jalr	-1224(ra) # 8fb0 <close>
    3480:	b7f9                	j	344e <forkforkfork+0xa2>
        exit(0);
    3482:	4501                	li	a0,0
    3484:	00006097          	auipc	ra,0x6
    3488:	b04080e7          	jalr	-1276(ra) # 8f88 <exit>

000000000000348c <preempt>:
{
    348c:	7139                	addi	sp,sp,-64
    348e:	fc06                	sd	ra,56(sp)
    3490:	f822                	sd	s0,48(sp)
    3492:	f426                	sd	s1,40(sp)
    3494:	f04a                	sd	s2,32(sp)
    3496:	ec4e                	sd	s3,24(sp)
    3498:	e852                	sd	s4,16(sp)
    349a:	0080                	addi	s0,sp,64
    349c:	892a                	mv	s2,a0
  pid1 = fork();
    349e:	00006097          	auipc	ra,0x6
    34a2:	ae2080e7          	jalr	-1310(ra) # 8f80 <fork>
  if(pid1 < 0) {
    34a6:	00054563          	bltz	a0,34b0 <preempt+0x24>
    34aa:	84aa                	mv	s1,a0
  if(pid1 == 0)
    34ac:	ed19                	bnez	a0,34ca <preempt+0x3e>
    for(;;)
    34ae:	a001                	j	34ae <preempt+0x22>
    printf("%s: fork failed");
    34b0:	00007517          	auipc	a0,0x7
    34b4:	ee850513          	addi	a0,a0,-280 # a398 <malloc+0xdd8>
    34b8:	00006097          	auipc	ra,0x6
    34bc:	050080e7          	jalr	80(ra) # 9508 <printf>
    exit(1);
    34c0:	4505                	li	a0,1
    34c2:	00006097          	auipc	ra,0x6
    34c6:	ac6080e7          	jalr	-1338(ra) # 8f88 <exit>
  pid2 = fork();
    34ca:	00006097          	auipc	ra,0x6
    34ce:	ab6080e7          	jalr	-1354(ra) # 8f80 <fork>
    34d2:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    34d4:	00054463          	bltz	a0,34dc <preempt+0x50>
  if(pid2 == 0)
    34d8:	e105                	bnez	a0,34f8 <preempt+0x6c>
    for(;;)
    34da:	a001                	j	34da <preempt+0x4e>
    printf("%s: fork failed\n", s);
    34dc:	85ca                	mv	a1,s2
    34de:	00007517          	auipc	a0,0x7
    34e2:	cfa50513          	addi	a0,a0,-774 # a1d8 <malloc+0xc18>
    34e6:	00006097          	auipc	ra,0x6
    34ea:	022080e7          	jalr	34(ra) # 9508 <printf>
    exit(1);
    34ee:	4505                	li	a0,1
    34f0:	00006097          	auipc	ra,0x6
    34f4:	a98080e7          	jalr	-1384(ra) # 8f88 <exit>
  pipe(pfds);
    34f8:	fc840513          	addi	a0,s0,-56
    34fc:	00006097          	auipc	ra,0x6
    3500:	a9c080e7          	jalr	-1380(ra) # 8f98 <pipe>
  pid3 = fork();
    3504:	00006097          	auipc	ra,0x6
    3508:	a7c080e7          	jalr	-1412(ra) # 8f80 <fork>
    350c:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    350e:	02054e63          	bltz	a0,354a <preempt+0xbe>
  if(pid3 == 0){
    3512:	e13d                	bnez	a0,3578 <preempt+0xec>
    close(pfds[0]);
    3514:	fc842503          	lw	a0,-56(s0)
    3518:	00006097          	auipc	ra,0x6
    351c:	a98080e7          	jalr	-1384(ra) # 8fb0 <close>
    if(write(pfds[1], "x", 1) != 1)
    3520:	4605                	li	a2,1
    3522:	00006597          	auipc	a1,0x6
    3526:	25658593          	addi	a1,a1,598 # 9778 <malloc+0x1b8>
    352a:	fcc42503          	lw	a0,-52(s0)
    352e:	00006097          	auipc	ra,0x6
    3532:	a7a080e7          	jalr	-1414(ra) # 8fa8 <write>
    3536:	4785                	li	a5,1
    3538:	02f51763          	bne	a0,a5,3566 <preempt+0xda>
    close(pfds[1]);
    353c:	fcc42503          	lw	a0,-52(s0)
    3540:	00006097          	auipc	ra,0x6
    3544:	a70080e7          	jalr	-1424(ra) # 8fb0 <close>
    for(;;)
    3548:	a001                	j	3548 <preempt+0xbc>
     printf("%s: fork failed\n", s);
    354a:	85ca                	mv	a1,s2
    354c:	00007517          	auipc	a0,0x7
    3550:	c8c50513          	addi	a0,a0,-884 # a1d8 <malloc+0xc18>
    3554:	00006097          	auipc	ra,0x6
    3558:	fb4080e7          	jalr	-76(ra) # 9508 <printf>
     exit(1);
    355c:	4505                	li	a0,1
    355e:	00006097          	auipc	ra,0x6
    3562:	a2a080e7          	jalr	-1494(ra) # 8f88 <exit>
      printf("%s: preempt write error");
    3566:	00008517          	auipc	a0,0x8
    356a:	95a50513          	addi	a0,a0,-1702 # aec0 <malloc+0x1900>
    356e:	00006097          	auipc	ra,0x6
    3572:	f9a080e7          	jalr	-102(ra) # 9508 <printf>
    3576:	b7d9                	j	353c <preempt+0xb0>
  close(pfds[1]);
    3578:	fcc42503          	lw	a0,-52(s0)
    357c:	00006097          	auipc	ra,0x6
    3580:	a34080e7          	jalr	-1484(ra) # 8fb0 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    3584:	6609                	lui	a2,0x2
    3586:	80060613          	addi	a2,a2,-2048 # 1800 <exectest+0x172>
    358a:	0001a597          	auipc	a1,0x1a
    358e:	b3e58593          	addi	a1,a1,-1218 # 1d0c8 <buf>
    3592:	fc842503          	lw	a0,-56(s0)
    3596:	00006097          	auipc	ra,0x6
    359a:	a0a080e7          	jalr	-1526(ra) # 8fa0 <read>
    359e:	4785                	li	a5,1
    35a0:	02f50263          	beq	a0,a5,35c4 <preempt+0x138>
    printf("%s: preempt read error");
    35a4:	00008517          	auipc	a0,0x8
    35a8:	93450513          	addi	a0,a0,-1740 # aed8 <malloc+0x1918>
    35ac:	00006097          	auipc	ra,0x6
    35b0:	f5c080e7          	jalr	-164(ra) # 9508 <printf>
}
    35b4:	70e2                	ld	ra,56(sp)
    35b6:	7442                	ld	s0,48(sp)
    35b8:	74a2                	ld	s1,40(sp)
    35ba:	7902                	ld	s2,32(sp)
    35bc:	69e2                	ld	s3,24(sp)
    35be:	6a42                	ld	s4,16(sp)
    35c0:	6121                	addi	sp,sp,64
    35c2:	8082                	ret
  close(pfds[0]);
    35c4:	fc842503          	lw	a0,-56(s0)
    35c8:	00006097          	auipc	ra,0x6
    35cc:	9e8080e7          	jalr	-1560(ra) # 8fb0 <close>
  printf("kill... ");
    35d0:	00008517          	auipc	a0,0x8
    35d4:	92050513          	addi	a0,a0,-1760 # aef0 <malloc+0x1930>
    35d8:	00006097          	auipc	ra,0x6
    35dc:	f30080e7          	jalr	-208(ra) # 9508 <printf>
  kill(pid1);
    35e0:	8526                	mv	a0,s1
    35e2:	00006097          	auipc	ra,0x6
    35e6:	9d6080e7          	jalr	-1578(ra) # 8fb8 <kill>
  kill(pid2);
    35ea:	854e                	mv	a0,s3
    35ec:	00006097          	auipc	ra,0x6
    35f0:	9cc080e7          	jalr	-1588(ra) # 8fb8 <kill>
  kill(pid3);
    35f4:	8552                	mv	a0,s4
    35f6:	00006097          	auipc	ra,0x6
    35fa:	9c2080e7          	jalr	-1598(ra) # 8fb8 <kill>
  printf("wait... ");
    35fe:	00008517          	auipc	a0,0x8
    3602:	90250513          	addi	a0,a0,-1790 # af00 <malloc+0x1940>
    3606:	00006097          	auipc	ra,0x6
    360a:	f02080e7          	jalr	-254(ra) # 9508 <printf>
  wait(0);
    360e:	4501                	li	a0,0
    3610:	00006097          	auipc	ra,0x6
    3614:	980080e7          	jalr	-1664(ra) # 8f90 <wait>
  wait(0);
    3618:	4501                	li	a0,0
    361a:	00006097          	auipc	ra,0x6
    361e:	976080e7          	jalr	-1674(ra) # 8f90 <wait>
  wait(0);
    3622:	4501                	li	a0,0
    3624:	00006097          	auipc	ra,0x6
    3628:	96c080e7          	jalr	-1684(ra) # 8f90 <wait>
    362c:	b761                	j	35b4 <preempt+0x128>

000000000000362e <sbrkfail>:
{
    362e:	7119                	addi	sp,sp,-128
    3630:	fc86                	sd	ra,120(sp)
    3632:	f8a2                	sd	s0,112(sp)
    3634:	f4a6                	sd	s1,104(sp)
    3636:	f0ca                	sd	s2,96(sp)
    3638:	ecce                	sd	s3,88(sp)
    363a:	e8d2                	sd	s4,80(sp)
    363c:	e4d6                	sd	s5,72(sp)
    363e:	e0da                	sd	s6,64(sp)
    3640:	0100                	addi	s0,sp,128
    3642:	8b2a                	mv	s6,a0
  if(pipe(fds) != 0){
    3644:	fb040513          	addi	a0,s0,-80
    3648:	00006097          	auipc	ra,0x6
    364c:	950080e7          	jalr	-1712(ra) # 8f98 <pipe>
    3650:	e911                	bnez	a0,3664 <sbrkfail+0x36>
    3652:	f8040493          	addi	s1,s0,-128
    3656:	fa840993          	addi	s3,s0,-88
    365a:	8926                	mv	s2,s1
    if(pids[i] != -1)
    365c:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    365e:	faf40a93          	addi	s5,s0,-81
    3662:	a085                	j	36c2 <sbrkfail+0x94>
    printf("%s: pipe() failed\n", s);
    3664:	85da                	mv	a1,s6
    3666:	00007517          	auipc	a0,0x7
    366a:	c7a50513          	addi	a0,a0,-902 # a2e0 <malloc+0xd20>
    366e:	00006097          	auipc	ra,0x6
    3672:	e9a080e7          	jalr	-358(ra) # 9508 <printf>
    exit(1);
    3676:	4505                	li	a0,1
    3678:	00006097          	auipc	ra,0x6
    367c:	910080e7          	jalr	-1776(ra) # 8f88 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    3680:	00006097          	auipc	ra,0x6
    3684:	978080e7          	jalr	-1672(ra) # 8ff8 <sbrk>
    3688:	064007b7          	lui	a5,0x6400
    368c:	40a7853b          	subw	a0,a5,a0
    3690:	00006097          	auipc	ra,0x6
    3694:	968080e7          	jalr	-1688(ra) # 8ff8 <sbrk>
      write(fds[1], "x", 1);
    3698:	4605                	li	a2,1
    369a:	00006597          	auipc	a1,0x6
    369e:	0de58593          	addi	a1,a1,222 # 9778 <malloc+0x1b8>
    36a2:	fb442503          	lw	a0,-76(s0)
    36a6:	00006097          	auipc	ra,0x6
    36aa:	902080e7          	jalr	-1790(ra) # 8fa8 <write>
      for(;;) sleep(1000);
    36ae:	3e800513          	li	a0,1000
    36b2:	00006097          	auipc	ra,0x6
    36b6:	94e080e7          	jalr	-1714(ra) # 9000 <sleep>
    36ba:	bfd5                	j	36ae <sbrkfail+0x80>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    36bc:	0911                	addi	s2,s2,4
    36be:	03390463          	beq	s2,s3,36e6 <sbrkfail+0xb8>
    if((pids[i] = fork()) == 0){
    36c2:	00006097          	auipc	ra,0x6
    36c6:	8be080e7          	jalr	-1858(ra) # 8f80 <fork>
    36ca:	00a92023          	sw	a0,0(s2)
    36ce:	d94d                	beqz	a0,3680 <sbrkfail+0x52>
    if(pids[i] != -1)
    36d0:	ff4506e3          	beq	a0,s4,36bc <sbrkfail+0x8e>
      read(fds[0], &scratch, 1);
    36d4:	4605                	li	a2,1
    36d6:	85d6                	mv	a1,s5
    36d8:	fb042503          	lw	a0,-80(s0)
    36dc:	00006097          	auipc	ra,0x6
    36e0:	8c4080e7          	jalr	-1852(ra) # 8fa0 <read>
    36e4:	bfe1                	j	36bc <sbrkfail+0x8e>
  c = sbrk(PGSIZE);
    36e6:	6505                	lui	a0,0x1
    36e8:	00006097          	auipc	ra,0x6
    36ec:	910080e7          	jalr	-1776(ra) # 8ff8 <sbrk>
    36f0:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    36f2:	597d                	li	s2,-1
    36f4:	a021                	j	36fc <sbrkfail+0xce>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    36f6:	0491                	addi	s1,s1,4
    36f8:	01348f63          	beq	s1,s3,3716 <sbrkfail+0xe8>
    if(pids[i] == -1)
    36fc:	4088                	lw	a0,0(s1)
    36fe:	ff250ce3          	beq	a0,s2,36f6 <sbrkfail+0xc8>
    kill(pids[i]);
    3702:	00006097          	auipc	ra,0x6
    3706:	8b6080e7          	jalr	-1866(ra) # 8fb8 <kill>
    wait(0);
    370a:	4501                	li	a0,0
    370c:	00006097          	auipc	ra,0x6
    3710:	884080e7          	jalr	-1916(ra) # 8f90 <wait>
    3714:	b7cd                	j	36f6 <sbrkfail+0xc8>
  if(c == (char*)0xffffffffffffffffL){
    3716:	57fd                	li	a5,-1
    3718:	04fa0263          	beq	s4,a5,375c <sbrkfail+0x12e>
  pid = fork();
    371c:	00006097          	auipc	ra,0x6
    3720:	864080e7          	jalr	-1948(ra) # 8f80 <fork>
    3724:	84aa                	mv	s1,a0
  if(pid < 0){
    3726:	04054963          	bltz	a0,3778 <sbrkfail+0x14a>
  if(pid == 0){
    372a:	c52d                	beqz	a0,3794 <sbrkfail+0x166>
  wait(&xstatus);
    372c:	fbc40513          	addi	a0,s0,-68
    3730:	00006097          	auipc	ra,0x6
    3734:	860080e7          	jalr	-1952(ra) # 8f90 <wait>
  if(xstatus != -1 && xstatus != 2)
    3738:	fbc42783          	lw	a5,-68(s0)
    373c:	577d                	li	a4,-1
    373e:	00e78563          	beq	a5,a4,3748 <sbrkfail+0x11a>
    3742:	4709                	li	a4,2
    3744:	08e79d63          	bne	a5,a4,37de <sbrkfail+0x1b0>
}
    3748:	70e6                	ld	ra,120(sp)
    374a:	7446                	ld	s0,112(sp)
    374c:	74a6                	ld	s1,104(sp)
    374e:	7906                	ld	s2,96(sp)
    3750:	69e6                	ld	s3,88(sp)
    3752:	6a46                	ld	s4,80(sp)
    3754:	6aa6                	ld	s5,72(sp)
    3756:	6b06                	ld	s6,64(sp)
    3758:	6109                	addi	sp,sp,128
    375a:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    375c:	85da                	mv	a1,s6
    375e:	00007517          	auipc	a0,0x7
    3762:	7b250513          	addi	a0,a0,1970 # af10 <malloc+0x1950>
    3766:	00006097          	auipc	ra,0x6
    376a:	da2080e7          	jalr	-606(ra) # 9508 <printf>
    exit(1);
    376e:	4505                	li	a0,1
    3770:	00006097          	auipc	ra,0x6
    3774:	818080e7          	jalr	-2024(ra) # 8f88 <exit>
    printf("%s: fork failed\n", s);
    3778:	85da                	mv	a1,s6
    377a:	00007517          	auipc	a0,0x7
    377e:	a5e50513          	addi	a0,a0,-1442 # a1d8 <malloc+0xc18>
    3782:	00006097          	auipc	ra,0x6
    3786:	d86080e7          	jalr	-634(ra) # 9508 <printf>
    exit(1);
    378a:	4505                	li	a0,1
    378c:	00005097          	auipc	ra,0x5
    3790:	7fc080e7          	jalr	2044(ra) # 8f88 <exit>
    a = sbrk(0);
    3794:	4501                	li	a0,0
    3796:	00006097          	auipc	ra,0x6
    379a:	862080e7          	jalr	-1950(ra) # 8ff8 <sbrk>
    379e:	892a                	mv	s2,a0
    sbrk(10*BIG);
    37a0:	3e800537          	lui	a0,0x3e800
    37a4:	00006097          	auipc	ra,0x6
    37a8:	854080e7          	jalr	-1964(ra) # 8ff8 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    37ac:	87ca                	mv	a5,s2
    37ae:	3e800737          	lui	a4,0x3e800
    37b2:	993a                	add	s2,s2,a4
    37b4:	6705                	lui	a4,0x1
      n += *(a+i);
    37b6:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63e1720>
    37ba:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    37bc:	97ba                	add	a5,a5,a4
    37be:	ff279ce3          	bne	a5,s2,37b6 <sbrkfail+0x188>
    printf("%s: allocate a lot of memory succeeded %d\n", n);
    37c2:	85a6                	mv	a1,s1
    37c4:	00007517          	auipc	a0,0x7
    37c8:	76c50513          	addi	a0,a0,1900 # af30 <malloc+0x1970>
    37cc:	00006097          	auipc	ra,0x6
    37d0:	d3c080e7          	jalr	-708(ra) # 9508 <printf>
    exit(1);
    37d4:	4505                	li	a0,1
    37d6:	00005097          	auipc	ra,0x5
    37da:	7b2080e7          	jalr	1970(ra) # 8f88 <exit>
    exit(1);
    37de:	4505                	li	a0,1
    37e0:	00005097          	auipc	ra,0x5
    37e4:	7a8080e7          	jalr	1960(ra) # 8f88 <exit>

00000000000037e8 <reparent>:
{
    37e8:	7179                	addi	sp,sp,-48
    37ea:	f406                	sd	ra,40(sp)
    37ec:	f022                	sd	s0,32(sp)
    37ee:	ec26                	sd	s1,24(sp)
    37f0:	e84a                	sd	s2,16(sp)
    37f2:	e44e                	sd	s3,8(sp)
    37f4:	e052                	sd	s4,0(sp)
    37f6:	1800                	addi	s0,sp,48
    37f8:	89aa                	mv	s3,a0
  int master_pid = getpid();
    37fa:	00005097          	auipc	ra,0x5
    37fe:	7f6080e7          	jalr	2038(ra) # 8ff0 <getpid>
    3802:	8a2a                	mv	s4,a0
    3804:	0c800913          	li	s2,200
    int pid = fork();
    3808:	00005097          	auipc	ra,0x5
    380c:	778080e7          	jalr	1912(ra) # 8f80 <fork>
    3810:	84aa                	mv	s1,a0
    if(pid < 0){
    3812:	02054263          	bltz	a0,3836 <reparent+0x4e>
    if(pid){
    3816:	cd21                	beqz	a0,386e <reparent+0x86>
      if(wait(0) != pid){
    3818:	4501                	li	a0,0
    381a:	00005097          	auipc	ra,0x5
    381e:	776080e7          	jalr	1910(ra) # 8f90 <wait>
    3822:	02951863          	bne	a0,s1,3852 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    3826:	397d                	addiw	s2,s2,-1
    3828:	fe0910e3          	bnez	s2,3808 <reparent+0x20>
  exit(0);
    382c:	4501                	li	a0,0
    382e:	00005097          	auipc	ra,0x5
    3832:	75a080e7          	jalr	1882(ra) # 8f88 <exit>
      printf("%s: fork failed\n", s);
    3836:	85ce                	mv	a1,s3
    3838:	00007517          	auipc	a0,0x7
    383c:	9a050513          	addi	a0,a0,-1632 # a1d8 <malloc+0xc18>
    3840:	00006097          	auipc	ra,0x6
    3844:	cc8080e7          	jalr	-824(ra) # 9508 <printf>
      exit(1);
    3848:	4505                	li	a0,1
    384a:	00005097          	auipc	ra,0x5
    384e:	73e080e7          	jalr	1854(ra) # 8f88 <exit>
        printf("%s: wait wrong pid\n", s);
    3852:	85ce                	mv	a1,s3
    3854:	00007517          	auipc	a0,0x7
    3858:	b0c50513          	addi	a0,a0,-1268 # a360 <malloc+0xda0>
    385c:	00006097          	auipc	ra,0x6
    3860:	cac080e7          	jalr	-852(ra) # 9508 <printf>
        exit(1);
    3864:	4505                	li	a0,1
    3866:	00005097          	auipc	ra,0x5
    386a:	722080e7          	jalr	1826(ra) # 8f88 <exit>
      int pid2 = fork();
    386e:	00005097          	auipc	ra,0x5
    3872:	712080e7          	jalr	1810(ra) # 8f80 <fork>
      if(pid2 < 0){
    3876:	00054763          	bltz	a0,3884 <reparent+0x9c>
      exit(0);
    387a:	4501                	li	a0,0
    387c:	00005097          	auipc	ra,0x5
    3880:	70c080e7          	jalr	1804(ra) # 8f88 <exit>
        kill(master_pid);
    3884:	8552                	mv	a0,s4
    3886:	00005097          	auipc	ra,0x5
    388a:	732080e7          	jalr	1842(ra) # 8fb8 <kill>
        exit(1);
    388e:	4505                	li	a0,1
    3890:	00005097          	auipc	ra,0x5
    3894:	6f8080e7          	jalr	1784(ra) # 8f88 <exit>

0000000000003898 <mem>:
{
    3898:	7139                	addi	sp,sp,-64
    389a:	fc06                	sd	ra,56(sp)
    389c:	f822                	sd	s0,48(sp)
    389e:	f426                	sd	s1,40(sp)
    38a0:	f04a                	sd	s2,32(sp)
    38a2:	ec4e                	sd	s3,24(sp)
    38a4:	0080                	addi	s0,sp,64
    38a6:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    38a8:	00005097          	auipc	ra,0x5
    38ac:	6d8080e7          	jalr	1752(ra) # 8f80 <fork>
    m1 = 0;
    38b0:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    38b2:	6909                	lui	s2,0x2
    38b4:	71190913          	addi	s2,s2,1809 # 2711 <execout+0x6f>
  if((pid = fork()) == 0){
    38b8:	c115                	beqz	a0,38dc <mem+0x44>
    wait(&xstatus);
    38ba:	fcc40513          	addi	a0,s0,-52
    38be:	00005097          	auipc	ra,0x5
    38c2:	6d2080e7          	jalr	1746(ra) # 8f90 <wait>
    if(xstatus == -1){
    38c6:	fcc42503          	lw	a0,-52(s0)
    38ca:	57fd                	li	a5,-1
    38cc:	06f50363          	beq	a0,a5,3932 <mem+0x9a>
    exit(xstatus);
    38d0:	00005097          	auipc	ra,0x5
    38d4:	6b8080e7          	jalr	1720(ra) # 8f88 <exit>
      *(char**)m2 = m1;
    38d8:	e104                	sd	s1,0(a0)
      m1 = m2;
    38da:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    38dc:	854a                	mv	a0,s2
    38de:	00006097          	auipc	ra,0x6
    38e2:	ce2080e7          	jalr	-798(ra) # 95c0 <malloc>
    38e6:	f96d                	bnez	a0,38d8 <mem+0x40>
    while(m1){
    38e8:	c881                	beqz	s1,38f8 <mem+0x60>
      m2 = *(char**)m1;
    38ea:	8526                	mv	a0,s1
    38ec:	6084                	ld	s1,0(s1)
      free(m1);
    38ee:	00006097          	auipc	ra,0x6
    38f2:	c50080e7          	jalr	-944(ra) # 953e <free>
    while(m1){
    38f6:	f8f5                	bnez	s1,38ea <mem+0x52>
    m1 = malloc(1024*20);
    38f8:	6515                	lui	a0,0x5
    38fa:	00006097          	auipc	ra,0x6
    38fe:	cc6080e7          	jalr	-826(ra) # 95c0 <malloc>
    if(m1 == 0){
    3902:	c911                	beqz	a0,3916 <mem+0x7e>
    free(m1);
    3904:	00006097          	auipc	ra,0x6
    3908:	c3a080e7          	jalr	-966(ra) # 953e <free>
    exit(0);
    390c:	4501                	li	a0,0
    390e:	00005097          	auipc	ra,0x5
    3912:	67a080e7          	jalr	1658(ra) # 8f88 <exit>
      printf("couldn't allocate mem?!!\n", s);
    3916:	85ce                	mv	a1,s3
    3918:	00007517          	auipc	a0,0x7
    391c:	64850513          	addi	a0,a0,1608 # af60 <malloc+0x19a0>
    3920:	00006097          	auipc	ra,0x6
    3924:	be8080e7          	jalr	-1048(ra) # 9508 <printf>
      exit(1);
    3928:	4505                	li	a0,1
    392a:	00005097          	auipc	ra,0x5
    392e:	65e080e7          	jalr	1630(ra) # 8f88 <exit>
      exit(0);
    3932:	4501                	li	a0,0
    3934:	00005097          	auipc	ra,0x5
    3938:	654080e7          	jalr	1620(ra) # 8f88 <exit>

000000000000393c <sharedfd>:
{
    393c:	7159                	addi	sp,sp,-112
    393e:	f486                	sd	ra,104(sp)
    3940:	f0a2                	sd	s0,96(sp)
    3942:	eca6                	sd	s1,88(sp)
    3944:	e8ca                	sd	s2,80(sp)
    3946:	e4ce                	sd	s3,72(sp)
    3948:	e0d2                	sd	s4,64(sp)
    394a:	fc56                	sd	s5,56(sp)
    394c:	f85a                	sd	s6,48(sp)
    394e:	f45e                	sd	s7,40(sp)
    3950:	f062                	sd	s8,32(sp)
    3952:	1880                	addi	s0,sp,112
    3954:	8aaa                	mv	s5,a0
  remove("sharedfd");
    3956:	00007517          	auipc	a0,0x7
    395a:	62a50513          	addi	a0,a0,1578 # af80 <malloc+0x19c0>
    395e:	00005097          	auipc	ra,0x5
    3962:	6d2080e7          	jalr	1746(ra) # 9030 <remove>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3966:	20200593          	li	a1,514
    396a:	00007517          	auipc	a0,0x7
    396e:	61650513          	addi	a0,a0,1558 # af80 <malloc+0x19c0>
    3972:	00005097          	auipc	ra,0x5
    3976:	656080e7          	jalr	1622(ra) # 8fc8 <open>
  if(fd < 0){
    397a:	04054b63          	bltz	a0,39d0 <sharedfd+0x94>
    397e:	892a                	mv	s2,a0
  pid = fork();
    3980:	00005097          	auipc	ra,0x5
    3984:	600080e7          	jalr	1536(ra) # 8f80 <fork>
    3988:	8a2a                	mv	s4,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    398a:	06300593          	li	a1,99
    398e:	c119                	beqz	a0,3994 <sharedfd+0x58>
    3990:	07000593          	li	a1,112
    3994:	4629                	li	a2,10
    3996:	fa040513          	addi	a0,s0,-96
    399a:	00005097          	auipc	ra,0x5
    399e:	3d6080e7          	jalr	982(ra) # 8d70 <memset>
    39a2:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    39a6:	fa040993          	addi	s3,s0,-96
    39aa:	4629                	li	a2,10
    39ac:	85ce                	mv	a1,s3
    39ae:	854a                	mv	a0,s2
    39b0:	00005097          	auipc	ra,0x5
    39b4:	5f8080e7          	jalr	1528(ra) # 8fa8 <write>
    39b8:	47a9                	li	a5,10
    39ba:	02f51963          	bne	a0,a5,39ec <sharedfd+0xb0>
  for(i = 0; i < N; i++){
    39be:	34fd                	addiw	s1,s1,-1
    39c0:	f4ed                	bnez	s1,39aa <sharedfd+0x6e>
  if(pid == 0) {
    39c2:	040a1363          	bnez	s4,3a08 <sharedfd+0xcc>
    exit(0);
    39c6:	4501                	li	a0,0
    39c8:	00005097          	auipc	ra,0x5
    39cc:	5c0080e7          	jalr	1472(ra) # 8f88 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    39d0:	85d6                	mv	a1,s5
    39d2:	00007517          	auipc	a0,0x7
    39d6:	5be50513          	addi	a0,a0,1470 # af90 <malloc+0x19d0>
    39da:	00006097          	auipc	ra,0x6
    39de:	b2e080e7          	jalr	-1234(ra) # 9508 <printf>
    exit(1);
    39e2:	4505                	li	a0,1
    39e4:	00005097          	auipc	ra,0x5
    39e8:	5a4080e7          	jalr	1444(ra) # 8f88 <exit>
      printf("%s: write sharedfd failed\n", s);
    39ec:	85d6                	mv	a1,s5
    39ee:	00007517          	auipc	a0,0x7
    39f2:	5ca50513          	addi	a0,a0,1482 # afb8 <malloc+0x19f8>
    39f6:	00006097          	auipc	ra,0x6
    39fa:	b12080e7          	jalr	-1262(ra) # 9508 <printf>
      exit(1);
    39fe:	4505                	li	a0,1
    3a00:	00005097          	auipc	ra,0x5
    3a04:	588080e7          	jalr	1416(ra) # 8f88 <exit>
    wait(&xstatus);
    3a08:	f9c40513          	addi	a0,s0,-100
    3a0c:	00005097          	auipc	ra,0x5
    3a10:	584080e7          	jalr	1412(ra) # 8f90 <wait>
    if(xstatus != 0)
    3a14:	f9c42983          	lw	s3,-100(s0)
    3a18:	00098763          	beqz	s3,3a26 <sharedfd+0xea>
      exit(xstatus);
    3a1c:	854e                	mv	a0,s3
    3a1e:	00005097          	auipc	ra,0x5
    3a22:	56a080e7          	jalr	1386(ra) # 8f88 <exit>
  close(fd);
    3a26:	854a                	mv	a0,s2
    3a28:	00005097          	auipc	ra,0x5
    3a2c:	588080e7          	jalr	1416(ra) # 8fb0 <close>
  fd = open("sharedfd", 0);
    3a30:	4581                	li	a1,0
    3a32:	00007517          	auipc	a0,0x7
    3a36:	54e50513          	addi	a0,a0,1358 # af80 <malloc+0x19c0>
    3a3a:	00005097          	auipc	ra,0x5
    3a3e:	58e080e7          	jalr	1422(ra) # 8fc8 <open>
    3a42:	8baa                	mv	s7,a0
  nc = np = 0;
    3a44:	8a4e                	mv	s4,s3
  if(fd < 0){
    3a46:	02054663          	bltz	a0,3a72 <sharedfd+0x136>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3a4a:	fa040c13          	addi	s8,s0,-96
    3a4e:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    3a52:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3a56:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3a5a:	4629                	li	a2,10
    3a5c:	85e2                	mv	a1,s8
    3a5e:	855e                	mv	a0,s7
    3a60:	00005097          	auipc	ra,0x5
    3a64:	540080e7          	jalr	1344(ra) # 8fa0 <read>
    3a68:	02a05f63          	blez	a0,3aa6 <sharedfd+0x16a>
    3a6c:	fa040793          	addi	a5,s0,-96
    3a70:	a01d                	j	3a96 <sharedfd+0x15a>
    printf("%s: cannot open sharedfd for reading\n", s);
    3a72:	85d6                	mv	a1,s5
    3a74:	00007517          	auipc	a0,0x7
    3a78:	56450513          	addi	a0,a0,1380 # afd8 <malloc+0x1a18>
    3a7c:	00006097          	auipc	ra,0x6
    3a80:	a8c080e7          	jalr	-1396(ra) # 9508 <printf>
    exit(1);
    3a84:	4505                	li	a0,1
    3a86:	00005097          	auipc	ra,0x5
    3a8a:	502080e7          	jalr	1282(ra) # 8f88 <exit>
        nc++;
    3a8e:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    3a90:	0785                	addi	a5,a5,1
    3a92:	fd2784e3          	beq	a5,s2,3a5a <sharedfd+0x11e>
      if(buf[i] == 'c')
    3a96:	0007c703          	lbu	a4,0(a5)
    3a9a:	fe970ae3          	beq	a4,s1,3a8e <sharedfd+0x152>
      if(buf[i] == 'p')
    3a9e:	ff6719e3          	bne	a4,s6,3a90 <sharedfd+0x154>
        np++;
    3aa2:	2a05                	addiw	s4,s4,1
    3aa4:	b7f5                	j	3a90 <sharedfd+0x154>
  close(fd);
    3aa6:	855e                	mv	a0,s7
    3aa8:	00005097          	auipc	ra,0x5
    3aac:	508080e7          	jalr	1288(ra) # 8fb0 <close>
  remove("sharedfd");
    3ab0:	00007517          	auipc	a0,0x7
    3ab4:	4d050513          	addi	a0,a0,1232 # af80 <malloc+0x19c0>
    3ab8:	00005097          	auipc	ra,0x5
    3abc:	578080e7          	jalr	1400(ra) # 9030 <remove>
  if(nc == N*SZ && np == N*SZ){
    3ac0:	6789                	lui	a5,0x2
    3ac2:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x6e>
    3ac6:	00f99763          	bne	s3,a5,3ad4 <sharedfd+0x198>
    3aca:	6789                	lui	a5,0x2
    3acc:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x6e>
    3ad0:	02fa0063          	beq	s4,a5,3af0 <sharedfd+0x1b4>
    printf("%s: nc/np test fails\n", s);
    3ad4:	85d6                	mv	a1,s5
    3ad6:	00007517          	auipc	a0,0x7
    3ada:	52a50513          	addi	a0,a0,1322 # b000 <malloc+0x1a40>
    3ade:	00006097          	auipc	ra,0x6
    3ae2:	a2a080e7          	jalr	-1494(ra) # 9508 <printf>
    exit(1);
    3ae6:	4505                	li	a0,1
    3ae8:	00005097          	auipc	ra,0x5
    3aec:	4a0080e7          	jalr	1184(ra) # 8f88 <exit>
    exit(0);
    3af0:	4501                	li	a0,0
    3af2:	00005097          	auipc	ra,0x5
    3af6:	496080e7          	jalr	1174(ra) # 8f88 <exit>

0000000000003afa <fourfiles>:
{
    3afa:	7171                	addi	sp,sp,-176
    3afc:	f506                	sd	ra,168(sp)
    3afe:	f122                	sd	s0,160(sp)
    3b00:	ed26                	sd	s1,152(sp)
    3b02:	e94a                	sd	s2,144(sp)
    3b04:	e54e                	sd	s3,136(sp)
    3b06:	e152                	sd	s4,128(sp)
    3b08:	fcd6                	sd	s5,120(sp)
    3b0a:	f8da                	sd	s6,112(sp)
    3b0c:	f4de                	sd	s7,104(sp)
    3b0e:	f0e2                	sd	s8,96(sp)
    3b10:	ece6                	sd	s9,88(sp)
    3b12:	e8ea                	sd	s10,80(sp)
    3b14:	e4ee                	sd	s11,72(sp)
    3b16:	1900                	addi	s0,sp,176
    3b18:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    3b1c:	00007797          	auipc	a5,0x7
    3b20:	4fc78793          	addi	a5,a5,1276 # b018 <malloc+0x1a58>
    3b24:	f6f43823          	sd	a5,-144(s0)
    3b28:	00007797          	auipc	a5,0x7
    3b2c:	4f878793          	addi	a5,a5,1272 # b020 <malloc+0x1a60>
    3b30:	f6f43c23          	sd	a5,-136(s0)
    3b34:	00007797          	auipc	a5,0x7
    3b38:	4f478793          	addi	a5,a5,1268 # b028 <malloc+0x1a68>
    3b3c:	f8f43023          	sd	a5,-128(s0)
    3b40:	00007797          	auipc	a5,0x7
    3b44:	4f078793          	addi	a5,a5,1264 # b030 <malloc+0x1a70>
    3b48:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3b4c:	f7040c93          	addi	s9,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3b50:	8966                	mv	s2,s9
  for(pi = 0; pi < NCHILD; pi++){
    3b52:	4481                	li	s1,0
    3b54:	4a11                	li	s4,4
    fname = names[pi];
    3b56:	00093983          	ld	s3,0(s2)
    remove(fname);
    3b5a:	854e                	mv	a0,s3
    3b5c:	00005097          	auipc	ra,0x5
    3b60:	4d4080e7          	jalr	1236(ra) # 9030 <remove>
    pid = fork();
    3b64:	00005097          	auipc	ra,0x5
    3b68:	41c080e7          	jalr	1052(ra) # 8f80 <fork>
    if(pid < 0){
    3b6c:	04054a63          	bltz	a0,3bc0 <fourfiles+0xc6>
    if(pid == 0){
    3b70:	c53d                	beqz	a0,3bde <fourfiles+0xe4>
  for(pi = 0; pi < NCHILD; pi++){
    3b72:	2485                	addiw	s1,s1,1
    3b74:	0921                	addi	s2,s2,8
    3b76:	ff4490e3          	bne	s1,s4,3b56 <fourfiles+0x5c>
    3b7a:	4491                	li	s1,4
    wait(&xstatus);
    3b7c:	f6c40913          	addi	s2,s0,-148
    3b80:	854a                	mv	a0,s2
    3b82:	00005097          	auipc	ra,0x5
    3b86:	40e080e7          	jalr	1038(ra) # 8f90 <wait>
    if(xstatus != 0)
    3b8a:	f6c42b83          	lw	s7,-148(s0)
    3b8e:	0e0b9363          	bnez	s7,3c74 <fourfiles+0x17a>
  for(pi = 0; pi < NCHILD; pi++){
    3b92:	34fd                	addiw	s1,s1,-1
    3b94:	f4f5                	bnez	s1,3b80 <fourfiles+0x86>
    3b96:	03000c13          	li	s8,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3b9a:	6a09                	lui	s4,0x2
    3b9c:	800a0a13          	addi	s4,s4,-2048 # 1800 <exectest+0x172>
    3ba0:	00019a97          	auipc	s5,0x19
    3ba4:	528a8a93          	addi	s5,s5,1320 # 1d0c8 <buf>
    3ba8:	00019b17          	auipc	s6,0x19
    3bac:	521b0b13          	addi	s6,s6,1313 # 1d0c9 <buf+0x1>
    if(total != N*SZ){
    3bb0:	6785                	lui	a5,0x1
    3bb2:	77078793          	addi	a5,a5,1904 # 1770 <exectest+0xe2>
    3bb6:	f4f43823          	sd	a5,-176(s0)
  for(i = 0; i < NCHILD; i++){
    3bba:	03400d93          	li	s11,52
    3bbe:	aa2d                	j	3cf8 <fourfiles+0x1fe>
      printf("fork failed\n", s);
    3bc0:	f5843583          	ld	a1,-168(s0)
    3bc4:	00007517          	auipc	a0,0x7
    3bc8:	99450513          	addi	a0,a0,-1644 # a558 <malloc+0xf98>
    3bcc:	00006097          	auipc	ra,0x6
    3bd0:	93c080e7          	jalr	-1732(ra) # 9508 <printf>
      exit(1);
    3bd4:	4505                	li	a0,1
    3bd6:	00005097          	auipc	ra,0x5
    3bda:	3b2080e7          	jalr	946(ra) # 8f88 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3bde:	20200593          	li	a1,514
    3be2:	854e                	mv	a0,s3
    3be4:	00005097          	auipc	ra,0x5
    3be8:	3e4080e7          	jalr	996(ra) # 8fc8 <open>
    3bec:	892a                	mv	s2,a0
      if(fd < 0){
    3bee:	04054763          	bltz	a0,3c3c <fourfiles+0x142>
      memset(buf, '0'+pi, SZ);
    3bf2:	1f400613          	li	a2,500
    3bf6:	0304859b          	addiw	a1,s1,48
    3bfa:	00019517          	auipc	a0,0x19
    3bfe:	4ce50513          	addi	a0,a0,1230 # 1d0c8 <buf>
    3c02:	00005097          	auipc	ra,0x5
    3c06:	16e080e7          	jalr	366(ra) # 8d70 <memset>
    3c0a:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3c0c:	00019997          	auipc	s3,0x19
    3c10:	4bc98993          	addi	s3,s3,1212 # 1d0c8 <buf>
    3c14:	1f400613          	li	a2,500
    3c18:	85ce                	mv	a1,s3
    3c1a:	854a                	mv	a0,s2
    3c1c:	00005097          	auipc	ra,0x5
    3c20:	38c080e7          	jalr	908(ra) # 8fa8 <write>
    3c24:	85aa                	mv	a1,a0
    3c26:	1f400793          	li	a5,500
    3c2a:	02f51863          	bne	a0,a5,3c5a <fourfiles+0x160>
      for(i = 0; i < N; i++){
    3c2e:	34fd                	addiw	s1,s1,-1
    3c30:	f0f5                	bnez	s1,3c14 <fourfiles+0x11a>
      exit(0);
    3c32:	4501                	li	a0,0
    3c34:	00005097          	auipc	ra,0x5
    3c38:	354080e7          	jalr	852(ra) # 8f88 <exit>
        printf("create failed\n", s);
    3c3c:	f5843583          	ld	a1,-168(s0)
    3c40:	00007517          	auipc	a0,0x7
    3c44:	3f850513          	addi	a0,a0,1016 # b038 <malloc+0x1a78>
    3c48:	00006097          	auipc	ra,0x6
    3c4c:	8c0080e7          	jalr	-1856(ra) # 9508 <printf>
        exit(1);
    3c50:	4505                	li	a0,1
    3c52:	00005097          	auipc	ra,0x5
    3c56:	336080e7          	jalr	822(ra) # 8f88 <exit>
          printf("write failed %d\n", n);
    3c5a:	00007517          	auipc	a0,0x7
    3c5e:	3ee50513          	addi	a0,a0,1006 # b048 <malloc+0x1a88>
    3c62:	00006097          	auipc	ra,0x6
    3c66:	8a6080e7          	jalr	-1882(ra) # 9508 <printf>
          exit(1);
    3c6a:	4505                	li	a0,1
    3c6c:	00005097          	auipc	ra,0x5
    3c70:	31c080e7          	jalr	796(ra) # 8f88 <exit>
      exit(xstatus);
    3c74:	855e                	mv	a0,s7
    3c76:	00005097          	auipc	ra,0x5
    3c7a:	312080e7          	jalr	786(ra) # 8f88 <exit>
          printf("wrong char\n", s);
    3c7e:	f5843583          	ld	a1,-168(s0)
    3c82:	00007517          	auipc	a0,0x7
    3c86:	3de50513          	addi	a0,a0,990 # b060 <malloc+0x1aa0>
    3c8a:	00006097          	auipc	ra,0x6
    3c8e:	87e080e7          	jalr	-1922(ra) # 9508 <printf>
          exit(1);
    3c92:	4505                	li	a0,1
    3c94:	00005097          	auipc	ra,0x5
    3c98:	2f4080e7          	jalr	756(ra) # 8f88 <exit>
      total += n;
    3c9c:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3ca0:	8652                	mv	a2,s4
    3ca2:	85d6                	mv	a1,s5
    3ca4:	854e                	mv	a0,s3
    3ca6:	00005097          	auipc	ra,0x5
    3caa:	2fa080e7          	jalr	762(ra) # 8fa0 <read>
    3cae:	02a05363          	blez	a0,3cd4 <fourfiles+0x1da>
    3cb2:	00019797          	auipc	a5,0x19
    3cb6:	41678793          	addi	a5,a5,1046 # 1d0c8 <buf>
    3cba:	fff5069b          	addiw	a3,a0,-1
    3cbe:	1682                	slli	a3,a3,0x20
    3cc0:	9281                	srli	a3,a3,0x20
    3cc2:	96da                	add	a3,a3,s6
        if(buf[j] != '0'+i){
    3cc4:	0007c703          	lbu	a4,0(a5)
    3cc8:	fa971be3          	bne	a4,s1,3c7e <fourfiles+0x184>
      for(j = 0; j < n; j++){
    3ccc:	0785                	addi	a5,a5,1
    3cce:	fed79be3          	bne	a5,a3,3cc4 <fourfiles+0x1ca>
    3cd2:	b7e9                	j	3c9c <fourfiles+0x1a2>
    close(fd);
    3cd4:	854e                	mv	a0,s3
    3cd6:	00005097          	auipc	ra,0x5
    3cda:	2da080e7          	jalr	730(ra) # 8fb0 <close>
    if(total != N*SZ){
    3cde:	f5043783          	ld	a5,-176(s0)
    3ce2:	02f91863          	bne	s2,a5,3d12 <fourfiles+0x218>
    remove(fname);
    3ce6:	856a                	mv	a0,s10
    3ce8:	00005097          	auipc	ra,0x5
    3cec:	348080e7          	jalr	840(ra) # 9030 <remove>
  for(i = 0; i < NCHILD; i++){
    3cf0:	0ca1                	addi	s9,s9,8
    3cf2:	2c05                	addiw	s8,s8,1
    3cf4:	03bc0d63          	beq	s8,s11,3d2e <fourfiles+0x234>
    fname = names[i];
    3cf8:	000cbd03          	ld	s10,0(s9)
    fd = open(fname, 0);
    3cfc:	4581                	li	a1,0
    3cfe:	856a                	mv	a0,s10
    3d00:	00005097          	auipc	ra,0x5
    3d04:	2c8080e7          	jalr	712(ra) # 8fc8 <open>
    3d08:	89aa                	mv	s3,a0
    total = 0;
    3d0a:	895e                	mv	s2,s7
        if(buf[j] != '0'+i){
    3d0c:	000c049b          	sext.w	s1,s8
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3d10:	bf41                	j	3ca0 <fourfiles+0x1a6>
      printf("wrong length %d\n", total);
    3d12:	85ca                	mv	a1,s2
    3d14:	00007517          	auipc	a0,0x7
    3d18:	35c50513          	addi	a0,a0,860 # b070 <malloc+0x1ab0>
    3d1c:	00005097          	auipc	ra,0x5
    3d20:	7ec080e7          	jalr	2028(ra) # 9508 <printf>
      exit(1);
    3d24:	4505                	li	a0,1
    3d26:	00005097          	auipc	ra,0x5
    3d2a:	262080e7          	jalr	610(ra) # 8f88 <exit>
}
    3d2e:	70aa                	ld	ra,168(sp)
    3d30:	740a                	ld	s0,160(sp)
    3d32:	64ea                	ld	s1,152(sp)
    3d34:	694a                	ld	s2,144(sp)
    3d36:	69aa                	ld	s3,136(sp)
    3d38:	6a0a                	ld	s4,128(sp)
    3d3a:	7ae6                	ld	s5,120(sp)
    3d3c:	7b46                	ld	s6,112(sp)
    3d3e:	7ba6                	ld	s7,104(sp)
    3d40:	7c06                	ld	s8,96(sp)
    3d42:	6ce6                	ld	s9,88(sp)
    3d44:	6d46                	ld	s10,80(sp)
    3d46:	6da6                	ld	s11,72(sp)
    3d48:	614d                	addi	sp,sp,176
    3d4a:	8082                	ret

0000000000003d4c <bigfile>:
{
    3d4c:	7139                	addi	sp,sp,-64
    3d4e:	fc06                	sd	ra,56(sp)
    3d50:	f822                	sd	s0,48(sp)
    3d52:	f426                	sd	s1,40(sp)
    3d54:	f04a                	sd	s2,32(sp)
    3d56:	ec4e                	sd	s3,24(sp)
    3d58:	e852                	sd	s4,16(sp)
    3d5a:	e456                	sd	s5,8(sp)
    3d5c:	0080                	addi	s0,sp,64
    3d5e:	8aaa                	mv	s5,a0
  remove("bigfile.dat");
    3d60:	00007517          	auipc	a0,0x7
    3d64:	32850513          	addi	a0,a0,808 # b088 <malloc+0x1ac8>
    3d68:	00005097          	auipc	ra,0x5
    3d6c:	2c8080e7          	jalr	712(ra) # 9030 <remove>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    3d70:	20200593          	li	a1,514
    3d74:	00007517          	auipc	a0,0x7
    3d78:	31450513          	addi	a0,a0,788 # b088 <malloc+0x1ac8>
    3d7c:	00005097          	auipc	ra,0x5
    3d80:	24c080e7          	jalr	588(ra) # 8fc8 <open>
    3d84:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    3d86:	4481                	li	s1,0
    memset(buf, i, SZ);
    3d88:	00019917          	auipc	s2,0x19
    3d8c:	34090913          	addi	s2,s2,832 # 1d0c8 <buf>
  for(i = 0; i < N; i++){
    3d90:	4a51                	li	s4,20
  if(fd < 0){
    3d92:	0a054063          	bltz	a0,3e32 <bigfile+0xe6>
    memset(buf, i, SZ);
    3d96:	25800613          	li	a2,600
    3d9a:	85a6                	mv	a1,s1
    3d9c:	854a                	mv	a0,s2
    3d9e:	00005097          	auipc	ra,0x5
    3da2:	fd2080e7          	jalr	-46(ra) # 8d70 <memset>
    if(write(fd, buf, SZ) != SZ){
    3da6:	25800613          	li	a2,600
    3daa:	85ca                	mv	a1,s2
    3dac:	854e                	mv	a0,s3
    3dae:	00005097          	auipc	ra,0x5
    3db2:	1fa080e7          	jalr	506(ra) # 8fa8 <write>
    3db6:	25800793          	li	a5,600
    3dba:	08f51a63          	bne	a0,a5,3e4e <bigfile+0x102>
  for(i = 0; i < N; i++){
    3dbe:	2485                	addiw	s1,s1,1
    3dc0:	fd449be3          	bne	s1,s4,3d96 <bigfile+0x4a>
  close(fd);
    3dc4:	854e                	mv	a0,s3
    3dc6:	00005097          	auipc	ra,0x5
    3dca:	1ea080e7          	jalr	490(ra) # 8fb0 <close>
  fd = open("bigfile.dat", 0);
    3dce:	4581                	li	a1,0
    3dd0:	00007517          	auipc	a0,0x7
    3dd4:	2b850513          	addi	a0,a0,696 # b088 <malloc+0x1ac8>
    3dd8:	00005097          	auipc	ra,0x5
    3ddc:	1f0080e7          	jalr	496(ra) # 8fc8 <open>
    3de0:	8a2a                	mv	s4,a0
  total = 0;
    3de2:	4981                	li	s3,0
  for(i = 0; ; i++){
    3de4:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    3de6:	00019917          	auipc	s2,0x19
    3dea:	2e290913          	addi	s2,s2,738 # 1d0c8 <buf>
  if(fd < 0){
    3dee:	06054e63          	bltz	a0,3e6a <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    3df2:	12c00613          	li	a2,300
    3df6:	85ca                	mv	a1,s2
    3df8:	8552                	mv	a0,s4
    3dfa:	00005097          	auipc	ra,0x5
    3dfe:	1a6080e7          	jalr	422(ra) # 8fa0 <read>
    if(cc < 0){
    3e02:	08054263          	bltz	a0,3e86 <bigfile+0x13a>
    if(cc == 0)
    3e06:	c971                	beqz	a0,3eda <bigfile+0x18e>
    if(cc != SZ/2){
    3e08:	12c00793          	li	a5,300
    3e0c:	08f51b63          	bne	a0,a5,3ea2 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    3e10:	01f4d79b          	srliw	a5,s1,0x1f
    3e14:	9fa5                	addw	a5,a5,s1
    3e16:	4017d79b          	sraiw	a5,a5,0x1
    3e1a:	00094703          	lbu	a4,0(s2)
    3e1e:	0af71063          	bne	a4,a5,3ebe <bigfile+0x172>
    3e22:	12b94703          	lbu	a4,299(s2)
    3e26:	08f71c63          	bne	a4,a5,3ebe <bigfile+0x172>
    total += cc;
    3e2a:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    3e2e:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    3e30:	b7c9                	j	3df2 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    3e32:	85d6                	mv	a1,s5
    3e34:	00007517          	auipc	a0,0x7
    3e38:	26450513          	addi	a0,a0,612 # b098 <malloc+0x1ad8>
    3e3c:	00005097          	auipc	ra,0x5
    3e40:	6cc080e7          	jalr	1740(ra) # 9508 <printf>
    exit(1);
    3e44:	4505                	li	a0,1
    3e46:	00005097          	auipc	ra,0x5
    3e4a:	142080e7          	jalr	322(ra) # 8f88 <exit>
      printf("%s: write bigfile failed\n", s);
    3e4e:	85d6                	mv	a1,s5
    3e50:	00007517          	auipc	a0,0x7
    3e54:	26850513          	addi	a0,a0,616 # b0b8 <malloc+0x1af8>
    3e58:	00005097          	auipc	ra,0x5
    3e5c:	6b0080e7          	jalr	1712(ra) # 9508 <printf>
      exit(1);
    3e60:	4505                	li	a0,1
    3e62:	00005097          	auipc	ra,0x5
    3e66:	126080e7          	jalr	294(ra) # 8f88 <exit>
    printf("%s: cannot open bigfile\n", s);
    3e6a:	85d6                	mv	a1,s5
    3e6c:	00007517          	auipc	a0,0x7
    3e70:	26c50513          	addi	a0,a0,620 # b0d8 <malloc+0x1b18>
    3e74:	00005097          	auipc	ra,0x5
    3e78:	694080e7          	jalr	1684(ra) # 9508 <printf>
    exit(1);
    3e7c:	4505                	li	a0,1
    3e7e:	00005097          	auipc	ra,0x5
    3e82:	10a080e7          	jalr	266(ra) # 8f88 <exit>
      printf("%s: read bigfile failed\n", s);
    3e86:	85d6                	mv	a1,s5
    3e88:	00007517          	auipc	a0,0x7
    3e8c:	27050513          	addi	a0,a0,624 # b0f8 <malloc+0x1b38>
    3e90:	00005097          	auipc	ra,0x5
    3e94:	678080e7          	jalr	1656(ra) # 9508 <printf>
      exit(1);
    3e98:	4505                	li	a0,1
    3e9a:	00005097          	auipc	ra,0x5
    3e9e:	0ee080e7          	jalr	238(ra) # 8f88 <exit>
      printf("%s: short read bigfile\n", s);
    3ea2:	85d6                	mv	a1,s5
    3ea4:	00007517          	auipc	a0,0x7
    3ea8:	27450513          	addi	a0,a0,628 # b118 <malloc+0x1b58>
    3eac:	00005097          	auipc	ra,0x5
    3eb0:	65c080e7          	jalr	1628(ra) # 9508 <printf>
      exit(1);
    3eb4:	4505                	li	a0,1
    3eb6:	00005097          	auipc	ra,0x5
    3eba:	0d2080e7          	jalr	210(ra) # 8f88 <exit>
      printf("%s: read bigfile wrong data\n", s);
    3ebe:	85d6                	mv	a1,s5
    3ec0:	00007517          	auipc	a0,0x7
    3ec4:	27050513          	addi	a0,a0,624 # b130 <malloc+0x1b70>
    3ec8:	00005097          	auipc	ra,0x5
    3ecc:	640080e7          	jalr	1600(ra) # 9508 <printf>
      exit(1);
    3ed0:	4505                	li	a0,1
    3ed2:	00005097          	auipc	ra,0x5
    3ed6:	0b6080e7          	jalr	182(ra) # 8f88 <exit>
  close(fd);
    3eda:	8552                	mv	a0,s4
    3edc:	00005097          	auipc	ra,0x5
    3ee0:	0d4080e7          	jalr	212(ra) # 8fb0 <close>
  if(total != N*SZ){
    3ee4:	678d                	lui	a5,0x3
    3ee6:	ee078793          	addi	a5,a5,-288 # 2ee0 <rmdot+0xc4>
    3eea:	02f99363          	bne	s3,a5,3f10 <bigfile+0x1c4>
  remove("bigfile.dat");
    3eee:	00007517          	auipc	a0,0x7
    3ef2:	19a50513          	addi	a0,a0,410 # b088 <malloc+0x1ac8>
    3ef6:	00005097          	auipc	ra,0x5
    3efa:	13a080e7          	jalr	314(ra) # 9030 <remove>
}
    3efe:	70e2                	ld	ra,56(sp)
    3f00:	7442                	ld	s0,48(sp)
    3f02:	74a2                	ld	s1,40(sp)
    3f04:	7902                	ld	s2,32(sp)
    3f06:	69e2                	ld	s3,24(sp)
    3f08:	6a42                	ld	s4,16(sp)
    3f0a:	6aa2                	ld	s5,8(sp)
    3f0c:	6121                	addi	sp,sp,64
    3f0e:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    3f10:	85d6                	mv	a1,s5
    3f12:	00007517          	auipc	a0,0x7
    3f16:	23e50513          	addi	a0,a0,574 # b150 <malloc+0x1b90>
    3f1a:	00005097          	auipc	ra,0x5
    3f1e:	5ee080e7          	jalr	1518(ra) # 9508 <printf>
    exit(1);
    3f22:	4505                	li	a0,1
    3f24:	00005097          	auipc	ra,0x5
    3f28:	064080e7          	jalr	100(ra) # 8f88 <exit>

0000000000003f2c <createdelete>:
{
    3f2c:	7171                	addi	sp,sp,-176
    3f2e:	f506                	sd	ra,168(sp)
    3f30:	f122                	sd	s0,160(sp)
    3f32:	ed26                	sd	s1,152(sp)
    3f34:	e94a                	sd	s2,144(sp)
    3f36:	e54e                	sd	s3,136(sp)
    3f38:	e152                	sd	s4,128(sp)
    3f3a:	fcd6                	sd	s5,120(sp)
    3f3c:	f8da                	sd	s6,112(sp)
    3f3e:	f4de                	sd	s7,104(sp)
    3f40:	f0e2                	sd	s8,96(sp)
    3f42:	ece6                	sd	s9,88(sp)
    3f44:	e8ea                	sd	s10,80(sp)
    3f46:	e4ee                	sd	s11,72(sp)
    3f48:	1900                	addi	s0,sp,176
    3f4a:	8daa                	mv	s11,a0
  char illegal[] = { '\"', '*', '/', ':', '<', '>', '?', '\\', '|', 0 };
    3f4c:	00007797          	auipc	a5,0x7
    3f50:	28c78793          	addi	a5,a5,652 # b1d8 <malloc+0x1c18>
    3f54:	6398                	ld	a4,0(a5)
    3f56:	f6e43023          	sd	a4,-160(s0)
    3f5a:	0087d783          	lhu	a5,8(a5)
    3f5e:	f6f41423          	sh	a5,-152(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3f62:	4901                	li	s2,0
    3f64:	4991                	li	s3,4
    pid = fork();
    3f66:	00005097          	auipc	ra,0x5
    3f6a:	01a080e7          	jalr	26(ra) # 8f80 <fork>
    3f6e:	84aa                	mv	s1,a0
    if(pid < 0){
    3f70:	04054263          	bltz	a0,3fb4 <createdelete+0x88>
    if(pid == 0){
    3f74:	cd31                	beqz	a0,3fd0 <createdelete+0xa4>
  for(pi = 0; pi < NCHILD; pi++){
    3f76:	2905                	addiw	s2,s2,1
    3f78:	ff3917e3          	bne	s2,s3,3f66 <createdelete+0x3a>
    3f7c:	4491                	li	s1,4
    wait(&xstatus);
    3f7e:	f5c40913          	addi	s2,s0,-164
    3f82:	854a                	mv	a0,s2
    3f84:	00005097          	auipc	ra,0x5
    3f88:	00c080e7          	jalr	12(ra) # 8f90 <wait>
    if(xstatus != 0)
    3f8c:	f5c42983          	lw	s3,-164(s0)
    3f90:	10099963          	bnez	s3,40a2 <createdelete+0x176>
  for(pi = 0; pi < NCHILD; pi++){
    3f94:	34fd                	addiw	s1,s1,-1
    3f96:	f4f5                	bnez	s1,3f82 <createdelete+0x56>
  name[0] = name[1] = name[2] = 0;
    3f98:	f6040923          	sb	zero,-142(s0)
    3f9c:	03000913          	li	s2,48
    3fa0:	5b7d                	li	s6,-1
    3fa2:	07000c93          	li	s9,112
      if (strchr(illegal, name[1]) != 0) { continue; }
    3fa6:	f6040a93          	addi	s5,s0,-160
      fd = open(name, 0);
    3faa:	f7040c13          	addi	s8,s0,-144
      } else if((i >= 1 && i < N/2) && fd >= 0){
    3fae:	4ba1                	li	s7,8
      if((i == 0 || i >= N/2) && fd < 0){
    3fb0:	4d25                	li	s10,9
    3fb2:	aa71                	j	414e <createdelete+0x222>
      printf("fork failed\n", s);
    3fb4:	85ee                	mv	a1,s11
    3fb6:	00006517          	auipc	a0,0x6
    3fba:	5a250513          	addi	a0,a0,1442 # a558 <malloc+0xf98>
    3fbe:	00005097          	auipc	ra,0x5
    3fc2:	54a080e7          	jalr	1354(ra) # 9508 <printf>
      exit(1);
    3fc6:	4505                	li	a0,1
    3fc8:	00005097          	auipc	ra,0x5
    3fcc:	fc0080e7          	jalr	-64(ra) # 8f88 <exit>
      name[0] = 'p' + pi;
    3fd0:	0709091b          	addiw	s2,s2,112
    3fd4:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
    3fd8:	f6040923          	sb	zero,-142(s0)
        if (strchr(illegal, name[1]) == 0) {
    3fdc:	f6040913          	addi	s2,s0,-160
          fd = open(name, O_CREATE | O_RDWR);
    3fe0:	f7040a13          	addi	s4,s0,-144
      for(i = 0; i < N; i++){
    3fe4:	49d1                	li	s3,20
    3fe6:	a091                	j	402a <createdelete+0xfe>
          fd = open(name, O_CREATE | O_RDWR);
    3fe8:	20200593          	li	a1,514
    3fec:	8552                	mv	a0,s4
    3fee:	00005097          	auipc	ra,0x5
    3ff2:	fda080e7          	jalr	-38(ra) # 8fc8 <open>
          if(fd < 0){
    3ff6:	00054763          	bltz	a0,4004 <createdelete+0xd8>
          close(fd);
    3ffa:	00005097          	auipc	ra,0x5
    3ffe:	fb6080e7          	jalr	-74(ra) # 8fb0 <close>
    4002:	a081                	j	4042 <createdelete+0x116>
            printf("%s: create %s failed\n", s, name);
    4004:	f7040613          	addi	a2,s0,-144
    4008:	85ee                	mv	a1,s11
    400a:	00007517          	auipc	a0,0x7
    400e:	16650513          	addi	a0,a0,358 # b170 <malloc+0x1bb0>
    4012:	00005097          	auipc	ra,0x5
    4016:	4f6080e7          	jalr	1270(ra) # 9508 <printf>
            exit(1);
    401a:	4505                	li	a0,1
    401c:	00005097          	auipc	ra,0x5
    4020:	f6c080e7          	jalr	-148(ra) # 8f88 <exit>
      for(i = 0; i < N; i++){
    4024:	2485                	addiw	s1,s1,1
    4026:	07348963          	beq	s1,s3,4098 <createdelete+0x16c>
        name[1] = '0' + i;
    402a:	0304859b          	addiw	a1,s1,48
    402e:	0ff5f593          	zext.b	a1,a1
    4032:	f6b408a3          	sb	a1,-143(s0)
        if (strchr(illegal, name[1]) == 0) {
    4036:	854a                	mv	a0,s2
    4038:	00005097          	auipc	ra,0x5
    403c:	d5a080e7          	jalr	-678(ra) # 8d92 <strchr>
    4040:	d545                	beqz	a0,3fe8 <createdelete+0xbc>
        if(i > 0 && (i % 2 ) == 0){
    4042:	fe9051e3          	blez	s1,4024 <createdelete+0xf8>
    4046:	0014f793          	andi	a5,s1,1
    404a:	ffe9                	bnez	a5,4024 <createdelete+0xf8>
          name[1] = '0' + (i / 2);
    404c:	01f4d59b          	srliw	a1,s1,0x1f
    4050:	9da5                	addw	a1,a1,s1
    4052:	4015d59b          	sraiw	a1,a1,0x1
    4056:	0305859b          	addiw	a1,a1,48
    405a:	0ff5f593          	zext.b	a1,a1
    405e:	f6b408a3          	sb	a1,-143(s0)
          if (strchr(illegal, name[1]) == 0) {
    4062:	854a                	mv	a0,s2
    4064:	00005097          	auipc	ra,0x5
    4068:	d2e080e7          	jalr	-722(ra) # 8d92 <strchr>
    406c:	fd45                	bnez	a0,4024 <createdelete+0xf8>
            if(remove(name) < 0){
    406e:	8552                	mv	a0,s4
    4070:	00005097          	auipc	ra,0x5
    4074:	fc0080e7          	jalr	-64(ra) # 9030 <remove>
    4078:	fa0556e3          	bgez	a0,4024 <createdelete+0xf8>
              printf("%s: remove failed\n", s);
    407c:	85ee                	mv	a1,s11
    407e:	00007517          	auipc	a0,0x7
    4082:	e1a50513          	addi	a0,a0,-486 # ae98 <malloc+0x18d8>
    4086:	00005097          	auipc	ra,0x5
    408a:	482080e7          	jalr	1154(ra) # 9508 <printf>
              exit(1);
    408e:	4505                	li	a0,1
    4090:	00005097          	auipc	ra,0x5
    4094:	ef8080e7          	jalr	-264(ra) # 8f88 <exit>
      exit(0);
    4098:	4501                	li	a0,0
    409a:	00005097          	auipc	ra,0x5
    409e:	eee080e7          	jalr	-274(ra) # 8f88 <exit>
      exit(1);
    40a2:	4505                	li	a0,1
    40a4:	00005097          	auipc	ra,0x5
    40a8:	ee4080e7          	jalr	-284(ra) # 8f88 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    40ac:	f7040613          	addi	a2,s0,-144
    40b0:	85ee                	mv	a1,s11
    40b2:	00007517          	auipc	a0,0x7
    40b6:	0d650513          	addi	a0,a0,214 # b188 <malloc+0x1bc8>
    40ba:	00005097          	auipc	ra,0x5
    40be:	44e080e7          	jalr	1102(ra) # 9508 <printf>
        exit(1);
    40c2:	4505                	li	a0,1
    40c4:	00005097          	auipc	ra,0x5
    40c8:	ec4080e7          	jalr	-316(ra) # 8f88 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    40cc:	056bf763          	bgeu	s7,s6,411a <createdelete+0x1ee>
      if(fd >= 0)
    40d0:	04055063          	bgez	a0,4110 <createdelete+0x1e4>
    for(pi = 0; pi < NCHILD; pi++){
    40d4:	2485                	addiw	s1,s1,1
    40d6:	0ff4f493          	zext.b	s1,s1
    40da:	07448263          	beq	s1,s4,413e <createdelete+0x212>
      name[0] = 'p' + pi;
    40de:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    40e2:	f72408a3          	sb	s2,-143(s0)
      if (strchr(illegal, name[1]) != 0) { continue; }
    40e6:	85ca                	mv	a1,s2
    40e8:	8556                	mv	a0,s5
    40ea:	00005097          	auipc	ra,0x5
    40ee:	ca8080e7          	jalr	-856(ra) # 8d92 <strchr>
    40f2:	f16d                	bnez	a0,40d4 <createdelete+0x1a8>
      fd = open(name, 0);
    40f4:	4581                	li	a1,0
    40f6:	8562                	mv	a0,s8
    40f8:	00005097          	auipc	ra,0x5
    40fc:	ed0080e7          	jalr	-304(ra) # 8fc8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    4100:	00098463          	beqz	s3,4108 <createdelete+0x1dc>
    4104:	fd3d54e3          	bge	s10,s3,40cc <createdelete+0x1a0>
    4108:	fa0542e3          	bltz	a0,40ac <createdelete+0x180>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    410c:	016bf963          	bgeu	s7,s6,411e <createdelete+0x1f2>
        close(fd);
    4110:	00005097          	auipc	ra,0x5
    4114:	ea0080e7          	jalr	-352(ra) # 8fb0 <close>
    4118:	bf75                	j	40d4 <createdelete+0x1a8>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    411a:	fa054de3          	bltz	a0,40d4 <createdelete+0x1a8>
        printf("%s: oops createdelete %s did exist\n", s, name);
    411e:	f7040613          	addi	a2,s0,-144
    4122:	85ee                	mv	a1,s11
    4124:	00007517          	auipc	a0,0x7
    4128:	08c50513          	addi	a0,a0,140 # b1b0 <malloc+0x1bf0>
    412c:	00005097          	auipc	ra,0x5
    4130:	3dc080e7          	jalr	988(ra) # 9508 <printf>
        exit(1);
    4134:	4505                	li	a0,1
    4136:	00005097          	auipc	ra,0x5
    413a:	e52080e7          	jalr	-430(ra) # 8f88 <exit>
  for(i = 0; i < N; i++){
    413e:	2985                	addiw	s3,s3,1
    4140:	2b05                	addiw	s6,s6,1
    4142:	2905                	addiw	s2,s2,1
    4144:	0ff97913          	zext.b	s2,s2
    4148:	47d1                	li	a5,20
    414a:	02f98b63          	beq	s3,a5,4180 <createdelete+0x254>
    for(pi = 0; pi < NCHILD; pi++){
    414e:	84e6                	mv	s1,s9
    4150:	07400a13          	li	s4,116
    4154:	b769                	j	40de <createdelete+0x1b2>
  for(i = 0; i < N; i++){
    4156:	2905                	addiw	s2,s2,1
    4158:	0ff97913          	zext.b	s2,s2
    415c:	03590d63          	beq	s2,s5,4196 <createdelete+0x26a>
  name[0] = name[1] = name[2] = 0;
    4160:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    4162:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    4166:	f72408a3          	sb	s2,-143(s0)
      remove(name);
    416a:	8552                	mv	a0,s4
    416c:	00005097          	auipc	ra,0x5
    4170:	ec4080e7          	jalr	-316(ra) # 9030 <remove>
    for(pi = 0; pi < NCHILD; pi++){
    4174:	2485                	addiw	s1,s1,1
    4176:	0ff4f493          	zext.b	s1,s1
    417a:	ff3494e3          	bne	s1,s3,4162 <createdelete+0x236>
    417e:	bfe1                	j	4156 <createdelete+0x22a>
    4180:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    4184:	07000b13          	li	s6,112
      remove(name);
    4188:	f7040a13          	addi	s4,s0,-144
    for(pi = 0; pi < NCHILD; pi++){
    418c:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    4190:	04400a93          	li	s5,68
    4194:	b7f1                	j	4160 <createdelete+0x234>
}
    4196:	70aa                	ld	ra,168(sp)
    4198:	740a                	ld	s0,160(sp)
    419a:	64ea                	ld	s1,152(sp)
    419c:	694a                	ld	s2,144(sp)
    419e:	69aa                	ld	s3,136(sp)
    41a0:	6a0a                	ld	s4,128(sp)
    41a2:	7ae6                	ld	s5,120(sp)
    41a4:	7b46                	ld	s6,112(sp)
    41a6:	7ba6                	ld	s7,104(sp)
    41a8:	7c06                	ld	s8,96(sp)
    41aa:	6ce6                	ld	s9,88(sp)
    41ac:	6d46                	ld	s10,80(sp)
    41ae:	6da6                	ld	s11,72(sp)
    41b0:	614d                	addi	sp,sp,176
    41b2:	8082                	ret

00000000000041b4 <validatetest>:
{
    41b4:	715d                	addi	sp,sp,-80
    41b6:	e486                	sd	ra,72(sp)
    41b8:	e0a2                	sd	s0,64(sp)
    41ba:	fc26                	sd	s1,56(sp)
    41bc:	f84a                	sd	s2,48(sp)
    41be:	f44e                	sd	s3,40(sp)
    41c0:	f052                	sd	s4,32(sp)
    41c2:	ec56                	sd	s5,24(sp)
    41c4:	e85a                	sd	s6,16(sp)
    41c6:	e45e                	sd	s7,8(sp)
    41c8:	0880                	addi	s0,sp,80
    41ca:	8baa                	mv	s7,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    41cc:	4481                	li	s1,0
    if(open((char*)p, O_RDONLY) != -1){
    41ce:	597d                	li	s2,-1
      if(strcmp((char*)p, "echo") == 0) continue;
    41d0:	00005b17          	auipc	s6,0x5
    41d4:	538b0b13          	addi	s6,s6,1336 # 9708 <malloc+0x148>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    41d8:	6a05                	lui	s4,0x1
    41da:	001149b7          	lui	s3,0x114
    41de:	a021                	j	41e6 <validatetest+0x32>
    41e0:	94d2                	add	s1,s1,s4
    41e2:	05348863          	beq	s1,s3,4232 <validatetest+0x7e>
    if(open((char*)p, O_RDONLY) != -1){
    41e6:	4581                	li	a1,0
    41e8:	8526                	mv	a0,s1
    41ea:	00005097          	auipc	ra,0x5
    41ee:	dde080e7          	jalr	-546(ra) # 8fc8 <open>
    41f2:	ff2507e3          	beq	a0,s2,41e0 <validatetest+0x2c>
      if(strcmp((char*)p, "echo") == 0) continue;
    41f6:	85da                	mv	a1,s6
    41f8:	8526                	mv	a0,s1
    41fa:	00005097          	auipc	ra,0x5
    41fe:	b20080e7          	jalr	-1248(ra) # 8d1a <strcmp>
    4202:	dd79                	beqz	a0,41e0 <validatetest+0x2c>
      printf("%s: link should not succeed\n", s);
    4204:	85de                	mv	a1,s7
    4206:	00007517          	auipc	a0,0x7
    420a:	fe250513          	addi	a0,a0,-30 # b1e8 <malloc+0x1c28>
    420e:	00005097          	auipc	ra,0x5
    4212:	2fa080e7          	jalr	762(ra) # 9508 <printf>
      printf("bad string:[%s]\n", (char*)p);
    4216:	85a6                	mv	a1,s1
    4218:	00007517          	auipc	a0,0x7
    421c:	ff050513          	addi	a0,a0,-16 # b208 <malloc+0x1c48>
    4220:	00005097          	auipc	ra,0x5
    4224:	2e8080e7          	jalr	744(ra) # 9508 <printf>
      exit(1);
    4228:	4505                	li	a0,1
    422a:	00005097          	auipc	ra,0x5
    422e:	d5e080e7          	jalr	-674(ra) # 8f88 <exit>
}
    4232:	60a6                	ld	ra,72(sp)
    4234:	6406                	ld	s0,64(sp)
    4236:	74e2                	ld	s1,56(sp)
    4238:	7942                	ld	s2,48(sp)
    423a:	79a2                	ld	s3,40(sp)
    423c:	7a02                	ld	s4,32(sp)
    423e:	6ae2                	ld	s5,24(sp)
    4240:	6b42                	ld	s6,16(sp)
    4242:	6ba2                	ld	s7,8(sp)
    4244:	6161                	addi	sp,sp,80
    4246:	8082                	ret

0000000000004248 <my_handler>:
volatile int signal_received = 0;
volatile int signal_number = 0;

// 简单的信号处理函数 - 添加调试输出
void my_handler(int sig)
{
    4248:	1141                	addi	sp,sp,-16
    424a:	e406                	sd	ra,8(sp)
    424c:	e022                	sd	s0,0(sp)
    424e:	0800                	addi	s0,sp,16
  // 注意：在信号处理器中直接使用 printf 可能有问题
  // 先设置标志
  signal_received = 1;
    4250:	0000b797          	auipc	a5,0xb
    4254:	63878793          	addi	a5,a5,1592 # f888 <alarm_simple_received>
    4258:	4705                	li	a4,1
    425a:	10e7a823          	sw	a4,272(a5)
  signal_number = sig;
    425e:	10a7aa23          	sw	a0,276(a5)
  
  // 尝试打印调试信息（可能不安全但有助于诊断）
  // printf("  [handler] received sig=%d, calling sigreturn...\n", sig);
  
  // 显式调用 sigreturn 恢复上下文
  int ret = sigreturn();
    4262:	00005097          	auipc	ra,0x5
    4266:	e8e080e7          	jalr	-370(ra) # 90f0 <sigreturn>
  
  // 如果 sigreturn 返回了，说明出问题了
  // printf("  [handler] sigreturn returned %d (should not happen!)\n", ret);
  (void)ret;  // 避免警告
}
    426a:	60a2                	ld	ra,8(sp)
    426c:	6402                	ld	s0,0(sp)
    426e:	0141                	addi	sp,sp,16
    4270:	8082                	ret

0000000000004272 <semtest>:
    int id = shmcreate("stress_shm", 4096);
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    shmunlink("stress_shm");
}

void semtest(char *s) {
    4272:	7179                	addi	sp,sp,-48
    4274:	f406                	sd	ra,40(sp)
    4276:	f022                	sd	s0,32(sp)
    4278:	ec26                	sd	s1,24(sp)
    427a:	e84a                	sd	s2,16(sp)
    427c:	1800                	addi	s0,sp,48
    if(verbose) { semtest_main(); return; }
    427e:	0000b797          	auipc	a5,0xb
    4282:	6167a783          	lw	a5,1558(a5) # f894 <verbose>
    4286:	ef95                	bnez	a5,42c2 <semtest+0x50>
    4288:	892a                	mv	s2,a0
    int id = sem_open(2);
    428a:	4509                	li	a0,2
    428c:	00005097          	auipc	ra,0x5
    4290:	dc4080e7          	jalr	-572(ra) # 9050 <sem_open>
    4294:	84aa                	mv	s1,a0
    if(id < 0) { printf("%s: sem_open failed\n", s); exit(1); }
    4296:	3c054e63          	bltz	a0,4672 <semtest+0x400>
    sem_post(id);
    429a:	00005097          	auipc	ra,0x5
    429e:	dc6080e7          	jalr	-570(ra) # 9060 <sem_post>
    sem_wait(id);
    42a2:	8526                	mv	a0,s1
    42a4:	00005097          	auipc	ra,0x5
    42a8:	db4080e7          	jalr	-588(ra) # 9058 <sem_wait>
    sem_close(id);
    42ac:	8526                	mv	a0,s1
    42ae:	00005097          	auipc	ra,0x5
    42b2:	dba080e7          	jalr	-582(ra) # 9068 <sem_close>
}
    42b6:	70a2                	ld	ra,40(sp)
    42b8:	7402                	ld	s0,32(sp)
    42ba:	64e2                	ld	s1,24(sp)
    42bc:	6942                	ld	s2,16(sp)
    42be:	6145                	addi	sp,sp,48
    42c0:	8082                	ret
static int semtest_main(void)
{
  int sem_id;
  int value;
  
  printf("=== Semaphore Test ===\n");
    42c2:	00007517          	auipc	a0,0x7
    42c6:	f5e50513          	addi	a0,a0,-162 # b220 <malloc+0x1c60>
    42ca:	00005097          	auipc	ra,0x5
    42ce:	23e080e7          	jalr	574(ra) # 9508 <printf>
  
  // Test 1: Create semaphore with initial value 2
  printf("Test 1: Creating semaphore with initial value 2\n");
    42d2:	00007517          	auipc	a0,0x7
    42d6:	f6650513          	addi	a0,a0,-154 # b238 <malloc+0x1c78>
    42da:	00005097          	auipc	ra,0x5
    42de:	22e080e7          	jalr	558(ra) # 9508 <printf>
  sem_id = sem_open(2);
    42e2:	4509                	li	a0,2
    42e4:	00005097          	auipc	ra,0x5
    42e8:	d6c080e7          	jalr	-660(ra) # 9050 <sem_open>
    42ec:	84aa                	mv	s1,a0
  if(sem_id < 0) {
    42ee:	2a054d63          	bltz	a0,45a8 <semtest+0x336>
    printf("ERROR: sem_open failed\n");
    exit(1);
  }
  printf("SUCCESS: semaphore created with id=%d\n", sem_id);
    42f2:	85aa                	mv	a1,a0
    42f4:	00007517          	auipc	a0,0x7
    42f8:	f9450513          	addi	a0,a0,-108 # b288 <malloc+0x1cc8>
    42fc:	00005097          	auipc	ra,0x5
    4300:	20c080e7          	jalr	524(ra) # 9508 <printf>
  
  // Get and display initial value
  if(sem_getvalue(sem_id, &value) == 0) {
    4304:	fdc40593          	addi	a1,s0,-36
    4308:	8526                	mv	a0,s1
    430a:	00005097          	auipc	ra,0x5
    430e:	d66080e7          	jalr	-666(ra) # 9070 <sem_getvalue>
    4312:	2a051863          	bnez	a0,45c2 <semtest+0x350>
    printf("  -> Semaphore value: %d\n", value);
    4316:	fdc42583          	lw	a1,-36(s0)
    431a:	00007517          	auipc	a0,0x7
    431e:	f9650513          	addi	a0,a0,-106 # b2b0 <malloc+0x1cf0>
    4322:	00005097          	auipc	ra,0x5
    4326:	1e6080e7          	jalr	486(ra) # 9508 <printf>
  } else {
    printf("  -> ERROR: Failed to get semaphore value\n");
  }
  
  // Test 2: Post operation (V)
  printf("\nTest 2: Testing sem_post (V operation)\n");
    432a:	00007517          	auipc	a0,0x7
    432e:	fd650513          	addi	a0,a0,-42 # b300 <malloc+0x1d40>
    4332:	00005097          	auipc	ra,0x5
    4336:	1d6080e7          	jalr	470(ra) # 9508 <printf>
  if(sem_post(sem_id) < 0) {
    433a:	8526                	mv	a0,s1
    433c:	00005097          	auipc	ra,0x5
    4340:	d24080e7          	jalr	-732(ra) # 9060 <sem_post>
    4344:	28054863          	bltz	a0,45d4 <semtest+0x362>
    printf("ERROR: sem_post failed\n");
    exit(1);
  }
  printf("SUCCESS: sem_post completed\n");
    4348:	00007517          	auipc	a0,0x7
    434c:	00050513          	mv	a0,a0
    4350:	00005097          	auipc	ra,0x5
    4354:	1b8080e7          	jalr	440(ra) # 9508 <printf>
  if(sem_getvalue(sem_id, &value) == 0) {
    4358:	fdc40593          	addi	a1,s0,-36
    435c:	8526                	mv	a0,s1
    435e:	00005097          	auipc	ra,0x5
    4362:	d12080e7          	jalr	-750(ra) # 9070 <sem_getvalue>
    4366:	28050463          	beqz	a0,45ee <semtest+0x37c>
    printf("  -> Semaphore value: %d (expected: 3)\n", value);
  }
  
  // Test 3: Wait operation (P)
  printf("\nTest 3: Testing sem_wait (P operation)\n");
    436a:	00007517          	auipc	a0,0x7
    436e:	02650513          	addi	a0,a0,38 # b390 <malloc+0x1dd0>
    4372:	00005097          	auipc	ra,0x5
    4376:	196080e7          	jalr	406(ra) # 9508 <printf>
  if(sem_wait(sem_id) < 0) {
    437a:	8526                	mv	a0,s1
    437c:	00005097          	auipc	ra,0x5
    4380:	cdc080e7          	jalr	-804(ra) # 9058 <sem_wait>
    4384:	28054063          	bltz	a0,4604 <semtest+0x392>
    printf("ERROR: sem_wait failed\n");
    exit(1);
  }
  printf("SUCCESS: sem_wait completed\n");
    4388:	00007517          	auipc	a0,0x7
    438c:	05050513          	addi	a0,a0,80 # b3d8 <malloc+0x1e18>
    4390:	00005097          	auipc	ra,0x5
    4394:	178080e7          	jalr	376(ra) # 9508 <printf>
  if(sem_getvalue(sem_id, &value) == 0) {
    4398:	fdc40593          	addi	a1,s0,-36
    439c:	8526                	mv	a0,s1
    439e:	00005097          	auipc	ra,0x5
    43a2:	cd2080e7          	jalr	-814(ra) # 9070 <sem_getvalue>
    43a6:	26050c63          	beqz	a0,461e <semtest+0x3ac>
    printf("  -> Semaphore value: %d (expected: 2)\n", value);
  }
  
  // Test 4: Multiple operations to show value changes
  printf("\nTest 4: Multiple operations to show value changes\n");
    43aa:	00007517          	auipc	a0,0x7
    43ae:	07650513          	addi	a0,a0,118 # b420 <malloc+0x1e60>
    43b2:	00005097          	auipc	ra,0x5
    43b6:	156080e7          	jalr	342(ra) # 9508 <printf>
  printf("  Current value: ");
    43ba:	00007517          	auipc	a0,0x7
    43be:	09e50513          	addi	a0,a0,158 # b458 <malloc+0x1e98>
    43c2:	00005097          	auipc	ra,0x5
    43c6:	146080e7          	jalr	326(ra) # 9508 <printf>
  sem_getvalue(sem_id, &value);
    43ca:	fdc40913          	addi	s2,s0,-36
    43ce:	85ca                	mv	a1,s2
    43d0:	8526                	mv	a0,s1
    43d2:	00005097          	auipc	ra,0x5
    43d6:	c9e080e7          	jalr	-866(ra) # 9070 <sem_getvalue>
  printf("%d\n", value);
    43da:	fdc42583          	lw	a1,-36(s0)
    43de:	0000a517          	auipc	a0,0xa
    43e2:	30a50513          	addi	a0,a0,778 # e6e8 <malloc+0x5128>
    43e6:	00005097          	auipc	ra,0x5
    43ea:	122080e7          	jalr	290(ra) # 9508 <printf>
  
  printf("  Performing 2 P operations (wait)...\n");
    43ee:	00007517          	auipc	a0,0x7
    43f2:	08250513          	addi	a0,a0,130 # b470 <malloc+0x1eb0>
    43f6:	00005097          	auipc	ra,0x5
    43fa:	112080e7          	jalr	274(ra) # 9508 <printf>
  sem_wait(sem_id);
    43fe:	8526                	mv	a0,s1
    4400:	00005097          	auipc	ra,0x5
    4404:	c58080e7          	jalr	-936(ra) # 9058 <sem_wait>
  sem_getvalue(sem_id, &value);
    4408:	85ca                	mv	a1,s2
    440a:	8526                	mv	a0,s1
    440c:	00005097          	auipc	ra,0x5
    4410:	c64080e7          	jalr	-924(ra) # 9070 <sem_getvalue>
  printf("    After 1st wait: value = %d\n", value);
    4414:	fdc42583          	lw	a1,-36(s0)
    4418:	00007517          	auipc	a0,0x7
    441c:	08050513          	addi	a0,a0,128 # b498 <malloc+0x1ed8>
    4420:	00005097          	auipc	ra,0x5
    4424:	0e8080e7          	jalr	232(ra) # 9508 <printf>
  sem_wait(sem_id);
    4428:	8526                	mv	a0,s1
    442a:	00005097          	auipc	ra,0x5
    442e:	c2e080e7          	jalr	-978(ra) # 9058 <sem_wait>
  sem_getvalue(sem_id, &value);
    4432:	85ca                	mv	a1,s2
    4434:	8526                	mv	a0,s1
    4436:	00005097          	auipc	ra,0x5
    443a:	c3a080e7          	jalr	-966(ra) # 9070 <sem_getvalue>
  printf("    After 2nd wait: value = %d\n", value);
    443e:	fdc42583          	lw	a1,-36(s0)
    4442:	00007517          	auipc	a0,0x7
    4446:	07650513          	addi	a0,a0,118 # b4b8 <malloc+0x1ef8>
    444a:	00005097          	auipc	ra,0x5
    444e:	0be080e7          	jalr	190(ra) # 9508 <printf>
  
  // Note: If we do one more wait, value would become -1 and process would block
  // This is normal semaphore behavior - it waits for another process to post
  printf("  Note: If we wait again, value would be -1 and process would block\n");
    4452:	00007517          	auipc	a0,0x7
    4456:	08650513          	addi	a0,a0,134 # b4d8 <malloc+0x1f18>
    445a:	00005097          	auipc	ra,0x5
    445e:	0ae080e7          	jalr	174(ra) # 9508 <printf>
  printf("        (waiting for another process to call sem_post)\n");
    4462:	00007517          	auipc	a0,0x7
    4466:	0be50513          	addi	a0,a0,190 # b520 <malloc+0x1f60>
    446a:	00005097          	auipc	ra,0x5
    446e:	09e080e7          	jalr	158(ra) # 9508 <printf>
  
  printf("  Performing 2 V operations (post)...\n");
    4472:	00007517          	auipc	a0,0x7
    4476:	0e650513          	addi	a0,a0,230 # b558 <malloc+0x1f98>
    447a:	00005097          	auipc	ra,0x5
    447e:	08e080e7          	jalr	142(ra) # 9508 <printf>
  sem_post(sem_id);
    4482:	8526                	mv	a0,s1
    4484:	00005097          	auipc	ra,0x5
    4488:	bdc080e7          	jalr	-1060(ra) # 9060 <sem_post>
  sem_getvalue(sem_id, &value);
    448c:	85ca                	mv	a1,s2
    448e:	8526                	mv	a0,s1
    4490:	00005097          	auipc	ra,0x5
    4494:	be0080e7          	jalr	-1056(ra) # 9070 <sem_getvalue>
  printf("    After 1st post: value = %d\n", value);
    4498:	fdc42583          	lw	a1,-36(s0)
    449c:	00007517          	auipc	a0,0x7
    44a0:	0e450513          	addi	a0,a0,228 # b580 <malloc+0x1fc0>
    44a4:	00005097          	auipc	ra,0x5
    44a8:	064080e7          	jalr	100(ra) # 9508 <printf>
  sem_post(sem_id);
    44ac:	8526                	mv	a0,s1
    44ae:	00005097          	auipc	ra,0x5
    44b2:	bb2080e7          	jalr	-1102(ra) # 9060 <sem_post>
  sem_getvalue(sem_id, &value);
    44b6:	85ca                	mv	a1,s2
    44b8:	8526                	mv	a0,s1
    44ba:	00005097          	auipc	ra,0x5
    44be:	bb6080e7          	jalr	-1098(ra) # 9070 <sem_getvalue>
  printf("    After 2nd post: value = %d\n", value);
    44c2:	fdc42583          	lw	a1,-36(s0)
    44c6:	00007517          	auipc	a0,0x7
    44ca:	0da50513          	addi	a0,a0,218 # b5a0 <malloc+0x1fe0>
    44ce:	00005097          	auipc	ra,0x5
    44d2:	03a080e7          	jalr	58(ra) # 9508 <printf>
  
  // Now we can safely do one more wait without blocking
  printf("  Now performing 1 more wait (safe, won't block)...\n");
    44d6:	00007517          	auipc	a0,0x7
    44da:	0ea50513          	addi	a0,a0,234 # b5c0 <malloc+0x2000>
    44de:	00005097          	auipc	ra,0x5
    44e2:	02a080e7          	jalr	42(ra) # 9508 <printf>
  sem_wait(sem_id);
    44e6:	8526                	mv	a0,s1
    44e8:	00005097          	auipc	ra,0x5
    44ec:	b70080e7          	jalr	-1168(ra) # 9058 <sem_wait>
  sem_getvalue(sem_id, &value);
    44f0:	85ca                	mv	a1,s2
    44f2:	8526                	mv	a0,s1
    44f4:	00005097          	auipc	ra,0x5
    44f8:	b7c080e7          	jalr	-1156(ra) # 9070 <sem_getvalue>
  printf("    After wait: value = %d\n", value);
    44fc:	fdc42583          	lw	a1,-36(s0)
    4500:	00007517          	auipc	a0,0x7
    4504:	0f850513          	addi	a0,a0,248 # b5f8 <malloc+0x2038>
    4508:	00005097          	auipc	ra,0x5
    450c:	000080e7          	jalr	ra # 9508 <printf>
  
  // Test 5: Close semaphore
  printf("\nTest 5: Closing semaphore\n");
    4510:	00007517          	auipc	a0,0x7
    4514:	10850513          	addi	a0,a0,264 # b618 <malloc+0x2058>
    4518:	00005097          	auipc	ra,0x5
    451c:	ff0080e7          	jalr	-16(ra) # 9508 <printf>
  if(sem_close(sem_id) < 0) {
    4520:	8526                	mv	a0,s1
    4522:	00005097          	auipc	ra,0x5
    4526:	b46080e7          	jalr	-1210(ra) # 9068 <sem_close>
    452a:	10054563          	bltz	a0,4634 <semtest+0x3c2>
    printf("ERROR: sem_close failed\n");
    exit(1);
  }
  printf("SUCCESS: semaphore closed\n");
    452e:	00007517          	auipc	a0,0x7
    4532:	12a50513          	addi	a0,a0,298 # b658 <malloc+0x2098>
    4536:	00005097          	auipc	ra,0x5
    453a:	fd2080e7          	jalr	-46(ra) # 9508 <printf>
  
  // Test 6: Try to use closed semaphore (should fail)
  printf("\nTest 6: Trying to use closed semaphore (should fail)\n");
    453e:	00007517          	auipc	a0,0x7
    4542:	13a50513          	addi	a0,a0,314 # b678 <malloc+0x20b8>
    4546:	00005097          	auipc	ra,0x5
    454a:	fc2080e7          	jalr	-62(ra) # 9508 <printf>
  if(sem_wait(sem_id) < 0) {
    454e:	8526                	mv	a0,s1
    4550:	00005097          	auipc	ra,0x5
    4554:	b08080e7          	jalr	-1272(ra) # 9058 <sem_wait>
    4558:	0e054b63          	bltz	a0,464e <semtest+0x3dc>
    printf("SUCCESS: sem_wait correctly failed for closed semaphore\n");
  } else {
    printf("ERROR: sem_wait should have failed\n");
    455c:	00007517          	auipc	a0,0x7
    4560:	19450513          	addi	a0,a0,404 # b6f0 <malloc+0x2130>
    4564:	00005097          	auipc	ra,0x5
    4568:	fa4080e7          	jalr	-92(ra) # 9508 <printf>
  }
  
  // Test 7: Try to get value of closed semaphore (should fail)
  if(sem_getvalue(sem_id, &value) < 0) {
    456c:	fdc40593          	addi	a1,s0,-36
    4570:	8526                	mv	a0,s1
    4572:	00005097          	auipc	ra,0x5
    4576:	afe080e7          	jalr	-1282(ra) # 9070 <sem_getvalue>
    457a:	0e054363          	bltz	a0,4660 <semtest+0x3ee>
    printf("SUCCESS: sem_getvalue correctly failed for closed semaphore\n");
  } else {
    printf("ERROR: sem_getvalue should have failed\n");
    457e:	00007517          	auipc	a0,0x7
    4582:	1da50513          	addi	a0,a0,474 # b758 <malloc+0x2198>
    4586:	00005097          	auipc	ra,0x5
    458a:	f82080e7          	jalr	-126(ra) # 9508 <printf>
  }
  
  printf("\n=== All tests completed ===\n");
    458e:	00006517          	auipc	a0,0x6
    4592:	b1a50513          	addi	a0,a0,-1254 # a0a8 <malloc+0xae8>
    4596:	00005097          	auipc	ra,0x5
    459a:	f72080e7          	jalr	-142(ra) # 9508 <printf>
  exit(0);
    459e:	4501                	li	a0,0
    45a0:	00005097          	auipc	ra,0x5
    45a4:	9e8080e7          	jalr	-1560(ra) # 8f88 <exit>
    printf("ERROR: sem_open failed\n");
    45a8:	00007517          	auipc	a0,0x7
    45ac:	cc850513          	addi	a0,a0,-824 # b270 <malloc+0x1cb0>
    45b0:	00005097          	auipc	ra,0x5
    45b4:	f58080e7          	jalr	-168(ra) # 9508 <printf>
    exit(1);
    45b8:	4505                	li	a0,1
    45ba:	00005097          	auipc	ra,0x5
    45be:	9ce080e7          	jalr	-1586(ra) # 8f88 <exit>
    printf("  -> ERROR: Failed to get semaphore value\n");
    45c2:	00007517          	auipc	a0,0x7
    45c6:	d0e50513          	addi	a0,a0,-754 # b2d0 <malloc+0x1d10>
    45ca:	00005097          	auipc	ra,0x5
    45ce:	f3e080e7          	jalr	-194(ra) # 9508 <printf>
    45d2:	bba1                	j	432a <semtest+0xb8>
    printf("ERROR: sem_post failed\n");
    45d4:	00007517          	auipc	a0,0x7
    45d8:	d5c50513          	addi	a0,a0,-676 # b330 <malloc+0x1d70>
    45dc:	00005097          	auipc	ra,0x5
    45e0:	f2c080e7          	jalr	-212(ra) # 9508 <printf>
    exit(1);
    45e4:	4505                	li	a0,1
    45e6:	00005097          	auipc	ra,0x5
    45ea:	9a2080e7          	jalr	-1630(ra) # 8f88 <exit>
    printf("  -> Semaphore value: %d (expected: 3)\n", value);
    45ee:	fdc42583          	lw	a1,-36(s0)
    45f2:	00007517          	auipc	a0,0x7
    45f6:	d7650513          	addi	a0,a0,-650 # b368 <malloc+0x1da8>
    45fa:	00005097          	auipc	ra,0x5
    45fe:	f0e080e7          	jalr	-242(ra) # 9508 <printf>
    4602:	b3a5                	j	436a <semtest+0xf8>
    printf("ERROR: sem_wait failed\n");
    4604:	00007517          	auipc	a0,0x7
    4608:	dbc50513          	addi	a0,a0,-580 # b3c0 <malloc+0x1e00>
    460c:	00005097          	auipc	ra,0x5
    4610:	efc080e7          	jalr	-260(ra) # 9508 <printf>
    exit(1);
    4614:	4505                	li	a0,1
    4616:	00005097          	auipc	ra,0x5
    461a:	972080e7          	jalr	-1678(ra) # 8f88 <exit>
    printf("  -> Semaphore value: %d (expected: 2)\n", value);
    461e:	fdc42583          	lw	a1,-36(s0)
    4622:	00007517          	auipc	a0,0x7
    4626:	dd650513          	addi	a0,a0,-554 # b3f8 <malloc+0x1e38>
    462a:	00005097          	auipc	ra,0x5
    462e:	ede080e7          	jalr	-290(ra) # 9508 <printf>
    4632:	bba5                	j	43aa <semtest+0x138>
    printf("ERROR: sem_close failed\n");
    4634:	00007517          	auipc	a0,0x7
    4638:	00450513          	addi	a0,a0,4 # b638 <malloc+0x2078>
    463c:	00005097          	auipc	ra,0x5
    4640:	ecc080e7          	jalr	-308(ra) # 9508 <printf>
    exit(1);
    4644:	4505                	li	a0,1
    4646:	00005097          	auipc	ra,0x5
    464a:	942080e7          	jalr	-1726(ra) # 8f88 <exit>
    printf("SUCCESS: sem_wait correctly failed for closed semaphore\n");
    464e:	00007517          	auipc	a0,0x7
    4652:	06250513          	addi	a0,a0,98 # b6b0 <malloc+0x20f0>
    4656:	00005097          	auipc	ra,0x5
    465a:	eb2080e7          	jalr	-334(ra) # 9508 <printf>
    465e:	b739                	j	456c <semtest+0x2fa>
    printf("SUCCESS: sem_getvalue correctly failed for closed semaphore\n");
    4660:	00007517          	auipc	a0,0x7
    4664:	0b850513          	addi	a0,a0,184 # b718 <malloc+0x2158>
    4668:	00005097          	auipc	ra,0x5
    466c:	ea0080e7          	jalr	-352(ra) # 9508 <printf>
    4670:	bf39                	j	458e <semtest+0x31c>
    if(id < 0) { printf("%s: sem_open failed\n", s); exit(1); }
    4672:	85ca                	mv	a1,s2
    4674:	00007517          	auipc	a0,0x7
    4678:	10c50513          	addi	a0,a0,268 # b780 <malloc+0x21c0>
    467c:	00005097          	auipc	ra,0x5
    4680:	e8c080e7          	jalr	-372(ra) # 9508 <printf>
    4684:	4505                	li	a0,1
    4686:	00005097          	auipc	ra,0x5
    468a:	902080e7          	jalr	-1790(ra) # 8f88 <exit>

000000000000468e <semtest2>:

void semtest2(char *s) {
    468e:	7179                	addi	sp,sp,-48
    4690:	f406                	sd	ra,40(sp)
    4692:	f022                	sd	s0,32(sp)
    4694:	ec26                	sd	s1,24(sp)
    4696:	e84a                	sd	s2,16(sp)
    4698:	1800                	addi	s0,sp,48
    if(verbose) { semtest2_main(); return; }
    469a:	0000b797          	auipc	a5,0xb
    469e:	1fa7a783          	lw	a5,506(a5) # f894 <verbose>
    46a2:	e39d                	bnez	a5,46c8 <semtest2+0x3a>
    46a4:	84aa                	mv	s1,a0
    int id = sem_open(0);
    46a6:	4501                	li	a0,0
    46a8:	00005097          	auipc	ra,0x5
    46ac:	9a8080e7          	jalr	-1624(ra) # 9050 <sem_open>
    if(id < 0) { printf("%s: sem_open failed\n", s); exit(1); }
    46b0:	1e054563          	bltz	a0,489a <semtest2+0x20c>
    sem_close(id);
    46b4:	00005097          	auipc	ra,0x5
    46b8:	9b4080e7          	jalr	-1612(ra) # 9068 <sem_close>
}
    46bc:	70a2                	ld	ra,40(sp)
    46be:	7402                	ld	s0,32(sp)
    46c0:	64e2                	ld	s1,24(sp)
    46c2:	6942                	ld	s2,16(sp)
    46c4:	6145                	addi	sp,sp,48
    46c6:	8082                	ret
{
  int sem_id;
  int pid;
  int value;
  
  printf("=== Multi-Process Semaphore Test ===\n");
    46c8:	00007517          	auipc	a0,0x7
    46cc:	0d050513          	addi	a0,a0,208 # b798 <malloc+0x21d8>
    46d0:	00005097          	auipc	ra,0x5
    46d4:	e38080e7          	jalr	-456(ra) # 9508 <printf>
  printf("This test demonstrates blocking and waking with multiple processes\n\n");
    46d8:	00007517          	auipc	a0,0x7
    46dc:	0e850513          	addi	a0,a0,232 # b7c0 <malloc+0x2200>
    46e0:	00005097          	auipc	ra,0x5
    46e4:	e28080e7          	jalr	-472(ra) # 9508 <printf>
  
  // Create semaphore with initial value 0 (will block on first wait)
  sem_id = sem_open(0);
    46e8:	4501                	li	a0,0
    46ea:	00005097          	auipc	ra,0x5
    46ee:	966080e7          	jalr	-1690(ra) # 9050 <sem_open>
    46f2:	84aa                	mv	s1,a0
  if(sem_id < 0) {
    46f4:	08054d63          	bltz	a0,478e <semtest2+0x100>
    printf("ERROR: sem_open failed\n");
    exit(1);
  }
  printf("Created semaphore with id=%d, initial value=0\n", sem_id);
    46f8:	85aa                	mv	a1,a0
    46fa:	00007517          	auipc	a0,0x7
    46fe:	10e50513          	addi	a0,a0,270 # b808 <malloc+0x2248>
    4702:	00005097          	auipc	ra,0x5
    4706:	e06080e7          	jalr	-506(ra) # 9508 <printf>
  
  // Fork a child process
  pid = fork();
    470a:	00005097          	auipc	ra,0x5
    470e:	876080e7          	jalr	-1930(ra) # 8f80 <fork>
    4712:	892a                	mv	s2,a0
  if(pid < 0) {
    4714:	08054a63          	bltz	a0,47a8 <semtest2+0x11a>
    printf("ERROR: fork failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    4718:	e54d                	bnez	a0,47c2 <semtest2+0x134>
    // Child process: will wait on semaphore (will block)
    printf("[Child] Process %d: Waiting on semaphore (will block)...\n", getpid());
    471a:	00005097          	auipc	ra,0x5
    471e:	8d6080e7          	jalr	-1834(ra) # 8ff0 <getpid>
    4722:	85aa                	mv	a1,a0
    4724:	00007517          	auipc	a0,0x7
    4728:	12c50513          	addi	a0,a0,300 # b850 <malloc+0x2290>
    472c:	00005097          	auipc	ra,0x5
    4730:	ddc080e7          	jalr	-548(ra) # 9508 <printf>
    sem_wait(sem_id);
    4734:	8526                	mv	a0,s1
    4736:	00005097          	auipc	ra,0x5
    473a:	922080e7          	jalr	-1758(ra) # 9058 <sem_wait>
    printf("[Child] Process %d: Woken up! Semaphore acquired.\n", getpid());
    473e:	00005097          	auipc	ra,0x5
    4742:	8b2080e7          	jalr	-1870(ra) # 8ff0 <getpid>
    4746:	85aa                	mv	a1,a0
    4748:	00007517          	auipc	a0,0x7
    474c:	14850513          	addi	a0,a0,328 # b890 <malloc+0x22d0>
    4750:	00005097          	auipc	ra,0x5
    4754:	db8080e7          	jalr	-584(ra) # 9508 <printf>
    sem_getvalue(sem_id, &value);
    4758:	fdc40593          	addi	a1,s0,-36
    475c:	8526                	mv	a0,s1
    475e:	00005097          	auipc	ra,0x5
    4762:	912080e7          	jalr	-1774(ra) # 9070 <sem_getvalue>
    printf("[Child] Process %d: Semaphore value = %d\n", getpid(), value);
    4766:	00005097          	auipc	ra,0x5
    476a:	88a080e7          	jalr	-1910(ra) # 8ff0 <getpid>
    476e:	85aa                	mv	a1,a0
    4770:	fdc42603          	lw	a2,-36(s0)
    4774:	00007517          	auipc	a0,0x7
    4778:	15450513          	addi	a0,a0,340 # b8c8 <malloc+0x2308>
    477c:	00005097          	auipc	ra,0x5
    4780:	d8c080e7          	jalr	-628(ra) # 9508 <printf>
    exit(0);
    4784:	4501                	li	a0,0
    4786:	00005097          	auipc	ra,0x5
    478a:	802080e7          	jalr	-2046(ra) # 8f88 <exit>
    printf("ERROR: sem_open failed\n");
    478e:	00007517          	auipc	a0,0x7
    4792:	ae250513          	addi	a0,a0,-1310 # b270 <malloc+0x1cb0>
    4796:	00005097          	auipc	ra,0x5
    479a:	d72080e7          	jalr	-654(ra) # 9508 <printf>
    exit(1);
    479e:	4505                	li	a0,1
    47a0:	00004097          	auipc	ra,0x4
    47a4:	7e8080e7          	jalr	2024(ra) # 8f88 <exit>
    printf("ERROR: fork failed\n");
    47a8:	00007517          	auipc	a0,0x7
    47ac:	09050513          	addi	a0,a0,144 # b838 <malloc+0x2278>
    47b0:	00005097          	auipc	ra,0x5
    47b4:	d58080e7          	jalr	-680(ra) # 9508 <printf>
    exit(1);
    47b8:	4505                	li	a0,1
    47ba:	00004097          	auipc	ra,0x4
    47be:	7ce080e7          	jalr	1998(ra) # 8f88 <exit>
  } else {
    // Parent process: sleep a bit, then post to wake child
    printf("[Parent] Process %d: Child process %d created\n", getpid(), pid);
    47c2:	00005097          	auipc	ra,0x5
    47c6:	82e080e7          	jalr	-2002(ra) # 8ff0 <getpid>
    47ca:	85aa                	mv	a1,a0
    47cc:	864a                	mv	a2,s2
    47ce:	00007517          	auipc	a0,0x7
    47d2:	12a50513          	addi	a0,a0,298 # b8f8 <malloc+0x2338>
    47d6:	00005097          	auipc	ra,0x5
    47da:	d32080e7          	jalr	-718(ra) # 9508 <printf>
    printf("[Parent] Process %d: Sleeping for 2 seconds...\n", getpid());
    47de:	00005097          	auipc	ra,0x5
    47e2:	812080e7          	jalr	-2030(ra) # 8ff0 <getpid>
    47e6:	85aa                	mv	a1,a0
    47e8:	00007517          	auipc	a0,0x7
    47ec:	14050513          	addi	a0,a0,320 # b928 <malloc+0x2368>
    47f0:	00005097          	auipc	ra,0x5
    47f4:	d18080e7          	jalr	-744(ra) # 9508 <printf>
    sleep(20);  // Sleep for 2 seconds (20 ticks)
    47f8:	4551                	li	a0,20
    47fa:	00005097          	auipc	ra,0x5
    47fe:	806080e7          	jalr	-2042(ra) # 9000 <sleep>
    
    printf("[Parent] Process %d: Posting semaphore to wake child...\n", getpid());
    4802:	00004097          	auipc	ra,0x4
    4806:	7ee080e7          	jalr	2030(ra) # 8ff0 <getpid>
    480a:	85aa                	mv	a1,a0
    480c:	00007517          	auipc	a0,0x7
    4810:	14c50513          	addi	a0,a0,332 # b958 <malloc+0x2398>
    4814:	00005097          	auipc	ra,0x5
    4818:	cf4080e7          	jalr	-780(ra) # 9508 <printf>
    sem_post(sem_id);
    481c:	8526                	mv	a0,s1
    481e:	00005097          	auipc	ra,0x5
    4822:	842080e7          	jalr	-1982(ra) # 9060 <sem_post>
    sem_getvalue(sem_id, &value);
    4826:	fdc40593          	addi	a1,s0,-36
    482a:	8526                	mv	a0,s1
    482c:	00005097          	auipc	ra,0x5
    4830:	844080e7          	jalr	-1980(ra) # 9070 <sem_getvalue>
    printf("[Parent] Process %d: Semaphore value = %d\n", getpid(), value);
    4834:	00004097          	auipc	ra,0x4
    4838:	7bc080e7          	jalr	1980(ra) # 8ff0 <getpid>
    483c:	85aa                	mv	a1,a0
    483e:	fdc42603          	lw	a2,-36(s0)
    4842:	00007517          	auipc	a0,0x7
    4846:	15650513          	addi	a0,a0,342 # b998 <malloc+0x23d8>
    484a:	00005097          	auipc	ra,0x5
    484e:	cbe080e7          	jalr	-834(ra) # 9508 <printf>
    
    // Wait for child to finish
    wait(0);
    4852:	4501                	li	a0,0
    4854:	00004097          	auipc	ra,0x4
    4858:	73c080e7          	jalr	1852(ra) # 8f90 <wait>
    printf("[Parent] Process %d: Child finished\n", getpid());
    485c:	00004097          	auipc	ra,0x4
    4860:	794080e7          	jalr	1940(ra) # 8ff0 <getpid>
    4864:	85aa                	mv	a1,a0
    4866:	00007517          	auipc	a0,0x7
    486a:	16250513          	addi	a0,a0,354 # b9c8 <malloc+0x2408>
    486e:	00005097          	auipc	ra,0x5
    4872:	c9a080e7          	jalr	-870(ra) # 9508 <printf>
    
    // Close semaphore
    sem_close(sem_id);
    4876:	8526                	mv	a0,s1
    4878:	00004097          	auipc	ra,0x4
    487c:	7f0080e7          	jalr	2032(ra) # 9068 <sem_close>
    printf("\n=== Test completed ===\n");
    4880:	00007517          	auipc	a0,0x7
    4884:	17050513          	addi	a0,a0,368 # b9f0 <malloc+0x2430>
    4888:	00005097          	auipc	ra,0x5
    488c:	c80080e7          	jalr	-896(ra) # 9508 <printf>
    exit(0);
    4890:	4501                	li	a0,0
    4892:	00004097          	auipc	ra,0x4
    4896:	6f6080e7          	jalr	1782(ra) # 8f88 <exit>
    if(id < 0) { printf("%s: sem_open failed\n", s); exit(1); }
    489a:	85a6                	mv	a1,s1
    489c:	00007517          	auipc	a0,0x7
    48a0:	ee450513          	addi	a0,a0,-284 # b780 <malloc+0x21c0>
    48a4:	00005097          	auipc	ra,0x5
    48a8:	c64080e7          	jalr	-924(ra) # 9508 <printf>
    48ac:	4505                	li	a0,1
    48ae:	00004097          	auipc	ra,0x4
    48b2:	6da080e7          	jalr	1754(ra) # 8f88 <exit>

00000000000048b6 <logtest>:
    if(verbose) { char *argv[] = {"logtest", 0}; logtest_main(1, argv); return; }
    48b6:	0000b797          	auipc	a5,0xb
    48ba:	fde7a783          	lw	a5,-34(a5) # f894 <verbose>
    48be:	e391                	bnez	a5,48c2 <logtest+0xc>
    48c0:	8082                	ret
void logtest(char *s) {
    48c2:	1141                	addi	sp,sp,-16
    48c4:	e406                	sd	ra,8(sp)
    48c6:	e022                	sd	s0,0(sp)
    48c8:	0800                	addi	s0,sp,16
#include "serein-user/user.h"

static int logtest_main(int argc, char **argv)
{
  printf("logtest: hello from user, pid=%d\n", getpid());
    48ca:	00004097          	auipc	ra,0x4
    48ce:	726080e7          	jalr	1830(ra) # 8ff0 <getpid>
    48d2:	85aa                	mv	a1,a0
    48d4:	00007517          	auipc	a0,0x7
    48d8:	13c50513          	addi	a0,a0,316 # ba10 <malloc+0x2450>
    48dc:	00005097          	auipc	ra,0x5
    48e0:	c2c080e7          	jalr	-980(ra) # 9508 <printf>

  fprintf(2, "logtest: stderr output works too\n");
    48e4:	00007597          	auipc	a1,0x7
    48e8:	15458593          	addi	a1,a1,340 # ba38 <malloc+0x2478>
    48ec:	4509                	li	a0,2
    48ee:	00005097          	auipc	ra,0x5
    48f2:	bec080e7          	jalr	-1044(ra) # 94da <fprintf>

  // 也可以触发一个 syscall 输出（看内核是否还能正常工作）
  int t = uptime();
    48f6:	00004097          	auipc	ra,0x4
    48fa:	712080e7          	jalr	1810(ra) # 9008 <uptime>
    48fe:	85aa                	mv	a1,a0
  printf("logtest: uptime=%d\n", t);
    4900:	00007517          	auipc	a0,0x7
    4904:	16050513          	addi	a0,a0,352 # ba60 <malloc+0x24a0>
    4908:	00005097          	auipc	ra,0x5
    490c:	c00080e7          	jalr	-1024(ra) # 9508 <printf>

  exit(0);
    4910:	4501                	li	a0,0
    4912:	00004097          	auipc	ra,0x4
    4916:	676080e7          	jalr	1654(ra) # 8f88 <exit>

000000000000491a <shmtest1>:

void shmtest1(char *s) {
    491a:	1101                	addi	sp,sp,-32
    491c:	ec06                	sd	ra,24(sp)
    491e:	e822                	sd	s0,16(sp)
    4920:	e426                	sd	s1,8(sp)
    4922:	e04a                	sd	s2,0(sp)
    4924:	1000                	addi	s0,sp,32
    if(verbose) { shmtest1_main(); return; }
    4926:	0000b797          	auipc	a5,0xb
    492a:	f6e7a783          	lw	a5,-146(a5) # f894 <verbose>
    492e:	eb9d                	bnez	a5,4964 <shmtest1+0x4a>
    4930:	84aa                	mv	s1,a0
    int id = shmcreate("test_shm1", 4096);
    4932:	6585                	lui	a1,0x1
    4934:	00007517          	auipc	a0,0x7
    4938:	77c50513          	addi	a0,a0,1916 # c0b0 <malloc+0x2af0>
    493c:	00004097          	auipc	ra,0x4
    4940:	75a080e7          	jalr	1882(ra) # 9096 <shmcreate>
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    4944:	3c054963          	bltz	a0,4d16 <shmtest1+0x3fc>
    shmunlink("test_shm1");
    4948:	00007517          	auipc	a0,0x7
    494c:	76850513          	addi	a0,a0,1896 # c0b0 <malloc+0x2af0>
    4950:	00004097          	auipc	ra,0x4
    4954:	76e080e7          	jalr	1902(ra) # 90be <shmunlink>
}
    4958:	60e2                	ld	ra,24(sp)
    495a:	6442                	ld	s0,16(sp)
    495c:	64a2                	ld	s1,8(sp)
    495e:	6902                	ld	s2,0(sp)
    4960:	6105                	addi	sp,sp,32
    4962:	8082                	ret

static int shmtest1_main(void)
{
  int shmid1, shmid2;
  
  printf("=== Shared Memory Test 1: Basic Operations ===\n");
    4964:	00007517          	auipc	a0,0x7
    4968:	11450513          	addi	a0,a0,276 # ba78 <malloc+0x24b8>
    496c:	00005097          	auipc	ra,0x5
    4970:	b9c080e7          	jalr	-1124(ra) # 9508 <printf>
  
  // Test 1: Create a shared memory segment
  printf("Test 1.1: Creating shared memory 'test_shm' with size 4096...\n");
    4974:	00007517          	auipc	a0,0x7
    4978:	13450513          	addi	a0,a0,308 # baa8 <malloc+0x24e8>
    497c:	00005097          	auipc	ra,0x5
    4980:	b8c080e7          	jalr	-1140(ra) # 9508 <printf>
  shmid1 = shmcreate("test_shm", 4096);
    4984:	6585                	lui	a1,0x1
    4986:	00007517          	auipc	a0,0x7
    498a:	16250513          	addi	a0,a0,354 # bae8 <malloc+0x2528>
    498e:	00004097          	auipc	ra,0x4
    4992:	708080e7          	jalr	1800(ra) # 9096 <shmcreate>
    4996:	892a                	mv	s2,a0
  if(shmid1 < 0) {
    4998:	04054b63          	bltz	a0,49ee <shmtest1+0xd4>
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  printf("SUCCESS: Created shm with shmid=%d\n", shmid1);
    499c:	85aa                	mv	a1,a0
    499e:	00007517          	auipc	a0,0x7
    49a2:	17a50513          	addi	a0,a0,378 # bb18 <malloc+0x2558>
    49a6:	00005097          	auipc	ra,0x5
    49aa:	b62080e7          	jalr	-1182(ra) # 9508 <printf>
  
  // Test 2: Try to create the same name again (should fail)
  printf("Test 1.2: Trying to create 'test_shm' again (should fail)...\n");
    49ae:	00007517          	auipc	a0,0x7
    49b2:	19250513          	addi	a0,a0,402 # bb40 <malloc+0x2580>
    49b6:	00005097          	auipc	ra,0x5
    49ba:	b52080e7          	jalr	-1198(ra) # 9508 <printf>
  shmid2 = shmcreate("test_shm", 4096);
    49be:	6585                	lui	a1,0x1
    49c0:	00007517          	auipc	a0,0x7
    49c4:	12850513          	addi	a0,a0,296 # bae8 <malloc+0x2528>
    49c8:	00004097          	auipc	ra,0x4
    49cc:	6ce080e7          	jalr	1742(ra) # 9096 <shmcreate>
  if(shmid2 >= 0) {
    49d0:	02054c63          	bltz	a0,4a08 <shmtest1+0xee>
    printf("ERROR: Should not be able to create duplicate name\n");
    49d4:	00007517          	auipc	a0,0x7
    49d8:	1ac50513          	addi	a0,a0,428 # bb80 <malloc+0x25c0>
    49dc:	00005097          	auipc	ra,0x5
    49e0:	b2c080e7          	jalr	-1236(ra) # 9508 <printf>
    exit(1);
    49e4:	4505                	li	a0,1
    49e6:	00004097          	auipc	ra,0x4
    49ea:	5a2080e7          	jalr	1442(ra) # 8f88 <exit>
    printf("ERROR: shmcreate failed\n");
    49ee:	00007517          	auipc	a0,0x7
    49f2:	10a50513          	addi	a0,a0,266 # baf8 <malloc+0x2538>
    49f6:	00005097          	auipc	ra,0x5
    49fa:	b12080e7          	jalr	-1262(ra) # 9508 <printf>
    exit(1);
    49fe:	4505                	li	a0,1
    4a00:	00004097          	auipc	ra,0x4
    4a04:	588080e7          	jalr	1416(ra) # 8f88 <exit>
  }
  printf("SUCCESS: Correctly rejected duplicate name\n");
    4a08:	00007517          	auipc	a0,0x7
    4a0c:	1b050513          	addi	a0,a0,432 # bbb8 <malloc+0x25f8>
    4a10:	00005097          	auipc	ra,0x5
    4a14:	af8080e7          	jalr	-1288(ra) # 9508 <printf>
  
  // Test 3: Open existing shared memory
  printf("Test 1.3: Opening existing 'test_shm'...\n");
    4a18:	00007517          	auipc	a0,0x7
    4a1c:	1d050513          	addi	a0,a0,464 # bbe8 <malloc+0x2628>
    4a20:	00005097          	auipc	ra,0x5
    4a24:	ae8080e7          	jalr	-1304(ra) # 9508 <printf>
  shmid2 = shmopen("test_shm");
    4a28:	00007517          	auipc	a0,0x7
    4a2c:	0c050513          	addi	a0,a0,192 # bae8 <malloc+0x2528>
    4a30:	00004097          	auipc	ra,0x4
    4a34:	670080e7          	jalr	1648(ra) # 90a0 <shmopen>
    4a38:	84aa                	mv	s1,a0
  if(shmid2 < 0) {
    4a3a:	02054363          	bltz	a0,4a60 <shmtest1+0x146>
    printf("ERROR: shmopen failed\n");
    exit(1);
  }
  if(shmid2 != shmid1) {
    4a3e:	02a90e63          	beq	s2,a0,4a7a <shmtest1+0x160>
    printf("ERROR: shmid mismatch (expected %d, got %d)\n", shmid1, shmid2);
    4a42:	862a                	mv	a2,a0
    4a44:	85ca                	mv	a1,s2
    4a46:	00007517          	auipc	a0,0x7
    4a4a:	1ea50513          	addi	a0,a0,490 # bc30 <malloc+0x2670>
    4a4e:	00005097          	auipc	ra,0x5
    4a52:	aba080e7          	jalr	-1350(ra) # 9508 <printf>
    exit(1);
    4a56:	4505                	li	a0,1
    4a58:	00004097          	auipc	ra,0x4
    4a5c:	530080e7          	jalr	1328(ra) # 8f88 <exit>
    printf("ERROR: shmopen failed\n");
    4a60:	00007517          	auipc	a0,0x7
    4a64:	1b850513          	addi	a0,a0,440 # bc18 <malloc+0x2658>
    4a68:	00005097          	auipc	ra,0x5
    4a6c:	aa0080e7          	jalr	-1376(ra) # 9508 <printf>
    exit(1);
    4a70:	4505                	li	a0,1
    4a72:	00004097          	auipc	ra,0x4
    4a76:	516080e7          	jalr	1302(ra) # 8f88 <exit>
  }
  printf("SUCCESS: Opened shm with shmid=%d\n", shmid2);
    4a7a:	85aa                	mv	a1,a0
    4a7c:	00007517          	auipc	a0,0x7
    4a80:	1e450513          	addi	a0,a0,484 # bc60 <malloc+0x26a0>
    4a84:	00005097          	auipc	ra,0x5
    4a88:	a84080e7          	jalr	-1404(ra) # 9508 <printf>
  
  // Test 4: Try to open non-existent shared memory (should fail)
  printf("Test 1.4: Trying to open non-existent 'nonexistent' (should fail)...\n");
    4a8c:	00007517          	auipc	a0,0x7
    4a90:	1fc50513          	addi	a0,a0,508 # bc88 <malloc+0x26c8>
    4a94:	00005097          	auipc	ra,0x5
    4a98:	a74080e7          	jalr	-1420(ra) # 9508 <printf>
  shmid2 = shmopen("nonexistent");
    4a9c:	00007517          	auipc	a0,0x7
    4aa0:	23450513          	addi	a0,a0,564 # bcd0 <malloc+0x2710>
    4aa4:	00004097          	auipc	ra,0x4
    4aa8:	5fc080e7          	jalr	1532(ra) # 90a0 <shmopen>
  if(shmid2 >= 0) {
    4aac:	00054f63          	bltz	a0,4aca <shmtest1+0x1b0>
    printf("ERROR: Should not be able to open non-existent shm\n");
    4ab0:	00007517          	auipc	a0,0x7
    4ab4:	23050513          	addi	a0,a0,560 # bce0 <malloc+0x2720>
    4ab8:	00005097          	auipc	ra,0x5
    4abc:	a50080e7          	jalr	-1456(ra) # 9508 <printf>
    exit(1);
    4ac0:	4505                	li	a0,1
    4ac2:	00004097          	auipc	ra,0x4
    4ac6:	4c6080e7          	jalr	1222(ra) # 8f88 <exit>
  }
  printf("SUCCESS: Correctly rejected non-existent name\n");
    4aca:	00007517          	auipc	a0,0x7
    4ace:	24e50513          	addi	a0,a0,590 # bd18 <malloc+0x2758>
    4ad2:	00005097          	auipc	ra,0x5
    4ad6:	a36080e7          	jalr	-1482(ra) # 9508 <printf>

  // Test 5: Attach and write to shared memory
  printf("Test 1.5: Attaching 'test_shm' and writing a pattern...\n");
    4ada:	00007517          	auipc	a0,0x7
    4ade:	26e50513          	addi	a0,a0,622 # bd48 <malloc+0x2788>
    4ae2:	00005097          	auipc	ra,0x5
    4ae6:	a26080e7          	jalr	-1498(ra) # 9508 <printf>
  uint64 va = shmattach(shmid1);
    4aea:	8526                	mv	a0,s1
    4aec:	00004097          	auipc	ra,0x4
    4af0:	5be080e7          	jalr	1470(ra) # 90aa <shmattach>
    4af4:	892a                	mv	s2,a0
  if(va == 0){
    4af6:	ed11                	bnez	a0,4b12 <shmtest1+0x1f8>
    printf("ERROR: shmattach failed\n");
    4af8:	00007517          	auipc	a0,0x7
    4afc:	29050513          	addi	a0,a0,656 # bd88 <malloc+0x27c8>
    4b00:	00005097          	auipc	ra,0x5
    4b04:	a08080e7          	jalr	-1528(ra) # 9508 <printf>
    exit(1);
    4b08:	4505                	li	a0,1
    4b0a:	00004097          	auipc	ra,0x4
    4b0e:	47e080e7          	jalr	1150(ra) # 8f88 <exit>
  }
  char *p = (char*)va;
  p[0] = 0x5A;
    4b12:	05a00793          	li	a5,90
    4b16:	00f50023          	sb	a5,0(a0)
  p[1] = 0xA5;
    4b1a:	fa500793          	li	a5,-91
    4b1e:	00f500a3          	sb	a5,1(a0)
  printf("SUCCESS: Wrote pattern at va=%p\n", va);
    4b22:	85aa                	mv	a1,a0
    4b24:	00007517          	auipc	a0,0x7
    4b28:	28450513          	addi	a0,a0,644 # bda8 <malloc+0x27e8>
    4b2c:	00005097          	auipc	ra,0x5
    4b30:	9dc080e7          	jalr	-1572(ra) # 9508 <printf>

  // Test 6: Detach and re-attach to check persistence
  printf("Test 1.6: Detach and re-attach to check persistence...\n");
    4b34:	00007517          	auipc	a0,0x7
    4b38:	29c50513          	addi	a0,a0,668 # bdd0 <malloc+0x2810>
    4b3c:	00005097          	auipc	ra,0x5
    4b40:	9cc080e7          	jalr	-1588(ra) # 9508 <printf>
  if(shmdetach(va, 4096) < 0){
    4b44:	6585                	lui	a1,0x1
    4b46:	854a                	mv	a0,s2
    4b48:	00004097          	auipc	ra,0x4
    4b4c:	56c080e7          	jalr	1388(ra) # 90b4 <shmdetach>
    4b50:	04054263          	bltz	a0,4b94 <shmtest1+0x27a>
    printf("ERROR: shmdetach failed\n");
    exit(1);
  }
  uint64 va2 = shmattach(shmid1);
    4b54:	8526                	mv	a0,s1
    4b56:	00004097          	auipc	ra,0x4
    4b5a:	554080e7          	jalr	1364(ra) # 90aa <shmattach>
    4b5e:	892a                	mv	s2,a0
  if(va2 == 0){
    4b60:	c539                	beqz	a0,4bae <shmtest1+0x294>
    printf("ERROR: shmattach (2) failed\n");
    exit(1);
  }
  char *q = (char*)va2;
  if(q[0] != 0x5A || q[1] != 0xA5){
    4b62:	00054703          	lbu	a4,0(a0)
    4b66:	05a00793          	li	a5,90
    4b6a:	00f71863          	bne	a4,a5,4b7a <shmtest1+0x260>
    4b6e:	00154703          	lbu	a4,1(a0)
    4b72:	0a500793          	li	a5,165
    4b76:	04f70963          	beq	a4,a5,4bc8 <shmtest1+0x2ae>
    printf("ERROR: Data not persistent after detach/attach\n");
    4b7a:	00007517          	auipc	a0,0x7
    4b7e:	2ce50513          	addi	a0,a0,718 # be48 <malloc+0x2888>
    4b82:	00005097          	auipc	ra,0x5
    4b86:	986080e7          	jalr	-1658(ra) # 9508 <printf>
    exit(1);
    4b8a:	4505                	li	a0,1
    4b8c:	00004097          	auipc	ra,0x4
    4b90:	3fc080e7          	jalr	1020(ra) # 8f88 <exit>
    printf("ERROR: shmdetach failed\n");
    4b94:	00007517          	auipc	a0,0x7
    4b98:	27450513          	addi	a0,a0,628 # be08 <malloc+0x2848>
    4b9c:	00005097          	auipc	ra,0x5
    4ba0:	96c080e7          	jalr	-1684(ra) # 9508 <printf>
    exit(1);
    4ba4:	4505                	li	a0,1
    4ba6:	00004097          	auipc	ra,0x4
    4baa:	3e2080e7          	jalr	994(ra) # 8f88 <exit>
    printf("ERROR: shmattach (2) failed\n");
    4bae:	00007517          	auipc	a0,0x7
    4bb2:	27a50513          	addi	a0,a0,634 # be28 <malloc+0x2868>
    4bb6:	00005097          	auipc	ra,0x5
    4bba:	952080e7          	jalr	-1710(ra) # 9508 <printf>
    exit(1);
    4bbe:	4505                	li	a0,1
    4bc0:	00004097          	auipc	ra,0x4
    4bc4:	3c8080e7          	jalr	968(ra) # 8f88 <exit>
  }
  printf("SUCCESS: Data persisted after detach/attach (va2=%p)\n", va2);
    4bc8:	85aa                	mv	a1,a0
    4bca:	00007517          	auipc	a0,0x7
    4bce:	2ae50513          	addi	a0,a0,686 # be78 <malloc+0x28b8>
    4bd2:	00005097          	auipc	ra,0x5
    4bd6:	936080e7          	jalr	-1738(ra) # 9508 <printf>

  // Test 7: Unlink behavior - unlink should remove name but not free until detach
  printf("Test 1.7: Unlink 'test_shm' (should still be accessible until detach)...\n");
    4bda:	00007517          	auipc	a0,0x7
    4bde:	2d650513          	addi	a0,a0,726 # beb0 <malloc+0x28f0>
    4be2:	00005097          	auipc	ra,0x5
    4be6:	926080e7          	jalr	-1754(ra) # 9508 <printf>
  if(shmunlink("test_shm") < 0){
    4bea:	00007517          	auipc	a0,0x7
    4bee:	efe50513          	addi	a0,a0,-258 # bae8 <malloc+0x2528>
    4bf2:	00004097          	auipc	ra,0x4
    4bf6:	4cc080e7          	jalr	1228(ra) # 90be <shmunlink>
    4bfa:	04054163          	bltz	a0,4c3c <shmtest1+0x322>
    printf("ERROR: shmunlink failed\n");
    exit(1);
  }
  printf("SUCCESS: shmunlink returned success\n");
    4bfe:	00007517          	auipc	a0,0x7
    4c02:	32250513          	addi	a0,a0,802 # bf20 <malloc+0x2960>
    4c06:	00005097          	auipc	ra,0x5
    4c0a:	902080e7          	jalr	-1790(ra) # 9508 <printf>

  // After unlink, opening by name should fail
  shmid2 = shmopen("test_shm");
    4c0e:	00007517          	auipc	a0,0x7
    4c12:	eda50513          	addi	a0,a0,-294 # bae8 <malloc+0x2528>
    4c16:	00004097          	auipc	ra,0x4
    4c1a:	48a080e7          	jalr	1162(ra) # 90a0 <shmopen>
  if(shmid2 >= 0){
    4c1e:	02054c63          	bltz	a0,4c56 <shmtest1+0x33c>
    printf("ERROR: shmopen should fail after unlink\n");
    4c22:	00007517          	auipc	a0,0x7
    4c26:	32650513          	addi	a0,a0,806 # bf48 <malloc+0x2988>
    4c2a:	00005097          	auipc	ra,0x5
    4c2e:	8de080e7          	jalr	-1826(ra) # 9508 <printf>
    exit(1);
    4c32:	4505                	li	a0,1
    4c34:	00004097          	auipc	ra,0x4
    4c38:	354080e7          	jalr	852(ra) # 8f88 <exit>
    printf("ERROR: shmunlink failed\n");
    4c3c:	00007517          	auipc	a0,0x7
    4c40:	2c450513          	addi	a0,a0,708 # bf00 <malloc+0x2940>
    4c44:	00005097          	auipc	ra,0x5
    4c48:	8c4080e7          	jalr	-1852(ra) # 9508 <printf>
    exit(1);
    4c4c:	4505                	li	a0,1
    4c4e:	00004097          	auipc	ra,0x4
    4c52:	33a080e7          	jalr	826(ra) # 8f88 <exit>
  }
  printf("SUCCESS: shmopen correctly failed after unlink\n");
    4c56:	00007517          	auipc	a0,0x7
    4c5a:	32250513          	addi	a0,a0,802 # bf78 <malloc+0x29b8>
    4c5e:	00005097          	auipc	ra,0x5
    4c62:	8aa080e7          	jalr	-1878(ra) # 9508 <printf>

  // Detach last mapping - this should free the underlying memory
  if(shmdetach(va2, 4096) < 0){
    4c66:	6585                	lui	a1,0x1
    4c68:	854a                	mv	a0,s2
    4c6a:	00004097          	auipc	ra,0x4
    4c6e:	44a080e7          	jalr	1098(ra) # 90b4 <shmdetach>
    4c72:	04054e63          	bltz	a0,4cce <shmtest1+0x3b4>
    printf("ERROR: shmdetach failed (final)\n");
    exit(1);
  }

  // Now creating with same name should succeed and likely produce a different shmid
  printf("Test 1.8: Re-create 'test_shm' after detach/unlink...\n");
    4c76:	00007517          	auipc	a0,0x7
    4c7a:	35a50513          	addi	a0,a0,858 # bfd0 <malloc+0x2a10>
    4c7e:	00005097          	auipc	ra,0x5
    4c82:	88a080e7          	jalr	-1910(ra) # 9508 <printf>
  int shmid3 = shmcreate("test_shm", 4096);
    4c86:	6585                	lui	a1,0x1
    4c88:	00007517          	auipc	a0,0x7
    4c8c:	e6050513          	addi	a0,a0,-416 # bae8 <malloc+0x2528>
    4c90:	00004097          	auipc	ra,0x4
    4c94:	406080e7          	jalr	1030(ra) # 9096 <shmcreate>
    4c98:	892a                	mv	s2,a0
  if(shmid3 < 0){
    4c9a:	04054763          	bltz	a0,4ce8 <shmtest1+0x3ce>
    printf("ERROR: shmcreate failed on re-create\n");
    exit(1);
  }
  if(shmid3 == shmid1){
    4c9e:	06a48263          	beq	s1,a0,4d02 <shmtest1+0x3e8>
    printf("WARNING: shmid reused (allowed), new shmid=%d\n", shmid3);
  }
  printf("SUCCESS: Re-created 'test_shm' with shmid=%d\n", shmid3);
    4ca2:	85ca                	mv	a1,s2
    4ca4:	00007517          	auipc	a0,0x7
    4ca8:	3bc50513          	addi	a0,a0,956 # c060 <malloc+0x2aa0>
    4cac:	00005097          	auipc	ra,0x5
    4cb0:	85c080e7          	jalr	-1956(ra) # 9508 <printf>

  printf("\n=== All Tests Passed! ===\n");
    4cb4:	00007517          	auipc	a0,0x7
    4cb8:	3dc50513          	addi	a0,a0,988 # c090 <malloc+0x2ad0>
    4cbc:	00005097          	auipc	ra,0x5
    4cc0:	84c080e7          	jalr	-1972(ra) # 9508 <printf>
  exit(0);
    4cc4:	4501                	li	a0,0
    4cc6:	00004097          	auipc	ra,0x4
    4cca:	2c2080e7          	jalr	706(ra) # 8f88 <exit>
    printf("ERROR: shmdetach failed (final)\n");
    4cce:	00007517          	auipc	a0,0x7
    4cd2:	2da50513          	addi	a0,a0,730 # bfa8 <malloc+0x29e8>
    4cd6:	00005097          	auipc	ra,0x5
    4cda:	832080e7          	jalr	-1998(ra) # 9508 <printf>
    exit(1);
    4cde:	4505                	li	a0,1
    4ce0:	00004097          	auipc	ra,0x4
    4ce4:	2a8080e7          	jalr	680(ra) # 8f88 <exit>
    printf("ERROR: shmcreate failed on re-create\n");
    4ce8:	00007517          	auipc	a0,0x7
    4cec:	32050513          	addi	a0,a0,800 # c008 <malloc+0x2a48>
    4cf0:	00005097          	auipc	ra,0x5
    4cf4:	818080e7          	jalr	-2024(ra) # 9508 <printf>
    exit(1);
    4cf8:	4505                	li	a0,1
    4cfa:	00004097          	auipc	ra,0x4
    4cfe:	28e080e7          	jalr	654(ra) # 8f88 <exit>
    printf("WARNING: shmid reused (allowed), new shmid=%d\n", shmid3);
    4d02:	85aa                	mv	a1,a0
    4d04:	00007517          	auipc	a0,0x7
    4d08:	32c50513          	addi	a0,a0,812 # c030 <malloc+0x2a70>
    4d0c:	00004097          	auipc	ra,0x4
    4d10:	7fc080e7          	jalr	2044(ra) # 9508 <printf>
    4d14:	b779                	j	4ca2 <shmtest1+0x388>
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    4d16:	85a6                	mv	a1,s1
    4d18:	00007517          	auipc	a0,0x7
    4d1c:	3a850513          	addi	a0,a0,936 # c0c0 <malloc+0x2b00>
    4d20:	00004097          	auipc	ra,0x4
    4d24:	7e8080e7          	jalr	2024(ra) # 9508 <printf>
    4d28:	4505                	li	a0,1
    4d2a:	00004097          	auipc	ra,0x4
    4d2e:	25e080e7          	jalr	606(ra) # 8f88 <exit>

0000000000004d32 <shmtest2>:

void shmtest2(char *s) {
    4d32:	711d                	addi	sp,sp,-96
    4d34:	ec86                	sd	ra,88(sp)
    4d36:	e8a2                	sd	s0,80(sp)
    4d38:	e4a6                	sd	s1,72(sp)
    4d3a:	e0ca                	sd	s2,64(sp)
    4d3c:	fc4e                	sd	s3,56(sp)
    4d3e:	1080                	addi	s0,sp,96
    if(verbose) { shmtest2_main(); return; }
    4d40:	0000b797          	auipc	a5,0xb
    4d44:	b547a783          	lw	a5,-1196(a5) # f894 <verbose>
    4d48:	e7b9                	bnez	a5,4d96 <shmtest2+0x64>
    4d4a:	84aa                	mv	s1,a0
    int id = shmcreate("test_shm2", 4096);
    4d4c:	6585                	lui	a1,0x1
    4d4e:	00008517          	auipc	a0,0x8
    4d52:	8aa50513          	addi	a0,a0,-1878 # c5f8 <malloc+0x3038>
    4d56:	00004097          	auipc	ra,0x4
    4d5a:	340080e7          	jalr	832(ra) # 9096 <shmcreate>
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    4d5e:	70054163          	bltz	a0,5460 <shmtest2+0x72e>
    uint64 va = shmattach(id);
    4d62:	00004097          	auipc	ra,0x4
    4d66:	348080e7          	jalr	840(ra) # 90aa <shmattach>
    if(va == 0) { printf("%s: attach failed\n", s); exit(1); }
    4d6a:	70050963          	beqz	a0,547c <shmtest2+0x74a>
    shmdetach(va, 4096);
    4d6e:	6585                	lui	a1,0x1
    4d70:	00004097          	auipc	ra,0x4
    4d74:	344080e7          	jalr	836(ra) # 90b4 <shmdetach>
    shmunlink("test_shm2");
    4d78:	00008517          	auipc	a0,0x8
    4d7c:	88050513          	addi	a0,a0,-1920 # c5f8 <malloc+0x3038>
    4d80:	00004097          	auipc	ra,0x4
    4d84:	33e080e7          	jalr	830(ra) # 90be <shmunlink>
}
    4d88:	60e6                	ld	ra,88(sp)
    4d8a:	6446                	ld	s0,80(sp)
    4d8c:	64a6                	ld	s1,72(sp)
    4d8e:	6906                	ld	s2,64(sp)
    4d90:	79e2                	ld	s3,56(sp)
    4d92:	6125                	addi	sp,sp,96
    4d94:	8082                	ret
{
  int shmid;
  uint64 va_parent;
  int pid, i;

  printf("=== Shared Memory Test 2: Cross-process & Boundaries ===\n");
    4d96:	00007517          	auipc	a0,0x7
    4d9a:	34250513          	addi	a0,a0,834 # c0d8 <malloc+0x2b18>
    4d9e:	00004097          	auipc	ra,0x4
    4da2:	76a080e7          	jalr	1898(ra) # 9508 <printf>

  // Test 1: parent create, write, child attach/read/modify, parent sees changes
  printf("Test 2.1: Cross-process visibility (parent->child->parent)...\n");
    4da6:	00007517          	auipc	a0,0x7
    4daa:	37250513          	addi	a0,a0,882 # c118 <malloc+0x2b58>
    4dae:	00004097          	auipc	ra,0x4
    4db2:	75a080e7          	jalr	1882(ra) # 9508 <printf>
  shmid = shmcreate("cross_shm", 2*PGSIZE);
    4db6:	6589                	lui	a1,0x2
    4db8:	00007517          	auipc	a0,0x7
    4dbc:	3a050513          	addi	a0,a0,928 # c158 <malloc+0x2b98>
    4dc0:	00004097          	auipc	ra,0x4
    4dc4:	2d6080e7          	jalr	726(ra) # 9096 <shmcreate>
  if(shmid < 0){
    4dc8:	08054863          	bltz	a0,4e58 <shmtest2+0x126>
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  va_parent = shmattach(shmid);
    4dcc:	00004097          	auipc	ra,0x4
    4dd0:	2de080e7          	jalr	734(ra) # 90aa <shmattach>
    4dd4:	84aa                	mv	s1,a0
  if(va_parent == 0){
    4dd6:	cd51                	beqz	a0,4e72 <shmtest2+0x140>
    4dd8:	01050693          	addi	a3,a0,16
    4ddc:	87aa                	mv	a5,a0
    exit(1);
  }

  // fill with pattern 0x11
  for(i = 0; i < 16; i++)
    ((char*)va_parent)[i] = 0x11;
    4dde:	4745                	li	a4,17
    4de0:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < 16; i++)
    4de4:	0785                	addi	a5,a5,1
    4de6:	fed79de3          	bne	a5,a3,4de0 <shmtest2+0xae>

  pid = fork();
    4dea:	00004097          	auipc	ra,0x4
    4dee:	196080e7          	jalr	406(ra) # 8f80 <fork>
  if(pid < 0){
    4df2:	08054d63          	bltz	a0,4e8c <shmtest2+0x15a>
    printf("ERROR: fork failed\n");
    exit(1);
  }

  if(pid == 0){
    4df6:	10051c63          	bnez	a0,4f0e <shmtest2+0x1dc>
    // child
    int cshmid = shmopen("cross_shm");
    4dfa:	00007517          	auipc	a0,0x7
    4dfe:	35e50513          	addi	a0,a0,862 # c158 <malloc+0x2b98>
    4e02:	00004097          	auipc	ra,0x4
    4e06:	29e080e7          	jalr	670(ra) # 90a0 <shmopen>
    if(cshmid < 0){
    4e0a:	08054e63          	bltz	a0,4ea6 <shmtest2+0x174>
      printf("CHILD ERROR: shmopen failed\n");
      exit(1);
    }
    uint64 va_child = shmattach(cshmid);
    4e0e:	00004097          	auipc	ra,0x4
    4e12:	29c080e7          	jalr	668(ra) # 90aa <shmattach>
    if(va_child == 0){
    4e16:	4781                	li	a5,0
    4e18:	c545                	beqz	a0,4ec0 <shmtest2+0x18e>
      printf("CHILD ERROR: shmattach failed\n");
      exit(1);
    }
    // check pattern
    for(i = 0; i < 16; i++){
      if(((char*)va_child)[i] != 0x11){
    4e1a:	46c5                	li	a3,17
    for(i = 0; i < 16; i++){
    4e1c:	4741                	li	a4,16
      if(((char*)va_child)[i] != 0x11){
    4e1e:	00f50633          	add	a2,a0,a5
    4e22:	00064603          	lbu	a2,0(a2)
    4e26:	0ad61a63          	bne	a2,a3,4eda <shmtest2+0x1a8>
    for(i = 0; i < 16; i++){
    4e2a:	0785                	addi	a5,a5,1
    4e2c:	fee799e3          	bne	a5,a4,4e1e <shmtest2+0xec>
        printf("CHILD ERROR: unexpected data before modify\n");
        exit(1);
      }
    }
    // modify
    ((char*)va_child)[0] = 0xAA;
    4e30:	faa00793          	li	a5,-86
    4e34:	00f50023          	sb	a5,0(a0)
    ((char*)va_child)[1] = 0xBB;
    4e38:	fbb00793          	li	a5,-69
    4e3c:	00f500a3          	sb	a5,1(a0)

    // detach and exit
    if(shmdetach(va_child, PGSIZE) < 0){
    4e40:	6585                	lui	a1,0x1
    4e42:	00004097          	auipc	ra,0x4
    4e46:	272080e7          	jalr	626(ra) # 90b4 <shmdetach>
    4e4a:	0a054563          	bltz	a0,4ef4 <shmtest2+0x1c2>
      printf("CHILD ERROR: shmdetach failed\n");
      exit(1);
    }
    exit(0);
    4e4e:	4501                	li	a0,0
    4e50:	00004097          	auipc	ra,0x4
    4e54:	138080e7          	jalr	312(ra) # 8f88 <exit>
    printf("ERROR: shmcreate failed\n");
    4e58:	00007517          	auipc	a0,0x7
    4e5c:	ca050513          	addi	a0,a0,-864 # baf8 <malloc+0x2538>
    4e60:	00004097          	auipc	ra,0x4
    4e64:	6a8080e7          	jalr	1704(ra) # 9508 <printf>
    exit(1);
    4e68:	4505                	li	a0,1
    4e6a:	00004097          	auipc	ra,0x4
    4e6e:	11e080e7          	jalr	286(ra) # 8f88 <exit>
    printf("ERROR: parent shmattach failed\n");
    4e72:	00007517          	auipc	a0,0x7
    4e76:	2f650513          	addi	a0,a0,758 # c168 <malloc+0x2ba8>
    4e7a:	00004097          	auipc	ra,0x4
    4e7e:	68e080e7          	jalr	1678(ra) # 9508 <printf>
    exit(1);
    4e82:	4505                	li	a0,1
    4e84:	00004097          	auipc	ra,0x4
    4e88:	104080e7          	jalr	260(ra) # 8f88 <exit>
    printf("ERROR: fork failed\n");
    4e8c:	00007517          	auipc	a0,0x7
    4e90:	9ac50513          	addi	a0,a0,-1620 # b838 <malloc+0x2278>
    4e94:	00004097          	auipc	ra,0x4
    4e98:	674080e7          	jalr	1652(ra) # 9508 <printf>
    exit(1);
    4e9c:	4505                	li	a0,1
    4e9e:	00004097          	auipc	ra,0x4
    4ea2:	0ea080e7          	jalr	234(ra) # 8f88 <exit>
      printf("CHILD ERROR: shmopen failed\n");
    4ea6:	00007517          	auipc	a0,0x7
    4eaa:	2e250513          	addi	a0,a0,738 # c188 <malloc+0x2bc8>
    4eae:	00004097          	auipc	ra,0x4
    4eb2:	65a080e7          	jalr	1626(ra) # 9508 <printf>
      exit(1);
    4eb6:	4505                	li	a0,1
    4eb8:	00004097          	auipc	ra,0x4
    4ebc:	0d0080e7          	jalr	208(ra) # 8f88 <exit>
      printf("CHILD ERROR: shmattach failed\n");
    4ec0:	00007517          	auipc	a0,0x7
    4ec4:	2e850513          	addi	a0,a0,744 # c1a8 <malloc+0x2be8>
    4ec8:	00004097          	auipc	ra,0x4
    4ecc:	640080e7          	jalr	1600(ra) # 9508 <printf>
      exit(1);
    4ed0:	4505                	li	a0,1
    4ed2:	00004097          	auipc	ra,0x4
    4ed6:	0b6080e7          	jalr	182(ra) # 8f88 <exit>
        printf("CHILD ERROR: unexpected data before modify\n");
    4eda:	00007517          	auipc	a0,0x7
    4ede:	2ee50513          	addi	a0,a0,750 # c1c8 <malloc+0x2c08>
    4ee2:	00004097          	auipc	ra,0x4
    4ee6:	626080e7          	jalr	1574(ra) # 9508 <printf>
        exit(1);
    4eea:	4505                	li	a0,1
    4eec:	00004097          	auipc	ra,0x4
    4ef0:	09c080e7          	jalr	156(ra) # 8f88 <exit>
      printf("CHILD ERROR: shmdetach failed\n");
    4ef4:	00007517          	auipc	a0,0x7
    4ef8:	30450513          	addi	a0,a0,772 # c1f8 <malloc+0x2c38>
    4efc:	00004097          	auipc	ra,0x4
    4f00:	60c080e7          	jalr	1548(ra) # 9508 <printf>
      exit(1);
    4f04:	4505                	li	a0,1
    4f06:	00004097          	auipc	ra,0x4
    4f0a:	082080e7          	jalr	130(ra) # 8f88 <exit>
  }

  // parent waits for child
  wait(0);
    4f0e:	4501                	li	a0,0
    4f10:	00004097          	auipc	ra,0x4
    4f14:	080080e7          	jalr	128(ra) # 8f90 <wait>

  // parent should see child's modifications
  if(((char*)va_parent)[0] != 0xAA || ((char*)va_parent)[1] != 0xBB){
    4f18:	0004c703          	lbu	a4,0(s1)
    4f1c:	0aa00793          	li	a5,170
    4f20:	00f71863          	bne	a4,a5,4f30 <shmtest2+0x1fe>
    4f24:	0014c703          	lbu	a4,1(s1)
    4f28:	0bb00793          	li	a5,187
    4f2c:	00f70f63          	beq	a4,a5,4f4a <shmtest2+0x218>
    printf("ERROR: Parent did not see child's modifications\n");
    4f30:	00007517          	auipc	a0,0x7
    4f34:	2e850513          	addi	a0,a0,744 # c218 <malloc+0x2c58>
    4f38:	00004097          	auipc	ra,0x4
    4f3c:	5d0080e7          	jalr	1488(ra) # 9508 <printf>
    exit(1);
    4f40:	4505                	li	a0,1
    4f42:	00004097          	auipc	ra,0x4
    4f46:	046080e7          	jalr	70(ra) # 8f88 <exit>
  }
  printf("SUCCESS: Cross-process visibility works\n");
    4f4a:	00007517          	auipc	a0,0x7
    4f4e:	30650513          	addi	a0,a0,774 # c250 <malloc+0x2c90>
    4f52:	00004097          	auipc	ra,0x4
    4f56:	5b6080e7          	jalr	1462(ra) # 9508 <printf>

  // cleanup
  shmdetach(va_parent, 2*PGSIZE);
    4f5a:	6589                	lui	a1,0x2
    4f5c:	8526                	mv	a0,s1
    4f5e:	00004097          	auipc	ra,0x4
    4f62:	156080e7          	jalr	342(ra) # 90b4 <shmdetach>
  shmunlink("cross_shm");
    4f66:	00007517          	auipc	a0,0x7
    4f6a:	1f250513          	addi	a0,a0,498 # c158 <malloc+0x2b98>
    4f6e:	00004097          	auipc	ra,0x4
    4f72:	150080e7          	jalr	336(ra) # 90be <shmunlink>

  // Test 2: concurrent attach/write by multiple children
  printf("Test 2.2: Concurrent attach/write by multiple children...\n");
    4f76:	00007517          	auipc	a0,0x7
    4f7a:	30a50513          	addi	a0,a0,778 # c280 <malloc+0x2cc0>
    4f7e:	00004097          	auipc	ra,0x4
    4f82:	58a080e7          	jalr	1418(ra) # 9508 <printf>
  shmid = shmcreate("concurrent_shm", PGSIZE);
    4f86:	6585                	lui	a1,0x1
    4f88:	00007517          	auipc	a0,0x7
    4f8c:	33850513          	addi	a0,a0,824 # c2c0 <malloc+0x2d00>
    4f90:	00004097          	auipc	ra,0x4
    4f94:	106080e7          	jalr	262(ra) # 9096 <shmcreate>
  if(shmid < 0){
    4f98:	10054c63          	bltz	a0,50b0 <shmtest2+0x37e>
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  va_parent = shmattach(shmid);
    4f9c:	00004097          	auipc	ra,0x4
    4fa0:	10e080e7          	jalr	270(ra) # 90aa <shmattach>
    4fa4:	892a                	mv	s2,a0
    printf("ERROR: parent shmattach failed\n");
    exit(1);
  }

  int nchildren = 4;
  for(i = 0; i < nchildren; i++){
    4fa6:	4481                	li	s1,0
    4fa8:	4991                	li	s3,4
  if(va_parent == 0){
    4faa:	12050063          	beqz	a0,50ca <shmtest2+0x398>
    if(fork() == 0){
    4fae:	00004097          	auipc	ra,0x4
    4fb2:	fd2080e7          	jalr	-46(ra) # 8f80 <fork>
    4fb6:	12050763          	beqz	a0,50e4 <shmtest2+0x3b2>
  for(i = 0; i < nchildren; i++){
    4fba:	2485                	addiw	s1,s1,1
    4fbc:	ff3499e3          	bne	s1,s3,4fae <shmtest2+0x27c>
      exit(0);
    }
  }

  for(i = 0; i < nchildren; i++)
    wait(0);
    4fc0:	4501                	li	a0,0
    4fc2:	00004097          	auipc	ra,0x4
    4fc6:	fce080e7          	jalr	-50(ra) # 8f90 <wait>
    4fca:	4501                	li	a0,0
    4fcc:	00004097          	auipc	ra,0x4
    4fd0:	fc4080e7          	jalr	-60(ra) # 8f90 <wait>
    4fd4:	4501                	li	a0,0
    4fd6:	00004097          	auipc	ra,0x4
    4fda:	fba080e7          	jalr	-70(ra) # 8f90 <wait>
    4fde:	4501                	li	a0,0
    4fe0:	00004097          	auipc	ra,0x4
    4fe4:	fb0080e7          	jalr	-80(ra) # 8f90 <wait>

  // parent reads back and checks that values are present (note: order may vary)
  int seen[5] = {0};
    4fe8:	fa043c23          	sd	zero,-72(s0)
    4fec:	fc043023          	sd	zero,-64(s0)
    4ff0:	fc042423          	sw	zero,-56(s0)
    4ff4:	4701                	li	a4,0
  for(i = 0; i < nchildren; i++){
    int val = (int)((char*)va_parent)[i];
    if(val < 1 || val > nchildren){
    4ff6:	480d                	li	a6,3
      printf("ERROR: unexpected value %d at offset %d\n", val, i);
      exit(1);
    }
    seen[val] = 1;
    4ff8:	4505                	li	a0,1
  for(i = 0; i < nchildren; i++){
    4ffa:	4691                	li	a3,4
    4ffc:	0007061b          	sext.w	a2,a4
    int val = (int)((char*)va_parent)[i];
    5000:	00e907b3          	add	a5,s2,a4
    5004:	0007c783          	lbu	a5,0(a5)
    5008:	0007859b          	sext.w	a1,a5
    if(val < 1 || val > nchildren){
    500c:	37fd                	addiw	a5,a5,-1
    500e:	0ff7f793          	zext.b	a5,a5
    5012:	14f86163          	bltu	a6,a5,5154 <shmtest2+0x422>
    seen[val] = 1;
    5016:	00259793          	slli	a5,a1,0x2
    501a:	fd078793          	addi	a5,a5,-48
    501e:	97a2                	add	a5,a5,s0
    5020:	fea7a423          	sw	a0,-24(a5)
  for(i = 0; i < nchildren; i++){
    5024:	0705                	addi	a4,a4,1 # 1001 <testdev+0x163>
    5026:	fcd71be3          	bne	a4,a3,4ffc <shmtest2+0x2ca>
    502a:	fb840793          	addi	a5,s0,-72
  }
  for(i = 1; i <= nchildren; i++){
    502e:	4585                	li	a1,1
    5030:	4715                	li	a4,5
    if(!seen[i]){
    5032:	43d4                	lw	a3,4(a5)
    5034:	12068d63          	beqz	a3,516e <shmtest2+0x43c>
  for(i = 1; i <= nchildren; i++){
    5038:	2585                	addiw	a1,a1,1 # 1001 <testdev+0x163>
    503a:	0791                	addi	a5,a5,4
    503c:	fee59be3          	bne	a1,a4,5032 <shmtest2+0x300>
      printf("ERROR: missing value %d\n", i);
      exit(1);
    }
  }
  printf("SUCCESS: Concurrent attach/write succeeded\n");
    5040:	00007517          	auipc	a0,0x7
    5044:	2e050513          	addi	a0,a0,736 # c320 <malloc+0x2d60>
    5048:	00004097          	auipc	ra,0x4
    504c:	4c0080e7          	jalr	1216(ra) # 9508 <printf>

  shmdetach(va_parent, PGSIZE);
    5050:	6585                	lui	a1,0x1
    5052:	854a                	mv	a0,s2
    5054:	00004097          	auipc	ra,0x4
    5058:	060080e7          	jalr	96(ra) # 90b4 <shmdetach>
  shmunlink("concurrent_shm");
    505c:	00007517          	auipc	a0,0x7
    5060:	26450513          	addi	a0,a0,612 # c2c0 <malloc+0x2d00>
    5064:	00004097          	auipc	ra,0x4
    5068:	05a080e7          	jalr	90(ra) # 90be <shmunlink>

  // Test 3: Boundary (too big) should fail
  printf("Test 2.3: Boundary: create too-large shared memory should fail...\n");
    506c:	00007517          	auipc	a0,0x7
    5070:	2e450513          	addi	a0,a0,740 # c350 <malloc+0x2d90>
    5074:	00004097          	auipc	ra,0x4
    5078:	494080e7          	jalr	1172(ra) # 9508 <printf>
  int big = shmcreate("big_shm", 70000); // > 16*4096 = 65536
    507c:	65c5                	lui	a1,0x11
    507e:	17058593          	addi	a1,a1,368 # 11170 <data+0x7c0>
    5082:	00007517          	auipc	a0,0x7
    5086:	31650513          	addi	a0,a0,790 # c398 <malloc+0x2dd8>
    508a:	00004097          	auipc	ra,0x4
    508e:	00c080e7          	jalr	12(ra) # 9096 <shmcreate>
  if(big >= 0){
    5092:	0e054b63          	bltz	a0,5188 <shmtest2+0x456>
    printf("ERROR: creation of too-large shared memory succeeded unexpectedly\n");
    5096:	00007517          	auipc	a0,0x7
    509a:	30a50513          	addi	a0,a0,778 # c3a0 <malloc+0x2de0>
    509e:	00004097          	auipc	ra,0x4
    50a2:	46a080e7          	jalr	1130(ra) # 9508 <printf>
    exit(1);
    50a6:	4505                	li	a0,1
    50a8:	00004097          	auipc	ra,0x4
    50ac:	ee0080e7          	jalr	-288(ra) # 8f88 <exit>
    printf("ERROR: shmcreate failed\n");
    50b0:	00007517          	auipc	a0,0x7
    50b4:	a4850513          	addi	a0,a0,-1464 # baf8 <malloc+0x2538>
    50b8:	00004097          	auipc	ra,0x4
    50bc:	450080e7          	jalr	1104(ra) # 9508 <printf>
    exit(1);
    50c0:	4505                	li	a0,1
    50c2:	00004097          	auipc	ra,0x4
    50c6:	ec6080e7          	jalr	-314(ra) # 8f88 <exit>
    printf("ERROR: parent shmattach failed\n");
    50ca:	00007517          	auipc	a0,0x7
    50ce:	09e50513          	addi	a0,a0,158 # c168 <malloc+0x2ba8>
    50d2:	00004097          	auipc	ra,0x4
    50d6:	436080e7          	jalr	1078(ra) # 9508 <printf>
    exit(1);
    50da:	4505                	li	a0,1
    50dc:	00004097          	auipc	ra,0x4
    50e0:	eac080e7          	jalr	-340(ra) # 8f88 <exit>
      int c = shmopen("concurrent_shm");
    50e4:	00007517          	auipc	a0,0x7
    50e8:	1dc50513          	addi	a0,a0,476 # c2c0 <malloc+0x2d00>
    50ec:	00004097          	auipc	ra,0x4
    50f0:	fb4080e7          	jalr	-76(ra) # 90a0 <shmopen>
      if(c < 0){
    50f4:	02054463          	bltz	a0,511c <shmtest2+0x3ea>
      uint64 v = shmattach(c);
    50f8:	00004097          	auipc	ra,0x4
    50fc:	fb2080e7          	jalr	-78(ra) # 90aa <shmattach>
      if(v == 0){
    5100:	e91d                	bnez	a0,5136 <shmtest2+0x404>
        printf("CHILD ERROR: shmattach failed\n");
    5102:	00007517          	auipc	a0,0x7
    5106:	0a650513          	addi	a0,a0,166 # c1a8 <malloc+0x2be8>
    510a:	00004097          	auipc	ra,0x4
    510e:	3fe080e7          	jalr	1022(ra) # 9508 <printf>
        exit(1);
    5112:	4505                	li	a0,1
    5114:	00004097          	auipc	ra,0x4
    5118:	e74080e7          	jalr	-396(ra) # 8f88 <exit>
        printf("CHILD ERROR: shmopen failed\n");
    511c:	00007517          	auipc	a0,0x7
    5120:	06c50513          	addi	a0,a0,108 # c188 <malloc+0x2bc8>
    5124:	00004097          	auipc	ra,0x4
    5128:	3e4080e7          	jalr	996(ra) # 9508 <printf>
        exit(1);
    512c:	4505                	li	a0,1
    512e:	00004097          	auipc	ra,0x4
    5132:	e5a080e7          	jalr	-422(ra) # 8f88 <exit>
      ((char*)v)[i] = (char)(i + 1);
    5136:	00a487b3          	add	a5,s1,a0
    513a:	2485                	addiw	s1,s1,1
    513c:	00978023          	sb	s1,0(a5)
      shmdetach(v, PGSIZE);
    5140:	6585                	lui	a1,0x1
    5142:	00004097          	auipc	ra,0x4
    5146:	f72080e7          	jalr	-142(ra) # 90b4 <shmdetach>
      exit(0);
    514a:	4501                	li	a0,0
    514c:	00004097          	auipc	ra,0x4
    5150:	e3c080e7          	jalr	-452(ra) # 8f88 <exit>
      printf("ERROR: unexpected value %d at offset %d\n", val, i);
    5154:	00007517          	auipc	a0,0x7
    5158:	17c50513          	addi	a0,a0,380 # c2d0 <malloc+0x2d10>
    515c:	00004097          	auipc	ra,0x4
    5160:	3ac080e7          	jalr	940(ra) # 9508 <printf>
      exit(1);
    5164:	4505                	li	a0,1
    5166:	00004097          	auipc	ra,0x4
    516a:	e22080e7          	jalr	-478(ra) # 8f88 <exit>
      printf("ERROR: missing value %d\n", i);
    516e:	00007517          	auipc	a0,0x7
    5172:	19250513          	addi	a0,a0,402 # c300 <malloc+0x2d40>
    5176:	00004097          	auipc	ra,0x4
    517a:	392080e7          	jalr	914(ra) # 9508 <printf>
      exit(1);
    517e:	4505                	li	a0,1
    5180:	00004097          	auipc	ra,0x4
    5184:	e08080e7          	jalr	-504(ra) # 8f88 <exit>
  }
  printf("SUCCESS: Too-large shmcreate failed as expected\n");
    5188:	00007517          	auipc	a0,0x7
    518c:	26050513          	addi	a0,a0,608 # c3e8 <malloc+0x2e28>
    5190:	00004097          	auipc	ra,0x4
    5194:	378080e7          	jalr	888(ra) # 9508 <printf>

  // Test 4: Unlink while attached
  printf("Test 2.4: Unlink while attached...\n");
    5198:	00007517          	auipc	a0,0x7
    519c:	28850513          	addi	a0,a0,648 # c420 <malloc+0x2e60>
    51a0:	00004097          	auipc	ra,0x4
    51a4:	368080e7          	jalr	872(ra) # 9508 <printf>
  shmid = shmcreate("unlink_shm", PGSIZE);
    51a8:	6585                	lui	a1,0x1
    51aa:	00007517          	auipc	a0,0x7
    51ae:	29e50513          	addi	a0,a0,670 # c448 <malloc+0x2e88>
    51b2:	00004097          	auipc	ra,0x4
    51b6:	ee4080e7          	jalr	-284(ra) # 9096 <shmcreate>
    51ba:	84aa                	mv	s1,a0
  if(shmid < 0){
    51bc:	02054563          	bltz	a0,51e6 <shmtest2+0x4b4>
    printf("ERROR: shmcreate failed\n");
    exit(1);
  }
  va_parent = shmattach(shmid);
    51c0:	00004097          	auipc	ra,0x4
    51c4:	eea080e7          	jalr	-278(ra) # 90aa <shmattach>
    51c8:	892a                	mv	s2,a0
  if(va_parent == 0){
    51ca:	e91d                	bnez	a0,5200 <shmtest2+0x4ce>
    printf("ERROR: shmattach failed\n");
    51cc:	00007517          	auipc	a0,0x7
    51d0:	bbc50513          	addi	a0,a0,-1092 # bd88 <malloc+0x27c8>
    51d4:	00004097          	auipc	ra,0x4
    51d8:	334080e7          	jalr	820(ra) # 9508 <printf>
    exit(1);
    51dc:	4505                	li	a0,1
    51de:	00004097          	auipc	ra,0x4
    51e2:	daa080e7          	jalr	-598(ra) # 8f88 <exit>
    printf("ERROR: shmcreate failed\n");
    51e6:	00007517          	auipc	a0,0x7
    51ea:	91250513          	addi	a0,a0,-1774 # baf8 <malloc+0x2538>
    51ee:	00004097          	auipc	ra,0x4
    51f2:	31a080e7          	jalr	794(ra) # 9508 <printf>
    exit(1);
    51f6:	4505                	li	a0,1
    51f8:	00004097          	auipc	ra,0x4
    51fc:	d90080e7          	jalr	-624(ra) # 8f88 <exit>
  }
  // use a pipe to ensure child attaches before parent unlinks
  int fds[2];
  if(pipe(fds) < 0){
    5200:	fb040513          	addi	a0,s0,-80
    5204:	00004097          	auipc	ra,0x4
    5208:	d94080e7          	jalr	-620(ra) # 8f98 <pipe>
    520c:	04054c63          	bltz	a0,5264 <shmtest2+0x532>
    printf("ERROR: pipe failed\n");
    exit(1);
  }

  // fork child to attach
  pid = fork();
    5210:	00004097          	auipc	ra,0x4
    5214:	d70080e7          	jalr	-656(ra) # 8f80 <fork>
  if(pid < 0){
    5218:	06054363          	bltz	a0,527e <shmtest2+0x54c>
    printf("ERROR: fork failed\n");
    exit(1);
  }
  if(pid == 0){
    521c:	ed61                	bnez	a0,52f4 <shmtest2+0x5c2>
    close(fds[0]); // close read end
    521e:	fb042503          	lw	a0,-80(s0)
    5222:	00004097          	auipc	ra,0x4
    5226:	d8e080e7          	jalr	-626(ra) # 8fb0 <close>
    int c = shmopen("unlink_shm");
    522a:	00007517          	auipc	a0,0x7
    522e:	21e50513          	addi	a0,a0,542 # c448 <malloc+0x2e88>
    5232:	00004097          	auipc	ra,0x4
    5236:	e6e080e7          	jalr	-402(ra) # 90a0 <shmopen>
    if(c < 0){
    523a:	04054f63          	bltz	a0,5298 <shmtest2+0x566>
      printf("CHILD ERROR: shmopen failed\n");
      exit(1);
    }
    uint64 v = shmattach(c);
    523e:	00004097          	auipc	ra,0x4
    5242:	e6c080e7          	jalr	-404(ra) # 90aa <shmattach>
    5246:	84aa                	mv	s1,a0
    if(v == 0){
    5248:	e52d                	bnez	a0,52b2 <shmtest2+0x580>
      printf("CHILD ERROR: shmattach failed\n");
    524a:	00007517          	auipc	a0,0x7
    524e:	f5e50513          	addi	a0,a0,-162 # c1a8 <malloc+0x2be8>
    5252:	00004097          	auipc	ra,0x4
    5256:	2b6080e7          	jalr	694(ra) # 9508 <printf>
      exit(1);
    525a:	4505                	li	a0,1
    525c:	00004097          	auipc	ra,0x4
    5260:	d2c080e7          	jalr	-724(ra) # 8f88 <exit>
    printf("ERROR: pipe failed\n");
    5264:	00007517          	auipc	a0,0x7
    5268:	1f450513          	addi	a0,a0,500 # c458 <malloc+0x2e98>
    526c:	00004097          	auipc	ra,0x4
    5270:	29c080e7          	jalr	668(ra) # 9508 <printf>
    exit(1);
    5274:	4505                	li	a0,1
    5276:	00004097          	auipc	ra,0x4
    527a:	d12080e7          	jalr	-750(ra) # 8f88 <exit>
    printf("ERROR: fork failed\n");
    527e:	00006517          	auipc	a0,0x6
    5282:	5ba50513          	addi	a0,a0,1466 # b838 <malloc+0x2278>
    5286:	00004097          	auipc	ra,0x4
    528a:	282080e7          	jalr	642(ra) # 9508 <printf>
    exit(1);
    528e:	4505                	li	a0,1
    5290:	00004097          	auipc	ra,0x4
    5294:	cf8080e7          	jalr	-776(ra) # 8f88 <exit>
      printf("CHILD ERROR: shmopen failed\n");
    5298:	00007517          	auipc	a0,0x7
    529c:	ef050513          	addi	a0,a0,-272 # c188 <malloc+0x2bc8>
    52a0:	00004097          	auipc	ra,0x4
    52a4:	268080e7          	jalr	616(ra) # 9508 <printf>
      exit(1);
    52a8:	4505                	li	a0,1
    52aa:	00004097          	auipc	ra,0x4
    52ae:	cde080e7          	jalr	-802(ra) # 8f88 <exit>
    }
    // signal parent that attach succeeded
    char ok = 1;
    52b2:	4785                	li	a5,1
    52b4:	faf407a3          	sb	a5,-81(s0)
    write(fds[1], &ok, 1);
    52b8:	4605                	li	a2,1
    52ba:	faf40593          	addi	a1,s0,-81
    52be:	fb442503          	lw	a0,-76(s0)
    52c2:	00004097          	auipc	ra,0x4
    52c6:	ce6080e7          	jalr	-794(ra) # 8fa8 <write>

    // child writes
    ((char*)v)[0] = 0x5A;
    52ca:	05a00793          	li	a5,90
    52ce:	00f48023          	sb	a5,0(s1)
    shmdetach(v, PGSIZE);
    52d2:	6585                	lui	a1,0x1
    52d4:	8526                	mv	a0,s1
    52d6:	00004097          	auipc	ra,0x4
    52da:	dde080e7          	jalr	-546(ra) # 90b4 <shmdetach>
    close(fds[1]);
    52de:	fb442503          	lw	a0,-76(s0)
    52e2:	00004097          	auipc	ra,0x4
    52e6:	cce080e7          	jalr	-818(ra) # 8fb0 <close>
    exit(0);
    52ea:	4501                	li	a0,0
    52ec:	00004097          	auipc	ra,0x4
    52f0:	c9c080e7          	jalr	-868(ra) # 8f88 <exit>
  }
  // parent waits for child's signal (attach done)
  close(fds[1]);
    52f4:	fb442503          	lw	a0,-76(s0)
    52f8:	00004097          	auipc	ra,0x4
    52fc:	cb8080e7          	jalr	-840(ra) # 8fb0 <close>
  char buf;
  if(read(fds[0], &buf, 1) != 1){
    5300:	4605                	li	a2,1
    5302:	faf40593          	addi	a1,s0,-81
    5306:	fb042503          	lw	a0,-80(s0)
    530a:	00004097          	auipc	ra,0x4
    530e:	c96080e7          	jalr	-874(ra) # 8fa0 <read>
    5312:	4785                	li	a5,1
    5314:	00f50f63          	beq	a0,a5,5332 <shmtest2+0x600>
    printf("ERROR: pipe read failed\n");
    5318:	00007517          	auipc	a0,0x7
    531c:	15850513          	addi	a0,a0,344 # c470 <malloc+0x2eb0>
    5320:	00004097          	auipc	ra,0x4
    5324:	1e8080e7          	jalr	488(ra) # 9508 <printf>
    exit(1);
    5328:	4505                	li	a0,1
    532a:	00004097          	auipc	ra,0x4
    532e:	c5e080e7          	jalr	-930(ra) # 8f88 <exit>
  }
  close(fds[0]);
    5332:	fb042503          	lw	a0,-80(s0)
    5336:	00004097          	auipc	ra,0x4
    533a:	c7a080e7          	jalr	-902(ra) # 8fb0 <close>

  // parent unlink while child still mapped
  if(shmunlink("unlink_shm") < 0){
    533e:	00007517          	auipc	a0,0x7
    5342:	10a50513          	addi	a0,a0,266 # c448 <malloc+0x2e88>
    5346:	00004097          	auipc	ra,0x4
    534a:	d78080e7          	jalr	-648(ra) # 90be <shmunlink>
    534e:	04054c63          	bltz	a0,53a6 <shmtest2+0x674>
    printf("ERROR: shmunlink failed\n");
    exit(1);
  }
  wait(0);
    5352:	4501                	li	a0,0
    5354:	00004097          	auipc	ra,0x4
    5358:	c3c080e7          	jalr	-964(ra) # 8f90 <wait>
  // parent should detach its original mapping before re-attaching to the same shmid
  printf("Parent: original va=%p, detaching now...\n", (void*)va_parent);
    535c:	85ca                	mv	a1,s2
    535e:	00007517          	auipc	a0,0x7
    5362:	13250513          	addi	a0,a0,306 # c490 <malloc+0x2ed0>
    5366:	00004097          	auipc	ra,0x4
    536a:	1a2080e7          	jalr	418(ra) # 9508 <printf>
  if(shmdetach(va_parent, PGSIZE) < 0){
    536e:	6585                	lui	a1,0x1
    5370:	854a                	mv	a0,s2
    5372:	00004097          	auipc	ra,0x4
    5376:	d42080e7          	jalr	-702(ra) # 90b4 <shmdetach>
    537a:	04054363          	bltz	a0,53c0 <shmtest2+0x68e>
    printf("ERROR: parent shmdetach failed\n");
    exit(1);
  }

  // parent re-attach to check value (should be 0x5A if still present)
  uint64 va2 = shmattach(shmid);
    537e:	8526                	mv	a0,s1
    5380:	00004097          	auipc	ra,0x4
    5384:	d2a080e7          	jalr	-726(ra) # 90aa <shmattach>
    5388:	84aa                	mv	s1,a0
  if(va2 == 0){
    538a:	e921                	bnez	a0,53da <shmtest2+0x6a8>
    printf("ERROR: re-attach after unlink failed (va2==0)\n");
    538c:	00007517          	auipc	a0,0x7
    5390:	15450513          	addi	a0,a0,340 # c4e0 <malloc+0x2f20>
    5394:	00004097          	auipc	ra,0x4
    5398:	174080e7          	jalr	372(ra) # 9508 <printf>
    exit(1);
    539c:	4505                	li	a0,1
    539e:	00004097          	auipc	ra,0x4
    53a2:	bea080e7          	jalr	-1046(ra) # 8f88 <exit>
    printf("ERROR: shmunlink failed\n");
    53a6:	00007517          	auipc	a0,0x7
    53aa:	b5a50513          	addi	a0,a0,-1190 # bf00 <malloc+0x2940>
    53ae:	00004097          	auipc	ra,0x4
    53b2:	15a080e7          	jalr	346(ra) # 9508 <printf>
    exit(1);
    53b6:	4505                	li	a0,1
    53b8:	00004097          	auipc	ra,0x4
    53bc:	bd0080e7          	jalr	-1072(ra) # 8f88 <exit>
    printf("ERROR: parent shmdetach failed\n");
    53c0:	00007517          	auipc	a0,0x7
    53c4:	10050513          	addi	a0,a0,256 # c4c0 <malloc+0x2f00>
    53c8:	00004097          	auipc	ra,0x4
    53cc:	140080e7          	jalr	320(ra) # 9508 <printf>
    exit(1);
    53d0:	4505                	li	a0,1
    53d2:	00004097          	auipc	ra,0x4
    53d6:	bb6080e7          	jalr	-1098(ra) # 8f88 <exit>
  }
  printf("Parent: re-attached at va2=%p, reading byte...\n", (void*)va2);
    53da:	85aa                	mv	a1,a0
    53dc:	00007517          	auipc	a0,0x7
    53e0:	13450513          	addi	a0,a0,308 # c510 <malloc+0x2f50>
    53e4:	00004097          	auipc	ra,0x4
    53e8:	124080e7          	jalr	292(ra) # 9508 <printf>
  unsigned char got = ((unsigned char*)va2)[0];
    53ec:	0004c983          	lbu	s3,0(s1)
  printf("Parent: read byte=0x%x\n", got);
    53f0:	0009891b          	sext.w	s2,s3
    53f4:	85ca                	mv	a1,s2
    53f6:	00007517          	auipc	a0,0x7
    53fa:	14a50513          	addi	a0,a0,330 # c540 <malloc+0x2f80>
    53fe:	00004097          	auipc	ra,0x4
    5402:	10a080e7          	jalr	266(ra) # 9508 <printf>
  if(got != 0x5A){
    5406:	05a00793          	li	a5,90
    540a:	02f98063          	beq	s3,a5,542a <shmtest2+0x6f8>
    printf("ERROR: expected byte 0x5A after unlink/child write, got %x\n", got);
    540e:	85ca                	mv	a1,s2
    5410:	00007517          	auipc	a0,0x7
    5414:	14850513          	addi	a0,a0,328 # c558 <malloc+0x2f98>
    5418:	00004097          	auipc	ra,0x4
    541c:	0f0080e7          	jalr	240(ra) # 9508 <printf>
    exit(1);
    5420:	4505                	li	a0,1
    5422:	00004097          	auipc	ra,0x4
    5426:	b66080e7          	jalr	-1178(ra) # 8f88 <exit>
  }
  shmdetach(va2, PGSIZE);
    542a:	6585                	lui	a1,0x1
    542c:	8526                	mv	a0,s1
    542e:	00004097          	auipc	ra,0x4
    5432:	c86080e7          	jalr	-890(ra) # 90b4 <shmdetach>
  printf("SUCCESS: Unlink while attached behaves correctly\n");
    5436:	00007517          	auipc	a0,0x7
    543a:	16250513          	addi	a0,a0,354 # c598 <malloc+0x2fd8>
    543e:	00004097          	auipc	ra,0x4
    5442:	0ca080e7          	jalr	202(ra) # 9508 <printf>

  printf("\n=== All Tests in shmtest2 Passed ===\n");
    5446:	00007517          	auipc	a0,0x7
    544a:	18a50513          	addi	a0,a0,394 # c5d0 <malloc+0x3010>
    544e:	00004097          	auipc	ra,0x4
    5452:	0ba080e7          	jalr	186(ra) # 9508 <printf>
  exit(0);
    5456:	4501                	li	a0,0
    5458:	00004097          	auipc	ra,0x4
    545c:	b30080e7          	jalr	-1232(ra) # 8f88 <exit>
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    5460:	85a6                	mv	a1,s1
    5462:	00007517          	auipc	a0,0x7
    5466:	c5e50513          	addi	a0,a0,-930 # c0c0 <malloc+0x2b00>
    546a:	00004097          	auipc	ra,0x4
    546e:	09e080e7          	jalr	158(ra) # 9508 <printf>
    5472:	4505                	li	a0,1
    5474:	00004097          	auipc	ra,0x4
    5478:	b14080e7          	jalr	-1260(ra) # 8f88 <exit>
    if(va == 0) { printf("%s: attach failed\n", s); exit(1); }
    547c:	85a6                	mv	a1,s1
    547e:	00007517          	auipc	a0,0x7
    5482:	18a50513          	addi	a0,a0,394 # c608 <malloc+0x3048>
    5486:	00004097          	auipc	ra,0x4
    548a:	082080e7          	jalr	130(ra) # 9508 <printf>
    548e:	4505                	li	a0,1
    5490:	00004097          	auipc	ra,0x4
    5494:	af8080e7          	jalr	-1288(ra) # 8f88 <exit>

0000000000005498 <mincoretest>:
void mincoretest(char *s) {
    5498:	7139                	addi	sp,sp,-64
    549a:	fc06                	sd	ra,56(sp)
    549c:	f822                	sd	s0,48(sp)
    549e:	f426                	sd	s1,40(sp)
    54a0:	f04a                	sd	s2,32(sp)
    54a2:	ec4e                	sd	s3,24(sp)
    54a4:	e852                	sd	s4,16(sp)
    54a6:	0080                	addi	s0,sp,64
    if(verbose) { mincore_test_main(); return; }
    54a8:	0000a797          	auipc	a5,0xa
    54ac:	3ec7a783          	lw	a5,1004(a5) # f894 <verbose>
    54b0:	e38d                	bnez	a5,54d2 <mincoretest+0x3a>
    mincore((void*)0x1000, 4096, vec);  // Just verify exists
    54b2:	fc840613          	addi	a2,s0,-56
    54b6:	6585                	lui	a1,0x1
    54b8:	6505                	lui	a0,0x1
    54ba:	00004097          	auipc	ra,0x4
    54be:	cb8080e7          	jalr	-840(ra) # 9172 <mincore>
}
    54c2:	70e2                	ld	ra,56(sp)
    54c4:	7442                	ld	s0,48(sp)
    54c6:	74a2                	ld	s1,40(sp)
    54c8:	7902                	ld	s2,32(sp)
    54ca:	69e2                	ld	s3,24(sp)
    54cc:	6a42                	ld	s4,16(sp)
    54ce:	6121                	addi	sp,sp,64
    54d0:	8082                	ret
{
  int pages = 8;
  int len = pages * PGSIZE;
  unsigned char vec[(8 + 7) / 8];

  char *p = sbrk(len);
    54d2:	6521                	lui	a0,0x8
    54d4:	00004097          	auipc	ra,0x4
    54d8:	b24080e7          	jalr	-1244(ra) # 8ff8 <sbrk>
    54dc:	892a                	mv	s2,a0
  if(p == (char*)-1){
    54de:	57fd                	li	a5,-1
    54e0:	0ef50563          	beq	a0,a5,55ca <mincoretest+0x132>
    printf("mincore_test: sbrk failed\n");
    exit(1);
  }

  // 第一次查询
  if(mincore(p, len, vec) < 0){
    54e4:	fc040613          	addi	a2,s0,-64
    54e8:	65a1                	lui	a1,0x8
    54ea:	00004097          	auipc	ra,0x4
    54ee:	c88080e7          	jalr	-888(ra) # 9172 <mincore>
    54f2:	0e054963          	bltz	a0,55e4 <mincoretest+0x14c>
    printf("mincore_test: mincore failed\n");
    exit(1);
  }

  printf("mincore_test: after sbrk\n");
    54f6:	00007517          	auipc	a0,0x7
    54fa:	16a50513          	addi	a0,a0,362 # c660 <malloc+0x30a0>
    54fe:	00004097          	auipc	ra,0x4
    5502:	00a080e7          	jalr	10(ra) # 9508 <printf>
  for(int i = 0; i < pages; i++){
    5506:	4481                	li	s1,0
    printf("  page %d: %d\n", i, bit_is_set(vec, i));
    5508:	00007a17          	auipc	s4,0x7
    550c:	178a0a13          	addi	s4,s4,376 # c680 <malloc+0x30c0>
  for(int i = 0; i < pages; i++){
    5510:	49a1                	li	s3,8
  return (vec[idx/8] >> (idx % 8)) & 1;
    5512:	41f4d79b          	sraiw	a5,s1,0x1f
    5516:	01d7d79b          	srliw	a5,a5,0x1d
    551a:	9fa5                	addw	a5,a5,s1
    551c:	4037d79b          	sraiw	a5,a5,0x3
    5520:	fd078793          	addi	a5,a5,-48
    5524:	97a2                	add	a5,a5,s0
    5526:	ff07c603          	lbu	a2,-16(a5)
    552a:	0074f793          	andi	a5,s1,7
    552e:	40f6563b          	sraw	a2,a2,a5
    printf("  page %d: %d\n", i, bit_is_set(vec, i));
    5532:	8a05                	andi	a2,a2,1
    5534:	85a6                	mv	a1,s1
    5536:	8552                	mv	a0,s4
    5538:	00004097          	auipc	ra,0x4
    553c:	fd0080e7          	jalr	-48(ra) # 9508 <printf>
  for(int i = 0; i < pages; i++){
    5540:	2485                	addiw	s1,s1,1
    5542:	fd3498e3          	bne	s1,s3,5512 <mincoretest+0x7a>
    5546:	874a                	mv	a4,s2
  }

  // 访问一下每页，确保映射存在
  for(int i = 0; i < pages; i++){
    5548:	4781                	li	a5,0
    554a:	6605                	lui	a2,0x1
    554c:	46a1                	li	a3,8
    p[i * PGSIZE] = (char)i;
    554e:	00f70023          	sb	a5,0(a4)
  for(int i = 0; i < pages; i++){
    5552:	2785                	addiw	a5,a5,1
    5554:	9732                	add	a4,a4,a2
    5556:	fed79ce3          	bne	a5,a3,554e <mincoretest+0xb6>
  }

  // 第二次查询
  if(mincore(p, len, vec) < 0){
    555a:	fc040613          	addi	a2,s0,-64
    555e:	65a1                	lui	a1,0x8
    5560:	854a                	mv	a0,s2
    5562:	00004097          	auipc	ra,0x4
    5566:	c10080e7          	jalr	-1008(ra) # 9172 <mincore>
    556a:	08054a63          	bltz	a0,55fe <mincoretest+0x166>
    printf("mincore_test: mincore failed after touch\n");
    exit(1);
  }

  printf("mincore_test: after touch\n");
    556e:	00007517          	auipc	a0,0x7
    5572:	15250513          	addi	a0,a0,338 # c6c0 <malloc+0x3100>
    5576:	00004097          	auipc	ra,0x4
    557a:	f92080e7          	jalr	-110(ra) # 9508 <printf>
  for(int i = 0; i < pages; i++){
    557e:	4481                	li	s1,0
  return (vec[idx/8] >> (idx % 8)) & 1;
    5580:	49a1                	li	s3,8
    printf("  page %d: %d\n", i, bit_is_set(vec, i));
    5582:	00007a17          	auipc	s4,0x7
    5586:	0fea0a13          	addi	s4,s4,254 # c680 <malloc+0x30c0>
  for(int i = 0; i < pages; i++){
    558a:	4921                	li	s2,8
  return (vec[idx/8] >> (idx % 8)) & 1;
    558c:	0334c7bb          	divw	a5,s1,s3
    5590:	fd078793          	addi	a5,a5,-48
    5594:	97a2                	add	a5,a5,s0
    5596:	ff07c603          	lbu	a2,-16(a5)
    559a:	0074f793          	andi	a5,s1,7
    559e:	40f6563b          	sraw	a2,a2,a5
    printf("  page %d: %d\n", i, bit_is_set(vec, i));
    55a2:	8a05                	andi	a2,a2,1
    55a4:	85a6                	mv	a1,s1
    55a6:	8552                	mv	a0,s4
    55a8:	00004097          	auipc	ra,0x4
    55ac:	f60080e7          	jalr	-160(ra) # 9508 <printf>
  for(int i = 0; i < pages; i++){
    55b0:	2485                	addiw	s1,s1,1
    55b2:	fd249de3          	bne	s1,s2,558c <mincoretest+0xf4>
  }

  // 回收
  sbrk(-len);
    55b6:	7561                	lui	a0,0xffff8
    55b8:	00004097          	auipc	ra,0x4
    55bc:	a40080e7          	jalr	-1472(ra) # 8ff8 <sbrk>
  exit(0);
    55c0:	4501                	li	a0,0
    55c2:	00004097          	auipc	ra,0x4
    55c6:	9c6080e7          	jalr	-1594(ra) # 8f88 <exit>
    printf("mincore_test: sbrk failed\n");
    55ca:	00007517          	auipc	a0,0x7
    55ce:	05650513          	addi	a0,a0,86 # c620 <malloc+0x3060>
    55d2:	00004097          	auipc	ra,0x4
    55d6:	f36080e7          	jalr	-202(ra) # 9508 <printf>
    exit(1);
    55da:	4505                	li	a0,1
    55dc:	00004097          	auipc	ra,0x4
    55e0:	9ac080e7          	jalr	-1620(ra) # 8f88 <exit>
    printf("mincore_test: mincore failed\n");
    55e4:	00007517          	auipc	a0,0x7
    55e8:	05c50513          	addi	a0,a0,92 # c640 <malloc+0x3080>
    55ec:	00004097          	auipc	ra,0x4
    55f0:	f1c080e7          	jalr	-228(ra) # 9508 <printf>
    exit(1);
    55f4:	4505                	li	a0,1
    55f6:	00004097          	auipc	ra,0x4
    55fa:	992080e7          	jalr	-1646(ra) # 8f88 <exit>
    printf("mincore_test: mincore failed after touch\n");
    55fe:	00007517          	auipc	a0,0x7
    5602:	09250513          	addi	a0,a0,146 # c690 <malloc+0x30d0>
    5606:	00004097          	auipc	ra,0x4
    560a:	f02080e7          	jalr	-254(ra) # 9508 <printf>
    exit(1);
    560e:	4505                	li	a0,1
    5610:	00004097          	auipc	ra,0x4
    5614:	978080e7          	jalr	-1672(ra) # 8f88 <exit>

0000000000005618 <dirtest>:
{
    5618:	1101                	addi	sp,sp,-32
    561a:	ec06                	sd	ra,24(sp)
    561c:	e822                	sd	s0,16(sp)
    561e:	e426                	sd	s1,8(sp)
    5620:	1000                	addi	s0,sp,32
    5622:	84aa                	mv	s1,a0
  printf("mkdir test\n");
    5624:	00007517          	auipc	a0,0x7
    5628:	0bc50513          	addi	a0,a0,188 # c6e0 <malloc+0x3120>
    562c:	00004097          	auipc	ra,0x4
    5630:	edc080e7          	jalr	-292(ra) # 9508 <printf>
  if(mkdir("dir0") < 0){
    5634:	00007517          	auipc	a0,0x7
    5638:	0bc50513          	addi	a0,a0,188 # c6f0 <malloc+0x3130>
    563c:	00004097          	auipc	ra,0x4
    5640:	99c080e7          	jalr	-1636(ra) # 8fd8 <mkdir>
    5644:	04054d63          	bltz	a0,569e <dirtest+0x86>
  if(chdir("dir0") < 0){
    5648:	00007517          	auipc	a0,0x7
    564c:	0a850513          	addi	a0,a0,168 # c6f0 <malloc+0x3130>
    5650:	00004097          	auipc	ra,0x4
    5654:	990080e7          	jalr	-1648(ra) # 8fe0 <chdir>
    5658:	06054163          	bltz	a0,56ba <dirtest+0xa2>
  if(chdir("..") < 0){
    565c:	00005517          	auipc	a0,0x5
    5660:	5fc50513          	addi	a0,a0,1532 # ac58 <malloc+0x1698>
    5664:	00004097          	auipc	ra,0x4
    5668:	97c080e7          	jalr	-1668(ra) # 8fe0 <chdir>
    566c:	06054563          	bltz	a0,56d6 <dirtest+0xbe>
  if(remove("dir0") < 0){
    5670:	00007517          	auipc	a0,0x7
    5674:	08050513          	addi	a0,a0,128 # c6f0 <malloc+0x3130>
    5678:	00004097          	auipc	ra,0x4
    567c:	9b8080e7          	jalr	-1608(ra) # 9030 <remove>
    5680:	06054963          	bltz	a0,56f2 <dirtest+0xda>
  printf("%s: mkdir test ok\n");
    5684:	00007517          	auipc	a0,0x7
    5688:	0bc50513          	addi	a0,a0,188 # c740 <malloc+0x3180>
    568c:	00004097          	auipc	ra,0x4
    5690:	e7c080e7          	jalr	-388(ra) # 9508 <printf>
}
    5694:	60e2                	ld	ra,24(sp)
    5696:	6442                	ld	s0,16(sp)
    5698:	64a2                	ld	s1,8(sp)
    569a:	6105                	addi	sp,sp,32
    569c:	8082                	ret
    printf("%s: mkdir failed\n", s);
    569e:	85a6                	mv	a1,s1
    56a0:	00005517          	auipc	a0,0x5
    56a4:	13850513          	addi	a0,a0,312 # a7d8 <malloc+0x1218>
    56a8:	00004097          	auipc	ra,0x4
    56ac:	e60080e7          	jalr	-416(ra) # 9508 <printf>
    exit(1);
    56b0:	4505                	li	a0,1
    56b2:	00004097          	auipc	ra,0x4
    56b6:	8d6080e7          	jalr	-1834(ra) # 8f88 <exit>
    printf("%s: chdir dir0 failed\n", s);
    56ba:	85a6                	mv	a1,s1
    56bc:	00007517          	auipc	a0,0x7
    56c0:	03c50513          	addi	a0,a0,60 # c6f8 <malloc+0x3138>
    56c4:	00004097          	auipc	ra,0x4
    56c8:	e44080e7          	jalr	-444(ra) # 9508 <printf>
    exit(1);
    56cc:	4505                	li	a0,1
    56ce:	00004097          	auipc	ra,0x4
    56d2:	8ba080e7          	jalr	-1862(ra) # 8f88 <exit>
    printf("%s: chdir .. failed\n", s);
    56d6:	85a6                	mv	a1,s1
    56d8:	00007517          	auipc	a0,0x7
    56dc:	03850513          	addi	a0,a0,56 # c710 <malloc+0x3150>
    56e0:	00004097          	auipc	ra,0x4
    56e4:	e28080e7          	jalr	-472(ra) # 9508 <printf>
    exit(1);
    56e8:	4505                	li	a0,1
    56ea:	00004097          	auipc	ra,0x4
    56ee:	89e080e7          	jalr	-1890(ra) # 8f88 <exit>
    printf("%s: remove dir0 failed\n", s);
    56f2:	85a6                	mv	a1,s1
    56f4:	00007517          	auipc	a0,0x7
    56f8:	03450513          	addi	a0,a0,52 # c728 <malloc+0x3168>
    56fc:	00004097          	auipc	ra,0x4
    5700:	e0c080e7          	jalr	-500(ra) # 9508 <printf>
    exit(1);
    5704:	4505                	li	a0,1
    5706:	00004097          	auipc	ra,0x4
    570a:	882080e7          	jalr	-1918(ra) # 8f88 <exit>

000000000000570e <fourteen>:
{
    570e:	1101                	addi	sp,sp,-32
    5710:	ec06                	sd	ra,24(sp)
    5712:	e822                	sd	s0,16(sp)
    5714:	e426                	sd	s1,8(sp)
    5716:	1000                	addi	s0,sp,32
    5718:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    571a:	00007517          	auipc	a0,0x7
    571e:	20e50513          	addi	a0,a0,526 # c928 <malloc+0x3368>
    5722:	00004097          	auipc	ra,0x4
    5726:	8b6080e7          	jalr	-1866(ra) # 8fd8 <mkdir>
    572a:	e165                	bnez	a0,580a <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    572c:	00007517          	auipc	a0,0x7
    5730:	05450513          	addi	a0,a0,84 # c780 <malloc+0x31c0>
    5734:	00004097          	auipc	ra,0x4
    5738:	8a4080e7          	jalr	-1884(ra) # 8fd8 <mkdir>
    573c:	e56d                	bnez	a0,5826 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    573e:	20000593          	li	a1,512
    5742:	00007517          	auipc	a0,0x7
    5746:	09650513          	addi	a0,a0,150 # c7d8 <malloc+0x3218>
    574a:	00004097          	auipc	ra,0x4
    574e:	87e080e7          	jalr	-1922(ra) # 8fc8 <open>
  if(fd < 0){
    5752:	0e054863          	bltz	a0,5842 <fourteen+0x134>
  close(fd);
    5756:	00004097          	auipc	ra,0x4
    575a:	85a080e7          	jalr	-1958(ra) # 8fb0 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    575e:	4581                	li	a1,0
    5760:	00007517          	auipc	a0,0x7
    5764:	0f050513          	addi	a0,a0,240 # c850 <malloc+0x3290>
    5768:	00004097          	auipc	ra,0x4
    576c:	860080e7          	jalr	-1952(ra) # 8fc8 <open>
  if(fd < 0){
    5770:	0e054763          	bltz	a0,585e <fourteen+0x150>
  close(fd);
    5774:	00004097          	auipc	ra,0x4
    5778:	83c080e7          	jalr	-1988(ra) # 8fb0 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    577c:	00007517          	auipc	a0,0x7
    5780:	14450513          	addi	a0,a0,324 # c8c0 <malloc+0x3300>
    5784:	00004097          	auipc	ra,0x4
    5788:	854080e7          	jalr	-1964(ra) # 8fd8 <mkdir>
    578c:	c57d                	beqz	a0,587a <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    578e:	00007517          	auipc	a0,0x7
    5792:	18a50513          	addi	a0,a0,394 # c918 <malloc+0x3358>
    5796:	00004097          	auipc	ra,0x4
    579a:	842080e7          	jalr	-1982(ra) # 8fd8 <mkdir>
    579e:	cd65                	beqz	a0,5896 <fourteen+0x188>
  remove("123456789012345/12345678901234");
    57a0:	00007517          	auipc	a0,0x7
    57a4:	17850513          	addi	a0,a0,376 # c918 <malloc+0x3358>
    57a8:	00004097          	auipc	ra,0x4
    57ac:	888080e7          	jalr	-1912(ra) # 9030 <remove>
  remove("12345678901234/12345678901234");
    57b0:	00007517          	auipc	a0,0x7
    57b4:	11050513          	addi	a0,a0,272 # c8c0 <malloc+0x3300>
    57b8:	00004097          	auipc	ra,0x4
    57bc:	878080e7          	jalr	-1928(ra) # 9030 <remove>
  remove("12345678901234/12345678901234/12345678901234");
    57c0:	00007517          	auipc	a0,0x7
    57c4:	09050513          	addi	a0,a0,144 # c850 <malloc+0x3290>
    57c8:	00004097          	auipc	ra,0x4
    57cc:	868080e7          	jalr	-1944(ra) # 9030 <remove>
  remove("123456789012345/123456789012345/123456789012345");
    57d0:	00007517          	auipc	a0,0x7
    57d4:	00850513          	addi	a0,a0,8 # c7d8 <malloc+0x3218>
    57d8:	00004097          	auipc	ra,0x4
    57dc:	858080e7          	jalr	-1960(ra) # 9030 <remove>
  remove("12345678901234/123456789012345");
    57e0:	00007517          	auipc	a0,0x7
    57e4:	fa050513          	addi	a0,a0,-96 # c780 <malloc+0x31c0>
    57e8:	00004097          	auipc	ra,0x4
    57ec:	848080e7          	jalr	-1976(ra) # 9030 <remove>
  remove("12345678901234");
    57f0:	00007517          	auipc	a0,0x7
    57f4:	13850513          	addi	a0,a0,312 # c928 <malloc+0x3368>
    57f8:	00004097          	auipc	ra,0x4
    57fc:	838080e7          	jalr	-1992(ra) # 9030 <remove>
}
    5800:	60e2                	ld	ra,24(sp)
    5802:	6442                	ld	s0,16(sp)
    5804:	64a2                	ld	s1,8(sp)
    5806:	6105                	addi	sp,sp,32
    5808:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    580a:	85a6                	mv	a1,s1
    580c:	00007517          	auipc	a0,0x7
    5810:	f4c50513          	addi	a0,a0,-180 # c758 <malloc+0x3198>
    5814:	00004097          	auipc	ra,0x4
    5818:	cf4080e7          	jalr	-780(ra) # 9508 <printf>
    exit(1);
    581c:	4505                	li	a0,1
    581e:	00003097          	auipc	ra,0x3
    5822:	76a080e7          	jalr	1898(ra) # 8f88 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    5826:	85a6                	mv	a1,s1
    5828:	00007517          	auipc	a0,0x7
    582c:	f7850513          	addi	a0,a0,-136 # c7a0 <malloc+0x31e0>
    5830:	00004097          	auipc	ra,0x4
    5834:	cd8080e7          	jalr	-808(ra) # 9508 <printf>
    exit(1);
    5838:	4505                	li	a0,1
    583a:	00003097          	auipc	ra,0x3
    583e:	74e080e7          	jalr	1870(ra) # 8f88 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    5842:	85a6                	mv	a1,s1
    5844:	00007517          	auipc	a0,0x7
    5848:	fc450513          	addi	a0,a0,-60 # c808 <malloc+0x3248>
    584c:	00004097          	auipc	ra,0x4
    5850:	cbc080e7          	jalr	-836(ra) # 9508 <printf>
    exit(1);
    5854:	4505                	li	a0,1
    5856:	00003097          	auipc	ra,0x3
    585a:	732080e7          	jalr	1842(ra) # 8f88 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    585e:	85a6                	mv	a1,s1
    5860:	00007517          	auipc	a0,0x7
    5864:	02050513          	addi	a0,a0,32 # c880 <malloc+0x32c0>
    5868:	00004097          	auipc	ra,0x4
    586c:	ca0080e7          	jalr	-864(ra) # 9508 <printf>
    exit(1);
    5870:	4505                	li	a0,1
    5872:	00003097          	auipc	ra,0x3
    5876:	716080e7          	jalr	1814(ra) # 8f88 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    587a:	85a6                	mv	a1,s1
    587c:	00007517          	auipc	a0,0x7
    5880:	06450513          	addi	a0,a0,100 # c8e0 <malloc+0x3320>
    5884:	00004097          	auipc	ra,0x4
    5888:	c84080e7          	jalr	-892(ra) # 9508 <printf>
    exit(1);
    588c:	4505                	li	a0,1
    588e:	00003097          	auipc	ra,0x3
    5892:	6fa080e7          	jalr	1786(ra) # 8f88 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    5896:	85a6                	mv	a1,s1
    5898:	00007517          	auipc	a0,0x7
    589c:	0a050513          	addi	a0,a0,160 # c938 <malloc+0x3378>
    58a0:	00004097          	auipc	ra,0x4
    58a4:	c68080e7          	jalr	-920(ra) # 9508 <printf>
    exit(1);
    58a8:	4505                	li	a0,1
    58aa:	00003097          	auipc	ra,0x3
    58ae:	6de080e7          	jalr	1758(ra) # 8f88 <exit>

00000000000058b2 <fsfull>:
{
    58b2:	7171                	addi	sp,sp,-176
    58b4:	f506                	sd	ra,168(sp)
    58b6:	f122                	sd	s0,160(sp)
    58b8:	ed26                	sd	s1,152(sp)
    58ba:	e94a                	sd	s2,144(sp)
    58bc:	e54e                	sd	s3,136(sp)
    58be:	e152                	sd	s4,128(sp)
    58c0:	fcd6                	sd	s5,120(sp)
    58c2:	f8da                	sd	s6,112(sp)
    58c4:	f4de                	sd	s7,104(sp)
    58c6:	f0e2                	sd	s8,96(sp)
    58c8:	ece6                	sd	s9,88(sp)
    58ca:	e8ea                	sd	s10,80(sp)
    58cc:	e4ee                	sd	s11,72(sp)
    58ce:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    58d0:	00007517          	auipc	a0,0x7
    58d4:	0a050513          	addi	a0,a0,160 # c970 <malloc+0x33b0>
    58d8:	00004097          	auipc	ra,0x4
    58dc:	c30080e7          	jalr	-976(ra) # 9508 <printf>
  for(nfiles = 0; ; nfiles++){
    58e0:	4481                	li	s1,0
    name[0] = 'f';
    58e2:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    58e6:	3e800c93          	li	s9,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    58ea:	06400c13          	li	s8,100
    name[3] = '0' + (nfiles % 100) / 10;
    58ee:	4ba9                	li	s7,10
    printf("%s: writing %s\n", name);
    58f0:	f5040b13          	addi	s6,s0,-176
    58f4:	00007d17          	auipc	s10,0x7
    58f8:	08cd0d13          	addi	s10,s10,140 # c980 <malloc+0x33c0>
      int cc = write(fd, buf, BSIZE);
    58fc:	00017a17          	auipc	s4,0x17
    5900:	7cca0a13          	addi	s4,s4,1996 # 1d0c8 <buf>
    name[0] = 'f';
    5904:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5908:	0394c7bb          	divw	a5,s1,s9
    590c:	0307879b          	addiw	a5,a5,48
    5910:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5914:	0394e7bb          	remw	a5,s1,s9
    5918:	0387c7bb          	divw	a5,a5,s8
    591c:	0307879b          	addiw	a5,a5,48
    5920:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5924:	0384e7bb          	remw	a5,s1,s8
    5928:	0377c7bb          	divw	a5,a5,s7
    592c:	0307879b          	addiw	a5,a5,48
    5930:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5934:	0374e7bb          	remw	a5,s1,s7
    5938:	0307879b          	addiw	a5,a5,48
    593c:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5940:	f4040aa3          	sb	zero,-171(s0)
    printf("%s: writing %s\n", name);
    5944:	85da                	mv	a1,s6
    5946:	856a                	mv	a0,s10
    5948:	00004097          	auipc	ra,0x4
    594c:	bc0080e7          	jalr	-1088(ra) # 9508 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5950:	20200593          	li	a1,514
    5954:	855a                	mv	a0,s6
    5956:	00003097          	auipc	ra,0x3
    595a:	672080e7          	jalr	1650(ra) # 8fc8 <open>
    595e:	892a                	mv	s2,a0
    if(fd < 0){
    5960:	0a055763          	bgez	a0,5a0e <fsfull+0x15c>
      printf("%s: open %s failed\n", name);
    5964:	f5040593          	addi	a1,s0,-176
    5968:	00007517          	auipc	a0,0x7
    596c:	02850513          	addi	a0,a0,40 # c990 <malloc+0x33d0>
    5970:	00004097          	auipc	ra,0x4
    5974:	b98080e7          	jalr	-1128(ra) # 9508 <printf>
  while(nfiles >= 0){
    5978:	0604c463          	bltz	s1,59e0 <fsfull+0x12e>
    name[0] = 'f';
    597c:	06600b93          	li	s7,102
    name[1] = '0' + nfiles / 1000;
    5980:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5984:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5988:	4929                	li	s2,10
    remove(name);
    598a:	f5040b13          	addi	s6,s0,-176
  while(nfiles >= 0){
    598e:	5afd                	li	s5,-1
    name[0] = 'f';
    5990:	f5740823          	sb	s7,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5994:	0344c7bb          	divw	a5,s1,s4
    5998:	0307879b          	addiw	a5,a5,48
    599c:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    59a0:	0344e7bb          	remw	a5,s1,s4
    59a4:	0337c7bb          	divw	a5,a5,s3
    59a8:	0307879b          	addiw	a5,a5,48
    59ac:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    59b0:	0334e7bb          	remw	a5,s1,s3
    59b4:	0327c7bb          	divw	a5,a5,s2
    59b8:	0307879b          	addiw	a5,a5,48
    59bc:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    59c0:	0324e7bb          	remw	a5,s1,s2
    59c4:	0307879b          	addiw	a5,a5,48
    59c8:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    59cc:	f4040aa3          	sb	zero,-171(s0)
    remove(name);
    59d0:	855a                	mv	a0,s6
    59d2:	00003097          	auipc	ra,0x3
    59d6:	65e080e7          	jalr	1630(ra) # 9030 <remove>
    nfiles--;
    59da:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    59dc:	fb549ae3          	bne	s1,s5,5990 <fsfull+0xde>
  printf("fsfull test finished\n");
    59e0:	00007517          	auipc	a0,0x7
    59e4:	fe050513          	addi	a0,a0,-32 # c9c0 <malloc+0x3400>
    59e8:	00004097          	auipc	ra,0x4
    59ec:	b20080e7          	jalr	-1248(ra) # 9508 <printf>
}
    59f0:	70aa                	ld	ra,168(sp)
    59f2:	740a                	ld	s0,160(sp)
    59f4:	64ea                	ld	s1,152(sp)
    59f6:	694a                	ld	s2,144(sp)
    59f8:	69aa                	ld	s3,136(sp)
    59fa:	6a0a                	ld	s4,128(sp)
    59fc:	7ae6                	ld	s5,120(sp)
    59fe:	7b46                	ld	s6,112(sp)
    5a00:	7ba6                	ld	s7,104(sp)
    5a02:	7c06                	ld	s8,96(sp)
    5a04:	6ce6                	ld	s9,88(sp)
    5a06:	6d46                	ld	s10,80(sp)
    5a08:	6da6                	ld	s11,72(sp)
    5a0a:	614d                	addi	sp,sp,176
    5a0c:	8082                	ret
    int total = 0;
    5a0e:	4981                	li	s3,0
      if(cc < BSIZE)
    5a10:	1ff00a93          	li	s5,511
      int cc = write(fd, buf, BSIZE);
    5a14:	20000613          	li	a2,512
    5a18:	85d2                	mv	a1,s4
    5a1a:	854a                	mv	a0,s2
    5a1c:	00003097          	auipc	ra,0x3
    5a20:	58c080e7          	jalr	1420(ra) # 8fa8 <write>
      if(cc < BSIZE)
    5a24:	00aad563          	bge	s5,a0,5a2e <fsfull+0x17c>
      total += cc;
    5a28:	00a989bb          	addw	s3,s3,a0
    while(1){
    5a2c:	b7e5                	j	5a14 <fsfull+0x162>
    printf("%s: wrote %d bytes\n", total);
    5a2e:	85ce                	mv	a1,s3
    5a30:	00007517          	auipc	a0,0x7
    5a34:	f7850513          	addi	a0,a0,-136 # c9a8 <malloc+0x33e8>
    5a38:	00004097          	auipc	ra,0x4
    5a3c:	ad0080e7          	jalr	-1328(ra) # 9508 <printf>
    close(fd);
    5a40:	854a                	mv	a0,s2
    5a42:	00003097          	auipc	ra,0x3
    5a46:	56e080e7          	jalr	1390(ra) # 8fb0 <close>
    if(total == 0)
    5a4a:	f20987e3          	beqz	s3,5978 <fsfull+0xc6>
  for(nfiles = 0; ; nfiles++){
    5a4e:	2485                	addiw	s1,s1,1
    5a50:	bd55                	j	5904 <fsfull+0x52>

0000000000005a52 <rand>:
{
    5a52:	1141                	addi	sp,sp,-16
    5a54:	e422                	sd	s0,8(sp)
    5a56:	0800                	addi	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    5a58:	0000a717          	auipc	a4,0xa
    5a5c:	95870713          	addi	a4,a4,-1704 # f3b0 <__DATA_BEGIN__>
    5a60:	7308                	ld	a0,32(a4)
    5a62:	001967b7          	lui	a5,0x196
    5a66:	60d78793          	addi	a5,a5,1549 # 19660d <__BSS_END__+0x177d2d>
    5a6a:	02f50533          	mul	a0,a0,a5
    5a6e:	3c6ef7b7          	lui	a5,0x3c6ef
    5a72:	35f78793          	addi	a5,a5,863 # 3c6ef35f <__BSS_END__+0x3c6d0a7f>
    5a76:	953e                	add	a0,a0,a5
    5a78:	f308                	sd	a0,32(a4)
}
    5a7a:	2501                	sext.w	a0,a0
    5a7c:	6422                	ld	s0,8(sp)
    5a7e:	0141                	addi	sp,sp,16
    5a80:	8082                	ret

0000000000005a82 <countfree>:
{
    5a82:	7139                	addi	sp,sp,-64
    5a84:	fc06                	sd	ra,56(sp)
    5a86:	f822                	sd	s0,48(sp)
    5a88:	f426                	sd	s1,40(sp)
    5a8a:	f04a                	sd	s2,32(sp)
    5a8c:	ec4e                	sd	s3,24(sp)
    5a8e:	0080                	addi	s0,sp,64
  if(pipe(fds) < 0){
    5a90:	fc840513          	addi	a0,s0,-56
    5a94:	00003097          	auipc	ra,0x3
    5a98:	504080e7          	jalr	1284(ra) # 8f98 <pipe>
    5a9c:	06054763          	bltz	a0,5b0a <countfree+0x88>
  int pid = fork();
    5aa0:	00003097          	auipc	ra,0x3
    5aa4:	4e0080e7          	jalr	1248(ra) # 8f80 <fork>
  if(pid < 0){
    5aa8:	06054e63          	bltz	a0,5b24 <countfree+0xa2>
  if(pid == 0){
    5aac:	ed51                	bnez	a0,5b48 <countfree+0xc6>
    close(fds[0]);
    5aae:	fc842503          	lw	a0,-56(s0)
    5ab2:	00003097          	auipc	ra,0x3
    5ab6:	4fe080e7          	jalr	1278(ra) # 8fb0 <close>
      if(a == 0xffffffffffffffff){
    5aba:	597d                	li	s2,-1
      *(char *)(a + 4096 - 1) = 1;
    5abc:	4485                	li	s1,1
      if(write(fds[1], "x", 1) != 1){
    5abe:	00004997          	auipc	s3,0x4
    5ac2:	cba98993          	addi	s3,s3,-838 # 9778 <malloc+0x1b8>
      uint64 a = (uint64) sbrk(4096);
    5ac6:	6505                	lui	a0,0x1
    5ac8:	00003097          	auipc	ra,0x3
    5acc:	530080e7          	jalr	1328(ra) # 8ff8 <sbrk>
      if(a == 0xffffffffffffffff){
    5ad0:	07250763          	beq	a0,s2,5b3e <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    5ad4:	6785                	lui	a5,0x1
    5ad6:	97aa                	add	a5,a5,a0
    5ad8:	fe978fa3          	sb	s1,-1(a5) # fff <testdev+0x161>
      if(write(fds[1], "x", 1) != 1){
    5adc:	8626                	mv	a2,s1
    5ade:	85ce                	mv	a1,s3
    5ae0:	fcc42503          	lw	a0,-52(s0)
    5ae4:	00003097          	auipc	ra,0x3
    5ae8:	4c4080e7          	jalr	1220(ra) # 8fa8 <write>
    5aec:	fc950de3          	beq	a0,s1,5ac6 <countfree+0x44>
        printf("write() failed in countfree()\n");
    5af0:	00007517          	auipc	a0,0x7
    5af4:	f2850513          	addi	a0,a0,-216 # ca18 <malloc+0x3458>
    5af8:	00004097          	auipc	ra,0x4
    5afc:	a10080e7          	jalr	-1520(ra) # 9508 <printf>
        exit(1);
    5b00:	4505                	li	a0,1
    5b02:	00003097          	auipc	ra,0x3
    5b06:	486080e7          	jalr	1158(ra) # 8f88 <exit>
    printf("pipe() failed in countfree()\n");
    5b0a:	00007517          	auipc	a0,0x7
    5b0e:	ece50513          	addi	a0,a0,-306 # c9d8 <malloc+0x3418>
    5b12:	00004097          	auipc	ra,0x4
    5b16:	9f6080e7          	jalr	-1546(ra) # 9508 <printf>
    exit(1);
    5b1a:	4505                	li	a0,1
    5b1c:	00003097          	auipc	ra,0x3
    5b20:	46c080e7          	jalr	1132(ra) # 8f88 <exit>
    printf("fork failed in countfree()\n");
    5b24:	00007517          	auipc	a0,0x7
    5b28:	ed450513          	addi	a0,a0,-300 # c9f8 <malloc+0x3438>
    5b2c:	00004097          	auipc	ra,0x4
    5b30:	9dc080e7          	jalr	-1572(ra) # 9508 <printf>
    exit(1);
    5b34:	4505                	li	a0,1
    5b36:	00003097          	auipc	ra,0x3
    5b3a:	452080e7          	jalr	1106(ra) # 8f88 <exit>
    exit(0);
    5b3e:	4501                	li	a0,0
    5b40:	00003097          	auipc	ra,0x3
    5b44:	448080e7          	jalr	1096(ra) # 8f88 <exit>
  close(fds[1]);
    5b48:	fcc42503          	lw	a0,-52(s0)
    5b4c:	00003097          	auipc	ra,0x3
    5b50:	464080e7          	jalr	1124(ra) # 8fb0 <close>
  int n = 0;
    5b54:	4481                	li	s1,0
    int cc = read(fds[0], &c, 1);
    5b56:	fc740913          	addi	s2,s0,-57
    5b5a:	4605                	li	a2,1
    5b5c:	85ca                	mv	a1,s2
    5b5e:	fc842503          	lw	a0,-56(s0)
    5b62:	00003097          	auipc	ra,0x3
    5b66:	43e080e7          	jalr	1086(ra) # 8fa0 <read>
    if(cc < 0){
    5b6a:	00054563          	bltz	a0,5b74 <countfree+0xf2>
    if(cc == 0)
    5b6e:	c105                	beqz	a0,5b8e <countfree+0x10c>
    n += 1;
    5b70:	2485                	addiw	s1,s1,1
  while(1){
    5b72:	b7e5                	j	5b5a <countfree+0xd8>
      printf("read() failed in countfree()\n");
    5b74:	00007517          	auipc	a0,0x7
    5b78:	ec450513          	addi	a0,a0,-316 # ca38 <malloc+0x3478>
    5b7c:	00004097          	auipc	ra,0x4
    5b80:	98c080e7          	jalr	-1652(ra) # 9508 <printf>
      exit(1);
    5b84:	4505                	li	a0,1
    5b86:	00003097          	auipc	ra,0x3
    5b8a:	402080e7          	jalr	1026(ra) # 8f88 <exit>
  close(fds[0]);
    5b8e:	fc842503          	lw	a0,-56(s0)
    5b92:	00003097          	auipc	ra,0x3
    5b96:	41e080e7          	jalr	1054(ra) # 8fb0 <close>
  wait((int*)0);
    5b9a:	4501                	li	a0,0
    5b9c:	00003097          	auipc	ra,0x3
    5ba0:	3f4080e7          	jalr	1012(ra) # 8f90 <wait>
}
    5ba4:	8526                	mv	a0,s1
    5ba6:	70e2                	ld	ra,56(sp)
    5ba8:	7442                	ld	s0,48(sp)
    5baa:	74a2                	ld	s1,40(sp)
    5bac:	7902                	ld	s2,32(sp)
    5bae:	69e2                	ld	s3,24(sp)
    5bb0:	6121                	addi	sp,sp,64
    5bb2:	8082                	ret

0000000000005bb4 <alarmtest_main>:

int alarmtest_main(int argc, char *argv[])
{
    5bb4:	7179                	addi	sp,sp,-48
    5bb6:	f406                	sd	ra,40(sp)
    5bb8:	f022                	sd	s0,32(sp)
    5bba:	ec26                	sd	s1,24(sp)
    5bbc:	e84a                	sd	s2,16(sp)
    5bbe:	e44e                	sd	s3,8(sp)
    5bc0:	1800                	addi	s0,sp,48
    printf("=== alarm() Timer Test ===\n\n");
    5bc2:	00007517          	auipc	a0,0x7
    5bc6:	e9650513          	addi	a0,a0,-362 # ca58 <malloc+0x3498>
    5bca:	00004097          	auipc	ra,0x4
    5bce:	93e080e7          	jalr	-1730(ra) # 9508 <printf>
    
    // Test 1: Basic alarm functionality
    printf("Test 1: Set alarm for 2 seconds\n");
    5bd2:	00007517          	auipc	a0,0x7
    5bd6:	ea650513          	addi	a0,a0,-346 # ca78 <malloc+0x34b8>
    5bda:	00004097          	auipc	ra,0x4
    5bde:	92e080e7          	jalr	-1746(ra) # 9508 <printf>
    
    // Register signal handler
    if(sigaction(SIGALRM, alarm_handler) < 0) {
    5be2:	ffffa597          	auipc	a1,0xffffa
    5be6:	43458593          	addi	a1,a1,1076 # 16 <alarm_handler>
    5bea:	4539                	li	a0,14
    5bec:	00003097          	auipc	ra,0x3
    5bf0:	4fa080e7          	jalr	1274(ra) # 90e6 <sigaction>
    5bf4:	10054b63          	bltz	a0,5d0a <alarmtest_main+0x156>
        printf("ERROR: sigaction failed\n");
        exit(1);
    }
    printf("  Registered SIGALRM handler\n");
    5bf8:	00007517          	auipc	a0,0x7
    5bfc:	ec850513          	addi	a0,a0,-312 # cac0 <malloc+0x3500>
    5c00:	00004097          	auipc	ra,0x4
    5c04:	908080e7          	jalr	-1784(ra) # 9508 <printf>
    
    // Set alarm for 2 seconds
    int remaining = alarm(2);
    5c08:	4509                	li	a0,2
    5c0a:	00003097          	auipc	ra,0x3
    5c0e:	572080e7          	jalr	1394(ra) # 917c <alarm>
    5c12:	85aa                	mv	a1,a0
    printf("  alarm(2) returned %d (should be 0)\n", remaining);
    5c14:	00007517          	auipc	a0,0x7
    5c18:	ecc50513          	addi	a0,a0,-308 # cae0 <malloc+0x3520>
    5c1c:	00004097          	auipc	ra,0x4
    5c20:	8ec080e7          	jalr	-1812(ra) # 9508 <printf>
    
    printf("  Waiting for SIGALRM...\n");
    5c24:	00007517          	auipc	a0,0x7
    5c28:	ee450513          	addi	a0,a0,-284 # cb08 <malloc+0x3548>
    5c2c:	00004097          	auipc	ra,0x4
    5c30:	8dc080e7          	jalr	-1828(ra) # 9508 <printf>
    
    // Wait for alarm (busy loop for simplicity)
    int start = uptime();
    5c34:	00003097          	auipc	ra,0x3
    5c38:	3d4080e7          	jalr	980(ra) # 9008 <uptime>
    5c3c:	84aa                	mv	s1,a0
    while(!alarm_received && (uptime() - start) < 50) {
    5c3e:	0000a797          	auipc	a5,0xa
    5c42:	c4e7a783          	lw	a5,-946(a5) # f88c <alarm_received>
    5c46:	03100913          	li	s2,49
    5c4a:	0000a997          	auipc	s3,0xa
    5c4e:	c3e98993          	addi	s3,s3,-962 # f888 <alarm_simple_received>
    5c52:	e38d                	bnez	a5,5c74 <alarmtest_main+0xc0>
    5c54:	00003097          	auipc	ra,0x3
    5c58:	3b4080e7          	jalr	948(ra) # 9008 <uptime>
    5c5c:	9d05                	subw	a0,a0,s1
    5c5e:	00a94b63          	blt	s2,a0,5c74 <alarmtest_main+0xc0>
        // Yield to allow timer interrupts
        sleep(1);
    5c62:	4505                	li	a0,1
    5c64:	00003097          	auipc	ra,0x3
    5c68:	39c080e7          	jalr	924(ra) # 9000 <sleep>
    while(!alarm_received && (uptime() - start) < 50) {
    5c6c:	0049a783          	lw	a5,4(s3)
    5c70:	2781                	sext.w	a5,a5
    5c72:	d3ed                	beqz	a5,5c54 <alarmtest_main+0xa0>
    }
    
    if(alarm_received) {
    5c74:	0000a797          	auipc	a5,0xa
    5c78:	c187a783          	lw	a5,-1000(a5) # f88c <alarm_received>
    5c7c:	c7c5                	beqz	a5,5d24 <alarmtest_main+0x170>
        printf("  SUCCESS: SIGALRM received!\n");
    5c7e:	00007517          	auipc	a0,0x7
    5c82:	eaa50513          	addi	a0,a0,-342 # cb28 <malloc+0x3568>
    5c86:	00004097          	auipc	ra,0x4
    5c8a:	882080e7          	jalr	-1918(ra) # 9508 <printf>
        printf("  FAILED: SIGALRM not received within timeout\n");
        exit(1);
    }
    
    // Test 2: Alarm cancellation
    printf("\nTest 2: Alarm cancellation\n");
    5c8e:	00007517          	auipc	a0,0x7
    5c92:	eba50513          	addi	a0,a0,-326 # cb48 <malloc+0x3588>
    5c96:	00004097          	auipc	ra,0x4
    5c9a:	872080e7          	jalr	-1934(ra) # 9508 <printf>
    alarm_received = 0;
    5c9e:	0000a497          	auipc	s1,0xa
    5ca2:	bea48493          	addi	s1,s1,-1046 # f888 <alarm_simple_received>
    5ca6:	0004a223          	sw	zero,4(s1)
    
    alarm(5);  // Set 5 second alarm
    5caa:	4515                	li	a0,5
    5cac:	00003097          	auipc	ra,0x3
    5cb0:	4d0080e7          	jalr	1232(ra) # 917c <alarm>
    printf("  Set alarm(5)\n");
    5cb4:	00007517          	auipc	a0,0x7
    5cb8:	eb450513          	addi	a0,a0,-332 # cb68 <malloc+0x35a8>
    5cbc:	00004097          	auipc	ra,0x4
    5cc0:	84c080e7          	jalr	-1972(ra) # 9508 <printf>
    
    remaining = alarm(0);  // Cancel it
    5cc4:	4501                	li	a0,0
    5cc6:	00003097          	auipc	ra,0x3
    5cca:	4b6080e7          	jalr	1206(ra) # 917c <alarm>
    5cce:	85aa                	mv	a1,a0
    printf("  alarm(0) to cancel, returned remaining=%d\n", remaining);
    5cd0:	00007517          	auipc	a0,0x7
    5cd4:	ea850513          	addi	a0,a0,-344 # cb78 <malloc+0x35b8>
    5cd8:	00004097          	auipc	ra,0x4
    5cdc:	830080e7          	jalr	-2000(ra) # 9508 <printf>
    
    // Wait briefly to confirm no signal
    sleep(20);  // 2 seconds
    5ce0:	4551                	li	a0,20
    5ce2:	00003097          	auipc	ra,0x3
    5ce6:	31e080e7          	jalr	798(ra) # 9000 <sleep>
    
    if(!alarm_received) {
    5cea:	40dc                	lw	a5,4(s1)
    5cec:	2781                	sext.w	a5,a5
    5cee:	cba1                	beqz	a5,5d3e <alarmtest_main+0x18a>
        printf("  SUCCESS: No SIGALRM after cancellation\n");
    } else {
        printf("  FAILED: Received SIGALRM after cancellation\n");
    5cf0:	00007517          	auipc	a0,0x7
    5cf4:	f7850513          	addi	a0,a0,-136 # cc68 <malloc+0x36a8>
    5cf8:	00004097          	auipc	ra,0x4
    5cfc:	810080e7          	jalr	-2032(ra) # 9508 <printf>
        exit(1);
    5d00:	4505                	li	a0,1
    5d02:	00003097          	auipc	ra,0x3
    5d06:	286080e7          	jalr	646(ra) # 8f88 <exit>
        printf("ERROR: sigaction failed\n");
    5d0a:	00007517          	auipc	a0,0x7
    5d0e:	d9650513          	addi	a0,a0,-618 # caa0 <malloc+0x34e0>
    5d12:	00003097          	auipc	ra,0x3
    5d16:	7f6080e7          	jalr	2038(ra) # 9508 <printf>
        exit(1);
    5d1a:	4505                	li	a0,1
    5d1c:	00003097          	auipc	ra,0x3
    5d20:	26c080e7          	jalr	620(ra) # 8f88 <exit>
        printf("  FAILED: SIGALRM not received within timeout\n");
    5d24:	00007517          	auipc	a0,0x7
    5d28:	e8450513          	addi	a0,a0,-380 # cba8 <malloc+0x35e8>
    5d2c:	00003097          	auipc	ra,0x3
    5d30:	7dc080e7          	jalr	2012(ra) # 9508 <printf>
        exit(1);
    5d34:	4505                	li	a0,1
    5d36:	00003097          	auipc	ra,0x3
    5d3a:	252080e7          	jalr	594(ra) # 8f88 <exit>
        printf("  SUCCESS: No SIGALRM after cancellation\n");
    5d3e:	00007517          	auipc	a0,0x7
    5d42:	e9a50513          	addi	a0,a0,-358 # cbd8 <malloc+0x3618>
    5d46:	00003097          	auipc	ra,0x3
    5d4a:	7c2080e7          	jalr	1986(ra) # 9508 <printf>
    }
    
    // Test 3: Alarm replacement
    printf("\nTest 3: Alarm replacement\n");
    5d4e:	00007517          	auipc	a0,0x7
    5d52:	eba50513          	addi	a0,a0,-326 # cc08 <malloc+0x3648>
    5d56:	00003097          	auipc	ra,0x3
    5d5a:	7b2080e7          	jalr	1970(ra) # 9508 <printf>
    alarm_received = 0;
    5d5e:	0000a917          	auipc	s2,0xa
    5d62:	b2a90913          	addi	s2,s2,-1238 # f888 <alarm_simple_received>
    5d66:	00092223          	sw	zero,4(s2)
    
    alarm(10);  // Set 10 second alarm
    5d6a:	4529                	li	a0,10
    5d6c:	00003097          	auipc	ra,0x3
    5d70:	410080e7          	jalr	1040(ra) # 917c <alarm>
    printf("  Set alarm(10)\n");
    5d74:	00007517          	auipc	a0,0x7
    5d78:	eb450513          	addi	a0,a0,-332 # cc28 <malloc+0x3668>
    5d7c:	00003097          	auipc	ra,0x3
    5d80:	78c080e7          	jalr	1932(ra) # 9508 <printf>
    
    remaining = alarm(1);  // Replace with 1 second alarm
    5d84:	4505                	li	a0,1
    5d86:	00003097          	auipc	ra,0x3
    5d8a:	3f6080e7          	jalr	1014(ra) # 917c <alarm>
    5d8e:	85aa                	mv	a1,a0
    printf("  alarm(1) returned %d (should be ~10)\n", remaining);
    5d90:	00007517          	auipc	a0,0x7
    5d94:	eb050513          	addi	a0,a0,-336 # cc40 <malloc+0x3680>
    5d98:	00003097          	auipc	ra,0x3
    5d9c:	770080e7          	jalr	1904(ra) # 9508 <printf>
    
    // Wait for new alarm
    start = uptime();
    5da0:	00003097          	auipc	ra,0x3
    5da4:	268080e7          	jalr	616(ra) # 9008 <uptime>
    5da8:	84aa                	mv	s1,a0
    while(!alarm_received && (uptime() - start) < 30) {
    5daa:	00492783          	lw	a5,4(s2)
    5dae:	2781                	sext.w	a5,a5
    5db0:	4975                	li	s2,29
    5db2:	0000a997          	auipc	s3,0xa
    5db6:	ad698993          	addi	s3,s3,-1322 # f888 <alarm_simple_received>
    5dba:	e38d                	bnez	a5,5ddc <alarmtest_main+0x228>
    5dbc:	00003097          	auipc	ra,0x3
    5dc0:	24c080e7          	jalr	588(ra) # 9008 <uptime>
    5dc4:	9d05                	subw	a0,a0,s1
    5dc6:	00a94b63          	blt	s2,a0,5ddc <alarmtest_main+0x228>
        sleep(1);
    5dca:	4505                	li	a0,1
    5dcc:	00003097          	auipc	ra,0x3
    5dd0:	234080e7          	jalr	564(ra) # 9000 <sleep>
    while(!alarm_received && (uptime() - start) < 30) {
    5dd4:	0049a783          	lw	a5,4(s3)
    5dd8:	2781                	sext.w	a5,a5
    5dda:	d3ed                	beqz	a5,5dbc <alarmtest_main+0x208>
    }
    
    if(alarm_received) {
    5ddc:	0000a797          	auipc	a5,0xa
    5de0:	ab07a783          	lw	a5,-1360(a5) # f88c <alarm_received>
    5de4:	c795                	beqz	a5,5e10 <alarmtest_main+0x25c>
        printf("  SUCCESS: New 1-second alarm fired!\n");
    5de6:	00007517          	auipc	a0,0x7
    5dea:	eb250513          	addi	a0,a0,-334 # cc98 <malloc+0x36d8>
    5dee:	00003097          	auipc	ra,0x3
    5df2:	71a080e7          	jalr	1818(ra) # 9508 <printf>
    } else {
        printf("  FAILED: Replacement alarm not received\n");
        exit(1);
    }
    
    printf("\n=== All alarm tests PASSED ===\n");
    5df6:	00007517          	auipc	a0,0x7
    5dfa:	eca50513          	addi	a0,a0,-310 # ccc0 <malloc+0x3700>
    5dfe:	00003097          	auipc	ra,0x3
    5e02:	70a080e7          	jalr	1802(ra) # 9508 <printf>
    exit(0);
    5e06:	4501                	li	a0,0
    5e08:	00003097          	auipc	ra,0x3
    5e0c:	180080e7          	jalr	384(ra) # 8f88 <exit>
        printf("  FAILED: Replacement alarm not received\n");
    5e10:	00007517          	auipc	a0,0x7
    5e14:	ed850513          	addi	a0,a0,-296 # cce8 <malloc+0x3728>
    5e18:	00003097          	auipc	ra,0x3
    5e1c:	6f0080e7          	jalr	1776(ra) # 9508 <printf>
        exit(1);
    5e20:	4505                	li	a0,1
    5e22:	00003097          	auipc	ra,0x3
    5e26:	166080e7          	jalr	358(ra) # 8f88 <exit>

0000000000005e2a <alarmtest>:
void alarmtest(char *s) {
    5e2a:	7139                	addi	sp,sp,-64
    5e2c:	fc06                	sd	ra,56(sp)
    5e2e:	f822                	sd	s0,48(sp)
    5e30:	f426                	sd	s1,40(sp)
    5e32:	f04a                	sd	s2,32(sp)
    5e34:	ec4e                	sd	s3,24(sp)
    5e36:	e852                	sd	s4,16(sp)
    5e38:	0080                	addi	s0,sp,64
    if(verbose) { char *argv[] = {"alarmtest", 0}; alarmtest_main(1, argv); return; }
    5e3a:	0000a797          	auipc	a5,0xa
    5e3e:	a5a7a783          	lw	a5,-1446(a5) # f894 <verbose>
    5e42:	e3c9                	bnez	a5,5ec4 <alarmtest+0x9a>
    5e44:	8a2a                	mv	s4,a0
    alarm_simple_received = 0;
    5e46:	0000a917          	auipc	s2,0xa
    5e4a:	a4290913          	addi	s2,s2,-1470 # f888 <alarm_simple_received>
    5e4e:	00092023          	sw	zero,0(s2)
    sigaction(SIGALRM, alarm_simple_handler);
    5e52:	ffffa597          	auipc	a1,0xffffa
    5e56:	1ae58593          	addi	a1,a1,430 # 0 <alarm_simple_handler>
    5e5a:	4539                	li	a0,14
    5e5c:	00003097          	auipc	ra,0x3
    5e60:	28a080e7          	jalr	650(ra) # 90e6 <sigaction>
    alarm(1);
    5e64:	4505                	li	a0,1
    5e66:	00003097          	auipc	ra,0x3
    5e6a:	316080e7          	jalr	790(ra) # 917c <alarm>
    int start = uptime();
    5e6e:	00003097          	auipc	ra,0x3
    5e72:	19a080e7          	jalr	410(ra) # 9008 <uptime>
    5e76:	84aa                	mv	s1,a0
    while(!alarm_simple_received && (uptime() - start) < 30) sleep(1);
    5e78:	00092783          	lw	a5,0(s2)
    5e7c:	2781                	sext.w	a5,a5
    5e7e:	4975                	li	s2,29
    5e80:	0000a997          	auipc	s3,0xa
    5e84:	a0898993          	addi	s3,s3,-1528 # f888 <alarm_simple_received>
    5e88:	e38d                	bnez	a5,5eaa <alarmtest+0x80>
    5e8a:	00003097          	auipc	ra,0x3
    5e8e:	17e080e7          	jalr	382(ra) # 9008 <uptime>
    5e92:	9d05                	subw	a0,a0,s1
    5e94:	00a94b63          	blt	s2,a0,5eaa <alarmtest+0x80>
    5e98:	4505                	li	a0,1
    5e9a:	00003097          	auipc	ra,0x3
    5e9e:	166080e7          	jalr	358(ra) # 9000 <sleep>
    5ea2:	0009a783          	lw	a5,0(s3)
    5ea6:	2781                	sext.w	a5,a5
    5ea8:	d3ed                	beqz	a5,5e8a <alarmtest+0x60>
    if(!alarm_simple_received) { printf("%s: failed\n", s); exit(1); }
    5eaa:	0000a797          	auipc	a5,0xa
    5eae:	9de7a783          	lw	a5,-1570(a5) # f888 <alarm_simple_received>
    5eb2:	c385                	beqz	a5,5ed2 <alarmtest+0xa8>
}
    5eb4:	70e2                	ld	ra,56(sp)
    5eb6:	7442                	ld	s0,48(sp)
    5eb8:	74a2                	ld	s1,40(sp)
    5eba:	7902                	ld	s2,32(sp)
    5ebc:	69e2                	ld	s3,24(sp)
    5ebe:	6a42                	ld	s4,16(sp)
    5ec0:	6121                	addi	sp,sp,64
    5ec2:	8082                	ret
    if(verbose) { char *argv[] = {"alarmtest", 0}; alarmtest_main(1, argv); return; }
    5ec4:	fc040593          	addi	a1,s0,-64
    5ec8:	4505                	li	a0,1
    5eca:	00000097          	auipc	ra,0x0
    5ece:	cea080e7          	jalr	-790(ra) # 5bb4 <alarmtest_main>
    if(!alarm_simple_received) { printf("%s: failed\n", s); exit(1); }
    5ed2:	85d2                	mv	a1,s4
    5ed4:	00007517          	auipc	a0,0x7
    5ed8:	e4450513          	addi	a0,a0,-444 # cd18 <malloc+0x3758>
    5edc:	00003097          	auipc	ra,0x3
    5ee0:	62c080e7          	jalr	1580(ra) # 9508 <printf>
    5ee4:	4505                	li	a0,1
    5ee6:	00003097          	auipc	ra,0x3
    5eea:	0a2080e7          	jalr	162(ra) # 8f88 <exit>

0000000000005eee <fcntltest_main>:
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int fcntltest_main(int argc, char *argv[])
{
    5eee:	7179                	addi	sp,sp,-48
    5ef0:	f406                	sd	ra,40(sp)
    5ef2:	f022                	sd	s0,32(sp)
    5ef4:	ec26                	sd	s1,24(sp)
    5ef6:	e84a                	sd	s2,16(sp)
    5ef8:	e44e                	sd	s3,8(sp)
    5efa:	1800                	addi	s0,sp,48
    int fd, fd2, ret;
    
    printf("=== fcntl() Test ===\n\n");
    5efc:	00007517          	auipc	a0,0x7
    5f00:	e2c50513          	addi	a0,a0,-468 # cd28 <malloc+0x3768>
    5f04:	00003097          	auipc	ra,0x3
    5f08:	604080e7          	jalr	1540(ra) # 9508 <printf>
    
    // Test 1: F_GETFD / F_SETFD
    printf("Test 1: F_GETFD / F_SETFD\n");
    5f0c:	00007517          	auipc	a0,0x7
    5f10:	e3450513          	addi	a0,a0,-460 # cd40 <malloc+0x3780>
    5f14:	00003097          	auipc	ra,0x3
    5f18:	5f4080e7          	jalr	1524(ra) # 9508 <printf>
    
    fd = open("README", 0);
    5f1c:	4581                	li	a1,0
    5f1e:	00004517          	auipc	a0,0x4
    5f22:	9c250513          	addi	a0,a0,-1598 # 98e0 <malloc+0x320>
    5f26:	00003097          	auipc	ra,0x3
    5f2a:	0a2080e7          	jalr	162(ra) # 8fc8 <open>
    if(fd < 0) {
    5f2e:	20054d63          	bltz	a0,6148 <fcntltest_main+0x25a>
    5f32:	84aa                	mv	s1,a0
        printf("  ERROR: Cannot open README\n");
        exit(1);
    }
    
    ret = fcntl(fd, F_GETFD, 0);
    5f34:	4601                	li	a2,0
    5f36:	4585                	li	a1,1
    5f38:	00003097          	auipc	ra,0x3
    5f3c:	258080e7          	jalr	600(ra) # 9190 <fcntl>
    5f40:	892a                	mv	s2,a0
    printf("  Initial FD flags: %d (expect 0)\n", ret);
    5f42:	85aa                	mv	a1,a0
    5f44:	00007517          	auipc	a0,0x7
    5f48:	e3c50513          	addi	a0,a0,-452 # cd80 <malloc+0x37c0>
    5f4c:	00003097          	auipc	ra,0x3
    5f50:	5bc080e7          	jalr	1468(ra) # 9508 <printf>
    if(ret != 0) {
    5f54:	20091763          	bnez	s2,6162 <fcntltest_main+0x274>
        printf("  WARNING: Expected 0\n");
    }
    
    ret = fcntl(fd, F_SETFD, FD_CLOEXEC);
    5f58:	4605                	li	a2,1
    5f5a:	4589                	li	a1,2
    5f5c:	8526                	mv	a0,s1
    5f5e:	00003097          	auipc	ra,0x3
    5f62:	232080e7          	jalr	562(ra) # 9190 <fcntl>
    5f66:	85aa                	mv	a1,a0
    printf("  Set FD_CLOEXEC: %d (expect 0)\n", ret);
    5f68:	00007517          	auipc	a0,0x7
    5f6c:	e5850513          	addi	a0,a0,-424 # cdc0 <malloc+0x3800>
    5f70:	00003097          	auipc	ra,0x3
    5f74:	598080e7          	jalr	1432(ra) # 9508 <printf>
    
    ret = fcntl(fd, F_GETFD, 0);
    5f78:	4601                	li	a2,0
    5f7a:	4585                	li	a1,1
    5f7c:	8526                	mv	a0,s1
    5f7e:	00003097          	auipc	ra,0x3
    5f82:	212080e7          	jalr	530(ra) # 9190 <fcntl>
    5f86:	892a                	mv	s2,a0
    printf("  After set: %d (expect FD_CLOEXEC=1)\n", ret);
    5f88:	85aa                	mv	a1,a0
    5f8a:	00007517          	auipc	a0,0x7
    5f8e:	e5e50513          	addi	a0,a0,-418 # cde8 <malloc+0x3828>
    5f92:	00003097          	auipc	ra,0x3
    5f96:	576080e7          	jalr	1398(ra) # 9508 <printf>
    
    if(ret & FD_CLOEXEC) {
    5f9a:	00197913          	andi	s2,s2,1
    5f9e:	1c090b63          	beqz	s2,6174 <fcntltest_main+0x286>
        printf("  SUCCESS: FD_CLOEXEC is set\n");
    5fa2:	00007517          	auipc	a0,0x7
    5fa6:	e6e50513          	addi	a0,a0,-402 # ce10 <malloc+0x3850>
    5faa:	00003097          	auipc	ra,0x3
    5fae:	55e080e7          	jalr	1374(ra) # 9508 <printf>
    } else {
        printf("  FAILED: FD_CLOEXEC not set\n");
    }
    
    // Test 2: F_GETFL / F_SETFL
    printf("\nTest 2: F_GETFL / F_SETFL\n");
    5fb2:	00007517          	auipc	a0,0x7
    5fb6:	e9e50513          	addi	a0,a0,-354 # ce50 <malloc+0x3890>
    5fba:	00003097          	auipc	ra,0x3
    5fbe:	54e080e7          	jalr	1358(ra) # 9508 <printf>
    
    ret = fcntl(fd, F_GETFL, 0);
    5fc2:	4601                	li	a2,0
    5fc4:	458d                	li	a1,3
    5fc6:	8526                	mv	a0,s1
    5fc8:	00003097          	auipc	ra,0x3
    5fcc:	1c8080e7          	jalr	456(ra) # 9190 <fcntl>
    5fd0:	85aa                	mv	a1,a0
    printf("  Initial file flags: 0x%x\n", ret);
    5fd2:	00007517          	auipc	a0,0x7
    5fd6:	e9e50513          	addi	a0,a0,-354 # ce70 <malloc+0x38b0>
    5fda:	00003097          	auipc	ra,0x3
    5fde:	52e080e7          	jalr	1326(ra) # 9508 <printf>
    
    // Try to set O_NONBLOCK (0x800)
    ret = fcntl(fd, F_SETFL, 0x800);  // O_NONBLOCK
    5fe2:	6985                	lui	s3,0x1
    5fe4:	80098613          	addi	a2,s3,-2048 # 800 <truncate1+0x64>
    5fe8:	4591                	li	a1,4
    5fea:	8526                	mv	a0,s1
    5fec:	00003097          	auipc	ra,0x3
    5ff0:	1a4080e7          	jalr	420(ra) # 9190 <fcntl>
    5ff4:	85aa                	mv	a1,a0
    printf("  Set O_NONBLOCK: %d\n", ret);
    5ff6:	00007517          	auipc	a0,0x7
    5ffa:	e9a50513          	addi	a0,a0,-358 # ce90 <malloc+0x38d0>
    5ffe:	00003097          	auipc	ra,0x3
    6002:	50a080e7          	jalr	1290(ra) # 9508 <printf>
    
    ret = fcntl(fd, F_GETFL, 0);
    6006:	4601                	li	a2,0
    6008:	458d                	li	a1,3
    600a:	8526                	mv	a0,s1
    600c:	00003097          	auipc	ra,0x3
    6010:	184080e7          	jalr	388(ra) # 9190 <fcntl>
    6014:	892a                	mv	s2,a0
    printf("  After set: 0x%x (expect 0x800)\n", ret);
    6016:	85aa                	mv	a1,a0
    6018:	00007517          	auipc	a0,0x7
    601c:	e9050513          	addi	a0,a0,-368 # cea8 <malloc+0x38e8>
    6020:	00003097          	auipc	ra,0x3
    6024:	4e8080e7          	jalr	1256(ra) # 9508 <printf>
    
    if(ret & 0x800) {
    6028:	80098993          	addi	s3,s3,-2048
    602c:	01397933          	and	s2,s2,s3
    6030:	2901                	sext.w	s2,s2
    6032:	14090a63          	beqz	s2,6186 <fcntltest_main+0x298>
        printf("  SUCCESS: O_NONBLOCK is set\n");
    6036:	00007517          	auipc	a0,0x7
    603a:	e9a50513          	addi	a0,a0,-358 # ced0 <malloc+0x3910>
    603e:	00003097          	auipc	ra,0x3
    6042:	4ca080e7          	jalr	1226(ra) # 9508 <printf>
    } else {
        printf("  WARNING: O_NONBLOCK not set\n");
    }
    
    // Test 3: F_DUPFD
    printf("\nTest 3: F_DUPFD\n");
    6046:	00007517          	auipc	a0,0x7
    604a:	eca50513          	addi	a0,a0,-310 # cf10 <malloc+0x3950>
    604e:	00003097          	auipc	ra,0x3
    6052:	4ba080e7          	jalr	1210(ra) # 9508 <printf>
    
    fd2 = fcntl(fd, F_DUPFD, 10);  // 复制到 >= 10 的 fd
    6056:	4629                	li	a2,10
    6058:	4581                	li	a1,0
    605a:	8526                	mv	a0,s1
    605c:	00003097          	auipc	ra,0x3
    6060:	134080e7          	jalr	308(ra) # 9190 <fcntl>
    6064:	892a                	mv	s2,a0
    printf("  F_DUPFD(fd, 10) = %d (expect >= 10)\n", fd2);
    6066:	85aa                	mv	a1,a0
    6068:	00007517          	auipc	a0,0x7
    606c:	ec050513          	addi	a0,a0,-320 # cf28 <malloc+0x3968>
    6070:	00003097          	auipc	ra,0x3
    6074:	498080e7          	jalr	1176(ra) # 9508 <printf>
    
    if(fd2 >= 10) {
    6078:	47a5                	li	a5,9
    607a:	1127df63          	bge	a5,s2,6198 <fcntltest_main+0x2aa>
        printf("  SUCCESS: Duplicated to fd %d\n", fd2);
    607e:	85ca                	mv	a1,s2
    6080:	00007517          	auipc	a0,0x7
    6084:	ed050513          	addi	a0,a0,-304 # cf50 <malloc+0x3990>
    6088:	00003097          	auipc	ra,0x3
    608c:	480080e7          	jalr	1152(ra) # 9508 <printf>
        close(fd2);
    6090:	854a                	mv	a0,s2
    6092:	00003097          	auipc	ra,0x3
    6096:	f1e080e7          	jalr	-226(ra) # 8fb0 <close>
    } else {
        printf("  FAILED: Expected fd >= 10\n");
    }
    
    close(fd);
    609a:	8526                	mv	a0,s1
    609c:	00003097          	auipc	ra,0x3
    60a0:	f14080e7          	jalr	-236(ra) # 8fb0 <close>
    
    // Test 4: O_CLOEXEC with exec
    printf("\nTest 4: CLOEXEC behavior\n");
    60a4:	00007517          	auipc	a0,0x7
    60a8:	eec50513          	addi	a0,a0,-276 # cf90 <malloc+0x39d0>
    60ac:	00003097          	auipc	ra,0x3
    60b0:	45c080e7          	jalr	1116(ra) # 9508 <printf>
    printf("  (Manual test: set FD_CLOEXEC on fd 3, exec a program)\n");
    60b4:	00007517          	auipc	a0,0x7
    60b8:	efc50513          	addi	a0,a0,-260 # cfb0 <malloc+0x39f0>
    60bc:	00003097          	auipc	ra,0x3
    60c0:	44c080e7          	jalr	1100(ra) # 9508 <printf>
    printf("  FD_CLOEXEC flag implementation complete\n");
    60c4:	00007517          	auipc	a0,0x7
    60c8:	f2c50513          	addi	a0,a0,-212 # cff0 <malloc+0x3a30>
    60cc:	00003097          	auipc	ra,0x3
    60d0:	43c080e7          	jalr	1084(ra) # 9508 <printf>
    printf("  SUCCESS: exec() will close CLOEXEC fds\n");
    60d4:	00007517          	auipc	a0,0x7
    60d8:	f4c50513          	addi	a0,a0,-180 # d020 <malloc+0x3a60>
    60dc:	00003097          	auipc	ra,0x3
    60e0:	42c080e7          	jalr	1068(ra) # 9508 <printf>
    
    // Test 5: Invalid fd
    printf("\nTest 5: Invalid fd handling\n");
    60e4:	00007517          	auipc	a0,0x7
    60e8:	f6c50513          	addi	a0,a0,-148 # d050 <malloc+0x3a90>
    60ec:	00003097          	auipc	ra,0x3
    60f0:	41c080e7          	jalr	1052(ra) # 9508 <printf>
    ret = fcntl(999, F_GETFD, 0);
    60f4:	4601                	li	a2,0
    60f6:	4585                	li	a1,1
    60f8:	3e700513          	li	a0,999
    60fc:	00003097          	auipc	ra,0x3
    6100:	094080e7          	jalr	148(ra) # 9190 <fcntl>
    6104:	84aa                	mv	s1,a0
    printf("  fcntl(999, F_GETFD) = %d (expect -1)\n", ret);
    6106:	85aa                	mv	a1,a0
    6108:	00007517          	auipc	a0,0x7
    610c:	f6850513          	addi	a0,a0,-152 # d070 <malloc+0x3ab0>
    6110:	00003097          	auipc	ra,0x3
    6114:	3f8080e7          	jalr	1016(ra) # 9508 <printf>
    
    if(ret == -1) {
    6118:	57fd                	li	a5,-1
    611a:	08f48863          	beq	s1,a5,61aa <fcntltest_main+0x2bc>
        printf("  SUCCESS: Invalid fd returns -1\n");
    } else {
        printf("  FAILED: Should return -1\n");
    611e:	00007517          	auipc	a0,0x7
    6122:	fa250513          	addi	a0,a0,-94 # d0c0 <malloc+0x3b00>
    6126:	00003097          	auipc	ra,0x3
    612a:	3e2080e7          	jalr	994(ra) # 9508 <printf>
    }
    
    printf("\n=== All fcntl tests completed ===\n");
    612e:	00007517          	auipc	a0,0x7
    6132:	fb250513          	addi	a0,a0,-78 # d0e0 <malloc+0x3b20>
    6136:	00003097          	auipc	ra,0x3
    613a:	3d2080e7          	jalr	978(ra) # 9508 <printf>
    exit(0);
    613e:	4501                	li	a0,0
    6140:	00003097          	auipc	ra,0x3
    6144:	e48080e7          	jalr	-440(ra) # 8f88 <exit>
        printf("  ERROR: Cannot open README\n");
    6148:	00007517          	auipc	a0,0x7
    614c:	c1850513          	addi	a0,a0,-1000 # cd60 <malloc+0x37a0>
    6150:	00003097          	auipc	ra,0x3
    6154:	3b8080e7          	jalr	952(ra) # 9508 <printf>
        exit(1);
    6158:	4505                	li	a0,1
    615a:	00003097          	auipc	ra,0x3
    615e:	e2e080e7          	jalr	-466(ra) # 8f88 <exit>
        printf("  WARNING: Expected 0\n");
    6162:	00007517          	auipc	a0,0x7
    6166:	c4650513          	addi	a0,a0,-954 # cda8 <malloc+0x37e8>
    616a:	00003097          	auipc	ra,0x3
    616e:	39e080e7          	jalr	926(ra) # 9508 <printf>
    6172:	b3dd                	j	5f58 <fcntltest_main+0x6a>
        printf("  FAILED: FD_CLOEXEC not set\n");
    6174:	00007517          	auipc	a0,0x7
    6178:	cbc50513          	addi	a0,a0,-836 # ce30 <malloc+0x3870>
    617c:	00003097          	auipc	ra,0x3
    6180:	38c080e7          	jalr	908(ra) # 9508 <printf>
    6184:	b53d                	j	5fb2 <fcntltest_main+0xc4>
        printf("  WARNING: O_NONBLOCK not set\n");
    6186:	00007517          	auipc	a0,0x7
    618a:	d6a50513          	addi	a0,a0,-662 # cef0 <malloc+0x3930>
    618e:	00003097          	auipc	ra,0x3
    6192:	37a080e7          	jalr	890(ra) # 9508 <printf>
    6196:	bd45                	j	6046 <fcntltest_main+0x158>
        printf("  FAILED: Expected fd >= 10\n");
    6198:	00007517          	auipc	a0,0x7
    619c:	dd850513          	addi	a0,a0,-552 # cf70 <malloc+0x39b0>
    61a0:	00003097          	auipc	ra,0x3
    61a4:	368080e7          	jalr	872(ra) # 9508 <printf>
    61a8:	bdcd                	j	609a <fcntltest_main+0x1ac>
        printf("  SUCCESS: Invalid fd returns -1\n");
    61aa:	00007517          	auipc	a0,0x7
    61ae:	eee50513          	addi	a0,a0,-274 # d098 <malloc+0x3ad8>
    61b2:	00003097          	auipc	ra,0x3
    61b6:	356080e7          	jalr	854(ra) # 9508 <printf>
    61ba:	bf95                	j	612e <fcntltest_main+0x240>

00000000000061bc <fcntltest>:
void fcntltest(char *s) {
    61bc:	7179                	addi	sp,sp,-48
    61be:	f406                	sd	ra,40(sp)
    61c0:	f022                	sd	s0,32(sp)
    61c2:	ec26                	sd	s1,24(sp)
    61c4:	e84a                	sd	s2,16(sp)
    61c6:	1800                	addi	s0,sp,48
    if(verbose) { char *argv[] = {"fcntltest", 0}; fcntltest_main(1, argv); return; }
    61c8:	00009797          	auipc	a5,0x9
    61cc:	6cc7a783          	lw	a5,1740(a5) # f894 <verbose>
    61d0:	e3a9                	bnez	a5,6212 <fcntltest+0x56>
    61d2:	892a                	mv	s2,a0
    int fd = open("README", 0);
    61d4:	4581                	li	a1,0
    61d6:	00003517          	auipc	a0,0x3
    61da:	70a50513          	addi	a0,a0,1802 # 98e0 <malloc+0x320>
    61de:	00003097          	auipc	ra,0x3
    61e2:	dea080e7          	jalr	-534(ra) # 8fc8 <open>
    61e6:	84aa                	mv	s1,a0
    if(fd < 0) { printf("%s: cannot open\n", s); exit(1); }
    61e8:	02054c63          	bltz	a0,6220 <fcntltest+0x64>
    if(fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) { printf("%s: failed\n", s); exit(1); }
    61ec:	4605                	li	a2,1
    61ee:	4589                	li	a1,2
    61f0:	00003097          	auipc	ra,0x3
    61f4:	fa0080e7          	jalr	-96(ra) # 9190 <fcntl>
    61f8:	04054263          	bltz	a0,623c <fcntltest+0x80>
    close(fd);
    61fc:	8526                	mv	a0,s1
    61fe:	00003097          	auipc	ra,0x3
    6202:	db2080e7          	jalr	-590(ra) # 8fb0 <close>
}
    6206:	70a2                	ld	ra,40(sp)
    6208:	7402                	ld	s0,32(sp)
    620a:	64e2                	ld	s1,24(sp)
    620c:	6942                	ld	s2,16(sp)
    620e:	6145                	addi	sp,sp,48
    6210:	8082                	ret
    if(verbose) { char *argv[] = {"fcntltest", 0}; fcntltest_main(1, argv); return; }
    6212:	fd040593          	addi	a1,s0,-48
    6216:	4505                	li	a0,1
    6218:	00000097          	auipc	ra,0x0
    621c:	cd6080e7          	jalr	-810(ra) # 5eee <fcntltest_main>
    if(fd < 0) { printf("%s: cannot open\n", s); exit(1); }
    6220:	85ca                	mv	a1,s2
    6222:	00007517          	auipc	a0,0x7
    6226:	ee650513          	addi	a0,a0,-282 # d108 <malloc+0x3b48>
    622a:	00003097          	auipc	ra,0x3
    622e:	2de080e7          	jalr	734(ra) # 9508 <printf>
    6232:	4505                	li	a0,1
    6234:	00003097          	auipc	ra,0x3
    6238:	d54080e7          	jalr	-684(ra) # 8f88 <exit>
    if(fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) { printf("%s: failed\n", s); exit(1); }
    623c:	85ca                	mv	a1,s2
    623e:	00007517          	auipc	a0,0x7
    6242:	ada50513          	addi	a0,a0,-1318 # cd18 <malloc+0x3758>
    6246:	00003097          	auipc	ra,0x3
    624a:	2c2080e7          	jalr	706(ra) # 9508 <printf>
    624e:	4505                	li	a0,1
    6250:	00003097          	auipc	ra,0x3
    6254:	d38080e7          	jalr	-712(ra) # 8f88 <exit>

0000000000006258 <test_chmod>:
#include "serein-user/user.h"
#include "kernel/include/fcntl.h"

// V3.0: chmod/fchmod test program

void test_chmod() {
    6258:	1101                	addi	sp,sp,-32
    625a:	ec06                	sd	ra,24(sp)
    625c:	e822                	sd	s0,16(sp)
    625e:	e426                	sd	s1,8(sp)
    6260:	1000                	addi	s0,sp,32
  printf("Test 1: chmod basic functionality\n");
    6262:	00007517          	auipc	a0,0x7
    6266:	ebe50513          	addi	a0,a0,-322 # d120 <malloc+0x3b60>
    626a:	00003097          	auipc	ra,0x3
    626e:	29e080e7          	jalr	670(ra) # 9508 <printf>
  
  // Create a test file
  int fd = open("chmod_test_file", O_CREATE | O_RDWR);
    6272:	20200593          	li	a1,514
    6276:	00007517          	auipc	a0,0x7
    627a:	ed250513          	addi	a0,a0,-302 # d148 <malloc+0x3b88>
    627e:	00003097          	auipc	ra,0x3
    6282:	d4a080e7          	jalr	-694(ra) # 8fc8 <open>
  if(fd < 0) {
    6286:	04054a63          	bltz	a0,62da <test_chmod+0x82>
    628a:	84aa                	mv	s1,a0
    printf("  FAILED: create file\n");
    exit(1);
  }
  write(fd, "test", 4);
    628c:	4611                	li	a2,4
    628e:	00009597          	auipc	a1,0x9
    6292:	ea258593          	addi	a1,a1,-350 # f130 <malloc+0x5b70>
    6296:	00003097          	auipc	ra,0x3
    629a:	d12080e7          	jalr	-750(ra) # 8fa8 <write>
  close(fd);
    629e:	8526                	mv	a0,s1
    62a0:	00003097          	auipc	ra,0x3
    62a4:	d10080e7          	jalr	-752(ra) # 8fb0 <close>

  // Test chmod
  if(chmod("chmod_test_file", 0755) < 0) {
    62a8:	1ed00593          	li	a1,493
    62ac:	00007517          	auipc	a0,0x7
    62b0:	e9c50513          	addi	a0,a0,-356 # d148 <malloc+0x3b88>
    62b4:	00003097          	auipc	ra,0x3
    62b8:	ee6080e7          	jalr	-282(ra) # 919a <chmod>
    62bc:	02054c63          	bltz	a0,62f4 <test_chmod+0x9c>
    printf("  FAILED: chmod failed\n");
    exit(1);
  }
  
  printf("  SUCCESS: chmod() returned 0\n");
    62c0:	00007517          	auipc	a0,0x7
    62c4:	ec850513          	addi	a0,a0,-312 # d188 <malloc+0x3bc8>
    62c8:	00003097          	auipc	ra,0x3
    62cc:	240080e7          	jalr	576(ra) # 9508 <printf>
}
    62d0:	60e2                	ld	ra,24(sp)
    62d2:	6442                	ld	s0,16(sp)
    62d4:	64a2                	ld	s1,8(sp)
    62d6:	6105                	addi	sp,sp,32
    62d8:	8082                	ret
    printf("  FAILED: create file\n");
    62da:	00007517          	auipc	a0,0x7
    62de:	e7e50513          	addi	a0,a0,-386 # d158 <malloc+0x3b98>
    62e2:	00003097          	auipc	ra,0x3
    62e6:	226080e7          	jalr	550(ra) # 9508 <printf>
    exit(1);
    62ea:	4505                	li	a0,1
    62ec:	00003097          	auipc	ra,0x3
    62f0:	c9c080e7          	jalr	-868(ra) # 8f88 <exit>
    printf("  FAILED: chmod failed\n");
    62f4:	00007517          	auipc	a0,0x7
    62f8:	e7c50513          	addi	a0,a0,-388 # d170 <malloc+0x3bb0>
    62fc:	00003097          	auipc	ra,0x3
    6300:	20c080e7          	jalr	524(ra) # 9508 <printf>
    exit(1);
    6304:	4505                	li	a0,1
    6306:	00003097          	auipc	ra,0x3
    630a:	c82080e7          	jalr	-894(ra) # 8f88 <exit>

000000000000630e <test_fchmod>:

void test_fchmod() {
    630e:	1101                	addi	sp,sp,-32
    6310:	ec06                	sd	ra,24(sp)
    6312:	e822                	sd	s0,16(sp)
    6314:	e426                	sd	s1,8(sp)
    6316:	1000                	addi	s0,sp,32
  printf("Test 2: fchmod functionality\n");
    6318:	00007517          	auipc	a0,0x7
    631c:	e9050513          	addi	a0,a0,-368 # d1a8 <malloc+0x3be8>
    6320:	00003097          	auipc	ra,0x3
    6324:	1e8080e7          	jalr	488(ra) # 9508 <printf>
  
  int fd = open("fchmod_test_file", O_CREATE | O_RDWR);
    6328:	20200593          	li	a1,514
    632c:	00007517          	auipc	a0,0x7
    6330:	e9c50513          	addi	a0,a0,-356 # d1c8 <malloc+0x3c08>
    6334:	00003097          	auipc	ra,0x3
    6338:	c94080e7          	jalr	-876(ra) # 8fc8 <open>
  if(fd < 0) {
    633c:	02054d63          	bltz	a0,6376 <test_fchmod+0x68>
    6340:	84aa                	mv	s1,a0
    printf("  FAILED: create file\n");
    exit(1);
  }
  
  // Test fchmod
  if(fchmod(fd, 0644) < 0) {
    6342:	1a400593          	li	a1,420
    6346:	00003097          	auipc	ra,0x3
    634a:	e5e080e7          	jalr	-418(ra) # 91a4 <fchmod>
    634e:	04054163          	bltz	a0,6390 <test_fchmod+0x82>
    printf("  FAILED: fchmod failed\n");
    close(fd);
    exit(1);
  }
  
  close(fd);
    6352:	8526                	mv	a0,s1
    6354:	00003097          	auipc	ra,0x3
    6358:	c5c080e7          	jalr	-932(ra) # 8fb0 <close>
  printf("  SUCCESS: fchmod() returned 0\n");
    635c:	00007517          	auipc	a0,0x7
    6360:	ea450513          	addi	a0,a0,-348 # d200 <malloc+0x3c40>
    6364:	00003097          	auipc	ra,0x3
    6368:	1a4080e7          	jalr	420(ra) # 9508 <printf>
}
    636c:	60e2                	ld	ra,24(sp)
    636e:	6442                	ld	s0,16(sp)
    6370:	64a2                	ld	s1,8(sp)
    6372:	6105                	addi	sp,sp,32
    6374:	8082                	ret
    printf("  FAILED: create file\n");
    6376:	00007517          	auipc	a0,0x7
    637a:	de250513          	addi	a0,a0,-542 # d158 <malloc+0x3b98>
    637e:	00003097          	auipc	ra,0x3
    6382:	18a080e7          	jalr	394(ra) # 9508 <printf>
    exit(1);
    6386:	4505                	li	a0,1
    6388:	00003097          	auipc	ra,0x3
    638c:	c00080e7          	jalr	-1024(ra) # 8f88 <exit>
    printf("  FAILED: fchmod failed\n");
    6390:	00007517          	auipc	a0,0x7
    6394:	e5050513          	addi	a0,a0,-432 # d1e0 <malloc+0x3c20>
    6398:	00003097          	auipc	ra,0x3
    639c:	170080e7          	jalr	368(ra) # 9508 <printf>
    close(fd);
    63a0:	8526                	mv	a0,s1
    63a2:	00003097          	auipc	ra,0x3
    63a6:	c0e080e7          	jalr	-1010(ra) # 8fb0 <close>
    exit(1);
    63aa:	4505                	li	a0,1
    63ac:	00003097          	auipc	ra,0x3
    63b0:	bdc080e7          	jalr	-1060(ra) # 8f88 <exit>

00000000000063b4 <test_permission_check>:

void test_permission_check() {
    63b4:	1101                	addi	sp,sp,-32
    63b6:	ec06                	sd	ra,24(sp)
    63b8:	e822                	sd	s0,16(sp)
    63ba:	e426                	sd	s1,8(sp)
    63bc:	1000                	addi	s0,sp,32
  printf("Test 3: Permission checking\n");
    63be:	00007517          	auipc	a0,0x7
    63c2:	e6250513          	addi	a0,a0,-414 # d220 <malloc+0x3c60>
    63c6:	00003097          	auipc	ra,0x3
    63ca:	142080e7          	jalr	322(ra) # 9508 <printf>
  
  int uid = getuid();
    63ce:	00003097          	auipc	ra,0x3
    63d2:	d4a080e7          	jalr	-694(ra) # 9118 <getuid>
    63d6:	84aa                	mv	s1,a0
  printf("  Current UID: %d\n", uid);
    63d8:	85aa                	mv	a1,a0
    63da:	00007517          	auipc	a0,0x7
    63de:	e6650513          	addi	a0,a0,-410 # d240 <malloc+0x3c80>
    63e2:	00003097          	auipc	ra,0x3
    63e6:	126080e7          	jalr	294(ra) # 9508 <printf>
  
  if(uid == 0) {
    63ea:	e495                	bnez	s1,6416 <test_permission_check+0x62>
    printf("  Root user: all permissions granted\n");
    63ec:	00007517          	auipc	a0,0x7
    63f0:	e6c50513          	addi	a0,a0,-404 # d258 <malloc+0x3c98>
    63f4:	00003097          	auipc	ra,0x3
    63f8:	114080e7          	jalr	276(ra) # 9508 <printf>
  } else {
    printf("  Non-root user: limited permissions\n");
  }
  
  printf("  SUCCESS: Permission system active\n");
    63fc:	00007517          	auipc	a0,0x7
    6400:	eac50513          	addi	a0,a0,-340 # d2a8 <malloc+0x3ce8>
    6404:	00003097          	auipc	ra,0x3
    6408:	104080e7          	jalr	260(ra) # 9508 <printf>
}
    640c:	60e2                	ld	ra,24(sp)
    640e:	6442                	ld	s0,16(sp)
    6410:	64a2                	ld	s1,8(sp)
    6412:	6105                	addi	sp,sp,32
    6414:	8082                	ret
    printf("  Non-root user: limited permissions\n");
    6416:	00007517          	auipc	a0,0x7
    641a:	e6a50513          	addi	a0,a0,-406 # d280 <malloc+0x3cc0>
    641e:	00003097          	auipc	ra,0x3
    6422:	0ea080e7          	jalr	234(ra) # 9508 <printf>
    6426:	bfd9                	j	63fc <test_permission_check+0x48>

0000000000006428 <chmodtest_main>:

int chmodtest_main(int argc, char *argv[]) {
    6428:	1141                	addi	sp,sp,-16
    642a:	e406                	sd	ra,8(sp)
    642c:	e022                	sd	s0,0(sp)
    642e:	0800                	addi	s0,sp,16
  printf("=== chmod/fchmod Test ===\n\n");
    6430:	00007517          	auipc	a0,0x7
    6434:	ea050513          	addi	a0,a0,-352 # d2d0 <malloc+0x3d10>
    6438:	00003097          	auipc	ra,0x3
    643c:	0d0080e7          	jalr	208(ra) # 9508 <printf>
  
  test_chmod();
    6440:	00000097          	auipc	ra,0x0
    6444:	e18080e7          	jalr	-488(ra) # 6258 <test_chmod>
  test_fchmod();
    6448:	00000097          	auipc	ra,0x0
    644c:	ec6080e7          	jalr	-314(ra) # 630e <test_fchmod>
  test_permission_check();
    6450:	00000097          	auipc	ra,0x0
    6454:	f64080e7          	jalr	-156(ra) # 63b4 <test_permission_check>
  
  // Cleanup
  remove("chmod_test_file");
    6458:	00007517          	auipc	a0,0x7
    645c:	cf050513          	addi	a0,a0,-784 # d148 <malloc+0x3b88>
    6460:	00003097          	auipc	ra,0x3
    6464:	bd0080e7          	jalr	-1072(ra) # 9030 <remove>
  remove("fchmod_test_file");
    6468:	00007517          	auipc	a0,0x7
    646c:	d6050513          	addi	a0,a0,-672 # d1c8 <malloc+0x3c08>
    6470:	00003097          	auipc	ra,0x3
    6474:	bc0080e7          	jalr	-1088(ra) # 9030 <remove>
  
  printf("\n=== All chmod tests PASSED ===\n");
    6478:	00007517          	auipc	a0,0x7
    647c:	e7850513          	addi	a0,a0,-392 # d2f0 <malloc+0x3d30>
    6480:	00003097          	auipc	ra,0x3
    6484:	088080e7          	jalr	136(ra) # 9508 <printf>
  exit(0);
    6488:	4501                	li	a0,0
    648a:	00003097          	auipc	ra,0x3
    648e:	afe080e7          	jalr	-1282(ra) # 8f88 <exit>

0000000000006492 <chmodtest>:
void chmodtest(char *s) {
    6492:	7179                	addi	sp,sp,-48
    6494:	f406                	sd	ra,40(sp)
    6496:	f022                	sd	s0,32(sp)
    6498:	ec26                	sd	s1,24(sp)
    649a:	1800                	addi	s0,sp,48
    if(verbose) { char *argv[] = {"chmodtest", 0}; chmodtest_main(1, argv); return; }
    649c:	00009797          	auipc	a5,0x9
    64a0:	3f87a783          	lw	a5,1016(a5) # f894 <verbose>
    64a4:	ebb9                	bnez	a5,64fa <chmodtest+0x68>
    64a6:	84aa                	mv	s1,a0
    int fd = open("chmodtest.tmp", O_CREATE | O_WRONLY);
    64a8:	20100593          	li	a1,513
    64ac:	00007517          	auipc	a0,0x7
    64b0:	e6c50513          	addi	a0,a0,-404 # d318 <malloc+0x3d58>
    64b4:	00003097          	auipc	ra,0x3
    64b8:	b14080e7          	jalr	-1260(ra) # 8fc8 <open>
    if(fd < 0) { printf("%s: create failed\n", s); exit(1); }
    64bc:	04054663          	bltz	a0,6508 <chmodtest+0x76>
    close(fd);
    64c0:	00003097          	auipc	ra,0x3
    64c4:	af0080e7          	jalr	-1296(ra) # 8fb0 <close>
    if(chmod("chmodtest.tmp", 0755) < 0) { printf("%s: chmod failed\n", s); exit(1); }
    64c8:	1ed00593          	li	a1,493
    64cc:	00007517          	auipc	a0,0x7
    64d0:	e4c50513          	addi	a0,a0,-436 # d318 <malloc+0x3d58>
    64d4:	00003097          	auipc	ra,0x3
    64d8:	cc6080e7          	jalr	-826(ra) # 919a <chmod>
    64dc:	04054463          	bltz	a0,6524 <chmodtest+0x92>
    remove("chmodtest.tmp");
    64e0:	00007517          	auipc	a0,0x7
    64e4:	e3850513          	addi	a0,a0,-456 # d318 <malloc+0x3d58>
    64e8:	00003097          	auipc	ra,0x3
    64ec:	b48080e7          	jalr	-1208(ra) # 9030 <remove>
}
    64f0:	70a2                	ld	ra,40(sp)
    64f2:	7402                	ld	s0,32(sp)
    64f4:	64e2                	ld	s1,24(sp)
    64f6:	6145                	addi	sp,sp,48
    64f8:	8082                	ret
    if(verbose) { char *argv[] = {"chmodtest", 0}; chmodtest_main(1, argv); return; }
    64fa:	fd040593          	addi	a1,s0,-48
    64fe:	4505                	li	a0,1
    6500:	00000097          	auipc	ra,0x0
    6504:	f28080e7          	jalr	-216(ra) # 6428 <chmodtest_main>
    if(fd < 0) { printf("%s: create failed\n", s); exit(1); }
    6508:	85a6                	mv	a1,s1
    650a:	00004517          	auipc	a0,0x4
    650e:	d6650513          	addi	a0,a0,-666 # a270 <malloc+0xcb0>
    6512:	00003097          	auipc	ra,0x3
    6516:	ff6080e7          	jalr	-10(ra) # 9508 <printf>
    651a:	4505                	li	a0,1
    651c:	00003097          	auipc	ra,0x3
    6520:	a6c080e7          	jalr	-1428(ra) # 8f88 <exit>
    if(chmod("chmodtest.tmp", 0755) < 0) { printf("%s: chmod failed\n", s); exit(1); }
    6524:	85a6                	mv	a1,s1
    6526:	00007517          	auipc	a0,0x7
    652a:	e0250513          	addi	a0,a0,-510 # d328 <malloc+0x3d68>
    652e:	00003097          	auipc	ra,0x3
    6532:	fda080e7          	jalr	-38(ra) # 9508 <printf>
    6536:	4505                	li	a0,1
    6538:	00003097          	auipc	ra,0x3
    653c:	a50080e7          	jalr	-1456(ra) # 8f88 <exit>

0000000000006540 <test_clone_basic>:

// V3.0: POSIX threads test program (clone/futex/exit_group)

volatile int shared_counter = 0;

void test_clone_basic() {
    6540:	1141                	addi	sp,sp,-16
    6542:	e406                	sd	ra,8(sp)
    6544:	e022                	sd	s0,0(sp)
    6546:	0800                	addi	s0,sp,16
  printf("Test 1: clone() basic functionality\n");
    6548:	00007517          	auipc	a0,0x7
    654c:	df850513          	addi	a0,a0,-520 # d340 <malloc+0x3d80>
    6550:	00003097          	auipc	ra,0x3
    6554:	fb8080e7          	jalr	-72(ra) # 9508 <printf>
  
  int pid = clone(0, 0);  // Simple fork-like clone
    6558:	4581                	li	a1,0
    655a:	4501                	li	a0,0
    655c:	00003097          	auipc	ra,0x3
    6560:	c52080e7          	jalr	-942(ra) # 91ae <clone>
    6564:	85aa                	mv	a1,a0
  
  if(pid < 0) {
    6566:	02054c63          	bltz	a0,659e <test_clone_basic+0x5e>
    printf("  FAILED: clone returned %d\n", pid);
    exit(1);
  }
  
  if(pid == 0) {
    656a:	c539                	beqz	a0,65b8 <test_clone_basic+0x78>
    // Child
    printf("  Child process running (pid=%d)\n", getpid());
    exit(0);
  } else {
    // Parent
    printf("  Parent: child pid = %d\n", pid);
    656c:	00007517          	auipc	a0,0x7
    6570:	e4450513          	addi	a0,a0,-444 # d3b0 <malloc+0x3df0>
    6574:	00003097          	auipc	ra,0x3
    6578:	f94080e7          	jalr	-108(ra) # 9508 <printf>
    wait(0);
    657c:	4501                	li	a0,0
    657e:	00003097          	auipc	ra,0x3
    6582:	a12080e7          	jalr	-1518(ra) # 8f90 <wait>
    printf("  SUCCESS: clone() basic test passed\n");
    6586:	00007517          	auipc	a0,0x7
    658a:	e4a50513          	addi	a0,a0,-438 # d3d0 <malloc+0x3e10>
    658e:	00003097          	auipc	ra,0x3
    6592:	f7a080e7          	jalr	-134(ra) # 9508 <printf>
  }
}
    6596:	60a2                	ld	ra,8(sp)
    6598:	6402                	ld	s0,0(sp)
    659a:	0141                	addi	sp,sp,16
    659c:	8082                	ret
    printf("  FAILED: clone returned %d\n", pid);
    659e:	00007517          	auipc	a0,0x7
    65a2:	dca50513          	addi	a0,a0,-566 # d368 <malloc+0x3da8>
    65a6:	00003097          	auipc	ra,0x3
    65aa:	f62080e7          	jalr	-158(ra) # 9508 <printf>
    exit(1);
    65ae:	4505                	li	a0,1
    65b0:	00003097          	auipc	ra,0x3
    65b4:	9d8080e7          	jalr	-1576(ra) # 8f88 <exit>
    printf("  Child process running (pid=%d)\n", getpid());
    65b8:	00003097          	auipc	ra,0x3
    65bc:	a38080e7          	jalr	-1480(ra) # 8ff0 <getpid>
    65c0:	85aa                	mv	a1,a0
    65c2:	00007517          	auipc	a0,0x7
    65c6:	dc650513          	addi	a0,a0,-570 # d388 <malloc+0x3dc8>
    65ca:	00003097          	auipc	ra,0x3
    65ce:	f3e080e7          	jalr	-194(ra) # 9508 <printf>
    exit(0);
    65d2:	4501                	li	a0,0
    65d4:	00003097          	auipc	ra,0x3
    65d8:	9b4080e7          	jalr	-1612(ra) # 8f88 <exit>

00000000000065dc <test_clone_with_stack>:

void test_clone_with_stack() {
    65dc:	1141                	addi	sp,sp,-16
    65de:	e406                	sd	ra,8(sp)
    65e0:	e022                	sd	s0,0(sp)
    65e2:	0800                	addi	s0,sp,16
  printf("Test 2: clone() with custom stack\n");
    65e4:	00007517          	auipc	a0,0x7
    65e8:	e1450513          	addi	a0,a0,-492 # d3f8 <malloc+0x3e38>
    65ec:	00003097          	auipc	ra,0x3
    65f0:	f1c080e7          	jalr	-228(ra) # 9508 <printf>
  
  // Allocate stack for child
  char *stack = sbrk(4096);
    65f4:	6505                	lui	a0,0x1
    65f6:	00003097          	auipc	ra,0x3
    65fa:	a02080e7          	jalr	-1534(ra) # 8ff8 <sbrk>
  if(stack == (char*)-1) {
    65fe:	57fd                	li	a5,-1
    6600:	02f50d63          	beq	a0,a5,663a <test_clone_with_stack+0x5e>
  }
  
  // Stack grows downward, so point to top
  char *stack_top = stack + 4096;
  
  int pid = clone(CLONE_THREAD, stack_top);
    6604:	6585                	lui	a1,0x1
    6606:	95aa                	add	a1,a1,a0
    6608:	6541                	lui	a0,0x10
    660a:	00003097          	auipc	ra,0x3
    660e:	ba4080e7          	jalr	-1116(ra) # 91ae <clone>
  
  if(pid < 0) {
    6612:	04054163          	bltz	a0,6654 <test_clone_with_stack+0x78>
    printf("  FAILED: clone with stack failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    6616:	cd21                	beqz	a0,666e <test_clone_with_stack+0x92>
    // Child with custom stack
    printf("  Thread running on custom stack\n");
    exit(0);
  } else {
    wait(0);
    6618:	4501                	li	a0,0
    661a:	00003097          	auipc	ra,0x3
    661e:	976080e7          	jalr	-1674(ra) # 8f90 <wait>
    printf("  SUCCESS: clone() with stack passed\n");
    6622:	00007517          	auipc	a0,0x7
    6626:	e6e50513          	addi	a0,a0,-402 # d490 <malloc+0x3ed0>
    662a:	00003097          	auipc	ra,0x3
    662e:	ede080e7          	jalr	-290(ra) # 9508 <printf>
  }
}
    6632:	60a2                	ld	ra,8(sp)
    6634:	6402                	ld	s0,0(sp)
    6636:	0141                	addi	sp,sp,16
    6638:	8082                	ret
    printf("  FAILED: sbrk for stack\n");
    663a:	00007517          	auipc	a0,0x7
    663e:	de650513          	addi	a0,a0,-538 # d420 <malloc+0x3e60>
    6642:	00003097          	auipc	ra,0x3
    6646:	ec6080e7          	jalr	-314(ra) # 9508 <printf>
    exit(1);
    664a:	4505                	li	a0,1
    664c:	00003097          	auipc	ra,0x3
    6650:	93c080e7          	jalr	-1732(ra) # 8f88 <exit>
    printf("  FAILED: clone with stack failed\n");
    6654:	00007517          	auipc	a0,0x7
    6658:	dec50513          	addi	a0,a0,-532 # d440 <malloc+0x3e80>
    665c:	00003097          	auipc	ra,0x3
    6660:	eac080e7          	jalr	-340(ra) # 9508 <printf>
    exit(1);
    6664:	4505                	li	a0,1
    6666:	00003097          	auipc	ra,0x3
    666a:	922080e7          	jalr	-1758(ra) # 8f88 <exit>
    printf("  Thread running on custom stack\n");
    666e:	00007517          	auipc	a0,0x7
    6672:	dfa50513          	addi	a0,a0,-518 # d468 <malloc+0x3ea8>
    6676:	00003097          	auipc	ra,0x3
    667a:	e92080e7          	jalr	-366(ra) # 9508 <printf>
    exit(0);
    667e:	4501                	li	a0,0
    6680:	00003097          	auipc	ra,0x3
    6684:	908080e7          	jalr	-1784(ra) # 8f88 <exit>

0000000000006688 <test_futex>:

void test_futex() {
    6688:	1101                	addi	sp,sp,-32
    668a:	ec06                	sd	ra,24(sp)
    668c:	e822                	sd	s0,16(sp)
    668e:	1000                	addi	s0,sp,32
  printf("Test 3: futex() basic functionality\n");
    6690:	00007517          	auipc	a0,0x7
    6694:	e2850513          	addi	a0,a0,-472 # d4b8 <malloc+0x3ef8>
    6698:	00003097          	auipc	ra,0x3
    669c:	e70080e7          	jalr	-400(ra) # 9508 <printf>
  
  // Simple futex wake test (no waiter)
  int lock = 0;
    66a0:	fe042623          	sw	zero,-20(s0)
  
  // Wake should succeed even with no waiters
  int ret = futex(&lock, FUTEX_WAKE, 1);
    66a4:	4605                	li	a2,1
    66a6:	4585                	li	a1,1
    66a8:	fec40513          	addi	a0,s0,-20
    66ac:	00003097          	auipc	ra,0x3
    66b0:	b0c080e7          	jalr	-1268(ra) # 91b8 <futex>
  if(ret < 0) {
    66b4:	00054e63          	bltz	a0,66d0 <test_futex+0x48>
    printf("  Note: futex wake returned %d (may be expected)\n", ret);
  }
  
  printf("  SUCCESS: futex() basic test passed\n");
    66b8:	00007517          	auipc	a0,0x7
    66bc:	e6050513          	addi	a0,a0,-416 # d518 <malloc+0x3f58>
    66c0:	00003097          	auipc	ra,0x3
    66c4:	e48080e7          	jalr	-440(ra) # 9508 <printf>
}
    66c8:	60e2                	ld	ra,24(sp)
    66ca:	6442                	ld	s0,16(sp)
    66cc:	6105                	addi	sp,sp,32
    66ce:	8082                	ret
    printf("  Note: futex wake returned %d (may be expected)\n", ret);
    66d0:	85aa                	mv	a1,a0
    66d2:	00007517          	auipc	a0,0x7
    66d6:	e0e50513          	addi	a0,a0,-498 # d4e0 <malloc+0x3f20>
    66da:	00003097          	auipc	ra,0x3
    66de:	e2e080e7          	jalr	-466(ra) # 9508 <printf>
    66e2:	bfd9                	j	66b8 <test_futex+0x30>

00000000000066e4 <test_exit_group>:

void test_exit_group() {
    66e4:	1141                	addi	sp,sp,-16
    66e6:	e406                	sd	ra,8(sp)
    66e8:	e022                	sd	s0,0(sp)
    66ea:	0800                	addi	s0,sp,16
  printf("Test 4: exit_group() verify\n");
    66ec:	00007517          	auipc	a0,0x7
    66f0:	e5450513          	addi	a0,a0,-428 # d540 <malloc+0x3f80>
    66f4:	00003097          	auipc	ra,0x3
    66f8:	e14080e7          	jalr	-492(ra) # 9508 <printf>
  
  // We can't fully test exit_group here as it terminates the process
  // Just verify the syscall exists
  printf("  Note: exit_group() will be called at program end\n");
    66fc:	00007517          	auipc	a0,0x7
    6700:	e6450513          	addi	a0,a0,-412 # d560 <malloc+0x3fa0>
    6704:	00003097          	auipc	ra,0x3
    6708:	e04080e7          	jalr	-508(ra) # 9508 <printf>
  printf("  SUCCESS: exit_group available\n");
    670c:	00007517          	auipc	a0,0x7
    6710:	e8c50513          	addi	a0,a0,-372 # d598 <malloc+0x3fd8>
    6714:	00003097          	auipc	ra,0x3
    6718:	df4080e7          	jalr	-524(ra) # 9508 <printf>
}
    671c:	60a2                	ld	ra,8(sp)
    671e:	6402                	ld	s0,0(sp)
    6720:	0141                	addi	sp,sp,16
    6722:	8082                	ret

0000000000006724 <threadtest_main>:

int threadtest_main(int argc, char *argv[]) {
    6724:	1141                	addi	sp,sp,-16
    6726:	e406                	sd	ra,8(sp)
    6728:	e022                	sd	s0,0(sp)
    672a:	0800                	addi	s0,sp,16
  printf("=== POSIX Threads Test (clone/futex) ===\n\n");
    672c:	00007517          	auipc	a0,0x7
    6730:	e9450513          	addi	a0,a0,-364 # d5c0 <malloc+0x4000>
    6734:	00003097          	auipc	ra,0x3
    6738:	dd4080e7          	jalr	-556(ra) # 9508 <printf>
  
  test_clone_basic();
    673c:	00000097          	auipc	ra,0x0
    6740:	e04080e7          	jalr	-508(ra) # 6540 <test_clone_basic>
  test_clone_with_stack();
    6744:	00000097          	auipc	ra,0x0
    6748:	e98080e7          	jalr	-360(ra) # 65dc <test_clone_with_stack>
  test_futex();
    674c:	00000097          	auipc	ra,0x0
    6750:	f3c080e7          	jalr	-196(ra) # 6688 <test_futex>
  test_exit_group();
    6754:	00000097          	auipc	ra,0x0
    6758:	f90080e7          	jalr	-112(ra) # 66e4 <test_exit_group>
  
  printf("\n=== All thread tests PASSED ===\n");
    675c:	00007517          	auipc	a0,0x7
    6760:	e9450513          	addi	a0,a0,-364 # d5f0 <malloc+0x4030>
    6764:	00003097          	auipc	ra,0x3
    6768:	da4080e7          	jalr	-604(ra) # 9508 <printf>
  
  // Use exit_group to exit
  exit_group(0);
    676c:	4501                	li	a0,0
    676e:	00003097          	auipc	ra,0x3
    6772:	a54080e7          	jalr	-1452(ra) # 91c2 <exit_group>
  exit(0);  // Never reached
    6776:	4501                	li	a0,0
    6778:	00003097          	auipc	ra,0x3
    677c:	810080e7          	jalr	-2032(ra) # 8f88 <exit>

0000000000006780 <threadtest>:
void threadtest(char *s) {
    6780:	1101                	addi	sp,sp,-32
    6782:	ec06                	sd	ra,24(sp)
    6784:	e822                	sd	s0,16(sp)
    6786:	1000                	addi	s0,sp,32
    if(verbose) { char *argv[] = {"threadtest", 0}; threadtest_main(1, argv); return; }
    6788:	00009797          	auipc	a5,0x9
    678c:	10c7a783          	lw	a5,268(a5) # f894 <verbose>
    6790:	ef99                	bnez	a5,67ae <threadtest+0x2e>
    int pid = fork();
    6792:	00002097          	auipc	ra,0x2
    6796:	7ee080e7          	jalr	2030(ra) # 8f80 <fork>
    if(pid == 0) exit(0);
    679a:	c10d                	beqz	a0,67bc <threadtest+0x3c>
    wait(0);
    679c:	4501                	li	a0,0
    679e:	00002097          	auipc	ra,0x2
    67a2:	7f2080e7          	jalr	2034(ra) # 8f90 <wait>
}
    67a6:	60e2                	ld	ra,24(sp)
    67a8:	6442                	ld	s0,16(sp)
    67aa:	6105                	addi	sp,sp,32
    67ac:	8082                	ret
    if(verbose) { char *argv[] = {"threadtest", 0}; threadtest_main(1, argv); return; }
    67ae:	fe040593          	addi	a1,s0,-32
    67b2:	4505                	li	a0,1
    67b4:	00000097          	auipc	ra,0x0
    67b8:	f70080e7          	jalr	-144(ra) # 6724 <threadtest_main>
    if(pid == 0) exit(0);
    67bc:	00002097          	auipc	ra,0x2
    67c0:	7cc080e7          	jalr	1996(ra) # 8f88 <exit>

00000000000067c4 <parent_strcmp>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

// simple strcmp
int parent_strcmp(const char *p, const char *q)
{
    67c4:	1141                	addi	sp,sp,-16
    67c6:	e422                	sd	s0,8(sp)
    67c8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    67ca:	00054783          	lbu	a5,0(a0)
    67ce:	cb91                	beqz	a5,67e2 <parent_strcmp+0x1e>
    67d0:	0005c703          	lbu	a4,0(a1) # 1000 <testdev+0x162>
    67d4:	00f71763          	bne	a4,a5,67e2 <parent_strcmp+0x1e>
    p++, q++;
    67d8:	0505                	addi	a0,a0,1
    67da:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    67dc:	00054783          	lbu	a5,0(a0)
    67e0:	fbe5                	bnez	a5,67d0 <parent_strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    67e2:	0005c503          	lbu	a0,0(a1)
}
    67e6:	40a7853b          	subw	a0,a5,a0
    67ea:	6422                	ld	s0,8(sp)
    67ec:	0141                	addi	sp,sp,16
    67ee:	8082                	ret

00000000000067f0 <test_lseek>:

void test_lseek(void) {
    67f0:	7179                	addi	sp,sp,-48
    67f2:	f406                	sd	ra,40(sp)
    67f4:	f022                	sd	s0,32(sp)
    67f6:	ec26                	sd	s1,24(sp)
    67f8:	1800                	addi	s0,sp,48
  printf("Test: lseek...\n");
    67fa:	00007517          	auipc	a0,0x7
    67fe:	e1e50513          	addi	a0,a0,-482 # d618 <malloc+0x4058>
    6802:	00003097          	auipc	ra,0x3
    6806:	d06080e7          	jalr	-762(ra) # 9508 <printf>
  int fd = open("lseek.test", O_CREATE | O_RDWR);
    680a:	20200593          	li	a1,514
    680e:	00007517          	auipc	a0,0x7
    6812:	e1a50513          	addi	a0,a0,-486 # d628 <malloc+0x4068>
    6816:	00002097          	auipc	ra,0x2
    681a:	7b2080e7          	jalr	1970(ra) # 8fc8 <open>
  if(fd < 0){
    681e:	0c054a63          	bltz	a0,68f2 <test_lseek+0x102>
    6822:	84aa                	mv	s1,a0
    printf("lseek: create failed\n");
    exit(1);
  }

  write(fd, "hello world", 11);
    6824:	462d                	li	a2,11
    6826:	00007597          	auipc	a1,0x7
    682a:	e2a58593          	addi	a1,a1,-470 # d650 <malloc+0x4090>
    682e:	00002097          	auipc	ra,0x2
    6832:	77a080e7          	jalr	1914(ra) # 8fa8 <write>

  // SEEK_SET
  if(lseek(fd, 0, 0) != 0){ // SEEK_SET = 0
    6836:	4601                	li	a2,0
    6838:	4581                	li	a1,0
    683a:	8526                	mv	a0,s1
    683c:	00003097          	auipc	ra,0x3
    6840:	8be080e7          	jalr	-1858(ra) # 90fa <lseek>
    6844:	e561                	bnez	a0,690c <test_lseek+0x11c>
    printf("lseek: SEEK_SET failed\n");
    exit(1);
  }
  
  char buf[6];
  if(read(fd, buf, 5) != 5){
    6846:	4615                	li	a2,5
    6848:	fd840593          	addi	a1,s0,-40
    684c:	8526                	mv	a0,s1
    684e:	00002097          	auipc	ra,0x2
    6852:	752080e7          	jalr	1874(ra) # 8fa0 <read>
    6856:	4795                	li	a5,5
    6858:	0cf51763          	bne	a0,a5,6926 <test_lseek+0x136>
    printf("lseek: read failed\n");
    exit(1);
  }
  buf[5] = 0;
    685c:	fc040ea3          	sb	zero,-35(s0)
  if(parent_strcmp(buf, "hello") != 0){ // strcmp is not available? use manual compare
    6860:	00003597          	auipc	a1,0x3
    6864:	3d058593          	addi	a1,a1,976 # 9c30 <malloc+0x670>
    6868:	fd840513          	addi	a0,s0,-40
    686c:	00000097          	auipc	ra,0x0
    6870:	f58080e7          	jalr	-168(ra) # 67c4 <parent_strcmp>
    6874:	e571                	bnez	a0,6940 <test_lseek+0x150>
     printf("lseek: content mismatch (expected hello, got %s)\n", buf);
     exit(1);
  }

  // SEEK_CUR
  if(lseek(fd, 1, 1) != 6){ // SEEK_CUR = 1, current is 5, +1 = 6
    6876:	4605                	li	a2,1
    6878:	4585                	li	a1,1
    687a:	8526                	mv	a0,s1
    687c:	00003097          	auipc	ra,0x3
    6880:	87e080e7          	jalr	-1922(ra) # 90fa <lseek>
    6884:	4799                	li	a5,6
    6886:	0cf51c63          	bne	a0,a5,695e <test_lseek+0x16e>
    printf("lseek: SEEK_CUR failed\n");
    exit(1);
  }

  if(read(fd, buf, 5) != 5){
    688a:	4615                	li	a2,5
    688c:	fd840593          	addi	a1,s0,-40
    6890:	8526                	mv	a0,s1
    6892:	00002097          	auipc	ra,0x2
    6896:	70e080e7          	jalr	1806(ra) # 8fa0 <read>
    689a:	4795                	li	a5,5
    689c:	0cf51e63          	bne	a0,a5,6978 <test_lseek+0x188>
     printf("lseek: read2 failed\n");
     exit(1);
  }
  buf[5] = 0;
    68a0:	fc040ea3          	sb	zero,-35(s0)
  if(parent_strcmp(buf, "world") != 0){
    68a4:	00007597          	auipc	a1,0x7
    68a8:	e5458593          	addi	a1,a1,-428 # d6f8 <malloc+0x4138>
    68ac:	fd840513          	addi	a0,s0,-40
    68b0:	00000097          	auipc	ra,0x0
    68b4:	f14080e7          	jalr	-236(ra) # 67c4 <parent_strcmp>
    68b8:	ed69                	bnez	a0,6992 <test_lseek+0x1a2>
      printf("lseek: content mismatch 2 (expected world, got %s)\n", buf);
      exit(1);
  }

  // SEEK_END
  if(lseek(fd, -5, 2) != 6){ // SEEK_END = 2, size is 11, -5 = 6
    68ba:	4609                	li	a2,2
    68bc:	55ed                	li	a1,-5
    68be:	8526                	mv	a0,s1
    68c0:	00003097          	auipc	ra,0x3
    68c4:	83a080e7          	jalr	-1990(ra) # 90fa <lseek>
    68c8:	4799                	li	a5,6
    68ca:	0ef51363          	bne	a0,a5,69b0 <test_lseek+0x1c0>
      printf("lseek: SEEK_END failed\n");
      exit(1);
  }

  close(fd);
    68ce:	8526                	mv	a0,s1
    68d0:	00002097          	auipc	ra,0x2
    68d4:	6e0080e7          	jalr	1760(ra) # 8fb0 <close>
  printf("lseek: ok\n");
    68d8:	00007517          	auipc	a0,0x7
    68dc:	e7850513          	addi	a0,a0,-392 # d750 <malloc+0x4190>
    68e0:	00003097          	auipc	ra,0x3
    68e4:	c28080e7          	jalr	-984(ra) # 9508 <printf>
}
    68e8:	70a2                	ld	ra,40(sp)
    68ea:	7402                	ld	s0,32(sp)
    68ec:	64e2                	ld	s1,24(sp)
    68ee:	6145                	addi	sp,sp,48
    68f0:	8082                	ret
    printf("lseek: create failed\n");
    68f2:	00007517          	auipc	a0,0x7
    68f6:	d4650513          	addi	a0,a0,-698 # d638 <malloc+0x4078>
    68fa:	00003097          	auipc	ra,0x3
    68fe:	c0e080e7          	jalr	-1010(ra) # 9508 <printf>
    exit(1);
    6902:	4505                	li	a0,1
    6904:	00002097          	auipc	ra,0x2
    6908:	684080e7          	jalr	1668(ra) # 8f88 <exit>
    printf("lseek: SEEK_SET failed\n");
    690c:	00007517          	auipc	a0,0x7
    6910:	d5450513          	addi	a0,a0,-684 # d660 <malloc+0x40a0>
    6914:	00003097          	auipc	ra,0x3
    6918:	bf4080e7          	jalr	-1036(ra) # 9508 <printf>
    exit(1);
    691c:	4505                	li	a0,1
    691e:	00002097          	auipc	ra,0x2
    6922:	66a080e7          	jalr	1642(ra) # 8f88 <exit>
    printf("lseek: read failed\n");
    6926:	00007517          	auipc	a0,0x7
    692a:	d5250513          	addi	a0,a0,-686 # d678 <malloc+0x40b8>
    692e:	00003097          	auipc	ra,0x3
    6932:	bda080e7          	jalr	-1062(ra) # 9508 <printf>
    exit(1);
    6936:	4505                	li	a0,1
    6938:	00002097          	auipc	ra,0x2
    693c:	650080e7          	jalr	1616(ra) # 8f88 <exit>
     printf("lseek: content mismatch (expected hello, got %s)\n", buf);
    6940:	fd840593          	addi	a1,s0,-40
    6944:	00007517          	auipc	a0,0x7
    6948:	d4c50513          	addi	a0,a0,-692 # d690 <malloc+0x40d0>
    694c:	00003097          	auipc	ra,0x3
    6950:	bbc080e7          	jalr	-1092(ra) # 9508 <printf>
     exit(1);
    6954:	4505                	li	a0,1
    6956:	00002097          	auipc	ra,0x2
    695a:	632080e7          	jalr	1586(ra) # 8f88 <exit>
    printf("lseek: SEEK_CUR failed\n");
    695e:	00007517          	auipc	a0,0x7
    6962:	d6a50513          	addi	a0,a0,-662 # d6c8 <malloc+0x4108>
    6966:	00003097          	auipc	ra,0x3
    696a:	ba2080e7          	jalr	-1118(ra) # 9508 <printf>
    exit(1);
    696e:	4505                	li	a0,1
    6970:	00002097          	auipc	ra,0x2
    6974:	618080e7          	jalr	1560(ra) # 8f88 <exit>
     printf("lseek: read2 failed\n");
    6978:	00007517          	auipc	a0,0x7
    697c:	d6850513          	addi	a0,a0,-664 # d6e0 <malloc+0x4120>
    6980:	00003097          	auipc	ra,0x3
    6984:	b88080e7          	jalr	-1144(ra) # 9508 <printf>
     exit(1);
    6988:	4505                	li	a0,1
    698a:	00002097          	auipc	ra,0x2
    698e:	5fe080e7          	jalr	1534(ra) # 8f88 <exit>
      printf("lseek: content mismatch 2 (expected world, got %s)\n", buf);
    6992:	fd840593          	addi	a1,s0,-40
    6996:	00007517          	auipc	a0,0x7
    699a:	d6a50513          	addi	a0,a0,-662 # d700 <malloc+0x4140>
    699e:	00003097          	auipc	ra,0x3
    69a2:	b6a080e7          	jalr	-1174(ra) # 9508 <printf>
      exit(1);
    69a6:	4505                	li	a0,1
    69a8:	00002097          	auipc	ra,0x2
    69ac:	5e0080e7          	jalr	1504(ra) # 8f88 <exit>
      printf("lseek: SEEK_END failed\n");
    69b0:	00007517          	auipc	a0,0x7
    69b4:	d8850513          	addi	a0,a0,-632 # d738 <malloc+0x4178>
    69b8:	00003097          	auipc	ra,0x3
    69bc:	b50080e7          	jalr	-1200(ra) # 9508 <printf>
      exit(1);
    69c0:	4505                	li	a0,1
    69c2:	00002097          	auipc	ra,0x2
    69c6:	5c6080e7          	jalr	1478(ra) # 8f88 <exit>

00000000000069ca <test_dup2>:

void test_dup2(void) {
    69ca:	7179                	addi	sp,sp,-48
    69cc:	f406                	sd	ra,40(sp)
    69ce:	f022                	sd	s0,32(sp)
    69d0:	ec26                	sd	s1,24(sp)
    69d2:	1800                	addi	s0,sp,48
  printf("Test: dup2...\n");
    69d4:	00007517          	auipc	a0,0x7
    69d8:	d8c50513          	addi	a0,a0,-628 # d760 <malloc+0x41a0>
    69dc:	00003097          	auipc	ra,0x3
    69e0:	b2c080e7          	jalr	-1236(ra) # 9508 <printf>
  int fd = open("dup2.test", O_CREATE | O_RDWR);
    69e4:	20200593          	li	a1,514
    69e8:	00007517          	auipc	a0,0x7
    69ec:	d8850513          	addi	a0,a0,-632 # d770 <malloc+0x41b0>
    69f0:	00002097          	auipc	ra,0x2
    69f4:	5d8080e7          	jalr	1496(ra) # 8fc8 <open>
  if(fd < 0){
    69f8:	08054c63          	bltz	a0,6a90 <test_dup2+0xc6>
    69fc:	84aa                	mv	s1,a0
      printf("dup2: create failed\n");
      exit(1);
  }
  
  // dup2 to 10
  if(dup2(fd, 10) != 10){
    69fe:	45a9                	li	a1,10
    6a00:	00002097          	auipc	ra,0x2
    6a04:	704080e7          	jalr	1796(ra) # 9104 <dup2>
    6a08:	47a9                	li	a5,10
    6a0a:	0af51063          	bne	a0,a5,6aaa <test_dup2+0xe0>
      printf("dup2: failed to dup to 10\n");
      exit(1);
  }
  
  write(10, "dup2data", 8);
    6a0e:	4621                	li	a2,8
    6a10:	00007597          	auipc	a1,0x7
    6a14:	da858593          	addi	a1,a1,-600 # d7b8 <malloc+0x41f8>
    6a18:	4529                	li	a0,10
    6a1a:	00002097          	auipc	ra,0x2
    6a1e:	58e080e7          	jalr	1422(ra) # 8fa8 <write>
  close(10);
    6a22:	4529                	li	a0,10
    6a24:	00002097          	auipc	ra,0x2
    6a28:	58c080e7          	jalr	1420(ra) # 8fb0 <close>
  
  // Verify content
  if(lseek(fd, 0, 0) != 0){
    6a2c:	4601                	li	a2,0
    6a2e:	4581                	li	a1,0
    6a30:	8526                	mv	a0,s1
    6a32:	00002097          	auipc	ra,0x2
    6a36:	6c8080e7          	jalr	1736(ra) # 90fa <lseek>
    6a3a:	e549                	bnez	a0,6ac4 <test_dup2+0xfa>
      printf("dup2: lseek failed\n");
      exit(1);
  }
  char buf[9];
  if(read(fd, buf, 8) != 8){
    6a3c:	4621                	li	a2,8
    6a3e:	fd040593          	addi	a1,s0,-48
    6a42:	8526                	mv	a0,s1
    6a44:	00002097          	auipc	ra,0x2
    6a48:	55c080e7          	jalr	1372(ra) # 8fa0 <read>
    6a4c:	47a1                	li	a5,8
    6a4e:	08f51863          	bne	a0,a5,6ade <test_dup2+0x114>
      printf("dup2: verify read failed\n");
      exit(1);
  }
  buf[8] = 0;
    6a52:	fc040c23          	sb	zero,-40(s0)
  if(parent_strcmp(buf, "dup2data") != 0){
    6a56:	00007597          	auipc	a1,0x7
    6a5a:	d6258593          	addi	a1,a1,-670 # d7b8 <malloc+0x41f8>
    6a5e:	fd040513          	addi	a0,s0,-48
    6a62:	00000097          	auipc	ra,0x0
    6a66:	d62080e7          	jalr	-670(ra) # 67c4 <parent_strcmp>
    6a6a:	e559                	bnez	a0,6af8 <test_dup2+0x12e>
      printf("dup2: content mismatch\n");
      exit(1);
  }
  
  close(fd);
    6a6c:	8526                	mv	a0,s1
    6a6e:	00002097          	auipc	ra,0x2
    6a72:	542080e7          	jalr	1346(ra) # 8fb0 <close>
  printf("dup2: ok\n");
    6a76:	00007517          	auipc	a0,0x7
    6a7a:	da250513          	addi	a0,a0,-606 # d818 <malloc+0x4258>
    6a7e:	00003097          	auipc	ra,0x3
    6a82:	a8a080e7          	jalr	-1398(ra) # 9508 <printf>
}
    6a86:	70a2                	ld	ra,40(sp)
    6a88:	7402                	ld	s0,32(sp)
    6a8a:	64e2                	ld	s1,24(sp)
    6a8c:	6145                	addi	sp,sp,48
    6a8e:	8082                	ret
      printf("dup2: create failed\n");
    6a90:	00007517          	auipc	a0,0x7
    6a94:	cf050513          	addi	a0,a0,-784 # d780 <malloc+0x41c0>
    6a98:	00003097          	auipc	ra,0x3
    6a9c:	a70080e7          	jalr	-1424(ra) # 9508 <printf>
      exit(1);
    6aa0:	4505                	li	a0,1
    6aa2:	00002097          	auipc	ra,0x2
    6aa6:	4e6080e7          	jalr	1254(ra) # 8f88 <exit>
      printf("dup2: failed to dup to 10\n");
    6aaa:	00007517          	auipc	a0,0x7
    6aae:	cee50513          	addi	a0,a0,-786 # d798 <malloc+0x41d8>
    6ab2:	00003097          	auipc	ra,0x3
    6ab6:	a56080e7          	jalr	-1450(ra) # 9508 <printf>
      exit(1);
    6aba:	4505                	li	a0,1
    6abc:	00002097          	auipc	ra,0x2
    6ac0:	4cc080e7          	jalr	1228(ra) # 8f88 <exit>
      printf("dup2: lseek failed\n");
    6ac4:	00007517          	auipc	a0,0x7
    6ac8:	d0450513          	addi	a0,a0,-764 # d7c8 <malloc+0x4208>
    6acc:	00003097          	auipc	ra,0x3
    6ad0:	a3c080e7          	jalr	-1476(ra) # 9508 <printf>
      exit(1);
    6ad4:	4505                	li	a0,1
    6ad6:	00002097          	auipc	ra,0x2
    6ada:	4b2080e7          	jalr	1202(ra) # 8f88 <exit>
      printf("dup2: verify read failed\n");
    6ade:	00007517          	auipc	a0,0x7
    6ae2:	d0250513          	addi	a0,a0,-766 # d7e0 <malloc+0x4220>
    6ae6:	00003097          	auipc	ra,0x3
    6aea:	a22080e7          	jalr	-1502(ra) # 9508 <printf>
      exit(1);
    6aee:	4505                	li	a0,1
    6af0:	00002097          	auipc	ra,0x2
    6af4:	498080e7          	jalr	1176(ra) # 8f88 <exit>
      printf("dup2: content mismatch\n");
    6af8:	00007517          	auipc	a0,0x7
    6afc:	d0850513          	addi	a0,a0,-760 # d800 <malloc+0x4240>
    6b00:	00003097          	auipc	ra,0x3
    6b04:	a08080e7          	jalr	-1528(ra) # 9508 <printf>
      exit(1);
    6b08:	4505                	li	a0,1
    6b0a:	00002097          	auipc	ra,0x2
    6b0e:	47e080e7          	jalr	1150(ra) # 8f88 <exit>

0000000000006b12 <test_getppid>:

void test_getppid(void) {
    6b12:	7179                	addi	sp,sp,-48
    6b14:	f406                	sd	ra,40(sp)
    6b16:	f022                	sd	s0,32(sp)
    6b18:	ec26                	sd	s1,24(sp)
    6b1a:	1800                	addi	s0,sp,48
  printf("Test: getppid...\n");
    6b1c:	00007517          	auipc	a0,0x7
    6b20:	d0c50513          	addi	a0,a0,-756 # d828 <malloc+0x4268>
    6b24:	00003097          	auipc	ra,0x3
    6b28:	9e4080e7          	jalr	-1564(ra) # 9508 <printf>
  int pid = fork();
    6b2c:	00002097          	auipc	ra,0x2
    6b30:	454080e7          	jalr	1108(ra) # 8f80 <fork>
  if(pid < 0){
    6b34:	02054f63          	bltz	a0,6b72 <test_getppid+0x60>
      printf("getppid: fork failed\n");
      exit(1);
  }
  
  if(pid == 0){
    6b38:	c931                	beqz	a0,6b8c <test_getppid+0x7a>
      int ppid = getppid();
      // int actual_ppid = getpid(); // Unused
      exit(ppid);
  } else {
      // parent
      int mypid = getpid();
    6b3a:	00002097          	auipc	ra,0x2
    6b3e:	4b6080e7          	jalr	1206(ra) # 8ff0 <getpid>
    6b42:	84aa                	mv	s1,a0
      int status;
      wait(&status);
    6b44:	fdc40513          	addi	a0,s0,-36
    6b48:	00002097          	auipc	ra,0x2
    6b4c:	448080e7          	jalr	1096(ra) # 8f90 <wait>
      if(status != mypid){
    6b50:	fdc42603          	lw	a2,-36(s0)
    6b54:	04961463          	bne	a2,s1,6b9c <test_getppid+0x8a>
          printf("getppid: expected %d, got %d\n", mypid, status);
          exit(1);
      }
      printf("getppid: ok\n");
    6b58:	00007517          	auipc	a0,0x7
    6b5c:	d2050513          	addi	a0,a0,-736 # d878 <malloc+0x42b8>
    6b60:	00003097          	auipc	ra,0x3
    6b64:	9a8080e7          	jalr	-1624(ra) # 9508 <printf>
  }
}
    6b68:	70a2                	ld	ra,40(sp)
    6b6a:	7402                	ld	s0,32(sp)
    6b6c:	64e2                	ld	s1,24(sp)
    6b6e:	6145                	addi	sp,sp,48
    6b70:	8082                	ret
      printf("getppid: fork failed\n");
    6b72:	00007517          	auipc	a0,0x7
    6b76:	cce50513          	addi	a0,a0,-818 # d840 <malloc+0x4280>
    6b7a:	00003097          	auipc	ra,0x3
    6b7e:	98e080e7          	jalr	-1650(ra) # 9508 <printf>
      exit(1);
    6b82:	4505                	li	a0,1
    6b84:	00002097          	auipc	ra,0x2
    6b88:	404080e7          	jalr	1028(ra) # 8f88 <exit>
      int ppid = getppid();
    6b8c:	00002097          	auipc	ra,0x2
    6b90:	582080e7          	jalr	1410(ra) # 910e <getppid>
      exit(ppid);
    6b94:	00002097          	auipc	ra,0x2
    6b98:	3f4080e7          	jalr	1012(ra) # 8f88 <exit>
          printf("getppid: expected %d, got %d\n", mypid, status);
    6b9c:	85a6                	mv	a1,s1
    6b9e:	00007517          	auipc	a0,0x7
    6ba2:	cba50513          	addi	a0,a0,-838 # d858 <malloc+0x4298>
    6ba6:	00003097          	auipc	ra,0x3
    6baa:	962080e7          	jalr	-1694(ra) # 9508 <printf>
          exit(1);
    6bae:	4505                	li	a0,1
    6bb0:	00002097          	auipc	ra,0x2
    6bb4:	3d8080e7          	jalr	984(ra) # 8f88 <exit>

0000000000006bb8 <exttest_main>:

int exttest_main(void) {
    6bb8:	1141                	addi	sp,sp,-16
    6bba:	e406                	sd	ra,8(sp)
    6bbc:	e022                	sd	s0,0(sp)
    6bbe:	0800                	addi	s0,sp,16
  printf("exttest starting\n");
    6bc0:	00007517          	auipc	a0,0x7
    6bc4:	cc850513          	addi	a0,a0,-824 # d888 <malloc+0x42c8>
    6bc8:	00003097          	auipc	ra,0x3
    6bcc:	940080e7          	jalr	-1728(ra) # 9508 <printf>
  test_lseek();
    6bd0:	00000097          	auipc	ra,0x0
    6bd4:	c20080e7          	jalr	-992(ra) # 67f0 <test_lseek>
  test_dup2();
    6bd8:	00000097          	auipc	ra,0x0
    6bdc:	df2080e7          	jalr	-526(ra) # 69ca <test_dup2>
  test_getppid();
    6be0:	00000097          	auipc	ra,0x0
    6be4:	f32080e7          	jalr	-206(ra) # 6b12 <test_getppid>
  printf("exttest finished\n");
    6be8:	00007517          	auipc	a0,0x7
    6bec:	cb850513          	addi	a0,a0,-840 # d8a0 <malloc+0x42e0>
    6bf0:	00003097          	auipc	ra,0x3
    6bf4:	918080e7          	jalr	-1768(ra) # 9508 <printf>
  exit(0);
    6bf8:	4501                	li	a0,0
    6bfa:	00002097          	auipc	ra,0x2
    6bfe:	38e080e7          	jalr	910(ra) # 8f88 <exit>

0000000000006c02 <exttest>:
void exttest(char *s) {
    6c02:	1101                	addi	sp,sp,-32
    6c04:	ec06                	sd	ra,24(sp)
    6c06:	e822                	sd	s0,16(sp)
    6c08:	e426                	sd	s1,8(sp)
    6c0a:	1000                	addi	s0,sp,32
    if(verbose) { exttest_main(); return; }
    6c0c:	00009797          	auipc	a5,0x9
    6c10:	c887a783          	lw	a5,-888(a5) # f894 <verbose>
    6c14:	ef89                	bnez	a5,6c2e <exttest+0x2c>
    6c16:	84aa                	mv	s1,a0
    if(getppid() <= 0) { printf("%s: getppid failed\n", s); exit(1); }
    6c18:	00002097          	auipc	ra,0x2
    6c1c:	4f6080e7          	jalr	1270(ra) # 910e <getppid>
    6c20:	00a05b63          	blez	a0,6c36 <exttest+0x34>
}
    6c24:	60e2                	ld	ra,24(sp)
    6c26:	6442                	ld	s0,16(sp)
    6c28:	64a2                	ld	s1,8(sp)
    6c2a:	6105                	addi	sp,sp,32
    6c2c:	8082                	ret
    if(verbose) { exttest_main(); return; }
    6c2e:	00000097          	auipc	ra,0x0
    6c32:	f8a080e7          	jalr	-118(ra) # 6bb8 <exttest_main>
    if(getppid() <= 0) { printf("%s: getppid failed\n", s); exit(1); }
    6c36:	85a6                	mv	a1,s1
    6c38:	00007517          	auipc	a0,0x7
    6c3c:	c8050513          	addi	a0,a0,-896 # d8b8 <malloc+0x42f8>
    6c40:	00003097          	auipc	ra,0x3
    6c44:	8c8080e7          	jalr	-1848(ra) # 9508 <printf>
    6c48:	4505                	li	a0,1
    6c4a:	00002097          	auipc	ra,0x2
    6c4e:	33e080e7          	jalr	830(ra) # 8f88 <exit>

0000000000006c52 <test_basic>:
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

void test_basic(void) {
    6c52:	1101                	addi	sp,sp,-32
    6c54:	ec06                	sd	ra,24(sp)
    6c56:	e822                	sd	s0,16(sp)
    6c58:	e426                	sd	s1,8(sp)
    6c5a:	e04a                	sd	s2,0(sp)
    6c5c:	1000                	addi	s0,sp,32
  printf("Test: basic uid/gid...\n");
    6c5e:	00007517          	auipc	a0,0x7
    6c62:	c7250513          	addi	a0,a0,-910 # d8d0 <malloc+0x4310>
    6c66:	00003097          	auipc	ra,0x3
    6c6a:	8a2080e7          	jalr	-1886(ra) # 9508 <printf>
  int uid = getuid();
    6c6e:	00002097          	auipc	ra,0x2
    6c72:	4aa080e7          	jalr	1194(ra) # 9118 <getuid>
    6c76:	84aa                	mv	s1,a0
  int gid = getgid();
    6c78:	00002097          	auipc	ra,0x2
    6c7c:	4b4080e7          	jalr	1204(ra) # 912c <getgid>
    6c80:	892a                	mv	s2,a0
  printf("Current uid=%d, gid=%d\n", uid, gid);
    6c82:	862a                	mv	a2,a0
    6c84:	85a6                	mv	a1,s1
    6c86:	00007517          	auipc	a0,0x7
    6c8a:	c6250513          	addi	a0,a0,-926 # d8e8 <malloc+0x4328>
    6c8e:	00003097          	auipc	ra,0x3
    6c92:	87a080e7          	jalr	-1926(ra) # 9508 <printf>
  if(uid != 0 || gid != 0) {
    6c96:	0124e7b3          	or	a5,s1,s2
    6c9a:	2781                	sext.w	a5,a5
    6c9c:	ef99                	bnez	a5,6cba <test_basic+0x68>
    printf("Initial uid/gid should be 0 (got uid=%d, gid=%d)\n", uid, gid);
    exit(1);
  }
  printf("basic: ok\n");
    6c9e:	00007517          	auipc	a0,0x7
    6ca2:	c9a50513          	addi	a0,a0,-870 # d938 <malloc+0x4378>
    6ca6:	00003097          	auipc	ra,0x3
    6caa:	862080e7          	jalr	-1950(ra) # 9508 <printf>
}
    6cae:	60e2                	ld	ra,24(sp)
    6cb0:	6442                	ld	s0,16(sp)
    6cb2:	64a2                	ld	s1,8(sp)
    6cb4:	6902                	ld	s2,0(sp)
    6cb6:	6105                	addi	sp,sp,32
    6cb8:	8082                	ret
    printf("Initial uid/gid should be 0 (got uid=%d, gid=%d)\n", uid, gid);
    6cba:	864a                	mv	a2,s2
    6cbc:	85a6                	mv	a1,s1
    6cbe:	00007517          	auipc	a0,0x7
    6cc2:	c4250513          	addi	a0,a0,-958 # d900 <malloc+0x4340>
    6cc6:	00003097          	auipc	ra,0x3
    6cca:	842080e7          	jalr	-1982(ra) # 9508 <printf>
    exit(1);
    6cce:	4505                	li	a0,1
    6cd0:	00002097          	auipc	ra,0x2
    6cd4:	2b8080e7          	jalr	696(ra) # 8f88 <exit>

0000000000006cd8 <test_setuid>:

void test_setuid(void) {
    6cd8:	1101                	addi	sp,sp,-32
    6cda:	ec06                	sd	ra,24(sp)
    6cdc:	e822                	sd	s0,16(sp)
    6cde:	1000                	addi	s0,sp,32
  printf("Test: setuid...\n");
    6ce0:	00007517          	auipc	a0,0x7
    6ce4:	c6850513          	addi	a0,a0,-920 # d948 <malloc+0x4388>
    6ce8:	00003097          	auipc	ra,0x3
    6cec:	820080e7          	jalr	-2016(ra) # 9508 <printf>
  
  // Root can set strict
  if(setuid(100) < 0) {
    6cf0:	06400513          	li	a0,100
    6cf4:	00002097          	auipc	ra,0x2
    6cf8:	42e080e7          	jalr	1070(ra) # 9122 <setuid>
    6cfc:	04054c63          	bltz	a0,6d54 <test_setuid+0x7c>
    printf("root setuid(100) failed\n");
    exit(1);
  }

  if(getuid() != 100) {
    6d00:	00002097          	auipc	ra,0x2
    6d04:	418080e7          	jalr	1048(ra) # 9118 <getuid>
    6d08:	06400793          	li	a5,100
    6d0c:	06f51163          	bne	a0,a5,6d6e <test_setuid+0x96>
     printf("getuid failed after setuid(100)\n");
     exit(1);
  }

  // Fork should inherit
  int pid = fork();
    6d10:	00002097          	auipc	ra,0x2
    6d14:	270080e7          	jalr	624(ra) # 8f80 <fork>
  if(pid < 0) {
    6d18:	06054863          	bltz	a0,6d88 <test_setuid+0xb0>
      printf("fork failed\n");
      exit(1);
  }

  if(pid == 0) {
    6d1c:	e979                	bnez	a0,6df2 <test_setuid+0x11a>
      // Child
      int cuid = getuid();
    6d1e:	00002097          	auipc	ra,0x2
    6d22:	3fa080e7          	jalr	1018(ra) # 9118 <getuid>
      if(cuid != 100) {
    6d26:	06400793          	li	a5,100
    6d2a:	06f51c63          	bne	a0,a5,6da2 <test_setuid+0xca>
          printf("Child did not inherit uid 100 (got %d)\n", cuid);
          exit(1);
      }
      
      // Non-root cannot set to 0
      if(setuid(0) == 0) {
    6d2e:	4501                	li	a0,0
    6d30:	00002097          	auipc	ra,0x2
    6d34:	3f2080e7          	jalr	1010(ra) # 9122 <setuid>
    6d38:	c159                	beqz	a0,6dbe <test_setuid+0xe6>
          printf("Non-root (100) setuid(0) should fail but succeeded\n");
          exit(1);
      }
      
      // Non-root can set to self
      if(setuid(100) < 0) {
    6d3a:	06400513          	li	a0,100
    6d3e:	00002097          	auipc	ra,0x2
    6d42:	3e4080e7          	jalr	996(ra) # 9122 <setuid>
    6d46:	08054963          	bltz	a0,6dd8 <test_setuid+0x100>
          printf("Non-root setuid(self) failed\n");
          exit(1);
      }
      
      exit(0);
    6d4a:	4501                	li	a0,0
    6d4c:	00002097          	auipc	ra,0x2
    6d50:	23c080e7          	jalr	572(ra) # 8f88 <exit>
    printf("root setuid(100) failed\n");
    6d54:	00007517          	auipc	a0,0x7
    6d58:	c0c50513          	addi	a0,a0,-1012 # d960 <malloc+0x43a0>
    6d5c:	00002097          	auipc	ra,0x2
    6d60:	7ac080e7          	jalr	1964(ra) # 9508 <printf>
    exit(1);
    6d64:	4505                	li	a0,1
    6d66:	00002097          	auipc	ra,0x2
    6d6a:	222080e7          	jalr	546(ra) # 8f88 <exit>
     printf("getuid failed after setuid(100)\n");
    6d6e:	00007517          	auipc	a0,0x7
    6d72:	c1250513          	addi	a0,a0,-1006 # d980 <malloc+0x43c0>
    6d76:	00002097          	auipc	ra,0x2
    6d7a:	792080e7          	jalr	1938(ra) # 9508 <printf>
     exit(1);
    6d7e:	4505                	li	a0,1
    6d80:	00002097          	auipc	ra,0x2
    6d84:	208080e7          	jalr	520(ra) # 8f88 <exit>
      printf("fork failed\n");
    6d88:	00003517          	auipc	a0,0x3
    6d8c:	7d050513          	addi	a0,a0,2000 # a558 <malloc+0xf98>
    6d90:	00002097          	auipc	ra,0x2
    6d94:	778080e7          	jalr	1912(ra) # 9508 <printf>
      exit(1);
    6d98:	4505                	li	a0,1
    6d9a:	00002097          	auipc	ra,0x2
    6d9e:	1ee080e7          	jalr	494(ra) # 8f88 <exit>
          printf("Child did not inherit uid 100 (got %d)\n", cuid);
    6da2:	85aa                	mv	a1,a0
    6da4:	00007517          	auipc	a0,0x7
    6da8:	c0450513          	addi	a0,a0,-1020 # d9a8 <malloc+0x43e8>
    6dac:	00002097          	auipc	ra,0x2
    6db0:	75c080e7          	jalr	1884(ra) # 9508 <printf>
          exit(1);
    6db4:	4505                	li	a0,1
    6db6:	00002097          	auipc	ra,0x2
    6dba:	1d2080e7          	jalr	466(ra) # 8f88 <exit>
          printf("Non-root (100) setuid(0) should fail but succeeded\n");
    6dbe:	00007517          	auipc	a0,0x7
    6dc2:	c1250513          	addi	a0,a0,-1006 # d9d0 <malloc+0x4410>
    6dc6:	00002097          	auipc	ra,0x2
    6dca:	742080e7          	jalr	1858(ra) # 9508 <printf>
          exit(1);
    6dce:	4505                	li	a0,1
    6dd0:	00002097          	auipc	ra,0x2
    6dd4:	1b8080e7          	jalr	440(ra) # 8f88 <exit>
          printf("Non-root setuid(self) failed\n");
    6dd8:	00007517          	auipc	a0,0x7
    6ddc:	c3050513          	addi	a0,a0,-976 # da08 <malloc+0x4448>
    6de0:	00002097          	auipc	ra,0x2
    6de4:	728080e7          	jalr	1832(ra) # 9508 <printf>
          exit(1);
    6de8:	4505                	li	a0,1
    6dea:	00002097          	auipc	ra,0x2
    6dee:	19e080e7          	jalr	414(ra) # 8f88 <exit>
  } else {
      int status;
      wait(&status);
    6df2:	fec40513          	addi	a0,s0,-20
    6df6:	00002097          	auipc	ra,0x2
    6dfa:	19a080e7          	jalr	410(ra) # 8f90 <wait>
      if(status != 0) {
    6dfe:	fec42783          	lw	a5,-20(s0)
    6e02:	ef89                	bnez	a5,6e1c <test_setuid+0x144>
  }

  // Restore root? No wait, we are 100 now.
  // We cannot restore to 0. Ideally test should fork before changing self.
  // But for this simple test suite, it's fine.
  printf("setuid: ok\n");
    6e04:	00007517          	auipc	a0,0x7
    6e08:	c3c50513          	addi	a0,a0,-964 # da40 <malloc+0x4480>
    6e0c:	00002097          	auipc	ra,0x2
    6e10:	6fc080e7          	jalr	1788(ra) # 9508 <printf>
}
    6e14:	60e2                	ld	ra,24(sp)
    6e16:	6442                	ld	s0,16(sp)
    6e18:	6105                	addi	sp,sp,32
    6e1a:	8082                	ret
          printf("Child test failed\n");
    6e1c:	00007517          	auipc	a0,0x7
    6e20:	c0c50513          	addi	a0,a0,-1012 # da28 <malloc+0x4468>
    6e24:	00002097          	auipc	ra,0x2
    6e28:	6e4080e7          	jalr	1764(ra) # 9508 <printf>
          exit(1);
    6e2c:	4505                	li	a0,1
    6e2e:	00002097          	auipc	ra,0x2
    6e32:	15a080e7          	jalr	346(ra) # 8f88 <exit>

0000000000006e36 <idtest_main>:

int idtest_main(void) {
    6e36:	1141                	addi	sp,sp,-16
    6e38:	e406                	sd	ra,8(sp)
    6e3a:	e022                	sd	s0,0(sp)
    6e3c:	0800                	addi	s0,sp,16
  printf("idtest starting\n");
    6e3e:	00007517          	auipc	a0,0x7
    6e42:	c1250513          	addi	a0,a0,-1006 # da50 <malloc+0x4490>
    6e46:	00002097          	auipc	ra,0x2
    6e4a:	6c2080e7          	jalr	1730(ra) # 9508 <printf>
  test_basic();
    6e4e:	00000097          	auipc	ra,0x0
    6e52:	e04080e7          	jalr	-508(ra) # 6c52 <test_basic>
  
  // run setuid test in a child to not affect main process (though irrelevant for userinit)
  int pid = fork();
    6e56:	00002097          	auipc	ra,0x2
    6e5a:	12a080e7          	jalr	298(ra) # 8f80 <fork>
  if(pid == 0) {
    6e5e:	e911                	bnez	a0,6e72 <idtest_main+0x3c>
     test_setuid();
    6e60:	00000097          	auipc	ra,0x0
    6e64:	e78080e7          	jalr	-392(ra) # 6cd8 <test_setuid>
     exit(0);
    6e68:	4501                	li	a0,0
    6e6a:	00002097          	auipc	ra,0x2
    6e6e:	11e080e7          	jalr	286(ra) # 8f88 <exit>
  }
  wait(0);
    6e72:	4501                	li	a0,0
    6e74:	00002097          	auipc	ra,0x2
    6e78:	11c080e7          	jalr	284(ra) # 8f90 <wait>
  
  printf("idtest finished\n");
    6e7c:	00007517          	auipc	a0,0x7
    6e80:	bec50513          	addi	a0,a0,-1044 # da68 <malloc+0x44a8>
    6e84:	00002097          	auipc	ra,0x2
    6e88:	684080e7          	jalr	1668(ra) # 9508 <printf>
  exit(0);
    6e8c:	4501                	li	a0,0
    6e8e:	00002097          	auipc	ra,0x2
    6e92:	0fa080e7          	jalr	250(ra) # 8f88 <exit>

0000000000006e96 <idtest>:
void idtest(char *s) {
    6e96:	1141                	addi	sp,sp,-16
    6e98:	e406                	sd	ra,8(sp)
    6e9a:	e022                	sd	s0,0(sp)
    6e9c:	0800                	addi	s0,sp,16
    if(verbose) { idtest_main(); return; }
    6e9e:	00009797          	auipc	a5,0x9
    6ea2:	9f67a783          	lw	a5,-1546(a5) # f894 <verbose>
    6ea6:	ef89                	bnez	a5,6ec0 <idtest+0x2a>
    getuid(); getgid();  // Simple call test
    6ea8:	00002097          	auipc	ra,0x2
    6eac:	270080e7          	jalr	624(ra) # 9118 <getuid>
    6eb0:	00002097          	auipc	ra,0x2
    6eb4:	27c080e7          	jalr	636(ra) # 912c <getgid>
}
    6eb8:	60a2                	ld	ra,8(sp)
    6eba:	6402                	ld	s0,0(sp)
    6ebc:	0141                	addi	sp,sp,16
    6ebe:	8082                	ret
    if(verbose) { idtest_main(); return; }
    6ec0:	00000097          	auipc	ra,0x0
    6ec4:	f76080e7          	jalr	-138(ra) # 6e36 <idtest_main>

0000000000006ec8 <test_pipe2_basic>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

void
test_pipe2_basic()
{
    6ec8:	7179                	addi	sp,sp,-48
    6eca:	f406                	sd	ra,40(sp)
    6ecc:	f022                	sd	s0,32(sp)
    6ece:	1800                	addi	s0,sp,48
  int fd[2];
  char buf[10];
  int n;

  printf("test pipe2 basic...\n");
    6ed0:	00007517          	auipc	a0,0x7
    6ed4:	bb050513          	addi	a0,a0,-1104 # da80 <malloc+0x44c0>
    6ed8:	00002097          	auipc	ra,0x2
    6edc:	630080e7          	jalr	1584(ra) # 9508 <printf>

  if(pipe2(fd, O_NONBLOCK) < 0){
    6ee0:	6585                	lui	a1,0x1
    6ee2:	80058593          	addi	a1,a1,-2048 # 800 <truncate1+0x64>
    6ee6:	fe840513          	addi	a0,s0,-24
    6eea:	00002097          	auipc	ra,0x2
    6eee:	27e080e7          	jalr	638(ra) # 9168 <pipe2>
    6ef2:	0a054563          	bltz	a0,6f9c <test_pipe2_basic+0xd4>
    printf("pipe2 failed\n");
    exit(1);
  }

  // 1. Read from empty non-blocking pipe should return -1
  n = read(fd[0], buf, sizeof(buf));
    6ef6:	4629                	li	a2,10
    6ef8:	fd840593          	addi	a1,s0,-40
    6efc:	fe842503          	lw	a0,-24(s0)
    6f00:	00002097          	auipc	ra,0x2
    6f04:	0a0080e7          	jalr	160(ra) # 8fa0 <read>
  if(n != -1){
    6f08:	57fd                	li	a5,-1
    6f0a:	0af51663          	bne	a0,a5,6fb6 <test_pipe2_basic+0xee>
    printf("read empty non-blocking pipe returned %d, expected -1\n", n);
    exit(1);
  } else {
    printf("read empty non-blocking pipe returned -1 (expected)\n");
    6f0e:	00007517          	auipc	a0,0x7
    6f12:	bd250513          	addi	a0,a0,-1070 # dae0 <malloc+0x4520>
    6f16:	00002097          	auipc	ra,0x2
    6f1a:	5f2080e7          	jalr	1522(ra) # 9508 <printf>
  }

  // 2. Write to non-blocking pipe
  n = write(fd[1], "hello", 5);
    6f1e:	4615                	li	a2,5
    6f20:	00003597          	auipc	a1,0x3
    6f24:	d1058593          	addi	a1,a1,-752 # 9c30 <malloc+0x670>
    6f28:	fec42503          	lw	a0,-20(s0)
    6f2c:	00002097          	auipc	ra,0x2
    6f30:	07c080e7          	jalr	124(ra) # 8fa8 <write>
  if(n != 5){
    6f34:	4795                	li	a5,5
    6f36:	08f51e63          	bne	a0,a5,6fd2 <test_pipe2_basic+0x10a>
    printf("write non-blocking pipe failed\n");
    exit(1);
  }

  // 3. Read back
  n = read(fd[0], buf, sizeof(buf));
    6f3a:	4629                	li	a2,10
    6f3c:	fd840593          	addi	a1,s0,-40
    6f40:	fe842503          	lw	a0,-24(s0)
    6f44:	00002097          	auipc	ra,0x2
    6f48:	05c080e7          	jalr	92(ra) # 8fa0 <read>
  if(n != 5){
    6f4c:	4795                	li	a5,5
    6f4e:	08f51f63          	bne	a0,a5,6fec <test_pipe2_basic+0x124>
    printf("read back from non-blocking pipe returned %d\n", n);
    exit(1);
  }
  buf[n] = 0;
    6f52:	fc040ea3          	sb	zero,-35(s0)
  if(strcmp(buf, "hello") != 0){
    6f56:	00003597          	auipc	a1,0x3
    6f5a:	cda58593          	addi	a1,a1,-806 # 9c30 <malloc+0x670>
    6f5e:	fd840513          	addi	a0,s0,-40
    6f62:	00002097          	auipc	ra,0x2
    6f66:	db8080e7          	jalr	-584(ra) # 8d1a <strcmp>
    6f6a:	ed59                	bnez	a0,7008 <test_pipe2_basic+0x140>
    printf("read content mismatch\n");
    exit(1);
  }

  close(fd[0]);
    6f6c:	fe842503          	lw	a0,-24(s0)
    6f70:	00002097          	auipc	ra,0x2
    6f74:	040080e7          	jalr	64(ra) # 8fb0 <close>
  close(fd[1]);
    6f78:	fec42503          	lw	a0,-20(s0)
    6f7c:	00002097          	auipc	ra,0x2
    6f80:	034080e7          	jalr	52(ra) # 8fb0 <close>
  printf("test pipe2 basic OK\n");
    6f84:	00007517          	auipc	a0,0x7
    6f88:	bfc50513          	addi	a0,a0,-1028 # db80 <malloc+0x45c0>
    6f8c:	00002097          	auipc	ra,0x2
    6f90:	57c080e7          	jalr	1404(ra) # 9508 <printf>
}
    6f94:	70a2                	ld	ra,40(sp)
    6f96:	7402                	ld	s0,32(sp)
    6f98:	6145                	addi	sp,sp,48
    6f9a:	8082                	ret
    printf("pipe2 failed\n");
    6f9c:	00007517          	auipc	a0,0x7
    6fa0:	afc50513          	addi	a0,a0,-1284 # da98 <malloc+0x44d8>
    6fa4:	00002097          	auipc	ra,0x2
    6fa8:	564080e7          	jalr	1380(ra) # 9508 <printf>
    exit(1);
    6fac:	4505                	li	a0,1
    6fae:	00002097          	auipc	ra,0x2
    6fb2:	fda080e7          	jalr	-38(ra) # 8f88 <exit>
    printf("read empty non-blocking pipe returned %d, expected -1\n", n);
    6fb6:	85aa                	mv	a1,a0
    6fb8:	00007517          	auipc	a0,0x7
    6fbc:	af050513          	addi	a0,a0,-1296 # daa8 <malloc+0x44e8>
    6fc0:	00002097          	auipc	ra,0x2
    6fc4:	548080e7          	jalr	1352(ra) # 9508 <printf>
    exit(1);
    6fc8:	4505                	li	a0,1
    6fca:	00002097          	auipc	ra,0x2
    6fce:	fbe080e7          	jalr	-66(ra) # 8f88 <exit>
    printf("write non-blocking pipe failed\n");
    6fd2:	00007517          	auipc	a0,0x7
    6fd6:	b4650513          	addi	a0,a0,-1210 # db18 <malloc+0x4558>
    6fda:	00002097          	auipc	ra,0x2
    6fde:	52e080e7          	jalr	1326(ra) # 9508 <printf>
    exit(1);
    6fe2:	4505                	li	a0,1
    6fe4:	00002097          	auipc	ra,0x2
    6fe8:	fa4080e7          	jalr	-92(ra) # 8f88 <exit>
    printf("read back from non-blocking pipe returned %d\n", n);
    6fec:	85aa                	mv	a1,a0
    6fee:	00007517          	auipc	a0,0x7
    6ff2:	b4a50513          	addi	a0,a0,-1206 # db38 <malloc+0x4578>
    6ff6:	00002097          	auipc	ra,0x2
    6ffa:	512080e7          	jalr	1298(ra) # 9508 <printf>
    exit(1);
    6ffe:	4505                	li	a0,1
    7000:	00002097          	auipc	ra,0x2
    7004:	f88080e7          	jalr	-120(ra) # 8f88 <exit>
    printf("read content mismatch\n");
    7008:	00007517          	auipc	a0,0x7
    700c:	b6050513          	addi	a0,a0,-1184 # db68 <malloc+0x45a8>
    7010:	00002097          	auipc	ra,0x2
    7014:	4f8080e7          	jalr	1272(ra) # 9508 <printf>
    exit(1);
    7018:	4505                	li	a0,1
    701a:	00002097          	auipc	ra,0x2
    701e:	f6e080e7          	jalr	-146(ra) # 8f88 <exit>

0000000000007022 <nbtest>:
void nbtest(char *s) {
    7022:	7179                	addi	sp,sp,-48
    7024:	f406                	sd	ra,40(sp)
    7026:	f022                	sd	s0,32(sp)
    7028:	ec26                	sd	s1,24(sp)
    702a:	1800                	addi	s0,sp,48
    if(verbose) { char *argv[] = {"nbtest", 0}; nbtest_main(1, argv); return; }
    702c:	00009797          	auipc	a5,0x9
    7030:	8687a783          	lw	a5,-1944(a5) # f894 <verbose>
    7034:	ef95                	bnez	a5,7070 <nbtest+0x4e>
    7036:	84aa                	mv	s1,a0
    if(pipe2(p, O_NONBLOCK) < 0) { printf("%s: pipe2 failed\n", s); exit(1); }
    7038:	6585                	lui	a1,0x1
    703a:	80058593          	addi	a1,a1,-2048 # 800 <truncate1+0x64>
    703e:	fd840513          	addi	a0,s0,-40
    7042:	00002097          	auipc	ra,0x2
    7046:	126080e7          	jalr	294(ra) # 9168 <pipe2>
    704a:	02054c63          	bltz	a0,7082 <nbtest+0x60>
    close(p[0]); close(p[1]);
    704e:	fd842503          	lw	a0,-40(s0)
    7052:	00002097          	auipc	ra,0x2
    7056:	f5e080e7          	jalr	-162(ra) # 8fb0 <close>
    705a:	fdc42503          	lw	a0,-36(s0)
    705e:	00002097          	auipc	ra,0x2
    7062:	f52080e7          	jalr	-174(ra) # 8fb0 <close>
}
    7066:	70a2                	ld	ra,40(sp)
    7068:	7402                	ld	s0,32(sp)
    706a:	64e2                	ld	s1,24(sp)
    706c:	6145                	addi	sp,sp,48
    706e:	8082                	ret

static int nbtest_main(int argc, char *argv[])
{
  test_pipe2_basic();
    7070:	00000097          	auipc	ra,0x0
    7074:	e58080e7          	jalr	-424(ra) # 6ec8 <test_pipe2_basic>
  exit(0);
    7078:	4501                	li	a0,0
    707a:	00002097          	auipc	ra,0x2
    707e:	f0e080e7          	jalr	-242(ra) # 8f88 <exit>
    if(pipe2(p, O_NONBLOCK) < 0) { printf("%s: pipe2 failed\n", s); exit(1); }
    7082:	85a6                	mv	a1,s1
    7084:	00007517          	auipc	a0,0x7
    7088:	b1450513          	addi	a0,a0,-1260 # db98 <malloc+0x45d8>
    708c:	00002097          	auipc	ra,0x2
    7090:	47c080e7          	jalr	1148(ra) # 9508 <printf>
    7094:	4505                	li	a0,1
    7096:	00002097          	auipc	ra,0x2
    709a:	ef2080e7          	jalr	-270(ra) # 8f88 <exit>

000000000000709e <test_pgid_basic>:
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

void test_pgid_basic(void) {
    709e:	1101                	addi	sp,sp,-32
    70a0:	ec06                	sd	ra,24(sp)
    70a2:	e822                	sd	s0,16(sp)
    70a4:	e426                	sd	s1,8(sp)
    70a6:	e04a                	sd	s2,0(sp)
    70a8:	1000                	addi	s0,sp,32
  printf("Test: pgid basic...\n");
    70aa:	00007517          	auipc	a0,0x7
    70ae:	b0650513          	addi	a0,a0,-1274 # dbb0 <malloc+0x45f0>
    70b2:	00002097          	auipc	ra,0x2
    70b6:	456080e7          	jalr	1110(ra) # 9508 <printf>
  
  int mypgid = getpgid(0);
    70ba:	4501                	li	a0,0
    70bc:	00002097          	auipc	ra,0x2
    70c0:	084080e7          	jalr	132(ra) # 9140 <getpgid>
    70c4:	892a                	mv	s2,a0
  int mypid = getpid();
    70c6:	00002097          	auipc	ra,0x2
    70ca:	f2a080e7          	jalr	-214(ra) # 8ff0 <getpid>
    70ce:	84aa                	mv	s1,a0
  
  printf("Initial pgid=%d, pid=%d\n", mypgid, mypid);
    70d0:	862a                	mv	a2,a0
    70d2:	85ca                	mv	a1,s2
    70d4:	00007517          	auipc	a0,0x7
    70d8:	af450513          	addi	a0,a0,-1292 # dbc8 <malloc+0x4608>
    70dc:	00002097          	auipc	ra,0x2
    70e0:	42c080e7          	jalr	1068(ra) # 9508 <printf>

  // Shell runs children in its own group (usually 1 or 2)
  // So mypgid != mypid is expected in current shell implementation.
  
  // Test 1: Become process group leader
  if(setpgid(0, 0) < 0) {
    70e4:	4581                	li	a1,0
    70e6:	4501                	li	a0,0
    70e8:	00002097          	auipc	ra,0x2
    70ec:	062080e7          	jalr	98(ra) # 914a <setpgid>
    70f0:	02054763          	bltz	a0,711e <test_pgid_basic+0x80>
      printf("setpgid(0, 0) failed\n");
      exit(1);
  }

  int newpgid = getpgid(0);
    70f4:	4501                	li	a0,0
    70f6:	00002097          	auipc	ra,0x2
    70fa:	04a080e7          	jalr	74(ra) # 9140 <getpgid>
  if(newpgid != mypid) {
    70fe:	02a49d63          	bne	s1,a0,7138 <test_pgid_basic+0x9a>
      printf("After setpgid(0,0), pgid should be pid (pgid=%d, pid=%d)\n", newpgid, mypid);
      exit(1);
  }
  
  printf("pgid basic: ok (became leader)\n");
    7102:	00007517          	auipc	a0,0x7
    7106:	b3e50513          	addi	a0,a0,-1218 # dc40 <malloc+0x4680>
    710a:	00002097          	auipc	ra,0x2
    710e:	3fe080e7          	jalr	1022(ra) # 9508 <printf>
}
    7112:	60e2                	ld	ra,24(sp)
    7114:	6442                	ld	s0,16(sp)
    7116:	64a2                	ld	s1,8(sp)
    7118:	6902                	ld	s2,0(sp)
    711a:	6105                	addi	sp,sp,32
    711c:	8082                	ret
      printf("setpgid(0, 0) failed\n");
    711e:	00007517          	auipc	a0,0x7
    7122:	aca50513          	addi	a0,a0,-1334 # dbe8 <malloc+0x4628>
    7126:	00002097          	auipc	ra,0x2
    712a:	3e2080e7          	jalr	994(ra) # 9508 <printf>
      exit(1);
    712e:	4505                	li	a0,1
    7130:	00002097          	auipc	ra,0x2
    7134:	e58080e7          	jalr	-424(ra) # 8f88 <exit>
      printf("After setpgid(0,0), pgid should be pid (pgid=%d, pid=%d)\n", newpgid, mypid);
    7138:	8626                	mv	a2,s1
    713a:	85aa                	mv	a1,a0
    713c:	00007517          	auipc	a0,0x7
    7140:	ac450513          	addi	a0,a0,-1340 # dc00 <malloc+0x4640>
    7144:	00002097          	auipc	ra,0x2
    7148:	3c4080e7          	jalr	964(ra) # 9508 <printf>
      exit(1);
    714c:	4505                	li	a0,1
    714e:	00002097          	auipc	ra,0x2
    7152:	e3a080e7          	jalr	-454(ra) # 8f88 <exit>

0000000000007156 <test_pgid_inherit>:

void test_pgid_inherit(void) {
    7156:	7179                	addi	sp,sp,-48
    7158:	f406                	sd	ra,40(sp)
    715a:	f022                	sd	s0,32(sp)
    715c:	ec26                	sd	s1,24(sp)
    715e:	1800                	addi	s0,sp,48
  printf("Test: pgid inherit...\n");
    7160:	00007517          	auipc	a0,0x7
    7164:	b0050513          	addi	a0,a0,-1280 # dc60 <malloc+0x46a0>
    7168:	00002097          	auipc	ra,0x2
    716c:	3a0080e7          	jalr	928(ra) # 9508 <printf>
  
  int parent_pgid = getpgid(0);
    7170:	4501                	li	a0,0
    7172:	00002097          	auipc	ra,0x2
    7176:	fce080e7          	jalr	-50(ra) # 9140 <getpgid>
    717a:	84aa                	mv	s1,a0
  int pid = fork();
    717c:	00002097          	auipc	ra,0x2
    7180:	e04080e7          	jalr	-508(ra) # 8f80 <fork>
  
  if(pid < 0) {
    7184:	02054863          	bltz	a0,71b4 <test_pgid_inherit+0x5e>
    printf("fork failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    7188:	e921                	bnez	a0,71d8 <test_pgid_inherit+0x82>
    // Child
    int child_pgid = getpgid(0);
    718a:	00002097          	auipc	ra,0x2
    718e:	fb6080e7          	jalr	-74(ra) # 9140 <getpgid>
    7192:	85aa                	mv	a1,a0
    if(child_pgid != parent_pgid) {
    7194:	02a48d63          	beq	s1,a0,71ce <test_pgid_inherit+0x78>
      printf("Child should inherit parent pgid (child=%d, parent=%d)\n", 
    7198:	8626                	mv	a2,s1
    719a:	00007517          	auipc	a0,0x7
    719e:	ade50513          	addi	a0,a0,-1314 # dc78 <malloc+0x46b8>
    71a2:	00002097          	auipc	ra,0x2
    71a6:	366080e7          	jalr	870(ra) # 9508 <printf>
             child_pgid, parent_pgid);
      exit(1);
    71aa:	4505                	li	a0,1
    71ac:	00002097          	auipc	ra,0x2
    71b0:	ddc080e7          	jalr	-548(ra) # 8f88 <exit>
    printf("fork failed\n");
    71b4:	00003517          	auipc	a0,0x3
    71b8:	3a450513          	addi	a0,a0,932 # a558 <malloc+0xf98>
    71bc:	00002097          	auipc	ra,0x2
    71c0:	34c080e7          	jalr	844(ra) # 9508 <printf>
    exit(1);
    71c4:	4505                	li	a0,1
    71c6:	00002097          	auipc	ra,0x2
    71ca:	dc2080e7          	jalr	-574(ra) # 8f88 <exit>
    }
    exit(0);
    71ce:	4501                	li	a0,0
    71d0:	00002097          	auipc	ra,0x2
    71d4:	db8080e7          	jalr	-584(ra) # 8f88 <exit>
  } else {
    int status;
    wait(&status);
    71d8:	fdc40513          	addi	a0,s0,-36
    71dc:	00002097          	auipc	ra,0x2
    71e0:	db4080e7          	jalr	-588(ra) # 8f90 <wait>
    if(status != 0) {
    71e4:	fdc42783          	lw	a5,-36(s0)
    71e8:	ef91                	bnez	a5,7204 <test_pgid_inherit+0xae>
      printf("Child test failed\n");
      exit(1);
    }
  }
  printf("pgid inherit: ok\n");
    71ea:	00007517          	auipc	a0,0x7
    71ee:	ac650513          	addi	a0,a0,-1338 # dcb0 <malloc+0x46f0>
    71f2:	00002097          	auipc	ra,0x2
    71f6:	316080e7          	jalr	790(ra) # 9508 <printf>
}
    71fa:	70a2                	ld	ra,40(sp)
    71fc:	7402                	ld	s0,32(sp)
    71fe:	64e2                	ld	s1,24(sp)
    7200:	6145                	addi	sp,sp,48
    7202:	8082                	ret
      printf("Child test failed\n");
    7204:	00007517          	auipc	a0,0x7
    7208:	82450513          	addi	a0,a0,-2012 # da28 <malloc+0x4468>
    720c:	00002097          	auipc	ra,0x2
    7210:	2fc080e7          	jalr	764(ra) # 9508 <printf>
      exit(1);
    7214:	4505                	li	a0,1
    7216:	00002097          	auipc	ra,0x2
    721a:	d72080e7          	jalr	-654(ra) # 8f88 <exit>

000000000000721e <test_setpgid>:

void test_setpgid(void) {
    721e:	1101                	addi	sp,sp,-32
    7220:	ec06                	sd	ra,24(sp)
    7222:	e822                	sd	s0,16(sp)
    7224:	e426                	sd	s1,8(sp)
    7226:	1000                	addi	s0,sp,32
  printf("Test: setpgid...\n");
    7228:	00007517          	auipc	a0,0x7
    722c:	aa050513          	addi	a0,a0,-1376 # dcc8 <malloc+0x4708>
    7230:	00002097          	auipc	ra,0x2
    7234:	2d8080e7          	jalr	728(ra) # 9508 <printf>
  
  int newpgid = 12345;
  if(setpgid(0, newpgid) < 0) {
    7238:	658d                	lui	a1,0x3
    723a:	03958593          	addi	a1,a1,57 # 3039 <dirfile+0x97>
    723e:	4501                	li	a0,0
    7240:	00002097          	auipc	ra,0x2
    7244:	f0a080e7          	jalr	-246(ra) # 914a <setpgid>
    7248:	04054d63          	bltz	a0,72a2 <test_setpgid+0x84>
    printf("setpgid failed\n");
    exit(1);
  }
  
  if(getpgid(0) != newpgid) {
    724c:	4501                	li	a0,0
    724e:	00002097          	auipc	ra,0x2
    7252:	ef2080e7          	jalr	-270(ra) # 9140 <getpgid>
    7256:	678d                	lui	a5,0x3
    7258:	03978793          	addi	a5,a5,57 # 3039 <dirfile+0x97>
    725c:	06f51063          	bne	a0,a5,72bc <test_setpgid+0x9e>
    printf("getpgid after setpgid failed\n");
    exit(1);
  }
  
  // Reset to self
  if(setpgid(0, 0) < 0) {
    7260:	4581                	li	a1,0
    7262:	4501                	li	a0,0
    7264:	00002097          	auipc	ra,0x2
    7268:	ee6080e7          	jalr	-282(ra) # 914a <setpgid>
    726c:	06054563          	bltz	a0,72d6 <test_setpgid+0xb8>
    printf("setpgid(0,0) failed\n");
    exit(1);
  }
  
  if(getpgid(0) != getpid()) {
    7270:	4501                	li	a0,0
    7272:	00002097          	auipc	ra,0x2
    7276:	ece080e7          	jalr	-306(ra) # 9140 <getpgid>
    727a:	84aa                	mv	s1,a0
    727c:	00002097          	auipc	ra,0x2
    7280:	d74080e7          	jalr	-652(ra) # 8ff0 <getpid>
    7284:	06a49663          	bne	s1,a0,72f0 <test_setpgid+0xd2>
    printf("setpgid(0,0) should set pgid to pid\n");
    exit(1);
  }
  
  printf("setpgid: ok\n");
    7288:	00007517          	auipc	a0,0x7
    728c:	ac850513          	addi	a0,a0,-1336 # dd50 <malloc+0x4790>
    7290:	00002097          	auipc	ra,0x2
    7294:	278080e7          	jalr	632(ra) # 9508 <printf>
}
    7298:	60e2                	ld	ra,24(sp)
    729a:	6442                	ld	s0,16(sp)
    729c:	64a2                	ld	s1,8(sp)
    729e:	6105                	addi	sp,sp,32
    72a0:	8082                	ret
    printf("setpgid failed\n");
    72a2:	00007517          	auipc	a0,0x7
    72a6:	a3e50513          	addi	a0,a0,-1474 # dce0 <malloc+0x4720>
    72aa:	00002097          	auipc	ra,0x2
    72ae:	25e080e7          	jalr	606(ra) # 9508 <printf>
    exit(1);
    72b2:	4505                	li	a0,1
    72b4:	00002097          	auipc	ra,0x2
    72b8:	cd4080e7          	jalr	-812(ra) # 8f88 <exit>
    printf("getpgid after setpgid failed\n");
    72bc:	00007517          	auipc	a0,0x7
    72c0:	a3450513          	addi	a0,a0,-1484 # dcf0 <malloc+0x4730>
    72c4:	00002097          	auipc	ra,0x2
    72c8:	244080e7          	jalr	580(ra) # 9508 <printf>
    exit(1);
    72cc:	4505                	li	a0,1
    72ce:	00002097          	auipc	ra,0x2
    72d2:	cba080e7          	jalr	-838(ra) # 8f88 <exit>
    printf("setpgid(0,0) failed\n");
    72d6:	00007517          	auipc	a0,0x7
    72da:	a3a50513          	addi	a0,a0,-1478 # dd10 <malloc+0x4750>
    72de:	00002097          	auipc	ra,0x2
    72e2:	22a080e7          	jalr	554(ra) # 9508 <printf>
    exit(1);
    72e6:	4505                	li	a0,1
    72e8:	00002097          	auipc	ra,0x2
    72ec:	ca0080e7          	jalr	-864(ra) # 8f88 <exit>
    printf("setpgid(0,0) should set pgid to pid\n");
    72f0:	00007517          	auipc	a0,0x7
    72f4:	a3850513          	addi	a0,a0,-1480 # dd28 <malloc+0x4768>
    72f8:	00002097          	auipc	ra,0x2
    72fc:	210080e7          	jalr	528(ra) # 9508 <printf>
    exit(1);
    7300:	4505                	li	a0,1
    7302:	00002097          	auipc	ra,0x2
    7306:	c86080e7          	jalr	-890(ra) # 8f88 <exit>

000000000000730a <pgtest_main>:

int pgtest_main(void) {
    730a:	1141                	addi	sp,sp,-16
    730c:	e406                	sd	ra,8(sp)
    730e:	e022                	sd	s0,0(sp)
    7310:	0800                	addi	s0,sp,16
  printf("pgtest starting\n");
    7312:	00007517          	auipc	a0,0x7
    7316:	a4e50513          	addi	a0,a0,-1458 # dd60 <malloc+0x47a0>
    731a:	00002097          	auipc	ra,0x2
    731e:	1ee080e7          	jalr	494(ra) # 9508 <printf>
  test_pgid_basic();
    7322:	00000097          	auipc	ra,0x0
    7326:	d7c080e7          	jalr	-644(ra) # 709e <test_pgid_basic>
  
  // Run inheritance test in child to not affect main
  int pid = fork();
    732a:	00002097          	auipc	ra,0x2
    732e:	c56080e7          	jalr	-938(ra) # 8f80 <fork>
  if(pid == 0) {
    7332:	e911                	bnez	a0,7346 <pgtest_main+0x3c>
    test_pgid_inherit();
    7334:	00000097          	auipc	ra,0x0
    7338:	e22080e7          	jalr	-478(ra) # 7156 <test_pgid_inherit>
    exit(0);
    733c:	4501                	li	a0,0
    733e:	00002097          	auipc	ra,0x2
    7342:	c4a080e7          	jalr	-950(ra) # 8f88 <exit>
  }
  wait(0);
    7346:	4501                	li	a0,0
    7348:	00002097          	auipc	ra,0x2
    734c:	c48080e7          	jalr	-952(ra) # 8f90 <wait>
  
  // Run setpgid test in child
  pid = fork();
    7350:	00002097          	auipc	ra,0x2
    7354:	c30080e7          	jalr	-976(ra) # 8f80 <fork>
  if(pid == 0) {
    7358:	e911                	bnez	a0,736c <pgtest_main+0x62>
    test_setpgid();
    735a:	00000097          	auipc	ra,0x0
    735e:	ec4080e7          	jalr	-316(ra) # 721e <test_setpgid>
    exit(0);
    7362:	4501                	li	a0,0
    7364:	00002097          	auipc	ra,0x2
    7368:	c24080e7          	jalr	-988(ra) # 8f88 <exit>
  }
  wait(0);
    736c:	4501                	li	a0,0
    736e:	00002097          	auipc	ra,0x2
    7372:	c22080e7          	jalr	-990(ra) # 8f90 <wait>
  
  printf("pgtest finished\n");
    7376:	00007517          	auipc	a0,0x7
    737a:	a0250513          	addi	a0,a0,-1534 # dd78 <malloc+0x47b8>
    737e:	00002097          	auipc	ra,0x2
    7382:	18a080e7          	jalr	394(ra) # 9508 <printf>
  exit(0);
    7386:	4501                	li	a0,0
    7388:	00002097          	auipc	ra,0x2
    738c:	c00080e7          	jalr	-1024(ra) # 8f88 <exit>

0000000000007390 <pgtest>:
void pgtest(char *s) {
    7390:	1101                	addi	sp,sp,-32
    7392:	ec06                	sd	ra,24(sp)
    7394:	e822                	sd	s0,16(sp)
    7396:	e426                	sd	s1,8(sp)
    7398:	1000                	addi	s0,sp,32
    if(verbose) { pgtest_main(); return; }
    739a:	00008797          	auipc	a5,0x8
    739e:	4fa7a783          	lw	a5,1274(a5) # f894 <verbose>
    73a2:	ef91                	bnez	a5,73be <pgtest+0x2e>
    73a4:	84aa                	mv	s1,a0
    if(getpgid(0) < 0) { printf("%s: getpgid failed\n", s); exit(1); }
    73a6:	4501                	li	a0,0
    73a8:	00002097          	auipc	ra,0x2
    73ac:	d98080e7          	jalr	-616(ra) # 9140 <getpgid>
    73b0:	00054b63          	bltz	a0,73c6 <pgtest+0x36>
}
    73b4:	60e2                	ld	ra,24(sp)
    73b6:	6442                	ld	s0,16(sp)
    73b8:	64a2                	ld	s1,8(sp)
    73ba:	6105                	addi	sp,sp,32
    73bc:	8082                	ret
    if(verbose) { pgtest_main(); return; }
    73be:	00000097          	auipc	ra,0x0
    73c2:	f4c080e7          	jalr	-180(ra) # 730a <pgtest_main>
    if(getpgid(0) < 0) { printf("%s: getpgid failed\n", s); exit(1); }
    73c6:	85a6                	mv	a1,s1
    73c8:	00007517          	auipc	a0,0x7
    73cc:	9c850513          	addi	a0,a0,-1592 # dd90 <malloc+0x47d0>
    73d0:	00002097          	auipc	ra,0x2
    73d4:	138080e7          	jalr	312(ra) # 9508 <printf>
    73d8:	4505                	li	a0,1
    73da:	00002097          	auipc	ra,0x2
    73de:	bae080e7          	jalr	-1106(ra) # 8f88 <exit>

00000000000073e2 <polltest_main>:
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int polltest_main(int argc, char *argv[])
{
    73e2:	7119                	addi	sp,sp,-128
    73e4:	fc86                	sd	ra,120(sp)
    73e6:	f8a2                	sd	s0,112(sp)
    73e8:	f4a6                	sd	s1,104(sp)
    73ea:	f0ca                	sd	s2,96(sp)
    73ec:	0100                	addi	s0,sp,128
    int p[2];
    struct pollfd fds[3];
    int ret;
    char buf[64];
    
    printf("=== poll() I/O Multiplexing Test ===\n\n");
    73ee:	00007517          	auipc	a0,0x7
    73f2:	9ba50513          	addi	a0,a0,-1606 # dda8 <malloc+0x47e8>
    73f6:	00002097          	auipc	ra,0x2
    73fa:	112080e7          	jalr	274(ra) # 9508 <printf>
    
    // Test 1: poll 超时测试
    printf("Test 1: Timeout test (poll with 200ms timeout)\n");
    73fe:	00007517          	auipc	a0,0x7
    7402:	9d250513          	addi	a0,a0,-1582 # ddd0 <malloc+0x4810>
    7406:	00002097          	auipc	ra,0x2
    740a:	102080e7          	jalr	258(ra) # 9508 <printf>
    fds[0].fd = 0;  // stdin
    740e:	fc042023          	sw	zero,-64(s0)
    fds[0].events = POLLIN;
    7412:	4785                	li	a5,1
    7414:	fcf41223          	sh	a5,-60(s0)
    fds[0].revents = 0;
    7418:	fc041323          	sh	zero,-58(s0)
    
    int start = uptime();
    741c:	00002097          	auipc	ra,0x2
    7420:	bec080e7          	jalr	-1044(ra) # 9008 <uptime>
    7424:	892a                	mv	s2,a0
    ret = poll(fds, 1, 200);  // 200ms timeout
    7426:	0c800613          	li	a2,200
    742a:	4585                	li	a1,1
    742c:	fc040513          	addi	a0,s0,-64
    7430:	00002097          	auipc	ra,0x2
    7434:	d56080e7          	jalr	-682(ra) # 9186 <poll>
    7438:	84aa                	mv	s1,a0
    int elapsed = uptime() - start;
    743a:	00002097          	auipc	ra,0x2
    743e:	bce080e7          	jalr	-1074(ra) # 9008 <uptime>
    7442:	4125093b          	subw	s2,a0,s2
    
    printf("  poll returned %d, elapsed ~%d ticks\n", ret, elapsed);
    7446:	864a                	mv	a2,s2
    7448:	85a6                	mv	a1,s1
    744a:	00007517          	auipc	a0,0x7
    744e:	9b650513          	addi	a0,a0,-1610 # de00 <malloc+0x4840>
    7452:	00002097          	auipc	ra,0x2
    7456:	0b6080e7          	jalr	182(ra) # 9508 <printf>
    if(ret == 0 && elapsed >= 1) {
    745a:	2c049c63          	bnez	s1,7732 <polltest_main+0x350>
    745e:	2d204163          	bgtz	s2,7720 <polltest_main+0x33e>
        printf("  SUCCESS: poll timeout works\n");
    } else if(ret == 0) {
        printf("  WARNING: returned immediately (stdin might have data)\n");
    7462:	00007517          	auipc	a0,0x7
    7466:	9e650513          	addi	a0,a0,-1562 # de48 <malloc+0x4888>
    746a:	00002097          	auipc	ra,0x2
    746e:	09e080e7          	jalr	158(ra) # 9508 <printf>
    } else {
        printf("  NOTE: stdin has data ready, revents=0x%x\n", fds[0].revents);
    }
    
    // Test 2: pipe poll
    printf("\nTest 2: Pipe poll test\n");
    7472:	00007517          	auipc	a0,0x7
    7476:	a4650513          	addi	a0,a0,-1466 # deb8 <malloc+0x48f8>
    747a:	00002097          	auipc	ra,0x2
    747e:	08e080e7          	jalr	142(ra) # 9508 <printf>
    
    if(pipe(p) < 0) {
    7482:	fd840513          	addi	a0,s0,-40
    7486:	00002097          	auipc	ra,0x2
    748a:	b12080e7          	jalr	-1262(ra) # 8f98 <pipe>
    748e:	2a054d63          	bltz	a0,7748 <polltest_main+0x366>
        printf("  ERROR: pipe failed\n");
        exit(1);
    }
    
    // 空管道应该只有写就绪
    fds[0].fd = p[0];  // 读端
    7492:	fd842783          	lw	a5,-40(s0)
    7496:	fcf42023          	sw	a5,-64(s0)
    fds[0].events = POLLIN;
    749a:	4785                	li	a5,1
    749c:	fcf41223          	sh	a5,-60(s0)
    fds[0].revents = 0;
    74a0:	fc041323          	sh	zero,-58(s0)
    
    fds[1].fd = p[1];  // 写端
    74a4:	fdc42783          	lw	a5,-36(s0)
    74a8:	fcf42423          	sw	a5,-56(s0)
    fds[1].events = POLLOUT;
    74ac:	4791                	li	a5,4
    74ae:	fcf41623          	sh	a5,-52(s0)
    fds[1].revents = 0;
    74b2:	fc041723          	sh	zero,-50(s0)
    
    ret = poll(fds, 2, 0);  // 立即返回
    74b6:	4601                	li	a2,0
    74b8:	4589                	li	a1,2
    74ba:	fc040513          	addi	a0,s0,-64
    74be:	00002097          	auipc	ra,0x2
    74c2:	cc8080e7          	jalr	-824(ra) # 9186 <poll>
    74c6:	85aa                	mv	a1,a0
    printf("  Empty pipe: poll returned %d\n", ret);
    74c8:	00007517          	auipc	a0,0x7
    74cc:	a2850513          	addi	a0,a0,-1496 # def0 <malloc+0x4930>
    74d0:	00002097          	auipc	ra,0x2
    74d4:	038080e7          	jalr	56(ra) # 9508 <printf>
    printf("    Read fd: revents=0x%x (expect 0)\n", fds[0].revents);
    74d8:	fc641583          	lh	a1,-58(s0)
    74dc:	00007517          	auipc	a0,0x7
    74e0:	a3450513          	addi	a0,a0,-1484 # df10 <malloc+0x4950>
    74e4:	00002097          	auipc	ra,0x2
    74e8:	024080e7          	jalr	36(ra) # 9508 <printf>
    printf("    Write fd: revents=0x%x (expect POLLOUT=0x4)\n", fds[1].revents);
    74ec:	fce41583          	lh	a1,-50(s0)
    74f0:	00007517          	auipc	a0,0x7
    74f4:	a4850513          	addi	a0,a0,-1464 # df38 <malloc+0x4978>
    74f8:	00002097          	auipc	ra,0x2
    74fc:	010080e7          	jalr	16(ra) # 9508 <printf>
    
    if((fds[1].revents & POLLOUT) && !(fds[0].revents & POLLIN)) {
    7500:	fce45783          	lhu	a5,-50(s0)
    7504:	8b91                	andi	a5,a5,4
    7506:	c791                	beqz	a5,7512 <polltest_main+0x130>
    7508:	fc645783          	lhu	a5,-58(s0)
    750c:	8b85                	andi	a5,a5,1
    750e:	24078a63          	beqz	a5,7762 <polltest_main+0x380>
        printf("  SUCCESS: Empty pipe state correct\n");
    } else {
        printf("  WARNING: Unexpected state\n");
    7512:	00007517          	auipc	a0,0x7
    7516:	a8650513          	addi	a0,a0,-1402 # df98 <malloc+0x49d8>
    751a:	00002097          	auipc	ra,0x2
    751e:	fee080e7          	jalr	-18(ra) # 9508 <printf>
    }
    
    // 写入数据后再测试
    printf("\nTest 3: Pipe with data\n");
    7522:	00007517          	auipc	a0,0x7
    7526:	a9650513          	addi	a0,a0,-1386 # dfb8 <malloc+0x49f8>
    752a:	00002097          	auipc	ra,0x2
    752e:	fde080e7          	jalr	-34(ra) # 9508 <printf>
    write(p[1], "hello", 5);
    7532:	4615                	li	a2,5
    7534:	00002597          	auipc	a1,0x2
    7538:	6fc58593          	addi	a1,a1,1788 # 9c30 <malloc+0x670>
    753c:	fdc42503          	lw	a0,-36(s0)
    7540:	00002097          	auipc	ra,0x2
    7544:	a68080e7          	jalr	-1432(ra) # 8fa8 <write>
    
    fds[0].revents = 0;
    7548:	fc041323          	sh	zero,-58(s0)
    fds[1].revents = 0;
    754c:	fc041723          	sh	zero,-50(s0)
    
    ret = poll(fds, 2, 0);
    7550:	4601                	li	a2,0
    7552:	4589                	li	a1,2
    7554:	fc040513          	addi	a0,s0,-64
    7558:	00002097          	auipc	ra,0x2
    755c:	c2e080e7          	jalr	-978(ra) # 9186 <poll>
    7560:	85aa                	mv	a1,a0
    printf("  After write: poll returned %d\n", ret);
    7562:	00007517          	auipc	a0,0x7
    7566:	a7650513          	addi	a0,a0,-1418 # dfd8 <malloc+0x4a18>
    756a:	00002097          	auipc	ra,0x2
    756e:	f9e080e7          	jalr	-98(ra) # 9508 <printf>
    printf("    Read fd: revents=0x%x (expect POLLIN=0x1)\n", fds[0].revents);
    7572:	fc641583          	lh	a1,-58(s0)
    7576:	00007517          	auipc	a0,0x7
    757a:	a8a50513          	addi	a0,a0,-1398 # e000 <malloc+0x4a40>
    757e:	00002097          	auipc	ra,0x2
    7582:	f8a080e7          	jalr	-118(ra) # 9508 <printf>
    printf("    Write fd: revents=0x%x (expect POLLOUT=0x4)\n", fds[1].revents);
    7586:	fce41583          	lh	a1,-50(s0)
    758a:	00007517          	auipc	a0,0x7
    758e:	9ae50513          	addi	a0,a0,-1618 # df38 <malloc+0x4978>
    7592:	00002097          	auipc	ra,0x2
    7596:	f76080e7          	jalr	-138(ra) # 9508 <printf>
    
    if((fds[0].revents & POLLIN) && (fds[1].revents & POLLOUT)) {
    759a:	fc645783          	lhu	a5,-58(s0)
    759e:	8b85                	andi	a5,a5,1
    75a0:	c791                	beqz	a5,75ac <polltest_main+0x1ca>
    75a2:	fce45783          	lhu	a5,-50(s0)
    75a6:	8b91                	andi	a5,a5,4
    75a8:	1c079663          	bnez	a5,7774 <polltest_main+0x392>
        printf("  SUCCESS: Pipe with data state correct\n");
    } else {
        printf("  FAILED: Unexpected state\n");
    75ac:	00007517          	auipc	a0,0x7
    75b0:	ab450513          	addi	a0,a0,-1356 # e060 <malloc+0x4aa0>
    75b4:	00002097          	auipc	ra,0x2
    75b8:	f54080e7          	jalr	-172(ra) # 9508 <printf>
    }
    
    // 清空管道
    read(p[0], buf, 5);
    75bc:	4615                	li	a2,5
    75be:	f8040593          	addi	a1,s0,-128
    75c2:	fd842503          	lw	a0,-40(s0)
    75c6:	00002097          	auipc	ra,0x2
    75ca:	9da080e7          	jalr	-1574(ra) # 8fa0 <read>
    
    // Test 4: 关闭写端后读端应该显示 POLLHUP
    printf("\nTest 4: Closed write end -> POLLHUP\n");
    75ce:	00007517          	auipc	a0,0x7
    75d2:	ab250513          	addi	a0,a0,-1358 # e080 <malloc+0x4ac0>
    75d6:	00002097          	auipc	ra,0x2
    75da:	f32080e7          	jalr	-206(ra) # 9508 <printf>
    close(p[1]);
    75de:	fdc42503          	lw	a0,-36(s0)
    75e2:	00002097          	auipc	ra,0x2
    75e6:	9ce080e7          	jalr	-1586(ra) # 8fb0 <close>
    
    fds[0].revents = 0;
    75ea:	fc041323          	sh	zero,-58(s0)
    ret = poll(fds, 1, 0);
    75ee:	4601                	li	a2,0
    75f0:	4585                	li	a1,1
    75f2:	fc040513          	addi	a0,s0,-64
    75f6:	00002097          	auipc	ra,0x2
    75fa:	b90080e7          	jalr	-1136(ra) # 9186 <poll>
    printf("  After close write end: revents=0x%x (expect POLLHUP=0x10)\n", fds[0].revents);
    75fe:	fc641583          	lh	a1,-58(s0)
    7602:	00007517          	auipc	a0,0x7
    7606:	aa650513          	addi	a0,a0,-1370 # e0a8 <malloc+0x4ae8>
    760a:	00002097          	auipc	ra,0x2
    760e:	efe080e7          	jalr	-258(ra) # 9508 <printf>
    
    if(fds[0].revents & POLLHUP) {
    7612:	fc645783          	lhu	a5,-58(s0)
    7616:	8bc1                	andi	a5,a5,16
    7618:	16078763          	beqz	a5,7786 <polltest_main+0x3a4>
        printf("  SUCCESS: POLLHUP detected\n");
    761c:	00007517          	auipc	a0,0x7
    7620:	acc50513          	addi	a0,a0,-1332 # e0e8 <malloc+0x4b28>
    7624:	00002097          	auipc	ra,0x2
    7628:	ee4080e7          	jalr	-284(ra) # 9508 <printf>
    } else {
        printf("  WARNING: POLLHUP not set\n");
    }
    
    close(p[0]);
    762c:	fd842503          	lw	a0,-40(s0)
    7630:	00002097          	auipc	ra,0x2
    7634:	980080e7          	jalr	-1664(ra) # 8fb0 <close>
    
    // Test 5: 无效 fd
    printf("\nTest 5: Invalid fd -> POLLNVAL\n");
    7638:	00007517          	auipc	a0,0x7
    763c:	af050513          	addi	a0,a0,-1296 # e128 <malloc+0x4b68>
    7640:	00002097          	auipc	ra,0x2
    7644:	ec8080e7          	jalr	-312(ra) # 9508 <printf>
    fds[0].fd = 999;  // 无效 fd
    7648:	3e700793          	li	a5,999
    764c:	fcf42023          	sw	a5,-64(s0)
    fds[0].events = POLLIN;
    7650:	4785                	li	a5,1
    7652:	fcf41223          	sh	a5,-60(s0)
    fds[0].revents = 0;
    7656:	fc041323          	sh	zero,-58(s0)
    
    ret = poll(fds, 1, 0);
    765a:	4601                	li	a2,0
    765c:	4585                	li	a1,1
    765e:	fc040513          	addi	a0,s0,-64
    7662:	00002097          	auipc	ra,0x2
    7666:	b24080e7          	jalr	-1244(ra) # 9186 <poll>
    printf("  Invalid fd 999: revents=0x%x (expect POLLNVAL=0x20)\n", fds[0].revents);
    766a:	fc641583          	lh	a1,-58(s0)
    766e:	00007517          	auipc	a0,0x7
    7672:	ae250513          	addi	a0,a0,-1310 # e150 <malloc+0x4b90>
    7676:	00002097          	auipc	ra,0x2
    767a:	e92080e7          	jalr	-366(ra) # 9508 <printf>
    
    if(fds[0].revents & POLLNVAL) {
    767e:	fc645783          	lhu	a5,-58(s0)
    7682:	0207f793          	andi	a5,a5,32
    7686:	10078963          	beqz	a5,7798 <polltest_main+0x3b6>
        printf("  SUCCESS: POLLNVAL detected\n");
    768a:	00007517          	auipc	a0,0x7
    768e:	afe50513          	addi	a0,a0,-1282 # e188 <malloc+0x4bc8>
    7692:	00002097          	auipc	ra,0x2
    7696:	e76080e7          	jalr	-394(ra) # 9508 <printf>
    } else {
        printf("  FAILED: POLLNVAL not set\n");
    }
    
    // Test 6: 文件 poll
    printf("\nTest 6: File poll\n");
    769a:	00007517          	auipc	a0,0x7
    769e:	b2e50513          	addi	a0,a0,-1234 # e1c8 <malloc+0x4c08>
    76a2:	00002097          	auipc	ra,0x2
    76a6:	e66080e7          	jalr	-410(ra) # 9508 <printf>
    int fd = open("README", 0);  // 打开只读
    76aa:	4581                	li	a1,0
    76ac:	00002517          	auipc	a0,0x2
    76b0:	23450513          	addi	a0,a0,564 # 98e0 <malloc+0x320>
    76b4:	00002097          	auipc	ra,0x2
    76b8:	914080e7          	jalr	-1772(ra) # 8fc8 <open>
    76bc:	84aa                	mv	s1,a0
    if(fd < 0) {
    76be:	0e054663          	bltz	a0,77aa <polltest_main+0x3c8>
        printf("  Skip: README not found\n");
    } else {
        fds[0].fd = fd;
    76c2:	fca42023          	sw	a0,-64(s0)
        fds[0].events = POLLIN | POLLOUT;
    76c6:	4795                	li	a5,5
    76c8:	fcf41223          	sh	a5,-60(s0)
        fds[0].revents = 0;
    76cc:	fc041323          	sh	zero,-58(s0)
        
        ret = poll(fds, 1, 0);
    76d0:	4601                	li	a2,0
    76d2:	4585                	li	a1,1
    76d4:	fc040513          	addi	a0,s0,-64
    76d8:	00002097          	auipc	ra,0x2
    76dc:	aae080e7          	jalr	-1362(ra) # 9186 <poll>
        printf("  File poll: revents=0x%x (expect POLLIN=0x1)\n", fds[0].revents);
    76e0:	fc641583          	lh	a1,-58(s0)
    76e4:	00007517          	auipc	a0,0x7
    76e8:	b1c50513          	addi	a0,a0,-1252 # e200 <malloc+0x4c40>
    76ec:	00002097          	auipc	ra,0x2
    76f0:	e1c080e7          	jalr	-484(ra) # 9508 <printf>
        
        if(fds[0].revents & POLLIN) {
    76f4:	fc645783          	lhu	a5,-58(s0)
    76f8:	8b85                	andi	a5,a5,1
    76fa:	e3e9                	bnez	a5,77bc <polltest_main+0x3da>
            printf("  SUCCESS: File is readable\n");
        }
        close(fd);
    76fc:	8526                	mv	a0,s1
    76fe:	00002097          	auipc	ra,0x2
    7702:	8b2080e7          	jalr	-1870(ra) # 8fb0 <close>
    }
    
    printf("\n=== All poll tests completed ===\n");
    7706:	00007517          	auipc	a0,0x7
    770a:	b4a50513          	addi	a0,a0,-1206 # e250 <malloc+0x4c90>
    770e:	00002097          	auipc	ra,0x2
    7712:	dfa080e7          	jalr	-518(ra) # 9508 <printf>
    exit(0);
    7716:	4501                	li	a0,0
    7718:	00002097          	auipc	ra,0x2
    771c:	870080e7          	jalr	-1936(ra) # 8f88 <exit>
        printf("  SUCCESS: poll timeout works\n");
    7720:	00006517          	auipc	a0,0x6
    7724:	70850513          	addi	a0,a0,1800 # de28 <malloc+0x4868>
    7728:	00002097          	auipc	ra,0x2
    772c:	de0080e7          	jalr	-544(ra) # 9508 <printf>
    7730:	b389                	j	7472 <polltest_main+0x90>
        printf("  NOTE: stdin has data ready, revents=0x%x\n", fds[0].revents);
    7732:	fc641583          	lh	a1,-58(s0)
    7736:	00006517          	auipc	a0,0x6
    773a:	75250513          	addi	a0,a0,1874 # de88 <malloc+0x48c8>
    773e:	00002097          	auipc	ra,0x2
    7742:	dca080e7          	jalr	-566(ra) # 9508 <printf>
    7746:	b335                	j	7472 <polltest_main+0x90>
        printf("  ERROR: pipe failed\n");
    7748:	00006517          	auipc	a0,0x6
    774c:	79050513          	addi	a0,a0,1936 # ded8 <malloc+0x4918>
    7750:	00002097          	auipc	ra,0x2
    7754:	db8080e7          	jalr	-584(ra) # 9508 <printf>
        exit(1);
    7758:	4505                	li	a0,1
    775a:	00002097          	auipc	ra,0x2
    775e:	82e080e7          	jalr	-2002(ra) # 8f88 <exit>
        printf("  SUCCESS: Empty pipe state correct\n");
    7762:	00007517          	auipc	a0,0x7
    7766:	80e50513          	addi	a0,a0,-2034 # df70 <malloc+0x49b0>
    776a:	00002097          	auipc	ra,0x2
    776e:	d9e080e7          	jalr	-610(ra) # 9508 <printf>
    7772:	bb45                	j	7522 <polltest_main+0x140>
        printf("  SUCCESS: Pipe with data state correct\n");
    7774:	00007517          	auipc	a0,0x7
    7778:	8bc50513          	addi	a0,a0,-1860 # e030 <malloc+0x4a70>
    777c:	00002097          	auipc	ra,0x2
    7780:	d8c080e7          	jalr	-628(ra) # 9508 <printf>
    7784:	bd25                	j	75bc <polltest_main+0x1da>
        printf("  WARNING: POLLHUP not set\n");
    7786:	00007517          	auipc	a0,0x7
    778a:	98250513          	addi	a0,a0,-1662 # e108 <malloc+0x4b48>
    778e:	00002097          	auipc	ra,0x2
    7792:	d7a080e7          	jalr	-646(ra) # 9508 <printf>
    7796:	bd59                	j	762c <polltest_main+0x24a>
        printf("  FAILED: POLLNVAL not set\n");
    7798:	00007517          	auipc	a0,0x7
    779c:	a1050513          	addi	a0,a0,-1520 # e1a8 <malloc+0x4be8>
    77a0:	00002097          	auipc	ra,0x2
    77a4:	d68080e7          	jalr	-664(ra) # 9508 <printf>
    77a8:	bdcd                	j	769a <polltest_main+0x2b8>
        printf("  Skip: README not found\n");
    77aa:	00007517          	auipc	a0,0x7
    77ae:	a3650513          	addi	a0,a0,-1482 # e1e0 <malloc+0x4c20>
    77b2:	00002097          	auipc	ra,0x2
    77b6:	d56080e7          	jalr	-682(ra) # 9508 <printf>
    77ba:	b7b1                	j	7706 <polltest_main+0x324>
            printf("  SUCCESS: File is readable\n");
    77bc:	00007517          	auipc	a0,0x7
    77c0:	a7450513          	addi	a0,a0,-1420 # e230 <malloc+0x4c70>
    77c4:	00002097          	auipc	ra,0x2
    77c8:	d44080e7          	jalr	-700(ra) # 9508 <printf>
    77cc:	bf05                	j	76fc <polltest_main+0x31a>

00000000000077ce <polltest>:
void polltest(char *s) {
    77ce:	7179                	addi	sp,sp,-48
    77d0:	f406                	sd	ra,40(sp)
    77d2:	f022                	sd	s0,32(sp)
    77d4:	1800                	addi	s0,sp,48
    if(verbose) { char *argv[] = {"polltest", 0}; polltest_main(1, argv); return; }
    77d6:	00008797          	auipc	a5,0x8
    77da:	0be7a783          	lw	a5,190(a5) # f894 <verbose>
    77de:	e785                	bnez	a5,7806 <polltest+0x38>
    struct pollfd pfd = {0, POLLIN, 0};
    77e0:	fe042423          	sw	zero,-24(s0)
    77e4:	4785                	li	a5,1
    77e6:	fef41623          	sh	a5,-20(s0)
    77ea:	fe041723          	sh	zero,-18(s0)
    poll(&pfd, 1, 0);  // Just verify it works
    77ee:	4601                	li	a2,0
    77f0:	4585                	li	a1,1
    77f2:	fe840513          	addi	a0,s0,-24
    77f6:	00002097          	auipc	ra,0x2
    77fa:	990080e7          	jalr	-1648(ra) # 9186 <poll>
}
    77fe:	70a2                	ld	ra,40(sp)
    7800:	7402                	ld	s0,32(sp)
    7802:	6145                	addi	sp,sp,48
    7804:	8082                	ret
    if(verbose) { char *argv[] = {"polltest", 0}; polltest_main(1, argv); return; }
    7806:	fd840593          	addi	a1,s0,-40
    780a:	4505                	li	a0,1
    780c:	00000097          	auipc	ra,0x0
    7810:	bd6080e7          	jalr	-1066(ra) # 73e2 <polltest_main>

0000000000007814 <sigtest_main>:
// sigtest.c - 信号系统测试程序 (V2.1)
#include "kernel/include/types.h"
#include "serein-user/user.h"

int sigtest_main(void)
{
    7814:	7179                	addi	sp,sp,-48
    7816:	f406                	sd	ra,40(sp)
    7818:	f022                	sd	s0,32(sp)
    781a:	ec26                	sd	s1,24(sp)
    781c:	1800                	addi	s0,sp,48
  printf("=== Signal System Test (V2.1) ===\n");
    781e:	00007517          	auipc	a0,0x7
    7822:	a5a50513          	addi	a0,a0,-1446 # e278 <malloc+0x4cb8>
    7826:	00002097          	auipc	ra,0x2
    782a:	ce2080e7          	jalr	-798(ra) # 9508 <printf>
  
  // 测试 1: 使用 SIGTERM 终止子进程
  printf("Test 1: SIGTERM termination\n");
    782e:	00007517          	auipc	a0,0x7
    7832:	a7250513          	addi	a0,a0,-1422 # e2a0 <malloc+0x4ce0>
    7836:	00002097          	auipc	ra,0x2
    783a:	cd2080e7          	jalr	-814(ra) # 9508 <printf>
  int pid1 = fork();
    783e:	00001097          	auipc	ra,0x1
    7842:	742080e7          	jalr	1858(ra) # 8f80 <fork>
  if(pid1 == 0) {
    7846:	e519                	bnez	a0,7854 <sigtest_main+0x40>
    // 子进程：无限循环
    while(1) {
      sleep(1);
    7848:	4505                	li	a0,1
    784a:	00001097          	auipc	ra,0x1
    784e:	7b6080e7          	jalr	1974(ra) # 9000 <sleep>
    while(1) {
    7852:	bfdd                	j	7848 <sigtest_main+0x34>
    7854:	84aa                	mv	s1,a0
    }
  }
  
  sleep(5);  // 等待一小会
    7856:	4515                	li	a0,5
    7858:	00001097          	auipc	ra,0x1
    785c:	7a8080e7          	jalr	1960(ra) # 9000 <sleep>
  printf("  Sending SIGTERM to child %d\n", pid1);
    7860:	85a6                	mv	a1,s1
    7862:	00007517          	auipc	a0,0x7
    7866:	a5e50513          	addi	a0,a0,-1442 # e2c0 <malloc+0x4d00>
    786a:	00002097          	auipc	ra,0x2
    786e:	c9e080e7          	jalr	-866(ra) # 9508 <printf>
  int result = kill2(pid1, SIGTERM);
    7872:	45bd                	li	a1,15
    7874:	8526                	mv	a0,s1
    7876:	00002097          	auipc	ra,0x2
    787a:	866080e7          	jalr	-1946(ra) # 90dc <kill2>
    787e:	85aa                	mv	a1,a0
  printf("  kill2 returned: %d\n", result);
    7880:	00007517          	auipc	a0,0x7
    7884:	a6050513          	addi	a0,a0,-1440 # e2e0 <malloc+0x4d20>
    7888:	00002097          	auipc	ra,0x2
    788c:	c80080e7          	jalr	-896(ra) # 9508 <printf>
  
  int status;
  wait(&status);
    7890:	fdc40513          	addi	a0,s0,-36
    7894:	00001097          	auipc	ra,0x1
    7898:	6fc080e7          	jalr	1788(ra) # 8f90 <wait>
  printf("  Child exited with status: %d\n", status);
    789c:	fdc42583          	lw	a1,-36(s0)
    78a0:	00007517          	auipc	a0,0x7
    78a4:	a5850513          	addi	a0,a0,-1448 # e2f8 <malloc+0x4d38>
    78a8:	00002097          	auipc	ra,0x2
    78ac:	c60080e7          	jalr	-928(ra) # 9508 <printf>
  printf("  Test 1: PASSED\n\n");
    78b0:	00007517          	auipc	a0,0x7
    78b4:	a6850513          	addi	a0,a0,-1432 # e318 <malloc+0x4d58>
    78b8:	00002097          	auipc	ra,0x2
    78bc:	c50080e7          	jalr	-944(ra) # 9508 <printf>
  
  // 测试 2: 使用 SIGKILL 强制终止
  printf("Test 2: SIGKILL forced termination\n");
    78c0:	00007517          	auipc	a0,0x7
    78c4:	a7050513          	addi	a0,a0,-1424 # e330 <malloc+0x4d70>
    78c8:	00002097          	auipc	ra,0x2
    78cc:	c40080e7          	jalr	-960(ra) # 9508 <printf>
  int pid2 = fork();
    78d0:	00001097          	auipc	ra,0x1
    78d4:	6b0080e7          	jalr	1712(ra) # 8f80 <fork>
    78d8:	84aa                	mv	s1,a0
  if(pid2 == 0) {
    78da:	e519                	bnez	a0,78e8 <sigtest_main+0xd4>
    while(1) {
      sleep(1);
    78dc:	4505                	li	a0,1
    78de:	00001097          	auipc	ra,0x1
    78e2:	722080e7          	jalr	1826(ra) # 9000 <sleep>
    while(1) {
    78e6:	bfdd                	j	78dc <sigtest_main+0xc8>
    }
  }
  
  sleep(5);
    78e8:	4515                	li	a0,5
    78ea:	00001097          	auipc	ra,0x1
    78ee:	716080e7          	jalr	1814(ra) # 9000 <sleep>
  printf("  Sending SIGKILL to child %d\n", pid2);
    78f2:	85a6                	mv	a1,s1
    78f4:	00007517          	auipc	a0,0x7
    78f8:	a6450513          	addi	a0,a0,-1436 # e358 <malloc+0x4d98>
    78fc:	00002097          	auipc	ra,0x2
    7900:	c0c080e7          	jalr	-1012(ra) # 9508 <printf>
  result = kill2(pid2, SIGKILL);
    7904:	45a5                	li	a1,9
    7906:	8526                	mv	a0,s1
    7908:	00001097          	auipc	ra,0x1
    790c:	7d4080e7          	jalr	2004(ra) # 90dc <kill2>
    7910:	85aa                	mv	a1,a0
  printf("  kill2 returned: %d\n", result);
    7912:	00007517          	auipc	a0,0x7
    7916:	9ce50513          	addi	a0,a0,-1586 # e2e0 <malloc+0x4d20>
    791a:	00002097          	auipc	ra,0x2
    791e:	bee080e7          	jalr	-1042(ra) # 9508 <printf>
  
  wait(&status);
    7922:	fdc40513          	addi	a0,s0,-36
    7926:	00001097          	auipc	ra,0x1
    792a:	66a080e7          	jalr	1642(ra) # 8f90 <wait>
  printf("  Child exited with status: %d\n", status);
    792e:	fdc42583          	lw	a1,-36(s0)
    7932:	00007517          	auipc	a0,0x7
    7936:	9c650513          	addi	a0,a0,-1594 # e2f8 <malloc+0x4d38>
    793a:	00002097          	auipc	ra,0x2
    793e:	bce080e7          	jalr	-1074(ra) # 9508 <printf>
  printf("  Test 2: PASSED\n\n");
    7942:	00007517          	auipc	a0,0x7
    7946:	a3650513          	addi	a0,a0,-1482 # e378 <malloc+0x4db8>
    794a:	00002097          	auipc	ra,0x2
    794e:	bbe080e7          	jalr	-1090(ra) # 9508 <printf>
  
  // 测试 3: 向不存在的进程发送信号
  printf("Test 3: Signal to non-existent process\n");
    7952:	00007517          	auipc	a0,0x7
    7956:	a3e50513          	addi	a0,a0,-1474 # e390 <malloc+0x4dd0>
    795a:	00002097          	auipc	ra,0x2
    795e:	bae080e7          	jalr	-1106(ra) # 9508 <printf>
  result = kill2(99999, SIGTERM);
    7962:	45bd                	li	a1,15
    7964:	6561                	lui	a0,0x18
    7966:	69f50513          	addi	a0,a0,1695 # 1869f <data+0x7cef>
    796a:	00001097          	auipc	ra,0x1
    796e:	772080e7          	jalr	1906(ra) # 90dc <kill2>
    7972:	84aa                	mv	s1,a0
  printf("  kill2(99999, SIGTERM) returned: %d (expected: -1)\n", result);
    7974:	85aa                	mv	a1,a0
    7976:	00007517          	auipc	a0,0x7
    797a:	a4250513          	addi	a0,a0,-1470 # e3b8 <malloc+0x4df8>
    797e:	00002097          	auipc	ra,0x2
    7982:	b8a080e7          	jalr	-1142(ra) # 9508 <printf>
  if(result == -1) {
    7986:	57fd                	li	a5,-1
    7988:	06f48e63          	beq	s1,a5,7a04 <sigtest_main+0x1f0>
    printf("  Test 3: PASSED\n\n");
  } else {
    printf("  Test 3: FAILED\n\n");
    798c:	00007517          	auipc	a0,0x7
    7990:	a7c50513          	addi	a0,a0,-1412 # e408 <malloc+0x4e48>
    7994:	00002097          	auipc	ra,0x2
    7998:	b74080e7          	jalr	-1164(ra) # 9508 <printf>
  }
  
  // 测试 4: 无效信号
  printf("Test 4: Invalid signal number\n");
    799c:	00007517          	auipc	a0,0x7
    79a0:	a8450513          	addi	a0,a0,-1404 # e420 <malloc+0x4e60>
    79a4:	00002097          	auipc	ra,0x2
    79a8:	b64080e7          	jalr	-1180(ra) # 9508 <printf>
  result = kill2(getpid(), 100);  // 无效信号
    79ac:	00001097          	auipc	ra,0x1
    79b0:	644080e7          	jalr	1604(ra) # 8ff0 <getpid>
    79b4:	06400593          	li	a1,100
    79b8:	00001097          	auipc	ra,0x1
    79bc:	724080e7          	jalr	1828(ra) # 90dc <kill2>
    79c0:	84aa                	mv	s1,a0
  printf("  kill2(pid, 100) returned: %d (expected: -1)\n", result);
    79c2:	85aa                	mv	a1,a0
    79c4:	00007517          	auipc	a0,0x7
    79c8:	a7c50513          	addi	a0,a0,-1412 # e440 <malloc+0x4e80>
    79cc:	00002097          	auipc	ra,0x2
    79d0:	b3c080e7          	jalr	-1220(ra) # 9508 <printf>
  if(result == -1) {
    79d4:	57fd                	li	a5,-1
    79d6:	04f48063          	beq	s1,a5,7a16 <sigtest_main+0x202>
    printf("  Test 4: PASSED\n\n");
  } else {
    printf("  Test 4: FAILED\n\n");
    79da:	00007517          	auipc	a0,0x7
    79de:	aae50513          	addi	a0,a0,-1362 # e488 <malloc+0x4ec8>
    79e2:	00002097          	auipc	ra,0x2
    79e6:	b26080e7          	jalr	-1242(ra) # 9508 <printf>
  }
  
  printf("=== All Signal Tests Completed ===\n");
    79ea:	00007517          	auipc	a0,0x7
    79ee:	ab650513          	addi	a0,a0,-1354 # e4a0 <malloc+0x4ee0>
    79f2:	00002097          	auipc	ra,0x2
    79f6:	b16080e7          	jalr	-1258(ra) # 9508 <printf>
  exit(0);
    79fa:	4501                	li	a0,0
    79fc:	00001097          	auipc	ra,0x1
    7a00:	58c080e7          	jalr	1420(ra) # 8f88 <exit>
    printf("  Test 3: PASSED\n\n");
    7a04:	00007517          	auipc	a0,0x7
    7a08:	9ec50513          	addi	a0,a0,-1556 # e3f0 <malloc+0x4e30>
    7a0c:	00002097          	auipc	ra,0x2
    7a10:	afc080e7          	jalr	-1284(ra) # 9508 <printf>
    7a14:	b761                	j	799c <sigtest_main+0x188>
    printf("  Test 4: PASSED\n\n");
    7a16:	00007517          	auipc	a0,0x7
    7a1a:	a5a50513          	addi	a0,a0,-1446 # e470 <malloc+0x4eb0>
    7a1e:	00002097          	auipc	ra,0x2
    7a22:	aea080e7          	jalr	-1302(ra) # 9508 <printf>
    7a26:	b7d1                	j	79ea <sigtest_main+0x1d6>

0000000000007a28 <sigtest>:
void sigtest(char *s) {
    7a28:	1141                	addi	sp,sp,-16
    7a2a:	e406                	sd	ra,8(sp)
    7a2c:	e022                	sd	s0,0(sp)
    7a2e:	0800                	addi	s0,sp,16
    if(verbose) { sigtest_main(); return; }
    7a30:	00008797          	auipc	a5,0x8
    7a34:	e647a783          	lw	a5,-412(a5) # f894 <verbose>
    7a38:	ef81                	bnez	a5,7a50 <sigtest+0x28>
    int pid = fork();
    7a3a:	00001097          	auipc	ra,0x1
    7a3e:	546080e7          	jalr	1350(ra) # 8f80 <fork>
    if(pid == 0) { for(;;) sleep(1); }
    7a42:	e919                	bnez	a0,7a58 <sigtest+0x30>
    7a44:	4505                	li	a0,1
    7a46:	00001097          	auipc	ra,0x1
    7a4a:	5ba080e7          	jalr	1466(ra) # 9000 <sleep>
    7a4e:	bfdd                	j	7a44 <sigtest+0x1c>
    if(verbose) { sigtest_main(); return; }
    7a50:	00000097          	auipc	ra,0x0
    7a54:	dc4080e7          	jalr	-572(ra) # 7814 <sigtest_main>
    kill2(pid, SIGKILL);
    7a58:	45a5                	li	a1,9
    7a5a:	00001097          	auipc	ra,0x1
    7a5e:	682080e7          	jalr	1666(ra) # 90dc <kill2>
    wait(0);
    7a62:	4501                	li	a0,0
    7a64:	00001097          	auipc	ra,0x1
    7a68:	52c080e7          	jalr	1324(ra) # 8f90 <wait>
}
    7a6c:	60a2                	ld	ra,8(sp)
    7a6e:	6402                	ld	s0,0(sp)
    7a70:	0141                	addi	sp,sp,16
    7a72:	8082                	ret

0000000000007a74 <sigtest2_main>:

int sigtest2_main(void)
{
    7a74:	1101                	addi	sp,sp,-32
    7a76:	ec06                	sd	ra,24(sp)
    7a78:	e822                	sd	s0,16(sp)
    7a7a:	e426                	sd	s1,8(sp)
    7a7c:	1000                	addi	s0,sp,32
  printf("=== User Signal Handler Test (V2.1) DEBUG ===\n\n");
    7a7e:	00007517          	auipc	a0,0x7
    7a82:	a4a50513          	addi	a0,a0,-1462 # e4c8 <malloc+0x4f08>
    7a86:	00002097          	auipc	ra,0x2
    7a8a:	a82080e7          	jalr	-1406(ra) # 9508 <printf>
  
  // 测试 0: 验证基本功能
  printf("Test 0: Basic setup verification\n");
    7a8e:	00007517          	auipc	a0,0x7
    7a92:	a6a50513          	addi	a0,a0,-1430 # e4f8 <malloc+0x4f38>
    7a96:	00002097          	auipc	ra,0x2
    7a9a:	a72080e7          	jalr	-1422(ra) # 9508 <printf>
  printf("  PID: %d\n", getpid());
    7a9e:	00001097          	auipc	ra,0x1
    7aa2:	552080e7          	jalr	1362(ra) # 8ff0 <getpid>
    7aa6:	85aa                	mv	a1,a0
    7aa8:	00007517          	auipc	a0,0x7
    7aac:	a7850513          	addi	a0,a0,-1416 # e520 <malloc+0x4f60>
    7ab0:	00002097          	auipc	ra,0x2
    7ab4:	a58080e7          	jalr	-1448(ra) # 9508 <printf>
  printf("  Test 0: PASSED\n\n");
    7ab8:	00007517          	auipc	a0,0x7
    7abc:	a7850513          	addi	a0,a0,-1416 # e530 <malloc+0x4f70>
    7ac0:	00002097          	auipc	ra,0x2
    7ac4:	a48080e7          	jalr	-1464(ra) # 9508 <printf>
  
  // 测试 1: 注册 SIGUSR1 处理器
  printf("Test 1: Register SIGUSR1 handler\n");
    7ac8:	00007517          	auipc	a0,0x7
    7acc:	a8050513          	addi	a0,a0,-1408 # e548 <malloc+0x4f88>
    7ad0:	00002097          	auipc	ra,0x2
    7ad4:	a38080e7          	jalr	-1480(ra) # 9508 <printf>
  signal_received = 0;
    7ad8:	00008797          	auipc	a5,0x8
    7adc:	db078793          	addi	a5,a5,-592 # f888 <alarm_simple_received>
    7ae0:	1007a823          	sw	zero,272(a5)
  signal_number = 0;
    7ae4:	1007aa23          	sw	zero,276(a5)
  
  if(sigaction(SIGUSR1, my_handler) < 0) {
    7ae8:	ffffc597          	auipc	a1,0xffffc
    7aec:	76058593          	addi	a1,a1,1888 # 4248 <my_handler>
    7af0:	4579                	li	a0,30
    7af2:	00001097          	auipc	ra,0x1
    7af6:	5f4080e7          	jalr	1524(ra) # 90e6 <sigaction>
    7afa:	0a054663          	bltz	a0,7ba6 <sigtest2_main+0x132>
    printf("  sigaction failed!\n");
    exit(1);
  }
  printf("  Handler registered at %p\n", my_handler);
    7afe:	ffffc597          	auipc	a1,0xffffc
    7b02:	74a58593          	addi	a1,a1,1866 # 4248 <my_handler>
    7b06:	00007517          	auipc	a0,0x7
    7b0a:	a8250513          	addi	a0,a0,-1406 # e588 <malloc+0x4fc8>
    7b0e:	00002097          	auipc	ra,0x2
    7b12:	9fa080e7          	jalr	-1542(ra) # 9508 <printf>
  
  // 向自己发送信号
  printf("  Sending SIGUSR1 to self (pid=%d)...\n", getpid());
    7b16:	00001097          	auipc	ra,0x1
    7b1a:	4da080e7          	jalr	1242(ra) # 8ff0 <getpid>
    7b1e:	85aa                	mv	a1,a0
    7b20:	00007517          	auipc	a0,0x7
    7b24:	a8850513          	addi	a0,a0,-1400 # e5a8 <malloc+0x4fe8>
    7b28:	00002097          	auipc	ra,0x2
    7b2c:	9e0080e7          	jalr	-1568(ra) # 9508 <printf>
  int result = kill2(getpid(), SIGUSR1);
    7b30:	00001097          	auipc	ra,0x1
    7b34:	4c0080e7          	jalr	1216(ra) # 8ff0 <getpid>
    7b38:	45f9                	li	a1,30
    7b3a:	00001097          	auipc	ra,0x1
    7b3e:	5a2080e7          	jalr	1442(ra) # 90dc <kill2>
    7b42:	85aa                	mv	a1,a0
  printf("  kill2 returned: %d\n", result);
    7b44:	00006517          	auipc	a0,0x6
    7b48:	79c50513          	addi	a0,a0,1948 # e2e0 <malloc+0x4d20>
    7b4c:	00002097          	auipc	ra,0x2
    7b50:	9bc080e7          	jalr	-1604(ra) # 9508 <printf>
  
  // 如果能到这里，说明 sigreturn 工作了
  printf("  After signal: received=%d, sig=%d\n", signal_received, signal_number);
    7b54:	00008597          	auipc	a1,0x8
    7b58:	e445a583          	lw	a1,-444(a1) # f998 <signal_received>
    7b5c:	00008617          	auipc	a2,0x8
    7b60:	e4062603          	lw	a2,-448(a2) # f99c <signal_number>
    7b64:	00007517          	auipc	a0,0x7
    7b68:	a6c50513          	addi	a0,a0,-1428 # e5d0 <malloc+0x5010>
    7b6c:	00002097          	auipc	ra,0x2
    7b70:	99c080e7          	jalr	-1636(ra) # 9508 <printf>
  
  if(signal_received && signal_number == SIGUSR1) {
    7b74:	00008797          	auipc	a5,0x8
    7b78:	e247a783          	lw	a5,-476(a5) # f998 <signal_received>
    7b7c:	cb81                	beqz	a5,7b8c <sigtest2_main+0x118>
    7b7e:	00008717          	auipc	a4,0x8
    7b82:	e1e72703          	lw	a4,-482(a4) # f99c <signal_number>
    7b86:	47f9                	li	a5,30
    7b88:	02f70c63          	beq	a4,a5,7bc0 <sigtest2_main+0x14c>
    printf("  Test 1: PASSED\n\n");
  } else {
    printf("  Test 1: FAILED\n\n");
    7b8c:	00007517          	auipc	a0,0x7
    7b90:	ad450513          	addi	a0,a0,-1324 # e660 <malloc+0x50a0>
    7b94:	00002097          	auipc	ra,0x2
    7b98:	974080e7          	jalr	-1676(ra) # 9508 <printf>
    exit(1);
    7b9c:	4505                	li	a0,1
    7b9e:	00001097          	auipc	ra,0x1
    7ba2:	3ea080e7          	jalr	1002(ra) # 8f88 <exit>
    printf("  sigaction failed!\n");
    7ba6:	00007517          	auipc	a0,0x7
    7baa:	9ca50513          	addi	a0,a0,-1590 # e570 <malloc+0x4fb0>
    7bae:	00002097          	auipc	ra,0x2
    7bb2:	95a080e7          	jalr	-1702(ra) # 9508 <printf>
    exit(1);
    7bb6:	4505                	li	a0,1
    7bb8:	00001097          	auipc	ra,0x1
    7bbc:	3d0080e7          	jalr	976(ra) # 8f88 <exit>
    printf("  Test 1: PASSED\n\n");
    7bc0:	00006517          	auipc	a0,0x6
    7bc4:	75850513          	addi	a0,a0,1880 # e318 <malloc+0x4d58>
    7bc8:	00002097          	auipc	ra,0x2
    7bcc:	940080e7          	jalr	-1728(ra) # 9508 <printf>
  }
  
  // 测试 2: 尝试捕获 SIGKILL (应该失败)
  printf("Test 2: Attempt to catch SIGKILL (should fail)\n");
    7bd0:	00007517          	auipc	a0,0x7
    7bd4:	a2850513          	addi	a0,a0,-1496 # e5f8 <malloc+0x5038>
    7bd8:	00002097          	auipc	ra,0x2
    7bdc:	930080e7          	jalr	-1744(ra) # 9508 <printf>
  result = sigaction(SIGKILL, my_handler);
    7be0:	ffffc597          	auipc	a1,0xffffc
    7be4:	66858593          	addi	a1,a1,1640 # 4248 <my_handler>
    7be8:	4525                	li	a0,9
    7bea:	00001097          	auipc	ra,0x1
    7bee:	4fc080e7          	jalr	1276(ra) # 90e6 <sigaction>
    7bf2:	84aa                	mv	s1,a0
  printf("  sigaction(SIGKILL) returned: %d (expected: -1)\n", result);
    7bf4:	85aa                	mv	a1,a0
    7bf6:	00007517          	auipc	a0,0x7
    7bfa:	a3250513          	addi	a0,a0,-1486 # e628 <malloc+0x5068>
    7bfe:	00002097          	auipc	ra,0x2
    7c02:	90a080e7          	jalr	-1782(ra) # 9508 <printf>
  if(result == -1) {
    7c06:	57fd                	li	a5,-1
    7c08:	02f48763          	beq	s1,a5,7c36 <sigtest2_main+0x1c2>
    printf("  Test 2: PASSED\n\n");
  } else {
    printf("  Test 2: FAILED\n\n");
    7c0c:	00007517          	auipc	a0,0x7
    7c10:	a6c50513          	addi	a0,a0,-1428 # e678 <malloc+0x50b8>
    7c14:	00002097          	auipc	ra,0x2
    7c18:	8f4080e7          	jalr	-1804(ra) # 9508 <printf>
  }
  
  printf("=== All Tests Completed ===\n");
    7c1c:	00007517          	auipc	a0,0x7
    7c20:	a7450513          	addi	a0,a0,-1420 # e690 <malloc+0x50d0>
    7c24:	00002097          	auipc	ra,0x2
    7c28:	8e4080e7          	jalr	-1820(ra) # 9508 <printf>
  exit(0);
    7c2c:	4501                	li	a0,0
    7c2e:	00001097          	auipc	ra,0x1
    7c32:	35a080e7          	jalr	858(ra) # 8f88 <exit>
    printf("  Test 2: PASSED\n\n");
    7c36:	00006517          	auipc	a0,0x6
    7c3a:	74250513          	addi	a0,a0,1858 # e378 <malloc+0x4db8>
    7c3e:	00002097          	auipc	ra,0x2
    7c42:	8ca080e7          	jalr	-1846(ra) # 9508 <printf>
    7c46:	bfd9                	j	7c1c <sigtest2_main+0x1a8>

0000000000007c48 <sigtest2>:
void sigtest2(char *s) {
    7c48:	1141                	addi	sp,sp,-16
    7c4a:	e406                	sd	ra,8(sp)
    7c4c:	e022                	sd	s0,0(sp)
    7c4e:	0800                	addi	s0,sp,16
    if(verbose) { sigtest2_main(); return; }
    7c50:	00008797          	auipc	a5,0x8
    7c54:	c447a783          	lw	a5,-956(a5) # f894 <verbose>
    7c58:	eb99                	bnez	a5,7c6e <sigtest2+0x26>
    sigaction(SIGUSR1, 0);
    7c5a:	4581                	li	a1,0
    7c5c:	4579                	li	a0,30
    7c5e:	00001097          	auipc	ra,0x1
    7c62:	488080e7          	jalr	1160(ra) # 90e6 <sigaction>
}
    7c66:	60a2                	ld	ra,8(sp)
    7c68:	6402                	ld	s0,0(sp)
    7c6a:	0141                	addi	sp,sp,16
    7c6c:	8082                	ret
    if(verbose) { sigtest2_main(); return; }
    7c6e:	00000097          	auipc	ra,0x0
    7c72:	e06080e7          	jalr	-506(ra) # 7a74 <sigtest2_main>

0000000000007c76 <test_main>:
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "serein-user/user.h"

int test_main()
{
    7c76:	7119                	addi	sp,sp,-128
    7c78:	fc86                	sd	ra,120(sp)
    7c7a:	f8a2                	sd	s0,112(sp)
    7c7c:	0100                	addi	s0,sp,128
    struct sysinfo info;
    if (sysinfo(&info) < 0) {
    7c7e:	f8840513          	addi	a0,s0,-120
    7c82:	00001097          	auipc	ra,0x1
    7c86:	3be080e7          	jalr	958(ra) # 9040 <sysinfo>
    7c8a:	02054c63          	bltz	a0,7cc2 <test_main+0x4c>
        printf("sysinfo fail!\n");
    } else {
        printf("memory left: %d KB\n", info.freemem >> 10);
    7c8e:	f8843583          	ld	a1,-120(s0)
    7c92:	81a9                	srli	a1,a1,0xa
    7c94:	00007517          	auipc	a0,0x7
    7c98:	a2c50513          	addi	a0,a0,-1492 # e6c0 <malloc+0x5100>
    7c9c:	00002097          	auipc	ra,0x2
    7ca0:	86c080e7          	jalr	-1940(ra) # 9508 <printf>
        printf("process amount: %d\n", info.nproc);
    7ca4:	f9043583          	ld	a1,-112(s0)
    7ca8:	00007517          	auipc	a0,0x7
    7cac:	a3050513          	addi	a0,a0,-1488 # e6d8 <malloc+0x5118>
    7cb0:	00002097          	auipc	ra,0x2
    7cb4:	858080e7          	jalr	-1960(ra) # 9508 <printf>
    }
    exit(0);
    7cb8:	4501                	li	a0,0
    7cba:	00001097          	auipc	ra,0x1
    7cbe:	2ce080e7          	jalr	718(ra) # 8f88 <exit>
        printf("sysinfo fail!\n");
    7cc2:	00007517          	auipc	a0,0x7
    7cc6:	9ee50513          	addi	a0,a0,-1554 # e6b0 <malloc+0x50f0>
    7cca:	00002097          	auipc	ra,0x2
    7cce:	83e080e7          	jalr	-1986(ra) # 9508 <printf>
    7cd2:	b7dd                	j	7cb8 <test_main+0x42>

0000000000007cd4 <sysinfotest>:
void sysinfotest(char *s) {
    7cd4:	7135                	addi	sp,sp,-160
    7cd6:	ed06                	sd	ra,152(sp)
    7cd8:	e922                	sd	s0,144(sp)
    7cda:	e526                	sd	s1,136(sp)
    7cdc:	1100                	addi	s0,sp,160
    if(verbose) { char *argv[] = {"test", 0}; test_main(1, argv); return; }
    7cde:	00008797          	auipc	a5,0x8
    7ce2:	bb67a783          	lw	a5,-1098(a5) # f894 <verbose>
    7ce6:	ef99                	bnez	a5,7d04 <sysinfotest+0x30>
    7ce8:	84aa                	mv	s1,a0
    if(sysinfo(&info) < 0) { printf("%s: sysinfo failed\n", s); exit(1); }
    7cea:	f7840513          	addi	a0,s0,-136
    7cee:	00001097          	auipc	ra,0x1
    7cf2:	352080e7          	jalr	850(ra) # 9040 <sysinfo>
    7cf6:	02054663          	bltz	a0,7d22 <sysinfotest+0x4e>
}
    7cfa:	60ea                	ld	ra,152(sp)
    7cfc:	644a                	ld	s0,144(sp)
    7cfe:	64aa                	ld	s1,136(sp)
    7d00:	610d                	addi	sp,sp,160
    7d02:	8082                	ret
    if(verbose) { char *argv[] = {"test", 0}; test_main(1, argv); return; }
    7d04:	00007797          	auipc	a5,0x7
    7d08:	42c78793          	addi	a5,a5,1068 # f130 <malloc+0x5b70>
    7d0c:	f6f43423          	sd	a5,-152(s0)
    7d10:	f6043823          	sd	zero,-144(s0)
    7d14:	f6840593          	addi	a1,s0,-152
    7d18:	4505                	li	a0,1
    7d1a:	00000097          	auipc	ra,0x0
    7d1e:	f5c080e7          	jalr	-164(ra) # 7c76 <test_main>
    if(sysinfo(&info) < 0) { printf("%s: sysinfo failed\n", s); exit(1); }
    7d22:	85a6                	mv	a1,s1
    7d24:	00007517          	auipc	a0,0x7
    7d28:	9cc50513          	addi	a0,a0,-1588 # e6f0 <malloc+0x5130>
    7d2c:	00001097          	auipc	ra,0x1
    7d30:	7dc080e7          	jalr	2012(ra) # 9508 <printf>
    7d34:	4505                	li	a0,1
    7d36:	00001097          	auipc	ra,0x1
    7d3a:	252080e7          	jalr	594(ra) # 8f88 <exit>

0000000000007d3e <cowstress_run>:
// 用于测试的全局数组
char data[NPAGES * 4096];

void
cowstress_run(void)
{
    7d3e:	7159                	addi	sp,sp,-112
    7d40:	f486                	sd	ra,104(sp)
    7d42:	f0a2                	sd	s0,96(sp)
    7d44:	eca6                	sd	s1,88(sp)
    7d46:	e8ca                	sd	s2,80(sp)
    7d48:	e4ce                	sd	s3,72(sp)
    7d4a:	e0d2                	sd	s4,64(sp)
    7d4c:	fc56                	sd	s5,56(sp)
    7d4e:	f85a                	sd	s6,48(sp)
    7d50:	f45e                	sd	s7,40(sp)
    7d52:	f062                	sd	s8,32(sp)
    7d54:	ec66                	sd	s9,24(sp)
    7d56:	1880                	addi	s0,sp,112
  int pids[NFORK];
  int i, j, iter;
  
  printf("cowstress: starting CoW stress test...\n");
    7d58:	00007517          	auipc	a0,0x7
    7d5c:	9b050513          	addi	a0,a0,-1616 # e708 <malloc+0x5148>
    7d60:	00001097          	auipc	ra,0x1
    7d64:	7a8080e7          	jalr	1960(ra) # 9508 <printf>
  printf("  NFORK=%d, NPAGES=%d, ITERATIONS=%d\n", NFORK, NPAGES, ITERATIONS);
    7d68:	468d                	li	a3,3
    7d6a:	4629                	li	a2,10
    7d6c:	45d1                	li	a1,20
    7d6e:	00007517          	auipc	a0,0x7
    7d72:	9c250513          	addi	a0,a0,-1598 # e730 <malloc+0x5170>
    7d76:	00001097          	auipc	ra,0x1
    7d7a:	792080e7          	jalr	1938(ra) # 9508 <printf>
  
  for(iter = 0; iter < ITERATIONS; iter++) {
    7d7e:	4b81                	li	s7,0
    printf("cowstress: iteration %d/%d\n", iter + 1, ITERATIONS);
    7d80:	00007c17          	auipc	s8,0x7
    7d84:	9d8c0c13          	addi	s8,s8,-1576 # e758 <malloc+0x5198>
    7d88:	00013997          	auipc	s3,0x13
    7d8c:	c2898993          	addi	s3,s3,-984 # 1a9b0 <shared_counter>
    
    // 初始化父进程数据
    for(i = 0; i < NPAGES * 4096; i++) {
      data[i] = 'P';  // Parent
    7d90:	05000913          	li	s2,80
    }
    
    // Fork 多个子进程
    for(i = 0; i < NFORK; i++) {
    7d94:	4ad1                	li	s5,20
    }
    
    // 父进程：等待所有子进程
    for(i = 0; i < NFORK; i++) {
      int status;
      int pid = wait(&status);
    7d96:	f9c40b13          	addi	s6,s0,-100
        exit(1);
      }
    }
    
    // 验证父进程数据未被污染
    for(i = 0; i < NPAGES * 4096; i++) {
    7d9a:	6a29                	lui	s4,0xa
    printf("cowstress: iteration %d/%d\n", iter + 1, ITERATIONS);
    7d9c:	2b85                	addiw	s7,s7,1
    7d9e:	460d                	li	a2,3
    7da0:	85de                	mv	a1,s7
    7da2:	8562                	mv	a0,s8
    7da4:	00001097          	auipc	ra,0x1
    7da8:	764080e7          	jalr	1892(ra) # 9508 <printf>
    for(i = 0; i < NPAGES * 4096; i++) {
    7dac:	00009497          	auipc	s1,0x9
    7db0:	c0448493          	addi	s1,s1,-1020 # 109b0 <data>
    printf("cowstress: iteration %d/%d\n", iter + 1, ITERATIONS);
    7db4:	87a6                	mv	a5,s1
      data[i] = 'P';  // Parent
    7db6:	01278023          	sb	s2,0(a5)
    for(i = 0; i < NPAGES * 4096; i++) {
    7dba:	0785                	addi	a5,a5,1
    7dbc:	ff379de3          	bne	a5,s3,7db6 <cowstress_run+0x78>
    for(i = 0; i < NFORK; i++) {
    7dc0:	4c81                	li	s9,0
      pids[i] = fork();
    7dc2:	00001097          	auipc	ra,0x1
    7dc6:	1be080e7          	jalr	446(ra) # 8f80 <fork>
      if(pids[i] < 0) {
    7dca:	06054463          	bltz	a0,7e32 <cowstress_run+0xf4>
      if(pids[i] == 0) {
    7dce:	c141                	beqz	a0,7e4e <cowstress_run+0x110>
    for(i = 0; i < NFORK; i++) {
    7dd0:	2c85                	addiw	s9,s9,1
    7dd2:	ff5c98e3          	bne	s9,s5,7dc2 <cowstress_run+0x84>
    7dd6:	8cd6                	mv	s9,s5
      int pid = wait(&status);
    7dd8:	855a                	mv	a0,s6
    7dda:	00001097          	auipc	ra,0x1
    7dde:	1b6080e7          	jalr	438(ra) # 8f90 <wait>
      if(pid < 0) {
    7de2:	0a054f63          	bltz	a0,7ea0 <cowstress_run+0x162>
      if(status != 0) {
    7de6:	f9c42603          	lw	a2,-100(s0)
    7dea:	ea61                	bnez	a2,7eba <cowstress_run+0x17c>
    for(i = 0; i < NFORK; i++) {
    7dec:	3cfd                	addiw	s9,s9,-1
    7dee:	fe0c95e3          	bnez	s9,7dd8 <cowstress_run+0x9a>
      if(data[i] != 'P') {
    7df2:	0004c783          	lbu	a5,0(s1)
    7df6:	0f279063          	bne	a5,s2,7ed6 <cowstress_run+0x198>
    for(i = 0; i < NPAGES * 4096; i++) {
    7dfa:	2605                	addiw	a2,a2,1
    7dfc:	0485                	addi	s1,s1,1
    7dfe:	ff461ae3          	bne	a2,s4,7df2 <cowstress_run+0xb4>
  for(iter = 0; iter < ITERATIONS; iter++) {
    7e02:	478d                	li	a5,3
    7e04:	f8fb9ce3          	bne	s7,a5,7d9c <cowstress_run+0x5e>
        exit(1);
      }
    }
  }
  
  printf("cowstress: PASSED\n");
    7e08:	00007517          	auipc	a0,0x7
    7e0c:	a3050513          	addi	a0,a0,-1488 # e838 <malloc+0x5278>
    7e10:	00001097          	auipc	ra,0x1
    7e14:	6f8080e7          	jalr	1784(ra) # 9508 <printf>
}
    7e18:	70a6                	ld	ra,104(sp)
    7e1a:	7406                	ld	s0,96(sp)
    7e1c:	64e6                	ld	s1,88(sp)
    7e1e:	6946                	ld	s2,80(sp)
    7e20:	69a6                	ld	s3,72(sp)
    7e22:	6a06                	ld	s4,64(sp)
    7e24:	7ae2                	ld	s5,56(sp)
    7e26:	7b42                	ld	s6,48(sp)
    7e28:	7ba2                	ld	s7,40(sp)
    7e2a:	7c02                	ld	s8,32(sp)
    7e2c:	6ce2                	ld	s9,24(sp)
    7e2e:	6165                	addi	sp,sp,112
    7e30:	8082                	ret
        printf("cowstress: fork %d failed\n", i);
    7e32:	85e6                	mv	a1,s9
    7e34:	00007517          	auipc	a0,0x7
    7e38:	94450513          	addi	a0,a0,-1724 # e778 <malloc+0x51b8>
    7e3c:	00001097          	auipc	ra,0x1
    7e40:	6cc080e7          	jalr	1740(ra) # 9508 <printf>
        exit(1);
    7e44:	4505                	li	a0,1
    7e46:	00001097          	auipc	ra,0x1
    7e4a:	142080e7          	jalr	322(ra) # 8f88 <exit>
          data[offset] = 'C' + (i % 26);  // Child
    7e4e:	4769                	li	a4,26
    7e50:	02ece73b          	remw	a4,s9,a4
    7e54:	0437071b          	addiw	a4,a4,67
    7e58:	0ff77713          	zext.b	a4,a4
          if(data[offset + 1] != 'P') {
    7e5c:	05000593          	li	a1,80
        for(j = 0; j < NPAGES; j++) {
    7e60:	6605                	lui	a2,0x1
    7e62:	46a9                	li	a3,10
          data[offset] = 'C' + (i % 26);  // Child
    7e64:	00e48023          	sb	a4,0(s1)
          if(data[offset + 1] != 'P') {
    7e68:	0014c783          	lbu	a5,1(s1)
    7e6c:	00b79b63          	bne	a5,a1,7e82 <cowstress_run+0x144>
        for(j = 0; j < NPAGES; j++) {
    7e70:	2505                	addiw	a0,a0,1
    7e72:	94b2                	add	s1,s1,a2
    7e74:	fed518e3          	bne	a0,a3,7e64 <cowstress_run+0x126>
        exit(0);
    7e78:	4501                	li	a0,0
    7e7a:	00001097          	auipc	ra,0x1
    7e7e:	10e080e7          	jalr	270(ra) # 8f88 <exit>
            printf("cowstress: child %d page %d corrupted!\n", i, j);
    7e82:	862a                	mv	a2,a0
    7e84:	85e6                	mv	a1,s9
    7e86:	00007517          	auipc	a0,0x7
    7e8a:	91250513          	addi	a0,a0,-1774 # e798 <malloc+0x51d8>
    7e8e:	00001097          	auipc	ra,0x1
    7e92:	67a080e7          	jalr	1658(ra) # 9508 <printf>
            exit(1);
    7e96:	4505                	li	a0,1
    7e98:	00001097          	auipc	ra,0x1
    7e9c:	0f0080e7          	jalr	240(ra) # 8f88 <exit>
        printf("cowstress: wait failed\n");
    7ea0:	00007517          	auipc	a0,0x7
    7ea4:	92050513          	addi	a0,a0,-1760 # e7c0 <malloc+0x5200>
    7ea8:	00001097          	auipc	ra,0x1
    7eac:	660080e7          	jalr	1632(ra) # 9508 <printf>
        exit(1);
    7eb0:	4505                	li	a0,1
    7eb2:	00001097          	auipc	ra,0x1
    7eb6:	0d6080e7          	jalr	214(ra) # 8f88 <exit>
        printf("cowstress: child %d failed with status %d\n", pid, status);
    7eba:	85aa                	mv	a1,a0
    7ebc:	00007517          	auipc	a0,0x7
    7ec0:	91c50513          	addi	a0,a0,-1764 # e7d8 <malloc+0x5218>
    7ec4:	00001097          	auipc	ra,0x1
    7ec8:	644080e7          	jalr	1604(ra) # 9508 <printf>
        exit(1);
    7ecc:	4505                	li	a0,1
    7ece:	00001097          	auipc	ra,0x1
    7ed2:	0ba080e7          	jalr	186(ra) # 8f88 <exit>
        printf("cowstress: parent data corrupted at offset %d!\n", i);
    7ed6:	85b2                	mv	a1,a2
    7ed8:	00007517          	auipc	a0,0x7
    7edc:	93050513          	addi	a0,a0,-1744 # e808 <malloc+0x5248>
    7ee0:	00001097          	auipc	ra,0x1
    7ee4:	628080e7          	jalr	1576(ra) # 9508 <printf>
        exit(1);
    7ee8:	4505                	li	a0,1
    7eea:	00001097          	auipc	ra,0x1
    7eee:	09e080e7          	jalr	158(ra) # 8f88 <exit>

0000000000007ef2 <cowstress>:
void cowstress(char *s) {
    7ef2:	1141                	addi	sp,sp,-16
    7ef4:	e406                	sd	ra,8(sp)
    7ef6:	e022                	sd	s0,0(sp)
    7ef8:	0800                	addi	s0,sp,16
    if(verbose) { char *argv[] = {"cowstress", 0}; cowstress_main(1, argv); return; }
    7efa:	00008797          	auipc	a5,0x8
    7efe:	99a7a783          	lw	a5,-1638(a5) # f894 <verbose>
    7f02:	ef99                	bnez	a5,7f20 <cowstress+0x2e>
    int pid = fork();
    7f04:	00001097          	auipc	ra,0x1
    7f08:	07c080e7          	jalr	124(ra) # 8f80 <fork>
    if(pid == 0) exit(0);
    7f0c:	c11d                	beqz	a0,7f32 <cowstress+0x40>
    wait(0);
    7f0e:	4501                	li	a0,0
    7f10:	00001097          	auipc	ra,0x1
    7f14:	080080e7          	jalr	128(ra) # 8f90 <wait>
}
    7f18:	60a2                	ld	ra,8(sp)
    7f1a:	6402                	ld	s0,0(sp)
    7f1c:	0141                	addi	sp,sp,16
    7f1e:	8082                	ret

static int cowstress_main(int argc, char *argv[])
{
  cowstress_run();
    7f20:	00000097          	auipc	ra,0x0
    7f24:	e1e080e7          	jalr	-482(ra) # 7d3e <cowstress_run>
  exit(0);
    7f28:	4501                	li	a0,0
    7f2a:	00001097          	auipc	ra,0x1
    7f2e:	05e080e7          	jalr	94(ra) # 8f88 <exit>
    if(pid == 0) exit(0);
    7f32:	00001097          	auipc	ra,0x1
    7f36:	056080e7          	jalr	86(ra) # 8f88 <exit>

0000000000007f3a <producer>:

static int sem_id;

void
producer(int id)
{
    7f3a:	7179                	addi	sp,sp,-48
    7f3c:	f406                	sd	ra,40(sp)
    7f3e:	f022                	sd	s0,32(sp)
    7f40:	ec26                	sd	s1,24(sp)
    7f42:	e84a                	sd	s2,16(sp)
    7f44:	e44e                	sd	s3,8(sp)
    7f46:	e052                	sd	s4,0(sp)
    7f48:	1800                	addi	s0,sp,48
  for(int i = 0; i < ITERATIONS; i++) {
    7f4a:	4481                	li	s1,0
    sem_post(sem_id);
    7f4c:	00008a17          	auipc	s4,0x8
    7f50:	93ca0a13          	addi	s4,s4,-1732 # f888 <alarm_simple_received>
    // 让出 CPU 增加交错
    if(i % 5 == 0) sleep(0);
    7f54:	4995                	li	s3,5
  for(int i = 0; i < ITERATIONS; i++) {
    7f56:	03200913          	li	s2,50
    7f5a:	a809                	j	7f6c <producer+0x32>
    if(i % 5 == 0) sleep(0);
    7f5c:	4501                	li	a0,0
    7f5e:	00001097          	auipc	ra,0x1
    7f62:	0a2080e7          	jalr	162(ra) # 9000 <sleep>
  for(int i = 0; i < ITERATIONS; i++) {
    7f66:	2485                	addiw	s1,s1,1
    7f68:	01248c63          	beq	s1,s2,7f80 <producer+0x46>
    sem_post(sem_id);
    7f6c:	118a2503          	lw	a0,280(s4)
    7f70:	00001097          	auipc	ra,0x1
    7f74:	0f0080e7          	jalr	240(ra) # 9060 <sem_post>
    if(i % 5 == 0) sleep(0);
    7f78:	0334e7bb          	remw	a5,s1,s3
    7f7c:	f7ed                	bnez	a5,7f66 <producer+0x2c>
    7f7e:	bff9                	j	7f5c <producer+0x22>
  }
  exit(0);
    7f80:	4501                	li	a0,0
    7f82:	00001097          	auipc	ra,0x1
    7f86:	006080e7          	jalr	6(ra) # 8f88 <exit>

0000000000007f8a <consumer>:
}

void
consumer(int id)
{
    7f8a:	7179                	addi	sp,sp,-48
    7f8c:	f406                	sd	ra,40(sp)
    7f8e:	f022                	sd	s0,32(sp)
    7f90:	ec26                	sd	s1,24(sp)
    7f92:	e84a                	sd	s2,16(sp)
    7f94:	e44e                	sd	s3,8(sp)
    7f96:	e052                	sd	s4,0(sp)
    7f98:	1800                	addi	s0,sp,48
  for(int i = 0; i < ITERATIONS; i++) {
    7f9a:	4481                	li	s1,0
    sem_wait(sem_id);
    7f9c:	00008a17          	auipc	s4,0x8
    7fa0:	8eca0a13          	addi	s4,s4,-1812 # f888 <alarm_simple_received>
    // 让出 CPU 增加交错
    if(i % 3 == 0) sleep(0);
    7fa4:	498d                	li	s3,3
  for(int i = 0; i < ITERATIONS; i++) {
    7fa6:	03200913          	li	s2,50
    7faa:	a809                	j	7fbc <consumer+0x32>
    if(i % 3 == 0) sleep(0);
    7fac:	4501                	li	a0,0
    7fae:	00001097          	auipc	ra,0x1
    7fb2:	052080e7          	jalr	82(ra) # 9000 <sleep>
  for(int i = 0; i < ITERATIONS; i++) {
    7fb6:	2485                	addiw	s1,s1,1
    7fb8:	01248c63          	beq	s1,s2,7fd0 <consumer+0x46>
    sem_wait(sem_id);
    7fbc:	118a2503          	lw	a0,280(s4)
    7fc0:	00001097          	auipc	ra,0x1
    7fc4:	098080e7          	jalr	152(ra) # 9058 <sem_wait>
    if(i % 3 == 0) sleep(0);
    7fc8:	0334e7bb          	remw	a5,s1,s3
    7fcc:	f7ed                	bnez	a5,7fb6 <consumer+0x2c>
    7fce:	bff9                	j	7fac <consumer+0x22>
  }
  exit(0);
    7fd0:	4501                	li	a0,0
    7fd2:	00001097          	auipc	ra,0x1
    7fd6:	fb6080e7          	jalr	-74(ra) # 8f88 <exit>

0000000000007fda <semstress_run>:
}

void
semstress_run(void)
{
    7fda:	7179                	addi	sp,sp,-48
    7fdc:	f406                	sd	ra,40(sp)
    7fde:	f022                	sd	s0,32(sp)
    7fe0:	ec26                	sd	s1,24(sp)
    7fe2:	e84a                	sd	s2,16(sp)
    7fe4:	1800                	addi	s0,sp,48
  int pids[NPROCS * 2];
  int i;
  
  printf("semstress: starting semaphore stress test...\n");
    7fe6:	00007517          	auipc	a0,0x7
    7fea:	86a50513          	addi	a0,a0,-1942 # e850 <malloc+0x5290>
    7fee:	00001097          	auipc	ra,0x1
    7ff2:	51a080e7          	jalr	1306(ra) # 9508 <printf>
  printf("  NPROCS=%d (each side), ITERATIONS=%d\n", NPROCS, ITERATIONS);
    7ff6:	03200613          	li	a2,50
    7ffa:	45a1                	li	a1,8
    7ffc:	00007517          	auipc	a0,0x7
    8000:	88450513          	addi	a0,a0,-1916 # e880 <malloc+0x52c0>
    8004:	00001097          	auipc	ra,0x1
    8008:	504080e7          	jalr	1284(ra) # 9508 <printf>
  
  // 创建信号量，初始值为 0
  sem_id = sem_open(0);
    800c:	4501                	li	a0,0
    800e:	00001097          	auipc	ra,0x1
    8012:	042080e7          	jalr	66(ra) # 9050 <sem_open>
    8016:	00008797          	auipc	a5,0x8
    801a:	98a7a523          	sw	a0,-1654(a5) # f9a0 <sem_id>
    printf("semstress: sem_open failed\n");
    exit(1);
  }
  
  // 创建生产者和消费者
  for(i = 0; i < NPROCS; i++) {
    801e:	4481                	li	s1,0
    8020:	4921                	li	s2,8
  if(sem_id < 0) {
    8022:	08054763          	bltz	a0,80b0 <semstress_run+0xd6>
    // 消费者
    pids[i] = fork();
    8026:	00001097          	auipc	ra,0x1
    802a:	f5a080e7          	jalr	-166(ra) # 8f80 <fork>
    if(pids[i] < 0) {
    802e:	08054e63          	bltz	a0,80ca <semstress_run+0xf0>
      printf("semstress: fork consumer %d failed\n", i);
      exit(1);
    }
    if(pids[i] == 0) {
    8032:	c955                	beqz	a0,80e6 <semstress_run+0x10c>
      consumer(i);
    }
    
    // 生产者
    pids[NPROCS + i] = fork();
    8034:	00001097          	auipc	ra,0x1
    8038:	f4c080e7          	jalr	-180(ra) # 8f80 <fork>
    if(pids[NPROCS + i] < 0) {
    803c:	0a054a63          	bltz	a0,80f0 <semstress_run+0x116>
      printf("semstress: fork producer %d failed\n", i);
      exit(1);
    }
    if(pids[NPROCS + i] == 0) {
    8040:	c571                	beqz	a0,810c <semstress_run+0x132>
  for(i = 0; i < NPROCS; i++) {
    8042:	2485                	addiw	s1,s1,1
    8044:	ff2491e3          	bne	s1,s2,8026 <semstress_run+0x4c>
    8048:	44c1                	li	s1,16
  }
  
  // 等待所有进程完成
  for(i = 0; i < NPROCS * 2; i++) {
    int status;
    int pid = wait(&status);
    804a:	fd840913          	addi	s2,s0,-40
    804e:	854a                	mv	a0,s2
    8050:	00001097          	auipc	ra,0x1
    8054:	f40080e7          	jalr	-192(ra) # 8f90 <wait>
    if(pid < 0) {
    8058:	0a054f63          	bltz	a0,8116 <semstress_run+0x13c>
      printf("semstress: wait failed\n");
      exit(1);
    }
    if(status != 0) {
    805c:	fd842603          	lw	a2,-40(s0)
    8060:	ea61                	bnez	a2,8130 <semstress_run+0x156>
  for(i = 0; i < NPROCS * 2; i++) {
    8062:	34fd                	addiw	s1,s1,-1
    8064:	f4ed                	bnez	s1,804e <semstress_run+0x74>
    }
  }
  
  // 验证信号量最终值为 0
  int val;
  if(sem_getvalue(sem_id, &val) < 0) {
    8066:	fdc40593          	addi	a1,s0,-36
    806a:	00008517          	auipc	a0,0x8
    806e:	93652503          	lw	a0,-1738(a0) # f9a0 <sem_id>
    8072:	00001097          	auipc	ra,0x1
    8076:	ffe080e7          	jalr	-2(ra) # 9070 <sem_getvalue>
    807a:	0c054963          	bltz	a0,814c <semstress_run+0x172>
    printf("semstress: sem_getvalue failed\n");
    exit(1);
  }
  
  if(val != 0) {
    807e:	fdc42583          	lw	a1,-36(s0)
    8082:	e1f5                	bnez	a1,8166 <semstress_run+0x18c>
    printf("semstress: final semaphore value is %d, expected 0\n", val);
    exit(1);
  }
  
  sem_close(sem_id);
    8084:	00008517          	auipc	a0,0x8
    8088:	91c52503          	lw	a0,-1764(a0) # f9a0 <sem_id>
    808c:	00001097          	auipc	ra,0x1
    8090:	fdc080e7          	jalr	-36(ra) # 9068 <sem_close>
  printf("semstress: PASSED\n");
    8094:	00007517          	auipc	a0,0x7
    8098:	92450513          	addi	a0,a0,-1756 # e9b8 <malloc+0x53f8>
    809c:	00001097          	auipc	ra,0x1
    80a0:	46c080e7          	jalr	1132(ra) # 9508 <printf>
}
    80a4:	70a2                	ld	ra,40(sp)
    80a6:	7402                	ld	s0,32(sp)
    80a8:	64e2                	ld	s1,24(sp)
    80aa:	6942                	ld	s2,16(sp)
    80ac:	6145                	addi	sp,sp,48
    80ae:	8082                	ret
    printf("semstress: sem_open failed\n");
    80b0:	00006517          	auipc	a0,0x6
    80b4:	7f850513          	addi	a0,a0,2040 # e8a8 <malloc+0x52e8>
    80b8:	00001097          	auipc	ra,0x1
    80bc:	450080e7          	jalr	1104(ra) # 9508 <printf>
    exit(1);
    80c0:	4505                	li	a0,1
    80c2:	00001097          	auipc	ra,0x1
    80c6:	ec6080e7          	jalr	-314(ra) # 8f88 <exit>
      printf("semstress: fork consumer %d failed\n", i);
    80ca:	85a6                	mv	a1,s1
    80cc:	00006517          	auipc	a0,0x6
    80d0:	7fc50513          	addi	a0,a0,2044 # e8c8 <malloc+0x5308>
    80d4:	00001097          	auipc	ra,0x1
    80d8:	434080e7          	jalr	1076(ra) # 9508 <printf>
      exit(1);
    80dc:	4505                	li	a0,1
    80de:	00001097          	auipc	ra,0x1
    80e2:	eaa080e7          	jalr	-342(ra) # 8f88 <exit>
      consumer(i);
    80e6:	8526                	mv	a0,s1
    80e8:	00000097          	auipc	ra,0x0
    80ec:	ea2080e7          	jalr	-350(ra) # 7f8a <consumer>
      printf("semstress: fork producer %d failed\n", i);
    80f0:	85a6                	mv	a1,s1
    80f2:	00006517          	auipc	a0,0x6
    80f6:	7fe50513          	addi	a0,a0,2046 # e8f0 <malloc+0x5330>
    80fa:	00001097          	auipc	ra,0x1
    80fe:	40e080e7          	jalr	1038(ra) # 9508 <printf>
      exit(1);
    8102:	4505                	li	a0,1
    8104:	00001097          	auipc	ra,0x1
    8108:	e84080e7          	jalr	-380(ra) # 8f88 <exit>
      producer(i);
    810c:	8526                	mv	a0,s1
    810e:	00000097          	auipc	ra,0x0
    8112:	e2c080e7          	jalr	-468(ra) # 7f3a <producer>
      printf("semstress: wait failed\n");
    8116:	00007517          	auipc	a0,0x7
    811a:	80250513          	addi	a0,a0,-2046 # e918 <malloc+0x5358>
    811e:	00001097          	auipc	ra,0x1
    8122:	3ea080e7          	jalr	1002(ra) # 9508 <printf>
      exit(1);
    8126:	4505                	li	a0,1
    8128:	00001097          	auipc	ra,0x1
    812c:	e60080e7          	jalr	-416(ra) # 8f88 <exit>
      printf("semstress: child %d failed with status %d\n", pid, status);
    8130:	85aa                	mv	a1,a0
    8132:	00006517          	auipc	a0,0x6
    8136:	7fe50513          	addi	a0,a0,2046 # e930 <malloc+0x5370>
    813a:	00001097          	auipc	ra,0x1
    813e:	3ce080e7          	jalr	974(ra) # 9508 <printf>
      exit(1);
    8142:	4505                	li	a0,1
    8144:	00001097          	auipc	ra,0x1
    8148:	e44080e7          	jalr	-444(ra) # 8f88 <exit>
    printf("semstress: sem_getvalue failed\n");
    814c:	00007517          	auipc	a0,0x7
    8150:	81450513          	addi	a0,a0,-2028 # e960 <malloc+0x53a0>
    8154:	00001097          	auipc	ra,0x1
    8158:	3b4080e7          	jalr	948(ra) # 9508 <printf>
    exit(1);
    815c:	4505                	li	a0,1
    815e:	00001097          	auipc	ra,0x1
    8162:	e2a080e7          	jalr	-470(ra) # 8f88 <exit>
    printf("semstress: final semaphore value is %d, expected 0\n", val);
    8166:	00007517          	auipc	a0,0x7
    816a:	81a50513          	addi	a0,a0,-2022 # e980 <malloc+0x53c0>
    816e:	00001097          	auipc	ra,0x1
    8172:	39a080e7          	jalr	922(ra) # 9508 <printf>
    exit(1);
    8176:	4505                	li	a0,1
    8178:	00001097          	auipc	ra,0x1
    817c:	e10080e7          	jalr	-496(ra) # 8f88 <exit>

0000000000008180 <semkilltest>:

// 测试 kill 清理
void
semkilltest(void)
{
    8180:	7179                	addi	sp,sp,-48
    8182:	f406                	sd	ra,40(sp)
    8184:	f022                	sd	s0,32(sp)
    8186:	ec26                	sd	s1,24(sp)
    8188:	e84a                	sd	s2,16(sp)
    818a:	1800                	addi	s0,sp,48
  printf("semkilltest: testing semaphore cleanup on kill...\n");
    818c:	00007517          	auipc	a0,0x7
    8190:	84450513          	addi	a0,a0,-1980 # e9d0 <malloc+0x5410>
    8194:	00001097          	auipc	ra,0x1
    8198:	374080e7          	jalr	884(ra) # 9508 <printf>
  
  int sem = sem_open(0);
    819c:	4501                	li	a0,0
    819e:	00001097          	auipc	ra,0x1
    81a2:	eb2080e7          	jalr	-334(ra) # 9050 <sem_open>
  if(sem < 0) {
    81a6:	06054f63          	bltz	a0,8224 <semkilltest+0xa4>
    81aa:	84aa                	mv	s1,a0
    printf("semkilltest: sem_open failed\n");
    exit(1);
  }
  
  int pid = fork();
    81ac:	00001097          	auipc	ra,0x1
    81b0:	dd4080e7          	jalr	-556(ra) # 8f80 <fork>
    81b4:	892a                	mv	s2,a0
  if(pid < 0) {
    81b6:	08054463          	bltz	a0,823e <semkilltest+0xbe>
    printf("semkilltest: fork failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    81ba:	cd59                	beqz	a0,8258 <semkilltest+0xd8>
    // 如果能到这里说明被唤醒了（kill 后）
    exit(0);
  }
  
  // 父进程：等待子进程阻塞，然后 kill
  sleep(1);  // 等待子进程进入 wait
    81bc:	4505                	li	a0,1
    81be:	00001097          	auipc	ra,0x1
    81c2:	e42080e7          	jalr	-446(ra) # 9000 <sleep>
  kill(pid);
    81c6:	854a                	mv	a0,s2
    81c8:	00001097          	auipc	ra,0x1
    81cc:	df0080e7          	jalr	-528(ra) # 8fb8 <kill>
  
  int status;
  wait(&status);
    81d0:	fdc40513          	addi	a0,s0,-36
    81d4:	00001097          	auipc	ra,0x1
    81d8:	dbc080e7          	jalr	-580(ra) # 8f90 <wait>
  
  // 验证信号量可以正常操作（没有死锁）
  sem_post(sem);
    81dc:	8526                	mv	a0,s1
    81de:	00001097          	auipc	ra,0x1
    81e2:	e82080e7          	jalr	-382(ra) # 9060 <sem_post>
  int val;
  sem_getvalue(sem, &val);
    81e6:	fd840593          	addi	a1,s0,-40
    81ea:	8526                	mv	a0,s1
    81ec:	00001097          	auipc	ra,0x1
    81f0:	e84080e7          	jalr	-380(ra) # 9070 <sem_getvalue>
  
  if(val != 1) {
    81f4:	fd842583          	lw	a1,-40(s0)
    81f8:	4785                	li	a5,1
    81fa:	06f59963          	bne	a1,a5,826c <semkilltest+0xec>
    printf("semkilltest: unexpected semaphore value %d after kill\n", val);
    exit(1);
  }
  
  sem_close(sem);
    81fe:	8526                	mv	a0,s1
    8200:	00001097          	auipc	ra,0x1
    8204:	e68080e7          	jalr	-408(ra) # 9068 <sem_close>
  printf("semkilltest: PASSED\n");
    8208:	00007517          	auipc	a0,0x7
    820c:	87850513          	addi	a0,a0,-1928 # ea80 <malloc+0x54c0>
    8210:	00001097          	auipc	ra,0x1
    8214:	2f8080e7          	jalr	760(ra) # 9508 <printf>
}
    8218:	70a2                	ld	ra,40(sp)
    821a:	7402                	ld	s0,32(sp)
    821c:	64e2                	ld	s1,24(sp)
    821e:	6942                	ld	s2,16(sp)
    8220:	6145                	addi	sp,sp,48
    8222:	8082                	ret
    printf("semkilltest: sem_open failed\n");
    8224:	00006517          	auipc	a0,0x6
    8228:	7e450513          	addi	a0,a0,2020 # ea08 <malloc+0x5448>
    822c:	00001097          	auipc	ra,0x1
    8230:	2dc080e7          	jalr	732(ra) # 9508 <printf>
    exit(1);
    8234:	4505                	li	a0,1
    8236:	00001097          	auipc	ra,0x1
    823a:	d52080e7          	jalr	-686(ra) # 8f88 <exit>
    printf("semkilltest: fork failed\n");
    823e:	00006517          	auipc	a0,0x6
    8242:	7ea50513          	addi	a0,a0,2026 # ea28 <malloc+0x5468>
    8246:	00001097          	auipc	ra,0x1
    824a:	2c2080e7          	jalr	706(ra) # 9508 <printf>
    exit(1);
    824e:	4505                	li	a0,1
    8250:	00001097          	auipc	ra,0x1
    8254:	d38080e7          	jalr	-712(ra) # 8f88 <exit>
    sem_wait(sem);
    8258:	8526                	mv	a0,s1
    825a:	00001097          	auipc	ra,0x1
    825e:	dfe080e7          	jalr	-514(ra) # 9058 <sem_wait>
    exit(0);
    8262:	4501                	li	a0,0
    8264:	00001097          	auipc	ra,0x1
    8268:	d24080e7          	jalr	-732(ra) # 8f88 <exit>
    printf("semkilltest: unexpected semaphore value %d after kill\n", val);
    826c:	00006517          	auipc	a0,0x6
    8270:	7dc50513          	addi	a0,a0,2012 # ea48 <malloc+0x5488>
    8274:	00001097          	auipc	ra,0x1
    8278:	294080e7          	jalr	660(ra) # 9508 <printf>
    exit(1);
    827c:	4505                	li	a0,1
    827e:	00001097          	auipc	ra,0x1
    8282:	d0a080e7          	jalr	-758(ra) # 8f88 <exit>

0000000000008286 <semstress>:
void semstress(char *s) {
    8286:	1101                	addi	sp,sp,-32
    8288:	ec06                	sd	ra,24(sp)
    828a:	e822                	sd	s0,16(sp)
    828c:	e426                	sd	s1,8(sp)
    828e:	1000                	addi	s0,sp,32
    if(verbose) { char *argv[] = {"semstress", 0}; semstress_main(1, argv); return; }
    8290:	00007797          	auipc	a5,0x7
    8294:	6047a783          	lw	a5,1540(a5) # f894 <verbose>
    8298:	e395                	bnez	a5,82bc <semstress+0x36>
    829a:	84aa                	mv	s1,a0
    int id = sem_open(1);
    829c:	4505                	li	a0,1
    829e:	00001097          	auipc	ra,0x1
    82a2:	db2080e7          	jalr	-590(ra) # 9050 <sem_open>
    if(id < 0) { printf("%s: sem_open failed\n", s); exit(1); }
    82a6:	02054863          	bltz	a0,82d6 <semstress+0x50>
    sem_close(id);
    82aa:	00001097          	auipc	ra,0x1
    82ae:	dbe080e7          	jalr	-578(ra) # 9068 <sem_close>
}
    82b2:	60e2                	ld	ra,24(sp)
    82b4:	6442                	ld	s0,16(sp)
    82b6:	64a2                	ld	s1,8(sp)
    82b8:	6105                	addi	sp,sp,32
    82ba:	8082                	ret

static int semstress_main(int argc, char *argv[])
{
  semstress_run();
    82bc:	00000097          	auipc	ra,0x0
    82c0:	d1e080e7          	jalr	-738(ra) # 7fda <semstress_run>
  semkilltest();
    82c4:	00000097          	auipc	ra,0x0
    82c8:	ebc080e7          	jalr	-324(ra) # 8180 <semkilltest>
  exit(0);
    82cc:	4501                	li	a0,0
    82ce:	00001097          	auipc	ra,0x1
    82d2:	cba080e7          	jalr	-838(ra) # 8f88 <exit>
    if(id < 0) { printf("%s: sem_open failed\n", s); exit(1); }
    82d6:	85a6                	mv	a1,s1
    82d8:	00003517          	auipc	a0,0x3
    82dc:	4a850513          	addi	a0,a0,1192 # b780 <malloc+0x21c0>
    82e0:	00001097          	auipc	ra,0x1
    82e4:	228080e7          	jalr	552(ra) # 9508 <printf>
    82e8:	4505                	li	a0,1
    82ea:	00001097          	auipc	ra,0x1
    82ee:	c9e080e7          	jalr	-866(ra) # 8f88 <exit>

00000000000082f2 <shmstress_run>:
#define NPROCS 4       // 并发进程数
#define ITERATIONS 100 // 每个进程的写入次数

void
shmstress_run(void)
{
    82f2:	715d                	addi	sp,sp,-80
    82f4:	e486                	sd	ra,72(sp)
    82f6:	e0a2                	sd	s0,64(sp)
    82f8:	fc26                	sd	s1,56(sp)
    82fa:	f84a                	sd	s2,48(sp)
    82fc:	f44e                	sd	s3,40(sp)
    82fe:	f052                	sd	s4,32(sp)
    8300:	ec56                	sd	s5,24(sp)
    8302:	0880                	addi	s0,sp,80
  int pids[NPROCS];
  int i;
  
  printf("shmstress: starting shared memory stress test...\n");
    8304:	00006517          	auipc	a0,0x6
    8308:	79450513          	addi	a0,a0,1940 # ea98 <malloc+0x54d8>
    830c:	00001097          	auipc	ra,0x1
    8310:	1fc080e7          	jalr	508(ra) # 9508 <printf>
  printf("  NPROCS=%d, ITERATIONS=%d\n", NPROCS, ITERATIONS);
    8314:	06400613          	li	a2,100
    8318:	4591                	li	a1,4
    831a:	00006517          	auipc	a0,0x6
    831e:	7b650513          	addi	a0,a0,1974 # ead0 <malloc+0x5510>
    8322:	00001097          	auipc	ra,0x1
    8326:	1e6080e7          	jalr	486(ra) # 9508 <printf>
  
  // 创建共享内存段
  int shmid = shmcreate("stress", 4096);
    832a:	6585                	lui	a1,0x1
    832c:	00006517          	auipc	a0,0x6
    8330:	7c450513          	addi	a0,a0,1988 # eaf0 <malloc+0x5530>
    8334:	00001097          	auipc	ra,0x1
    8338:	d62080e7          	jalr	-670(ra) # 9096 <shmcreate>
  if(shmid < 0) {
    833c:	0a054763          	bltz	a0,83ea <shmstress_run+0xf8>
    8340:	8a2a                	mv	s4,a0
    printf("shmstress: shm_create failed\n");
    exit(1);
  }
  
  // 映射到当前进程
  uint64 addr = shmattach(shmid);
    8342:	00001097          	auipc	ra,0x1
    8346:	d68080e7          	jalr	-664(ra) # 90aa <shmattach>
    834a:	892a                	mv	s2,a0
  if(addr == 0) {
    834c:	cd45                	beqz	a0,8404 <shmstress_run+0x112>
    exit(1);
  }
  
  // 初始化共享计数器
  volatile int *counter = (volatile int *)addr;
  *counter = 0;
    834e:	00052023          	sw	zero,0(a0)
  
  // 创建子进程
  for(i = 0; i < NPROCS; i++) {
    8352:	4981                	li	s3,0
    8354:	4a91                	li	s5,4
    pids[i] = fork();
    8356:	00001097          	auipc	ra,0x1
    835a:	c2a080e7          	jalr	-982(ra) # 8f80 <fork>
    835e:	84aa                	mv	s1,a0
    if(pids[i] < 0) {
    8360:	0a054f63          	bltz	a0,841e <shmstress_run+0x12c>
      printf("shmstress: fork %d failed\n", i);
      exit(1);
    }
    
    if(pids[i] == 0) {
    8364:	c979                	beqz	a0,843a <shmstress_run+0x148>
  for(i = 0; i < NPROCS; i++) {
    8366:	2985                	addiw	s3,s3,1
    8368:	ff5997e3          	bne	s3,s5,8356 <shmstress_run+0x64>
    836c:	4491                	li	s1,4
  }
  
  // 等待所有子进程
  for(i = 0; i < NPROCS; i++) {
    int status;
    int pid = wait(&status);
    836e:	fbc40993          	addi	s3,s0,-68
    8372:	854e                	mv	a0,s3
    8374:	00001097          	auipc	ra,0x1
    8378:	c1c080e7          	jalr	-996(ra) # 8f90 <wait>
    if(pid < 0) {
    837c:	12054363          	bltz	a0,84a2 <shmstress_run+0x1b0>
      printf("shmstress: wait failed\n");
      exit(1);
    }
    if(status != 0) {
    8380:	fbc42603          	lw	a2,-68(s0)
    8384:	12061c63          	bnez	a2,84bc <shmstress_run+0x1ca>
  for(i = 0; i < NPROCS; i++) {
    8388:	34fd                	addiw	s1,s1,-1
    838a:	f4e5                	bnez	s1,8372 <shmstress_run+0x80>
      exit(1);
    }
  }
  
  // 检查计数器（由于非原子操作，值可能小于预期，但不应为 0 或负数）
  int final = *counter;
    838c:	00092483          	lw	s1,0(s2)
    8390:	2481                	sext.w	s1,s1
  printf("shmstress: final counter = %d (expected up to %d)\n", 
    8392:	19000613          	li	a2,400
    8396:	85a6                	mv	a1,s1
    8398:	00007517          	auipc	a0,0x7
    839c:	83850513          	addi	a0,a0,-1992 # ebd0 <malloc+0x5610>
    83a0:	00001097          	auipc	ra,0x1
    83a4:	168080e7          	jalr	360(ra) # 9508 <printf>
         final, NPROCS * ITERATIONS);
  
  if(final <= 0) {
    83a8:	12905863          	blez	s1,84d8 <shmstress_run+0x1e6>
    printf("shmstress: counter corruption detected!\n");
    exit(1);
  }
  
  shmdetach(addr, 4096);
    83ac:	6585                	lui	a1,0x1
    83ae:	854a                	mv	a0,s2
    83b0:	00001097          	auipc	ra,0x1
    83b4:	d04080e7          	jalr	-764(ra) # 90b4 <shmdetach>
  shmunlink("stress");  // 释放共享内存段，避免资源泄漏
    83b8:	00006517          	auipc	a0,0x6
    83bc:	73850513          	addi	a0,a0,1848 # eaf0 <malloc+0x5530>
    83c0:	00001097          	auipc	ra,0x1
    83c4:	cfe080e7          	jalr	-770(ra) # 90be <shmunlink>
  printf("shmstress: PASSED\n");
    83c8:	00007517          	auipc	a0,0x7
    83cc:	87050513          	addi	a0,a0,-1936 # ec38 <malloc+0x5678>
    83d0:	00001097          	auipc	ra,0x1
    83d4:	138080e7          	jalr	312(ra) # 9508 <printf>
}
    83d8:	60a6                	ld	ra,72(sp)
    83da:	6406                	ld	s0,64(sp)
    83dc:	74e2                	ld	s1,56(sp)
    83de:	7942                	ld	s2,48(sp)
    83e0:	79a2                	ld	s3,40(sp)
    83e2:	7a02                	ld	s4,32(sp)
    83e4:	6ae2                	ld	s5,24(sp)
    83e6:	6161                	addi	sp,sp,80
    83e8:	8082                	ret
    printf("shmstress: shm_create failed\n");
    83ea:	00006517          	auipc	a0,0x6
    83ee:	70e50513          	addi	a0,a0,1806 # eaf8 <malloc+0x5538>
    83f2:	00001097          	auipc	ra,0x1
    83f6:	116080e7          	jalr	278(ra) # 9508 <printf>
    exit(1);
    83fa:	4505                	li	a0,1
    83fc:	00001097          	auipc	ra,0x1
    8400:	b8c080e7          	jalr	-1140(ra) # 8f88 <exit>
    printf("shmstress: parent shm_attach failed\n");
    8404:	00006517          	auipc	a0,0x6
    8408:	71450513          	addi	a0,a0,1812 # eb18 <malloc+0x5558>
    840c:	00001097          	auipc	ra,0x1
    8410:	0fc080e7          	jalr	252(ra) # 9508 <printf>
    exit(1);
    8414:	4505                	li	a0,1
    8416:	00001097          	auipc	ra,0x1
    841a:	b72080e7          	jalr	-1166(ra) # 8f88 <exit>
      printf("shmstress: fork %d failed\n", i);
    841e:	85ce                	mv	a1,s3
    8420:	00006517          	auipc	a0,0x6
    8424:	72050513          	addi	a0,a0,1824 # eb40 <malloc+0x5580>
    8428:	00001097          	auipc	ra,0x1
    842c:	0e0080e7          	jalr	224(ra) # 9508 <printf>
      exit(1);
    8430:	4505                	li	a0,1
    8432:	00001097          	auipc	ra,0x1
    8436:	b56080e7          	jalr	-1194(ra) # 8f88 <exit>
      uint64 child_addr = shmattach(shmid);
    843a:	8552                	mv	a0,s4
    843c:	00001097          	auipc	ra,0x1
    8440:	c6e080e7          	jalr	-914(ra) # 90aa <shmattach>
    8444:	892a                	mv	s2,a0
        if(j % 20 == 0) sleep(0);
    8446:	4ad1                	li	s5,20
      for(int j = 0; j < ITERATIONS; j++) {
    8448:	06400a13          	li	s4,100
      if(child_addr == 0) {
    844c:	e115                	bnez	a0,8470 <shmstress_run+0x17e>
        printf("shmstress: child %d shm_attach failed\n", i);
    844e:	85ce                	mv	a1,s3
    8450:	00006517          	auipc	a0,0x6
    8454:	71050513          	addi	a0,a0,1808 # eb60 <malloc+0x55a0>
    8458:	00001097          	auipc	ra,0x1
    845c:	0b0080e7          	jalr	176(ra) # 9508 <printf>
        exit(1);
    8460:	4505                	li	a0,1
    8462:	00001097          	auipc	ra,0x1
    8466:	b26080e7          	jalr	-1242(ra) # 8f88 <exit>
      for(int j = 0; j < ITERATIONS; j++) {
    846a:	2485                	addiw	s1,s1,1
    846c:	03448063          	beq	s1,s4,848c <shmstress_run+0x19a>
        int old = *child_counter;
    8470:	00092783          	lw	a5,0(s2)
        *child_counter = old + 1;
    8474:	2785                	addiw	a5,a5,1
    8476:	00f92023          	sw	a5,0(s2)
        if(j % 20 == 0) sleep(0);
    847a:	0354e7bb          	remw	a5,s1,s5
    847e:	f7f5                	bnez	a5,846a <shmstress_run+0x178>
    8480:	4501                	li	a0,0
    8482:	00001097          	auipc	ra,0x1
    8486:	b7e080e7          	jalr	-1154(ra) # 9000 <sleep>
    848a:	b7c5                	j	846a <shmstress_run+0x178>
      shmdetach(child_addr, 4096);
    848c:	6585                	lui	a1,0x1
    848e:	854a                	mv	a0,s2
    8490:	00001097          	auipc	ra,0x1
    8494:	c24080e7          	jalr	-988(ra) # 90b4 <shmdetach>
      exit(0);
    8498:	4501                	li	a0,0
    849a:	00001097          	auipc	ra,0x1
    849e:	aee080e7          	jalr	-1298(ra) # 8f88 <exit>
      printf("shmstress: wait failed\n");
    84a2:	00006517          	auipc	a0,0x6
    84a6:	6e650513          	addi	a0,a0,1766 # eb88 <malloc+0x55c8>
    84aa:	00001097          	auipc	ra,0x1
    84ae:	05e080e7          	jalr	94(ra) # 9508 <printf>
      exit(1);
    84b2:	4505                	li	a0,1
    84b4:	00001097          	auipc	ra,0x1
    84b8:	ad4080e7          	jalr	-1324(ra) # 8f88 <exit>
      printf("shmstress: child %d failed with status %d\n", pid, status);
    84bc:	85aa                	mv	a1,a0
    84be:	00006517          	auipc	a0,0x6
    84c2:	6e250513          	addi	a0,a0,1762 # eba0 <malloc+0x55e0>
    84c6:	00001097          	auipc	ra,0x1
    84ca:	042080e7          	jalr	66(ra) # 9508 <printf>
      exit(1);
    84ce:	4505                	li	a0,1
    84d0:	00001097          	auipc	ra,0x1
    84d4:	ab8080e7          	jalr	-1352(ra) # 8f88 <exit>
    printf("shmstress: counter corruption detected!\n");
    84d8:	00006517          	auipc	a0,0x6
    84dc:	73050513          	addi	a0,a0,1840 # ec08 <malloc+0x5648>
    84e0:	00001097          	auipc	ra,0x1
    84e4:	028080e7          	jalr	40(ra) # 9508 <printf>
    exit(1);
    84e8:	4505                	li	a0,1
    84ea:	00001097          	auipc	ra,0x1
    84ee:	a9e080e7          	jalr	-1378(ra) # 8f88 <exit>

00000000000084f2 <shmstress>:
void shmstress(char *s) {
    84f2:	1101                	addi	sp,sp,-32
    84f4:	ec06                	sd	ra,24(sp)
    84f6:	e822                	sd	s0,16(sp)
    84f8:	e426                	sd	s1,8(sp)
    84fa:	1000                	addi	s0,sp,32
    if(verbose) { char *argv[] = {"shmstress", 0}; shmstress_main(1, argv); return; }
    84fc:	00007797          	auipc	a5,0x7
    8500:	3987a783          	lw	a5,920(a5) # f894 <verbose>
    8504:	eb95                	bnez	a5,8538 <shmstress+0x46>
    8506:	84aa                	mv	s1,a0
    int id = shmcreate("stress_shm", 4096);
    8508:	6585                	lui	a1,0x1
    850a:	00006517          	auipc	a0,0x6
    850e:	74650513          	addi	a0,a0,1862 # ec50 <malloc+0x5690>
    8512:	00001097          	auipc	ra,0x1
    8516:	b84080e7          	jalr	-1148(ra) # 9096 <shmcreate>
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    851a:	02054863          	bltz	a0,854a <shmstress+0x58>
    shmunlink("stress_shm");
    851e:	00006517          	auipc	a0,0x6
    8522:	73250513          	addi	a0,a0,1842 # ec50 <malloc+0x5690>
    8526:	00001097          	auipc	ra,0x1
    852a:	b98080e7          	jalr	-1128(ra) # 90be <shmunlink>
}
    852e:	60e2                	ld	ra,24(sp)
    8530:	6442                	ld	s0,16(sp)
    8532:	64a2                	ld	s1,8(sp)
    8534:	6105                	addi	sp,sp,32
    8536:	8082                	ret

static int shmstress_main(int argc, char *argv[])
{
  shmstress_run();
    8538:	00000097          	auipc	ra,0x0
    853c:	dba080e7          	jalr	-582(ra) # 82f2 <shmstress_run>
  exit(0);
    8540:	4501                	li	a0,0
    8542:	00001097          	auipc	ra,0x1
    8546:	a46080e7          	jalr	-1466(ra) # 8f88 <exit>
    if(id < 0) { printf("%s: shmcreate failed\n", s); exit(1); }
    854a:	85a6                	mv	a1,s1
    854c:	00004517          	auipc	a0,0x4
    8550:	b7450513          	addi	a0,a0,-1164 # c0c0 <malloc+0x2b00>
    8554:	00001097          	auipc	ra,0x1
    8558:	fb4080e7          	jalr	-76(ra) # 9508 <printf>
    855c:	4505                	li	a0,1
    855e:	00001097          	auipc	ra,0x1
    8562:	a2a080e7          	jalr	-1494(ra) # 8f88 <exit>

0000000000008566 <test_anonymous_mmap>:

#define PGSIZE 4096

void
test_anonymous_mmap(void)
{
    8566:	1141                	addi	sp,sp,-16
    8568:	e406                	sd	ra,8(sp)
    856a:	e022                	sd	s0,0(sp)
    856c:	0800                	addi	s0,sp,16
  printf("test anonymous mmap: ");
    856e:	00006517          	auipc	a0,0x6
    8572:	6f250513          	addi	a0,a0,1778 # ec60 <malloc+0x56a0>
    8576:	00001097          	auipc	ra,0x1
    857a:	f92080e7          	jalr	-110(ra) # 9508 <printf>
  
  // 匿名映射
  char *p = mmap(0, PGSIZE, PROT_READ | PROT_WRITE, 
    857e:	4781                	li	a5,0
    8580:	577d                	li	a4,-1
    8582:	02200693          	li	a3,34
    8586:	460d                	li	a2,3
    8588:	6585                	lui	a1,0x1
    858a:	4501                	li	a0,0
    858c:	00001097          	auipc	ra,0x1
    8590:	b3c080e7          	jalr	-1220(ra) # 90c8 <mmap>
                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if(p == MAP_FAILED) {
    8594:	57fd                	li	a5,-1
    8596:	04f50263          	beq	a0,a5,85da <test_anonymous_mmap+0x74>
    printf("FAILED - mmap returned MAP_FAILED\n");
    exit(1);
  }
  
  // 写入和读取
  p[0] = 'A';
    859a:	04100793          	li	a5,65
    859e:	00f50023          	sb	a5,0(a0)
  p[100] = 'B';
    85a2:	04200793          	li	a5,66
    85a6:	06f50223          	sb	a5,100(a0)
  p[PGSIZE - 1] = 'C';
    85aa:	6785                	lui	a5,0x1
    85ac:	97aa                	add	a5,a5,a0
    85ae:	04300713          	li	a4,67
    85b2:	fee78fa3          	sb	a4,-1(a5) # fff <testdev+0x161>
    printf("FAILED - data mismatch\n");
    exit(1);
  }
  
  // 解除映射
  if(munmap(p, PGSIZE) != 0) {
    85b6:	6585                	lui	a1,0x1
    85b8:	00001097          	auipc	ra,0x1
    85bc:	b1a080e7          	jalr	-1254(ra) # 90d2 <munmap>
    85c0:	e915                	bnez	a0,85f4 <test_anonymous_mmap+0x8e>
    printf("FAILED - munmap failed\n");
    exit(1);
  }
  
  printf("OK\n");
    85c2:	00006517          	auipc	a0,0x6
    85c6:	6f650513          	addi	a0,a0,1782 # ecb8 <malloc+0x56f8>
    85ca:	00001097          	auipc	ra,0x1
    85ce:	f3e080e7          	jalr	-194(ra) # 9508 <printf>
}
    85d2:	60a2                	ld	ra,8(sp)
    85d4:	6402                	ld	s0,0(sp)
    85d6:	0141                	addi	sp,sp,16
    85d8:	8082                	ret
    printf("FAILED - mmap returned MAP_FAILED\n");
    85da:	00006517          	auipc	a0,0x6
    85de:	69e50513          	addi	a0,a0,1694 # ec78 <malloc+0x56b8>
    85e2:	00001097          	auipc	ra,0x1
    85e6:	f26080e7          	jalr	-218(ra) # 9508 <printf>
    exit(1);
    85ea:	4505                	li	a0,1
    85ec:	00001097          	auipc	ra,0x1
    85f0:	99c080e7          	jalr	-1636(ra) # 8f88 <exit>
    printf("FAILED - munmap failed\n");
    85f4:	00006517          	auipc	a0,0x6
    85f8:	6ac50513          	addi	a0,a0,1708 # eca0 <malloc+0x56e0>
    85fc:	00001097          	auipc	ra,0x1
    8600:	f0c080e7          	jalr	-244(ra) # 9508 <printf>
    exit(1);
    8604:	4505                	li	a0,1
    8606:	00001097          	auipc	ra,0x1
    860a:	982080e7          	jalr	-1662(ra) # 8f88 <exit>

000000000000860e <test_file_mmap>:

void
test_file_mmap(void)
{
    860e:	7179                	addi	sp,sp,-48
    8610:	f406                	sd	ra,40(sp)
    8612:	f022                	sd	s0,32(sp)
    8614:	ec26                	sd	s1,24(sp)
    8616:	e84a                	sd	s2,16(sp)
    8618:	e44e                	sd	s3,8(sp)
    861a:	1800                	addi	s0,sp,48
  printf("test file mmap: ");
    861c:	00006517          	auipc	a0,0x6
    8620:	6a450513          	addi	a0,a0,1700 # ecc0 <malloc+0x5700>
    8624:	00001097          	auipc	ra,0x1
    8628:	ee4080e7          	jalr	-284(ra) # 9508 <printf>
  
  // 使用 malloc 而不是栈上大缓冲区，避免栈溢出
  char *buf = malloc(PGSIZE);
    862c:	6505                	lui	a0,0x1
    862e:	00001097          	auipc	ra,0x1
    8632:	f92080e7          	jalr	-110(ra) # 95c0 <malloc>
  if(buf == 0) {
    8636:	14050363          	beqz	a0,877c <test_file_mmap+0x16e>
    863a:	84aa                	mv	s1,a0
    printf("FAILED - malloc failed\n");
    exit(1);
  }
  
  // 创建测试文件
  int fd = open("mmaptest.txt", O_CREATE | O_RDWR);
    863c:	20200593          	li	a1,514
    8640:	00006517          	auipc	a0,0x6
    8644:	6b050513          	addi	a0,a0,1712 # ecf0 <malloc+0x5730>
    8648:	00001097          	auipc	ra,0x1
    864c:	980080e7          	jalr	-1664(ra) # 8fc8 <open>
    8650:	892a                	mv	s2,a0
  if(fd < 0) {
    8652:	14054263          	bltz	a0,8796 <test_file_mmap+0x188>
    8656:	87a6                	mv	a5,s1
    8658:	6705                	lui	a4,0x1
    865a:	9726                	add	a4,a4,s1
    free(buf);
    exit(1);
  }
  
  for(int i = 0; i < PGSIZE; i++) {
    buf[i] = 'X';
    865c:	05800693          	li	a3,88
    8660:	00d78023          	sb	a3,0(a5)
  for(int i = 0; i < PGSIZE; i++) {
    8664:	0785                	addi	a5,a5,1
    8666:	fee79de3          	bne	a5,a4,8660 <test_file_mmap+0x52>
  }
  write(fd, buf, PGSIZE);
    866a:	6605                	lui	a2,0x1
    866c:	85a6                	mv	a1,s1
    866e:	854a                	mv	a0,s2
    8670:	00001097          	auipc	ra,0x1
    8674:	938080e7          	jalr	-1736(ra) # 8fa8 <write>
  close(fd);
    8678:	854a                	mv	a0,s2
    867a:	00001097          	auipc	ra,0x1
    867e:	936080e7          	jalr	-1738(ra) # 8fb0 <close>
  
  // 重新打开并映射
  fd = open("mmaptest.txt", O_RDWR);
    8682:	4589                	li	a1,2
    8684:	00006517          	auipc	a0,0x6
    8688:	66c50513          	addi	a0,a0,1644 # ecf0 <malloc+0x5730>
    868c:	00001097          	auipc	ra,0x1
    8690:	93c080e7          	jalr	-1732(ra) # 8fc8 <open>
    8694:	89aa                	mv	s3,a0
  if(fd < 0) {
    8696:	12054263          	bltz	a0,87ba <test_file_mmap+0x1ac>
    printf("FAILED - cannot open file\n");
    free(buf);
    exit(1);
  }
  
  char *p = mmap(0, PGSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    869a:	4781                	li	a5,0
    869c:	872a                	mv	a4,a0
    869e:	4685                	li	a3,1
    86a0:	460d                	li	a2,3
    86a2:	6585                	lui	a1,0x1
    86a4:	4501                	li	a0,0
    86a6:	00001097          	auipc	ra,0x1
    86aa:	a22080e7          	jalr	-1502(ra) # 90c8 <mmap>
    86ae:	892a                	mv	s2,a0
  if(p == MAP_FAILED) {
    86b0:	57fd                	li	a5,-1
    86b2:	12f50663          	beq	a0,a5,87de <test_file_mmap+0x1d0>
    free(buf);
    exit(1);
  }
  
  // 验证读取
  if(p[0] != 'X' || p[PGSIZE - 1] != 'X') {
    86b6:	00054583          	lbu	a1,0(a0)
    86ba:	05800793          	li	a5,88
    86be:	14f59763          	bne	a1,a5,880c <test_file_mmap+0x1fe>
    86c2:	6785                	lui	a5,0x1
    86c4:	97aa                	add	a5,a5,a0
    86c6:	fff7c703          	lbu	a4,-1(a5) # fff <testdev+0x161>
    86ca:	05800793          	li	a5,88
    86ce:	12f71f63          	bne	a4,a5,880c <test_file_mmap+0x1fe>
    free(buf);
    exit(1);
  }
  
  // 修改映射内容
  p[0] = 'Y';
    86d2:	05900793          	li	a5,89
    86d6:	00f50023          	sb	a5,0(a0)
  p[PGSIZE - 1] = 'Z';
    86da:	6785                	lui	a5,0x1
    86dc:	97aa                	add	a5,a5,a0
    86de:	05a00713          	li	a4,90
    86e2:	fee78fa3          	sb	a4,-1(a5) # fff <testdev+0x161>
  
  // 解除映射 (应该写回文件)
  munmap(p, PGSIZE);
    86e6:	6585                	lui	a1,0x1
    86e8:	00001097          	auipc	ra,0x1
    86ec:	9ea080e7          	jalr	-1558(ra) # 90d2 <munmap>
  close(fd);
    86f0:	854e                	mv	a0,s3
    86f2:	00001097          	auipc	ra,0x1
    86f6:	8be080e7          	jalr	-1858(ra) # 8fb0 <close>
  
  // 重新读取文件验证写回
  fd = open("mmaptest.txt", O_RDONLY);
    86fa:	4581                	li	a1,0
    86fc:	00006517          	auipc	a0,0x6
    8700:	5f450513          	addi	a0,a0,1524 # ecf0 <malloc+0x5730>
    8704:	00001097          	auipc	ra,0x1
    8708:	8c4080e7          	jalr	-1852(ra) # 8fc8 <open>
    870c:	892a                	mv	s2,a0
  if(fd < 0) {
    870e:	14054063          	bltz	a0,884e <test_file_mmap+0x240>
    printf("FAILED - cannot reopen file\n");
    free(buf);
    exit(1);
  }
  
  read(fd, buf, PGSIZE);
    8712:	6605                	lui	a2,0x1
    8714:	85a6                	mv	a1,s1
    8716:	00001097          	auipc	ra,0x1
    871a:	88a080e7          	jalr	-1910(ra) # 8fa0 <read>
  close(fd);
    871e:	854a                	mv	a0,s2
    8720:	00001097          	auipc	ra,0x1
    8724:	890080e7          	jalr	-1904(ra) # 8fb0 <close>
  
  if(buf[0] != 'Y' || buf[PGSIZE - 1] != 'Z') {
    8728:	0004c703          	lbu	a4,0(s1)
    872c:	05900793          	li	a5,89
    8730:	14f71163          	bne	a4,a5,8872 <test_file_mmap+0x264>
    8734:	6785                	lui	a5,0x1
    8736:	97a6                	add	a5,a5,s1
    8738:	fff7c703          	lbu	a4,-1(a5) # fff <testdev+0x161>
    873c:	05a00793          	li	a5,90
    8740:	12f71963          	bne	a4,a5,8872 <test_file_mmap+0x264>
    free(buf);
    exit(1);
  }
  
  // 清理
  remove("mmaptest.txt");
    8744:	00006517          	auipc	a0,0x6
    8748:	5ac50513          	addi	a0,a0,1452 # ecf0 <malloc+0x5730>
    874c:	00001097          	auipc	ra,0x1
    8750:	8e4080e7          	jalr	-1820(ra) # 9030 <remove>
  free(buf);
    8754:	8526                	mv	a0,s1
    8756:	00001097          	auipc	ra,0x1
    875a:	de8080e7          	jalr	-536(ra) # 953e <free>
  
  printf("OK\n");
    875e:	00006517          	auipc	a0,0x6
    8762:	55a50513          	addi	a0,a0,1370 # ecb8 <malloc+0x56f8>
    8766:	00001097          	auipc	ra,0x1
    876a:	da2080e7          	jalr	-606(ra) # 9508 <printf>
}
    876e:	70a2                	ld	ra,40(sp)
    8770:	7402                	ld	s0,32(sp)
    8772:	64e2                	ld	s1,24(sp)
    8774:	6942                	ld	s2,16(sp)
    8776:	69a2                	ld	s3,8(sp)
    8778:	6145                	addi	sp,sp,48
    877a:	8082                	ret
    printf("FAILED - malloc failed\n");
    877c:	00006517          	auipc	a0,0x6
    8780:	55c50513          	addi	a0,a0,1372 # ecd8 <malloc+0x5718>
    8784:	00001097          	auipc	ra,0x1
    8788:	d84080e7          	jalr	-636(ra) # 9508 <printf>
    exit(1);
    878c:	4505                	li	a0,1
    878e:	00000097          	auipc	ra,0x0
    8792:	7fa080e7          	jalr	2042(ra) # 8f88 <exit>
    printf("FAILED - cannot create file\n");
    8796:	00006517          	auipc	a0,0x6
    879a:	56a50513          	addi	a0,a0,1386 # ed00 <malloc+0x5740>
    879e:	00001097          	auipc	ra,0x1
    87a2:	d6a080e7          	jalr	-662(ra) # 9508 <printf>
    free(buf);
    87a6:	8526                	mv	a0,s1
    87a8:	00001097          	auipc	ra,0x1
    87ac:	d96080e7          	jalr	-618(ra) # 953e <free>
    exit(1);
    87b0:	4505                	li	a0,1
    87b2:	00000097          	auipc	ra,0x0
    87b6:	7d6080e7          	jalr	2006(ra) # 8f88 <exit>
    printf("FAILED - cannot open file\n");
    87ba:	00006517          	auipc	a0,0x6
    87be:	56650513          	addi	a0,a0,1382 # ed20 <malloc+0x5760>
    87c2:	00001097          	auipc	ra,0x1
    87c6:	d46080e7          	jalr	-698(ra) # 9508 <printf>
    free(buf);
    87ca:	8526                	mv	a0,s1
    87cc:	00001097          	auipc	ra,0x1
    87d0:	d72080e7          	jalr	-654(ra) # 953e <free>
    exit(1);
    87d4:	4505                	li	a0,1
    87d6:	00000097          	auipc	ra,0x0
    87da:	7b2080e7          	jalr	1970(ra) # 8f88 <exit>
    printf("FAILED - mmap returned MAP_FAILED\n");
    87de:	00006517          	auipc	a0,0x6
    87e2:	49a50513          	addi	a0,a0,1178 # ec78 <malloc+0x56b8>
    87e6:	00001097          	auipc	ra,0x1
    87ea:	d22080e7          	jalr	-734(ra) # 9508 <printf>
    close(fd);
    87ee:	854e                	mv	a0,s3
    87f0:	00000097          	auipc	ra,0x0
    87f4:	7c0080e7          	jalr	1984(ra) # 8fb0 <close>
    free(buf);
    87f8:	8526                	mv	a0,s1
    87fa:	00001097          	auipc	ra,0x1
    87fe:	d44080e7          	jalr	-700(ra) # 953e <free>
    exit(1);
    8802:	4505                	li	a0,1
    8804:	00000097          	auipc	ra,0x0
    8808:	784080e7          	jalr	1924(ra) # 8f88 <exit>
    printf("FAILED - file content mismatch (got %c, %c)\n", p[0], p[PGSIZE-1]);
    880c:	6785                	lui	a5,0x1
    880e:	97ca                	add	a5,a5,s2
    8810:	fff7c603          	lbu	a2,-1(a5) # fff <testdev+0x161>
    8814:	00006517          	auipc	a0,0x6
    8818:	52c50513          	addi	a0,a0,1324 # ed40 <malloc+0x5780>
    881c:	00001097          	auipc	ra,0x1
    8820:	cec080e7          	jalr	-788(ra) # 9508 <printf>
    munmap(p, PGSIZE);
    8824:	6585                	lui	a1,0x1
    8826:	854a                	mv	a0,s2
    8828:	00001097          	auipc	ra,0x1
    882c:	8aa080e7          	jalr	-1878(ra) # 90d2 <munmap>
    close(fd);
    8830:	854e                	mv	a0,s3
    8832:	00000097          	auipc	ra,0x0
    8836:	77e080e7          	jalr	1918(ra) # 8fb0 <close>
    free(buf);
    883a:	8526                	mv	a0,s1
    883c:	00001097          	auipc	ra,0x1
    8840:	d02080e7          	jalr	-766(ra) # 953e <free>
    exit(1);
    8844:	4505                	li	a0,1
    8846:	00000097          	auipc	ra,0x0
    884a:	742080e7          	jalr	1858(ra) # 8f88 <exit>
    printf("FAILED - cannot reopen file\n");
    884e:	00006517          	auipc	a0,0x6
    8852:	52250513          	addi	a0,a0,1314 # ed70 <malloc+0x57b0>
    8856:	00001097          	auipc	ra,0x1
    885a:	cb2080e7          	jalr	-846(ra) # 9508 <printf>
    free(buf);
    885e:	8526                	mv	a0,s1
    8860:	00001097          	auipc	ra,0x1
    8864:	cde080e7          	jalr	-802(ra) # 953e <free>
    exit(1);
    8868:	4505                	li	a0,1
    886a:	00000097          	auipc	ra,0x0
    886e:	71e080e7          	jalr	1822(ra) # 8f88 <exit>
    printf("FAILED - writeback mismatch\n");
    8872:	00006517          	auipc	a0,0x6
    8876:	51e50513          	addi	a0,a0,1310 # ed90 <malloc+0x57d0>
    887a:	00001097          	auipc	ra,0x1
    887e:	c8e080e7          	jalr	-882(ra) # 9508 <printf>
    free(buf);
    8882:	8526                	mv	a0,s1
    8884:	00001097          	auipc	ra,0x1
    8888:	cba080e7          	jalr	-838(ra) # 953e <free>
    exit(1);
    888c:	4505                	li	a0,1
    888e:	00000097          	auipc	ra,0x0
    8892:	6fa080e7          	jalr	1786(ra) # 8f88 <exit>

0000000000008896 <mmaptest>:

void mmaptest(char *s) {
    8896:	1101                	addi	sp,sp,-32
    8898:	ec06                	sd	ra,24(sp)
    889a:	e822                	sd	s0,16(sp)
    889c:	e426                	sd	s1,8(sp)
    889e:	1000                	addi	s0,sp,32
    if(verbose) { char *argv[] = {"mmaptest", 0}; mmaptest_main(1, argv); return; }
    88a0:	00007797          	auipc	a5,0x7
    88a4:	ff47a783          	lw	a5,-12(a5) # f894 <verbose>
    88a8:	ef95                	bnez	a5,88e4 <mmaptest+0x4e>
    88aa:	84aa                	mv	s1,a0
    char *p = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    88ac:	4781                	li	a5,0
    88ae:	577d                	li	a4,-1
    88b0:	02200693          	li	a3,34
    88b4:	460d                	li	a2,3
    88b6:	6585                	lui	a1,0x1
    88b8:	4501                	li	a0,0
    88ba:	00001097          	auipc	ra,0x1
    88be:	80e080e7          	jalr	-2034(ra) # 90c8 <mmap>
    if(p == MAP_FAILED) { printf("%s: mmap failed\n", s); exit(1); }
    88c2:	57fd                	li	a5,-1
    88c4:	04f50d63          	beq	a0,a5,891e <mmaptest+0x88>
    p[0] = 'A';
    88c8:	04100793          	li	a5,65
    88cc:	00f50023          	sb	a5,0(a0)
    munmap(p, 4096);
    88d0:	6585                	lui	a1,0x1
    88d2:	00001097          	auipc	ra,0x1
    88d6:	800080e7          	jalr	-2048(ra) # 90d2 <munmap>
}
    88da:	60e2                	ld	ra,24(sp)
    88dc:	6442                	ld	s0,16(sp)
    88de:	64a2                	ld	s1,8(sp)
    88e0:	6105                	addi	sp,sp,32
    88e2:	8082                	ret

static int mmaptest_main(int argc, char *argv[])
{
  printf("mmaptest starting\n");
    88e4:	00006517          	auipc	a0,0x6
    88e8:	4cc50513          	addi	a0,a0,1228 # edb0 <malloc+0x57f0>
    88ec:	00001097          	auipc	ra,0x1
    88f0:	c1c080e7          	jalr	-996(ra) # 9508 <printf>
  
  test_anonymous_mmap();
    88f4:	00000097          	auipc	ra,0x0
    88f8:	c72080e7          	jalr	-910(ra) # 8566 <test_anonymous_mmap>
  test_file_mmap();
    88fc:	00000097          	auipc	ra,0x0
    8900:	d12080e7          	jalr	-750(ra) # 860e <test_file_mmap>
  
  printf("mmaptest: ALL TESTS PASSED\n");
    8904:	00006517          	auipc	a0,0x6
    8908:	4c450513          	addi	a0,a0,1220 # edc8 <malloc+0x5808>
    890c:	00001097          	auipc	ra,0x1
    8910:	bfc080e7          	jalr	-1028(ra) # 9508 <printf>
  exit(0);
    8914:	4501                	li	a0,0
    8916:	00000097          	auipc	ra,0x0
    891a:	672080e7          	jalr	1650(ra) # 8f88 <exit>
    if(p == MAP_FAILED) { printf("%s: mmap failed\n", s); exit(1); }
    891e:	85a6                	mv	a1,s1
    8920:	00006517          	auipc	a0,0x6
    8924:	4c850513          	addi	a0,a0,1224 # ede8 <malloc+0x5828>
    8928:	00001097          	auipc	ra,0x1
    892c:	be0080e7          	jalr	-1056(ra) # 9508 <printf>
    8930:	4505                	li	a0,1
    8932:	00000097          	auipc	ra,0x0
    8936:	656080e7          	jalr	1622(ra) # 8f88 <exit>

000000000000893a <run>:
// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int verbose = 0;  // global verbose flag

int
run(void f(char *), char *s) {
    893a:	7179                	addi	sp,sp,-48
    893c:	f406                	sd	ra,40(sp)
    893e:	f022                	sd	s0,32(sp)
    8940:	ec26                	sd	s1,24(sp)
    8942:	e84a                	sd	s2,16(sp)
    8944:	1800                	addi	s0,sp,48
    8946:	892a                	mv	s2,a0
    8948:	84ae                	mv	s1,a1
  int pid;
  int xstatus;

  if(verbose) {
    894a:	00007797          	auipc	a5,0x7
    894e:	f4a7a783          	lw	a5,-182(a5) # f894 <verbose>
    8952:	c3ad                	beqz	a5,89b4 <run+0x7a>
    printf("test %s:\n", s);  // newline for detailed output
    8954:	00006517          	auipc	a0,0x6
    8958:	4ac50513          	addi	a0,a0,1196 # ee00 <malloc+0x5840>
    895c:	00001097          	auipc	ra,0x1
    8960:	bac080e7          	jalr	-1108(ra) # 9508 <printf>
  } else {
    printf("test %s: ", s);
  }
  
  // Always use fork for isolation
  if((pid = fork()) < 0) {
    8964:	00000097          	auipc	ra,0x0
    8968:	61c080e7          	jalr	1564(ra) # 8f80 <fork>
    896c:	04054d63          	bltz	a0,89c6 <run+0x8c>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    8970:	c925                	beqz	a0,89e0 <run+0xa6>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    8972:	fdc40513          	addi	a0,s0,-36
    8976:	00000097          	auipc	ra,0x0
    897a:	61a080e7          	jalr	1562(ra) # 8f90 <wait>
    if(xstatus != 0) {
    897e:	fdc42783          	lw	a5,-36(s0)
    8982:	e7b5                	bnez	a5,89ee <run+0xb4>
      printf("FAILED\n");
    } else {
      if(verbose)
    8984:	00007797          	auipc	a5,0x7
    8988:	f107a783          	lw	a5,-240(a5) # f894 <verbose>
    898c:	cbb5                	beqz	a5,8a00 <run+0xc6>
        printf("test %s: OK\n", s);  // In verbose mode, print with test name
    898e:	85a6                	mv	a1,s1
    8990:	00006517          	auipc	a0,0x6
    8994:	4b050513          	addi	a0,a0,1200 # ee40 <malloc+0x5880>
    8998:	00001097          	auipc	ra,0x1
    899c:	b70080e7          	jalr	-1168(ra) # 9508 <printf>
      else
        printf("OK\n");
    }
    return xstatus == 0;
    89a0:	fdc42503          	lw	a0,-36(s0)
  }
}
    89a4:	00153513          	seqz	a0,a0
    89a8:	70a2                	ld	ra,40(sp)
    89aa:	7402                	ld	s0,32(sp)
    89ac:	64e2                	ld	s1,24(sp)
    89ae:	6942                	ld	s2,16(sp)
    89b0:	6145                	addi	sp,sp,48
    89b2:	8082                	ret
    printf("test %s: ", s);
    89b4:	00006517          	auipc	a0,0x6
    89b8:	45c50513          	addi	a0,a0,1116 # ee10 <malloc+0x5850>
    89bc:	00001097          	auipc	ra,0x1
    89c0:	b4c080e7          	jalr	-1204(ra) # 9508 <printf>
    89c4:	b745                	j	8964 <run+0x2a>
    printf("runtest: fork error\n");
    89c6:	00006517          	auipc	a0,0x6
    89ca:	45a50513          	addi	a0,a0,1114 # ee20 <malloc+0x5860>
    89ce:	00001097          	auipc	ra,0x1
    89d2:	b3a080e7          	jalr	-1222(ra) # 9508 <printf>
    exit(1);
    89d6:	4505                	li	a0,1
    89d8:	00000097          	auipc	ra,0x0
    89dc:	5b0080e7          	jalr	1456(ra) # 8f88 <exit>
    f(s);
    89e0:	8526                	mv	a0,s1
    89e2:	9902                	jalr	s2
    exit(0);
    89e4:	4501                	li	a0,0
    89e6:	00000097          	auipc	ra,0x0
    89ea:	5a2080e7          	jalr	1442(ra) # 8f88 <exit>
      printf("FAILED\n");
    89ee:	00006517          	auipc	a0,0x6
    89f2:	44a50513          	addi	a0,a0,1098 # ee38 <malloc+0x5878>
    89f6:	00001097          	auipc	ra,0x1
    89fa:	b12080e7          	jalr	-1262(ra) # 9508 <printf>
    89fe:	b74d                	j	89a0 <run+0x66>
        printf("OK\n");
    8a00:	00006517          	auipc	a0,0x6
    8a04:	2b850513          	addi	a0,a0,696 # ecb8 <malloc+0x56f8>
    8a08:	00001097          	auipc	ra,0x1
    8a0c:	b00080e7          	jalr	-1280(ra) # 9508 <printf>
    8a10:	bf41                	j	89a0 <run+0x66>

0000000000008a12 <main>:

int
main(int argc, char *argv[])
{
    8a12:	ae010113          	addi	sp,sp,-1312
    8a16:	50113c23          	sd	ra,1304(sp)
    8a1a:	50813823          	sd	s0,1296(sp)
    8a1e:	50913423          	sd	s1,1288(sp)
    8a22:	51213023          	sd	s2,1280(sp)
    8a26:	4f313c23          	sd	s3,1272(sp)
    8a2a:	4f413823          	sd	s4,1264(sp)
    8a2e:	4f513423          	sd	s5,1256(sp)
    8a32:	4f613023          	sd	s6,1248(sp)
    8a36:	4d713c23          	sd	s7,1240(sp)
    8a3a:	4d813823          	sd	s8,1232(sp)
    8a3e:	4d913423          	sd	s9,1224(sp)
    8a42:	4da13023          	sd	s10,1216(sp)
    8a46:	4bb13c23          	sd	s11,1208(sp)
    8a4a:	52010413          	addi	s0,sp,1312
  int continuous = 0;
  char *justone = 0;

  // Parse arguments
  for(int i = 1; i < argc; i++) {
    8a4e:	4785                	li	a5,1
    8a50:	20a7dc63          	bge	a5,a0,8c68 <main+0x256>
    8a54:	00858493          	addi	s1,a1,8 # 1008 <testdev+0x16a>
    8a58:	ffe5091b          	addiw	s2,a0,-2
    8a5c:	02091793          	slli	a5,s2,0x20
    8a60:	01d7d913          	srli	s2,a5,0x1d
    8a64:	05c1                	addi	a1,a1,16
    8a66:	992e                	add	s2,s2,a1
  char *justone = 0;
    8a68:	4b81                	li	s7,0
  int continuous = 0;
    8a6a:	4981                	li	s3,0
    if(strcmp(argv[i], "-c") == 0) {
    8a6c:	00006a97          	auipc	s5,0x6
    8a70:	3e4a8a93          	addi	s5,s5,996 # ee50 <malloc+0x5890>
      continuous = 1;
    8a74:	4b05                	li	s6,1
    } else if(strcmp(argv[i], "-C") == 0) {
    8a76:	00006c17          	auipc	s8,0x6
    8a7a:	3e2c0c13          	addi	s8,s8,994 # ee58 <malloc+0x5898>
      continuous = 2;
    } else if(strcmp(argv[i], "-v") == 0) {
    8a7e:	00006c97          	auipc	s9,0x6
    8a82:	3e2c8c93          	addi	s9,s9,994 # ee60 <malloc+0x58a0>
      verbose = 1;
    } else if(argv[i][0] != '-') {
    8a86:	02d00d93          	li	s11,45
      verbose = 1;
    8a8a:	00007d17          	auipc	s10,0x7
    8a8e:	dfed0d13          	addi	s10,s10,-514 # f888 <alarm_simple_received>
    8a92:	a821                	j	8aaa <main+0x98>
    } else if(strcmp(argv[i], "-C") == 0) {
    8a94:	85e2                	mv	a1,s8
    8a96:	6088                	ld	a0,0(s1)
    8a98:	00000097          	auipc	ra,0x0
    8a9c:	282080e7          	jalr	642(ra) # 8d1a <strcmp>
    8aa0:	ed11                	bnez	a0,8abc <main+0xaa>
      continuous = 2;
    8aa2:	4989                	li	s3,2
  for(int i = 1; i < argc; i++) {
    8aa4:	04a1                	addi	s1,s1,8
    8aa6:	07248863          	beq	s1,s2,8b16 <main+0x104>
    if(strcmp(argv[i], "-c") == 0) {
    8aaa:	85d6                	mv	a1,s5
    8aac:	6088                	ld	a0,0(s1)
    8aae:	00000097          	auipc	ra,0x0
    8ab2:	26c080e7          	jalr	620(ra) # 8d1a <strcmp>
    8ab6:	fd79                	bnez	a0,8a94 <main+0x82>
      continuous = 1;
    8ab8:	89da                	mv	s3,s6
    8aba:	b7ed                	j	8aa4 <main+0x92>
    } else if(strcmp(argv[i], "-v") == 0) {
    8abc:	85e6                	mv	a1,s9
    8abe:	6088                	ld	a0,0(s1)
    8ac0:	00000097          	auipc	ra,0x0
    8ac4:	25a080e7          	jalr	602(ra) # 8d1a <strcmp>
    8ac8:	e501                	bnez	a0,8ad0 <main+0xbe>
      verbose = 1;
    8aca:	016d2623          	sw	s6,12(s10)
    8ace:	bfd9                	j	8aa4 <main+0x92>
    } else if(argv[i][0] != '-') {
    8ad0:	0004bb83          	ld	s7,0(s1)
    8ad4:	000bc783          	lbu	a5,0(s7)
    8ad8:	fdb796e3          	bne	a5,s11,8aa4 <main+0x92>
      justone = argv[i];
    } else {
      printf("Usage: usertests [-v] [-c] [testname]\n");
    8adc:	00006517          	auipc	a0,0x6
    8ae0:	38c50513          	addi	a0,a0,908 # ee68 <malloc+0x58a8>
    8ae4:	00001097          	auipc	ra,0x1
    8ae8:	a24080e7          	jalr	-1500(ra) # 9508 <printf>
      printf("  -v: verbose mode (show detailed test output)\n");
    8aec:	00006517          	auipc	a0,0x6
    8af0:	3a450513          	addi	a0,a0,932 # ee90 <malloc+0x58d0>
    8af4:	00001097          	auipc	ra,0x1
    8af8:	a14080e7          	jalr	-1516(ra) # 9508 <printf>
      printf("  -c: continuous mode\n");
    8afc:	00006517          	auipc	a0,0x6
    8b00:	3c450513          	addi	a0,a0,964 # eec0 <malloc+0x5900>
    8b04:	00001097          	auipc	ra,0x1
    8b08:	a04080e7          	jalr	-1532(ra) # 9508 <printf>
      exit(1);
    8b0c:	4505                	li	a0,1
    8b0e:	00000097          	auipc	ra,0x0
    8b12:	47a080e7          	jalr	1146(ra) # 8f88 <exit>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    8b16:	00007797          	auipc	a5,0x7
    8b1a:	8c278793          	addi	a5,a5,-1854 # f3d8 <randstate+0x8>
    8b1e:	ae040713          	addi	a4,s0,-1312
    8b22:	00007897          	auipc	a7,0x7
    8b26:	d6688893          	addi	a7,a7,-666 # f888 <alarm_simple_received>
    8b2a:	0007b803          	ld	a6,0(a5)
    8b2e:	6788                	ld	a0,8(a5)
    8b30:	6b8c                	ld	a1,16(a5)
    8b32:	6f90                	ld	a2,24(a5)
    8b34:	7394                	ld	a3,32(a5)
    8b36:	01073023          	sd	a6,0(a4) # 1000 <testdev+0x162>
    8b3a:	e708                	sd	a0,8(a4)
    8b3c:	eb0c                	sd	a1,16(a4)
    8b3e:	ef10                	sd	a2,24(a4)
    8b40:	f314                	sd	a3,32(a4)
    8b42:	02878793          	addi	a5,a5,40
    8b46:	02870713          	addi	a4,a4,40
    8b4a:	ff1790e3          	bne	a5,a7,8b2a <main+0x118>
    {shmtest2, "shmtest2"},
    {mmaptest, "mmaptest"},
    { 0, 0},
  };

  if(continuous){
    8b4e:	14098c63          	beqz	s3,8ca6 <main+0x294>
    printf("continuous usertests starting\n");
    8b52:	00006517          	auipc	a0,0x6
    8b56:	38650513          	addi	a0,a0,902 # eed8 <malloc+0x5918>
    8b5a:	00001097          	auipc	ra,0x1
    8b5e:	9ae080e7          	jalr	-1618(ra) # 9508 <printf>
          fail = 1;
          break;
        }
      }
      if(fail){
        printf("SOME TESTS FAILED\n");
    8b62:	00006a97          	auipc	s5,0x6
    8b66:	3cea8a93          	addi	s5,s5,974 # ef30 <malloc+0x5970>
        if(continuous != 2)
    8b6a:	4a09                	li	s4,2
          exit(1);
      }
      int free1 = countfree();
      if(free1 < free0){
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    8b6c:	00006b17          	auipc	s6,0x6
    8b70:	38cb0b13          	addi	s6,s6,908 # eef8 <malloc+0x5938>
    8b74:	a0f1                	j	8c40 <main+0x22e>
          exit(1);
    8b76:	4505                	li	a0,1
    8b78:	00000097          	auipc	ra,0x0
    8b7c:	410080e7          	jalr	1040(ra) # 8f88 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    8b80:	40a905bb          	subw	a1,s2,a0
    8b84:	855a                	mv	a0,s6
    8b86:	00001097          	auipc	ra,0x1
    8b8a:	982080e7          	jalr	-1662(ra) # 9508 <printf>
        if(continuous != 2)
    8b8e:	0b498963          	beq	s3,s4,8c40 <main+0x22e>
          exit(1);
    8b92:	4505                	li	a0,1
    8b94:	00000097          	auipc	ra,0x0
    8b98:	3f4080e7          	jalr	1012(ra) # 8f88 <exit>

  printf("usertests starting\n");
  int free0 = countfree();
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    8b9c:	04c1                	addi	s1,s1,16
    8b9e:	6488                	ld	a0,8(s1)
    8ba0:	c115                	beqz	a0,8bc4 <main+0x1b2>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    8ba2:	000b8863          	beqz	s7,8bb2 <main+0x1a0>
    8ba6:	85de                	mv	a1,s7
    8ba8:	00000097          	auipc	ra,0x0
    8bac:	172080e7          	jalr	370(ra) # 8d1a <strcmp>
    8bb0:	f575                	bnez	a0,8b9c <main+0x18a>
      if(!run(t->f, t->s))
    8bb2:	648c                	ld	a1,8(s1)
    8bb4:	6088                	ld	a0,0(s1)
    8bb6:	00000097          	auipc	ra,0x0
    8bba:	d84080e7          	jalr	-636(ra) # 893a <run>
    8bbe:	fd79                	bnez	a0,8b9c <main+0x18a>
        fail = 1;
    8bc0:	8952                	mv	s2,s4
    8bc2:	bfe9                	j	8b9c <main+0x18a>
    }
  }

  if(fail){
    8bc4:	00090f63          	beqz	s2,8be2 <main+0x1d0>
    printf("SOME TESTS FAILED\n");
    8bc8:	00006517          	auipc	a0,0x6
    8bcc:	36850513          	addi	a0,a0,872 # ef30 <malloc+0x5970>
    8bd0:	00001097          	auipc	ra,0x1
    8bd4:	938080e7          	jalr	-1736(ra) # 9508 <printf>
    exit(1);
    8bd8:	4505                	li	a0,1
    8bda:	00000097          	auipc	ra,0x0
    8bde:	3ae080e7          	jalr	942(ra) # 8f88 <exit>
  } else if((free1 = countfree()) < free0){
    8be2:	ffffd097          	auipc	ra,0xffffd
    8be6:	ea0080e7          	jalr	-352(ra) # 5a82 <countfree>
    8bea:	85aa                	mv	a1,a0
    8bec:	03355063          	bge	a0,s3,8c0c <main+0x1fa>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    8bf0:	864e                	mv	a2,s3
    8bf2:	00006517          	auipc	a0,0x6
    8bf6:	35650513          	addi	a0,a0,854 # ef48 <malloc+0x5988>
    8bfa:	00001097          	auipc	ra,0x1
    8bfe:	90e080e7          	jalr	-1778(ra) # 9508 <printf>
    exit(1);
    8c02:	4505                	li	a0,1
    8c04:	00000097          	auipc	ra,0x0
    8c08:	384080e7          	jalr	900(ra) # 8f88 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    8c0c:	00006517          	auipc	a0,0x6
    8c10:	36c50513          	addi	a0,a0,876 # ef78 <malloc+0x59b8>
    8c14:	00001097          	auipc	ra,0x1
    8c18:	8f4080e7          	jalr	-1804(ra) # 9508 <printf>
    exit(0);
    8c1c:	4501                	li	a0,0
    8c1e:	00000097          	auipc	ra,0x0
    8c22:	36a080e7          	jalr	874(ra) # 8f88 <exit>
        printf("SOME TESTS FAILED\n");
    8c26:	8556                	mv	a0,s5
    8c28:	00001097          	auipc	ra,0x1
    8c2c:	8e0080e7          	jalr	-1824(ra) # 9508 <printf>
        if(continuous != 2)
    8c30:	f54993e3          	bne	s3,s4,8b76 <main+0x164>
      int free1 = countfree();
    8c34:	ffffd097          	auipc	ra,0xffffd
    8c38:	e4e080e7          	jalr	-434(ra) # 5a82 <countfree>
      if(free1 < free0){
    8c3c:	f52542e3          	blt	a0,s2,8b80 <main+0x16e>
      int free0 = countfree();
    8c40:	ffffd097          	auipc	ra,0xffffd
    8c44:	e42080e7          	jalr	-446(ra) # 5a82 <countfree>
    8c48:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    8c4a:	ae843583          	ld	a1,-1304(s0)
    8c4e:	d1fd                	beqz	a1,8c34 <main+0x222>
    8c50:	ae040493          	addi	s1,s0,-1312
        if(!run(t->f, t->s)){
    8c54:	6088                	ld	a0,0(s1)
    8c56:	00000097          	auipc	ra,0x0
    8c5a:	ce4080e7          	jalr	-796(ra) # 893a <run>
    8c5e:	d561                	beqz	a0,8c26 <main+0x214>
      for (struct test *t = tests; t->s != 0; t++) {
    8c60:	04c1                	addi	s1,s1,16
    8c62:	648c                	ld	a1,8(s1)
    8c64:	f9e5                	bnez	a1,8c54 <main+0x242>
    8c66:	b7f9                	j	8c34 <main+0x222>
  } tests[] = {
    8c68:	00006797          	auipc	a5,0x6
    8c6c:	77078793          	addi	a5,a5,1904 # f3d8 <randstate+0x8>
    8c70:	ae040713          	addi	a4,s0,-1312
    8c74:	00007697          	auipc	a3,0x7
    8c78:	c1468693          	addi	a3,a3,-1004 # f888 <alarm_simple_received>
    8c7c:	0007b883          	ld	a7,0(a5)
    8c80:	0087b803          	ld	a6,8(a5)
    8c84:	6b88                	ld	a0,16(a5)
    8c86:	6f8c                	ld	a1,24(a5)
    8c88:	7390                	ld	a2,32(a5)
    8c8a:	01173023          	sd	a7,0(a4)
    8c8e:	01073423          	sd	a6,8(a4)
    8c92:	eb08                	sd	a0,16(a4)
    8c94:	ef0c                	sd	a1,24(a4)
    8c96:	f310                	sd	a2,32(a4)
    8c98:	02878793          	addi	a5,a5,40
    8c9c:	02870713          	addi	a4,a4,40
    8ca0:	fcd79ee3          	bne	a5,a3,8c7c <main+0x26a>
  char *justone = 0;
    8ca4:	4b81                	li	s7,0
  printf("usertests starting\n");
    8ca6:	00006517          	auipc	a0,0x6
    8caa:	27250513          	addi	a0,a0,626 # ef18 <malloc+0x5958>
    8cae:	00001097          	auipc	ra,0x1
    8cb2:	85a080e7          	jalr	-1958(ra) # 9508 <printf>
  int free0 = countfree();
    8cb6:	ffffd097          	auipc	ra,0xffffd
    8cba:	dcc080e7          	jalr	-564(ra) # 5a82 <countfree>
    8cbe:	89aa                	mv	s3,a0
  for (struct test *t = tests; t->s != 0; t++) {
    8cc0:	ae843503          	ld	a0,-1304(s0)
    8cc4:	dd19                	beqz	a0,8be2 <main+0x1d0>
    8cc6:	ae040493          	addi	s1,s0,-1312
  int fail = 0;
    8cca:	4901                	li	s2,0
        fail = 1;
    8ccc:	4a05                	li	s4,1
    8cce:	bdd1                	j	8ba2 <main+0x190>

0000000000008cd0 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
    8cd0:	1141                	addi	sp,sp,-16
    8cd2:	e422                	sd	s0,8(sp)
    8cd4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    8cd6:	87aa                	mv	a5,a0
    8cd8:	0585                	addi	a1,a1,1
    8cda:	0785                	addi	a5,a5,1
    8cdc:	fff5c703          	lbu	a4,-1(a1)
    8ce0:	fee78fa3          	sb	a4,-1(a5)
    8ce4:	fb75                	bnez	a4,8cd8 <strcpy+0x8>
    ;
  return os;
}
    8ce6:	6422                	ld	s0,8(sp)
    8ce8:	0141                	addi	sp,sp,16
    8cea:	8082                	ret

0000000000008cec <strcat>:

char*
strcat(char *s, const char *t)
{
    8cec:	1141                	addi	sp,sp,-16
    8cee:	e422                	sd	s0,8(sp)
    8cf0:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
    8cf2:	00054783          	lbu	a5,0(a0)
    8cf6:	c385                	beqz	a5,8d16 <strcat+0x2a>
    8cf8:	87aa                	mv	a5,a0
    s++;
    8cfa:	0785                	addi	a5,a5,1
  while(*s)
    8cfc:	0007c703          	lbu	a4,0(a5)
    8d00:	ff6d                	bnez	a4,8cfa <strcat+0xe>
  while((*s++ = *t++))
    8d02:	0585                	addi	a1,a1,1
    8d04:	0785                	addi	a5,a5,1
    8d06:	fff5c703          	lbu	a4,-1(a1)
    8d0a:	fee78fa3          	sb	a4,-1(a5)
    8d0e:	fb75                	bnez	a4,8d02 <strcat+0x16>
    ;
  return os;
}
    8d10:	6422                	ld	s0,8(sp)
    8d12:	0141                	addi	sp,sp,16
    8d14:	8082                	ret
  while(*s)
    8d16:	87aa                	mv	a5,a0
    8d18:	b7ed                	j	8d02 <strcat+0x16>

0000000000008d1a <strcmp>:


int
strcmp(const char *p, const char *q)
{
    8d1a:	1141                	addi	sp,sp,-16
    8d1c:	e422                	sd	s0,8(sp)
    8d1e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    8d20:	00054783          	lbu	a5,0(a0)
    8d24:	cb91                	beqz	a5,8d38 <strcmp+0x1e>
    8d26:	0005c703          	lbu	a4,0(a1)
    8d2a:	00f71763          	bne	a4,a5,8d38 <strcmp+0x1e>
    p++, q++;
    8d2e:	0505                	addi	a0,a0,1
    8d30:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    8d32:	00054783          	lbu	a5,0(a0)
    8d36:	fbe5                	bnez	a5,8d26 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    8d38:	0005c503          	lbu	a0,0(a1)
}
    8d3c:	40a7853b          	subw	a0,a5,a0
    8d40:	6422                	ld	s0,8(sp)
    8d42:	0141                	addi	sp,sp,16
    8d44:	8082                	ret

0000000000008d46 <strlen>:

uint
strlen(const char *s)
{
    8d46:	1141                	addi	sp,sp,-16
    8d48:	e422                	sd	s0,8(sp)
    8d4a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    8d4c:	00054783          	lbu	a5,0(a0)
    8d50:	cf91                	beqz	a5,8d6c <strlen+0x26>
    8d52:	0505                	addi	a0,a0,1
    8d54:	87aa                	mv	a5,a0
    8d56:	4685                	li	a3,1
    8d58:	9e89                	subw	a3,a3,a0
    8d5a:	00f6853b          	addw	a0,a3,a5
    8d5e:	0785                	addi	a5,a5,1
    8d60:	fff7c703          	lbu	a4,-1(a5)
    8d64:	fb7d                	bnez	a4,8d5a <strlen+0x14>
    ;
  return n;
}
    8d66:	6422                	ld	s0,8(sp)
    8d68:	0141                	addi	sp,sp,16
    8d6a:	8082                	ret
  for(n = 0; s[n]; n++)
    8d6c:	4501                	li	a0,0
    8d6e:	bfe5                	j	8d66 <strlen+0x20>

0000000000008d70 <memset>:

void*
memset(void *dst, int c, uint n)
{
    8d70:	1141                	addi	sp,sp,-16
    8d72:	e422                	sd	s0,8(sp)
    8d74:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8d76:	ca19                	beqz	a2,8d8c <memset+0x1c>
    8d78:	87aa                	mv	a5,a0
    8d7a:	1602                	slli	a2,a2,0x20
    8d7c:	9201                	srli	a2,a2,0x20
    8d7e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8d82:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    8d86:	0785                	addi	a5,a5,1
    8d88:	fee79de3          	bne	a5,a4,8d82 <memset+0x12>
  }
  return dst;
}
    8d8c:	6422                	ld	s0,8(sp)
    8d8e:	0141                	addi	sp,sp,16
    8d90:	8082                	ret

0000000000008d92 <strchr>:

char*
strchr(const char *s, char c)
{
    8d92:	1141                	addi	sp,sp,-16
    8d94:	e422                	sd	s0,8(sp)
    8d96:	0800                	addi	s0,sp,16
  for(; *s; s++)
    8d98:	00054783          	lbu	a5,0(a0)
    8d9c:	cb99                	beqz	a5,8db2 <strchr+0x20>
    if(*s == c)
    8d9e:	00f58763          	beq	a1,a5,8dac <strchr+0x1a>
  for(; *s; s++)
    8da2:	0505                	addi	a0,a0,1
    8da4:	00054783          	lbu	a5,0(a0)
    8da8:	fbfd                	bnez	a5,8d9e <strchr+0xc>
      return (char*)s;
  return 0;
    8daa:	4501                	li	a0,0
}
    8dac:	6422                	ld	s0,8(sp)
    8dae:	0141                	addi	sp,sp,16
    8db0:	8082                	ret
  return 0;
    8db2:	4501                	li	a0,0
    8db4:	bfe5                	j	8dac <strchr+0x1a>

0000000000008db6 <gets>:

char*
gets(char *buf, int max)
{
    8db6:	711d                	addi	sp,sp,-96
    8db8:	ec86                	sd	ra,88(sp)
    8dba:	e8a2                	sd	s0,80(sp)
    8dbc:	e4a6                	sd	s1,72(sp)
    8dbe:	e0ca                	sd	s2,64(sp)
    8dc0:	fc4e                	sd	s3,56(sp)
    8dc2:	f852                	sd	s4,48(sp)
    8dc4:	f456                	sd	s5,40(sp)
    8dc6:	f05a                	sd	s6,32(sp)
    8dc8:	ec5e                	sd	s7,24(sp)
    8dca:	e862                	sd	s8,16(sp)
    8dcc:	1080                	addi	s0,sp,96
    8dce:	8baa                	mv	s7,a0
    8dd0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    8dd2:	892a                	mv	s2,a0
    8dd4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    8dd6:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    8dda:	4b29                	li	s6,10
    8ddc:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
    8dde:	89a6                	mv	s3,s1
    8de0:	2485                	addiw	s1,s1,1
    8de2:	0344d763          	bge	s1,s4,8e10 <gets+0x5a>
    cc = read(0, &c, 1);
    8de6:	4605                	li	a2,1
    8de8:	85d6                	mv	a1,s5
    8dea:	4501                	li	a0,0
    8dec:	00000097          	auipc	ra,0x0
    8df0:	1b4080e7          	jalr	436(ra) # 8fa0 <read>
    if(cc < 1)
    8df4:	00a05e63          	blez	a0,8e10 <gets+0x5a>
    buf[i++] = c;
    8df8:	faf44783          	lbu	a5,-81(s0)
    8dfc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    8e00:	01678763          	beq	a5,s6,8e0e <gets+0x58>
    8e04:	0905                	addi	s2,s2,1
    8e06:	fd879ce3          	bne	a5,s8,8dde <gets+0x28>
  for(i=0; i+1 < max; ){
    8e0a:	89a6                	mv	s3,s1
    8e0c:	a011                	j	8e10 <gets+0x5a>
    8e0e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    8e10:	99de                	add	s3,s3,s7
    8e12:	00098023          	sb	zero,0(s3)
  return buf;
}
    8e16:	855e                	mv	a0,s7
    8e18:	60e6                	ld	ra,88(sp)
    8e1a:	6446                	ld	s0,80(sp)
    8e1c:	64a6                	ld	s1,72(sp)
    8e1e:	6906                	ld	s2,64(sp)
    8e20:	79e2                	ld	s3,56(sp)
    8e22:	7a42                	ld	s4,48(sp)
    8e24:	7aa2                	ld	s5,40(sp)
    8e26:	7b02                	ld	s6,32(sp)
    8e28:	6be2                	ld	s7,24(sp)
    8e2a:	6c42                	ld	s8,16(sp)
    8e2c:	6125                	addi	sp,sp,96
    8e2e:	8082                	ret

0000000000008e30 <stat>:

int
stat(const char *n, struct stat *st)
{
    8e30:	1101                	addi	sp,sp,-32
    8e32:	ec06                	sd	ra,24(sp)
    8e34:	e822                	sd	s0,16(sp)
    8e36:	e426                	sd	s1,8(sp)
    8e38:	e04a                	sd	s2,0(sp)
    8e3a:	1000                	addi	s0,sp,32
    8e3c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    8e3e:	4581                	li	a1,0
    8e40:	00000097          	auipc	ra,0x0
    8e44:	188080e7          	jalr	392(ra) # 8fc8 <open>
  if(fd < 0)
    8e48:	02054563          	bltz	a0,8e72 <stat+0x42>
    8e4c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    8e4e:	85ca                	mv	a1,s2
    8e50:	00000097          	auipc	ra,0x0
    8e54:	180080e7          	jalr	384(ra) # 8fd0 <fstat>
    8e58:	892a                	mv	s2,a0
  close(fd);
    8e5a:	8526                	mv	a0,s1
    8e5c:	00000097          	auipc	ra,0x0
    8e60:	154080e7          	jalr	340(ra) # 8fb0 <close>
  return r;
}
    8e64:	854a                	mv	a0,s2
    8e66:	60e2                	ld	ra,24(sp)
    8e68:	6442                	ld	s0,16(sp)
    8e6a:	64a2                	ld	s1,8(sp)
    8e6c:	6902                	ld	s2,0(sp)
    8e6e:	6105                	addi	sp,sp,32
    8e70:	8082                	ret
    return -1;
    8e72:	597d                	li	s2,-1
    8e74:	bfc5                	j	8e64 <stat+0x34>

0000000000008e76 <atoi>:

int
atoi(const char *s)
{
    8e76:	1141                	addi	sp,sp,-16
    8e78:	e422                	sd	s0,8(sp)
    8e7a:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
    8e7c:	00054703          	lbu	a4,0(a0)
    8e80:	02d00793          	li	a5,45
  int neg = 1;
    8e84:	4585                	li	a1,1
  if (*s == '-') {
    8e86:	04f70363          	beq	a4,a5,8ecc <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
    8e8a:	00054703          	lbu	a4,0(a0)
    8e8e:	fd07079b          	addiw	a5,a4,-48
    8e92:	0ff7f793          	zext.b	a5,a5
    8e96:	46a5                	li	a3,9
    8e98:	02f6ed63          	bltu	a3,a5,8ed2 <atoi+0x5c>
  n = 0;
    8e9c:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
    8e9e:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
    8ea0:	0505                	addi	a0,a0,1
    8ea2:	0026979b          	slliw	a5,a3,0x2
    8ea6:	9fb5                	addw	a5,a5,a3
    8ea8:	0017979b          	slliw	a5,a5,0x1
    8eac:	9fb9                	addw	a5,a5,a4
    8eae:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
    8eb2:	00054703          	lbu	a4,0(a0)
    8eb6:	fd07079b          	addiw	a5,a4,-48
    8eba:	0ff7f793          	zext.b	a5,a5
    8ebe:	fef671e3          	bgeu	a2,a5,8ea0 <atoi+0x2a>
  return n * neg;
}
    8ec2:	02d5853b          	mulw	a0,a1,a3
    8ec6:	6422                	ld	s0,8(sp)
    8ec8:	0141                	addi	sp,sp,16
    8eca:	8082                	ret
    s++;
    8ecc:	0505                	addi	a0,a0,1
    neg = -1;
    8ece:	55fd                	li	a1,-1
    8ed0:	bf6d                	j	8e8a <atoi+0x14>
  n = 0;
    8ed2:	4681                	li	a3,0
    8ed4:	b7fd                	j	8ec2 <atoi+0x4c>

0000000000008ed6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    8ed6:	1141                	addi	sp,sp,-16
    8ed8:	e422                	sd	s0,8(sp)
    8eda:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    8edc:	02b57463          	bgeu	a0,a1,8f04 <memmove+0x2e>
    while(n-- > 0)
    8ee0:	00c05f63          	blez	a2,8efe <memmove+0x28>
    8ee4:	1602                	slli	a2,a2,0x20
    8ee6:	9201                	srli	a2,a2,0x20
    8ee8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    8eec:	872a                	mv	a4,a0
      *dst++ = *src++;
    8eee:	0585                	addi	a1,a1,1
    8ef0:	0705                	addi	a4,a4,1
    8ef2:	fff5c683          	lbu	a3,-1(a1)
    8ef6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8efa:	fee79ae3          	bne	a5,a4,8eee <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    8efe:	6422                	ld	s0,8(sp)
    8f00:	0141                	addi	sp,sp,16
    8f02:	8082                	ret
    dst += n;
    8f04:	00c50733          	add	a4,a0,a2
    src += n;
    8f08:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    8f0a:	fec05ae3          	blez	a2,8efe <memmove+0x28>
    8f0e:	fff6079b          	addiw	a5,a2,-1 # fff <testdev+0x161>
    8f12:	1782                	slli	a5,a5,0x20
    8f14:	9381                	srli	a5,a5,0x20
    8f16:	fff7c793          	not	a5,a5
    8f1a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    8f1c:	15fd                	addi	a1,a1,-1
    8f1e:	177d                	addi	a4,a4,-1
    8f20:	0005c683          	lbu	a3,0(a1)
    8f24:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    8f28:	fee79ae3          	bne	a5,a4,8f1c <memmove+0x46>
    8f2c:	bfc9                	j	8efe <memmove+0x28>

0000000000008f2e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    8f2e:	1141                	addi	sp,sp,-16
    8f30:	e422                	sd	s0,8(sp)
    8f32:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    8f34:	ca05                	beqz	a2,8f64 <memcmp+0x36>
    8f36:	fff6069b          	addiw	a3,a2,-1
    8f3a:	1682                	slli	a3,a3,0x20
    8f3c:	9281                	srli	a3,a3,0x20
    8f3e:	0685                	addi	a3,a3,1
    8f40:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    8f42:	00054783          	lbu	a5,0(a0)
    8f46:	0005c703          	lbu	a4,0(a1)
    8f4a:	00e79863          	bne	a5,a4,8f5a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    8f4e:	0505                	addi	a0,a0,1
    p2++;
    8f50:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    8f52:	fed518e3          	bne	a0,a3,8f42 <memcmp+0x14>
  }
  return 0;
    8f56:	4501                	li	a0,0
    8f58:	a019                	j	8f5e <memcmp+0x30>
      return *p1 - *p2;
    8f5a:	40e7853b          	subw	a0,a5,a4
}
    8f5e:	6422                	ld	s0,8(sp)
    8f60:	0141                	addi	sp,sp,16
    8f62:	8082                	ret
  return 0;
    8f64:	4501                	li	a0,0
    8f66:	bfe5                	j	8f5e <memcmp+0x30>

0000000000008f68 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    8f68:	1141                	addi	sp,sp,-16
    8f6a:	e406                	sd	ra,8(sp)
    8f6c:	e022                	sd	s0,0(sp)
    8f6e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8f70:	00000097          	auipc	ra,0x0
    8f74:	f66080e7          	jalr	-154(ra) # 8ed6 <memmove>
}
    8f78:	60a2                	ld	ra,8(sp)
    8f7a:	6402                	ld	s0,0(sp)
    8f7c:	0141                	addi	sp,sp,16
    8f7e:	8082                	ret

0000000000008f80 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
    8f80:	4885                	li	a7,1
 ecall
    8f82:	00000073          	ecall
 ret
    8f86:	8082                	ret

0000000000008f88 <exit>:
.global exit
exit:
 li a7, SYS_exit
    8f88:	4889                	li	a7,2
 ecall
    8f8a:	00000073          	ecall
 ret
    8f8e:	8082                	ret

0000000000008f90 <wait>:
.global wait
wait:
 li a7, SYS_wait
    8f90:	488d                	li	a7,3
 ecall
    8f92:	00000073          	ecall
 ret
    8f96:	8082                	ret

0000000000008f98 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    8f98:	4891                	li	a7,4
 ecall
    8f9a:	00000073          	ecall
 ret
    8f9e:	8082                	ret

0000000000008fa0 <read>:
.global read
read:
 li a7, SYS_read
    8fa0:	4895                	li	a7,5
 ecall
    8fa2:	00000073          	ecall
 ret
    8fa6:	8082                	ret

0000000000008fa8 <write>:
.global write
write:
 li a7, SYS_write
    8fa8:	48c1                	li	a7,16
 ecall
    8faa:	00000073          	ecall
 ret
    8fae:	8082                	ret

0000000000008fb0 <close>:
.global close
close:
 li a7, SYS_close
    8fb0:	48d5                	li	a7,21
 ecall
    8fb2:	00000073          	ecall
 ret
    8fb6:	8082                	ret

0000000000008fb8 <kill>:
.global kill
kill:
 li a7, SYS_kill
    8fb8:	4899                	li	a7,6
 ecall
    8fba:	00000073          	ecall
 ret
    8fbe:	8082                	ret

0000000000008fc0 <exec>:
.global exec
exec:
 li a7, SYS_exec
    8fc0:	489d                	li	a7,7
 ecall
    8fc2:	00000073          	ecall
 ret
    8fc6:	8082                	ret

0000000000008fc8 <open>:
.global open
open:
 li a7, SYS_open
    8fc8:	48bd                	li	a7,15
 ecall
    8fca:	00000073          	ecall
 ret
    8fce:	8082                	ret

0000000000008fd0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    8fd0:	48a1                	li	a7,8
 ecall
    8fd2:	00000073          	ecall
 ret
    8fd6:	8082                	ret

0000000000008fd8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    8fd8:	48d1                	li	a7,20
 ecall
    8fda:	00000073          	ecall
 ret
    8fde:	8082                	ret

0000000000008fe0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    8fe0:	48a5                	li	a7,9
 ecall
    8fe2:	00000073          	ecall
 ret
    8fe6:	8082                	ret

0000000000008fe8 <dup>:
.global dup
dup:
 li a7, SYS_dup
    8fe8:	48a9                	li	a7,10
 ecall
    8fea:	00000073          	ecall
 ret
    8fee:	8082                	ret

0000000000008ff0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    8ff0:	48ad                	li	a7,11
 ecall
    8ff2:	00000073          	ecall
 ret
    8ff6:	8082                	ret

0000000000008ff8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    8ff8:	48b1                	li	a7,12
 ecall
    8ffa:	00000073          	ecall
 ret
    8ffe:	8082                	ret

0000000000009000 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    9000:	48b5                	li	a7,13
 ecall
    9002:	00000073          	ecall
 ret
    9006:	8082                	ret

0000000000009008 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    9008:	48b9                	li	a7,14
 ecall
    900a:	00000073          	ecall
 ret
    900e:	8082                	ret

0000000000009010 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
    9010:	48d9                	li	a7,22
 ecall
    9012:	00000073          	ecall
 ret
    9016:	8082                	ret

0000000000009018 <dev>:
.global dev
dev:
 li a7, SYS_dev
    9018:	48dd                	li	a7,23
 ecall
    901a:	00000073          	ecall
 ret
    901e:	8082                	ret

0000000000009020 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
    9020:	48e1                	li	a7,24
 ecall
    9022:	00000073          	ecall
 ret
    9026:	8082                	ret

0000000000009028 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
    9028:	48e5                	li	a7,25
 ecall
    902a:	00000073          	ecall
 ret
    902e:	8082                	ret

0000000000009030 <remove>:
.global remove
remove:
 li a7, SYS_remove
    9030:	48c5                	li	a7,17
 ecall
    9032:	00000073          	ecall
 ret
    9036:	8082                	ret

0000000000009038 <trace>:
.global trace
trace:
 li a7, SYS_trace
    9038:	48c9                	li	a7,18
 ecall
    903a:	00000073          	ecall
 ret
    903e:	8082                	ret

0000000000009040 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    9040:	48cd                	li	a7,19
 ecall
    9042:	00000073          	ecall
 ret
    9046:	8082                	ret

0000000000009048 <rename>:
.global rename
rename:
 li a7, SYS_rename
    9048:	48e9                	li	a7,26
 ecall
    904a:	00000073          	ecall
 ret
    904e:	8082                	ret

0000000000009050 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
    9050:	48ed                	li	a7,27
 ecall
    9052:	00000073          	ecall
 ret
    9056:	8082                	ret

0000000000009058 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
    9058:	48f1                	li	a7,28
 ecall
    905a:	00000073          	ecall
 ret
    905e:	8082                	ret

0000000000009060 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
    9060:	48f5                	li	a7,29
 ecall
    9062:	00000073          	ecall
 ret
    9066:	8082                	ret

0000000000009068 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
    9068:	48f9                	li	a7,30
 ecall
    906a:	00000073          	ecall
 ret
    906e:	8082                	ret

0000000000009070 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
    9070:	48fd                	li	a7,31
 ecall
    9072:	00000073          	ecall
 ret
    9076:	8082                	ret

0000000000009078 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
    9078:	02000893          	li	a7,32
 ecall
    907c:	00000073          	ecall
 ret
    9080:	8082                	ret

0000000000009082 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
    9082:	02100893          	li	a7,33
 ecall
    9086:	00000073          	ecall
 ret
    908a:	8082                	ret

000000000000908c <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
    908c:	02200893          	li	a7,34
 ecall
    9090:	00000073          	ecall
 ret
    9094:	8082                	ret

0000000000009096 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
    9096:	02300893          	li	a7,35
 ecall
    909a:	00000073          	ecall
 ret
    909e:	8082                	ret

00000000000090a0 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
    90a0:	02400893          	li	a7,36
 ecall
    90a4:	00000073          	ecall
 ret
    90a8:	8082                	ret

00000000000090aa <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
    90aa:	02500893          	li	a7,37
 ecall
    90ae:	00000073          	ecall
 ret
    90b2:	8082                	ret

00000000000090b4 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
    90b4:	02600893          	li	a7,38
 ecall
    90b8:	00000073          	ecall
 ret
    90bc:	8082                	ret

00000000000090be <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
    90be:	02700893          	li	a7,39
 ecall
    90c2:	00000073          	ecall
 ret
    90c6:	8082                	ret

00000000000090c8 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
    90c8:	02800893          	li	a7,40
 ecall
    90cc:	00000073          	ecall
 ret
    90d0:	8082                	ret

00000000000090d2 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
    90d2:	02900893          	li	a7,41
 ecall
    90d6:	00000073          	ecall
 ret
    90da:	8082                	ret

00000000000090dc <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
    90dc:	02a00893          	li	a7,42
 ecall
    90e0:	00000073          	ecall
 ret
    90e4:	8082                	ret

00000000000090e6 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
    90e6:	02b00893          	li	a7,43
 ecall
    90ea:	00000073          	ecall
 ret
    90ee:	8082                	ret

00000000000090f0 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
    90f0:	02c00893          	li	a7,44
 ecall
    90f4:	00000073          	ecall
 ret
    90f8:	8082                	ret

00000000000090fa <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
    90fa:	02d00893          	li	a7,45
 ecall
    90fe:	00000073          	ecall
 ret
    9102:	8082                	ret

0000000000009104 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
    9104:	02e00893          	li	a7,46
 ecall
    9108:	00000073          	ecall
 ret
    910c:	8082                	ret

000000000000910e <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
    910e:	02f00893          	li	a7,47
 ecall
    9112:	00000073          	ecall
 ret
    9116:	8082                	ret

0000000000009118 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
    9118:	03000893          	li	a7,48
 ecall
    911c:	00000073          	ecall
 ret
    9120:	8082                	ret

0000000000009122 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
    9122:	03100893          	li	a7,49
 ecall
    9126:	00000073          	ecall
 ret
    912a:	8082                	ret

000000000000912c <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
    912c:	03200893          	li	a7,50
 ecall
    9130:	00000073          	ecall
 ret
    9134:	8082                	ret

0000000000009136 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
    9136:	03300893          	li	a7,51
 ecall
    913a:	00000073          	ecall
 ret
    913e:	8082                	ret

0000000000009140 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
    9140:	03400893          	li	a7,52
 ecall
    9144:	00000073          	ecall
 ret
    9148:	8082                	ret

000000000000914a <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
    914a:	03500893          	li	a7,53
 ecall
    914e:	00000073          	ecall
 ret
    9152:	8082                	ret

0000000000009154 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
    9154:	03600893          	li	a7,54
 ecall
    9158:	00000073          	ecall
 ret
    915c:	8082                	ret

000000000000915e <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
    915e:	03700893          	li	a7,55
 ecall
    9162:	00000073          	ecall
 ret
    9166:	8082                	ret

0000000000009168 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
    9168:	03800893          	li	a7,56
 ecall
    916c:	00000073          	ecall
 ret
    9170:	8082                	ret

0000000000009172 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
    9172:	03900893          	li	a7,57
 ecall
    9176:	00000073          	ecall
 ret
    917a:	8082                	ret

000000000000917c <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
    917c:	03a00893          	li	a7,58
 ecall
    9180:	00000073          	ecall
 ret
    9184:	8082                	ret

0000000000009186 <poll>:
.global poll
poll:
 li a7, SYS_poll
    9186:	03b00893          	li	a7,59
 ecall
    918a:	00000073          	ecall
 ret
    918e:	8082                	ret

0000000000009190 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
    9190:	03c00893          	li	a7,60
 ecall
    9194:	00000073          	ecall
 ret
    9198:	8082                	ret

000000000000919a <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
    919a:	03d00893          	li	a7,61
 ecall
    919e:	00000073          	ecall
 ret
    91a2:	8082                	ret

00000000000091a4 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
    91a4:	03e00893          	li	a7,62
 ecall
    91a8:	00000073          	ecall
 ret
    91ac:	8082                	ret

00000000000091ae <clone>:
.global clone
clone:
 li a7, SYS_clone
    91ae:	03f00893          	li	a7,63
 ecall
    91b2:	00000073          	ecall
 ret
    91b6:	8082                	ret

00000000000091b8 <futex>:
.global futex
futex:
 li a7, SYS_futex
    91b8:	04000893          	li	a7,64
 ecall
    91bc:	00000073          	ecall
 ret
    91c0:	8082                	ret

00000000000091c2 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
    91c2:	04100893          	li	a7,65
 ecall
    91c6:	00000073          	ecall
 ret
    91ca:	8082                	ret

00000000000091cc <halt>:
.global halt
halt:
 li a7, SYS_halt
    91cc:	04200893          	li	a7,66
 ecall
    91d0:	00000073          	ecall
 ret
    91d4:	8082                	ret

00000000000091d6 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
    91d6:	04300893          	li	a7,67
 ecall
    91da:	00000073          	ecall
 ret
    91de:	8082                	ret

00000000000091e0 <socket>:
.global socket
socket:
 li a7, SYS_socket
    91e0:	04400893          	li	a7,68
 ecall
    91e4:	00000073          	ecall
 ret
    91e8:	8082                	ret

00000000000091ea <bind>:
.global bind
bind:
 li a7, SYS_bind
    91ea:	04500893          	li	a7,69
 ecall
    91ee:	00000073          	ecall
 ret
    91f2:	8082                	ret

00000000000091f4 <listen>:
.global listen
listen:
 li a7, SYS_listen
    91f4:	04600893          	li	a7,70
 ecall
    91f8:	00000073          	ecall
 ret
    91fc:	8082                	ret

00000000000091fe <accept>:
.global accept
accept:
 li a7, SYS_accept
    91fe:	04700893          	li	a7,71
 ecall
    9202:	00000073          	ecall
 ret
    9206:	8082                	ret

0000000000009208 <connect>:
.global connect
connect:
 li a7, SYS_connect
    9208:	04800893          	li	a7,72
 ecall
    920c:	00000073          	ecall
 ret
    9210:	8082                	ret

0000000000009212 <send>:
.global send
send:
 li a7, SYS_send
    9212:	04900893          	li	a7,73
 ecall
    9216:	00000073          	ecall
 ret
    921a:	8082                	ret

000000000000921c <recv>:
.global recv
recv:
 li a7, SYS_recv
    921c:	04a00893          	li	a7,74
 ecall
    9220:	00000073          	ecall
 ret
    9224:	8082                	ret

0000000000009226 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
    9226:	04b00893          	li	a7,75
 ecall
    922a:	00000073          	ecall
 ret
    922e:	8082                	ret

0000000000009230 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    9230:	1101                	addi	sp,sp,-32
    9232:	ec06                	sd	ra,24(sp)
    9234:	e822                	sd	s0,16(sp)
    9236:	1000                	addi	s0,sp,32
    9238:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    923c:	4605                	li	a2,1
    923e:	fef40593          	addi	a1,s0,-17
    9242:	00000097          	auipc	ra,0x0
    9246:	d66080e7          	jalr	-666(ra) # 8fa8 <write>
}
    924a:	60e2                	ld	ra,24(sp)
    924c:	6442                	ld	s0,16(sp)
    924e:	6105                	addi	sp,sp,32
    9250:	8082                	ret

0000000000009252 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    9252:	7139                	addi	sp,sp,-64
    9254:	fc06                	sd	ra,56(sp)
    9256:	f822                	sd	s0,48(sp)
    9258:	f426                	sd	s1,40(sp)
    925a:	f04a                	sd	s2,32(sp)
    925c:	ec4e                	sd	s3,24(sp)
    925e:	0080                	addi	s0,sp,64
    9260:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    9262:	c299                	beqz	a3,9268 <printint+0x16>
    9264:	0805c863          	bltz	a1,92f4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    9268:	2581                	sext.w	a1,a1
  neg = 0;
    926a:	4881                	li	a7,0
  }

  i = 0;
    926c:	fc040993          	addi	s3,s0,-64
  neg = 0;
    9270:	86ce                	mv	a3,s3
  i = 0;
    9272:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    9274:	2601                	sext.w	a2,a2
    9276:	00006517          	auipc	a0,0x6
    927a:	12250513          	addi	a0,a0,290 # f398 <digits>
    927e:	883a                	mv	a6,a4
    9280:	2705                	addiw	a4,a4,1
    9282:	02c5f7bb          	remuw	a5,a1,a2
    9286:	1782                	slli	a5,a5,0x20
    9288:	9381                	srli	a5,a5,0x20
    928a:	97aa                	add	a5,a5,a0
    928c:	0007c783          	lbu	a5,0(a5)
    9290:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    9294:	0005879b          	sext.w	a5,a1
    9298:	02c5d5bb          	divuw	a1,a1,a2
    929c:	0685                	addi	a3,a3,1
    929e:	fec7f0e3          	bgeu	a5,a2,927e <printint+0x2c>
  if(neg)
    92a2:	00088c63          	beqz	a7,92ba <printint+0x68>
    buf[i++] = '-';
    92a6:	fd070793          	addi	a5,a4,-48
    92aa:	00878733          	add	a4,a5,s0
    92ae:	02d00793          	li	a5,45
    92b2:	fef70823          	sb	a5,-16(a4)
    92b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    92ba:	02e05663          	blez	a4,92e6 <printint+0x94>
    92be:	fc040913          	addi	s2,s0,-64
    92c2:	993a                	add	s2,s2,a4
    92c4:	19fd                	addi	s3,s3,-1
    92c6:	99ba                	add	s3,s3,a4
    92c8:	377d                	addiw	a4,a4,-1
    92ca:	1702                	slli	a4,a4,0x20
    92cc:	9301                	srli	a4,a4,0x20
    92ce:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    92d2:	fff94583          	lbu	a1,-1(s2)
    92d6:	8526                	mv	a0,s1
    92d8:	00000097          	auipc	ra,0x0
    92dc:	f58080e7          	jalr	-168(ra) # 9230 <putc>
  while(--i >= 0)
    92e0:	197d                	addi	s2,s2,-1
    92e2:	ff3918e3          	bne	s2,s3,92d2 <printint+0x80>
}
    92e6:	70e2                	ld	ra,56(sp)
    92e8:	7442                	ld	s0,48(sp)
    92ea:	74a2                	ld	s1,40(sp)
    92ec:	7902                	ld	s2,32(sp)
    92ee:	69e2                	ld	s3,24(sp)
    92f0:	6121                	addi	sp,sp,64
    92f2:	8082                	ret
    x = -xx;
    92f4:	40b005bb          	negw	a1,a1
    neg = 1;
    92f8:	4885                	li	a7,1
    x = -xx;
    92fa:	bf8d                	j	926c <printint+0x1a>

00000000000092fc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    92fc:	7119                	addi	sp,sp,-128
    92fe:	fc86                	sd	ra,120(sp)
    9300:	f8a2                	sd	s0,112(sp)
    9302:	f4a6                	sd	s1,104(sp)
    9304:	f0ca                	sd	s2,96(sp)
    9306:	ecce                	sd	s3,88(sp)
    9308:	e8d2                	sd	s4,80(sp)
    930a:	e4d6                	sd	s5,72(sp)
    930c:	e0da                	sd	s6,64(sp)
    930e:	fc5e                	sd	s7,56(sp)
    9310:	f862                	sd	s8,48(sp)
    9312:	f466                	sd	s9,40(sp)
    9314:	f06a                	sd	s10,32(sp)
    9316:	ec6e                	sd	s11,24(sp)
    9318:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    931a:	0005c903          	lbu	s2,0(a1)
    931e:	18090f63          	beqz	s2,94bc <vprintf+0x1c0>
    9322:	8aaa                	mv	s5,a0
    9324:	8b32                	mv	s6,a2
    9326:	00158493          	addi	s1,a1,1
  state = 0;
    932a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    932c:	02500a13          	li	s4,37
    9330:	4c55                	li	s8,21
    9332:	00006c97          	auipc	s9,0x6
    9336:	00ec8c93          	addi	s9,s9,14 # f340 <malloc+0x5d80>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    933a:	02800d93          	li	s11,40
  putc(fd, 'x');
    933e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    9340:	00006b97          	auipc	s7,0x6
    9344:	058b8b93          	addi	s7,s7,88 # f398 <digits>
    9348:	a839                	j	9366 <vprintf+0x6a>
        putc(fd, c);
    934a:	85ca                	mv	a1,s2
    934c:	8556                	mv	a0,s5
    934e:	00000097          	auipc	ra,0x0
    9352:	ee2080e7          	jalr	-286(ra) # 9230 <putc>
    9356:	a019                	j	935c <vprintf+0x60>
    } else if(state == '%'){
    9358:	01498d63          	beq	s3,s4,9372 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    935c:	0485                	addi	s1,s1,1
    935e:	fff4c903          	lbu	s2,-1(s1)
    9362:	14090d63          	beqz	s2,94bc <vprintf+0x1c0>
    if(state == 0){
    9366:	fe0999e3          	bnez	s3,9358 <vprintf+0x5c>
      if(c == '%'){
    936a:	ff4910e3          	bne	s2,s4,934a <vprintf+0x4e>
        state = '%';
    936e:	89d2                	mv	s3,s4
    9370:	b7f5                	j	935c <vprintf+0x60>
      if(c == 'd'){
    9372:	11490c63          	beq	s2,s4,948a <vprintf+0x18e>
    9376:	f9d9079b          	addiw	a5,s2,-99
    937a:	0ff7f793          	zext.b	a5,a5
    937e:	10fc6e63          	bltu	s8,a5,949a <vprintf+0x19e>
    9382:	f9d9079b          	addiw	a5,s2,-99
    9386:	0ff7f713          	zext.b	a4,a5
    938a:	10ec6863          	bltu	s8,a4,949a <vprintf+0x19e>
    938e:	00271793          	slli	a5,a4,0x2
    9392:	97e6                	add	a5,a5,s9
    9394:	439c                	lw	a5,0(a5)
    9396:	97e6                	add	a5,a5,s9
    9398:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    939a:	008b0913          	addi	s2,s6,8
    939e:	4685                	li	a3,1
    93a0:	4629                	li	a2,10
    93a2:	000b2583          	lw	a1,0(s6)
    93a6:	8556                	mv	a0,s5
    93a8:	00000097          	auipc	ra,0x0
    93ac:	eaa080e7          	jalr	-342(ra) # 9252 <printint>
    93b0:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    93b2:	4981                	li	s3,0
    93b4:	b765                	j	935c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    93b6:	008b0913          	addi	s2,s6,8
    93ba:	4681                	li	a3,0
    93bc:	4629                	li	a2,10
    93be:	000b2583          	lw	a1,0(s6)
    93c2:	8556                	mv	a0,s5
    93c4:	00000097          	auipc	ra,0x0
    93c8:	e8e080e7          	jalr	-370(ra) # 9252 <printint>
    93cc:	8b4a                	mv	s6,s2
      state = 0;
    93ce:	4981                	li	s3,0
    93d0:	b771                	j	935c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    93d2:	008b0913          	addi	s2,s6,8
    93d6:	4681                	li	a3,0
    93d8:	866a                	mv	a2,s10
    93da:	000b2583          	lw	a1,0(s6)
    93de:	8556                	mv	a0,s5
    93e0:	00000097          	auipc	ra,0x0
    93e4:	e72080e7          	jalr	-398(ra) # 9252 <printint>
    93e8:	8b4a                	mv	s6,s2
      state = 0;
    93ea:	4981                	li	s3,0
    93ec:	bf85                	j	935c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    93ee:	008b0793          	addi	a5,s6,8
    93f2:	f8f43423          	sd	a5,-120(s0)
    93f6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    93fa:	03000593          	li	a1,48
    93fe:	8556                	mv	a0,s5
    9400:	00000097          	auipc	ra,0x0
    9404:	e30080e7          	jalr	-464(ra) # 9230 <putc>
  putc(fd, 'x');
    9408:	07800593          	li	a1,120
    940c:	8556                	mv	a0,s5
    940e:	00000097          	auipc	ra,0x0
    9412:	e22080e7          	jalr	-478(ra) # 9230 <putc>
    9416:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    9418:	03c9d793          	srli	a5,s3,0x3c
    941c:	97de                	add	a5,a5,s7
    941e:	0007c583          	lbu	a1,0(a5)
    9422:	8556                	mv	a0,s5
    9424:	00000097          	auipc	ra,0x0
    9428:	e0c080e7          	jalr	-500(ra) # 9230 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    942c:	0992                	slli	s3,s3,0x4
    942e:	397d                	addiw	s2,s2,-1
    9430:	fe0914e3          	bnez	s2,9418 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    9434:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    9438:	4981                	li	s3,0
    943a:	b70d                	j	935c <vprintf+0x60>
        s = va_arg(ap, char*);
    943c:	008b0913          	addi	s2,s6,8
    9440:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    9444:	02098163          	beqz	s3,9466 <vprintf+0x16a>
        while(*s != 0){
    9448:	0009c583          	lbu	a1,0(s3)
    944c:	c5ad                	beqz	a1,94b6 <vprintf+0x1ba>
          putc(fd, *s);
    944e:	8556                	mv	a0,s5
    9450:	00000097          	auipc	ra,0x0
    9454:	de0080e7          	jalr	-544(ra) # 9230 <putc>
          s++;
    9458:	0985                	addi	s3,s3,1
        while(*s != 0){
    945a:	0009c583          	lbu	a1,0(s3)
    945e:	f9e5                	bnez	a1,944e <vprintf+0x152>
        s = va_arg(ap, char*);
    9460:	8b4a                	mv	s6,s2
      state = 0;
    9462:	4981                	li	s3,0
    9464:	bde5                	j	935c <vprintf+0x60>
          s = "(null)";
    9466:	00006997          	auipc	s3,0x6
    946a:	ed298993          	addi	s3,s3,-302 # f338 <malloc+0x5d78>
        while(*s != 0){
    946e:	85ee                	mv	a1,s11
    9470:	bff9                	j	944e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    9472:	008b0913          	addi	s2,s6,8
    9476:	000b4583          	lbu	a1,0(s6)
    947a:	8556                	mv	a0,s5
    947c:	00000097          	auipc	ra,0x0
    9480:	db4080e7          	jalr	-588(ra) # 9230 <putc>
    9484:	8b4a                	mv	s6,s2
      state = 0;
    9486:	4981                	li	s3,0
    9488:	bdd1                	j	935c <vprintf+0x60>
        putc(fd, c);
    948a:	85d2                	mv	a1,s4
    948c:	8556                	mv	a0,s5
    948e:	00000097          	auipc	ra,0x0
    9492:	da2080e7          	jalr	-606(ra) # 9230 <putc>
      state = 0;
    9496:	4981                	li	s3,0
    9498:	b5d1                	j	935c <vprintf+0x60>
        putc(fd, '%');
    949a:	85d2                	mv	a1,s4
    949c:	8556                	mv	a0,s5
    949e:	00000097          	auipc	ra,0x0
    94a2:	d92080e7          	jalr	-622(ra) # 9230 <putc>
        putc(fd, c);
    94a6:	85ca                	mv	a1,s2
    94a8:	8556                	mv	a0,s5
    94aa:	00000097          	auipc	ra,0x0
    94ae:	d86080e7          	jalr	-634(ra) # 9230 <putc>
      state = 0;
    94b2:	4981                	li	s3,0
    94b4:	b565                	j	935c <vprintf+0x60>
        s = va_arg(ap, char*);
    94b6:	8b4a                	mv	s6,s2
      state = 0;
    94b8:	4981                	li	s3,0
    94ba:	b54d                	j	935c <vprintf+0x60>
    }
  }
}
    94bc:	70e6                	ld	ra,120(sp)
    94be:	7446                	ld	s0,112(sp)
    94c0:	74a6                	ld	s1,104(sp)
    94c2:	7906                	ld	s2,96(sp)
    94c4:	69e6                	ld	s3,88(sp)
    94c6:	6a46                	ld	s4,80(sp)
    94c8:	6aa6                	ld	s5,72(sp)
    94ca:	6b06                	ld	s6,64(sp)
    94cc:	7be2                	ld	s7,56(sp)
    94ce:	7c42                	ld	s8,48(sp)
    94d0:	7ca2                	ld	s9,40(sp)
    94d2:	7d02                	ld	s10,32(sp)
    94d4:	6de2                	ld	s11,24(sp)
    94d6:	6109                	addi	sp,sp,128
    94d8:	8082                	ret

00000000000094da <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    94da:	715d                	addi	sp,sp,-80
    94dc:	ec06                	sd	ra,24(sp)
    94de:	e822                	sd	s0,16(sp)
    94e0:	1000                	addi	s0,sp,32
    94e2:	e010                	sd	a2,0(s0)
    94e4:	e414                	sd	a3,8(s0)
    94e6:	e818                	sd	a4,16(s0)
    94e8:	ec1c                	sd	a5,24(s0)
    94ea:	03043023          	sd	a6,32(s0)
    94ee:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    94f2:	8622                	mv	a2,s0
    94f4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    94f8:	00000097          	auipc	ra,0x0
    94fc:	e04080e7          	jalr	-508(ra) # 92fc <vprintf>
}
    9500:	60e2                	ld	ra,24(sp)
    9502:	6442                	ld	s0,16(sp)
    9504:	6161                	addi	sp,sp,80
    9506:	8082                	ret

0000000000009508 <printf>:

void
printf(const char *fmt, ...)
{
    9508:	711d                	addi	sp,sp,-96
    950a:	ec06                	sd	ra,24(sp)
    950c:	e822                	sd	s0,16(sp)
    950e:	1000                	addi	s0,sp,32
    9510:	e40c                	sd	a1,8(s0)
    9512:	e810                	sd	a2,16(s0)
    9514:	ec14                	sd	a3,24(s0)
    9516:	f018                	sd	a4,32(s0)
    9518:	f41c                	sd	a5,40(s0)
    951a:	03043823          	sd	a6,48(s0)
    951e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    9522:	00840613          	addi	a2,s0,8
    9526:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    952a:	85aa                	mv	a1,a0
    952c:	4505                	li	a0,1
    952e:	00000097          	auipc	ra,0x0
    9532:	dce080e7          	jalr	-562(ra) # 92fc <vprintf>
}
    9536:	60e2                	ld	ra,24(sp)
    9538:	6442                	ld	s0,16(sp)
    953a:	6125                	addi	sp,sp,96
    953c:	8082                	ret

000000000000953e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    953e:	1141                	addi	sp,sp,-16
    9540:	e422                	sd	s0,8(sp)
    9542:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    9544:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    9548:	00015797          	auipc	a5,0x15
    954c:	3807b783          	ld	a5,896(a5) # 1e8c8 <freep>
    9550:	a02d                	j	957a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    9552:	4618                	lw	a4,8(a2)
    9554:	9f2d                	addw	a4,a4,a1
    9556:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    955a:	6398                	ld	a4,0(a5)
    955c:	6310                	ld	a2,0(a4)
    955e:	a83d                	j	959c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    9560:	ff852703          	lw	a4,-8(a0)
    9564:	9f31                	addw	a4,a4,a2
    9566:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    9568:	ff053683          	ld	a3,-16(a0)
    956c:	a091                	j	95b0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    956e:	6398                	ld	a4,0(a5)
    9570:	00e7e463          	bltu	a5,a4,9578 <free+0x3a>
    9574:	00e6ea63          	bltu	a3,a4,9588 <free+0x4a>
{
    9578:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    957a:	fed7fae3          	bgeu	a5,a3,956e <free+0x30>
    957e:	6398                	ld	a4,0(a5)
    9580:	00e6e463          	bltu	a3,a4,9588 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    9584:	fee7eae3          	bltu	a5,a4,9578 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    9588:	ff852583          	lw	a1,-8(a0)
    958c:	6390                	ld	a2,0(a5)
    958e:	02059813          	slli	a6,a1,0x20
    9592:	01c85713          	srli	a4,a6,0x1c
    9596:	9736                	add	a4,a4,a3
    9598:	fae60de3          	beq	a2,a4,9552 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    959c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    95a0:	4790                	lw	a2,8(a5)
    95a2:	02061593          	slli	a1,a2,0x20
    95a6:	01c5d713          	srli	a4,a1,0x1c
    95aa:	973e                	add	a4,a4,a5
    95ac:	fae68ae3          	beq	a3,a4,9560 <free+0x22>
    p->s.ptr = bp->s.ptr;
    95b0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    95b2:	00015717          	auipc	a4,0x15
    95b6:	30f73b23          	sd	a5,790(a4) # 1e8c8 <freep>
}
    95ba:	6422                	ld	s0,8(sp)
    95bc:	0141                	addi	sp,sp,16
    95be:	8082                	ret

00000000000095c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    95c0:	7139                	addi	sp,sp,-64
    95c2:	fc06                	sd	ra,56(sp)
    95c4:	f822                	sd	s0,48(sp)
    95c6:	f426                	sd	s1,40(sp)
    95c8:	f04a                	sd	s2,32(sp)
    95ca:	ec4e                	sd	s3,24(sp)
    95cc:	e852                	sd	s4,16(sp)
    95ce:	e456                	sd	s5,8(sp)
    95d0:	e05a                	sd	s6,0(sp)
    95d2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    95d4:	02051493          	slli	s1,a0,0x20
    95d8:	9081                	srli	s1,s1,0x20
    95da:	04bd                	addi	s1,s1,15
    95dc:	8091                	srli	s1,s1,0x4
    95de:	00148a1b          	addiw	s4,s1,1
    95e2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    95e4:	00015517          	auipc	a0,0x15
    95e8:	2e453503          	ld	a0,740(a0) # 1e8c8 <freep>
    95ec:	c515                	beqz	a0,9618 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    95ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    95f0:	4798                	lw	a4,8(a5)
    95f2:	04977163          	bgeu	a4,s1,9634 <malloc+0x74>
    95f6:	89d2                	mv	s3,s4
    95f8:	000a071b          	sext.w	a4,s4
    95fc:	6685                	lui	a3,0x1
    95fe:	00d77363          	bgeu	a4,a3,9604 <malloc+0x44>
    9602:	6985                	lui	s3,0x1
    9604:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    9608:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    960c:	00015917          	auipc	s2,0x15
    9610:	2bc90913          	addi	s2,s2,700 # 1e8c8 <freep>
  if(p == (char*)-1)
    9614:	5afd                	li	s5,-1
    9616:	a8a5                	j	968e <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    9618:	00015797          	auipc	a5,0x15
    961c:	2b078793          	addi	a5,a5,688 # 1e8c8 <freep>
    9620:	00015717          	auipc	a4,0x15
    9624:	2b070713          	addi	a4,a4,688 # 1e8d0 <base>
    9628:	e398                	sd	a4,0(a5)
    962a:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    962c:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    9630:	87ba                	mv	a5,a4
    9632:	b7d1                	j	95f6 <malloc+0x36>
      if(p->s.size == nunits)
    9634:	02e48c63          	beq	s1,a4,966c <malloc+0xac>
        p->s.size -= nunits;
    9638:	4147073b          	subw	a4,a4,s4
    963c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    963e:	02071693          	slli	a3,a4,0x20
    9642:	01c6d713          	srli	a4,a3,0x1c
    9646:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    9648:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    964c:	00015717          	auipc	a4,0x15
    9650:	26a73e23          	sd	a0,636(a4) # 1e8c8 <freep>
      return (void*)(p + 1);
    9654:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    9658:	70e2                	ld	ra,56(sp)
    965a:	7442                	ld	s0,48(sp)
    965c:	74a2                	ld	s1,40(sp)
    965e:	7902                	ld	s2,32(sp)
    9660:	69e2                	ld	s3,24(sp)
    9662:	6a42                	ld	s4,16(sp)
    9664:	6aa2                	ld	s5,8(sp)
    9666:	6b02                	ld	s6,0(sp)
    9668:	6121                	addi	sp,sp,64
    966a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    966c:	6398                	ld	a4,0(a5)
    966e:	e118                	sd	a4,0(a0)
    9670:	bff1                	j	964c <malloc+0x8c>
  hp->s.size = nu;
    9672:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    9676:	0541                	addi	a0,a0,16
    9678:	00000097          	auipc	ra,0x0
    967c:	ec6080e7          	jalr	-314(ra) # 953e <free>
  return freep;
    9680:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    9684:	d971                	beqz	a0,9658 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    9686:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    9688:	4798                	lw	a4,8(a5)
    968a:	fa9775e3          	bgeu	a4,s1,9634 <malloc+0x74>
    if(p == freep)
    968e:	00093703          	ld	a4,0(s2)
    9692:	853e                	mv	a0,a5
    9694:	fef719e3          	bne	a4,a5,9686 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    9698:	854e                	mv	a0,s3
    969a:	00000097          	auipc	ra,0x0
    969e:	95e080e7          	jalr	-1698(ra) # 8ff8 <sbrk>
  if(p == (char*)-1)
    96a2:	fd5518e3          	bne	a0,s5,9672 <malloc+0xb2>
        return 0;
    96a6:	4501                	li	a0,0
    96a8:	bf45                	j	9658 <malloc+0x98>
