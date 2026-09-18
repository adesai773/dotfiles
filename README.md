# My Dotfiles

Custom configuration files managed with GNU Stow.

## 1. Prerequisites
Before linking files, install the following:

- **Zsh**: `brew install zsh` (macOS) or `sudo apt install zsh` (Linux)
- **Stow**: `brew install stow` or `sudo apt install stow`
- **FZF**: `brew install fzf` (Required by your .zshrc plugins)
- **tmux**: `brew install tmux` 
- **bat**: `brew install bat` (Just a nice alternative to cat)

- **ghostty**: `brew install ghostty` (ultra fast mac-optimized terminal)
- **opencode**: `curl -fsSL https://opencode.ai/install | bash` 
- **pi**: `curl -fsSL https://pi.dev/install.sh | sh`
- **bun**: `brew install oven-sh/bun/bun` (needed by pi's `/termdraw`)

## 2. Install Oh My Zsh & Theme
Run the following to install the framework and the Powerlevel10k theme:
```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## 3. Setup for syncing zsh, git, vim, tmux, ghostty, opencode etc. with this dotfiles repo
```bash
# 0. Setup SSH Keys if cloning over SSH. (If cloning with a Public Access Token, then no need for SSH Keys).

# 1. Clone this repo with SSH (or Public Access Token)
git clone git@github.com:adesai773/dotfiles.git ~/.dotfiles
# Note: Alternatively, can clone with PAT over https: git clone https://github.com/adesai773/dotfiles.git ~/.dotfiles
# and submit a Public Access Token when it asks for password.

cd ~/.dotfiles

# 2. Remove the default files to avoid Stow conflicts
rm ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.tmux.conf 
mkdir -p ~/.pi/agent && rm -f ~/.pi/agent/settings.json

# 3. Use Stow to link the files
stow zsh git vim shell tmux ghostty pi

# Note: You may have to run `p10k configure` in order to download the
# recommended "Meslo Nerd Font" if it wasn't already downloaded
```

## 4. VS Code Setup
Install the following plugins:

- **C/C++**
- **C/C++ Extension Pack**
- **Catppuccin for VSCode**
- **Claude Code for VS Code**
- **GitLens — Git supercharged**
- **Night Owl**
- **Everforest** (by sainnhe)
- **Python**
- **Ruff** 

```bash
# Remove default settings file to avoid Stow conflicts
rm ~/Library/Application\ Support/Code/User/settings.json

# Note, we stow the configs in the vscode/ dir to the target dir
# "~/Library/Application\ Support/Code/User" in order to flatten the directory structure
stow -t ~/Library/Application\ Support/Code/User vscode
```

## 5. opencode Setup
opencode reads config from `~/.config/opencode/`. This package mirrors that
path and stows `opencode.json` and `tui.json`.

```bash
# Remove any existing opencode configs to avoid Stow conflicts
rm -f ~/.config/opencode/opencode.json ~/.config/opencode/tui.json

# Stow the configs
cd ~/.dotfiles
stow opencode
```

## 6. pi Setup
`pi` stows `~/.pi/agent/settings.json`; `auth.json` (tokens) and `~/.config/mcp/mcp.json` (MCP servers) are untracked.

```bash
pi install npm:pi-mcp-adapter
pi install npm:@tintinweb/pi-subagents
pi install git:github.com/DietrichGebert/ponytail
ln -s ~/.claude/agents ~/.pi/agent/agents   # Claude Code agents as pi subagents

# In pi: /login (Anthropic/OpenAI) or add a baseten api_key entry to ~/.pi/agent/auth.json,
# then /mcp-auth <server> once per MCP server
```

## 7. ponytail Setup
[ponytail](https://github.com/DietrichGebert/ponytail) is installed per host (Claude Code below, pi in §6).
The stowed `~/.config/ponytail/config.json` sets `ultra` as the default mode for every host.

```bash
# Claude Code plugin (hooks need node on PATH: brew install node)
claude plugin marketplace add DietrichGebert/ponytail
claude plugin install ponytail@ponytail

# Default mode
rm -f ~/.config/ponytail/config.json
cd ~/.dotfiles && stow ponytail
```

## 8. caveman Setup
[caveman](https://github.com/JuliusBrussee/caveman) makes agent prose terse. Claude Code, opencode, and pi (via
[pi-caveman-config](https://github.com/adesai773/pi-caveman-config)) all read the stowed `~/.config/caveman/config.json`;
edit `defaultMode` (`lite|full|ultra`) there to change every host.

```bash
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman
# opencode plugin + pi package are already in the stowed opencode.json / pi settings.json

rm -rf ~/.config/caveman
cd ~/.dotfiles && stow caveman
```

## How to add new dotfiles to repo
```bash
# Create matching directory structure
mkdir -p ~/.dotfiles/shell

# Move original file into .dotfiles repo
mv ~/.hushlogin ~/.dotfiles/shell/

# Stow the package
cd ~/.dotfiles 
stow shell
```

## How to update when you change your config files
```bash
cd ~/.dotfiles
git add .
git commit -m "Update configurations"
git push origin main
```

