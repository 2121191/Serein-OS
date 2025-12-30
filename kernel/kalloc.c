// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.


#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/spinlock.h"
#include "include/kalloc.h"
#include "include/string.h"
#include "include/printf.h"

void freerange(void *pa_start, void *pa_end);

extern char kernel_end[]; // first address after kernel.

// 物理页数量: (PHYSTOP - KERNBASE) / PGSIZE
#define NPHYPAGE ((PHYSTOP - KERNBASE) / PGSIZE)

// 物理地址转索引
#define PA2IDX(pa) (((uint64)(pa) - KERNBASE) / PGSIZE)

// 前置条件检查
#define PA_VALID(pa) ((uint64)(pa) >= KERNBASE && (uint64)(pa) < PHYSTOP && ((uint64)(pa) % PGSIZE) == 0)

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
  uint64 npage;
  uint8 refcnt[NPHYPAGE];  // 每页引用计数 (0-255)
} kmem;

void
kinit()
{
  initlock(&kmem.lock, "kmem");
  kmem.freelist = 0;
  kmem.npage = 0;
  // 初始化所有引用计数为 0
  memset(kmem.refcnt, 0, sizeof(kmem.refcnt));
  freerange(kernel_end, (void*)PHYSTOP);
  #ifdef DEBUG
  printf("kernel_end: %p, phystop: %p, nphypage: %d\n", kernel_end, (void*)PHYSTOP, NPHYPAGE);
  printf("kinit\n");
  #endif
}

void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  struct run *r;
  
  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < kernel_end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  acquire(&kmem.lock);
  
  // CoW: 仅当引用计数为 0 或 1 时才真正释放
  int idx = PA2IDX(pa);
  if (kmem.refcnt[idx] > 1) {
    // 还有其他引用，仅减少计数
    kmem.refcnt[idx]--;
    release(&kmem.lock);
    return;
  }
  
  // 引用计数为 0 或 1，可以释放
  kmem.refcnt[idx] = 0;
  
  release(&kmem.lock);

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
  kmem.npage++;
  release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r) {
    kmem.freelist = r->next;
    kmem.npage--;
    // 新分配页引用计数为 1
    kmem.refcnt[PA2IDX(r)] = 1;
  }
  release(&kmem.lock);

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}

uint64
freemem_amount(void)
{
  return kmem.npage << PGSHIFT;
}

// ============== 引用计数 API ==============

// 增加引用计数 (用于 CoW 共享页面)
void
krefget(void *pa)
{
  if (!PA_VALID(pa))
    panic("krefget: invalid pa");
  
  acquire(&kmem.lock);
  kmem.refcnt[PA2IDX(pa)]++;
  release(&kmem.lock);
}

// 减少引用计数，归零时调用 kfree 释放
void
krefput(void *pa)
{
  if (!PA_VALID(pa))
    panic("krefput: invalid pa");
  
  // kfree 已经实现了引用计数减少逻辑
  kfree(pa);
}

// 查询引用计数 (V2.0.1 修复：加锁读取)
// 必须持锁读取，防止 CoW 处理器基于过期值做出错误决策
int
krefcnt(void *pa)
{
  if (!PA_VALID(pa))
    return 0;
  
  // V2.0.1: 加锁确保一致性读取
  // 避免在 kfree/krefget 并发时读到中间状态
  acquire(&kmem.lock);
  int cnt = kmem.refcnt[PA2IDX(pa)];
  release(&kmem.lock);
  return cnt;
}
