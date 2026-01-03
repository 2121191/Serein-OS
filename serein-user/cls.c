
// 说明：不要用 printf("\x1b...")，因为 serein-user/printf.c 的 vprintf() 对 fmt 做逐字节解析，
// 若格式串位于只读段/或在该项目的 LazyAlloc/CoW 组合下触发异常，可能导致 page fault。
// 这里改为直接 write() 常量字节到 stdout。

#include "kernel/include/types.h"
#include "serein-user/user.h"


#include "kernel/include/types.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
  // 创建一个局部字符数组，包含 ANSI 转义序列
  // 0x1b 是 ESC 键的 ASCII 码（27）
  // "[2J" 是清除整个屏幕的 ANSI 转义码
  // "[H" 是将光标移动到左上角（1行1列）的 ANSI 转义码
  // '\n' 是换行符（回车），将光标移动到下一行行首
  char seq[] = {0x1b,'[','2','J', 0x1b,'[','H', '\n'};
  
  // 将清屏序列写入标准输出（文件描述符1）
  // seq: 要写入的数据的起始地址
  // sizeof(seq): 要写入的字节数（现在是8个字节）
  write(1, seq, sizeof(seq));
  
  // 正常退出程序，返回状态码0
  exit(0);
}
