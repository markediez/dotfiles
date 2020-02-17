#!/bin/bash
set -xe

function download_repository() {
	echo "Downloading repository"

}

function install_aptget_tools() {
	echo "Downloading core dependencies"
	sudo apt-get update
	echo "Installing $@"
	sudo apt-get install -y $@
}

function install_golang() {
	echo "Installing golang"
	local GOLANG_HTTP='https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz'
	local GOLANG_LOC=/usr/local
	local GOLANG_DL_LOC=/tmp/go1.13.8.linux-amd64.tar.gz
	curl $GOLANG_HTTP -o $GOLANG_DL_LOC
	sudo tar -C $GOLANG_LOC -xzf $GOLANG_DL_LOC
	rm -f $GOLANG_DL_LOC
	for binary in $(ls $GOLANG_LOC/go/bin)
	do
		sudo ln -s $GOLANG_LOC/go/bin/$binary /usr/local/bin/$binary
	done
}

function install_ohmyzsh() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function setup_git() {
	echo "Setting up core config"
	git config --global user.name "Mark Diez"
	git config --global user.email "markediez@gmail.com"
}

function setup_zsh() {
	ln -s $1 ~/.zsh_profile
}

function in_dotfiles () {
	local REMOTE_URL=$(git remote get-url origin)
	if [[ "$REMOTE_URL" == "git@github.com:markediez/dotfiles.git" ]]
	then
		return 0
	else
		return 1
	fi
}

function setup_python3() {
	pip3 install virtualenvwrapper
}

function install_vscode() {
	echo "GOTO WEBSITE"
}

function main() {
	local REPO_DIR=$(pwd)
	# One-liner bash command invocation
	if in_dotfiles
	then
		echo "Skipping download, already in dotfiles"
	else
		download_repository
		REPO_DIR="$ZSH_PROFILE/dotfiles"
	fi

	install_aptget_tools gcc make git vim curl zsh python3 python3-pip
	install_golang
	install_ohmyzsh
	install_vscode
	setup_git
	setup_zsh $REPO_DIR/.zsh_profile
	setup_python3
}

main $@
