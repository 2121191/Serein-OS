// PID Hash Table (V3.0)
// 优化 PID 查找性能，从 O(N) 降至 O(1)

#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/defs.h"

#define PID_HASH_SIZE 64
#define PID_HASH(pid) ((pid) % PID_HASH_SIZE)

struct {
  struct spinlock lock;
  struct proc *table[PID_HASH_SIZE];
} pidhash;

void
pidhash_init(void)
{
  initlock(&pidhash.lock, "pidhash");
  for(int i = 0; i < PID_HASH_SIZE; i++)
    pidhash.table[i] = 0;
}

// 插入进程到哈希表 (需持有 p->lock, 内部获取 hash lock)
void
pidhash_insert(struct proc *p)
{
  int h = PID_HASH(p->pid);
  acquire(&pidhash.lock);
  p->hash_next = pidhash.table[h];
  pidhash.table[h] = p;
  release(&pidhash.lock);
}

// 从哈希表移除进程 (需持有 p->lock, 内部获取 hash lock)
void
pidhash_remove(struct proc *p)
{
  int h = PID_HASH(p->pid);
  struct proc **pp;
  
  acquire(&pidhash.lock);
  for(pp = &pidhash.table[h]; *pp; pp = &(*pp)->hash_next){
    if(*pp == p){
      *pp = p->hash_next;
      p->hash_next = 0;
      break;
    }
  }
  release(&pidhash.lock);
}

// 根据 PID 查找进程 (返回时持有 p->lock)
// 如果未找到返回 0
struct proc*
pidhash_lookup(int pid)
{
  int h = PID_HASH(pid);
  struct proc *p;

  acquire(&pidhash.lock);
  for(p = pidhash.table[h]; p; p = p->hash_next){
    if(p->pid == pid){
      // 尝试获取进程锁
      acquire(&p->lock);
      // 验证 PID 仍匹配且未释放 (极少发生)
      if(p->pid == pid && p->state != UNUSED){
        release(&pidhash.lock);
        return p;
      }
      release(&p->lock);
    }
  }
  release(&pidhash.lock);
  return 0;
}
