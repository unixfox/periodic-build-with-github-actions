#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>
#include <ngx_log.h>
#include <ngx_http_v2.h>

/**
 * Params:
 *      c and h2c should be a valid pointers
 *
 * Returns:
 *      NGX_OK -- h2c->fp_str is set
 *      NGX_ERROR -- something went wrong
 */
int ngx_http2_fingerprint(ngx_connection_t *c, ngx_http_v2_connection_t *h2c)
{
    unsigned char *pstr = NULL;
    unsigned short n = 0;
    size_t i;

    if (h2c->fp_str.len > 0) {
        return NGX_OK;
    }

    n = 4 + h2c->fp_settings.len * 3
        + 10 + h2c->fp_priorities.len * 2
        + h2c->fp_pseudoheaders.len * 2;

    h2c->fp_str.data = ngx_pnalloc(c->pool, n);
    if (h2c->fp_str.data == NULL) {
        /** Else we break a stream */
        return NGX_ERROR;
    }
    pstr = h2c->fp_str.data;

    ngx_log_debug(NGX_LOG_DEBUG_EVENT, c->log, 0, "ngx_http2_fingerprint: alloc bytes: [%d]\n", n);

    /* setting */
    for (i = 0; i < h2c->fp_settings.len; i+=5) {
        pstr = append_uint8(pstr, h2c->fp_settings.data[i]);
        *pstr++ = ':';
        pstr = append_uint32(pstr, *(uint32_t*)(h2c->fp_settings.data+i+1));
        *pstr++ = ';';
    }
    *(pstr-1) = '|';

    /* windows update */
    pstr = append_uint32(pstr, h2c->fp_windowupdate);
    *pstr++ = '|';

    /* priorities */
    for (i = 0; i < h2c->fp_priorities.len; i+=4) {
        pstr = append_uint8(pstr, h2c->fp_priorities.data[i]);
        *pstr++ = ':';
        pstr = append_uint8(pstr, h2c->fp_priorities.data[i+1]);
        *pstr++ = ':';
        pstr = append_uint8(pstr, h2c->fp_priorities.data[i+2]);
        *pstr++ = ':';
        pstr = append_uint16(pstr, (uint16_t)h2c->fp_priorities.data[i+3]+1);
        *pstr++ = ',';
    }
    *(pstr-1) = '|';

    /* fp_pseudoheaders */
    for (i = 0; i < h2c->fp_pseudoheaders.len; i++) {
        *pstr++ = h2c->fp_pseudoheaders.data[i];
        *pstr++ = ',';
    }

    /* null terminator */
    *--pstr = 0;

    h2c->fp_str.len = pstr - h2c->fp_str.data;

    h2c->fp_fingerprinted = 1;

    ngx_log_debug(NGX_LOG_DEBUG_EVENT, c->log, 0, "ngx_http2_fingerprint: http2 fingerprint: [%V], len=[%d]\n", &h2c->fp_str, h2c->fp_str.len);

    return NGX_OK;
}