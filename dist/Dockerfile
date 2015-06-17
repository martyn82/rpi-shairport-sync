# This Dockerfile creates a containerized rpi-shairport-sync production instance.
# It will install and run a rpi-shairport-sync application.

FROM resin/rpi-raspbian:wheezy
MAINTAINER Martijn Endenburg <martijn.endenburg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    avahi-daemon \
    dbus \
    gcc \
    libavahi-client-dev \
    libasound2-dev \
    libdaemon-dev \
    libpopt-dev \
    libssl-dev \
    libtool \
    make \
    supervisor \
    tar

# Copy apps and config
COPY bin/shairport-sync.tar.gz shairport-sync.tar.gz
COPY bin/controller /controller
COPY client.conf.json /client.conf.json
COPY supervisord.conf /etc/supervisord.conf
COPY shairport-sync-runner /shairport-sync-runner

RUN tar -zxvf shairport-sync.tar.gz \
    && cd shairport-sync \
    && make install

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
