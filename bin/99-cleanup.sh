#!/bin/bash

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

kubectl delete clusterrolebinding/oidc-reviewer
helm uninstall ${CONJUR_HELM_RELEASE} -n ${CONJUR_NAMESPACE}
kubectl delete namespace "${CONJUR_NAMESPACE}"

kubectl delete namespace demo