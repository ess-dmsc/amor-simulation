FROM centos:7

COPY kafka-to-nexus.tar.gz kafka-to-nexus.tar.gz

RUN tar -xzvf kafka-to-nexus.tar.gz

CMD kafka-to-nexus/bin/kafka-to-nexus --command-uri ${KAFKA_BROKER:-localhost}:${KAFKA_PORT:-9092}/${COMMAND_TOPIC:-filewriter_config} --status-uri ${KAFKA_BROKER:-localhost}:${KAFKA_PORT:-9092}/${STATUS_TOPIC:-filewriter_status}

