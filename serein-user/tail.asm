
serein-user/_tail：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <usage>:
#define DEF_N 10
#define MAX_LINE 4096

static void
usage(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  fprintf(2, "usage: tail [-n N] [file ...]\n");
   8:	00001597          	auipc	a1,0x1
   c:	e6858593          	addi	a1,a1,-408 # e70 <malloc+0xec>
  10:	4509                	li	a0,2
  12:	00001097          	auipc	ra,0x1
  16:	c8c080e7          	jalr	-884(ra) # c9e <fprintf>
  exit(1);
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	730080e7          	jalr	1840(ra) # 74c <exit>

0000000000000024 <tailfd>:
}

void
tailfd(int fd, int n)
{
  24:	d6010113          	addi	sp,sp,-672
  28:	28113c23          	sd	ra,664(sp)
  2c:	28813823          	sd	s0,656(sp)
  30:	28913423          	sd	s1,648(sp)
  34:	29213023          	sd	s2,640(sp)
  38:	27313c23          	sd	s3,632(sp)
  3c:	27413823          	sd	s4,624(sp)
  40:	27513423          	sd	s5,616(sp)
  44:	27613023          	sd	s6,608(sp)
  48:	25713c23          	sd	s7,600(sp)
  4c:	25813823          	sd	s8,592(sp)
  50:	25913423          	sd	s9,584(sp)
  54:	25a13023          	sd	s10,576(sp)
  58:	23b13c23          	sd	s11,568(sp)
  5c:	1500                	addi	s0,sp,672
  5e:	d8a43023          	sd	a0,-640(s0)
  int r, i;
  int li = 0; // linebuf index
  int idx = 0; // circular index
  int total = 0;

  if(n <= 0) return;
  62:	28b05963          	blez	a1,2f4 <tailfd+0x2d0>
  66:	8cae                	mv	s9,a1

  lines = malloc(sizeof(char*) * n);
  68:	0035951b          	slliw	a0,a1,0x3
  6c:	00001097          	auipc	ra,0x1
  70:	d18080e7          	jalr	-744(ra) # d84 <malloc>
  74:	8daa                	mv	s11,a0
  if(!lines){
  76:	cd35                	beqz	a0,f2 <tailfd+0xce>
  78:	d8a43423          	sd	a0,-632(s0)
  7c:	020c9713          	slli	a4,s9,0x20
  80:	01d75793          	srli	a5,a4,0x1d
  84:	97aa                	add	a5,a5,a0
  86:	d6f43423          	sd	a5,-664(s0)
  8a:	87aa                	mv	a5,a0
    fprintf(2, "tail: malloc failed\n");
    exit(1);
  }
  for(i = 0; i < n; i++) lines[i] = 0;
  8c:	0007b023          	sd	zero,0(a5)
  90:	07a1                	addi	a5,a5,8
  92:	d6843703          	ld	a4,-664(s0)
  96:	fee79be3          	bne	a5,a4,8c <tailfd+0x68>

  linebuf = malloc(MAX_LINE);
  9a:	6505                	lui	a0,0x1
  9c:	00001097          	auipc	ra,0x1
  a0:	ce8080e7          	jalr	-792(ra) # d84 <malloc>
  a4:	8b2a                	mv	s6,a0
  if(!linebuf){
  a6:	c525                	beqz	a0,10e <tailfd+0xea>
  int total = 0;
  a8:	4d01                	li	s10,0
  int idx = 0; // circular index
  aa:	4981                	li	s3,0
  int li = 0; // linebuf index
  ac:	4901                	li	s2,0
    fprintf(2, "tail: malloc failed\n");
    exit(1);
  }

  while((r = read(fd, buf, sizeof(buf))) > 0){
  ae:	d9040793          	addi	a5,s0,-624
  b2:	d6f43c23          	sd	a5,-648(s0)
  b6:	d9140793          	addi	a5,s0,-623
  ba:	d6f43823          	sd	a5,-656(s0)
    for(i = 0; i < r; i++){
      char c = buf[i];
      if(li < MAX_LINE - 1) linebuf[li++] = c;
  be:	6b85                	lui	s7,0x1
  c0:	1bf9                	addi	s7,s7,-2 # ffe <__BSS_END__+0x6e>
      if(c == '\n'){
  c2:	4c29                	li	s8,10
  while((r = read(fd, buf, sizeof(buf))) > 0){
  c4:	20000613          	li	a2,512
  c8:	d7843583          	ld	a1,-648(s0)
  cc:	d8043503          	ld	a0,-640(s0)
  d0:	00000097          	auipc	ra,0x0
  d4:	694080e7          	jalr	1684(ra) # 764 <read>
  d8:	0ca05a63          	blez	a0,1ac <tailfd+0x188>
  dc:	d9040493          	addi	s1,s0,-624
  e0:	fff50a9b          	addiw	s5,a0,-1 # fff <__BSS_END__+0x6f>
  e4:	1a82                	slli	s5,s5,0x20
  e6:	020ada93          	srli	s5,s5,0x20
  ea:	d7043783          	ld	a5,-656(s0)
  ee:	9abe                	add	s5,s5,a5
  f0:	a091                	j	134 <tailfd+0x110>
    fprintf(2, "tail: malloc failed\n");
  f2:	00001597          	auipc	a1,0x1
  f6:	d9e58593          	addi	a1,a1,-610 # e90 <malloc+0x10c>
  fa:	4509                	li	a0,2
  fc:	00001097          	auipc	ra,0x1
 100:	ba2080e7          	jalr	-1118(ra) # c9e <fprintf>
    exit(1);
 104:	4505                	li	a0,1
 106:	00000097          	auipc	ra,0x0
 10a:	646080e7          	jalr	1606(ra) # 74c <exit>
    fprintf(2, "tail: malloc failed\n");
 10e:	00001597          	auipc	a1,0x1
 112:	d8258593          	addi	a1,a1,-638 # e90 <malloc+0x10c>
 116:	4509                	li	a0,2
 118:	00001097          	auipc	ra,0x1
 11c:	b86080e7          	jalr	-1146(ra) # c9e <fprintf>
    exit(1);
 120:	4505                	li	a0,1
 122:	00000097          	auipc	ra,0x0
 126:	62a080e7          	jalr	1578(ra) # 74c <exit>
      if(c == '\n'){
 12a:	01878f63          	beq	a5,s8,148 <tailfd+0x124>
    for(i = 0; i < r; i++){
 12e:	0485                	addi	s1,s1,1
 130:	f9548ae3          	beq	s1,s5,c4 <tailfd+0xa0>
      char c = buf[i];
 134:	0004c783          	lbu	a5,0(s1)
      if(li < MAX_LINE - 1) linebuf[li++] = c;
 138:	ff2bc9e3          	blt	s7,s2,12a <tailfd+0x106>
 13c:	012b0733          	add	a4,s6,s2
 140:	00f70023          	sb	a5,0(a4)
 144:	2905                	addiw	s2,s2,1
 146:	b7d5                	j	12a <tailfd+0x106>
        linebuf[li] = '\0';
 148:	012b07b3          	add	a5,s6,s2
 14c:	00078023          	sb	zero,0(a5)
        if(lines[idx]) free(lines[idx]);
 150:	00399a13          	slli	s4,s3,0x3
 154:	9a6e                	add	s4,s4,s11
 156:	000a3503          	ld	a0,0(s4)
 15a:	c509                	beqz	a0,164 <tailfd+0x140>
 15c:	00001097          	auipc	ra,0x1
 160:	ba6080e7          	jalr	-1114(ra) # d02 <free>
        lines[idx] = malloc(li + 1);
 164:	0019051b          	addiw	a0,s2,1
 168:	00001097          	auipc	ra,0x1
 16c:	c1c080e7          	jalr	-996(ra) # d84 <malloc>
 170:	00aa3023          	sd	a0,0(s4)
        if(!lines[idx]){
 174:	cd11                	beqz	a0,190 <tailfd+0x16c>
          fprintf(2, "tail: malloc failed\n");
          exit(1);
        }
        strcpy(lines[idx], linebuf);
 176:	85da                	mv	a1,s6
 178:	00000097          	auipc	ra,0x0
 17c:	31c080e7          	jalr	796(ra) # 494 <strcpy>
        idx = (idx + 1) % n;
 180:	2985                	addiw	s3,s3,1
 182:	0399e9bb          	remw	s3,s3,s9
        if(total < n) total++;
        li = 0;
 186:	4901                	li	s2,0
        if(total < n) total++;
 188:	fb9d53e3          	bge	s10,s9,12e <tailfd+0x10a>
 18c:	2d05                	addiw	s10,s10,1
 18e:	b745                	j	12e <tailfd+0x10a>
          fprintf(2, "tail: malloc failed\n");
 190:	00001597          	auipc	a1,0x1
 194:	d0058593          	addi	a1,a1,-768 # e90 <malloc+0x10c>
 198:	4509                	li	a0,2
 19a:	00001097          	auipc	ra,0x1
 19e:	b04080e7          	jalr	-1276(ra) # c9e <fprintf>
          exit(1);
 1a2:	4505                	li	a0,1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	5a8080e7          	jalr	1448(ra) # 74c <exit>
      }
    }
  }

  if(r < 0){
 1ac:	06054663          	bltz	a0,218 <tailfd+0x1f4>
    free(linebuf);
    exit(1);
  }

  // 处理 EOF 时如果有未以 \n 结尾的残余行
  if(li > 0){
 1b0:	05205263          	blez	s2,1f4 <tailfd+0x1d0>
    linebuf[li] = '\0';
 1b4:	012b07b3          	add	a5,s6,s2
 1b8:	00078023          	sb	zero,0(a5)
    if(lines[idx]) free(lines[idx]);
 1bc:	00399493          	slli	s1,s3,0x3
 1c0:	94ee                	add	s1,s1,s11
 1c2:	6088                	ld	a0,0(s1)
 1c4:	c509                	beqz	a0,1ce <tailfd+0x1aa>
 1c6:	00001097          	auipc	ra,0x1
 1ca:	b3c080e7          	jalr	-1220(ra) # d02 <free>
    lines[idx] = malloc(li + 1);
 1ce:	0019051b          	addiw	a0,s2,1
 1d2:	00001097          	auipc	ra,0x1
 1d6:	bb2080e7          	jalr	-1102(ra) # d84 <malloc>
 1da:	e088                	sd	a0,0(s1)
    if(!lines[idx]){
 1dc:	c12d                	beqz	a0,23e <tailfd+0x21a>
      fprintf(2, "tail: malloc failed\n");
      free(linebuf);
      exit(1);
    }
    strcpy(lines[idx], linebuf);
 1de:	85da                	mv	a1,s6
 1e0:	00000097          	auipc	ra,0x0
 1e4:	2b4080e7          	jalr	692(ra) # 494 <strcpy>
    idx = (idx + 1) % n;
 1e8:	2985                	addiw	s3,s3,1
 1ea:	0399e9bb          	remw	s3,s3,s9
    if(total < n) total++;
 1ee:	019d5363          	bge	s10,s9,1f4 <tailfd+0x1d0>
 1f2:	2d05                	addiw	s10,s10,1
  }

  free(linebuf);
 1f4:	855a                	mv	a0,s6
 1f6:	00001097          	auipc	ra,0x1
 1fa:	b0c080e7          	jalr	-1268(ra) # d02 <free>

  // 输出 oldest -> newest
  int start = (idx - total + n) % n;
 1fe:	41a984bb          	subw	s1,s3,s10
 202:	019484bb          	addw	s1,s1,s9
 206:	0394e4bb          	remw	s1,s1,s9
  for(i = 0; i < total; i++){
 20a:	0da05763          	blez	s10,2d8 <tailfd+0x2b4>
 20e:	0004899b          	sext.w	s3,s1
 212:	01a484bb          	addw	s1,s1,s10
 216:	a891                	j	26a <tailfd+0x246>
    fprintf(2, "tail: read error\n");
 218:	00001597          	auipc	a1,0x1
 21c:	c9058593          	addi	a1,a1,-880 # ea8 <malloc+0x124>
 220:	4509                	li	a0,2
 222:	00001097          	auipc	ra,0x1
 226:	a7c080e7          	jalr	-1412(ra) # c9e <fprintf>
    free(linebuf);
 22a:	855a                	mv	a0,s6
 22c:	00001097          	auipc	ra,0x1
 230:	ad6080e7          	jalr	-1322(ra) # d02 <free>
    exit(1);
 234:	4505                	li	a0,1
 236:	00000097          	auipc	ra,0x0
 23a:	516080e7          	jalr	1302(ra) # 74c <exit>
      fprintf(2, "tail: malloc failed\n");
 23e:	00001597          	auipc	a1,0x1
 242:	c5258593          	addi	a1,a1,-942 # e90 <malloc+0x10c>
 246:	4509                	li	a0,2
 248:	00001097          	auipc	ra,0x1
 24c:	a56080e7          	jalr	-1450(ra) # c9e <fprintf>
      free(linebuf);
 250:	855a                	mv	a0,s6
 252:	00001097          	auipc	ra,0x1
 256:	ab0080e7          	jalr	-1360(ra) # d02 <free>
      exit(1);
 25a:	4505                	li	a0,1
 25c:	00000097          	auipc	ra,0x0
 260:	4f0080e7          	jalr	1264(ra) # 74c <exit>
  for(i = 0; i < total; i++){
 264:	2985                	addiw	s3,s3,1
 266:	06998963          	beq	s3,s1,2d8 <tailfd+0x2b4>
    int p = (start + i) % n;
    if(lines[p]){
 26a:	0399e93b          	remw	s2,s3,s9
 26e:	090e                	slli	s2,s2,0x3
 270:	996e                	add	s2,s2,s11
 272:	00093a03          	ld	s4,0(s2)
 276:	fe0a07e3          	beqz	s4,264 <tailfd+0x240>
      if(write(1, lines[p], strlen(lines[p])) != strlen(lines[p])){
 27a:	8552                	mv	a0,s4
 27c:	00000097          	auipc	ra,0x0
 280:	28e080e7          	jalr	654(ra) # 50a <strlen>
 284:	0005061b          	sext.w	a2,a0
 288:	85d2                	mv	a1,s4
 28a:	4505                	li	a0,1
 28c:	00000097          	auipc	ra,0x0
 290:	4e0080e7          	jalr	1248(ra) # 76c <write>
 294:	8a2a                	mv	s4,a0
 296:	00093503          	ld	a0,0(s2)
 29a:	00000097          	auipc	ra,0x0
 29e:	270080e7          	jalr	624(ra) # 50a <strlen>
 2a2:	2501                	sext.w	a0,a0
 2a4:	2a01                	sext.w	s4,s4
 2a6:	faaa0fe3          	beq	s4,a0,264 <tailfd+0x240>
        fprintf(2, "tail: write error\n");
 2aa:	00001597          	auipc	a1,0x1
 2ae:	c1658593          	addi	a1,a1,-1002 # ec0 <malloc+0x13c>
 2b2:	4509                	li	a0,2
 2b4:	00001097          	auipc	ra,0x1
 2b8:	9ea080e7          	jalr	-1558(ra) # c9e <fprintf>
        exit(1);
 2bc:	4505                	li	a0,1
 2be:	00000097          	auipc	ra,0x0
 2c2:	48e080e7          	jalr	1166(ra) # 74c <exit>
      }
    }
  }

  for(i = 0; i < n; i++) if(lines[i]) free(lines[i]);
 2c6:	d8843783          	ld	a5,-632(s0)
 2ca:	07a1                	addi	a5,a5,8
 2cc:	d8f43423          	sd	a5,-632(s0)
 2d0:	d6843703          	ld	a4,-664(s0)
 2d4:	00e78b63          	beq	a5,a4,2ea <tailfd+0x2c6>
 2d8:	d8843783          	ld	a5,-632(s0)
 2dc:	6388                	ld	a0,0(a5)
 2de:	d565                	beqz	a0,2c6 <tailfd+0x2a2>
 2e0:	00001097          	auipc	ra,0x1
 2e4:	a22080e7          	jalr	-1502(ra) # d02 <free>
 2e8:	bff9                	j	2c6 <tailfd+0x2a2>
  free(lines);
 2ea:	856e                	mv	a0,s11
 2ec:	00001097          	auipc	ra,0x1
 2f0:	a16080e7          	jalr	-1514(ra) # d02 <free>
}
 2f4:	29813083          	ld	ra,664(sp)
 2f8:	29013403          	ld	s0,656(sp)
 2fc:	28813483          	ld	s1,648(sp)
 300:	28013903          	ld	s2,640(sp)
 304:	27813983          	ld	s3,632(sp)
 308:	27013a03          	ld	s4,624(sp)
 30c:	26813a83          	ld	s5,616(sp)
 310:	26013b03          	ld	s6,608(sp)
 314:	25813b83          	ld	s7,600(sp)
 318:	25013c03          	ld	s8,592(sp)
 31c:	24813c83          	ld	s9,584(sp)
 320:	24013d03          	ld	s10,576(sp)
 324:	23813d83          	ld	s11,568(sp)
 328:	2a010113          	addi	sp,sp,672
 32c:	8082                	ret

000000000000032e <main>:

int main(int argc, char *argv[])
{
 32e:	711d                	addi	sp,sp,-96
 330:	ec86                	sd	ra,88(sp)
 332:	e8a2                	sd	s0,80(sp)
 334:	e4a6                	sd	s1,72(sp)
 336:	e0ca                	sd	s2,64(sp)
 338:	fc4e                	sd	s3,56(sp)
 33a:	f852                	sd	s4,48(sp)
 33c:	f456                	sd	s5,40(sp)
 33e:	f05a                	sd	s6,32(sp)
 340:	ec5e                	sd	s7,24(sp)
 342:	e862                	sd	s8,16(sp)
 344:	e466                	sd	s9,8(sp)
 346:	e06a                	sd	s10,0(sp)
 348:	1080                	addi	s0,sp,96
  int n = DEF_N;
  int i = 1;
  int firstFile = 1;

  if(argc > 1){
 34a:	4785                	li	a5,1
 34c:	0aa7d563          	bge	a5,a0,3f6 <main+0xc8>
 350:	8a2a                	mv	s4,a0
 352:	892e                	mv	s2,a1
    if(argv[1][0] == '-'){
 354:	6588                	ld	a0,8(a1)
 356:	00054703          	lbu	a4,0(a0)
 35a:	02d00793          	li	a5,45
 35e:	02f70263          	beq	a4,a5,382 <main+0x54>
 362:	4985                	li	s3,1
 364:	4ba9                	li	s7,10
  if(i >= argc){
    tailfd(0, n);
    exit(0);
  }

  for(; i < argc; i++){
 366:	00399793          	slli	a5,s3,0x3
 36a:	993e                	add	s2,s2,a5
  int firstFile = 1;
 36c:	4b05                	li	s6,1
    int fd = open(argv[i], 0);
    if(fd < 0){
      fprintf(2, "tail: cannot open %s\n", argv[i]);
      exit(1);
    }
    if(argc - i > 1) {
 36e:	4c05                	li	s8,1
      if(!firstFile) printf("\n");
      printf("==> %s <==\n", argv[i]);
 370:	00001c97          	auipc	s9,0x1
 374:	b80c8c93          	addi	s9,s9,-1152 # ef0 <malloc+0x16c>
      if(!firstFile) printf("\n");
 378:	00001d17          	auipc	s10,0x1
 37c:	b40d0d13          	addi	s10,s10,-1216 # eb8 <malloc+0x134>
 380:	a8f1                	j	45c <main+0x12e>
      if(argv[1][1] == 'n'){
 382:	00154783          	lbu	a5,1(a0)
 386:	06e00713          	li	a4,110
 38a:	00e78c63          	beq	a5,a4,3a2 <main+0x74>
      } else if(argv[1][1] >= '0' && argv[1][1] <= '9'){
 38e:	fd07879b          	addiw	a5,a5,-48
 392:	0ff7f793          	zext.b	a5,a5
 396:	4725                	li	a4,9
 398:	02f77f63          	bgeu	a4,a5,3d6 <main+0xa8>
 39c:	4985                	li	s3,1
 39e:	4ba9                	li	s7,10
 3a0:	b7d9                	j	366 <main+0x38>
        if(argv[1][2]){ // -nN
 3a2:	00254783          	lbu	a5,2(a0)
 3a6:	eb81                	bnez	a5,3b6 <main+0x88>
          if(argc < 3) usage();
 3a8:	4789                	li	a5,2
 3aa:	0147ce63          	blt	a5,s4,3c6 <main+0x98>
 3ae:	00000097          	auipc	ra,0x0
 3b2:	c52080e7          	jalr	-942(ra) # 0 <usage>
          n = atoi(argv[1] + 2);
 3b6:	0509                	addi	a0,a0,2
 3b8:	00000097          	auipc	ra,0x0
 3bc:	282080e7          	jalr	642(ra) # 63a <atoi>
 3c0:	8baa                	mv	s7,a0
          i = 2;
 3c2:	4989                	li	s3,2
 3c4:	a005                	j	3e4 <main+0xb6>
          n = atoi(argv[2]);
 3c6:	6988                	ld	a0,16(a1)
 3c8:	00000097          	auipc	ra,0x0
 3cc:	272080e7          	jalr	626(ra) # 63a <atoi>
 3d0:	8baa                	mv	s7,a0
          i = 3;
 3d2:	498d                	li	s3,3
 3d4:	a801                	j	3e4 <main+0xb6>
        n = atoi(argv[1] + 1); // -N
 3d6:	0505                	addi	a0,a0,1
 3d8:	00000097          	auipc	ra,0x0
 3dc:	262080e7          	jalr	610(ra) # 63a <atoi>
 3e0:	8baa                	mv	s7,a0
        i = 2;
 3e2:	4989                	li	s3,2
    if(n <= 0) usage();
 3e4:	01705563          	blez	s7,3ee <main+0xc0>
  if(i >= argc){
 3e8:	f749cfe3          	blt	s3,s4,366 <main+0x38>
 3ec:	a031                	j	3f8 <main+0xca>
    if(n <= 0) usage();
 3ee:	00000097          	auipc	ra,0x0
 3f2:	c12080e7          	jalr	-1006(ra) # 0 <usage>
  int n = DEF_N;
 3f6:	4ba9                	li	s7,10
    tailfd(0, n);
 3f8:	85de                	mv	a1,s7
 3fa:	4501                	li	a0,0
 3fc:	00000097          	auipc	ra,0x0
 400:	c28080e7          	jalr	-984(ra) # 24 <tailfd>
    exit(0);
 404:	4501                	li	a0,0
 406:	00000097          	auipc	ra,0x0
 40a:	346080e7          	jalr	838(ra) # 74c <exit>
      fprintf(2, "tail: cannot open %s\n", argv[i]);
 40e:	00093603          	ld	a2,0(s2)
 412:	00001597          	auipc	a1,0x1
 416:	ac658593          	addi	a1,a1,-1338 # ed8 <malloc+0x154>
 41a:	4509                	li	a0,2
 41c:	00001097          	auipc	ra,0x1
 420:	882080e7          	jalr	-1918(ra) # c9e <fprintf>
      exit(1);
 424:	4505                	li	a0,1
 426:	00000097          	auipc	ra,0x0
 42a:	326080e7          	jalr	806(ra) # 74c <exit>
      printf("==> %s <==\n", argv[i]);
 42e:	000ab583          	ld	a1,0(s5)
 432:	8566                	mv	a0,s9
 434:	00001097          	auipc	ra,0x1
 438:	898080e7          	jalr	-1896(ra) # ccc <printf>
      firstFile = 0;
 43c:	4b01                	li	s6,0
    }
    tailfd(fd, n);
 43e:	85de                	mv	a1,s7
 440:	8526                	mv	a0,s1
 442:	00000097          	auipc	ra,0x0
 446:	be2080e7          	jalr	-1054(ra) # 24 <tailfd>
    close(fd);
 44a:	8526                	mv	a0,s1
 44c:	00000097          	auipc	ra,0x0
 450:	328080e7          	jalr	808(ra) # 774 <close>
  for(; i < argc; i++){
 454:	2985                	addiw	s3,s3,1
 456:	0921                	addi	s2,s2,8
 458:	0349d963          	bge	s3,s4,48a <main+0x15c>
    int fd = open(argv[i], 0);
 45c:	8aca                	mv	s5,s2
 45e:	4581                	li	a1,0
 460:	00093503          	ld	a0,0(s2)
 464:	00000097          	auipc	ra,0x0
 468:	328080e7          	jalr	808(ra) # 78c <open>
 46c:	84aa                	mv	s1,a0
    if(fd < 0){
 46e:	fa0540e3          	bltz	a0,40e <main+0xe0>
    if(argc - i > 1) {
 472:	413a07bb          	subw	a5,s4,s3
 476:	fcfc54e3          	bge	s8,a5,43e <main+0x110>
      if(!firstFile) printf("\n");
 47a:	fa0b1ae3          	bnez	s6,42e <main+0x100>
 47e:	856a                	mv	a0,s10
 480:	00001097          	auipc	ra,0x1
 484:	84c080e7          	jalr	-1972(ra) # ccc <printf>
 488:	b75d                	j	42e <main+0x100>
  }
  exit(0);
 48a:	4501                	li	a0,0
 48c:	00000097          	auipc	ra,0x0
 490:	2c0080e7          	jalr	704(ra) # 74c <exit>

0000000000000494 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 494:	1141                	addi	sp,sp,-16
 496:	e422                	sd	s0,8(sp)
 498:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 49a:	87aa                	mv	a5,a0
 49c:	0585                	addi	a1,a1,1
 49e:	0785                	addi	a5,a5,1
 4a0:	fff5c703          	lbu	a4,-1(a1)
 4a4:	fee78fa3          	sb	a4,-1(a5)
 4a8:	fb75                	bnez	a4,49c <strcpy+0x8>
    ;
  return os;
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret

00000000000004b0 <strcat>:

char*
strcat(char *s, const char *t)
{
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e422                	sd	s0,8(sp)
 4b4:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	c385                	beqz	a5,4da <strcat+0x2a>
 4bc:	87aa                	mv	a5,a0
    s++;
 4be:	0785                	addi	a5,a5,1
  while(*s)
 4c0:	0007c703          	lbu	a4,0(a5)
 4c4:	ff6d                	bnez	a4,4be <strcat+0xe>
  while((*s++ = *t++))
 4c6:	0585                	addi	a1,a1,1
 4c8:	0785                	addi	a5,a5,1
 4ca:	fff5c703          	lbu	a4,-1(a1)
 4ce:	fee78fa3          	sb	a4,-1(a5)
 4d2:	fb75                	bnez	a4,4c6 <strcat+0x16>
    ;
  return os;
}
 4d4:	6422                	ld	s0,8(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
  while(*s)
 4da:	87aa                	mv	a5,a0
 4dc:	b7ed                	j	4c6 <strcat+0x16>

00000000000004de <strcmp>:


int
strcmp(const char *p, const char *q)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 4e4:	00054783          	lbu	a5,0(a0)
 4e8:	cb91                	beqz	a5,4fc <strcmp+0x1e>
 4ea:	0005c703          	lbu	a4,0(a1)
 4ee:	00f71763          	bne	a4,a5,4fc <strcmp+0x1e>
    p++, q++;
 4f2:	0505                	addi	a0,a0,1
 4f4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4f6:	00054783          	lbu	a5,0(a0)
 4fa:	fbe5                	bnez	a5,4ea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 4fc:	0005c503          	lbu	a0,0(a1)
}
 500:	40a7853b          	subw	a0,a5,a0
 504:	6422                	ld	s0,8(sp)
 506:	0141                	addi	sp,sp,16
 508:	8082                	ret

000000000000050a <strlen>:

uint
strlen(const char *s)
{
 50a:	1141                	addi	sp,sp,-16
 50c:	e422                	sd	s0,8(sp)
 50e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 510:	00054783          	lbu	a5,0(a0)
 514:	cf91                	beqz	a5,530 <strlen+0x26>
 516:	0505                	addi	a0,a0,1
 518:	87aa                	mv	a5,a0
 51a:	4685                	li	a3,1
 51c:	9e89                	subw	a3,a3,a0
 51e:	00f6853b          	addw	a0,a3,a5
 522:	0785                	addi	a5,a5,1
 524:	fff7c703          	lbu	a4,-1(a5)
 528:	fb7d                	bnez	a4,51e <strlen+0x14>
    ;
  return n;
}
 52a:	6422                	ld	s0,8(sp)
 52c:	0141                	addi	sp,sp,16
 52e:	8082                	ret
  for(n = 0; s[n]; n++)
 530:	4501                	li	a0,0
 532:	bfe5                	j	52a <strlen+0x20>

0000000000000534 <memset>:

void*
memset(void *dst, int c, uint n)
{
 534:	1141                	addi	sp,sp,-16
 536:	e422                	sd	s0,8(sp)
 538:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 53a:	ca19                	beqz	a2,550 <memset+0x1c>
 53c:	87aa                	mv	a5,a0
 53e:	1602                	slli	a2,a2,0x20
 540:	9201                	srli	a2,a2,0x20
 542:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 546:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 54a:	0785                	addi	a5,a5,1
 54c:	fee79de3          	bne	a5,a4,546 <memset+0x12>
  }
  return dst;
}
 550:	6422                	ld	s0,8(sp)
 552:	0141                	addi	sp,sp,16
 554:	8082                	ret

0000000000000556 <strchr>:

char*
strchr(const char *s, char c)
{
 556:	1141                	addi	sp,sp,-16
 558:	e422                	sd	s0,8(sp)
 55a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 55c:	00054783          	lbu	a5,0(a0)
 560:	cb99                	beqz	a5,576 <strchr+0x20>
    if(*s == c)
 562:	00f58763          	beq	a1,a5,570 <strchr+0x1a>
  for(; *s; s++)
 566:	0505                	addi	a0,a0,1
 568:	00054783          	lbu	a5,0(a0)
 56c:	fbfd                	bnez	a5,562 <strchr+0xc>
      return (char*)s;
  return 0;
 56e:	4501                	li	a0,0
}
 570:	6422                	ld	s0,8(sp)
 572:	0141                	addi	sp,sp,16
 574:	8082                	ret
  return 0;
 576:	4501                	li	a0,0
 578:	bfe5                	j	570 <strchr+0x1a>

000000000000057a <gets>:

char*
gets(char *buf, int max)
{
 57a:	711d                	addi	sp,sp,-96
 57c:	ec86                	sd	ra,88(sp)
 57e:	e8a2                	sd	s0,80(sp)
 580:	e4a6                	sd	s1,72(sp)
 582:	e0ca                	sd	s2,64(sp)
 584:	fc4e                	sd	s3,56(sp)
 586:	f852                	sd	s4,48(sp)
 588:	f456                	sd	s5,40(sp)
 58a:	f05a                	sd	s6,32(sp)
 58c:	ec5e                	sd	s7,24(sp)
 58e:	e862                	sd	s8,16(sp)
 590:	1080                	addi	s0,sp,96
 592:	8baa                	mv	s7,a0
 594:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 596:	892a                	mv	s2,a0
 598:	4481                	li	s1,0
    cc = read(0, &c, 1);
 59a:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 59e:	4b29                	li	s6,10
 5a0:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 5a2:	89a6                	mv	s3,s1
 5a4:	2485                	addiw	s1,s1,1
 5a6:	0344d763          	bge	s1,s4,5d4 <gets+0x5a>
    cc = read(0, &c, 1);
 5aa:	4605                	li	a2,1
 5ac:	85d6                	mv	a1,s5
 5ae:	4501                	li	a0,0
 5b0:	00000097          	auipc	ra,0x0
 5b4:	1b4080e7          	jalr	436(ra) # 764 <read>
    if(cc < 1)
 5b8:	00a05e63          	blez	a0,5d4 <gets+0x5a>
    buf[i++] = c;
 5bc:	faf44783          	lbu	a5,-81(s0)
 5c0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 5c4:	01678763          	beq	a5,s6,5d2 <gets+0x58>
 5c8:	0905                	addi	s2,s2,1
 5ca:	fd879ce3          	bne	a5,s8,5a2 <gets+0x28>
  for(i=0; i+1 < max; ){
 5ce:	89a6                	mv	s3,s1
 5d0:	a011                	j	5d4 <gets+0x5a>
 5d2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 5d4:	99de                	add	s3,s3,s7
 5d6:	00098023          	sb	zero,0(s3)
  return buf;
}
 5da:	855e                	mv	a0,s7
 5dc:	60e6                	ld	ra,88(sp)
 5de:	6446                	ld	s0,80(sp)
 5e0:	64a6                	ld	s1,72(sp)
 5e2:	6906                	ld	s2,64(sp)
 5e4:	79e2                	ld	s3,56(sp)
 5e6:	7a42                	ld	s4,48(sp)
 5e8:	7aa2                	ld	s5,40(sp)
 5ea:	7b02                	ld	s6,32(sp)
 5ec:	6be2                	ld	s7,24(sp)
 5ee:	6c42                	ld	s8,16(sp)
 5f0:	6125                	addi	sp,sp,96
 5f2:	8082                	ret

00000000000005f4 <stat>:

int
stat(const char *n, struct stat *st)
{
 5f4:	1101                	addi	sp,sp,-32
 5f6:	ec06                	sd	ra,24(sp)
 5f8:	e822                	sd	s0,16(sp)
 5fa:	e426                	sd	s1,8(sp)
 5fc:	e04a                	sd	s2,0(sp)
 5fe:	1000                	addi	s0,sp,32
 600:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 602:	4581                	li	a1,0
 604:	00000097          	auipc	ra,0x0
 608:	188080e7          	jalr	392(ra) # 78c <open>
  if(fd < 0)
 60c:	02054563          	bltz	a0,636 <stat+0x42>
 610:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 612:	85ca                	mv	a1,s2
 614:	00000097          	auipc	ra,0x0
 618:	180080e7          	jalr	384(ra) # 794 <fstat>
 61c:	892a                	mv	s2,a0
  close(fd);
 61e:	8526                	mv	a0,s1
 620:	00000097          	auipc	ra,0x0
 624:	154080e7          	jalr	340(ra) # 774 <close>
  return r;
}
 628:	854a                	mv	a0,s2
 62a:	60e2                	ld	ra,24(sp)
 62c:	6442                	ld	s0,16(sp)
 62e:	64a2                	ld	s1,8(sp)
 630:	6902                	ld	s2,0(sp)
 632:	6105                	addi	sp,sp,32
 634:	8082                	ret
    return -1;
 636:	597d                	li	s2,-1
 638:	bfc5                	j	628 <stat+0x34>

000000000000063a <atoi>:

int
atoi(const char *s)
{
 63a:	1141                	addi	sp,sp,-16
 63c:	e422                	sd	s0,8(sp)
 63e:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 640:	00054703          	lbu	a4,0(a0)
 644:	02d00793          	li	a5,45
  int neg = 1;
 648:	4585                	li	a1,1
  if (*s == '-') {
 64a:	04f70363          	beq	a4,a5,690 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 64e:	00054703          	lbu	a4,0(a0)
 652:	fd07079b          	addiw	a5,a4,-48
 656:	0ff7f793          	zext.b	a5,a5
 65a:	46a5                	li	a3,9
 65c:	02f6ed63          	bltu	a3,a5,696 <atoi+0x5c>
  n = 0;
 660:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 662:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 664:	0505                	addi	a0,a0,1
 666:	0026979b          	slliw	a5,a3,0x2
 66a:	9fb5                	addw	a5,a5,a3
 66c:	0017979b          	slliw	a5,a5,0x1
 670:	9fb9                	addw	a5,a5,a4
 672:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 676:	00054703          	lbu	a4,0(a0)
 67a:	fd07079b          	addiw	a5,a4,-48
 67e:	0ff7f793          	zext.b	a5,a5
 682:	fef671e3          	bgeu	a2,a5,664 <atoi+0x2a>
  return n * neg;
}
 686:	02d5853b          	mulw	a0,a1,a3
 68a:	6422                	ld	s0,8(sp)
 68c:	0141                	addi	sp,sp,16
 68e:	8082                	ret
    s++;
 690:	0505                	addi	a0,a0,1
    neg = -1;
 692:	55fd                	li	a1,-1
 694:	bf6d                	j	64e <atoi+0x14>
  n = 0;
 696:	4681                	li	a3,0
 698:	b7fd                	j	686 <atoi+0x4c>

000000000000069a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 69a:	1141                	addi	sp,sp,-16
 69c:	e422                	sd	s0,8(sp)
 69e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6a0:	02b57463          	bgeu	a0,a1,6c8 <memmove+0x2e>
    while(n-- > 0)
 6a4:	00c05f63          	blez	a2,6c2 <memmove+0x28>
 6a8:	1602                	slli	a2,a2,0x20
 6aa:	9201                	srli	a2,a2,0x20
 6ac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6b0:	872a                	mv	a4,a0
      *dst++ = *src++;
 6b2:	0585                	addi	a1,a1,1
 6b4:	0705                	addi	a4,a4,1
 6b6:	fff5c683          	lbu	a3,-1(a1)
 6ba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6be:	fee79ae3          	bne	a5,a4,6b2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6c2:	6422                	ld	s0,8(sp)
 6c4:	0141                	addi	sp,sp,16
 6c6:	8082                	ret
    dst += n;
 6c8:	00c50733          	add	a4,a0,a2
    src += n;
 6cc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6ce:	fec05ae3          	blez	a2,6c2 <memmove+0x28>
 6d2:	fff6079b          	addiw	a5,a2,-1
 6d6:	1782                	slli	a5,a5,0x20
 6d8:	9381                	srli	a5,a5,0x20
 6da:	fff7c793          	not	a5,a5
 6de:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 6e0:	15fd                	addi	a1,a1,-1
 6e2:	177d                	addi	a4,a4,-1
 6e4:	0005c683          	lbu	a3,0(a1)
 6e8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 6ec:	fee79ae3          	bne	a5,a4,6e0 <memmove+0x46>
 6f0:	bfc9                	j	6c2 <memmove+0x28>

00000000000006f2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 6f2:	1141                	addi	sp,sp,-16
 6f4:	e422                	sd	s0,8(sp)
 6f6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 6f8:	ca05                	beqz	a2,728 <memcmp+0x36>
 6fa:	fff6069b          	addiw	a3,a2,-1
 6fe:	1682                	slli	a3,a3,0x20
 700:	9281                	srli	a3,a3,0x20
 702:	0685                	addi	a3,a3,1
 704:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 706:	00054783          	lbu	a5,0(a0)
 70a:	0005c703          	lbu	a4,0(a1)
 70e:	00e79863          	bne	a5,a4,71e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 712:	0505                	addi	a0,a0,1
    p2++;
 714:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 716:	fed518e3          	bne	a0,a3,706 <memcmp+0x14>
  }
  return 0;
 71a:	4501                	li	a0,0
 71c:	a019                	j	722 <memcmp+0x30>
      return *p1 - *p2;
 71e:	40e7853b          	subw	a0,a5,a4
}
 722:	6422                	ld	s0,8(sp)
 724:	0141                	addi	sp,sp,16
 726:	8082                	ret
  return 0;
 728:	4501                	li	a0,0
 72a:	bfe5                	j	722 <memcmp+0x30>

000000000000072c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 72c:	1141                	addi	sp,sp,-16
 72e:	e406                	sd	ra,8(sp)
 730:	e022                	sd	s0,0(sp)
 732:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 734:	00000097          	auipc	ra,0x0
 738:	f66080e7          	jalr	-154(ra) # 69a <memmove>
}
 73c:	60a2                	ld	ra,8(sp)
 73e:	6402                	ld	s0,0(sp)
 740:	0141                	addi	sp,sp,16
 742:	8082                	ret

0000000000000744 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 744:	4885                	li	a7,1
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <exit>:
.global exit
exit:
 li a7, SYS_exit
 74c:	4889                	li	a7,2
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <wait>:
.global wait
wait:
 li a7, SYS_wait
 754:	488d                	li	a7,3
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 75c:	4891                	li	a7,4
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <read>:
.global read
read:
 li a7, SYS_read
 764:	4895                	li	a7,5
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <write>:
.global write
write:
 li a7, SYS_write
 76c:	48c1                	li	a7,16
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <close>:
.global close
close:
 li a7, SYS_close
 774:	48d5                	li	a7,21
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <kill>:
.global kill
kill:
 li a7, SYS_kill
 77c:	4899                	li	a7,6
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <exec>:
.global exec
exec:
 li a7, SYS_exec
 784:	489d                	li	a7,7
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <open>:
.global open
open:
 li a7, SYS_open
 78c:	48bd                	li	a7,15
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 794:	48a1                	li	a7,8
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 79c:	48d1                	li	a7,20
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7a4:	48a5                	li	a7,9
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 7ac:	48a9                	li	a7,10
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7b4:	48ad                	li	a7,11
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7bc:	48b1                	li	a7,12
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7c4:	48b5                	li	a7,13
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7cc:	48b9                	li	a7,14
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 7d4:	48d9                	li	a7,22
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <dev>:
.global dev
dev:
 li a7, SYS_dev
 7dc:	48dd                	li	a7,23
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 7e4:	48e1                	li	a7,24
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 7ec:	48e5                	li	a7,25
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <remove>:
.global remove
remove:
 li a7, SYS_remove
 7f4:	48c5                	li	a7,17
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <trace>:
.global trace
trace:
 li a7, SYS_trace
 7fc:	48c9                	li	a7,18
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 804:	48cd                	li	a7,19
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <rename>:
.global rename
rename:
 li a7, SYS_rename
 80c:	48e9                	li	a7,26
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 814:	48ed                	li	a7,27
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 81c:	48f1                	li	a7,28
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 824:	48f5                	li	a7,29
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 82c:	48f9                	li	a7,30
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 834:	48fd                	li	a7,31
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 83c:	02000893          	li	a7,32
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 846:	02100893          	li	a7,33
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 850:	02200893          	li	a7,34
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 85a:	02300893          	li	a7,35
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 864:	02400893          	li	a7,36
 ecall
 868:	00000073          	ecall
 ret
 86c:	8082                	ret

000000000000086e <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 86e:	02500893          	li	a7,37
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 878:	02600893          	li	a7,38
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 882:	02700893          	li	a7,39
 ecall
 886:	00000073          	ecall
 ret
 88a:	8082                	ret

000000000000088c <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 88c:	02800893          	li	a7,40
 ecall
 890:	00000073          	ecall
 ret
 894:	8082                	ret

0000000000000896 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 896:	02900893          	li	a7,41
 ecall
 89a:	00000073          	ecall
 ret
 89e:	8082                	ret

00000000000008a0 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 8a0:	02a00893          	li	a7,42
 ecall
 8a4:	00000073          	ecall
 ret
 8a8:	8082                	ret

00000000000008aa <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 8aa:	02b00893          	li	a7,43
 ecall
 8ae:	00000073          	ecall
 ret
 8b2:	8082                	ret

00000000000008b4 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 8b4:	02c00893          	li	a7,44
 ecall
 8b8:	00000073          	ecall
 ret
 8bc:	8082                	ret

00000000000008be <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 8be:	02d00893          	li	a7,45
 ecall
 8c2:	00000073          	ecall
 ret
 8c6:	8082                	ret

00000000000008c8 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 8c8:	02e00893          	li	a7,46
 ecall
 8cc:	00000073          	ecall
 ret
 8d0:	8082                	ret

00000000000008d2 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 8d2:	02f00893          	li	a7,47
 ecall
 8d6:	00000073          	ecall
 ret
 8da:	8082                	ret

00000000000008dc <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 8dc:	03000893          	li	a7,48
 ecall
 8e0:	00000073          	ecall
 ret
 8e4:	8082                	ret

00000000000008e6 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 8e6:	03100893          	li	a7,49
 ecall
 8ea:	00000073          	ecall
 ret
 8ee:	8082                	ret

00000000000008f0 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 8f0:	03200893          	li	a7,50
 ecall
 8f4:	00000073          	ecall
 ret
 8f8:	8082                	ret

00000000000008fa <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 8fa:	03300893          	li	a7,51
 ecall
 8fe:	00000073          	ecall
 ret
 902:	8082                	ret

0000000000000904 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 904:	03400893          	li	a7,52
 ecall
 908:	00000073          	ecall
 ret
 90c:	8082                	ret

000000000000090e <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 90e:	03500893          	li	a7,53
 ecall
 912:	00000073          	ecall
 ret
 916:	8082                	ret

0000000000000918 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 918:	03600893          	li	a7,54
 ecall
 91c:	00000073          	ecall
 ret
 920:	8082                	ret

0000000000000922 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 922:	03700893          	li	a7,55
 ecall
 926:	00000073          	ecall
 ret
 92a:	8082                	ret

000000000000092c <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 92c:	03800893          	li	a7,56
 ecall
 930:	00000073          	ecall
 ret
 934:	8082                	ret

0000000000000936 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 936:	03900893          	li	a7,57
 ecall
 93a:	00000073          	ecall
 ret
 93e:	8082                	ret

0000000000000940 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 940:	03a00893          	li	a7,58
 ecall
 944:	00000073          	ecall
 ret
 948:	8082                	ret

000000000000094a <poll>:
.global poll
poll:
 li a7, SYS_poll
 94a:	03b00893          	li	a7,59
 ecall
 94e:	00000073          	ecall
 ret
 952:	8082                	ret

0000000000000954 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 954:	03c00893          	li	a7,60
 ecall
 958:	00000073          	ecall
 ret
 95c:	8082                	ret

000000000000095e <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 95e:	03d00893          	li	a7,61
 ecall
 962:	00000073          	ecall
 ret
 966:	8082                	ret

0000000000000968 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 968:	03e00893          	li	a7,62
 ecall
 96c:	00000073          	ecall
 ret
 970:	8082                	ret

0000000000000972 <clone>:
.global clone
clone:
 li a7, SYS_clone
 972:	03f00893          	li	a7,63
 ecall
 976:	00000073          	ecall
 ret
 97a:	8082                	ret

000000000000097c <futex>:
.global futex
futex:
 li a7, SYS_futex
 97c:	04000893          	li	a7,64
 ecall
 980:	00000073          	ecall
 ret
 984:	8082                	ret

0000000000000986 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 986:	04100893          	li	a7,65
 ecall
 98a:	00000073          	ecall
 ret
 98e:	8082                	ret

0000000000000990 <halt>:
.global halt
halt:
 li a7, SYS_halt
 990:	04200893          	li	a7,66
 ecall
 994:	00000073          	ecall
 ret
 998:	8082                	ret

000000000000099a <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 99a:	04300893          	li	a7,67
 ecall
 99e:	00000073          	ecall
 ret
 9a2:	8082                	ret

00000000000009a4 <socket>:
.global socket
socket:
 li a7, SYS_socket
 9a4:	04400893          	li	a7,68
 ecall
 9a8:	00000073          	ecall
 ret
 9ac:	8082                	ret

00000000000009ae <bind>:
.global bind
bind:
 li a7, SYS_bind
 9ae:	04500893          	li	a7,69
 ecall
 9b2:	00000073          	ecall
 ret
 9b6:	8082                	ret

00000000000009b8 <listen>:
.global listen
listen:
 li a7, SYS_listen
 9b8:	04600893          	li	a7,70
 ecall
 9bc:	00000073          	ecall
 ret
 9c0:	8082                	ret

00000000000009c2 <accept>:
.global accept
accept:
 li a7, SYS_accept
 9c2:	04700893          	li	a7,71
 ecall
 9c6:	00000073          	ecall
 ret
 9ca:	8082                	ret

00000000000009cc <connect>:
.global connect
connect:
 li a7, SYS_connect
 9cc:	04800893          	li	a7,72
 ecall
 9d0:	00000073          	ecall
 ret
 9d4:	8082                	ret

00000000000009d6 <send>:
.global send
send:
 li a7, SYS_send
 9d6:	04900893          	li	a7,73
 ecall
 9da:	00000073          	ecall
 ret
 9de:	8082                	ret

00000000000009e0 <recv>:
.global recv
recv:
 li a7, SYS_recv
 9e0:	04a00893          	li	a7,74
 ecall
 9e4:	00000073          	ecall
 ret
 9e8:	8082                	ret

00000000000009ea <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 9ea:	04b00893          	li	a7,75
 ecall
 9ee:	00000073          	ecall
 ret
 9f2:	8082                	ret

00000000000009f4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 9f4:	1101                	addi	sp,sp,-32
 9f6:	ec06                	sd	ra,24(sp)
 9f8:	e822                	sd	s0,16(sp)
 9fa:	1000                	addi	s0,sp,32
 9fc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a00:	4605                	li	a2,1
 a02:	fef40593          	addi	a1,s0,-17
 a06:	00000097          	auipc	ra,0x0
 a0a:	d66080e7          	jalr	-666(ra) # 76c <write>
}
 a0e:	60e2                	ld	ra,24(sp)
 a10:	6442                	ld	s0,16(sp)
 a12:	6105                	addi	sp,sp,32
 a14:	8082                	ret

0000000000000a16 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a16:	7139                	addi	sp,sp,-64
 a18:	fc06                	sd	ra,56(sp)
 a1a:	f822                	sd	s0,48(sp)
 a1c:	f426                	sd	s1,40(sp)
 a1e:	f04a                	sd	s2,32(sp)
 a20:	ec4e                	sd	s3,24(sp)
 a22:	0080                	addi	s0,sp,64
 a24:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a26:	c299                	beqz	a3,a2c <printint+0x16>
 a28:	0805c863          	bltz	a1,ab8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a2c:	2581                	sext.w	a1,a1
  neg = 0;
 a2e:	4881                	li	a7,0
  }

  i = 0;
 a30:	fc040993          	addi	s3,s0,-64
  neg = 0;
 a34:	86ce                	mv	a3,s3
  i = 0;
 a36:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a38:	2601                	sext.w	a2,a2
 a3a:	00000517          	auipc	a0,0x0
 a3e:	52650513          	addi	a0,a0,1318 # f60 <digits>
 a42:	883a                	mv	a6,a4
 a44:	2705                	addiw	a4,a4,1
 a46:	02c5f7bb          	remuw	a5,a1,a2
 a4a:	1782                	slli	a5,a5,0x20
 a4c:	9381                	srli	a5,a5,0x20
 a4e:	97aa                	add	a5,a5,a0
 a50:	0007c783          	lbu	a5,0(a5)
 a54:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a58:	0005879b          	sext.w	a5,a1
 a5c:	02c5d5bb          	divuw	a1,a1,a2
 a60:	0685                	addi	a3,a3,1
 a62:	fec7f0e3          	bgeu	a5,a2,a42 <printint+0x2c>
  if(neg)
 a66:	00088c63          	beqz	a7,a7e <printint+0x68>
    buf[i++] = '-';
 a6a:	fd070793          	addi	a5,a4,-48
 a6e:	00878733          	add	a4,a5,s0
 a72:	02d00793          	li	a5,45
 a76:	fef70823          	sb	a5,-16(a4)
 a7a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a7e:	02e05663          	blez	a4,aaa <printint+0x94>
 a82:	fc040913          	addi	s2,s0,-64
 a86:	993a                	add	s2,s2,a4
 a88:	19fd                	addi	s3,s3,-1
 a8a:	99ba                	add	s3,s3,a4
 a8c:	377d                	addiw	a4,a4,-1
 a8e:	1702                	slli	a4,a4,0x20
 a90:	9301                	srli	a4,a4,0x20
 a92:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a96:	fff94583          	lbu	a1,-1(s2)
 a9a:	8526                	mv	a0,s1
 a9c:	00000097          	auipc	ra,0x0
 aa0:	f58080e7          	jalr	-168(ra) # 9f4 <putc>
  while(--i >= 0)
 aa4:	197d                	addi	s2,s2,-1
 aa6:	ff3918e3          	bne	s2,s3,a96 <printint+0x80>
}
 aaa:	70e2                	ld	ra,56(sp)
 aac:	7442                	ld	s0,48(sp)
 aae:	74a2                	ld	s1,40(sp)
 ab0:	7902                	ld	s2,32(sp)
 ab2:	69e2                	ld	s3,24(sp)
 ab4:	6121                	addi	sp,sp,64
 ab6:	8082                	ret
    x = -xx;
 ab8:	40b005bb          	negw	a1,a1
    neg = 1;
 abc:	4885                	li	a7,1
    x = -xx;
 abe:	bf8d                	j	a30 <printint+0x1a>

0000000000000ac0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 ac0:	7119                	addi	sp,sp,-128
 ac2:	fc86                	sd	ra,120(sp)
 ac4:	f8a2                	sd	s0,112(sp)
 ac6:	f4a6                	sd	s1,104(sp)
 ac8:	f0ca                	sd	s2,96(sp)
 aca:	ecce                	sd	s3,88(sp)
 acc:	e8d2                	sd	s4,80(sp)
 ace:	e4d6                	sd	s5,72(sp)
 ad0:	e0da                	sd	s6,64(sp)
 ad2:	fc5e                	sd	s7,56(sp)
 ad4:	f862                	sd	s8,48(sp)
 ad6:	f466                	sd	s9,40(sp)
 ad8:	f06a                	sd	s10,32(sp)
 ada:	ec6e                	sd	s11,24(sp)
 adc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 ade:	0005c903          	lbu	s2,0(a1)
 ae2:	18090f63          	beqz	s2,c80 <vprintf+0x1c0>
 ae6:	8aaa                	mv	s5,a0
 ae8:	8b32                	mv	s6,a2
 aea:	00158493          	addi	s1,a1,1
  state = 0;
 aee:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 af0:	02500a13          	li	s4,37
 af4:	4c55                	li	s8,21
 af6:	00000c97          	auipc	s9,0x0
 afa:	412c8c93          	addi	s9,s9,1042 # f08 <malloc+0x184>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 afe:	02800d93          	li	s11,40
  putc(fd, 'x');
 b02:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b04:	00000b97          	auipc	s7,0x0
 b08:	45cb8b93          	addi	s7,s7,1116 # f60 <digits>
 b0c:	a839                	j	b2a <vprintf+0x6a>
        putc(fd, c);
 b0e:	85ca                	mv	a1,s2
 b10:	8556                	mv	a0,s5
 b12:	00000097          	auipc	ra,0x0
 b16:	ee2080e7          	jalr	-286(ra) # 9f4 <putc>
 b1a:	a019                	j	b20 <vprintf+0x60>
    } else if(state == '%'){
 b1c:	01498d63          	beq	s3,s4,b36 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 b20:	0485                	addi	s1,s1,1
 b22:	fff4c903          	lbu	s2,-1(s1)
 b26:	14090d63          	beqz	s2,c80 <vprintf+0x1c0>
    if(state == 0){
 b2a:	fe0999e3          	bnez	s3,b1c <vprintf+0x5c>
      if(c == '%'){
 b2e:	ff4910e3          	bne	s2,s4,b0e <vprintf+0x4e>
        state = '%';
 b32:	89d2                	mv	s3,s4
 b34:	b7f5                	j	b20 <vprintf+0x60>
      if(c == 'd'){
 b36:	11490c63          	beq	s2,s4,c4e <vprintf+0x18e>
 b3a:	f9d9079b          	addiw	a5,s2,-99
 b3e:	0ff7f793          	zext.b	a5,a5
 b42:	10fc6e63          	bltu	s8,a5,c5e <vprintf+0x19e>
 b46:	f9d9079b          	addiw	a5,s2,-99
 b4a:	0ff7f713          	zext.b	a4,a5
 b4e:	10ec6863          	bltu	s8,a4,c5e <vprintf+0x19e>
 b52:	00271793          	slli	a5,a4,0x2
 b56:	97e6                	add	a5,a5,s9
 b58:	439c                	lw	a5,0(a5)
 b5a:	97e6                	add	a5,a5,s9
 b5c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b5e:	008b0913          	addi	s2,s6,8
 b62:	4685                	li	a3,1
 b64:	4629                	li	a2,10
 b66:	000b2583          	lw	a1,0(s6)
 b6a:	8556                	mv	a0,s5
 b6c:	00000097          	auipc	ra,0x0
 b70:	eaa080e7          	jalr	-342(ra) # a16 <printint>
 b74:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b76:	4981                	li	s3,0
 b78:	b765                	j	b20 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b7a:	008b0913          	addi	s2,s6,8
 b7e:	4681                	li	a3,0
 b80:	4629                	li	a2,10
 b82:	000b2583          	lw	a1,0(s6)
 b86:	8556                	mv	a0,s5
 b88:	00000097          	auipc	ra,0x0
 b8c:	e8e080e7          	jalr	-370(ra) # a16 <printint>
 b90:	8b4a                	mv	s6,s2
      state = 0;
 b92:	4981                	li	s3,0
 b94:	b771                	j	b20 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 b96:	008b0913          	addi	s2,s6,8
 b9a:	4681                	li	a3,0
 b9c:	866a                	mv	a2,s10
 b9e:	000b2583          	lw	a1,0(s6)
 ba2:	8556                	mv	a0,s5
 ba4:	00000097          	auipc	ra,0x0
 ba8:	e72080e7          	jalr	-398(ra) # a16 <printint>
 bac:	8b4a                	mv	s6,s2
      state = 0;
 bae:	4981                	li	s3,0
 bb0:	bf85                	j	b20 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 bb2:	008b0793          	addi	a5,s6,8
 bb6:	f8f43423          	sd	a5,-120(s0)
 bba:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 bbe:	03000593          	li	a1,48
 bc2:	8556                	mv	a0,s5
 bc4:	00000097          	auipc	ra,0x0
 bc8:	e30080e7          	jalr	-464(ra) # 9f4 <putc>
  putc(fd, 'x');
 bcc:	07800593          	li	a1,120
 bd0:	8556                	mv	a0,s5
 bd2:	00000097          	auipc	ra,0x0
 bd6:	e22080e7          	jalr	-478(ra) # 9f4 <putc>
 bda:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 bdc:	03c9d793          	srli	a5,s3,0x3c
 be0:	97de                	add	a5,a5,s7
 be2:	0007c583          	lbu	a1,0(a5)
 be6:	8556                	mv	a0,s5
 be8:	00000097          	auipc	ra,0x0
 bec:	e0c080e7          	jalr	-500(ra) # 9f4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 bf0:	0992                	slli	s3,s3,0x4
 bf2:	397d                	addiw	s2,s2,-1
 bf4:	fe0914e3          	bnez	s2,bdc <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 bf8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 bfc:	4981                	li	s3,0
 bfe:	b70d                	j	b20 <vprintf+0x60>
        s = va_arg(ap, char*);
 c00:	008b0913          	addi	s2,s6,8
 c04:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 c08:	02098163          	beqz	s3,c2a <vprintf+0x16a>
        while(*s != 0){
 c0c:	0009c583          	lbu	a1,0(s3)
 c10:	c5ad                	beqz	a1,c7a <vprintf+0x1ba>
          putc(fd, *s);
 c12:	8556                	mv	a0,s5
 c14:	00000097          	auipc	ra,0x0
 c18:	de0080e7          	jalr	-544(ra) # 9f4 <putc>
          s++;
 c1c:	0985                	addi	s3,s3,1
        while(*s != 0){
 c1e:	0009c583          	lbu	a1,0(s3)
 c22:	f9e5                	bnez	a1,c12 <vprintf+0x152>
        s = va_arg(ap, char*);
 c24:	8b4a                	mv	s6,s2
      state = 0;
 c26:	4981                	li	s3,0
 c28:	bde5                	j	b20 <vprintf+0x60>
          s = "(null)";
 c2a:	00000997          	auipc	s3,0x0
 c2e:	2d698993          	addi	s3,s3,726 # f00 <malloc+0x17c>
        while(*s != 0){
 c32:	85ee                	mv	a1,s11
 c34:	bff9                	j	c12 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 c36:	008b0913          	addi	s2,s6,8
 c3a:	000b4583          	lbu	a1,0(s6)
 c3e:	8556                	mv	a0,s5
 c40:	00000097          	auipc	ra,0x0
 c44:	db4080e7          	jalr	-588(ra) # 9f4 <putc>
 c48:	8b4a                	mv	s6,s2
      state = 0;
 c4a:	4981                	li	s3,0
 c4c:	bdd1                	j	b20 <vprintf+0x60>
        putc(fd, c);
 c4e:	85d2                	mv	a1,s4
 c50:	8556                	mv	a0,s5
 c52:	00000097          	auipc	ra,0x0
 c56:	da2080e7          	jalr	-606(ra) # 9f4 <putc>
      state = 0;
 c5a:	4981                	li	s3,0
 c5c:	b5d1                	j	b20 <vprintf+0x60>
        putc(fd, '%');
 c5e:	85d2                	mv	a1,s4
 c60:	8556                	mv	a0,s5
 c62:	00000097          	auipc	ra,0x0
 c66:	d92080e7          	jalr	-622(ra) # 9f4 <putc>
        putc(fd, c);
 c6a:	85ca                	mv	a1,s2
 c6c:	8556                	mv	a0,s5
 c6e:	00000097          	auipc	ra,0x0
 c72:	d86080e7          	jalr	-634(ra) # 9f4 <putc>
      state = 0;
 c76:	4981                	li	s3,0
 c78:	b565                	j	b20 <vprintf+0x60>
        s = va_arg(ap, char*);
 c7a:	8b4a                	mv	s6,s2
      state = 0;
 c7c:	4981                	li	s3,0
 c7e:	b54d                	j	b20 <vprintf+0x60>
    }
  }
}
 c80:	70e6                	ld	ra,120(sp)
 c82:	7446                	ld	s0,112(sp)
 c84:	74a6                	ld	s1,104(sp)
 c86:	7906                	ld	s2,96(sp)
 c88:	69e6                	ld	s3,88(sp)
 c8a:	6a46                	ld	s4,80(sp)
 c8c:	6aa6                	ld	s5,72(sp)
 c8e:	6b06                	ld	s6,64(sp)
 c90:	7be2                	ld	s7,56(sp)
 c92:	7c42                	ld	s8,48(sp)
 c94:	7ca2                	ld	s9,40(sp)
 c96:	7d02                	ld	s10,32(sp)
 c98:	6de2                	ld	s11,24(sp)
 c9a:	6109                	addi	sp,sp,128
 c9c:	8082                	ret

0000000000000c9e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c9e:	715d                	addi	sp,sp,-80
 ca0:	ec06                	sd	ra,24(sp)
 ca2:	e822                	sd	s0,16(sp)
 ca4:	1000                	addi	s0,sp,32
 ca6:	e010                	sd	a2,0(s0)
 ca8:	e414                	sd	a3,8(s0)
 caa:	e818                	sd	a4,16(s0)
 cac:	ec1c                	sd	a5,24(s0)
 cae:	03043023          	sd	a6,32(s0)
 cb2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 cb6:	8622                	mv	a2,s0
 cb8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 cbc:	00000097          	auipc	ra,0x0
 cc0:	e04080e7          	jalr	-508(ra) # ac0 <vprintf>
}
 cc4:	60e2                	ld	ra,24(sp)
 cc6:	6442                	ld	s0,16(sp)
 cc8:	6161                	addi	sp,sp,80
 cca:	8082                	ret

0000000000000ccc <printf>:

void
printf(const char *fmt, ...)
{
 ccc:	711d                	addi	sp,sp,-96
 cce:	ec06                	sd	ra,24(sp)
 cd0:	e822                	sd	s0,16(sp)
 cd2:	1000                	addi	s0,sp,32
 cd4:	e40c                	sd	a1,8(s0)
 cd6:	e810                	sd	a2,16(s0)
 cd8:	ec14                	sd	a3,24(s0)
 cda:	f018                	sd	a4,32(s0)
 cdc:	f41c                	sd	a5,40(s0)
 cde:	03043823          	sd	a6,48(s0)
 ce2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ce6:	00840613          	addi	a2,s0,8
 cea:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 cee:	85aa                	mv	a1,a0
 cf0:	4505                	li	a0,1
 cf2:	00000097          	auipc	ra,0x0
 cf6:	dce080e7          	jalr	-562(ra) # ac0 <vprintf>
}
 cfa:	60e2                	ld	ra,24(sp)
 cfc:	6442                	ld	s0,16(sp)
 cfe:	6125                	addi	sp,sp,96
 d00:	8082                	ret

0000000000000d02 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d02:	1141                	addi	sp,sp,-16
 d04:	e422                	sd	s0,8(sp)
 d06:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d08:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d0c:	00000797          	auipc	a5,0x0
 d10:	26c7b783          	ld	a5,620(a5) # f78 <freep>
 d14:	a02d                	j	d3e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 d16:	4618                	lw	a4,8(a2)
 d18:	9f2d                	addw	a4,a4,a1
 d1a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 d1e:	6398                	ld	a4,0(a5)
 d20:	6310                	ld	a2,0(a4)
 d22:	a83d                	j	d60 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 d24:	ff852703          	lw	a4,-8(a0)
 d28:	9f31                	addw	a4,a4,a2
 d2a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d2c:	ff053683          	ld	a3,-16(a0)
 d30:	a091                	j	d74 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d32:	6398                	ld	a4,0(a5)
 d34:	00e7e463          	bltu	a5,a4,d3c <free+0x3a>
 d38:	00e6ea63          	bltu	a3,a4,d4c <free+0x4a>
{
 d3c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d3e:	fed7fae3          	bgeu	a5,a3,d32 <free+0x30>
 d42:	6398                	ld	a4,0(a5)
 d44:	00e6e463          	bltu	a3,a4,d4c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d48:	fee7eae3          	bltu	a5,a4,d3c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 d4c:	ff852583          	lw	a1,-8(a0)
 d50:	6390                	ld	a2,0(a5)
 d52:	02059813          	slli	a6,a1,0x20
 d56:	01c85713          	srli	a4,a6,0x1c
 d5a:	9736                	add	a4,a4,a3
 d5c:	fae60de3          	beq	a2,a4,d16 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 d60:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 d64:	4790                	lw	a2,8(a5)
 d66:	02061593          	slli	a1,a2,0x20
 d6a:	01c5d713          	srli	a4,a1,0x1c
 d6e:	973e                	add	a4,a4,a5
 d70:	fae68ae3          	beq	a3,a4,d24 <free+0x22>
    p->s.ptr = bp->s.ptr;
 d74:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 d76:	00000717          	auipc	a4,0x0
 d7a:	20f73123          	sd	a5,514(a4) # f78 <freep>
}
 d7e:	6422                	ld	s0,8(sp)
 d80:	0141                	addi	sp,sp,16
 d82:	8082                	ret

0000000000000d84 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d84:	7139                	addi	sp,sp,-64
 d86:	fc06                	sd	ra,56(sp)
 d88:	f822                	sd	s0,48(sp)
 d8a:	f426                	sd	s1,40(sp)
 d8c:	f04a                	sd	s2,32(sp)
 d8e:	ec4e                	sd	s3,24(sp)
 d90:	e852                	sd	s4,16(sp)
 d92:	e456                	sd	s5,8(sp)
 d94:	e05a                	sd	s6,0(sp)
 d96:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d98:	02051493          	slli	s1,a0,0x20
 d9c:	9081                	srli	s1,s1,0x20
 d9e:	04bd                	addi	s1,s1,15
 da0:	8091                	srli	s1,s1,0x4
 da2:	00148a1b          	addiw	s4,s1,1
 da6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 da8:	00000517          	auipc	a0,0x0
 dac:	1d053503          	ld	a0,464(a0) # f78 <freep>
 db0:	c515                	beqz	a0,ddc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 db2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 db4:	4798                	lw	a4,8(a5)
 db6:	04977163          	bgeu	a4,s1,df8 <malloc+0x74>
 dba:	89d2                	mv	s3,s4
 dbc:	000a071b          	sext.w	a4,s4
 dc0:	6685                	lui	a3,0x1
 dc2:	00d77363          	bgeu	a4,a3,dc8 <malloc+0x44>
 dc6:	6985                	lui	s3,0x1
 dc8:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 dcc:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 dd0:	00000917          	auipc	s2,0x0
 dd4:	1a890913          	addi	s2,s2,424 # f78 <freep>
  if(p == (char*)-1)
 dd8:	5afd                	li	s5,-1
 dda:	a8a5                	j	e52 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 ddc:	00000797          	auipc	a5,0x0
 de0:	19c78793          	addi	a5,a5,412 # f78 <freep>
 de4:	00000717          	auipc	a4,0x0
 de8:	19c70713          	addi	a4,a4,412 # f80 <base>
 dec:	e398                	sd	a4,0(a5)
 dee:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 df0:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 df4:	87ba                	mv	a5,a4
 df6:	b7d1                	j	dba <malloc+0x36>
      if(p->s.size == nunits)
 df8:	02e48c63          	beq	s1,a4,e30 <malloc+0xac>
        p->s.size -= nunits;
 dfc:	4147073b          	subw	a4,a4,s4
 e00:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e02:	02071693          	slli	a3,a4,0x20
 e06:	01c6d713          	srli	a4,a3,0x1c
 e0a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 e0c:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 e10:	00000717          	auipc	a4,0x0
 e14:	16a73423          	sd	a0,360(a4) # f78 <freep>
      return (void*)(p + 1);
 e18:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 e1c:	70e2                	ld	ra,56(sp)
 e1e:	7442                	ld	s0,48(sp)
 e20:	74a2                	ld	s1,40(sp)
 e22:	7902                	ld	s2,32(sp)
 e24:	69e2                	ld	s3,24(sp)
 e26:	6a42                	ld	s4,16(sp)
 e28:	6aa2                	ld	s5,8(sp)
 e2a:	6b02                	ld	s6,0(sp)
 e2c:	6121                	addi	sp,sp,64
 e2e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 e30:	6398                	ld	a4,0(a5)
 e32:	e118                	sd	a4,0(a0)
 e34:	bff1                	j	e10 <malloc+0x8c>
  hp->s.size = nu;
 e36:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 e3a:	0541                	addi	a0,a0,16
 e3c:	00000097          	auipc	ra,0x0
 e40:	ec6080e7          	jalr	-314(ra) # d02 <free>
  return freep;
 e44:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 e48:	d971                	beqz	a0,e1c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e4a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 e4c:	4798                	lw	a4,8(a5)
 e4e:	fa9775e3          	bgeu	a4,s1,df8 <malloc+0x74>
    if(p == freep)
 e52:	00093703          	ld	a4,0(s2)
 e56:	853e                	mv	a0,a5
 e58:	fef719e3          	bne	a4,a5,e4a <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 e5c:	854e                	mv	a0,s3
 e5e:	00000097          	auipc	ra,0x0
 e62:	95e080e7          	jalr	-1698(ra) # 7bc <sbrk>
  if(p == (char*)-1)
 e66:	fd5518e3          	bne	a0,s5,e36 <malloc+0xb2>
        return 0;
 e6a:	4501                	li	a0,0
 e6c:	bf45                	j	e1c <malloc+0x98>
