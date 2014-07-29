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
	    cat $file | docker build -t terminal-cool-$name -
	done
	exit 0
	;;

    "build-all")
	$0 build
	$0 build-children
	exit 0
	;;

    "run")
        docker stop terminal-cool &> /dev/null
        docker rm terminal-cool &> /dev/null
        docker run --name terminal-cool -d terminal-cool
        exit 0
        ;;

    "sbrk")
	TO_RUN=$2
	mkdir -p ~/.docker
	run() {
	    NAME="$1"
	    IMAGE="$2"
	    shift
	    shift
	    PARAMS="$@"
	    if [ "$NAME" = "$TO_RUN" -o "$TO_RUN" = "all" ]; then
		echo "=========== [CONTAINER:$NAME] =========="
		echo " - stopping"
		docker stop $NAME >/dev/null 2>/dev/null
		echo " - destroying"
		docker rm $NAME >/dev/null 2>/dev/null
		echo " - destroyed"
		echo " - image = $IMAGE"
		echo " - params = $PARAMS"
		echo "docker run $PARAMS --name $NAME $IMAGE $ARGS"
		CID=$(docker run $PARAMS --name $NAME $IMAGE $ARGS)
		echo " - created with CID=$CID"
		echo $CID > ~/.docker/$NAME.cid
	    fi
	    ARGS=""
	}

	ARGS=tetris run terminal-cool-emacs-tetris terminal-cool-emacs-app -d -p 12345:8080
	ARGS=doctor run terminal-cool-emacs-doctor terminal-cool-emacs-app -d -p 12346:8080
	ARGS=pong   run terminal-cool-emacs-pong   terminal-cool-emacs-app -d -p 12347:8080
	ARGS=gomoku run terminal-cool-emacs-gomoku terminal-cool-emacs-app -d -p 12348:8080
	run terminal-cool-nethack terminal-cool-nethack -d -p 12349:8080
	exit 0
	;;

esac

echo >&2 "usage: $0 [dev|build|build-children|build-all|run|sbrk]"
exit 1
