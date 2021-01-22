#!/bin/bash

# Docker intsall
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update && apt-cache policy docker-ce
sudo apt install -y docker-ce docker-compose unzip

# nano syntax highlight
git clone --single-branch --branch=v2.9 https://github.com/scopatz/nanorc.git ~/.nano
cat ~/.nano/nanorc >> ~/.nanorc
echo "include $install_path/*.nanorc" >> ~/.nanorc

sudo systemctl status docker
sudo usermod -aG docker $USER
su - $USER