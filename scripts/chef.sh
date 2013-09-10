#!/bin/sh
set -ex

sudo pacman --noconfirm -S base-devel ruby rsync
sudo gem install chef --bindir /usr/bin
