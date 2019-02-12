#!/bin/bash 
#
# menu file
sc="system_control.sh"
ac="alarm_control.sh"
db="dashboard.sh"
lg="logger.sh"

check_script_running () {
    processes=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
    if [[ $processes -eq 0 ]] 
    then
        case "$2" in
        0) echo "Error: Script" $1 "has to be started on separate terminal window"
            echo "Exit..."; exit 9
            ;;
        1) if [[ -e "$1" ]]; then ./$1 &
            echo "script $1 started"
            else echo "Error: There is no $1 file in current directory. Exit..."; exit 9; fi
            ;;
        esac
    fi
}

check_script_running $sc 1
check_script_running $ac 1
check_script_running $db 0
check_script_running $lg 0

echo -n "Initialization..."
./init.sh 0
echo "Done."

#Exit: killig processes in background 
#    kill $(ps aux | grep 'control.sh' | awk '{print $2}')
