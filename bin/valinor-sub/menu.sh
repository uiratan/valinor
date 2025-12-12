#!/bin/bash

if [ $# -eq 0 ]; then
	SUB=$(gum choose "Install" "Uninstall" "Theme" "Font" "Update" "Manual" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

[ -n "$SUB" ] && [ "$SUB" != "quit" ] && source $VALINOR_PATH/bin/valinor-sub/$SUB.sh
