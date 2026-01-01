// polltest.c - V3.0 poll() I/O multiplexing test
// Tests the poll system call for various scenarios

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

int main(int argc, char *argv[])
{
    int p[2];
    struct pollfd fds[3];
    int ret;
    char buf[64];
    
    printf("=== poll() I/O Multiplexing Test ===\n\n");
    
    // Test 1: poll 超时测试
    printf("Test 1: Timeout test (poll with 200ms timeout)\n");
    fds[0].fd = 0;  // stdin
    fds[0].events = POLLIN;
    fds[0].revents = 0;
    
    int start = uptime();
    ret = poll(fds, 1, 200);  // 200ms timeout
    int elapsed = uptime() - start;
    
    printf("  poll returned %d, elapsed ~%d ticks\n", ret, elapsed);
    if(ret == 0 && elapsed >= 1) {
        printf("  SUCCESS: poll timeout works\n");
    } else if(ret == 0) {
        printf("  WARNING: returned immediately (stdin might have data)\n");
    } else {
        printf("  NOTE: stdin has data ready, revents=0x%x\n", fds[0].revents);
    }
    
    // Test 2: pipe poll
    printf("\nTest 2: Pipe poll test\n");
    
    if(pipe(p) < 0) {
        printf("  ERROR: pipe failed\n");
        exit(1);
    }
    
    // 空管道应该只有写就绪
    fds[0].fd = p[0];  // 读端
    fds[0].events = POLLIN;
    fds[0].revents = 0;
    
    fds[1].fd = p[1];  // 写端
    fds[1].events = POLLOUT;
    fds[1].revents = 0;
    
    ret = poll(fds, 2, 0);  // 立即返回
    printf("  Empty pipe: poll returned %d\n", ret);
    printf("    Read fd: revents=0x%x (expect 0)\n", fds[0].revents);
    printf("    Write fd: revents=0x%x (expect POLLOUT=0x4)\n", fds[1].revents);
    
    if((fds[1].revents & POLLOUT) && !(fds[0].revents & POLLIN)) {
        printf("  SUCCESS: Empty pipe state correct\n");
    } else {
        printf("  WARNING: Unexpected state\n");
    }
    
    // 写入数据后再测试
    printf("\nTest 3: Pipe with data\n");
    write(p[1], "hello", 5);
    
    fds[0].revents = 0;
    fds[1].revents = 0;
    
    ret = poll(fds, 2, 0);
    printf("  After write: poll returned %d\n", ret);
    printf("    Read fd: revents=0x%x (expect POLLIN=0x1)\n", fds[0].revents);
    printf("    Write fd: revents=0x%x (expect POLLOUT=0x4)\n", fds[1].revents);
    
    if((fds[0].revents & POLLIN) && (fds[1].revents & POLLOUT)) {
        printf("  SUCCESS: Pipe with data state correct\n");
    } else {
        printf("  FAILED: Unexpected state\n");
    }
    
    // 清空管道
    read(p[0], buf, 5);
    
    // Test 4: 关闭写端后读端应该显示 POLLHUP
    printf("\nTest 4: Closed write end -> POLLHUP\n");
    close(p[1]);
    
    fds[0].revents = 0;
    ret = poll(fds, 1, 0);
    printf("  After close write end: revents=0x%x (expect POLLHUP=0x10)\n", fds[0].revents);
    
    if(fds[0].revents & POLLHUP) {
        printf("  SUCCESS: POLLHUP detected\n");
    } else {
        printf("  WARNING: POLLHUP not set\n");
    }
    
    close(p[0]);
    
    // Test 5: 无效 fd
    printf("\nTest 5: Invalid fd -> POLLNVAL\n");
    fds[0].fd = 999;  // 无效 fd
    fds[0].events = POLLIN;
    fds[0].revents = 0;
    
    ret = poll(fds, 1, 0);
    printf("  Invalid fd 999: revents=0x%x (expect POLLNVAL=0x20)\n", fds[0].revents);
    
    if(fds[0].revents & POLLNVAL) {
        printf("  SUCCESS: POLLNVAL detected\n");
    } else {
        printf("  FAILED: POLLNVAL not set\n");
    }
    
    // Test 6: 文件 poll
    printf("\nTest 6: File poll\n");
    int fd = open("README", 0);  // 打开只读
    if(fd < 0) {
        printf("  Skip: README not found\n");
    } else {
        fds[0].fd = fd;
        fds[0].events = POLLIN | POLLOUT;
        fds[0].revents = 0;
        
        ret = poll(fds, 1, 0);
        printf("  File poll: revents=0x%x (expect POLLIN=0x1)\n", fds[0].revents);
        
        if(fds[0].revents & POLLIN) {
            printf("  SUCCESS: File is readable\n");
        }
        close(fd);
    }
    
    printf("\n=== All poll tests completed ===\n");
    exit(0);
}
