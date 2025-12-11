#!/bin/bash

set -e

# Cores (funcionam até se o terminal não suportar)
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
ORANGE="$(tput setaf 9)"
BRIGHT_WHITE="$(tput setaf 15)"   # ou setaf 9 em alguns terminais

print_msg() {
    echo "${ORANGE}${BOLD}$1${RESET}"
}

print_msg "INICIANDO: boot.sh"

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
#sudo apt-get update >/dev/null
echo "Installing git..."
#sudo apt-get install -y git >/dev/null

echo "Cloning Valinor..."
rm -rf ~/.local/share/valinor
rsync -av --exclude='.git' --exclude='ascii.sh' /home/uira/git/linux/valinor/ ~/.local/share/valinor
#git clone https://github.com/uiratan/valinor.git ~/.local/share/valinor >/dev/null

echo "Installation starting..."
source ~/.local/share/valinor/install.sh

print_msg "FIM: boot.sh"
