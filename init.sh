#!/bin/bash 
#
# initialization

house="x00158589_house"

rooms=('bedroom1' 'bedroom2' 'sitting_room' 'kitchen' )

if [ $1 = 0 ]
then 
# mosquitto_pub -t "/$house/" -m "INITIATE ${#rooms[@]} ROOMS"

for room in ${rooms[@]}
do
 mosquitto_pub -t "/"$house"/"$room"/PIR" -m "INITIATE"
# mosquitto_pub -t "/"$house"/"$room"/Alarm" -m "OFF"
done

else
# kitchen/PIR ON
mosquitto_pub -t "/"$house"/"$1 -m $2
fi





