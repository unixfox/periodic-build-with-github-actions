FROM ghcr.io/maxisoft/nim-docker-images/nim as build

ARG  REPO=https://github.com/zedeus/nitter.git

RUN apk update \
&&  apk add libsass-dev \
        libffi-dev \
	openssl-dev \
	unzip \
	git \
&&  mkdir -p /build

WORKDIR /build
    
RUN set -ex \
&&  git clone $REPO . \
&&  nimble build -y -d:release --passC:"-flto" --passL:"-flto" \
&&  strip -s nitter \
&&  nimble scss \
&&  nimble md

# ---------------------------------------------------------------------

FROM alpine:3.13

LABEL maintainer="ken@epenguin.com"

ENV  REDIS_HOST="localhost" \
     REDIS_PORT=6379 \
	 NITTER_HTTPS="false" \
     NITTER_HOST="nitter.net" \
     NITTER_NAME="nitter" \
     NITTER_THEME="Nitter" \
     REPLACE_TWITTER="nitter.net" \
     REPLACE_YOUTUBE="invidio.us" \
	 REPLACE_REDDIT="teddit.net" \
     REPLACE_INSTAGRAM=""

COPY ./nitter-git/entrypoint.sh /entrypoint.sh
COPY ./nitter-git/nitter.conf.pre /dist/nitter.conf.pre

COPY --from=build /build/nitter /usr/local/bin
COPY --from=build /build/public /build/public
COPY --from=bootstrap /usr/local/bin/gosu /usr/bin/gosu

RUN set -eux \
&&  addgroup -g 82 www-data \
&&  adduser -u 82 -G www-data -h /data -D www-data \
&&  apk add --no-cache tini curl pcre su-exec

WORKDIR /data
VOLUME  /data

EXPOSE  8080

HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
