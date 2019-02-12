#!/bin/bash 
#
# system_control listens to PISs published messages and sends an "ACTIVATE" command automatically
# to alarms. DEACTIVATION of the alarm has to be done manually (after checking the intrusion)

pir='PIR'
alarm='Alarm'
activate='ACTIVATE'

mosquitto_sub -v -t '/+/+/'$alarm | \
while read mqtt_string
do 
IFS='/' read -r -a topic_array <<< "$mqtt_string"
IFS=' ' read -r -a mqtt_msg <<< "${topic_array[3]}"
msg_cmd="${mqtt_msg[1]}"

		house_name="${topic_array[1]}"

		if [ "$msg_cmd" = 'ACTIVATE' ]
		then 
			alarm_topic="/"$house_name"/"${topic_array[2]}"/"$alarm
			mosquitto_pub -h localhost -t "${alarm_topic}" -m "ON"
		fi
		if [ "$msg_cmd" = 'DEACTIVATE' ]
		then 
			alarm_topic="/"$house_name"/"${topic_array[2]}"/"$alarm
			mosquitto_pub -h localhost -t "${alarm_topic}" -m "OFF"
		fi
	#done
done