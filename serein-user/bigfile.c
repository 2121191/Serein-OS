#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/fcntl.h"
#include "serein-user/user.h"

#define BSIZE 512
#define TARGET_SIZE (10 * 1024 * 1024) // 10MB

int
main(int argc, char *argv[])
{
  int fd, i;
  char buf[BSIZE];
  int n;
  char *fname = "bigfile.txt";

  printf("bigfile: creating %s, target size %d bytes\n", fname, TARGET_SIZE);

  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf("bigfile: cannot open %s\n", fname);
    exit(0); // Failed to open file
  }

  // Initialize buffer with some pattern
  for(i = 0; i < BSIZE; i++){
    buf[i] = i % 256;
  }

  int total_written = 0;
  int start_time = uptime();

  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
    if((n = write(fd, buf, BSIZE)) != BSIZE){
      printf("bigfile: write error at block %d, wrote %d bytes (expected %d)\n", i, n, BSIZE);
      exit(0); // Write failed
    }
    total_written += n;
    if((total_written % (100 * 1024)) == 0){
      printf("bigfile: written %d KB\n", total_written / 1024);
    }
  }

  printf("bigfile: write complete, total %d bytes\n", total_written);
  close(fd);
  int end_time = uptime();
  printf("bigfile: time taken (ticks): %d\n", end_time - start_time);

  printf("bigfile: testing random access optimization using mmap...\n");
  fd = open(fname, O_RDONLY);
  if(fd < 0){
      printf("bigfile: cannot open for mmap\n");
      exit(0);
  }

  void *map_addr = mmap(0, TARGET_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
  if(map_addr == MAP_FAILED) {
      printf("bigfile: mmap failed\n");
      exit(0);
  }
  printf("bigfile: mmap success at %p\n", map_addr);

  char *data = (char*)map_addr;
  volatile char c; 
  
  // 1. Read near end (Forward Seek) - Should be fast with or without index if sequential, 
  // but here we jump 0 -> 9MB. Without index: O(N). With index: O(1).
  printf("bigfile: reading near end (9MB)...\n");
  int t1 = uptime();
  c = data[9 * 1024 * 1024]; 
  int t2 = uptime();
  printf("bigfile: read 9MB took %d ticks\n", t2 - t1);
  
  // 2. Read near start (Backward Seek) - Without index: Rewind + O(N). With index: Jump back O(1).
  printf("bigfile: reading near start (1MB)...\n");
  t1 = uptime();
  c = data[1 * 1024 * 1024];
  t2 = uptime();
  printf("bigfile: read 1MB took %d ticks\n", t2 - t1);
  
  // Verify data
  if (c != (char)((1024*1024)%256)) {
      printf("bigfile: Data mismatch at 1MB! %d vs %d\n", c, (1024*1024)%256);
  }

  // 3. Read middle (Random)
  printf("bigfile: reading middle (5MB)...\n");
  t1 = uptime();
  c = data[5 * 1024 * 1024];
  t2 = uptime();
  printf("bigfile: read 5MB took %d ticks\n", t2 - t1);

  munmap(map_addr, TARGET_SIZE);
  // close(fd) is called below
  printf("bigfile: time taken (ticks): %d\n", end_time - start_time);


  printf("bigfile: verifying data...\n");
  fd = open(fname, O_RDONLY);
  if(fd < 0){
      printf("bigfile: cannot re-open %s for verification\n", fname);
      exit(0);
  }

  int total_read = 0;
  for(i = 0; i < TARGET_SIZE / BSIZE; i++){
      if((n = read(fd, buf, BSIZE)) != BSIZE){
          printf("bigfile: read error at block %d, ready %d bytes\n", i, n);
          exit(0);
      }
      // Simple check of first byte of the block to ensure we are reading valid-ish data
      // Check full buffer to be sure? 
      // For speed, let's just check the first byte of each block for now, or check a few spots.
      // But full check is safer.
      for(int k=0; k<BSIZE; k++){
        if(buf[k] != (char)(k % 256)){
            printf("bigfile: data mismatch at block %d offset %d. Expected %d got %d\n", i, k, (k%256), buf[k]);
            exit(0);
        }
      }
      total_read += n;
      if((total_read % (100 * 1024)) == 0){
          // limit output to avoid spamming console too much during verification
          if (total_read % (1024*1024) == 0) // log every 1MB read
              printf("bigfile: verified %d MB\n", total_read / (1024*1024));
      }
  }
  
  printf("bigfile: verification successful!\n");
  close(fd);

  // Clean up
  if(remove(fname) < 0){
      printf("bigfile: failed to delete %s\n", fname);
  } else {
      printf("bigfile: deleted %s\n", fname);
  }

  exit(0);
}
