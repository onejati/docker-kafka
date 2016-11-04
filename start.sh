#!/bin/bash
sleep 3
kafka-config.sh
sleep 1
bin/kafka-server-start.sh config/server.properties
sleep 1
tail -F /logs/kafkaServer.out
