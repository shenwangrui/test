#!/bin/sh
while [ 1 ] 
do
	./monitor_memory.sh > adc_memory_`date +"%F_%H-%M"`.txt
	sleep 1h
done
