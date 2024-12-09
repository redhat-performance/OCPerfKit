# OpenShift Cluster Setup and Benchmarking

## Prerequisites

Before starting, ensure the following:

1. **Configure `environment_variables.sh`:**
   - Set up necessary environment variables in the `environment_variables.sh` file. Make sure to include all required configuration details for the OpenShift installation and operators.

2. **Download OpenShift Installer:**
   - Download the OpenShift installer from the official OpenShift mirror:  
     [OpenShift Installer](https://mirror.openshift.com/pub/openshift-v4/)

3. **Copy `install-config.yaml`:**
   - Fill pull secret in install-config.yaml
   - Fill baseDomain in install-config.yaml
   - Copy the `install-config.yaml` file into the `ocp/ocp4` directory. This configuration file contains the necessary parameters for the cluster installation.

4. **For Azure Boost VM v6 Support:**
   - Verify that the OpenShift installer supports Azure Boost VM v6. The required patch can be found here:  
     [PR #922](https://github.com/openshift/installer/pull/922)

5. **For ODF: After deploy cluster create 3 disks per worker:**
    - Recommended: Premium SSD v2 (for performance test)
    - Disk size: 1000 GB
    - 20,000 IOPS and 750 MB/s (MSSQL recommendation)

---

## Usage

### Commands

- **`make install-config`**  
  Creates the installation configuration required for deploying the OpenShift cluster.

- **`make cluster`**  
  Deploys the OpenShift cluster based on the provided `install-config.yaml` configuration.

- **`make destroy`**  
  Destroys the deployed OpenShift cluster and cleans up the resources.

- **`make operator`**  
  Installs the CNV/LSO/ODF operators.  
  **Note:** A *data disk* is required for this operation.

- **`make test`**  
  Runs the specified workloads to test the cluster. Ensure the following:
  - The test environments are configured correctly.
  - `podman` is installed on the system.  
  The results will be saved in the directory `/tmp/benchmark-runner-run-artifacts`.

- **`make version`**  
  Displays the version of the OpenShift installer currently in use.

---