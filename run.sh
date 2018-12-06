#!/bin/bash

CLEAN_PERIOD=${CLEAN_PERIOD:-600}

docker ps -a -q -f status=exited -f status=dead | xargs --no-run-if-empty docker rm
docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi
docker volume ls -q -f dangling=true | xargs --no-run-if-empty docker volume rmi

sleep ${CLEAN_PERIOD}
