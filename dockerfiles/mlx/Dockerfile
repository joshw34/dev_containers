FROM archlinux:latest

COPY ./files/mlx/libmlx.a /usr/local/lib
COPY ./files/mlx/mlx.h /usr/local/include
COPY ./files/mlx/man3/ /usr/local/man/man3/
COPY ./files/norminette-3.3.55-1-x86_64.pkg.tar.zst /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst
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
    bear \
    btop \
    clang \
    curl \
    debuginfod \
    eza \
    gdb \
    git \
    github-cli \
    lazygit \
    libbsd \
    libx11 \
    libxext \
    lldb \
    man-db \
    man-pages \
    neovim \
    openssh \
    readline \
    ripgrep \
    tree-sitter-cli \
    unzip \
    unrar \
    valgrind \
    wl-clipboard \
    zsh && \
    pacman -U --noconfirm /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst && \
    rm /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    pacman -Scc --noconfirm && \
    mandb

ENV DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
ENV TERM=xterm-256color
