#!/bin/bash
while true; do
  if oc get pod -n openshift-local-storage | grep -q local-storage-operator; then
    echo "Resource found!"
    break
  else
    echo "Resource not found, checking again in 10 seconds..."
    sleep 10
  fi
done
