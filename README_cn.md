# Serein OS

基于华科 xv6-k210 深度开发的增强版 RISC-V 操作系统内核  
[English](./README.md) | [中文](./README_cn.md)

```
  _________                     .__        
 /   _____/ ___________   ____  |__| ____  
 \_____  \ / __ \_  __ \_/ __ \ |  |/    \ 
 /        \  ___/|  | \/\  ___/ |  |   |  \
/_______  /\___  >__|    \___  >|__|___|  /
        \/     \/            \/         \/ 
                                           
      |\__/,|   (`\      v3.1
    _.|o o  |_   ) )     QEMU Port
  -(((---(((--------  
```

<div align="center">
  <img src="./img/serein_demo.gif" alt="Serein Demo" width="600">
  <br>
  <em>演示：项目构建、系统启动、usertests 回归测试全过程</em>
</div>

## 项目简介

Serein 是基于华中科技大学 HUST-OS/xv6-k210 深度开发的增强版操作系统内核。我们将原版内核移植到 **QEMU v6.2+** 版本，并适配了标准 **OpenSBI** 启动流程。在保留原版全部功能的基础上，新增了约 10,000 行内核代码，实现了 **75 个系统调用**，涵盖多项现代操作系统特性。

## 依赖

- `qemu-system-riscv64` (v6.2+)
- RISC-V GCC 编译链: [riscv-gnu-toolchain](https://github.com/riscv/riscv-gnu-toolchain)

## 快速开始

```bash
# 克隆项目
git clone https://github.com/2121191/Serein-OS
cd Serein-OS

# 构建文件系统镜像（需要 sudo）
make fs

# 运行
make run
```

按 `Ctrl+A` 然后 `X` 退出 QEMU。

## 运行测试

```bash
# 在 xv6 shell 中运行完整回归测试
usertests

# 最后显示 "ALL TESTS PASSED" 表示全部通过
```

测试套件包含 **70+ 个测试用例**，其中我们新增了 20+ 个自定义测试（位于 `serein-user/tests/`）：

| 类别 | 测试程序 |
|------|----------|
| **内存管理** | `cowstress`, `mmaptest`, `mincore_test` |
| **信号系统** | `sigtest`, `sigtest2`, `alarmtest` |
| **信号量** | `semtest`, `semtest2`, `semstress` |
| **共享内存** | `shmtest1`, `shmtest2`, `shmstress` |
| **线程/并发** | `threadtest`, `polltest`, `nbtest` |
| **文件系统** | `fcntltest`, `chmodtest`, `testdev`, `exttest` |
| **进程/权限** | `idtest`, `pgtest` |

---

## 新增特性

### 内存管理

| 特性 | 说明 |
|------|------|
| **Copy-on-Write** | fork 时共享页面，写入时才复制，fork 10MB 进程从 80ms 降到 5ms |
| **Lazy Allocation** | sbrk 延迟分配，首次访问时按需加载物理页 |
| **mmap/munmap** | 内存映射文件，支持 MAP_SHARED 和 MAP_PRIVATE |
| **mincore** | 查询页面物理驻留状态 |
| **共享内存** | 命名多页共享内存，支持引用计数和 unlink 语义 |

### 进程调度

| 特性 | 说明 |
|------|------|
| **Stride 调度** | 公平份额调度算法，通过 tickets 设置进程权重 |
| **POSIX 信号量** | sem_open/wait/post/close 完整实现 |
| **信号系统** | 完整 POSIX 信号支持，32 种信号 + 用户自定义处理器 |
| **clone/futex** | 线程支持，CLONE_VM/CLONE_FILES/CLONE_THREAD |

### 网络功能 (V3.1)

| 特性 | 说明 |
|------|------|
| **BSD Socket API** | socket/bind/listen/accept/connect/send/recv |
| **Unix Domain Socket** | 基于内核缓冲区的本地进程间通信 |
| **IPv4 Loopback** | 127.0.0.1 本地回环，支持端口分发 |
| **UDP** | 无连接数据报传输，保留消息边界 |

### I/O 与文件系统

| 特性 | 说明 |
|------|------|
| **poll()** | I/O 多路复用，同时监控多个文件描述符 |
| **alarm()** | 定时器，配合 SIGALRM 实现超时功能 |
| **fcntl()** | 文件描述符控制，F_DUPFD/F_GETFL/F_SETFL |
| **非阻塞 I/O** | O_NONBLOCK 支持，pipe2 系统调用 |
| **FAT32 优化** | 稀疏簇索引，大文件随机访问从 O(n) 降到 O(1) |
| **/dev/null, /dev/zero** | 特殊设备文件支持 |

### Shell 增强

**新增功能**：

| 特性 | 说明 |
|------|------|
| **Tab 补全** | 输入前缀按 Tab 自动补全命令和文件名 |
| **命令历史** | ↑/↓ 浏览最近 16 条历史命令 |
| **光标编辑** | ←/→ 移动光标，支持行内插入和删除 |
| **Ctrl+C** | 终止当前进程 |
| **Ctrl+L** | 快捷清屏 |
| **halt/reboot** | 软关机和重启命令 |

**原版保留**：

| 快捷键 | 说明 |
|--------|------|
| **Ctrl+H** | 退格 (Backspace) |
| **Ctrl+U** | 删除当前行 |
| **Ctrl+D** | 文件结束 (EOF) |
| **Ctrl+P** | 打印进程列表 |

### 可视化演示

```bash
procshow      # Stride 调度器可视化
memviz        # 内存管理演示 (Lazy + CoW)
sockviz demo  # Socket 网络状态监控
ipcband       # IPC 生产者-消费者演示
pollwatch     # poll() I/O 多路复用演示
```

### 其他改进

- **PID 哈希表**: kill/wait 从 O(N) 降到 O(1)
- **缓冲区分桶**: 多核 I/O 争用优化
- **多级日志系统**: LOG_DEBUG/LOG_INF/LOG_WARN/LOG_ERROR
- **控制台溢出监控**: 统计丢弃字符数

---

## 原版功能保留

以下是从 xv6-k210 基线继承并保留的功能：

- **多核启动**: 支持 RISC-V 双核 SMP 启动
- **FAT32 文件系统**: 替代原版 xv6 文件系统，支持标准 SD 卡格式
- **进程管理**: fork/exec/wait/exit/kill 完整进程生命周期
- **虚拟内存**: 页表管理、用户/内核地址空间隔离
- **中断处理**: 时钟中断、S 态外部中断
- **UART 串口**: UARTHS 串口数据收发
- **Shell**: 命令解析、管道、重定向支持
- **基础命令**: ls、cat、echo、grep、mkdir、rm、wc、find 等

## 添加用户程序

1. 在 `serein-user/` 目录下新建 C 文件，如 `myprog.c`
2. 引入 `user.h` 头文件使用系统调用
3. 在 `Makefile` 的 `UPROGS` 中添加 `$U/_myprog\`
4. 运行 `make userprogs`

## 版本历史

| 版本 | 主要特性 |
|------|----------|
| V1.0 | CoW、Lazy Allocation、Stride 调度、POSIX 信号量 |
| V2.0 | mmap、信号系统、共享内存、PID 哈希表 |
| V2.3 | 缓冲区分桶、非阻塞 I/O、FAT32 优化 |
| V3.0 | poll、alarm、fcntl、clone/futex、Shell 增强 |
| V3.1 | BSD Socket、Unix Domain、UDP、sockviz 可视化 |

## 致谢

> Serein 一词源自法语，意为“傍晚的晴空雨”，感谢朋友的同名电影所带来的启发。

- [HUST-OS/xv6-k210](https://github.com/HUST-OS/xv6-k210) - 项目bassline
- [MIT xv6](https://github.com/mit-pdos/xv6-riscv) - 原版 xv6

## License

MIT License
