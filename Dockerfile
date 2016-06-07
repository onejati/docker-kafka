FROM java:8-jre-alpine

ARG KAFKA_VER=0.10.0.0

RUN apk add --update bash zip curl java-gcj-compat&& \
    curl http://www.us.apache.org/dist/kafka/$KAFKA_VER/kafka_2.10-$KAFKA_VER.tgz| tar -xzf - && \
    mv kafka_2.10-$KAFKA_VER /kafka && \
    rm /var/cache/apk/*
RUN mkdir /tmp/kafka-logs
VOLUME ["/data"]
ENV KAFKA_HOME /kafka
ENV PATH /kafka:$PATH
WORKDIR /kafka
RUN rm config/server.properties
ADD server.properties config/server.properties
ADD run.sh /kafka/run.sh
RUN chmod a+x /kafka/run.sh
EXPOSE 9092
CMD ["run.sh"]
