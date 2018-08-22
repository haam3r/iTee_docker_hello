#!/bin/bash

if ssh $HOST "docker container ls -f ancestor=nginx -q"
then
    echo "file is there"
else
    echo "nah"
fi