FROM debian:wheezy

RUN apt-get -q update
RUN apt-get -qy install redsocks

ADD redsocks.conf /tmp/
ADD redsocks /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/redsocks"]
