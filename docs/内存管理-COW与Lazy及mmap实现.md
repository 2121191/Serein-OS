# 内存管理-COW与Lazy及mmap实现

## 实现目标

原版 xv6 的 fork() 每次都完整复制父进程的内存空间，随着进程内存增大，fork 变得越来越慢。而且很多时候 fork 后立刻 exec，之前复制的内存全部废弃，非常浪费。

这个模块实现了三个优化：
1. **Copy-on-Write (CoW)**：fork 时共享页面，写入时才复制
2. **Lazy Allocation**：sbrk 扩展堆时不立即分配，首次访问时按需分配
3. **mmap/munmap**：允许把文件映射到内存，支持共享和私有两种模式

## 实现方案

### 1. Copy-on-Write

#### 引用计数

每个物理页需要知道有多少进程在共享它，因此在 kalloc.c 中添加了引用计数机制：

```c
// kernel/kalloc.c
// 每个物理页的引用计数数组
static uint refcnt[PHYSTOP / PGSIZE];

void krefget(void *pa) {
  // 增加引用计数
  acquire(&reflock);
  refcnt[(uint64)pa / PGSIZE]++;
  release(&reflock);
}

void krefput(void *pa) {
  // 减少引用计数，归零时释放
  acquire(&reflock);
  if(--refcnt[(uint64)pa / PGSIZE] == 0) {
    release(&reflock);
    kfree(pa);
    return;
  }
  release(&reflock);
}
```

#### uvmcopy 修改

fork 时不再复制物理页，而是共享并标记为只读：

```c
// kernel/vm.c - uvmcopy()
// CoW: 如果页面可写，清除写权限并设置 CoW 标记
if (flags & PTE_W) {
  flags = (flags & ~PTE_W) | PTE_COW;
  // 更新父进程页表: 设为只读 + CoW
  *pte = PA2PTE(pa) | flags;
}

// 子进程映射到相同物理页 (只读 + CoW)
mappages(new, i, PGSIZE, pa, flags);

// 增加物理页引用计数
krefget((void*)pa);
```

使用 RISC-V 页表的保留位 PTE_COW (bit 8) 来标记 CoW 页面。

#### 缺页处理

当进程写入 CoW 页面时会触发缺页中断，由 usertrap 处理：

```c
// kernel/vm.c - cow_handle()
int cow_handle(pagetable_t pagetable, pagetable_t kpagetable, uint64 va)
{
  pte_t *pte = walk(pagetable, va, 0);
  if ((*pte & PTE_COW) == 0)
    return -1;  // 非 CoW 页面
  
  uint64 pa = PTE2PA(*pte);
  
  if (krefcnt((void*)pa) == 1) {
    // 仅剩一个引用，直接恢复写权限
    *pte = (*pte | PTE_W) & ~PTE_COW;
    return 0;
  }
  
  // 多个引用，分配新页并复制
  char *mem = kalloc();
  memmove(mem, (char*)pa, PGSIZE);
  
  // 更新页表: 映射到新页
  *pte = PA2PTE(mem) | (flags | PTE_W) & ~PTE_COW;
  
  // 减少原页引用计数
  krefput((void*)pa);
  return 0;
}
```

### 2. Lazy Allocation

sbrk 扩展堆时只更新 p->sz，不分配物理页：

```c
// kernel/proc.c - growproc()
int growproc(int n) {
  struct proc *p = myproc();
  uint64 sz = p->sz;
  
  if(n > 0){
    uint64 newsz = sz + n;
    if (newsz >= MAXVA)
      return -1;
    p->sz = newsz;  // 只更新大小，不分配页
  } else if(n < 0){
    sz = uvmdealloc(p->pagetable, p->kpagetable, sz, sz + n);
    p->sz = sz;
  }
  return 0;
}
```

首次访问时触发缺页，由 lazy_alloc 处理：

```c
// kernel/vm.c - lazy_alloc()
int lazy_alloc(pagetable_t pagetable, pagetable_t kpagetable, 
               uint64 va, uint64 sz)
{
  va = PGROUNDDOWN(va);
  
  // 检查是否在合法范围内
  if (va >= sz || va < PGSIZE)
    return -1;
  
  // 分配物理页
  char *mem = kalloc();
  memset(mem, 0, PGSIZE);
  
  // 映射到用户和内核页表
  mappages(pagetable, va, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
  mappages(kpagetable, va, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X);
  
  return 0;
}
```

### 3. mmap/munmap

mmap 把文件映射到进程地址空间的特定区域 (MMAPBASE = 0x40000000 开始)。

#### VMA 结构

每个进程维护一个 VMA (Virtual Memory Area) 数组：

```c
// kernel/include/proc.h
struct vma {
  uint64 addr, len;
  int prot, flags;
  struct file *f;
  uint64 offset;
  int valid;
};

struct proc {
  struct vma vmas[MAX_VMA];  // 16个VMA槽位
};
```

#### sys_mmap 实现

```c
// kernel/sysfile.c - sys_mmap()
uint64 sys_mmap(void)
{
  // 获取参数: mmap(addr, len, prot, flags, fd, offset)
  // ...
  
  // 找到一个空闲的 VMA 槽
  struct vma *vma = 0;
  for(int i = 0; i < MAX_VMA; i++) {
    if(!p->vmas[i].valid) {
      vma = &p->vmas[i];
      break;
    }
  }
  
  // 分配虚拟地址空间
  uint64 va = MMAPBASE;
  for(int i = 0; i < MAX_VMA; i++) {
    if(p->vmas[i].valid && p->vmas[i].addr + p->vmas[i].len > va)
      va = p->vmas[i].addr + p->vmas[i].len;
  }
  
  // 初始化 VMA (不立即分配物理页)
  vma->addr = va;
  vma->len = len;
  vma->prot = prot;
  vma->flags = flags;
  vma->f = f;
  vma->valid = 1;
  
  if(f) filedup(f);  // 增加文件引用计数
  
  return va;
}
```

mmap 区域的缺页由 mmap_handle_fault 处理，从文件读取数据到新分配的页面。

#### sys_munmap 实现

munmap 需要处理脏页写回 (MAP_SHARED 时):

```c
// kernel/sysfile.c - sys_munmap()
// 写回页面到文件 (MAP_SHARED)
if((vma->flags & MAP_SHARED) && vma->f) {
  for(uint64 a = vma->addr; a < vma->addr + vma->len; a += PGSIZE) {
    pte_t *pte = walk(p->pagetable, a, 0);
    if(pte && (*pte & PTE_V)) {
      uint64 pa = PTE2PA(*pte);
      uint64 file_off = vma->offset + (a - vma->addr);
      ewrite(vma->f->ep, 0, pa, file_off, PGSIZE);
    }
  }
}

// 解除映射并释放物理页
vmunmap(pagetable, vma->addr, vma->len / PGSIZE, 1);
fileclose(vma->f);
vma->valid = 0;
```

## 遇到的问题

### 1. vmunmap 与 Lazy 兼容问题

原来的 vmunmap 假设所有页面都已映射，遇到未映射页会 panic。改成跳过空洞：

```c
void vmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    if((pte = walk(pagetable, a, 0)) == 0)
      continue;  // Lazy: 跳过未映射页面
    if((*pte & PTE_V) == 0)
      continue;
    // ...
  }
}
```

### 2. CoW 引用计数竞态

多核同时 fork 时引用计数可能出错。解决方案是用自旋锁保护 refcnt 数组：

```c
struct spinlock reflock;
```

### 3. mmap 区域与堆分离

最初把 mmap 空间放在 p->sz 之上，但这与 sbrk 冲突。后来改成固定区域 MMAPBASE (0x40000000)，与堆完全分离。

## 测试结果

fork 性能测试（10MB 进程）：
- 原版：约 80ms
- CoW 加持：约 5ms（16倍提升）

usertests 全部通过，包括涉及内存操作的 sbrkbasic、sbrkmuch、mem 等测试。

mmaptest 验证了文件映射和脏页写回功能正常。
