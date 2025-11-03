FROM fedora:latest

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    dnf update -y && \
    dnf install -y \
    bear \
    clang \
    clang-tools-extra \
    git \
    lldb \
    man-db \
    man-pages \
    neovim \
    valgrind \
    zsh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
