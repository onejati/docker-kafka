#!/usr/bin/env bash
SERVICE_CONF=${KAFKA_HOME}/config/server.properties
KAFKA_HEAP_OPTS=${JVMFLAGS:-"-Xmx1G -Xms1G"}
MAX_KAFKA_BROKER_ID=${MAX_KAFKA_BROKER_ID:-"15"}
KAFKA_ADVERTISE_PORT=${KAFKA_ADVERTISE_PORT:-"9092"}
KAFKA_LOG_DIRS=${KAFKA_LOG_DIRS:-${SERVICE_HOME}"/logs"}
KAFKA_NUM_REPLICATION=${KAFKA_NUM_REPLICATION:-"2"}
KAFKA_LOG_RETENTION_HOURS=${KAFKA_LOG_RETENTION_HOURS:-"168"}
KAFKA_NUM_PARTITIONS=${KAFKA_NUM_PARTITIONS:-"2"}
KAFKA_ZK_HOST=${KAFKA_ZK_HOST:-"zk:2181"}
KAFKA_EXT_IP=${KAFKA_EXT_IP}

cat << EOF > ${SERVICE_CONF}
############################# Server Basics #############################
broker.id.generation.enable = true
reserved.broker.max.id=${MAX_KAFKA_BROKER_ID}
############################# Socket Server Settings ###########################
port=${KAFKA_ADVERTISE_PORT}
#host.name=localhost
advertised.host.name=${KAFKA_EXT_IP}
advertised.port=${KAFKA_ADVERTISE_PORT}
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
############################# Log Basics #############################
log.dirs=${KAFKA_LOG_DIRS}
num.partitions=${KAFKA_NUM_PARTITIONS}
default.replication.factor=${KAFKA_NUM_REPLICATION}
num.recovery.threads.per.data.dir=1
delete.topic.enable=true
############################# Log Flush Policy #############################
#log.flush.interval.messages=10000
#log.flush.interval.ms=1000
############################# Log Retention Policy #############################
log.retention.hours=${KAFKA_LOG_RETENTION_HOURS}
#log.retention.bytes=1073741824
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
log.cleaner.enable=true
############################# Connect Policy #############################
zookeeper.connect=${KAFKA_ZK_HOST}
zookeeper.connection.timeout.ms=6000
EOF
