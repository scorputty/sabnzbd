[![Build Status](https://travis-ci.org/scorputty/sabnzbd.svg?branch=master)](https://travis-ci.org/scorputty/sabnzbd)

# docker sabnzbd

This is a Dockerfile to set up "SABnzbd" - (http://sabnzbd.org/)

Build from docker file

```
git clone https://github.com/scorputty/sabnzbd.git
cd sabnzbd
./build.sh
```
- to run edit rundocker.sh
```
VOL_CONFIG="*your_config_location*"
VOL_DATA="*your_videos_location"
LOCAL_PORT="8080"
docker run -d -h $(hostname) -v ${VOL_CONFIG}:/config -v ${VOL_DATA}:/data -p ${LOCAL_PORT}:8080 --restart=always scorputty/sabnzbd
```
