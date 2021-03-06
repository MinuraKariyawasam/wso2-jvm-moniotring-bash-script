#!/bin/bash

tmpdir="/tmp/heap_value"
tmpfile="/tmp/heap_value/heapusage"

currentHeapUsage=$(/usr/lib/jvm/java/bin/jstat -gc $(cat /home/ec2-user/wso2is-5.9.0/wso2carbon.pid | head -n 1) | tail -n 1 | /usr/bin/awk '{split($0,a," "); sum=(a[3]+a[4]+a[6]+a[8]+a[10]+a[12])/1024; print sum" MB"}' | /usr/bin/cut -d " " -f 1 | /usr/bin/cut -d "." -f 1)

XmxValue=$(/usr/lib/jvm/java/bin/jps -lvm | tr " " "\n" | grep "Xmx"  | head -1)
totalAllocatedHeap=${XmxValue:4:-1};

if [ -d "$tmpdir" ]
then
  echo -e "current heap: $currentHeapUsage\ntotalHeap: $totalAllocatedHeap"  > $tmpfile
else
  mkdir $tmpdir
  echo -e "current heap: $currentHeapUsage\ntotalHeap: $totalAllocatedHeap"  > $tmpfile
fi