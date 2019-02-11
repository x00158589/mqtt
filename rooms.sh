#!/bin/bash 
#
#

mosquitto_sub -v -t '#' | while read mqtt_msg
do
echo $mqtt_msg | awk -F/ '{print $2, $3, $4}' | \
		while read -a msg_string
		do 
			echo "Topic to array:"
			for room in "${msg_string[@]}"
			do
			echo $room
			done
			echo "echo msg_string[@]: " ${msg_string[@]}
		done
echo "Now different way:*******************************"
IFS='/' read -r -a topic_array <<< "$mqtt_msg"
			for room in "${topic_array[@]}"
			do
				echo $room
			done

done





