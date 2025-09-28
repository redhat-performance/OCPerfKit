#!/bin/bash

export HOME_PATH="/root"
export PARENT_PATH=$(dirname $(pwd))
export ON_PREMISE_PATH=$(pwd)
export JETLAG_PATH=${ON_PREMISE_PATH}/jetlag

# Jetlag Prerequisite
dnf install -y git python3 podman
# clone jetlag
# Check if the 'jetlag' directory exists
if [[ ! -d "jetlag" ]]; then
    echo "Jetlag directory does not exist. Cloning repository..."
    git clone https://github.com/redhat-performance/jetlag
fi

# Must configure cloud number according to performanceLab number e.g. cloud41
export CLOUD_NUM="cloud41"

# Operator
export CNV_VERSION="4.17.0"
export ODF_VERSION="4.17"
export LSO_VERSION="4.17"
export LSO_VERSION_NAME="417"
# ODF:
# disk type: 'wwn', 'nvme'
export ODF_DISK_TYPE='nvme'
export ODF_DISK_MIN_SIZE="0.5Ti"
export ODF_DISK_MAX_SIZE="2.5Ti"
export ODF_DISK_PER_WORKER="3"  # Maximum number of devices per node to be used
# Total number of OSD
export OSD_COUNT="9"

# Test
# Set environment variables
export KUBEADMIN_PASSWORD=$(cat ${HOME_PATH}/.kube/kubeadmin-password)
# Every PIN different Worker node
export PIN_NODE_BENCHMARK_OPERATOR=$(oc get nodes -l node-role.kubernetes.io/worker -o jsonpath='{.items[0].metadata.name}')
export PIN_NODE1=$(oc get nodes -l node-role.kubernetes.io/worker -o jsonpath='{.items[1].metadata.name}')
export PIN_NODE2=$(oc get nodes -l node-role.kubernetes.io/worker -o jsonpath='{.items[2].metadata.name}')
export KUBECONFIG_PATH="${HOME_PATH}/.kube/config"
export CONTAINER_KUBECONFIG_PATH="/root/.kube/config"
export ENABLE_PROMETHEUS_SNAPSHOT='False'
# LSO disk id w/o '/dev/disk/by-id/' i.e. LSO_DISK_ID="nvme-eui.2dd4ce36818041708da77f"
export LSO_DISK_ID=""
export LSO_NODE=""
# 'func_ci'(functional short run), 'perf_ci'(performance long run)
export RUN_TYPE="func_ci"
export TIMEOUT=20000

# WORKLOAD='stressng_pod', 'stressng_vm', 'stressng_kata', 'uperf_pod', 'uperf_vm', 'uperf_kata', 'hammerdb_pod_mariadb', 'hammerdb_vm_mariadb', 'hammerdb_kata_mariadb', 'hammerdb_pod_mariadb_lso', 'hammerdb_vm_mariadb_lso', 'hammerdb_kata_mariadb_lso', 'hammerdb_pod_postgres', 'hammerdb_vm_postgres', 'hammerdb_kata_postgres', 'hammerdb_pod_postgres_lso', 'hammerdb_vm_postgres_lso', 'hammerdb_kata_postgres_lso', 'hammerdb_pod_mssql', 'hammerdb_vm_mssql', 'hammerdb_kata_mssql', 'hammerdb_pod_mssql_lso', 'hammerdb_vm_mssql_lso', 'hammerdb_kata_mssql_lso', 'vdbench_pod', 'vdbench_kata', 'vdbench_vm', 'clusterbuster', 'bootstorm_vm', 'windows_vm'
export WORKLOAD="hammerdb_vm_mssql"