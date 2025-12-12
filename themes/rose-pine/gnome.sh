#!/bin/bash

VALINOR_THEME_COLOR="red"
VALINOR_THEME_BACKGROUND="rose-pine/background.jpg"
source $VALINOR_PATH/themes/set-gnome-theme.sh
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
