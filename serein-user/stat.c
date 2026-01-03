#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "serein-user/user.h"

int
main(int argc, char *argv[])
{
  struct stat st;
  int i;

  if(argc <= 1){
    fprintf(2, "usage: stat file...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(stat(argv[i], &st) < 0){
      fprintf(2, "stat: cannot stat %s\n", argv[i]);
      continue;
    }
    printf("%s:\n", argv[i]);
    printf("  type: ");
    if(st.type == T_DIR) printf("directory\n");
    else if(st.type == T_FILE) printf("file\n");
    else if(st.type == T_DEVICE) printf("device\n");
    else printf("unknown(%d)\n", st.type);
    printf("  size: %d bytes\n", st.size);
    printf("  dev: %d\n", st.dev);
  }
  exit(0);
}
