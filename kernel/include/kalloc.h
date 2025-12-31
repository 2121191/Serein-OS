#ifndef __KALLOC_H
#define __KALLOC_H

#include "types.h"

void*           kalloc(void);
void            kfree(void *);
void            kinit(void);
uint64          freemem_amount(void);

// 导出每 CPU kalloc 统计 (用于 sysinfo)
void            kalloc_stats_copyout(void *dst);

// ======= VM observability counters =======
uint64          kcow_pages(void);
uint64          kshm_pages(void);
uint64          kmmap_pages(void);
void            kcow_pages_add(long delta);
void            kshm_pages_add(long delta);
void            kmmap_pages_add(long delta);

// 引用计数 API (用于 CoW)
void            krefget(void *pa);   // 增加引用计数
void            krefput(void *pa);   // 减少引用计数，归零时释放
int             krefcnt(void *pa);   // 查询引用计数

#endif