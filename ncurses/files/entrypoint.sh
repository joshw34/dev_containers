#!/bin/bash
set -e  # Exit on error

FISH_CONFIG_DIR="$HOME/.config/fish"
FISH_CONFIG_FILE="$FISH_CONFIG_DIR/config.fish"

if [ ! -f "$FISH_CONFIG_FILE" ]; then
  mkdir -p "$FISH_CONFIG_DIR"
  touch "$FISH_CONFIG_FILE"
  echo "set fish_greeting" > "$FISH_CONFIG_FILE"
  echo "fish_config prompt choose astronaut" >> "$FISH_CONFIG_FILE"
  echo 'fish_config theme choose "Catppuccin Mocha"' >> "$FISH_CONFIG_FILE"
  git clone https://github.com/catppuccin/fish.git "$HOME"/catppuccin_theme
  mkdir -p "$FISH_CONFIG_DIR"/themes
  mv "$HOME"/catppuccin_theme/themes/"Catppuccin Mocha.theme" "$FISH_CONFIG_DIR"/themes
  rm -rf "$HOME"/catppuccin_theme
fi

# Configure git
echo "Configuring git..."
git config --global user.email "joshw34@joshw34.com"
git config --global user.name "joshw34"

# Configure SSH agent
if ! grep -q 'SSH_AUTH_SOCK' "$FISH_CONFIG_FILE"; then
  echo "Configuring SSH agent..."
  cat >> "$FISH_CONFIG_FILE" << 'EOF'
# SSH Agent
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) > /dev/null
    test -f ~/.ssh/github; and ssh-add ~/.ssh/github 2>/dev/null
end
EOF
fi

# Configure eza aliases
if ! grep -q 'eza aliases' "$FISH_CONFIG_FILE"; then
  echo "Configuring eza aliases..."
  cat >> "$FISH_CONFIG_FILE" << 'EOF'

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

exec fish
