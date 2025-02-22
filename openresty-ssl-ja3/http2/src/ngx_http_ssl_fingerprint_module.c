
#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>

#include <nginx_ssl_fingerprint.h>

static ngx_int_t ngx_http_http2_fingerprint(ngx_http_request_t *r,
                            ngx_http_variable_value_t *v, uintptr_t data);

static ngx_http_variable_t ngx_http_ssl_fingerprint_variables_list[] = {
    {ngx_string("http2_fingerprint"), NULL, ngx_http_http2_fingerprint,
     0, NGX_HTTP_VAR_NOCACHEABLE, 0},
    ngx_http_null_variable
};

static ngx_int_t
ngx_http_http2_fingerprint(ngx_http_request_t *r,
                 ngx_http_variable_value_t *v, uintptr_t data)
{
    /* For access.log's map $VAR {}:
     * if it's not found, then user could add a defined string */
    v->not_found = 1;

    if (r->stream == NULL) {
        return NGX_OK;
    }

    if (ngx_http2_fingerprint(r->connection, r->stream->connection)
            != NGX_OK)
    {
        return NGX_ERROR;
    }

    v->data = r->stream->connection->fp_str.data;
    v->len = r->stream->connection->fp_str.len;
    v->not_found = 0;

    return NGX_OK;
}
