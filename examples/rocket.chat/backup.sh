#!/bin/bash

docker-compose -f rocket/docker-compose.yml exec mongo mongodump --db rocketchat --archive=/dev/stdout | bzip2 > mongobackup.archive.bz2
