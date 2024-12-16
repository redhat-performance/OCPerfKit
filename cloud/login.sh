#!/bin/bash

# Vars
source environment_variables.sh

# Create the .kube directory if it does not exist
if [[ ! -d "${HOME_PATH}/.kube" ]]; then
  echo "Creating directory ${HOME_PATH}/.kube/"
  mkdir -p "${HOME_PATH}/.kube"
fi

cp ${MAIN_PATH}/ocp4/auth/kubeconfig ${HOME_PATH}/.kube/config
cp ${MAIN_PATH}/ocp4/auth/kubeadmin-password ${HOME_PATH}/.kube/kubeadmin-password
oc login -u kubeadmin -p $(cat ${MAIN_PATH}/ocp4/auth/kubeadmin-password);
oc get nodes;
