#!/bin/bash
LogDIR=.
LogFile=debug.log
LogTimer=1
IgnoreSIGINT=0

. Log4Bash.sh

. f4.sh
. f5.sh
. f6.sh

Log Hello Log4Bash, Press Ctrl+C
Func4
# Press Ctrl+C here

Log Error and Exit at line 14, should not execute to here