#ifndef __PARAM_H
#define __PARAM_H

#define NPROC        50  // maximum number of processes
#define NCPU          2  // maximum number of CPUs
#define NOFILE       16  // open files per process
#define NFILE       100  // open files per system
#define NINODE       50  // maximum number of active i-nodes
#define NDEV         10  // maximum major device number
#define ROOTDEV       1  // device number of file system root disk
#define MAXARG       32  // max exec arguments
#define MAXOPBLOCKS  10  // max # of blocks any FS op writes
#define LOGSIZE      (MAXOPBLOCKS*3)  // max data blocks in on-disk log
#define NBUF         60  // size of disk block cache (increased for bucket partitioning)
#define NBUCKET      13  // number of bcache buckets (prime for better distribution)
#define FSSIZE       1000  // size of file system in blocks
#define MAXPATH      260   // maximum file path name
#define INTERVAL     (390000000 / 200) // timer interrupt interval

#endif