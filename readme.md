# OpenShift Performance Benchmark Kit

## Overview
This repository provides a set of tools and workflows to deploy and benchmark OpenShift clusters. It is designed to facilitate performance testing and ensure the reliability of OpenShift deployments.

## Prerequisites
- Ensure you have the necessary permissions and access to deploy OpenShift clusters.
- You must have `git` installed and configured.
- Ensure required environment variables are set in `environment_variables.sh` in cloud/on-premise.

---

## Deployment

### Clone the repository:
```bash
git clone https://github.com/redhat-performance/OCPerfKit
```
### Pre-requisites for all environments
```bash
sudo dnf update -y
sudo dnf install -y git make wget podman
```
### Install OCP client as root - use latest version
```bash
OCP_CLIENT_VERSION=4.19.2
sudo bash -c "curl -L 'https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OCP_CLIENT_VERSION}/openshift-client-linux-${OCP_CLIENT_VERSION}.tar.gz' -o '/home/azureuser/openshift-client-linux-${OCP_CLIENT_VERSION}.tar.gz' \
  && tar -xzvf /home/azureuser/openshift-client-linux-${OCP_CLIENT_VERSION}.tar.gz -C /home/azureuser/ \
  && mv /home/azureuser/kubectl /usr/local/bin/kubectl \
  && mv /home/azureuser/oc /usr/local/bin/oc \
  && rm -rf /home/azureuser/openshift-client-linux-${OCP_CLIENT_VERSION}.tar.gz /home/azureuser/kubectl /home/azureuser/oc"
```  
### Install Virtctl - use latest version
```bash
VIRTCTL_VERSION=1.5.2
sudo curl -L "https://github.com/kubevirt/kubevirt/releases/download/v${VIRTCTL_VERSION}/virtctl-v${VIRTCTL_VERSION}-linux-amd64" -o /usr/local/bin/virtctl \
  && sudo chmod +x /usr/local/bin/virtctl
```

### for on_premise 
```bash
cd on_premise
```

### for cloud
```bash
cd cloud
```
### Continue with cloud/on-premise readme.md
