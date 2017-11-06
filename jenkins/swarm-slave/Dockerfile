# vim: set ft=dockerfile:

FROM jenkins/slave:1.0.0

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack CentOS jenkins swarm slave Image" \
  vender="opstack" \
  build-date="20170719"

ARG JENKINS_SWARM_VERSION=3.3

USER root
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-${JENKINS_SWARM_VERSION}.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/swarm-client-${JENKINS_SWARM_VERSION}.jar

COPY ./jenkins-swarm-slave /usr/local/bin/jenkins-swarm-slave

USER ${JENKINS_USER}

ENTRYPOINT ["/usr/local/bin/jenkins-swarm-slave"]
