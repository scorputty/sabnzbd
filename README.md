[![Build Status](https://travis-ci.org/scorputty/sabnzbd.svg?branch=master)](https://travis-ci.org/scorputty/sabnzbd)

# Docker SABnzbd (Alpine Base)

This is a Dockerfile to set up "SABnzbd" - (http://sabnzbd.org/)

### Docker Hub
The built image is also hosted at Docker Hub (https://hub.docker.com/r/cryptout/sabnzbd/)

### Build from Dockerfile

```sh
git clone https://github.com/scorputty/sabnzbd.git
cd sabnzbd
./build.sh
```
- to run edit rundocker.sh (this will be replaced by docker-compose soon...)
```sh
VOL_CONFIG="*your_config_location*"
VOL_DATA="*your_videos_location"
LOCAL_PORT="8080"
docker run -d -h $(hostname) -v ${VOL_CONFIG}:/config -v ${VOL_DATA}:/data -p ${LOCAL_PORT}:8080 --restart=always scorputty/sabnzbd
```
