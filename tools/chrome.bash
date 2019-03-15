#!/usr/bin/env bash
declare -r temp_dir=$(mktemp -d)

# Immediately exit on failure
set -e

# Delete temp dir on exit
function finish() {
	local RETVAL=$?
	rm -rf $temp_dir
}
eval trap "'finish $0 $@'" EXIT

# Download and install Chrome package
chrome_pkg=$temp_dir/google-chrome-stable_current_amd64.deb
wget \
	-O $chrome_pkg \
	https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i $chrome_pkg

