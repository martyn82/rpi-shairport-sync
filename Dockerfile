FROM resin/rpi-raspbian:wheezy
MAINTAINER Martijn Endenburg <martijn.endenburg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    alsa-utils \
    autoconf \
    avahi-daemon \
    build-essential \
    dbus \
    libasound2-dev \
    libavahi-client-dev \
    libdaemon-dev \
    libgpg-error0 \
    libpopt-dev \
    libssl-dev \
    libtool \
    supervisor \
    unzip \
    wget

# Download, unpack, and compile Shairport-Sync
RUN mkdir -p \
    /var/log/supervisor \
    /var/run/dbus \
    /usr/src/shairport-sync \
    && wget --no-check-certificate -O /usr/src/shairport-sync/shairport-sync-2.2.zip https://github.com/mikebrady/shairport-sync/archive/2.2.zip \
    && cd /usr/src/shairport-sync \
    && unzip -d /usr/src/shairport-sync shairport-sync-2.2.zip \
    && cd shairport-sync-2.2 \
    && autoreconf -i -f && ./configure --with-alsa --with-avahi --with-ssl=openssl && make && make install

# Configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Entrypoint
COPY start /start
RUN chmod +x start
CMD ["/start"]

