#!/bin/sh
while [ 1 ] 
do
	./monitor_memory.sh > adc_memory_`date +"%M"`.txt
	sleep 1m
done
