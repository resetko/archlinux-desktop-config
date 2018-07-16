source ./scripts/constants.sh

echo "Installing initially required packages"

sudo pacman -Sy --needed --noconfirm base-devel wget gvim