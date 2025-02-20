FROM ghcr.io/whyvl/wireproxy:latest as build
FROM debian:latest
RUN apt-get update && apt-get install -y --no-install-recommends \
  && apt-get install -y jq curl \
  && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/bin/wireproxy /usr/bin/wireproxy
ENTRYPOINT [ "/usr/bin/wireproxy" ]
CMD [ "--config", "/etc/wireproxy/config" ]
