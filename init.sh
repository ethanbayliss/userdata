#!/bin/bash
exec > >(tee /var/log/cloud-init-output.log | logger -t user-data -s 2>/dev/console) 2>&1

apt-get update 
apt-get install curl screen bash grep unzip -y

adduser --disabled-password --gecos "" ebayliss
usermod -aG sudo ebayliss
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

runuser -l ebayliss -c '\
mkdir ~/.ssh;\
chmod 700 ~/.ssh;\
curl https://github.com/ethanbayliss.keys -s | tee -a ~/.ssh/authorized_keys;\
chmod 644 ~/.ssh/authorized_keys'
