FROM terminal-cool

RUN apt-get -y install emacs23-nox

RUN ["emacs", "-f", "tetris", "--color"]
