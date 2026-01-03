// Simple test program for semaphore system calls

#include "kernel/include/types.h"
#include "serein-user/user.h"

static int semtest_main(void)
{
  int sem_id;
  int value;
  
  printf("=== Semaphore Test ===\n");
  
  // Test 1: Create semaphore with initial value 2
  printf("Test 1: Creating semaphore with initial value 2\n");
  sem_id = sem_open(2);
  if(sem_id < 0) {
    printf("ERROR: sem_open failed\n");
    exit(1);
  }
  printf("SUCCESS: semaphore created with id=%d\n", sem_id);
  
  // Get and display initial value
  if(sem_getvalue(sem_id, &value) == 0) {
    printf("  -> Semaphore value: %d\n", value);
  } else {
    printf("  -> ERROR: Failed to get semaphore value\n");
  }
  
  // Test 2: Post operation (V)
  printf("\nTest 2: Testing sem_post (V operation)\n");
  if(sem_post(sem_id) < 0) {
    printf("ERROR: sem_post failed\n");
    exit(1);
  }
  printf("SUCCESS: sem_post completed\n");
  if(sem_getvalue(sem_id, &value) == 0) {
    printf("  -> Semaphore value: %d (expected: 3)\n", value);
  }
  
  // Test 3: Wait operation (P)
  printf("\nTest 3: Testing sem_wait (P operation)\n");
  if(sem_wait(sem_id) < 0) {
    printf("ERROR: sem_wait failed\n");
    exit(1);
  }
  printf("SUCCESS: sem_wait completed\n");
  if(sem_getvalue(sem_id, &value) == 0) {
    printf("  -> Semaphore value: %d (expected: 2)\n", value);
  }
  
  // Test 4: Multiple operations to show value changes
  printf("\nTest 4: Multiple operations to show value changes\n");
  printf("  Current value: ");
  sem_getvalue(sem_id, &value);
  printf("%d\n", value);
  
  printf("  Performing 2 P operations (wait)...\n");
  sem_wait(sem_id);
  sem_getvalue(sem_id, &value);
  printf("    After 1st wait: value = %d\n", value);
  sem_wait(sem_id);
  sem_getvalue(sem_id, &value);
  printf("    After 2nd wait: value = %d\n", value);
  
  // Note: If we do one more wait, value would become -1 and process would block
  // This is normal semaphore behavior - it waits for another process to post
  printf("  Note: If we wait again, value would be -1 and process would block\n");
  printf("        (waiting for another process to call sem_post)\n");
  
  printf("  Performing 2 V operations (post)...\n");
  sem_post(sem_id);
  sem_getvalue(sem_id, &value);
  printf("    After 1st post: value = %d\n", value);
  sem_post(sem_id);
  sem_getvalue(sem_id, &value);
  printf("    After 2nd post: value = %d\n", value);
  
  // Now we can safely do one more wait without blocking
  printf("  Now performing 1 more wait (safe, won't block)...\n");
  sem_wait(sem_id);
  sem_getvalue(sem_id, &value);
  printf("    After wait: value = %d\n", value);
  
  // Test 5: Close semaphore
  printf("\nTest 5: Closing semaphore\n");
  if(sem_close(sem_id) < 0) {
    printf("ERROR: sem_close failed\n");
    exit(1);
  }
  printf("SUCCESS: semaphore closed\n");
  
  // Test 6: Try to use closed semaphore (should fail)
  printf("\nTest 6: Trying to use closed semaphore (should fail)\n");
  if(sem_wait(sem_id) < 0) {
    printf("SUCCESS: sem_wait correctly failed for closed semaphore\n");
  } else {
    printf("ERROR: sem_wait should have failed\n");
  }
  
  // Test 7: Try to get value of closed semaphore (should fail)
  if(sem_getvalue(sem_id, &value) < 0) {
    printf("SUCCESS: sem_getvalue correctly failed for closed semaphore\n");
  } else {
    printf("ERROR: sem_getvalue should have failed\n");
  }
  
  printf("\n=== All tests completed ===\n");
  exit(0);
}

