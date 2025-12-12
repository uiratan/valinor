#!/bin/bash

print_msg "CONFIGURING: xcompose"

envsubst < ~/.local/share/valinor/configs/xcompose > ~/.XCompose
ibus restart
gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']"
