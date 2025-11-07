ARG CADDY_VERSION=2.10.2

FROM caddy:$CADDY_VERSION-builder AS builder

RUN xcaddy build \
    --with github.com/tailscale/caddy-tailscale \
    --with github.com/victories/powerdns@latest \
    --with github.com/pteich/caddy-tlsconsul \
    --with github.com/mholt/caddy-l4

FROM caddy:$CADDY_VERSION

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
