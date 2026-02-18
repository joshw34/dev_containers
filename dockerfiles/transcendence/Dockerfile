FROM archlinux:latest

COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY ./files/sshd_config /etc/ssh/sshd_config

RUN sed -i 's/^NoExtract.*man/# &/' /etc/pacman.conf && \
    chmod +x /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/start_ssh.sh && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
    base-devel \
    bat \
    btop \
    curl \
    debuginfod \
    eza \
    git \
    github-cli \
    lazygit \
    man-db \
    man-pages \
    neovim \
    nodejs \
    npm \
    openssh \
    ripgrep \
    tree-sitter-cli \
    unzip \
    unrar \
    wl-clipboard \
    zsh && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    pacman -Scc --noconfirm && \
    mandb

RUN npm install -g \
        eslint@9 \
        jiti \
        prettier \
        typescript \
        typescript-language-server \
        vscode-langservers-extracted

ENV DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
ENV TERM=xterm-256color
