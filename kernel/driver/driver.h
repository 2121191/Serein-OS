/**
 * driver.h - 驱动抽象层统一接口
 * 
 * 定义控制台、磁盘、PLIC 的操作接口，实现平台无关化
 */

#ifndef __DRIVER_H
#define __DRIVER_H

#include "../include/types.h"

struct buf;  // 前向声明

// ============== 控制台操作接口 ==============
struct console_ops {
    void (*init)(void);           // 初始化控制台
    void (*putc)(int c);          // 输出单字符
    int  (*getc)(void);           // 获取单字符，无字符返回 -1
    int  (*handle_char)(int c);   // 处理特殊字符 (如 \r -> \n)，返回处理后字符
};

// ============== 磁盘操作接口 ==============
struct disk_ops {
    void (*init)(void);           // 初始化磁盘
    void (*read)(struct buf *b);  // 读取扇区
    void (*write)(struct buf *b); // 写入扇区
    void (*intr)(void);           // 中断处理
};

// ============== PLIC 操作接口 ==============
struct plic_ops {
    void (*init)(void);           // PLIC 初始化
    void (*inithart)(void);       // 每个 hart 的初始化
    int  (*claim)(void);          // 获取中断号
    void (*complete)(int irq);    // 完成中断处理
    int  uart_irq;                // UART 中断号
    int  disk_irq;                // 磁盘中断号
};

// ============== 平台操作集合 ==============
struct platform_ops {
    const char *name;             // 平台名称 "qemu" / "k210"
    struct console_ops *console;
    struct disk_ops    *disk;
    struct plic_ops    *plic;
};

// 全局平台操作指针 (在 kinit 阶段初始化)
extern struct platform_ops *platform;

// 平台初始化函数
void platform_init(void);

#endif // __DRIVER_H
