// Buffer cache with bucket partitioning (V2.0)
//
// The buffer cache is organized into NBUCKET hash buckets, each with
// its own lock. This reduces lock contention compared to a single global lock.
//
// Buffers are hashed to buckets by sector number. Each bucket maintains
// its own LRU list. When evicting, we use timestamps for global LRU.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.

#include "include/types.h"
#include "include/param.h"
#include "include/spinlock.h"
#include "include/sleeplock.h"
#include "include/riscv.h"
#include "include/buf.h"
#include "include/sdcard.h"
#include "include/printf.h"
#include "include/disk.h"

// Hash function to map sector number to bucket
#define BUCKET(sectorno) ((sectorno) % NBUCKET)

// Global timestamp for LRU
static uint ticks_counter = 0;

// Per-bucket structure
struct bucket {
  struct spinlock lock;
  struct buf head;  // Linked list head for this bucket
};

static struct bucket bcache[NBUCKET];
static struct buf buf[NBUF];  // Global buffer array

void
binit(void)
{
  struct buf *b;
  int i;

  // Initialize each bucket with static lock name
  for(i = 0; i < NBUCKET; i++){
    initlock(&bcache[i].lock, "bcache");
    bcache[i].head.prev = &bcache[i].head;
    bcache[i].head.next = &bcache[i].head;
  }

  // Distribute buffers across buckets initially
  for(i = 0; i < NBUF; i++){
    b = &buf[i];
    b->refcnt = 0;
    b->sectorno = ~0;
    b->dev = ~0;
    b->lastuse = 0;
    initsleeplock(&b->lock, "buffer");
    
    // Initially assign to bucket based on index
    int bucket_idx = i % NBUCKET;
    b->next = bcache[bucket_idx].head.next;
    b->prev = &bcache[bucket_idx].head;
    bcache[bucket_idx].head.next->prev = b;
    bcache[bucket_idx].head.next = b;
  }
  
  #ifdef DEBUG
  printf("binit: %d buckets, %d buffers\n", NBUCKET, NBUF);
  #endif
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint sectorno)
{
  struct buf *b;
  int bucket_idx = BUCKET(sectorno);
  struct bucket *bkt = &bcache[bucket_idx];

  acquire(&bkt->lock);

  // Is the block already cached in this bucket?
  for(b = bkt->head.next; b != &bkt->head; b = b->next){
    if(b->dev == dev && b->sectorno == sectorno){
      b->refcnt++;
      b->lastuse = ++ticks_counter;
      release(&bkt->lock);
      acquiresleep(&b->lock);
      return b;
    }
  }

  // Not cached. Find a buffer to recycle in this bucket.
  // Use LRU: find the buffer with smallest lastuse and refcnt == 0
  struct buf *victim = 0;
  uint min_lastuse = ~0U;
  
  for(b = bkt->head.prev; b != &bkt->head; b = b->prev){
    if(b->refcnt == 0 && b->lastuse < min_lastuse){
      min_lastuse = b->lastuse;
      victim = b;
    }
  }
  
  if(victim){
    victim->dev = dev;
    victim->sectorno = sectorno;
    victim->valid = 0;
    victim->refcnt = 1;
    victim->lastuse = ++ticks_counter;
    release(&bkt->lock);
    acquiresleep(&victim->lock);
    return victim;
  }

  // No free buffer in this bucket, try to steal from other buckets
  release(&bkt->lock);
  
  for(int i = 0; i < NBUCKET; i++){
    if(i == bucket_idx) continue;  // Already checked
    
    struct bucket *other = &bcache[i];
    acquire(&other->lock);
    
    // Find LRU buffer with refcnt == 0
    victim = 0;
    min_lastuse = ~0U;
    for(b = other->head.prev; b != &other->head; b = b->prev){
      if(b->refcnt == 0 && b->lastuse < min_lastuse){
        min_lastuse = b->lastuse;
        victim = b;
      }
    }
    
    if(victim){
      // Remove from old bucket
      victim->next->prev = victim->prev;
      victim->prev->next = victim->next;
      release(&other->lock);
      
      // Add to target bucket
      acquire(&bkt->lock);
      victim->next = bkt->head.next;
      victim->prev = &bkt->head;
      bkt->head.next->prev = victim;
      bkt->head.next = victim;
      
      victim->dev = dev;
      victim->sectorno = sectorno;
      victim->valid = 0;
      victim->refcnt = 1;
      victim->lastuse = ++ticks_counter;
      release(&bkt->lock);
      acquiresleep(&victim->lock);
      return victim;
    }
    
    release(&other->lock);
  }
  
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf* 
bread(uint dev, uint sectorno) {
  struct buf *b;

  b = bget(dev, sectorno);
  if (!b->valid) {
    disk_read(b);
    b->valid = 1;
  }

  return b;
}

// Write b's contents to disk.  Must be locked.
void 
bwrite(struct buf *b) {
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  disk_write(b);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list in its bucket.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  releasesleep(&b->lock);

  int bucket_idx = BUCKET(b->sectorno);
  struct bucket *bkt = &bcache[bucket_idx];
  
  acquire(&bkt->lock);
  b->refcnt--;
  if (b->refcnt == 0) {
    // Move to head of LRU list (most recently used)
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bkt->head.next;
    b->prev = &bkt->head;
    bkt->head.next->prev = b;
    bkt->head.next = b;
  }
  release(&bkt->lock);
}

void
bpin(struct buf *b) {
  int bucket_idx = BUCKET(b->sectorno);
  acquire(&bcache[bucket_idx].lock);
  b->refcnt++;
  release(&bcache[bucket_idx].lock);
}

void
bunpin(struct buf *b) {
  int bucket_idx = BUCKET(b->sectorno);
  acquire(&bcache[bucket_idx].lock);
  b->refcnt--;
  release(&bcache[bucket_idx].lock);
}
