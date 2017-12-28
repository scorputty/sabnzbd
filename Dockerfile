FROM alpine:latest
MAINTAINER scorputty
LABEL Description="SABnzbd" Vendor="Stef Corputty" Version="0.1.0"

# variables
ENV TZ="Europe/Amsterdam"
ENV appUser="media"
ENV appGroup="media"
ENV PUID="10000"
ENV PGID="10000"

# ports should be mapped with the run command to match your situation
EXPOSE 8080 9090

# copy the start script to the container
COPY start.sh /start.sh

# install runtime packages
RUN \
 apk --update add --no-cache \
       ca-certificates \
       bash \
       su-exec \
       py2-pip \
       python \
       ffmpeg-libs \
       ffmpeg \
       unrar \
       openssl \
       p7zip && \

# update certificates
 update-ca-certificates && \

# install build packages (these will be removed later)
 apk add --no-cache --virtual=build-dependencies \
       g++ \
       gcc \
       libffi-dev\
       openssl-dev \
       make \
       automake \
       autoconf \
       git \
       mercurial \
       musl-dev \
       python-dev && \

# install pip packages
 pip install --no-cache-dir -U \
       incremental \
       pip && \
 pip install --no-cache-dir -U \
       cheetah \
       pyopenssl \
       sabyenc && \

# get and build par2cmdline
 git clone https://github.com/Parchive/par2cmdline.git && \
 cd par2cmdline && \
 aclocal && \
 automake --add-missing && \
 autoconf && \
 ./configure && \
 make && \
 make install && \
 cd / && \

# cleanup
 cd / && \
 apk del --purge \
       build-dependencies && \
 rm -rf \
       /var/cache/apk/* \
       /par2cmdline \
       /sabnzbd/.git \
       /tmp/*

# user with access to media files and config
RUN addgroup -g ${PGID} ${appGroup} && \
 adduser -G ${appGroup} -D -u ${PUID} ${appUser}

# create dir to be mounted over by volume
RUN mkdir -p /share/config/sabnzbd && touch /share/config/sabnzbd/tag.txt

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /share

# make sure start.sh is executable
RUN chmod u+x  /start.sh

# switch to application directory
WORKDIR /sabnzbd

# switch to appUser
USER ${appUser}

# single mounted shared volume
VOLUME ["/share"]

# start application
CMD ["/start.sh"]
