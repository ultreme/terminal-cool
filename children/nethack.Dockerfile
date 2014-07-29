FROM terminal-cool

RUN apt-get -y install nethack-console

CMD ["/usr/games/nethack"]
