FROM terminal-cool

RUN apt-get -y install emacs23-nox

CMD ["emacs", "-f", "tetris", "--color"]
