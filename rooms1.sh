#!/bin/bash 
#
#
rooms=("bedroom" "sitting room")
mosquitto_sub -v -t '#' | while read mqtt_msg
do
echo $mqtt_msg | while IFS='/' read -a msg_string
		do 
			room=$(echo "${msg_string[2]}")
			if [[ ! ${rooms[*]} =~ "$room" ]]; then rooms=("${rooms[@]}" "$room"); echo "All rooms:${rooms[@]}" "The last room: " $room; fi
			for i in "${rooms[@]}"
			do
		        		echo $i $room
			done
			echo "All rooms: " ${rooms[@]}
		done
echo "All rooms: " ${rooms[@]}
done



