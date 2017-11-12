#!/bin/bash
export OPENSHIFT_ENDPOINT=https://ocp:8443
export OPENSHIFT_TOKEN=$(oc whoami -t)
export OPENSHIFT_NAMESPACE_URL=che-eclipse-che.apps.192.168.124.215.nip.io
export OPENSHIFT_FLAVOR=ocp
export CHE_IMAGE_TAG=5.17.0-centos 

DEPLOY_SCRIPT_URL=https://raw.githubusercontent.com/eclipse/che/master/dockerfiles/init/modules/openshift/files/scripts/deploy_che.sh
WAIT_SCRIPT_URL=https://raw.githubusercontent.com/eclipse/che/master/dockerfiles/init/modules/openshift/files/scripts/wait_until_che_is_available.sh
STACKS_SCRIPT_URL=https://raw.githubusercontent.com/eclipse/che/master/dockerfiles/init/modules/openshift/files/scripts/replace_stacks.sh
curl -fsSL ${DEPLOY_SCRIPT_URL} -o ./get-che.sh
curl -fsSL ${WAIT_SCRIPT_URL} -o ./wait-che.sh
curl -fsSL ${STACKS_SCRIPT_URL} -o ./stacks-che.sh
bash ./get-che.sh && bash ./wait-che.sh && bash ./stacks-che.sh
