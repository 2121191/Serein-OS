    .section .text
    .globl _entry
_entry:
    # -------------------------------------
    # 必须将a0存入tp
    # xv6的C代码依赖tp寄存器来识别当前是哪个CPU
    # -------------------------------------
    mv tp, a0
    add t0, a0, 1
    slli t0, t0, 14
    la sp, boot_stack
    add sp, sp, t0
    call main

loop:
    j loop

    .section .bss.stack
    .align 12
    .globl boot_stack
boot_stack:
    .space 4096 * 4 * 2
    .globl boot_stack_top
boot_stack_top:
