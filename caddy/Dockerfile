ARG CADDY_VERSION=2.10.2

FROM caddy:$CADDY_VERSION-builder AS builder

COPY xcaddy-build.sh /usr/local/bin/xcaddy-build.sh
RUN sh /usr/local/bin/xcaddy-build.sh

FROM caddy:$CADDY_VERSION

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
