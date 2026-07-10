# Build asm-lsp
FROM archlinux:latest AS rust-builder
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
    base-devel \
    clang \
    curl \
    openssl \
    pkgconf && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install asm-lsp --root /opt/ts

# Final image (openssl needed for asm-lsp)
FROM archlinux:latest
COPY ./files/mlx/libmlx.a /usr/local/lib
COPY ./files/mlx/mlx.h /usr/local/include
COPY ./files/mlx/man3/ /usr/local/man/man3/
COPY ./files/norminette-3.3.55-1-x86_64.pkg.tar.zst /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst
COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY --from=rust-builder /opt/ts/bin/ /usr/local/bin/

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
    fzf \
    gcc \
    gdb \
    git \
    github-cli \
    lazygit \
    libbsd \
    libx11 \
    libxext \
    lldb \
    make \
    man-db \
    man-pages \
    nasm \
    neovim \
    openssh \
    openssl \
    php-cgi \
    readline \
    ripgrep \
    siege \
    strace \
    tree-sitter-cli \
    unzip \
    unrar \
    valgrind \
    wl-clipboard \
    xorg-xauth \
    zsh && \
    pacman -U --noconfirm /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst && \
    rm /tmp/norminette-3.3.55-1-x86_64.pkg.tar.zst && \
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
