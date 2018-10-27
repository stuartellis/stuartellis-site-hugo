FROM alpine:3.8

## Image metadata ##

LABEL maintainer="stuart@stuartellis.name" \
     version="0.1.0" \
    description="Hugo ToolBox"

ENV HUGO_VERSION 0.49.2
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

## Install Hugo ##

RUN set -x && \
  apk add --update wget ca-certificates && \
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  rm -r ${HUGO_BINARY} && \
  mv hugo /usr/bin && \
  apk del wget ca-certificates && \
  rm /var/cache/apk/*

## Import source files ##

COPY ./ /site
WORKDIR /site

## Run Hugo ##

RUN /usr/bin/hugo