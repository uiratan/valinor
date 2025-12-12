#!/bin/bash

print_msg "INSTALANDO: zellij" 

cd /tmp
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf zellij.tar.gz zellij
sudo install zellij /usr/local/bin
rm zellij.tar.gz zellij
cd -

mkdir -p ~/.config/zellij/themes
#[ ! -f "$HOME/.config/zellij/config.kdl" ] && cp ~/.local/share/valinor/configs/zellij.kdl ~/.config/zellij/config.kdl
cp ~/.local/share/valinor/themes/tokyo-night/zellij.kdl ~/.config/zellij/themes/tokyo-night.kdl
