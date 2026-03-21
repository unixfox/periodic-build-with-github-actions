# Patches

These patches are applied on top of the upstream Nitter codebase during the build process.

## 0001 - CDN + HMAC Support

**File:** `0001-cdn-hmac-support.patch`
**Files modified:** 8 (`nitter.example.conf`, `src/config.nim`, `src/nitter.nim`, `src/routes/media.nim`, `src/types.nim`, `src/utils.nim`, `src/views/general.nim`, `src/views/rss.nimf`)

Adds CDN URL support and HMAC signature verification for media URLs.

- Introduces a `cdnUrl` config option (default: `https://cdn.xcancel.com`) to serve media (pictures and videos) through a CDN.
- Adds HMAC signature verification on `/pic/` and `/pic/orig/` routes, returning HTTP 403 if the signature doesn't match. The HMAC is time-rotating (based on current year + month + day).
- All generated media URLs (`getPicUrl`, `getOrigPicUrl`, `getVidUrl`) now include the HMAC signature in the path and are prefixed with the CDN URL (except m3u8/HLS streams which stay local).
- Removes redundant `getUrlPrefix(cfg)` prepending in views since the CDN URL is now baked into the URL generation functions.

## 0002 - Proxy Pictures Support

**File:** `0002-proxy-pictures-support.patch`
**Files modified:** 15 (`nitter.example.conf`, `public/js/proxyneededcheck.js`, `src/parser.nim`, `src/prefs_impl.nim`, `src/routes/list.nim`, `src/routes/router_utils.nim`, `src/routes/status.nim`, `src/utils.nim`, `src/views/general.nim`, `src/views/list.nim`, `src/views/profile.nim`, `src/views/renderutils.nim`, `src/views/rss.nimf`, `src/views/timeline.nim`, `src/views/tweet.nim`)

Adds a user preference to toggle picture proxying, allowing images to be served directly from `pbs.twimg.com` instead of through the Nitter server/CDN.

- Adds a `proxyPics` checkbox preference (default: on) under user settings.
- When `proxyPics` is off, `getPicUrl` and `getOrigPicUrl` return direct `https://pbs.twimg.com/...` URLs instead of proxied/CDN URLs.
- Adds `public/js/proxyneededcheck.js`: a client-side script that auto-detects if `pbs.twimg.com` is blocked by trying to load its favicon. If blocked, it sets `proxyPics=on` and `proxyVideos=on` cookies and reloads.
- Changes cookie `httpOnly` from `true` to `false` so the JS detection script can read preference cookies.
- RSS feeds always use `proxyPics=false` (direct Twitter URLs).
- Threads `proxyPics` parameter through all view rendering functions (`genImg`, `getSmallPic`, `renderAlbum`, `renderCardImage`, `renderBanner`, `renderPhotoRail`, `renderList`, etc.).

## 0003 - Add X-Cache Header

**File:** `0003-add-x-cache-header.patch`
**Files modified:** 1 (`src/routes/rss.nim`)

Adds an `X-Cache` response header to RSS feed responses indicating whether the response was served from cache.

- Modifies the `respRss` template to accept a `cached` boolean parameter (default: `false`).
- Adds `"X-Cache": $cached` to RSS response headers.
- All cache-hit paths (`getCachedRss` returning a result) pass `cached=true`; fresh fetches use the default `false`.

## 0004 - Custom Donation Page

**File:** `0004-custom-donation-page.patch`
**Files modified:** 2 (`public/md/about.md`, `src/views/general.nim`)

Customizes the about/donation page for the XCancel instance.

- Adds "XCancel is an instance of Nitter." to the about page header.
- Adds an XCancel-specific donation section with Liberapay, Ko-fi, and various cryptocurrency addresses (BTC, ETH, XMR, Nano, Stellar, Doge, Dash, Decred, BNB, LTC, USDC).
- Separates donations into "Donating to XCancel" and "Donating to the Nitter project" sections.
- Adds a "(donate)" link next to the site name in the navbar.
- Changes the Liberapay link in the navbar from `zedeus` (Nitter author) to `yewtube` (XCancel operator).
