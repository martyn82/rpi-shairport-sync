#!/bin/bash

docker run -d --net=host \
    --device=/dev/snd/controlC0:/dev/snd/controlC0 \
    --device=/dev/snd/pcmC0D0p:/dev/snd/pcmC0D0p \
    --device=/dev/snd/pcmC0D1p:/dev/snd/pcmC0D1p \
    --device=/dev/snd/seq:/dev/snd/seq \
    --device=/dev/snd/timer:/dev/snd/timer \
    -e "ARGS=-a 'Media Player' -w -B '/controller -c=client.conf.json -m=EVT\ shairport:PLAY:START' -E '/controller -c=client.conf.json -m=EVT\ shairport:PLAY:STOP'" \
    martyn82/rpi-shairport-sync
