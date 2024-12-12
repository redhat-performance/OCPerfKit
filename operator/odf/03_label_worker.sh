#!/bin/bash

# Get the list of worker nodes
nodes=$(oc get nodes -l node-role.kubernetes.io/worker= -o jsonpath="{range .items[*]}{.metadata.name}{'\n'}{end}")

# Loop through each node and apply the label
for node in $nodes; do
  oc label node "$node" cluster.ocs.openshift.io/openshift-storage=''
done

