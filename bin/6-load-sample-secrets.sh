#!/bin/bash

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

conjur variable set -i conjur/authn-jwt/kubernetes/identity-path -v "/kubernetes-apps"
conjur variable set -i conjur/authn-jwt/kubernetes/issuer -v "https://kubernetes.default.svc.cluster.local"

# Sample App ID policy
conjur policy load -f ${SCRIPT_ROOT}/policy/app-id-example.yml -b root

# Sample secret policy
conjur policy load -f ${SCRIPT_ROOT}/policy/sample-secrets.yml -b root

# Sample Secret
conjur variable set -i db/password -v "ThisIsTheSecrets!!"

