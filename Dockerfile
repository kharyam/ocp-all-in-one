FROM docker.io/sonarqube:latest
RUN wget https://github.com/SonarQubeCommunity/sonar-build-breaker/releases/download/2.2/sonar-build-breaker-plugin-2.2.jar -O /opt/sonarqube/extensions/plugins/sonar-build-breaker-plugin-2.2.jar
RUN chgrp -R 0 /opt/sonarqube && chmod -R 770 /opt/sonarqube 
