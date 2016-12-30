#!/usr/bin/env bash

# edit for your situation
VOL_CONFIG="/Volumes/shares/docker/config/sabnzbd"
VOL_DOWNLOADS="/Volumes/shares/docker/data/sabnzbd/downloads"
VOL_INCOMPLETE_DOWNLOADS="/Volumes/shares/docker/data/sabnzbd/incomplete-downloads"
VOL_MEDIA="/Volumes/shares/docker/media"
LOCAL_PORT1="8080"
LOACL_PORT2="9090"

test -d ${VOL_CONFIG} || VOL_CONFIG="${PWD}${VOL_CONFIG}" && mkdir -p ${VOL_CONFIG}
test -d ${VOL_DOWNLOADS} || VOL_DOWNLOADS="${PWD}${VOL_DOWNLOADS}" && mkdir -p ${VOL_DOWNLOADS}
test -d ${VOL_INCOMPLETE_DOWNLOADS} || VOL_INCOMPLETE_DOWNLOADS="${PWD}${VOL_INCOMPLETE_DOWNLOADS}" && mkdir -p ${VOL_INCOMPLETE_DOWNLOADS}
test -d ${VOL_MEDIA} || VOL_MEDIA="${PWD}${VOL_MEDIA}" && mkdir -p ${VOL_MEDIA}

docker run -d -h $(hostname) \
  -v ${VOL_CONFIG}:/config \
  -v ${VOL_DOWNLOADS}:/downloads \
  -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete-downloads \
  -v ${VOL_MEDIA}:/media \
  -p ${LOCAL_PORT1}:8080 \
  -p ${LOACL_PORT2}:9090 \
  --name=sabnzbd --restart=always cryptout/sabnzbd
