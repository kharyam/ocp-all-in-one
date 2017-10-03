#!/bin/bash

# Create PV directories on the vm:
#mkdir /home/openshift/pvs/pv{00..50}
#chcon -Rt svirt_sandbox_file_t /home/openshift/pvs

for i in {0..50}
do
printf 'kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv%02d
  labels:
    type: local
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
    - ReadWriteOnce
  hostPath:
    path: "/home/openshift/pvs/pv%02d"
' $i $i | oc create -f -

done
