# vim: set ft=dockerfile:

FROM sameersbn/redmine:3.3.0

MAINTAINER seanly <seanly@aliyun.com>

LABEL name="Opstack apps/redmine Image" \
  vender="opstack" \
  build-date="20170719"

# change timezone to +8
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' > /etc/timezone
