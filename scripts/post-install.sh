source ./scripts/constants.sh

echo "Running post install scripts"

xdg-user-dirs-update
sudo chsh -s /usr/bin/zsh root
sudo chsh -s /usr/bin/zsh $USER