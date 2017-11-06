# vim: set ft=dockerfile:

FROM core/centos:7.3.1611

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack Ansible Base Image" \
  vender="opstack" \
  build-date="20170719"

USER root

RUN yum -y install vsftpd ftp lftp jq \
  && yum clean all 

ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV UPLOADED_FILES_WORLD_READABLE **Boolean**

EXPOSE 20-21 21100-21110
COPY data /

VOLUME /var/log /home/ftp

CMD ["/entrypoint.sh"]


