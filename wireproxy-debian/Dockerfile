FROM debian:latest
COPY --from=ghcr.io/pufferffish/wireproxy:latest /usr/bin/wireproxy /usr/bin/wireproxy
ENTRYPOINT [ "/usr/bin/wireproxy" ]
CMD [ "--config", "/etc/wireproxy/config" ]