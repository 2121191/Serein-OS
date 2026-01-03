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
#include "include/sem.h"
#include "include/sched.h"
#include "include/shm.h"
#include "driver/driver.h"
#include "include/file.h"
#include "include/socket.h"

#ifndef QEMU
#include "include/sdcard.h"
#include "include/fpioa.h"
#include "include/dmac.h"
#endif

// 引入 entry_qemu.S 或 entry_k210.S 的入口
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
// 原子锁，用于争抢"主启动核"的身份
volatile static int init_lock = 0;

void
main(unsigned long hartid, unsigned long dtb_pa)
{
  inithartid(hartid);

  // 使用原子操作进行选举
  int is_master = __sync_bool_compare_and_swap(&init_lock, 0, 1);

  if (is_master) {
    // === Master Core 初始化 ===
    
    // 步骤 1: 初始化平台驱动抽象层
    platform_init();
    
    // 步骤 2: 控制台和打印
    consoleinit();
    printfinit();

    __INF("kernel log enabled: hart=%d", hartid);

    print_logo();
    
    // 步骤 3: 使用驱动抽象层初始化 UART 中断
    // (已移入 platform_qemu.c 的 console_ops.init)
    platform->console->init();

    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    
    // 步骤 4: 核心子系统初始化
    kinit();         
    kvminit();       
    kvminithart();   
    timerinit();     
    trapinithart();  
    procinit();
    seminit();        // Initialize semaphore subsystem
    shminit();        // Initialize shared memory subsystem
    
    #ifdef DEBUG
    test_sem();       // Test semaphore implementation
    #endif
    
    // Stride 调度：确定性算法，无需 PRNG 初始化
    
    // 步骤 5: 使用驱动抽象层初始化 PLIC
    platform->plic->init();
    platform->plic->inithart();
    
    // 步骤 6: K210 特有初始化 (保留条件编译)
    #ifndef QEMU
    fpioa_pin_init();
    dmac_init();
    #endif 
    
    // 步骤 7: 使用驱动抽象层初始化磁盘
    platform->disk->init();
    
    binit();         
    fileinit();
    sockinit();      // V3.1: Initialize socket subsystem
    
    // Initialize device files
    nullinit();      // /dev/null
    zeroinit();      // /dev/zero
      
    userinit();      
    
    printf("hart %d init done (I am the Master)\n", hartid);

    // === 唤醒其他核心 ===
    for(int i = 0; i < NCPU; i++) {
      if(i == hartid) continue;
      
      // 兼容旧版：发送 IPI
      unsigned long mask = 1 << i;
      sbi_send_ipi(&mask);
      
      // 使用符号地址而非硬编码
      sbi_hart_start(i, (unsigned long)_entry, 0);
    }
    
    __sync_synchronize();
    started = 1;
  }
  else
  {
    // === Slave Core 初始化 ===
    while (started == 0)
      ;
    __sync_synchronize();
    
    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    
    kvminithart();
    trapinithart();
    
    // 使用驱动抽象层
    platform->plic->inithart();
    
    printf("hart %d init done\n", hartid);
  }

  scheduler();
}