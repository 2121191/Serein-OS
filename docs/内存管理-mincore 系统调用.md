# 内核原理-内存管理-mincore 系统调用

## 1. 工作概述 
我们在实现懒分配（Lazy Allocation）之前，进程通过 `sbrk()` 扩展堆内存时通常会同步完成物理页分配，因此用户态很难区分“仅扩展了虚拟地址空间”与“已经真正分配了物理内存”。

为验证本项目中新加入的 **Lazy Allocation** 行为，我们为此新增了 `mincore` 系统调用，使用户程序可以查询一段虚拟地址范围内：哪些页面已经具备有效映射。

相关代码位置：
- 系统调用号：`kernel/include/sysnum.h`（`SYS_mincore`）
- 系统调用注册：`kernel/syscall.c`
- 系统调用实现：`kernel/sysproc.c`（`sys_mincore()`）
- 用户态接口：`xv6-user/user.h`（`int mincore(void *addr, uint64 length, unsigned char *vec);`）
- 用户态测试：`xv6-user/tests/mincore_test.c`

---

## 2. 问题发现 
引入 Lazy Allocation 后，系统的预期行为是：
- `sbrk(n)` **只增加进程的逻辑地址空间大小**（例如 `p->sz`），并不立即分配物理页。
- 当程序第一次访问这些新地址时，触发 Page Fault，再由内核按需分配物理页并建立映射。

因此需要一个用户态可用的机制来回答：
- “我 `sbrk` 出来的这几页里，到底哪些页已经真正分配到物理内存了？”

---

## 3. 解决方案 
### 3.1 内核侧实现要点
`sys_mincore()` 在内核中的核心处理流程为：
1. 解析参数并进行基本校验：
   - `addr` 必须页对齐
   - `length` 不能为 0
   - 检查 `addr + length` 溢出
2. 计算需要查询的页面数 `npages`，并按“1 页对应 1 bit”组织为位图，位图大小为 `vec_size = (npages + 7)/8`。
3. 遍历每个页面地址 `a = addr + i*PGSIZE`：
   - 通过 `walk(p->pagetable, a, 0)` 获取页表项
   - 若页表项存在且 `PTE_V` 有效，则认为该页已驻留（已映射物理页），设置位图对应 bit 为 1

---

## 5. 测试与验证 
项目中提供了用户态测试 mincore_test.c`，测试流程为：
- 申请多页内存
- 第一次 `mincore`：打印每页 bit
- 逐页 touch（写入 `p[i*PGSIZE]`）
- 第二次 `mincore`：再次打印每页 bit

该测试用例用于直接观察 Lazy Allocation 的效果：**sbrk 后不分配，touch 后才分配**。

---

## 6. 小结
综上，张尚昆同学新增了 `mincore` 系统调用，用于从用户态查询虚拟页是否已经建立有效映射，从而为本项目中新加入的 Lazy Allocation 机制提供了可观测、可验证的手段，并配套 `mincore_test` 完成了基本验证流程。

