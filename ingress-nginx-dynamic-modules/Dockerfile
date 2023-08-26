ARG INGRESS_NGINX_CONTROLLER_VERSION
FROM registry.k8s.io/ingress-nginx/controller:${INGRESS_NGINX_CONTROLLER_VERSION} as build

ARG INGRESS_NGINX_CONTROLLER_VERSION
ENV INGRESS_NGINX_CONTROLLER_VERSION=${INGRESS_NGINX_CONTROLLER_VERSION}

USER root
RUN apk add \
        automake \
        ca-certificates \
        curl \
        gcc \
        g++ \
        make \
        pcre-dev \
        zlib-dev

RUN NGINX_VERSION=$(nginx -V 2>&1 |sed -n -e 's/nginx version: //p' |cut -d'/' -f2); \
    curl -L "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" | tar -C /tmp/nginx --strip-components=1 -xz

WORKDIR /src/echo-nginx-module
RUN curl -L https://github.com/openresty/echo-nginx-module/archive/refs/tags/v0.63.tar.gz | tar --strip-components=1 -xz

WORKDIR /tmp/nginx
RUN ./configure --with-compat --add-dynamic-module=/src/echo-nginx-module && \
    make modules

FROM registry.k8s.io/ingress-nginx/controller:${INGRESS_NGINX_CONTROLLER_VERSION}

COPY --from=build /tmp/nginx/objs/ngx_http_echo_module.so /etc/nginx/modules/