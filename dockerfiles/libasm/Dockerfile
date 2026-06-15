# Build tree-sitter-cli
FROM ubuntu:22.04 AS ts-builder
RUN apt-get update && apt-get install -y curl build-essential \
 && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install tree-sitter-cli --root /opt/ts


# Final image (Pulls tree-sitter binary without rust toolchain)
FROM ubuntu:22.04

COPY ./files/setup.sh /usr/local/bin/setup.sh
COPY ./files/start_ssh.sh /usr/local/bin/start_ssh.sh
COPY ./files/sshd_config /etc/ssh/sshd_config
COPY --from=ts-builder /opt/ts/bin/tree-sitter /usr/local/bin/tree-sitter

RUN chmod +x /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/start_ssh.sh && \
    apt update && \
    apt install -y \
    bat \
    btop \
    curl \
    fzf \
    gcc \
    g++ \
    gdb \
    git \
    make \
    nasm \
    openssh-server \
    ripgrep \
    unzip \
    wl-clipboard \
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

ENV TERM="tmux-256color"
ENV FZF_DEFAULT_OPTS="--border --preview 'bat --color=always {}' --color=dark"
