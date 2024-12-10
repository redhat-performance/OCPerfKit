#!/bin/bash
# Set the main path
HOME_PATH=$(dirname "$(pwd)")
MAIN_PATH=$(pwd)
echo "HOME_PATH=${HOME_PATH}"
echo "MAIN_PATH=${MAIN_PATH}"

# Create the .kube directory if it does not exist
if [[ ! -d "${HOME_PATH}/.kube" ]]; then
  echo "Creating directory ${HOME_PATH}/.kube/"
  mkdir -p "${HOME_PATH}/.kube"
fi

cp ${HOME_PATH}/ocp4/auth/kubeconfig ${HOME_PATH}/.kube/config
cp ${HOME_PATH}/ocp4/auth/kubeadmin-password ${HOME_PATH}/.kube/kubeadmin-password
oc login -u kubeadmin -p $(cat ${HOME_PATH}/ocp4/auth/kubeadmin-password);
oc get nodes;
