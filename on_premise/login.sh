#!/bin/bash

# Vars
source environment_variables.sh

# Create the .kube directory if it does not exist
if [[ ! -d "${HOME_PATH}/.kube" ]]; then
  echo "Creating directory ${HOME_PATH}/.kube/"
  mkdir -p "${HOME_PATH}/.kube"
fi

yes | cp -rf ${HOME_PATH}/mno/kubeconfig ${HOME_PATH}/.kube/config;
yes | cp -rf ${HOME_PATH}/mno/kubeadmin-password ${HOME_PATH}/.kube/kubeadmin-password;
oc login -u kubeadmin -p $(cat ${HOME_PATH}/mno/kubeadmin-password);
oc get nodes
