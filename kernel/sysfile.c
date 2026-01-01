//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//


#include "include/types.h"
#include "include/riscv.h"
#include "include/param.h"
#include "include/stat.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/sleeplock.h"
#include "include/file.h"
#include "include/pipe.h"
#include "include/fcntl.h"
#include "include/fat32.h"
#include "include/syscall.h"
#include "include/string.h"
#include "include/printf.h"
#include "include/vm.h"
#include "include/memlayout.h"
#include "include/kalloc.h"

// Forward declarations for vm.c internal functions
pte_t *walk(pagetable_t pagetable, uint64 va, int alloc);

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == NULL)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *p = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

uint64
sys_dup(void)
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

uint64
sys_read(void)
{
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    return -1;
  return fileread(f, p, n);
}

uint64
sys_write(void)
{
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    return -1;

  return filewrite(f, p, n);
}

uint64
sys_close(void)
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}

uint64
sys_fstat(void)
{
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    return -1;
  return filestat(f, st);
}

// V2.2: lseek - 文件定位
// lseek(fd, offset, whence) - SEEK_SET=0, SEEK_CUR=1, SEEK_END=2
uint64
sys_lseek(void)
{
  struct file *f;
  int offset, whence;

  if(argfd(0, 0, &f) < 0 || argint(1, &offset) < 0 || argint(2, &whence) < 0)
    return -1;
  
  // 只支持常规文件
  if(f->type != FD_ENTRY)
    return -1;
  
  int newoff;
  switch(whence) {
    case 0:  // SEEK_SET
      newoff = offset;
      break;
    case 1:  // SEEK_CUR
      newoff = f->off + offset;
      break;
    case 2:  // SEEK_END
      newoff = f->ep->file_size + offset;
      break;
    default:
      return -1;
  }
  
  // 检查边界
  if(newoff < 0)
    return -1;
  
  f->off = newoff;
  return newoff;
}

// V2.2: dup2 - 复制文件描述符到指定槽
// dup2(oldfd, newfd)
uint64
sys_dup2(void)
{
  struct file *f;
  int newfd;
  struct proc *p = myproc();

  if(argfd(0, 0, &f) < 0 || argint(1, &newfd) < 0)
    return -1;
  
  // 验证 newfd 范围
  if(newfd < 0 || newfd >= NOFILE)
    return -1;
  
  // 如果 oldfd == newfd，直接返回
  for(int fd = 0; fd < NOFILE; fd++) {
    if(p->ofile[fd] == f && fd == newfd)
      return newfd;
  }
  
  // 如果 newfd 已打开，先关闭
  if(p->ofile[newfd])
    fileclose(p->ofile[newfd]);
  
  // 复制到 newfd
  p->ofile[newfd] = f;
  filedup(f);
  return newfd;
}

static struct dirent*
create(char *path, short type, int mode)
{
  struct dirent *ep, *dp;
  char name[FAT32_MAX_FILENAME + 1];

  if((dp = enameparent(path, name)) == NULL)
    return NULL;

  if (type == T_DIR) {
    mode = ATTR_DIRECTORY;
  } else if (mode & O_RDONLY) {
    mode = ATTR_READ_ONLY;
  } else {
    mode = 0;  
  }

  elock(dp);
  if ((ep = ealloc(dp, name, mode)) == NULL) {
    eunlock(dp);
    eput(dp);
    return NULL;
  }
  
  if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
      (type == T_FILE && (ep->attribute & ATTR_DIRECTORY))) {
    eunlock(dp);
    eput(ep);
    eput(dp);
    return NULL;
  }

  eunlock(dp);
  eput(dp);

  elock(ep);
  return ep;
}

uint64
sys_open(void)
{
  char path[FAT32_MAX_PATH];
  int fd, omode;
  struct file *f;
  struct dirent *ep;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argint(1, &omode) < 0)
    return -1;

  // Handle device files: /dev/null and /dev/zero
  if(strncmp("/dev/null", path, 9) == 0) {
    if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0) {
      if(f)
        fileclose(f);
      return -1;
    }
    f->type = FD_DEVICE;
    f->off = 0;
    f->ep = 0;
    f->major = NULL_DEV;
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    return fd;
  }
  
  if(strncmp("/dev/zero", path, 9) == 0) {
    if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0) {
      if(f)
        fileclose(f);
      return -1;
    }
    f->type = FD_DEVICE;
    f->off = 0;
    f->ep = 0;
    f->major = ZERO_DEV;
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    return fd;
  }

  if(omode & O_CREATE){
    ep = create(path, T_FILE, omode);
    if(ep == NULL){
      return -1;
    }
  } else {
    if((ep = ename(path)) == NULL){
      return -1;
    }
    elock(ep);
    if((ep->attribute & ATTR_DIRECTORY) && omode != O_RDONLY){
      eunlock(ep);
      eput(ep);
      return -1;
    }
  }

  if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    if (f) {
      fileclose(f);
    }
    eunlock(ep);
    eput(ep);
    return -1;
  }

  if(!(ep->attribute & ATTR_DIRECTORY) && (omode & O_TRUNC)){
    etrunc(ep);
  }

  f->type = FD_ENTRY;
  f->off = (omode & O_APPEND) ? ep->file_size : 0;
  f->ep = ep;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f->flags = omode;  // V3.0 (Task 12)

  eunlock(ep);

  return fd;
}

uint64
sys_mkdir(void)
{
  char path[FAT32_MAX_PATH];
  struct dirent *ep;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    return -1;
  }
  eunlock(ep);
  eput(ep);
  return 0;
}

uint64
sys_chdir(void)
{
  char path[FAT32_MAX_PATH];
  struct dirent *ep;
  struct proc *p = myproc();
  
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    return -1;
  }
  elock(ep);
  if(!(ep->attribute & ATTR_DIRECTORY)){
    eunlock(ep);
    eput(ep);
    return -1;
  }
  eunlock(ep);
  eput(p->cwd);
  p->cwd = ep;
  return 0;
}

uint64
sys_pipe(void)
{
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();

  if(argaddr(0, &fdarray) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  // V3.0 (Task 12): 显式初始化 flags 为 0，避免垃圾值被误识别为 O_NONBLOCK
  rf->flags = 0;
  wf->flags = 0;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  // if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
  //    copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
  if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
     copyout2(fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    p->ofile[fd0] = 0;
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
}

// V3.0 (Task 12): pipe2(int pipefd[2], int flags)
uint64
sys_pipe2(void)
{
  uint64 fdarray; // user pointer to array of two integers
  int flags;
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();

  if(argaddr(0, &fdarray) < 0 || argint(1, &flags) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  
  // Apply flags
  rf->flags = flags;
  wf->flags = flags;

  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
     copyout2(fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    p->ofile[fd0] = 0;
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
}

// To open console device.
uint64
sys_dev(void)
{
  int fd, omode;
  int major, minor;
  struct file *f;

  if(argint(0, &omode) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0){
    return -1;
  }

  if(omode & O_CREATE){
    panic("dev file on FAT");
  }

  if(major < 0 || major >= NDEV)
    return -1;

  if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    return -1;
  }

  f->type = FD_DEVICE;
  f->off = 0;
  f->ep = 0;
  f->major = major;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
}

// To support ls command
uint64
sys_readdir(void)
{
  struct file *f;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    return -1;
  return dirnext(f, p);
}

// get absolute cwd string
uint64
sys_getcwd(void)
{
  uint64 addr;
  if (argaddr(0, &addr) < 0)
    return -1;

  struct dirent *de = myproc()->cwd;
  char path[FAT32_MAX_PATH];
  char *s;
  int len;

  if (de->parent == NULL) {
    s = "/";
  } else {
    s = path + FAT32_MAX_PATH - 1;
    *s = '\0';
    while (de->parent) {
      len = strlen(de->filename);
      s -= len;
      if (s <= path)          // can't reach root "/"
        return -1;
      strncpy(s, de->filename, len);
      *--s = '/';
      de = de->parent;
    }
  }

  // if (copyout(myproc()->pagetable, addr, s, strlen(s) + 1) < 0)
  if (copyout2(addr, s, strlen(s) + 1) < 0)
    return -1;
  
  return 0;

}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct dirent *dp)
{
  struct dirent ep;
  int count;
  int ret;
  ep.valid = 0;
  ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
  return ret == -1;
}

uint64
sys_remove(void)
{
  char path[FAT32_MAX_PATH];
  struct dirent *ep;
  int len;
  if((len = argstr(0, path, FAT32_MAX_PATH)) <= 0)
    return -1;

  char *s = path + len - 1;
  while (s >= path && *s == '/') {
    s--;
  }
  if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    return -1;
  }
  
  if((ep = ename(path)) == NULL){
    return -1;
  }
  elock(ep);
  if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
      eunlock(ep);
      eput(ep);
      return -1;
  }
  elock(ep->parent);      // Will this lead to deadlock?
  eremove(ep);
  eunlock(ep->parent);
  eunlock(ep);
  eput(ep);

  return 0;
}

// V2.0.1 修复：基于地址的锁排序，防止死锁
// 规则：总是先锁地址较小的 dirent，后锁地址较大的
// Because this op takes some steps, we can't promise atomicity
uint64
sys_rename(void)
{
  char old[FAT32_MAX_PATH], new[FAT32_MAX_PATH];
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
      return -1;
  }

  struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
  int srclock = 0, pdstlock = 0;
  char *name;
  if ((src = ename(old)) == NULL || (pdst = enameparent(new, old)) == NULL
      || (name = formatname(old)) == NULL) {
    goto fail;          // src doesn't exist || dst parent doesn't exist || illegal new name
  }
  
  // 检查循环引用：不能将目录移动到其子目录中
  for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    if (ep == src) {
      goto fail;
    }
  }

  // V2.0.1 锁排序：基于地址顺序获取锁，防止死锁
  // 规则：地址小的先锁
  uint off;
  if ((uint64)src < (uint64)pdst) {
    elock(src);
    srclock = 1;
    elock(pdst);
    pdstlock = 1;
  } else {
    elock(pdst);
    pdstlock = 1;
    elock(src);
    srclock = 1;
  }
  
  dst = dirlookup(pdst, name, &off);
  if (dst != NULL) {
    if (src == dst) {
      goto fail;
    } else if (src->attribute & dst->attribute & ATTR_DIRECTORY) {
      elock(dst);
      if (!isdirempty(dst)) {
        eunlock(dst);
        goto fail;
      }
      // dst 锁持有继续
    } else {
      // src is not a dir || dst exists and is not a dir
      goto fail;
    }
  }

  if (dst) {
    eremove(dst);
    eunlock(dst);
  }
  memmove(src->filename, name, FAT32_MAX_FILENAME);
  emake(pdst, src, off);
  
  // 处理 src 的父目录锁
  struct dirent *psrc = src->parent;
  if (psrc != pdst) {
    // 需要锁 psrc，但要保持锁顺序
    eunlock(pdst);
    pdstlock = 0;
    if (psrc != src) {  // 防止自锁
      elock(psrc);
      eremove(src);
      eunlock(psrc);
    }
  } else {
    // psrc == pdst，已持锁
    eremove(src);
  }
  
  src->parent = edup(pdst);
  src->off = off;
  src->valid = 1;
  
  if (srclock) {
    eunlock(src);
    srclock = 0;
  }
  if (pdstlock) {
    eunlock(pdst);
    pdstlock = 0;
  }

  eput(psrc);
  if (dst) {
    eput(dst);
  }
  eput(pdst);
  eput(src);

  return 0;

fail:
  if (srclock)
    eunlock(src);
  if (pdstlock)
    eunlock(pdst);
  if (dst)
    eput(dst);
  if (pdst)
    eput(pdst);
  if (src)
    eput(src);
  return -1;
}

// V2.0.2: mmap implementation
// Maps a file or anonymous memory into the process's virtual address space
// mmap 区域从 MMAPBASE 开始，向高地址增长，不影响 p->sz
#define MMAPBASE 0x40000000  // 1GB - mmap 起始地址

uint64
sys_mmap(void)
{
  uint64 addr;
  uint64 len;
  int prot, flags, fd;
  uint64 offset;
  struct proc *p = myproc();
  struct file *f = 0;
  
  // 获取参数: mmap(addr, len, prot, flags, fd, offset)
  if(argaddr(0, &addr) < 0 || argaddr(1, &len) < 0 || 
     argint(2, &prot) < 0 || argint(3, &flags) < 0 ||
     argint(4, &fd) < 0 || argaddr(5, &offset) < 0)
    return -1;
  
  // 验证长度
  if(len == 0)
    return -1;
  
  // 处理文件映射 vs 匿名映射
  if(!(flags & MAP_ANONYMOUS)) {
    // 文件映射：获取文件
    if(fd < 0 || fd >= NOFILE || (f = p->ofile[fd]) == 0)
      return -1;
    
    // 检查权限兼容性
    if((prot & PROT_READ) && !f->readable)
      return -1;
    if((prot & PROT_WRITE) && (flags & MAP_SHARED) && !f->writable)
      return -1;
  }
  
  // 找到一个空闲的 VMA 槽
  struct vma *vma = 0;
  for(int i = 0; i < MAX_VMA; i++) {
    if(!p->vmas[i].valid) {
      vma = &p->vmas[i];
      break;
    }
  }
  if(vma == 0)
    return -1;  // 没有空闲 VMA 槽
  
  // 分配虚拟地址空间
  // 使用 MMAPBASE 开始的区域，不修改 p->sz
  len = PGROUNDUP(len);
  
  // 查找最高的已分配 mmap 地址
  uint64 va = MMAPBASE;
  for(int i = 0; i < MAX_VMA; i++) {
    if(p->vmas[i].valid && p->vmas[i].addr + p->vmas[i].len > va) {
      va = p->vmas[i].addr + p->vmas[i].len;
    }
  }
  va = PGROUNDUP(va);
  
  // 确保不会与 TRAPFRAME 冲突
  if(va + len > TRAPFRAME)
    return -1;
  
  // 初始化 VMA
  vma->addr = va;
  vma->len = len;
  vma->prot = prot;
  vma->flags = flags;
  vma->offset = offset;
  vma->valid = 1;
  
  if(f) {
    vma->f = f;
    filedup(f);  // 增加文件引用计数
  } else {
    vma->f = 0;  // 匿名映射
  }
  
  // 不再修改 p->sz，mmap 区域与堆分离
  
  return va;
}

// V2.0.2: munmap implementation
// Unmaps a previously mapped region
uint64
sys_munmap(void)
{
  uint64 addr;
  uint64 len;
  struct proc *p = myproc();
  
  if(argaddr(0, &addr) < 0 || argaddr(1, &len) < 0)
    return -1;
  
  if(len == 0)
    return 0;
  
  len = PGROUNDUP(len);
  addr = PGROUNDDOWN(addr);
  
  // 找到对应的 VMA
  struct vma *vma = 0;
  for(int i = 0; i < MAX_VMA; i++) {
    if(p->vmas[i].valid && 
       addr >= p->vmas[i].addr && 
       addr < p->vmas[i].addr + p->vmas[i].len) {
      vma = &p->vmas[i];
      break;
    }
  }
  
  if(vma == 0)
    return -1;  // 没有找到对应的 VMA
  
  // 简化实现：只支持完全 unmap 或从头/尾部 unmap
  if(addr == vma->addr && len == vma->len) {
    // 完全 unmap
    // 写回页面到文件 (MAP_SHARED)
    if((vma->flags & MAP_SHARED) && vma->f) {
      for(uint64 a = vma->addr; a < vma->addr + vma->len; a += PGSIZE) {
        pte_t *pte = walk(p->pagetable, a, 0);
        if(pte && (*pte & PTE_V)) {
          // 写回文件
          uint64 pa = PTE2PA(*pte);
          uint64 file_off = vma->offset + (a - vma->addr);
          elock(vma->f->ep);
          ewrite(vma->f->ep, 0, pa, file_off, PGSIZE);
          eunlock(vma->f->ep);
        }
      }
    }
    
    // 解除映射并释放物理页
    for(uint64 a = vma->addr; a < vma->addr + vma->len; a += PGSIZE) {
      pte_t *pte = walk(p->pagetable, a, 0);
      if(pte && (*pte & PTE_V)) {
        uint64 pa = PTE2PA(*pte);
        kfree((void*)pa);
        *pte = 0;
      }
      // 同时处理内核页表
      pte = walk(p->kpagetable, a, 0);
      if(pte && (*pte & PTE_V)) {
        *pte = 0;
      }
    }
    
    // 关闭文件
    if(vma->f) {
      fileclose(vma->f);
    }
    
    // 释放 VMA
    vma->valid = 0;
    return 0;
  }
  
  // 部分 unmap 暂不支持
  return -1;
}

// V3.0: poll() I/O 多路复用
// poll(struct pollfd *fds, nfds_t nfds, int timeout)
// 返回: 就绪 fd 数量, 0 超时, -1 错误

// Poll 事件标志 (与 poll.h 保持一致)
#define POLLIN      0x0001
#define POLLOUT     0x0004
#define POLLERR     0x0008
#define POLLHUP     0x0010
#define POLLNVAL    0x0020

#define POLL_MAX_FDS  64

struct pollfd {
    int fd;
    short events;
    short revents;
};

// 检查单个文件的 poll 状态
static short
file_poll(struct file *f)
{
  short revents = 0;
  
  if(f == 0)
    return POLLNVAL;
  
  switch(f->type) {
    case FD_PIPE: {
      struct pipe *pi = f->pipe;
      acquire(&pi->lock);
      
      // 检查可读
      if(f->readable) {
        if(pi->nread != pi->nwrite)  // 有数据
          revents |= POLLIN;
        if(!pi->writeopen)           // 写端关闭
          revents |= POLLHUP;
      }
      
      // 检查可写
      if(f->writable) {
        if(pi->nwrite < pi->nread + PIPESIZE)  // 有空间
          revents |= POLLOUT;
        if(!pi->readopen)            // 读端关闭
          revents |= POLLERR;
      }
      
      release(&pi->lock);
      break;
    }
    
    case FD_ENTRY: {
      // 普通文件总是可读可写
      if(f->readable)
        revents |= POLLIN;
      if(f->writable)
        revents |= POLLOUT;
      break;
    }
    
    case FD_DEVICE: {
      // 设备假设总是就绪
      if(f->readable)
        revents |= POLLIN;
      if(f->writable)
        revents |= POLLOUT;
      break;
    }
    
    default:
      revents |= POLLNVAL;
  }
  
  return revents;
}

uint64
sys_poll(void)
{
  uint64 fds_addr;
  int nfds;
  int timeout;
  struct pollfd fds[POLL_MAX_FDS];
  struct proc *p = myproc();
  extern uint ticks;
  extern struct spinlock tickslock;
  
  // 获取参数
  if(argaddr(0, &fds_addr) < 0 || argint(1, &nfds) < 0 || argint(2, &timeout) < 0)
    return -1;
  
  // 验证 nfds
  if(nfds < 0 || nfds > POLL_MAX_FDS)
    return -1;
  
  if(nfds == 0) {
    // 没有 fd，只是等待 timeout
    if(timeout > 0) {
      acquire(&tickslock);
      sleep(&ticks, &tickslock);
      release(&tickslock);
    }
    return 0;
  }
  
  // 从用户空间复制 pollfd 数组
  if(copyin(p->pagetable, (char*)fds, fds_addr, nfds * sizeof(struct pollfd)) < 0)
    return -1;
  
  uint start_ticks;
  acquire(&tickslock);
  start_ticks = ticks;
  release(&tickslock);
  
  int timeout_ticks = (timeout < 0) ? 0x7fffffff : timeout / 100;  // 转换 ms 到 ticks (约10ms/tick)
  
  while(1) {
    int ready = 0;
    
    // 检查所有 fd
    for(int i = 0; i < nfds; i++) {
      fds[i].revents = 0;
      
      if(fds[i].fd < 0) {
        // 负 fd 被忽略
        continue;
      }
      
      if(fds[i].fd >= NOFILE) {
        fds[i].revents = POLLNVAL;
        ready++;
        continue;
      }
      
      struct file *f = p->ofile[fds[i].fd];
      if(f == 0) {
        fds[i].revents = POLLNVAL;
        ready++;
        continue;
      }
      
      short rev = file_poll(f);
      fds[i].revents = rev & (fds[i].events | POLLERR | POLLHUP | POLLNVAL);
      
      if(fds[i].revents != 0)
        ready++;
    }
    
    // 有就绪的 fd
    if(ready > 0) {
      // 复制结果回用户空间
      if(copyout(p->pagetable, fds_addr, (char*)fds, nfds * sizeof(struct pollfd)) < 0)
        return -1;
      return ready;
    }
    
    // 检查超时
    acquire(&tickslock);
    uint current_ticks = ticks;
    release(&tickslock);
    
    if(timeout == 0 || (int)(current_ticks - start_ticks) >= timeout_ticks) {
      // 超时，复制结果并返回 0
      if(copyout(p->pagetable, fds_addr, (char*)fds, nfds * sizeof(struct pollfd)) < 0)
        return -1;
      return 0;
    }
    
    // 检查是否被 kill
    if(p->killed)
      return -1;
    
    // 等待一小段时间再重试
    acquire(&tickslock);
    sleep(&ticks, &tickslock);
    release(&tickslock);
  }
}

// V3.0: fcntl() 文件描述符控制
// fcntl(fd, cmd, arg)
// 返回: 命令结果或 -1 错误
uint64
sys_fcntl(void)
{
  int fd, cmd, arg;
  struct proc *p = myproc();
  struct file *f;
  
  if(argint(0, &fd) < 0 || argint(1, &cmd) < 0 || argint(2, &arg) < 0)
    return -1;
  
  if(fd < 0 || fd >= NOFILE || (f = p->ofile[fd]) == 0)
    return -1;
  
  switch(cmd) {
    case F_DUPFD: {
      // 复制 fd 到 >= arg 的最小空闲 fd
      if(arg < 0 || arg >= NOFILE)
        return -1;
      for(int newfd = arg; newfd < NOFILE; newfd++) {
        if(p->ofile[newfd] == 0) {
          p->ofile[newfd] = filedup(f);
          p->fd_flags[newfd] = 0;  // 清除 CLOEXEC
          return newfd;
        }
      }
      return -1;  // 没有空闲 fd
    }
    
    case F_GETFD:
      // 获取 fd 标志 (FD_CLOEXEC)
      return p->fd_flags[fd];
    
    case F_SETFD:
      // 设置 fd 标志
      p->fd_flags[fd] = arg & FD_CLOEXEC;
      return 0;
    
    case F_GETFL:
      // 获取文件状态标志
      return f->flags;
    
    case F_SETFL: {
      // 设置文件状态标志 (只能改变某些标志)
      // 只允许设置 O_APPEND, O_NONBLOCK
      uint mask = O_APPEND | O_NONBLOCK;
      f->flags = (f->flags & ~mask) | (arg & mask);
      return 0;
    }
    
    default:
      return -1;  // 不支持的命令
  }
}
