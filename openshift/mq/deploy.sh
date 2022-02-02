DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh
source ${DEPLOYMENT_ROOT}/paths.sh

source ${DEPLOYMENT_ROOT}/common/common.sh

oc process -f queue_manager.yaml \
  -p PREFIX=${PREFIX} \
  -p MQ_VERSION=${MQ_VERSION} \
  -p QUEUE_MANAGER_NAME=${QUEUE_MANAGER_NAME} \
  -p CONFIG_MQSC=$(base64 -w 0 ${CONFIG_MQSC_PATH}) \
  -p MQ_SERVER_CERT=$(base64 -w 0 ${MQ_SERVER_CERT_PATH}) \
  -p MQ_SERVER_KEY=$(base64 -w 0 ${MQ_SERVER_KEY_PATH}) \
  -p CA_CERT=$(base64 -w 0 ${CA_CERT_PATH}) | $(command $1 ${MQ_NAMESPACE})
