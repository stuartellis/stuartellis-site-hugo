#!/bin/bash

mkdir src
cd src || exit 1
git clone https://github.com/gohugoio/hugo.git
cd hugo || exit 1
go install --tags extended
