#!/bin/bash

# install zsh
sudo apt install \
  zsh \
  curl \
  neovim \
  ca-certificates \
  gnupg \
  lsb-release \
  build-essential \
  apt-transport-https

sudo apt-get update

# install oh-my-zsh a plugin for zsh
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# install spacevim
curl -sLf https://spacevim.org/install.sh | bash

# add docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo apt-get update -y

# install docker
sudo apt-get install docker-ce-cli containerd.id -y

# install golang
# download go
wget https://go.dev/dl/go1.17.6.linux-amd64.tar.gz
# remove old versions of go
sudo rm -rf /usr/local/go
# untar
sudo tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz
rm go.1.17.6-linux-amd64.tar.gz

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install kubctl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
