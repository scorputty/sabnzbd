[![Build Status](https://travis-ci.org/scorputty/sabnzbd.svg?branch=master)](https://travis-ci.org/scorputty/sabnzbd)[![](https://images.microbadger.com/badges/image/cryptout/sabnzbd.svg)](https://microbadger.com/images/cryptout/sabnzbd "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/cryptout/sabnzbd.svg)](https://microbadger.com/images/cryptout/sabnzbd "Get your own version badge on microbadger.com")

# Docker SABnzbd (Alpine Base)

This is a Dockerfile to build "SABnzbd" - (http://sabnzbd.org/).
This is no longer updated

### Docker Hub
The built image is also hosted at Docker Hub - (https://hub.docker.com/r/cryptout/sabnzbd/).

# Build from Dockerfile
Clone this repository and run the build.sh script.
```sh
git clone https://github.com/scorputty/sabnzbd.git
cd sabnzbd
./build.sh
```

### Start container
```sh
./rundocker.sh
```

### Or use docker-compose
```
sabnzbd:
    container_name: sabnzbd
    image: docker.io/cryptout/sabnzbd
    hostname: sabnzbd
    network_mode: host
    environment:
      - TZ=Europe/Amsterdam
      - USER=media
      - USERID=10000
      - PUID=10000
      - PGID=10000
      - ENV appUser=media
      - ENV appGroup=media
    volumes:
      - /share:/share
```

### WebGUI
To reach the WebGUI go to - (http://localhost:8080).
Or replace localhost with your target IP.
* I did not bother with SSL/TLS or any login credentials. 

## Info
* Shell access whilst the container is running: `docker exec -it sabnzbd /bin/sh`
* To monitor the logs of the container in realtime: `docker logs -f sabnzbd`

# Notes
I'm still learning Docker and use these private (pet)projects to develop my skills.
While I use these containers myself they are by no means perfect and are always prone to error or change.
That said, even if only one person copies a snippet of code or learns something from my projects I feel I've contributed a little bit to the Open-source cause...
