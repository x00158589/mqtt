#!/bin/bash

mosquitto_sub -v -t '#' | while 
	read mqtt_message; 
	do action=$(echo $mqtt_message | awk '{print $2}') 
	export PIR1=$action
	echo $PIR1
done

#mqtt_message="house1/room1/alarm1 ACTIVATE"

#echo $action
