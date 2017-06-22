#!/bin/bash
TMP_PATH=/tmp/preinittpm
CURRENT_PATH="$( cd `dirname "$0"` && pwd)"

# @todo install zsh, copy zshrc for root and current user and replace theme name

# installing base packages
sudo pacman -Sy --needed --noconfirm base-devel wget gvim

mkdir -p $TMP_PATH
cd $TMP_PATH

# installing yaourt
wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xzvf package-query.tar.gz
cd package-query
makepkg -sri --noconfirm
cd $TMP_PATH
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xzvf yaourt.tar.gz
cd yaourt
makepkg -sri --noconfirm

# configuration for makepkg and yaourt
sudo sed -i s/#EDITFILES=1/EDITFILES=0/g /etc/yaourtrc
sudo sed -i s/#BUILD_NOCONFIRM=0/BUILD_NOCONFIRM=0/g /etc/yaourtrc
sudo sed -i s/PKGEXT=\'.pkg.tar.xz\'/PKGEXT=\'.pkg.tar\'/g /etc/makepkg.conf
sudo sed -i -E s/^TMPDIR.*$//g /etc/yaourtrc
echo "TMPDIR=/home/\$USER/.yaourt-tmp" | sudo tee -a /etc/yaourtrc
mkdir -p $HOME/.yaourt-tmp


mkdir -p $HOME/Screenshots

yaourt -S --needed --noconfirm xdg-user-dirs i3 rofi i3blocks zenity escrotum-git google-chrome numix-icon-theme-git numix-circle-icon-theme-git numix-themes-archblue-git xorg-server xorg-apps lightdm lightdm-gtk-greeter xfce4 xfce4-goodies gtk-engine-murrine ttf-dejavu ttf-google-fonts-git oh-my-zsh-git openssh

sudo sed -i s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g /etc/lightdm/lightdm.conf

sudo sed -i s/#theme-name=/theme-name=Numix-ArchBlue/g /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i s/#icon-theme-name=/icon-theme-name=Numix-Circle/g /etc/lightdm/lightdm-gtk-greeter.conf

xdg-user-dirs-update

sudo sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"gentoo\"/g /usr/share/oh-my-zsh/zshrc
cp /usr/share/oh-my-zsh/zshrc $HOME/.zshrc
sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc

sudo chsh -s /usr/bin/zsh root
sudo chsh -s /usr/bin/zsh $USER

cp -r $CURRENT_PATH/.config $HOME/
cp $CURRENT_PATH/.Xresources $HOME/
cp $CURRENT_PATH/.gtkrc-2.0 $HOME/
