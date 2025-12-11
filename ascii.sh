#!/bin/bash

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

# Define the color gradient (shades of cyan and blue)
eu quero mudar essa paleta para iniciando com branco, passando por prateado ate dourado
colors=(
    '\033[38;5;172m' # Ouro profundo
    '\033[38;5;178m' # Ouro
    '\033[38;5;184m' # Ouro claro/amarelado
    '\033[38;5;220m' # Dourado claro
    '\033[38;5;247m' # Prata médio
    '\033[38;5;250m' # Prata claro
    '\033[38;5;254m' # Cinza quase branco
    '\033[38;5;231m' # Branco
)


# Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

# Print each line with the corresponding color
for i in "${!lines[@]}"; do
	color_index=$((i % ${#colors[@]}))
	echo -e "${colors[color_index]}${lines[i]}"
done
