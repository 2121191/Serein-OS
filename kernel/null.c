#include "include/types.h"
#include "include/proc.h"
#include "include/string.h"
#include "include/file.h"

#define NULL_DEV 2

// /dev/null: 读返回0，写丢弃所有数据
int nullread(int user_dst, uint64 dst, int n)
{
  // 读 /dev/null 返回0（表示EOF）
  return 0;
}

int nullwrite(int user_src, uint64 src, int n)
{
  // 写 /dev/null 丢弃所有数据，但返回写入的字节数
  return n;
}

void nullinit(void)
{
  devsw[NULL_DEV].read = nullread;
  devsw[NULL_DEV].write = nullwrite;
}

