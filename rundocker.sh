#!/usr/bin/env bash

# edit for your situation
VOL_CONFIG="/Volumes/shares/docker/config/sabnzbd"
VOL_MEDIA="/Volumes/shares/docker/media"

test -d ${VOL_CONFIG} || VOL_CONFIG="${PWD}${VOL_CONFIG}" && mkdir -p ${VOL_CONFIG}
test -d ${VOL_MEDIA} || VOL_MEDIA="${PWD}${VOL_MEDIA}" && mkdir -p ${VOL_MEDIA}

docker run -d -h $(hostname) \
  -p 8080:8080
  -p 9090:9090
  -v ${VOL_CONFIG}:/config \
  -v ${VOL_MEDIA}:/media \
  -e TZ="Europe/Amsterdam" \
  -e appUser="media" \
  -e appGroup="media" \
  -e PUID="10000" \
  -e PGID="10000" \
  --name=sabnzbd --restart=always cryptout/sabnzbd

  # for troubleshooting run
  # docker exec -it sabnzbd /bin/bash
  # to check logs run
  # docker logs -f sabnzbd
