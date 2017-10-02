#!/bin/bash
rm -fr ~/.jenkins/jobs/Personal\ Qualification\ Calculator/builds/*
echo "1" > ~/.jenkins/jobs/Personal\ Qualification\ Calculator/nextBuildNumber
export JENKINS_HOME=jenkins
java -jar -Dhudson.model.DirectoryBrowserSupport.CSP="" -Xms1g -Xmx1g jenkins.war
