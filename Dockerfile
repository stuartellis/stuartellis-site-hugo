FROM alpine:3.8

## Image metadata ##

LABEL maintainer="stuart@stuartellis.name" \
     version="0.3.0" \
    description="Hugo ToolBox"

ENV S3DEPLOY_VERSION 2.2.0
ENV S3DEPLOY_BINARY s3deploy_${S3DEPLOY_VERSION}_Linux-64bit.tar.gz

ENV HUGO_VERSION 0.51
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN apk add --update wget ca-certificates && \
  rm /var/cache/apk/*

## Install s3deploy ##

RUN wget https://github.com/bep/s3deploy/releases/download/v${S3DEPLOY_VERSION}/${S3DEPLOY_BINARY} && \
  tar xzf ${S3DEPLOY_BINARY} && \
  rm -r ${S3DEPLOY_BINARY} && \
  mv s3deploy /usr/local/bin

## Install Hugo ##

RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  rm -r ${HUGO_BINARY} && \
  mv hugo /usr/local/bin


## Run Hugo server ##
WORKDIR /var/local
EXPOSE 1313
CMD [ "hugo", "server", "--bind=0.0.0.0" ] 
