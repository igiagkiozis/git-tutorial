#!/bin/bash

declare -a users=("Priya" "Steve" "Gurmit" "Connor" "Patrick" "Giulio" "Jyothi" "Gareth" "Mike" "Ioannis")
declare -a repoTypes=("Repo")

function setup_repository {
	PREV_DIR=$(pwd)
	REPO_DIR=$1
	REPO_USER=$2
	mkdir $REPO_DIR
	cd $REPO_DIR
	git init
	echo "Initial commit" > README.md
	git add README.md
	git commit -m "0 - ${REPO_USER} Initial commit"
	
	cp "$PREV_DIR/files/proxy.go" proxy.go	
	git add proxy.go
	git commit -m "1 - ${REPO_USER} added proxy.go"

	cp "$PREV_DIR/files/box.js" box.js	
	git add box.js
	git commit -m "2 - ${REPO_USER} added box.js"

	cp "$PREV_DIR/files/box_plot.html" box_plot.html	
	git add box_plot.html
	git commit -m "3 - ${REPO_USER} added box_plot.html"

	cp "$PREV_DIR/files/HSO3.hpp" HSO3.hpp
	git add HSO3.hpp
	git commit -m "4 - ${REPO_USER} added HSO3.hpp"

	git gc

	cd $PREV_DIR
}

function generate_repositories {
	echo "Generating repos..."
	echo $TARGET_DIR
	rm -rf $TARGET_DIR
	mkdir $TARGET_DIR

	for user in "${users[@]}"
	do
		for repoType in "${repoTypes[@]}"
		do
			echo "Generating $TARGET_DIR/$user$repoType"
			REPO_DIR="$TARGET_DIR/$user$repoType"
			setup_repository $REPO_DIR $user
		done
	done
	setup_repository "$TARGET_DIR/origin"
}

CWD=$(pwd)
TARGET_DIR=$(pwd)

if [ $# -lt 1 ]; then
	generate_repositories
fi
if [ $# -eq 1 ]; then  
	TARGET_DIR=$1
	generate_repositories
fi