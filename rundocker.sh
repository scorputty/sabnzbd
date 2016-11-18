#!/usr/bin/env bash

# edit for your situation
VOL_CONFIG="/Volumes/shares/docker/config/sabnzbd"
VOL_DOWNLOADS="/Volumes/shares/docker/data/sabnzbd/downloads"
VOL_INCOMPLETE_DOWNLOADS="/Volumes/shares/docker/data/sabnzbd/incomplete-downloads"
LOCAL_PORT1="8080"
LOACL_PORT2="9090"

test -d ${VOL_CONFIG} || VOL_CONFIG=".${VOL_CONFIG}" && mkdir -p ${VOL_CONFIG}
test -d ${VOL_DOWNLOADS} || VOL_DOWNLOADS=".${VOL_DOWNLOADS}" && mkdir -p ${VOL_DOWNLOADS}
test -d ${VOL_INCOMPLETE_DOWNLOADS} || VOL_INCOMPLETE_DOWNLOADS=".${VOL_INCOMPLETE_DOWNLOADS}" && mkdir -p ${VOL_INCOMPLETE_DOWNLOADS}

docker run -d -h $(hostname) \
  -v ${VOL_CONFIG}:/config \
  -v ${VOL_DOWNLOADS}:/downloads \
  -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete-downloads \
  -p ${LOCAL_PORT1}:8080 \
  -p ${LOACL_PORT2}:9090 \
  --restart=always scorputty/sabnzbd
# for troubleshooting use this start command to get a shell
# docker run -ti -h $(hostname) \
#   -v ${VOL_CONFIG}:/config \
#   -v ${VOL_DOWNLOADS}:/downloads \
#   -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete-downloads \
#   -p ${LOCAL_PORT1}:8080 \
#   -p ${LOACL_PORT2}:9090 \
#   --restart=always scorputty/sabnzbd \
#   /bin/sh
