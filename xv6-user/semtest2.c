// Multi-process test for semaphore blocking/waking mechanism

#include "kernel/include/types.h"
#include "xv6-user/user.h"

int
main(void)
{
  int sem_id;
  int pid;
  int value;
  
  printf("=== Multi-Process Semaphore Test ===\n");
  printf("This test demonstrates blocking and waking with multiple processes\n\n");
  
  // Create semaphore with initial value 0 (will block on first wait)
  sem_id = sem_open(0);
  if(sem_id < 0) {
    printf("ERROR: sem_open failed\n");
    exit(1);
  }
  printf("Created semaphore with id=%d, initial value=0\n", sem_id);
  
  // Fork a child process
  pid = fork();
  if(pid < 0) {
    printf("ERROR: fork failed\n");
    exit(1);
  }
  
  if(pid == 0) {
    // Child process: will wait on semaphore (will block)
    printf("[Child] Process %d: Waiting on semaphore (will block)...\n", getpid());
    sem_wait(sem_id);
    printf("[Child] Process %d: Woken up! Semaphore acquired.\n", getpid());
    sem_getvalue(sem_id, &value);
    printf("[Child] Process %d: Semaphore value = %d\n", getpid(), value);
    exit(0);
  } else {
    // Parent process: sleep a bit, then post to wake child
    printf("[Parent] Process %d: Child process %d created\n", getpid(), pid);
    printf("[Parent] Process %d: Sleeping for 2 seconds...\n", getpid());
    sleep(20);  // Sleep for 2 seconds (20 ticks)
    
    printf("[Parent] Process %d: Posting semaphore to wake child...\n", getpid());
    sem_post(sem_id);
    sem_getvalue(sem_id, &value);
    printf("[Parent] Process %d: Semaphore value = %d\n", getpid(), value);
    
    // Wait for child to finish
    wait(0);
    printf("[Parent] Process %d: Child finished\n", getpid());
    
    // Close semaphore
    sem_close(sem_id);
    printf("\n=== Test completed ===\n");
    exit(0);
  }
}

