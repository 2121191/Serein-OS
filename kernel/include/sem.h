#ifndef __SEM_H
#define __SEM_H

#include "types.h"
#include "spinlock.h"
#include "param.h"

#define NSEM 32  // maximum number of semaphores

// Forward declaration
struct proc;

struct sem {
  struct spinlock lock;       // protects this semaphore
  int count;                  // semaphore value (can be negative)
  int ref;                    // reference count
  char name[16];              // semaphore name (for debugging)
  struct proc *waiters[NPROC]; // V2.0: 等待队列 (防止 kill 死锁)
  int nwaiters;               // 等待者数量
};

// Initialize semaphore subsystem
void seminit(void);

// Allocate a semaphore with initial value
// Returns semaphore index (0 to NSEM-1) on success, -1 on failure
int semalloc(int initial_value);

// Get semaphore pointer by index (for internal use)
// Returns pointer to semaphore, or 0 if invalid
struct sem* semget(int sem_id);

// Free a semaphore (decrement reference count)
void semfree(struct sem *sem);

// Wait (P) operation: decrement semaphore, block if count < 0
void semwait(struct sem *sem);

// Post (V) operation: increment semaphore, wake up waiting processes
void sempost(struct sem *sem);

// Get semaphore value
// Returns 0 on success, -1 on failure
int semgetvalue(struct sem *sem, int *value);

// V2.0: 进程退出时清理信号量等待
// 从所有信号量的等待队列中移除该进程
void sem_cleanup_proc(struct proc *p);

#endif

