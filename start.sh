#!/bin/sh

set -e

# /share/config maps to nfs share home-server/config
test -d /share/config/sickrage || exit 1

# WORKDIR should be /sabnzbd
./SABnzbd.py -b 0 -f /config/sabnzbd -s 0.0.0.0:8080
