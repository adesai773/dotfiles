# My Dotfiles

Custom configuration files managed with GNU Stow.

## 1. Prerequisites
Before linking files, install the following:

- **Zsh**: `brew install zsh` (macOS) or `sudo apt install zsh` (Linux)
- **Stow**: `brew install stow` or `sudo apt install stow`
- **FZF**: `brew install fzf` (Required by your .zshrc plugins)

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

## 3. Setup for syncing with this dotfiles repo
```bash
# 1. Clone this repo
https://github.com/adesai773/dotfiles.git
cd ~/.dotfiles

# 2. Remove the default .zshrc created by the OMZ installer to avoid conflicts
rm ~/.zshrc

# 3. Use Stow to link the files (This assumes your files are inside a folder named 'zsh')
stow zsh
```

## 4. How to update when you change your config files
```bash
cd ~/.dotfiles
git add .
git commit -m "Update configurations"
git push origin main
```

