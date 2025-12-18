FROM fedora:latest

RUN dnf install -y \
    clang \
    nodejs-npm && \
    npm install -g @anthropic-ai/claude-code

ENTRYPOINT ["bash"]
