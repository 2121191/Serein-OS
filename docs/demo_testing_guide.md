# xv6-k210 V3.0 测试指南

## 快速开始

### 1. 构建并运行系统

```bash
cd /path/to/xv6-k210

# 清理并重新构建
make clean
rm -f fs.img
make fs        # 需要 sudo 密码
make run
```

### 2. 基础测试命令

进入 xv6 shell 后，可以运行以下测试：

```bash
# 完整测试套件（约 3-5 分钟）
usertests

# 如果最后显示 "ALL TESTS PASSED" 说明全部通过
```

---

## 可视化演示

### procshow - Stride 调度器

```bash
procshow
# 或指定运行轮数
procshow 5
```

**看什么**：观察进度条比例是否与 tickets 比例一致
- Worker1 (tickets=5) 的进度应该最慢
- Worker4 (tickets=40) 的进度应该是 Worker1 的 8 倍

**预期时间**：约 15-30 秒

---

### memviz - 内存管理

```bash
memviz
```

**看什么**：
- Phase 1：Lazy Allocation - sbrk 扩展后，页面并未立即分配，访问时才分配
- Phase 2：Copy-on-Write - fork 后共享页面，写入时才复制

**预期时间**：约 10 秒

---

### pollwatch - I/O 多路复用

```bash
pollwatch
```

**看什么**：
- 4 个管道（Alpha/Beta/Gamma/Delta）的状态变化
- `[DATA READY!]` 表示有数据可读
- `[HANGUP]` 表示写端已关闭
- 观察 poll() 如何同时监控多个 fd

**预期时间**：约 30 秒（自动结束）

---

### ipcband - IPC 综合

```bash
ipcband
```

**看什么**：
- Producer 往 Buffer 写数据
- Consumer 从 Buffer 读数据
- 缓冲区状态 `[####....]` 实时变化
- 最终 Produced=20, Consumed=20

**预期时间**：约 20 秒

---

## 中断演示

所有演示都支持 **Ctrl+C** 中断。按下后程序会正常退出，不会留下僵尸进程。

---

## 常见问题

### Q: QEMU 启动失败，提示 "Failed to get write lock"

**A**: 有另一个 QEMU 实例在运行，执行：
```bash
pkill -9 qemu-system-riscv64
```

### Q: usertests 某个测试卡住

**A**: 部分测试（如 bigfile）比较耗时，等待约 30 秒。如果超过 1 分钟无响应，可以 Ctrl+A X 退出 QEMU。

### Q: 演示程序找不到

**A**: 确保运行过 `make fs` 构建文件系统。如果修改了代码，需要重新运行：
```bash
rm fs.img && make fs
```

---

## 关闭系统

```bash
halt
```

或者在 QEMU 中按 **Ctrl+A X** 强制退出。
