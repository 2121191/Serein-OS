#include "include/types.h"
#include "include/proc.h"
#include "include/string.h"
#include "include/file.h"
#include "include/defs.h"

#define ZERO_DEV 3
#define ZEROBUFSIZE 128

// 静态缓冲区，用于快速返回全0数据
static char zerobuf[ZEROBUFSIZE];

// /dev/zero: 读返回全0，写丢弃所有数据
int zeroread(int user_dst, uint64 dst, int n)
{
  int count = 0;
  int remaining = n;
  
  while(remaining > 0) {
    if(remaining > ZEROBUFSIZE) {
      count = ZEROBUFSIZE;
    } else {
      count = remaining;
    }
    
    // 使用 either_copyout 将全0数据复制到用户空间
    if(either_copyout(user_dst, dst, (void *)zerobuf, count) < 0) {
      return n - remaining;
    }
    
    remaining -= count;
    dst += count;
  }
  
  return n;
}

int zerowrite(int user_src, uint64 src, int n)
{
  // 写 /dev/zero 丢弃所有数据，但返回写入的字节数
  return n;
}

void zeroinit(void)
{
  // 初始化缓冲区为全0（虽然已经是静态初始化的，但显式初始化更清晰）
  memset((void *)zerobuf, 0, sizeof(zerobuf));
  devsw[ZERO_DEV].read = zeroread;
  devsw[ZERO_DEV].write = zerowrite;
}

