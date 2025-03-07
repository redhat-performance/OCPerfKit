#!/bin/bash
echo ODF_DISK_TYPE=${ODF_DISK_TYPE}

oc get nodes -l node-role.kubernetes.io/worker= -o jsonpath="{range .items[*]}{.metadata.name}{'\n'}{end}" | xargs -I{} oc debug node/{} -- chroot /host sh -c "ls -l /dev/disk/by-id/ | grep '${ODF_DISK_TYPE}' | awk '{print \$9}' | sed 's/^/sudo wipefs -a \\/dev\\/disk\\/by-id\\//' | tee /tmp/wipe_disks_to_run.sh; chmod +x /tmp/wipe_disks_to_run.sh; sudo /tmp/wipe_disks_to_run.sh"