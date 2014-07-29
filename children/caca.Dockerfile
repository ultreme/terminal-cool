FROM terminal-cool

RUN apt-get -y install caca-utils

ENTRYPOINT ["coffee", "server.coffee"]
CMD ["cacafire"]
