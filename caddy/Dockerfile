FROM caddy:latest

# Reuse the caddy binary already built earlier in the workflow
# (.github/workflows/docker-build-caddy.yml) instead of rebuilding it with
# xcaddy. TARGETARCH is set automatically by buildx for each target platform
# and matches the build/linux/<arch> layout produced by the build steps.
ARG TARGETARCH
COPY build/linux/$TARGETARCH/caddy /usr/bin/caddy
