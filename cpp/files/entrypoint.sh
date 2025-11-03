#!/bin/zsh
set -e  # Exit on error

USER_HOME="${HOME:-/root}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}"

echo "Setting up zsh environment..."

# Install oh-my-zsh
if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Configure zsh theme
if ! grep -q "powerlevel10k" "$USER_HOME/.zshrc"; then
  echo "Setting Powerlevel10k theme..."
  sed -i '/^ZSH_THEME/c\ZSH_THEME="powerlevel10k/powerlevel10k"' "$USER_HOME/.zshrc"
fi

# Configure zsh plugins
if ! grep -q "zsh-autosuggestions" "$USER_HOME/.zshrc"; then
  echo "Configuring plugins..."
  sed -i '/^plugins=/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' "$USER_HOME/.zshrc"
fi

# Configure git
echo "Configuring git..."
git config --global user.email "joshw34@joshw34.com"
git config --global user.name "joshw34"

# Configure SSH agent (only add if not already present)
if ! grep -q 'SSH_AUTH_SOCK' "$USER_HOME/.zshrc"; then
  echo "Configuring SSH agent..."
  cat >> "$USER_HOME/.zshrc" << 'EOF'

# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
  [ -f ~/.ssh/github ] && ssh-add ~/.ssh/github 2>/dev/null
fi
EOF
fi

# Configure eza aliases
if ! grep -q 'eza aliases' "$USER_HOME/.zshrc"; then
  echo "Configuring eza aliases..."
  cat >> "$USER_HOME/.zshrc" << 'EOF'

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

# Install eza
if [ ! -f "$USER_HOME/.local/bin/eza" ]; then
  echo "Installing eza..."
  mkdir -p "$USER_HOME/.local/bin"
  curl -Lo /tmp/eza.tar.gz "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz"
  tar -xzf /tmp/eza.tar.gz -C "$USER_HOME/.local/bin" ./eza
  chmod +x "$USER_HOME/.local/bin/eza"
  rm /tmp/eza.tar.gz
  echo "eza installed successfully!"
fi

# Install lazygit if not present
if [ ! -f "$USER_HOME/.local/bin/lazygit" ]; then
  echo "Installing lazygit..."
  mkdir -p "$USER_HOME/.local/bin"
  LAZYGIT_TEMP=$(mktemp -d)
  curl -Lo "$LAZYGIT_TEMP/lazygit.tar.gz" "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')_Linux_x86_64.tar.gz"
  tar -xzf "$LAZYGIT_TEMP/lazygit.tar.gz" -C "$LAZYGIT_TEMP"
  mv "$LAZYGIT_TEMP/lazygit" "$USER_HOME/.local/bin/lazygit"
  chmod +x "$USER_HOME/.local/bin/lazygit"
  rm -rf "$LAZYGIT_TEMP"
  echo "lazygit installed successfully!"
fi

# Add .local/bin to PATH
if ! grep -q '^export PATH=.*\.local/bin' "$USER_HOME/.zshrc"; then
  echo "Adding .local/bin to PATH..."
  cat >> "$USER_HOME/.zshrc" << 'EOF'

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"
EOF
fi

echo "Setup complete! Starting zsh..."
exec zsh
