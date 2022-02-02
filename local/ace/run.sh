#!/bin/sh

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh
source ${DEPLOYMENT_ROOT}/common/common.sh

create_network ace-mq-tls
remove_container ace

${CONTAINER_CLI} run \
  -d \
  --network ace-mq-tls \
  -v ${DEPLOYMENT_ROOT}/ace/initial-config:/home/aceuser/initial-config \
  -v ${ACE_MQ_TLS_MA_ACE_SERVER_KDB_PATH}:/home/aceuser/keystores/ace-server.kdb \
  -v ${ACE_MQ_TLS_MA_ACE_SERVER_STH_PATH}:/home/aceuser/keystores/ace-server.sth \
  -e LICENSE=accept \
  -e ACE_SERVER_NAME=ACESERVER \
  -e MQCERTLABL=aceclient \
  -p 7600:7600 \
  -p 7800:7800 \
  --name ace \
  icr.io/appc-dev/ace-server@sha256:9c0ab33cf01233b52e1273e559c1b1daa2f23282430ecd2c48001fc0469132f3 \
