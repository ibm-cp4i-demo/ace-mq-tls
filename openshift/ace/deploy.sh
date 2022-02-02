#¡/bin/bash

set -e

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/common/common.sh
source ${DEPLOYMENT_ROOT}/env.sh

check_file ACE_MQ_TLS_MA_POLICY_PROJECT_PATH
check_file ACE_MQ_TLS_MA_ACE_SERVER_KDB_PATH
check_file ACE_MQ_TLS_MA_ACE_SERVER_STH_PATH
check_file ACE_MQ_TLS_MA_SERVERCONF_PATH
check_file ACE_MQ_TLS_MA_SETDBPARMS_PATH

TEMP_DIR=/tmp/$(timestamp)
mkdir -p ${TEMP_DIR}/DefaultPolicies

cp ${ACE_MQ_TLS_MA_POLICY_PROJECT_PATH} ${TEMP_DIR}/DefaultPolicies

pushd ${TEMP_DIR} 2>&1 > /dev/null
ACE_MQ_TLS_MA_POLICY_PROJECT=$(zip -r - DefaultPolicies | base64 -w 0)
popd 2>&1 > /dev/null

check_var PREFIX
check_var ACE_VERSION
check_var ACE_LICENSE
check_var ACE_USE

oc process -f integration_server.yaml \
  -p PREFIX=${PREFIX} \
  -p ACE_VERSION=${ACE_VERSION} \
  -p ACE_LICENSE=${ACE_LICENSE} \
  -p ACE_USE=${ACE_USE} \
  -p ACE_MQ_TLS_MA_ACE_SERVER_KDB=$(base64 -w 0 ${ACE_MQ_TLS_MA_ACE_SERVER_KDB_PATH}) \
  -p ACE_MQ_TLS_MA_ACE_SERVER_STH=$(base64 -w 0 ${ACE_MQ_TLS_MA_ACE_SERVER_STH_PATH}) \
  -p ACE_MQ_TLS_MA_SERVERCONF=$(base64 -w 0 ${ACE_MQ_TLS_MA_SERVERCONF_PATH}) \
  -p ACE_MQ_TLS_MA_SETDBPARMS=$(base64 -w 0 ${ACE_MQ_TLS_MA_SETDBPARMS_PATH}) \
  -p ACE_MQ_TLS_MA_POLICY_PROJECT=${ACE_MQ_TLS_MA_POLICY_PROJECT} | $(command $1 ace)
