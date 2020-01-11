source ./scripts/constants.sh

echo "Installing yay"
cd $TMP_PATH
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xzvf yay.tar.gz
cd yay
makepkg -sri --noconfirm