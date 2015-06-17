# This Dockerfile creates a containerized rpi-shairport-sync build instance.
# It will compile and package a rpi-shairport-sync application.

FROM library/ubuntu:14.04
MAINTAINER Martijn Endenburg <martijn.endenburg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

VOLUME /build

RUN apt-get update
RUN apt-get install -y \
    autoconf \
    gcc \
    libavahi-client-dev \
    libasound2-dev \
    libdaemon-dev \
    libpopt-dev \
    libssl-dev \
    libtool \
    make \
    tar \
    unzip \
    wget

# Build and install Go
RUN mkdir ~/go \
    && cd ~/go \
    && wget https://go.googlesource.com/go/+archive/go1.4.2.tar.gz \
    && tar -xvf go1.4.2.tar.gz \
    && cd src/ \
    && ./make.bash

# Build controller client
RUN mkdir ~/rpi-controller \
    && wget -O ~/rpi-controller/rpi-controller.zip \
        https://github.com/martyn82/rpi-controller/archive/master.zip \
    && cd ~/rpi-controller \
    && unzip rpi-controller.zip \
    && mkdir -p src/github.com/martyn82 \
    && mv rpi-controller-master src/github.com/martyn82/rpi-controller \
    && export GOPATH=$(pwd) \
    && export GOBIN=$GOPATH/bin \
    && ~/go/bin/go install src/github.com/martyn82/rpi-controller/client/controller.go \
    && cd ~

# Build shairport-sync
RUN mkdir -p \
    ~/shairport-sync \
    && wget --no-check-certificate -O ~/shairport-sync/shairport-sync.zip https://github.com/mikebrady/shairport-sync/archive/master.zip \
    && cd ~/shairport-sync \
    && unzip -d . shairport-sync.zip \
    && cd shairport-sync-master \
    && autoreconf -i -f && ./configure --with-alsa --with-avahi --with-ssl=openssl && make

# Package shairport-sync
RUN cd ~/shairport-sync \
    && mv shairport-sync-master shairport-sync \
    && tar -zcf shairport-sync.tar.gz shairport-sync \
    && mkdir -p /build/bin

RUN mkdir -p /build/bin
CMD cp ~/shairport-sync/shairport-sync.tar.gz /build/bin/shairport-sync.tar.gz \
    && cp ~/rpi-controller/bin/controller /build/bin/controller
