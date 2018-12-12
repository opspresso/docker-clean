#!/bin/bash

CLEAN_PERIOD=${CLEAN_PERIOD:-600}

while true; do
    echo
    echo "# started at $(date)"

    echo
    echo "$ docker ps -a -f status=exited -f status=dead"
    docker ps -a -f status=exited -f status=dead
    docker ps -a -q -f status=exited -f status=dead | xargs --no-run-if-empty docker rm

    echo
    echo "$ docker images -f dangling=true"
    docker images -f dangling=true
    docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

    echo
    echo "$ docker volume ls -f dangling=true"
    docker volume ls -f dangling=true
    docker volume ls -q -f dangling=true | xargs --no-run-if-empty docker volume rmi

    sleep ${CLEAN_PERIOD}
done
