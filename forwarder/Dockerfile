FROM centos:7

COPY forwarder.tar.gz .

RUN yum -y install centos-release-scl \
	&& yum -y install rh-python38 \
	&& yum -y clean all \
	&& echo "source /opt/rh/rh-python38/enable" >> /root/.bashrc

RUN tar xzvf forwarder.tar.gz \
	&& cd forwarder-master \
	&& source /opt/rh/rh-python38/enable \
	&& pip --no-cache-dir install -r requirements.txt

WORKDIR /forwarder-master

ENV SERVICE_ID=${SERVICE_ID:-$(uuidgen)}

CMD source /opt/rh/rh-python38/enable && python3 forwarder_launch.py --config-topic ${KAFKA_BROKER}:${KAFKA_PORT}/${COMMAND_TOPIC} --status-topic ${KAFKA_BROKER}:${KAFKA_PORT}/${STATUS_TOPIC} --output-broker ${KAFKA_BROKER}:${KAFKA_PORT} --storage-topic ${KAFKA_BROKER}:${KAFKA_PORT}/${STORAGE_TOPIC}
