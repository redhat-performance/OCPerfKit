#!/bin/bash
# cnv before odf for: ocs-storagecluster-ceph-rbd-virtualization
cd ${MAIN_PATH}/operator/cnv/
./run_cnv.sh
cd ${MAIN_PATH}/operator/odf/
./run_odf.sh
