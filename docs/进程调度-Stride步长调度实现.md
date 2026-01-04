# 进程调度-Stride 步长调度实现

## 实现目标

原来的彩票调度器（Lottery Scheduling）虽然简单，但存在一个根本问题：进程被调度的顺序完全随机。这导致高票数进程有可能连续多轮没被选中，造成响应时间波动。

在引入信号量和共享内存后，这个问题更加明显。比如一个持有信号量的高优先级进程，可能因为"运气不好"连续几轮没被调度，导致其他等待该信号量的进程全部阻塞。

Stride 调度用确定性算法替代随机抽奖：每个进程维护一个 pass 值，每次选择 pass 最小的进程运行，运行后 pass 增加一个步长（stride = L / tickets）。票数多的进程步长小，所以能更频繁地被选中。

## 实现方案

![stride原理图](../img/stride原理图%20.png)

### 数据结构

在 `struct proc` 中添加三个字段：

```c
// kernel/include/proc.h
int tickets;     // 票数权重 (1-100)
uint64 stride;   // stride = STRIDE_LARGE / tickets
uint64 pass;     // 累计 pass 值，每次运行后 +stride
```

常量定义在 `sched.h`：

```c
// kernel/include/sched.h
#define STRIDE_LARGE    (1 << 20)   // 2^20，足够精度
#define DEFAULT_TICKETS     10
#define MAX_TICKETS         100
#define MIN_TICKETS         1
```

选择 2^20 作为大常数是因为：对于 1-100 范围的票数，stride 值在 10485 到 1048576 之间，精度足够且不会很快溢出。

### 调度器实现

调度器采用"无锁扫描 + 单锁验证"的两阶段设计：

```c
// kernel/proc.c - scheduler()
void scheduler(void)
{
  for(;;){
    intr_on();

    // 阶段1：无锁扫描找到 pass 最小的 RUNNABLE 进程
    struct proc *minp = 0;
    uint64 min_pass = ~0ULL;
    
    for(p = proc; p < &proc[NPROC]; p++) {
      if(p->state == RUNNABLE && p->pass < min_pass) {
        min_pass = p->pass;
        minp = p;
      }
    }
    
    if(minp == 0) continue;

    // 阶段2：获取锁并验证状态
    acquire(&minp->lock);
    if(minp->state == RUNNABLE) {
      minp->state = RUNNING;
      minp->pass += minp->stride;
      // ... 上下文切换 ...
    }
    release(&minp->lock);
  }
}
```

第一阶段不持锁遍历，找到候选进程。第二阶段获取锁后再次检查状态，因为在多核环境下，其他 CPU 可能已经把这个进程抢走了。

### 新进程和 fork 处理

新进程在 `allocproc()` 中初始化：

```c
p->tickets = DEFAULT_TICKETS;
p->stride = STRIDE_LARGE / DEFAULT_TICKETS;
p->pass = 0;
```

`fork()` 时子进程继承父进程的调度参数：

```c
np->tickets = p->tickets;
np->stride = p->stride;
np->pass = p->pass;  // 继承 pass 值
```

继承 pass 值是为了保持公平性。如果子进程从 0 开始，它会立即获得大量 CPU 时间，破坏原有的比例分配。

## 遇到的问题

### 死锁问题

最初的实现在遍历过程中持有 winner 的锁继续遍历，导致在 `reparent2` 测试中卡死。问题是：

1. CPU0 在调度器中持有进程 A 的锁，继续遍历
2. CPU1 在 `exit()` 中持有进程 B 的锁，需要遍历子进程
3. 如果 A 是 B 的子进程或反过来，就死锁了

解决方案是改成两阶段：第一阶段不持锁扫描，第二阶段只持单个锁。这样不会和 `reparent/exit` 产生循环等待。

### pass 溢出

理论上 pass 会持续增长直到溢出。但实际计算表明，即使每秒调度 1000 次，也需要运行几百年才会溢出 uint64。所以暂时没做处理，如果将来需要，可以定期把所有进程的 pass 减去最小值来归一化。

## 测试结果

usertests 全部通过，包括之前卡住的 `reparent2`。

运行 `ps` 命令可以看到 Stride 调度信息：

```
PID     TICKETS TICKS   NAME
1       10      15      init
2       10      8       sh
5       10      2       ps
```

在两个不同票数的进程竞争 CPU 时，运行时间比例基本符合票数比例，比彩票调度稳定得多。
