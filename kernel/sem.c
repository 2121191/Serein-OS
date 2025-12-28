// Semaphore implementation
// Based on sleep/wakeup mechanism

#include "include/types.h"
#include "include/param.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/sem.h"
#include "include/printf.h"

// Global semaphore table
struct sem sems[NSEM];
struct spinlock sem_table_lock;

// Initialize semaphore subsystem
void
seminit(void)
{
  initlock(&sem_table_lock, "sem_table");
  for(int i = 0; i < NSEM; i++) {
    initlock(&sems[i].lock, "sem");
    sems[i].count = 0;
    sems[i].ref = 0;
    sems[i].name[0] = 0;
  }
  #ifdef DEBUG
  printf("seminit: initialized %d semaphores\n", NSEM);
  #endif
}

// Allocate a semaphore with initial value
// Returns semaphore index (0 to NSEM-1) on success, -1 on failure
int
semalloc(int initial_value)
{
  struct sem *s;
  int index = 0;
  
  acquire(&sem_table_lock);
  for(s = sems; s < &sems[NSEM]; s++) {
    if(s->ref == 0) {
      s->ref = 1;
      s->count = initial_value;
      release(&sem_table_lock);
      #ifdef DEBUG
      printf("semalloc: allocated semaphore[%d] with initial value %d\n", index, initial_value);
      #endif
      return index;
    }
    index++;
  }
  release(&sem_table_lock);
  #ifdef DEBUG
  printf("semalloc: failed - no free semaphore slots\n");
  #endif
  return -1;
}

// Get semaphore pointer by index
// Returns pointer to semaphore, or 0 if invalid index or not allocated
struct sem*
semget(int sem_id)
{
  if(sem_id < 0 || sem_id >= NSEM)
    return 0;
  if(sems[sem_id].ref == 0)
    return 0;
  return &sems[sem_id];
}

// Free a semaphore (decrement reference count)
void
semfree(struct sem *sem)
{
  if(sem == 0)
    return;
    
  acquire(&sem_table_lock);
  if(sem->ref > 0) {
    sem->ref--;
    if(sem->ref == 0) {
      // Wake up all processes waiting on this semaphore
      acquire(&sem->lock);
      while(sem->count < 0) {
        wakeup(sem);
        sem->count++;
      }
      release(&sem->lock);
      #ifdef DEBUG
      printf("semfree: freed semaphore\n");
      #endif
    }
  }
  release(&sem_table_lock);
}

// Wait (P) operation: decrement semaphore, block if count < 0
void
semwait(struct sem *sem)
{
  if(sem == 0)
    return;
    
  acquire(&sem->lock);
  #ifdef DEBUG
  printf("semwait: before wait, count = %d\n", sem->count);
  #endif
  sem->count--;
  if(sem->count < 0) {
    // Block until someone posts
    sleep(sem, &sem->lock);
  }
  #ifdef DEBUG
  printf("semwait: after wait, count = %d\n", sem->count);
  #endif
  release(&sem->lock);
}

// Get semaphore value (for system calls)
// Returns 0 on success, -1 on failure
int
semgetvalue(struct sem *sem, int *value)
{
  if(sem == 0)
    return -1;
    
  acquire(&sem->lock);
  *value = sem->count;
  release(&sem->lock);
  return 0;
}

// Post (V) operation: increment semaphore, wake up waiting processes
void
sempost(struct sem *sem)
{
  if(sem == 0)
    return;
    
  acquire(&sem->lock);
  #ifdef DEBUG
  printf("sempost: before post, count = %d\n", sem->count);
  #endif
  sem->count++;
  if(sem->count <= 0) {
    // Wake up one waiting process
    wakeup(sem);
  }
  #ifdef DEBUG
  printf("sempost: after post, count = %d\n", sem->count);
  #endif
  release(&sem->lock);
}

// Test function for semaphore (only callable from kernel)
void
test_sem(void)
{
  struct sem *s1, *s2 = 0;
  int id1, id2;
  
  printf("=== Testing semaphore ===\n");
  
  // Test 1: Allocate semaphore
  printf("Test 1: Allocating semaphore with initial value 2\n");
  id1 = semalloc(2);
  if(id1 < 0) {
    printf("ERROR: semalloc failed\n");
    return;
  }
  s1 = semget(id1);
  if(s1 == 0) {
    printf("ERROR: semget failed\n");
    return;
  }
  printf("SUCCESS: semaphore allocated with id=%d\n", id1);
  
  // Test 2: Check initial value
  acquire(&s1->lock);
  if(s1->count == 2 && s1->ref == 1) {
    printf("SUCCESS: semaphore has correct initial value (count=%d, ref=%d)\n", 
           s1->count, s1->ref);
  } else {
    printf("ERROR: semaphore has wrong values (count=%d, ref=%d)\n", 
           s1->count, s1->ref);
  }
  release(&s1->lock);
  
  // Test 3: Post operation
  printf("Test 3: Testing sempost (V operation)\n");
  sempost(s1);
  acquire(&s1->lock);
  if(s1->count == 3) {
    printf("SUCCESS: sempost increased count to %d\n", s1->count);
  } else {
    printf("ERROR: sempost failed (count=%d, expected 3)\n", s1->count);
  }
  release(&s1->lock);
  
  // Test 4: Wait operation (should not block since count > 0)
  printf("Test 4: Testing semwait (P operation) - should not block\n");
  semwait(s1);
  acquire(&s1->lock);
  if(s1->count == 2) {
    printf("SUCCESS: semwait decreased count to %d\n", s1->count);
  } else {
    printf("ERROR: semwait failed (count=%d, expected 2)\n", s1->count);
  }
  release(&s1->lock);
  
  // Test 5: Allocate another semaphore
  printf("Test 5: Allocating second semaphore\n");
  id2 = semalloc(0);
  if(id2 < 0) {
    printf("ERROR: second semalloc failed\n");
  } else {
    s2 = semget(id2);
    if(s2) {
      printf("SUCCESS: second semaphore allocated with id=%d\n", id2);
    } else {
      printf("ERROR: semget failed for id=%d\n", id2);
    }
  }
  
  // Test 6: Free semaphores
  printf("Test 6: Freeing semaphores\n");
  if(s1) semfree(s1);
  if(s2) semfree(s2);
  printf("SUCCESS: semaphores freed\n");
  
  printf("=== Semaphore test completed ===\n");
}
