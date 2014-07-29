FROM terminal-cool

RUN apt-get -y install emacs23-nox

ENTRYPOINT ["coffee", "server.coffee", "emacs", "--color", "-f"]
CMD ["tetris"]
