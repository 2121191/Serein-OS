
serein-user/_sh：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <checkenvname>:
// u_strncpy moved to avoid conflict


int
checkenvname(char* s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
       6:	88aa                	mv	a7,a0
  if((*s >= 'A' && *s <= 'Z') ||
       8:	00054703          	lbu	a4,0(a0)
       c:	fdf77793          	andi	a5,a4,-33
      10:	fbf7879b          	addiw	a5,a5,-65
      14:	0ff7f793          	zext.b	a5,a5
      18:	46e5                	li	a3,25
      1a:	00f6f763          	bgeu	a3,a5,28 <checkenvname+0x28>
     (*s >= 'a' && *s <= 'z') ||
      1e:	05f00793          	li	a5,95
      *s == '_')
    ;
  else
    return 0;
      22:	4501                	li	a0,0
     (*s >= 'a' && *s <= 'z') ||
      24:	02f71e63          	bne	a4,a5,60 <checkenvname+0x60>
  char *tmp = s + 1;
      28:	00188713          	addi	a4,a7,1
  while((*tmp >= 'A' && *tmp <= 'Z') ||
        (*tmp >= 'a' && *tmp <= 'z') ||
        (*tmp >= '0' && *tmp <= '9') ||
      2c:	4665                	li	a2,25
        (*tmp >= 'a' && *tmp <= 'z') ||
      2e:	45a5                	li	a1,9
        (*tmp >= '0' && *tmp <= '9') ||
      30:	05f00813          	li	a6,95
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      34:	a011                	j	38 <checkenvname+0x38>
         *tmp == '_')
    tmp++;
      36:	0705                	addi	a4,a4,1
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      38:	00074683          	lbu	a3,0(a4)
        (*tmp >= '0' && *tmp <= '9') ||
      3c:	fdf6f793          	andi	a5,a3,-33
      40:	fbf7879b          	addiw	a5,a5,-65
      44:	0ff7f793          	zext.b	a5,a5
      48:	fef677e3          	bgeu	a2,a5,36 <checkenvname+0x36>
      4c:	fd06879b          	addiw	a5,a3,-48
        (*tmp >= 'a' && *tmp <= 'z') ||
      50:	0ff7f793          	zext.b	a5,a5
      54:	fef5f1e3          	bgeu	a1,a5,36 <checkenvname+0x36>
        (*tmp >= '0' && *tmp <= '9') ||
      58:	fd068fe3          	beq	a3,a6,36 <checkenvname+0x36>
  return (int)(tmp - s);
      5c:	4117053b          	subw	a0,a4,a7
}
      60:	6422                	ld	s0,8(sp)
      62:	0141                	addi	sp,sp,16
      64:	8082                	ret

0000000000000066 <export>:

int
export(char *argv[])
{
      66:	7131                	addi	sp,sp,-192
      68:	fd06                	sd	ra,184(sp)
      6a:	f922                	sd	s0,176(sp)
      6c:	f526                	sd	s1,168(sp)
      6e:	f14a                	sd	s2,160(sp)
      70:	ed4e                	sd	s3,152(sp)
      72:	e952                	sd	s4,144(sp)
      74:	e556                	sd	s5,136(sp)
      76:	e15a                	sd	s6,128(sp)
      78:	0180                	addi	s0,sp,192
      7a:	84aa                	mv	s1,a0
  if(!strcmp(argv[1], "-p"))
      7c:	00002597          	auipc	a1,0x2
      80:	31c58593          	addi	a1,a1,796 # 2398 <malloc+0xec>
      84:	6508                	ld	a0,8(a0)
      86:	00002097          	auipc	ra,0x2
      8a:	980080e7          	jalr	-1664(ra) # 1a06 <strcmp>
      8e:	e12d                	bnez	a0,f0 <export+0x8a>
      90:	89aa                	mv	s3,a0
  { // print all the env vars
    if(!nenv)
      92:	00002b17          	auipc	s6,0x2
      96:	5beb2b03          	lw	s6,1470(s6) # 2650 <nenv>
      9a:	040b0163          	beqz	s6,dc <export+0x76>
    {
      printf("NO env var exported\n");
      return 0;
    }
    for(int i=0; i<nenv; i++)
      9e:	00003497          	auipc	s1,0x3
      a2:	eca48493          	addi	s1,s1,-310 # 2f68 <envs>
      a6:	892a                	mv	s2,a0
      printf("export %s=%s\n", envs[i].name, envs[i].value);
      a8:	00002a97          	auipc	s5,0x2
      ac:	310a8a93          	addi	s5,s5,784 # 23b8 <malloc+0x10c>
    for(int i=0; i<nenv; i++)
      b0:	00002a17          	auipc	s4,0x2
      b4:	5a0a0a13          	addi	s4,s4,1440 # 2650 <nenv>
      b8:	0f605c63          	blez	s6,1b0 <export+0x14a>
      printf("export %s=%s\n", envs[i].name, envs[i].value);
      bc:	02048613          	addi	a2,s1,32
      c0:	85a6                	mv	a1,s1
      c2:	8556                	mv	a0,s5
      c4:	00002097          	auipc	ra,0x2
      c8:	130080e7          	jalr	304(ra) # 21f4 <printf>
    for(int i=0; i<nenv; i++)
      cc:	2905                	addiw	s2,s2,1
      ce:	08048493          	addi	s1,s1,128
      d2:	000a2783          	lw	a5,0(s4)
      d6:	fef943e3          	blt	s2,a5,bc <export+0x56>
      da:	a8d9                	j	1b0 <export+0x14a>
      printf("NO env var exported\n");
      dc:	00002517          	auipc	a0,0x2
      e0:	2c450513          	addi	a0,a0,708 # 23a0 <malloc+0xf4>
      e4:	00002097          	auipc	ra,0x2
      e8:	110080e7          	jalr	272(ra) # 21f4 <printf>
      return 0;
      ec:	89da                	mv	s3,s6
      ee:	a0c9                	j	1b0 <export+0x14a>
    return 0;
  }
  else if(nenv == NENVS)
      f0:	00002997          	auipc	s3,0x2
      f4:	5609a983          	lw	s3,1376(s3) # 2650 <nenv>
      f8:	47c1                	li	a5,16
      fa:	0cf98663          	beq	s3,a5,1c6 <export+0x160>
  {
    fprintf(2, "too many env vars\n");
    return -1;
  }
  char name[32], value[96];
  char *s = argv[1], *t = name;
      fe:	0084b903          	ld	s2,8(s1)

  for(s=argv[1], t=name; (*t=*s++)!='='; t++)
     102:	00190493          	addi	s1,s2,1
     106:	00094783          	lbu	a5,0(s2)
     10a:	faf40023          	sb	a5,-96(s0)
     10e:	03d00713          	li	a4,61
     112:	0ce78563          	beq	a5,a4,1dc <export+0x176>
     116:	fa040793          	addi	a5,s0,-96
     11a:	03d00693          	li	a3,61
     11e:	0785                	addi	a5,a5,1
     120:	0485                	addi	s1,s1,1
     122:	fff4c703          	lbu	a4,-1(s1)
     126:	00e78023          	sb	a4,0(a5)
     12a:	fed71ae3          	bne	a4,a3,11e <export+0xb8>
    ;
  *t = 0;
     12e:	00078023          	sb	zero,0(a5)

  if(checkenvname(name) != ((s - argv[1]) - 1))
     132:	fa040513          	addi	a0,s0,-96
     136:	00000097          	auipc	ra,0x0
     13a:	eca080e7          	jalr	-310(ra) # 0 <checkenvname>
     13e:	41248933          	sub	s2,s1,s2
     142:	197d                	addi	s2,s2,-1
     144:	09251f63          	bne	a0,s2,1e2 <export+0x17c>
  {
    fprintf(2, "Invalid NAME!\n");
    return -1;
  }
  for(t=value; (*t=*s); s++, t++)
     148:	0004c703          	lbu	a4,0(s1)
     14c:	f4e40023          	sb	a4,-192(s0)
     150:	f4040793          	addi	a5,s0,-192
     154:	cb01                	beqz	a4,164 <export+0xfe>
     156:	0485                	addi	s1,s1,1
     158:	0785                	addi	a5,a5,1
     15a:	0004c703          	lbu	a4,0(s1)
     15e:	00e78023          	sb	a4,0(a5)
     162:	fb75                	bnez	a4,156 <export+0xf0>
    ;
  if(*--t == '/')
     164:	fff7c683          	lbu	a3,-1(a5)
     168:	02f00713          	li	a4,47
     16c:	08e68663          	beq	a3,a4,1f8 <export+0x192>
    *t = 0;
  
  strcpy(envs[nenv].name, name);
     170:	00799513          	slli	a0,s3,0x7
     174:	00003917          	auipc	s2,0x3
     178:	df490913          	addi	s2,s2,-524 # 2f68 <envs>
     17c:	fa040593          	addi	a1,s0,-96
     180:	954a                	add	a0,a0,s2
     182:	00002097          	auipc	ra,0x2
     186:	83a080e7          	jalr	-1990(ra) # 19bc <strcpy>
  strcpy(envs[nenv].value, value);
     18a:	00002497          	auipc	s1,0x2
     18e:	4c648493          	addi	s1,s1,1222 # 2650 <nenv>
     192:	4088                	lw	a0,0(s1)
     194:	051e                	slli	a0,a0,0x7
     196:	02050513          	addi	a0,a0,32
     19a:	f4040593          	addi	a1,s0,-192
     19e:	954a                	add	a0,a0,s2
     1a0:	00002097          	auipc	ra,0x2
     1a4:	81c080e7          	jalr	-2020(ra) # 19bc <strcpy>
  nenv++;
     1a8:	409c                	lw	a5,0(s1)
     1aa:	2785                	addiw	a5,a5,1
     1ac:	c09c                	sw	a5,0(s1)
  return 0;
     1ae:	4981                	li	s3,0
}
     1b0:	854e                	mv	a0,s3
     1b2:	70ea                	ld	ra,184(sp)
     1b4:	744a                	ld	s0,176(sp)
     1b6:	74aa                	ld	s1,168(sp)
     1b8:	790a                	ld	s2,160(sp)
     1ba:	69ea                	ld	s3,152(sp)
     1bc:	6a4a                	ld	s4,144(sp)
     1be:	6aaa                	ld	s5,136(sp)
     1c0:	6b0a                	ld	s6,128(sp)
     1c2:	6129                	addi	sp,sp,192
     1c4:	8082                	ret
    fprintf(2, "too many env vars\n");
     1c6:	00002597          	auipc	a1,0x2
     1ca:	20258593          	addi	a1,a1,514 # 23c8 <malloc+0x11c>
     1ce:	4509                	li	a0,2
     1d0:	00002097          	auipc	ra,0x2
     1d4:	ff6080e7          	jalr	-10(ra) # 21c6 <fprintf>
    return -1;
     1d8:	59fd                	li	s3,-1
     1da:	bfd9                	j	1b0 <export+0x14a>
  for(s=argv[1], t=name; (*t=*s++)!='='; t++)
     1dc:	fa040793          	addi	a5,s0,-96
     1e0:	b7b9                	j	12e <export+0xc8>
    fprintf(2, "Invalid NAME!\n");
     1e2:	00002597          	auipc	a1,0x2
     1e6:	1fe58593          	addi	a1,a1,510 # 23e0 <malloc+0x134>
     1ea:	4509                	li	a0,2
     1ec:	00002097          	auipc	ra,0x2
     1f0:	fda080e7          	jalr	-38(ra) # 21c6 <fprintf>
    return -1;
     1f4:	59fd                	li	s3,-1
     1f6:	bf6d                	j	1b0 <export+0x14a>
    *t = 0;
     1f8:	fe078fa3          	sb	zero,-1(a5)
     1fc:	bf95                	j	170 <export+0x10a>

00000000000001fe <replace>:

int
replace(char *buf)
{
     1fe:	7111                	addi	sp,sp,-256
     200:	fd86                	sd	ra,248(sp)
     202:	f9a2                	sd	s0,240(sp)
     204:	f5a6                	sd	s1,232(sp)
     206:	f1ca                	sd	s2,224(sp)
     208:	edce                	sd	s3,216(sp)
     20a:	e9d2                	sd	s4,208(sp)
     20c:	e5d6                	sd	s5,200(sp)
     20e:	e1da                	sd	s6,192(sp)
     210:	fd5e                	sd	s7,184(sp)
     212:	f962                	sd	s8,176(sp)
     214:	f566                	sd	s9,168(sp)
     216:	f16a                	sd	s10,160(sp)
     218:	ed6e                	sd	s11,152(sp)
     21a:	0200                	addi	s0,sp,256
     21c:	89aa                	mv	s3,a0
  char raw[100], name[32], *s, *t, *tmp;
  int n = 0;
  strcpy(raw, buf);
     21e:	85aa                	mv	a1,a0
     220:	f2840513          	addi	a0,s0,-216
     224:	00001097          	auipc	ra,0x1
     228:	798080e7          	jalr	1944(ra) # 19bc <strcpy>
  for(s=raw, t=buf; (*t=*s); t++)
     22c:	f2844783          	lbu	a5,-216(s0)
     230:	00f98023          	sb	a5,0(s3)
     234:	c7f5                	beqz	a5,320 <replace+0x122>
  int n = 0;
     236:	4c81                	li	s9,0
  for(s=raw, t=buf; (*t=*s); t++)
     238:	f2840713          	addi	a4,s0,-216
  {
    if(*s++ == '$'){
     23c:	02400c13          	li	s8,36
      tmp = name;
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
     240:	4965                	li	s2,25
      {
        *tmp++ = *s++;
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     242:	4a25                	li	s4,9
     244:	05f00a93          	li	s5,95
          *tmp++ = *s++;
        *tmp = 0;
        for(int i=0; i<nenv; i++)
     248:	00002b17          	auipc	s6,0x2
     24c:	408b0b13          	addi	s6,s6,1032 # 2650 <nenv>
          if(!strcmp(name, envs[i].name))
     250:	f0840b93          	addi	s7,s0,-248
     254:	a03d                	j	282 <replace+0x84>
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
     256:	00174683          	lbu	a3,1(a4)
     25a:	fdf6f793          	andi	a5,a3,-33
     25e:	fbf7879b          	addiw	a5,a5,-65
     262:	0ff7f793          	zext.b	a5,a5
     266:	02f97563          	bgeu	s2,a5,290 <replace+0x92>
     26a:	03568363          	beq	a3,s5,290 <replace+0x92>
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
              ;
        t--;
      }
      n++;
     26e:	2c85                	addiw	s9,s9,1
     270:	86ce                	mv	a3,s3
     272:	8726                	mv	a4,s1
  for(s=raw, t=buf; (*t=*s); t++)
     274:	00168993          	addi	s3,a3,1
     278:	00074783          	lbu	a5,0(a4)
     27c:	00f680a3          	sb	a5,1(a3)
     280:	c3cd                	beqz	a5,322 <replace+0x124>
    if(*s++ == '$'){
     282:	00170493          	addi	s1,a4,1
     286:	fd8788e3          	beq	a5,s8,256 <replace+0x58>
     28a:	86ce                	mv	a3,s3
     28c:	8726                	mv	a4,s1
     28e:	b7dd                	j	274 <replace+0x76>
        *tmp++ = *s++;
     290:	00270493          	addi	s1,a4,2
     294:	f0d40423          	sb	a3,-248(s0)
     298:	f0940693          	addi	a3,s0,-247
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     29c:	a029                	j	2a6 <replace+0xa8>
          *tmp++ = *s++;
     29e:	0485                	addi	s1,s1,1
     2a0:	0685                	addi	a3,a3,1
     2a2:	fee68fa3          	sb	a4,-1(a3)
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     2a6:	0004c703          	lbu	a4,0(s1)
     2aa:	fdf77793          	andi	a5,a4,-33
     2ae:	fbf7879b          	addiw	a5,a5,-65
     2b2:	0ff7f793          	zext.b	a5,a5
     2b6:	fef974e3          	bgeu	s2,a5,29e <replace+0xa0>
     2ba:	fd07079b          	addiw	a5,a4,-48
     2be:	0ff7f793          	zext.b	a5,a5
     2c2:	fcfa7ee3          	bgeu	s4,a5,29e <replace+0xa0>
     2c6:	fd570ce3          	beq	a4,s5,29e <replace+0xa0>
        *tmp = 0;
     2ca:	00068023          	sb	zero,0(a3)
        for(int i=0; i<nenv; i++)
     2ce:	000b2783          	lw	a5,0(s6)
     2d2:	04f05563          	blez	a5,31c <replace+0x11e>
     2d6:	00003d17          	auipc	s10,0x3
     2da:	cb2d0d13          	addi	s10,s10,-846 # 2f88 <envs+0x20>
     2de:	4d81                	li	s11,0
     2e0:	a801                	j	2f0 <replace+0xf2>
     2e2:	2d85                	addiw	s11,s11,1
     2e4:	080d0d13          	addi	s10,s10,128
     2e8:	000b2783          	lw	a5,0(s6)
     2ec:	02fdd863          	bge	s11,a5,31c <replace+0x11e>
          if(!strcmp(name, envs[i].name))
     2f0:	fe0d0593          	addi	a1,s10,-32
     2f4:	855e                	mv	a0,s7
     2f6:	00001097          	auipc	ra,0x1
     2fa:	710080e7          	jalr	1808(ra) # 1a06 <strcmp>
     2fe:	f175                	bnez	a0,2e2 <replace+0xe4>
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
     300:	87ea                	mv	a5,s10
     302:	000d4703          	lbu	a4,0(s10)
     306:	00e98023          	sb	a4,0(s3)
     30a:	df61                	beqz	a4,2e2 <replace+0xe4>
     30c:	0985                	addi	s3,s3,1
     30e:	0785                	addi	a5,a5,1
     310:	0007c703          	lbu	a4,0(a5)
     314:	00e98023          	sb	a4,0(s3)
     318:	fb75                	bnez	a4,30c <replace+0x10e>
     31a:	b7e1                	j	2e2 <replace+0xe4>
        t--;
     31c:	19fd                	addi	s3,s3,-1
     31e:	bf81                	j	26e <replace+0x70>
  int n = 0;
     320:	4c81                	li	s9,0
    }
  }
  return n;
}
     322:	8566                	mv	a0,s9
     324:	70ee                	ld	ra,248(sp)
     326:	744e                	ld	s0,240(sp)
     328:	74ae                	ld	s1,232(sp)
     32a:	790e                	ld	s2,224(sp)
     32c:	69ee                	ld	s3,216(sp)
     32e:	6a4e                	ld	s4,208(sp)
     330:	6aae                	ld	s5,200(sp)
     332:	6b0e                	ld	s6,192(sp)
     334:	7bea                	ld	s7,184(sp)
     336:	7c4a                	ld	s8,176(sp)
     338:	7caa                	ld	s9,168(sp)
     33a:	7d0a                	ld	s10,160(sp)
     33c:	6dea                	ld	s11,152(sp)
     33e:	6111                	addi	sp,sp,256
     340:	8082                	ret

0000000000000342 <history_init>:
  int pos;    // Navigation position (-1 = not navigating)
} history;

void
history_init(void)
{
     342:	1141                	addi	sp,sp,-16
     344:	e422                	sd	s0,8(sp)
     346:	0800                	addi	s0,sp,16
  history.head = 0;
     348:	00003797          	auipc	a5,0x3
     34c:	41078793          	addi	a5,a5,1040 # 3758 <envs+0x7f0>
     350:	8007a023          	sw	zero,-2048(a5)
  history.tail = 0;
     354:	8007a223          	sw	zero,-2044(a5)
  history.count = 0;
     358:	8007a423          	sw	zero,-2040(a5)
  history.pos = -1;
     35c:	577d                	li	a4,-1
     35e:	80e7a623          	sw	a4,-2036(a5)
}
     362:	6422                	ld	s0,8(sp)
     364:	0141                	addi	sp,sp,16
     366:	8082                	ret

0000000000000368 <history_add>:

void
history_add(char *cmd)
{
  // Safety check: Don't add if empty
  if(cmd[0] == 0) return;
     368:	00054783          	lbu	a5,0(a0)
     36c:	cbe9                	beqz	a5,43e <history_add+0xd6>
{
     36e:	1101                	addi	sp,sp,-32
     370:	ec06                	sd	ra,24(sp)
     372:	e822                	sd	s0,16(sp)
     374:	e426                	sd	s1,8(sp)
     376:	e04a                	sd	s2,0(sp)
     378:	1000                	addi	s0,sp,32
     37a:	84aa                	mv	s1,a0
  
  // Don't duplicate the immediately previous command
  if(history.count > 0) {
     37c:	00003797          	auipc	a5,0x3
     380:	be47a783          	lw	a5,-1052(a5) # 2f60 <__global_pointer$+0x110>
     384:	02f05a63          	blez	a5,3b8 <history_add+0x50>
    int prev = (history.head - 1 + HISTORY_SIZE) % HISTORY_SIZE;
     388:	00003797          	auipc	a5,0x3
     38c:	bd07a783          	lw	a5,-1072(a5) # 2f58 <__global_pointer$+0x108>
     390:	27bd                	addiw	a5,a5,15
     392:	41f7d71b          	sraiw	a4,a5,0x1f
     396:	01c7571b          	srliw	a4,a4,0x1c
     39a:	9fb9                	addw	a5,a5,a4
     39c:	8bbd                	andi	a5,a5,15
    if(strcmp(history.commands[prev], cmd) == 0)
     39e:	9f99                	subw	a5,a5,a4
     3a0:	079e                	slli	a5,a5,0x7
     3a2:	85aa                	mv	a1,a0
     3a4:	00002517          	auipc	a0,0x2
     3a8:	3b450513          	addi	a0,a0,948 # 2758 <history>
     3ac:	953e                	add	a0,a0,a5
     3ae:	00001097          	auipc	ra,0x1
     3b2:	658080e7          	jalr	1624(ra) # 1a06 <strcmp>
     3b6:	cd29                	beqz	a0,410 <history_add+0xa8>
      return;
  }
  
  // Add to circular buffer
  strcpy(history.commands[history.head], cmd);
     3b8:	00003917          	auipc	s2,0x3
     3bc:	3a090913          	addi	s2,s2,928 # 3758 <envs+0x7f0>
     3c0:	80092783          	lw	a5,-2048(s2)
     3c4:	079e                	slli	a5,a5,0x7
     3c6:	85a6                	mv	a1,s1
     3c8:	00002517          	auipc	a0,0x2
     3cc:	39050513          	addi	a0,a0,912 # 2758 <history>
     3d0:	953e                	add	a0,a0,a5
     3d2:	00001097          	auipc	ra,0x1
     3d6:	5ea080e7          	jalr	1514(ra) # 19bc <strcpy>
  history.head = (history.head + 1) % HISTORY_SIZE;
     3da:	80092783          	lw	a5,-2048(s2)
     3de:	2785                	addiw	a5,a5,1
     3e0:	41f7d71b          	sraiw	a4,a5,0x1f
     3e4:	01c7571b          	srliw	a4,a4,0x1c
     3e8:	9fb9                	addw	a5,a5,a4
     3ea:	8bbd                	andi	a5,a5,15
     3ec:	9f99                	subw	a5,a5,a4
     3ee:	80f92023          	sw	a5,-2048(s2)
  
  if(history.count < HISTORY_SIZE) {
     3f2:	80892783          	lw	a5,-2040(s2)
     3f6:	473d                	li	a4,15
     3f8:	02f74263          	blt	a4,a5,41c <history_add+0xb4>
    history.count++;
     3fc:	2785                	addiw	a5,a5,1
     3fe:	00003717          	auipc	a4,0x3
     402:	b6f72123          	sw	a5,-1182(a4) # 2f60 <__global_pointer$+0x110>
  } else {
    history.tail = (history.tail + 1) % HISTORY_SIZE;
  }
  
  history.pos = -1; // Reset navigation
     406:	57fd                	li	a5,-1
     408:	00003717          	auipc	a4,0x3
     40c:	b4f72e23          	sw	a5,-1188(a4) # 2f64 <__global_pointer$+0x114>
}
     410:	60e2                	ld	ra,24(sp)
     412:	6442                	ld	s0,16(sp)
     414:	64a2                	ld	s1,8(sp)
     416:	6902                	ld	s2,0(sp)
     418:	6105                	addi	sp,sp,32
     41a:	8082                	ret
    history.tail = (history.tail + 1) % HISTORY_SIZE;
     41c:	00003697          	auipc	a3,0x3
     420:	33c68693          	addi	a3,a3,828 # 3758 <envs+0x7f0>
     424:	8046a783          	lw	a5,-2044(a3)
     428:	2785                	addiw	a5,a5,1
     42a:	41f7d71b          	sraiw	a4,a5,0x1f
     42e:	01c7571b          	srliw	a4,a4,0x1c
     432:	9fb9                	addw	a5,a5,a4
     434:	8bbd                	andi	a5,a5,15
     436:	9f99                	subw	a5,a5,a4
     438:	80f6a223          	sw	a5,-2044(a3)
     43c:	b7e9                	j	406 <history_add+0x9e>
     43e:	8082                	ret

0000000000000440 <history_prev>:

char*
history_prev(void)
{
     440:	1141                	addi	sp,sp,-16
     442:	e422                	sd	s0,8(sp)
     444:	0800                	addi	s0,sp,16
  if(history.count == 0) return 0;
     446:	00003797          	auipc	a5,0x3
     44a:	b1a7a783          	lw	a5,-1254(a5) # 2f60 <__global_pointer$+0x110>
     44e:	cba5                	beqz	a5,4be <history_prev+0x7e>
  
  if(history.pos == -1) {
     450:	00003797          	auipc	a5,0x3
     454:	b147a783          	lw	a5,-1260(a5) # 2f64 <__global_pointer$+0x114>
     458:	577d                	li	a4,-1
     45a:	04e78163          	beq	a5,a4,49c <history_prev+0x5c>
    // Start from newest (-1 because head points to next EMPTY slot)
    history.pos = (history.head - 1 + HISTORY_SIZE) % HISTORY_SIZE;
  } else if(history.pos != history.tail) {
     45e:	00003717          	auipc	a4,0x3
     462:	afe72703          	lw	a4,-1282(a4) # 2f5c <__global_pointer$+0x10c>
     466:	00f70e63          	beq	a4,a5,482 <history_prev+0x42>
    // Move backward until tail
    history.pos = (history.pos - 1 + HISTORY_SIZE) % HISTORY_SIZE;
     46a:	27bd                	addiw	a5,a5,15
     46c:	41f7d71b          	sraiw	a4,a5,0x1f
     470:	01c7571b          	srliw	a4,a4,0x1c
     474:	9fb9                	addw	a5,a5,a4
     476:	8bbd                	andi	a5,a5,15
     478:	9f99                	subw	a5,a5,a4
     47a:	00003717          	auipc	a4,0x3
     47e:	aef72523          	sw	a5,-1302(a4) # 2f64 <__global_pointer$+0x114>
  }
  
  return history.commands[history.pos];
     482:	00003517          	auipc	a0,0x3
     486:	ae252503          	lw	a0,-1310(a0) # 2f64 <__global_pointer$+0x114>
     48a:	051e                	slli	a0,a0,0x7
     48c:	00002797          	auipc	a5,0x2
     490:	2cc78793          	addi	a5,a5,716 # 2758 <history>
     494:	953e                	add	a0,a0,a5
}
     496:	6422                	ld	s0,8(sp)
     498:	0141                	addi	sp,sp,16
     49a:	8082                	ret
    history.pos = (history.head - 1 + HISTORY_SIZE) % HISTORY_SIZE;
     49c:	00003697          	auipc	a3,0x3
     4a0:	2bc68693          	addi	a3,a3,700 # 3758 <envs+0x7f0>
     4a4:	8006a783          	lw	a5,-2048(a3)
     4a8:	27bd                	addiw	a5,a5,15
     4aa:	41f7d71b          	sraiw	a4,a5,0x1f
     4ae:	01c7571b          	srliw	a4,a4,0x1c
     4b2:	9fb9                	addw	a5,a5,a4
     4b4:	8bbd                	andi	a5,a5,15
     4b6:	9f99                	subw	a5,a5,a4
     4b8:	80f6a623          	sw	a5,-2036(a3)
     4bc:	b7d9                	j	482 <history_prev+0x42>
  if(history.count == 0) return 0;
     4be:	4501                	li	a0,0
     4c0:	bfd9                	j	496 <history_prev+0x56>

00000000000004c2 <history_next>:

char*
history_next(void)
{
     4c2:	1141                	addi	sp,sp,-16
     4c4:	e422                	sd	s0,8(sp)
     4c6:	0800                	addi	s0,sp,16
  if(history.pos == -1) return 0; // Not navigating
     4c8:	00003797          	auipc	a5,0x3
     4cc:	a9c7a783          	lw	a5,-1380(a5) # 2f64 <__global_pointer$+0x114>
     4d0:	577d                	li	a4,-1
     4d2:	04e78963          	beq	a5,a4,524 <history_next+0x62>
  
  int next = (history.pos + 1) % HISTORY_SIZE;
     4d6:	2785                	addiw	a5,a5,1
     4d8:	41f7d71b          	sraiw	a4,a5,0x1f
     4dc:	01c7571b          	srliw	a4,a4,0x1c
     4e0:	9fb9                	addw	a5,a5,a4
     4e2:	8bbd                	andi	a5,a5,15
     4e4:	9f99                	subw	a5,a5,a4
     4e6:	0007851b          	sext.w	a0,a5
  if(next == history.head) {
     4ea:	00003717          	auipc	a4,0x3
     4ee:	a6e72703          	lw	a4,-1426(a4) # 2f58 <__global_pointer$+0x108>
     4f2:	00a70f63          	beq	a4,a0,510 <history_next+0x4e>
    // Moved past latest command -> back to empty input line
    history.pos = -1;
    return ""; 
  }
  
  history.pos = next;
     4f6:	00003717          	auipc	a4,0x3
     4fa:	a6f72723          	sw	a5,-1426(a4) # 2f64 <__global_pointer$+0x114>
  return history.commands[history.pos];
     4fe:	051e                	slli	a0,a0,0x7
     500:	00002797          	auipc	a5,0x2
     504:	25878793          	addi	a5,a5,600 # 2758 <history>
     508:	953e                	add	a0,a0,a5
}
     50a:	6422                	ld	s0,8(sp)
     50c:	0141                	addi	sp,sp,16
     50e:	8082                	ret
    history.pos = -1;
     510:	57fd                	li	a5,-1
     512:	00003717          	auipc	a4,0x3
     516:	a4f72923          	sw	a5,-1454(a4) # 2f64 <__global_pointer$+0x114>
    return ""; 
     51a:	00002517          	auipc	a0,0x2
     51e:	06650513          	addi	a0,a0,102 # 2580 <malloc+0x2d4>
     522:	b7e5                	j	50a <history_next+0x48>
  if(history.pos == -1) return 0; // Not navigating
     524:	4501                	li	a0,0
     526:	b7d5                	j	50a <history_next+0x48>

0000000000000528 <u_strncpy>:

// V3.1: Helper for strncpy
char*
u_strncpy(char *s, const char *t, int n)
{
     528:	1141                	addi	sp,sp,-16
     52a:	e422                	sd	s0,8(sp)
     52c:	0800                	addi	s0,sp,16
  char *os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
     52e:	872a                	mv	a4,a0
     530:	8832                	mv	a6,a2
     532:	367d                	addiw	a2,a2,-1
     534:	01005963          	blez	a6,546 <u_strncpy+0x1e>
     538:	0705                	addi	a4,a4,1
     53a:	0005c783          	lbu	a5,0(a1)
     53e:	fef70fa3          	sb	a5,-1(a4)
     542:	0585                	addi	a1,a1,1
     544:	f7f5                	bnez	a5,530 <u_strncpy+0x8>
    ;
  while(n-- > 0)
     546:	86ba                	mv	a3,a4
     548:	00c05c63          	blez	a2,560 <u_strncpy+0x38>
    *s++ = 0;
     54c:	0685                	addi	a3,a3,1
     54e:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
     552:	40d707bb          	subw	a5,a4,a3
     556:	37fd                	addiw	a5,a5,-1
     558:	010787bb          	addw	a5,a5,a6
     55c:	fef048e3          	bgtz	a5,54c <u_strncpy+0x24>
  return os;
}
     560:	6422                	ld	s0,8(sp)
     562:	0141                	addi	sp,sp,16
     564:	8082                	ret

0000000000000566 <completion>:
#define MAX_MATCHES 16
#define MAX_NAME_LEN 32

void
completion(char *buf, int *idx)
{
     566:	d4010113          	addi	sp,sp,-704
     56a:	2a113c23          	sd	ra,696(sp)
     56e:	2a813823          	sd	s0,688(sp)
     572:	2a913423          	sd	s1,680(sp)
     576:	2b213023          	sd	s2,672(sp)
     57a:	29313c23          	sd	s3,664(sp)
     57e:	29413823          	sd	s4,656(sp)
     582:	29513423          	sd	s5,648(sp)
     586:	29613023          	sd	s6,640(sp)
     58a:	27713c23          	sd	s7,632(sp)
     58e:	27813823          	sd	s8,624(sp)
     592:	27913423          	sd	s9,616(sp)
     596:	27a13023          	sd	s10,608(sp)
     59a:	25b13c23          	sd	s11,600(sp)
     59e:	0580                	addi	s0,sp,704
     5a0:	892a                	mv	s2,a0
     5a2:	8aae                	mv	s5,a1
  char *prefix = buf;
  int prefix_len = *idx;
     5a4:	0005ab03          	lw	s6,0(a1)
  int fd;
  struct stat st;
  
  // Find the start of the last word
  int i;
  for(i = *idx - 1; i >= 0; i--) {
     5a8:	fffb049b          	addiw	s1,s6,-1
     5ac:	0604c763          	bltz	s1,61a <completion+0xb4>
    if(buf[i] == ' ') {
     5b0:	02000693          	li	a3,32
     5b4:	0004871b          	sext.w	a4,s1
     5b8:	009907b3          	add	a5,s2,s1
     5bc:	0007c783          	lbu	a5,0(a5)
     5c0:	00d78963          	beq	a5,a3,5d2 <completion+0x6c>
  for(i = *idx - 1; i >= 0; i--) {
     5c4:	14fd                	addi	s1,s1,-1
     5c6:	0004879b          	sext.w	a5,s1
     5ca:	fe07d5e3          	bgez	a5,5b4 <completion+0x4e>
  char *prefix = buf;
     5ce:	84ca                	mv	s1,s2
     5d0:	a031                	j	5dc <completion+0x76>
      prefix = buf + i + 1;
     5d2:	0485                	addi	s1,s1,1
     5d4:	94ca                	add	s1,s1,s2
      prefix_len = *idx - (i + 1);
     5d6:	2705                	addiw	a4,a4,1
     5d8:	40eb0b3b          	subw	s6,s6,a4
      break;
    }
  }
  
  if(prefix_len == 0) return; // Nothing to complete
     5dc:	040b1163          	bnez	s6,61e <completion+0xb8>
    for(int m=0; m<match_count; m++) {
      fprintf(2, "%s  ", matches[m]);
    }
    fprintf(2, "\n-> %s $ %s", mycwd, buf);
  }
}
     5e0:	2b813083          	ld	ra,696(sp)
     5e4:	2b013403          	ld	s0,688(sp)
     5e8:	2a813483          	ld	s1,680(sp)
     5ec:	2a013903          	ld	s2,672(sp)
     5f0:	29813983          	ld	s3,664(sp)
     5f4:	29013a03          	ld	s4,656(sp)
     5f8:	28813a83          	ld	s5,648(sp)
     5fc:	28013b03          	ld	s6,640(sp)
     600:	27813b83          	ld	s7,632(sp)
     604:	27013c03          	ld	s8,624(sp)
     608:	26813c83          	ld	s9,616(sp)
     60c:	26013d03          	ld	s10,608(sp)
     610:	25813d83          	ld	s11,600(sp)
     614:	2c010113          	addi	sp,sp,704
     618:	8082                	ret
  char *prefix = buf;
     61a:	84aa                	mv	s1,a0
     61c:	b7c1                	j	5dc <completion+0x76>
  if((fd = open(".", 0)) < 0){
     61e:	4581                	li	a1,0
     620:	00002517          	auipc	a0,0x2
     624:	dd050513          	addi	a0,a0,-560 # 23f0 <malloc+0x144>
     628:	00001097          	auipc	ra,0x1
     62c:	68c080e7          	jalr	1676(ra) # 1cb4 <open>
     630:	8baa                	mv	s7,a0
     632:	fa0547e3          	bltz	a0,5e0 <completion+0x7a>
  int match_count = 0;
     636:	4a01                	li	s4,0
  while(readdir(fd, &st) == 1 && match_count < MAX_MATCHES){
     638:	f5040c13          	addi	s8,s0,-176
     63c:	4c85                	li	s9,1
     63e:	4d3d                	li	s10,15
      memset(matches[match_count], 0, MAX_NAME_LEN);
     640:	d5040793          	addi	a5,s0,-688
     644:	d4f43423          	sd	a5,-696(s0)
     648:	fffb079b          	addiw	a5,s6,-1
     64c:	1782                	slli	a5,a5,0x20
     64e:	9381                	srli	a5,a5,0x20
     650:	f5140993          	addi	s3,s0,-175
     654:	99be                	add	s3,s3,a5
  while(readdir(fd, &st) == 1 && match_count < MAX_MATCHES){
     656:	85e2                	mv	a1,s8
     658:	855e                	mv	a0,s7
     65a:	00001097          	auipc	ra,0x1
     65e:	6b2080e7          	jalr	1714(ra) # 1d0c <readdir>
     662:	05951c63          	bne	a0,s9,6ba <completion+0x154>
     666:	054d4a63          	blt	s10,s4,6ba <completion+0x154>
    if(st.name[0] == 0) continue;
     66a:	f5044783          	lbu	a5,-176(s0)
     66e:	d7e5                	beqz	a5,656 <completion+0xf0>
    for(int j=0; j<prefix_len; j++) {
     670:	01605f63          	blez	s6,68e <completion+0x128>
     674:	f5040793          	addi	a5,s0,-176
     678:	8726                	mv	a4,s1
      if(st.name[j] != prefix[j]) {
     67a:	0007c603          	lbu	a2,0(a5)
     67e:	00074683          	lbu	a3,0(a4)
     682:	fcd61ae3          	bne	a2,a3,656 <completion+0xf0>
    for(int j=0; j<prefix_len; j++) {
     686:	0785                	addi	a5,a5,1
     688:	0705                	addi	a4,a4,1
     68a:	ff3798e3          	bne	a5,s3,67a <completion+0x114>
      memset(matches[match_count], 0, MAX_NAME_LEN);
     68e:	005a1d93          	slli	s11,s4,0x5
     692:	d4843783          	ld	a5,-696(s0)
     696:	9dbe                	add	s11,s11,a5
     698:	02000613          	li	a2,32
     69c:	4581                	li	a1,0
     69e:	856e                	mv	a0,s11
     6a0:	00001097          	auipc	ra,0x1
     6a4:	3bc080e7          	jalr	956(ra) # 1a5c <memset>
      u_strncpy(matches[match_count], st.name, MAX_NAME_LEN-1);
     6a8:	467d                	li	a2,31
     6aa:	85e2                	mv	a1,s8
     6ac:	856e                	mv	a0,s11
     6ae:	00000097          	auipc	ra,0x0
     6b2:	e7a080e7          	jalr	-390(ra) # 528 <u_strncpy>
      match_count++;
     6b6:	2a05                	addiw	s4,s4,1
     6b8:	bf79                	j	656 <completion+0xf0>
  close(fd);
     6ba:	855e                	mv	a0,s7
     6bc:	00001097          	auipc	ra,0x1
     6c0:	5e0080e7          	jalr	1504(ra) # 1c9c <close>
  if(match_count == 0) {
     6c4:	f00a0ee3          	beqz	s4,5e0 <completion+0x7a>
  if(match_count == 1) {
     6c8:	4785                	li	a5,1
     6ca:	02fa0863          	beq	s4,a5,6fa <completion+0x194>
    int common_len = strlen(matches[0]);
     6ce:	d5040513          	addi	a0,s0,-688
     6d2:	00001097          	auipc	ra,0x1
     6d6:	360080e7          	jalr	864(ra) # 1a32 <strlen>
     6da:	2501                	sext.w	a0,a0
    for(int m=1; m<match_count; m++) {
     6dc:	4785                	li	a5,1
     6de:	0b47d763          	bge	a5,s4,78c <completion+0x226>
     6e2:	ffea081b          	addiw	a6,s4,-2
     6e6:	02081793          	slli	a5,a6,0x20
     6ea:	01b7d813          	srli	a6,a5,0x1b
     6ee:	04080813          	addi	a6,a6,64
     6f2:	02000593          	li	a1,32
      int k = 0;
     6f6:	4881                	li	a7,0
     6f8:	a0b5                	j	764 <completion+0x1fe>
    int name_len = strlen(matches[0]);
     6fa:	d5040513          	addi	a0,s0,-688
     6fe:	00001097          	auipc	ra,0x1
     702:	334080e7          	jalr	820(ra) # 1a32 <strlen>
    int extra_len = name_len - prefix_len;
     706:	416507bb          	subw	a5,a0,s6
     70a:	0007871b          	sext.w	a4,a5
    if(extra_len > 0) {
     70e:	ece059e3          	blez	a4,5e0 <completion+0x7a>
      for(int k=0; k<extra_len; k++) {
     712:	d5040493          	addi	s1,s0,-688
     716:	94da                	add	s1,s1,s6
     718:	d5140993          	addi	s3,s0,-687
     71c:	99da                	add	s3,s3,s6
     71e:	37fd                	addiw	a5,a5,-1
     720:	1782                	slli	a5,a5,0x20
     722:	9381                	srli	a5,a5,0x20
     724:	99be                	add	s3,s3,a5
        fprintf(2, "%c", append[k]);
     726:	00002a17          	auipc	s4,0x2
     72a:	cd2a0a13          	addi	s4,s4,-814 # 23f8 <malloc+0x14c>
        buf[*idx] = append[k];
     72e:	0004c603          	lbu	a2,0(s1)
     732:	000aa783          	lw	a5,0(s5)
     736:	97ca                	add	a5,a5,s2
     738:	00c78023          	sb	a2,0(a5)
        fprintf(2, "%c", append[k]);
     73c:	85d2                	mv	a1,s4
     73e:	4509                	li	a0,2
     740:	00002097          	auipc	ra,0x2
     744:	a86080e7          	jalr	-1402(ra) # 21c6 <fprintf>
        (*idx)++;
     748:	000aa783          	lw	a5,0(s5)
     74c:	2785                	addiw	a5,a5,1
     74e:	00faa023          	sw	a5,0(s5)
      for(int k=0; k<extra_len; k++) {
     752:	0485                	addi	s1,s1,1
     754:	fd349de3          	bne	s1,s3,72e <completion+0x1c8>
     758:	b561                	j	5e0 <completion+0x7a>
     75a:	8536                	mv	a0,a3
    for(int m=1; m<match_count; m++) {
     75c:	02058593          	addi	a1,a1,32
     760:	03058663          	beq	a1,a6,78c <completion+0x226>
      while(k < common_len && matches[0][k] == matches[m][k]) {
     764:	02a05263          	blez	a0,788 <completion+0x222>
     768:	d5040713          	addi	a4,s0,-688
      int k = 0;
     76c:	86c6                	mv	a3,a7
      while(k < common_len && matches[0][k] == matches[m][k]) {
     76e:	00b707b3          	add	a5,a4,a1
     772:	00074603          	lbu	a2,0(a4)
     776:	0007c783          	lbu	a5,0(a5)
     77a:	fef610e3          	bne	a2,a5,75a <completion+0x1f4>
        k++;
     77e:	2685                	addiw	a3,a3,1
      while(k < common_len && matches[0][k] == matches[m][k]) {
     780:	0705                	addi	a4,a4,1
     782:	fea696e3          	bne	a3,a0,76e <completion+0x208>
     786:	bfd9                	j	75c <completion+0x1f6>
      int k = 0;
     788:	8546                	mv	a0,a7
     78a:	bfc9                	j	75c <completion+0x1f6>
    int extra_len = common_len - prefix_len;
     78c:	4165053b          	subw	a0,a0,s6
     790:	0005079b          	sext.w	a5,a0
    if(extra_len > 0) {
     794:	04f05663          	blez	a5,7e0 <completion+0x27a>
      for(int k=0; k<extra_len; k++) {
     798:	d5040493          	addi	s1,s0,-688
     79c:	94da                	add	s1,s1,s6
     79e:	d5140993          	addi	s3,s0,-687
     7a2:	99da                	add	s3,s3,s6
     7a4:	357d                	addiw	a0,a0,-1
     7a6:	02051793          	slli	a5,a0,0x20
     7aa:	9381                	srli	a5,a5,0x20
     7ac:	99be                	add	s3,s3,a5
        fprintf(2, "%c", append[k]);
     7ae:	00002b17          	auipc	s6,0x2
     7b2:	c4ab0b13          	addi	s6,s6,-950 # 23f8 <malloc+0x14c>
        buf[*idx] = append[k];
     7b6:	0004c603          	lbu	a2,0(s1)
     7ba:	000aa783          	lw	a5,0(s5)
     7be:	97ca                	add	a5,a5,s2
     7c0:	00c78023          	sb	a2,0(a5)
        fprintf(2, "%c", append[k]);
     7c4:	85da                	mv	a1,s6
     7c6:	4509                	li	a0,2
     7c8:	00002097          	auipc	ra,0x2
     7cc:	9fe080e7          	jalr	-1538(ra) # 21c6 <fprintf>
        (*idx)++;
     7d0:	000aa783          	lw	a5,0(s5)
     7d4:	2785                	addiw	a5,a5,1
     7d6:	00faa023          	sw	a5,0(s5)
      for(int k=0; k<extra_len; k++) {
     7da:	0485                	addi	s1,s1,1
     7dc:	fd349de3          	bne	s1,s3,7b6 <completion+0x250>
    fprintf(2, "\n");
     7e0:	00002597          	auipc	a1,0x2
     7e4:	c2058593          	addi	a1,a1,-992 # 2400 <malloc+0x154>
     7e8:	4509                	li	a0,2
     7ea:	00002097          	auipc	ra,0x2
     7ee:	9dc080e7          	jalr	-1572(ra) # 21c6 <fprintf>
    for(int m=0; m<match_count; m++) {
     7f2:	03405c63          	blez	s4,82a <completion+0x2c4>
     7f6:	d5040993          	addi	s3,s0,-688
     7fa:	fffa049b          	addiw	s1,s4,-1
     7fe:	02049793          	slli	a5,s1,0x20
     802:	01b7d493          	srli	s1,a5,0x1b
     806:	d7040793          	addi	a5,s0,-656
     80a:	94be                	add	s1,s1,a5
      fprintf(2, "%s  ", matches[m]);
     80c:	00002a17          	auipc	s4,0x2
     810:	bfca0a13          	addi	s4,s4,-1028 # 2408 <malloc+0x15c>
     814:	864e                	mv	a2,s3
     816:	85d2                	mv	a1,s4
     818:	4509                	li	a0,2
     81a:	00002097          	auipc	ra,0x2
     81e:	9ac080e7          	jalr	-1620(ra) # 21c6 <fprintf>
    for(int m=0; m<match_count; m++) {
     822:	02098993          	addi	s3,s3,32
     826:	fe9997e3          	bne	s3,s1,814 <completion+0x2ae>
    fprintf(2, "\n-> %s $ %s", mycwd, buf);
     82a:	86ca                	mv	a3,s2
     82c:	00002617          	auipc	a2,0x2
     830:	e2c60613          	addi	a2,a2,-468 # 2658 <mycwd>
     834:	00002597          	auipc	a1,0x2
     838:	bdc58593          	addi	a1,a1,-1060 # 2410 <malloc+0x164>
     83c:	4509                	li	a0,2
     83e:	00002097          	auipc	ra,0x2
     842:	988080e7          	jalr	-1656(ra) # 21c6 <fprintf>
     846:	bb69                	j	5e0 <completion+0x7a>

0000000000000848 <getcmd>:

int
getcmd(char *buf, int nbuf)
{
     848:	7175                	addi	sp,sp,-144
     84a:	e506                	sd	ra,136(sp)
     84c:	e122                	sd	s0,128(sp)
     84e:	fca6                	sd	s1,120(sp)
     850:	f8ca                	sd	s2,112(sp)
     852:	f4ce                	sd	s3,104(sp)
     854:	f0d2                	sd	s4,96(sp)
     856:	ecd6                	sd	s5,88(sp)
     858:	e8da                	sd	s6,80(sp)
     85a:	e4de                	sd	s7,72(sp)
     85c:	e0e2                	sd	s8,64(sp)
     85e:	fc66                	sd	s9,56(sp)
     860:	f86a                	sd	s10,48(sp)
     862:	f46e                	sd	s11,40(sp)
     864:	0900                	addi	s0,sp,144
     866:	8a2a                	mv	s4,a0
     868:	8cae                	mv	s9,a1
  fprintf(2, "-> %s $ ", mycwd);
     86a:	00002617          	auipc	a2,0x2
     86e:	dee60613          	addi	a2,a2,-530 # 2658 <mycwd>
     872:	00002597          	auipc	a1,0x2
     876:	bae58593          	addi	a1,a1,-1106 # 2420 <malloc+0x174>
     87a:	4509                	li	a0,2
     87c:	00002097          	auipc	ra,0x2
     880:	94a080e7          	jalr	-1718(ra) # 21c6 <fprintf>
  memset(buf, 0, nbuf);
     884:	000c879b          	sext.w	a5,s9
     888:	f6f43823          	sd	a5,-144(s0)
     88c:	863e                	mv	a2,a5
     88e:	4581                	li	a1,0
     890:	8552                	mv	a0,s4
     892:	00001097          	auipc	ra,0x1
     896:	1ca080e7          	jalr	458(ra) # 1a5c <memset>
  
  int len = 0; // Current length of the command
     89a:	f8042623          	sw	zero,-116(s0)
  int pos = 0; // Current cursor position (0 to len)
     89e:	4481                	li	s1,0
  char c;
  
  while(1){
    if(read(0, &c, 1) != 1) { // EOF
     8a0:	f8b40a93          	addi	s5,s0,-117
      if(len > 0) return 0; // Return partial line if any
      return -1;
    }
    
    // Tab Completion
    if(c == '\t') {
     8a4:	4b25                	li	s6,9
      pos = len; // Tab completion always moves to end
      continue;
    }

    // Ctrl+L: Clear Screen
    if(c == 0x0C) {
     8a6:	4bb1                	li	s7,12
      for(i=len; i>pos; i--) fprintf(2, "\b");
      continue;
    }

    // Backspace Handling (0x7f)
    if(c == '\x7f' || c == BACKSPACE) {
     8a8:	07f00c13          	li	s8,127
      if(len > 0) history_add(buf);
      return 0;
    }
    
    // Normal Character Insertion
    if(len < nbuf - 1){
     8ac:	3cfd                	addiw	s9,s9,-1
      completion(buf, &len);
     8ae:	f8c40d93          	addi	s11,s0,-116
     8b2:	a065                	j	95a <getcmd+0x112>
      if(len > 0) return 0; // Return partial line if any
     8b4:	f8c42503          	lw	a0,-116(s0)
     8b8:	00152513          	slti	a0,a0,1
     8bc:	40a0053b          	negw	a0,a0
     8c0:	2501                	sext.w	a0,a0
           for(i=len; i>pos; i--) fprintf(2, "\b");
        }
      }
    }
  }
}
     8c2:	60aa                	ld	ra,136(sp)
     8c4:	640a                	ld	s0,128(sp)
     8c6:	74e6                	ld	s1,120(sp)
     8c8:	7946                	ld	s2,112(sp)
     8ca:	79a6                	ld	s3,104(sp)
     8cc:	7a06                	ld	s4,96(sp)
     8ce:	6ae6                	ld	s5,88(sp)
     8d0:	6b46                	ld	s6,80(sp)
     8d2:	6ba6                	ld	s7,72(sp)
     8d4:	6c06                	ld	s8,64(sp)
     8d6:	7ce2                	ld	s9,56(sp)
     8d8:	7d42                	ld	s10,48(sp)
     8da:	7da2                	ld	s11,40(sp)
     8dc:	6149                	addi	sp,sp,144
     8de:	8082                	ret
      completion(buf, &len);
     8e0:	85ee                	mv	a1,s11
     8e2:	8552                	mv	a0,s4
     8e4:	00000097          	auipc	ra,0x0
     8e8:	c82080e7          	jalr	-894(ra) # 566 <completion>
      pos = len; // Tab completion always moves to end
     8ec:	f8c42483          	lw	s1,-116(s0)
      continue;
     8f0:	a0ad                	j	95a <getcmd+0x112>
      fprintf(2, "\x1b[2J\x1b[H"); 
     8f2:	00002597          	auipc	a1,0x2
     8f6:	b3e58593          	addi	a1,a1,-1218 # 2430 <malloc+0x184>
     8fa:	4509                	li	a0,2
     8fc:	00002097          	auipc	ra,0x2
     900:	8ca080e7          	jalr	-1846(ra) # 21c6 <fprintf>
      fprintf(2, "-> %s $ ", mycwd);
     904:	00002617          	auipc	a2,0x2
     908:	d5460613          	addi	a2,a2,-684 # 2658 <mycwd>
     90c:	00002597          	auipc	a1,0x2
     910:	b1458593          	addi	a1,a1,-1260 # 2420 <malloc+0x174>
     914:	4509                	li	a0,2
     916:	00002097          	auipc	ra,0x2
     91a:	8b0080e7          	jalr	-1872(ra) # 21c6 <fprintf>
      fprintf(2, "%s", buf);
     91e:	8652                	mv	a2,s4
     920:	00002597          	auipc	a1,0x2
     924:	b1858593          	addi	a1,a1,-1256 # 2438 <malloc+0x18c>
     928:	4509                	li	a0,2
     92a:	00002097          	auipc	ra,0x2
     92e:	89c080e7          	jalr	-1892(ra) # 21c6 <fprintf>
      for(i=len; i>pos; i--) fprintf(2, "\b");
     932:	f8c42903          	lw	s2,-116(s0)
     936:	0324d263          	bge	s1,s2,95a <getcmd+0x112>
     93a:	00002997          	auipc	s3,0x2
     93e:	b0698993          	addi	s3,s3,-1274 # 2440 <malloc+0x194>
     942:	85ce                	mv	a1,s3
     944:	4509                	li	a0,2
     946:	00002097          	auipc	ra,0x2
     94a:	880080e7          	jalr	-1920(ra) # 21c6 <fprintf>
     94e:	397d                	addiw	s2,s2,-1
     950:	ff2499e3          	bne	s1,s2,942 <getcmd+0xfa>
     954:	a019                	j	95a <getcmd+0x112>
      if(pos > 0) {
     956:	08904363          	bgtz	s1,9dc <getcmd+0x194>
    if(read(0, &c, 1) != 1) { // EOF
     95a:	4605                	li	a2,1
     95c:	85d6                	mv	a1,s5
     95e:	4501                	li	a0,0
     960:	00001097          	auipc	ra,0x1
     964:	32c080e7          	jalr	812(ra) # 1c8c <read>
     968:	4785                	li	a5,1
     96a:	f4f515e3          	bne	a0,a5,8b4 <getcmd+0x6c>
    if(c == '\t') {
     96e:	f8b44783          	lbu	a5,-117(s0)
     972:	f76787e3          	beq	a5,s6,8e0 <getcmd+0x98>
    if(c == 0x0C) {
     976:	f7778ee3          	beq	a5,s7,8f2 <getcmd+0xaa>
    if(c == '\x7f' || c == BACKSPACE) {
     97a:	fd878ee3          	beq	a5,s8,956 <getcmd+0x10e>
     97e:	4721                	li	a4,8
     980:	fce78be3          	beq	a5,a4,956 <getcmd+0x10e>
    if(c == (char)KEY_UP || c == (char)KEY_DOWN || c == (char)KEY_LEFT || c == (char)KEY_RIGHT) {
     984:	01e7871b          	addiw	a4,a5,30
     988:	0ff77713          	zext.b	a4,a4
     98c:	4685                	li	a3,1
     98e:	14e6f063          	bgeu	a3,a4,ace <getcmd+0x286>
     992:	0e000713          	li	a4,224
     996:	0ee78c63          	beq	a5,a4,a8e <getcmd+0x246>
     99a:	0e100713          	li	a4,225
     99e:	10e78563          	beq	a5,a4,aa8 <getcmd+0x260>
    if(c == '\n' || c == '\r'){
     9a2:	4729                	li	a4,10
     9a4:	1ee78863          	beq	a5,a4,b94 <getcmd+0x34c>
     9a8:	4735                	li	a4,13
     9aa:	1ee78563          	beq	a5,a4,b94 <getcmd+0x34c>
    if(len < nbuf - 1){
     9ae:	f8c42703          	lw	a4,-116(s0)
     9b2:	fb9754e3          	bge	a4,s9,95a <getcmd+0x112>
      if((unsigned char)c >= 32) {
     9b6:	46fd                	li	a3,31
     9b8:	faf6f1e3          	bgeu	a3,a5,95a <getcmd+0x112>
        if(pos < len) {
     9bc:	24e4c263          	blt	s1,a4,c00 <getcmd+0x3b8>
        buf[pos] = c;
     9c0:	009a06b3          	add	a3,s4,s1
     9c4:	00f68023          	sb	a5,0(a3)
        len++;
     9c8:	2705                	addiw	a4,a4,1
     9ca:	0007079b          	sext.w	a5,a4
     9ce:	f8e42623          	sw	a4,-116(s0)
        pos++;
     9d2:	2485                	addiw	s1,s1,1
        buf[len] = 0;
     9d4:	97d2                	add	a5,a5,s4
     9d6:	00078023          	sb	zero,0(a5)
        if(pos < len) {
     9da:	b741                	j	95a <getcmd+0x112>
        len--;
     9dc:	f8c42703          	lw	a4,-116(s0)
     9e0:	fff7079b          	addiw	a5,a4,-1
     9e4:	0007891b          	sext.w	s2,a5
     9e8:	f8f42623          	sw	a5,-116(s0)
        pos--;
     9ec:	fff48d1b          	addiw	s10,s1,-1
        for(i=pos; i<len; i++) buf[i] = buf[i+1];
     9f0:	28e4d463          	bge	s1,a4,c78 <getcmd+0x430>
     9f4:	01aa07b3          	add	a5,s4,s10
     9f8:	f6f43c23          	sd	a5,-136(s0)
     9fc:	0004899b          	sext.w	s3,s1
     a00:	377d                	addiw	a4,a4,-1
     a02:	9f05                	subw	a4,a4,s1
     a04:	1702                	slli	a4,a4,0x20
     a06:	9301                	srli	a4,a4,0x20
     a08:	94d2                	add	s1,s1,s4
     a0a:	9726                	add	a4,a4,s1
     a0c:	0017c683          	lbu	a3,1(a5)
     a10:	00d78023          	sb	a3,0(a5)
     a14:	0785                	addi	a5,a5,1
     a16:	fee79be3          	bne	a5,a4,a0c <getcmd+0x1c4>
        buf[len] = 0;
     a1a:	012a07b3          	add	a5,s4,s2
     a1e:	00078023          	sb	zero,0(a5)
        fprintf(2, "\b"); // Move back to pos
     a22:	00002597          	auipc	a1,0x2
     a26:	a1e58593          	addi	a1,a1,-1506 # 2440 <malloc+0x194>
     a2a:	4509                	li	a0,2
     a2c:	00001097          	auipc	ra,0x1
     a30:	79a080e7          	jalr	1946(ra) # 21c6 <fprintf>
        fprintf(2, "%s", buf+pos); // Print tail
     a34:	f7843603          	ld	a2,-136(s0)
     a38:	00002597          	auipc	a1,0x2
     a3c:	a0058593          	addi	a1,a1,-1536 # 2438 <malloc+0x18c>
     a40:	4509                	li	a0,2
     a42:	00001097          	auipc	ra,0x1
     a46:	784080e7          	jalr	1924(ra) # 21c6 <fprintf>
        fprintf(2, " "); // Erase last char
     a4a:	00002597          	auipc	a1,0x2
     a4e:	9fe58593          	addi	a1,a1,-1538 # 2448 <malloc+0x19c>
     a52:	4509                	li	a0,2
     a54:	00001097          	auipc	ra,0x1
     a58:	772080e7          	jalr	1906(ra) # 21c6 <fprintf>
        fprintf(2, "\b"); // Move back one step
     a5c:	00002597          	auipc	a1,0x2
     a60:	9e458593          	addi	a1,a1,-1564 # 2440 <malloc+0x194>
     a64:	4509                	li	a0,2
     a66:	00001097          	auipc	ra,0x1
     a6a:	760080e7          	jalr	1888(ra) # 21c6 <fprintf>
        for(i=len; i>pos; i--) fprintf(2, "\b");
     a6e:	39fd                	addiw	s3,s3,-1
     a70:	00002497          	auipc	s1,0x2
     a74:	9d048493          	addi	s1,s1,-1584 # 2440 <malloc+0x194>
     a78:	85a6                	mv	a1,s1
     a7a:	4509                	li	a0,2
     a7c:	00001097          	auipc	ra,0x1
     a80:	74a080e7          	jalr	1866(ra) # 21c6 <fprintf>
     a84:	397d                	addiw	s2,s2,-1
     a86:	ff2999e3          	bne	s3,s2,a78 <getcmd+0x230>
        pos--;
     a8a:	84ea                	mv	s1,s10
     a8c:	b5f9                	j	95a <getcmd+0x112>
        if(pos > 0) {
     a8e:	ec9056e3          	blez	s1,95a <getcmd+0x112>
          pos--;
     a92:	34fd                	addiw	s1,s1,-1
          fprintf(2, "\b");
     a94:	00002597          	auipc	a1,0x2
     a98:	9ac58593          	addi	a1,a1,-1620 # 2440 <malloc+0x194>
     a9c:	4509                	li	a0,2
     a9e:	00001097          	auipc	ra,0x1
     aa2:	728080e7          	jalr	1832(ra) # 21c6 <fprintf>
     aa6:	bd55                	j	95a <getcmd+0x112>
        if(pos < len) {
     aa8:	f8c42783          	lw	a5,-116(s0)
     aac:	eaf4d7e3          	bge	s1,a5,95a <getcmd+0x112>
          fprintf(2, "%c", buf[pos]);
     ab0:	009a07b3          	add	a5,s4,s1
     ab4:	0007c603          	lbu	a2,0(a5)
     ab8:	00002597          	auipc	a1,0x2
     abc:	94058593          	addi	a1,a1,-1728 # 23f8 <malloc+0x14c>
     ac0:	4509                	li	a0,2
     ac2:	00001097          	auipc	ra,0x1
     ac6:	704080e7          	jalr	1796(ra) # 21c6 <fprintf>
          pos++;
     aca:	2485                	addiw	s1,s1,1
     acc:	b579                	j	95a <getcmd+0x112>
        if(c == (char)KEY_UP) {
     ace:	0e200713          	li	a4,226
     ad2:	0ae78b63          	beq	a5,a4,b88 <getcmd+0x340>
          hist_cmd = history_next();
     ad6:	00000097          	auipc	ra,0x0
     ada:	9ec080e7          	jalr	-1556(ra) # 4c2 <history_next>
     ade:	892a                	mv	s2,a0
        if(hist_cmd) {
     ae0:	e6090de3          	beqz	s2,95a <getcmd+0x112>
          for(i=0; i<pos; i++) fprintf(2, "\b");
     ae4:	02905063          	blez	s1,b04 <getcmd+0x2bc>
     ae8:	4981                	li	s3,0
     aea:	00002d17          	auipc	s10,0x2
     aee:	956d0d13          	addi	s10,s10,-1706 # 2440 <malloc+0x194>
     af2:	85ea                	mv	a1,s10
     af4:	4509                	li	a0,2
     af6:	00001097          	auipc	ra,0x1
     afa:	6d0080e7          	jalr	1744(ra) # 21c6 <fprintf>
     afe:	2985                	addiw	s3,s3,1
     b00:	ff3499e3          	bne	s1,s3,af2 <getcmd+0x2aa>
          for(i=0; i<len; i++) fprintf(2, " ");
     b04:	f8c42983          	lw	s3,-116(s0)
     b08:	03305e63          	blez	s3,b44 <getcmd+0x2fc>
     b0c:	4481                	li	s1,0
     b0e:	00002d17          	auipc	s10,0x2
     b12:	93ad0d13          	addi	s10,s10,-1734 # 2448 <malloc+0x19c>
     b16:	85ea                	mv	a1,s10
     b18:	4509                	li	a0,2
     b1a:	00001097          	auipc	ra,0x1
     b1e:	6ac080e7          	jalr	1708(ra) # 21c6 <fprintf>
     b22:	2485                	addiw	s1,s1,1
     b24:	ff3499e3          	bne	s1,s3,b16 <getcmd+0x2ce>
     b28:	4481                	li	s1,0
          for(i=0; i<len; i++) fprintf(2, "\b");
     b2a:	00002d17          	auipc	s10,0x2
     b2e:	916d0d13          	addi	s10,s10,-1770 # 2440 <malloc+0x194>
     b32:	85ea                	mv	a1,s10
     b34:	4509                	li	a0,2
     b36:	00001097          	auipc	ra,0x1
     b3a:	690080e7          	jalr	1680(ra) # 21c6 <fprintf>
     b3e:	2485                	addiw	s1,s1,1
     b40:	ff3499e3          	bne	s1,s3,b32 <getcmd+0x2ea>
          memset(buf, 0, nbuf);
     b44:	f7043603          	ld	a2,-144(s0)
     b48:	4581                	li	a1,0
     b4a:	8552                	mv	a0,s4
     b4c:	00001097          	auipc	ra,0x1
     b50:	f10080e7          	jalr	-240(ra) # 1a5c <memset>
          strcpy(buf, hist_cmd);
     b54:	85ca                	mv	a1,s2
     b56:	8552                	mv	a0,s4
     b58:	00001097          	auipc	ra,0x1
     b5c:	e64080e7          	jalr	-412(ra) # 19bc <strcpy>
          len = strlen(buf);
     b60:	8552                	mv	a0,s4
     b62:	00001097          	auipc	ra,0x1
     b66:	ed0080e7          	jalr	-304(ra) # 1a32 <strlen>
     b6a:	0005049b          	sext.w	s1,a0
     b6e:	f8942623          	sw	s1,-116(s0)
          fprintf(2, "%s", buf);
     b72:	8652                	mv	a2,s4
     b74:	00002597          	auipc	a1,0x2
     b78:	8c458593          	addi	a1,a1,-1852 # 2438 <malloc+0x18c>
     b7c:	4509                	li	a0,2
     b7e:	00001097          	auipc	ra,0x1
     b82:	648080e7          	jalr	1608(ra) # 21c6 <fprintf>
     b86:	bbd1                	j	95a <getcmd+0x112>
          hist_cmd = history_prev();
     b88:	00000097          	auipc	ra,0x0
     b8c:	8b8080e7          	jalr	-1864(ra) # 440 <history_prev>
     b90:	892a                	mv	s2,a0
     b92:	b7b9                	j	ae0 <getcmd+0x298>
      buf[len] = 0;
     b94:	f8c42a83          	lw	s5,-116(s0)
     b98:	015a07b3          	add	a5,s4,s5
     b9c:	00078023          	sb	zero,0(a5)
      for(i=pos; i<len; i++) fprintf(2, "%c", buf[i]); // Actually just newline is enough usually, but to be clean
     ba0:	0354dd63          	bge	s1,s5,bda <getcmd+0x392>
     ba4:	009a0933          	add	s2,s4,s1
     ba8:	001a0793          	addi	a5,s4,1
     bac:	97a6                	add	a5,a5,s1
     bae:	fffa871b          	addiw	a4,s5,-1
     bb2:	9f05                	subw	a4,a4,s1
     bb4:	1702                	slli	a4,a4,0x20
     bb6:	9301                	srli	a4,a4,0x20
     bb8:	00e784b3          	add	s1,a5,a4
     bbc:	00002997          	auipc	s3,0x2
     bc0:	83c98993          	addi	s3,s3,-1988 # 23f8 <malloc+0x14c>
     bc4:	00094603          	lbu	a2,0(s2)
     bc8:	85ce                	mv	a1,s3
     bca:	4509                	li	a0,2
     bcc:	00001097          	auipc	ra,0x1
     bd0:	5fa080e7          	jalr	1530(ra) # 21c6 <fprintf>
     bd4:	0905                	addi	s2,s2,1
     bd6:	ff2497e3          	bne	s1,s2,bc4 <getcmd+0x37c>
      fprintf(2, "\n");
     bda:	00002597          	auipc	a1,0x2
     bde:	82658593          	addi	a1,a1,-2010 # 2400 <malloc+0x154>
     be2:	4509                	li	a0,2
     be4:	00001097          	auipc	ra,0x1
     be8:	5e2080e7          	jalr	1506(ra) # 21c6 <fprintf>
      return 0;
     bec:	4501                	li	a0,0
      if(len > 0) history_add(buf);
     bee:	cd505ae3          	blez	s5,8c2 <getcmd+0x7a>
     bf2:	8552                	mv	a0,s4
     bf4:	fffff097          	auipc	ra,0xfffff
     bf8:	774080e7          	jalr	1908(ra) # 368 <history_add>
      return 0;
     bfc:	4501                	li	a0,0
     bfe:	b1d1                	j	8c2 <getcmd+0x7a>
     c00:	00ea06b3          	add	a3,s4,a4
     c04:	0004899b          	sext.w	s3,s1
     c08:	fff70593          	addi	a1,a4,-1
     c0c:	95d2                	add	a1,a1,s4
     c0e:	fff7061b          	addiw	a2,a4,-1
     c12:	9e05                	subw	a2,a2,s1
     c14:	1602                	slli	a2,a2,0x20
     c16:	9201                	srli	a2,a2,0x20
     c18:	8d91                	sub	a1,a1,a2
          for(i=len; i>pos; i--) buf[i] = buf[i-1];
     c1a:	fff6c603          	lbu	a2,-1(a3)
     c1e:	00c68023          	sb	a2,0(a3)
     c22:	16fd                	addi	a3,a3,-1
     c24:	feb69be3          	bne	a3,a1,c1a <getcmd+0x3d2>
        buf[pos] = c;
     c28:	009a06b3          	add	a3,s4,s1
     c2c:	00f68023          	sb	a5,0(a3)
        len++;
     c30:	2705                	addiw	a4,a4,1
     c32:	0007091b          	sext.w	s2,a4
     c36:	f8e42623          	sw	a4,-116(s0)
        pos++;
     c3a:	2485                	addiw	s1,s1,1
        buf[len] = 0;
     c3c:	012a07b3          	add	a5,s4,s2
     c40:	00078023          	sb	zero,0(a5)
           fprintf(2, "%s", buf+pos);
     c44:	009a0633          	add	a2,s4,s1
     c48:	00001597          	auipc	a1,0x1
     c4c:	7f058593          	addi	a1,a1,2032 # 2438 <malloc+0x18c>
     c50:	4509                	li	a0,2
     c52:	00001097          	auipc	ra,0x1
     c56:	574080e7          	jalr	1396(ra) # 21c6 <fprintf>
           for(i=len; i>pos; i--) fprintf(2, "\b");
     c5a:	2985                	addiw	s3,s3,1
     c5c:	00001d17          	auipc	s10,0x1
     c60:	7e4d0d13          	addi	s10,s10,2020 # 2440 <malloc+0x194>
     c64:	85ea                	mv	a1,s10
     c66:	4509                	li	a0,2
     c68:	00001097          	auipc	ra,0x1
     c6c:	55e080e7          	jalr	1374(ra) # 21c6 <fprintf>
     c70:	397d                	addiw	s2,s2,-1
     c72:	ff3919e3          	bne	s2,s3,c64 <getcmd+0x41c>
     c76:	b1d5                	j	95a <getcmd+0x112>
        buf[len] = 0;
     c78:	9952                	add	s2,s2,s4
     c7a:	00090023          	sb	zero,0(s2)
        fprintf(2, "\b"); // Move back to pos
     c7e:	00001597          	auipc	a1,0x1
     c82:	7c258593          	addi	a1,a1,1986 # 2440 <malloc+0x194>
     c86:	4509                	li	a0,2
     c88:	00001097          	auipc	ra,0x1
     c8c:	53e080e7          	jalr	1342(ra) # 21c6 <fprintf>
        fprintf(2, "%s", buf+pos); // Print tail
     c90:	01aa0633          	add	a2,s4,s10
     c94:	00001597          	auipc	a1,0x1
     c98:	7a458593          	addi	a1,a1,1956 # 2438 <malloc+0x18c>
     c9c:	4509                	li	a0,2
     c9e:	00001097          	auipc	ra,0x1
     ca2:	528080e7          	jalr	1320(ra) # 21c6 <fprintf>
        fprintf(2, " "); // Erase last char
     ca6:	00001597          	auipc	a1,0x1
     caa:	7a258593          	addi	a1,a1,1954 # 2448 <malloc+0x19c>
     cae:	4509                	li	a0,2
     cb0:	00001097          	auipc	ra,0x1
     cb4:	516080e7          	jalr	1302(ra) # 21c6 <fprintf>
        fprintf(2, "\b"); // Move back one step
     cb8:	00001597          	auipc	a1,0x1
     cbc:	78858593          	addi	a1,a1,1928 # 2440 <malloc+0x194>
     cc0:	4509                	li	a0,2
     cc2:	00001097          	auipc	ra,0x1
     cc6:	504080e7          	jalr	1284(ra) # 21c6 <fprintf>
        pos--;
     cca:	84ea                	mv	s1,s10
     ccc:	b179                	j	95a <getcmd+0x112>

0000000000000cce <panic>:
  exit(0);
}

void
panic(char *s)
{
     cce:	1141                	addi	sp,sp,-16
     cd0:	e406                	sd	ra,8(sp)
     cd2:	e022                	sd	s0,0(sp)
     cd4:	0800                	addi	s0,sp,16
     cd6:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
     cd8:	00001597          	auipc	a1,0x1
     cdc:	77858593          	addi	a1,a1,1912 # 2450 <malloc+0x1a4>
     ce0:	4509                	li	a0,2
     ce2:	00001097          	auipc	ra,0x1
     ce6:	4e4080e7          	jalr	1252(ra) # 21c6 <fprintf>
  exit(1);
     cea:	4505                	li	a0,1
     cec:	00001097          	auipc	ra,0x1
     cf0:	f88080e7          	jalr	-120(ra) # 1c74 <exit>

0000000000000cf4 <fork1>:
}

int
fork1(void)
{
     cf4:	1141                	addi	sp,sp,-16
     cf6:	e406                	sd	ra,8(sp)
     cf8:	e022                	sd	s0,0(sp)
     cfa:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
     cfc:	00001097          	auipc	ra,0x1
     d00:	f70080e7          	jalr	-144(ra) # 1c6c <fork>
  if(pid == -1)
     d04:	57fd                	li	a5,-1
     d06:	00f50663          	beq	a0,a5,d12 <fork1+0x1e>
    panic("fork");
  return pid;
}
     d0a:	60a2                	ld	ra,8(sp)
     d0c:	6402                	ld	s0,0(sp)
     d0e:	0141                	addi	sp,sp,16
     d10:	8082                	ret
    panic("fork");
     d12:	00001517          	auipc	a0,0x1
     d16:	74650513          	addi	a0,a0,1862 # 2458 <malloc+0x1ac>
     d1a:	00000097          	auipc	ra,0x0
     d1e:	fb4080e7          	jalr	-76(ra) # cce <panic>

0000000000000d22 <runcmd>:
{
     d22:	7135                	addi	sp,sp,-160
     d24:	ed06                	sd	ra,152(sp)
     d26:	e922                	sd	s0,144(sp)
     d28:	e526                	sd	s1,136(sp)
     d2a:	e14a                	sd	s2,128(sp)
     d2c:	fcce                	sd	s3,120(sp)
     d2e:	f8d2                	sd	s4,112(sp)
     d30:	f4d6                	sd	s5,104(sp)
     d32:	f0da                	sd	s6,96(sp)
     d34:	ecde                	sd	s7,88(sp)
     d36:	1100                	addi	s0,sp,160
  if(cmd == 0)
     d38:	c10d                	beqz	a0,d5a <runcmd+0x38>
     d3a:	84aa                	mv	s1,a0
  switch(cmd->type){
     d3c:	4118                	lw	a4,0(a0)
     d3e:	4795                	li	a5,5
     d40:	02e7e263          	bltu	a5,a4,d64 <runcmd+0x42>
     d44:	00056783          	lwu	a5,0(a0)
     d48:	078a                	slli	a5,a5,0x2
     d4a:	00002717          	auipc	a4,0x2
     d4e:	84e70713          	addi	a4,a4,-1970 # 2598 <malloc+0x2ec>
     d52:	97ba                	add	a5,a5,a4
     d54:	439c                	lw	a5,0(a5)
     d56:	97ba                	add	a5,a5,a4
     d58:	8782                	jr	a5
    exit(1);
     d5a:	4505                	li	a0,1
     d5c:	00001097          	auipc	ra,0x1
     d60:	f18080e7          	jalr	-232(ra) # 1c74 <exit>
    panic("runcmd");
     d64:	00001517          	auipc	a0,0x1
     d68:	6fc50513          	addi	a0,a0,1788 # 2460 <malloc+0x1b4>
     d6c:	00000097          	auipc	ra,0x0
     d70:	f62080e7          	jalr	-158(ra) # cce <panic>
    if(ecmd->argv[0] == 0)
     d74:	6508                	ld	a0,8(a0)
     d76:	c155                	beqz	a0,e1a <runcmd+0xf8>
    exec(ecmd->argv[0], ecmd->argv);
     d78:	00848a13          	addi	s4,s1,8
     d7c:	85d2                	mv	a1,s4
     d7e:	00001097          	auipc	ra,0x1
     d82:	f2e080e7          	jalr	-210(ra) # 1cac <exec>
    for(i=0; i<nenv; i++)
     d86:	00002797          	auipc	a5,0x2
     d8a:	8ca7a783          	lw	a5,-1846(a5) # 2650 <nenv>
     d8e:	06f05763          	blez	a5,dfc <runcmd+0xda>
     d92:	00002917          	auipc	s2,0x2
     d96:	1f790913          	addi	s2,s2,503 # 2f89 <envs+0x21>
     d9a:	4981                	li	s3,0
      *s_tmp++ = '/';
     d9c:	02f00b93          	li	s7,47
      exec(env_cmd, ecmd->argv);
     da0:	f6840b13          	addi	s6,s0,-152
    for(i=0; i<nenv; i++)
     da4:	00002a97          	auipc	s5,0x2
     da8:	8aca8a93          	addi	s5,s5,-1876 # 2650 <nenv>
      while((*s_tmp = *d_tmp++))
     dac:	874a                	mv	a4,s2
     dae:	fff94783          	lbu	a5,-1(s2)
     db2:	f6f40423          	sb	a5,-152(s0)
     db6:	c7bd                	beqz	a5,e24 <runcmd+0x102>
      char *s_tmp = env_cmd;
     db8:	f6840793          	addi	a5,s0,-152
        s_tmp++;
     dbc:	0785                	addi	a5,a5,1
      while((*s_tmp = *d_tmp++))
     dbe:	0705                	addi	a4,a4,1
     dc0:	fff74683          	lbu	a3,-1(a4)
     dc4:	00d78023          	sb	a3,0(a5)
     dc8:	faf5                	bnez	a3,dbc <runcmd+0x9a>
      *s_tmp++ = '/';
     dca:	00178713          	addi	a4,a5,1
     dce:	01778023          	sb	s7,0(a5)
      d_tmp = ecmd->argv[0];
     dd2:	649c                	ld	a5,8(s1)
      while((*s_tmp++ = *d_tmp++))
     dd4:	0785                	addi	a5,a5,1
     dd6:	0705                	addi	a4,a4,1
     dd8:	fff7c683          	lbu	a3,-1(a5)
     ddc:	fed70fa3          	sb	a3,-1(a4)
     de0:	faf5                	bnez	a3,dd4 <runcmd+0xb2>
      exec(env_cmd, ecmd->argv);
     de2:	85d2                	mv	a1,s4
     de4:	855a                	mv	a0,s6
     de6:	00001097          	auipc	ra,0x1
     dea:	ec6080e7          	jalr	-314(ra) # 1cac <exec>
    for(i=0; i<nenv; i++)
     dee:	2985                	addiw	s3,s3,1
     df0:	08090913          	addi	s2,s2,128
     df4:	000aa783          	lw	a5,0(s5)
     df8:	faf9cae3          	blt	s3,a5,dac <runcmd+0x8a>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     dfc:	6490                	ld	a2,8(s1)
     dfe:	00001597          	auipc	a1,0x1
     e02:	66a58593          	addi	a1,a1,1642 # 2468 <malloc+0x1bc>
     e06:	4509                	li	a0,2
     e08:	00001097          	auipc	ra,0x1
     e0c:	3be080e7          	jalr	958(ra) # 21c6 <fprintf>
  exit(0);
     e10:	4501                	li	a0,0
     e12:	00001097          	auipc	ra,0x1
     e16:	e62080e7          	jalr	-414(ra) # 1c74 <exit>
      exit(1);
     e1a:	4505                	li	a0,1
     e1c:	00001097          	auipc	ra,0x1
     e20:	e58080e7          	jalr	-424(ra) # 1c74 <exit>
      char *s_tmp = env_cmd;
     e24:	f6840793          	addi	a5,s0,-152
     e28:	b74d                	j	dca <runcmd+0xa8>
    close(rcmd->fd);
     e2a:	5148                	lw	a0,36(a0)
     e2c:	00001097          	auipc	ra,0x1
     e30:	e70080e7          	jalr	-400(ra) # 1c9c <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     e34:	508c                	lw	a1,32(s1)
     e36:	6888                	ld	a0,16(s1)
     e38:	00001097          	auipc	ra,0x1
     e3c:	e7c080e7          	jalr	-388(ra) # 1cb4 <open>
     e40:	00054763          	bltz	a0,e4e <runcmd+0x12c>
    runcmd(rcmd->cmd);
     e44:	6488                	ld	a0,8(s1)
     e46:	00000097          	auipc	ra,0x0
     e4a:	edc080e7          	jalr	-292(ra) # d22 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     e4e:	6890                	ld	a2,16(s1)
     e50:	00001597          	auipc	a1,0x1
     e54:	62858593          	addi	a1,a1,1576 # 2478 <malloc+0x1cc>
     e58:	4509                	li	a0,2
     e5a:	00001097          	auipc	ra,0x1
     e5e:	36c080e7          	jalr	876(ra) # 21c6 <fprintf>
      exit(1);
     e62:	4505                	li	a0,1
     e64:	00001097          	auipc	ra,0x1
     e68:	e10080e7          	jalr	-496(ra) # 1c74 <exit>
    if(fork1() == 0)
     e6c:	00000097          	auipc	ra,0x0
     e70:	e88080e7          	jalr	-376(ra) # cf4 <fork1>
     e74:	c919                	beqz	a0,e8a <runcmd+0x168>
    wait(0);
     e76:	4501                	li	a0,0
     e78:	00001097          	auipc	ra,0x1
     e7c:	e04080e7          	jalr	-508(ra) # 1c7c <wait>
    runcmd(lcmd->right);
     e80:	6888                	ld	a0,16(s1)
     e82:	00000097          	auipc	ra,0x0
     e86:	ea0080e7          	jalr	-352(ra) # d22 <runcmd>
      runcmd(lcmd->left);
     e8a:	6488                	ld	a0,8(s1)
     e8c:	00000097          	auipc	ra,0x0
     e90:	e96080e7          	jalr	-362(ra) # d22 <runcmd>
    if(pipe(p) < 0)
     e94:	fa840513          	addi	a0,s0,-88
     e98:	00001097          	auipc	ra,0x1
     e9c:	dec080e7          	jalr	-532(ra) # 1c84 <pipe>
     ea0:	04054363          	bltz	a0,ee6 <runcmd+0x1c4>
    if(fork1() == 0){
     ea4:	00000097          	auipc	ra,0x0
     ea8:	e50080e7          	jalr	-432(ra) # cf4 <fork1>
     eac:	c529                	beqz	a0,ef6 <runcmd+0x1d4>
    if(fork1() == 0){
     eae:	00000097          	auipc	ra,0x0
     eb2:	e46080e7          	jalr	-442(ra) # cf4 <fork1>
     eb6:	cd25                	beqz	a0,f2e <runcmd+0x20c>
    close(p[0]);
     eb8:	fa842503          	lw	a0,-88(s0)
     ebc:	00001097          	auipc	ra,0x1
     ec0:	de0080e7          	jalr	-544(ra) # 1c9c <close>
    close(p[1]);
     ec4:	fac42503          	lw	a0,-84(s0)
     ec8:	00001097          	auipc	ra,0x1
     ecc:	dd4080e7          	jalr	-556(ra) # 1c9c <close>
    wait(0);
     ed0:	4501                	li	a0,0
     ed2:	00001097          	auipc	ra,0x1
     ed6:	daa080e7          	jalr	-598(ra) # 1c7c <wait>
    wait(0);
     eda:	4501                	li	a0,0
     edc:	00001097          	auipc	ra,0x1
     ee0:	da0080e7          	jalr	-608(ra) # 1c7c <wait>
    break;
     ee4:	b735                	j	e10 <runcmd+0xee>
      panic("pipe");
     ee6:	00001517          	auipc	a0,0x1
     eea:	5a250513          	addi	a0,a0,1442 # 2488 <malloc+0x1dc>
     eee:	00000097          	auipc	ra,0x0
     ef2:	de0080e7          	jalr	-544(ra) # cce <panic>
      close(1);
     ef6:	4505                	li	a0,1
     ef8:	00001097          	auipc	ra,0x1
     efc:	da4080e7          	jalr	-604(ra) # 1c9c <close>
      dup(p[1]);
     f00:	fac42503          	lw	a0,-84(s0)
     f04:	00001097          	auipc	ra,0x1
     f08:	dd0080e7          	jalr	-560(ra) # 1cd4 <dup>
      close(p[0]);
     f0c:	fa842503          	lw	a0,-88(s0)
     f10:	00001097          	auipc	ra,0x1
     f14:	d8c080e7          	jalr	-628(ra) # 1c9c <close>
      close(p[1]);
     f18:	fac42503          	lw	a0,-84(s0)
     f1c:	00001097          	auipc	ra,0x1
     f20:	d80080e7          	jalr	-640(ra) # 1c9c <close>
      runcmd(pcmd->left);
     f24:	6488                	ld	a0,8(s1)
     f26:	00000097          	auipc	ra,0x0
     f2a:	dfc080e7          	jalr	-516(ra) # d22 <runcmd>
      close(0);
     f2e:	00001097          	auipc	ra,0x1
     f32:	d6e080e7          	jalr	-658(ra) # 1c9c <close>
      dup(p[0]);
     f36:	fa842503          	lw	a0,-88(s0)
     f3a:	00001097          	auipc	ra,0x1
     f3e:	d9a080e7          	jalr	-614(ra) # 1cd4 <dup>
      close(p[0]);
     f42:	fa842503          	lw	a0,-88(s0)
     f46:	00001097          	auipc	ra,0x1
     f4a:	d56080e7          	jalr	-682(ra) # 1c9c <close>
      close(p[1]);
     f4e:	fac42503          	lw	a0,-84(s0)
     f52:	00001097          	auipc	ra,0x1
     f56:	d4a080e7          	jalr	-694(ra) # 1c9c <close>
      runcmd(pcmd->right);
     f5a:	6888                	ld	a0,16(s1)
     f5c:	00000097          	auipc	ra,0x0
     f60:	dc6080e7          	jalr	-570(ra) # d22 <runcmd>
    if(fork1() == 0)
     f64:	00000097          	auipc	ra,0x0
     f68:	d90080e7          	jalr	-624(ra) # cf4 <fork1>
     f6c:	ea0512e3          	bnez	a0,e10 <runcmd+0xee>
      runcmd(bcmd->cmd);
     f70:	6488                	ld	a0,8(s1)
     f72:	00000097          	auipc	ra,0x0
     f76:	db0080e7          	jalr	-592(ra) # d22 <runcmd>

0000000000000f7a <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     f7a:	1101                	addi	sp,sp,-32
     f7c:	ec06                	sd	ra,24(sp)
     f7e:	e822                	sd	s0,16(sp)
     f80:	e426                	sd	s1,8(sp)
     f82:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     f84:	0a800513          	li	a0,168
     f88:	00001097          	auipc	ra,0x1
     f8c:	324080e7          	jalr	804(ra) # 22ac <malloc>
     f90:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     f92:	0a800613          	li	a2,168
     f96:	4581                	li	a1,0
     f98:	00001097          	auipc	ra,0x1
     f9c:	ac4080e7          	jalr	-1340(ra) # 1a5c <memset>
  cmd->type = EXEC;
     fa0:	4785                	li	a5,1
     fa2:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     fa4:	8526                	mv	a0,s1
     fa6:	60e2                	ld	ra,24(sp)
     fa8:	6442                	ld	s0,16(sp)
     faa:	64a2                	ld	s1,8(sp)
     fac:	6105                	addi	sp,sp,32
     fae:	8082                	ret

0000000000000fb0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     fb0:	7139                	addi	sp,sp,-64
     fb2:	fc06                	sd	ra,56(sp)
     fb4:	f822                	sd	s0,48(sp)
     fb6:	f426                	sd	s1,40(sp)
     fb8:	f04a                	sd	s2,32(sp)
     fba:	ec4e                	sd	s3,24(sp)
     fbc:	e852                	sd	s4,16(sp)
     fbe:	e456                	sd	s5,8(sp)
     fc0:	e05a                	sd	s6,0(sp)
     fc2:	0080                	addi	s0,sp,64
     fc4:	8b2a                	mv	s6,a0
     fc6:	8aae                	mv	s5,a1
     fc8:	8a32                	mv	s4,a2
     fca:	89b6                	mv	s3,a3
     fcc:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     fce:	02800513          	li	a0,40
     fd2:	00001097          	auipc	ra,0x1
     fd6:	2da080e7          	jalr	730(ra) # 22ac <malloc>
     fda:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     fdc:	02800613          	li	a2,40
     fe0:	4581                	li	a1,0
     fe2:	00001097          	auipc	ra,0x1
     fe6:	a7a080e7          	jalr	-1414(ra) # 1a5c <memset>
  cmd->type = REDIR;
     fea:	4789                	li	a5,2
     fec:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     fee:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     ff2:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     ff6:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     ffa:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     ffe:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
    1002:	8526                	mv	a0,s1
    1004:	70e2                	ld	ra,56(sp)
    1006:	7442                	ld	s0,48(sp)
    1008:	74a2                	ld	s1,40(sp)
    100a:	7902                	ld	s2,32(sp)
    100c:	69e2                	ld	s3,24(sp)
    100e:	6a42                	ld	s4,16(sp)
    1010:	6aa2                	ld	s5,8(sp)
    1012:	6b02                	ld	s6,0(sp)
    1014:	6121                	addi	sp,sp,64
    1016:	8082                	ret

0000000000001018 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    1018:	7179                	addi	sp,sp,-48
    101a:	f406                	sd	ra,40(sp)
    101c:	f022                	sd	s0,32(sp)
    101e:	ec26                	sd	s1,24(sp)
    1020:	e84a                	sd	s2,16(sp)
    1022:	e44e                	sd	s3,8(sp)
    1024:	1800                	addi	s0,sp,48
    1026:	89aa                	mv	s3,a0
    1028:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    102a:	4561                	li	a0,24
    102c:	00001097          	auipc	ra,0x1
    1030:	280080e7          	jalr	640(ra) # 22ac <malloc>
    1034:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    1036:	4661                	li	a2,24
    1038:	4581                	li	a1,0
    103a:	00001097          	auipc	ra,0x1
    103e:	a22080e7          	jalr	-1502(ra) # 1a5c <memset>
  cmd->type = PIPE;
    1042:	478d                	li	a5,3
    1044:	c09c                	sw	a5,0(s1)
  cmd->left = left;
    1046:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
    104a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
    104e:	8526                	mv	a0,s1
    1050:	70a2                	ld	ra,40(sp)
    1052:	7402                	ld	s0,32(sp)
    1054:	64e2                	ld	s1,24(sp)
    1056:	6942                	ld	s2,16(sp)
    1058:	69a2                	ld	s3,8(sp)
    105a:	6145                	addi	sp,sp,48
    105c:	8082                	ret

000000000000105e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    105e:	7179                	addi	sp,sp,-48
    1060:	f406                	sd	ra,40(sp)
    1062:	f022                	sd	s0,32(sp)
    1064:	ec26                	sd	s1,24(sp)
    1066:	e84a                	sd	s2,16(sp)
    1068:	e44e                	sd	s3,8(sp)
    106a:	1800                	addi	s0,sp,48
    106c:	89aa                	mv	s3,a0
    106e:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1070:	4561                	li	a0,24
    1072:	00001097          	auipc	ra,0x1
    1076:	23a080e7          	jalr	570(ra) # 22ac <malloc>
    107a:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    107c:	4661                	li	a2,24
    107e:	4581                	li	a1,0
    1080:	00001097          	auipc	ra,0x1
    1084:	9dc080e7          	jalr	-1572(ra) # 1a5c <memset>
  cmd->type = LIST;
    1088:	4791                	li	a5,4
    108a:	c09c                	sw	a5,0(s1)
  cmd->left = left;
    108c:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
    1090:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
    1094:	8526                	mv	a0,s1
    1096:	70a2                	ld	ra,40(sp)
    1098:	7402                	ld	s0,32(sp)
    109a:	64e2                	ld	s1,24(sp)
    109c:	6942                	ld	s2,16(sp)
    109e:	69a2                	ld	s3,8(sp)
    10a0:	6145                	addi	sp,sp,48
    10a2:	8082                	ret

00000000000010a4 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
    10a4:	1101                	addi	sp,sp,-32
    10a6:	ec06                	sd	ra,24(sp)
    10a8:	e822                	sd	s0,16(sp)
    10aa:	e426                	sd	s1,8(sp)
    10ac:	e04a                	sd	s2,0(sp)
    10ae:	1000                	addi	s0,sp,32
    10b0:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    10b2:	4541                	li	a0,16
    10b4:	00001097          	auipc	ra,0x1
    10b8:	1f8080e7          	jalr	504(ra) # 22ac <malloc>
    10bc:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    10be:	4641                	li	a2,16
    10c0:	4581                	li	a1,0
    10c2:	00001097          	auipc	ra,0x1
    10c6:	99a080e7          	jalr	-1638(ra) # 1a5c <memset>
  cmd->type = BACK;
    10ca:	4795                	li	a5,5
    10cc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
    10ce:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
    10d2:	8526                	mv	a0,s1
    10d4:	60e2                	ld	ra,24(sp)
    10d6:	6442                	ld	s0,16(sp)
    10d8:	64a2                	ld	s1,8(sp)
    10da:	6902                	ld	s2,0(sp)
    10dc:	6105                	addi	sp,sp,32
    10de:	8082                	ret

00000000000010e0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    10e0:	7139                	addi	sp,sp,-64
    10e2:	fc06                	sd	ra,56(sp)
    10e4:	f822                	sd	s0,48(sp)
    10e6:	f426                	sd	s1,40(sp)
    10e8:	f04a                	sd	s2,32(sp)
    10ea:	ec4e                	sd	s3,24(sp)
    10ec:	e852                	sd	s4,16(sp)
    10ee:	e456                	sd	s5,8(sp)
    10f0:	e05a                	sd	s6,0(sp)
    10f2:	0080                	addi	s0,sp,64
    10f4:	8a2a                	mv	s4,a0
    10f6:	892e                	mv	s2,a1
    10f8:	8ab2                	mv	s5,a2
    10fa:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
    10fc:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
    10fe:	00001997          	auipc	s3,0x1
    1102:	54298993          	addi	s3,s3,1346 # 2640 <whitespace>
    1106:	00b4fe63          	bgeu	s1,a1,1122 <gettoken+0x42>
    110a:	0004c583          	lbu	a1,0(s1)
    110e:	854e                	mv	a0,s3
    1110:	00001097          	auipc	ra,0x1
    1114:	96e080e7          	jalr	-1682(ra) # 1a7e <strchr>
    1118:	c509                	beqz	a0,1122 <gettoken+0x42>
    s++;
    111a:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
    111c:	fe9917e3          	bne	s2,s1,110a <gettoken+0x2a>
    s++;
    1120:	84ca                	mv	s1,s2
  if(q)
    1122:	000a8463          	beqz	s5,112a <gettoken+0x4a>
    *q = s;
    1126:	009ab023          	sd	s1,0(s5)
  ret = *s;
    112a:	0004c783          	lbu	a5,0(s1)
    112e:	00078a9b          	sext.w	s5,a5
  switch(*s){
    1132:	03c00713          	li	a4,60
    1136:	06f76663          	bltu	a4,a5,11a2 <gettoken+0xc2>
    113a:	03a00713          	li	a4,58
    113e:	00f76e63          	bltu	a4,a5,115a <gettoken+0x7a>
    1142:	cf89                	beqz	a5,115c <gettoken+0x7c>
    1144:	02600713          	li	a4,38
    1148:	00e78963          	beq	a5,a4,115a <gettoken+0x7a>
    114c:	fd87879b          	addiw	a5,a5,-40
    1150:	0ff7f793          	zext.b	a5,a5
    1154:	4705                	li	a4,1
    1156:	06f76d63          	bltu	a4,a5,11d0 <gettoken+0xf0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    115a:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    115c:	000b0463          	beqz	s6,1164 <gettoken+0x84>
    *eq = s;
    1160:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
    1164:	00001997          	auipc	s3,0x1
    1168:	4dc98993          	addi	s3,s3,1244 # 2640 <whitespace>
    116c:	0124fe63          	bgeu	s1,s2,1188 <gettoken+0xa8>
    1170:	0004c583          	lbu	a1,0(s1)
    1174:	854e                	mv	a0,s3
    1176:	00001097          	auipc	ra,0x1
    117a:	908080e7          	jalr	-1784(ra) # 1a7e <strchr>
    117e:	c509                	beqz	a0,1188 <gettoken+0xa8>
    s++;
    1180:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
    1182:	fe9917e3          	bne	s2,s1,1170 <gettoken+0x90>
    s++;
    1186:	84ca                	mv	s1,s2
  *ps = s;
    1188:	009a3023          	sd	s1,0(s4)
  return ret;
}
    118c:	8556                	mv	a0,s5
    118e:	70e2                	ld	ra,56(sp)
    1190:	7442                	ld	s0,48(sp)
    1192:	74a2                	ld	s1,40(sp)
    1194:	7902                	ld	s2,32(sp)
    1196:	69e2                	ld	s3,24(sp)
    1198:	6a42                	ld	s4,16(sp)
    119a:	6aa2                	ld	s5,8(sp)
    119c:	6b02                	ld	s6,0(sp)
    119e:	6121                	addi	sp,sp,64
    11a0:	8082                	ret
  switch(*s){
    11a2:	03e00713          	li	a4,62
    11a6:	02e79163          	bne	a5,a4,11c8 <gettoken+0xe8>
    s++;
    11aa:	00148693          	addi	a3,s1,1
    if(*s == '>'){
    11ae:	0014c703          	lbu	a4,1(s1)
    11b2:	03e00793          	li	a5,62
      s++;
    11b6:	0489                	addi	s1,s1,2
      ret = '+';
    11b8:	02b00a93          	li	s5,43
    if(*s == '>'){
    11bc:	faf700e3          	beq	a4,a5,115c <gettoken+0x7c>
    s++;
    11c0:	84b6                	mv	s1,a3
  ret = *s;
    11c2:	03e00a93          	li	s5,62
    11c6:	bf59                	j	115c <gettoken+0x7c>
  switch(*s){
    11c8:	07c00713          	li	a4,124
    11cc:	f8e787e3          	beq	a5,a4,115a <gettoken+0x7a>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    11d0:	00001997          	auipc	s3,0x1
    11d4:	47098993          	addi	s3,s3,1136 # 2640 <whitespace>
    11d8:	00001a97          	auipc	s5,0x1
    11dc:	470a8a93          	addi	s5,s5,1136 # 2648 <symbols>
    11e0:	0324f663          	bgeu	s1,s2,120c <gettoken+0x12c>
    11e4:	0004c583          	lbu	a1,0(s1)
    11e8:	854e                	mv	a0,s3
    11ea:	00001097          	auipc	ra,0x1
    11ee:	894080e7          	jalr	-1900(ra) # 1a7e <strchr>
    11f2:	e50d                	bnez	a0,121c <gettoken+0x13c>
    11f4:	0004c583          	lbu	a1,0(s1)
    11f8:	8556                	mv	a0,s5
    11fa:	00001097          	auipc	ra,0x1
    11fe:	884080e7          	jalr	-1916(ra) # 1a7e <strchr>
    1202:	e911                	bnez	a0,1216 <gettoken+0x136>
      s++;
    1204:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1206:	fc991fe3          	bne	s2,s1,11e4 <gettoken+0x104>
      s++;
    120a:	84ca                	mv	s1,s2
  if(eq)
    120c:	06100a93          	li	s5,97
    1210:	f40b18e3          	bnez	s6,1160 <gettoken+0x80>
    1214:	bf95                	j	1188 <gettoken+0xa8>
    ret = 'a';
    1216:	06100a93          	li	s5,97
    121a:	b789                	j	115c <gettoken+0x7c>
    121c:	06100a93          	li	s5,97
    1220:	bf35                	j	115c <gettoken+0x7c>

0000000000001222 <peek>:

int
peek(char **ps, char *es, char *toks)
{
    1222:	7139                	addi	sp,sp,-64
    1224:	fc06                	sd	ra,56(sp)
    1226:	f822                	sd	s0,48(sp)
    1228:	f426                	sd	s1,40(sp)
    122a:	f04a                	sd	s2,32(sp)
    122c:	ec4e                	sd	s3,24(sp)
    122e:	e852                	sd	s4,16(sp)
    1230:	e456                	sd	s5,8(sp)
    1232:	0080                	addi	s0,sp,64
    1234:	8a2a                	mv	s4,a0
    1236:	892e                	mv	s2,a1
    1238:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
    123a:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
    123c:	00001997          	auipc	s3,0x1
    1240:	40498993          	addi	s3,s3,1028 # 2640 <whitespace>
    1244:	00b4fe63          	bgeu	s1,a1,1260 <peek+0x3e>
    1248:	0004c583          	lbu	a1,0(s1)
    124c:	854e                	mv	a0,s3
    124e:	00001097          	auipc	ra,0x1
    1252:	830080e7          	jalr	-2000(ra) # 1a7e <strchr>
    1256:	c509                	beqz	a0,1260 <peek+0x3e>
    s++;
    1258:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
    125a:	fe9917e3          	bne	s2,s1,1248 <peek+0x26>
    s++;
    125e:	84ca                	mv	s1,s2
  *ps = s;
    1260:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
    1264:	0004c583          	lbu	a1,0(s1)
    1268:	4501                	li	a0,0
    126a:	e991                	bnez	a1,127e <peek+0x5c>
}
    126c:	70e2                	ld	ra,56(sp)
    126e:	7442                	ld	s0,48(sp)
    1270:	74a2                	ld	s1,40(sp)
    1272:	7902                	ld	s2,32(sp)
    1274:	69e2                	ld	s3,24(sp)
    1276:	6a42                	ld	s4,16(sp)
    1278:	6aa2                	ld	s5,8(sp)
    127a:	6121                	addi	sp,sp,64
    127c:	8082                	ret
  return *s && strchr(toks, *s);
    127e:	8556                	mv	a0,s5
    1280:	00000097          	auipc	ra,0x0
    1284:	7fe080e7          	jalr	2046(ra) # 1a7e <strchr>
    1288:	00a03533          	snez	a0,a0
    128c:	b7c5                	j	126c <peek+0x4a>

000000000000128e <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    128e:	7119                	addi	sp,sp,-128
    1290:	fc86                	sd	ra,120(sp)
    1292:	f8a2                	sd	s0,112(sp)
    1294:	f4a6                	sd	s1,104(sp)
    1296:	f0ca                	sd	s2,96(sp)
    1298:	ecce                	sd	s3,88(sp)
    129a:	e8d2                	sd	s4,80(sp)
    129c:	e4d6                	sd	s5,72(sp)
    129e:	e0da                	sd	s6,64(sp)
    12a0:	fc5e                	sd	s7,56(sp)
    12a2:	f862                	sd	s8,48(sp)
    12a4:	f466                	sd	s9,40(sp)
    12a6:	f06a                	sd	s10,32(sp)
    12a8:	ec6e                	sd	s11,24(sp)
    12aa:	0100                	addi	s0,sp,128
    12ac:	8a2a                	mv	s4,a0
    12ae:	89ae                	mv	s3,a1
    12b0:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    12b2:	00001b97          	auipc	s7,0x1
    12b6:	1feb8b93          	addi	s7,s7,510 # 24b0 <malloc+0x204>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
    12ba:	f8040d13          	addi	s10,s0,-128
    12be:	f8840c93          	addi	s9,s0,-120
    12c2:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
    12c6:	03c00d93          	li	s11,60
  while(peek(ps, es, "<>")){
    12ca:	a02d                	j	12f4 <parseredirs+0x66>
      panic("missing file for redirection");
    12cc:	00001517          	auipc	a0,0x1
    12d0:	1c450513          	addi	a0,a0,452 # 2490 <malloc+0x1e4>
    12d4:	00000097          	auipc	ra,0x0
    12d8:	9fa080e7          	jalr	-1542(ra) # cce <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    12dc:	4701                	li	a4,0
    12de:	4681                	li	a3,0
    12e0:	f8043603          	ld	a2,-128(s0)
    12e4:	f8843583          	ld	a1,-120(s0)
    12e8:	8552                	mv	a0,s4
    12ea:	00000097          	auipc	ra,0x0
    12ee:	cc6080e7          	jalr	-826(ra) # fb0 <redircmd>
    12f2:	8a2a                	mv	s4,a0
    switch(tok){
    12f4:	03e00b13          	li	s6,62
    12f8:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
    12fc:	865e                	mv	a2,s7
    12fe:	85ca                	mv	a1,s2
    1300:	854e                	mv	a0,s3
    1302:	00000097          	auipc	ra,0x0
    1306:	f20080e7          	jalr	-224(ra) # 1222 <peek>
    130a:	c535                	beqz	a0,1376 <parseredirs+0xe8>
    tok = gettoken(ps, es, 0, 0);
    130c:	4681                	li	a3,0
    130e:	4601                	li	a2,0
    1310:	85ca                	mv	a1,s2
    1312:	854e                	mv	a0,s3
    1314:	00000097          	auipc	ra,0x0
    1318:	dcc080e7          	jalr	-564(ra) # 10e0 <gettoken>
    131c:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
    131e:	86ea                	mv	a3,s10
    1320:	8666                	mv	a2,s9
    1322:	85ca                	mv	a1,s2
    1324:	854e                	mv	a0,s3
    1326:	00000097          	auipc	ra,0x0
    132a:	dba080e7          	jalr	-582(ra) # 10e0 <gettoken>
    132e:	f9851fe3          	bne	a0,s8,12cc <parseredirs+0x3e>
    switch(tok){
    1332:	fbb485e3          	beq	s1,s11,12dc <parseredirs+0x4e>
    1336:	03648263          	beq	s1,s6,135a <parseredirs+0xcc>
    133a:	fd5491e3          	bne	s1,s5,12fc <parseredirs+0x6e>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_APPEND, 1);
    133e:	4705                	li	a4,1
    1340:	20500693          	li	a3,517
    1344:	f8043603          	ld	a2,-128(s0)
    1348:	f8843583          	ld	a1,-120(s0)
    134c:	8552                	mv	a0,s4
    134e:	00000097          	auipc	ra,0x0
    1352:	c62080e7          	jalr	-926(ra) # fb0 <redircmd>
    1356:	8a2a                	mv	s4,a0
      break;
    1358:	bf71                	j	12f4 <parseredirs+0x66>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
    135a:	4705                	li	a4,1
    135c:	60100693          	li	a3,1537
    1360:	f8043603          	ld	a2,-128(s0)
    1364:	f8843583          	ld	a1,-120(s0)
    1368:	8552                	mv	a0,s4
    136a:	00000097          	auipc	ra,0x0
    136e:	c46080e7          	jalr	-954(ra) # fb0 <redircmd>
    1372:	8a2a                	mv	s4,a0
      break;
    1374:	b741                	j	12f4 <parseredirs+0x66>
    }
  }
  return cmd;
}
    1376:	8552                	mv	a0,s4
    1378:	70e6                	ld	ra,120(sp)
    137a:	7446                	ld	s0,112(sp)
    137c:	74a6                	ld	s1,104(sp)
    137e:	7906                	ld	s2,96(sp)
    1380:	69e6                	ld	s3,88(sp)
    1382:	6a46                	ld	s4,80(sp)
    1384:	6aa6                	ld	s5,72(sp)
    1386:	6b06                	ld	s6,64(sp)
    1388:	7be2                	ld	s7,56(sp)
    138a:	7c42                	ld	s8,48(sp)
    138c:	7ca2                	ld	s9,40(sp)
    138e:	7d02                	ld	s10,32(sp)
    1390:	6de2                	ld	s11,24(sp)
    1392:	6109                	addi	sp,sp,128
    1394:	8082                	ret

0000000000001396 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
    1396:	7119                	addi	sp,sp,-128
    1398:	fc86                	sd	ra,120(sp)
    139a:	f8a2                	sd	s0,112(sp)
    139c:	f4a6                	sd	s1,104(sp)
    139e:	f0ca                	sd	s2,96(sp)
    13a0:	ecce                	sd	s3,88(sp)
    13a2:	e8d2                	sd	s4,80(sp)
    13a4:	e4d6                	sd	s5,72(sp)
    13a6:	e0da                	sd	s6,64(sp)
    13a8:	fc5e                	sd	s7,56(sp)
    13aa:	f862                	sd	s8,48(sp)
    13ac:	f466                	sd	s9,40(sp)
    13ae:	f06a                	sd	s10,32(sp)
    13b0:	ec6e                	sd	s11,24(sp)
    13b2:	0100                	addi	s0,sp,128
    13b4:	8a2a                	mv	s4,a0
    13b6:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    13b8:	00001617          	auipc	a2,0x1
    13bc:	10060613          	addi	a2,a2,256 # 24b8 <malloc+0x20c>
    13c0:	00000097          	auipc	ra,0x0
    13c4:	e62080e7          	jalr	-414(ra) # 1222 <peek>
    13c8:	ed05                	bnez	a0,1400 <parseexec+0x6a>
    13ca:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
    13cc:	00000097          	auipc	ra,0x0
    13d0:	bae080e7          	jalr	-1106(ra) # f7a <execcmd>
    13d4:	8daa                	mv	s11,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
    13d6:	8656                	mv	a2,s5
    13d8:	85d2                	mv	a1,s4
    13da:	00000097          	auipc	ra,0x0
    13de:	eb4080e7          	jalr	-332(ra) # 128e <parseredirs>
    13e2:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
    13e4:	008d8913          	addi	s2,s11,8
    13e8:	00001b17          	auipc	s6,0x1
    13ec:	0f0b0b13          	addi	s6,s6,240 # 24d8 <malloc+0x22c>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    13f0:	f8040c13          	addi	s8,s0,-128
    13f4:	f8840b93          	addi	s7,s0,-120
      break;
    if(tok != 'a')
    13f8:	06100d13          	li	s10,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
    13fc:	4ca9                	li	s9,10
  while(!peek(ps, es, "|)&;")){
    13fe:	a881                	j	144e <parseexec+0xb8>
    return parseblock(ps, es);
    1400:	85d6                	mv	a1,s5
    1402:	8552                	mv	a0,s4
    1404:	00000097          	auipc	ra,0x0
    1408:	1bc080e7          	jalr	444(ra) # 15c0 <parseblock>
    140c:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
    140e:	8526                	mv	a0,s1
    1410:	70e6                	ld	ra,120(sp)
    1412:	7446                	ld	s0,112(sp)
    1414:	74a6                	ld	s1,104(sp)
    1416:	7906                	ld	s2,96(sp)
    1418:	69e6                	ld	s3,88(sp)
    141a:	6a46                	ld	s4,80(sp)
    141c:	6aa6                	ld	s5,72(sp)
    141e:	6b06                	ld	s6,64(sp)
    1420:	7be2                	ld	s7,56(sp)
    1422:	7c42                	ld	s8,48(sp)
    1424:	7ca2                	ld	s9,40(sp)
    1426:	7d02                	ld	s10,32(sp)
    1428:	6de2                	ld	s11,24(sp)
    142a:	6109                	addi	sp,sp,128
    142c:	8082                	ret
      panic("syntax");
    142e:	00001517          	auipc	a0,0x1
    1432:	09250513          	addi	a0,a0,146 # 24c0 <malloc+0x214>
    1436:	00000097          	auipc	ra,0x0
    143a:	898080e7          	jalr	-1896(ra) # cce <panic>
    ret = parseredirs(ret, ps, es);
    143e:	8656                	mv	a2,s5
    1440:	85d2                	mv	a1,s4
    1442:	8526                	mv	a0,s1
    1444:	00000097          	auipc	ra,0x0
    1448:	e4a080e7          	jalr	-438(ra) # 128e <parseredirs>
    144c:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
    144e:	865a                	mv	a2,s6
    1450:	85d6                	mv	a1,s5
    1452:	8552                	mv	a0,s4
    1454:	00000097          	auipc	ra,0x0
    1458:	dce080e7          	jalr	-562(ra) # 1222 <peek>
    145c:	e121                	bnez	a0,149c <parseexec+0x106>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    145e:	86e2                	mv	a3,s8
    1460:	865e                	mv	a2,s7
    1462:	85d6                	mv	a1,s5
    1464:	8552                	mv	a0,s4
    1466:	00000097          	auipc	ra,0x0
    146a:	c7a080e7          	jalr	-902(ra) # 10e0 <gettoken>
    146e:	c51d                	beqz	a0,149c <parseexec+0x106>
    if(tok != 'a')
    1470:	fba51fe3          	bne	a0,s10,142e <parseexec+0x98>
    cmd->argv[argc] = q;
    1474:	f8843783          	ld	a5,-120(s0)
    1478:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
    147c:	f8043783          	ld	a5,-128(s0)
    1480:	04f93823          	sd	a5,80(s2)
    argc++;
    1484:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
    1486:	0921                	addi	s2,s2,8
    1488:	fb999be3          	bne	s3,s9,143e <parseexec+0xa8>
      panic("too many args");
    148c:	00001517          	auipc	a0,0x1
    1490:	03c50513          	addi	a0,a0,60 # 24c8 <malloc+0x21c>
    1494:	00000097          	auipc	ra,0x0
    1498:	83a080e7          	jalr	-1990(ra) # cce <panic>
  cmd->argv[argc] = 0;
    149c:	098e                	slli	s3,s3,0x3
    149e:	9dce                	add	s11,s11,s3
    14a0:	000db423          	sd	zero,8(s11)
  cmd->eargv[argc] = 0;
    14a4:	040dbc23          	sd	zero,88(s11)
  return ret;
    14a8:	b79d                	j	140e <parseexec+0x78>

00000000000014aa <parsepipe>:
{
    14aa:	7179                	addi	sp,sp,-48
    14ac:	f406                	sd	ra,40(sp)
    14ae:	f022                	sd	s0,32(sp)
    14b0:	ec26                	sd	s1,24(sp)
    14b2:	e84a                	sd	s2,16(sp)
    14b4:	e44e                	sd	s3,8(sp)
    14b6:	1800                	addi	s0,sp,48
    14b8:	892a                	mv	s2,a0
    14ba:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
    14bc:	00000097          	auipc	ra,0x0
    14c0:	eda080e7          	jalr	-294(ra) # 1396 <parseexec>
    14c4:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
    14c6:	00001617          	auipc	a2,0x1
    14ca:	01a60613          	addi	a2,a2,26 # 24e0 <malloc+0x234>
    14ce:	85ce                	mv	a1,s3
    14d0:	854a                	mv	a0,s2
    14d2:	00000097          	auipc	ra,0x0
    14d6:	d50080e7          	jalr	-688(ra) # 1222 <peek>
    14da:	e909                	bnez	a0,14ec <parsepipe+0x42>
}
    14dc:	8526                	mv	a0,s1
    14de:	70a2                	ld	ra,40(sp)
    14e0:	7402                	ld	s0,32(sp)
    14e2:	64e2                	ld	s1,24(sp)
    14e4:	6942                	ld	s2,16(sp)
    14e6:	69a2                	ld	s3,8(sp)
    14e8:	6145                	addi	sp,sp,48
    14ea:	8082                	ret
    gettoken(ps, es, 0, 0);
    14ec:	4681                	li	a3,0
    14ee:	4601                	li	a2,0
    14f0:	85ce                	mv	a1,s3
    14f2:	854a                	mv	a0,s2
    14f4:	00000097          	auipc	ra,0x0
    14f8:	bec080e7          	jalr	-1044(ra) # 10e0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
    14fc:	85ce                	mv	a1,s3
    14fe:	854a                	mv	a0,s2
    1500:	00000097          	auipc	ra,0x0
    1504:	faa080e7          	jalr	-86(ra) # 14aa <parsepipe>
    1508:	85aa                	mv	a1,a0
    150a:	8526                	mv	a0,s1
    150c:	00000097          	auipc	ra,0x0
    1510:	b0c080e7          	jalr	-1268(ra) # 1018 <pipecmd>
    1514:	84aa                	mv	s1,a0
  return cmd;
    1516:	b7d9                	j	14dc <parsepipe+0x32>

0000000000001518 <parseline>:
{
    1518:	7179                	addi	sp,sp,-48
    151a:	f406                	sd	ra,40(sp)
    151c:	f022                	sd	s0,32(sp)
    151e:	ec26                	sd	s1,24(sp)
    1520:	e84a                	sd	s2,16(sp)
    1522:	e44e                	sd	s3,8(sp)
    1524:	e052                	sd	s4,0(sp)
    1526:	1800                	addi	s0,sp,48
    1528:	892a                	mv	s2,a0
    152a:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
    152c:	00000097          	auipc	ra,0x0
    1530:	f7e080e7          	jalr	-130(ra) # 14aa <parsepipe>
    1534:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
    1536:	00001a17          	auipc	s4,0x1
    153a:	fb2a0a13          	addi	s4,s4,-78 # 24e8 <malloc+0x23c>
    153e:	a839                	j	155c <parseline+0x44>
    gettoken(ps, es, 0, 0);
    1540:	4681                	li	a3,0
    1542:	4601                	li	a2,0
    1544:	85ce                	mv	a1,s3
    1546:	854a                	mv	a0,s2
    1548:	00000097          	auipc	ra,0x0
    154c:	b98080e7          	jalr	-1128(ra) # 10e0 <gettoken>
    cmd = backcmd(cmd);
    1550:	8526                	mv	a0,s1
    1552:	00000097          	auipc	ra,0x0
    1556:	b52080e7          	jalr	-1198(ra) # 10a4 <backcmd>
    155a:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
    155c:	8652                	mv	a2,s4
    155e:	85ce                	mv	a1,s3
    1560:	854a                	mv	a0,s2
    1562:	00000097          	auipc	ra,0x0
    1566:	cc0080e7          	jalr	-832(ra) # 1222 <peek>
    156a:	f979                	bnez	a0,1540 <parseline+0x28>
  if(peek(ps, es, ";")){
    156c:	00001617          	auipc	a2,0x1
    1570:	f8460613          	addi	a2,a2,-124 # 24f0 <malloc+0x244>
    1574:	85ce                	mv	a1,s3
    1576:	854a                	mv	a0,s2
    1578:	00000097          	auipc	ra,0x0
    157c:	caa080e7          	jalr	-854(ra) # 1222 <peek>
    1580:	e911                	bnez	a0,1594 <parseline+0x7c>
}
    1582:	8526                	mv	a0,s1
    1584:	70a2                	ld	ra,40(sp)
    1586:	7402                	ld	s0,32(sp)
    1588:	64e2                	ld	s1,24(sp)
    158a:	6942                	ld	s2,16(sp)
    158c:	69a2                	ld	s3,8(sp)
    158e:	6a02                	ld	s4,0(sp)
    1590:	6145                	addi	sp,sp,48
    1592:	8082                	ret
    gettoken(ps, es, 0, 0);
    1594:	4681                	li	a3,0
    1596:	4601                	li	a2,0
    1598:	85ce                	mv	a1,s3
    159a:	854a                	mv	a0,s2
    159c:	00000097          	auipc	ra,0x0
    15a0:	b44080e7          	jalr	-1212(ra) # 10e0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
    15a4:	85ce                	mv	a1,s3
    15a6:	854a                	mv	a0,s2
    15a8:	00000097          	auipc	ra,0x0
    15ac:	f70080e7          	jalr	-144(ra) # 1518 <parseline>
    15b0:	85aa                	mv	a1,a0
    15b2:	8526                	mv	a0,s1
    15b4:	00000097          	auipc	ra,0x0
    15b8:	aaa080e7          	jalr	-1366(ra) # 105e <listcmd>
    15bc:	84aa                	mv	s1,a0
  return cmd;
    15be:	b7d1                	j	1582 <parseline+0x6a>

00000000000015c0 <parseblock>:
{
    15c0:	7179                	addi	sp,sp,-48
    15c2:	f406                	sd	ra,40(sp)
    15c4:	f022                	sd	s0,32(sp)
    15c6:	ec26                	sd	s1,24(sp)
    15c8:	e84a                	sd	s2,16(sp)
    15ca:	e44e                	sd	s3,8(sp)
    15cc:	1800                	addi	s0,sp,48
    15ce:	84aa                	mv	s1,a0
    15d0:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
    15d2:	00001617          	auipc	a2,0x1
    15d6:	ee660613          	addi	a2,a2,-282 # 24b8 <malloc+0x20c>
    15da:	00000097          	auipc	ra,0x0
    15de:	c48080e7          	jalr	-952(ra) # 1222 <peek>
    15e2:	c12d                	beqz	a0,1644 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
    15e4:	4681                	li	a3,0
    15e6:	4601                	li	a2,0
    15e8:	85ca                	mv	a1,s2
    15ea:	8526                	mv	a0,s1
    15ec:	00000097          	auipc	ra,0x0
    15f0:	af4080e7          	jalr	-1292(ra) # 10e0 <gettoken>
  cmd = parseline(ps, es);
    15f4:	85ca                	mv	a1,s2
    15f6:	8526                	mv	a0,s1
    15f8:	00000097          	auipc	ra,0x0
    15fc:	f20080e7          	jalr	-224(ra) # 1518 <parseline>
    1600:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
    1602:	00001617          	auipc	a2,0x1
    1606:	f0660613          	addi	a2,a2,-250 # 2508 <malloc+0x25c>
    160a:	85ca                	mv	a1,s2
    160c:	8526                	mv	a0,s1
    160e:	00000097          	auipc	ra,0x0
    1612:	c14080e7          	jalr	-1004(ra) # 1222 <peek>
    1616:	cd1d                	beqz	a0,1654 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
    1618:	4681                	li	a3,0
    161a:	4601                	li	a2,0
    161c:	85ca                	mv	a1,s2
    161e:	8526                	mv	a0,s1
    1620:	00000097          	auipc	ra,0x0
    1624:	ac0080e7          	jalr	-1344(ra) # 10e0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
    1628:	864a                	mv	a2,s2
    162a:	85a6                	mv	a1,s1
    162c:	854e                	mv	a0,s3
    162e:	00000097          	auipc	ra,0x0
    1632:	c60080e7          	jalr	-928(ra) # 128e <parseredirs>
}
    1636:	70a2                	ld	ra,40(sp)
    1638:	7402                	ld	s0,32(sp)
    163a:	64e2                	ld	s1,24(sp)
    163c:	6942                	ld	s2,16(sp)
    163e:	69a2                	ld	s3,8(sp)
    1640:	6145                	addi	sp,sp,48
    1642:	8082                	ret
    panic("parseblock");
    1644:	00001517          	auipc	a0,0x1
    1648:	eb450513          	addi	a0,a0,-332 # 24f8 <malloc+0x24c>
    164c:	fffff097          	auipc	ra,0xfffff
    1650:	682080e7          	jalr	1666(ra) # cce <panic>
    panic("syntax - missing )");
    1654:	00001517          	auipc	a0,0x1
    1658:	ebc50513          	addi	a0,a0,-324 # 2510 <malloc+0x264>
    165c:	fffff097          	auipc	ra,0xfffff
    1660:	672080e7          	jalr	1650(ra) # cce <panic>

0000000000001664 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    1664:	1101                	addi	sp,sp,-32
    1666:	ec06                	sd	ra,24(sp)
    1668:	e822                	sd	s0,16(sp)
    166a:	e426                	sd	s1,8(sp)
    166c:	1000                	addi	s0,sp,32
    166e:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    1670:	c521                	beqz	a0,16b8 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
    1672:	4118                	lw	a4,0(a0)
    1674:	4795                	li	a5,5
    1676:	04e7e163          	bltu	a5,a4,16b8 <nulterminate+0x54>
    167a:	00056783          	lwu	a5,0(a0)
    167e:	078a                	slli	a5,a5,0x2
    1680:	00001717          	auipc	a4,0x1
    1684:	f3070713          	addi	a4,a4,-208 # 25b0 <malloc+0x304>
    1688:	97ba                	add	a5,a5,a4
    168a:	439c                	lw	a5,0(a5)
    168c:	97ba                	add	a5,a5,a4
    168e:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1690:	651c                	ld	a5,8(a0)
    1692:	c39d                	beqz	a5,16b8 <nulterminate+0x54>
    1694:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
    1698:	67b8                	ld	a4,72(a5)
    169a:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
    169e:	07a1                	addi	a5,a5,8
    16a0:	ff87b703          	ld	a4,-8(a5)
    16a4:	fb75                	bnez	a4,1698 <nulterminate+0x34>
    16a6:	a809                	j	16b8 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    16a8:	6508                	ld	a0,8(a0)
    16aa:	00000097          	auipc	ra,0x0
    16ae:	fba080e7          	jalr	-70(ra) # 1664 <nulterminate>
    *rcmd->efile = 0;
    16b2:	6c9c                	ld	a5,24(s1)
    16b4:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
    16b8:	8526                	mv	a0,s1
    16ba:	60e2                	ld	ra,24(sp)
    16bc:	6442                	ld	s0,16(sp)
    16be:	64a2                	ld	s1,8(sp)
    16c0:	6105                	addi	sp,sp,32
    16c2:	8082                	ret
    nulterminate(pcmd->left);
    16c4:	6508                	ld	a0,8(a0)
    16c6:	00000097          	auipc	ra,0x0
    16ca:	f9e080e7          	jalr	-98(ra) # 1664 <nulterminate>
    nulterminate(pcmd->right);
    16ce:	6888                	ld	a0,16(s1)
    16d0:	00000097          	auipc	ra,0x0
    16d4:	f94080e7          	jalr	-108(ra) # 1664 <nulterminate>
    break;
    16d8:	b7c5                	j	16b8 <nulterminate+0x54>
    nulterminate(lcmd->left);
    16da:	6508                	ld	a0,8(a0)
    16dc:	00000097          	auipc	ra,0x0
    16e0:	f88080e7          	jalr	-120(ra) # 1664 <nulterminate>
    nulterminate(lcmd->right);
    16e4:	6888                	ld	a0,16(s1)
    16e6:	00000097          	auipc	ra,0x0
    16ea:	f7e080e7          	jalr	-130(ra) # 1664 <nulterminate>
    break;
    16ee:	b7e9                	j	16b8 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
    16f0:	6508                	ld	a0,8(a0)
    16f2:	00000097          	auipc	ra,0x0
    16f6:	f72080e7          	jalr	-142(ra) # 1664 <nulterminate>
    break;
    16fa:	bf7d                	j	16b8 <nulterminate+0x54>

00000000000016fc <parsecmd>:
{
    16fc:	7139                	addi	sp,sp,-64
    16fe:	fc06                	sd	ra,56(sp)
    1700:	f822                	sd	s0,48(sp)
    1702:	f426                	sd	s1,40(sp)
    1704:	f04a                	sd	s2,32(sp)
    1706:	ec4e                	sd	s3,24(sp)
    1708:	0080                	addi	s0,sp,64
    170a:	fca43423          	sd	a0,-56(s0)
  es = s + strlen(s);
    170e:	84aa                	mv	s1,a0
    1710:	00000097          	auipc	ra,0x0
    1714:	322080e7          	jalr	802(ra) # 1a32 <strlen>
    1718:	1502                	slli	a0,a0,0x20
    171a:	9101                	srli	a0,a0,0x20
    171c:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
    171e:	85a6                	mv	a1,s1
    1720:	fc840913          	addi	s2,s0,-56
    1724:	854a                	mv	a0,s2
    1726:	00000097          	auipc	ra,0x0
    172a:	df2080e7          	jalr	-526(ra) # 1518 <parseline>
    172e:	89aa                	mv	s3,a0
  peek(&s, es, "");
    1730:	00001617          	auipc	a2,0x1
    1734:	e5060613          	addi	a2,a2,-432 # 2580 <malloc+0x2d4>
    1738:	85a6                	mv	a1,s1
    173a:	854a                	mv	a0,s2
    173c:	00000097          	auipc	ra,0x0
    1740:	ae6080e7          	jalr	-1306(ra) # 1222 <peek>
  if(s != es){
    1744:	fc843603          	ld	a2,-56(s0)
    1748:	00961f63          	bne	a2,s1,1766 <parsecmd+0x6a>
  nulterminate(cmd);
    174c:	854e                	mv	a0,s3
    174e:	00000097          	auipc	ra,0x0
    1752:	f16080e7          	jalr	-234(ra) # 1664 <nulterminate>
}
    1756:	854e                	mv	a0,s3
    1758:	70e2                	ld	ra,56(sp)
    175a:	7442                	ld	s0,48(sp)
    175c:	74a2                	ld	s1,40(sp)
    175e:	7902                	ld	s2,32(sp)
    1760:	69e2                	ld	s3,24(sp)
    1762:	6121                	addi	sp,sp,64
    1764:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
    1766:	00001597          	auipc	a1,0x1
    176a:	dc258593          	addi	a1,a1,-574 # 2528 <malloc+0x27c>
    176e:	4509                	li	a0,2
    1770:	00001097          	auipc	ra,0x1
    1774:	a56080e7          	jalr	-1450(ra) # 21c6 <fprintf>
    panic("syntax");
    1778:	00001517          	auipc	a0,0x1
    177c:	d4850513          	addi	a0,a0,-696 # 24c0 <malloc+0x214>
    1780:	fffff097          	auipc	ra,0xfffff
    1784:	54e080e7          	jalr	1358(ra) # cce <panic>

0000000000001788 <main>:
{
    1788:	711d                	addi	sp,sp,-96
    178a:	ec86                	sd	ra,88(sp)
    178c:	e8a2                	sd	s0,80(sp)
    178e:	e4a6                	sd	s1,72(sp)
    1790:	e0ca                	sd	s2,64(sp)
    1792:	fc4e                	sd	s3,56(sp)
    1794:	f852                	sd	s4,48(sp)
    1796:	f456                	sd	s5,40(sp)
    1798:	f05a                	sd	s6,32(sp)
    179a:	ec5e                	sd	s7,24(sp)
    179c:	e862                	sd	s8,16(sp)
    179e:	e466                	sd	s9,8(sp)
    17a0:	1080                	addi	s0,sp,96
  while((fd = dev(O_RDWR, 1, 0)) >= 0){
    17a2:	4601                	li	a2,0
    17a4:	4585                	li	a1,1
    17a6:	4509                	li	a0,2
    17a8:	00000097          	auipc	ra,0x0
    17ac:	55c080e7          	jalr	1372(ra) # 1d04 <dev>
    17b0:	00054963          	bltz	a0,17c2 <main+0x3a>
    if(fd >= 3){
    17b4:	4789                	li	a5,2
    17b6:	fea7d6e3          	bge	a5,a0,17a2 <main+0x1a>
      close(fd);
    17ba:	00000097          	auipc	ra,0x0
    17be:	4e2080e7          	jalr	1250(ra) # 1c9c <close>
  strcpy(envs[nenv].name, "SHELL");
    17c2:	00001497          	auipc	s1,0x1
    17c6:	e8e48493          	addi	s1,s1,-370 # 2650 <nenv>
    17ca:	4088                	lw	a0,0(s1)
    17cc:	051e                	slli	a0,a0,0x7
    17ce:	00001917          	auipc	s2,0x1
    17d2:	79a90913          	addi	s2,s2,1946 # 2f68 <envs>
    17d6:	00001597          	auipc	a1,0x1
    17da:	d6258593          	addi	a1,a1,-670 # 2538 <malloc+0x28c>
    17de:	954a                	add	a0,a0,s2
    17e0:	00000097          	auipc	ra,0x0
    17e4:	1dc080e7          	jalr	476(ra) # 19bc <strcpy>
  strcpy(envs[nenv].value, "/bin");
    17e8:	4088                	lw	a0,0(s1)
    17ea:	051e                	slli	a0,a0,0x7
    17ec:	02050513          	addi	a0,a0,32
    17f0:	00001597          	auipc	a1,0x1
    17f4:	d5058593          	addi	a1,a1,-688 # 2540 <malloc+0x294>
    17f8:	954a                	add	a0,a0,s2
    17fa:	00000097          	auipc	ra,0x0
    17fe:	1c2080e7          	jalr	450(ra) # 19bc <strcpy>
  nenv++;
    1802:	409c                	lw	a5,0(s1)
    1804:	2785                	addiw	a5,a5,1
    1806:	0007851b          	sext.w	a0,a5
    180a:	c09c                	sw	a5,0(s1)
  strcpy(envs[nenv].value, "/bin");
    180c:	051e                	slli	a0,a0,0x7
    180e:	02050513          	addi	a0,a0,32
    1812:	00001597          	auipc	a1,0x1
    1816:	d2e58593          	addi	a1,a1,-722 # 2540 <malloc+0x294>
    181a:	954a                	add	a0,a0,s2
    181c:	00000097          	auipc	ra,0x0
    1820:	1a0080e7          	jalr	416(ra) # 19bc <strcpy>
  nenv++;
    1824:	409c                	lw	a5,0(s1)
    1826:	2785                	addiw	a5,a5,1
    1828:	c09c                	sw	a5,0(s1)
  history_init();
    182a:	fffff097          	auipc	ra,0xfffff
    182e:	b18080e7          	jalr	-1256(ra) # 342 <history_init>
  getcwd(mycwd);
    1832:	00001517          	auipc	a0,0x1
    1836:	e2650513          	addi	a0,a0,-474 # 2658 <mycwd>
    183a:	00000097          	auipc	ra,0x0
    183e:	4da080e7          	jalr	1242(ra) # 1d14 <getcwd>
  while(getcmd(buf, sizeof(buf)) >= 0){
    1842:	00001917          	auipc	s2,0x1
    1846:	e9690913          	addi	s2,s2,-362 # 26d8 <buf.0>
    replace(buf);
    184a:	89a6                	mv	s3,s1
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    184c:	06300a13          	li	s4,99
      else if(!strcmp(ecmd->argv[0], "export"))
    1850:	00001a97          	auipc	s5,0x1
    1854:	d08a8a93          	addi	s5,s5,-760 # 2558 <malloc+0x2ac>
          fprintf(2, "export failed\n");
    1858:	00001b97          	auipc	s7,0x1
    185c:	d30b8b93          	addi	s7,s7,-720 # 2588 <malloc+0x2dc>
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
    1860:	00001b17          	auipc	s6,0x1
    1864:	d00b0b13          	addi	s6,s6,-768 # 2560 <malloc+0x2b4>
      if(chdir(buf+3) < 0)
    1868:	00001c17          	auipc	s8,0x1
    186c:	e73c0c13          	addi	s8,s8,-397 # 26db <buf.0+0x3>
      getcwd(mycwd);
    1870:	00001c97          	auipc	s9,0x1
    1874:	de8c8c93          	addi	s9,s9,-536 # 2658 <mycwd>
  while(getcmd(buf, sizeof(buf)) >= 0){
    1878:	a8a5                	j	18f0 <main+0x168>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    187a:	08a9c703          	lbu	a4,138(s3)
    187e:	02000793          	li	a5,32
    1882:	08f71f63          	bne	a4,a5,1920 <main+0x198>
      buf[strlen(buf)-1] = 0;  // chop \n
    1886:	854a                	mv	a0,s2
    1888:	00000097          	auipc	ra,0x0
    188c:	1aa080e7          	jalr	426(ra) # 1a32 <strlen>
    1890:	fff5079b          	addiw	a5,a0,-1
    1894:	1782                	slli	a5,a5,0x20
    1896:	9381                	srli	a5,a5,0x20
    1898:	97ce                	add	a5,a5,s3
    189a:	08078423          	sb	zero,136(a5)
      if(chdir(buf+3) < 0)
    189e:	8562                	mv	a0,s8
    18a0:	00000097          	auipc	ra,0x0
    18a4:	42c080e7          	jalr	1068(ra) # 1ccc <chdir>
    18a8:	00054863          	bltz	a0,18b8 <main+0x130>
      getcwd(mycwd);
    18ac:	8566                	mv	a0,s9
    18ae:	00000097          	auipc	ra,0x0
    18b2:	466080e7          	jalr	1126(ra) # 1d14 <getcwd>
    18b6:	a82d                	j	18f0 <main+0x168>
        fprintf(2, "cannot cd %s\n", buf+3);
    18b8:	8662                	mv	a2,s8
    18ba:	00001597          	auipc	a1,0x1
    18be:	c8e58593          	addi	a1,a1,-882 # 2548 <malloc+0x29c>
    18c2:	4509                	li	a0,2
    18c4:	00001097          	auipc	ra,0x1
    18c8:	902080e7          	jalr	-1790(ra) # 21c6 <fprintf>
    18cc:	b7c5                	j	18ac <main+0x124>
        free(cmd);
    18ce:	8526                	mv	a0,s1
    18d0:	00001097          	auipc	ra,0x1
    18d4:	95a080e7          	jalr	-1702(ra) # 222a <free>
        continue;
    18d8:	a821                	j	18f0 <main+0x168>
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
    18da:	85da                	mv	a1,s6
    18dc:	4509                	li	a0,2
    18de:	00001097          	auipc	ra,0x1
    18e2:	8e8080e7          	jalr	-1816(ra) # 21c6 <fprintf>
        free(cmd);
    18e6:	8526                	mv	a0,s1
    18e8:	00001097          	auipc	ra,0x1
    18ec:	942080e7          	jalr	-1726(ra) # 222a <free>
  while(getcmd(buf, sizeof(buf)) >= 0){
    18f0:	08000593          	li	a1,128
    18f4:	854a                	mv	a0,s2
    18f6:	fffff097          	auipc	ra,0xfffff
    18fa:	f52080e7          	jalr	-174(ra) # 848 <getcmd>
    18fe:	0a054a63          	bltz	a0,19b2 <main+0x22a>
    replace(buf);
    1902:	854a                	mv	a0,s2
    1904:	fffff097          	auipc	ra,0xfffff
    1908:	8fa080e7          	jalr	-1798(ra) # 1fe <replace>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    190c:	0889c783          	lbu	a5,136(s3)
    1910:	01479863          	bne	a5,s4,1920 <main+0x198>
    1914:	0899c703          	lbu	a4,137(s3)
    1918:	06400793          	li	a5,100
    191c:	f4f70fe3          	beq	a4,a5,187a <main+0xf2>
      struct cmd *cmd = parsecmd(buf);
    1920:	854a                	mv	a0,s2
    1922:	00000097          	auipc	ra,0x0
    1926:	dda080e7          	jalr	-550(ra) # 16fc <parsecmd>
    192a:	84aa                	mv	s1,a0
      if(ecmd->argv[0] == 0) {
    192c:	6508                	ld	a0,8(a0)
    192e:	d145                	beqz	a0,18ce <main+0x146>
      else if(!strcmp(ecmd->argv[0], "export"))
    1930:	85d6                	mv	a1,s5
    1932:	00000097          	auipc	ra,0x0
    1936:	0d4080e7          	jalr	212(ra) # 1a06 <strcmp>
    193a:	e115                	bnez	a0,195e <main+0x1d6>
        if(ecmd->argv[1] == NULL)
    193c:	689c                	ld	a5,16(s1)
    193e:	dfd1                	beqz	a5,18da <main+0x152>
        else if(export(ecmd->argv) < 0)
    1940:	00848513          	addi	a0,s1,8
    1944:	ffffe097          	auipc	ra,0xffffe
    1948:	722080e7          	jalr	1826(ra) # 66 <export>
    194c:	f8055de3          	bgez	a0,18e6 <main+0x15e>
          fprintf(2, "export failed\n");
    1950:	85de                	mv	a1,s7
    1952:	4509                	li	a0,2
    1954:	00001097          	auipc	ra,0x1
    1958:	872080e7          	jalr	-1934(ra) # 21c6 <fprintf>
    195c:	b769                	j	18e6 <main+0x15e>
      else if(fork1() == 0) {
    195e:	fffff097          	auipc	ra,0xfffff
    1962:	396080e7          	jalr	918(ra) # cf4 <fork1>
    1966:	c505                	beqz	a0,198e <main+0x206>
      wait(0);
    1968:	4501                	li	a0,0
    196a:	00000097          	auipc	ra,0x0
    196e:	312080e7          	jalr	786(ra) # 1c7c <wait>
      tcsetpgrp(getpid());
    1972:	00000097          	auipc	ra,0x0
    1976:	36a080e7          	jalr	874(ra) # 1cdc <getpid>
    197a:	00000097          	auipc	ra,0x0
    197e:	4d0080e7          	jalr	1232(ra) # 1e4a <tcsetpgrp>
      free(cmd);
    1982:	8526                	mv	a0,s1
    1984:	00001097          	auipc	ra,0x1
    1988:	8a6080e7          	jalr	-1882(ra) # 222a <free>
    198c:	b795                	j	18f0 <main+0x168>
        setpgid(0, 0);           // pgid = pid
    198e:	4581                	li	a1,0
    1990:	00000097          	auipc	ra,0x0
    1994:	4a6080e7          	jalr	1190(ra) # 1e36 <setpgid>
        tcsetpgrp(getpid());     // 设为前台进程组
    1998:	00000097          	auipc	ra,0x0
    199c:	344080e7          	jalr	836(ra) # 1cdc <getpid>
    19a0:	00000097          	auipc	ra,0x0
    19a4:	4aa080e7          	jalr	1194(ra) # 1e4a <tcsetpgrp>
        runcmd(cmd);
    19a8:	8526                	mv	a0,s1
    19aa:	fffff097          	auipc	ra,0xfffff
    19ae:	378080e7          	jalr	888(ra) # d22 <runcmd>
  exit(0);
    19b2:	4501                	li	a0,0
    19b4:	00000097          	auipc	ra,0x0
    19b8:	2c0080e7          	jalr	704(ra) # 1c74 <exit>

00000000000019bc <strcpy>:
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

char*
strcpy(char *s, const char *t)
{
    19bc:	1141                	addi	sp,sp,-16
    19be:	e422                	sd	s0,8(sp)
    19c0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    19c2:	87aa                	mv	a5,a0
    19c4:	0585                	addi	a1,a1,1
    19c6:	0785                	addi	a5,a5,1
    19c8:	fff5c703          	lbu	a4,-1(a1)
    19cc:	fee78fa3          	sb	a4,-1(a5)
    19d0:	fb75                	bnez	a4,19c4 <strcpy+0x8>
    ;
  return os;
}
    19d2:	6422                	ld	s0,8(sp)
    19d4:	0141                	addi	sp,sp,16
    19d6:	8082                	ret

00000000000019d8 <strcat>:

char*
strcat(char *s, const char *t)
{
    19d8:	1141                	addi	sp,sp,-16
    19da:	e422                	sd	s0,8(sp)
    19dc:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
    19de:	00054783          	lbu	a5,0(a0)
    19e2:	c385                	beqz	a5,1a02 <strcat+0x2a>
    19e4:	87aa                	mv	a5,a0
    s++;
    19e6:	0785                	addi	a5,a5,1
  while(*s)
    19e8:	0007c703          	lbu	a4,0(a5)
    19ec:	ff6d                	bnez	a4,19e6 <strcat+0xe>
  while((*s++ = *t++))
    19ee:	0585                	addi	a1,a1,1
    19f0:	0785                	addi	a5,a5,1
    19f2:	fff5c703          	lbu	a4,-1(a1)
    19f6:	fee78fa3          	sb	a4,-1(a5)
    19fa:	fb75                	bnez	a4,19ee <strcat+0x16>
    ;
  return os;
}
    19fc:	6422                	ld	s0,8(sp)
    19fe:	0141                	addi	sp,sp,16
    1a00:	8082                	ret
  while(*s)
    1a02:	87aa                	mv	a5,a0
    1a04:	b7ed                	j	19ee <strcat+0x16>

0000000000001a06 <strcmp>:


int
strcmp(const char *p, const char *q)
{
    1a06:	1141                	addi	sp,sp,-16
    1a08:	e422                	sd	s0,8(sp)
    1a0a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    1a0c:	00054783          	lbu	a5,0(a0)
    1a10:	cb91                	beqz	a5,1a24 <strcmp+0x1e>
    1a12:	0005c703          	lbu	a4,0(a1)
    1a16:	00f71763          	bne	a4,a5,1a24 <strcmp+0x1e>
    p++, q++;
    1a1a:	0505                	addi	a0,a0,1
    1a1c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    1a1e:	00054783          	lbu	a5,0(a0)
    1a22:	fbe5                	bnez	a5,1a12 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    1a24:	0005c503          	lbu	a0,0(a1)
}
    1a28:	40a7853b          	subw	a0,a5,a0
    1a2c:	6422                	ld	s0,8(sp)
    1a2e:	0141                	addi	sp,sp,16
    1a30:	8082                	ret

0000000000001a32 <strlen>:

uint
strlen(const char *s)
{
    1a32:	1141                	addi	sp,sp,-16
    1a34:	e422                	sd	s0,8(sp)
    1a36:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    1a38:	00054783          	lbu	a5,0(a0)
    1a3c:	cf91                	beqz	a5,1a58 <strlen+0x26>
    1a3e:	0505                	addi	a0,a0,1
    1a40:	87aa                	mv	a5,a0
    1a42:	4685                	li	a3,1
    1a44:	9e89                	subw	a3,a3,a0
    1a46:	00f6853b          	addw	a0,a3,a5
    1a4a:	0785                	addi	a5,a5,1
    1a4c:	fff7c703          	lbu	a4,-1(a5)
    1a50:	fb7d                	bnez	a4,1a46 <strlen+0x14>
    ;
  return n;
}
    1a52:	6422                	ld	s0,8(sp)
    1a54:	0141                	addi	sp,sp,16
    1a56:	8082                	ret
  for(n = 0; s[n]; n++)
    1a58:	4501                	li	a0,0
    1a5a:	bfe5                	j	1a52 <strlen+0x20>

0000000000001a5c <memset>:

void*
memset(void *dst, int c, uint n)
{
    1a5c:	1141                	addi	sp,sp,-16
    1a5e:	e422                	sd	s0,8(sp)
    1a60:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    1a62:	ca19                	beqz	a2,1a78 <memset+0x1c>
    1a64:	87aa                	mv	a5,a0
    1a66:	1602                	slli	a2,a2,0x20
    1a68:	9201                	srli	a2,a2,0x20
    1a6a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    1a6e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    1a72:	0785                	addi	a5,a5,1
    1a74:	fee79de3          	bne	a5,a4,1a6e <memset+0x12>
  }
  return dst;
}
    1a78:	6422                	ld	s0,8(sp)
    1a7a:	0141                	addi	sp,sp,16
    1a7c:	8082                	ret

0000000000001a7e <strchr>:

char*
strchr(const char *s, char c)
{
    1a7e:	1141                	addi	sp,sp,-16
    1a80:	e422                	sd	s0,8(sp)
    1a82:	0800                	addi	s0,sp,16
  for(; *s; s++)
    1a84:	00054783          	lbu	a5,0(a0)
    1a88:	cb99                	beqz	a5,1a9e <strchr+0x20>
    if(*s == c)
    1a8a:	00f58763          	beq	a1,a5,1a98 <strchr+0x1a>
  for(; *s; s++)
    1a8e:	0505                	addi	a0,a0,1
    1a90:	00054783          	lbu	a5,0(a0)
    1a94:	fbfd                	bnez	a5,1a8a <strchr+0xc>
      return (char*)s;
  return 0;
    1a96:	4501                	li	a0,0
}
    1a98:	6422                	ld	s0,8(sp)
    1a9a:	0141                	addi	sp,sp,16
    1a9c:	8082                	ret
  return 0;
    1a9e:	4501                	li	a0,0
    1aa0:	bfe5                	j	1a98 <strchr+0x1a>

0000000000001aa2 <gets>:

char*
gets(char *buf, int max)
{
    1aa2:	711d                	addi	sp,sp,-96
    1aa4:	ec86                	sd	ra,88(sp)
    1aa6:	e8a2                	sd	s0,80(sp)
    1aa8:	e4a6                	sd	s1,72(sp)
    1aaa:	e0ca                	sd	s2,64(sp)
    1aac:	fc4e                	sd	s3,56(sp)
    1aae:	f852                	sd	s4,48(sp)
    1ab0:	f456                	sd	s5,40(sp)
    1ab2:	f05a                	sd	s6,32(sp)
    1ab4:	ec5e                	sd	s7,24(sp)
    1ab6:	e862                	sd	s8,16(sp)
    1ab8:	1080                	addi	s0,sp,96
    1aba:	8baa                	mv	s7,a0
    1abc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1abe:	892a                	mv	s2,a0
    1ac0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    1ac2:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1ac6:	4b29                	li	s6,10
    1ac8:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
    1aca:	89a6                	mv	s3,s1
    1acc:	2485                	addiw	s1,s1,1
    1ace:	0344d763          	bge	s1,s4,1afc <gets+0x5a>
    cc = read(0, &c, 1);
    1ad2:	4605                	li	a2,1
    1ad4:	85d6                	mv	a1,s5
    1ad6:	4501                	li	a0,0
    1ad8:	00000097          	auipc	ra,0x0
    1adc:	1b4080e7          	jalr	436(ra) # 1c8c <read>
    if(cc < 1)
    1ae0:	00a05e63          	blez	a0,1afc <gets+0x5a>
    buf[i++] = c;
    1ae4:	faf44783          	lbu	a5,-81(s0)
    1ae8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    1aec:	01678763          	beq	a5,s6,1afa <gets+0x58>
    1af0:	0905                	addi	s2,s2,1
    1af2:	fd879ce3          	bne	a5,s8,1aca <gets+0x28>
  for(i=0; i+1 < max; ){
    1af6:	89a6                	mv	s3,s1
    1af8:	a011                	j	1afc <gets+0x5a>
    1afa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    1afc:	99de                	add	s3,s3,s7
    1afe:	00098023          	sb	zero,0(s3)
  return buf;
}
    1b02:	855e                	mv	a0,s7
    1b04:	60e6                	ld	ra,88(sp)
    1b06:	6446                	ld	s0,80(sp)
    1b08:	64a6                	ld	s1,72(sp)
    1b0a:	6906                	ld	s2,64(sp)
    1b0c:	79e2                	ld	s3,56(sp)
    1b0e:	7a42                	ld	s4,48(sp)
    1b10:	7aa2                	ld	s5,40(sp)
    1b12:	7b02                	ld	s6,32(sp)
    1b14:	6be2                	ld	s7,24(sp)
    1b16:	6c42                	ld	s8,16(sp)
    1b18:	6125                	addi	sp,sp,96
    1b1a:	8082                	ret

0000000000001b1c <stat>:

int
stat(const char *n, struct stat *st)
{
    1b1c:	1101                	addi	sp,sp,-32
    1b1e:	ec06                	sd	ra,24(sp)
    1b20:	e822                	sd	s0,16(sp)
    1b22:	e426                	sd	s1,8(sp)
    1b24:	e04a                	sd	s2,0(sp)
    1b26:	1000                	addi	s0,sp,32
    1b28:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1b2a:	4581                	li	a1,0
    1b2c:	00000097          	auipc	ra,0x0
    1b30:	188080e7          	jalr	392(ra) # 1cb4 <open>
  if(fd < 0)
    1b34:	02054563          	bltz	a0,1b5e <stat+0x42>
    1b38:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    1b3a:	85ca                	mv	a1,s2
    1b3c:	00000097          	auipc	ra,0x0
    1b40:	180080e7          	jalr	384(ra) # 1cbc <fstat>
    1b44:	892a                	mv	s2,a0
  close(fd);
    1b46:	8526                	mv	a0,s1
    1b48:	00000097          	auipc	ra,0x0
    1b4c:	154080e7          	jalr	340(ra) # 1c9c <close>
  return r;
}
    1b50:	854a                	mv	a0,s2
    1b52:	60e2                	ld	ra,24(sp)
    1b54:	6442                	ld	s0,16(sp)
    1b56:	64a2                	ld	s1,8(sp)
    1b58:	6902                	ld	s2,0(sp)
    1b5a:	6105                	addi	sp,sp,32
    1b5c:	8082                	ret
    return -1;
    1b5e:	597d                	li	s2,-1
    1b60:	bfc5                	j	1b50 <stat+0x34>

0000000000001b62 <atoi>:

int
atoi(const char *s)
{
    1b62:	1141                	addi	sp,sp,-16
    1b64:	e422                	sd	s0,8(sp)
    1b66:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
    1b68:	00054703          	lbu	a4,0(a0)
    1b6c:	02d00793          	li	a5,45
  int neg = 1;
    1b70:	4585                	li	a1,1
  if (*s == '-') {
    1b72:	04f70363          	beq	a4,a5,1bb8 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
    1b76:	00054703          	lbu	a4,0(a0)
    1b7a:	fd07079b          	addiw	a5,a4,-48
    1b7e:	0ff7f793          	zext.b	a5,a5
    1b82:	46a5                	li	a3,9
    1b84:	02f6ed63          	bltu	a3,a5,1bbe <atoi+0x5c>
  n = 0;
    1b88:	4681                	li	a3,0
  while('0' <= *s && *s <= '9')
    1b8a:	4625                	li	a2,9
    n = n*10 + *s++ - '0';
    1b8c:	0505                	addi	a0,a0,1
    1b8e:	0026979b          	slliw	a5,a3,0x2
    1b92:	9fb5                	addw	a5,a5,a3
    1b94:	0017979b          	slliw	a5,a5,0x1
    1b98:	9fb9                	addw	a5,a5,a4
    1b9a:	fd07869b          	addiw	a3,a5,-48
  while('0' <= *s && *s <= '9')
    1b9e:	00054703          	lbu	a4,0(a0)
    1ba2:	fd07079b          	addiw	a5,a4,-48
    1ba6:	0ff7f793          	zext.b	a5,a5
    1baa:	fef671e3          	bgeu	a2,a5,1b8c <atoi+0x2a>
  return n * neg;
}
    1bae:	02d5853b          	mulw	a0,a1,a3
    1bb2:	6422                	ld	s0,8(sp)
    1bb4:	0141                	addi	sp,sp,16
    1bb6:	8082                	ret
    s++;
    1bb8:	0505                	addi	a0,a0,1
    neg = -1;
    1bba:	55fd                	li	a1,-1
    1bbc:	bf6d                	j	1b76 <atoi+0x14>
  n = 0;
    1bbe:	4681                	li	a3,0
    1bc0:	b7fd                	j	1bae <atoi+0x4c>

0000000000001bc2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1bc2:	1141                	addi	sp,sp,-16
    1bc4:	e422                	sd	s0,8(sp)
    1bc6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    1bc8:	02b57463          	bgeu	a0,a1,1bf0 <memmove+0x2e>
    while(n-- > 0)
    1bcc:	00c05f63          	blez	a2,1bea <memmove+0x28>
    1bd0:	1602                	slli	a2,a2,0x20
    1bd2:	9201                	srli	a2,a2,0x20
    1bd4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    1bd8:	872a                	mv	a4,a0
      *dst++ = *src++;
    1bda:	0585                	addi	a1,a1,1
    1bdc:	0705                	addi	a4,a4,1
    1bde:	fff5c683          	lbu	a3,-1(a1)
    1be2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    1be6:	fee79ae3          	bne	a5,a4,1bda <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    1bea:	6422                	ld	s0,8(sp)
    1bec:	0141                	addi	sp,sp,16
    1bee:	8082                	ret
    dst += n;
    1bf0:	00c50733          	add	a4,a0,a2
    src += n;
    1bf4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    1bf6:	fec05ae3          	blez	a2,1bea <memmove+0x28>
    1bfa:	fff6079b          	addiw	a5,a2,-1
    1bfe:	1782                	slli	a5,a5,0x20
    1c00:	9381                	srli	a5,a5,0x20
    1c02:	fff7c793          	not	a5,a5
    1c06:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    1c08:	15fd                	addi	a1,a1,-1
    1c0a:	177d                	addi	a4,a4,-1
    1c0c:	0005c683          	lbu	a3,0(a1)
    1c10:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1c14:	fee79ae3          	bne	a5,a4,1c08 <memmove+0x46>
    1c18:	bfc9                	j	1bea <memmove+0x28>

0000000000001c1a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    1c1a:	1141                	addi	sp,sp,-16
    1c1c:	e422                	sd	s0,8(sp)
    1c1e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1c20:	ca05                	beqz	a2,1c50 <memcmp+0x36>
    1c22:	fff6069b          	addiw	a3,a2,-1
    1c26:	1682                	slli	a3,a3,0x20
    1c28:	9281                	srli	a3,a3,0x20
    1c2a:	0685                	addi	a3,a3,1
    1c2c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    1c2e:	00054783          	lbu	a5,0(a0)
    1c32:	0005c703          	lbu	a4,0(a1)
    1c36:	00e79863          	bne	a5,a4,1c46 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    1c3a:	0505                	addi	a0,a0,1
    p2++;
    1c3c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    1c3e:	fed518e3          	bne	a0,a3,1c2e <memcmp+0x14>
  }
  return 0;
    1c42:	4501                	li	a0,0
    1c44:	a019                	j	1c4a <memcmp+0x30>
      return *p1 - *p2;
    1c46:	40e7853b          	subw	a0,a5,a4
}
    1c4a:	6422                	ld	s0,8(sp)
    1c4c:	0141                	addi	sp,sp,16
    1c4e:	8082                	ret
  return 0;
    1c50:	4501                	li	a0,0
    1c52:	bfe5                	j	1c4a <memcmp+0x30>

0000000000001c54 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1c54:	1141                	addi	sp,sp,-16
    1c56:	e406                	sd	ra,8(sp)
    1c58:	e022                	sd	s0,0(sp)
    1c5a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    1c5c:	00000097          	auipc	ra,0x0
    1c60:	f66080e7          	jalr	-154(ra) # 1bc2 <memmove>
}
    1c64:	60a2                	ld	ra,8(sp)
    1c66:	6402                	ld	s0,0(sp)
    1c68:	0141                	addi	sp,sp,16
    1c6a:	8082                	ret

0000000000001c6c <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
    1c6c:	4885                	li	a7,1
 ecall
    1c6e:	00000073          	ecall
 ret
    1c72:	8082                	ret

0000000000001c74 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1c74:	4889                	li	a7,2
 ecall
    1c76:	00000073          	ecall
 ret
    1c7a:	8082                	ret

0000000000001c7c <wait>:
.global wait
wait:
 li a7, SYS_wait
    1c7c:	488d                	li	a7,3
 ecall
    1c7e:	00000073          	ecall
 ret
    1c82:	8082                	ret

0000000000001c84 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1c84:	4891                	li	a7,4
 ecall
    1c86:	00000073          	ecall
 ret
    1c8a:	8082                	ret

0000000000001c8c <read>:
.global read
read:
 li a7, SYS_read
    1c8c:	4895                	li	a7,5
 ecall
    1c8e:	00000073          	ecall
 ret
    1c92:	8082                	ret

0000000000001c94 <write>:
.global write
write:
 li a7, SYS_write
    1c94:	48c1                	li	a7,16
 ecall
    1c96:	00000073          	ecall
 ret
    1c9a:	8082                	ret

0000000000001c9c <close>:
.global close
close:
 li a7, SYS_close
    1c9c:	48d5                	li	a7,21
 ecall
    1c9e:	00000073          	ecall
 ret
    1ca2:	8082                	ret

0000000000001ca4 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1ca4:	4899                	li	a7,6
 ecall
    1ca6:	00000073          	ecall
 ret
    1caa:	8082                	ret

0000000000001cac <exec>:
.global exec
exec:
 li a7, SYS_exec
    1cac:	489d                	li	a7,7
 ecall
    1cae:	00000073          	ecall
 ret
    1cb2:	8082                	ret

0000000000001cb4 <open>:
.global open
open:
 li a7, SYS_open
    1cb4:	48bd                	li	a7,15
 ecall
    1cb6:	00000073          	ecall
 ret
    1cba:	8082                	ret

0000000000001cbc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1cbc:	48a1                	li	a7,8
 ecall
    1cbe:	00000073          	ecall
 ret
    1cc2:	8082                	ret

0000000000001cc4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1cc4:	48d1                	li	a7,20
 ecall
    1cc6:	00000073          	ecall
 ret
    1cca:	8082                	ret

0000000000001ccc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1ccc:	48a5                	li	a7,9
 ecall
    1cce:	00000073          	ecall
 ret
    1cd2:	8082                	ret

0000000000001cd4 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1cd4:	48a9                	li	a7,10
 ecall
    1cd6:	00000073          	ecall
 ret
    1cda:	8082                	ret

0000000000001cdc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1cdc:	48ad                	li	a7,11
 ecall
    1cde:	00000073          	ecall
 ret
    1ce2:	8082                	ret

0000000000001ce4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1ce4:	48b1                	li	a7,12
 ecall
    1ce6:	00000073          	ecall
 ret
    1cea:	8082                	ret

0000000000001cec <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1cec:	48b5                	li	a7,13
 ecall
    1cee:	00000073          	ecall
 ret
    1cf2:	8082                	ret

0000000000001cf4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1cf4:	48b9                	li	a7,14
 ecall
    1cf6:	00000073          	ecall
 ret
    1cfa:	8082                	ret

0000000000001cfc <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
    1cfc:	48d9                	li	a7,22
 ecall
    1cfe:	00000073          	ecall
 ret
    1d02:	8082                	ret

0000000000001d04 <dev>:
.global dev
dev:
 li a7, SYS_dev
    1d04:	48dd                	li	a7,23
 ecall
    1d06:	00000073          	ecall
 ret
    1d0a:	8082                	ret

0000000000001d0c <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
    1d0c:	48e1                	li	a7,24
 ecall
    1d0e:	00000073          	ecall
 ret
    1d12:	8082                	ret

0000000000001d14 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
    1d14:	48e5                	li	a7,25
 ecall
    1d16:	00000073          	ecall
 ret
    1d1a:	8082                	ret

0000000000001d1c <remove>:
.global remove
remove:
 li a7, SYS_remove
    1d1c:	48c5                	li	a7,17
 ecall
    1d1e:	00000073          	ecall
 ret
    1d22:	8082                	ret

0000000000001d24 <trace>:
.global trace
trace:
 li a7, SYS_trace
    1d24:	48c9                	li	a7,18
 ecall
    1d26:	00000073          	ecall
 ret
    1d2a:	8082                	ret

0000000000001d2c <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    1d2c:	48cd                	li	a7,19
 ecall
    1d2e:	00000073          	ecall
 ret
    1d32:	8082                	ret

0000000000001d34 <rename>:
.global rename
rename:
 li a7, SYS_rename
    1d34:	48e9                	li	a7,26
 ecall
    1d36:	00000073          	ecall
 ret
    1d3a:	8082                	ret

0000000000001d3c <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
    1d3c:	48ed                	li	a7,27
 ecall
    1d3e:	00000073          	ecall
 ret
    1d42:	8082                	ret

0000000000001d44 <sem_wait>:
.global sem_wait
sem_wait:
 li a7, SYS_sem_wait
    1d44:	48f1                	li	a7,28
 ecall
    1d46:	00000073          	ecall
 ret
    1d4a:	8082                	ret

0000000000001d4c <sem_post>:
.global sem_post
sem_post:
 li a7, SYS_sem_post
    1d4c:	48f5                	li	a7,29
 ecall
    1d4e:	00000073          	ecall
 ret
    1d52:	8082                	ret

0000000000001d54 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
    1d54:	48f9                	li	a7,30
 ecall
    1d56:	00000073          	ecall
 ret
    1d5a:	8082                	ret

0000000000001d5c <sem_getvalue>:
.global sem_getvalue
sem_getvalue:
 li a7, SYS_sem_getvalue
    1d5c:	48fd                	li	a7,31
 ecall
    1d5e:	00000073          	ecall
 ret
    1d62:	8082                	ret

0000000000001d64 <settickets>:
.global settickets
settickets:
 li a7, SYS_settickets
    1d64:	02000893          	li	a7,32
 ecall
    1d68:	00000073          	ecall
 ret
    1d6c:	8082                	ret

0000000000001d6e <getpinfo>:
.global getpinfo
getpinfo:
 li a7, SYS_getpinfo
    1d6e:	02100893          	li	a7,33
 ecall
    1d72:	00000073          	ecall
 ret
    1d76:	8082                	ret

0000000000001d78 <waitpid>:
.global waitpid
waitpid:
 li a7, SYS_waitpid
    1d78:	02200893          	li	a7,34
 ecall
    1d7c:	00000073          	ecall
 ret
    1d80:	8082                	ret

0000000000001d82 <shmcreate>:
.global shmcreate
shmcreate:
 li a7, SYS_shmcreate
    1d82:	02300893          	li	a7,35
 ecall
    1d86:	00000073          	ecall
 ret
    1d8a:	8082                	ret

0000000000001d8c <shmopen>:
.global shmopen
shmopen:
 li a7, SYS_shmopen
    1d8c:	02400893          	li	a7,36
 ecall
    1d90:	00000073          	ecall
 ret
    1d94:	8082                	ret

0000000000001d96 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
    1d96:	02500893          	li	a7,37
 ecall
    1d9a:	00000073          	ecall
 ret
    1d9e:	8082                	ret

0000000000001da0 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
    1da0:	02600893          	li	a7,38
 ecall
    1da4:	00000073          	ecall
 ret
    1da8:	8082                	ret

0000000000001daa <shmunlink>:
.global shmunlink
shmunlink:
 li a7, SYS_shmunlink
    1daa:	02700893          	li	a7,39
 ecall
    1dae:	00000073          	ecall
 ret
    1db2:	8082                	ret

0000000000001db4 <mmap>:
.global mmap
mmap:
 li a7, SYS_mmap
    1db4:	02800893          	li	a7,40
 ecall
    1db8:	00000073          	ecall
 ret
    1dbc:	8082                	ret

0000000000001dbe <munmap>:
.global munmap
munmap:
 li a7, SYS_munmap
    1dbe:	02900893          	li	a7,41
 ecall
    1dc2:	00000073          	ecall
 ret
    1dc6:	8082                	ret

0000000000001dc8 <kill2>:
.global kill2
kill2:
 li a7, SYS_kill2
    1dc8:	02a00893          	li	a7,42
 ecall
    1dcc:	00000073          	ecall
 ret
    1dd0:	8082                	ret

0000000000001dd2 <sigaction>:
.global sigaction
sigaction:
 li a7, SYS_sigaction
    1dd2:	02b00893          	li	a7,43
 ecall
    1dd6:	00000073          	ecall
 ret
    1dda:	8082                	ret

0000000000001ddc <sigreturn>:
.global sigreturn
sigreturn:
 li a7, SYS_sigreturn
    1ddc:	02c00893          	li	a7,44
 ecall
    1de0:	00000073          	ecall
 ret
    1de4:	8082                	ret

0000000000001de6 <lseek>:
.global lseek
lseek:
 li a7, SYS_lseek
    1de6:	02d00893          	li	a7,45
 ecall
    1dea:	00000073          	ecall
 ret
    1dee:	8082                	ret

0000000000001df0 <dup2>:
.global dup2
dup2:
 li a7, SYS_dup2
    1df0:	02e00893          	li	a7,46
 ecall
    1df4:	00000073          	ecall
 ret
    1df8:	8082                	ret

0000000000001dfa <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
    1dfa:	02f00893          	li	a7,47
 ecall
    1dfe:	00000073          	ecall
 ret
    1e02:	8082                	ret

0000000000001e04 <getuid>:
.global getuid
getuid:
 li a7, SYS_getuid
    1e04:	03000893          	li	a7,48
 ecall
    1e08:	00000073          	ecall
 ret
    1e0c:	8082                	ret

0000000000001e0e <setuid>:
.global setuid
setuid:
 li a7, SYS_setuid
    1e0e:	03100893          	li	a7,49
 ecall
    1e12:	00000073          	ecall
 ret
    1e16:	8082                	ret

0000000000001e18 <getgid>:
.global getgid
getgid:
 li a7, SYS_getgid
    1e18:	03200893          	li	a7,50
 ecall
    1e1c:	00000073          	ecall
 ret
    1e20:	8082                	ret

0000000000001e22 <setgid>:
.global setgid
setgid:
 li a7, SYS_setgid
    1e22:	03300893          	li	a7,51
 ecall
    1e26:	00000073          	ecall
 ret
    1e2a:	8082                	ret

0000000000001e2c <getpgid>:
.global getpgid
getpgid:
 li a7, SYS_getpgid
    1e2c:	03400893          	li	a7,52
 ecall
    1e30:	00000073          	ecall
 ret
    1e34:	8082                	ret

0000000000001e36 <setpgid>:
.global setpgid
setpgid:
 li a7, SYS_setpgid
    1e36:	03500893          	li	a7,53
 ecall
    1e3a:	00000073          	ecall
 ret
    1e3e:	8082                	ret

0000000000001e40 <tcgetpgrp>:
.global tcgetpgrp
tcgetpgrp:
 li a7, SYS_tcgetpgrp
    1e40:	03600893          	li	a7,54
 ecall
    1e44:	00000073          	ecall
 ret
    1e48:	8082                	ret

0000000000001e4a <tcsetpgrp>:
.global tcsetpgrp
tcsetpgrp:
 li a7, SYS_tcsetpgrp
    1e4a:	03700893          	li	a7,55
 ecall
    1e4e:	00000073          	ecall
 ret
    1e52:	8082                	ret

0000000000001e54 <pipe2>:
.global pipe2
pipe2:
 li a7, SYS_pipe2
    1e54:	03800893          	li	a7,56
 ecall
    1e58:	00000073          	ecall
 ret
    1e5c:	8082                	ret

0000000000001e5e <mincore>:
.global mincore
mincore:
 li a7, SYS_mincore
    1e5e:	03900893          	li	a7,57
 ecall
    1e62:	00000073          	ecall
 ret
    1e66:	8082                	ret

0000000000001e68 <alarm>:
.global alarm
alarm:
 li a7, SYS_alarm
    1e68:	03a00893          	li	a7,58
 ecall
    1e6c:	00000073          	ecall
 ret
    1e70:	8082                	ret

0000000000001e72 <poll>:
.global poll
poll:
 li a7, SYS_poll
    1e72:	03b00893          	li	a7,59
 ecall
    1e76:	00000073          	ecall
 ret
    1e7a:	8082                	ret

0000000000001e7c <fcntl>:
.global fcntl
fcntl:
 li a7, SYS_fcntl
    1e7c:	03c00893          	li	a7,60
 ecall
    1e80:	00000073          	ecall
 ret
    1e84:	8082                	ret

0000000000001e86 <chmod>:
.global chmod
chmod:
 li a7, SYS_chmod
    1e86:	03d00893          	li	a7,61
 ecall
    1e8a:	00000073          	ecall
 ret
    1e8e:	8082                	ret

0000000000001e90 <fchmod>:
.global fchmod
fchmod:
 li a7, SYS_fchmod
    1e90:	03e00893          	li	a7,62
 ecall
    1e94:	00000073          	ecall
 ret
    1e98:	8082                	ret

0000000000001e9a <clone>:
.global clone
clone:
 li a7, SYS_clone
    1e9a:	03f00893          	li	a7,63
 ecall
    1e9e:	00000073          	ecall
 ret
    1ea2:	8082                	ret

0000000000001ea4 <futex>:
.global futex
futex:
 li a7, SYS_futex
    1ea4:	04000893          	li	a7,64
 ecall
    1ea8:	00000073          	ecall
 ret
    1eac:	8082                	ret

0000000000001eae <exit_group>:
.global exit_group
exit_group:
 li a7, SYS_exit_group
    1eae:	04100893          	li	a7,65
 ecall
    1eb2:	00000073          	ecall
 ret
    1eb6:	8082                	ret

0000000000001eb8 <halt>:
.global halt
halt:
 li a7, SYS_halt
    1eb8:	04200893          	li	a7,66
 ecall
    1ebc:	00000073          	ecall
 ret
    1ec0:	8082                	ret

0000000000001ec2 <reboot>:
.global reboot
reboot:
 li a7, SYS_reboot
    1ec2:	04300893          	li	a7,67
 ecall
    1ec6:	00000073          	ecall
 ret
    1eca:	8082                	ret

0000000000001ecc <socket>:
.global socket
socket:
 li a7, SYS_socket
    1ecc:	04400893          	li	a7,68
 ecall
    1ed0:	00000073          	ecall
 ret
    1ed4:	8082                	ret

0000000000001ed6 <bind>:
.global bind
bind:
 li a7, SYS_bind
    1ed6:	04500893          	li	a7,69
 ecall
    1eda:	00000073          	ecall
 ret
    1ede:	8082                	ret

0000000000001ee0 <listen>:
.global listen
listen:
 li a7, SYS_listen
    1ee0:	04600893          	li	a7,70
 ecall
    1ee4:	00000073          	ecall
 ret
    1ee8:	8082                	ret

0000000000001eea <accept>:
.global accept
accept:
 li a7, SYS_accept
    1eea:	04700893          	li	a7,71
 ecall
    1eee:	00000073          	ecall
 ret
    1ef2:	8082                	ret

0000000000001ef4 <connect>:
.global connect
connect:
 li a7, SYS_connect
    1ef4:	04800893          	li	a7,72
 ecall
    1ef8:	00000073          	ecall
 ret
    1efc:	8082                	ret

0000000000001efe <send>:
.global send
send:
 li a7, SYS_send
    1efe:	04900893          	li	a7,73
 ecall
    1f02:	00000073          	ecall
 ret
    1f06:	8082                	ret

0000000000001f08 <recv>:
.global recv
recv:
 li a7, SYS_recv
    1f08:	04a00893          	li	a7,74
 ecall
    1f0c:	00000073          	ecall
 ret
    1f10:	8082                	ret

0000000000001f12 <netstat>:
.global netstat
netstat:
 li a7, SYS_netstat
    1f12:	04b00893          	li	a7,75
 ecall
    1f16:	00000073          	ecall
 ret
    1f1a:	8082                	ret

0000000000001f1c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1f1c:	1101                	addi	sp,sp,-32
    1f1e:	ec06                	sd	ra,24(sp)
    1f20:	e822                	sd	s0,16(sp)
    1f22:	1000                	addi	s0,sp,32
    1f24:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    1f28:	4605                	li	a2,1
    1f2a:	fef40593          	addi	a1,s0,-17
    1f2e:	00000097          	auipc	ra,0x0
    1f32:	d66080e7          	jalr	-666(ra) # 1c94 <write>
}
    1f36:	60e2                	ld	ra,24(sp)
    1f38:	6442                	ld	s0,16(sp)
    1f3a:	6105                	addi	sp,sp,32
    1f3c:	8082                	ret

0000000000001f3e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1f3e:	7139                	addi	sp,sp,-64
    1f40:	fc06                	sd	ra,56(sp)
    1f42:	f822                	sd	s0,48(sp)
    1f44:	f426                	sd	s1,40(sp)
    1f46:	f04a                	sd	s2,32(sp)
    1f48:	ec4e                	sd	s3,24(sp)
    1f4a:	0080                	addi	s0,sp,64
    1f4c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1f4e:	c299                	beqz	a3,1f54 <printint+0x16>
    1f50:	0805c863          	bltz	a1,1fe0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1f54:	2581                	sext.w	a1,a1
  neg = 0;
    1f56:	4881                	li	a7,0
  }

  i = 0;
    1f58:	fc040993          	addi	s3,s0,-64
  neg = 0;
    1f5c:	86ce                	mv	a3,s3
  i = 0;
    1f5e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    1f60:	2601                	sext.w	a2,a2
    1f62:	00000517          	auipc	a0,0x0
    1f66:	6c650513          	addi	a0,a0,1734 # 2628 <digits>
    1f6a:	883a                	mv	a6,a4
    1f6c:	2705                	addiw	a4,a4,1
    1f6e:	02c5f7bb          	remuw	a5,a1,a2
    1f72:	1782                	slli	a5,a5,0x20
    1f74:	9381                	srli	a5,a5,0x20
    1f76:	97aa                	add	a5,a5,a0
    1f78:	0007c783          	lbu	a5,0(a5)
    1f7c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1f80:	0005879b          	sext.w	a5,a1
    1f84:	02c5d5bb          	divuw	a1,a1,a2
    1f88:	0685                	addi	a3,a3,1
    1f8a:	fec7f0e3          	bgeu	a5,a2,1f6a <printint+0x2c>
  if(neg)
    1f8e:	00088c63          	beqz	a7,1fa6 <printint+0x68>
    buf[i++] = '-';
    1f92:	fd070793          	addi	a5,a4,-48
    1f96:	00878733          	add	a4,a5,s0
    1f9a:	02d00793          	li	a5,45
    1f9e:	fef70823          	sb	a5,-16(a4)
    1fa2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1fa6:	02e05663          	blez	a4,1fd2 <printint+0x94>
    1faa:	fc040913          	addi	s2,s0,-64
    1fae:	993a                	add	s2,s2,a4
    1fb0:	19fd                	addi	s3,s3,-1
    1fb2:	99ba                	add	s3,s3,a4
    1fb4:	377d                	addiw	a4,a4,-1
    1fb6:	1702                	slli	a4,a4,0x20
    1fb8:	9301                	srli	a4,a4,0x20
    1fba:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1fbe:	fff94583          	lbu	a1,-1(s2)
    1fc2:	8526                	mv	a0,s1
    1fc4:	00000097          	auipc	ra,0x0
    1fc8:	f58080e7          	jalr	-168(ra) # 1f1c <putc>
  while(--i >= 0)
    1fcc:	197d                	addi	s2,s2,-1
    1fce:	ff3918e3          	bne	s2,s3,1fbe <printint+0x80>
}
    1fd2:	70e2                	ld	ra,56(sp)
    1fd4:	7442                	ld	s0,48(sp)
    1fd6:	74a2                	ld	s1,40(sp)
    1fd8:	7902                	ld	s2,32(sp)
    1fda:	69e2                	ld	s3,24(sp)
    1fdc:	6121                	addi	sp,sp,64
    1fde:	8082                	ret
    x = -xx;
    1fe0:	40b005bb          	negw	a1,a1
    neg = 1;
    1fe4:	4885                	li	a7,1
    x = -xx;
    1fe6:	bf8d                	j	1f58 <printint+0x1a>

0000000000001fe8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1fe8:	7119                	addi	sp,sp,-128
    1fea:	fc86                	sd	ra,120(sp)
    1fec:	f8a2                	sd	s0,112(sp)
    1fee:	f4a6                	sd	s1,104(sp)
    1ff0:	f0ca                	sd	s2,96(sp)
    1ff2:	ecce                	sd	s3,88(sp)
    1ff4:	e8d2                	sd	s4,80(sp)
    1ff6:	e4d6                	sd	s5,72(sp)
    1ff8:	e0da                	sd	s6,64(sp)
    1ffa:	fc5e                	sd	s7,56(sp)
    1ffc:	f862                	sd	s8,48(sp)
    1ffe:	f466                	sd	s9,40(sp)
    2000:	f06a                	sd	s10,32(sp)
    2002:	ec6e                	sd	s11,24(sp)
    2004:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    2006:	0005c903          	lbu	s2,0(a1)
    200a:	18090f63          	beqz	s2,21a8 <vprintf+0x1c0>
    200e:	8aaa                	mv	s5,a0
    2010:	8b32                	mv	s6,a2
    2012:	00158493          	addi	s1,a1,1
  state = 0;
    2016:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    2018:	02500a13          	li	s4,37
    201c:	4c55                	li	s8,21
    201e:	00000c97          	auipc	s9,0x0
    2022:	5b2c8c93          	addi	s9,s9,1458 # 25d0 <malloc+0x324>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2026:	02800d93          	li	s11,40
  putc(fd, 'x');
    202a:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    202c:	00000b97          	auipc	s7,0x0
    2030:	5fcb8b93          	addi	s7,s7,1532 # 2628 <digits>
    2034:	a839                	j	2052 <vprintf+0x6a>
        putc(fd, c);
    2036:	85ca                	mv	a1,s2
    2038:	8556                	mv	a0,s5
    203a:	00000097          	auipc	ra,0x0
    203e:	ee2080e7          	jalr	-286(ra) # 1f1c <putc>
    2042:	a019                	j	2048 <vprintf+0x60>
    } else if(state == '%'){
    2044:	01498d63          	beq	s3,s4,205e <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    2048:	0485                	addi	s1,s1,1
    204a:	fff4c903          	lbu	s2,-1(s1)
    204e:	14090d63          	beqz	s2,21a8 <vprintf+0x1c0>
    if(state == 0){
    2052:	fe0999e3          	bnez	s3,2044 <vprintf+0x5c>
      if(c == '%'){
    2056:	ff4910e3          	bne	s2,s4,2036 <vprintf+0x4e>
        state = '%';
    205a:	89d2                	mv	s3,s4
    205c:	b7f5                	j	2048 <vprintf+0x60>
      if(c == 'd'){
    205e:	11490c63          	beq	s2,s4,2176 <vprintf+0x18e>
    2062:	f9d9079b          	addiw	a5,s2,-99
    2066:	0ff7f793          	zext.b	a5,a5
    206a:	10fc6e63          	bltu	s8,a5,2186 <vprintf+0x19e>
    206e:	f9d9079b          	addiw	a5,s2,-99
    2072:	0ff7f713          	zext.b	a4,a5
    2076:	10ec6863          	bltu	s8,a4,2186 <vprintf+0x19e>
    207a:	00271793          	slli	a5,a4,0x2
    207e:	97e6                	add	a5,a5,s9
    2080:	439c                	lw	a5,0(a5)
    2082:	97e6                	add	a5,a5,s9
    2084:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    2086:	008b0913          	addi	s2,s6,8
    208a:	4685                	li	a3,1
    208c:	4629                	li	a2,10
    208e:	000b2583          	lw	a1,0(s6)
    2092:	8556                	mv	a0,s5
    2094:	00000097          	auipc	ra,0x0
    2098:	eaa080e7          	jalr	-342(ra) # 1f3e <printint>
    209c:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    209e:	4981                	li	s3,0
    20a0:	b765                	j	2048 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    20a2:	008b0913          	addi	s2,s6,8
    20a6:	4681                	li	a3,0
    20a8:	4629                	li	a2,10
    20aa:	000b2583          	lw	a1,0(s6)
    20ae:	8556                	mv	a0,s5
    20b0:	00000097          	auipc	ra,0x0
    20b4:	e8e080e7          	jalr	-370(ra) # 1f3e <printint>
    20b8:	8b4a                	mv	s6,s2
      state = 0;
    20ba:	4981                	li	s3,0
    20bc:	b771                	j	2048 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    20be:	008b0913          	addi	s2,s6,8
    20c2:	4681                	li	a3,0
    20c4:	866a                	mv	a2,s10
    20c6:	000b2583          	lw	a1,0(s6)
    20ca:	8556                	mv	a0,s5
    20cc:	00000097          	auipc	ra,0x0
    20d0:	e72080e7          	jalr	-398(ra) # 1f3e <printint>
    20d4:	8b4a                	mv	s6,s2
      state = 0;
    20d6:	4981                	li	s3,0
    20d8:	bf85                	j	2048 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    20da:	008b0793          	addi	a5,s6,8
    20de:	f8f43423          	sd	a5,-120(s0)
    20e2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    20e6:	03000593          	li	a1,48
    20ea:	8556                	mv	a0,s5
    20ec:	00000097          	auipc	ra,0x0
    20f0:	e30080e7          	jalr	-464(ra) # 1f1c <putc>
  putc(fd, 'x');
    20f4:	07800593          	li	a1,120
    20f8:	8556                	mv	a0,s5
    20fa:	00000097          	auipc	ra,0x0
    20fe:	e22080e7          	jalr	-478(ra) # 1f1c <putc>
    2102:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    2104:	03c9d793          	srli	a5,s3,0x3c
    2108:	97de                	add	a5,a5,s7
    210a:	0007c583          	lbu	a1,0(a5)
    210e:	8556                	mv	a0,s5
    2110:	00000097          	auipc	ra,0x0
    2114:	e0c080e7          	jalr	-500(ra) # 1f1c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    2118:	0992                	slli	s3,s3,0x4
    211a:	397d                	addiw	s2,s2,-1
    211c:	fe0914e3          	bnez	s2,2104 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    2120:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    2124:	4981                	li	s3,0
    2126:	b70d                	j	2048 <vprintf+0x60>
        s = va_arg(ap, char*);
    2128:	008b0913          	addi	s2,s6,8
    212c:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    2130:	02098163          	beqz	s3,2152 <vprintf+0x16a>
        while(*s != 0){
    2134:	0009c583          	lbu	a1,0(s3)
    2138:	c5ad                	beqz	a1,21a2 <vprintf+0x1ba>
          putc(fd, *s);
    213a:	8556                	mv	a0,s5
    213c:	00000097          	auipc	ra,0x0
    2140:	de0080e7          	jalr	-544(ra) # 1f1c <putc>
          s++;
    2144:	0985                	addi	s3,s3,1
        while(*s != 0){
    2146:	0009c583          	lbu	a1,0(s3)
    214a:	f9e5                	bnez	a1,213a <vprintf+0x152>
        s = va_arg(ap, char*);
    214c:	8b4a                	mv	s6,s2
      state = 0;
    214e:	4981                	li	s3,0
    2150:	bde5                	j	2048 <vprintf+0x60>
          s = "(null)";
    2152:	00000997          	auipc	s3,0x0
    2156:	47698993          	addi	s3,s3,1142 # 25c8 <malloc+0x31c>
        while(*s != 0){
    215a:	85ee                	mv	a1,s11
    215c:	bff9                	j	213a <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    215e:	008b0913          	addi	s2,s6,8
    2162:	000b4583          	lbu	a1,0(s6)
    2166:	8556                	mv	a0,s5
    2168:	00000097          	auipc	ra,0x0
    216c:	db4080e7          	jalr	-588(ra) # 1f1c <putc>
    2170:	8b4a                	mv	s6,s2
      state = 0;
    2172:	4981                	li	s3,0
    2174:	bdd1                	j	2048 <vprintf+0x60>
        putc(fd, c);
    2176:	85d2                	mv	a1,s4
    2178:	8556                	mv	a0,s5
    217a:	00000097          	auipc	ra,0x0
    217e:	da2080e7          	jalr	-606(ra) # 1f1c <putc>
      state = 0;
    2182:	4981                	li	s3,0
    2184:	b5d1                	j	2048 <vprintf+0x60>
        putc(fd, '%');
    2186:	85d2                	mv	a1,s4
    2188:	8556                	mv	a0,s5
    218a:	00000097          	auipc	ra,0x0
    218e:	d92080e7          	jalr	-622(ra) # 1f1c <putc>
        putc(fd, c);
    2192:	85ca                	mv	a1,s2
    2194:	8556                	mv	a0,s5
    2196:	00000097          	auipc	ra,0x0
    219a:	d86080e7          	jalr	-634(ra) # 1f1c <putc>
      state = 0;
    219e:	4981                	li	s3,0
    21a0:	b565                	j	2048 <vprintf+0x60>
        s = va_arg(ap, char*);
    21a2:	8b4a                	mv	s6,s2
      state = 0;
    21a4:	4981                	li	s3,0
    21a6:	b54d                	j	2048 <vprintf+0x60>
    }
  }
}
    21a8:	70e6                	ld	ra,120(sp)
    21aa:	7446                	ld	s0,112(sp)
    21ac:	74a6                	ld	s1,104(sp)
    21ae:	7906                	ld	s2,96(sp)
    21b0:	69e6                	ld	s3,88(sp)
    21b2:	6a46                	ld	s4,80(sp)
    21b4:	6aa6                	ld	s5,72(sp)
    21b6:	6b06                	ld	s6,64(sp)
    21b8:	7be2                	ld	s7,56(sp)
    21ba:	7c42                	ld	s8,48(sp)
    21bc:	7ca2                	ld	s9,40(sp)
    21be:	7d02                	ld	s10,32(sp)
    21c0:	6de2                	ld	s11,24(sp)
    21c2:	6109                	addi	sp,sp,128
    21c4:	8082                	ret

00000000000021c6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    21c6:	715d                	addi	sp,sp,-80
    21c8:	ec06                	sd	ra,24(sp)
    21ca:	e822                	sd	s0,16(sp)
    21cc:	1000                	addi	s0,sp,32
    21ce:	e010                	sd	a2,0(s0)
    21d0:	e414                	sd	a3,8(s0)
    21d2:	e818                	sd	a4,16(s0)
    21d4:	ec1c                	sd	a5,24(s0)
    21d6:	03043023          	sd	a6,32(s0)
    21da:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    21de:	8622                	mv	a2,s0
    21e0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    21e4:	00000097          	auipc	ra,0x0
    21e8:	e04080e7          	jalr	-508(ra) # 1fe8 <vprintf>
}
    21ec:	60e2                	ld	ra,24(sp)
    21ee:	6442                	ld	s0,16(sp)
    21f0:	6161                	addi	sp,sp,80
    21f2:	8082                	ret

00000000000021f4 <printf>:

void
printf(const char *fmt, ...)
{
    21f4:	711d                	addi	sp,sp,-96
    21f6:	ec06                	sd	ra,24(sp)
    21f8:	e822                	sd	s0,16(sp)
    21fa:	1000                	addi	s0,sp,32
    21fc:	e40c                	sd	a1,8(s0)
    21fe:	e810                	sd	a2,16(s0)
    2200:	ec14                	sd	a3,24(s0)
    2202:	f018                	sd	a4,32(s0)
    2204:	f41c                	sd	a5,40(s0)
    2206:	03043823          	sd	a6,48(s0)
    220a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    220e:	00840613          	addi	a2,s0,8
    2212:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    2216:	85aa                	mv	a1,a0
    2218:	4505                	li	a0,1
    221a:	00000097          	auipc	ra,0x0
    221e:	dce080e7          	jalr	-562(ra) # 1fe8 <vprintf>
}
    2222:	60e2                	ld	ra,24(sp)
    2224:	6442                	ld	s0,16(sp)
    2226:	6125                	addi	sp,sp,96
    2228:	8082                	ret

000000000000222a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    222a:	1141                	addi	sp,sp,-16
    222c:	e422                	sd	s0,8(sp)
    222e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    2230:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2234:	00001797          	auipc	a5,0x1
    2238:	5347b783          	ld	a5,1332(a5) # 3768 <freep>
    223c:	a02d                	j	2266 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    223e:	4618                	lw	a4,8(a2)
    2240:	9f2d                	addw	a4,a4,a1
    2242:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    2246:	6398                	ld	a4,0(a5)
    2248:	6310                	ld	a2,0(a4)
    224a:	a83d                	j	2288 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    224c:	ff852703          	lw	a4,-8(a0)
    2250:	9f31                	addw	a4,a4,a2
    2252:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    2254:	ff053683          	ld	a3,-16(a0)
    2258:	a091                	j	229c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    225a:	6398                	ld	a4,0(a5)
    225c:	00e7e463          	bltu	a5,a4,2264 <free+0x3a>
    2260:	00e6ea63          	bltu	a3,a4,2274 <free+0x4a>
{
    2264:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2266:	fed7fae3          	bgeu	a5,a3,225a <free+0x30>
    226a:	6398                	ld	a4,0(a5)
    226c:	00e6e463          	bltu	a3,a4,2274 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2270:	fee7eae3          	bltu	a5,a4,2264 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    2274:	ff852583          	lw	a1,-8(a0)
    2278:	6390                	ld	a2,0(a5)
    227a:	02059813          	slli	a6,a1,0x20
    227e:	01c85713          	srli	a4,a6,0x1c
    2282:	9736                	add	a4,a4,a3
    2284:	fae60de3          	beq	a2,a4,223e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    2288:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    228c:	4790                	lw	a2,8(a5)
    228e:	02061593          	slli	a1,a2,0x20
    2292:	01c5d713          	srli	a4,a1,0x1c
    2296:	973e                	add	a4,a4,a5
    2298:	fae68ae3          	beq	a3,a4,224c <free+0x22>
    p->s.ptr = bp->s.ptr;
    229c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    229e:	00001717          	auipc	a4,0x1
    22a2:	4cf73523          	sd	a5,1226(a4) # 3768 <freep>
}
    22a6:	6422                	ld	s0,8(sp)
    22a8:	0141                	addi	sp,sp,16
    22aa:	8082                	ret

00000000000022ac <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    22ac:	7139                	addi	sp,sp,-64
    22ae:	fc06                	sd	ra,56(sp)
    22b0:	f822                	sd	s0,48(sp)
    22b2:	f426                	sd	s1,40(sp)
    22b4:	f04a                	sd	s2,32(sp)
    22b6:	ec4e                	sd	s3,24(sp)
    22b8:	e852                	sd	s4,16(sp)
    22ba:	e456                	sd	s5,8(sp)
    22bc:	e05a                	sd	s6,0(sp)
    22be:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    22c0:	02051493          	slli	s1,a0,0x20
    22c4:	9081                	srli	s1,s1,0x20
    22c6:	04bd                	addi	s1,s1,15
    22c8:	8091                	srli	s1,s1,0x4
    22ca:	00148a1b          	addiw	s4,s1,1
    22ce:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    22d0:	00001517          	auipc	a0,0x1
    22d4:	49853503          	ld	a0,1176(a0) # 3768 <freep>
    22d8:	c515                	beqz	a0,2304 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    22da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    22dc:	4798                	lw	a4,8(a5)
    22de:	04977163          	bgeu	a4,s1,2320 <malloc+0x74>
    22e2:	89d2                	mv	s3,s4
    22e4:	000a071b          	sext.w	a4,s4
    22e8:	6685                	lui	a3,0x1
    22ea:	00d77363          	bgeu	a4,a3,22f0 <malloc+0x44>
    22ee:	6985                	lui	s3,0x1
    22f0:	00098b1b          	sext.w	s6,s3
  p = sbrk(nu * sizeof(Header));
    22f4:	0049999b          	slliw	s3,s3,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    22f8:	00001917          	auipc	s2,0x1
    22fc:	47090913          	addi	s2,s2,1136 # 3768 <freep>
  if(p == (char*)-1)
    2300:	5afd                	li	s5,-1
    2302:	a8a5                	j	237a <malloc+0xce>
    base.s.ptr = freep = prevp = &base;
    2304:	00001797          	auipc	a5,0x1
    2308:	46478793          	addi	a5,a5,1124 # 3768 <freep>
    230c:	00001717          	auipc	a4,0x1
    2310:	46470713          	addi	a4,a4,1124 # 3770 <base>
    2314:	e398                	sd	a4,0(a5)
    2316:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    2318:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    231c:	87ba                	mv	a5,a4
    231e:	b7d1                	j	22e2 <malloc+0x36>
      if(p->s.size == nunits)
    2320:	02e48c63          	beq	s1,a4,2358 <malloc+0xac>
        p->s.size -= nunits;
    2324:	4147073b          	subw	a4,a4,s4
    2328:	c798                	sw	a4,8(a5)
        p += p->s.size;
    232a:	02071693          	slli	a3,a4,0x20
    232e:	01c6d713          	srli	a4,a3,0x1c
    2332:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    2334:	0147a423          	sw	s4,8(a5)
      freep = prevp;
    2338:	00001717          	auipc	a4,0x1
    233c:	42a73823          	sd	a0,1072(a4) # 3768 <freep>
      return (void*)(p + 1);
    2340:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    2344:	70e2                	ld	ra,56(sp)
    2346:	7442                	ld	s0,48(sp)
    2348:	74a2                	ld	s1,40(sp)
    234a:	7902                	ld	s2,32(sp)
    234c:	69e2                	ld	s3,24(sp)
    234e:	6a42                	ld	s4,16(sp)
    2350:	6aa2                	ld	s5,8(sp)
    2352:	6b02                	ld	s6,0(sp)
    2354:	6121                	addi	sp,sp,64
    2356:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    2358:	6398                	ld	a4,0(a5)
    235a:	e118                	sd	a4,0(a0)
    235c:	bff1                	j	2338 <malloc+0x8c>
  hp->s.size = nu;
    235e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    2362:	0541                	addi	a0,a0,16
    2364:	00000097          	auipc	ra,0x0
    2368:	ec6080e7          	jalr	-314(ra) # 222a <free>
  return freep;
    236c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    2370:	d971                	beqz	a0,2344 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2372:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    2374:	4798                	lw	a4,8(a5)
    2376:	fa9775e3          	bgeu	a4,s1,2320 <malloc+0x74>
    if(p == freep)
    237a:	00093703          	ld	a4,0(s2)
    237e:	853e                	mv	a0,a5
    2380:	fef719e3          	bne	a4,a5,2372 <malloc+0xc6>
  p = sbrk(nu * sizeof(Header));
    2384:	854e                	mv	a0,s3
    2386:	00000097          	auipc	ra,0x0
    238a:	95e080e7          	jalr	-1698(ra) # 1ce4 <sbrk>
  if(p == (char*)-1)
    238e:	fd5518e3          	bne	a0,s5,235e <malloc+0xb2>
        return 0;
    2392:	4501                	li	a0,0
    2394:	bf45                	j	2344 <malloc+0x98>
