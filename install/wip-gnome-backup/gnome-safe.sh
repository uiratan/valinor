#!/bin/bash
set -e

# ============================================================
# GNOME SAFE SCRIPT (Zorin / Ubuntu / GNOME puro)
# Backup, Cleanup e Restore corretos e reversíveis
# ============================================================

ACTION="$1"
#BASE_DIR="$HOME/backup-gnome"
BASE_DIR="backup-gnome"
TIMESTAMP="$(date +%Y-%m-%d-%H%M)"
BACKUP_DIR="$BASE_DIR/$TIMESTAMP"

EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
SCHEMA_DIR="/usr/share/glib-2.0/schemas"

# Extensões instaladas pelo script de customização
CUSTOM_EXTENSIONS=(
  "tactile@lundal.io"
  "just-perfection-desktop@just-perfection"
  "blur-my-shell@aunetx"
  "space-bar@luchrioh"
  "undecorate@sun.wxg@gmail.com"
  "tophat@fflewddur.github.io"
  "AlphabeticalAppGrid@stuarthayhurst"
)

die() {
  echo "Uso: $0 {backup|cleanup|restore}"
  exit 1
}

reload_gnome() {
  echo "Recarregando GNOME Shell..."
  gnome-shell --replace &>/dev/null || true
}

# ============================================================
# BACKUP
# ============================================================
backup() {
  echo "=== BACKUP DO GNOME ==="
  mkdir -p "$BACKUP_DIR"

  # 1) Backup completo do estado real do GNOME
  echo "Salvando dconf (estado completo)"
  dconf dump / > "$BACKUP_DIR/dconf.ini"

  # 2) Backup legível para auditoria
  echo "Salvando gsettings (referência)"
  gsettings list-recursively > "$BACKUP_DIR/gsettings.txt"

  # 3) Estado real das extensões (distro-agnóstico)
  echo "Salvando estado das extensões"
  {
    echo "### EXTENSÕES ATIVAS ###"
    gnome-extensions list --enabled
    echo
    echo "### TODAS AS EXTENSÕES ###"
    gnome-extensions list
  } > "$BACKUP_DIR/extensions-state.txt"

  # 4) Arquivos das extensões do usuário
  echo "Salvando arquivos das extensões"
  cp -r "$EXT_DIR" "$BACKUP_DIR/extensions" 2>/dev/null || true

  # 5) Schemas do sistema
  echo "Salvando schemas do sistema (sudo)"
  sudo cp -r "$SCHEMA_DIR" "$BACKUP_DIR/schemas"

  echo "Backup concluído em:"
  echo "$BACKUP_DIR"
}

# ============================================================
# CLEANUP (remove SOMENTE customizações)
# ============================================================
cleanup() {
  echo "=== CLEANUP ==="

  echo "Removendo extensões instaladas pelo script"
  for ext in "${CUSTOM_EXTENSIONS[@]}"; do
    if [ -d "$EXT_DIR/$ext" ]; then
      echo " - $ext"
      gnome-extensions disable "$ext" 2>/dev/null || true
      rm -rf "$EXT_DIR/$ext"
    fi
  done

  echo "Removendo schemas adicionados manualmente (sudo)"
  sudo rm -f \
    "$SCHEMA_DIR/org.gnome.shell.extensions.tactile.gschema.xml" \
    "$SCHEMA_DIR/org.gnome.shell.extensions.just-perfection.gschema.xml" \
    "$SCHEMA_DIR/org.gnome.shell.extensions.blur-my-shell.gschema.xml" \
    "$SCHEMA_DIR/org.gnome.shell.extensions.space-bar.gschema.xml" \
    "$SCHEMA_DIR/org.gnome.shell.extensions.tophat.gschema.xml" \
    "$SCHEMA_DIR/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml"

  sudo glib-compile-schemas "$SCHEMA_DIR"

  reload_gnome
  echo "Cleanup concluído"
}

# ============================================================
# RESTORE (VOLTA 100% AO ESTADO ANTERIOR)
# ============================================================
restore() {
  echo "=== RESTORE ==="

  # Sempre limpar antes
  cleanup

  LATEST="$(ls -1 "$BASE_DIR" | tail -n1)"
  [ -z "$LATEST" ] && echo "Nenhum backup encontrado" && exit 1
  RESTORE_DIR="$BASE_DIR/$LATEST"

  echo "Restaurando a partir de:"
  echo "$RESTORE_DIR"

  # 1) Restaurar estado completo do GNOME
  echo "Restaurando dconf"
  dconf load / < "$RESTORE_DIR/dconf.ini"

  # 2) Restaurar schemas originais
  echo "Restaurando schemas (sudo)"
  sudo rm -rf "$SCHEMA_DIR"/*
  sudo cp -r "$RESTORE_DIR/schemas"/* "$SCHEMA_DIR/"
  sudo glib-compile-schemas "$SCHEMA_DIR"

  # 3) Restaurar extensões do usuário
  echo "Restaurando extensões do usuário"
  rm -rf "$EXT_DIR"
  cp -r "$RESTORE_DIR/extensions" "$EXT_DIR" 2>/dev/null || true

  reload_gnome
  echo "Restore concluído — estado original garantido"
}

# ============================================================
# MAIN
# ============================================================
case "$ACTION" in
  backup)   backup ;;
  cleanup)  cleanup ;;
  restore)  restore ;;
  *)        die ;;
esac

