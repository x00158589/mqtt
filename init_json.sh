#!/bin/bash

house="house1"
PIR1="OFF"
alarm1="OFF"
PIR2="OFF"
alarm2="OFF"
PIR3="OFF"
alarm3="OFF"


{"house1": [ { "room" : "room1", "PIR" : "OFF", "Alarm" : "OFF" }, { "room" : "room2", "PIR" : "OFF", "Alarm" : "OFF" }, { "room" : "room3", "PIR" : "OFF", "Alarm" : "OFF" } ] }







JSON_STRING=$( jq -n \
                  --arg PIR1 "$PIR1" \
                  --arg on "$OBJECT_NAME" \
                  --arg tl "$TARGET_LOCATION" \
                  '{bucketname: $bn, objectname: $on, targetlocation: $tl}' )

echo "PIR1: "$PIR1", Alarm 1: "$alarm1", PIR2: "$PIR2", Alarm 2: "$alarm2", PIR3: "$PIR3", Alarm 3: "$alarm3
