#!/usr/bin/env bash

# Wait for Kafka broker to be up
export LD_LIBRARY_PATH=/kafkacat:$LD_LIBRARY_PATH
/kafkacat/kafkacat -b ${KAFKA_BROKER:="localhost"} -L

OUT=$?
i="0"
while [ $OUT -ne 0 -a  $i -ne 5  ]; do
   echo "Waiting for Kafka to be ready"
   sleep 10
   /kafkacat/kafkacat -b ${KAFKA_BROKER:="localhost"} -L
   OUT=$?
   let i=$i+1
   echo $i
done
if [ $i -eq 5 ]
then
   echo "Kafka broker not accessible at file writer launch"
   exit 1
fi
