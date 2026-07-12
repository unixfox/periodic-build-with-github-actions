#!/usr/bin/env sh
# Single source of truth for the xcaddy build arguments (plugins + module
# replacements) shared by the Docker image (caddy/Dockerfile) and the release
# binaries workflow (.github/workflows/docker-build-caddy.yml).
#
# Any extra arguments are passed through to `xcaddy build`, e.g. the caddy
# version (positional, only used by the workflow) and `--output <path>`.
set -eu

exec xcaddy build "$@" \
  --with github.com/caddy-dns/powerdns \
  --with github.com/pteich/caddy-tlsconsul \
  --with github.com/mholt/caddy-l4=github.com/tannevaled/caddy-l4@feat/dynamic-srv-upstreams \
  --with github.com/lixmal/caddy-netbird=github.com/unixfox/caddy-netbird@add-dns-labels-option \
  --with github.com/mholt/caddy-ratelimit \
  --replace github.com/cloudflare/circl=codeberg.org/cunicu/circl@v0.0.0-20230801113412-fec58fc7b5f6 \
  --replace github.com/dexidp/dex=github.com/netbirdio/dex@v0.244.1-0.20260512110716-8d70ad8647c1 \
  --replace github.com/dexidp/dex/api/v2=github.com/netbirdio/dex/api/v2@v2.0.0-20260512110716-8d70ad8647c1 \
  --replace github.com/getlantern/systray=github.com/netbirdio/systray@v0.0.0-20231030152038-ef1ed2a27949 \
  --replace github.com/kardianos/service=github.com/netbirdio/service@v0.0.0-20240911161631-f62744f42502 \
  --replace github.com/mailru/easyjson=github.com/netbirdio/easyjson@v0.9.0 \
  --replace github.com/pion/ice/v4=github.com/netbirdio/ice/v4@v4.0.0-20250908184934-6202be846b51 \
  --replace golang.zx2c4.com/wireguard=github.com/netbirdio/wireguard-go@v0.0.0-20260523085312-4b4a4e36017f
