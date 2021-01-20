FROM centos:7

COPY kafka-to-nexus.tar.gz kafka-to-nexus.tar.gz

RUN tar -xzvf kafka-to-nexus.tar.gz \
	&& rm	kafka-to-nexus.tar.gz

CMD /kafka-to-nexus/bin/kafka-to-nexus --command-uri ${COMMAND_URI} --status-uri ${STATUS_URI} --hdf-output-prefix ${HDF_OUTPUT_PREFIX} -v ${LOG_LEVEL:=3}

