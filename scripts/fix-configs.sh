source ./scripts/constants.sh

echo "Fixing configs"

sudo sed -i s/PKGEXT=\'.pkg.tar.xz\'/PKGEXT=\'.pkg.tar\'/g /etc/makepkg.conf

sudo sed -i s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g /etc/lightdm/lightdm.conf

sudo sed -i s/#theme-name=/theme-name=Numix/g /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i s/#font-name=/font-name=Roboto Regular/g /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i s/#icon-theme-name=/icon-theme-name=Numix-Circle/g /etc/lightdm/lightdm-gtk-greeter.conf

sudo sed -i s/#Color/Color/g /etc/pacman.conf

sudo sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"gentoo\"/g /usr/share/oh-my-zsh/zshrc

sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
cp /usr/share/oh-my-zsh/zshrc $HOME/.zshrc

cp -vr $FILES_PATH/home/user/. $HOME/