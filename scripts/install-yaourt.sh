source ./scripts/constants.sh

echo "Installing package-query"
cd $TMP_PATH
wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xzvf package-query.tar.gz
cd package-query
makepkg -sri --noconfirm

echo "Installing yaourt"
cd $TMP_PATH
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xzvf yaourt.tar.gz
cd yaourt
makepkg -sri --noconfirm