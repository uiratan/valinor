#!/bin/bash

# código que roda QUANDO o arquivo NÃO EXISTE
if [ ! -f /etc/os-release ]; then
  # aplica cor vermelha ao texto
  echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  echo "Installation stopped."
  # garante parada imediata
  exit 1
fi

# carregar dados do sistema operacional
# Com . (source), essas variáveis passam a existir no shell
. /etc/os-release
echo "You are currently running: $PRETTY_NAME $VERSION_CODENAME ($ID_LIKE) on $ARCH"

# Check if running on x86
ARCH=$(uname -m)
if [ "$ARCH" != "x86_64" ] && [ "$ARCH" != "i686" ]; then
  echo "$(tput setaf 1)Error: Unsupported architecture detected"
  echo "Current architecture: $ARCH"
  echo "This installation is only supported on x86 architectures (x86_64 or i686)."
  echo "Installation stopped."
  exit 1
fi
