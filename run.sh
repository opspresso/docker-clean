#!/bin/bash

CLEAN_PERIOD=${CLEAN_PERIOD:-600}

echo "started at $(date)"

echo "docker ps -a -f status=exited -f status=dead"
docker ps -a -f status=exited -f status=dead
docker ps -a -q -f status=exited -f status=dead | xargs --no-run-if-empty docker rm

echo "docker images -f dangling=true"
docker images -f dangling=true
docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

echo "docker volume ls -f dangling=true"
docker volume ls -f dangling=true
docker volume ls -q -f dangling=true | xargs --no-run-if-empty docker volume rmi

sleep ${CLEAN_PERIOD}
