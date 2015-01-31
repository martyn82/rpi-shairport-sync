Dockerized shairport-sync for RaspberryPi
==========================================

Build an image for running Shairport-sync on a RaspberryPi. It uses the Raspbian base image by resin.
Contains avahi, dbus, and shairport-sync, run by supervisord.

Build the image
---------------

The base image is targetted at an arm architecture, because that is what the RaspberryPi is using. Therefore, to
successfully build this image, you must build it on an arm device as well (or you can use a cross-compiling technique).

Build the image this way:

```
$ docker build .
```

Building the container can take a while on the RaspberryPi itself as it does not have the fastest CPU,
but hey, it is cool!

Run the image
-------------

Running the image on a device with arm architecture:

```
$ docker run -d --net=host --device=... <image_id>
```

It is advised to run the container as a daemon as it starts long running processes. Furthermore, to be sure that
all necessary ports for enabling discovery of AirPlay devices are forwarded on the host use the host's
network interface.

One important note is that you have to map the sound devices located in /dev/snd to the container. Otherwise, the
container will be unable to provide sound playback at the host.

Configuration
-------------
Alter the supervisord.conf file to match your preferences. The same holds for the entrypoint script (start). By default,
the HDMI sound output is used for playback.
