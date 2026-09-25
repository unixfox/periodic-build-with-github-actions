# Grafana Alloy v1.20.0 Linux Binaries

Built on: 2026-09-25 13:41:40 UTC

Built from source with CGO_ENABLED=0, GOOS=linux, GOARCH=arm GOARM=7 (ARMv7 is not officially supported by Grafana).

## Available binaries:

-rw-r--r-- 1 runner runner   0 Sep 25 13:41 README.md
-rwxr-xr-x 1 runner runner 58M Sep 25 13:41 alloy-linux-armv7.xz
-rw-r--r-- 1 runner runner  93 Sep 25 13:41 alloy-linux-armv7.xz.sha256

## Installation on an ARMv7 (armhf) device:

```
cd /tmp
curl -LO https://raw.githubusercontent.com/unixfox/periodic-build-with-github-actions/dist/binaries/alloy/v1.20.0/alloy-linux-armv7.xz
echo "VERIFY CHECKSUM BELOW (compare to alloy-linux-armv7.xz.sha256):"
sha256sum alloy-linux-armv7.xz
xz -d alloy-linux-armv7.xz
chmod +x alloy-linux-armv7
sudo install -m 0755 alloy-linux-armv7 /usr/local/bin/alloy
alloy --version
```
