// sockviz.c - Network Socket Visualization (Rich Demo Version)
#include "kernel/include/types.h"
#include "kernel/include/param.h"
#include "xv6-user/user.h"

#define MAX_SOCKS 64
#define DEMO_PATH "/tmp/viz.demo"

// ANSI Helper
static void cls(void) { fprintf(2, "\033[2J\033[H"); }
static void color_green(void) { fprintf(2, "\033[32m"); }
static void color_yellow(void) { fprintf(2, "\033[33m"); }
static void color_cyan(void) { fprintf(2, "\033[36m"); }
static void color_red(void) { fprintf(2, "\033[31m"); }

static void color_reset(void) { fprintf(2, "\033[0m"); }

static void print_padded_str(char *s, int width) {
    fprintf(2, "%s", s);
    int len = strlen(s);
    while(len < width) { fprintf(2, " "); len++; }
}

static void print_padded_int(int n, int width) {
    fprintf(2, "%d", n);
    int temp = n, digits = 0;
    if(temp == 0) digits = 1;
    else { if(temp < 0) { digits++; temp = -temp; } while(temp > 0) { temp /= 10; digits++; } }
    while(digits < width) { fprintf(2, " "); digits++; }
}

// Process Management
#define MAX_WORKERS 8
static int workers[MAX_WORKERS];
static int worker_count = 0;

static void add_worker(int pid) {
    if(worker_count < MAX_WORKERS) workers[worker_count++] = pid;
}

static void kill_workers() {
    for(int i = 0; i < worker_count; i++) kill(workers[i]);
}

// --- Traffic Generators ---

// 1. Dynamic Server: Handles regular echo and sink
static void demo_server() {
    int s = socket(AF_UNIX, SOCK_STREAM, 0);
    struct sockaddr_un addr;
    addr.family = AF_UNIX;
    strcpy(addr.path, DEMO_PATH);
    remove(DEMO_PATH);
    
    if(bind(s, (struct sockaddr*)&addr, sizeof(addr)) < 0) exit(1);
    listen(s, 5);
    
    while(1) {
        int c = accept(s, 0, 0);
        if(c >= 0) {
            int pid = fork();
            if(pid == 0) {
                // Determine client type by first byte? No, just generic handler.
                // We read, random echo.
                char buf[64];
                int n;
                int total = 0;
                while((n = read(c, buf, sizeof(buf))) > 0) {
                    total += n;
                    // Echo back occasionally to show bidirectional
                    if(total % 10 == 0) write(c, "ACK", 3);
                    
                    // Artificial delay for flow control visualization
                    sleep(5); 
                }
                close(c);
                exit(0);
            }
            close(c);
        }
    }
}

// 2. Persistent Client (Stream): High traffic, slow server
static void demo_client_stream() {
    int c = socket(AF_UNIX, SOCK_STREAM, 0);
    struct sockaddr_un addr;
    addr.family = AF_UNIX;
    strcpy(addr.path, DEMO_PATH);
    
    // Retry connect
    while(connect(c, (struct sockaddr*)&addr, sizeof(addr)) < 0) sleep(10);
    
    while(1) {
        write(c, "STREAM", 6);
        sleep(2); // Fast
    }
}

// 3. Pulsing Client: Connects, bursts, disconnects
static void demo_client_pulse() {
    struct sockaddr_un addr;
    addr.family = AF_UNIX;
    strcpy(addr.path, DEMO_PATH);
    
    while(1) {
        int c = socket(AF_UNIX, SOCK_STREAM, 0);
        if(connect(c, (struct sockaddr*)&addr, sizeof(addr)) == 0) {
            // Burst
            for(int k=0; k<5; k++) {
                write(c, "BURST", 5);
                sleep(2);
            }
            close(c);
        }
        sleep(30); // Sleep 3s
    }
}

static void start_demo() {
    int pid;
    
    // Server
    if((pid = fork()) == 0) { demo_server(); exit(0); }
    add_worker(pid);
    sleep(10); // Wait for server bind
    
    // Client 1: Streamer (Persistent)
    if((pid = fork()) == 0) { demo_client_stream(); exit(0); }
    add_worker(pid);
    
    // Client 2: Pulser (Lifecycle)
    if((pid = fork()) == 0) { demo_client_pulse(); exit(0); }
    add_worker(pid);
}

int main(int argc, char *argv[]) {
    int demo = 0;
    int rounds = 30;

    if(argc > 1 && strcmp(argv[1], "demo") == 0) demo = 1;
    if(argc > 2) rounds = atoi(argv[2]);

    if(demo) {
        fprintf(2, "Initializing rich demo environment...\n");
        start_demo();
    }

    struct sock_stat *stats = malloc(sizeof(struct sock_stat) * MAX_SOCKS);
    if(!stats) exit(1);

    for(int r = 0; r <= rounds; r++) {
        int n = netstat(stats, MAX_SOCKS);
        
        cls();
        color_cyan();
        fprintf(2, "+================================================================+\n");
        fprintf(2, "|            xv6-k210 Socket Monitor (sockviz) v1.2              |\n");
        fprintf(2, "|                                                                |\n");
        
        fprintf(2, "|  Rounds: ");
        print_padded_int(r, 3);
        fprintf(2, " / ");
        print_padded_int(rounds, 3);
        fprintf(2, "              Active Sockets: ");
        print_padded_int(n, 3);
        fprintf(2, "          |\n");
        
        fprintf(2, "+================================================================+\n");
        color_reset();
        fprintf(2, "\n");

        if(demo) {
            color_yellow();
            fprintf(2, "  [DEMO] 1. Streamer (RECV_Q High)   2. Pulser (Connect/Close) \n\n");
            color_reset();
        }

        fprintf(2, "  TYPE   DOM    STATE      RECV_Q   LOCAL               REMOTE\n");
        fprintf(2, "  ----   ---    -----      ------   -----               ------\n");

        for(int i = 0; i < n; i++) {
            struct sock_stat *s = &stats[i];
            
            fprintf(2, "  ");
            
            if(s->type == SOCK_STREAM) fprintf(2, "STRM   "); else fprintf(2, "DGRM   ");
            if(s->domain == AF_INET)   fprintf(2, "INET   "); else fprintf(2, "UNIX   ");

            if(s->state == 1) { // LISTEN
                color_yellow(); print_padded_str("LISTEN     ", 11); color_reset();
            } else if(s->state == 3) { // ESTAB
                color_green(); print_padded_str("ESTAB      ", 11); color_reset();
            } else {
                if(s->state==0) print_padded_str("UNCONN     ", 11);
                else if(s->state==2) print_padded_str("CONNG      ", 11);
                else print_padded_str("DISCON     ", 11);
            }

            if(s->recv_usage > 0) {
                 color_red(); print_padded_int(s->recv_usage, 6); color_reset();
            } else {
                 print_padded_int(0, 6);
            }
            fprintf(2, "   ");

            // Local
             if(s->domain == AF_INET) {
                if(s->laddr == 0) print_padded_str("*:*", 20);
                else {
                    fprintf(2, "%d.%d.%d.%d:%d", 
                        s->laddr&0xff, (s->laddr>>8)&0xff, (s->laddr>>16)&0xff, (s->laddr>>24)&0xff, s->lport);
                    fprintf(2, "   ");
                }
            } else {
                if(s->lpath[0]) print_padded_str(s->lpath, 20);
                else print_padded_str("(unbound)", 20);
            }
            
            // Remote
            if(s->domain == AF_INET) {
                 if(s->raddr) {
                    fprintf(2, "-> %d.%d.%d.%d:%d", 
                        s->raddr&0xff, (s->raddr>>8)&0xff, (s->raddr>>16)&0xff, (s->raddr>>24)&0xff, s->rport);
                 }
            } else {
                 if(s->rpath[0]) fprintf(2, "-> %s", s->rpath);
            }
            fprintf(2, "\n");
        }
        
        fprintf(2, "\n");
        color_cyan();
        fprintf(2, "  Press Ctrl+C to exit.\n");
        color_reset();
        
        sleep(50);
    }
    
    // Kill demo workers
    kill_workers();
    while(wait(0) != -1);
    exit(0);
}
