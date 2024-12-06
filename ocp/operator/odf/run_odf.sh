#!/bin/bash

# Run the scripts in sequence
#./01_create_lso_stable.sh
./01_create_lso.sh
./01_verification.sh
./02_wipefs_worker_disk.sh
./02_wipefs_worker_disk.sh
./03_label_worker.sh
./04_auto_discovery.sh
./05_LocalVolumeSet.sh
./05_verification.sh
./06_install_odf.sh
./06_verification.sh
./07_storage_cluster.sh
./07_verification.sh
./08_odf_health_check.sh
./09_mssql_permission.sh
