#!/bin/bash
HOST="192.168.6.2"
FILE_PATH="/home/student/Dockerfile"
if ssh $HOST "[ -f $FILE_PATH ]"
then
    echo "File exists"
    OUTPUT=$(ssh $HOST cat $FILE_PATH)
    if echo $OUTPUT | grep "FROM" | grep "MAINTAINER" | grep "RUN apt" | grep "update" | grep "nginx" -oq
    then
        echo "Dockerfile seems valid"
        sed -i "s/check2.*$/check2: True/" ../web/index.html
    else
        echo "Dockerfile is missing some info"
        sed -i "s/check2.*$/check2: False/" ../web/index.html
        exit 1
    fi
else
    echo "File does not exist"
    sed -i "s/check2.*$/check2: False/" ../web/index.html
    exit 1
fi