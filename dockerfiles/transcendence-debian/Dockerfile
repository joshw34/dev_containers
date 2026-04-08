FROM node:24-trixie

COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY ./files/sshd_config /etc/ssh/sshd_config

RUN chmod +x /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/start_ssh.sh && \
    apt update && \
    apk add --no-cache \
    bash \
    bat \
    btop \
    curl \
    eza \
    gcc \
    git \
    gh \
    lazygit \
    make \
    openssh \
    ripgrep \
    tree-sitter-cli \
    unzip \
    wl-clipboard \
    zsh && \
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar xz -C /opt && \
    ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    rm -rf /var/lib/apt/lists/* && \
    /usr/local/bin/setup.sh && \
    mkdir -p /root/.config && \
    git clone https://github.com/joshw34/nvim.git /root/.config/nvim && \
    echo 'root:password' | chpasswd

RUN npm install -g \
        typescript-language-server \
        vscode-langservers-extracted

ENV TERM=tmux-256color
