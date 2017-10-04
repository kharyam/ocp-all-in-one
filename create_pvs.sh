#!/bin/bash

# Create PV directories on the vm:
#mkdir -p /home/openshift/pvs/pv{000..199}
#chmod -R 777 /home/openshift/pvs
#chcon -Rt svirt_sandbox_file_t /home/openshift/pvs

for i in {000..199}
do
printf 'kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv%03d
  labels:
    type: local
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
    - ReadWriteOnce
  hostPath:
    path: "/home/openshift/pvs/pv%03d"
  persistentVolumeReclaimPolicy: Recycle
' $i $i | oc create -f -

done
