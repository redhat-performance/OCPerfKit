#!/bin/bash

./01_cnv.sh
./verification.sh
oc create -f 02_hyperconverged.yaml
./verification.sh
#./03_run_nginx.sh

