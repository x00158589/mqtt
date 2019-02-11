#!/bin/bash 
#
#

date_time="$(date +%F) $(date +%T)"

mosquitto_sub -v -t '#' | while read mqtt_message
	do 	IFS='/' read -r -a topic_array <<< "$mqtt_message"
		# echo "$mqtt_message" | { IFS='/' read -r -a topic_array }
		house=$(echo "${topic_array[1]}.log")
		date_time="$(date +%F) $(date +%T)"
		echo $date_time $mqtt_message $topic_array		# display an event
		echo $date_time $mqtt_message >> "$house" # log an event to file
		# log_text=$(tail -n50 "$house.tmp")
		tail -50 "$house" > "$house.tmp"
		mv "$house.tmp" "$house"
		#echo $log_text > "$house"	# keep last 50 lines
	done
