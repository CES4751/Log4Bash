#!/bin/bash
LogStart=$(date +%s)
PS4=' [\d \t] [PID=$$] [UID=${UID}] [${FUNCNAME[0]}:${LINENO}] '

# Show LogPath when not specified ${LogDIR} or ${LogFile}
# 没指定 ${LogDIR} 或 ${LogFile} 时，显示Log保存的位置
ShowLogPath=0
[[ -z ${LogDIR} || -z ${LogFile} ]] && ShowLogPath=1

LogDIR=${LogDIR:-/tmp}
mkdir -p ${LogDIR}
LogFile=${LogFile:-$$.log}

LogTimer=${LogTimer:-0}

IgnoreSIGINT=${IgnoreSIGINT:-1}

exec 2>>${LogDIR}/${LogFile}

# Execute when EXIT
# 脚本退出时执行
function TrapEXIT {
    [[ ${ShowLogPath} -eq 1 ]] && echo "Log save to ${LogDIR}/${LogFile}"
    if [[ ${LogTimer} -ne 0 ]]; then
        LogEnd=$(date +%s)
        echo "Script runs $((LogEnd - LogStart)) seconds"
    fi
}
trap 'TrapEXIT' EXIT

# Execute when Error
# 脚本发生错误时执行
function TrapERR {
    __LastRet=$?
    echo ""
    # Check if error from SIGINT(Ctrl+C)
    # 检查错误是否是SIGINT(Ctrl+C)，即$?是130
    if [ "${__LastRet}" != "130" ]; then
        echo "[${BASH_SOURCE[1]}:$1] Execute FAIL: [${BASH_COMMAND}] exited with status ${__LastRet}"
    else
        echo "[${BASH_COMMAND}] was interrupted"
    fi

    echo "Call Trace:"
    __Stack=$((${#FUNCNAME[@]} - 1))
    for lvl in $(seq 1 ${__Stack}); do
        echo -e "\t ${FUNCNAME[${lvl}]} at ${BASH_SOURCE[${lvl}]}:${BASH_LINENO[$((lvl - 1))]}"
    done

    echo ""
}
trap 'TrapERR ${LINENO}' ERR

# Determine whether to handle SIGINT
# 决定是否要处理SIGINT
if [[ ${IgnoreSIGINT} -eq 1 ]]; then
    trap '' SIGINT
else
    trap 'echo -e "\n[ User Press Ctrl+C, EXIT ]"' SIGINT
fi

# Execute when Killed
# 脚本被kill时执行
function TrapTERM {
    echo "Process $$ is killed"
    exit 0
}
trap 'TrapTERM' SIGTERM

# Normal log info
# 正常日志消息，Info完全等价于Log
function Info {
    echo "[$(date +"%F %T")] [PID=$$] [UID=${UID}] $*" | tee -a ${LogDIR}/${LogFile}
}

function Log {
    echo "[$(date +"%F %T")] [PID=$$] [UID=${UID}] $*" | tee -a ${LogDIR}/${LogFile}
}

set -xeE
