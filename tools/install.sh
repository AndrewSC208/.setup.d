#!/bin/bash

# install zsh
sudo apt install -y \
  zsh \
  curl \
  neovim \
  ca-certificats \
  gnupg \
  lsb-release

# install oh-my-zsh a plugin for zsh
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh

# install spacevim
curl -sLf https://spacevim.org/install.sh | bash

# add docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo apt-get update -y

# install docker
sudo apt-get install docker-ce-cli containerd.id -y

# install golang
sudo add-aptrepository ppa:longsleep/golang-backports
sudo appt update -y
sudo apt install golang-go

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


