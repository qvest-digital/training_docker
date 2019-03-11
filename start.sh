#!/bin/bash

GATEWAY=$(docker network inspect bridge --format='{{json .IPAM.Config }}' | jq -r .[].Gateway)

export DOCKER_BRIDGE_GATEWAY=$GATEWAY

docker-compose build

docker-compose up -d --remove-orphans
