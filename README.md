# Log4Bash
<!-- TOC -->

- [Log4Bash](#log4bash)
  - [使用方法 Usage](#使用方法-usage)
  - [参数](#参数)
  - [Params](#params)

<!-- /TOC -->
Bash script log module

## 使用方法 Usage

```bash
LogDIR=.
LogFile=debug.log
LogTimer=1

. Log4Bash.sh

Log some infomation

ls /no_exist
```

## 参数

- LogDIR：日志目录
- LogFile：日志文件名
- ShowLogPath

    是否在脚本执行结束时显示日志位置，默认为0

    当未设置LogDIR或LogFile时自动改为1，显示日志位置

- LogTimer：计时器，记录从include到脚本执行结束的秒数
- IgnoreSIGINT：是否忽略SIGINT，默认值1，接收Ctrl+C不再终止执行

## Params

- LogDIR：Log's DIR

- LogFile：Log's Filename

- ShowLogPath

    Whether show the log position at the end of the script execution, the default is 0

    When the LogDIR or LogFile is not set, it is automatically changed to 1, and the location of the log is displayed.

- LogTimer：record the second number of seconds from include to the end of the script execution

- IgnoreSIGINT：Whether to ignore SIGINT, default value 1, receiving Ctrl+C will no longer terminate execution
