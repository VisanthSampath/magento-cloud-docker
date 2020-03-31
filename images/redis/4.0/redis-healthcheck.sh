#!/bin/bash

#Check the redis ping check

status=$(redis-cli ping)

if [ "$status" == "PONG" ]
then
	echo "Container is healthy"
	exit 0
else
	echo "Container is not healthy"
	exit 1
fi
