#!/bin/bash

# install neovim
sudo apt-get install neovim -y

# install spacevim
curl -sLf https://spacevim.org/install.sh | bash

# now replace the .Spacevim.d/init.toml file with your own settings
