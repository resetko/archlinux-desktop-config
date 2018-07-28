source ./scripts/constants.sh

echo "Fixing configs"

HOME_FILES_PATH="$FILES_PATH/home/user"

# configuration for makepkg and yaourt
sudo sed -i s/#EDITFILES=1/EDITFILES=0/g /etc/yaourtrc
sudo sed -i s/#BUILD_NOCONFIRM=0/BUILD_NOCONFIRM=0/g /etc/yaourtrc
sudo sed -i s/PKGEXT=\'.pkg.tar.xz\'/PKGEXT=\'.pkg.tar\'/g /etc/makepkg.conf
sudo sed -i s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g /etc/lightdm/lightdm.conf
sudo sed -i s/#theme-name=/theme-name=Numix-Archblue/g /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i s/#icon-theme-name=/icon-theme-name=Numix-Circle/g /etc/lightdm/lightdm-gtk-greeter.conf

sudo sed -i -E s/^TMPDIR.*$//g /etc/yaourtrc
echo "TMPDIR=/home/\$USER/.yaourt-tmp" | sudo tee -a /etc/yaourtrc

sudo sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"gentoo\"/g /usr/share/oh-my-zsh/zshrc


sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
cp /usr/share/oh-my-zsh/zshrc $HOME/.zshrc

sudo cp -r $FILES_PATH/usr /
sudo cp -r $FILES_PATH/etc /

cp -r $FILES_PATH/home/user/. $HOME/