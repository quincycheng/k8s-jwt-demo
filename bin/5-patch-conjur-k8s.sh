#!/bin/bash

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

# Trust Kubernetes CA cert, default: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
kubectl set env deployment/conjur-oss -n conjur-server SSL_CERT_FILE=${JWT_CA_PATH}

# Allow access to JWKS 
kubectl create clusterrolebinding oidc-reviewer \
  --clusterrole=system:service-account-issuer-discovery \
  --group=system:unauthenticated
