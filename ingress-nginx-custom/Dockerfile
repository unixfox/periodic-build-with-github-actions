ARG INGRESS_NGINX_CONTROLLER_VERSION
ENV INGRESS_NGINX_CONTROLLER_VERSION=${INGRESS_NGINX_CONTROLLER_VERSION}

FROM registry.k8s.io/ingress-nginx/controller:${INGRESS_NGINX_CONTROLLER_VERSION}

USER root
RUN apk update \
  && apk add --no-cache \
    pcre2 \
  && rm -rf /var/cache/apk/*

USER www-data

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/nginx-ingress-controller"]
