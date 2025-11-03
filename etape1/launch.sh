
#!/bin/bash

docker network rm tp3_net
docker network create tp3_net

docker stop http script
docker rm http script

docker run -d --name script --network tp3_net -v "$(pwd)/app:/app" php:8.2-fpm

docker run -d --name http --network tp3_net -p 8080:80 \
  -v "$(pwd)/app:/app:ro" \
  -v "$(pwd)/config/default.conf:/etc/nginx/conf.d/default.conf:ro" \
  nginx:stabledocker run -d --name http -p 8080:80 \
  --link script:php \
  -v "$PWD/app:/app:ro" \
  -v "$PWD/config/default.conf:/etc/nginx/conf.d/default.conf:ro" \
  nginx

docker run -d --name script php:8.2-fpm


