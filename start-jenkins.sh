#!/bin/bash
rm -fr jenkins_home/jobs/Personal\ Qualification\ Calculator/builds/*
echo "1" > ~/.jenkins/jobs/Personal\ Qualification\ Calculator/nextBuildNumber
export JENKINS_HOME=jenkins_home
java -jar -Dhudson.model.DirectoryBrowserSupport.CSP="" -Xms1g -Xmx1g jenkins.war
