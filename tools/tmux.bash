#!/usr/bin/env bash
TMUX_VERSION=3.0
now=$(date +%y%m%d-%H%M%S-Week%U-%a-%T)
install_dir=/tmp/tmux-$now

# https://github.com/tmux/tmux/blob/master/CHANGES

# Immediately exit on failure
set -e

# Always run when script finishes
function finish() {
	local RETVAL=$?
	echo -e "path: $here\ncommand: $@\nexit: $RETVAL"
}
eval trap "'finish $0 $@'" EXIT

# Install dependencies
sudo apt update
sudo apt install -y \
	automake \
	build-essential \
	pkg-config \
	libevent-dev \
	libncurses5-dev

# Install tmux
git clone https://github.com/tmux/tmux.git $install_dir
cd $install_dir
git checkout $TMUX_VERSION
sh autogen.sh
./configure && make
sudo make install

