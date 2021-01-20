#!/usr/bin/env bash

cd /

# Wait for Kafka broker to be up
export LD_LIBRARY_PATH=/kafkacat:$LD_LIBRARY_PATH
kafkacat/kafkacat -b ${BROKER_URI:="localhost"} -L
OUT=$?
i="0"
while [ $OUT -ne 0 -a  $i -ne 5  ]; do
   echo "Waiting for Kafka to be ready"
   sleep 10
   kafkacat/kafkacat -b ${BROKER_URI:="localhost"} -L
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

source /opt/rh/rh-python38/enable && python3 just-bin-it/bin/just-bin-it.py --brokers ${BROKER_URI} --config-topic ${CONFIG_TOPIC_URI} -hb ${HEARTBEAT_TOPIC_URI} -rt ${RESPONSE_TOPIC_URI} -l ${LOG_LEVEL:=3}
