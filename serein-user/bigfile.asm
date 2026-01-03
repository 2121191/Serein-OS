
serein-user/_bigfile：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#define BSIZE 512
#define TARGET_SIZE (10 * 1024 * 1024) // 10MB

int
main(int argc, char *argv[])
{
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	24913c23          	sd	s1,600(sp)
  10:	25213823          	sd	s2,592(sp)
  14:	25313423          	sd	s3,584(sp)
  18:	25413023          	sd	s4,576(sp)
  1c:	23513c23          	sd	s5,568(sp)
  20:	23613823          	sd	s6,560(sp)
  24:	23713423          	sd	s7,552(sp)
  28:	23813023          	sd	s8,544(sp)
  2c:	21913c23          	sd	s9,536(sp)
  30:	1c80                	addi	s0,sp,624
  int fd, i;
  char buf[BSIZE];
  int n;
  char *fname = "bigfile.txt";

  printf("bigfile: creating %s, target size %d bytes\n", fname, TARGET_SIZE);
  32:	00a00637          	lui	a2,0xa00
  36:	00001597          	auipc	a1,0x1
  3a:	e1258593          	addi	a1,a1,-494 # e48 <malloc+0xec>
  3e:	00001517          	auipc	a0,0x1
  42:	e1a50513          	addi	a0,a0,-486 # e58 <malloc+0xfc>
  46:	00001097          	auipc	ra,0x1
  4a:	c5e080e7          	jalr	-930(ra) # ca4 <printf>

  fd = open(fname, O_CREATE | O_RDWR);
  4e:	20200593          	li	a1,514
  52:	00001517          	auipc	a0,0x1
  56:	df650513          	addi	a0,a0,-522 # e48 <malloc+0xec>
  5a:	00000097          	auipc	ra,0x0
  5e:	70a080e7          	jalr	1802(ra) # 764 <open>
  62:	89aa                	mv	s3,a0
  if(fd < 0){
  64:	da040713          	addi	a4,s0,-608
    printf("bigfile: cannot open %s\n", fname);
    exit(0); // Failed to open file
  }

  // Initialize buffer with some pattern
  for(i = 0; i < BSIZE; i++){
  68:	4781                	li	a5,0
  6a:	20000693          	li	a3,512
  if(fd < 0){
  6e:	02054863          	bltz	a0,9e <main+0x9e>
    buf[i] = i % 256;
  72:	00f70023          	sb	a5,0(a4)
  for(i = 0; i < BSIZE; i++){
  76:	2785                	addiw	a5,a5,1
  78:	0705                	addi	a4,a4,1
  7a:	fed79ce3          	bne	a5,a3,72 <main+0x72>
  }

  int total_written = 0;
  int start_time = uptime();
  7e:	00000097          	auipc	ra,0x0
  82:	726080e7          	jalr	1830(ra) # 7a4 <uptime>
  86:	8c2a                	mv	s8,a0
  int total_written = 0;
  88:	4901                	li	s2,0

  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
  8a:	4481                	li	s1,0
    if((n = write(fd, buf, BSIZE)) != BSIZE){
  8c:	da040a13          	addi	s4,s0,-608
      printf("bigfile: write error at block %d, wrote %d bytes (expected %d)\n", i, n, BSIZE);
      exit(0); // Write failed
    }
    total_written += n;
    if((total_written % (100 * 1024)) == 0){
  90:	6b65                	lui	s6,0x19
      printf("bigfile: written %d KB\n", total_written / 1024);
  92:	00001b97          	auipc	s7,0x1
  96:	e56b8b93          	addi	s7,s7,-426 # ee8 <malloc+0x18c>
  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
  9a:	6a95                	lui	s5,0x5
  9c:	a0b1                	j	e8 <main+0xe8>
    printf("bigfile: cannot open %s\n", fname);
  9e:	00001597          	auipc	a1,0x1
  a2:	daa58593          	addi	a1,a1,-598 # e48 <malloc+0xec>
  a6:	00001517          	auipc	a0,0x1
  aa:	de250513          	addi	a0,a0,-542 # e88 <malloc+0x12c>
  ae:	00001097          	auipc	ra,0x1
  b2:	bf6080e7          	jalr	-1034(ra) # ca4 <printf>
    exit(0); // Failed to open file
  b6:	4501                	li	a0,0
  b8:	00000097          	auipc	ra,0x0
  bc:	66c080e7          	jalr	1644(ra) # 724 <exit>
      printf("bigfile: write error at block %d, wrote %d bytes (expected %d)\n", i, n, BSIZE);
  c0:	20000693          	li	a3,512
  c4:	862a                	mv	a2,a0
  c6:	85a6                	mv	a1,s1
  c8:	00001517          	auipc	a0,0x1
  cc:	de050513          	addi	a0,a0,-544 # ea8 <malloc+0x14c>
  d0:	00001097          	auipc	ra,0x1
  d4:	bd4080e7          	jalr	-1068(ra) # ca4 <printf>
      exit(0); // Write failed
  d8:	4501                	li	a0,0
  da:	00000097          	auipc	ra,0x0
  de:	64a080e7          	jalr	1610(ra) # 724 <exit>
  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
  e2:	2485                	addiw	s1,s1,1
  e4:	05548263          	beq	s1,s5,128 <main+0x128>
    if((n = write(fd, buf, BSIZE)) != BSIZE){
  e8:	20000613          	li	a2,512
  ec:	85d2                	mv	a1,s4
  ee:	854e                	mv	a0,s3
  f0:	00000097          	auipc	ra,0x0
  f4:	654080e7          	jalr	1620(ra) # 744 <write>
  f8:	20000793          	li	a5,512
  fc:	fcf512e3          	bne	a0,a5,c0 <main+0xc0>
    total_written += n;
 100:	2009079b          	addiw	a5,s2,512
 104:	0007891b          	sext.w	s2,a5
    if((total_written % (100 * 1024)) == 0){
 108:	0367e73b          	remw	a4,a5,s6
 10c:	fb79                	bnez	a4,e2 <main+0xe2>
      printf("bigfile: written %d KB\n", total_written / 1024);
 10e:	41f7d59b          	sraiw	a1,a5,0x1f
 112:	0165d59b          	srliw	a1,a1,0x16
 116:	9dbd                	addw	a1,a1,a5
 118:	40a5d59b          	sraiw	a1,a1,0xa
 11c:	855e                	mv	a0,s7
 11e:	00001097          	auipc	ra,0x1
 122:	b86080e7          	jalr	-1146(ra) # ca4 <printf>
 126:	bf75                	j	e2 <main+0xe2>
    }
  }

  printf("bigfile: write complete, total %d bytes\n", total_written);
 128:	85ca                	mv	a1,s2
 12a:	00001517          	auipc	a0,0x1
 12e:	dd650513          	addi	a0,a0,-554 # f00 <malloc+0x1a4>
 132:	00001097          	auipc	ra,0x1
 136:	b72080e7          	jalr	-1166(ra) # ca4 <printf>
  close(fd);
 13a:	854e                	mv	a0,s3
 13c:	00000097          	auipc	ra,0x0
 140:	610080e7          	jalr	1552(ra) # 74c <close>
  int end_time = uptime();
 144:	00000097          	auipc	ra,0x0
 148:	660080e7          	jalr	1632(ra) # 7a4 <uptime>
  printf("bigfile: time taken (ticks): %d\n", end_time - start_time);
 14c:	41850c3b          	subw	s8,a0,s8
 150:	85e2                	mv	a1,s8
 152:	00001517          	auipc	a0,0x1
 156:	dde50513          	addi	a0,a0,-546 # f30 <malloc+0x1d4>
 15a:	00001097          	auipc	ra,0x1
 15e:	b4a080e7          	jalr	-1206(ra) # ca4 <printf>

  printf("bigfile: testing random access optimization using mmap...\n");
 162:	00001517          	auipc	a0,0x1
 166:	df650513          	addi	a0,a0,-522 # f58 <malloc+0x1fc>
 16a:	00001097          	auipc	ra,0x1
 16e:	b3a080e7          	jalr	-1222(ra) # ca4 <printf>
  fd = open(fname, O_RDONLY);
 172:	4581                	li	a1,0
 174:	00001517          	auipc	a0,0x1
 178:	cd450513          	addi	a0,a0,-812 # e48 <malloc+0xec>
 17c:	00000097          	auipc	ra,0x0
 180:	5e8080e7          	jalr	1512(ra) # 764 <open>
 184:	872a                	mv	a4,a0
  if(fd < 0){
 186:	20054863          	bltz	a0,396 <main+0x396>
      printf("bigfile: cannot open for mmap\n");
      exit(0);
  }

  void *map_addr = mmap(0, TARGET_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
 18a:	4781                	li	a5,0
 18c:	4689                	li	a3,2
 18e:	4605                	li	a2,1
 190:	00a005b7          	lui	a1,0xa00
 194:	4501                	li	a0,0
 196:	00000097          	auipc	ra,0x0
 19a:	6ce080e7          	jalr	1742(ra) # 864 <mmap>
 19e:	84aa                	mv	s1,a0
  if(map_addr == MAP_FAILED) {
 1a0:	57fd                	li	a5,-1
 1a2:	20f50763          	beq	a0,a5,3b0 <main+0x3b0>
      printf("bigfile: mmap failed\n");
      exit(0);
  }
  printf("bigfile: mmap success at %p\n", map_addr);
 1a6:	85aa                	mv	a1,a0
 1a8:	00001517          	auipc	a0,0x1
 1ac:	e2850513          	addi	a0,a0,-472 # fd0 <malloc+0x274>
 1b0:	00001097          	auipc	ra,0x1
 1b4:	af4080e7          	jalr	-1292(ra) # ca4 <printf>
  char *data = (char*)map_addr;
  volatile char c; 
  
  // 1. Read near end (Forward Seek) - Should be fast with or without index if sequential, 
  // but here we jump 0 -> 9MB. Without index: O(N). With index: O(1).
  printf("bigfile: reading near end (9MB)...\n");
 1b8:	00001517          	auipc	a0,0x1
 1bc:	e3850513          	addi	a0,a0,-456 # ff0 <malloc+0x294>
 1c0:	00001097          	auipc	ra,0x1
 1c4:	ae4080e7          	jalr	-1308(ra) # ca4 <printf>
  int t1 = uptime();
 1c8:	00000097          	auipc	ra,0x0
 1cc:	5dc080e7          	jalr	1500(ra) # 7a4 <uptime>
 1d0:	89aa                	mv	s3,a0
  c = data[9 * 1024 * 1024]; 
 1d2:	009007b7          	lui	a5,0x900
 1d6:	97a6                	add	a5,a5,s1
 1d8:	0007c783          	lbu	a5,0(a5) # 900000 <__global_pointer$+0x8fe52f>
 1dc:	d8f40fa3          	sb	a5,-609(s0)
  int t2 = uptime();
 1e0:	00000097          	auipc	ra,0x0
 1e4:	5c4080e7          	jalr	1476(ra) # 7a4 <uptime>
  printf("bigfile: read 9MB took %d ticks\n", t2 - t1);
 1e8:	413505bb          	subw	a1,a0,s3
 1ec:	00001517          	auipc	a0,0x1
 1f0:	e2c50513          	addi	a0,a0,-468 # 1018 <malloc+0x2bc>
 1f4:	00001097          	auipc	ra,0x1
 1f8:	ab0080e7          	jalr	-1360(ra) # ca4 <printf>
  
  // 2. Read near start (Backward Seek) - Without index: Rewind + O(N). With index: Jump back O(1).
  printf("bigfile: reading near start (1MB)...\n");
 1fc:	00001517          	auipc	a0,0x1
 200:	e4450513          	addi	a0,a0,-444 # 1040 <malloc+0x2e4>
 204:	00001097          	auipc	ra,0x1
 208:	aa0080e7          	jalr	-1376(ra) # ca4 <printf>
  t1 = uptime();
 20c:	00000097          	auipc	ra,0x0
 210:	598080e7          	jalr	1432(ra) # 7a4 <uptime>
 214:	89aa                	mv	s3,a0
  c = data[1 * 1024 * 1024];
 216:	001007b7          	lui	a5,0x100
 21a:	97a6                	add	a5,a5,s1
 21c:	0007c783          	lbu	a5,0(a5) # 100000 <__global_pointer$+0xfe52f>
 220:	d8f40fa3          	sb	a5,-609(s0)
  t2 = uptime();
 224:	00000097          	auipc	ra,0x0
 228:	580080e7          	jalr	1408(ra) # 7a4 <uptime>
  printf("bigfile: read 1MB took %d ticks\n", t2 - t1);
 22c:	413505bb          	subw	a1,a0,s3
 230:	00001517          	auipc	a0,0x1
 234:	e3850513          	addi	a0,a0,-456 # 1068 <malloc+0x30c>
 238:	00001097          	auipc	ra,0x1
 23c:	a6c080e7          	jalr	-1428(ra) # ca4 <printf>
  
  // Verify data
  if (c != (char)((1024*1024)%256)) {
 240:	d9f44783          	lbu	a5,-609(s0)
 244:	18079363          	bnez	a5,3ca <main+0x3ca>
      printf("bigfile: Data mismatch at 1MB! %d vs %d\n", c, (1024*1024)%256);
  }

  // 3. Read middle (Random)
  printf("bigfile: reading middle (5MB)...\n");
 248:	00001517          	auipc	a0,0x1
 24c:	e7850513          	addi	a0,a0,-392 # 10c0 <malloc+0x364>
 250:	00001097          	auipc	ra,0x1
 254:	a54080e7          	jalr	-1452(ra) # ca4 <printf>
  t1 = uptime();
 258:	00000097          	auipc	ra,0x0
 25c:	54c080e7          	jalr	1356(ra) # 7a4 <uptime>
 260:	89aa                	mv	s3,a0
  c = data[5 * 1024 * 1024];
 262:	005007b7          	lui	a5,0x500
 266:	97a6                	add	a5,a5,s1
 268:	0007c783          	lbu	a5,0(a5) # 500000 <__global_pointer$+0x4fe52f>
 26c:	d8f40fa3          	sb	a5,-609(s0)
  t2 = uptime();
 270:	00000097          	auipc	ra,0x0
 274:	534080e7          	jalr	1332(ra) # 7a4 <uptime>
  printf("bigfile: read 5MB took %d ticks\n", t2 - t1);
 278:	413505bb          	subw	a1,a0,s3
 27c:	00001517          	auipc	a0,0x1
 280:	e6c50513          	addi	a0,a0,-404 # 10e8 <malloc+0x38c>
 284:	00001097          	auipc	ra,0x1
 288:	a20080e7          	jalr	-1504(ra) # ca4 <printf>

  munmap(map_addr, TARGET_SIZE);
 28c:	00a005b7          	lui	a1,0xa00
 290:	8526                	mv	a0,s1
 292:	00000097          	auipc	ra,0x0
 296:	5dc080e7          	jalr	1500(ra) # 86e <munmap>
  // close(fd) is called below
  printf("bigfile: time taken (ticks): %d\n", end_time - start_time);
 29a:	85e2                	mv	a1,s8
 29c:	00001517          	auipc	a0,0x1
 2a0:	c9450513          	addi	a0,a0,-876 # f30 <malloc+0x1d4>
 2a4:	00001097          	auipc	ra,0x1
 2a8:	a00080e7          	jalr	-1536(ra) # ca4 <printf>


  printf("bigfile: verifying data...\n");
 2ac:	00001517          	auipc	a0,0x1
 2b0:	e6450513          	addi	a0,a0,-412 # 1110 <malloc+0x3b4>
 2b4:	00001097          	auipc	ra,0x1
 2b8:	9f0080e7          	jalr	-1552(ra) # ca4 <printf>
  fd = open(fname, O_RDONLY);
 2bc:	4581                	li	a1,0
 2be:	00001517          	auipc	a0,0x1
 2c2:	b8a50513          	addi	a0,a0,-1142 # e48 <malloc+0xec>
 2c6:	00000097          	auipc	ra,0x0
 2ca:	49e080e7          	jalr	1182(ra) # 764 <open>
 2ce:	8a2a                	mv	s4,a0
  if(fd < 0){
 2d0:	10054963          	bltz	a0,3e2 <main+0x3e2>
      printf("bigfile: cannot re-open %s for verification\n", fname);
      exit(0);
  }

  int total_read = 0;
 2d4:	4b81                	li	s7,0
  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
 2d6:	4a81                	li	s5,0
      if((n = read(fd, buf, BSIZE)) != BSIZE){
 2d8:	da040913          	addi	s2,s0,-608
 2dc:	20000493          	li	s1,512
      // Simple check of first byte of the block to ensure we are reading valid-ish data
      // Check full buffer to be sure? 
      // For speed, let's just check the first byte of each block for now, or check a few spots.
      // But full check is safer.
      for(int k=0; k<BSIZE; k++){
        if(buf[k] != (char)(k % 256)){
 2e0:	10000993          	li	s3,256
        }
      }
      total_read += n;
      if((total_read % (100 * 1024)) == 0){
          // limit output to avoid spamming console too much during verification
          if (total_read % (1024*1024) == 0) // log every 1MB read
 2e4:	00100b37          	lui	s6,0x100
 2e8:	1b7d                	addi	s6,s6,-1 # fffff <__global_pointer$+0xfe52e>
      if((total_read % (100 * 1024)) == 0){
 2ea:	6ce5                	lui	s9,0x19
              printf("bigfile: verified %d MB\n", total_read / (1024*1024));
 2ec:	00100c37          	lui	s8,0x100
      if((n = read(fd, buf, BSIZE)) != BSIZE){
 2f0:	8626                	mv	a2,s1
 2f2:	85ca                	mv	a1,s2
 2f4:	8552                	mv	a0,s4
 2f6:	00000097          	auipc	ra,0x0
 2fa:	446080e7          	jalr	1094(ra) # 73c <read>
 2fe:	862a                	mv	a2,a0
 300:	10951263          	bne	a0,s1,404 <main+0x404>
 304:	4781                	li	a5,0
 306:	0007861b          	sext.w	a2,a5
        if(buf[k] != (char)(k % 256)){
 30a:	00f90733          	add	a4,s2,a5
 30e:	00074703          	lbu	a4,0(a4)
 312:	0337e6bb          	remw	a3,a5,s3
 316:	0ff6f593          	zext.b	a1,a3
 31a:	10b71363          	bne	a4,a1,420 <main+0x420>
      for(int k=0; k<BSIZE; k++){
 31e:	0785                	addi	a5,a5,1
 320:	fe9793e3          	bne	a5,s1,306 <main+0x306>
      total_read += n;
 324:	200b859b          	addiw	a1,s7,512
 328:	00058b9b          	sext.w	s7,a1
          if (total_read % (1024*1024) == 0) // log every 1MB read
 32c:	00bb77b3          	and	a5,s6,a1
      if((total_read % (100 * 1024)) == 0){
 330:	0395e73b          	remw	a4,a1,s9
          if (total_read % (1024*1024) == 0) // log every 1MB read
 334:	8fd9                	or	a5,a5,a4
 336:	2781                	sext.w	a5,a5
 338:	10078263          	beqz	a5,43c <main+0x43c>
  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
 33c:	2a85                	addiw	s5,s5,1 # 5001 <__global_pointer$+0x3530>
 33e:	00a007b7          	lui	a5,0xa00
 342:	fafb97e3          	bne	s7,a5,2f0 <main+0x2f0>
      }
  }
  
  printf("bigfile: verification successful!\n");
 346:	00001517          	auipc	a0,0x1
 34a:	eba50513          	addi	a0,a0,-326 # 1200 <malloc+0x4a4>
 34e:	00001097          	auipc	ra,0x1
 352:	956080e7          	jalr	-1706(ra) # ca4 <printf>
  close(fd);
 356:	8552                	mv	a0,s4
 358:	00000097          	auipc	ra,0x0
 35c:	3f4080e7          	jalr	1012(ra) # 74c <close>

  // Clean up
  if(remove(fname) < 0){
 360:	00001517          	auipc	a0,0x1
 364:	ae850513          	addi	a0,a0,-1304 # e48 <malloc+0xec>
 368:	00000097          	auipc	ra,0x0
 36c:	464080e7          	jalr	1124(ra) # 7cc <remove>
 370:	0e054163          	bltz	a0,452 <main+0x452>
      printf("bigfile: failed to delete %s\n", fname);
  } else {
      printf("bigfile: deleted %s\n", fname);
 374:	00001597          	auipc	a1,0x1
 378:	ad458593          	addi	a1,a1,-1324 # e48 <malloc+0xec>
 37c:	00001517          	auipc	a0,0x1
 380:	ecc50513          	addi	a0,a0,-308 # 1248 <malloc+0x4ec>
 384:	00001097          	auipc	ra,0x1
 388:	920080e7          	jalr	-1760(ra) # ca4 <printf>
  }

  exit(0);
 38c:	4501                	li	a0,0
 38e:	00000097          	auipc	ra,0x0
 392:	396080e7          	jalr	918(ra) # 724 <exit>
      printf("bigfile: cannot open for mmap\n");
 396:	00001517          	auipc	a0,0x1
 39a:	c0250513          	addi	a0,a0,-1022 # f98 <malloc+0x23c>
 39e:	00001097          	auipc	ra,0x1
 3a2:	906080e7          	jalr	-1786(ra) # ca4 <printf>
      exit(0);
 3a6:	4501                	li	a0,0
 3a8:	00000097          	auipc	ra,0x0
 3ac:	37c080e7          	jalr	892(ra) # 724 <exit>
      printf("bigfile: mmap failed\n");
 3b0:	00001517          	auipc	a0,0x1
 3b4:	c0850513          	addi	a0,a0,-1016 # fb8 <malloc+0x25c>
 3b8:	00001097          	auipc	ra,0x1
 3bc:	8ec080e7          	jalr	-1812(ra) # ca4 <printf>
      exit(0);
 3c0:	4501                	li	a0,0
 3c2:	00000097          	auipc	ra,0x0
 3c6:	362080e7          	jalr	866(ra) # 724 <exit>
      printf("bigfile: Data mismatch at 1MB! %d vs %d\n", c, (1024*1024)%256);
 3ca:	d9f44583          	lbu	a1,-609(s0)
 3ce:	4601                	li	a2,0
 3d0:	00001517          	auipc	a0,0x1
 3d4:	cc050513          	addi	a0,a0,-832 # 1090 <malloc+0x334>
 3d8:	00001097          	auipc	ra,0x1
 3dc:	8cc080e7          	jalr	-1844(ra) # ca4 <printf>
 3e0:	b5a5                	j	248 <main+0x248>
      printf("bigfile: cannot re-open %s for verification\n", fname);
 3e2:	00001597          	auipc	a1,0x1
 3e6:	a6658593          	addi	a1,a1,-1434 # e48 <malloc+0xec>
 3ea:	00001517          	auipc	a0,0x1
 3ee:	d4650513          	addi	a0,a0,-698 # 1130 <malloc+0x3d4>
 3f2:	00001097          	auipc	ra,0x1
 3f6:	8b2080e7          	jalr	-1870(ra) # ca4 <printf>
      exit(0);
 3fa:	4501                	li	a0,0
 3fc:	00000097          	auipc	ra,0x0
 400:	328080e7          	jalr	808(ra) # 724 <exit>
          printf("bigfile: read error at block %d, ready %d bytes\n", i, n);
 404:	85d6                	mv	a1,s5
 406:	00001517          	auipc	a0,0x1
 40a:	d5a50513          	addi	a0,a0,-678 # 1160 <malloc+0x404>
 40e:	00001097          	auipc	ra,0x1
 412:	896080e7          	jalr	-1898(ra) # ca4 <printf>
          exit(0);
 416:	4501                	li	a0,0
 418:	00000097          	auipc	ra,0x0
 41c:	30c080e7          	jalr	780(ra) # 724 <exit>
            printf("bigfile: data mismatch at block %d offset %d. Expected %d got %d\n", i, k, (k%256), buf[k]);
 420:	85d6                	mv	a1,s5
 422:	00001517          	auipc	a0,0x1
 426:	d7650513          	addi	a0,a0,-650 # 1198 <malloc+0x43c>
 42a:	00001097          	auipc	ra,0x1
 42e:	87a080e7          	jalr	-1926(ra) # ca4 <printf>
            exit(0);
 432:	4501                	li	a0,0
 434:	00000097          	auipc	ra,0x0
 438:	2f0080e7          	jalr	752(ra) # 724 <exit>
              printf("bigfile: verified %d MB\n", total_read / (1024*1024));
 43c:	0385c5bb          	divw	a1,a1,s8
 440:	00001517          	auipc	a0,0x1
 444:	da050513          	addi	a0,a0,-608 # 11e0 <malloc+0x484>
 448:	00001097          	auipc	ra,0x1
 44c:	85c080e7          	jalr	-1956(ra) # ca4 <printf>
 450:	b5f5                	j	33c <main+0x33c>
      printf("bigfile: failed to delete %s\n", fname);
 452:	00001597          	auipc	a1,0x1
 456:	9f658593          	addi	a1,a1,-1546 # e48 <malloc+0xec>
 45a:	00001517          	auipc	a0,0x1
 45e:	dce50513          	addi	a0,a0,-562 # 1228 <malloc+0x4cc>
 462:	00001097          	auipc	ra,0x1
 466:	842080e7          	jalr	-1982(ra) # ca4 <printf>
 46a:	b70d                	j	38c <main+0x38c>

000000000000046c <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 472:	87aa                	mv	a5,a0
 474:	0585                	addi	a1,a1,1
 476:	0785                	addi	a5,a5,1 # a00001 <__global_pointer$+0x9fe530>
 478:	fff5c703          	lbu	a4,-1(a1)
 47c:	fee78fa3          	sb	a4,-1(a5)
 480:	fb75                	bnez	a4,474 <strcpy+0x8>
    ;
  return os;
}
 482:	6422                	ld	s0,8(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret

0000000000000488 <strcat>:

char*
strcat(char *s, const char *t)
{
 488:	1141                	addi	sp,sp,-16
 48a:	e422                	sd	s0,8(sp)
 48c:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 48e:	00054783          	lbu	a5,0(a0)
 492:	c385                	beqz	a5,4b2 <strcat+0x2a>
 494:	87aa                	mv	a5,a0
    s++;
 496:	0785                	addi	a5,a5,1
  while(*s)
 498:	0007c703          	lbu	a4,0(a5)
 49c:	ff6d                	bnez	a4,496 <strcat+0xe>
  while((*s++ = *t++))
 49e:	0585                	addi	a1,a1,1
 4a0:	0785                	addi	a5,a5,1
 4a2:	fff5c703          	lbu	a4,-1(a1)
 4a6:	fee78fa3          	sb	a4,-1(a5)
 4aa:	fb75                	bnez	a4,49e <strcat+0x16>
    ;
  return os;
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	addi	sp,sp,16
 4b0:	8082                	ret
  while(*s)
 4b2:	87aa                	mv	a5,a0
 4b4:	b7ed                	j	49e <strcat+0x16>

00000000000004b6 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 4b6:	1141                	addi	sp,sp,-16
 4b8:	e422                	sd	s0,8(sp)
 4ba:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 4bc:	00054783          	lbu	a5,0(a0)
 4c0:	cb91                	beqz	a5,4d4 <strcmp+0x1e>
 4c2:	0005c703          	lbu	a4,0(a1)
 4c6:	00f71763          	bne	a4,a5,4d4 <strcmp+0x1e>
    p++, q++;
 4ca:	0505                	addi	a0,a0,1
 4cc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4ce:	00054783          	lbu	a5,0(a0)
 4d2:	fbe5                	bnez	a5,4c2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 4d4:	0005c503          	lbu	a0,0(a1)
}
 4d8:	40a7853b          	subw	a0,a5,a0
 4dc:	6422                	ld	s0,8(sp)
 4de:	0141                	addi	sp,sp,16
 4e0:	8082                	ret

00000000000004e2 <strlen>:

uint
strlen(const char *s)
{
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e422                	sd	s0,8(sp)
 4e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4e8:	00054783          	lbu	a5,0(a0)
 4ec:	cf91                	beqz	a5,508 <strlen+0x26>
 4ee:	0505                	addi	a0,a0,1
 4f0:	87aa                	mv	a5,a0
 4f2:	4685                	li	a3,1
 4f4:	9e89                	subw	a3,a3,a0
 4f6:	00f6853b          	addw	a0,a3,a5
 4fa:	0785                	addi	a5,a5,1
 4fc:	fff7c703          	lbu	a4,-1(a5)
 500:	fb7d                	bnez	a4,4f6 <strlen+0x14>
    ;
  return n;
}
 502:	6422                	ld	s0,8(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret
  for(n = 0; s[n]; n++)
 508:	4501                	li	a0,0
 50a:	bfe5                	j	502 <strlen+0x20>

000000000000050c <memset>:

void*
memset(void *dst, int c, uint n)
{
 50c:	1141                	addi	sp,sp,-16
 50e:	e422                	sd	s0,8(sp)
 510:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 512:	ca19                	beqz	a2,528 <memset+0x1c>
 514:	87aa                	mv	a5,a0
 516:	1602                	slli	a2,a2,0x20
 518:	9201                	srli	a2,a2,0x20
 51a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 51e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 522:	0785                	addi	a5,a5,1
 524:	fee79de3          	bne	a5,a4,51e <memset+0x12>
  }
  return dst;
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret

000000000000052e <strchr>:

char*
strchr(const char *s, char c)
{
 52e:	1141                	addi	sp,sp,-16
 530:	e422                	sd	s0,8(sp)
 532:	0800                	addi	s0,sp,16
  for(; *s; s++)
 534:	00054783          	lbu	a5,0(a0)
 538:	cb99                	beqz	a5,54e <strchr+0x20>
    if(*s == c)
 53a:	00f58763          	beq	a1,a5,548 <strchr+0x1a>
  for(; *s; s++)
 53e:	0505                	addi	a0,a0,1
 540:	00054783          	lbu	a5,0(a0)
 544:	fbfd                	bnez	a5,53a <strchr+0xc>
      return (char*)s;
  return 0;
 546:	4501                	li	a0,0
}
 548:	6422                	ld	s0,8(sp)
 54a:	0141                	addi	sp,sp,16
 54c:	8082                	ret
  return 0;
 54e:	4501                	li	a0,0
 550:	bfe5                	j	548 <strchr+0x1a>

0000000000000552 <gets>:

char*
gets(char *buf, int max)
{
 552:	711d                	addi	sp,sp,-96
 554:	ec86                	sd	ra,88(sp)
 556:	e8a2                	sd	s0,80(sp)
 558:	e4a6                	sd	s1,72(sp)
 55a:	e0ca                	sd	s2,64(sp)
 55c:	fc4e                	sd	s3,56(sp)
 55e:	f852                	sd	s4,48(sp)
 560:	f456                	sd	s5,40(sp)
 562:	f05a                	sd	s6,32(sp)
 564:	ec5e                	sd	s7,24(sp)
 566:	e862                	sd	s8,16(sp)
 568:	1080                	addi	s0,sp,96
 56a:	8baa                	mv	s7,a0
 56c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 56e:	892a                	mv	s2,a0
 570:	4481                	li	s1,0
    cc = read(0, &c, 1);
 572:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 576:	4b29                	li	s6,10
 578:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 57a:	89a6                	mv	s3,s1
 57c:	2485                	addiw	s1,s1,1
 57e:	0344d763          	bge	s1,s4,5ac <gets+0x5a>
    cc = read(0, &c, 1);
 582:	4605                	li	a2,1
 584:	85d6                	mv	a1,s5
 586:	4501                	li	a0,0
 588:	00000097          	auipc	ra,0x0
 58c:	1b4080e7          	jalr	436(ra) # 73c <read>
    if(cc < 1)
 590:	00a05e63          	blez	a0,5ac <gets+0x5a>
    buf[i++] = c;
 594:	faf44783          	lbu	a5,-81(s0)
 598:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 59c:	01678763          	beq	a5,s6,5aa <gets+0x58>
 5a0:	0905                	addi	s2,s2,1
 5a2:	fd879ce3          	bne	a5,s8,57a <gets+0x28>
  for(i=0; i+1 < max; ){
 5a6:	89a6                	mv	s3,s1
 5a8:	a011                	j	5ac <gets+0x5a>
 5aa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 5ac:	99de                	add	s3,s3,s7
 5ae:	00098023          	sb	zero,0(s3)
  return buf;
}
 5b2:	855e                	mv	a0,s7
 5b4:	60e6                	ld	ra,88(sp)
 5b6:	6446                	ld	s0,80(sp)
 5b8:	64a6                	ld	s1,72(sp)
 5ba:	6906                	ld	s2,64(sp)
 5bc:	79e2                	ld	s3,56(sp)
 5be:	7a42                	ld	s4,48(sp)
 5c0:	7aa2                	ld	s5,40(sp)
 5c2:	7b02                	ld	s6,32(sp)
 5c4:	6be2                	ld	s7,24(sp)
 5c6:	6c42                	ld	s8,16(sp)
 5c8:	6125                	addi	sp,sp,96
 5ca:	8082                	ret

00000000000005cc <stat>:

int
stat(const char *n, struct stat *st)
{
 5cc:	1101                	addi	sp,sp,-32
 5ce:	ec06                	sd	ra,24(sp)
 5d0:	e822                	sd	s0,16(sp)
 5d2:	e426                	sd	s1,8(sp)
 5d4:	e04a                	sd	s2,0(sp)
 5d6:	1000                	addi	s0,sp,32
 5d8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5da:	4581                	li	a1,0
 5dc:	00000097          	auipc	ra,0x0
 5e0:	188080e7          	jalr	392(ra) # 764 <open>
  if(fd < 0)
 5e4:	02054563          	bltz	a0,60e <stat+0x42>
 5e8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5ea:	85ca                	mv	a1,s2
 5ec:	00000097          	auipc	ra,0x0
 5f0:	180080e7          	jalr	384(ra) # 76c <fstat>
 5f4:	892a                	mv	s2,a0
  close(fd);
 5f6:	8526                	mv	a0,s1
 5f8:	00000097          	auipc	ra,0x0
 5fc:	154080e7          	jalr	340(ra) # 74c <close>
  return r;
}
 600:	854a                	mv	a0,s2
 602:	60e2                	ld	ra,24(sp)
 604:	6442                	ld	s0,16(sp)
 606:	64a2                	ld	s1,8(sp)
 608:	6902                	ld	s2,0(sp)
 60a:	6105                	addi	sp,sp,32
 60c:	8082                	ret
    return -1;
 60e:	597d                	li	s2,-1
 610:	bfc5                	j	600 <stat+0x34>

0000000000000612 <atoi>:

int
atoi(const char *s)
{
 612:	1141                	addi	sp,sp,-16
 614:	e422                	sd	s0,8(sp)
 616:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 618:	00054703          	lbu	a4,0(a0)
 61c:	02d00793          	li	a5,45
  int neg = 1;
 620:	4585                	li	a1,1
  if (*s == '-') {
 622:	04f70363          	beq	a4,a5,668 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 626:	00054703          	lbu	a4,0(a0)
 62a:	fd07079b          	addiw	a5,a4,-48
 62e:	0ff7f793          	zext.b	a5,a5
 632:	46a5                	li	a3,9
 634:	02f6ed63          	bltu	a3,a5,66e <atoi+0x5c>
  n = 0;
 638:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
 63a:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
 63c:	0505                	addi	a0,a0,1
 63e:	0026979b          	slliw	a5,a3,0x2
 642:	9fb5                	addw	a5,a5,a3
 644:	0017979b          	slliw	a5,a5,0x1
 648:	9fb9                	addw	a5,a5,a4
 64a:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
 64e:	00054703          	lbu	a4,0(a0)
 652:	fd07079b          	addiw	a5,a4,-48
 656:	0ff7f793          	zext.b	a5,a5
 65a:	fef671e3          	bgeu	a2,a5,63c <atoi+0x2a>
  return n * neg;
}
 65e:	02d5853b          	mulw	a0,a1,a3
 662:	6422                	ld	s0,8(sp)
 664:	0141                	addi	sp,sp,16
 666:	8082                	ret
    s++;
 668:	0505                	addi	a0,a0,1
    neg = -1;
 66a:	55fd                	li	a1,-1
 66c:	bf6d                	j	626 <atoi+0x14>
  n = 0;
 66e:	4681                	li	a3,0
 670:	b7fd                	j	65e <atoi+0x4c>

0000000000000672 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 672:	1141                	addi	sp,sp,-16
 674:	e422                	sd	s0,8(sp)
 676:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 678:	02b57463          	bgeu	a0,a1,6a0 <memmove+0x2e>
    while(n-- > 0)
 67c:	00c05f63          	blez	a2,69a <memmove+0x28>
 680:	1602                	slli	a2,a2,0x20
 682:	9201                	srli	a2,a2,0x20
 684:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 688:	872a                	mv	a4,a0
      *dst++ = *src++;
 68a:	0585                	addi	a1,a1,1
 68c:	0705                	addi	a4,a4,1
 68e:	fff5c683          	lbu	a3,-1(a1)
 692:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 696:	fee79ae3          	bne	a5,a4,68a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 69a:	6422                	ld	s0,8(sp)
 69c:	0141                	addi	sp,sp,16
 69e:	8082                	ret
    dst += n;
 6a0:	00c50733          	add	a4,a0,a2
    src += n;
 6a4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6a6:	fec05ae3          	blez	a2,69a <memmove+0x28>
 6aa:	fff6079b          	addiw	a5,a2,-1 # 9fffff <__global_pointer$+0x9fe52e>
 6ae:	1782                	slli	a5,a5,0x20
 6b0:	9381                	srli	a5,a5,0x20
 6b2:	fff7c793          	not	a5,a5
 6b6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 6b8:	15fd                	addi	a1,a1,-1
 6ba:	177d                	addi	a4,a4,-1
 6bc:	0005c683          	lbu	a3,0(a1)
 6c0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 6c4:	fee79ae3          	bne	a5,a4,6b8 <memmove+0x46>
 6c8:	bfc9                	j	69a <memmove+0x28>

00000000000006ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 6ca:	1141                	addi	sp,sp,-16
 6cc:	e422                	sd	s0,8(sp)
 6ce:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 6d0:	ca05                	beqz	a2,700 <memcmp+0x36>
 6d2:	fff6069b          	addiw	a3,a2,-1
 6d6:	1682                	slli	a3,a3,0x20
 6d8:	9281                	srli	a3,a3,0x20
 6da:	0685                	addi	a3,a3,1
 6dc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 6de:	00054783          	lbu	a5,0(a0)
 6e2:	0005c703          	lbu	a4,0(a1)
 6e6:	00e79863          	bne	a5,a4,6f6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 6ea:	0505                	addi	a0,a0,1
    p2++;
 6ec:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 6ee:	fed518e3          	bne	a0,a3,6de <memcmp+0x14>
  }
  return 0;
 6f2:	4501                	li	a0,0
 6f4:	a019                	j	6fa <memcmp+0x30>
      return *p1 - *p2;
 6f6:	40e7853b          	subw	a0,a5,a4
}
 6fa:	6422                	ld	s0,8(sp)
 6fc:	0141                	addi	sp,sp,16
 6fe:	8082                	ret
  return 0;
 700:	4501                	li	a0,0
 702:	bfe5                	j	6fa <memcmp+0x30>

0000000000000704 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 704:	1141                	addi	sp,sp,-16
 706:	e406                	sd	ra,8(sp)
 708:	e022                	sd	s0,0(sp)
 70a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 70c:	00000097          	auipc	ra,0x0
 710:	f66080e7          	jalr	-154(ra) # 672 <memmove>
}
 714:	60a2                	ld	ra,8(sp)
 716:	6402                	ld	s0,0(sp)
 718:	0141                	addi	sp,sp,16
 71a:	8082                	ret

000000000000071c <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 71c:	4885                	li	a7,1
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <exit>:
.global exit
exit:
 li a7, SYS_exit
 724:	4889                	li	a7,2
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <wait>:
.global wait
wait:
 li a7, SYS_wait
 72c:	488d                	li	a7,3
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 734:	4891                	li	a7,4
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <read>:
.global read
read:
 li a7, SYS_read
 73c:	4895                	li	a7,5
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <write>:
.global write
write:
 li a7, SYS_write
 744:	48c1                	li	a7,16
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <close>:
.global close
close:
 li a7, SYS_close
 74c:	48d5                	li	a7,21
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <kill>:
.global kill
kill:
 li a7, SYS_kill
 754:	4899                	li	a7,6
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <exec>:
.global exec
exec:
 li a7, SYS_exec
 75c:	489d                	li	a7,7
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <open>:
.global open
open:
 li a7, SYS_open
 764:	48bd                	li	a7,15
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 76c:	48a1                	li	a7,8
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 774:	48d1                	li	a7,20
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 77c:	48a5                	li	a7,9
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <dup>:
.global dup
dup:
 li a7, SYS_dup
 784:	48a9                	li	a7,10
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 78c:	48ad                	li	a7,11
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 794:	48b1                	li	a7,12
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 79c:	48b5                	li	a7,13
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7a4:	48b9                	li	a7,14
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 7ac:	48d9                	li	a7,22
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <dev>:
.global dev
dev:
 li a7, SYS_dev
 7b4:	48dd                	li	a7,23
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 7bc:	48e1                	li	a7,24
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 7c4:	48e5                	li	a7,25
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <remove>:
.global remove
remove:
 li a7, SYS_remove
 7cc:	48c5                	li	a7,17
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 7d4:	48c9                	li	a7,18
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 7dc:	48cd                	li	a7,19
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <rename>:
.global rename
rename:
 li a7, SYS_rename
 7e4:	48e9                	li	a7,26
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 7ec:	48ed                	li	a7,27
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
 7f4:	48f1                	li	a7,28
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
 7fc:	48f5                	li	a7,29
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 804:	48f9                	li	a7,30
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
 80c:	48fd                	li	a7,31
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
 814:	02000893          	li	a7,32
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
 81e:	02100893          	li	a7,33
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
 828:	02200893          	li	a7,34
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
 832:	02300893          	li	a7,35
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
 83c:	02400893          	li	a7,36
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 846:	02500893          	li	a7,37
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 850:	02600893          	li	a7,38
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
 85a:	02700893          	li	a7,39
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
 864:	02800893          	li	a7,40
 ecall
 868:	00000073          	ecall
 ret
 86c:	8082                	ret

000000000000086e <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
 86e:	02900893          	li	a7,41
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
 878:	02a00893          	li	a7,42
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
 882:	02b00893          	li	a7,43
 ecall
 886:	00000073          	ecall
 ret
 88a:	8082                	ret

000000000000088c <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
 88c:	02c00893          	li	a7,44
 ecall
 890:	00000073          	ecall
 ret
 894:	8082                	ret

0000000000000896 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
 896:	02d00893          	li	a7,45
 ecall
 89a:	00000073          	ecall
 ret
 89e:	8082                	ret

00000000000008a0 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
 8a0:	02e00893          	li	a7,46
 ecall
 8a4:	00000073          	ecall
 ret
 8a8:	8082                	ret

00000000000008aa <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 8aa:	02f00893          	li	a7,47
 ecall
 8ae:	00000073          	ecall
 ret
 8b2:	8082                	ret

00000000000008b4 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
 8b4:	03000893          	li	a7,48
 ecall
 8b8:	00000073          	ecall
 ret
 8bc:	8082                	ret

00000000000008be <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
 8be:	03100893          	li	a7,49
 ecall
 8c2:	00000073          	ecall
 ret
 8c6:	8082                	ret

00000000000008c8 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
 8c8:	03200893          	li	a7,50
 ecall
 8cc:	00000073          	ecall
 ret
 8d0:	8082                	ret

00000000000008d2 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
 8d2:	03300893          	li	a7,51
 ecall
 8d6:	00000073          	ecall
 ret
 8da:	8082                	ret

00000000000008dc <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
 8dc:	03400893          	li	a7,52
 ecall
 8e0:	00000073          	ecall
 ret
 8e4:	8082                	ret

00000000000008e6 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
 8e6:	03500893          	li	a7,53
 ecall
 8ea:	00000073          	ecall
 ret
 8ee:	8082                	ret

00000000000008f0 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
 8f0:	03600893          	li	a7,54
 ecall
 8f4:	00000073          	ecall
 ret
 8f8:	8082                	ret

00000000000008fa <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
 8fa:	03700893          	li	a7,55
 ecall
 8fe:	00000073          	ecall
 ret
 902:	8082                	ret

0000000000000904 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
 904:	03800893          	li	a7,56
 ecall
 908:	00000073          	ecall
 ret
 90c:	8082                	ret

000000000000090e <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
 90e:	03900893          	li	a7,57
 ecall
 912:	00000073          	ecall
 ret
 916:	8082                	ret

0000000000000918 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
 918:	03a00893          	li	a7,58
 ecall
 91c:	00000073          	ecall
 ret
 920:	8082                	ret

0000000000000922 <poll>:
.global poll
poll:
 li a7, SYS_poll
 922:	03b00893          	li	a7,59
 ecall
 926:	00000073          	ecall
 ret
 92a:	8082                	ret

000000000000092c <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
 92c:	03c00893          	li	a7,60
 ecall
 930:	00000073          	ecall
 ret
 934:	8082                	ret

0000000000000936 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
 936:	03d00893          	li	a7,61
 ecall
 93a:	00000073          	ecall
 ret
 93e:	8082                	ret

0000000000000940 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
 940:	03e00893          	li	a7,62
 ecall
 944:	00000073          	ecall
 ret
 948:	8082                	ret

000000000000094a <clone>:
.global clone
clone:
 li a7, SYS_clone
 94a:	03f00893          	li	a7,63
 ecall
 94e:	00000073          	ecall
 ret
 952:	8082                	ret

0000000000000954 <futex>:
.global futex
futex:
 li a7, SYS_futex
 954:	04000893          	li	a7,64
 ecall
 958:	00000073          	ecall
 ret
 95c:	8082                	ret

000000000000095e <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
 95e:	04100893          	li	a7,65
 ecall
 962:	00000073          	ecall
 ret
 966:	8082                	ret

0000000000000968 <halt>:
.global halt
halt:
 li a7, SYS_halt
 968:	04200893          	li	a7,66
 ecall
 96c:	00000073          	ecall
 ret
 970:	8082                	ret

0000000000000972 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
 972:	04300893          	li	a7,67
 ecall
 976:	00000073          	ecall
 ret
 97a:	8082                	ret

000000000000097c <socket>:
.global socket
socket:
 li a7, SYS_socket
 97c:	04400893          	li	a7,68
 ecall
 980:	00000073          	ecall
 ret
 984:	8082                	ret

0000000000000986 <bind>:
.global bind
bind:
 li a7, SYS_bind
 986:	04500893          	li	a7,69
 ecall
 98a:	00000073          	ecall
 ret
 98e:	8082                	ret

0000000000000990 <listen>:
.global listen
listen:
 li a7, SYS_listen
 990:	04600893          	li	a7,70
 ecall
 994:	00000073          	ecall
 ret
 998:	8082                	ret

000000000000099a <accept>:
.global accept
accept:
 li a7, SYS_accept
 99a:	04700893          	li	a7,71
 ecall
 99e:	00000073          	ecall
 ret
 9a2:	8082                	ret

00000000000009a4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 9a4:	04800893          	li	a7,72
 ecall
 9a8:	00000073          	ecall
 ret
 9ac:	8082                	ret

00000000000009ae <send>:
.global send
send:
 li a7, SYS_send
 9ae:	04900893          	li	a7,73
 ecall
 9b2:	00000073          	ecall
 ret
 9b6:	8082                	ret

00000000000009b8 <recv>:
.global recv
recv:
 li a7, SYS_recv
 9b8:	04a00893          	li	a7,74
 ecall
 9bc:	00000073          	ecall
 ret
 9c0:	8082                	ret

00000000000009c2 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
 9c2:	04b00893          	li	a7,75
 ecall
 9c6:	00000073          	ecall
 ret
 9ca:	8082                	ret

00000000000009cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 9cc:	1101                	addi	sp,sp,-32
 9ce:	ec06                	sd	ra,24(sp)
 9d0:	e822                	sd	s0,16(sp)
 9d2:	1000                	addi	s0,sp,32
 9d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 9d8:	4605                	li	a2,1
 9da:	fef40593          	addi	a1,s0,-17
 9de:	00000097          	auipc	ra,0x0
 9e2:	d66080e7          	jalr	-666(ra) # 744 <write>
}
 9e6:	60e2                	ld	ra,24(sp)
 9e8:	6442                	ld	s0,16(sp)
 9ea:	6105                	addi	sp,sp,32
 9ec:	8082                	ret

00000000000009ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 9ee:	7139                	addi	sp,sp,-64
 9f0:	fc06                	sd	ra,56(sp)
 9f2:	f822                	sd	s0,48(sp)
 9f4:	f426                	sd	s1,40(sp)
 9f6:	f04a                	sd	s2,32(sp)
 9f8:	ec4e                	sd	s3,24(sp)
 9fa:	0080                	addi	s0,sp,64
 9fc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 9fe:	c299                	beqz	a3,a04 <printint+0x16>
 a00:	0805c863          	bltz	a1,a90 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a04:	2581                	sext.w	a1,a1
  neg = 0;
 a06:	4881                	li	a7,0
  }

  i = 0;
 a08:	fc040993          	addi	s3,s0,-64
  neg = 0;
 a0c:	86ce                	mv	a3,s3
  i = 0;
 a0e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a10:	2601                	sext.w	a2,a2
 a12:	00001517          	auipc	a0,0x1
 a16:	8ae50513          	addi	a0,a0,-1874 # 12c0 <digits>
 a1a:	883a                	mv	a6,a4
 a1c:	2705                	addiw	a4,a4,1
 a1e:	02c5f7bb          	remuw	a5,a1,a2
 a22:	1782                	slli	a5,a5,0x20
 a24:	9381                	srli	a5,a5,0x20
 a26:	97aa                	add	a5,a5,a0
 a28:	0007c783          	lbu	a5,0(a5)
 a2c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a30:	0005879b          	sext.w	a5,a1
 a34:	02c5d5bb          	divuw	a1,a1,a2
 a38:	0685                	addi	a3,a3,1
 a3a:	fec7f0e3          	bgeu	a5,a2,a1a <printint+0x2c>
  if(neg)
 a3e:	00088c63          	beqz	a7,a56 <printint+0x68>
    buf[i++] = '-';
 a42:	fd070793          	addi	a5,a4,-48
 a46:	00878733          	add	a4,a5,s0
 a4a:	02d00793          	li	a5,45
 a4e:	fef70823          	sb	a5,-16(a4)
 a52:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a56:	02e05663          	blez	a4,a82 <printint+0x94>
 a5a:	fc040913          	addi	s2,s0,-64
 a5e:	993a                	add	s2,s2,a4
 a60:	19fd                	addi	s3,s3,-1
 a62:	99ba                	add	s3,s3,a4
 a64:	377d                	addiw	a4,a4,-1
 a66:	1702                	slli	a4,a4,0x20
 a68:	9301                	srli	a4,a4,0x20
 a6a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a6e:	fff94583          	lbu	a1,-1(s2)
 a72:	8526                	mv	a0,s1
 a74:	00000097          	auipc	ra,0x0
 a78:	f58080e7          	jalr	-168(ra) # 9cc <putc>
  while(--i >= 0)
 a7c:	197d                	addi	s2,s2,-1
 a7e:	ff3918e3          	bne	s2,s3,a6e <printint+0x80>
}
 a82:	70e2                	ld	ra,56(sp)
 a84:	7442                	ld	s0,48(sp)
 a86:	74a2                	ld	s1,40(sp)
 a88:	7902                	ld	s2,32(sp)
 a8a:	69e2                	ld	s3,24(sp)
 a8c:	6121                	addi	sp,sp,64
 a8e:	8082                	ret
    x = -xx;
 a90:	40b005bb          	negw	a1,a1
    neg = 1;
 a94:	4885                	li	a7,1
    x = -xx;
 a96:	bf8d                	j	a08 <printint+0x1a>

0000000000000a98 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 a98:	7119                	addi	sp,sp,-128
 a9a:	fc86                	sd	ra,120(sp)
 a9c:	f8a2                	sd	s0,112(sp)
 a9e:	f4a6                	sd	s1,104(sp)
 aa0:	f0ca                	sd	s2,96(sp)
 aa2:	ecce                	sd	s3,88(sp)
 aa4:	e8d2                	sd	s4,80(sp)
 aa6:	e4d6                	sd	s5,72(sp)
 aa8:	e0da                	sd	s6,64(sp)
 aaa:	fc5e                	sd	s7,56(sp)
 aac:	f862                	sd	s8,48(sp)
 aae:	f466                	sd	s9,40(sp)
 ab0:	f06a                	sd	s10,32(sp)
 ab2:	ec6e                	sd	s11,24(sp)
 ab4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 ab6:	0005c903          	lbu	s2,0(a1)
 aba:	18090f63          	beqz	s2,c58 <vprintf+0x1c0>
 abe:	8aaa                	mv	s5,a0
 ac0:	8b32                	mv	s6,a2
 ac2:	00158493          	addi	s1,a1,1
  state = 0;
 ac6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 ac8:	02500a13          	li	s4,37
 acc:	4c55                	li	s8,21
 ace:	00000c97          	auipc	s9,0x0
 ad2:	79ac8c93          	addi	s9,s9,1946 # 1268 <malloc+0x50c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 ad6:	02800d93          	li	s11,40
  putc(fd, 'x');
 ada:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 adc:	00000b97          	auipc	s7,0x0
 ae0:	7e4b8b93          	addi	s7,s7,2020 # 12c0 <digits>
 ae4:	a839                	j	b02 <vprintf+0x6a>
        putc(fd, c);
 ae6:	85ca                	mv	a1,s2
 ae8:	8556                	mv	a0,s5
 aea:	00000097          	auipc	ra,0x0
 aee:	ee2080e7          	jalr	-286(ra) # 9cc <putc>
 af2:	a019                	j	af8 <vprintf+0x60>
    } else if(state == '%'){
 af4:	01498d63          	beq	s3,s4,b0e <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 af8:	0485                	addi	s1,s1,1
 afa:	fff4c903          	lbu	s2,-1(s1)
 afe:	14090d63          	beqz	s2,c58 <vprintf+0x1c0>
    if(state == 0){
 b02:	fe0999e3          	bnez	s3,af4 <vprintf+0x5c>
      if(c == '%'){
 b06:	ff4910e3          	bne	s2,s4,ae6 <vprintf+0x4e>
        state = '%';
 b0a:	89d2                	mv	s3,s4
 b0c:	b7f5                	j	af8 <vprintf+0x60>
      if(c == 'd'){
 b0e:	11490c63          	beq	s2,s4,c26 <vprintf+0x18e>
 b12:	f9d9079b          	addiw	a5,s2,-99
 b16:	0ff7f793          	zext.b	a5,a5
 b1a:	10fc6e63          	bltu	s8,a5,c36 <vprintf+0x19e>
 b1e:	f9d9079b          	addiw	a5,s2,-99
 b22:	0ff7f713          	zext.b	a4,a5
 b26:	10ec6863          	bltu	s8,a4,c36 <vprintf+0x19e>
 b2a:	00271793          	slli	a5,a4,0x2
 b2e:	97e6                	add	a5,a5,s9
 b30:	439c                	lw	a5,0(a5)
 b32:	97e6                	add	a5,a5,s9
 b34:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b36:	008b0913          	addi	s2,s6,8
 b3a:	4685                	li	a3,1
 b3c:	4629                	li	a2,10
 b3e:	000b2583          	lw	a1,0(s6)
 b42:	8556                	mv	a0,s5
 b44:	00000097          	auipc	ra,0x0
 b48:	eaa080e7          	jalr	-342(ra) # 9ee <printint>
 b4c:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b4e:	4981                	li	s3,0
 b50:	b765                	j	af8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b52:	008b0913          	addi	s2,s6,8
 b56:	4681                	li	a3,0
 b58:	4629                	li	a2,10
 b5a:	000b2583          	lw	a1,0(s6)
 b5e:	8556                	mv	a0,s5
 b60:	00000097          	auipc	ra,0x0
 b64:	e8e080e7          	jalr	-370(ra) # 9ee <printint>
 b68:	8b4a                	mv	s6,s2
      state = 0;
 b6a:	4981                	li	s3,0
 b6c:	b771                	j	af8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 b6e:	008b0913          	addi	s2,s6,8
 b72:	4681                	li	a3,0
 b74:	866a                	mv	a2,s10
 b76:	000b2583          	lw	a1,0(s6)
 b7a:	8556                	mv	a0,s5
 b7c:	00000097          	auipc	ra,0x0
 b80:	e72080e7          	jalr	-398(ra) # 9ee <printint>
 b84:	8b4a                	mv	s6,s2
      state = 0;
 b86:	4981                	li	s3,0
 b88:	bf85                	j	af8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 b8a:	008b0793          	addi	a5,s6,8
 b8e:	f8f43423          	sd	a5,-120(s0)
 b92:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 b96:	03000593          	li	a1,48
 b9a:	8556                	mv	a0,s5
 b9c:	00000097          	auipc	ra,0x0
 ba0:	e30080e7          	jalr	-464(ra) # 9cc <putc>
  putc(fd, 'x');
 ba4:	07800593          	li	a1,120
 ba8:	8556                	mv	a0,s5
 baa:	00000097          	auipc	ra,0x0
 bae:	e22080e7          	jalr	-478(ra) # 9cc <putc>
 bb2:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 bb4:	03c9d793          	srli	a5,s3,0x3c
 bb8:	97de                	add	a5,a5,s7
 bba:	0007c583          	lbu	a1,0(a5)
 bbe:	8556                	mv	a0,s5
 bc0:	00000097          	auipc	ra,0x0
 bc4:	e0c080e7          	jalr	-500(ra) # 9cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 bc8:	0992                	slli	s3,s3,0x4
 bca:	397d                	addiw	s2,s2,-1
 bcc:	fe0914e3          	bnez	s2,bb4 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 bd0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 bd4:	4981                	li	s3,0
 bd6:	b70d                	j	af8 <vprintf+0x60>
        s = va_arg(ap, char*);
 bd8:	008b0913          	addi	s2,s6,8
 bdc:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 be0:	02098163          	beqz	s3,c02 <vprintf+0x16a>
        while(*s != 0){
 be4:	0009c583          	lbu	a1,0(s3)
 be8:	c5ad                	beqz	a1,c52 <vprintf+0x1ba>
          putc(fd, *s);
 bea:	8556                	mv	a0,s5
 bec:	00000097          	auipc	ra,0x0
 bf0:	de0080e7          	jalr	-544(ra) # 9cc <putc>
          s++;
 bf4:	0985                	addi	s3,s3,1
        while(*s != 0){
 bf6:	0009c583          	lbu	a1,0(s3)
 bfa:	f9e5                	bnez	a1,bea <vprintf+0x152>
        s = va_arg(ap, char*);
 bfc:	8b4a                	mv	s6,s2
      state = 0;
 bfe:	4981                	li	s3,0
 c00:	bde5                	j	af8 <vprintf+0x60>
          s = "(null)";
 c02:	00000997          	auipc	s3,0x0
 c06:	65e98993          	addi	s3,s3,1630 # 1260 <malloc+0x504>
        while(*s != 0){
 c0a:	85ee                	mv	a1,s11
 c0c:	bff9                	j	bea <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 c0e:	008b0913          	addi	s2,s6,8
 c12:	000b4583          	lbu	a1,0(s6)
 c16:	8556                	mv	a0,s5
 c18:	00000097          	auipc	ra,0x0
 c1c:	db4080e7          	jalr	-588(ra) # 9cc <putc>
 c20:	8b4a                	mv	s6,s2
      state = 0;
 c22:	4981                	li	s3,0
 c24:	bdd1                	j	af8 <vprintf+0x60>
        putc(fd, c);
 c26:	85d2                	mv	a1,s4
 c28:	8556                	mv	a0,s5
 c2a:	00000097          	auipc	ra,0x0
 c2e:	da2080e7          	jalr	-606(ra) # 9cc <putc>
      state = 0;
 c32:	4981                	li	s3,0
 c34:	b5d1                	j	af8 <vprintf+0x60>
        putc(fd, '%');
 c36:	85d2                	mv	a1,s4
 c38:	8556                	mv	a0,s5
 c3a:	00000097          	auipc	ra,0x0
 c3e:	d92080e7          	jalr	-622(ra) # 9cc <putc>
        putc(fd, c);
 c42:	85ca                	mv	a1,s2
 c44:	8556                	mv	a0,s5
 c46:	00000097          	auipc	ra,0x0
 c4a:	d86080e7          	jalr	-634(ra) # 9cc <putc>
      state = 0;
 c4e:	4981                	li	s3,0
 c50:	b565                	j	af8 <vprintf+0x60>
        s = va_arg(ap, char*);
 c52:	8b4a                	mv	s6,s2
      state = 0;
 c54:	4981                	li	s3,0
 c56:	b54d                	j	af8 <vprintf+0x60>
    }
  }
}
 c58:	70e6                	ld	ra,120(sp)
 c5a:	7446                	ld	s0,112(sp)
 c5c:	74a6                	ld	s1,104(sp)
 c5e:	7906                	ld	s2,96(sp)
 c60:	69e6                	ld	s3,88(sp)
 c62:	6a46                	ld	s4,80(sp)
 c64:	6aa6                	ld	s5,72(sp)
 c66:	6b06                	ld	s6,64(sp)
 c68:	7be2                	ld	s7,56(sp)
 c6a:	7c42                	ld	s8,48(sp)
 c6c:	7ca2                	ld	s9,40(sp)
 c6e:	7d02                	ld	s10,32(sp)
 c70:	6de2                	ld	s11,24(sp)
 c72:	6109                	addi	sp,sp,128
 c74:	8082                	ret

0000000000000c76 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c76:	715d                	addi	sp,sp,-80
 c78:	ec06                	sd	ra,24(sp)
 c7a:	e822                	sd	s0,16(sp)
 c7c:	1000                	addi	s0,sp,32
 c7e:	e010                	sd	a2,0(s0)
 c80:	e414                	sd	a3,8(s0)
 c82:	e818                	sd	a4,16(s0)
 c84:	ec1c                	sd	a5,24(s0)
 c86:	03043023          	sd	a6,32(s0)
 c8a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c8e:	8622                	mv	a2,s0
 c90:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c94:	00000097          	auipc	ra,0x0
 c98:	e04080e7          	jalr	-508(ra) # a98 <vprintf>
}
 c9c:	60e2                	ld	ra,24(sp)
 c9e:	6442                	ld	s0,16(sp)
 ca0:	6161                	addi	sp,sp,80
 ca2:	8082                	ret

0000000000000ca4 <printf>:

void
printf(const char *fmt, ...)
{
 ca4:	711d                	addi	sp,sp,-96
 ca6:	ec06                	sd	ra,24(sp)
 ca8:	e822                	sd	s0,16(sp)
 caa:	1000                	addi	s0,sp,32
 cac:	e40c                	sd	a1,8(s0)
 cae:	e810                	sd	a2,16(s0)
 cb0:	ec14                	sd	a3,24(s0)
 cb2:	f018                	sd	a4,32(s0)
 cb4:	f41c                	sd	a5,40(s0)
 cb6:	03043823          	sd	a6,48(s0)
 cba:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cbe:	00840613          	addi	a2,s0,8
 cc2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 cc6:	85aa                	mv	a1,a0
 cc8:	4505                	li	a0,1
 cca:	00000097          	auipc	ra,0x0
 cce:	dce080e7          	jalr	-562(ra) # a98 <vprintf>
}
 cd2:	60e2                	ld	ra,24(sp)
 cd4:	6442                	ld	s0,16(sp)
 cd6:	6125                	addi	sp,sp,96
 cd8:	8082                	ret

0000000000000cda <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cda:	1141                	addi	sp,sp,-16
 cdc:	e422                	sd	s0,8(sp)
 cde:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ce0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ce4:	00000797          	auipc	a5,0x0
 ce8:	5f47b783          	ld	a5,1524(a5) # 12d8 <freep>
 cec:	a02d                	j	d16 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 cee:	4618                	lw	a4,8(a2)
 cf0:	9f2d                	addw	a4,a4,a1
 cf2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 cf6:	6398                	ld	a4,0(a5)
 cf8:	6310                	ld	a2,0(a4)
 cfa:	a83d                	j	d38 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 cfc:	ff852703          	lw	a4,-8(a0)
 d00:	9f31                	addw	a4,a4,a2
 d02:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d04:	ff053683          	ld	a3,-16(a0)
 d08:	a091                	j	d4c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d0a:	6398                	ld	a4,0(a5)
 d0c:	00e7e463          	bltu	a5,a4,d14 <free+0x3a>
 d10:	00e6ea63          	bltu	a3,a4,d24 <free+0x4a>
{
 d14:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d16:	fed7fae3          	bgeu	a5,a3,d0a <free+0x30>
 d1a:	6398                	ld	a4,0(a5)
 d1c:	00e6e463          	bltu	a3,a4,d24 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d20:	fee7eae3          	bltu	a5,a4,d14 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 d24:	ff852583          	lw	a1,-8(a0)
 d28:	6390                	ld	a2,0(a5)
 d2a:	02059813          	slli	a6,a1,0x20
 d2e:	01c85713          	srli	a4,a6,0x1c
 d32:	9736                	add	a4,a4,a3
 d34:	fae60de3          	beq	a2,a4,cee <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 d38:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 d3c:	4790                	lw	a2,8(a5)
 d3e:	02061593          	slli	a1,a2,0x20
 d42:	01c5d713          	srli	a4,a1,0x1c
 d46:	973e                	add	a4,a4,a5
 d48:	fae68ae3          	beq	a3,a4,cfc <free+0x22>
    p->s.ptr = bp->s.ptr;
 d4c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 d4e:	00000717          	auipc	a4,0x0
 d52:	58f73523          	sd	a5,1418(a4) # 12d8 <freep>
}
 d56:	6422                	ld	s0,8(sp)
 d58:	0141                	addi	sp,sp,16
 d5a:	8082                	ret

0000000000000d5c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d5c:	7139                	addi	sp,sp,-64
 d5e:	fc06                	sd	ra,56(sp)
 d60:	f822                	sd	s0,48(sp)
 d62:	f426                	sd	s1,40(sp)
 d64:	f04a                	sd	s2,32(sp)
 d66:	ec4e                	sd	s3,24(sp)
 d68:	e852                	sd	s4,16(sp)
 d6a:	e456                	sd	s5,8(sp)
 d6c:	e05a                	sd	s6,0(sp)
 d6e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d70:	02051493          	slli	s1,a0,0x20
 d74:	9081                	srli	s1,s1,0x20
 d76:	04bd                	addi	s1,s1,15
 d78:	8091                	srli	s1,s1,0x4
 d7a:	00148a1b          	addiw	s4,s1,1
 d7e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 d80:	00000517          	auipc	a0,0x0
 d84:	55853503          	ld	a0,1368(a0) # 12d8 <freep>
 d88:	c515                	beqz	a0,db4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d8a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d8c:	4798                	lw	a4,8(a5)
 d8e:	04977163          	bgeu	a4,s1,dd0 <malloc+0x74>
 d92:	89d2                	mv	s3,s4
 d94:	000a071b          	sext.w	a4,s4
 d98:	6685                	lui	a3,0x1
 d9a:	00d77363          	bgeu	a4,a3,da0 <malloc+0x44>
 d9e:	6985                	lui	s3,0x1
 da0:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
 da4:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 da8:	00000917          	auipc	s2,0x0
 dac:	53090913          	addi	s2,s2,1328 # 12d8 <freep>
  if(p == (char*)-1)
 db0:	5afd                	li	s5,-1
 db2:	a8a5                	j	e2a <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
 db4:	00000797          	auipc	a5,0x0
 db8:	52478793          	addi	a5,a5,1316 # 12d8 <freep>
 dbc:	00000717          	auipc	a4,0x0
 dc0:	52470713          	addi	a4,a4,1316 # 12e0 <base>
 dc4:	e398                	sd	a4,0(a5)
 dc6:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 dc8:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dcc:	87ba                	mv	a5,a4
 dce:	b7d1                	j	d92 <malloc+0x36>
      if(p->s.size == nunits)
 dd0:	02e48c63          	beq	s1,a4,e08 <malloc+0xac>
        p->s.size -= nunits;
 dd4:	4147073b          	subw	a4,a4,s4
 dd8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 dda:	02071693          	slli	a3,a4,0x20
 dde:	01c6d713          	srli	a4,a3,0x1c
 de2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 de4:	0147a423          	sw	s4,8(a5)
      freep = prevp;
 de8:	00000717          	auipc	a4,0x0
 dec:	4ea73823          	sd	a0,1264(a4) # 12d8 <freep>
      return (void*)(p + 1);
 df0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 df4:	70e2                	ld	ra,56(sp)
 df6:	7442                	ld	s0,48(sp)
 df8:	74a2                	ld	s1,40(sp)
 dfa:	7902                	ld	s2,32(sp)
 dfc:	69e2                	ld	s3,24(sp)
 dfe:	6a42                	ld	s4,16(sp)
 e00:	6aa2                	ld	s5,8(sp)
 e02:	6b02                	ld	s6,0(sp)
 e04:	6121                	addi	sp,sp,64
 e06:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 e08:	6398                	ld	a4,0(a5)
 e0a:	e118                	sd	a4,0(a0)
 e0c:	bff1                	j	de8 <malloc+0x8c>
  hp->s.size = nu;
 e0e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 e12:	0541                	addi	a0,a0,16
 e14:	00000097          	auipc	ra,0x0
 e18:	ec6080e7          	jalr	-314(ra) # cda <free>
  return freep;
 e1c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 e20:	d971                	beqz	a0,df4 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e22:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 e24:	4798                	lw	a4,8(a5)
 e26:	fa9775e3          	bgeu	a4,s1,dd0 <malloc+0x74>
    if(p == freep)
 e2a:	00093703          	ld	a4,0(s2)
 e2e:	853e                	mv	a0,a5
 e30:	fef719e3          	bne	a4,a5,e22 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
 e34:	854e                	mv	a0,s3
 e36:	00000097          	auipc	ra,0x0
 e3a:	95e080e7          	jalr	-1698(ra) # 794 <sbrk>
  if(p == (char*)-1)
 e3e:	fd5518e3          	bne	a0,s5,e0e <malloc+0xb2>
        return 0;
 e42:	4501                	li	a0,0
 e44:	bf45                	j	df4 <malloc+0x98>
