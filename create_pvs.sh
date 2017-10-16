#!/bin/bash
for i in {1..200}
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
