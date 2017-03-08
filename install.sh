#!/bin/bash
TMP_PATH=/tmp/preinittpm

sudo pacman -Sy base-devel

mkdir -p $TMP_PATH
cd $TMP_PATH

wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xzvf package-query.tar.gz
cd package-query
makepkg -sri

cd $TMP_PATH
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xzvf yaourt.tar.gz
cd yaourt
makepkg -sri

sudo yaourt -S i3 rofi
