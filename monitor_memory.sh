#!/bin/sh

# In the beginning
date
echo "loadavg:" && cat /proc/loadavg
echo -e \\n
echo "meminfo:" && cat /proc/meminfo
echo -e \\n
echo "zoneinfo:" && cat /proc/zoneinfo
echo -e \\n
echo "buddyinfo:" && cat /proc/buddyinfo
echo -e \\n
echo "slabinfo:" && cat /proc/slabinfo
echo -e \\n
echo "ip_vs_ext_stat:" && cat /proc/self/net/ip_vs_ext_stats
echo -e \\n
echo "httproxy info:"
ps | grep httproxy
cat /tmp/lb.conf.log | grep error

echo -e \\n
echo "Processes info:"
echo 3 >/proc/sys/vm/drop_caches
memtotal=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
memfree=`cat /proc/meminfo | grep MemFree | awk '{print $2}'`
memused=`expr $memtotal - $memfree`
total=0
for pid in `ps | awk '{print $1}'`
do
	rss=`cat /proc/$pid/status | grep RSS | awk '{print $2}`
	if [ $rss ]; then
		echo `cat /proc/$pid/comm`\($pid\): $rss KB
		total=`expr $total + $rss`
	fi
done

echo userspace consumed: $total KB
echo kernel consumed: `expr $memused - $total` KB
echo total used: $memused KB

