# Valinor – Contexto para agentes

## Estrutura do projeto
- `boot.sh` faz preparação inicial, imprime banner e sincroniza o repo em `~/.local/share/valinor` antes de acionar `install.sh`, que usa `set -e` e `trap` para abortar com instrução de retry.
- `install/terminal` contém instaladores Bash para ferramentas CLI (fzf, ripgrep, zellij, Docker, mise), dependências de desenvolvimento e seletores com Gum para linguagens/DBs que usam mise, apt e Docker para provisionar Ruby, Node, Go, Python, Java, Postgres, Redis, MySQL etc.
- `install/desktop` reúne instaladores de aplicativos gráficos, scripts que criam `.desktop` wrappers, ajustes de GNOME (dock, atalhos, extensões, temas, teclas personalizadas) e opcionais (1Password, Brave, Discord, Steam, VirtualBox, Zed, Cursor, Ollama, etc.).
- `defaults/` e `configs/` guardam dotfiles copiados durante a instalação: Bash default (aliases, funções utilitárias, PATH, VALINOR_PATH), inputrc, Alacritty/Zellij/VS Code/Btop/Fastfetch/Ulauncher.
- `applications/` gera lançadores .desktop que abrem TUIs (fastfetch, btop, lazydocker, Valinor CLI) dentro de perfis específicos do Alacritty; `applications/optional` cria web apps encapsulados no Chrome.
- `themes/` oferece pacotes completos (Alacritty, Zellij, Neovim, Btop, fundos) e scripts que aplicam temas Yaru e extensões com `gsettings`; dois conjuntos de variáveis (`VALINOR_THEME_*` vs `OMAKUB_THEME_*`) coexistem, herdados do upstream.

## Stack e ferramentas
- Instaladores 100% Bash, utilizando `apt`, `snap`, `flatpak`, `docker`, `pipx`, `wget/curl`, `gum` (para prompts), `mise` como gerenciador de runtimes, `rsync` para cópia local.
- Terminal padrão: Alacritty + Zellij, com zoxide, fzf, eza/bat, lazygit, lazydocker, fastfetch, btop, git configurado com aliases e `credential.helper cache`.
- Desktop GNOME modificado via gsettings, extensões (Tactile, Blur My Shell, Space Bar, TopHat, Alphabetical App Grid), dock favorito, fontes Nerd (Caskaydia, iA Writer).
- Optional installers cobrem editores (Cursor, Zed, Doom Emacs), apps de mídia/comunicação (Spotify, Discord, Zoom), ferramentas dev (1Password CLI, VirtualBox, Mainline kernels, Ollama, Tailscale), jogos (Steam, Minecraft, Retroarch).

## Convenções e fluxos
- Entry point: `boot.sh` → `install.sh`; cada script define mensagens com `print_msg` para feedback colorido. `trap` garante instrução de rerun em caso de erro.
- Instalação distingue GNOME vs ambientes puramente terminal, desativando bloqueio de tela enquanto roda, executando todos os scripts de `install/terminal/*.sh` e depois `install/desktop/*.sh`.
- Shell padrão (`configs/bashrc`) importa `defaults/bash/rc`, que define PATH, exporta `VALINOR_PATH`, habilita autocompletion, aliases e funções (web2app/app2folder/etc).
- Configuração de apps copia arquivos de `configs/`/`themes/` para `~/.config`, padronizando cores (Tokyo Night como default), tipografia (CaskaydiaMono Nerd Font) e comportamento (VS Code sem minimap, Git autofetch).
- CLI pós-instalação via `bin/valinor` (menu Gum em `bin/omakub-sub/menu.sh`) permite trocar tema, fonte, rodar instaladores/updates, migrar ou desinstalar; vários scripts ainda usam `OMAKUB_PATH`, refletindo o fork do projeto original.
