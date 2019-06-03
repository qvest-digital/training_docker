#!/bin/bash

echo Creating mongodb archive...
docker-compose -f rocket/docker-compose.yml exec mongo mongodump --db rocketchat --archive=/dev/stdout | bzip2 > mongobackup.archive.bz2

echo Creating rocket upload archive...
tar cvfj rocket_uploads_backup.tar.bz2 rocket/uploads/
