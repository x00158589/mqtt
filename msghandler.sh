#!/bin/bash 
#

col_no="\033[0m"
col_green="\033[1;32m"
col_red="\033[1;31m"

beep () {
echo -en "\aPIR1:\033[1;32m OK \033[0m"
sleep 0.5
echo -e "\e[s\033[1K\rPIR1:\e[u"
}

print_line() {
char=$1
n=$2
printf "%0.s${char}" $(seq 1 $n)
}

mosquitto_sub -v -t '#' | \
while read mqtt_msg
do
#echo $mqtt_msg
echo $mqtt_msg | awk -F/ '{print $2, $3, $4}' | \
		while read msg_string
		do 
			# echo $msg_array
			# i=0
			# for member in $msg_array
		    	# do
			#	echo $member
			#	((i++))
			#done
	
		msg_array=($msg_string)
		count="${#msg_array[@]}"		
		house=$msg_array
		
		echo -n "+"; print_line "-" 35; echo "+"
		n=$((34-${#house}))
		echo -n "|" $house; printf '%0.s ' $(seq 1 $n); echo "|"
		echo "+----------------+------------------+"	

			
			echo $count $msg_array
			# echo ${member[1]} # $msg_array
			for (( j=0; j<$count; j++ )) 
			do 
				echo $count $j ${msg_array[$j]}
			done			
 		done
done

#echo "/gas/string" | awk -F/ '{print $1,$2,$3}'
