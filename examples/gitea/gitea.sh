#!/bin/bash

docker run -d --link gitea-database -p 3000:3000 -p 22:3022 -v /root/examples/gitea/data:/data gitea/gitea
