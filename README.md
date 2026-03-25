# My Dotfiles

Custom configuration files managed with GNU Stow.

## 1. Prerequisites
Before linking files, install the following:

- **Zsh**: `brew install zsh` (macOS) or `sudo apt install zsh` (Linux)
- **Stow**: `brew install stow` or `sudo apt install stow`
- **FZF**: `brew install fzf` (Required by your .zshrc plugins)
- **bat**: `brew install bat`

## 2. Install Oh My Zsh & Theme
Run the following to install the framework and the Powerlevel10k theme:
```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# Note: You may have to run `p10k configure` in order to download the
# recommended "Meslo Nerd Font"

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## 3. Setup for syncing Zsh, Git, and Vim with this dotfiles repo
```bash
# 0. Setup SSH Keys if cloning over SSH. (If cloning with a Public Access Token, then no need for SSH Keys).

# 1. Clone this repo with SSH (or Public Access Token)
git clone git@github.com:adesai773/dotfiles.git ~/.dotfiles
# Note: Alternatively, can clone with PAT over https: git clone https://github.com/adesai773/dotfiles.git ~/.dotfiles
# and submit a Public Access Token when it asks for password.

cd ~/.dotfiles

# 2. Remove the default files to avoid Stow conflicts
rm ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc

# 3. Use Stow to link the files
stow zsh git vim
```

## 4. VS Code Setup
Install the following plugins:

- **C/C++**
- **C/C++ Extension Pack**
- **Catppuccin for VSCode**
- **Claude Code for VS Code**
- **GitLens — Git supercharged**
- **Night Owl**
- **Python**
- **Ruff** 

```bash
# Remove default settings file to avoid Stow conflicts
rm ~/Library/Application\ Support/Code/User/settings.json

# Note, we stow the configs in the vscode/ dir to the target dir
# "~/Library/Application\ Support/Code/User" in order to flatten the directory structure
stow -t ~/Library/Application\ Support/Code/User vscode
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

