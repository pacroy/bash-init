#!/bin/bash
set -e

echo "Creating directories..."
if [ ! -d ~/clouddrive/dev ]; then mkdir ~/clouddrive/dev; fi
ln -sf /usr/csuser/clouddrive/dev ~/dev
if [ ! -d ~/clouddrive/bin ]; then mkdir ~/clouddrive/bin; fi
ln -sf /usr/csuser/clouddrive/bin ~/bin

if [ ! -d ~/clouddrive/.ssh ] || [ ! -e ~/clouddrive/.ssh/id_rsa ] || [ ! -e ~/clouddrive/.ssh/id_rsa.pub ]; then
    echo "Generate SSH keypair..."
    if [ ! -d ~/clouddrive/.ssh ]; then mkdir ~/clouddrive/.ssh; fi
    ssh-keygen -t rsa -b 4096 -C "$(whoami)@cloudshell.$(hostname)" -f ~/clouddrive/.ssh/id_rsa -N ""
fi
echo "Copying SSH keypair..."
cp --recursive --update --force ~/clouddrive/.ssh ~/
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

echo "Setting git config..."
git --version
while [ -z $name ]; do read -p "Your name: " name; done
while [ -z $email ]; do read -p "Your email: " email; done
git config --global user.email $email
git config --global user.name $name
git config --global push.default simple
git config --global pull.rebase false
git config --global --list