// sigtest2.c - 用户态信号处理器测试 (V2.1) - 调试版
#include "kernel/include/types.h"
#include "serein-user/user.h"

volatile int signal_received = 0;
volatile int signal_number = 0;

// 简单的信号处理函数 - 添加调试输出
void my_handler(int sig)
{
  // 注意：在信号处理器中直接使用 printf 可能有问题
  // 先设置标志
  signal_received = 1;
  signal_number = sig;
  
  // 尝试打印调试信息（可能不安全但有助于诊断）
  // printf("  [handler] received sig=%d, calling sigreturn...\n", sig);
  
  // 显式调用 sigreturn 恢复上下文
  int ret = sigreturn();
  
  // 如果 sigreturn 返回了，说明出问题了
  // printf("  [handler] sigreturn returned %d (should not happen!)\n", ret);
  (void)ret;  // 避免警告
}

int sigtest2_main(void)
{
  printf("=== User Signal Handler Test (V2.1) DEBUG ===\n\n");
  
  // 测试 0: 验证基本功能
  printf("Test 0: Basic setup verification\n");
  printf("  PID: %d\n", getpid());
  printf("  Test 0: PASSED\n\n");
  
  // 测试 1: 注册 SIGUSR1 处理器
  printf("Test 1: Register SIGUSR1 handler\n");
  signal_received = 0;
  signal_number = 0;
  
  if(sigaction(SIGUSR1, my_handler) < 0) {
    printf("  sigaction failed!\n");
    exit(1);
  }
  printf("  Handler registered at %p\n", my_handler);
  
  // 向自己发送信号
  printf("  Sending SIGUSR1 to self (pid=%d)...\n", getpid());
  int result = kill2(getpid(), SIGUSR1);
  printf("  kill2 returned: %d\n", result);
  
  // 如果能到这里，说明 sigreturn 工作了
  printf("  After signal: received=%d, sig=%d\n", signal_received, signal_number);
  
  if(signal_received && signal_number == SIGUSR1) {
    printf("  Test 1: PASSED\n\n");
  } else {
    printf("  Test 1: FAILED\n\n");
    exit(1);
  }
  
  // 测试 2: 尝试捕获 SIGKILL (应该失败)
  printf("Test 2: Attempt to catch SIGKILL (should fail)\n");
  result = sigaction(SIGKILL, my_handler);
  printf("  sigaction(SIGKILL) returned: %d (expected: -1)\n", result);
  if(result == -1) {
    printf("  Test 2: PASSED\n\n");
  } else {
    printf("  Test 2: FAILED\n\n");
  }
  
  printf("=== All Tests Completed ===\n");
  exit(0);
}
