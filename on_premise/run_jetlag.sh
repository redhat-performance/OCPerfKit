#!/bin/bash
# Vars
source environment_variables.sh

# cleanup
sudo rm -rf ${JETLAG_PATH}/jetlag.log
sudo rm -rf ${HOME_PATH}/.cache/*
sudo rm -rf /opt/assisted-service
sudo rm -rf /opt/http_store
sudo rm -rf /opt/ocp-version
podman ps | awk '{print $1}' | xargs -I % podman stop %; podman ps -a | awk '{print $1}' | xargs -I % podman rm %; podman pod ps | awk '{print $1}' | xargs -I % podman pod rm
sudo podman rmi -f -a
sudo podman volume prune --force
# when haproxy is enabled
systemctl start haproxy

# run jetlag
source ${JETLAG_PATH}/bootstrap.sh
ansible-playbook -i ${JETLAG_PATH}/ansible/create-inventory.yml 2>&1 | tee ${JETLAG_PATH}/jetlag.log
ansible-playbook -i ${JETLAG_PATH}/ansible/inventory/cloud06.local ansible/setup-bastion.yml 2>&1 | tee ${JETLAG_PATH}/jetlag.log
ansible-playbook -i ${JETLAG_PATH}/ansible/inventory/cloud06.local ansible/mno-deploy.yml 2>&1 | tee -a ${JETLAG_PATH}/jetlag.log
