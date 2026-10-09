FROM archlinux:latest
COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh

RUN sed -i 's/^NoExtract.*man/# &/' /etc/pacman.conf && \
    chmod +x /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/start_ssh.sh && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
    base-devel \
    bat \
    btop \
    clang \
    curl \
    debuginfod \
    delve \
    eza \
    fzf \
    git \
    github-cli \
    go \
    gopls \
    lazygit \
    lldb \
    man-db \
    man-pages \
    neovim \
    openssh \
    ripgrep \
    strace \
    tree-sitter-cli \
    unzip \
    unrar \
    wl-clipboard \
    xorg-xauth \
    zsh && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    pacman -Scc --noconfirm && \
    mandb && \
    /usr/local/bin/setup.sh && \
    mkdir -p /root/.config && \
    git clone https://github.com/joshw34/nvim.git /root/.config/nvim && \
    echo 'root:password' | chpasswd

COPY ./files/sshd_config /etc/ssh/sshd_config

ENV DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
ENV TERM=screen-256color
ENV FZF_DEFAULT_OPTS="--border --preview 'bat --color=always {}' --color=dark"
