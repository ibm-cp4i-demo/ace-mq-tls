#!/bin/sh

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh

source ${DEPLOYMENT_ROOT}/common/common.sh

oc process -f openldap-bitnami.yaml \
 -p PREFIX=${PREFIX} \
 -p BOOTSTRAP_LDIF=$(base64 -w 0 ${ACE_MQ_TLS_MA_BOOTSTRAP_LDIF_PATH}) | $(command $1 ldap)
