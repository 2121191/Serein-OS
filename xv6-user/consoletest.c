#include "user.h"

// 注意：这个结构体必须与你在 kernel/include/sysinfo.h 和 xv6-user/user.h
// 中定义的结构体完全一致。

int main(void)
{
  struct sysinfo info_before, info_after;
  char buf[2]; // 用于清空输入行，避免影响后续命令

  // 1. 获取初始的丢弃字符数
  if (sysinfo(&info_before) < 0) {
    printf("ERROR: sysinfo call failed.\n");
    exit(-1);
  }
  printf("Initial dropped characters: %d\n", info_before.dropped);

  // 2. 提示用户进行操作
  printf("\n>>> Please paste a very long line of text (more than 128 chars) right now.\n");
  printf(">>> Then press Enter.\n");

  // 3. 等待用户输入，这个gets()会消耗掉用户粘贴的并按回车后的那一行输入
  gets(buf, sizeof(buf));

  // 4. 再次获取 sysinfo，查看丢弃字符数的变化
  if (sysinfo(&info_after) < 0) {
    printf("ERROR: sysinfo call failed.\n");
    exit(-1);
  }
  printf("\nFinal dropped characters: %d\n", info_after.dropped);

  // 5. 验证结果
  if (info_after.dropped > info_before.dropped) {
    printf("\nSUCCESS: Dropped character count increased correctly!\n");
  } else {
    printf("\nNOTE: No characters were dropped. Try pasting more text, or faster.\n");
  }

  exit(0);
}