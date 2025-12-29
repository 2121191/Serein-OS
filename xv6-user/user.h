#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/fcntl.h"

struct stat;
struct rtcdate;
struct sysinfo;
struct pstat;

// system calls
int fork(void);
int exit(int) __attribute__((noreturn));
int wait(int*);
int pipe(int*);
int write(int fd, const void *buf, int len);
int read(int fd, void *buf, int len);
int close(int fd);
int kill(int pid);
int exec(char*, char**);
int open(const char *filename, int mode);
int fstat(int fd, struct stat*);
int mkdir(const char *dirname);
int chdir(const char *dirname);
int dup(int fd);
int getpid(void);
char* sbrk(int size);
int sleep(int ticks);
int uptime(void);
int test_proc(int);
int dev(int, short, short);
int readdir(int fd, struct stat*);
int getcwd(char *buf);
int remove(char *filename);
int trace(int mask);
int sysinfo(struct sysinfo *);
int rename(char *old, char *new);
int sem_open(int initial_value);
int sem_wait(int sem_id);
int sem_post(int sem_id);
int sem_close(int sem_id);
int sem_getvalue(int sem_id, int *value);
int settickets(int n);
int getpinfo(struct pstat *);
int waitpid(int pid, int *status, int options);
int shmcreate(char *name, uint64 size);
int shmopen(char *name);
uint64 shmattach(int shmid);
int shmdetach(uint64 va, uint64 size);
int shmunlink(char *name);
void *mmap(void *addr, uint64 len, int prot, int flags, int fd, uint64 offset);
int munmap(void *addr, uint64 len);

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
char* strcat(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void fprintf(int, const char*, ...);
void printf(const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
int memcmp(const void *, const void *, uint);
void *memcpy(void *, const void *, uint);
