#!/bin/bash 
#
# system_control listens to PISs published messages and sends an "ACTIVATE" command automatically
# to alarms. DEACTIVATION of the alarm has to be done manually (after checking the intrusion)

pir='PIR'
alarm='Alarm'
activate='ACTIVATE'

mosquitto_sub -v -t '/+/+/'$pir | \
while read mqtt_string
do 
IFS='/' read -r -a topic_array <<< "$mqtt_string"
IFS=' ' read -r -a mqtt_msg <<< "${topic_array[3]}"
msg_cmd="${mqtt_msg[1]}"

		#count="${#topic_array[@]}"		
		house_name="${topic_array[1]}"
		
		#for index in "${!topic_array[@]}"
		#do
		#    echo "$index ${topic_array[index]}"
		#done 
		
		# echo $count "${topic_array[@]}" "${topic_array[3]}" $msg_cmd

		if [ "$msg_cmd" = "ON" ]
		then 
			alarm_topic="/"$house_name"/"${topic_array[2]}"/"$alarm
			mosquitto_pub -t "${alarm_topic}" -m "$activate"
		fi
	#done
done
