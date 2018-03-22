#!/bin/sh
time=0
while [ $time -lt 3 ] 
do
	/var/log/bin/monitor_memory.sh > /var/log/bin/adc_memory_`date +"%F_%H-%M"`.txt
	timeout -t 30 -s SIGINT tcpdump -i port1 -w /var/log/bin/port1-`date +"%F_%H-%M"`.pcap & 
	timeout -t 30 -s SIGINT tcpdump -i port2 -w /var/log/bin/port2-`date +"%F_%H-%M"`.pcap &
	sleep 60 
	time=`expr $time + 1`
done
