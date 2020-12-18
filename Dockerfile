FROM 0x01be/base

ENV REVISION=master
RUN apk add --no-cache --virtual gds2pov-build-dependencies \
    git \
    build-base \
    cmake \
    libx11-dev \
    python3-dev \
    cairo-dev \
    mesa-dev \
    glu-dev \
    gtk+3.0-dev \
    gtk+2.0-dev &&\
    apk add --no-cache --virtual gds2pov-edge-build-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    wxgtk3-dev &&\
    git clone --depth 1 --branch ${REVISION} https://github.com/ralight/gds2pov.git /gds2pov

WORKDIR /gds2pov/build

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/gds2pov \
    -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config-gtk3 \
    .. &&\
    make

RUN make install

