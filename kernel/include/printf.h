#ifndef __PRINTF_H
#define __PRINTF_H

// ============ 日志系统宏定义 (移植自学长项目) ============

// 日志级别控制: 0=DEBUG, 1=INF, 2=WARN, 3=ERROR
// 设置为 0 表示输出所有日志, 设置为 3 表示只输出 ERROR
#define LOG_LEVEL 0

// 日志级别枚举
typedef enum{
    LOG_DEBUG = 0,
    LOG_INF,
    LOG_WARN,
    LOG_ERROR
} _LOG_LEVEL;

// 外部变量声明 (在 printf.c 中定义)
extern const char* _FILE_;
extern const char* _FUNCTION_;
extern int _LINE_;
extern int _LEVEL_;

// 日志宏定义
#define __LOG   _FILE_ = __FILE__; _LINE_ = __LINE__;
#define __DEBUG {__LOG _LEVEL_ = LOG_DEBUG;}LOG_INPUT
#define __INF   {__LOG _LEVEL_ = LOG_INF;}LOG_INPUT
#define __WARN  {__LOG _LEVEL_ = LOG_WARN;}LOG_INPUT
#define __ERROR {__LOG _LEVEL_ = LOG_ERROR;}LOG_INPUT

// ============ 原有函数声明 ============

void printfinit(void);

void printf(char *fmt, ...);

void panic(char *s) __attribute__((noreturn));

void backtrace();

void print_logo();

// 新增: LOG_INPUT 函数声明
void LOG_INPUT(const char *fmt, ...);

#endif 

