#!/bin/bash

cp ~/.Xresources .
cp ~/.gtkrc-2.0 .

mkdir -p .config/i3
cp  ~/.config/i3/config ./.config/i3/config

mkdir -p ./.config/gtk-3.0/
cp ~/.config/gtk-3.0/settings.ini ./.config/gtk-3.0/
