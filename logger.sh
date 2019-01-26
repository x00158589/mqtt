
#!/bin/bash 

mqtt_message="$0 started"
house="house1.log"
date_time="$(date +%F) $(date +%T)"
echo $date_time $mqtt_message > $house

mosquitto_sub -v -t '#' | while 
	read mqtt_message
	do 
	date_time="$(date +%F) $(date +%T)"
	echo $date_time $mqtt_message
	echo $date_time $mqtt_message >> $house
	done
