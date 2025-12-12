#!/bin/bash

# Only ask for default desktop app choices when running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  OPTIONAL_APPS=("1password" "Spotify" "Zoom" "Dropbox")
  #DEFAULT_OPTIONAL_APPS='1password,Spotify,Zoom'
  #DEFAULT_OPTIONAL_APPS='Dropbox'
  #export VALINOR_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 7 --header "Select optional apps" | tr ' ' '-')
  export VALINOR_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --height 7 --header "Select optional apps" | tr ' ' '-')
  echo $VALINOR_FIRST_RUN_OPTIONAL_APPS
fi

#AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
#SELECTED_LANGUAGES="Ruby on Rails","Node.js"
AVAILABLE_LANGUAGES=( "Java" "Node.js" "Go" "Python" "Rust" "PHP" "Elixir" "Ruby on Rails" )
SELECTED_LANGUAGES="Java","Node.js"
export VALINOR_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")
echo $VALINOR_FIRST_RUN_LANGUAGES

AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
#SELECTED_DBS="MySQL,Redis"
#SELECTED_DBS=" "
#export VALINOR_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")
export VALINOR_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")
echo $VALINOR_FIRST_RUN_DBS
