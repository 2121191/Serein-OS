// pollwatch.c - I/O Multiplexing Visualization Demo
// 展示 poll() 系统调用的多路复用能力
// 创建多个管道，使用 poll 监控它们的状态

#include "kernel/include/types.h"
#include "kernel/include/param.h"
#include "serein-user/user.h"

// ANSI 转义序列
static void cls(void) {
  char seq[] = {0x1b, '[', '2', 'J', 0x1b, '[', 'H'};
  write(2, seq, sizeof(seq));
}

static void color_green(void) {
  char seq[] = {0x1b, '[', '3', '2', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_yellow(void) {
  char seq[] = {0x1b, '[', '3', '3', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_cyan(void) {
  char seq[] = {0x1b, '[', '3', '6', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_magenta(void) {
  char seq[] = {0x1b, '[', '3', '5', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_red(void) {
  char seq[] = {0x1b, '[', '3', '1', 'm'};
  write(2, seq, sizeof(seq));
}

static void color_reset(void) {
  char seq[] = {0x1b, '[', '0', 'm'};
  write(2, seq, sizeof(seq));
}

// 管道配置
#define NUM_PIPES 4
static int pipes[NUM_PIPES][2];  // [i][0] = read end, [i][1] = write end
static int writer_pids[NUM_PIPES];
static char *pipe_names[] = {"Alpha", "Beta", "Gamma", "Delta"};
static int pipe_intervals[] = {150, 80, 200, 120};  // 写入间隔 (ticks)

// 写入进程
static void writer_process(int pipe_idx) {
  int write_fd = pipes[pipe_idx][1];
  int interval = pipe_intervals[pipe_idx];
  char msg[32];
  int count = 0;
  
  while(1) {
    sleep(interval);
    count++;
    
    // 格式化消息
    int len = 0;
    char *name = pipe_names[pipe_idx];
    while(*name) msg[len++] = *name++;
    msg[len++] = ':';
    
    // 简单数字转换
    if(count >= 10) msg[len++] = '0' + (count / 10);
    msg[len++] = '0' + (count % 10);
    msg[len++] = '\n';
    
    write(write_fd, msg, len);
    
    // 发送10条后退出
    if(count >= 10) {
      close(write_fd);
      exit(0);
    }
  }
}

// 启动 writer 进程
static void spawn_writers(void) {
  for(int i = 0; i < NUM_PIPES; i++) {
    // 创建管道
    if(pipe(pipes[i]) < 0) {
      fprintf(2, "pollwatch: pipe failed\n");
      exit(1);
    }
    
    int pid = fork();
    if(pid < 0) {
      fprintf(2, "pollwatch: fork failed\n");
      exit(1);
    }
    
    if(pid == 0) {
      // 子进程：关闭读端，运行 writer
      close(pipes[i][0]);
      writer_process(i);
      exit(0);
    }
    
    // 父进程：关闭写端，记录 pid
    close(pipes[i][1]);
    writer_pids[i] = pid;
  }
}

// 打印管道状态面板
static void print_pipe_status(struct pollfd *fds, int active_count) {
  fprintf(2, "  +----------------------------------------------------------+\n");
  fprintf(2, "  |  PIPE     FD   EVENTS    STATUS                         |\n");
  fprintf(2, "  +----------------------------------------------------------+\n");
  
  for(int i = 0; i < NUM_PIPES; i++) {
    fprintf(2, "  |  ");
    
    // 根据状态设置颜色
    if(fds[i].fd < 0) {
      color_red();
      // 手动左对齐填充 (xv6 不支持 %-8s)
      fprintf(2, "%s", pipe_names[i]);
      int namelen = strlen(pipe_names[i]);
      for(int p = namelen; p < 8; p++) fprintf(2, " ");
      color_reset();
      fprintf(2, "  --   ----      [CLOSED]                     |\n");
      continue;
    }
    
    color_cyan();
    // 手动左对齐填充
    fprintf(2, "%s", pipe_names[i]);
    int namelen = strlen(pipe_names[i]);
    for(int p = namelen; p < 8; p++) fprintf(2, " ");
    color_reset();
    
    // 打印 fd (手动填充)
    if(fds[i].fd < 10) fprintf(2, "  ");
    else fprintf(2, " ");
    fprintf(2, "%d   ", fds[i].fd);
    
    // 打印 events
    if(fds[i].events & POLLIN) {
      color_yellow();
      fprintf(2, "POLLIN");
      color_reset();
    } else {
      fprintf(2, "------");
    }
    fprintf(2, "    ");
    
    // 打印 revents 状态
    if(fds[i].revents & POLLIN) {
      color_green();
      fprintf(2, "[DATA READY!]  ");
      color_reset();
    } else if(fds[i].revents & POLLHUP) {
      color_magenta();
      fprintf(2, "[HANGUP]       ");
      color_reset();
    } else if(fds[i].revents & POLLERR) {
      color_red();
      fprintf(2, "[ERROR]        ");
      color_reset();
    } else {
      fprintf(2, "[waiting...]   ");
    }
    
    fprintf(2, "       |\n");
  }
  
  fprintf(2, "  +----------------------------------------------------------+\n");
  fprintf(2, "  Active pipes: %d / %d\n", active_count, NUM_PIPES);
}

int main(int argc, char *argv[]) {
  cls();
  
  color_cyan();
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|          I/O Multiplexing Demo - poll() Visualization         |\n");
  fprintf(2, "|                       Serein OS V3.0                           |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  
  fprintf(2, "\n");
  fprintf(2, "  This demo shows poll() monitoring multiple pipes:\n\n");
  
  for(int i = 0; i < NUM_PIPES; i++) {
    color_yellow();
    fprintf(2, "    Pipe %s: writes every %d ticks\n", 
            pipe_names[i], pipe_intervals[i]);
    color_reset();
  }
  
  fprintf(2, "\n");
  fprintf(2, "  Starting in 2 seconds... (Press Ctrl+C to exit)\n\n");
  sleep(200);
  
  // 创建管道和 writer 进程
  spawn_writers();
  
  // 设置 pollfd 数组
  struct pollfd fds[NUM_PIPES];
  for(int i = 0; i < NUM_PIPES; i++) {
    fds[i].fd = pipes[i][0];  // 监控读端
    fds[i].events = POLLIN;   // 关注可读事件
    fds[i].revents = 0;
  }
  
  int active_pipes = NUM_PIPES;
  int total_messages = 0;
  int round = 0;
  
  fprintf(2, "  Monitoring %d pipes with poll()...\n\n", NUM_PIPES);
  
  while(active_pipes > 0) {
    round++;
    
    // 调用 poll，超时 500 ticks
    int ret = poll(fds, NUM_PIPES, 500);
    
    cls();
    color_cyan();
    fprintf(2, "+================================================================+\n");
    fprintf(2, "|          I/O Multiplexing Demo - poll() Visualization         |\n");
    fprintf(2, "+================================================================+\n");
    color_reset();
    
    fprintf(2, "\n");
    fprintf(2, "  Round %d | poll() returned: %d", round, ret);
    if(ret == 0) {
      color_yellow();
      fprintf(2, " (timeout)");
      color_reset();
    } else if(ret > 0) {
      color_green();
      fprintf(2, " (%d fd%s ready)", ret, ret > 1 ? "s" : "");
      color_reset();
    }
    fprintf(2, "\n\n");
    
    // 打印状态面板
    print_pipe_status(fds, active_pipes);
    
    // 处理就绪的 fd
    if(ret > 0) {
      fprintf(2, "\n  Events:\n");
      
      for(int i = 0; i < NUM_PIPES; i++) {
        if(fds[i].fd < 0) continue;
        
        if(fds[i].revents & POLLIN) {
          // 读取数据
          char buf[64];
          int n = read(fds[i].fd, buf, sizeof(buf) - 1);
          if(n > 0) {
            buf[n] = 0;
            // 去除换行符
            for(int j = 0; j < n; j++) {
              if(buf[j] == '\n') buf[j] = 0;
            }
            color_green();
            fprintf(2, "    [%s] Received: \"%s\"\n", pipe_names[i], buf);
            color_reset();
            total_messages++;
          }
        }
        
        if(fds[i].revents & POLLHUP) {
          // 管道写端关闭
          color_magenta();
          fprintf(2, "    [%s] Writer closed (POLLHUP)\n", pipe_names[i]);
          color_reset();
          close(fds[i].fd);
          fds[i].fd = -1;  // 标记为不再监控
          active_pipes--;
        }
      }
    }
    
    fprintf(2, "\n  Total messages received: %d\n", total_messages);
    
    if(active_pipes > 0) {
      fprintf(2, "  Waiting for more data...\n");
    }
    
    sleep(50);  // 短暂延迟便于观察
  }
  
  // 等待所有子进程
  for(int i = 0; i < NUM_PIPES; i++) {
    wait(0);
  }
  
  fprintf(2, "\n");
  color_green();
  fprintf(2, "  === Demo Complete! ===\n");
  color_reset();
  fprintf(2, "  All %d writers finished. Total messages: %d\n", NUM_PIPES, total_messages);
  fprintf(2, "  poll() efficiently monitored %d pipes without blocking!\n\n", NUM_PIPES);
  
  exit(0);
}
