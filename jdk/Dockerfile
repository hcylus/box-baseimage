# vim: set ft=dockerfile:

FROM core/centos:7.3.1611

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack JDK Base Image" \
  vender="opstack" \
  build-date="20170719"

COPY ./install_jdk1.8.sh /install/jdk1.8.sh

RUN /install/jdk1.8.sh \
  && rm -rf /install

