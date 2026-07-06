# Build tree-sitter-cli
FROM ubuntu:22.04 AS rust-builder
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    clang \
    curl \
    libclang-dev \
    libssl-dev \
    pkg-config && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install tree-sitter-cli --root /opt/ts
RUN cargo install asm-lsp --root /opt/ts


# Final image (libsssl3 req. for asm-lsp)
FROM ubuntu:22.04
COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY --from=rust-builder /opt/ts/bin/ /usr/local/bin/

ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Europe/Paris"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    chmod +x /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/start_ssh.sh && \
    apt update && \
    yes | unminimize && \
    apt install -y \
    tzdata \
    bat \
    bear \
    build-essential \
    btop \
    clang \
    clangd \
    clang-format \
    clang-tidy \
    curl \
    debuginfod \
    fzf \
    g++ \
    gcc \
    gdb \
    git \
    libbsd-dev \
    libreadline-dev \
    libssl3 \
    libx11-dev \
    libxext-dev \
    lldb \
    make \
    man-db \
    nasm \
    openssh-server \
    php-cgi \
    python3 \
    python3-setuptools \
    pipx \
    ripgrep \
    siege \
    strace \
    unrar \
    unzip \
    valgrind \
    wl-clipboard \
    xauth \
    zsh && \
    mkdir -p /opt/lazygit /opt/nvim /opt/eza && \
    # Install lazygit
    curl -L https://github.com/jesseduffield/lazygit/releases/download/v0.62.2/lazygit_0.62.2_linux_x86_64.tar.gz | tar xz -C /opt/lazygit && \
    ln -s /opt/lazygit/lazygit /usr/local/bin/lazygit && \
    # Install neovim
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar xz -C /opt/nvim && \
    ln -s /opt/nvim/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim && \
    # Install eza
    curl -L https://github.com/eza-community/eza/releases/download/v0.23.4/eza_x86_64-unknown-linux-gnu.tar.gz | tar xz -C /opt/eza && \
    ln -s /opt/eza/eza /usr/local/bin/eza && \
    # Install norminette
    pipx install norminette && \
    #Install mlx
    git clone https://github.com/42paris/minilibx-linux.git /tmp/mlx && \
    cd /tmp/mlx && \
    ./configure && \
    mkdir -p /usr/local/lib /usr/local/include /usr/local/man/man3 && \
    mv libmlx.a /usr/local/lib && \
    mv mlx.h /usr/local/include && \
    mv man/man3/* /usr/local/man/man3 && \
    cd / && \
    rm -rf /tmp/mlx && \
    # Install claude code
    curl -fsSL https://claude.ai/install.sh | bash && \
    # Clear apt cache
    rm -rf /var/lib/apt/lists/* && \
    # Run setup script and clone nvim config
    /usr/local/bin/setup.sh && \
    mkdir -p /root/.config && \
    git clone https://github.com/joshw34/nvim.git /root/.config/nvim && \
    # Set root password for ssh access
    echo 'root:password' | chpasswd

COPY ./files/sshd_config /etc/ssh/sshd_config

ENV TERM="screen-256color"
ENV DEBUGINFOD_URLS="https://debuginfod.ubuntu.com"
ENV FZF_DEFAULT_OPTS="--border --preview 'bat --color=always {}' --color=dark"
