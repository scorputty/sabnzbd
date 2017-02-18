#!/usr/bin/env bash

# edit for your situation (config/sabnzbd should be there)
VOL_SHARE="/Volumes/shares/docker/"

test -d ${VOL_SHARE} || VOL_SHARE="${PWD}${VOL_SHARE}" && mkdir -p ${VOL_SHARE}/config/sabnzbd

docker run -d -h $(hostname) \
  -p 8080:8080 \
  -p 9090:9090 \
  -v ${VOL_SHARE}:/share \
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
