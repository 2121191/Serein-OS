// ipcband.c - IPC Orchestra Demo
// 展示多种 IPC 机制的协作：
// - 共享内存 (shm) - 数据传输
// - 信号量 (sem) - 同步控制
// - 管道 (pipe) - 状态报告
// - 信号 (signal) - 事件通知

#include "kernel/include/types.h"
#include "kernel/include/param.h"
#include "xv6-user/user.h"

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

static void color_reset(void) {
  char seq[] = {0x1b, '[', '0', 'm'};
  write(2, seq, sizeof(seq));
}

// 共享内存结构
struct shared_data {
  int producer_count;   // 生产者计数
  int consumer_count;   // 消费者计数
  int buffer[8];        // 环形缓冲区
  int head;             // 写入位置
  int tail;             // 读取位置
  int done;             // 完成标志
};

// 全局变量
static int sem_empty;       // 空槽信号量
static int sem_full;        // 满槽信号量
static int sem_mutex;       // 互斥锁
static int report_pipe[2];  // 状态报告管道
static struct shared_data *shm;
static uint64 shm_addr;
static int shm_id;

#define BUFFER_SIZE 8
#define NUM_ITEMS   20

// 生产者进程
static void producer_process(void) {
  for(int i = 1; i <= NUM_ITEMS; i++) {
    // 等待空槽
    sem_wait(sem_empty);
    sem_wait(sem_mutex);
    
    // 写入数据
    shm->buffer[shm->head] = i;
    shm->head = (shm->head + 1) % BUFFER_SIZE;
    shm->producer_count++;
    
    // 报告状态
    char msg[32];
    int len = 0;
    msg[len++] = 'P';
    msg[len++] = ':';
    if(i >= 10) msg[len++] = '0' + (i / 10);
    msg[len++] = '0' + (i % 10);
    msg[len++] = '\n';
    write(report_pipe[1], msg, len);
    
    sem_post(sem_mutex);
    sem_post(sem_full);
    
    sleep(30);  // 生产间隔
  }
  
  // 标记完成
  sem_wait(sem_mutex);
  shm->done = 1;
  sem_post(sem_mutex);
  sem_post(sem_full);  // 唤醒可能在等待的消费者
  
  close(report_pipe[1]);
  exit(0);
}

// 消费者进程
static void consumer_process(void) {
  while(1) {
    sem_wait(sem_full);
    sem_wait(sem_mutex);
    
    // 检查是否完成
    if(shm->done && shm->head == shm->tail) {
      sem_post(sem_mutex);
      break;
    }
    
    // 读取数据
    int data = shm->buffer[shm->tail];
    shm->tail = (shm->tail + 1) % BUFFER_SIZE;
    shm->consumer_count++;
    
    // 报告状态
    char msg[32];
    int len = 0;
    msg[len++] = 'C';
    msg[len++] = ':';
    if(data >= 10) msg[len++] = '0' + (data / 10);
    msg[len++] = '0' + (data % 10);
    msg[len++] = '\n';
    write(report_pipe[1], msg, len);
    
    sem_post(sem_mutex);
    sem_post(sem_empty);
    
    sleep(50);  // 消费间隔（比生产慢，测试缓冲）
  }
  
  close(report_pipe[1]);
  exit(0);
}

// 打印缓冲区状态
static void print_buffer_status(int head, int tail, int *buffer) {
  fprintf(2, "  Buffer: [");
  for(int i = 0; i < BUFFER_SIZE; i++) {
    int slot_has_data = 0;
    // 判断该槽是否有数据
    if(head > tail) {
      slot_has_data = (i >= tail && i < head);
    } else if(head < tail) {
      slot_has_data = (i >= tail || i < head);
    } else {
      slot_has_data = 0;  // 空
    }
    
    if(slot_has_data) {
      color_green();
      fprintf(2, "#");
      color_reset();
    } else {
      fprintf(2, ".");
    }
  }
  fprintf(2, "]  head=%d tail=%d\n", head, tail);
}

// 打印数据流动画
static void print_data_flow(char type, int data) {
  if(type == 'P') {
    color_yellow();
    fprintf(2, "  Producer ");
    color_reset();
    fprintf(2, "---[%d]---> ", data);
    color_green();
    fprintf(2, "Buffer\n");
    color_reset();
  } else {
    color_green();
    fprintf(2, "  Buffer ");
    color_reset();
    fprintf(2, "---[%d]---> ", data);
    color_cyan();
    fprintf(2, "Consumer\n");
    color_reset();
  }
}

int main(int argc, char *argv[]) {
  cls();
  
  color_cyan();
  fprintf(2, "+================================================================+\n");
  fprintf(2, "|              IPC Orchestra - xv6-k210 V3.0                     |\n");
  fprintf(2, "|    Producer-Consumer with Shared Memory + Semaphores          |\n");
  fprintf(2, "+================================================================+\n");
  color_reset();
  
  fprintf(2, "\n");
  fprintf(2, "  This demo shows IPC mechanisms working together:\n");
  color_yellow();fprintf(2, "    - Shared Memory: ");color_reset();fprintf(2, "Data buffer between processes\n");
  color_cyan();fprintf(2, "    - Semaphores:    ");color_reset();fprintf(2, "Synchronization (empty/full/mutex)\n");
  color_green();fprintf(2, "    - Pipes:         ");color_reset();fprintf(2, "Status reporting\n");
  fprintf(2, "\n");
  fprintf(2, "  Starting in 2 seconds... (Press Ctrl+C to exit)\n\n");
  sleep(200);
  
  // 创建信号量
  sem_empty = sem_open(BUFFER_SIZE);  // 初始有 BUFFER_SIZE 个空槽
  sem_full = sem_open(0);             // 初始没有满槽
  sem_mutex = sem_open(1);            // 互斥锁
  
  if(sem_empty < 0 || sem_full < 0 || sem_mutex < 0) {
    fprintf(2, "ipcband: sem_open failed\n");
    exit(1);
  }
  
  // 创建共享内存
  shm_id = shmcreate("ipcband_shm", sizeof(struct shared_data));
  if(shm_id < 0) {
    fprintf(2, "ipcband: shmcreate failed\n");
    exit(1);
  }
  
  shm_addr = shmattach(shm_id);
  if(shm_addr == 0) {
    fprintf(2, "ipcband: shmattach failed\n");
    exit(1);
  }
  shm = (struct shared_data *)shm_addr;
  
  // 初始化共享数据
  shm->producer_count = 0;
  shm->consumer_count = 0;
  shm->head = 0;
  shm->tail = 0;
  shm->done = 0;
  for(int i = 0; i < BUFFER_SIZE; i++) {
    shm->buffer[i] = 0;
  }
  
  // 创建报告管道
  if(pipe(report_pipe) < 0) {
    fprintf(2, "ipcband: pipe failed\n");
    exit(1);
  }
  
  // 启动生产者
  int producer_pid = fork();
  if(producer_pid == 0) {
    close(report_pipe[0]);
    // 子进程需要重新 attach 共享内存
    shm_addr = shmattach(shm_id);
    shm = (struct shared_data *)shm_addr;
    producer_process();
  }
  
  // 启动消费者
  int consumer_pid = fork();
  if(consumer_pid == 0) {
    close(report_pipe[0]);
    // 子进程需要重新 attach 共享内存
    shm_addr = shmattach(shm_id);
    shm = (struct shared_data *)shm_addr;
    consumer_process();
  }
  
  // 父进程：关闭写端，监控状态
  close(report_pipe[1]);
  
  fprintf(2, "  Producer (%d) and Consumer (%d) started!\n\n", 
          producer_pid, consumer_pid);
  
  // 监控循环
  char buf[64];
  int events = 0;
  
  while(1) {
    int n = read(report_pipe[0], buf, sizeof(buf) - 1);
    if(n <= 0) break;
    
    buf[n] = 0;
    
    // 解析事件
    char type = buf[0];
    int data = 0;
    for(int i = 2; i < n && buf[i] >= '0' && buf[i] <= '9'; i++) {
      data = data * 10 + (buf[i] - '0');
    }
    
    events++;
    
    // 显示状态
    fprintf(2, "  Event %d: ", events);
    print_data_flow(type, data);
    print_buffer_status(shm->head, shm->tail, shm->buffer);
    fprintf(2, "  Produced: %d  Consumed: %d\n\n", 
            shm->producer_count, shm->consumer_count);
    
    sleep(10);
  }
  
  // 等待子进程
  wait(0);
  wait(0);
  
  // 保存统计信息（在 detach 前）
  int final_produced = shm->producer_count;
  int final_consumed = shm->consumer_count;
  
  // 清理
  close(report_pipe[0]);
  shmdetach(shm_addr, sizeof(struct shared_data));
  shmunlink("ipcband_shm");
  sem_close(sem_empty);
  sem_close(sem_full);
  sem_close(sem_mutex);
  
  fprintf(2, "\n");
  color_green();
  fprintf(2, "  === IPC Orchestra Complete! ===\n");
  color_reset();
  fprintf(2, "  Total produced: %d  Total consumed: %d\n", 
          final_produced, final_consumed);
  fprintf(2, "  All IPC mechanisms worked together harmoniously!\n\n");
  
  exit(0);
}
