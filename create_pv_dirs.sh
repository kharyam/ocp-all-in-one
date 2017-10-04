#!/bin/bash
# Run as user openshift

PV_HOME=/home/openshift/pvs
NUM_PVS=200
mkdir -p $PV_HOME/pv{001..$NUM_PVS}
chmod -R 777 $PV_HOME
chcon -Rt svirt_sandbox_file_t $PV_HOME
