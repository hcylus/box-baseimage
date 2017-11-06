# vim: set ft=dockerfile:

FROM jenkins/slave:1.0.0

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack CentOS jenkins jnlp slave Image" \
  vender="opstack" \
  build-date="20170719"

ARG VERSION=3.7

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

USER ${JENKINS_USER}

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]
