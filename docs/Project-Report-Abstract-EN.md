# xv6-k210 V3.0 Project Report Abstract

## Project Overview

xv6-k210 is an enhanced operating system kernel based on the **HUST-OS/xv6-k210** baseline, which provides a basic port of MIT's xv6 to the RISC-V K210 development board. Starting from this baseline, I developed **four major versions** (V1.0 → V2.0 → V2.3 → V3.0) with approximately **10,000 lines of kernel code contributions**.

## Development Timeline

```
HUST Baseline → V1.0 → V2.0 → V2.3 → V3.0
     ↓           ↓       ↓       ↓       ↓
  Starting    CoW    mmap    Buffer  poll
   Point     Lazy   Signals  Bucket  alarm
            Stride   SHM            clone
             Sem    PID Hash       Shell UX
```

## Version Contributions

### V1.0: Core Memory & Scheduling
- **Copy-on-Write (CoW)**: Fork without copying pages, 16x performance improvement
- **Lazy Allocation**: On-demand page allocation for heap growth
- **POSIX Semaphores**: Inter-process synchronization with wait queues
- **Stride Scheduling**: Deterministic fair-share CPU scheduling
- **QEMU Support**: Dual-platform (K210 hardware + QEMU emulator)
- **~3,000 lines added**

### V2.0: Advanced Features
- **mmap/munmap**: Memory-mapped files with MAP_SHARED/MAP_PRIVATE
- **Signal System**: Complete POSIX signals (32 signals, handlers, sigreturn)
- **Shared Memory**: Named shared memory segments
- **PID Hash Table**: O(1) process lookup for kill()
- **UID/GID Permission**: Basic Unix permission infrastructure
- **~4,000 lines added**

### V2.3: Optimizations
- **Bucketed Buffer Cache**: 13 hash buckets reduce I/O lock contention
- **Non-blocking I/O**: O_NONBLOCK support for pipes and files
- **FAT32 Optimizations**: Allocation hints, sparse indexing
- **~1,000 lines added**

### V3.0: POSIX Compatibility & UX
- **poll()**: I/O multiplexing for multiple file descriptors
- **alarm()**: Timer-based SIGALRM delivery
- **fcntl()**: File descriptor control (F_DUPFD, F_GETFD, F_SETFD, F_GETFL, F_SETFL)
- **clone()/futex()**: Basic POSIX thread support
- **O_CLOEXEC**: Close-on-exec flag for file descriptors
- **Shell Enhancements**: Command history (↑↓), Tab completion, cursor navigation (←→)
- **~1,500 lines added**

## Technical Statistics

| Metric | Value |
|--------|-------|
| My Code Contribution | ~10,000 lines |
| System Calls | 67 |
| Test Cases | 70+ |
| Test Pass Rate | 100% |

## Key Innovations

1. **Two-Phase Stride Scheduling**: Lock-free scan + locked validation to avoid deadlock
2. **Per-CPU Memory Allocator**: Work stealing between CPUs
3. **FAT32 Sparse Indexing**: O(n/128) large file seeking
4. **UART Ring Buffer**: Interrupt top/bottom half separation

## Performance Improvements

| Operation | Before | After | Speedup |
|-----------|--------|-------|---------|
| fork 10MB process | 80ms | 5ms (CoW) | 16x |
| kill() lookup | O(N) | O(1) (hash) | 50x |
| Large file seek | O(n) | O(n/128) | 128x |

## Platform Support

- **Hardware**: K210 dual-core RISC-V (8MB RAM, SD Card)
- **Emulator**: QEMU riscv64-virt with VirtIO

## Conclusion

From the HUST baseline, I developed a feature-rich embedded OS kernel with modern Unix capabilities including virtual memory optimizations (CoW, Lazy, mmap), fair-share scheduling (Stride), complete IPC mechanisms (semaphores, shared memory, signals), and POSIX compatibility features (poll, alarm, fcntl, threads). The project demonstrates deep understanding of operating system internals through ~10,000 lines of carefully designed and tested kernel code.

---

*January 2026*
