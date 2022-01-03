#!/bin/bash

      export POD_NAME=$(kubectl get pods --namespace conjur-server \
                                         -l "app=conjur-oss,release=conjur-oss" \
                                         -o jsonpath="{.items[0].metadata.name}")
      kubectl exec --namespace conjur-server \
                   $POD_NAME \
                   --container=conjur-oss \
                   -- conjurctl role retrieve-key default:user:admin | tail -1
