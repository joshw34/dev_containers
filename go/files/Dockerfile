FROM fedora:latest

ARG UID
ARG GID
ARG USER_LOGIN

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    #Install fedora packages
    dnf install -y \
    clang \
    curl \
    git \
    man-db \
    man-pages \
    neovim \
    unzip \
    zsh && \
    #Create temp build directory
    mkdir -p /home/${USER_LOGIN}/build && \
    #Install go
    cd /home/${USER_LOGIN}/build && \
    curl -sL 'https://go.dev/VERSION?m=text' | head -1 > ./go_version && \
    GO_VERSION=$(cat ./go_version) && \
    curl -Lo go.tar.gz https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go.tar.gz && \
    #Install lazygit
    cd /home/${USER_LOGIN}/build && \
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar -xf lazygit.tar.gz && \
    install lazygit /usr/local/bin && \
    #Install eza
    cd /home/${USER_LOGIN}/build && \
    curl -Lo eza.tar.gz "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz" && \
    tar -xf eza.tar.gz && \
    install eza /usr/local/bin && \
    #Remove temp build dir
    cd /home/${USER_LOGIN} && \
    rm -rf build && \
    #Add user
    useradd -u ${UID} -g ${GID} ${USER_LOGIN}

USER ${USER_LOGIN}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
