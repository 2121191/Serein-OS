#ifndef __KALLOC_H
#define __KALLOC_H

#include "types.h"

void*           kalloc(void);
void            kfree(void *);
void            kinit(void);
uint64          freemem_amount(void);

// 引用计数 API (用于 CoW)
void            krefget(void *pa);   // 增加引用计数
void            krefput(void *pa);   // 减少引用计数，归零时释放
int             krefcnt(void *pa);   // 查询引用计数

#endif