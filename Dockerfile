FROM 0x01be/gds2pov:build as build

FROM 0x01be/xpra

COPY --from=build /opt/gds2pov/ /opt/gds2pov/

RUN apk add --no-cache --virtual gds2pov-runtime-dependencies \
    libx11 \
    python3 \
    cairo \
    mesa \
    glu \
    gtk+3.0 \
    gtk+2.0 &&\
    apk add --no-cache --virtual gds2pov-edge-runtime-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    wxgtk3

USER ${USER}
ENV PATH=${PATH}:/opt/gds2pov/bin \
    LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gds2pov/lib \
    COMMAND=gds2pov

