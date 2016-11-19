[![Build Status](https://travis-ci.org/scorputty/sabnzbd.svg?branch=master)](https://travis-ci.org/scorputty/sabnzbd)

# Docker SABnzbd (Alpine Base)

This is a Dockerfile to set up "SABnzbd" - (http://sabnzbd.org/).

### Docker Hub
The built image is also hosted at Docker Hub - (https://hub.docker.com/r/cryptout/sabnzbd/).
You can run it directly if you don't want to customize the container by typing the following commands.
```sh
export VOL_CONFIG="/Volumes/shares/docker/config/sabnzbd"
export VOL_DOWNLOADS="/Volumes/shares/docker/data/sabnzbd/downloads"
export VOL_INCOMPLETE_DOWNLOADS="/Volumes/shares/docker/data/sabnzbd/incomplete-downloads"
export LOCAL_PORT1="8080"
export LOACL_PORT2="9090"

docker run -d -h $(hostname) \
  -v ${VOL_CONFIG}:/config \
  -v ${VOL_DOWNLOADS}:/downloads \
  -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete-downloads \
  -p ${LOCAL_PORT1}:8080 \
  -p ${LOACL_PORT2}:9090 \
  --restart=always cryptout/sabnzbd
```

# Build from Dockerfile
Clone this repository and run the build.sh script.
```sh
git clone https://github.com/scorputty/sabnzbd.git
cd sabnzbd
./build.sh
```

### Variables
Change to match your situation.
```Dockerfile
ENV appUser="media"
ENV appGroup="1000"
```

### Volumes
Make sure to map the Volumes to match your situation.
```Dockerfile
VOLUME ["/config", "/downloads", "/incomplete-downloads"]
```

### To run the container
Edit rundocker.sh (this will be replaced by docker-compose soon...).
```sh
./rundocker.sh
```
### WebGUI
To reach the WebGUI go to - (http://localhost:8080).
Or replace localhost with your target IP.

## Info
Shell access whilst the container is running: `docker exec -it sabnzbd /bin/sh`
To monitor the logs of the container in realtime: `docker logs -f sabnzbd`

# Notes
I'm still learning Docker and use these private (pet)projects to develop my skills.
While I use these containers myself they are by no means perfect and are always prone to error or change.
That said, even if only one person copies a snippet of code or learns something from my projects I feel I've contributed a little bit to the Opensource cause...
