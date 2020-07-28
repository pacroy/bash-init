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
name=$(whoami)
email=$(az account show --query "user.name" --output tsv)
echo "===== Git global configurations ====="
git config --global user.email $email
git config --global user.name $name
git config --global push.default simple
git config --global pull.rebase false
git config --global --list

if [ ! -e ~/clouddrive/alias.sh ]; then
    echo "Installing alias..."
    curl -sS https://raw.githubusercontent.com/pacroy/bash-alias/master/install_alias.sh | bash -
else
    echo "Updating alias..."
    update_alias
fi