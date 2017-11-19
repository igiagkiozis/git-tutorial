#!/bin/bash

declare -a users=("Priya" "Steve" "Gurmit" "Connor" "Patrick" "Giulio" "Jyothi" "Gareth" "Mike" "Ioannis")
declare -a repoTypes=("Repo")

function setup_repository {
	PREV_DIR=$(pwd)
	REPO_DIR=$1
	mkdir $REPO_DIR
	cd $REPO_DIR
	git init
	cp "$PREV_DIR/Instructions.txt" Instructions.txt	
	git add .
	git commit -m "Initial commit"

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
			setup_repository $REPO_DIR
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