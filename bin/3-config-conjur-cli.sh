#!/bin/bash

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

export POD_NAME=$(kubectl get pods --namespace ${CONJUR_NAMESPACE} \
                                         -l "app=${CONJUR_HELM_RELEASE},release=${CONJUR_HELM_RELEASE}" \
                                         -o jsonpath="{.items[0].metadata.name}")
CONJUR_ADMIN_PASSWORD=$(kubectl exec --namespace ${CONJUR_NAMESPACE} \
                   $POD_NAME \
                   --container=${CONJUR_HELM_RELEASE} \
                   -- conjurctl role retrieve-key default:user:admin | tail -1)

conjur init -u https://${CONJUR_FQDN}:${CONJUR_PORT} -a default --force
conjur login -i admin -p ${CONJUR_ADMIN_PASSWORD}
