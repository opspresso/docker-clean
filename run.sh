#!/bin/bash

CLEAN_PERIOD=${CLEAN_PERIOD:-600}

while true; do
    echo
    echo "# started at $(date)"

    echo
    echo "$ docker ps -a -f status=exited -f status=dead"

    LIST="$(docker ps -a -q -f status=exited -f status=dead | xargs)"
    if [ "${LIST}" != "" ]; then
        docker rm ${LIST}
    fi

    echo
    echo "$ docker images -f dangling=true"

    LIST="$(docker images -q -f dangling=true | xargs)"
    if [ "${LIST}" != "" ]; then
        docker rmi ${LIST}
    fi

    echo
    echo "$ docker volume ls -f dangling=true"

    LIST="$(docker volume ls -q -f dangling=true | xargs)"
    if [ "${LIST}" != "" ]; then
        docker volume rm ${LIST}
    fi

    echo
    echo "# sleep ${CLEAN_PERIOD} sec.."
    sleep ${CLEAN_PERIOD}
done
