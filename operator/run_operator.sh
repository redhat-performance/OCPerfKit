#!/bin/bash
# cnv before odf for: ocs-storagecluster-ceph-rbd-virtualization
cd ${PARENT_PATH}/operator/cnv/
./run_cnv.sh
cd ${PARENT_PATH}/operator/odf/
./run_odf.sh
