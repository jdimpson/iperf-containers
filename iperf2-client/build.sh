#!/bin/sh

IMAGE='jdimpson/iperf2-client';

if docker images | grep -q "$IMAGE"; then
        docker image rm "$IMAGE";
fi

docker build . -t "$IMAGE"
