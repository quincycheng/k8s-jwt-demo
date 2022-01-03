#!/bin/bash

# For minkube
eval $(minikube -p minikube docker-env)

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

kubectl create namespace "$CONJUR_NAMESPACE"

CONJUR_DATA_KEY="$(docker run --rm cyberark/conjur data-key generate)"

echo "Installing Conjur..."

helm install \
   -n "${CONJUR_NAMESPACE}" \
   --set dataKey="$CONJUR_DATA_KEY" \
   --set authenticators="authn-jwt/${CONJUR_AUTHN_JWT_SERVICE_ID}" \
   --set account.create=true \
   --set service.external.port=${CONJUR_PORT} \
   --set image.tag=1.15.0 \
   "${CONJUR_HELM_RELEASE}" \
   https://github.com/cyberark/conjur-oss-helm-chart/releases/download/v${CONJUR_HELM_VERSION}/conjur-oss-${CONJUR_HELM_VERSION}.tgz


echo "If you are using minikube & haven't start 'minikube tunnel', you can execute it in a separated terminal and keep it open"
echo ""
echo "Wait for a moment and open a web browser to https://${CONJUR_FQDN}:${CONJUR_PORT}, make sure it shows 'Your Conjur server is running' before proceed"


