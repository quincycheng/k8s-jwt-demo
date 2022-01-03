#!/bin/bash

echo "Loading sample policy and settings for authn-jwt.   You may wish to adjust them accordingly"

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

conjur policy load -f ${SCRIPT_ROOT}/policy/authn-jwt.yml -b root

# kubectl get --raw /.well-known/openid-configuration | jq .issuer
conjur variable set -i conjur/authn-jwt/kubernetes/issuer -v "https://kubernetes.default.svc.cluster.local"
# kubectl get --raw /.well-known/openid-configuration | jq .jwks_uri
conjur variable set -i conjur/authn-jwt/kubernetes/jwks-uri -v "https://192.168.49.2:8443/openid/v1/jwks"  

conjur variable set -i conjur/authn-jwt/kubernetes/token-app-property -v "kubernetes.io/namespace"
conjur variable set -i conjur/authn-jwt/kubernetes/identity-path -v "/kubernetes-apps"

echo "Done"
