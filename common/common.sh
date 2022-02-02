check_file() {
  file=$1

  if [[ -z ${!file} ]]; then
    echo ensure $file is set
    exit 1
  fi

  if [[ ! -e ${!file} ]]; then
    echo ensure file ${!file} exists
    exit 1
  fi
}

check_var() {
  file=$1

  if [[ -z ${!file} ]]; then
    echo ensure variable, $file, is set
    exit 1
  fi
}

timestamp() {
  date +"%s"
}

command() {
  commnd=$1
  namespace=$2

  if [[ $commnd == "apply" ]]; then
    echo "oc -n ${namespace} apply -f -"
  elif [[ $commnd == "delete" ]]; then
    echo "oc -n ${namespace} delete -f -"
  else
    echo 'cat'
  fi
}

remove_container() {
  container=$1

  if ${CONTAINER_CLI} inspect -f='{{.ID}}' $container > /dev/null 2>&1; then
    echo removing conainer $container
    ${CONTAINER_CLI} rm -f $container > /dev/null
  fi

}

create_network() {
  network_name=$1

  if ! ${CONTAINER_CLI} network inspect -f='{{.ID}}' $network_name > /dev/null 2>&1; then
    echo creating network ${network_name}
    ${CONTAINER_CLI} network create $network_name
  fi
}

remove_network() {
  network_name=$1

  if ${CONTAINER_CLI} network inspect -f='{{.ID}}' $network_name > /dev/null 2>&1; then
    echo removing network ${network_name}
    ${CONTAINER_CLI} network rm $network_name > /dev/null
  fi
}