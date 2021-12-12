#!/bin/sh

if [[ -e $1/$2.cfg ]]; then
  docker buildx build $1 -t frogging-build/$1:latest --build-arg BUILD_CONFIG=$2.cfg
fi

docker buildx build $1 -t frogging-build/$1:latest

docker create --name frogging-$1 frogging-build/$1:latest

docker cp frogging-$1:/dist .

docker rm -f frogging-$1
