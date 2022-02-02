#!/bin/sh

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh

source ${DEPLOYMENT_ROOT}/common/common.sh


oc process -f openldap-bitnami.yaml \
 -p BOOTSTRAP_LDIF=$(base64 -w 0 ${BOOTSTRAP_LDIF_PATH}) | $(command $1 ${LDAP_NAMESPACE})
