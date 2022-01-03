#!/bin/bash

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

if ! [ -x "$(command -v kubectl)" ]; then
  echo 'Error: kubectl is not installed.' >&2
  exit 1
else
  echo "kubectl is installed"
fi
if ! [ -x "$(command -v helm)" ]; then
  echo 'Error: helm is not installed.' >&2
  exit 1
else
  echo "helm is installed"
fi
if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
else
  echo "docker is installed"
fi


CONJUR_CLI_VERSION=$(conjur -v | head -n 1)
CONJUR_CLI_VERSION="${CONJUR_CLI_VERSION##* }"
#echo "Conjur CLI version: $CONJUR_CLI_VERSION"

if [ $(version $CONJUR_CLI_VERSION) -ge $(version "7.0.0") ]; then
    echo "Conjur CLI is up to date"
else 
    echo "Please update Conjur CLI to version 7 or above"
    exit 1
fi
