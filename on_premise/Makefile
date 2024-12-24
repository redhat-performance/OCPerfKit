# Makefile for OCPPerfKit on-premise

# Get PARENT folder up
export PARENT_PATH = $(shell dirname $(MAIN_PATH))

# Set MAIN_PATH to the current directory
export MAIN_PATH = $(shell pwd)

# Targets
.PHONY: install-config cluster destroy help operator operator_common operator_odf operator_cnv version test

cluster:
	@echo "Checking environment setup..."
	@read -p "Did you fill in environment_variables.sh and run 'source environment_variables.sh'? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please fill in and source environment_variables.sh first."; \
		exit 1; \
	fi
	@read -p "Did you copy your pull secret 'pull_secret.txt' to the jetlag folder? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please copy your pull secret to pull_secret.txt: https://cloud.redhat.com/openshift/install/metal/installer-provisioned"; \
		exit 1; \
	fi
	cp $(MAIN_PATH)/run_jetlag.sh $(MAIN_PATH)/jetlag/run_jetlag.sh
	@chmod +x $(MAIN_PATH)/jetlag/bootstrap.sh $(MAIN_PATH)/jetlag/run_jetlag.sh
	@bash -c "source $(MAIN_PATH)/environment_variables.sh && source $(MAIN_PATH)/jetlag/bootstrap.sh && $(MAIN_PATH)/jetlag/run_jetlag.sh"
	@chmod +x $(MAIN_PATH)/login.sh
	@bash $(MAIN_PATH)/login.sh

operator_common:
	@if [ ! -f "$(MAIN_PATH)/environment_variables.sh" ]; then \
		echo "Environment script $(MAIN_PATH)/environment_variables.sh not found! Please ensure it exists."; \
		exit 1; \
	fi
	@git pull

operator: operator_common
	@read -p "Did you add the required ODF disks (3 disks per worker)? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please add the disks before proceeding."; \
		exit 1; \
	fi
	@bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/run_operator.sh"

operator_odf: operator_common
	@read -p "Did you add the required ODF disks (3 disks per worker)? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please add the disks before proceeding."; \
		exit 1; \
	fi
	@bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/odf/run_odf.sh"

operator_cnv: operator_common
	@bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/operator/cnv/run_cnv.sh"

test:
	@if [ ! -f "$(MAIN_PATH)/environment_variables.sh" ]; then \
		echo "Environment script $(MAIN_PATH)/environment_variables.sh not found! Please ensure it exists."; \
		exit 1; \
	fi
	@read -p "Did you configure test environments in $(MAIN_PATH)/environment_variables.sh? [y/N] " confirm && if [ "$$confirm" != "y" ]; then \
		echo "Please configure environments in $(MAIN_PATH)/environment_variables.sh before running tests!"; \
		exit 1; \
	fi
	@git pull
	@bash -c "source $(MAIN_PATH)/environment_variables.sh && $(PARENT_PATH)/test/run_test.sh"

help:
	@echo "Usage:"
	@echo "  make cluster         - Create BareMetal cluster"
	@echo "  make operator        - Install CNV/LSO/ODF operators [DATA DISK Required - 3 disks per worker!!!]"
	@echo "  make operator_odf    - Install ODF operator [DATA DISK Required]"
	@echo "  make operator_cnv    - Install CNV operator"
	@echo "  make test            - Run Workloads (ensure test environments are configured and podman is installed): Results path: /tmp/benchmark-runner-run-artifacts"
