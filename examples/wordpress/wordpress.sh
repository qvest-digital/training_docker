#!/bin/bash

docker run -d --link=wordpress-database -p 8080:80 wordpress
