#/bin/bash

set -e

build_and_push() {
  local image=$1
  local context=$2

  docker build -t $openshift_registry/${ACE_NAMESPACE}/${image} \
    -f Dockerfile \
    ${context}

  docker push $openshift_registry/${ACE_NAMESPACE}/${image}
}

DEPLOYMENT_ROOT=$(pwd)/../..

source ${DEPLOYMENT_ROOT}/env.sh

openshift_registry=$(oc -n openshift-image-registry get routes default-route -o jsonpath='{.spec.host}')
docker login $openshift_registry --username oc --password $(oc whoami -t)

build_and_push readwritemq ${DEPLOYMENT_ROOT}/ace/initial-config/bars
