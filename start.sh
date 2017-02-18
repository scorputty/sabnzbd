#!/bin/sh

set -e

# /share/config maps to nfs share home-server/config
test -d /share/config/sabnzbd || exit 1

# WORKDIR should be /sabnzbd
./SABnzbd.py -b 0 -f /share/config/sabnzbd -s 0.0.0.0:8080
