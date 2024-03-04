#!/bin/bash
LogDIR=.
LogFile=debug.log
LogTimer=1

. Log4Bash.sh

. f1.sh
. f2.sh
. f3.sh

Func1

sleep 1

Log Error and Exit at line 12, should not execute to here