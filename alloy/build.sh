#!/usr/bin/env sh
# Build Grafana Alloy from source for a single GOOS/GOARCH/GOARM target.
# Shared by .github/workflows/build-alloy.yml.
#
# Usage: ./alloy/build.sh <version-without-v> <output-path>
# e.g.: ./alloy/build.sh 1.18.1 build/linux/armv7/alloy
#
# Set GOOS/GOARCH/GOARM in the environment to select the target platform,
# e.g. GOOS=linux GOARCH=arm GOARM=7 for 32-bit ARMv7 (armhf).
set -eu

VERSION="$1"
OUTPUT="$2"

rm -rf /tmp/alloy-src
git clone --depth 1 --branch "v${VERSION}" https://github.com/grafana/alloy.git /tmp/alloy-src

cd /tmp/alloy-src/collector

CGO_ENABLED=0 go build \
  -trimpath \
  -ldflags="-s -w" \
  -o "$OLDPWD/$OUTPUT" .