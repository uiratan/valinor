#!/usr/bin/env sh

print_msg "CONFIGURANDO: alacritty default terminal"

# Make alacritty default terminal emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
