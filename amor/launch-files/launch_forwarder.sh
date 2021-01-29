#!/usr/bin/env bash

cd /

# Wait for Kafka broker to be up
export LD_LIBRARY_PATH=/kafkacat:$LD_LIBRARY_PATH
kafkacat/kafkacat -b ${KAFKA_BROKER} -L
OUT=$?
i="0"
while [ $OUT -ne 0 -a  $i -ne 5  ]; do
   echo "Waiting for Kafka to be ready"
   sleep 10
   kafkacat/kafkacat -b ${KAFKA_BROKER} -L
   OUT=$?
   let i=$i+1
   echo $i
done
if [ $i -eq 5 ]
then
   echo "Kafka broker not accessible at file writer launch"
   exit 1
fi

sleep 10

cd /forwarder-master
source /opt/rh/rh-python38/enable && python3 forwarder_launch.py --config-topic ${CONFIG_TOPIC_URI} --status-topic ${STATUS_TOPIC_URI} --output-broker ${OUTPUT_BROKER_URI} --storage-topic ${STORAGE_TOPIC_URI} --service-id ${SERVICE_ID}
