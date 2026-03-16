FROM node:24-alpine

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
    gcc \
    git \
    github-cli \
    lazygit \
    make \
    man-db \
    man-pages \
    man-pages-posix \
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
    mandb && \
    echo 'root:password' | chpasswd

RUN npm install -g \
        typescript-language-server \
        vscode-langservers-extracted

ENV TERM=xterm-256color
