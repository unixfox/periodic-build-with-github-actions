Using patches from https://github.com/fooinha/nginx-ssl-ja3 for ja3 fingerprint

And using a custom patch for HTTP2 fingerprint from this repo: https://github.com/phuslu/nginx-ssl-fingerprint and specifically extracted from this file: https://github.com/phuslu/nginx-ssl-fingerprint/blob/master/src/ngx_http_ssl_fingerprint_module.c

And using custom Dockerfile based on https://github.com/openresty/docker-openresty/tree/master/alpine