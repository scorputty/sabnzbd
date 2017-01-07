#!/bin/sh

# if /config doesnt exist, exit
test -d /config || exit 1

# WORKDIR should be /sabnzbd
./SABnzbd.py -b 0 -f /config/sabnzbd -s 0.0.0.0:8080
