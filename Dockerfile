# Dockerfile

FROM alpine

RUN apk add --update bash curl docker && \
    rm -rf /var/cache/apk/*

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
