# Makefile for OCPPerfKit cloud

# Set MAIN_PATH to the current directory
export MAIN_PATH = $(shell pwd)
# Get PARENT folder up
export PARENT_PATH = $(shell dirname $(MAIN_PATH))

# Directory containing the OpenShift configuration
export INSTALLER_PATH = $(MAIN_PATH)/openshift-install
export INSTALL_DIR = $(MAIN_PATH)/ocp4

# Targets
.PHONY: install-config cluster destroy help operator operator_odf operator_cnv version test

install-config:
	$(INSTALLER_PATH) create install-config --dir="$(INSTALL_DIR)"

cluster deploy:
	@if [ -d "$(MAIN_PATH)/ocp4" ]; then rm -rf "$(MAIN_PATH)/ocp4"; fi && \
	mkdir $(MAIN_PATH)/ocp4 && \
	cp $(MAIN_PATH)/install-config.yaml $(MAIN_PATH)/ocp4/
	@if [ ! -d "$(INSTALL_DIR)" ]; then \
		echo "Directory '$(INSTALL_DIR)' not found. Please ensure it exists."; \
		exit 1; \
	fi
	@read -p "Did you configure '$(MAIN_PATH)/install-config.yaml'? [y/N] " confirm; \
	if [ "$$confirm" != "y" ]; then \
		echo "Please configure '$(MAIN_PATH)/install-config.yaml' before proceeding."; \
		exit 1; \
	fi
#	OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=quay.io/openshift-release-dev/ocp-release:4.18.0-ec.4-x86_64 "$(INSTALLER_PATH)" create cluster --dir="$(INSTALL_DIR)"
	"$(INSTALLER_PATH)" create cluster --dir="$(INSTALL_DIR)"
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(MAIN_PATH)/login.sh"

destroy:
	@if [ ! -d "$(INSTALL_DIR)" ]; then \
		echo "Directory '$(INSTALL_DIR)' not found. Please ensure it exists."; \
		exit 1; \
	fi
	$(INSTALLER_PATH) destroy cluster --dir="$(INSTALL_DIR)"

operator_common:
	@if [ ! -f "$(MAIN_PATH)/environment_variables.sh" ]; then \
		echo "Environment script $(MAIN_PATH)/environment_variables.sh not found! Please ensure it exists."; \
		exit 1; \
	fi

operator: operator_common
	@read -p "Did you add the required ODF disks (3 disks per worker)? [y/N] " confirm; \
	if [ "$$confirm" != "y" ]; then \
		echo "Please add the disks before proceeding."; \
		exit 1; \
	fi
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/run_operator.sh"

lso: operator_common
	@read -p "Did you add the required LSO disk (1 disk per worker)? [y/N] " confirm; \
	if [ "$$confirm" != "y" ]; then \
	    echo "Please add the disks before proceeding."; \
	    exit 1; \
	fi; \
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/lso/run_lso.sh"

odf: operator_common
	@read -p "Did you add the required ODF disks (3 disks per worker)? [y/N] " confirm; \
	if [ "$$confirm" != "y" ]; then \
		echo "Please add the disks before proceeding."; \
		exit 1; \
	fi
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/odf/run_odf.sh"

cnv: operator_common
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/cnv/run_cnv.sh"

workload: operator_common
	@read -p "Did you configure test environments in $(MAIN_PATH)/environment_variables.sh? [y/N] " confirm; \
	if [ "$$confirm" != "y" ]; then \
		echo "Please configure environments in $(MAIN_PATH)/environment_variables.sh before running workload!"; \
		exit 1; \
	fi
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/workload/run_workload.sh"

version:
	$(INSTALLER_PATH) version

help:
	@echo "Usage:"
	@echo "  make install-config  - Create the install configuration"
	@echo "  make cluster/deploy         - Create the cluster: Comment out 'export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE' when using the official version"
	@echo "  make destroy         - Destroy the cluster"
	@echo "  make operator        - Install CNV/LSO/ODF operators [DATA DISK Required - 3 disks per worker!!!]"
	@echo "  make lso    - Install LSO operator [DATA DISK Required]"
	@echo "  make odf    - Install ODF operator [DATA DISK Required]"
	@echo "  make cnv    - Install CNV operator"
	@echo "  make workload            - Run workloads (ensure test environments are configured and Podman is installed): Results path: /tmp/benchmark-runner-run-artifacts"
	@echo "  make version         - Display the OpenShift installer version"
