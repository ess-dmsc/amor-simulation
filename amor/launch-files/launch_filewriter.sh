#!/usr/bin/env bash

# Wait for Kafka broker to be up
export LD_LIBRARY_PATH=/kafkacat:$LD_LIBRARY_PATH
kafkacat/kafkacat -b ${KAFKA_BROKER:="localhost"} -L
OUT=$?
i="0"
while [ $OUT -ne 0 -a  $i -ne 5  ]; do
   echo "Waiting for Kafka to be ready"
   sleep 10
   kafkacat/kafkacat -b ${KAFKA_BROKER:="localhost"} -L
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

export LD_LIBRARY_PATH=/kafka_to_nexus/lib/

COMMAND_URI="${COMMAND_URI:=//localhost:9092/TEST_writerCommand}"
STATUS_URI="${STATUS_URI:=//localhost:9092/TEST_writerStatus}"
HDF_OUTPUT_PREFIX="${HDF_OUTPUT_PREFIX:=/output-files/}"

if [ -z "$CONFIG_FILE" ]
then
   #  COMMAND=/kafka-to-nexus/bin/kafka-to-nexus --command-uri\ "${COMMAND_URI}"\ --status-uri\ "${STATUS_URI}"\ --hdf-output-prefix\ "${HDF_OUTPUT_PREFIX}"\ -v\ "${LOG_LEVEL:=3}"

    echo /kafka-to-nexus/bin/kafka-to-nexus --command-uri\ "${COMMAND_URI}"\ --status-uri\ "${STATUS_URI}"\ --hdf-output-prefix\ "${HDF_OUTPUT_PREFIX}"\ -v\ "${LOG_LEVEL:=3}"
    /kafka-to-nexus/bin/kafka-to-nexus --command-uri ${COMMAND_URI} --status-uri ${STATUS_URI} --hdf-output-prefix ${HDF_OUTPUT_PREFIX} -v ${LOG_LEVEL:=3}

fi
