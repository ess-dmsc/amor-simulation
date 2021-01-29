FROM centos:7

RUN yum -y install centos-release-scl \
	&& yum -y install rh-python38 \
	&& yum -y clean all \
	&& echo "source /opt/rh/rh-python38/enable" >> /root/.bashrc

COPY forwarder.tar.gz .

RUN tar xzvf forwarder.tar.gz \
	&& cd forwarder-master \
	&& source /opt/rh/rh-python38/enable \
	&& pip --no-cache-dir install -r requirements.txt

WORKDIR /forwarder-master

ENV SERVICE_ID=${SERVICE_ID:-$(uuidgen)}

CMD source /opt/rh/rh-python38/enable && python3 forwarder_launch.py --config-topic ${CONFIG_TOPIC_URI} --status-topic ${STATUS_TOPIC_URI} --output-broker ${OUTPUT_BROKER_URI} --storage-topic ${STORAGE_TOPIC_URI} --service-id ${SERVICE_ID}
