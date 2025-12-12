![alt](applications/icons/Valinor.png)

# Valinor

Provisionamento completo para transformar uma instalação nova baseada em Ubuntu 24.04+ (ex: Zorin Os) em um ambiente de desenvolvimento e desktop funcional. Valinor automatiza a instalação de ferramentas de terminal, aplicativos de desktop, ajustes de GNOME e dotfiles, reproduzindo um setup opinativo inspirado no [Omakub](https://omakub.org/).

## Principais recursos
- **Instalação guiada por terminal**: prompts interativos via [Gum](https://github.com/charmbracelet/gum) para escolher apps opcionais, linguagens e bancos de dados.
- **Stack dev pronta**: mise, Docker, zellij, Alacritty, VS Code, além de linguagens (Ruby, Node, Go, Python, Java, Elixir, Rust, PHP) e bancos (PostgreSQL, Redis, MySQL) configurados em containers.
- **Dotfiles e temas integrados**: Bash com aliases/funções úteis, Alacritty + Zellij com tema Tokyo Night, VS Code pré-ajustado, Fastfetch, Btop, fontes Nerd e papéis de parede.
- **GNOME ajustado**: dock, atalhos, extensões (Tactile, Blur My Shell, Space Bar, TopHat, Alphabetical App Grid), escala de texto e pastas de apps já configurados.
- **Catálogo de apps**: scripts individuais para instalar navegadores, mensageiros, ferramentas de produtividade, editores adicionais, clientes de jogos e utilitários como 1Password, Discord, Zoom, Zed, Cursor, Steam, VirtualBox etc.
- **Menu pós-instalação**: comando `valinor` abre um menu Gum para aplicar temas, trocar fontes, instalar/remover apps e executar atualizações ou migrações.

## Requisitos
- Ubuntu 24.04 ou mais recente (x86_64/i686) com GNOME para a experiência completa.
- Usuário com privilégios sudo.
- Conexão com a internet para baixar pacotes e assets.

## Instalação rápida
1. Clone este repositório em um sistema Ubuntu recém-instalado:
   ```bash
   git clone https://github.com/SEU_USUARIO/valinor.git ~/git/linux/valinor
   cd ~/git/linux/valinor
   ```
2. Execute o bootstrap (pode demorar – prepare sua senha sudo):
   ```bash
   ./boot.sh
   ```
   O script irá:
   - Atualizar o sistema e garantir que `git` esteja disponível.
   - Copiar o conteúdo para `~/.local/share/valinor`.
   - Rodar `install.sh`, que verifica versão do sistema, coleta preferências via Gum e executa todos os instaladores de terminal/desktop.
3. Ao final, confirme o reboot quando solicitado para aplicar todas as alterações do GNOME.

## Personalização
- **Escolha de linguagens/DBs/apps**: `install/first-run-choices.sh` usa Gum para definir as variáveis `VALINOR_FIRST_RUN_*`. Exporte-as antes de rodar `install.sh` para um setup não interativo.
- **Themes e fontes**: depois de instalado, execute `valinor` → "Theme" ou "Font" para aplicar qualquer tema em `themes/` ou trocar a fonte usado por Alacritty/VS Code.
- **Arquivos de configuração**: personalize arquivos em `configs/` (Bash, Alacritty, VS Code, Btop, Fastfetch, Ulauncher). Os scripts copiam esses arquivos para `~/.config` durante a instalação.
- **Aplicativos opcionais**: edite/adicione scripts em `install/desktop/optional/` ou `install/terminal/optional/`. Eles são simples Bash `#!/bin/bash` com comandos `apt`, `flatpak`, `snap` ou `curl`.

## Estrutura resumida
```
boot.sh                # Entry point: sincroniza e executa install.sh
install/
  terminal/            # Ferramentas CLI, linguagens, bancos, docker, dotfiles
  desktop/             # Apps gráficos, extensões GNOME, fontes, temas
configs/               # Dotfiles (bashrc, inputrc, Alacritty, VS Code, etc.)
defaults/bash/         # Shell base com PATH, aliases, funções, prompt
applications/          # Scripts que criam .desktop para TUIs no Alacritty
themes/                # Coleções de temas (Alacritty, Zellij, Neovim, GNOME)
bin/                   # Menu pós-instalação (valinor) e subcomandos Gum
```

## Uso pós-instalação
- `valinor`: abre o menu interativo para gerenciar tema, fonte, instalar apps extras, atualizar ferramentas ou acessar o manual.
- `web2app / app2folder`: funções do Bash default para criar lançadores de web apps e organizá-los em pastas do GNOME (`defaults/bash/functions`).
- Aplicativos "About", "Activity", "Docker" aparecem no menu GNOME como wrappers de Fastfetch/btop/LazyDocker rodando em perfis do Alacritty (`applications/*.sh`).

## Contribuindo
1. Faça um fork e crie um branch com sua mudança.
2. Garanta que scripts permaneçam idempotentes e usem `print_msg` para logs consistentes.
3. Atualize este README e quaisquer arquivos em `configs/`/`defaults/` se introduzir novas dependências.
4. Abra um PR descrevendo o que foi adicionado ou ajustado.

## Licença
Defina aqui a licença do projeto (por exemplo, MIT) e inclua o arquivo correspondente (`LICENSE`).
