oc create -f is.yml -n pqc-support || true
oc create -f bc.yml -n pqc-support || true
oc start-build custom-jenkins-build --follow --wait -n pqc-support
oc new-app custom-jenkins -n pqc-support
oc expose svc/custom-jenkins --port=8080 -n pqc-support
oc set env dc/custom-jenkins JAVA_OPTS=-Dhdson.model.DirectoryBrowserSupport.CSP=\"\" -n pqc-support
oc set env dc/custom-jenkins JAVA_GC_OPTS=-XX:MaxMetaspaceSize=256m -n pqc-support
