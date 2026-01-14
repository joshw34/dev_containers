FROM archlinux:latest

COPY ./mlx/libmlx.a /usr/local/lib
COPY ./mlx/mlx.h /usr/local/include
COPY ./mlx/man3/ /usr/local/man/man3/
COPY ./norminette/norminette-3.3.55-1-x86_64.pkg.tar.zst /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
    base-devel \
    bat \
    bear \
    btop \
    clang \
    curl \
    debuginfod \
    eza \
    git \
    lazygit \
    libbsd \
    libx11 \
    libxext \
    lldb \
    man-pages \
    neovim \
    readline \
    unzip \
    unrar \
    valgrind \
    zsh && \
    pacman -U --noconfirm /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst && \
    curl -fsSL https://claude.ai/install.sh | bash && \
    pacman -Scc --noconfirm

ENV DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
ENV TERM=xterm-256color
