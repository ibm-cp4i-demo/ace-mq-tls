#!/bin/sh

set -e

DEPLOYMENT_ROOT=$(pwd)/..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/common/common.sh

remove_container ldap
remove_network ace-mq-tls