#!/bin/bash

DEPLOYMENT_ROOT=$(pwd)/..

source ${DEPLOYMENT_ROOT}/env.sh

mkdir -p ${DEPLOYMENT_ROOT}/certs

docker build -t cert-generator docker

docker run \
  -v ${DEPLOYMENT_ROOT}/certs:/certs \
  -w /certs \
  -e PREFIX=${PREFIX} \
  -e COMMON_NAME=${COMMON_NAME} \
  -e SAN_DNS=${SAN_DNS} \
  -e ORGANISATION=${ORGANISATION} \
  -e COUNTRY=${COUNTRY} \
  -e LOCALITY=${LOCALITY} \
  -e STATE=${STATE} \
  cert-generator \
  make -f /src/Makefile

docker run \
  -v ${DEPLOYMENT_ROOT}/certs:/certs \
  -w /certs \
  cert-generator \
  openssl x509 \
  -in ${PREFIX}-mq-server.crt \
  -text \
  -noout
