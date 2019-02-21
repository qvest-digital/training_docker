#!/bin/bash

docker run -d \
--name=gitea-database \
-e POSTGRES_USER=gitea \
-e POSTGRES_PASSWORD=gitea \
-e POSTGRES_DB=gitea \
-v /root/examples/gitea/psql/data:/var/lib/postgresql/data \
postgres
