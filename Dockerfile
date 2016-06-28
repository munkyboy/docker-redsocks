FROM debian:jessie

RUN apt-get update \
 && apt-get install -y redsocks \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ADD redsocks.conf /tmp/
ADD redsocks /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/redsocks"]
