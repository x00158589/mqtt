#!/bin/bash 
#
#
rooms=()
pirs=()
alarms=()

col_no="\033[0m"
col_green="\033[0;32m"
col_red="\033[1;31m"

STATUS='INITIATE'

beep () {
echo -en "\aPIR1:\033[1;32m OK \033[0m"
sleep 0.5
echo -e "\e[s\033[1K\rPIR1:\e[u"
}

print_line() {
char=$1
n=$2
printf "%0.s${char}" $(seq 1 $n)
}
clear
mosquitto_sub -v -t '#' | while read mqtt_msg
do 	IFS='/' read -r -a msg_string <<< "$mqtt_msg"
			#room=$(echo "${msg_string[2]}")
	house_name="${msg_string[1]}"
	room="${msg_string[2]}"		
	IFS=' ' read -a device_status <<< "${msg_string[3]}"
					
	status="${device_status[1]}"
	device="${device_status[0]}"
	
	i=0
	if [[ ! ${rooms[*]} =~ "$room" ]]; then
		if [ $STATUS = "$status" ] ; then
			rooms=("${rooms[@]}" "$room")
			pirs=("${pirs[@]}" "OFF")
			alarms=("${alarms[@]}" "OFF")
		else
			echo "There is no such a room!"	
		fi
	else 
		for index in "${!rooms[@]}"; do
   			if [[ "${rooms[$index]}" = "${room}" ]]; then
       				j="${index}";
   			fi
		done

		if [ $device = "PIR" ]; then pirs[$j]=$status; fi
		if [ $device = "Alarm" ]; then alarms[$j]=$status; fi

	fi

	echo -n "+"; print_line "-" 53; echo "+"
	n=$((52-${#house_name}))
	echo -n "|" $house_name; print_line " " $n; echo "|"
	echo -n "+"; print_line "-" 53; echo "+"	
		
	for room_name in "${rooms[@]}"
	do		
		if [ "${pirs[$i]}" = "OFF" ]; then PIRSTAT=$col_green; else PIRSTAT=$col_red; fi
		if [ "${alarms[$i]}" = "OFF" ]; then alarmstat=$col_green; else alarmstat=$col_red; fi
		
		echo -e -n "|" $room_name 
		n=$((17-${#room_name})); print_line " " $n
		#printf "| PIR: \e[${PIRSTAT}%-7s\e[0m | Alarm: \e[${alarmstat}%-10s\e[0m |\n" ${pirs[$i]} ${alarms[$i]}
		printf "| PIR: ${PIRSTAT}%-7s\e[0m | Alarm: ${alarmstat}%-10s\e[0m |\n" ${pirs[$i]} ${alarms[$i]}
		((i++))
	done
echo -n "+"; print_line "-" 53; echo "+"
((i+=4))
printf "\033[${i}A%s\r"
done
