#!/bin/bash

cat <<EOF >~/.local/share/applications/Valinor.desktop
[Desktop Entry]
Version=1.0
Name=Valinor
Comment=Valinor Controls
Exec=alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=Valinor --title=Valinor -e valinor
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/valinor/applications/icons/Valinor.png
Categories=GTK;
StartupNotify=false
EOF
