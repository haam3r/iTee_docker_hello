#!/bin/bash
HOST="192.168.6.2"
FILE_PATH="/home/student/Dockerfile"
if ssh $HOST stat $FILE_PATH \> /dev/null 2\>\&1
then
    echo "File exists"
else
    echo "File does not exist"
fi