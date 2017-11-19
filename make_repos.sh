#!/bin/bash

declare -a users=("Priya" "Steve" "Gurmit" "Connor" "Patrick" "Giulio" "Jyothi" "Gareth" "Mike" "Ioannis")

function setup_bare_repository {
	PREV_DIR=$(pwd)
	REPO_DIR=$1
	REPO_USER=$2
	mkdir $REPO_DIR
	cd $REPO_DIR

	git init --bare
	git gc

	cd $PREV_DIR
}

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

	git checkout -b DEV-000
	cp "$PREV_DIR/files/HSO3.hpp" HSO3.hpp
	git add HSO3.hpp
	git commit -m "0 - DEV-000 - ${REPO_USER} added HSO3.hpp"
	echo "using some_function = void (*)(int a, int b);" >> super.hpp
	git add super.hpp
	git commit -m "1 - DEV-000 - ${REPO_USER} added super.hpp"
	git checkout master

	cp "$PREV_DIR/files/box.js" box.js	
	git add box.js
	git commit -m "2 - ${REPO_USER} added box.js"

	git merge DEV-000 -m " ** - ${REPO_USER} merging DEV-000 into master"

	cp "$PREV_DIR/files/box_plot.html" box_plot.html	
	git add box_plot.html
	git commit -m "3 - ${REPO_USER} added box_plot.html"

	git gc

	cd $PREV_DIR
}

function generate_repositories {
	echo "Generating repos..."
	echo $TARGET_DIR
	rm -rf $TARGET_DIR
	mkdir $TARGET_DIR

	repoType="Repo"
	for user in "${users[@]}"
	do
		echo "Generating $TARGET_DIR/$user$repoType"
		REPO_DIR="$TARGET_DIR/$user$repoType"
		setup_repository $REPO_DIR $user
	done
	setup_bare_repository "$TARGET_DIR/origin"
}

CWD=$(pwd)
TARGET_DIR=$(pwd)/TutorialRepositories

if [ $# -lt 1 ]; then
	generate_repositories
fi
if [ $# -eq 1 ]; then  
	TARGET_DIR=$1
	generate_repositories
fi