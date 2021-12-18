FROM alpine as build

ARG  REPO=https://github.com/zedeus/nitter.git

RUN apk add --no-cache g++ curl tar xz nodejs

RUN  mkdir -p /nim;     curl -sL "https://nim-lang.org/download/nim-1.6.2.tar.xz"     |tar xJ --strip-components=1 -C /nim;     cd /nim; sh build.sh;     rm -r c_code tests;     ln -s `pwd`/bin/nim /bin/nim

RUN apk --no-cache add libsass-dev libffi-dev openssl-dev redis openssh-client git mercurial

RUN cd /nim; nim c koch; ./koch tools;    ln -s `pwd`/bin/nimble /bin/nimble;    ln -s `pwd`/bin/nimsuggest /bin/nimsuggest;    ln -s `pwd`/bin/testament /bin/testament
ENV PATH=~/.nimble/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /build
    
RUN set -ex \
&&  git clone $REPO . \
&&  nimble build -y -d:release --passC:"-flto" --passL:"-flto" \
&&  strip -s nitter \
&&  nimble scss

# ---------------------------------------------------------------------

FROM alpine:latest as bootstrap

ENV GOSU_VERSION 1.11
RUN set -eux; \
	\
	apk add --no-cache --virtual .gosu-deps \
		ca-certificates \
		dpkg \
		gnupg \
	; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
# clean up fetch dependencies
	apk del --no-network .gosu-deps; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu --version; \
	gosu nobody true

# ---------------------------------------------------------------------

FROM alpine:3.13

LABEL maintainer="ken@epenguin.com"

ENV  REDIS_HOST="localhost" \
     REDIS_PORT=6379 \
     NITTER_HOST="nitter.net" \
     NITTER_NAME="nitter" \
     NITTER_THEME="Nitter" \
     REPLACE_TWITTER="nitter.net" \
     REPLACE_YOUTUBE="invidio.us" \
     REPLACE_INSTAGRAM=""

COPY ./entrypoint.sh /entrypoint.sh
COPY ./nitter.conf.pre /dist/nitter.conf.pre

COPY --from=build /build/nitter /usr/local/bin
COPY --from=build /build/public /build/public
COPY --from=bootstrap /usr/local/bin/gosu /usr/bin/gosu

RUN set -eux \
&&  addgroup -g 82 www-data \
&&  adduser -u 82 -G www-data -h /data -D www-data \
&&  apk add --no-cache tini curl pcre

WORKDIR /data
VOLUME  /data

EXPOSE  8080

HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
