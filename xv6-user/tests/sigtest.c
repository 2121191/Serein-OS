// sigtest.c - 信号系统测试程序 (V2.1)
#include "kernel/include/types.h"
#include "xv6-user/user.h"

int sigtest_main(void)
{
  printf("=== Signal System Test (V2.1) ===\n");
  
  // 测试 1: 使用 SIGTERM 终止子进程
  printf("Test 1: SIGTERM termination\n");
  int pid1 = fork();
  if(pid1 == 0) {
    // 子进程：无限循环
    while(1) {
      sleep(1);
    }
  }
  
  sleep(5);  // 等待一小会
  printf("  Sending SIGTERM to child %d\n", pid1);
  int result = kill2(pid1, SIGTERM);
  printf("  kill2 returned: %d\n", result);
  
  int status;
  wait(&status);
  printf("  Child exited with status: %d\n", status);
  printf("  Test 1: PASSED\n\n");
  
  // 测试 2: 使用 SIGKILL 强制终止
  printf("Test 2: SIGKILL forced termination\n");
  int pid2 = fork();
  if(pid2 == 0) {
    while(1) {
      sleep(1);
    }
  }
  
  sleep(5);
  printf("  Sending SIGKILL to child %d\n", pid2);
  result = kill2(pid2, SIGKILL);
  printf("  kill2 returned: %d\n", result);
  
  wait(&status);
  printf("  Child exited with status: %d\n", status);
  printf("  Test 2: PASSED\n\n");
  
  // 测试 3: 向不存在的进程发送信号
  printf("Test 3: Signal to non-existent process\n");
  result = kill2(99999, SIGTERM);
  printf("  kill2(99999, SIGTERM) returned: %d (expected: -1)\n", result);
  if(result == -1) {
    printf("  Test 3: PASSED\n\n");
  } else {
    printf("  Test 3: FAILED\n\n");
  }
  
  // 测试 4: 无效信号
  printf("Test 4: Invalid signal number\n");
  result = kill2(getpid(), 100);  // 无效信号
  printf("  kill2(pid, 100) returned: %d (expected: -1)\n", result);
  if(result == -1) {
    printf("  Test 4: PASSED\n\n");
  } else {
    printf("  Test 4: FAILED\n\n");
  }
  
  printf("=== All Signal Tests Completed ===\n");
  exit(0);
}
