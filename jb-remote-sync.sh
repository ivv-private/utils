#!/bin/bash

WEBAPP=webapp
HOST=v20
WAR_NAME=coreps-portlet-web-1.0.0-SNAPSHOT.war
SERVER_NAME=22
JBOSS_HOME=/usr/local/jboss

while true
do
    REMOTE_PATH=$(ssh ${HOST} find ${JBOSS_HOME}/server/${SERVER_NAME} -name ${WAR_NAME})
    rsync -r ${WEBAPP}/ v20:${REMOTE_PATH}/
    sleep 3
done