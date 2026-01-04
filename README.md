**Competition Entry**: Hefei University of Technology (合肥工业大学) | Team: 宇宙警备队 | [GitHub Repository](https://github.com/2121191/Serein-OS)

# Serein OS

An enhanced RISC-V operating system kernel based on HUST xv6-k210  
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

## Overview

Serein is an enhanced operating system kernel based on HUST-OS/xv6-k210. We ported the original kernel to **QEMU v6.2+** with standard **OpenSBI** boot support. While preserving all original features, we added approximately 10,000 lines of kernel code implementing **75 system calls** covering modern OS features.

## Requirements

- `qemu-system-riscv64` (v6.2+)
- RISC-V GCC toolchain: [riscv-gnu-toolchain](https://github.com/riscv/riscv-gnu-toolchain)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/2121191/Serein-OS
cd Serein-OS

# Build filesystem image (requires sudo)
make fs

# Run
make run
```

Press `Ctrl+A` then `X` to exit QEMU.

## Demo

<div align="center">
  <img src="./img/serein_demo.gif" alt="Serein Demo" width="600">
  <br>
  <em>Demo: Project build, system boot, and usertests regression test</em>
</div>

## Running Tests

```bash
# Run full regression test suite in xv6 shell
usertests

# "ALL TESTS PASSED" indicates success
```

The test suite contains **70+ test cases**, including 20+ custom tests we added (in `serein-user/tests/`):

| Category | Tests |
|----------|-------|
| **Memory** | `cowstress`, `mmaptest`, `mincore_test` |
| **Signals** | `sigtest`, `sigtest2`, `alarmtest` |
| **Semaphores** | `semtest`, `semtest2`, `semstress` |
| **Shared Memory** | `shmtest1`, `shmtest2`, `shmstress` |
| **Threads/Concurrency** | `threadtest`, `polltest`, `nbtest` |
| **File System** | `fcntltest`, `chmodtest`, `testdev`, `exttest` |
| **Process/Permissions** | `idtest`, `pgtest` |

---

## New Features

### Memory Management

| Feature | Description |
|---------|-------------|
| **Copy-on-Write** | Share pages on fork, copy on write. Fork 10MB process: 80ms → 5ms |
| **Lazy Allocation** | Demand paging for heap, allocate on first access |
| **mmap/munmap** | Memory-mapped files with MAP_SHARED and MAP_PRIVATE |
| **mincore** | Query page residency status |
| **Shared Memory** | Named multi-page shared memory with refcount and unlink semantics |

### Process Scheduling

| Feature | Description |
|---------|-------------|
| **Stride Scheduling** | Fair-share scheduling with configurable tickets |
| **POSIX Semaphores** | sem_open/wait/post/close implementation |
| **Signal System** | Full POSIX signals, 32 signals + custom handlers |
| **clone/futex** | Thread support with CLONE_VM/CLONE_FILES/CLONE_THREAD |

### Networking (V3.1)

| Feature | Description |
|---------|-------------|
| **BSD Socket API** | socket/bind/listen/accept/connect/send/recv |
| **Unix Domain Socket** | Local IPC via kernel buffer |
| **IPv4 Loopback** | 127.0.0.1 with port dispatch |
| **UDP** | Connectionless datagram with message boundary |

### I/O & File System

| Feature | Description |
|---------|-------------|
| **poll()** | I/O multiplexing for multiple file descriptors |
| **alarm()** | Timer with SIGALRM for timeout functionality |
| **fcntl()** | File descriptor control: F_DUPFD/F_GETFL/F_SETFL |
| **Non-blocking I/O** | O_NONBLOCK support, pipe2 syscall |
| **FAT32 Optimization** | Sparse cluster index, O(n) → O(1) random access |
| **/dev/null, /dev/zero** | Special device file support |

### Shell Enhancement

**New Features**:

| Feature | Description |
|---------|-------------|
| **Tab Completion** | Auto-complete commands and filenames |
| **Command History** | ↑/↓ to browse last 16 commands |
| **Cursor Editing** | ←/→ to move cursor, inline insert/delete |
| **Ctrl+C** | Send SIGINT signal to terminate current process |
| **Ctrl+L** | Quick clear screen |
| **halt/reboot** | Soft shutdown and reboot commands |

**Original Shortcuts** (inherited from xv6-k210):

| Shortcut | Description |
|----------|-------------|
| **Ctrl+H** | Backspace |
| **Ctrl+U** | Kill current line |
| **Ctrl+D** | End of file (EOF) |
| **Ctrl+P** | Print process list |

### Visualization Demos

```bash
procshow      # Stride scheduler visualization
memviz        # Memory management demo (Lazy + CoW)
sockviz demo  # Socket network monitor
ipcband       # IPC producer-consumer demo
pollwatch     # poll() I/O multiplexing demo
```

### Other Improvements

- **PID Hash Table**: kill/wait from O(N) to O(1)
- **Buffer Buckets**: Multi-core I/O contention optimization
- **Multi-level Logging**: LOG_DEBUG/LOG_INF/LOG_WARN/LOG_ERROR
- **Console Overflow Monitor**: Track dropped characters

---

## Original Features Preserved

The following features are inherited and preserved from xv6-k210 baseline:

- **Multi-core Boot**: RISC-V dual-core SMP boot support
- **FAT32 File System**: Replaces original xv6 FS, supports standard SD card format
- **Process Management**: fork/exec/wait/exit/kill full process lifecycle
- **Virtual Memory**: Page table management, user/kernel address space isolation
- **Interrupt Handling**: Timer interrupts, S-mode external interrupts
- **UART Serial**: UARTHS serial data transmission and reception
- **Shell**: Command parsing, pipes, redirection support
- **Basic Commands**: ls, cat, echo, grep, mkdir, rm, wc, find, etc.

## Adding User Programs

1. Create a C file in `serein-user/`, e.g., `myprog.c`
2. Include `user.h` for system calls
3. Add `$U/_myprog\` to `UPROGS` in `Makefile`
4. Run `make userprogs`

## Version History

| Version | Key Features |
|---------|--------------|
| V1.0 | CoW, Lazy Allocation, Stride scheduling, POSIX semaphores |
| V2.0 | mmap, signals, shared memory, PID hash table |
| V2.3 | Buffer buckets, non-blocking I/O, FAT32 optimization |
| V3.0 | poll, alarm, fcntl, clone/futex, shell enhancement |
| V3.1 | BSD Socket, Unix Domain, UDP, sockviz visualization |

## Acknowledgments

> The name "Serein" comes from French, meaning "fine rain falling from a cloudless sky at sunset". Thanks to a friend's film of the same name for the inspiration.

- [HUST-OS/xv6-k210](https://github.com/HUST-OS/xv6-k210) - Project baseline
- [MIT xv6](https://github.com/mit-pdos/xv6-riscv) - Original xv6

## License

MIT License
