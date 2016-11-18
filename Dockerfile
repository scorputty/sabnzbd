FROM alpine:latest
MAINTAINER scorputty
LABEL Description="SABnzbd" Vendor="Stef Corputty" Version="1.1.0"

# variables
ENV appUser="media"
ENV appGroup="1000"

# git repository version
ARG GITTAG=1.1.0

# mounted volumes should be mapped to media files and config with the run command
VOLUME ["/config", "/downloads", "/incomplete-downloads"]

# ports should be mapped with the run command to match your situation
EXPOSE 8080 9090

# copy the start script to the container
COPY start.sh /start.sh

# define build packages (these will be removed later)
ARG buildDeps="gcc g++ git mercurial make automake autoconf python-dev openssl-dev libffi-dev musl-dev"

# start building the software tree
RUN apk --update add $buildDeps \
  && apk add \
    python \
    py-pip \
    ffmpeg-libs \
    ffmpeg \
    unrar \
    openssl \
    ca-certificates \
    p7zip \
  && pip install --upgrade pip --no-cache-dir \
  && pip install pyopenssl cheetah --no-cache-dir \

  # get and build par2cmdline
  && git clone --depth 1 https://github.com/Parchive/par2cmdline.git \
  && cd /par2cmdline \
  && aclocal \
  && automake --add-missing \
  && autoconf \
  && ./configure \
  && make \
  && make install \
  && cd / \

  # get and build yenc
  && git clone --depth 1 --branch ${GITTAG} https://github.com/sabnzbd/sabnzbd.git \
  && hg clone https://bitbucket.org/dual75/yenc \
  && cd /yenc \
  && python setup.py build \
  && python setup.py install \
  && cd / \

  # cleanup
  && apk del $buildDeps \
  && rm -rf \
    /var/cache/apk/* \
    /par2cmdline \
    /yenc \
    /sabnzbd/.git \
    /tmp/*

# user with access to media files and config
RUN adduser -D -u ${appGroup} ${appUser}

# switch to application directory
WORKDIR /sabnzbd

# switch to appUser
USER ${appUser}

# start application
CMD ["/start.sh"]
