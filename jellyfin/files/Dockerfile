FROM alpine:latest

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    apk add jellyfin-tui

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
