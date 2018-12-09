#!/bin/sh

PROJECT_NAME=`basename ${PWD}`
BUILDER_IMAGE_VERSION=`cat ./Dockerfile | grep "version" | grep -oe "[0-9]\+[.][0-9]\+[.][0-9]\+"`
BUILDER_IMAGE_ID="$PROJECT_NAME-builder:$BUILDER_IMAGE_VERSION"

case $1 in
  clean)
    if [ -d public ]; then rm -r public; fi
    ;;
  deploy)
    docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" $BUILDER_IMAGE_ID /var/local/deploy.sh
    ;;
  info)
    echo "Project name: ${PROJECT_NAME}"
    echo "Docker builder image version: ${BUILDER_IMAGE_VERSION}"
    ;;
  serve)
    docker run --rm -p 1313:1313 --mount "type=bind,source=${PWD},destination=/var/local" $BUILDER_IMAGE_ID
    ;;
  setup)
    docker build . -t $BUILDER_IMAGE_ID
    ;;
  shell)
    docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" $BUILDER_IMAGE_ID /bin/sh
    ;;
  *)
    echo "$1 is not a valid command"
    ;;
esac

