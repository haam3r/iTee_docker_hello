#!/bin/bash
HOST="192.168.6.2"
FILE_PATH="/home/student/Dockerfile"
if ssh $HOST "[ -f $FILE_PATH ]"
then
    echo "File exists"
    # sed -i "s/check2.*$/check2: True/" ../web/index.html
    
else
    echo "File does not exist"
    sed -i "s/check2.*$/check2: False/" ../web/index.html
    exit 1
fi