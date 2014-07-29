FROM moul/node

RUN apt-get -y install build-essential
RUN npm install tty.js

EXPOSE 8080
ENTRYPOINT ["coffee", "server.coffee"]
CMD ["/bin/bash"]

ADD . /app/
RUN npm install
