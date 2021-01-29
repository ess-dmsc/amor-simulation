FROM centos:7

RUN yum -y install centos-release-scl \
	&& yum -y install rh-python38 \
	&& yum -y clean all \
	&& echo "source /opt/rh/rh-python38/enable" >> /root/.bashrc

COPY just-bin-it.tar.gz .

RUN tar xzvf just-bin-it.tar.gz \
	&& mv just-bin-it-master just-bin-it \
	&& cd just-bin-it \
	&& rm ../just-bin-it.tar.gz \
	&& source /opt/rh/rh-python38/enable \
	&& pip --no-cache-dir install -r requirements.txt

WORKDIR /just-bin-it

CMD source /opt/rh/rh-python38/enable && python3 bin/just-bin-it.py --brokers ${BROKER_URI} --config-topic ${CONFIG_TOPIC_URI} -hb ${HEARTBEAT_TOPIC_URI} -rt ${RESPONSE_TOPIC_URI} -l ${LOG_LEVEL:=3}
