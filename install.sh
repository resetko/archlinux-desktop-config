#!/bin/sh

sh -c './scripts/create-tmp-dir.sh'
sh -c './scripts/install-prerequirements.sh'
sh -c './scripts/install-yay.sh'
sh -c './scripts/create-user-dirs.sh'
sh -c './scripts/install-packages.sh'
sh -c './scripts/fix-configs.sh'
sh -c './scripts/post-install.sh'