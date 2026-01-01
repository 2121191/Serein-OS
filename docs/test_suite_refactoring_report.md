# xv6 测试套件重构报告

**日期**: 2026-01-02  
**版本**: V3.0

---

## 目录

1. [项目概述](#项目概述)
2. [主要改动](#主要改动)
3. [技术实现](#技术实现)
4. [文件变更清单](#文件变更清单)
5. [使用说明](#使用说明)
6. [Bug 修复记录](#bug-修复记录)

---

## 项目概述

本次重构将 xv6 的 **23 个独立测试程序** 整合到 `usertests.c` 中，实现了：

- ✅ 统一的测试入口：通过 `usertests` 运行所有测试
- ✅ Verbose 模式：`-v` 参数显示原始测试的详细输出
- ✅ 代码复用：通过 `#include` 包含原始测试文件，无需重写
- ✅ 清理文件系统：从 UPROGS 中移除独立测试程序

---

## 主要改动

### 1. 测试文件迁移

将 23 个测试文件迁移至 `xv6-user/tests/` 目录：

| 测试文件 | 功能描述 |
|----------|----------|
| `alarmtest.c` | SIGALRM 定时器测试 |
| `fcntltest.c` | fcntl() 系统调用测试 |
| `chmodtest.c` | chmod/fchmod 权限测试 |
| `threadtest.c` | clone() 线程创建测试 |
| `exttest.c` | lseek/dup2/getppid 测试 |
| `idtest.c` | UID/GID 管理测试 |
| `nbtest.c` | 非阻塞 I/O 测试 |
| `pgtest.c` | 进程组管理测试 |
| `polltest.c` | poll() 多路复用测试 |
| `sigtest.c` | kill2 信号发送测试 |
| `sigtest2.c` | 信号处理器测试 |
| `testdev.c` | /dev/null, /dev/zero 测试 |
| `mincore_test.c` | 内存驻留查询测试 |
| `logtest.c` | 日志输出测试 |
| `test.c` (sysinfotest) | sysinfo() 系统调用测试 |
| `cowstress.c` | Copy-on-Write 压力测试 |
| `semstress.c` | 信号量压力测试 |
| `shmstress.c` | 共享内存压力测试 |
| `semtest.c` | 信号量基本功能测试 |
| `semtest2.c` | 信号量扩展测试 |
| `shmtest1.c` | 共享内存创建/打开测试 |
| `shmtest2.c` | 共享内存附加/分离测试 |
| `mmaptest.c` | mmap 内存映射测试 |

### 2. usertests.c 改动

**改动内容**：
- 添加 `#include "tests/xxx.c"` 引入原始测试代码
- 将测试文件的 `main` 函数重命名为 `xxx_main`
- 添加 wrapper 函数，支持 verbose 和简化两种模式
- 添加 `-v` 命令行参数支持
- 注册所有新测试到 `tests[]` 数组

**代码结构**：
```c
// 全局 verbose 标志
int verbose = 0;

// 包含原始测试文件
#include "tests/alarmtest.c"
#include "tests/fcntltest.c"
// ... 23个文件

// Wrapper 函数示例
void alarmtest(char *s) {
    if(verbose) { 
        alarmtest_main(1, argv);  // 调用完整测试
        return; 
    }
    // 简化版测试逻辑
    ...
}
```

### 3. Makefile 改动

**移除的 UPROGS 条目**（23个测试程序）：
- `_alarmtest`, `_fcntltest`, `_chmodtest`, `_threadtest`
- `_exttest`, `_idtest`, `_nbtest`, `_pgtest`
- `_polltest`, `_sigtest`, `_sigtest2`, `_testdev`
- `_mincoretest`, `_logtest`, `_test`
- `_cowstress`, `_semstress`, `_shmstress`
- `_semtest`, `_semtest2`, `_shmtest1`, `_shmtest2`
- `_mmaptest`

**保留的独立程序**：
- `_consoletest` - 交互式测试，需手动输入

---

## 技术实现

### Verbose 模式实现

```c
int
run(void f(char *), char *s) {
    if(verbose) {
        printf("test %s:\n", s);  // 带换行，显示详细输出
    } else {
        printf("test %s: ", s);   // 不换行，等待 OK/FAILED
    }
    
    // 始终使用 fork 保持进程隔离
    if((pid = fork()) < 0) { ... }
    if(pid == 0) {
        f(s);
        exit(0);
    }
    wait(&xstatus);
    // 输出结果
}
```

### 测试函数主入口重命名

所有测试文件的 `main` 函数已重命名为 `xxx_main`：
```c
// 原始
int main(int argc, char *argv[]) { ... }

// 重命名后
int alarmtest_main(int argc, char *argv[]) { ... }
static int mmaptest_main(int argc, char *argv[]) { ... }
```

### 宏冲突解决

部分测试文件有相同的宏定义（如 `ITERATIONS`, `NPROCS`），通过 `#undef` 解决：
```c
#undef ITERATIONS
#undef NPROCS
// semstress.c, shmstress.c 开头
```

### 函数冲突解决

stress 测试文件中的内部函数重命名避免冲突：
- `cowstress()` → `cowstress_run()`
- `semstress()` → `semstress_run()`
- `shmstress()` → `shmstress_run()`

---

## 文件变更清单

### 新增文件
- `xv6-user/tests/` 目录下 23 个测试文件

### 修改文件

| 文件 | 改动类型 |
|------|----------|
| `xv6-user/usertests.c` | 添加 #include、wrapper 函数、verbose 支持 |
| `Makefile` | 移除 23 个测试程序的 UPROGS 条目，添加 _consoletest |
| `kernel/shm.c` | 修复共享内存引用计数泄漏 |

### 文件统计

- `usertests.c`: ~3000 行（原 ~2600 行）
- UPROGS 数量: 30 → 31（+consoletest, -23 测试程序）

---

## 使用说明

### 运行所有测试
```bash
usertests
```

### 运行单个测试
```bash
usertests alarmtest       # 简化输出
usertests -v alarmtest    # 详细输出（与原独立程序一致）
```

### 支持的参数
```
usertests [-v] [-c] [testname]
  -v: verbose 模式，显示详细测试输出
  -c: 连续模式，循环运行测试
```

### 交互式测试
```bash
consoletest    # 需手动输入测试
```

---

## Bug 修复记录

### 共享内存引用计数泄漏

**问题描述**：
- `shmcreate` 设置 `ref=1`
- `shmopen` 增加 `ref`（错误）
- `shmunlink` 不减少 `ref`（错误）
- 导致共享内存永不释放

**修复方案**：
1. `shmopen` 不再增加 `ref`（由 attach/detach 管理）
2. `shmunlink` 减少 `ref`（释放创建者引用）

**修改文件**：`kernel/shm.c`

---

## 总结

本次重构实现了 xv6 测试套件的现代化管理：
- 统一入口降低维护成本
- Verbose 模式保留调试能力
- 代码复用减少重复劳动
- 清理文件系统提升用户体验

**测试通过情况**：所有 integrated tests 通过 ✅
