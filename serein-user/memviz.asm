
serein-user/_memviz：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <color_yellow>:
static void color_green(void) {
  char seq[] = {0x1b, '[', '3', '2', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_yellow(void) {
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '3', 'm'};
       8:	333367b7          	lui	a5,0x33336
       c:	b1b78793          	addi	a5,a5,-1253 # 33335b1b <__global_pointer$+0x333336aa>
      10:	fef42423          	sw	a5,-24(s0)
      14:	06d00793          	li	a5,109
      18:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      1c:	4615                	li	a2,5
      1e:	fe840593          	addi	a1,s0,-24
      22:	4509                	li	a0,2
      24:	00001097          	auipc	ra,0x1
      28:	d1a080e7          	jalr	-742(ra) # d3e <write>
}
      2c:	60e2                	ld	ra,24(sp)
      2e:	6442                	ld	s0,16(sp)
      30:	6105                	addi	sp,sp,32
      32:	8082                	ret

0000000000000034 <color_magenta>:
static void color_cyan(void) {
  char seq[] = {0x1b, '[', '3', '6', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_magenta(void) {
      34:	1101                	addi	sp,sp,-32
      36:	ec06                	sd	ra,24(sp)
      38:	e822                	sd	s0,16(sp)
      3a:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '5', 'm'};
      3c:	353367b7          	lui	a5,0x35336
      40:	b1b78793          	addi	a5,a5,-1253 # 35335b1b <__global_pointer$+0x353336aa>
      44:	fef42423          	sw	a5,-24(s0)
      48:	06d00793          	li	a5,109
      4c:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      50:	4615                	li	a2,5
      52:	fe840593          	addi	a1,s0,-24
      56:	4509                	li	a0,2
      58:	00001097          	auipc	ra,0x1
      5c:	ce6080e7          	jalr	-794(ra) # d3e <write>
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
      74:	b1b78793          	addi	a5,a5,-1253 # 32335b1b <__global_pointer$+0x323336aa>
      78:	fef42423          	sw	a5,-24(s0)
      7c:	06d00793          	li	a5,109
      80:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      84:	4615                	li	a2,5
      86:	fe840593          	addi	a1,s0,-24
      8a:	4509                	li	a0,2
      8c:	00001097          	auipc	ra,0x1
      90:	cb2080e7          	jalr	-846(ra) # d3e <write>
}
      94:	60e2                	ld	ra,24(sp)
      96:	6442                	ld	s0,16(sp)
      98:	6105                	addi	sp,sp,32
      9a:	8082                	ret

000000000000009c <color_cyan>:
static void color_cyan(void) {
      9c:	1101                	addi	sp,sp,-32
      9e:	ec06                	sd	ra,24(sp)
      a0:	e822                	sd	s0,16(sp)
      a2:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '3', '6', 'm'};
      a4:	363367b7          	lui	a5,0x36336
      a8:	b1b78793          	addi	a5,a5,-1253 # 36335b1b <__global_pointer$+0x363336aa>
      ac:	fef42423          	sw	a5,-24(s0)
      b0:	06d00793          	li	a5,109
      b4:	fef40623          	sb	a5,-20(s0)
  write(2, seq, sizeof(seq));
      b8:	4615                	li	a2,5
      ba:	fe840593          	addi	a1,s0,-24
      be:	4509                	li	a0,2
      c0:	00001097          	auipc	ra,0x1
      c4:	c7e080e7          	jalr	-898(ra) # d3e <write>
}
      c8:	60e2                	ld	ra,24(sp)
      ca:	6442                	ld	s0,16(sp)
      cc:	6105                	addi	sp,sp,32
      ce:	8082                	ret

00000000000000d0 <color_reset>:

static void color_reset(void) {
      d0:	1101                	addi	sp,sp,-32
      d2:	ec06                	sd	ra,24(sp)
      d4:	e822                	sd	s0,16(sp)
      d6:	1000                	addi	s0,sp,32
  char seq[] = {0x1b, '[', '0', 'm'};
      d8:	6d3067b7          	lui	a5,0x6d306
      dc:	b1b78793          	addi	a5,a5,-1253 # 6d305b1b <__global_pointer$+0x6d3036aa>
      e0:	fef42423          	sw	a5,-24(s0)
  write(2, seq, sizeof(seq));
      e4:	4611                	li	a2,4
      e6:	fe840593          	addi	a1,s0,-24
      ea:	4509                	li	a0,2
      ec:	00001097          	auipc	ra,0x1
      f0:	c52080e7          	jalr	-942(ra) # d3e <write>
}
      f4:	60e2                	ld	ra,24(sp)
      f6:	6442                	ld	s0,16(sp)
      f8:	6105                	addi	sp,sp,32
      fa:	8082                	ret

00000000000000fc <get_mem_stats>:

// 获取内存统计
static void get_mem_stats(uint *free_kb, uint *cow_faults) {
      fc:	7175                	addi	sp,sp,-144
      fe:	e506                	sd	ra,136(sp)
     100:	e122                	sd	s0,128(sp)
     102:	fca6                	sd	s1,120(sp)
     104:	f8ca                	sd	s2,112(sp)
     106:	0900                	addi	s0,sp,144
     108:	892a                	mv	s2,a0
     10a:	84ae                	mv	s1,a1
  struct sysinfo info;
  if(sysinfo(&info) < 0) {
     10c:	f7840513          	addi	a0,s0,-136
     110:	00001097          	auipc	ra,0x1
     114:	cc6080e7          	jalr	-826(ra) # dd6 <sysinfo>
     118:	02054063          	bltz	a0,138 <get_mem_stats+0x3c>
    *free_kb = 0;
    *cow_faults = 0;
    return;
  }
  *free_kb = (uint)(info.freemem / 1024);
     11c:	f7843783          	ld	a5,-136(s0)
     120:	83a9                	srli	a5,a5,0xa
     122:	00f92023          	sw	a5,0(s2)
  *cow_faults = (uint)info.cow_pages;
     126:	f9042783          	lw	a5,-112(s0)
     12a:	c09c                	sw	a5,0(s1)
}
     12c:	60aa                	ld	ra,136(sp)
     12e:	640a                	ld	s0,128(sp)
     130:	74e6                	ld	s1,120(sp)
     132:	7946                	ld	s2,112(sp)
     134:	6149                	addi	sp,sp,144
     136:	8082                	ret
    *free_kb = 0;
     138:	00092023          	sw	zero,0(s2)
     13c:	4781                	li	a5,0
     13e:	b7f5                	j	12a <get_mem_stats+0x2e>

0000000000000140 <main>:
    // 清理
    sbrk(-alloc_size);
  }
}

int main(int argc, char *argv[]) {
     140:	7135                	addi	sp,sp,-160
     142:	ed06                	sd	ra,152(sp)
     144:	e922                	sd	s0,144(sp)
     146:	e526                	sd	s1,136(sp)
     148:	e14a                	sd	s2,128(sp)
     14a:	fcce                	sd	s3,120(sp)
     14c:	f8d2                	sd	s4,112(sp)
     14e:	f4d6                	sd	s5,104(sp)
     150:	f0da                	sd	s6,96(sp)
     152:	ecde                	sd	s7,88(sp)
     154:	e8e2                	sd	s8,80(sp)
     156:	e4e6                	sd	s9,72(sp)
     158:	e0ea                	sd	s10,64(sp)
     15a:	fc6e                	sd	s11,56(sp)
     15c:	1100                	addi	s0,sp,160
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
     15e:	4a3267b7          	lui	a5,0x4a326
     162:	b1b78793          	addi	a5,a5,-1253 # 4a325b1b <__global_pointer$+0x4a3236aa>
     166:	f8f42423          	sw	a5,-120(s0)
     16a:	6799                	lui	a5,0x6
     16c:	b1b78793          	addi	a5,a5,-1253 # 5b1b <__global_pointer$+0x36aa>
     170:	f8f41623          	sh	a5,-116(s0)
     174:	04800793          	li	a5,72
     178:	f8f40723          	sb	a5,-114(s0)
  write(2, seq, sizeof(seq));
     17c:	461d                	li	a2,7
     17e:	f8840593          	addi	a1,s0,-120
     182:	4509                	li	a0,2
     184:	00001097          	auipc	ra,0x1
     188:	bba080e7          	jalr	-1094(ra) # d3e <write>
  // 注意：Ctrl+C 使用默认 SIGINT 行为，直接终止进程
  
  cls();
  
  color_cyan();
     18c:	00000097          	auipc	ra,0x0
     190:	f10080e7          	jalr	-240(ra) # 9c <color_cyan>
  fprintf(2, "+================================================================+\n");
     194:	00001597          	auipc	a1,0x1
     198:	2ac58593          	addi	a1,a1,684 # 1440 <malloc+0xea>
     19c:	4509                	li	a0,2
     19e:	00001097          	auipc	ra,0x1
     1a2:	0d2080e7          	jalr	210(ra) # 1270 <fprintf>
  fprintf(2, "|         Memory Management Visualization - Serein OS            |\n");
     1a6:	00001597          	auipc	a1,0x1
     1aa:	2e258593          	addi	a1,a1,738 # 1488 <malloc+0x132>
     1ae:	4509                	li	a0,2
     1b0:	00001097          	auipc	ra,0x1
     1b4:	0c0080e7          	jalr	192(ra) # 1270 <fprintf>
  fprintf(2, "|              Lazy Allocation & Copy-on-Write                  |\n");
     1b8:	00001597          	auipc	a1,0x1
     1bc:	31858593          	addi	a1,a1,792 # 14d0 <malloc+0x17a>
     1c0:	4509                	li	a0,2
     1c2:	00001097          	auipc	ra,0x1
     1c6:	0ae080e7          	jalr	174(ra) # 1270 <fprintf>
  fprintf(2, "+================================================================+\n");
     1ca:	00001597          	auipc	a1,0x1
     1ce:	27658593          	addi	a1,a1,630 # 1440 <malloc+0xea>
     1d2:	4509                	li	a0,2
     1d4:	00001097          	auipc	ra,0x1
     1d8:	09c080e7          	jalr	156(ra) # 1270 <fprintf>
  color_reset();
     1dc:	00000097          	auipc	ra,0x0
     1e0:	ef4080e7          	jalr	-268(ra) # d0 <color_reset>
  
  fprintf(2, "\n");
     1e4:	00001597          	auipc	a1,0x1
     1e8:	7dc58593          	addi	a1,a1,2012 # 19c0 <malloc+0x66a>
     1ec:	4509                	li	a0,2
     1ee:	00001097          	auipc	ra,0x1
     1f2:	082080e7          	jalr	130(ra) # 1270 <fprintf>
  fprintf(2, "  This demo shows two key memory optimization techniques:\n");
     1f6:	00001597          	auipc	a1,0x1
     1fa:	32258593          	addi	a1,a1,802 # 1518 <malloc+0x1c2>
     1fe:	4509                	li	a0,2
     200:	00001097          	auipc	ra,0x1
     204:	070080e7          	jalr	112(ra) # 1270 <fprintf>
  fprintf(2, "\n");
     208:	00001597          	auipc	a1,0x1
     20c:	7b858593          	addi	a1,a1,1976 # 19c0 <malloc+0x66a>
     210:	4509                	li	a0,2
     212:	00001097          	auipc	ra,0x1
     216:	05e080e7          	jalr	94(ra) # 1270 <fprintf>
  color_yellow();
     21a:	00000097          	auipc	ra,0x0
     21e:	de6080e7          	jalr	-538(ra) # 0 <color_yellow>
  fprintf(2, "  1. Lazy Allocation: sbrk() doesn't allocate physical pages\n");
     222:	00001597          	auipc	a1,0x1
     226:	33658593          	addi	a1,a1,822 # 1558 <malloc+0x202>
     22a:	4509                	li	a0,2
     22c:	00001097          	auipc	ra,0x1
     230:	044080e7          	jalr	68(ra) # 1270 <fprintf>
  fprintf(2, "     until they are actually accessed (page fault)\n");
     234:	00001597          	auipc	a1,0x1
     238:	36458593          	addi	a1,a1,868 # 1598 <malloc+0x242>
     23c:	4509                	li	a0,2
     23e:	00001097          	auipc	ra,0x1
     242:	032080e7          	jalr	50(ra) # 1270 <fprintf>
  color_reset();
     246:	00000097          	auipc	ra,0x0
     24a:	e8a080e7          	jalr	-374(ra) # d0 <color_reset>
  fprintf(2, "\n");
     24e:	00001597          	auipc	a1,0x1
     252:	77258593          	addi	a1,a1,1906 # 19c0 <malloc+0x66a>
     256:	4509                	li	a0,2
     258:	00001097          	auipc	ra,0x1
     25c:	018080e7          	jalr	24(ra) # 1270 <fprintf>
  color_magenta();
     260:	00000097          	auipc	ra,0x0
     264:	dd4080e7          	jalr	-556(ra) # 34 <color_magenta>
  fprintf(2, "  2. Copy-on-Write: fork() shares parent's pages with child,\n");
     268:	00001597          	auipc	a1,0x1
     26c:	36858593          	addi	a1,a1,872 # 15d0 <malloc+0x27a>
     270:	4509                	li	a0,2
     272:	00001097          	auipc	ra,0x1
     276:	ffe080e7          	jalr	-2(ra) # 1270 <fprintf>
  fprintf(2, "     copies only when written (COW fault)\n");
     27a:	00001597          	auipc	a1,0x1
     27e:	39658593          	addi	a1,a1,918 # 1610 <malloc+0x2ba>
     282:	4509                	li	a0,2
     284:	00001097          	auipc	ra,0x1
     288:	fec080e7          	jalr	-20(ra) # 1270 <fprintf>
  color_reset();
     28c:	00000097          	auipc	ra,0x0
     290:	e44080e7          	jalr	-444(ra) # d0 <color_reset>
  fprintf(2, "\n");
     294:	00001597          	auipc	a1,0x1
     298:	72c58593          	addi	a1,a1,1836 # 19c0 <malloc+0x66a>
     29c:	4509                	li	a0,2
     29e:	00001097          	auipc	ra,0x1
     2a2:	fd2080e7          	jalr	-46(ra) # 1270 <fprintf>
  fprintf(2, "  Starting demos in 2 seconds...\n");
     2a6:	00001597          	auipc	a1,0x1
     2aa:	39a58593          	addi	a1,a1,922 # 1640 <malloc+0x2ea>
     2ae:	4509                	li	a0,2
     2b0:	00001097          	auipc	ra,0x1
     2b4:	fc0080e7          	jalr	-64(ra) # 1270 <fprintf>
  
  sleep(200);
     2b8:	0c800513          	li	a0,200
     2bc:	00001097          	auipc	ra,0x1
     2c0:	ada080e7          	jalr	-1318(ra) # d96 <sleep>
  color_cyan();
     2c4:	00000097          	auipc	ra,0x0
     2c8:	dd8080e7          	jalr	-552(ra) # 9c <color_cyan>
  fprintf(2, "\n");
     2cc:	00001597          	auipc	a1,0x1
     2d0:	6f458593          	addi	a1,a1,1780 # 19c0 <malloc+0x66a>
     2d4:	4509                	li	a0,2
     2d6:	00001097          	auipc	ra,0x1
     2da:	f9a080e7          	jalr	-102(ra) # 1270 <fprintf>
  fprintf(2, "+================================================================+\n");
     2de:	00001597          	auipc	a1,0x1
     2e2:	16258593          	addi	a1,a1,354 # 1440 <malloc+0xea>
     2e6:	4509                	li	a0,2
     2e8:	00001097          	auipc	ra,0x1
     2ec:	f88080e7          	jalr	-120(ra) # 1270 <fprintf>
  fprintf(2, "|              DEMO 1: Lazy Allocation (懒加载)                 |\n");
     2f0:	00001597          	auipc	a1,0x1
     2f4:	37858593          	addi	a1,a1,888 # 1668 <malloc+0x312>
     2f8:	4509                	li	a0,2
     2fa:	00001097          	auipc	ra,0x1
     2fe:	f76080e7          	jalr	-138(ra) # 1270 <fprintf>
  fprintf(2, "+================================================================+\n");
     302:	00001597          	auipc	a1,0x1
     306:	13e58593          	addi	a1,a1,318 # 1440 <malloc+0xea>
     30a:	4509                	li	a0,2
     30c:	00001097          	auipc	ra,0x1
     310:	f64080e7          	jalr	-156(ra) # 1270 <fprintf>
  color_reset();
     314:	00000097          	auipc	ra,0x0
     318:	dbc080e7          	jalr	-580(ra) # d0 <color_reset>
  get_mem_stats(&free_before, &cow_before);
     31c:	f7840593          	addi	a1,s0,-136
     320:	f7440513          	addi	a0,s0,-140
     324:	00000097          	auipc	ra,0x0
     328:	dd8080e7          	jalr	-552(ra) # fc <get_mem_stats>
  fprintf(2, "\n");
     32c:	00001597          	auipc	a1,0x1
     330:	69458593          	addi	a1,a1,1684 # 19c0 <malloc+0x66a>
     334:	4509                	li	a0,2
     336:	00001097          	auipc	ra,0x1
     33a:	f3a080e7          	jalr	-198(ra) # 1270 <fprintf>
  fprintf(2, "  Initial free memory: %d KB\n", free_before);
     33e:	f7442783          	lw	a5,-140(s0)
     342:	f6f43423          	sd	a5,-152(s0)
     346:	863e                	mv	a2,a5
     348:	00001597          	auipc	a1,0x1
     34c:	36858593          	addi	a1,a1,872 # 16b0 <malloc+0x35a>
     350:	4509                	li	a0,2
     352:	00001097          	auipc	ra,0x1
     356:	f1e080e7          	jalr	-226(ra) # 1270 <fprintf>
  fprintf(2, "\n");
     35a:	00001597          	auipc	a1,0x1
     35e:	66658593          	addi	a1,a1,1638 # 19c0 <malloc+0x66a>
     362:	4509                	li	a0,2
     364:	00001097          	auipc	ra,0x1
     368:	f0c080e7          	jalr	-244(ra) # 1270 <fprintf>
  fprintf(2, "  Step 1: sbrk(%d KB) - Requesting virtual memory...\n", alloc_size / 1024);
     36c:	04000613          	li	a2,64
     370:	00001597          	auipc	a1,0x1
     374:	36058593          	addi	a1,a1,864 # 16d0 <malloc+0x37a>
     378:	4509                	li	a0,2
     37a:	00001097          	auipc	ra,0x1
     37e:	ef6080e7          	jalr	-266(ra) # 1270 <fprintf>
  sleep(100);
     382:	06400513          	li	a0,100
     386:	00001097          	auipc	ra,0x1
     38a:	a10080e7          	jalr	-1520(ra) # d96 <sleep>
  char *mem = sbrk(alloc_size);
     38e:	6541                	lui	a0,0x10
     390:	00001097          	auipc	ra,0x1
     394:	9fe080e7          	jalr	-1538(ra) # d8e <sbrk>
  if(mem == (char*)-1) {
     398:	57fd                	li	a5,-1
     39a:	0cf50563          	beq	a0,a5,464 <main+0x324>
     39e:	8c2a                	mv	s8,a0
  get_mem_stats(&free_after_sbrk, &cow_temp);
     3a0:	f8040593          	addi	a1,s0,-128
     3a4:	f7c40513          	addi	a0,s0,-132
     3a8:	00000097          	auipc	ra,0x0
     3ac:	d54080e7          	jalr	-684(ra) # fc <get_mem_stats>
  fprintf(2, "\n");
     3b0:	00001597          	auipc	a1,0x1
     3b4:	61058593          	addi	a1,a1,1552 # 19c0 <malloc+0x66a>
     3b8:	4509                	li	a0,2
     3ba:	00001097          	auipc	ra,0x1
     3be:	eb6080e7          	jalr	-330(ra) # 1270 <fprintf>
  color_yellow();
     3c2:	00000097          	auipc	ra,0x0
     3c6:	c3e080e7          	jalr	-962(ra) # 0 <color_yellow>
  fprintf(2, "  [LAZY] Virtual address allocated: %p\n", mem);
     3ca:	8662                	mv	a2,s8
     3cc:	00001597          	auipc	a1,0x1
     3d0:	35458593          	addi	a1,a1,852 # 1720 <malloc+0x3ca>
     3d4:	4509                	li	a0,2
     3d6:	00001097          	auipc	ra,0x1
     3da:	e9a080e7          	jalr	-358(ra) # 1270 <fprintf>
  fprintf(2, "  [LAZY] Free memory: %d KB (should be SAME as before!)\n", free_after_sbrk);
     3de:	f7c42483          	lw	s1,-132(s0)
     3e2:	8626                	mv	a2,s1
     3e4:	00001597          	auipc	a1,0x1
     3e8:	36458593          	addi	a1,a1,868 # 1748 <malloc+0x3f2>
     3ec:	4509                	li	a0,2
     3ee:	00001097          	auipc	ra,0x1
     3f2:	e82080e7          	jalr	-382(ra) # 1270 <fprintf>
  color_reset();
     3f6:	00000097          	auipc	ra,0x0
     3fa:	cda080e7          	jalr	-806(ra) # d0 <color_reset>
  if(free_after_sbrk >= free_before - 4) {
     3fe:	f6843783          	ld	a5,-152(s0)
     402:	37f1                	addiw	a5,a5,-4
     404:	06f4fa63          	bgeu	s1,a5,478 <main+0x338>
  fprintf(2, "\n");
     408:	00001597          	auipc	a1,0x1
     40c:	5b858593          	addi	a1,a1,1464 # 19c0 <malloc+0x66a>
     410:	4509                	li	a0,2
     412:	00001097          	auipc	ra,0x1
     416:	e5e080e7          	jalr	-418(ra) # 1270 <fprintf>
  fprintf(2, "  Step 2: Touching pages one by one...\n");
     41a:	00001597          	auipc	a1,0x1
     41e:	3b658593          	addi	a1,a1,950 # 17d0 <malloc+0x47a>
     422:	4509                	li	a0,2
     424:	00001097          	auipc	ra,0x1
     428:	e4c080e7          	jalr	-436(ra) # 1270 <fprintf>
  fprintf(2, "\n");
     42c:	00001597          	auipc	a1,0x1
     430:	59458593          	addi	a1,a1,1428 # 19c0 <malloc+0x66a>
     434:	4509                	li	a0,2
     436:	00001097          	auipc	ra,0x1
     43a:	e3a080e7          	jalr	-454(ra) # 1270 <fprintf>
     43e:	4b81                	li	s7,0
    get_mem_stats(&free_now, &cow_now);
     440:	f8840d93          	addi	s11,s0,-120
     444:	f8440d13          	addi	s10,s0,-124
    fprintf(2, "  Touched page %d: Free=%d KB  ", i + 1, free_now);
     448:	00001c97          	auipc	s9,0x1
     44c:	3b0c8c93          	addi	s9,s9,944 # 17f8 <malloc+0x4a2>
      fprintf(2, "#");
     450:	00001b17          	auipc	s6,0x1
     454:	3d0b0b13          	addi	s6,s6,976 # 1820 <malloc+0x4ca>
    for(int j = i + 1; j < num_pages; j++) {
     458:	4a3d                	li	s4,15
      fprintf(2, ".");
     45a:	00001a97          	auipc	s5,0x1
     45e:	3cea8a93          	addi	s5,s5,974 # 1828 <malloc+0x4d2>
     462:	a0bd                	j	4d0 <main+0x390>
    fprintf(2, "  ERROR: sbrk failed!\n");
     464:	00001597          	auipc	a1,0x1
     468:	2a458593          	addi	a1,a1,676 # 1708 <malloc+0x3b2>
     46c:	4509                	li	a0,2
     46e:	00001097          	auipc	ra,0x1
     472:	e02080e7          	jalr	-510(ra) # 1270 <fprintf>
    return;
     476:	aaa1                	j	5ce <main+0x48e>
    color_green();
     478:	00000097          	auipc	ra,0x0
     47c:	bf0080e7          	jalr	-1040(ra) # 68 <color_green>
    fprintf(2, "  [OK] No physical pages allocated yet! (Lazy Allocation works)\n");
     480:	00001597          	auipc	a1,0x1
     484:	30858593          	addi	a1,a1,776 # 1788 <malloc+0x432>
     488:	4509                	li	a0,2
     48a:	00001097          	auipc	ra,0x1
     48e:	de6080e7          	jalr	-538(ra) # 1270 <fprintf>
    color_reset();
     492:	00000097          	auipc	ra,0x0
     496:	c3e080e7          	jalr	-962(ra) # d0 <color_reset>
     49a:	b7bd                	j	408 <main+0x2c8>
      fprintf(2, ".");
     49c:	85d6                	mv	a1,s5
     49e:	4509                	li	a0,2
     4a0:	00001097          	auipc	ra,0x1
     4a4:	dd0080e7          	jalr	-560(ra) # 1270 <fprintf>
    for(int j = i + 1; j < num_pages; j++) {
     4a8:	2485                	addiw	s1,s1,1
     4aa:	fe9a59e3          	bge	s4,s1,49c <main+0x35c>
    fprintf(2, "]\n");
     4ae:	00001597          	auipc	a1,0x1
     4b2:	59a58593          	addi	a1,a1,1434 # 1a48 <malloc+0x6f2>
     4b6:	4509                	li	a0,2
     4b8:	00001097          	auipc	ra,0x1
     4bc:	db8080e7          	jalr	-584(ra) # 1270 <fprintf>
    sleep(30);  // 短暂延迟便于观察
     4c0:	4579                	li	a0,30
     4c2:	00001097          	auipc	ra,0x1
     4c6:	8d4080e7          	jalr	-1836(ra) # d96 <sleep>
  for(int i = 0; i < num_pages; i++) {
     4ca:	0b85                	addi	s7,s7,1
     4cc:	6785                	lui	a5,0x1
     4ce:	9c3e                	add	s8,s8,a5
    mem[i * 4096] = (char)i;  // 触摸页面触发 page fault
     4d0:	017c0023          	sb	s7,0(s8)
    get_mem_stats(&free_now, &cow_now);
     4d4:	85ee                	mv	a1,s11
     4d6:	856a                	mv	a0,s10
     4d8:	00000097          	auipc	ra,0x0
     4dc:	c24080e7          	jalr	-988(ra) # fc <get_mem_stats>
    fprintf(2, "  Touched page %d: Free=%d KB  ", i + 1, free_now);
     4e0:	001b849b          	addiw	s1,s7,1
     4e4:	f8442683          	lw	a3,-124(s0)
     4e8:	8626                	mv	a2,s1
     4ea:	85e6                	mv	a1,s9
     4ec:	4509                	li	a0,2
     4ee:	00001097          	auipc	ra,0x1
     4f2:	d82080e7          	jalr	-638(ra) # 1270 <fprintf>
    fprintf(2, "[");
     4f6:	00001597          	auipc	a1,0x1
     4fa:	32258593          	addi	a1,a1,802 # 1818 <malloc+0x4c2>
     4fe:	4509                	li	a0,2
     500:	00001097          	auipc	ra,0x1
     504:	d70080e7          	jalr	-656(ra) # 1270 <fprintf>
    for(int j = 0; j <= i; j++) {
     508:	000b899b          	sext.w	s3,s7
     50c:	0209c463          	bltz	s3,534 <main+0x3f4>
     510:	4901                	li	s2,0
      color_green();
     512:	00000097          	auipc	ra,0x0
     516:	b56080e7          	jalr	-1194(ra) # 68 <color_green>
      fprintf(2, "#");
     51a:	85da                	mv	a1,s6
     51c:	4509                	li	a0,2
     51e:	00001097          	auipc	ra,0x1
     522:	d52080e7          	jalr	-686(ra) # 1270 <fprintf>
      color_reset();
     526:	00000097          	auipc	ra,0x0
     52a:	baa080e7          	jalr	-1110(ra) # d0 <color_reset>
    for(int j = 0; j <= i; j++) {
     52e:	2905                	addiw	s2,s2,1
     530:	ff29d1e3          	bge	s3,s2,512 <main+0x3d2>
    for(int j = i + 1; j < num_pages; j++) {
     534:	f74b94e3          	bne	s7,s4,49c <main+0x35c>
    fprintf(2, "]\n");
     538:	00001597          	auipc	a1,0x1
     53c:	51058593          	addi	a1,a1,1296 # 1a48 <malloc+0x6f2>
     540:	4509                	li	a0,2
     542:	00001097          	auipc	ra,0x1
     546:	d2e080e7          	jalr	-722(ra) # 1270 <fprintf>
    sleep(30);  // 短暂延迟便于观察
     54a:	4579                	li	a0,30
     54c:	00001097          	auipc	ra,0x1
     550:	84a080e7          	jalr	-1974(ra) # d96 <sleep>
  get_mem_stats(&free_final, &cow_final);
     554:	f8840593          	addi	a1,s0,-120
     558:	f8440513          	addi	a0,s0,-124
     55c:	00000097          	auipc	ra,0x0
     560:	ba0080e7          	jalr	-1120(ra) # fc <get_mem_stats>
  fprintf(2, "\n");
     564:	00001597          	auipc	a1,0x1
     568:	45c58593          	addi	a1,a1,1116 # 19c0 <malloc+0x66a>
     56c:	4509                	li	a0,2
     56e:	00001097          	auipc	ra,0x1
     572:	d02080e7          	jalr	-766(ra) # 1270 <fprintf>
  color_green();
     576:	00000097          	auipc	ra,0x0
     57a:	af2080e7          	jalr	-1294(ra) # 68 <color_green>
  fprintf(2, "  === Lazy Allocation Demo Complete ===\n");
     57e:	00001597          	auipc	a1,0x1
     582:	62258593          	addi	a1,a1,1570 # 1ba0 <malloc+0x84a>
     586:	4509                	li	a0,2
     588:	00001097          	auipc	ra,0x1
     58c:	ce8080e7          	jalr	-792(ra) # 1270 <fprintf>
  color_reset();
     590:	00000097          	auipc	ra,0x0
     594:	b40080e7          	jalr	-1216(ra) # d0 <color_reset>
  fprintf(2, "  Memory consumed: %d KB (for %d pages)\n", 
     598:	f8442603          	lw	a2,-124(s0)
     59c:	46c1                	li	a3,16
     59e:	f6843783          	ld	a5,-152(s0)
     5a2:	40c7863b          	subw	a2,a5,a2
     5a6:	00001597          	auipc	a1,0x1
     5aa:	62a58593          	addi	a1,a1,1578 # 1bd0 <malloc+0x87a>
     5ae:	4509                	li	a0,2
     5b0:	00001097          	auipc	ra,0x1
     5b4:	cc0080e7          	jalr	-832(ra) # 1270 <fprintf>
  sbrk(-alloc_size);
     5b8:	7541                	lui	a0,0xffff0
     5ba:	00000097          	auipc	ra,0x0
     5be:	7d4080e7          	jalr	2004(ra) # d8e <sbrk>
  sleep(50);
     5c2:	03200513          	li	a0,50
     5c6:	00000097          	auipc	ra,0x0
     5ca:	7d0080e7          	jalr	2000(ra) # d96 <sleep>
  
  // 运行演示
  demo_lazy_allocation();
  
  sleep(100);
     5ce:	06400513          	li	a0,100
     5d2:	00000097          	auipc	ra,0x0
     5d6:	7c4080e7          	jalr	1988(ra) # d96 <sleep>
  color_cyan();
     5da:	00000097          	auipc	ra,0x0
     5de:	ac2080e7          	jalr	-1342(ra) # 9c <color_cyan>
  fprintf(2, "\n");
     5e2:	00001597          	auipc	a1,0x1
     5e6:	3de58593          	addi	a1,a1,990 # 19c0 <malloc+0x66a>
     5ea:	4509                	li	a0,2
     5ec:	00001097          	auipc	ra,0x1
     5f0:	c84080e7          	jalr	-892(ra) # 1270 <fprintf>
  fprintf(2, "+================================================================+\n");
     5f4:	00001597          	auipc	a1,0x1
     5f8:	e4c58593          	addi	a1,a1,-436 # 1440 <malloc+0xea>
     5fc:	4509                	li	a0,2
     5fe:	00001097          	auipc	ra,0x1
     602:	c72080e7          	jalr	-910(ra) # 1270 <fprintf>
  fprintf(2, "|             DEMO 2: Copy-on-Write (写时复制)                  |\n");
     606:	00001597          	auipc	a1,0x1
     60a:	22a58593          	addi	a1,a1,554 # 1830 <malloc+0x4da>
     60e:	4509                	li	a0,2
     610:	00001097          	auipc	ra,0x1
     614:	c60080e7          	jalr	-928(ra) # 1270 <fprintf>
  fprintf(2, "+================================================================+\n");
     618:	00001597          	auipc	a1,0x1
     61c:	e2858593          	addi	a1,a1,-472 # 1440 <malloc+0xea>
     620:	4509                	li	a0,2
     622:	00001097          	auipc	ra,0x1
     626:	c4e080e7          	jalr	-946(ra) # 1270 <fprintf>
  color_reset();
     62a:	00000097          	auipc	ra,0x0
     62e:	aa6080e7          	jalr	-1370(ra) # d0 <color_reset>
  fprintf(2, "\n");
     632:	00001597          	auipc	a1,0x1
     636:	38e58593          	addi	a1,a1,910 # 19c0 <malloc+0x66a>
     63a:	4509                	li	a0,2
     63c:	00001097          	auipc	ra,0x1
     640:	c34080e7          	jalr	-972(ra) # 1270 <fprintf>
  fprintf(2, "  Step 1: Parent allocates %d pages and writes data...\n", num_pages);
     644:	4621                	li	a2,8
     646:	00001597          	auipc	a1,0x1
     64a:	23258593          	addi	a1,a1,562 # 1878 <malloc+0x522>
     64e:	4509                	li	a0,2
     650:	00001097          	auipc	ra,0x1
     654:	c20080e7          	jalr	-992(ra) # 1270 <fprintf>
  sleep(100);
     658:	06400513          	li	a0,100
     65c:	00000097          	auipc	ra,0x0
     660:	73a080e7          	jalr	1850(ra) # d96 <sleep>
  char *mem = sbrk(alloc_size);
     664:	6521                	lui	a0,0x8
     666:	00000097          	auipc	ra,0x0
     66a:	728080e7          	jalr	1832(ra) # d8e <sbrk>
     66e:	84aa                	mv	s1,a0
  if(mem == (char*)-1) {
     670:	55fd                	li	a1,-1
     672:	87aa                	mv	a5,a0
     674:	6721                	lui	a4,0x8
     676:	972a                	add	a4,a4,a0
    mem[i * 4096] = 'P';  // Parent's data
     678:	05000613          	li	a2,80
  for(int i = 0; i < num_pages; i++) {
     67c:	6685                	lui	a3,0x1
  if(mem == (char*)-1) {
     67e:	1cb50b63          	beq	a0,a1,854 <main+0x714>
    mem[i * 4096] = 'P';  // Parent's data
     682:	00c78023          	sb	a2,0(a5) # 1000 <printint+0x18>
  for(int i = 0; i < num_pages; i++) {
     686:	97b6                	add	a5,a5,a3
     688:	fee79de3          	bne	a5,a4,682 <main+0x542>
  get_mem_stats(&free_before_fork, &cow_before_fork);
     68c:	f7840593          	addi	a1,s0,-136
     690:	f7440513          	addi	a0,s0,-140
     694:	00000097          	auipc	ra,0x0
     698:	a68080e7          	jalr	-1432(ra) # fc <get_mem_stats>
  fprintf(2, "  Parent memory allocated. Free: %d KB\n", free_before_fork);
     69c:	f7442603          	lw	a2,-140(s0)
     6a0:	00001597          	auipc	a1,0x1
     6a4:	21058593          	addi	a1,a1,528 # 18b0 <malloc+0x55a>
     6a8:	4509                	li	a0,2
     6aa:	00001097          	auipc	ra,0x1
     6ae:	bc6080e7          	jalr	-1082(ra) # 1270 <fprintf>
  fprintf(2, "  COW faults so far: %d\n", cow_before_fork);
     6b2:	f7842983          	lw	s3,-136(s0)
     6b6:	864e                	mv	a2,s3
     6b8:	00001597          	auipc	a1,0x1
     6bc:	22058593          	addi	a1,a1,544 # 18d8 <malloc+0x582>
     6c0:	4509                	li	a0,2
     6c2:	00001097          	auipc	ra,0x1
     6c6:	bae080e7          	jalr	-1106(ra) # 1270 <fprintf>
  fprintf(2, "\n");
     6ca:	00001597          	auipc	a1,0x1
     6ce:	2f658593          	addi	a1,a1,758 # 19c0 <malloc+0x66a>
     6d2:	4509                	li	a0,2
     6d4:	00001097          	auipc	ra,0x1
     6d8:	b9c080e7          	jalr	-1124(ra) # 1270 <fprintf>
  fprintf(2, "  Step 2: fork() - Child shares parent's pages (COW)...\n");
     6dc:	00001597          	auipc	a1,0x1
     6e0:	21c58593          	addi	a1,a1,540 # 18f8 <malloc+0x5a2>
     6e4:	4509                	li	a0,2
     6e6:	00001097          	auipc	ra,0x1
     6ea:	b8a080e7          	jalr	-1142(ra) # 1270 <fprintf>
  sleep(100);
     6ee:	06400513          	li	a0,100
     6f2:	00000097          	auipc	ra,0x0
     6f6:	6a4080e7          	jalr	1700(ra) # d96 <sleep>
  int pid = fork();
     6fa:	00000097          	auipc	ra,0x0
     6fe:	61c080e7          	jalr	1564(ra) # d16 <fork>
     702:	892a                	mv	s2,a0
  if(pid < 0) {
     704:	16054263          	bltz	a0,868 <main+0x728>
  if(pid == 0) {
     708:	16050f63          	beqz	a0,886 <main+0x746>
    get_mem_stats(&free_after_fork, &cow_after_fork);
     70c:	f8040593          	addi	a1,s0,-128
     710:	f7c40513          	addi	a0,s0,-132
     714:	00000097          	auipc	ra,0x0
     718:	9e8080e7          	jalr	-1560(ra) # fc <get_mem_stats>
    color_cyan();
     71c:	00000097          	auipc	ra,0x0
     720:	980080e7          	jalr	-1664(ra) # 9c <color_cyan>
    fprintf(2, "  [Parent] Forked child PID=%d\n", pid);
     724:	864a                	mv	a2,s2
     726:	00001597          	auipc	a1,0x1
     72a:	35a58593          	addi	a1,a1,858 # 1a80 <malloc+0x72a>
     72e:	4509                	li	a0,2
     730:	00001097          	auipc	ra,0x1
     734:	b40080e7          	jalr	-1216(ra) # 1270 <fprintf>
    fprintf(2, "  [Parent] Free memory: %d KB (minimal change - COW!)\n", free_after_fork);
     738:	f7c42603          	lw	a2,-132(s0)
     73c:	00001597          	auipc	a1,0x1
     740:	36458593          	addi	a1,a1,868 # 1aa0 <malloc+0x74a>
     744:	4509                	li	a0,2
     746:	00001097          	auipc	ra,0x1
     74a:	b2a080e7          	jalr	-1238(ra) # 1270 <fprintf>
    color_reset();
     74e:	00000097          	auipc	ra,0x0
     752:	982080e7          	jalr	-1662(ra) # d0 <color_reset>
    wait(0);
     756:	4501                	li	a0,0
     758:	00000097          	auipc	ra,0x0
     75c:	5ce080e7          	jalr	1486(ra) # d26 <wait>
    get_mem_stats(&free_final, &cow_final);
     760:	f8840593          	addi	a1,s0,-120
     764:	f8440513          	addi	a0,s0,-124
     768:	00000097          	auipc	ra,0x0
     76c:	994080e7          	jalr	-1644(ra) # fc <get_mem_stats>
    fprintf(2, "\n");
     770:	00001597          	auipc	a1,0x1
     774:	25058593          	addi	a1,a1,592 # 19c0 <malloc+0x66a>
     778:	4509                	li	a0,2
     77a:	00001097          	auipc	ra,0x1
     77e:	af6080e7          	jalr	-1290(ra) # 1270 <fprintf>
    color_green();
     782:	00000097          	auipc	ra,0x0
     786:	8e6080e7          	jalr	-1818(ra) # 68 <color_green>
    fprintf(2, "  === Copy-on-Write Demo Complete ===\n");
     78a:	00001597          	auipc	a1,0x1
     78e:	34e58593          	addi	a1,a1,846 # 1ad8 <malloc+0x782>
     792:	4509                	li	a0,2
     794:	00001097          	auipc	ra,0x1
     798:	adc080e7          	jalr	-1316(ra) # 1270 <fprintf>
    color_reset();
     79c:	00000097          	auipc	ra,0x0
     7a0:	934080e7          	jalr	-1740(ra) # d0 <color_reset>
    fprintf(2, "  Total COW faults: %d (should be ~%d)\n", 
     7a4:	f8842603          	lw	a2,-120(s0)
     7a8:	46a1                	li	a3,8
     7aa:	4136063b          	subw	a2,a2,s3
     7ae:	00001597          	auipc	a1,0x1
     7b2:	35258593          	addi	a1,a1,850 # 1b00 <malloc+0x7aa>
     7b6:	4509                	li	a0,2
     7b8:	00001097          	auipc	ra,0x1
     7bc:	ab8080e7          	jalr	-1352(ra) # 1270 <fprintf>
    fprintf(2, "  Memory saved by COW during fork: ~%d KB\n", alloc_size / 1024);
     7c0:	02000613          	li	a2,32
     7c4:	00001597          	auipc	a1,0x1
     7c8:	36458593          	addi	a1,a1,868 # 1b28 <malloc+0x7d2>
     7cc:	4509                	li	a0,2
     7ce:	00001097          	auipc	ra,0x1
     7d2:	aa2080e7          	jalr	-1374(ra) # 1270 <fprintf>
    sbrk(-alloc_size);
     7d6:	7561                	lui	a0,0xffff8
     7d8:	00000097          	auipc	ra,0x0
     7dc:	5b6080e7          	jalr	1462(ra) # d8e <sbrk>
  
  demo_cow();
  
  fprintf(2, "\n");
     7e0:	00001597          	auipc	a1,0x1
     7e4:	1e058593          	addi	a1,a1,480 # 19c0 <malloc+0x66a>
     7e8:	4509                	li	a0,2
     7ea:	00001097          	auipc	ra,0x1
     7ee:	a86080e7          	jalr	-1402(ra) # 1270 <fprintf>
  color_cyan();
     7f2:	00000097          	auipc	ra,0x0
     7f6:	8aa080e7          	jalr	-1878(ra) # 9c <color_cyan>
  fprintf(2, "+================================================================+\n");
     7fa:	00001597          	auipc	a1,0x1
     7fe:	c4658593          	addi	a1,a1,-954 # 1440 <malloc+0xea>
     802:	4509                	li	a0,2
     804:	00001097          	auipc	ra,0x1
     808:	a6c080e7          	jalr	-1428(ra) # 1270 <fprintf>
  fprintf(2, "|                    All Demos Complete!                        |\n");
     80c:	00001597          	auipc	a1,0x1
     810:	34c58593          	addi	a1,a1,844 # 1b58 <malloc+0x802>
     814:	4509                	li	a0,2
     816:	00001097          	auipc	ra,0x1
     81a:	a5a080e7          	jalr	-1446(ra) # 1270 <fprintf>
  fprintf(2, "+================================================================+\n");
     81e:	00001597          	auipc	a1,0x1
     822:	c2258593          	addi	a1,a1,-990 # 1440 <malloc+0xea>
     826:	4509                	li	a0,2
     828:	00001097          	auipc	ra,0x1
     82c:	a48080e7          	jalr	-1464(ra) # 1270 <fprintf>
  color_reset();
     830:	00000097          	auipc	ra,0x0
     834:	8a0080e7          	jalr	-1888(ra) # d0 <color_reset>
  fprintf(2, "\n");
     838:	00001597          	auipc	a1,0x1
     83c:	18858593          	addi	a1,a1,392 # 19c0 <malloc+0x66a>
     840:	4509                	li	a0,2
     842:	00001097          	auipc	ra,0x1
     846:	a2e080e7          	jalr	-1490(ra) # 1270 <fprintf>
  
  exit(0);
     84a:	4501                	li	a0,0
     84c:	00000097          	auipc	ra,0x0
     850:	4d2080e7          	jalr	1234(ra) # d1e <exit>
    fprintf(2, "  ERROR: sbrk failed!\n");
     854:	00001597          	auipc	a1,0x1
     858:	eb458593          	addi	a1,a1,-332 # 1708 <malloc+0x3b2>
     85c:	4509                	li	a0,2
     85e:	00001097          	auipc	ra,0x1
     862:	a12080e7          	jalr	-1518(ra) # 1270 <fprintf>
    return;
     866:	bfad                	j	7e0 <main+0x6a0>
    fprintf(2, "  ERROR: fork failed!\n");
     868:	00001597          	auipc	a1,0x1
     86c:	0d058593          	addi	a1,a1,208 # 1938 <malloc+0x5e2>
     870:	4509                	li	a0,2
     872:	00001097          	auipc	ra,0x1
     876:	9fe080e7          	jalr	-1538(ra) # 1270 <fprintf>
    sbrk(-alloc_size);
     87a:	7561                	lui	a0,0xffff8
     87c:	00000097          	auipc	ra,0x0
     880:	512080e7          	jalr	1298(ra) # d8e <sbrk>
    return;
     884:	bfb1                	j	7e0 <main+0x6a0>
    sleep(50);  // 让父进程先打印
     886:	03200513          	li	a0,50
     88a:	00000097          	auipc	ra,0x0
     88e:	50c080e7          	jalr	1292(ra) # d96 <sleep>
    get_mem_stats(&free_child, &cow_child);
     892:	f8040593          	addi	a1,s0,-128
     896:	f7c40513          	addi	a0,s0,-132
     89a:	00000097          	auipc	ra,0x0
     89e:	862080e7          	jalr	-1950(ra) # fc <get_mem_stats>
    fprintf(2, "\n");
     8a2:	00001597          	auipc	a1,0x1
     8a6:	11e58593          	addi	a1,a1,286 # 19c0 <malloc+0x66a>
     8aa:	4509                	li	a0,2
     8ac:	00001097          	auipc	ra,0x1
     8b0:	9c4080e7          	jalr	-1596(ra) # 1270 <fprintf>
    color_magenta();
     8b4:	fffff097          	auipc	ra,0xfffff
     8b8:	780080e7          	jalr	1920(ra) # 34 <color_magenta>
    fprintf(2, "  [Child] I'm the child process (PID=%d)\n", getpid());
     8bc:	00000097          	auipc	ra,0x0
     8c0:	4ca080e7          	jalr	1226(ra) # d86 <getpid>
     8c4:	862a                	mv	a2,a0
     8c6:	00001597          	auipc	a1,0x1
     8ca:	08a58593          	addi	a1,a1,138 # 1950 <malloc+0x5fa>
     8ce:	4509                	li	a0,2
     8d0:	00001097          	auipc	ra,0x1
     8d4:	9a0080e7          	jalr	-1632(ra) # 1270 <fprintf>
    fprintf(2, "  [Child] Free memory: %d KB (should be similar - pages shared!)\n", free_child);
     8d8:	f7c42603          	lw	a2,-132(s0)
     8dc:	00001597          	auipc	a1,0x1
     8e0:	0a458593          	addi	a1,a1,164 # 1980 <malloc+0x62a>
     8e4:	4509                	li	a0,2
     8e6:	00001097          	auipc	ra,0x1
     8ea:	98a080e7          	jalr	-1654(ra) # 1270 <fprintf>
    color_reset();
     8ee:	fffff097          	auipc	ra,0xfffff
     8f2:	7e2080e7          	jalr	2018(ra) # d0 <color_reset>
    fprintf(2, "\n");
     8f6:	00001597          	auipc	a1,0x1
     8fa:	0ca58593          	addi	a1,a1,202 # 19c0 <malloc+0x66a>
     8fe:	4509                	li	a0,2
     900:	00001097          	auipc	ra,0x1
     904:	970080e7          	jalr	-1680(ra) # 1270 <fprintf>
    fprintf(2, "  Step 3: Child writes to pages (triggers COW faults)...\n");
     908:	00001597          	auipc	a1,0x1
     90c:	0c058593          	addi	a1,a1,192 # 19c8 <malloc+0x672>
     910:	4509                	li	a0,2
     912:	00001097          	auipc	ra,0x1
     916:	95e080e7          	jalr	-1698(ra) # 1270 <fprintf>
    fprintf(2, "\n");
     91a:	00001597          	auipc	a1,0x1
     91e:	0a658593          	addi	a1,a1,166 # 19c0 <malloc+0x66a>
     922:	4509                	li	a0,2
     924:	00001097          	auipc	ra,0x1
     928:	94c080e7          	jalr	-1716(ra) # 1270 <fprintf>
     92c:	4981                	li	s3,0
      get_mem_stats(&free_child, &cow_before);
     92e:	f8440d13          	addi	s10,s0,-124
     932:	f7c40b13          	addi	s6,s0,-132
      mem[i * 4096] = 'C';  // Child's data - triggers COW!
     936:	04300c93          	li	s9,67
      get_mem_stats(&free_child, &cow_after);
     93a:	f8840c13          	addi	s8,s0,-120
      fprintf(2, "  [Child] Wrote page %d: COW faults: %d -> %d  ", 
     93e:	00001b97          	auipc	s7,0x1
     942:	0cab8b93          	addi	s7,s7,202 # 1a08 <malloc+0x6b2>
     946:	a8b1                	j	9a2 <main+0x862>
      for(int j = i + 1; j < num_pages; j++) {
     948:	4a9d                	li	s5,7
     94a:	034ac563          	blt	s5,s4,974 <main+0x834>
        color_green();
     94e:	fffff097          	auipc	ra,0xfffff
     952:	71a080e7          	jalr	1818(ra) # 68 <color_green>
        fprintf(2, "S");  // Still shared
     956:	00001597          	auipc	a1,0x1
     95a:	0ea58593          	addi	a1,a1,234 # 1a40 <malloc+0x6ea>
     95e:	4509                	li	a0,2
     960:	00001097          	auipc	ra,0x1
     964:	910080e7          	jalr	-1776(ra) # 1270 <fprintf>
        color_reset();
     968:	fffff097          	auipc	ra,0xfffff
     96c:	768080e7          	jalr	1896(ra) # d0 <color_reset>
      for(int j = i + 1; j < num_pages; j++) {
     970:	2a05                	addiw	s4,s4,1
     972:	bfe1                	j	94a <main+0x80a>
      fprintf(2, "]\n");
     974:	00001597          	auipc	a1,0x1
     978:	0d458593          	addi	a1,a1,212 # 1a48 <malloc+0x6f2>
     97c:	4509                	li	a0,2
     97e:	00001097          	auipc	ra,0x1
     982:	8f2080e7          	jalr	-1806(ra) # 1270 <fprintf>
      color_reset();
     986:	fffff097          	auipc	ra,0xfffff
     98a:	74a080e7          	jalr	1866(ra) # d0 <color_reset>
      sleep(50);
     98e:	03200513          	li	a0,50
     992:	00000097          	auipc	ra,0x0
     996:	404080e7          	jalr	1028(ra) # d96 <sleep>
    for(int i = 0; i < num_pages; i++) {
     99a:	0985                	addi	s3,s3,1
     99c:	47a1                	li	a5,8
     99e:	08f98563          	beq	s3,a5,a28 <main+0x8e8>
      get_mem_stats(&free_child, &cow_before);
     9a2:	85ea                	mv	a1,s10
     9a4:	855a                	mv	a0,s6
     9a6:	fffff097          	auipc	ra,0xfffff
     9aa:	756080e7          	jalr	1878(ra) # fc <get_mem_stats>
      mem[i * 4096] = 'C';  // Child's data - triggers COW!
     9ae:	00c99793          	slli	a5,s3,0xc
     9b2:	97a6                	add	a5,a5,s1
     9b4:	01978023          	sb	s9,0(a5)
      get_mem_stats(&free_child, &cow_after);
     9b8:	85e2                	mv	a1,s8
     9ba:	855a                	mv	a0,s6
     9bc:	fffff097          	auipc	ra,0xfffff
     9c0:	740080e7          	jalr	1856(ra) # fc <get_mem_stats>
      color_yellow();
     9c4:	fffff097          	auipc	ra,0xfffff
     9c8:	63c080e7          	jalr	1596(ra) # 0 <color_yellow>
      fprintf(2, "  [Child] Wrote page %d: COW faults: %d -> %d  ", 
     9cc:	00198a1b          	addiw	s4,s3,1
     9d0:	f8842703          	lw	a4,-120(s0)
     9d4:	f8442683          	lw	a3,-124(s0)
     9d8:	8652                	mv	a2,s4
     9da:	85de                	mv	a1,s7
     9dc:	4509                	li	a0,2
     9de:	00001097          	auipc	ra,0x1
     9e2:	892080e7          	jalr	-1902(ra) # 1270 <fprintf>
      fprintf(2, "[");
     9e6:	00001597          	auipc	a1,0x1
     9ea:	e3258593          	addi	a1,a1,-462 # 1818 <malloc+0x4c2>
     9ee:	4509                	li	a0,2
     9f0:	00001097          	auipc	ra,0x1
     9f4:	880080e7          	jalr	-1920(ra) # 1270 <fprintf>
      for(int j = 0; j <= i; j++) {
     9f8:	8aca                	mv	s5,s2
     9fa:	00098d9b          	sext.w	s11,s3
     9fe:	f55dc5e3          	blt	s11,s5,948 <main+0x808>
        color_magenta();
     a02:	fffff097          	auipc	ra,0xfffff
     a06:	632080e7          	jalr	1586(ra) # 34 <color_magenta>
        fprintf(2, "C");  // Child's private copy
     a0a:	00001597          	auipc	a1,0x1
     a0e:	02e58593          	addi	a1,a1,46 # 1a38 <malloc+0x6e2>
     a12:	4509                	li	a0,2
     a14:	00001097          	auipc	ra,0x1
     a18:	85c080e7          	jalr	-1956(ra) # 1270 <fprintf>
        color_reset();
     a1c:	fffff097          	auipc	ra,0xfffff
     a20:	6b4080e7          	jalr	1716(ra) # d0 <color_reset>
      for(int j = 0; j <= i; j++) {
     a24:	2a85                	addiw	s5,s5,1
     a26:	bfe1                	j	9fe <main+0x8be>
    fprintf(2, "\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	f9858593          	addi	a1,a1,-104 # 19c0 <malloc+0x66a>
     a30:	4509                	li	a0,2
     a32:	00001097          	auipc	ra,0x1
     a36:	83e080e7          	jalr	-1986(ra) # 1270 <fprintf>
    color_green();
     a3a:	fffff097          	auipc	ra,0xfffff
     a3e:	62e080e7          	jalr	1582(ra) # 68 <color_green>
    fprintf(2, "  [Child] All pages now private copies!\n");
     a42:	00001597          	auipc	a1,0x1
     a46:	00e58593          	addi	a1,a1,14 # 1a50 <malloc+0x6fa>
     a4a:	4509                	li	a0,2
     a4c:	00001097          	auipc	ra,0x1
     a50:	824080e7          	jalr	-2012(ra) # 1270 <fprintf>
    color_reset();
     a54:	fffff097          	auipc	ra,0xfffff
     a58:	67c080e7          	jalr	1660(ra) # d0 <color_reset>
    exit(0);
     a5c:	4501                	li	a0,0
     a5e:	00000097          	auipc	ra,0x0
     a62:	2c0080e7          	jalr	704(ra) # d1e <exit>

0000000000000a66 <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
     a66:	1141                	addi	sp,sp,-16
     a68:	e422                	sd	s0,8(sp)
     a6a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     a6c:	87aa                	mv	a5,a0
     a6e:	0585                	addi	a1,a1,1
     a70:	0785                	addi	a5,a5,1
     a72:	fff5c703          	lbu	a4,-1(a1)
     a76:	fee78fa3          	sb	a4,-1(a5)
     a7a:	fb75                	bnez	a4,a6e <strcpy+0x8>
    ;
  return os;
}
     a7c:	6422                	ld	s0,8(sp)
     a7e:	0141                	addi	sp,sp,16
     a80:	8082                	ret

0000000000000a82 <strcat>:

char*
strcat(char *s, const char *t)
{
     a82:	1141                	addi	sp,sp,-16
     a84:	e422                	sd	s0,8(sp)
     a86:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
     a88:	00054783          	lbu	a5,0(a0) # ffffffffffff8000 <__global_pointer$+0xffffffffffff5b8f>
     a8c:	c385                	beqz	a5,aac <strcat+0x2a>
     a8e:	87aa                	mv	a5,a0
    s++;
     a90:	0785                	addi	a5,a5,1
  while(*s)
     a92:	0007c703          	lbu	a4,0(a5)
     a96:	ff6d                	bnez	a4,a90 <strcat+0xe>
  while((*s++ = *t++))
     a98:	0585                	addi	a1,a1,1
     a9a:	0785                	addi	a5,a5,1
     a9c:	fff5c703          	lbu	a4,-1(a1)
     aa0:	fee78fa3          	sb	a4,-1(a5)
     aa4:	fb75                	bnez	a4,a98 <strcat+0x16>
    ;
  return os;
}
     aa6:	6422                	ld	s0,8(sp)
     aa8:	0141                	addi	sp,sp,16
     aaa:	8082                	ret
  while(*s)
     aac:	87aa                	mv	a5,a0
     aae:	b7ed                	j	a98 <strcat+0x16>

0000000000000ab0 <strcmp>:


int
strcmp(const char *p, const char *q)
{
     ab0:	1141                	addi	sp,sp,-16
     ab2:	e422                	sd	s0,8(sp)
     ab4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     ab6:	00054783          	lbu	a5,0(a0)
     aba:	cb91                	beqz	a5,ace <strcmp+0x1e>
     abc:	0005c703          	lbu	a4,0(a1)
     ac0:	00f71763          	bne	a4,a5,ace <strcmp+0x1e>
    p++, q++;
     ac4:	0505                	addi	a0,a0,1
     ac6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     ac8:	00054783          	lbu	a5,0(a0)
     acc:	fbe5                	bnez	a5,abc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     ace:	0005c503          	lbu	a0,0(a1)
}
     ad2:	40a7853b          	subw	a0,a5,a0
     ad6:	6422                	ld	s0,8(sp)
     ad8:	0141                	addi	sp,sp,16
     ada:	8082                	ret

0000000000000adc <strlen>:

uint
strlen(const char *s)
{
     adc:	1141                	addi	sp,sp,-16
     ade:	e422                	sd	s0,8(sp)
     ae0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     ae2:	00054783          	lbu	a5,0(a0)
     ae6:	cf91                	beqz	a5,b02 <strlen+0x26>
     ae8:	0505                	addi	a0,a0,1
     aea:	87aa                	mv	a5,a0
     aec:	4685                	li	a3,1
     aee:	9e89                	subw	a3,a3,a0
     af0:	00f6853b          	addw	a0,a3,a5
     af4:	0785                	addi	a5,a5,1
     af6:	fff7c703          	lbu	a4,-1(a5)
     afa:	fb7d                	bnez	a4,af0 <strlen+0x14>
    ;
  return n;
}
     afc:	6422                	ld	s0,8(sp)
     afe:	0141                	addi	sp,sp,16
     b00:	8082                	ret
  for(n = 0; s[n]; n++)
     b02:	4501                	li	a0,0
     b04:	bfe5                	j	afc <strlen+0x20>

0000000000000b06 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b06:	1141                	addi	sp,sp,-16
     b08:	e422                	sd	s0,8(sp)
     b0a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     b0c:	ca19                	beqz	a2,b22 <memset+0x1c>
     b0e:	87aa                	mv	a5,a0
     b10:	1602                	slli	a2,a2,0x20
     b12:	9201                	srli	a2,a2,0x20
     b14:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     b18:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     b1c:	0785                	addi	a5,a5,1
     b1e:	fee79de3          	bne	a5,a4,b18 <memset+0x12>
  }
  return dst;
}
     b22:	6422                	ld	s0,8(sp)
     b24:	0141                	addi	sp,sp,16
     b26:	8082                	ret

0000000000000b28 <strchr>:

char*
strchr(const char *s, char c)
{
     b28:	1141                	addi	sp,sp,-16
     b2a:	e422                	sd	s0,8(sp)
     b2c:	0800                	addi	s0,sp,16
  for(; *s; s++)
     b2e:	00054783          	lbu	a5,0(a0)
     b32:	cb99                	beqz	a5,b48 <strchr+0x20>
    if(*s == c)
     b34:	00f58763          	beq	a1,a5,b42 <strchr+0x1a>
  for(; *s; s++)
     b38:	0505                	addi	a0,a0,1
     b3a:	00054783          	lbu	a5,0(a0)
     b3e:	fbfd                	bnez	a5,b34 <strchr+0xc>
      return (char*)s;
  return 0;
     b40:	4501                	li	a0,0
}
     b42:	6422                	ld	s0,8(sp)
     b44:	0141                	addi	sp,sp,16
     b46:	8082                	ret
  return 0;
     b48:	4501                	li	a0,0
     b4a:	bfe5                	j	b42 <strchr+0x1a>

0000000000000b4c <gets>:

char*
gets(char *buf, int max)
{
     b4c:	711d                	addi	sp,sp,-96
     b4e:	ec86                	sd	ra,88(sp)
     b50:	e8a2                	sd	s0,80(sp)
     b52:	e4a6                	sd	s1,72(sp)
     b54:	e0ca                	sd	s2,64(sp)
     b56:	fc4e                	sd	s3,56(sp)
     b58:	f852                	sd	s4,48(sp)
     b5a:	f456                	sd	s5,40(sp)
     b5c:	f05a                	sd	s6,32(sp)
     b5e:	ec5e                	sd	s7,24(sp)
     b60:	e862                	sd	s8,16(sp)
     b62:	1080                	addi	s0,sp,96
     b64:	8baa                	mv	s7,a0
     b66:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b68:	892a                	mv	s2,a0
     b6a:	4481                	li	s1,0
    cc = read(0, &c, 1);
     b6c:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     b70:	4b29                	li	s6,10
     b72:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     b74:	89a6                	mv	s3,s1
     b76:	2485                	addiw	s1,s1,1
     b78:	0344d763          	bge	s1,s4,ba6 <gets+0x5a>
    cc = read(0, &c, 1);
     b7c:	4605                	li	a2,1
     b7e:	85d6                	mv	a1,s5
     b80:	4501                	li	a0,0
     b82:	00000097          	auipc	ra,0x0
     b86:	1b4080e7          	jalr	436(ra) # d36 <read>
    if(cc < 1)
     b8a:	00a05e63          	blez	a0,ba6 <gets+0x5a>
    buf[i++] = c;
     b8e:	faf44783          	lbu	a5,-81(s0)
     b92:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     b96:	01678763          	beq	a5,s6,ba4 <gets+0x58>
     b9a:	0905                	addi	s2,s2,1
     b9c:	fd879ce3          	bne	a5,s8,b74 <gets+0x28>
  for(i=0; i+1 < max; ){
     ba0:	89a6                	mv	s3,s1
     ba2:	a011                	j	ba6 <gets+0x5a>
     ba4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     ba6:	99de                	add	s3,s3,s7
     ba8:	00098023          	sb	zero,0(s3)
  return buf;
}
     bac:	855e                	mv	a0,s7
     bae:	60e6                	ld	ra,88(sp)
     bb0:	6446                	ld	s0,80(sp)
     bb2:	64a6                	ld	s1,72(sp)
     bb4:	6906                	ld	s2,64(sp)
     bb6:	79e2                	ld	s3,56(sp)
     bb8:	7a42                	ld	s4,48(sp)
     bba:	7aa2                	ld	s5,40(sp)
     bbc:	7b02                	ld	s6,32(sp)
     bbe:	6be2                	ld	s7,24(sp)
     bc0:	6c42                	ld	s8,16(sp)
     bc2:	6125                	addi	sp,sp,96
     bc4:	8082                	ret

0000000000000bc6 <stat>:

int
stat(const char *n, struct stat *st)
{
     bc6:	1101                	addi	sp,sp,-32
     bc8:	ec06                	sd	ra,24(sp)
     bca:	e822                	sd	s0,16(sp)
     bcc:	e426                	sd	s1,8(sp)
     bce:	e04a                	sd	s2,0(sp)
     bd0:	1000                	addi	s0,sp,32
     bd2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     bd4:	4581                	li	a1,0
     bd6:	00000097          	auipc	ra,0x0
     bda:	188080e7          	jalr	392(ra) # d5e <open>
  if(fd < 0)
     bde:	02054563          	bltz	a0,c08 <stat+0x42>
     be2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     be4:	85ca                	mv	a1,s2
     be6:	00000097          	auipc	ra,0x0
     bea:	180080e7          	jalr	384(ra) # d66 <fstat>
     bee:	892a                	mv	s2,a0
  close(fd);
     bf0:	8526                	mv	a0,s1
     bf2:	00000097          	auipc	ra,0x0
     bf6:	154080e7          	jalr	340(ra) # d46 <close>
  return r;
}
     bfa:	854a                	mv	a0,s2
     bfc:	60e2                	ld	ra,24(sp)
     bfe:	6442                	ld	s0,16(sp)
     c00:	64a2                	ld	s1,8(sp)
     c02:	6902                	ld	s2,0(sp)
     c04:	6105                	addi	sp,sp,32
     c06:	8082                	ret
    return -1;
     c08:	597d                	li	s2,-1
     c0a:	bfc5                	j	bfa <stat+0x34>

0000000000000c0c <atoi>:

int
atoi(const char *s)
{
     c0c:	1141                	addi	sp,sp,-16
     c0e:	e422                	sd	s0,8(sp)
     c10:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
     c12:	00054703          	lbu	a4,0(a0)
     c16:	02d00793          	li	a5,45
  int neg = 1;
     c1a:	4585                	li	a1,1
  if (*s == '-') {
     c1c:	04f70363          	beq	a4,a5,c62 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
     c20:	00054703          	lbu	a4,0(a0)
     c24:	fd07079b          	addiw	a5,a4,-48 # 7fd0 <__global_pointer$+0x5b5f>
     c28:	0ff7f793          	zext.b	a5,a5
     c2c:	46a5                	li	a3,9
     c2e:	02f6ed63          	bltu	a3,a5,c68 <atoi+0x5c>
  n = 0;
     c32:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
     c34:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
     c36:	0505                	addi	a0,a0,1
     c38:	0026979b          	slliw	a5,a3,0x2
     c3c:	9fb5                	addw	a5,a5,a3
     c3e:	0017979b          	slliw	a5,a5,0x1
     c42:	9fb9                	addw	a5,a5,a4
     c44:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
     c48:	00054703          	lbu	a4,0(a0)
     c4c:	fd07079b          	addiw	a5,a4,-48
     c50:	0ff7f793          	zext.b	a5,a5
     c54:	fef671e3          	bgeu	a2,a5,c36 <atoi+0x2a>
  return n * neg;
}
     c58:	02d5853b          	mulw	a0,a1,a3
     c5c:	6422                	ld	s0,8(sp)
     c5e:	0141                	addi	sp,sp,16
     c60:	8082                	ret
    s++;
     c62:	0505                	addi	a0,a0,1
    neg = -1;
     c64:	55fd                	li	a1,-1
     c66:	bf6d                	j	c20 <atoi+0x14>
  n = 0;
     c68:	4681                	li	a3,0
     c6a:	b7fd                	j	c58 <atoi+0x4c>

0000000000000c6c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c6c:	1141                	addi	sp,sp,-16
     c6e:	e422                	sd	s0,8(sp)
     c70:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     c72:	02b57463          	bgeu	a0,a1,c9a <memmove+0x2e>
    while(n-- > 0)
     c76:	00c05f63          	blez	a2,c94 <memmove+0x28>
     c7a:	1602                	slli	a2,a2,0x20
     c7c:	9201                	srli	a2,a2,0x20
     c7e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     c82:	872a                	mv	a4,a0
      *dst++ = *src++;
     c84:	0585                	addi	a1,a1,1
     c86:	0705                	addi	a4,a4,1
     c88:	fff5c683          	lbu	a3,-1(a1)
     c8c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     c90:	fee79ae3          	bne	a5,a4,c84 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     c94:	6422                	ld	s0,8(sp)
     c96:	0141                	addi	sp,sp,16
     c98:	8082                	ret
    dst += n;
     c9a:	00c50733          	add	a4,a0,a2
    src += n;
     c9e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ca0:	fec05ae3          	blez	a2,c94 <memmove+0x28>
     ca4:	fff6079b          	addiw	a5,a2,-1
     ca8:	1782                	slli	a5,a5,0x20
     caa:	9381                	srli	a5,a5,0x20
     cac:	fff7c793          	not	a5,a5
     cb0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     cb2:	15fd                	addi	a1,a1,-1
     cb4:	177d                	addi	a4,a4,-1
     cb6:	0005c683          	lbu	a3,0(a1)
     cba:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     cbe:	fee79ae3          	bne	a5,a4,cb2 <memmove+0x46>
     cc2:	bfc9                	j	c94 <memmove+0x28>

0000000000000cc4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     cc4:	1141                	addi	sp,sp,-16
     cc6:	e422                	sd	s0,8(sp)
     cc8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     cca:	ca05                	beqz	a2,cfa <memcmp+0x36>
     ccc:	fff6069b          	addiw	a3,a2,-1
     cd0:	1682                	slli	a3,a3,0x20
     cd2:	9281                	srli	a3,a3,0x20
     cd4:	0685                	addi	a3,a3,1 # 1001 <printint+0x19>
     cd6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     cd8:	00054783          	lbu	a5,0(a0)
     cdc:	0005c703          	lbu	a4,0(a1)
     ce0:	00e79863          	bne	a5,a4,cf0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     ce4:	0505                	addi	a0,a0,1
    p2++;
     ce6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     ce8:	fed518e3          	bne	a0,a3,cd8 <memcmp+0x14>
  }
  return 0;
     cec:	4501                	li	a0,0
     cee:	a019                	j	cf4 <memcmp+0x30>
      return *p1 - *p2;
     cf0:	40e7853b          	subw	a0,a5,a4
}
     cf4:	6422                	ld	s0,8(sp)
     cf6:	0141                	addi	sp,sp,16
     cf8:	8082                	ret
  return 0;
     cfa:	4501                	li	a0,0
     cfc:	bfe5                	j	cf4 <memcmp+0x30>

0000000000000cfe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     cfe:	1141                	addi	sp,sp,-16
     d00:	e406                	sd	ra,8(sp)
     d02:	e022                	sd	s0,0(sp)
     d04:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     d06:	00000097          	auipc	ra,0x0
     d0a:	f66080e7          	jalr	-154(ra) # c6c <memmove>
}
     d0e:	60a2                	ld	ra,8(sp)
     d10:	6402                	ld	s0,0(sp)
     d12:	0141                	addi	sp,sp,16
     d14:	8082                	ret

0000000000000d16 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
     d16:	4885                	li	a7,1
 ecall
     d18:	00000073          	ecall
 ret
     d1c:	8082                	ret

0000000000000d1e <exit>:
.global exit
exit:
 li a7, SYS_exit
     d1e:	4889                	li	a7,2
 ecall
     d20:	00000073          	ecall
 ret
     d24:	8082                	ret

0000000000000d26 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d26:	488d                	li	a7,3
 ecall
     d28:	00000073          	ecall
 ret
     d2c:	8082                	ret

0000000000000d2e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d2e:	4891                	li	a7,4
 ecall
     d30:	00000073          	ecall
 ret
     d34:	8082                	ret

0000000000000d36 <read>:
.global read
read:
 li a7, SYS_read
     d36:	4895                	li	a7,5
 ecall
     d38:	00000073          	ecall
 ret
     d3c:	8082                	ret

0000000000000d3e <write>:
.global write
write:
 li a7, SYS_write
     d3e:	48c1                	li	a7,16
 ecall
     d40:	00000073          	ecall
 ret
     d44:	8082                	ret

0000000000000d46 <close>:
.global close
close:
 li a7, SYS_close
     d46:	48d5                	li	a7,21
 ecall
     d48:	00000073          	ecall
 ret
     d4c:	8082                	ret

0000000000000d4e <kill>:
.global kill
kill:
 li a7, SYS_kill
     d4e:	4899                	li	a7,6
 ecall
     d50:	00000073          	ecall
 ret
     d54:	8082                	ret

0000000000000d56 <exec>:
.global exec
exec:
 li a7, SYS_exec
     d56:	489d                	li	a7,7
 ecall
     d58:	00000073          	ecall
 ret
     d5c:	8082                	ret

0000000000000d5e <open>:
.global open
open:
 li a7, SYS_open
     d5e:	48bd                	li	a7,15
 ecall
     d60:	00000073          	ecall
 ret
     d64:	8082                	ret

0000000000000d66 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     d66:	48a1                	li	a7,8
 ecall
     d68:	00000073          	ecall
 ret
     d6c:	8082                	ret

0000000000000d6e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     d6e:	48d1                	li	a7,20
 ecall
     d70:	00000073          	ecall
 ret
     d74:	8082                	ret

0000000000000d76 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d76:	48a5                	li	a7,9
 ecall
     d78:	00000073          	ecall
 ret
     d7c:	8082                	ret

0000000000000d7e <dup>:
.global dup
dup:
 li a7, SYS_dup
     d7e:	48a9                	li	a7,10
 ecall
     d80:	00000073          	ecall
 ret
     d84:	8082                	ret

0000000000000d86 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d86:	48ad                	li	a7,11
 ecall
     d88:	00000073          	ecall
 ret
     d8c:	8082                	ret

0000000000000d8e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     d8e:	48b1                	li	a7,12
 ecall
     d90:	00000073          	ecall
 ret
     d94:	8082                	ret

0000000000000d96 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     d96:	48b5                	li	a7,13
 ecall
     d98:	00000073          	ecall
 ret
     d9c:	8082                	ret

0000000000000d9e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d9e:	48b9                	li	a7,14
 ecall
     da0:	00000073          	ecall
 ret
     da4:	8082                	ret

0000000000000da6 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
     da6:	48d9                	li	a7,22
 ecall
     da8:	00000073          	ecall
 ret
     dac:	8082                	ret

0000000000000dae <dev>:
.global dev
dev:
 li a7, SYS_dev
     dae:	48dd                	li	a7,23
 ecall
     db0:	00000073          	ecall
 ret
     db4:	8082                	ret

0000000000000db6 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
     db6:	48e1                	li	a7,24
 ecall
     db8:	00000073          	ecall
 ret
     dbc:	8082                	ret

0000000000000dbe <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     dbe:	48e5                	li	a7,25
 ecall
     dc0:	00000073          	ecall
 ret
     dc4:	8082                	ret

0000000000000dc6 <remove>:
.global remove
remove:
 li a7, SYS_remove
     dc6:	48c5                	li	a7,17
 ecall
     dc8:	00000073          	ecall
 ret
     dcc:	8082                	ret

0000000000000dce <trace>:
.global trace
trace:
 li a7, SYS_trace
     dce:	48c9                	li	a7,18
 ecall
     dd0:	00000073          	ecall
 ret
     dd4:	8082                	ret

0000000000000dd6 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     dd6:	48cd                	li	a7,19
 ecall
     dd8:	00000073          	ecall
 ret
     ddc:	8082                	ret

0000000000000dde <rename>:
.global rename
rename:
 li a7, SYS_rename
     dde:	48e9                	li	a7,26
 ecall
     de0:	00000073          	ecall
 ret
     de4:	8082                	ret

0000000000000de6 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
     de6:	48ed                	li	a7,27
 ecall
     de8:	00000073          	ecall
 ret
     dec:	8082                	ret

0000000000000dee <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
     dee:	48f1                	li	a7,28
 ecall
     df0:	00000073          	ecall
 ret
     df4:	8082                	ret

0000000000000df6 <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
     df6:	48f5                	li	a7,29
 ecall
     df8:	00000073          	ecall
 ret
     dfc:	8082                	ret

0000000000000dfe <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
     dfe:	48f9                	li	a7,30
 ecall
     e00:	00000073          	ecall
 ret
     e04:	8082                	ret

0000000000000e06 <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
     e06:	48fd                	li	a7,31
 ecall
     e08:	00000073          	ecall
 ret
     e0c:	8082                	ret

0000000000000e0e <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
     e0e:	02000893          	li	a7,32
 ecall
     e12:	00000073          	ecall
 ret
     e16:	8082                	ret

0000000000000e18 <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
     e18:	02100893          	li	a7,33
 ecall
     e1c:	00000073          	ecall
 ret
     e20:	8082                	ret

0000000000000e22 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
     e22:	02200893          	li	a7,34
 ecall
     e26:	00000073          	ecall
 ret
     e2a:	8082                	ret

0000000000000e2c <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
     e2c:	02300893          	li	a7,35
 ecall
     e30:	00000073          	ecall
 ret
     e34:	8082                	ret

0000000000000e36 <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
     e36:	02400893          	li	a7,36
 ecall
     e3a:	00000073          	ecall
 ret
     e3e:	8082                	ret

0000000000000e40 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
     e40:	02500893          	li	a7,37
 ecall
     e44:	00000073          	ecall
 ret
     e48:	8082                	ret

0000000000000e4a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
     e4a:	02600893          	li	a7,38
 ecall
     e4e:	00000073          	ecall
 ret
     e52:	8082                	ret

0000000000000e54 <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
     e54:	02700893          	li	a7,39
 ecall
     e58:	00000073          	ecall
 ret
     e5c:	8082                	ret

0000000000000e5e <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
     e5e:	02800893          	li	a7,40
 ecall
     e62:	00000073          	ecall
 ret
     e66:	8082                	ret

0000000000000e68 <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
     e68:	02900893          	li	a7,41
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
     e72:	02a00893          	li	a7,42
 ecall
     e76:	00000073          	ecall
 ret
     e7a:	8082                	ret

0000000000000e7c <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
     e7c:	02b00893          	li	a7,43
 ecall
     e80:	00000073          	ecall
 ret
     e84:	8082                	ret

0000000000000e86 <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
     e86:	02c00893          	li	a7,44
 ecall
     e8a:	00000073          	ecall
 ret
     e8e:	8082                	ret

0000000000000e90 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
     e90:	02d00893          	li	a7,45
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
     e9a:	02e00893          	li	a7,46
 ecall
     e9e:	00000073          	ecall
 ret
     ea2:	8082                	ret

0000000000000ea4 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
     ea4:	02f00893          	li	a7,47
 ecall
     ea8:	00000073          	ecall
 ret
     eac:	8082                	ret

0000000000000eae <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
     eae:	03000893          	li	a7,48
 ecall
     eb2:	00000073          	ecall
 ret
     eb6:	8082                	ret

0000000000000eb8 <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
     eb8:	03100893          	li	a7,49
 ecall
     ebc:	00000073          	ecall
 ret
     ec0:	8082                	ret

0000000000000ec2 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
     ec2:	03200893          	li	a7,50
 ecall
     ec6:	00000073          	ecall
 ret
     eca:	8082                	ret

0000000000000ecc <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
     ecc:	03300893          	li	a7,51
 ecall
     ed0:	00000073          	ecall
 ret
     ed4:	8082                	ret

0000000000000ed6 <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
     ed6:	03400893          	li	a7,52
 ecall
     eda:	00000073          	ecall
 ret
     ede:	8082                	ret

0000000000000ee0 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
     ee0:	03500893          	li	a7,53
 ecall
     ee4:	00000073          	ecall
 ret
     ee8:	8082                	ret

0000000000000eea <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
     eea:	03600893          	li	a7,54
 ecall
     eee:	00000073          	ecall
 ret
     ef2:	8082                	ret

0000000000000ef4 <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
     ef4:	03700893          	li	a7,55
 ecall
     ef8:	00000073          	ecall
 ret
     efc:	8082                	ret

0000000000000efe <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
     efe:	03800893          	li	a7,56
 ecall
     f02:	00000073          	ecall
 ret
     f06:	8082                	ret

0000000000000f08 <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
     f08:	03900893          	li	a7,57
 ecall
     f0c:	00000073          	ecall
 ret
     f10:	8082                	ret

0000000000000f12 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
     f12:	03a00893          	li	a7,58
 ecall
     f16:	00000073          	ecall
 ret
     f1a:	8082                	ret

0000000000000f1c <poll>:
.global poll
poll:
 li a7, SYS_poll
     f1c:	03b00893          	li	a7,59
 ecall
     f20:	00000073          	ecall
 ret
     f24:	8082                	ret

0000000000000f26 <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
     f26:	03c00893          	li	a7,60
 ecall
     f2a:	00000073          	ecall
 ret
     f2e:	8082                	ret

0000000000000f30 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
     f30:	03d00893          	li	a7,61
 ecall
     f34:	00000073          	ecall
 ret
     f38:	8082                	ret

0000000000000f3a <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
     f3a:	03e00893          	li	a7,62
 ecall
     f3e:	00000073          	ecall
 ret
     f42:	8082                	ret

0000000000000f44 <clone>:
.global clone
clone:
 li a7, SYS_clone
     f44:	03f00893          	li	a7,63
 ecall
     f48:	00000073          	ecall
 ret
     f4c:	8082                	ret

0000000000000f4e <futex>:
.global futex
futex:
 li a7, SYS_futex
     f4e:	04000893          	li	a7,64
 ecall
     f52:	00000073          	ecall
 ret
     f56:	8082                	ret

0000000000000f58 <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
     f58:	04100893          	li	a7,65
 ecall
     f5c:	00000073          	ecall
 ret
     f60:	8082                	ret

0000000000000f62 <halt>:
.global halt
halt:
 li a7, SYS_halt
     f62:	04200893          	li	a7,66
 ecall
     f66:	00000073          	ecall
 ret
     f6a:	8082                	ret

0000000000000f6c <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
     f6c:	04300893          	li	a7,67
 ecall
     f70:	00000073          	ecall
 ret
     f74:	8082                	ret

0000000000000f76 <socket>:
.global socket
socket:
 li a7, SYS_socket
     f76:	04400893          	li	a7,68
 ecall
     f7a:	00000073          	ecall
 ret
     f7e:	8082                	ret

0000000000000f80 <bind>:
.global bind
bind:
 li a7, SYS_bind
     f80:	04500893          	li	a7,69
 ecall
     f84:	00000073          	ecall
 ret
     f88:	8082                	ret

0000000000000f8a <listen>:
.global listen
listen:
 li a7, SYS_listen
     f8a:	04600893          	li	a7,70
 ecall
     f8e:	00000073          	ecall
 ret
     f92:	8082                	ret

0000000000000f94 <accept>:
.global accept
accept:
 li a7, SYS_accept
     f94:	04700893          	li	a7,71
 ecall
     f98:	00000073          	ecall
 ret
     f9c:	8082                	ret

0000000000000f9e <connect>:
.global connect
connect:
 li a7, SYS_connect
     f9e:	04800893          	li	a7,72
 ecall
     fa2:	00000073          	ecall
 ret
     fa6:	8082                	ret

0000000000000fa8 <send>:
.global send
send:
 li a7, SYS_send
     fa8:	04900893          	li	a7,73
 ecall
     fac:	00000073          	ecall
 ret
     fb0:	8082                	ret

0000000000000fb2 <recv>:
.global recv
recv:
 li a7, SYS_recv
     fb2:	04a00893          	li	a7,74
 ecall
     fb6:	00000073          	ecall
 ret
     fba:	8082                	ret

0000000000000fbc <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
     fbc:	04b00893          	li	a7,75
 ecall
     fc0:	00000073          	ecall
 ret
     fc4:	8082                	ret

0000000000000fc6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     fc6:	1101                	addi	sp,sp,-32
     fc8:	ec06                	sd	ra,24(sp)
     fca:	e822                	sd	s0,16(sp)
     fcc:	1000                	addi	s0,sp,32
     fce:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     fd2:	4605                	li	a2,1
     fd4:	fef40593          	addi	a1,s0,-17
     fd8:	00000097          	auipc	ra,0x0
     fdc:	d66080e7          	jalr	-666(ra) # d3e <write>
}
     fe0:	60e2                	ld	ra,24(sp)
     fe2:	6442                	ld	s0,16(sp)
     fe4:	6105                	addi	sp,sp,32
     fe6:	8082                	ret

0000000000000fe8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fe8:	7139                	addi	sp,sp,-64
     fea:	fc06                	sd	ra,56(sp)
     fec:	f822                	sd	s0,48(sp)
     fee:	f426                	sd	s1,40(sp)
     ff0:	f04a                	sd	s2,32(sp)
     ff2:	ec4e                	sd	s3,24(sp)
     ff4:	0080                	addi	s0,sp,64
     ff6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ff8:	c299                	beqz	a3,ffe <printint+0x16>
     ffa:	0805c863          	bltz	a1,108a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ffe:	2581                	sext.w	a1,a1
  neg = 0;
    1000:	4881                	li	a7,0
  }

  i = 0;
    1002:	fc040993          	addi	s3,s0,-64
  neg = 0;
    1006:	86ce                	mv	a3,s3
  i = 0;
    1008:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    100a:	2601                	sext.w	a2,a2
    100c:	00001517          	auipc	a0,0x1
    1010:	c5450513          	addi	a0,a0,-940 # 1c60 <digits>
    1014:	883a                	mv	a6,a4
    1016:	2705                	addiw	a4,a4,1
    1018:	02c5f7bb          	remuw	a5,a1,a2
    101c:	1782                	slli	a5,a5,0x20
    101e:	9381                	srli	a5,a5,0x20
    1020:	97aa                	add	a5,a5,a0
    1022:	0007c783          	lbu	a5,0(a5)
    1026:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    102a:	0005879b          	sext.w	a5,a1
    102e:	02c5d5bb          	divuw	a1,a1,a2
    1032:	0685                	addi	a3,a3,1
    1034:	fec7f0e3          	bgeu	a5,a2,1014 <printint+0x2c>
  if(neg)
    1038:	00088c63          	beqz	a7,1050 <printint+0x68>
    buf[i++] = '-';
    103c:	fd070793          	addi	a5,a4,-48
    1040:	00878733          	add	a4,a5,s0
    1044:	02d00793          	li	a5,45
    1048:	fef70823          	sb	a5,-16(a4)
    104c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1050:	02e05663          	blez	a4,107c <printint+0x94>
    1054:	fc040913          	addi	s2,s0,-64
    1058:	993a                	add	s2,s2,a4
    105a:	19fd                	addi	s3,s3,-1
    105c:	99ba                	add	s3,s3,a4
    105e:	377d                	addiw	a4,a4,-1
    1060:	1702                	slli	a4,a4,0x20
    1062:	9301                	srli	a4,a4,0x20
    1064:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1068:	fff94583          	lbu	a1,-1(s2)
    106c:	8526                	mv	a0,s1
    106e:	00000097          	auipc	ra,0x0
    1072:	f58080e7          	jalr	-168(ra) # fc6 <putc>
  while(--i >= 0)
    1076:	197d                	addi	s2,s2,-1
    1078:	ff3918e3          	bne	s2,s3,1068 <printint+0x80>
}
    107c:	70e2                	ld	ra,56(sp)
    107e:	7442                	ld	s0,48(sp)
    1080:	74a2                	ld	s1,40(sp)
    1082:	7902                	ld	s2,32(sp)
    1084:	69e2                	ld	s3,24(sp)
    1086:	6121                	addi	sp,sp,64
    1088:	8082                	ret
    x = -xx;
    108a:	40b005bb          	negw	a1,a1
    neg = 1;
    108e:	4885                	li	a7,1
    x = -xx;
    1090:	bf8d                	j	1002 <printint+0x1a>

0000000000001092 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1092:	7119                	addi	sp,sp,-128
    1094:	fc86                	sd	ra,120(sp)
    1096:	f8a2                	sd	s0,112(sp)
    1098:	f4a6                	sd	s1,104(sp)
    109a:	f0ca                	sd	s2,96(sp)
    109c:	ecce                	sd	s3,88(sp)
    109e:	e8d2                	sd	s4,80(sp)
    10a0:	e4d6                	sd	s5,72(sp)
    10a2:	e0da                	sd	s6,64(sp)
    10a4:	fc5e                	sd	s7,56(sp)
    10a6:	f862                	sd	s8,48(sp)
    10a8:	f466                	sd	s9,40(sp)
    10aa:	f06a                	sd	s10,32(sp)
    10ac:	ec6e                	sd	s11,24(sp)
    10ae:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    10b0:	0005c903          	lbu	s2,0(a1)
    10b4:	18090f63          	beqz	s2,1252 <vprintf+0x1c0>
    10b8:	8aaa                	mv	s5,a0
    10ba:	8b32                	mv	s6,a2
    10bc:	00158493          	addi	s1,a1,1
  state = 0;
    10c0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    10c2:	02500a13          	li	s4,37
    10c6:	4c55                	li	s8,21
    10c8:	00001c97          	auipc	s9,0x1
    10cc:	b40c8c93          	addi	s9,s9,-1216 # 1c08 <malloc+0x8b2>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    10d0:	02800d93          	li	s11,40
  putc(fd, 'x');
    10d4:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10d6:	00001b97          	auipc	s7,0x1
    10da:	b8ab8b93          	addi	s7,s7,-1142 # 1c60 <digits>
    10de:	a839                	j	10fc <vprintf+0x6a>
        putc(fd, c);
    10e0:	85ca                	mv	a1,s2
    10e2:	8556                	mv	a0,s5
    10e4:	00000097          	auipc	ra,0x0
    10e8:	ee2080e7          	jalr	-286(ra) # fc6 <putc>
    10ec:	a019                	j	10f2 <vprintf+0x60>
    } else if(state == '%'){
    10ee:	01498d63          	beq	s3,s4,1108 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    10f2:	0485                	addi	s1,s1,1
    10f4:	fff4c903          	lbu	s2,-1(s1)
    10f8:	14090d63          	beqz	s2,1252 <vprintf+0x1c0>
    if(state == 0){
    10fc:	fe0999e3          	bnez	s3,10ee <vprintf+0x5c>
      if(c == '%'){
    1100:	ff4910e3          	bne	s2,s4,10e0 <vprintf+0x4e>
        state = '%';
    1104:	89d2                	mv	s3,s4
    1106:	b7f5                	j	10f2 <vprintf+0x60>
      if(c == 'd'){
    1108:	11490c63          	beq	s2,s4,1220 <vprintf+0x18e>
    110c:	f9d9079b          	addiw	a5,s2,-99
    1110:	0ff7f793          	zext.b	a5,a5
    1114:	10fc6e63          	bltu	s8,a5,1230 <vprintf+0x19e>
    1118:	f9d9079b          	addiw	a5,s2,-99
    111c:	0ff7f713          	zext.b	a4,a5
    1120:	10ec6863          	bltu	s8,a4,1230 <vprintf+0x19e>
    1124:	00271793          	slli	a5,a4,0x2
    1128:	97e6                	add	a5,a5,s9
    112a:	439c                	lw	a5,0(a5)
    112c:	97e6                	add	a5,a5,s9
    112e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1130:	008b0913          	addi	s2,s6,8
    1134:	4685                	li	a3,1
    1136:	4629                	li	a2,10
    1138:	000b2583          	lw	a1,0(s6)
    113c:	8556                	mv	a0,s5
    113e:	00000097          	auipc	ra,0x0
    1142:	eaa080e7          	jalr	-342(ra) # fe8 <printint>
    1146:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1148:	4981                	li	s3,0
    114a:	b765                	j	10f2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    114c:	008b0913          	addi	s2,s6,8
    1150:	4681                	li	a3,0
    1152:	4629                	li	a2,10
    1154:	000b2583          	lw	a1,0(s6)
    1158:	8556                	mv	a0,s5
    115a:	00000097          	auipc	ra,0x0
    115e:	e8e080e7          	jalr	-370(ra) # fe8 <printint>
    1162:	8b4a                	mv	s6,s2
      state = 0;
    1164:	4981                	li	s3,0
    1166:	b771                	j	10f2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1168:	008b0913          	addi	s2,s6,8
    116c:	4681                	li	a3,0
    116e:	866a                	mv	a2,s10
    1170:	000b2583          	lw	a1,0(s6)
    1174:	8556                	mv	a0,s5
    1176:	00000097          	auipc	ra,0x0
    117a:	e72080e7          	jalr	-398(ra) # fe8 <printint>
    117e:	8b4a                	mv	s6,s2
      state = 0;
    1180:	4981                	li	s3,0
    1182:	bf85                	j	10f2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1184:	008b0793          	addi	a5,s6,8
    1188:	f8f43423          	sd	a5,-120(s0)
    118c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1190:	03000593          	li	a1,48
    1194:	8556                	mv	a0,s5
    1196:	00000097          	auipc	ra,0x0
    119a:	e30080e7          	jalr	-464(ra) # fc6 <putc>
  putc(fd, 'x');
    119e:	07800593          	li	a1,120
    11a2:	8556                	mv	a0,s5
    11a4:	00000097          	auipc	ra,0x0
    11a8:	e22080e7          	jalr	-478(ra) # fc6 <putc>
    11ac:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    11ae:	03c9d793          	srli	a5,s3,0x3c
    11b2:	97de                	add	a5,a5,s7
    11b4:	0007c583          	lbu	a1,0(a5)
    11b8:	8556                	mv	a0,s5
    11ba:	00000097          	auipc	ra,0x0
    11be:	e0c080e7          	jalr	-500(ra) # fc6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11c2:	0992                	slli	s3,s3,0x4
    11c4:	397d                	addiw	s2,s2,-1
    11c6:	fe0914e3          	bnez	s2,11ae <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    11ca:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    11ce:	4981                	li	s3,0
    11d0:	b70d                	j	10f2 <vprintf+0x60>
        s = va_arg(ap, char*);
    11d2:	008b0913          	addi	s2,s6,8
    11d6:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    11da:	02098163          	beqz	s3,11fc <vprintf+0x16a>
        while(*s != 0){
    11de:	0009c583          	lbu	a1,0(s3)
    11e2:	c5ad                	beqz	a1,124c <vprintf+0x1ba>
          putc(fd, *s);
    11e4:	8556                	mv	a0,s5
    11e6:	00000097          	auipc	ra,0x0
    11ea:	de0080e7          	jalr	-544(ra) # fc6 <putc>
          s++;
    11ee:	0985                	addi	s3,s3,1
        while(*s != 0){
    11f0:	0009c583          	lbu	a1,0(s3)
    11f4:	f9e5                	bnez	a1,11e4 <vprintf+0x152>
        s = va_arg(ap, char*);
    11f6:	8b4a                	mv	s6,s2
      state = 0;
    11f8:	4981                	li	s3,0
    11fa:	bde5                	j	10f2 <vprintf+0x60>
          s = "(null)";
    11fc:	00001997          	auipc	s3,0x1
    1200:	a0498993          	addi	s3,s3,-1532 # 1c00 <malloc+0x8aa>
        while(*s != 0){
    1204:	85ee                	mv	a1,s11
    1206:	bff9                	j	11e4 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    1208:	008b0913          	addi	s2,s6,8
    120c:	000b4583          	lbu	a1,0(s6)
    1210:	8556                	mv	a0,s5
    1212:	00000097          	auipc	ra,0x0
    1216:	db4080e7          	jalr	-588(ra) # fc6 <putc>
    121a:	8b4a                	mv	s6,s2
      state = 0;
    121c:	4981                	li	s3,0
    121e:	bdd1                	j	10f2 <vprintf+0x60>
        putc(fd, c);
    1220:	85d2                	mv	a1,s4
    1222:	8556                	mv	a0,s5
    1224:	00000097          	auipc	ra,0x0
    1228:	da2080e7          	jalr	-606(ra) # fc6 <putc>
      state = 0;
    122c:	4981                	li	s3,0
    122e:	b5d1                	j	10f2 <vprintf+0x60>
        putc(fd, '%');
    1230:	85d2                	mv	a1,s4
    1232:	8556                	mv	a0,s5
    1234:	00000097          	auipc	ra,0x0
    1238:	d92080e7          	jalr	-622(ra) # fc6 <putc>
        putc(fd, c);
    123c:	85ca                	mv	a1,s2
    123e:	8556                	mv	a0,s5
    1240:	00000097          	auipc	ra,0x0
    1244:	d86080e7          	jalr	-634(ra) # fc6 <putc>
      state = 0;
    1248:	4981                	li	s3,0
    124a:	b565                	j	10f2 <vprintf+0x60>
        s = va_arg(ap, char*);
    124c:	8b4a                	mv	s6,s2
      state = 0;
    124e:	4981                	li	s3,0
    1250:	b54d                	j	10f2 <vprintf+0x60>
    }
  }
}
    1252:	70e6                	ld	ra,120(sp)
    1254:	7446                	ld	s0,112(sp)
    1256:	74a6                	ld	s1,104(sp)
    1258:	7906                	ld	s2,96(sp)
    125a:	69e6                	ld	s3,88(sp)
    125c:	6a46                	ld	s4,80(sp)
    125e:	6aa6                	ld	s5,72(sp)
    1260:	6b06                	ld	s6,64(sp)
    1262:	7be2                	ld	s7,56(sp)
    1264:	7c42                	ld	s8,48(sp)
    1266:	7ca2                	ld	s9,40(sp)
    1268:	7d02                	ld	s10,32(sp)
    126a:	6de2                	ld	s11,24(sp)
    126c:	6109                	addi	sp,sp,128
    126e:	8082                	ret

0000000000001270 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1270:	715d                	addi	sp,sp,-80
    1272:	ec06                	sd	ra,24(sp)
    1274:	e822                	sd	s0,16(sp)
    1276:	1000                	addi	s0,sp,32
    1278:	e010                	sd	a2,0(s0)
    127a:	e414                	sd	a3,8(s0)
    127c:	e818                	sd	a4,16(s0)
    127e:	ec1c                	sd	a5,24(s0)
    1280:	03043023          	sd	a6,32(s0)
    1284:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1288:	8622                	mv	a2,s0
    128a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    128e:	00000097          	auipc	ra,0x0
    1292:	e04080e7          	jalr	-508(ra) # 1092 <vprintf>
}
    1296:	60e2                	ld	ra,24(sp)
    1298:	6442                	ld	s0,16(sp)
    129a:	6161                	addi	sp,sp,80
    129c:	8082                	ret

000000000000129e <printf>:

void
printf(const char *fmt, ...)
{
    129e:	711d                	addi	sp,sp,-96
    12a0:	ec06                	sd	ra,24(sp)
    12a2:	e822                	sd	s0,16(sp)
    12a4:	1000                	addi	s0,sp,32
    12a6:	e40c                	sd	a1,8(s0)
    12a8:	e810                	sd	a2,16(s0)
    12aa:	ec14                	sd	a3,24(s0)
    12ac:	f018                	sd	a4,32(s0)
    12ae:	f41c                	sd	a5,40(s0)
    12b0:	03043823          	sd	a6,48(s0)
    12b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    12b8:	00840613          	addi	a2,s0,8
    12bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    12c0:	85aa                	mv	a1,a0
    12c2:	4505                	li	a0,1
    12c4:	00000097          	auipc	ra,0x0
    12c8:	dce080e7          	jalr	-562(ra) # 1092 <vprintf>
}
    12cc:	60e2                	ld	ra,24(sp)
    12ce:	6442                	ld	s0,16(sp)
    12d0:	6125                	addi	sp,sp,96
    12d2:	8082                	ret

00000000000012d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12d4:	1141                	addi	sp,sp,-16
    12d6:	e422                	sd	s0,8(sp)
    12d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    12da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12de:	00001797          	auipc	a5,0x1
    12e2:	99a7b783          	ld	a5,-1638(a5) # 1c78 <freep>
    12e6:	a02d                	j	1310 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12e8:	4618                	lw	a4,8(a2)
    12ea:	9f2d                	addw	a4,a4,a1
    12ec:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    12f0:	6398                	ld	a4,0(a5)
    12f2:	6310                	ld	a2,0(a4)
    12f4:	a83d                	j	1332 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12f6:	ff852703          	lw	a4,-8(a0)
    12fa:	9f31                	addw	a4,a4,a2
    12fc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    12fe:	ff053683          	ld	a3,-16(a0)
    1302:	a091                	j	1346 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1304:	6398                	ld	a4,0(a5)
    1306:	00e7e463          	bltu	a5,a4,130e <free+0x3a>
    130a:	00e6ea63          	bltu	a3,a4,131e <free+0x4a>
{
    130e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1310:	fed7fae3          	bgeu	a5,a3,1304 <free+0x30>
    1314:	6398                	ld	a4,0(a5)
    1316:	00e6e463          	bltu	a3,a4,131e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    131a:	fee7eae3          	bltu	a5,a4,130e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    131e:	ff852583          	lw	a1,-8(a0)
    1322:	6390                	ld	a2,0(a5)
    1324:	02059813          	slli	a6,a1,0x20
    1328:	01c85713          	srli	a4,a6,0x1c
    132c:	9736                	add	a4,a4,a3
    132e:	fae60de3          	beq	a2,a4,12e8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1332:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1336:	4790                	lw	a2,8(a5)
    1338:	02061593          	slli	a1,a2,0x20
    133c:	01c5d713          	srli	a4,a1,0x1c
    1340:	973e                	add	a4,a4,a5
    1342:	fae68ae3          	beq	a3,a4,12f6 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1346:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1348:	00001717          	auipc	a4,0x1
    134c:	92f73823          	sd	a5,-1744(a4) # 1c78 <freep>
}
    1350:	6422                	ld	s0,8(sp)
    1352:	0141                	addi	sp,sp,16
    1354:	8082                	ret

0000000000001356 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1356:	7139                	addi	sp,sp,-64
    1358:	fc06                	sd	ra,56(sp)
    135a:	f822                	sd	s0,48(sp)
    135c:	f426                	sd	s1,40(sp)
    135e:	f04a                	sd	s2,32(sp)
    1360:	ec4e                	sd	s3,24(sp)
    1362:	e852                	sd	s4,16(sp)
    1364:	e456                	sd	s5,8(sp)
    1366:	e05a                	sd	s6,0(sp)
    1368:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    136a:	02051493          	slli	s1,a0,0x20
    136e:	9081                	srli	s1,s1,0x20
    1370:	04bd                	addi	s1,s1,15
    1372:	8091                	srli	s1,s1,0x4
    1374:	00148a1b          	addiw	s4,s1,1
    1378:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    137a:	00001517          	auipc	a0,0x1
    137e:	8fe53503          	ld	a0,-1794(a0) # 1c78 <freep>
    1382:	c515                	beqz	a0,13ae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1384:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1386:	4798                	lw	a4,8(a5)
    1388:	04977163          	bgeu	a4,s1,13ca <malloc+0x74>
    138c:	89d2                	mv	s3,s4
    138e:	000a071b          	sext.w	a4,s4
    1392:	6685                	lui	a3,0x1
    1394:	00d77363          	bgeu	a4,a3,139a <malloc+0x44>
    1398:	6985                	lui	s3,0x1
    139a:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    139e:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13a2:	00001917          	auipc	s2,0x1
    13a6:	8d690913          	addi	s2,s2,-1834 # 1c78 <freep>
  if(p == (char*)-1)
    13aa:	5afd                	li	s5,-1
    13ac:	a8a5                	j	1424 <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    13ae:	00001797          	auipc	a5,0x1
    13b2:	8ca78793          	addi	a5,a5,-1846 # 1c78 <freep>
    13b6:	00001717          	auipc	a4,0x1
    13ba:	8ca70713          	addi	a4,a4,-1846 # 1c80 <base>
    13be:	e398                	sd	a4,0(a5)
    13c0:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    13c2:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13c6:	87ba                	mv	a5,a4
    13c8:	b7d1                	j	138c <malloc+0x36>
      if(p->s.size == nunits)
    13ca:	02e48c63          	beq	s1,a4,1402 <malloc+0xac>
        p->s.size -= nunits;
    13ce:	4147073b          	subw	a4,a4,s4
    13d2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13d4:	02071693          	slli	a3,a4,0x20
    13d8:	01c6d713          	srli	a4,a3,0x1c
    13dc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    13de:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    13e2:	00001717          	auipc	a4,0x1
    13e6:	88a73b23          	sd	a0,-1898(a4) # 1c78 <freep>
      return (void*)(p + 1);
    13ea:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    13ee:	70e2                	ld	ra,56(sp)
    13f0:	7442                	ld	s0,48(sp)
    13f2:	74a2                	ld	s1,40(sp)
    13f4:	7902                	ld	s2,32(sp)
    13f6:	69e2                	ld	s3,24(sp)
    13f8:	6a42                	ld	s4,16(sp)
    13fa:	6aa2                	ld	s5,8(sp)
    13fc:	6b02                	ld	s6,0(sp)
    13fe:	6121                	addi	sp,sp,64
    1400:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1402:	6398                	ld	a4,0(a5)
    1404:	e118                	sd	a4,0(a0)
    1406:	bff1                	j	13e2 <malloc+0x8c>
  hp->s.size = nu;
    1408:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    140c:	0541                	addi	a0,a0,16
    140e:	00000097          	auipc	ra,0x0
    1412:	ec6080e7          	jalr	-314(ra) # 12d4 <free>
  return freep;
    1416:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    141a:	d971                	beqz	a0,13ee <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    141c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    141e:	4798                	lw	a4,8(a5)
    1420:	fa9775e3          	bgeu	a4,s1,13ca <malloc+0x74>
    if(p == freep)
    1424:	00093703          	ld	a4,0(s2)
    1428:	853e                	mv	a0,a5
    142a:	fef719e3          	bne	a4,a5,141c <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    142e:	854e                	mv	a0,s3
    1430:	00000097          	auipc	ra,0x0
    1434:	95e080e7          	jalr	-1698(ra) # d8e <sbrk>
  if(p == (char*)-1)
    1438:	fd5518e3          	bne	a0,s5,1408 <malloc+0xb2>
        return 0;
    143c:	4501                	li	a0,0
    143e:	bf45                	j	13ee <malloc+0x98>
