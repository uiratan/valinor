#!/bin/bash

# Needed for all installers
print_msg "# Needed for all installers" 
print_msg "INSTALANDO: apt update" 
sudo apt update -y
print_msg "INSTALANDO: apt upgrade" 
sudo apt upgrade -y
print_msg "INSTALANDO: curl" 
sudo apt install -y curl
print_msg "INSTALANDO: git" 
sudo apt install -y git
print_msg "INSTALANDO: unzip" 
sudo apt install -y unzip

# Run terminal installers
for installer in ~/.local/share/valinor/install/terminal/*.sh; do source $installer; done


