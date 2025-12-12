#!/bin/bash

print_msg "CONFIGURANDO: shell" 

# Configure the bash shell using Valinor defaults
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/valinor/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/valinor/defaults/bash/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Valinor defaults
cp ~/.local/share/valinor/configs/inputrc ~/.inputrc
