FROM python:3.8.3-alpine3.12

RUN set -e -x \
&& addgroup -g 1000 -S lektor \
&& adduser -u 1000 -D -S -G lektor lektor \
&& apk update \
&& apk add bash curl git wget \
&& apk add --virtual build-deps build-base python3-dev libffi-dev openssl-dev \
&& PIP_NO_CACHE_DIR=1 pip3 install lektor==3.1.2 \
&& apk del --purge build-deps \
&& rm -fr /var/cache/apk/*

USER lektor:lektor
WORKDIR /app
EXPOSE 5000
CMD ["lektor"]
