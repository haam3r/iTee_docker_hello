#!/bin/bash

# TODO
# Send results to NGINX server


# version="docker version --format '{{.Server.Version}}'"

output=$(ssh student@192.168.6.2 'apt-cache policy docker-ce')
# apt-cache policy docker-ce | grep https://download.docker.com | head -n 1

check_url=$(echo $output | grep -oq download.docker.com ; echo $?)
if [ $check_url -eq 0 ]
then
    installed_version=$(echo $output | grep -oP 'Installed:.+~ubuntu' | cut -d ":" -f 2 | cut -f 2 -d " ")
    candidate_version=$(echo $output | grep -oP 'Candidate:.+~ubuntu' | cut -d ":" -f 2 | cut -f 2 -d " ")
    if [ $installed_version = $candidate_version ]
    then
        true
    else
        echo "Installed does not equal candidate version"
        false
    fi
else
    echo "Docker is not installed from correct repository"
    false
fi


# echo $output | grep -oP 'Installed:.+~ubuntu' | cut -d ":" -f 2 | cut -f 2 -d " "