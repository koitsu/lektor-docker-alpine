FROM python:3.8.3-alpine3.12

ARG LEKTOR_VERSION=3.1.2
ARG LEKTOR_UID=1000
ARG LEKTOR_GID=1000

ENV PIP_NO_CACHE_DIR=1

RUN set -e -x \
&& addgroup -g $LEKTOR_UID -S lektor \
&& adduser -u $LEKTOR_GID -D -S -G lektor lektor \
&& apk update \
&& apk add build-base python3-dev libffi-dev openssl-dev bash curl git wget \
&& pip3 install lektor==$LEKTOR_VERSION \
&& apk del --purge build-base python3-dev libffi-dev openssl-dev \
&& rm -fr /var/cache/apk/*

USER lektor:lektor
WORKDIR /app
EXPOSE 5000
CMD ["lektor"]
