#ifndef __SHM_H
#define __SHM_H

#include "types.h"
#include "spinlock.h"
#include "riscv.h"

#define NSHM 16
#define SHM_NAME_MAX 32

// Maximum number of pages a single shared memory segment can hold
#define SHM_MAX_PAGES 16

struct shm {
  struct spinlock lock;
  char name[SHM_NAME_MAX];
  void *pa[SHM_MAX_PAGES]; // physical pages (may be non-contiguous)
  int npages;              // number of pages allocated
  uint64 size;             // requested size in bytes
  int ref;                 // number of opens/attachments
  int shmid;
};

void shminit(void);
int shmcreate(char *name, uint64 size);
int shmopen(char *name);
struct shm* shmget(int shmid);
uint64 shmattach(int shmid, pagetable_t pagetable);
int shmdetach(uint64 va, pagetable_t pagetable, uint64 size);
int shmunlink(char *name);
void shmfree(struct shm *shm);

// Detach any shared memory mappings present in the given pagetable.
// Called when a process is exiting to ensure its shared mappings are removed
// so uvmfree and freewalk don't encounter leaf PTEs outside process sz.
void shmdetach_all(pagetable_t pagetable);

#endif

