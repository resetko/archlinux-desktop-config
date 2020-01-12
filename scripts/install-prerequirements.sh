source ./scripts/constants.sh

echo "Installing initially required packages"

sudo pacman -Sy --needed --noconfirm base-devel wget reflector
reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist