# Deploy OpenShift On-premise using Jetlag Performance Lab

This document provides instructions for setting up and using the Jetlag Performance Lab.

---

## Configure Once

Follow the steps below to configure the lab:

1. Update environment_variables.sh, important: specify CLOUD_NUM, the number of performance lab
2. Clone jetlag
   ```bash
    cd /on_premise **
   ```
3. **Copy the sample configuration file:**
   ```bash
   cp jetlag/ansible/vars/all.sample.yml jetlag/ansible/vars/all.yml
   ```

4. **Edit the configuration file:**
   Open `jetlag/ansible/vars/all.yml` and configure the following parameters:

   - **Lab Cloud:** Specify the cloud environment.
     ```yaml
     lab_cloud: cloud06
     ```

   - **Cluster Type:** Define the cluster type (`bm`, `mno`, or `sno`).
     ```yaml
     cluster_type: mno
     ```

   - **Worker Node Count:** Set the number of worker nodes (applies to both `bm` and `rwn` clusters).
     ```yaml
     worker_node_count: 3
     ```

   - **OCP Build:** Choose the build type (`dev` or `ga`).
     ```yaml
     ocp_build: "ga"
     ```

   - **OCP Version:** Select the OpenShift version (`candidate-4.16` or `latest-4.15`).
     ```yaml
     ocp_version: "latest-4.15"
     ```

   - **Networking Configuration:** Configure the network interfaces. Refer to the [Private Networking Documentation](https://wiki.rdu3.labs.perfscale.redhat.com/usage/#Private_Networking):
     ```yaml
     bastion_lab_interface: [Public]
     bastion_controlplane_interface: [EM1]
     controlplane_lab_interface: [Public]
     ```
5. **Enter key only once:**
    ```bash
    bashssh-keygen ; cp /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
    ```
---

## How to Run

### Usage

- **Create a BareMetal cluster:**
  ```bash
  make cluster
  ```

- **Install CNV/LSO/ODF operators:**
  Ensure the data disk is required for this step.
  ```bash
  make operator
  ```

- **Run workloads:**
  Ensure test environments are configured and `podman` is installed. Results will be saved in:
  ```
  /tmp/benchmark-runner-run-artifacts
  ```
  Command:
  ```bash
  make test
  
