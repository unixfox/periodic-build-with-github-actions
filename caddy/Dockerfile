ARG CADDY_VERSION=2.10.0

FROM caddy:$CADDY_VERSION-builder AS builder

RUN xcaddy build \
    --with github.com/tailscale/caddy-tailscale \
    --with github.com/caddy-dns/powerdns

FROM caddy:$CADDY_VERSION

COPY --from=builder /usr/bin/caddy /usr/bin/caddy