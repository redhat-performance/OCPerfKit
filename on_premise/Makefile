# Makefile for OpenShift On-premise installation

# Set MAIN_PATH to one level up from the current directory
export HEAD_PATH=$(dirname $(pwd))

# Dynamically set MAIN_PATH to the current directory
export MAIN_PATH = $(shell pwd)

# Targets
.PHONY: install-config cluster destroy help operator version test

cluster:
	@read -p "Did you copy your pull secret to pull_secret.txt ? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please copy your pull secret to pull_secret.txt: https://cloud.redhat.com/openshift/install/metal/installer-provisioned"; \
		exit 1; \
    bash -c "source $(MAIN_PATH)/environment_variables.sh && $(MAIN_PATH)/jetlag/run_jetlag.sh"
	$(MAIN_PATH)/login.sh

operator:
	@if [ ! -f "$(MAIN_PATH)/environment_variables.sh" ]; then \
		echo "Environment script $(MAIN_PATH)/environment_variables.sh not found! Please ensure it exists."; \
		exit 1; \
	fi
	@read -p "Did you add the required ODF disks (3 disks per worker)? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please add the disks before proceeding."; \
		exit 1; \
	fi
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(HEAD_PATH)/operator/run_operator.sh"

test:
	@if [ ! -f "$(MAIN_PATH)/environment_variables.sh" ]; then \
		echo "Environment script $(MAIN_PATH)/environment_variables.sh not found! Please ensure it exists."; \
		exit 1; \
	fi
	@read -p "Did you configure test environments in $(MAIN_PATH)/environment_variables.sh? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please configure environments in $(MAIN_PATH)/environment_variables.sh before running tests!"; \
		exit 1; \
	fi
	bash -c "source $(MAIN_PATH)/environment_variables.sh && $(HEAD_PATH)/test/run_test.sh"


help:
	@echo "Usage:"
	@echo "  make cluster         - Create BareMetal cluster"
	@echo "  make operator        - Install CNV/LSO/ODF operators [DATA DISK Required!!!]"
	@echo "  make test            - Run Workloads (ensure test environments are configured and podman is installed):Results path: /tmp/benchmark-runner-run-artifacts"
