DEPLOYMENT_ROOT=$(pwd)/../../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh

source ${DEPLOYMENT_ROOT}/common/common.sh

oc process -f mq_client.yaml \
  -p PREFIX=${PREFIX} \
  -p CCDT_JSON=$(base64 -w 0 ${CCDT_JSON_PATH}) \
  -p MQ_CLIENT_KDB=$(base64 -w 0 ${MQ_CLIENT_KDB_PATH}) \
  -p MQ_CLIENT_STH=$(base64 -w 0 ${MQ_CLIENT_STH_PATH}) | $(command $1 ${MQ_NAMESPACE})
