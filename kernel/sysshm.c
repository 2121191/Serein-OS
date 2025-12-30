#include "include/types.h"
#include "include/riscv.h"
#include "include/param.h"
#include "include/proc.h"
#include "include/syscall.h"
#include "include/shm.h"
#include "include/printf.h"

extern struct proc proc[];

uint64
sys_shmcreate(void)
{
  char name[SHM_NAME_MAX];
  int size;
  if(argstr(0, name, SHM_NAME_MAX) < 0 || argint(1, &size) < 0)
    return -1;
  return shmcreate(name, (uint64)size);
}

uint64
sys_shmopen(void)
{
  char name[SHM_NAME_MAX];
  if(argstr(0, name, SHM_NAME_MAX) < 0)
    return -1;
  return shmopen(name);
}

uint64
sys_shmattach(void)
{
  int shmid;
  if(argint(0, &shmid) < 0)
    return -1;
  return shmattach(shmid, myproc()->pagetable);
}

uint64
sys_shmdetach(void)
{
  uint64 va;
  int size;
  if(argaddr(0, &va) < 0 || argint(1, &size) < 0)
    return -1;

  return shmdetach(va, myproc()->pagetable, (uint64)size);
}

uint64
sys_shmunlink(void)
{
  char name[SHM_NAME_MAX];
  if(argstr(0, name, SHM_NAME_MAX) < 0)
    return -1;
  return shmunlink(name);
}
