#!/bin/bash 
#
#

rooms=()
pirs=()
alarms=()

col_no="\033[0m"
col_green="\033[1;32m"
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
#declare -g rooms
#declare -g msg_string

mosquitto_sub -v -t '#' | while read mqtt_msg
do 	IFS='/' read -r -a msg_string <<< "$mqtt_msg"
			#room=$(echo "${msg_string[2]}")
			house_name="${msg_string[1]}"
			room="${msg_string[2]}"		
			IFS=' ' read -a device_status <<< "${msg_string[3]}"
						
			status="${device_status[1]}"
			device="${device_status[0]}"
			if [[ ! ${rooms[*]} =~ "$room" ]]; then
				if [ $STATUS = $status ] ; then
					rooms=("${rooms[@]}" "$room")
					pirs=("${pirs[@]}" "OFF")
					alarms=("${alarms[@]}" "OFF")
				fi
		#	echo "There is no such a room!"			
			fi
			#if [[ ! ${rooms[*]} =~ "$room" ]]; then 
				#while ! [[ $answer =~ ^(''|y|yes|Y|Yes|n|N|no|No)$ ]] 
				#do
	  			#	printf "Add a new room \"$room\"?[Y/n]:"
	  			#		read answer
				#done 
				#if [[ $answer = [yY] || $answer == [yY][eE][sS] || $answer = '' ]]; then 			
					#########################################rooms=("${rooms[@]}" "$room")
				#	echo "All rooms:${rooms[@]}" "The last room: " $room
				#fi	
			#	echo "There is no such a room"
			#fi

			#for i in "${rooms[@]}"
			#do
	        #		echo $i
		#	done
		echo -n "+"; print_line "-" 50; echo "+"
		n=$((49-${#house_name}))
		echo -n "|" $house_name; print_line " " $n; echo "|"
		echo -n "+"; print_line "-" 50; echo "+"	
	i=0		
	for room_name in "${rooms[@]}"
	do		
		if [ "${pirs[$i]}" = "OFF" ]; then PIRSTAT="0;32m"; else PIRSTAT="0;31m"; fi
		if [ "${alarms[$i]}" = "OFF" ]; then alarmstat="0;32m"; else alarmstat="0;31m"; fi
		
		echo -e -n "|" $room_name 
		n=$((17-${#room_name})); print_line " " $n
		printf "| PIR: \e[${PIRSTAT}%-7s\e[0m | Alarm: \e[${alarmstat}%-7s\e[0m |\n" ${pirs[$i]} ${alarms[$i]}
		
		
		#echo -e $room_name $pir_status $alarm_status
		((i++))


#       		PIR=$(echo $json_string | jq -r ".rooms[$i].PIR")
#		alarm=$(echo $json_string | jq -r ".rooms[$i].Alarm")
#
#		if [[ "$PIR" = "OFF" ]]; then PIRSTAT="0;32m"; else PIRSTAT="0;31m"; fi
#		if [[ "$alarm" = "OFF" ]]; then alarmstat="0;32m"; else alarmstat="1;31m"; fi
#		if [[ "$alarm" = "ACTIVE" ]]; then alarmstat="1;31m"
#			printf "| PIR %d: \e[${PIRSTAT}%-7s\e[0m | Alarm %d: \e[${alarmstat}%-7s\e[0m |\r\a" $room $PIR $room $alarm
#			sleep 0.5
#			alarmstat="K"
#			printf "\a"
#		fi
#
#		printf "| PIR %d: \e[${PIRSTAT}%-7s\e[0m | Alarm %d: \e[${alarmstat}%-7s\e[0m |\n" $room $PIR $room $alarm
#
#		((i++))
	done
echo -n "+"; print_line "-" 50; echo "+"
((i+=4))
printf "\033[${i}A%s\r"
done


#rooms=()
#while read mqtt_msg
#do
# rooms=("${rooms[@]}" "$mqtt_msg")
# echo "${rooms[@]}"
#	for i in "${rooms[@]}"
#			do
#		        		echo $i $room
#			done
#done
