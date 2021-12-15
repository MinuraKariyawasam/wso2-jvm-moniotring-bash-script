#!/bin/bash
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

JAVA_PATH='/opt/java/bin'
INSTANCE_ID=`cat /etc/InstanceData/ec2id.lock`
IDENTIFIER=`hostname`
NAMESPACE="MO-WSO2-CI"
#DAYS_TO_CERT_EXPIRE=`cat /tmp/certificate_expiry_check`

HEAP_USAGE=`cat /tmp/heap_value/heapusage | grep 'current heap:' | cut -d ' ' -f3`
THREAD_COUNT=`/bin/ps -o thcount $(cat /mnt/apim_gateway/wso2am-3.2.0/wso2carbon.pid | head -n 1) | sed -n 2p`
ROOT_USAGE=`/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /   | cut -d " " -f 7`
MEMORY_USAGE=`/usr/lib/nagios/plugins/check_memory.sh -w 5 -c 3 | cut -d " " -f 3`
LOAD_AVERAGE=`/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 20,15,10 | cut -d "," -f 2`
MNT_USAGE=`/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /mnt   | cut -d " " -f 7`
LOGIN_STAT=`/usr/lib/nagios/plugins/check_login_test.sh`

aws cloudwatch put-metric-data --metric-name "JVMHeapUsage" --namespace "$NAMESPACE" --value "$HEAP_USAGE" --unit "Megabytes" --region eu-west-2 --dimensions apim_gateway=$IDENTIFIER,InstanceID=$INSTANCE_ID
aws cloudwatch put-metric-data --metric-name "RootVolumeUsage" --namespace "$NAMESPACE" --value "$ROOT_USAGE" --unit "Gigabits" --region eu-west-2 --dimensions apim_gateway=$IDENTIFIER,InstanceID=$INSTANCE_ID
aws cloudwatch put-metric-data --metric-name "MntVolumeUsage" --namespace "$NAMESPACE" --value "$MNT_USAGE" --unit "Gigabits" --region eu-west-2 --dimensions apim_gateway=$IDENTIFIER,InstanceID=$INSTANCE_ID
aws cloudwatch put-metric-data --metric-name "MemoryUsage" --namespace "$NAMESPACE" --value "$MEMORY_USAGE" --unit "Gigabits" --region eu-west-2 --dimensions apim_gateway=$IDENTIFIER,InstanceID=$INSTANCE_ID
aws cloudwatch put-metric-data --metric-name "LoadAverage" --namespace "$NAMESPACE" --value "$LOAD_AVERAGE" --unit "Count" --region eu-west-2 --dimensions apim_gateway=$IDENTIFIER,InstanceID=$INSTANCE_ID
aws cloudwatch put-metric-data --metric-name "JVMThreadCount" --namespace "$NAMESPACE" --value "$THREAD_COUNT" --unit "Count" --region eu-west-2 --dimensions apim_gateway=$IDENTIFIER,InstanceID=$INSTANCE_ID