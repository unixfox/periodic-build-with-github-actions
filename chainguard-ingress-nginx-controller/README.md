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
the standard controller image from `rootfs/Dockerfile`.

The nginx base image is **built here too**, from the fork's `images/nginx/rootfs`
(nginx 1.27.1 + the CVE backports in `patches/`), natively on amd64 and arm64
runners, and pushed to https://quay.io/unixfox/chainguard-ingress-nginx-base
(tag `<images/nginx/TAG>-<tree hash of images/nginx/rootfs>`). We do **not** use
the fork's `NGINX_BASE` file: it still points to the frozen upstream
`registry.k8s.io/ingress-nginx/nginx:v2.2.8`, which lacks those patches, and
chainguard only publishes its patched base in its paid catalog.

New tags are detected hourly by `.github/workflows/check-docker-updates.yml`, which
triggers this workflow when the fork publishes a new `controller-v*` tag. Bump/edit
this file to force a manual rebuild.

Published image tags:

- `latest`
- `<version>` (e.g. `v1.15.8`)
- `<version>-build-<YYYYMMDD>`
