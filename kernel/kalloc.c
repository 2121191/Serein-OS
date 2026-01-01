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
#include "include/intr.h"  // push_off/pop_off

void freerange(void *pa_start, void *pa_end);

extern char kernel_end[]; // first address after kernel.

// Physical page count: (PHYSTOP - KERNBASE) / PGSIZE
#define NPHYPAGE ((PHYSTOP - KERNBASE) / PGSIZE)

// Physical address to index
#define PA2IDX(pa) (((uint64)(pa) - KERNBASE) / PGSIZE)

// Precondition check
#define PA_VALID(pa) ((uint64)(pa) >= KERNBASE && (uint64)(pa) < PHYSTOP && ((uint64)(pa) % PGSIZE) == 0)

struct run {
  struct run *next;
};

// Per-CPU memory allocator state
struct cpu_kmem {
  struct spinlock lock;
  struct run *freelist;
  // stats
  uint64 nalloc;
  uint64 nfree;
  uint64 nsteal;
};

// Per-CPU freelists and locks
static struct cpu_kmem kmem[NCPU];

// Shared state for reference counting
static struct {
  struct spinlock lock;
  uint8 refcnt[NPHYPAGE];  // Page reference counts (0-255)
} ref_kmem;

// Total free pages counter (for sysinfo)
static struct {
  struct spinlock lock;
  uint64 npage;
} total_free_pages;

// ======= VM observability counters (best-effort) =======
// 这些计数器用于 sysinfo/vmstat 展示。
// 设计为“尽力而为”：统计口径在内核各子模块里递增/递减。
static struct {
  struct spinlock lock;
  uint64 cow_pages;
  uint64 shm_pages;
  uint64 mmap_pages;
} vm_counters;

static inline int
mycpuid_kalloc(void)
{
  // must be called with interrupts off to avoid migration
  return r_tp();
}

void
kinit()
{
  // Initialize all per-CPU locks and the shared refcount lock
  for (int i = 0; i < NCPU; i++) {
    initlock(&kmem[i].lock, "kmem_cpu");
    kmem[i].freelist = 0;
    kmem[i].nalloc = 0;
    kmem[i].nfree = 0;
    kmem[i].nsteal = 0;
  }
  initlock(&ref_kmem.lock, "kmem_ref");
  initlock(&total_free_pages.lock, "kmem_total");
  initlock(&vm_counters.lock, "vm_count");
  vm_counters.cow_pages = 0;
  vm_counters.shm_pages = 0;
  vm_counters.mmap_pages = 0;

  // Initialize all reference counts to 0
  memset(ref_kmem.refcnt, 0, sizeof(ref_kmem.refcnt));
  total_free_pages.npage = 0;

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

  // First, handle the reference count reduction.
  acquire(&ref_kmem.lock);
  int idx = PA2IDX(pa);
  if (ref_kmem.refcnt[idx] > 1) {
    // Still other references, just decrement the count.
    ref_kmem.refcnt[idx]--;
    release(&ref_kmem.lock);
    return;
  }
  // Last reference, so we can free the page.
  ref_kmem.refcnt[idx] = 0;
  release(&ref_kmem.lock);

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  // Add the page to the current CPU's freelist.
  push_off();
  int cid = mycpuid_kalloc();

  acquire(&kmem[cid].lock);
  r->next = kmem[cid].freelist;
  kmem[cid].freelist = r;
  kmem[cid].nfree++;
  release(&kmem[cid].lock);

  pop_off();

  acquire(&total_free_pages.lock);
  total_free_pages.npage++;
  release(&total_free_pages.lock);
}

// Steal one page from another CPU's freelist.
// Returns a pointer to a page, or 0 if no pages were stolen.
static void *
ksteal(int cid)
{
  struct run *r = 0;

  for (int i = 1; i < NCPU; i++) {
    int other_cid = (cid + i) % NCPU;
    acquire(&kmem[other_cid].lock);
    r = kmem[other_cid].freelist;
    if (r) {
      kmem[other_cid].freelist = r->next;
      // count steal on current cpu
      kmem[cid].nsteal++;
      release(&kmem[other_cid].lock);
      break;
    }
    release(&kmem[other_cid].lock);
  }

  return (void*)r;
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  push_off();
  int cid = mycpuid_kalloc();

  acquire(&kmem[cid].lock);
  r = kmem[cid].freelist;
  if(r) {
    kmem[cid].freelist = r->next;
    kmem[cid].nalloc++;
  }
  release(&kmem[cid].lock);

  if (!r) {
    // Freelist was empty, try to steal from another CPU.
    r = ksteal(cid);
    if (r) {
      // steal counts as alloc for current cpu
      acquire(&kmem[cid].lock);
      kmem[cid].nalloc++;
      release(&kmem[cid].lock);
    }
  }

  pop_off();

  if(r) {
    // Successfully allocated or stolen a page
    acquire(&ref_kmem.lock);
    ref_kmem.refcnt[PA2IDX(r)] = 1; // Set initial refcount to 1
    release(&ref_kmem.lock);

    acquire(&total_free_pages.lock);
    total_free_pages.npage--;
    release(&total_free_pages.lock);

    memset((char*)r, 5, PGSIZE); // fill with junk
  }
  return (void*)r;
}

uint64
freemem_amount(void)
{
  uint64 n;
  acquire(&total_free_pages.lock);
  n = total_free_pages.npage << PGSHIFT;
  release(&total_free_pages.lock);
  return n;
}

// Export per-CPU kalloc stats for sysinfo
void
kalloc_stats_copyout(void *dst)
{
  // dst is a pointer to struct kalloc_stat [NCPU]
  struct kalloc_stat {
    uint64 nalloc;
    uint64 nfree;
    uint64 nsteal;
  };

  struct kalloc_stat *out = (struct kalloc_stat *)dst;

  for (int i = 0; i < NCPU; i++) {
    acquire(&kmem[i].lock);
    out[i].nalloc = kmem[i].nalloc;
    out[i].nfree  = kmem[i].nfree;
    out[i].nsteal = kmem[i].nsteal;
    release(&kmem[i].lock);
  }
}

// ======= VM observability counters API =======

uint64
kcow_pages(void)
{
  uint64 n;
  acquire(&vm_counters.lock);
  n = vm_counters.cow_pages;
  release(&vm_counters.lock);
  return n;
}

uint64
kshm_pages(void)
{
  uint64 n;
  acquire(&vm_counters.lock);
  n = vm_counters.shm_pages;
  release(&vm_counters.lock);
  return n;
}

uint64
kmmap_pages(void)
{
  uint64 n;
  acquire(&vm_counters.lock);
  n = vm_counters.mmap_pages;
  release(&vm_counters.lock);
  return n;
}

static void
counter_add(uint64 *p, long delta)
{
  if(delta < 0){
    uint64 d = (uint64)(-delta);
    if(*p < d)
      *p = 0;
    else
      *p -= d;
  } else {
    *p += (uint64)delta;
  }
}

void
kcow_pages_add(long delta)
{
  acquire(&vm_counters.lock);
  counter_add(&vm_counters.cow_pages, delta);
  release(&vm_counters.lock);
}

void
kshm_pages_add(long delta)
{
  acquire(&vm_counters.lock);
  counter_add(&vm_counters.shm_pages, delta);
  release(&vm_counters.lock);
}

void
kmmap_pages_add(long delta)
{
  acquire(&vm_counters.lock);
  counter_add(&vm_counters.mmap_pages, delta);
  release(&vm_counters.lock);
}

// ============== Reference Counting API ==============

// Increment reference count (for CoW sharing a page)
void
krefget(void *pa)
{
  if (!PA_VALID(pa))
    panic("krefget: invalid pa");

  acquire(&ref_kmem.lock);
  ref_kmem.refcnt[PA2IDX(pa)]++;
  release(&ref_kmem.lock);
}

// Decrement reference count, freeing the page if it reaches 0.
void
krefput(void *pa)
{
  if (!PA_VALID(pa))
    panic("krefput: invalid pa");

  // kfree already implements the logic of checking the refcount and freeing.
  kfree(pa);
}

// Get reference count
int
krefcnt(void *pa)
{
  if (!PA_VALID(pa))
    return 0;

  acquire(&ref_kmem.lock);
  int cnt = ref_kmem.refcnt[PA2IDX(pa)];
  release(&ref_kmem.lock);
  return cnt;
}
