#ifndef __SCHED_H
#define __SCHED_H

// ============================================
// Stride Scheduling (V2.0)
// ============================================
// Stride 调度替代彩票调度，提供确定性比例分配
// stride = STRIDE_LARGE / tickets
// 每次运行后 pass += stride
// 选择 pass 最小的进程运行

// 大常数 L = 2^20，用于计算 stride
// 确保足够精度且避免整数溢出
#define STRIDE_LARGE    (1 << 20)

// 新进程的默认彩票数 (兼容原有 API)
#define DEFAULT_TICKETS     10

// 最大/最小彩票数限制
#define MAX_TICKETS         100
#define MIN_TICKETS         1

#endif
