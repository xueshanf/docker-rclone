FROM alpine:3.6 as downloader
ENV RCLONE_RELEASE="rclone-v1.37-linux-amd64.zip"
RUN apk update && apk add --no-cache curl unzip;
RUN curl -s -O https://downloads.rclone.org/${RCLONE_RELEASE} \
    && unzip ${RCLONE_RELEASE}

FROM alpine:3.6
MAINTAINER xueshan.feng@gmail.com
COPY --from=downloader /rclone-v*-linux-amd64/rclone /usr/sbin
RUN chown root:root /usr/sbin/rclone && chmod 755 /usr/sbin/rclone
RUN apk add --update --no-cache ca-certificates \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["rclone"]
