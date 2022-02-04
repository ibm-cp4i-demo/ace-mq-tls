#!/bin/bash

set -e

DEPLOYMENT_ROOT=$(pwd)/../../..

source ${DEPLOYMENT_ROOT}/env.sh

ldap_pod=$(oc -n ldap get pods -l app=ldap -o jsonpath='{$.items[*].metadata.name}')

oc -n ldap exec -ti ${ldap_pod} -- ldapsearch -h localhost:1389 -w admin -b "dc=ibm,dc=com" -D "cn=admin,dc=ibm,dc=com"
