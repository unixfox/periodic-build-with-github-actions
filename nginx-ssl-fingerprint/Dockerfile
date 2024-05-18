FROM ubuntu:24.04

ARG OPENSSL_VERSION=openssl-3.2
ARG NGINX_VERSION=release-1.25.5

WORKDIR /build

ADD patches/ /build/nginx-ssl-fingerprint/patches/
ADD src/ /build/nginx-ssl-fingerprint/src/
ADD config nginx.conf /build/nginx-ssl-fingerprint/

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y git make gcc curl zlib1g-dev libpcre3-dev && \
    git clone -b ${OPENSSL_VERSION} --depth=1 https://github.com/openssl/openssl && \
    git clone -b ${NGINX_VERSION} --depth=1 https://github.com/nginx/nginx && \
    patch -p1 -d openssl < nginx-ssl-fingerprint/patches/openssl.openssl-3.2.patch && \
    patch -p1 -d nginx < nginx-ssl-fingerprint/patches/nginx-1.25.patch && \
    cd nginx && \
    ASAN_OPTIONS=symbolize=1 ./auto/configure --with-openssl=$(pwd)/../openssl --add-module=$(pwd)/../nginx-ssl-fingerprint --with-http_ssl_module --with-stream_ssl_module --with-debug --with-stream --with-http_v2_module --with-cc-opt="-fsanitize=address -O -fno-omit-frame-pointer" --with-ld-opt="-L/usr/local/lib -Wl,-E -lasan" && \
    make && \
    make install -j`nproc` && \
    cd .. && \
    rm -Rf openssl nginx && \
    apt-get purge -y git make gcc curl zlib1g-dev libpcre3-dev && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 443 80

CMD ./nginx/objs/nginx -p /build -g 'daemon off;' -c /etc/nginx/nginx.conf
