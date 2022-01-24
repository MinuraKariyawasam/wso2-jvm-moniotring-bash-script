#!/bin/bash

JAVA_PATH='/usr/lib/jvm/java/bin/'
INSTANCE_ID=`cat /var/lib/cloud/data/instance-id`
NAMESPACE="WSO2-JVM-METRICS" # make sure you dont chnage the namespace

HEAP_USAGE=`cat /tmp/heap_value/heapusage | grep 'current heap:' | cut -d ' ' -f3`
THREAD_COUNT=`/bin/ps -o thcount $(cat /home/ec2-user/wso2is-5.9.0/wso2carbon.pid | head -n 1) | sed -n 2p`

aws cloudwatch put-metric-data --metric-name "JVMHeapUsage" --namespace "$NAMESPACE" --value "$HEAP_USAGE" --unit "Megabytes" --region us-east-2 --dimensions InstanceID=$INSTANCE_ID
aws cloudwatch put-metric-data --metric-name "JVMThreadCount" --namespace "$NAMESPACE" --value "$THREAD_COUNT" --unit "Count" --region us-east-2 --dimensions InstanceID=$INSTANCE_ID
