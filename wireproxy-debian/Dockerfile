FROM ghcr.io/pufferffish/wireproxy:latest as build
FROM curlimages/curl:latest
COPY --from=build /usr/bin/wireproxy /usr/bin/wireproxy
ENTRYPOINT [ "/usr/bin/wireproxy" ]
CMD [ "--config", "/etc/wireproxy/config" ]