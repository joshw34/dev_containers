FROM fedora:latest

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

#Copy pre-compiled mlx as it doesn't compile on fedora
COPY ./mlx/libmlx.a /usr/local/lib
COPY ./mlx/mlx.h /usr/local/include
COPY ./mlx/man3/ /usr/local/man/man3/

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    #Install fedora packages
    dnf install -y \
    bear \
    clang \
    git \
    libbsd-devel \
    libX11-devel \
    libXext-devel \
    lldb \
    man-db \
    man-pages \
    neovim \
    pipx \
    readline-devel \
    unzip \
    valgrind \
    zsh && \
    #Install norminette
    pipx install norminette && \
    #Create temp build directory
    mkdir -p /root/build && \
    #Install lazygit
    cd /root/build && \
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar -xf lazygit.tar.gz && \
    install lazygit /usr/local/bin && \
    #Install eza
    cd /root/build && \
    curl -Lo eza.tar.gz "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz" && \
    tar -xf eza.tar.gz && \
    install eza /usr/local/bin && \
    #Remove temp build dir
    cd /root && \
    rm -rf build

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
