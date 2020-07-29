#!/bin/bash
set -e

echo "Setting up directories..."
if [ ! -d ~/dev ]; then mkdir ~/dev; fi
if [ ! -d ~/bin ]; then mkdir ~/bin; fi

if [ ! -d ~/.ssh ] || [ ! -e ~/.ssh/id_rsa ] || [ ! -e ~/.ssh/id_rsa.pub ]; then
    echo "Generate SSH keypair..."
    if [ ! -d ~/.ssh ]; then mkdir ~/.ssh; fi
    ssh-keygen -t rsa -b 4096 -C "$(whoami)@cloudshell.$(hostname)" -f ~/.ssh/id_rsa -N ""
fi
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

echo "Setting git config..."
name=$(whoami)
email=$(az account show --query "user.name" --output tsv)
git config --global user.email $email
git config --global user.name $name
git config --global push.default simple
git config --global pull.rebase false

if [ -z $PACROY_ALIAS ]; then
    echo "Installing alias..."
    curl -sS https://raw.githubusercontent.com/pacroy/bash-alias/master/install_alias.sh | bash -
else
    echo "Updating alias..."
    update_alias
    # curl -sS https://raw.githubusercontent.com/pacroy/bash-alias/master/alias.sh -o ~/alias.sh
    # source ~/alias.sh
fi

echo "===== Git configurations ====="
git --version
git config --global --list
echo "===== Your SSH Public Key ====="
cat ~/.ssh/id_rsa.pub
echo "==============================="