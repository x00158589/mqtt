#!/bin/bash
# this is a simple skeleton script that will sub to a topic and process anything that arrives line by line.

# subscribe to topic and process new lines one at a time in a while loop
# note the v option gives us the topic AND the message
mosquitto_sub -v -h localhost -t simpletest | while read line
do
	# is this simple example all we do is echo the line to the screen
  	echo $line
done
