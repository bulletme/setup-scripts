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

# Download and install Hugo package
hugo_url=https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.deb
hugo_pkg=$temp_dir/$(basename $hugo_url)
wget -O $hugo_pkg $hugo_url
sudo dpkg -i $hugo_pkg

