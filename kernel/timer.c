// Timer Interrupt handler

#include "include/types.h"
#include "include/param.h"
#include "include/riscv.h"
#include "include/sbi.h"
#include "include/spinlock.h"
#include "include/timer.h"
#include "include/printf.h"
#include "include/proc.h"

struct spinlock tickslock;
uint ticks;

void timerinit() {
    initlock(&tickslock, "time");
    #ifdef DEBUG
    printf("timerinit\n");
    #endif
}

void
set_next_timeout() {
    // There is a very strange bug,
    // if comment the `printf` line below
    // the timer will not work.

    // this bug seems to disappear automatically
    // printf("");
    sbi_set_timer(r_time() + INTERVAL);
}

void timer_tick() {
    acquire(&tickslock);
    ticks++;
    wakeup(&ticks);
    release(&tickslock);
    
    // V3.0: 检查所有进程的 alarm 定时器
    extern struct proc proc[];
    for(struct proc *p = proc; p < &proc[NPROC]; p++) {
        // 无锁预检查，减少开销
        if(p->alarm_ticks == 0 || p->state == UNUSED)
            continue;
        
        acquire(&p->lock);
        // Double-check with lock held
        if(p->alarm_ticks != 0 && p->alarm_ticks <= ticks && 
           p->state != UNUSED && p->state != ZOMBIE) {
            // 定时器到期，发送 SIGALRM
            p->alarm_ticks = 0;  // 清除 alarm
            p->sig_pending |= (1 << 14);  // SIGALRM = 14
            
            // 如果进程在睡眠，唤醒它
            if(p->state == SLEEPING) {
                p->state = RUNNABLE;
            }
        }
        release(&p->lock);
    }
    
    set_next_timeout();
}
