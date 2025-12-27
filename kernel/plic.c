#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/sbi.h"
#include "include/plic.h"
#include "include/proc.h"
#include "include/printf.h"

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    // 开启中断优先级
    // QEMU: UART=10, VIRTIO=1
    // K210: UART=33, DISK=27
    
    #ifdef QEMU
    // QEMU 模式：必须显式开启 10号(串口) 和 1号(磁盘)
    // 优先级设为 1 (只要大于0就能触发)
    writed(1, PLIC_V + 10 * sizeof(uint32)); // QEMU UART IRQ = 10
    writed(1, PLIC_V + 1  * sizeof(uint32)); // QEMU DISK IRQ = 1
    #else
    // K210 模式
    writed(1, PLIC_V + DISK_IRQ * sizeof(uint32));
    writed(1, PLIC_V + UART_IRQ * sizeof(uint32));
    #endif

    #ifdef DEBUG
    printf("plicinit\n");
    #endif
}

void
plicinithart(void)
{
  int hart = cpuid();
  
  #ifdef QEMU
  // QEMU S-mode 启用逻辑
  // 设置当前hart的 S模式 Enable寄存器
  
  // 这里的计算非常关键：
  // 我们手动构造 enable mask，开启 bit 10 (UART) 和 bit 1 (DISK)
  // (1 << 10) | (1 << 1)
  *(uint32*)PLIC_SENABLE(hart) = (1 << 10) | (1 << 1);

  // 设置 S模式 优先级阈值为 0
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
  
  #else
  // K210 M-mode 启用逻辑 (保持原样)
  uint32 *hart_m_enable = (uint32*)PLIC_MENABLE(hart);
  *(hart_m_enable) = readd(hart_m_enable) | (1 << DISK_IRQ);
  uint32 *hart0_m_int_enable_hi = hart_m_enable + 1;
  *(hart0_m_int_enable_hi) = readd(hart0_m_int_enable_hi) | (1 << (UART_IRQ % 32));
  #endif

  #ifdef DEBUG
  printf("plicinithart\n");
  #endif
}

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
  int hart = cpuid();
  int irq;
  #ifndef QEMU
  irq = *(uint32*)PLIC_MCLAIM(hart);
  #else
  irq = *(uint32*)PLIC_SCLAIM(hart);
  #endif
  return irq;
}

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
  int hart = cpuid();
  #ifndef QEMU
  *(uint32*)PLIC_MCLAIM(hart) = irq;
  #else
  *(uint32*)PLIC_SCLAIM(hart) = irq;
  #endif
}