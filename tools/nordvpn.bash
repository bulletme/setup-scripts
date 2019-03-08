#!/usr/bin/env bash
# ==============================================================================
# Instructions here:
# https://nordvpn.com/tutorials/linux/openvpn/
# ==============================================================================
declare -r tempdir=$(mktemp -d)
declare -r now=$(date +%y%m%d-%H%M%S-Week%U-%a-%T)

# Immediately exi on failure
set -e

# Always run when script finishes
function finish() {
	local RETVAL=$?
	rm -rf $tempdir
	if [[ $RETVAL -eq 0 ]]; then
		echo -e "Find a <server>:\n> ls -l /etc/openvpn/ovpn*"
		echo -e "Start VPN service:\n> sudo openvpn <server>"
	else
		echo -e "Exited with code: $RETVAL"
	fi
}
eval trap "'finish $0 $@'" EXIT

# Install packages
sudo apt install -y \
	openvpn \
	unzip

wget \
	-O $tempdir/ovpn.zip \
	https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
unzip -q -d $tempdir $tempdir/ovpn.zip
echo "Files extracted to $tempdir"

sudo rm -rf \
	/etc/openvpn/ovpn_tcp \
	/etc/openvpn/ovpn_udp

sudo cp -r \
	$tempdir/ovpn_tcp \
	$tempdir/ovpn_udp \
	/etc/openvpn

