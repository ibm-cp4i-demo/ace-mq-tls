#!/bin/sh

set -e

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh
source ${DEPLOYMENT_ROOT}/common/common.sh

create_network ace-mq-tls
remove_container mq-ibm-mq.mq

${CONTAINER_CLI} run \
  -d \
  --network ace-mq-tls \
  -v ${ACE_MQ_TLS_MA_MQ_SERVER_KEY_PATH}:/etc/mqm/pki/keys/${PREFIX}/${PREFIX}-mq-server.key \
  -v ${ACE_MQ_TLS_MA_MQ_SERVER_CERT_PATH}:/etc/mqm/pki/keys/${PREFIX}/${PREFIX}-mq-server.crt \
  -v ${ACE_MQ_TLS_MA_CA_CERT_PATH}:/etc/mqm/pki/trust/0/${PREFIX}-ca.crt \
  -v ${ACE_MQ_TLS_MA_CONFIG_MQSC_PATH}:/etc/mqm/confiq.mqsc \
  -e LICENSE=accept \
  -e MQ_QMGR_NAME=QM \
  -p 1414:1414 \
  -p 9443:9443 \
  --name mq-ibm-mq.mq \
  ibmcom/mq:9.2.4.0-r1-amd64
