// alarmtest.c - V3.0 alarm() timer test
// Tests the SIGALRM signal delivery mechanism

#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

volatile int alarm_received = 0;

void alarm_handler(int sig)
{
    alarm_received = 1;
    printf("SIGALRM handler called! sig=%d\n", sig);
}

int alarmtest_main(int argc, char *argv[])
{
    printf("=== alarm() Timer Test ===\n\n");
    
    // Test 1: Basic alarm functionality
    printf("Test 1: Set alarm for 2 seconds\n");
    
    // Register signal handler
    if(sigaction(SIGALRM, alarm_handler) < 0) {
        printf("ERROR: sigaction failed\n");
        exit(1);
    }
    printf("  Registered SIGALRM handler\n");
    
    // Set alarm for 2 seconds
    int remaining = alarm(2);
    printf("  alarm(2) returned %d (should be 0)\n", remaining);
    
    printf("  Waiting for SIGALRM...\n");
    
    // Wait for alarm (busy loop for simplicity)
    int start = uptime();
    while(!alarm_received && (uptime() - start) < 50) {
        // Yield to allow timer interrupts
        sleep(1);
    }
    
    if(alarm_received) {
        printf("  SUCCESS: SIGALRM received!\n");
    } else {
        printf("  FAILED: SIGALRM not received within timeout\n");
        exit(1);
    }
    
    // Test 2: Alarm cancellation
    printf("\nTest 2: Alarm cancellation\n");
    alarm_received = 0;
    
    alarm(5);  // Set 5 second alarm
    printf("  Set alarm(5)\n");
    
    remaining = alarm(0);  // Cancel it
    printf("  alarm(0) to cancel, returned remaining=%d\n", remaining);
    
    // Wait briefly to confirm no signal
    sleep(20);  // 2 seconds
    
    if(!alarm_received) {
        printf("  SUCCESS: No SIGALRM after cancellation\n");
    } else {
        printf("  FAILED: Received SIGALRM after cancellation\n");
        exit(1);
    }
    
    // Test 3: Alarm replacement
    printf("\nTest 3: Alarm replacement\n");
    alarm_received = 0;
    
    alarm(10);  // Set 10 second alarm
    printf("  Set alarm(10)\n");
    
    remaining = alarm(1);  // Replace with 1 second alarm
    printf("  alarm(1) returned %d (should be ~10)\n", remaining);
    
    // Wait for new alarm
    start = uptime();
    while(!alarm_received && (uptime() - start) < 30) {
        sleep(1);
    }
    
    if(alarm_received) {
        printf("  SUCCESS: New 1-second alarm fired!\n");
    } else {
        printf("  FAILED: Replacement alarm not received\n");
        exit(1);
    }
    
    printf("\n=== All alarm tests PASSED ===\n");
    exit(0);
}
