#!/bin/bash

CHOICES=(
  "Dev Editor        Install alternative programming editors"
  "Dev Language      Install programming language environment"
  "Dev Database      Install development database in Docker"
  "Ollama            Run LLMs, like Meta's Llama3, locally"
  "Zoom              Attend and host video chat meetings"
  "Audacity          Record and edit audio"
  "Brave             Chrome-based browser with built-in ad blocking"
  "Dropbox           Sync files across computers with ease"
  "Gimp              Image manipulation tool ala Photoshop"
  "Geekbench         CPU benchmaking tool"
  "Mainline Kernels  Install newer Linux kernels than Ubuntu defaults"
  "OBS Studio        Record screencasts with inputs from both display + webcam"
  "Neovim            Install LazyVim-based Neovim setup"
  "Retroarch         Play retro games"
  "VirtualBox        Virtual machines to run Windows/Linux"
  "Web Apps          Install web apps with their own icon and shell"
  "> All             Re-run any of the default installers"
  "<< Back           "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 26 --header "Install application")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't install anything
  echo ""
elif [[ "$CHOICE" == "> All"* ]]; then
  INSTALLER_FILE=$(gum file $VALINOR_PATH/install)

  [[ -n "$INSTALLER_FILE" ]] &&
    gum confirm "Run installer?" &&
    source $INSTALLER_FILE &&
    gum spin --spinner globe --title "Install completed!" -- sleep 3
else
  INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

  case "$INSTALLER" in
  "dev-editor") INSTALLER_FILE="$VALINOR_PATH/bin/valinor-sub/install-dev-editor.sh" ;;
  "web-apps") INSTALLER_FILE="$VALINOR_PATH/install/desktop/optional/select-web-apps.sh" ;;
  "dev-language") INSTALLER_FILE="$VALINOR_PATH/install/terminal/select-dev-language.sh" ;;
  "dev-database") INSTALLER_FILE="$VALINOR_PATH/install/terminal/select-dev-storage.sh" ;;
  "ollama") INSTALLER_FILE="$VALINOR_PATH/install/terminal/optional/app-ollama.sh" ;;
  "tailscale") INSTALLER_FILE="$VALINOR_PATH/install/terminal/optional/app-tailscale.sh" ;;
  "geekbench") INSTALLER_FILE="$VALINOR_PATH/install/terminal/optional/app-geekbench.sh" ;;
  "neovim") INSTALLER_FILE="$VALINOR_PATH/install/terminal/optional/app-neovim.sh" ;;
  *) INSTALLER_FILE="$VALINOR_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
  esac

  source $INSTALLER_FILE && gum spin --spinner globe --title "Install completed!" -- sleep 3
fi

clear
source $VALINOR_PATH/bin/valinor
