#!/bin/bash
set -e  # Exit on error

ZSHRC="$HOME/.zshrc"
OMZ_CUSTOM="$HOME/.oh-my-zsh/custom"
P10K_DIR="$OMZ_CUSTOM/themes/powerlevel10k"
AUTOSUGGEST_DIR="$OMZ_CUSTOM/plugins/zsh-autosuggestions"
HIGHLIGHTING_DIR="$OMZ_CUSTOM/plugins/zsh-syntax-highlighting"
GO_BIN_SYS="/usr/local/go/bin"
GO_BIN_LOCAL="$HOME/go/bin"

# Configure git
echo "Configuring git..."
git config --global user.email "joshw34@joshw34.com"
git config --global user.name "joshw34"

# Create .zshrc if not already present
if [ ! -f "$ZSHRC" ]; then
  touch "$ZSHRC"
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install powerlevel10k and set .zshrc theme
if [ ! -d "$P10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  sed -i '/^ZSH_THEME/c\ZSH_THEME="powerlevel10k/powerlevel10k"' "$ZSHRC"
fi

# Install zsh-autosuggestions
if [ ! -d "$AUTOSUGGEST_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGEST_DIR"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$HIGHLIGHTING_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HIGHLIGHTING_DIR"
fi

# Add zsh-autosuggestions and zsh-syntax-highlighting and add to .zshrc plugins
if ! grep -q 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' "$ZSHRC"; then
  sed -i '/^plugins=/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' "$ZSHRC"
fi

# Configure eza aliases
if ! grep -q 'eza aliases' "$ZSHRC"; then
  cat >> "$ZSHRC" << 'EOF'

# eza aliases
alias ls="eza -1 --icons=always"
alias lsa="eza -a -1 --icons=always"
alias lsl="eza -l --header --total-size --no-user --no-time --icons=always"
alias lsal="eza -al --header --total-size --no-user --no-time --icons=always"
alias lsla="eza -al --header --total-size --no-user --no-time --icons=always"
alias lsf="eza -l --header --total-size --icons=always"
alias lsaf="eza -al --header --total-size --icons=always"
alias lsg="eza -l --header --no-permissions --total-size --no-user --no-time --git --git-repos"
alias lst="eza -1T --icons=always"
alias lsat="eza -a -1T --icons=always"
EOF
fi

#Temp export for script to install gopls
export PATH="$PATH:$GO_BIN_SYS:$GO_BIN_LOCAL"
#Install go_pls
go install golang.org/x/tools/gopls@latest

# Add go paths to $PATH (needs to be added after zsh configuration so it isnt overwritten)
if ! grep -q 'export PATH=$PATH' "$ZSHRC"; then
  echo "export PATH=\$PATH:$GO_BIN_SYS:$GO_BIN_LOCAL" >> "$ZSHRC"
fi

exec zsh
