FROM golang:1.15 as builder

WORKDIR /app 

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" .

FROM        alpine:3.12

LABEL       maintainer="Mittwald CM Service <https://github.com/mittwald>"

ENV         BRUDI_USER="brudi" \
            BRUDI_GID="1000" \
            BRUDI_UID="1000"

COPY        --from=builder /app/brudi /usr/local/bin/brudi

COPY        --from=rclone/rclone:1.57 /usr/local/bin/rclone /usr/bin/rclone
COPY        --from=restic/restic:0.11.0 /usr/bin/restic /usr/local/bin/restic
COPY        --from=redis:alpine /usr/local/bin/redis-cli /usr/local/bin/redis-cli

RUN         apk add --no-cache --upgrade \
                mongodb-tools \
                mysql-client \
                postgresql-client \
            && \
            addgroup \
                -S "${BRUDI_USER}" \
                -g "${BRUDI_GID}" \
            && \
            adduser \
                -u "${BRUDI_UID}" \
                -S \
                -G "${BRUDI_USER}" \
                "${BRUDI_USER}"

USER        ${BRUDI_USER}

ENTRYPOINT  ["brudi"]