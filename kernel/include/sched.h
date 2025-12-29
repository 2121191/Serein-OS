#ifndef __SCHED_H
#define __SCHED_H

// 彩票调度常量
#define DEFAULT_TICKETS     10    // 新进程的默认彩票数

// 线性同余发生器 (LCG) - Numerical Recipes 标准常数
// 全整数运算，无浮点数
static unsigned int lcg_seed = 1;

static inline unsigned int lcg_rand(void) {
    lcg_seed = lcg_seed * 1664525 + 1013904223;
    return lcg_seed;
}

static inline void lcg_srand(unsigned int seed) {
    lcg_seed = seed;
}

#endif
