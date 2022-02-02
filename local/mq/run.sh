#!/bin/sh

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh

docker network create ace-mq || true

docker rm -f qmgr

docker run \
  -d \
  --network ace-mq \
  -v ${MQ_SERVER_KEY_PATH}:/etc/mqm/pki/keys/${PREFIX}/${PREFIX}-mq-server.key \
  -v ${MQ_SERVER_CERT_PATH}:/etc/mqm/pki/keys/${PREFIX}/${PREFIX}-mq-server.crt \
  -v ${CA_CERT_PATH}:/etc/mqm/pki/trust/0/${PREFIX}-ca.crt \
  -v ${DEPLOYMENT_ROOT}/mq/config.mqsc:/etc/mqm/confiq.mqsc \
  -e LICENSE=accept \
  -e MQ_QMGR_NAME=QM \
  -p 1414:1414 \
  -p 9443:9443 \
  --name qmgr \
  ibmcom/mq:9.2.4.0-r1-amd64 \
  

# ldapsearch -x -h localhost:389 -b "dc=ibm,dc=com" -D "cn=admin,dc=ibm,dc=com" -w admin