#!/bin/sh

IMAGE='jdimpson/iperf3-client';

if docker images | grep -q "$IMAGE"; then
        docker image rm "$IMAGE";
fi

docker build . -t "$IMAGE"
