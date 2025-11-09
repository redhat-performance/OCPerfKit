#!/bin/bash
cd ${PARENT_PATH}/operator/lso/
# Run the scripts in sequence
./01_create_lso_stable.sh
./01_verification.sh
