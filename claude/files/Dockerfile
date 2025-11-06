FROM fedora:latest

ARG UID
ARG GID
ARG USER_LOGIN

RUN dnf install -y \
    clang \
    nodejs-npm && \
    npm install -g @anthropic-ai/claude-code && \
    useradd -u ${UID} -g ${GID} ${USER_LOGIN}

USER ${USER_LOGIN}

ENTRYPOINT ["bash"]
