FROM centos:7

RUN yum -y install centos-release-scl \
	&& yum -y install rh-python38 \
	&& yum -y clean all \
	&& echo "source /opt/rh/rh-python38/enable" >> /root/.bashrc

COPY neutron-event-generator.tgz .

RUN tar xzvf neutron-event-generator.tgz \
	&& source /opt/rh/rh-python38/enable \
	&& pip --no-cache-dir install -r requirements.txt \
	&& rm neutron-event-generator.tgz requirements.txt

CMD source /opt/rh/rh-python38/enable && python3 nevent-generator.py --broker ${KAFKA_BROKER} --topic ${EVENT_STREAM_TOPIC} --filename ${SOURCE_NEXUS_FILENAME} --event_stream_path ${EVENT_STREAM_PATH} --delay ${DELAY_S:-1}