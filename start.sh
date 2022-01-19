#!/bin/bash
docker build shells/shellinabox1 -t local/shellinabox

docker-compose up -d --remove-orphans
