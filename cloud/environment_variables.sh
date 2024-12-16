#!/bin/bash
# Set the main path
export PARENT_PATH=$(dirname $(pwd))
MAIN_PATH=$(pwd)

export HOME_PATH="/home/azureuser"

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
export PIN_NODE_BENCHMARK_OPERATOR=""
export PIN_NODE1=""
export PIN_NODE2=""
export KUBECONFIG_PATH="${HOME_PATH}/.kube/config"
# 'func_ci'(functional short run), 'perf_ci'(performance long run)
export RUN_TYPE="func_ci"
export TIMEOUT=10000

# WORKLOAD='stressng_pod', 'stressng_vm', 'stressng_kata', 'uperf_pod', 'uperf_vm', 'uperf_kata', 'hammerdb_pod_mariadb', 'hammerdb_vm_mariadb', 'hammerdb_kata_mariadb', 'hammerdb_pod_mariadb_lso', 'hammerdb_vm_mariadb_lso', 'hammerdb_kata_mariadb_lso', 'hammerdb_pod_postgres', 'hammerdb_vm_postgres', 'hammerdb_kata_postgres', 'hammerdb_pod_postgres_lso', 'hammerdb_vm_postgres_lso', 'hammerdb_kata_postgres_lso', 'hammerdb_pod_mssql', 'hammerdb_vm_mssql', 'hammerdb_kata_mssql', 'hammerdb_pod_mssql_lso', 'hammerdb_vm_mssql_lso', 'hammerdb_kata_mssql_lso', 'vdbench_pod', 'vdbench_kata', 'vdbench_vm', 'clusterbuster', 'bootstorm_vm', 'windows_vm'
export WORKLOAD="hammerdb_vm_mssql"

