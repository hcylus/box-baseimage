# vim: set ft=dockerfile:

FROM centos:7.3.1611

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack CentOS Base Image" \
  vender="opstack" \
  build-date="20170719"

USER root

RUN sed -i '/^override_install_langs=/d' /etc/yum.conf \
  && yum clean all \
  && yum makecache \
  && yum -y install epel-release \
  && yum clean all

# Add locales
RUN set -o errexit -o nounset \
  && echo 'LANG=en_US.UTF-8' > /etc/locale.conf \
  && echo 'LC_ALL=en_US.UTF-8' >> /etc/locale.conf \
  && echo 'LANGUAGE=en_US:en' >> /etc/locale.conf \
  && /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY locale.sh /etc/profile.d/locale.sh

#RUN yum -y update \
#  && yum clean  all

