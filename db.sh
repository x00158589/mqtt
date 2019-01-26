#!/bin/bash 
#

json_string=$(cat init.json)
no_rooms=$(echo $json_string | jq '.rooms[].room' | wc -l)
rooms=$(echo $json_string | jq '.rooms[].room')
house=$(echo $json_string | jq -r '.house')

i=0
for room in $rooms
do
echo $room $(echo $json_string | jq -r ".rooms[$i].room") $i 
((i++))
done

#JSON_STRING=$( jq -n \
#                  --arg PIR1 "$PIR1" \
#                  --arg on "$OBJECT_NAME" \
#                  --arg tl "$TARGET_LOCATION" \
#                  '{bucketname: $bn, objectname: $on, targetlocation: $tl}' )


beep () {
echo -en "\aPIR1:\033[1;32m OK \033[0m"
sleep 0.5
echo -e "\e[s\033[1K\rPIR1:\e[u"
}

col_no="\033[0m"
col_green="\033[1;32m"
col_red="\033[1;31m"

# mosquitto_pub -t topic -m "qqq"
# mosquitto_sub -t '#' | while read msg; do echo $msg; done

#printf '\033[K%s\r' "hello world"
#sleep 1
#printf '\033[K%s\r' "bye now"


while true; do  
	echo "+-----------------------------------+"
	echo "| $house                           |"
	echo "+----------------+------------------+"

json_string=$(cat init.json)

no_rooms=$(echo $json_string | jq '.rooms[].room' | wc -l)
rooms=$(echo $json_string | jq '.rooms[].room')

i=0

for room in $rooms
do
PIR=$(echo $json_string | jq -r ".rooms[$i].PIR")
alarm=$(echo $json_string | jq -r ".rooms[$i].Alarm")

if [[ "$PIR" = "OFF" ]]; then PIRSTAT="0;32m"; else PIRSTAT="0;31m"; fi
if [[ "$alarm" = "OFF" ]]; then alarmstat="0;32m"; else alarmstat="1;31m"; fi
if [[ "$alarm" = "ACTIVE" ]]; then alarmstat="1;31m"
	printf "| PIR %d: \e[${PIRSTAT}%-7s\e[0m | Alarm %d: \e[${alarmstat}%-7s\e[0m |\r\a" $room $PIR $room $alarm
	sleep 0.5
	alarmstat="K"
fi

	printf "| PIR %d: \e[${PIRSTAT}%-7s\e[0m | Alarm %d: \e[${alarmstat}%-7s\e[0m |\n" $room $PIR $room $alarm

((i++))

done
	echo "+----------------+------------------+"
	printf '\033[7A%s\r'
sleep 1
done

