#!/bin/bash

# version="docker version --format '{{.Server.Version}}'"

output=$(ssh 192.168.6.2 'apt-cache policy docker-ce')
# apt-cache policy docker-ce | grep https://download.docker.com | head -n 1

check_url=$(echo $output | grep -oq download.docker.com ; echo $?)
if [ $check_url -eq 0 ]
then
    installed_version=$(echo $output | grep -oP 'Installed:.+~ubuntu' | cut -d ":" -f 2 | cut -f 2 -d " ")
    candidate_version=$(echo $output | grep -oP 'Candidate:.+~ubuntu' | cut -d ":" -f 2 | cut -f 2 -d " ")
    if [ $installed_version = $candidate_version ]
    then
        sed -i "s/check1.*$/check1: True/" ../web/index.html
    else
        echo "Installed does not equal candidate version"
        sed -i "s/check1.*$/check1: False/" ../web/index.html
        exit 1
    fi
else
    echo "Docker is not installed from correct repository"
    sed -i "s/check1.*$/check1: False/" ../web/index.html
    exit 1
fi


# echo $output | grep -oP 'Installed:.+~ubuntu' | cut -d ":" -f 2 | cut -f 2 -d " "