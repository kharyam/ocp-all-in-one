#!/bin/bash

set -e

# Import latest EAP images
oc import-image jboss-eap64-openshift -n openshift --all --confirm
oc import-image jboss-eap70-openshift -n openshift --all --confirm

# Import older image for demo purposes
oc import-image openshift/jboss-eap70-openshift:1.3 --from=registry.access.redhat.com/jboss-eap-7/eap70-openshift:1.3 --confirm -n openshift


# Create projects if they don't exist
oc new-project pqc-support --display-name "PQC Support Infrastructure" || true
oc new-project pqc-dev --display-name "PQC Development Project" || true
oc new-project pqc-test --display-name "PQC Test Project" || true
oc new-project pqc-prod --display-name "PQC Production Project" || true

# Wait for registry to start
while ! oc get pods -n default | grep docker-registry | grep Running
do
sleep 1
done

# Create the PQC Support Project
oc project pqc-support
oc delete all --all -n pqc-support
oc delete template pqc-support -n pqc-support
oc create -f pqc_templates/pqc_support_template.yml -n pqc-support
oc new-app --template=pqc-support -n pqc-support || true
oc start-build --from-file=./sonarqube/Dockerfile bc/sonarqube-custom --follow --wait --namespace=pqc-support

# Create the PQC Development Project
oc project pqc-dev
oc delete all --all -n pqc-dev
oc delete template pqc-dev -n pqc-dev
oc create -f pqc_templates/pqc_dev_template.yml -n pqc-dev
oc new-app --template=pqc-dev -n pqc-dev || true

# Create the PQC Test Project
oc project pqc-test
oc delete all --all -n pqc-test
oc delete template pqc-test -n pqc-test
oc create -f pqc_templates/pqc_test_template.yml -n pqc-test
oc new-app --template=pqc-test -n pqc-test || true

# Create the PQC Production Project
oc project pqc-prod
oc delete all --all -n pqc-prod
oc delete template pqc-prod -n pqc-prod
oc create -f pqc_templates/pqc_prod_template.yml -n pqc-prod
oc new-app --template=pqc-prod -n pqc-prod || true
