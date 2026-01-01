//
// Console input and output, to the uart.
// Reads are line at a time.
// Implements special input characters:
//   newline -- end of line
//   control-h -- backspace
//   control-u -- kill line
//   control-d -- end of file
//   control-p -- print process list
//
#include <stdarg.h>


#include "include/types.h"
#include "include/param.h"
#include "include/spinlock.h"
#include "include/sleeplock.h"
#include "include/file.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/proc.h"
#include "include/sbi.h"

#define BACKSPACE 0x100
#define C(x)  ((x)-'@')  // Control-x

// 统计因输入缓冲溢出而被丢弃的字符数
uint64 console_dropped_chars = 0;

void consputc(int c) {
  if(c == BACKSPACE){
    // if the user typed backspace, overwrite with a space.
    sbi_console_putchar('\b');
    sbi_console_putchar(' ');
    sbi_console_putchar('\b');
  } else {
    sbi_console_putchar(c);
  }
}
struct {
  struct spinlock lock;
  
  // input
#define INPUT_BUF 128
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} cons;

// V2.2C: TTY 前台进程组 ID
// Shell 应在启动前台命令时调用 tcsetpgrp 设置此值
int tty_fg_pgid = 0;

//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
  int i;

  acquire(&cons.lock);
  for(i = 0; i < n; i++){
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
      break;
    sbi_console_putchar(c);
  }
  release(&cons.lock);

  return i;
}

//
// user read()s from the console go here.
// copy (up to) a whole input line to dst.
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
  uint target;
  int c;
  char cbuf;

  target = n;
  acquire(&cons.lock);
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
      break;

    dst++;
    --n;

    if(c == '\n'){
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);

  return target - n;
}

//
// the console input interrupt handler.
// uartintr() calls this for input character.
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
  acquire(&cons.lock);

  switch(c){
  case C('C'):  // Ctrl+C: Send SIGINT to foreground process group
    {
      extern int kill_pg(int pgid, int sig);
      consputc('^');
      consputc('C');
      consputc('\n');
      
      // V2.2C: 向前台进程组发送 SIGINT
      if(tty_fg_pgid > 0) {
        kill_pg(tty_fg_pgid, 2);  // SIGINT = 2
      } else {
        // Fallback: 向当前进程发送信号
        struct proc *p = myproc();
        if(p) {
          extern int kill_sig(int pid, int sig);
          kill_sig(p->pid, 2);
        }
      }
    }
    break;
  case C('P'):  // Print process list.
    procdump();
    break;
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
      cons.e--;
      consputc(BACKSPACE);
    }
    break;
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
      cons.e--;
      consputc(BACKSPACE);
    }
    break;
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
      #ifndef QEMU
      if (c == '\r') break;     // on k210, "enter" will input \n and \r
      #else
      c = (c == '\r') ? '\n' : c;
      #endif
      // echo back to the user.
      consputc(c);

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
        wakeup(&cons.r);
      }
    }
    else {
      // 缓冲已满，丢弃字符并记录
      console_dropped_chars++;
      consputc('\a');          // 响铃提示
    }
    break;
  }
  
  release(&cons.lock);
}

void
consoleinit(void)
{
  initlock(&cons.lock, "cons");

  cons.e = cons.w = cons.r = 0;
  
  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
  devsw[CONSOLE].write = consolewrite;
}
