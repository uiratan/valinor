#!/bin/bash

print_msg "INSTALANDO: optional apss"

if [[ -v VALINOR_FIRST_RUN_OPTIONAL_APPS ]]; then
	apps=$VALINOR_FIRST_RUN_OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		for app in $apps; do
			source "$VALINOR_PATH/install/desktop/optional/app-${app,,}.sh"
		done
	fi
fi
