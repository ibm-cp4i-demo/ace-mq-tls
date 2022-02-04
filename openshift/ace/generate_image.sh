#/bin/bash

set -e

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh

openshift_registry=$(oc -n openshift-image-registry get routes default-route -o jsonpath='{.spec.host}')

${CONTAINER_CLI} login $openshift_registry --username oc --password $(oc whoami -t)

${CONTAINER_CLI} build -t $openshift_registry/ace/readwritemq \
    -f Dockerfile \
    ${DEPLOYMENT_ROOT}/ace/initial-config/bars

${CONTAINER_CLI} push $openshift_registry/ace/readwritemq
