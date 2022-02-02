#!/bin/sh

set -e

DEPLOYMENT_ROOT=$(pwd)/../../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh

${CONTAINER_CLI} run \
  --entrypoint="" \
  --rm \
  -it \
  --network ace-mq-tls \
  -v ${ACE_MQ_TLS_MA_MQ_CLIENT_KDB_PATH}:/keystore/mq-client.kdb \
  -v ${ACE_MQ_TLS_MA_MQ_CLIENT_STH_PATH}:/keystore/mq-client.sth \
  -v ${ACE_MQ_TLS_MA_CCDT_JSON_PATH}:/ccdt/ccdt.json \
  -e MQCCDTURL=/ccdt/ccdt.json \
  -e MQSAMP_USER_ID=aceapp \
  -e MQSSLKEYR=/keystore/mq-client \
  -w /opt/mqm/samp/bin \
  ibmcom/mq:9.2.4.0-r1-amd64 \
  /bin/bash