#!/bin/bash

while true; do
  if oc get pv | grep local-pv; then
    echo "PersistentVolumes found!"
    break
  else
    echo "No PersistentVolumes found, checking again in 10 seconds..."
    sleep 10
  fi
done
