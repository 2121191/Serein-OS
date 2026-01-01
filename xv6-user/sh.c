// Shell.

#include "kernel/include/types.h"
#include "xv6-user/user.h"
#include "kernel/include/fcntl.h"

// Parsed command representation
#define EXEC  1
#define REDIR 2
#define PIPE  3
#define LIST  4
#define BACK  5

#define NENVS 16
#define MAXARGS 10

struct env{
  char name[32];
  char value[96];
};

struct env envs[NENVS];
int nenv = 0;

struct cmd {
  int type;
};

struct execcmd {
  int type;
  char *argv[MAXARGS];
  char *eargv[MAXARGS];
};

struct redircmd {
  int type;
  struct cmd *cmd;
  char *file;
  char *efile;
  int mode;
  int fd;
};

struct pipecmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct listcmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct backcmd {
  int type;
  struct cmd *cmd;
};

int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd *parsecmd(char*);

struct cmd *parsecmd(char*);

char mycwd[128];

// Helper: Safe string copy
// u_strncpy moved to avoid conflict


int
checkenvname(char* s)
{
  if((*s >= 'A' && *s <= 'Z') ||
     (*s >= 'a' && *s <= 'z') ||
      *s == '_')
    ;
  else
    return 0;
  char *tmp = s + 1;
  while((*tmp >= 'A' && *tmp <= 'Z') ||
        (*tmp >= 'a' && *tmp <= 'z') ||
        (*tmp >= '0' && *tmp <= '9') ||
         *tmp == '_')
    tmp++;
  return (int)(tmp - s);
}

int
export(char *argv[])
{
  if(!strcmp(argv[1], "-p"))
  { // print all the env vars
    if(!nenv)
    {
      printf("NO env var exported\n");
      return 0;
    }
    for(int i=0; i<nenv; i++)
      printf("export %s=%s\n", envs[i].name, envs[i].value);
    return 0;
  }
  else if(nenv == NENVS)
  {
    fprintf(2, "too many env vars\n");
    return -1;
  }
  char name[32], value[96];
  char *s = argv[1], *t = name;

  for(s=argv[1], t=name; (*t=*s++)!='='; t++)
    ;
  *t = 0;

  if(checkenvname(name) != ((s - argv[1]) - 1))
  {
    fprintf(2, "Invalid NAME!\n");
    return -1;
  }
  for(t=value; (*t=*s); s++, t++)
    ;
  if(*--t == '/')
    *t = 0;
  
  strcpy(envs[nenv].name, name);
  strcpy(envs[nenv].value, value);
  nenv++;
  return 0;
}

int
replace(char *buf)
{
  char raw[100], name[32], *s, *t, *tmp;
  int n = 0;
  strcpy(raw, buf);
  for(s=raw, t=buf; (*t=*s); t++)
  {
    if(*s++ == '$'){
      tmp = name;
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
      {
        *tmp++ = *s++;
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
          *tmp++ = *s++;
        *tmp = 0;
        for(int i=0; i<nenv; i++)
          if(!strcmp(name, envs[i].name))
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
              ;
        t--;
      }
      n++;
    }
  }
  return n;
}

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
  int p[2];
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit(1);

  switch(cmd->type){
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
      exit(1);
    
    exec(ecmd->argv[0], ecmd->argv);

    int i;
    char env_cmd[64];
    for(i=0; i<nenv; i++)
    {
      char *s_tmp = env_cmd;
      char *d_tmp = envs[i].value;
      while((*s_tmp = *d_tmp++))
        s_tmp++;
      *s_tmp++ = '/';
      d_tmp = ecmd->argv[0];
      while((*s_tmp++ = *d_tmp++))
        ;

      exec(env_cmd, ecmd->argv);
    }
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      fprintf(2, "open %s failed\n", rcmd->file);
      exit(1);
    }
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
    wait(0);
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
    close(p[1]);
    wait(0);
    wait(0);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit(0);
}

// V3.1: Shell Command History
#define HISTORY_SIZE 16
#define KEY_UP    0xE2
#define KEY_DOWN  0xE3
#define INPUT_BUF_SIZE 128
#define BACKSPACE 0x08

struct {
  char commands[HISTORY_SIZE][INPUT_BUF_SIZE];
  int head;   // Where to write next
  int tail;   // Oldest command
  int count;  // How many valid commands
  int pos;    // Navigation position (-1 = not navigating)
} history;

void
history_init(void)
{
  history.head = 0;
  history.tail = 0;
  history.count = 0;
  history.pos = -1;
}

void
history_add(char *cmd)
{
  // Safety check: Don't add if empty
  if(cmd[0] == 0) return;
  
  // Don't duplicate the immediately previous command
  if(history.count > 0) {
    int prev = (history.head - 1 + HISTORY_SIZE) % HISTORY_SIZE;
    if(strcmp(history.commands[prev], cmd) == 0)
      return;
  }
  
  // Add to circular buffer
  strcpy(history.commands[history.head], cmd);
  history.head = (history.head + 1) % HISTORY_SIZE;
  
  if(history.count < HISTORY_SIZE) {
    history.count++;
  } else {
    history.tail = (history.tail + 1) % HISTORY_SIZE;
  }
  
  history.pos = -1; // Reset navigation
}

char*
history_prev(void)
{
  if(history.count == 0) return 0;
  
  if(history.pos == -1) {
    // Start from newest (-1 because head points to next EMPTY slot)
    history.pos = (history.head - 1 + HISTORY_SIZE) % HISTORY_SIZE;
  } else if(history.pos != history.tail) {
    // Move backward until tail
    history.pos = (history.pos - 1 + HISTORY_SIZE) % HISTORY_SIZE;
  }
  
  return history.commands[history.pos];
}

char*
history_next(void)
{
  if(history.pos == -1) return 0; // Not navigating
  
  int next = (history.pos + 1) % HISTORY_SIZE;
  if(next == history.head) {
    // Moved past latest command -> back to empty input line
    history.pos = -1;
    return ""; 
  }
  
  history.pos = next;
  return history.commands[history.pos];
}

// V3.1: Helper for strncpy
char*
u_strncpy(char *s, const char *t, int n)
{
  char *os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}

// V3.1: Tab Completion (Fixed)
#define MAX_MATCHES 16
#define MAX_NAME_LEN 32

void
completion(char *buf, int *idx)
{
  char *prefix = buf;
  int prefix_len = *idx;
  
  // DEBUG: Check what sh thinks buf is
  // fprintf(2, "\nDEBUG: completion idx=%d buf='%s'\n", *idx, buf);

  int fd;
  struct stat st;
  
  // Find the start of the last word
  int i;
  for(i = *idx - 1; i >= 0; i--) {
    if(buf[i] == ' ') {
      prefix = buf + i + 1;
      prefix_len = *idx - (i + 1);
      break;
    }
  }
  
  if(prefix_len == 0) return; // Nothing to complete

  // Scan current directory
  if((fd = open(".", 0)) < 0){
    return;
  }

  // Store matches
  char matches[MAX_MATCHES][MAX_NAME_LEN];
  int match_count = 0;

  while(readdir(fd, &st) == 1 && match_count < MAX_MATCHES){
    if(st.name[0] == 0) continue;
    
    // Check prefix match
    int is_match = 1;
    for(int j=0; j<prefix_len; j++) {
      if(st.name[j] != prefix[j]) {
        is_match = 0;
        break;
      }
    }
    
    if(is_match) {
      memset(matches[match_count], 0, MAX_NAME_LEN);
      u_strncpy(matches[match_count], st.name, MAX_NAME_LEN-1);
      match_count++;
    }
  }
  close(fd);
  
  if(match_count == 0) {
    return; // No matches
  }
  
  if(match_count == 1) {
    // Single match: auto-complete fully
    int name_len = strlen(matches[0]);
    int extra_len = name_len - prefix_len;
    
    if(extra_len > 0) {
      char *append = matches[0] + prefix_len;
      for(int k=0; k<extra_len; k++) {
        buf[*idx] = append[k];
        fprintf(2, "%c", append[k]);
        (*idx)++;
      }
    }
  } else {
    // Multiple matches: compute common prefix first
    int common_len = strlen(matches[0]);
    for(int m=1; m<match_count; m++) {
      int k = 0;
      while(k < common_len && matches[0][k] == matches[m][k]) {
        k++;
      }
      common_len = k;
    }
    
    // Complete common prefix beyond what user typed
    int extra_len = common_len - prefix_len;
    if(extra_len > 0) {
      char *append = matches[0] + prefix_len;
      for(int k=0; k<extra_len; k++) {
        buf[*idx] = append[k];
        fprintf(2, "%c", append[k]);
        (*idx)++;
      }
    }
    
    // List all matches
    fprintf(2, "\n");
    for(int m=0; m<match_count; m++) {
      fprintf(2, "%s  ", matches[m]);
    }
    fprintf(2, "\n-> %s $ %s", mycwd, buf);
  }
}

int
getcmd(char *buf, int nbuf)
{
  fprintf(2, "-> %s $ ", mycwd);
  memset(buf, 0, nbuf);
  
  int i = 0; // Current buffer index
  char c;
  
  while(1){
    if(read(0, &c, 1) != 1) { // EOF
      if(i > 0) return 0; // Return partial line if any
      return -1;
    }
    
    // Tab Completion
    if(c == '\t') {
      completion(buf, &i);
      continue;
    }

    // Ctrl+L: Clear Screen
    if(c == 0x0C) {
      // Clear screen and home cursor
      fprintf(2, "\x1b[2J\x1b[H"); 
      // Reprint prompt
      fprintf(2, "-> %s $ ", mycwd);
      // Reprint current buffer
      for(int j=0; j<i; j++) {
        fprintf(2, "%c", buf[j]);
      }
      continue;
    }

    // Backspace Handling (0x7f)
    if(c == '\x7f') {
      if(i > 0) {
        i--;
        buf[i] = 0;
        // Erase on screen
        fprintf(2, "\b \b");
      }
      continue;
    }

    // V3.1: History Navigation
    if(c == (char)KEY_UP || c == (char)KEY_DOWN) {
      char *hist_cmd = 0;
      
      if(c == (char)KEY_UP) {
        hist_cmd = history_prev();
      } else {
        hist_cmd = history_next();
      }
      
      if(hist_cmd) {
        // Erase current line from screen
        while(i > 0) {
          fprintf(2, "\b \b");
          i--;
        }
        
        // Copy historical command
        memset(buf, 0, nbuf);
        strcpy(buf, hist_cmd);
        i = strlen(buf);
        
        // Print new line
        fprintf(2, "%s", buf);
      }
      continue;
    }

    if(c == '\n' || c == '\r'){
      buf[i] = 0;
      fprintf(2, "\n");
      // Add to history if not empty
      if(i > 0) history_add(buf);
      return 0;
    }
    
    if(c == BACKSPACE || c == '\x7f'){
      if(i > 0){
        i--;
        fprintf(2, "\b \b"); // Erase character visually
        buf[i] = 0;
      }
      continue;
    }
    
    if(i < nbuf - 1){
      // V3.1: Only store printable chars, echo is handled by kernel console
      if((unsigned char)c >= 32 || c == '\t') {
        buf[i++] = c;
        // fprintf(2, "%c", c); // Double echo fix: Kernel echoes, shell should not
      }
    }
  }
}

int
main(void)
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = dev(O_RDWR, 1, 0)) >= 0){
    if(fd >= 3){
      close(fd);
      break;
    }
  }

  // Add an embedded env var(for basic commands in shell)
  strcpy(envs[nenv].name, "SHELL");
  strcpy(envs[nenv].value, "/bin");
  nenv++;

  strcpy(envs[nenv].value, "/bin");
  nenv++;
  
  // V3.1: Initialize history
  history_init();

  getcwd(mycwd);
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    replace(buf);
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        fprintf(2, "cannot cd %s\n", buf+3);
      getcwd(mycwd);
    }
    else{
      struct cmd *cmd = parsecmd(buf);
      struct execcmd *ecmd;

      ecmd = (struct execcmd*)cmd;
      if(ecmd->argv[0] == 0) {
        free(cmd);
        continue;
      }
      else if(!strcmp(ecmd->argv[0], "export"))
      {
        // Export must be called by the parent, not the child.
        if(ecmd->argv[1] == NULL)
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
        else if(export(ecmd->argv) < 0)
          fprintf(2, "export failed\n");
        free(cmd);
        continue;
      }
      else if(fork1() == 0) {
        // V2.2C: 子进程自成进程组，并设为 TTY 前台
        setpgid(0, 0);           // pgid = pid
        tcsetpgrp(getpid());     // 设为前台进程组
        runcmd(cmd);
      }
      wait(0);
      // V2.2C: 命令结束后，Shell 恢复为前台进程组
      tcsetpgrp(getpid());
      free(cmd);
    }
  }
  exit(0);
}

void
panic(char *s)
{
  fprintf(2, "%s\n", s);
  exit(1);
}

int
fork1(void)
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
  return pid;
}

//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
  cmd->cmd = subcmd;
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
//PAGEBREAK!
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
}

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    fprintf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_APPEND, 1);
      break;
    }
  }
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    nulterminate(pcmd->left);
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}