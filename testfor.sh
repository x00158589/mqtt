#!/bin/bash
# Basic for loop
json_string=$(cat init.json)
no_rooms=$(echo $json_string | jq '.rooms[].room' | wc -l)
rooms=$(echo $json_string | jq '.rooms[].room')

#echo "${rooms[@]}"

#for i in "${!rooms[@]}"; do 
#  printf "%s\t%s\n" "$i" "${rooms[$i]}"
#done

i=0
for room in $rooms
do
echo $room $(echo $json_string | jq -r ".rooms[$i].room") $i 
((i++))
done
echo All done
