/**
 * platform_qemu.c - QEMU 平台驱动实现
 * 
 * 为 QEMU virt 平台提供控制台、磁盘、PLIC 的具体实现
 */

#include "driver.h"
#include "../include/types.h"
#include "../include/param.h"
#include "../include/memlayout.h"
#include "../include/riscv.h"
#include "../include/sbi.h"
#include "../include/proc.h"
#include "../include/buf.h"

// ============== 前向声明 ==============
extern void virtio_disk_init(void);
extern void virtio_disk_rw(struct buf *b, int write);
extern void virtio_disk_intr(void);

// ============== 控制台实现 ==============
static void qemu_console_init(void) {
    // QEMU UART 初始化: 开启接收中断
    volatile unsigned char *uart_ier = (volatile unsigned char *)(UART + 1);
    *uart_ier = 0x01;
}

static void qemu_console_putc(int c) {
    sbi_console_putchar(c);
}

static int qemu_console_getc(void) {
    return sbi_console_getchar();
}

static int qemu_console_handle_char(int c) {
    // QEMU 回车符转换
    return (c == '\r') ? '\n' : c;
}

static struct console_ops qemu_console_ops = {
    .init = qemu_console_init,
    .putc = qemu_console_putc,
    .getc = qemu_console_getc,
    .handle_char = qemu_console_handle_char,
};

// ============== 磁盘实现 ==============
static void qemu_disk_init(void) {
    virtio_disk_init();
}

static void qemu_disk_read(struct buf *b) {
    virtio_disk_rw(b, 0);
}

static void qemu_disk_write(struct buf *b) {
    virtio_disk_rw(b, 1);
}

static void qemu_disk_intr(void) {
    virtio_disk_intr();
}

static struct disk_ops qemu_disk_ops = {
    .init = qemu_disk_init,
    .read = qemu_disk_read,
    .write = qemu_disk_write,
    .intr = qemu_disk_intr,
};

// ============== PLIC 实现 ==============
#define QEMU_UART_IRQ 10
#define QEMU_DISK_IRQ 1

static void qemu_plic_init(void) {
    // 开启 UART(10) 和 DISK(1) 中断优先级
    writed(1, PLIC_V + QEMU_UART_IRQ * sizeof(uint32));
    writed(1, PLIC_V + QEMU_DISK_IRQ * sizeof(uint32));
}

static void qemu_plic_inithart(void) {
    int hart = cpuid();
    // S-mode enable 寄存器: 开启 bit 10 (UART) 和 bit 1 (DISK)
    *(uint32*)PLIC_SENABLE(hart) = (1 << QEMU_UART_IRQ) | (1 << QEMU_DISK_IRQ);
    // S-mode 优先级阈值设为 0
    *(uint32*)PLIC_SPRIORITY(hart) = 0;
}

static int qemu_plic_claim(void) {
    int hart = cpuid();
    return *(uint32*)PLIC_SCLAIM(hart);
}

static void qemu_plic_complete(int irq) {
    int hart = cpuid();
    *(uint32*)PLIC_SCLAIM(hart) = irq;
}

static struct plic_ops qemu_plic_ops = {
    .init = qemu_plic_init,
    .inithart = qemu_plic_inithart,
    .claim = qemu_plic_claim,
    .complete = qemu_plic_complete,
    .uart_irq = QEMU_UART_IRQ,
    .disk_irq = QEMU_DISK_IRQ,
};

// ============== 平台操作集合 ==============
static struct platform_ops qemu_platform = {
    .name = "qemu",
    .console = &qemu_console_ops,
    .disk = &qemu_disk_ops,
    .plic = &qemu_plic_ops,
};

// ============== 全局平台指针 ==============
struct platform_ops *platform = 0;

void platform_init(void) {
    platform = &qemu_platform;
}
