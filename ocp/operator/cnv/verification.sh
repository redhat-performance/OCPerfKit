#/bin/bash
while true; do
  # Function to check if all CSVs in a namespace are in Succeeded phase
  check_phases() {
    local namespace=$1
    oc get csv -n "$namespace" --no-headers | awk '{print $NF}' | grep -qv 'Succeeded' && echo false || echo true
  }

  # Perform the first check
  all_succeeded_cnv=$(check_phases "openshift-cnv")

  if [ "$all_succeeded_cnv" = true ]; then
    echo "First check: All CSVs are in Succeeded phase in openshift-cnv."

    # Wait 30 seconds before the second check
    sleep 30

    # Perform the second check
    all_succeeded_cnv=$(check_phases "openshift-cnv")

    if [ "$all_succeeded_cnv" = true ]; then
      echo "Double-check: All CSVs are still in Succeeded phase in openshift-cnv."
      # Run oc get csv -n openshift-cnv at the end
      echo "Final CSVs in openshift-cnv:"
      oc get csv -n openshift-cnv
      break
    else
      echo "Double-check failed. Checking again in 10 seconds..."
    fi
  else
    echo "Initial check failed. Checking again in 10 seconds..."
  fi

  sleep 10
done

