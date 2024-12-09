#!/bin/bash

# Set a default value for OSD_COUNT if not already set
OSD_COUNT=${OSD_COUNT:-9}

# Wait until there are OSD_COUNT 'osd' pods (excluding those with 'prepare' in their name)
while true; do
  count=$(oc get pod -n openshift-storage | grep osd | grep -v prepare | wc -l)
  if [ "$count" -ge "$OSD_COUNT" ]; then
    echo "$OSD_COUNT or more 'osd' pods found!"
    break
  else
    echo "Currently $count 'osd' pods found, waiting for $OSD_COUNT. Checking again in 10 seconds..."
    sleep 10
  fi
done

