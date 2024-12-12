# Define ODF version environment variable

echo "Using ODF version: ${ODF_VERSION}"  # Echo the version for testing

# Create Namespace for OpenShift Storage
cat <<EOF | oc create -f -
apiVersion: v1
kind: Namespace
metadata:
  labels:
    openshift.io/cluster-monitoring: "true"
  name: openshift-storage
spec: {}
EOF

# Create OperatorGroup for OpenShift Storage
cat <<EOF | oc create -f -
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: openshift-storage-operatorgroup
  namespace: openshift-storage
spec:
  targetNamespaces:
  - openshift-storage
EOF

# Create Subscription for ODF Operator with dynamic version
cat <<EOF | oc create -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: odf-operator
  namespace: openshift-storage
spec:
  channel: "stable-${ODF_VERSION}"  # Use ODF_VERSION for the channel
  installPlanApproval: Automatic
  name: odf-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
EOF

