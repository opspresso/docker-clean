# Dockerfile

FROM docker

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
