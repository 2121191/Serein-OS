#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "user.h"

#define PGSIZE 4096

static int
bit_is_set(unsigned char *vec, int idx)
{
  return (vec[idx/8] >> (idx % 8)) & 1;
}

int
main(void)
{
  int pages = 8;
  int len = pages * PGSIZE;
  unsigned char vec[(8 + 7) / 8];

  char *p = sbrk(len);
  if(p == (char*)-1){
    printf("mincore_test: sbrk failed\n");
    exit(1);
  }

  // 第一次查询
  if(mincore(p, len, vec) < 0){
    printf("mincore_test: mincore failed\n");
    exit(1);
  }

  printf("mincore_test: after sbrk\n");
  for(int i = 0; i < pages; i++){
    printf("  page %d: %d\n", i, bit_is_set(vec, i));
  }

  // 访问一下每页，确保映射存在
  for(int i = 0; i < pages; i++){
    p[i * PGSIZE] = (char)i;
  }

  // 第二次查询
  if(mincore(p, len, vec) < 0){
    printf("mincore_test: mincore failed after touch\n");
    exit(1);
  }

  printf("mincore_test: after touch\n");
  for(int i = 0; i < pages; i++){
    printf("  page %d: %d\n", i, bit_is_set(vec, i));
  }

  // 回收
  sbrk(-len);
  exit(0);
}

