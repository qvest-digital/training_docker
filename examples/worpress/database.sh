#!/bin/bash

docker run -d \
           -e MYSQL_ROOT_PASSWORD=supersicher \
           -e MYSQL_USER=wordpress \
           -e MYSQL_PASSWORD=wordpress \
           -e MYSQL_DATABASE=wordpress \
           -v /root/examples/wordpress/maria/data:/var/lib/mysql \
           --name wordpress-database \
           mariadb
