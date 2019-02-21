#!/bin/bash

if [ "$1" == "-d" ]; then
  ARGS="-d"
else
  ARGS=""
fi

docker run $ARGS --link=wordpress-database -p 8080:80 wordpress
