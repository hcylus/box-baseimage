# vim: set ft=dockerfile:

FROM jenkins/slave:1.0.0

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack CentOS Jenkins SSH-Slave Image" \
  vender="opstack" \
  build-date="20170719"

USER root

# setup and configure SSH server
RUN yum -y install --nogpgcheck --setopt=tsflags=nodocs openssh-server net-tools mtr which  \
  && yum clean all \
  && sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config \
  && sed -i 's/#RSAAuthentication.*/RSAAuthentication yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
  && sed -i 's/#SyslogFacility.*/SyslogFacility AUTH/' /etc/ssh/sshd_config \
  && sed -i 's/#LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config \
  && mkdir /var/run/sshd

COPY setup-sshd /usr/local/bin/setup-sshd

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/setup-sshd"]
