#!/bin/bash

[[ ${#} != "3" ]] && { 
    echo usage
    echo host jboss-server-name file
    exit 1 
}

HOST=${1}
SERVER_NAME=${2}
DEPLOY=${3}
JBOSS_HOME=/usr/local/jboss
DEPLOY_FILE=$(basename ${DEPLOY})
DEPLOY_TMP=/tmp/deploy-${DEPLOY_FILE}

scp ${DEPLOY} ${HOST}:${DEPLOY_TMP}
ssh ${HOST} mv ${DEPLOY_TMP} ${JBOSS_HOME}/server/${SERVER_NAME}/deploy/${DEPLOY_FILE}
