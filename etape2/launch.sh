#!/bin/bash

docker network rm tp3_net
docker network create tp3_net

docker stop http script data
docker rm http script data

docker run -d --name data --network tp3_net \
  -e MARIADB_ROOT_PASSWORD=rootpwd \
  -e MARIADB_DATABASE=tp3 \
  -e MARIADB_USER=tp3 \
  -e MARIADB_PASSWORD=tp3pwd mariadb:10.11

docker build -t php-script:tp3 -f Dockerfile .

docker run -d --name script --network tp3_net -v "$(pwd)/app:/app" php-script:tp3

docker run -d --name http --network tp3_net -p 8080:80 \
  -v "$(pwd)/app:/app:ro" \
  -v "$(pwd)/config/default.conf:/etc/nginx/conf.d/default.conf:ro" \
  nginx:stable
