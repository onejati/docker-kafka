FROM java:8-jre-alpine

ENV KAFKA_VER=0.9.0.1

RUN apk add --update bash zip curl java-gcj-compat&& \
    curl http://www.us.apache.org/dist/kafka/$KAFKA_VER/kafka_2.10-$KAFKA_VER.tgz| tar -xzf - && \
    mv kafka_2.10-$KAFKA_VER /kafka && \
    rm /var/cache/apk/*
RUN mkdir /tmp/kafka-logs
VOLUME ["/data"]
ENV KAFKA_HOME /kafka
WORKDIR /kafka
Copy kafka-config.sh /kafka
Copy start.sh /kafka
RUN chmod a+x /kafka
EXPOSE 9092
ENTRYPOINT ["/kafka/start.sh"]
