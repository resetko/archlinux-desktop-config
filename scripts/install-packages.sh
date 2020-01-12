source ./scripts/constants.sh

echo "Installing packages"

yay -S --needed --noconfirm \
    flameshot \
    google-chrome \
    gtk-engine-murrine \
    i3-git \
    lightdm \
    lightdm-gtk-greeter \
    nitrogen \
    numix-circle-icon-theme-git \
    numix-gtk-theme \
    numix-icon-theme-git \
    oh-my-zsh-git \
    openssh \
    picom-git \
    rofi \
    terminus-font \
    ttf-dejavu \
    ttf-font-awesome \
    ttf-roboto \
    xdg-user-dirs \
    xfce4 \
    xfce4-goodies \
    xorg-apps \
    xorg-server \
    zenity
