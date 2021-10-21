FROM alpine:latest

LABEL maintainer "James Waters <james@jcwaters.co.uk>" 

RUN apk --no-cache --virtual deps add git && \
    case $(arch) in \
        x86_64|amd64) export ARCH=x86_64 ;; \
        i386) export ARCH=i386 ;; \
        armv6l|armv7l) export ARCH=armv6l ;; \
        aarch64) export ARCH=aarch64 ;; \
        esac && \
    git clone --depth 1 \
        https://github.com/50ButtonsEach/fliclib-linux-hci \
        /tmp/src && \
    cp /tmp/src/bin/${ARCH}/flicd /usr/bin/flicd && \
    chmod +x /usr/bin/flicd && \
    # Cleanup
    rm -rf /tmp/src && \
    apk del deps

COPY run.sh /run.sh

WORKDIR /data
VOLUME ["/data"]
EXPOSE 5551
ENTRYPOINT ["/run.sh"]
