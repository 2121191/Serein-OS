#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/sbi.h"
#include "include/console.h"
#include "include/printf.h"
#include "include/kalloc.h"
#include "include/timer.h"
#include "include/trap.h"
#include "include/proc.h"
#include "include/plic.h"
#include "include/vm.h"
#include "include/disk.h"
#include "include/buf.h"
#ifndef QEMU
#include "include/sdcard.h"
#include "include/fpioa.h"
#include "include/dmac.h"
#endif
// ... (保留上面的 include，不动) ...

// ============== 请完整替换下面的代码 ==============

// 引入 entry_qemu.S 的入口
extern void _entry(void);

// OpenSBI HSM 扩展常量
#define SBI_EXT_HSM 0x48534D
#define SBI_HSM_HART_START 0

// 启动核心的辅助函数
static inline void sbi_hart_start(unsigned long hartid, unsigned long start_addr, unsigned long opaque) {
    register unsigned long a0 asm("a0") = hartid;
    register unsigned long a1 asm("a1") = start_addr;
    register unsigned long a2 asm("a2") = opaque;
    register unsigned long a6 asm("a6") = SBI_HSM_HART_START;
    register unsigned long a7 asm("a7") = SBI_EXT_HSM;
    asm volatile("ecall"
                 : "+r"(a0), "+r"(a1)
                 : "r"(a0), "r"(a1), "r"(a2), "r"(a6), "r"(a7)
                 : "memory");
}

static inline void inithartid(unsigned long hartid) {
  asm volatile("mv tp, %0" : : "r" (hartid & 0x1));
}

volatile static int started = 0;
// 新增：一个原子锁，用于争抢“主启动核”的身份
volatile static int init_lock = 0;

void
main(unsigned long hartid, unsigned long dtb_pa)
{
  inithartid(hartid);

  // 【核心修改】自动选举逻辑
  // 使用原子操作检查 init_lock。
  // 如果 init_lock 原来是 0，被我改成了 1 -> 返回 true (我是老大)
  // 如果 init_lock 已经被别人改成 1 了 -> 返回 false (我是小弟)
  int is_master = __sync_bool_compare_and_swap(&init_lock, 0, 1);

  if (is_master) {
    // === 我是老大 (Master Core) ===
    consoleinit();
    printfinit();
    print_logo();

    #ifdef QEMU
    volatile unsigned char *uart_ier = (volatile unsigned char *)(0x10000000 + 1);
    *uart_ier = 0x01; // 强行开启接收中断
    #endif

    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    
    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    kinit();         
    kvminit();       
    kvminithart();   
    timerinit();     
    trapinithart();  
    procinit();
    plicinit();
    plicinithart();
    #ifndef QEMU
    fpioa_pin_init();
    dmac_init();
    #endif 
    disk_init();
    binit();         
    fileinit();      
    userinit();      
    
    printf("hart %d init done (I am the Master)\n", hartid);

    // === 叫醒其他所有核心 ===
    for(int i = 0; i < NCPU; i++) {
      if(i == hartid) continue; // 别叫醒自己
      
      // 兼容旧版：尝试发送 IPI
      unsigned long mask = 1 << i;
      sbi_send_ipi(&mask);
      
      // 针对新版 OpenSBI：使用 HSM 强制启动
      // 0x80200000 是 _entry 的地址
      sbi_hart_start(i, 0x80200000, 0);
    }
    
    __sync_synchronize();
    started = 1; // 通知其他核：内存初始化好了，你们可以动了
  }
  else
  {
    // === 我是小弟 (Slave Core) ===
    // 等待老大把 started 设为 1
    while (started == 0)
      ;
    __sync_synchronize();
    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    kvminithart();
    trapinithart();
    plicinithart();
    printf("hart %d init done\n", hartid);
  }

  scheduler();
}