FROM node:24-alpine

COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY ./files/sshd_config /etc/ssh/sshd_config

RUN apk update && \
    apk add --no-cache \
    bat \
    btop \
    curl \
    eza \
    git \
    github-cli \
    lazygit \
    man-db \
    man-pages \
    man-pages-posix \
    neovim \
    openssh \
    ripgrep \
    tree-sitter-cli \
    unzip \
    wl-clipboard \
    zsh && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    mandb

RUN npm install -g \
        jiti \
        typescript-language-server \
        vscode-langservers-extracted

ENV TERM=xterm-256color
