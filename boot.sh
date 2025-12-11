#!/bin/bash

set -e

ascii_art='
 █████   █████           ████   ███                               
░░███   ░░███           ░░███  ░░░                                
 ░███    ░███   ██████   ░███  ████  ████████    ██████  ████████ 
 ░███    ░███  ░░░░░███  ░███ ░░███ ░░███░░███  ███░░███░░███░░███
 ░░███   ███    ███████  ░███  ░███  ░███ ░███ ░███ ░███ ░███ ░░░ 
  ░░░█████░    ███░░███  ░███  ░███  ░███ ░███ ░███ ░███ ░███     
    ░░███     ░░████████ █████ █████ ████ █████░░██████  █████    
     ░░░       ░░░░░░░░ ░░░░░ ░░░░░ ░░░░ ░░░░░  ░░░░░░  ░░░░░      
     
'

echo -e "$ascii_art"
echo "=> Valinor is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

echo "apt-get update..."
sudo apt-get update >/dev/null
echo "Installing git..."
sudo apt-get install -y git >/dev/null

echo "Cloning Valinor..."
rm -rf ~/.local/share/valinor
git clone https://github.com/uiratan/valinor.git ~/.local/share/valinor >/dev/null

echo "Installation starting..."
source ~/.local/share/valinor/install.sh
