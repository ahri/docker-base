FROM phusion/baseimage:0.9.15
MAINTAINER Adam Piper <adam@ahri.net>

RUN addgroup --system --gid 415311 docker-group && \
    adduser \
    --system \
    --uid=415311 \
    --gid=415311 \
    --home /home/docker-user \
    --shell /bin/bash \
    docker-user

RUN export HOME=/root
RUN export DEBIAN_FRONTEND=noninteractive

ADD loggly-setup.sh /loggly-setup.sh
RUN /loggly-setup.sh
