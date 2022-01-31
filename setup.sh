#!/bin/bash

echo "#### Enter Username of remote system: "
read user_name
if [ -z "$user_name" ]
then
  echo "#### Invalid user name"
  exit 1
fi

# echo "#### Enter Password for user of remote system: "
# read password
# if [ -z "$password" ]
# then
#   echo "#### Password is invalid"
#   exit 1
# fi

echo "#### Enter target domain, or ip address: "
read target
if [ -z "$target" ]
then
  echo "#### Invalid target address"
  exit 1
fi

mkdir .ssh
pub_key=$PWD/.ssh/id_rsa.pub
key=$PWD/.ssh/id_rsa
user_at_target=${user_name}@${target}

echo "######## VARIABLES ########"
echo "####      user_name: ${user_name}"
echo "####         target: ${target}"
echo "####        pub_key: ${pub_key}"
echo "####            key: ${key}"
echo "#### user_at_target: ${user_at_target}"
echo "###########################"
echo " "

# generate a local ssh key
ssh-keygen -q -t rsa -N '' -b 4096 -C "meilingandrew@gmail.com" -f ${key} <<< y

echo " "
echo "#### key generated, now changing ownership"
chmod 600 ${pub_key}
chmod 600 ${key}
echo "#### key ownership, changed"

# this will prompt for remote server password
echo "#### copy ssh key to the remote server"
echo "#### NOTE: this will prompt for the remote servers password"
ssh-copy-id -i ${key} ${user_at_target}
echo " "

echo "#### tar, and gz tools directory"
tar -zcvf tools.tar.gz ./tools/

echo "#### upload files, using ssh keys"
scp -i ${key} $PWD/tools.tar.gz ${user_at_target}:/home/${user_name}

echo "#### test key copy"
ssh -i ${key} -t ${user_at_target} mkdir .setup.d

echo "#### expand payload onto system"
ssh -i ${key} -t ${user_at_target} tar -xzvf tools.tar.gz -C .setup.d

echo "#### run installation script"
ssh -i ${key} -t ${user_at_target} .setup.d/tools/install.sh

echo "#### update spacevim configuration with my custom settings"
ssh -i ${key} -t ${user_at_target} mv .setup.d/tools/custom_spacevim_config.toml .SpaceVim.d/init.toml

echo "#### update .zshrc file wiht my custom settings"
ssh -i ${key} -t ${user_at_target} mv .setup.d/tools/.zshrc .zshrc

ssh -i ${key} -t ${user_at_target} mkdir Projects

echo "### clean up remote files"
ssh -i ${key} -t ${user_at_target} rm -rf .setup.d tools.tar.gz

echo "### cleanup local files"
rm -rf tools.tar.gz ${pub_key} ${key}

