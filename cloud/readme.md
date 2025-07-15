# Deploy OpenShift On-Premise using Cloud (Azure, AWS, etc.)

This guide provides instructions for deploying OpenShift on-premise using cloud platforms like Azure or AWS. The deployment process includes creating the cluster, installing required operators, running workloads, and managing the cluster lifecycle.

## Prerequisites
Download stable OCP version:
```bash
rm -rf openshift-install
wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-install-linux.tar.gz
tar xvzf openshift-install-linux.tar.gz
```
azure cloud login
```bash
# Import the Microsoft GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add the Azure CLI repository
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/azure-cli

# Install Azure CLI
sudo dnf install -y azure-cli
az login
az account list --output table --> get subscription id 
az account show --query tenantId -o tsv -> get tenantId
az ad sp create-for-rbac --name -> appId = principal client id
az ad sp create-for-rbac --name -> password = service principal client secret
```
Update install-config.yaml with your cloud environment details.
highlight parameters:
```bash
baseDomain: dns.example.com
baseDomainResourceGroupName: resource group name
userTags:
pullSecret:

cp install-config.yaml ocp4/
```
Update environment_variables.sh
- **Cloud Environment**: Ensure access to your chosen cloud platform (Azure, AWS, etc.)
- **OpenShift Installer**: Install the required version of the OpenShift installer
- **Podman**: Ensure Podman is installed on the system for running workloads
- **Data Disks**: 3 disks per worker node are required for CNV/LSO/ODF operators

## Usage

The deployment process is managed using `make` commands. Below are the available commands and their purposes:

### 1. Create Install Configuration
```bash
make install-config
```
This command generates the OpenShift install configuration.

### 2. Create the Cluster
```bash
make cluster
```
This command creates the OpenShift cluster. 

**Note:**
- When using an official OpenShift version, comment out the line:
  ```bash
  export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE
  ```

### 3. Destroy the Cluster
```bash
make destroy
```
This command destroys the OpenShift cluster.

### 4. Install Required Operators
```bash
make operator
```
Installs the CNV/LSO/ODF operators. Ensure that each worker node has **3 data disks** attached.

### 5. Run Workloads
```bash
make test
```
Runs workloads on the OpenShift cluster. Ensure the test environments are configured, and Podman is installed.

- **Results Path**: `/tmp/benchmark-runner-run-artifacts`

### 6. Display OpenShift Installer Version
```bash
make version
```
Displays the currently installed OpenShift installer version.

## Results and Logs

- **Workload Results**: Located at `/tmp/benchmark-runner-run-artifacts`
- For troubleshooting and logs, refer to the system's logging tools or the OpenShift console.

## Notes

- Ensure all required resources and permissions are provisioned in your cloud environment.
- Carefully configure test environments before running workloads to avoid errors.
- The `make operator` command requires data disks to be attached to worker nodes.

## Contributing

Contributions to improve this project are welcome. Please submit a pull request or open an issue for suggestions or bugs.

## License

This project is licensed under the [MIT License](LICENSE).
