#!/bin/bash

# Wait for the local-storage-operator pod to be available
while true; do
  if oc get pod -n openshift-local-storage | grep -q local-storage-operator; then
    echo "Resource found!"
    break
  else
    echo "Resource not found, checking again in 10 seconds..."
    sleep 10
  fi
done

while true; do
  csv_count=$(oc get csv -n openshift-storage --no-headers | wc -l)

  if [ "$csv_count" -ge 4 ]; then
    # Check if all CSVs are in the Succeeded phase
    all_succeeded=true
    while IFS= read -r line; do
      phase=$(echo $line | awk '{print $NF}')
      if [ "$phase" != "Succeeded" ]; then
        all_succeeded=false
        break
      fi
    done < <(oc get csv -n openshift-storage --no-headers)

    if [ "$all_succeeded" = true ]; then
      echo "Found $csv_count CSVs in openshift-storage namespace, all in Succeeded phase." 
      oc get csv -n openshift-storage
      break
    else
      echo "Found $csv_count CSVs but not all are in Succeeded phase, checking again in 10 seconds..."
      sleep 10
    fi
  else
    echo "Currently $csv_count CSVs found, checking again in 10 seconds..."
    sleep 10
  fi
done

