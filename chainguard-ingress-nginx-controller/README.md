# chainguard-ingress-nginx-controller

Periodic rebuild of the [chainguard-forks/ingress-nginx](https://github.com/chainguard-forks/ingress-nginx)
controller image.

- **Source:** https://github.com/chainguard-forks/ingress-nginx
- **Published to:** https://quay.io/unixfox/chainguard-ingress-nginx-controller
- **Tag tracked:** latest `controller-v*` git tag of the fork
- **Platforms:** `linux/amd64`, `linux/arm64`

The workflow (`.github/workflows/docker-build-chainguard-ingress-nginx-controller.yml`)
checks out the fork at its newest `controller-v*` tag, compiles the controller
binaries with the fork's `make build` (for amd64 and arm64), then builds and pushes
the standard controller image from `rootfs/Dockerfile` using the base image pinned
in the fork's `NGINX_BASE` file — the same image chainguard builds.

New tags are detected hourly by `.github/workflows/check-docker-updates.yml`, which
triggers this workflow when the fork publishes a new `controller-v*` tag. Bump/edit
this file to force a manual rebuild.

Published image tags:

- `latest`
- `<version>` (e.g. `v1.15.8`)
- `<version>-build-<YYYYMMDD>`
