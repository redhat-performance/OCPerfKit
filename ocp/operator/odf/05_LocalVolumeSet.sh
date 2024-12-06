# Define disk size and device count environment variables for ODF
echo "Using ODF_DISK_MIN_SIZE: ${ODF_DISK_MIN_SIZE}" 
echo "Using ODF_DISK_MAX_SIZE: ${ODF_DISK_MAX_SIZE}"
echo "ODF_DISK_PER_WORKER: ${ODF_DISK_PER_WORKER}"

# Create LocalVolumeSet with disk size and device count constraints
cat <<EOF | oc apply -f -
apiVersion: local.storage.openshift.io/v1alpha1
kind: LocalVolumeSet
metadata:
  name: local-block
  namespace: openshift-local-storage
spec:
  nodeSelector:
    nodeSelectorTerms:
      - matchExpressions:
          - key: cluster.ocs.openshift.io/openshift-storage
            operator: In
            values:
              - ""
  storageClassName: localblock
  volumeMode: Block
  fstype: ext4
  maxDeviceCount: ${ODF_DISK_PER_WORKER}  # Use environment variable for maximum devices per worker
  deviceInclusionSpec:
    deviceTypes:
    - disk
    - part   # Remove this if not using partitions
    #deviceMechanicalProperties:
    #- NonRotational/Rotational
    minSize: ${ODF_DISK_MIN_SIZE}  # Use environment variable for minimum disk size
    maxSize: ${ODF_DISK_MAX_SIZE}  # Use environment variable for maximum disk size
EOF

