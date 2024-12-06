#!/bin/bash

#https://github.com/rook/kubectl-rook-ceph
sudo dnf install -y git
# install krew
set -x; cd "$(mktemp -d)" && OS="$(uname | tr '[:upper:]' '[:lower:]')" && ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && KREW="krew-${OS}_${ARCH}" && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" && tar zxvf "${KREW}.tar.gz" && ./"${KREW}" install krew

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ODF health check with timeout of 3600 seconds
timeout=3600
elapsed=0
health_status=""

# Loop to check the health status
while [ $elapsed -lt $timeout ]; do
  health_status=$(kubectl rook-ceph -n openshift-storage ceph -s | grep 'health' | awk '{print $2}' | tr -d '\n')
  echo "health_status==${health_status}"

  # Check if the health status is HEALTH_OK
  if [ "$health_status" == "HEALTH_OK1/1" ]; then
    echo "Ceph cluster is healthy!!!"
    exit 0
  fi

  # Wait for 10 seconds before re-checking
  sleep 10
  elapsed=$((elapsed + 10))
done

# If timeout is reached without HEALTH_OK
echo "Timeout reached. Ceph cluster status: $health_status"
exit 1

