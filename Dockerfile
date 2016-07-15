FROM debian:jessie

MAINTAINER Krzysztof Kardasz <krzysztof@kardasz.eu>

# Update system and install required packages
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -r memcache && useradd -r -g memcache memcache

RUN \
    apt-get update && \
    apt-get -y install libsqlite3-dev ruby ruby-dev build-essential && \
    gem install --no-ri --no-rdoc mailcatcher && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 1080 1025

CMD ["mailcatcher", "--http-ip=0.0.0.0", "--smtp-ip=0.0.0.0", "--foreground"]
