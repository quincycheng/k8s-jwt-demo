#!/bin/bash

SCRIPT_ROOT=$(dirname "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")
source ${SCRIPT_ROOT}/conf/conjur.conf

if [ "$#" -ne 1 ]; then
    echo "Usage: 7-test-query.sh <JWT TOKEN from Kubernetes>"
    exit 1
fi

CONJUR_URL=${CONJUR_FQDN}:${CONJUR_PORT}

CONJUR_ACCESS_TOKEN=$(curl -s -k --request POST \
    https://${CONJUR_URL}/authn-jwt/${CONJUR_AUTHN_JWT_SERVICE_ID}/${CONJUR_ACCOUNT}/authenticate \
    --header 'Content-Type: application/x-www-form-urlencoded' --header "Accept-Encoding: base64" \
    --data-urlencode "jwt=$1")

SECRET=$(curl -s -k --request GET -H "Authorization: Token token=\"${CONJUR_ACCESS_TOKEN}\"" https://${CONJUR_URL}/secrets/${CONJUR_ACCOUNT}/variable/db/password)


echo "access token: ${CONJUR_ACCESS_TOKEN}"
echo "The secret of db/password is: ${SECRET}"
