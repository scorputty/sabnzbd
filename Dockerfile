FROM alpine:latest
MAINTAINER scorputty
LABEL Description="SABnzbd" Vendor="Stef Corputty" Version="0.0.4"

# variables
ENV appUser="media"
ENV appGroup="media"
ENV PUID="10000"
ENV PGID="10000"

# git repository version
ARG GITTAG=1.1.0

# mounted volumes should be mapped to media files and config with the run command
VOLUME ["/config", "/media"]

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
       python \
       py-pip \
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
       pyopenssl && \

# get and build par2cmdline
 git clone --depth 1 https://github.com/Parchive/par2cmdline.git && \
 cd /par2cmdline && \
 aclocal && \
 automake --add-missing && \
 autoconf && \
 ./configure && \
 make && \
 make install && \
 cd / && \

# get and build yenc
 git clone --depth 1 --branch ${GITTAG} https://github.com/sabnzbd/sabnzbd.git && \
 hg clone https://bitbucket.org/dual75/yenc && \
 cd /yenc && \
 python setup.py build && \
 python setup.py install && \
 cd / && \

# cleanup
 cd / && \
 apk del --purge \
       build-dependencies && \
 rm -rf \
       /var/cache/apk/* \
       /par2cmdline \
       /yenc \
       /sabnzbd/.git \
       /tmp/*

# user with access to media files and config
RUN addgroup -g ${PGID} ${appGroup} && \
 adduser -G ${appGroup} -D -u ${PUID} ${appUser}

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /config /media

# switch to application directory
WORKDIR /sabnzbd

# switch to appUser
USER ${appUser}

# start application
CMD ["/start.sh"]
