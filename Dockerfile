FROM java:8-jre-alpine

ENV KAFKA_VER=0.9.0.0

RUN apk add --update bash zip curl java-gcj-compat&& \
    curl http://www.us.apache.org/dist/kafka/$KAFKA_VER/kafka_2.10-$KAFKA_VER.tgz| tar -xzf - && \
    mv kafka_2.10-$KAFKA_VER /kafka && \
    rm /var/cache/apk/*
RUN mkdir /tmp/kafka-logs
VOLUME ["/data"]
ENV KAFKA_HOME /opt/kafka
ENV PATH /opt/kafka:$PATH
WORKDIR /opt/kafka
ADD kafka-config.sh /opt
ADD start.sh /opt
RUN chmod a+x /opt
EXPOSE 9092
ENTRYPOINT ["/opt/start.sh"]
