FROM jenkins/jenkins:lts

USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY basic-security.groovy /usr/share/jenkins/ref/init.groovy.d/basic-security.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

USER root

# gosu
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -sSL -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
  && curl -sSL -o /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

COPY volume-permissions.sh /usr/local/bin/volume-permissions.sh

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/volume-permissions.sh"]