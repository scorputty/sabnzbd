#!/bin/sh

# if /config doesnt exist, exit
test -d /config || exit 1
# same goes for downloads
test -d /downloads || exit 2
# same goes for incomplete-downloads
test -d /incomplete-downloads || exit 3

# WORKDIR should be /sabnzbd
./SABnzbd.py -b 0 -f /config/sabnzbd -s 0.0.0.0:8080
