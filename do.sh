#!/bin/sh

case $1 in
  clean)
    if [ -d public ]; then rm -r public; fi
    ;;
  deploy)
    docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" hugo-toolbox /var/local/deploy.sh
    ;;
  serve)
    docker run --rm -p 1313:1313 --mount "type=bind,source=${PWD},destination=/var/local" hugo-toolbox
    ;;
  setup)
    docker build .
    ;;
  shell)
    docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" hugo-toolbox /bin/sh
    ;;
  *)
    echo "$1 is not a valid command"
    ;;
esac
