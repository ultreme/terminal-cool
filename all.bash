#!/usr/bin/env bash

cd $(dirname $0)

case $1 in
    "dev")
	coffee server.coffee /bin/bash
        exit 0
        ;;

    "build")
        docker build -t terminal-cool .
	exit 0
	;;

    "build-children")
	for file in children/*.Dockerfile; do
	    name=$(basename $file | cut -d\. -f1)
	    echo "Compiling child: $name"
	    cat $file | docker build -t $name -
	done
	exit 0
	;;

    "run")
        docker stop terminal-cool &> /dev/null
        docker rm terminal-cool &> /dev/null
        docker run --name terminal-cool -d terminal-cool
        exit 0
        ;;
esac

echo >&2 "usage: $0 [dev|build|build-children|run]"
exit 1
