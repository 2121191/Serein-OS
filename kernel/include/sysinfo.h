#ifndef __SYSINFO_H
#define __SYSINFO_H

#include "types.h"
#include "param.h"

// Per-CPU kalloc statistics
struct kalloc_stat {
  uint64 nalloc;      // number of allocations
  uint64 nfree;       // number of frees
  uint64 nsteal;      // number of steals from other CPUs
};

struct sysinfo {
  uint64 freemem;     // amount of free memory (bytes)
  uint64 nproc;       // number of processes
  uint64 uptime;      // number of ticks since start
  uint64 cow_pages;   // total copy-on-write pages
  uint64 shm_pages;   // total shared memory pages in use
  uint64 mmap_pages;  // total mmap anonymous/file pages
  struct kalloc_stat kalloc_stats[NCPU]; // Per-CPU kalloc stats
};


#endif
