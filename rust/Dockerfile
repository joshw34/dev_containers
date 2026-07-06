FROM rust:alpine

COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY ./files/sshd_config /etc/ssh/sshd_config

RUN chmod +x /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/start_ssh.sh && \
    apk update && \
    apk add --no-cache \
    bash \
    bat \
    btop \
    curl \
    eza \
    git \
    lazygit \
    musl-dev \
    neovim \
    openssh \
    ripgrep \
    tree-sitter-cli \
    unzip \
    vim \
    wl-clipboard \
    zsh && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    rustup component add rust-analyzer && \
    rustup component add rustfmt && \
    /usr/local/bin/setup.sh && \
    mkdir -p /root/.config && \
    git clone https://github.com/joshw34/nvim.git /root/.config/nvim && \
    echo 'root:password' | chpasswd

ENV TERM=tmux-256color
