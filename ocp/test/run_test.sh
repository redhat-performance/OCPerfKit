
#!/bin/bash

# Check if the results directory exists, if not, create it
RESULTS_PATH="/tmp/benchmark-runner-run-artifacts"
if [ ! -d "$RESULTS_PATH" ]; then
    echo "Creating directory $RESULTS_PATH"
    mkdir -p "$RESULTS_PATH"
fi

echo "Results path: $RESULTS_PATH"
echo "Example: $RESULTS_PATH/hammerdb-vm-mssql-2024-11-28-08-22-39/hammerdb-vm-workload-f3121161"
sudo podman run --rm -it -e WORKLOAD="$WORKLOAD" -e KUBEADMIN_PASSWORD="$KUBEADMIN_PASSWORD" -e PIN_NODE_BENCHMARK_OPERATOR="$PIN_NODE_BENCHMARK_OPERATOR" -e PIN_NODE1="$PIN_NODE1" -e PIN_NODE2="$PIN_NODE2" -e SAVE_ARTIFACTS_LOCAL=True -e ENABLE_PROMETHEUS_SNAPSHOT=False -e RUN_TYPE="$RUN_TYPE" -e TIMEOUT=$TIMEOUT -e log_level="INFO" -v "$KUBECONFIG_PATH":"/root/.kube/config" -v "$RESULTS_PATH":"$RESULTS_PATH" --privileged quay.io/ebattat/benchmark-runner:latest

