#!/bin/bash

eval $(minikube -p minikube docker-env)
SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

##########################################
# Original App with embedded secrets
#
echo "Building Original App with embedded secrets"

docker build -t original-app:latest  ${SCRIPT_ROOT}/apps/original-app

docker tag original-app:latest localhost:5000/original-app:latest
docker push localhost:5000/original-app:latest

# optional - uncomment to make sure the deployment is using the latest version of image
# kubectl delete deployment/original-app -n demo

kubectl apply -f ${SCRIPT_ROOT}/apps/original-app/deployment.yml

##########################################
# Summon App - fetch secrets when container starts/restarts 
#

echo "Building Summon App - fetch secrets when container starts/restarts"

export CONJUR_SSL_CERT=$(openssl s_client -showcerts  -connect ${CONJUR_FQDN}:${CONJUR_PORT} </dev/null 2>/dev/null | sed -n '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' )

kubectl -n demo delete configmap/conjur-ssl-cert
kubectl -n demo create configmap conjur-ssl-cert --from-literal=ssl-certificate="${CONJUR_SSL_CERT}"

docker build -t summon-app:latest  ${SCRIPT_ROOT}/apps/summon-app

docker tag summon-app:latest localhost:5000/summon-app:latest
docker push localhost:5000/summon-app:latest

# optional - uncomment to make sure the deployment is using the latest version of image
kubectl delete deployment/summon-app -n demo

kubectl apply -f ${SCRIPT_ROOT}/apps/summon-app/deployment.yml

rm -f ${SCRIPT_ROOT}/apps/summon-app/summon-conjur




##########################################
# API Apps with code changes
#
echo "Building API app with updated code"

docker build -t api-app:latest  ${SCRIPT_ROOT}/apps/api-app

docker tag api-app:latest localhost:5000/api-app:latest
docker push localhost:5000/api-app:latest

# optional - uncomment to make sure the deployment is using the latest version of image
kubectl delete deployment/api-app -n demo

kubectl apply -f ${SCRIPT_ROOT}/apps/api-app/deployment.yml
