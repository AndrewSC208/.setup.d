#!/bin/bash

# update local system
sudo apt-get update

# install deps
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# add gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# update system again
sudo apt-get update

# install docker, and it's tools
sudo apt-get install docker-ce-cli containerd.io
