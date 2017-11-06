FROM jenkins:2.32.3

MAINTAINER seanly seanly@aliyun.com

USER root

# change timezone to +8
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' > /etc/timezone

# Preinstalling plugins
ENV JENKINS_UC=http://updates.jenkins-ci.org
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN plugins.sh /usr/share/jenkins/ref/plugins.txt

# for main web interface:
EXPOSE 8080

# Jenkins home directory is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container, 
# ensure you use the same uid
USER jenkins
