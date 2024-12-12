# Define version parameters
echo "Using LSO version: ${LSO_VERSION}"  # Echo the version for testing
# Create Namespace for OpenShift Local Storage
cat <<EOF | oc create -f -
apiVersion: v1
kind: Namespace
metadata:
  name: openshift-local-storage
spec: {}
EOF

# Create OperatorGroup for OpenShift Local Storage
cat <<EOF | oc create -f -
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: local-operator-group
  namespace: openshift-local-storage
spec:
  targetNamespaces:
  - openshift-local-storage
EOF

# Create CatalogSource for Red Hat Operators with LSO_VERSION
oc create -f - <<__EOF__
---
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: redhat-operators-v${LSO_VERSION_NAME}
  namespace: openshift-marketplace
spec:
  displayName: Red Hat Operators v${LSO_VERSION_NAME}
  image: registry.redhat.io/redhat/redhat-operator-index:v${LSO_VERSION}
  publisher: Red Hat
  sourceType: grpc
  updateStrategy:
    registryPoll:
      interval: 30m0s
__EOF__

# Create Subscription for Local Storage Operator
cat <<EOF | oc create -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: local-storage-operator
  namespace: openshift-local-storage
spec:
  channel: "stable"
  installPlanApproval: Automatic
  name: local-storage-operator
  source: redhat-operators-v${LSO_VERSION_NAME}  # Use the versioned CatalogSource name
  sourceNamespace: openshift-marketplace
EOF

