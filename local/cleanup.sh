#!/bin/sh

set -e

DEPLOYMENT_ROOT=$(pwd)/..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/common/common.sh

remove_container ace
remove_container mq-ibm-mq.mq
remove_container ldap.ldap
remove_network ace-mq-tls