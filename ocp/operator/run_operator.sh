#!/bin/bash
# cnv before odf for: ocs-storagecluster-ceph-rbd-virtualization
cd /home/azureuser/ocp/operator/cnv/
./run_cnv.sh
cd /home/azureuser/ocp/operator/odf/
./run_odf.sh
