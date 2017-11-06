# vim: set ft=dockerfile:

FROM core/jdk:1.8.0

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack CentOS jenkins slave Image" \
  vender="opstack" \
  build-date="20170719"

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_USER=${user}
ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

# Jenkins is run with user `jenkins`, uid = 10000
# If you bind mount a volume from the host or a data container, 
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
  && useradd -d "$JENKINS_AGENT_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME ${JENKINS_AGENT_HOME}

RUN yum -y install git subversion && yum clean all
