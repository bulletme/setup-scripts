#!/usr/bin/env bash

sudo apt update

# I think this needs to be removed for Mint
# I forgot why
# This is why you need to document your code
sudo apt remove -y vivo

sudo apt install -y x11vnc

# Recommended start command:
# x11vnc -dontdisconnect -notruecolor -noxfixes -shared -forever -rfbport 5900 -rfbauth ~/.vnc/passwd

