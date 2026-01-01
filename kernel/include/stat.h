#ifndef __STAT_H
#define __STAT_H

#define T_DIR     1   // Directory
#define T_FILE    2   // File
#define T_DEVICE  3   // Device

#define STAT_MAX_NAME 32

// V3.0: Unix permission bits
#define S_IRUSR   0400  // Owner read
#define S_IWUSR   0200  // Owner write
#define S_IXUSR   0100  // Owner execute
#define S_IRGRP   0040  // Group read
#define S_IWGRP   0020  // Group write
#define S_IXGRP   0010  // Group execute
#define S_IROTH   0004  // Other read
#define S_IWOTH   0002  // Other write
#define S_IXOTH   0001  // Other execute

// Common permission masks
#define S_IRWXU   (S_IRUSR | S_IWUSR | S_IXUSR)
#define S_IRWXG   (S_IRGRP | S_IWGRP | S_IXGRP)
#define S_IRWXO   (S_IROTH | S_IWOTH | S_IXOTH)

struct stat {
  char name[STAT_MAX_NAME + 1];
  int dev;     // File system's disk device
  short type;  // Type of file
  uint64 size; // Size of file in bytes
  uint16 mode; // V3.0: Permission mode
  uint16 uid;  // V3.0: Owner UID
  uint16 gid;  // V3.0: Owner GID
};

#endif