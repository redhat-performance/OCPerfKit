#!/bin/bash

# Define variables
RESULTS_PATH="/tmp/benchmark-runner-run-artifacts"
IMAGE_NAME="quay.io/ebattat/benchmark-runner:latest"

# Check if the results directory exists, if not, create it
if [ ! -d "$RESULTS_PATH" ]; then
    echo "Creating directory $RESULTS_PATH"
    mkdir -p "$RESULTS_PATH"
fi

# Check if the image exists and delete it if found
if sudo podman images -q "$IMAGE_NAME" > /dev/null 2>&1; then
    echo "Deleting existing image $IMAGE_NAME"
    sudo podman rmi -f "$IMAGE_NAME"
else
    echo "Image $IMAGE_NAME not found. Skipping deletion."
fi

echo "Results path: $RESULTS_PATH"
echo "Example: $RESULTS_PATH/hammerdb-vm-mssql-2024-11-28-08-22-39/hammerdb-vm-workload-f3121161"

# Run the container
sudo podman run --rm -it \
    -e WORKLOAD="$WORKLOAD" \
    -e KUBEADMIN_PASSWORD="$KUBEADMIN_PASSWORD" \
    -e KUBECONFIG_PATH="$KUBECONFIG_PATH" \
    -e PIN_NODE_BENCHMARK_OPERATOR="$PIN_NODE_BENCHMARK_OPERATOR" \
    -e PIN_NODE1="$PIN_NODE1" \
    -e PIN_NODE2="$PIN_NODE2" \
    -e SAVE_ARTIFACTS_LOCAL=True \
    -e ENABLE_PROMETHEUS_SNAPSHOT=False \
    -e RUN_TYPE="$RUN_TYPE" \
    -e TIMEOUT=$TIMEOUT \
    -e log_level="INFO" \
    -v "$KUBECONFIG_PATH":"/root/.kube/config" \
    -v "$RESULTS_PATH":"$RESULTS_PATH" \
    --privileged "$IMAGE_NAME"
