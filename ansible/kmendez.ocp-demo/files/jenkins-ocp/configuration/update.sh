#!/bin/bash

echo Checking for updates

JENKINS_CLI=/var/lib/jenkins/war/WEB-INF/jenkins-cli.jar

UPDATE_LIST=$( java -jar ${JENKINS_CLI} -s http://127.0.0.1:8080/ list-plugins | grep -e ')$' | awk '{ print $1 }' ); 
if [ ! -z "${UPDATE_LIST}" ]; then 
    echo Updating Jenkins Plugins: ${UPDATE_LIST}; 
    java -jar ${JENKINS_CLI} -s http://127.0.0.1:8080/ install-plugin ${UPDATE_LIST} blueocean;
    java -jar ${JENKINS_CLI} -s http://127.0.0.1:8080/ safe-restart;
fi

echo done
