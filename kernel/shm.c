//
// Shared Memory (SHM) implementation
// Provides POSIX-style shared memory for inter-process communication
//

#include "include/types.h"
#include "include/param.h"
#include "include/spinlock.h"
#include "include/riscv.h"
#include "include/shm.h"
#include "include/kalloc.h"
#include "include/vm.h"
#include "include/string.h"
#include "include/printf.h"

// Global shared memory table
struct {
  struct spinlock lock;
  struct shm shm[NSHM];
} shmtable;

static int next_shmid = 1;

// Virtual address range reserved for shared memory
#define SHM_VA_BASE 0x40000000UL
#define SHM_VA_LIMIT 0x50000000UL
#define SHM_VA_STRIDE (SHM_MAX_PAGES * PGSIZE)

// Initialize shared memory subsystem
void
shminit(void)
{
  initlock(&shmtable.lock, "shmtable");
  struct shm *shm;
  for(shm = shmtable.shm; shm < shmtable.shm + NSHM; shm++){
    initlock(&shm->lock, "shm");
    shm->name[0] = '\0';
    shm->size = 0;
    shm->npages = 0;
    for(int i = 0; i < SHM_MAX_PAGES; i++)
      shm->pa[i] = 0;
    shm->ref = 0;
    shm->shmid = 0;
  }
  next_shmid = 1;
  #ifdef DEBUG
  printf("shminit: shared memory subsystem initialized\n");
  #endif
}

// Find a shared memory by name
static struct shm*
shmfind(char *name)
{
  struct shm *shm;
  
  for(shm = shmtable.shm; shm < shmtable.shm + NSHM; shm++){
    acquire(&shm->lock);
    if(shm->ref > 0 && strncmp(shm->name, name, SHM_NAME_MAX) == 0){
      release(&shm->lock);
      return shm;
    }
    release(&shm->lock);
  }
  return 0;
}

// Find a free slot in shmtable
static struct shm*
shmalloc(void)
{
  struct shm *shm;
  
  acquire(&shmtable.lock);
  for(shm = shmtable.shm; shm < shmtable.shm + NSHM; shm++){
    acquire(&shm->lock);
    if(shm->ref == 0){
      release(&shmtable.lock);
      return shm;
    }
    release(&shm->lock);
  }
  release(&shmtable.lock);
  return 0;
}

// Get shared memory by shmid
struct shm*
shmget(int shmid)
{
  struct shm *shm;
  
  acquire(&shmtable.lock);
  for(shm = shmtable.shm; shm < shmtable.shm + NSHM; shm++){
    acquire(&shm->lock);
    if(shm->ref > 0 && shm->shmid == shmid){
      release(&shmtable.lock);
      return shm;
    }
    release(&shm->lock);
  }
  release(&shmtable.lock);
  return 0;
}

// Create a new shared memory segment
int
shmcreate(char *name, uint64 size)
{
  struct shm *shm;
  int npages;
  
  // Check name length
  if(strlen(name) >= SHM_NAME_MAX)
    return -1;
  
  // Check if name already exists
  acquire(&shmtable.lock);
  if(shmfind(name) != 0){
    release(&shmtable.lock);
    return -1;  // Name already exists
  }
  release(&shmtable.lock);
  
  // Find a free slot
  if((shm = shmalloc()) == 0)
    return -1;  // No free slot
  
  // Calculate pages required
  npages = (PGROUNDUP(size)) / PGSIZE;
  if(npages == 0) npages = 1;  // At least one page
  if(npages > SHM_MAX_PAGES){
    release(&shm->lock);
    return -1; // too large
  }

  // Allocate physical pages (may be non-contiguous)
  for(int i = 0; i < npages; i++){
    void *pa = kalloc();
    if(pa == 0){
      // free previously allocated pages
      for(int j = 0; j < i; j++){
        kfree(shm->pa[j]);
        shm->pa[j] = 0;
      }
      release(&shm->lock);
      return -1;  // Out of memory
    }
    shm->pa[i] = pa;
    memset(pa, 0, PGSIZE);
  }

  // Initialize the shared memory
  strncpy(shm->name, name, SHM_NAME_MAX);
  shm->name[SHM_NAME_MAX-1] = '\0';
  shm->size = size;
  shm->npages = npages;
  shm->ref = 1; // creator holds one reference
  shm->shmid = next_shmid++;
  
  release(&shm->lock);
  
  #ifdef DEBUG
  printf("shmcreate: created shm '%s' (shmid=%d, size=%d, npages=%d, pa0=%p)\n", 
         name, shm->shmid, size, shm->npages, shm->pa[0]);
  #endif
  
  return shm->shmid;
}

// Open an existing shared memory segment by name
int
shmopen(char *name)
{
  struct shm *shm;
  
  if((shm = shmfind(name)) == 0)
    return -1;  // Not found
  
  acquire(&shm->lock);
  shm->ref++;
  int shmid = shm->shmid;
  release(&shm->lock);
  
  #ifdef DEBUG
  printf("shmopen: opened shm '%s' (shmid=%d, ref=%d)\n", 
         name, shmid, shm->ref);
  #endif
  
  return shmid;
}

// Attach shared memory to process address space
// Returns virtual address on success, 0 on failure
uint64
shmattach(int shmid, pagetable_t pagetable)
{
  struct shm *shm;
  uint64 va;
  
  if((shm = shmget(shmid)) == 0)
    return 0;  // Invalid shmid
  /* shmget() returns with shm->lock held */
  
  // Use fixed per-shmid VA stride so each shm has its own region
  va = SHM_VA_BASE + (shmid - 1) * SHM_VA_STRIDE;
  // Check bounds
  if(va + (uint64)shm->npages * PGSIZE > SHM_VA_LIMIT){
    release(&shm->lock);
    return 0;
  }

  // Check for collisions: ensure no page in region already mapped
  for(int i = 0; i < shm->npages; i++){
    if(walkaddr(pagetable, va + i * PGSIZE) != 0){
      release(&shm->lock);
      return 0; // already in use
    }
  }

  // Map each physical page to consecutive virtual pages
  for(int i = 0; i < shm->npages; i++){
    if(mappages(pagetable, va + i * PGSIZE, PGSIZE, (uint64)shm->pa[i], PTE_W|PTE_R|PTE_U) != 0){
      // on failure, unmap previously mapped pages (do NOT free physical pages)
      for(int j = 0; j < i; j++)
        vmunmap(pagetable, va + j * PGSIZE, 1, 0);
      release(&shm->lock);
      return 0;
    }
  }

  // Count this attachment
  shm->ref++;
  // 统计：本进程映射了 shm->npages 个共享页
  kshm_pages_add(shm->npages);
#ifdef DEBUG
  printf("[shm] attach shmid=%d npages=%d => shm_pages=%d\n", shmid, shm->npages, (int)kshm_pages());
#endif

  release(&shm->lock);
  
  #ifdef DEBUG
  printf("shmattach: attached shmid=%d to va=%p (pa0=%p, npages=%d)\n", shmid, va, shm->pa[0], shm->npages);
  #endif
  
  return va;
}

// Detach shared memory from process address space
int
shmdetach(uint64 va, pagetable_t pagetable, uint64 size)
{
  // Determine the shmid by fixed stride
  if(va < SHM_VA_BASE || va >= SHM_VA_LIMIT)
    return -1;
  int idx = (va - SHM_VA_BASE) / SHM_VA_STRIDE + 1;
  struct shm *shm = shmget(idx);
  if(shm == 0)
    return -1;
  /* shmget() returns with shm->lock held */

  // Unmap the virtual pages according to shm->npages
  // Do NOT free the physical pages here; physical pages are owned by the shared segment
  vmunmap(pagetable, va, shm->npages, 0);
  // 统计：本进程解除映射 shm->npages 个共享页
  kshm_pages_add(-(long)shm->npages);
#ifdef DEBUG
  printf("[shm] detach shmid=%d npages=%d => shm_pages=%d\n", shm->shmid, shm->npages, (int)kshm_pages());
#endif

  // Decrement reference and free if unlinked and no refs
  if(shm->ref > 0)
    shm->ref--;
  if(shm->ref == 0 && shm->name[0] == '\0'){
    release(&shm->lock);
    shmfree(shm);
    return 0;
  }

  release(&shm->lock);

  #ifdef DEBUG
  printf("shmdetach: detached va=%p (shmid=%d, ref=%d)\n", va, shm->shmid, shm->ref);
  #endif
  
  return 0;
}

// Unlink (delete) a shared memory segment by name
int
shmunlink(char *name)
{
  struct shm *shm;
  
  if((shm = shmfind(name)) == 0)
    return -1;  // Not found
  
  acquire(&shm->lock);
  // Mark as deleted by clearing name. Do not decrement ref here.
  shm->name[0] = '\0';
  // If no references remain, free immediately
  if(shm->ref == 0){
    release(&shm->lock);
    shmfree(shm);
    return 0;
  }
  release(&shm->lock);
  
  return 0;
}

// Free a shared memory segment
void
shmfree(struct shm *shm)
{
  acquire(&shm->lock);
  
  for(int i = 0; i < shm->npages; i++){
    if(shm->pa[i] != 0){
      kfree(shm->pa[i]);
      shm->pa[i] = 0;
    }
  }
  shm->npages = 0;
  shm->size = 0;
  shm->name[0] = '\0';
  shm->ref = 0;
  shm->shmid = 0;
  
  release(&shm->lock);
  
  #ifdef DEBUG
  printf("shmfree: freed shared memory segment\n");
  #endif
}

// Detach any shared memory mappings present in the given pagetable.
// Called when a process is exiting to ensure its shared mappings are removed
// so uvmfree and freewalk don't encounter leaf PTEs outside process sz.
void
shmdetach_all(pagetable_t pagetable)
{
  struct shm *shm;
  // Iterate through all possible shared segments
  for(shm = shmtable.shm; shm < shmtable.shm + NSHM; shm++){
    if(shm->shmid == 0)
      continue;
    uint64 va = SHM_VA_BASE + (shm->shmid - 1) * SHM_VA_STRIDE;
    // If this pagetable has a mapping at va, detach it
    if(walkaddr(pagetable, va) != 0){
      // Call shmdetach to unmap and update ref count
      shmdetach(va, pagetable, shm->size);
    }
  }
}
