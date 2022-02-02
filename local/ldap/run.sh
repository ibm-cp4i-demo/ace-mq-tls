#!/bin/sh

set -e

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh
source ${DEPLOYMENT_ROOT}/common/common.sh

create_network ace-mq-tls
remove_container ldap

${CONTAINER_CLI} run \
  -d \
  --network ace-mq-tls \
  -v ${ACE_MQ_TLS_MA_BOOTSTRAP_LDIF_PATH}:/ldifs/bootstrap.ldif \
  -e LDAP_ADMIN_USERNAME=admin \
  -e LDAP_ADMIN_PASSWORD=admin \
  -e LDAP_ROOT='dc=ibm,dc=com' \
  -p 1389:1389 \
  -p 1636:1636 \
  --name ldap \
  bitnami/openldap:2.4.59