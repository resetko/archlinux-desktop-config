#!make

TMP_DIR = /tmp/preinittpm
PACMAN_INSTALL_FLAGS = -Sy --needed --noconfirm

create-user:
	pacman ${PACMAN_INSTALL_FLAGS} sudo
	groupadd -r sudo
	useradd -m -U -G sudo ${USER_NAME}
	passwd ${USER_NAME}
	echo "%sudo  ALL=(ALL) ALL" > /etc/sudoers.d/resetko

make-tmp-dir:
	mkdir -p ${TMP_DIR}

prerequirements: make-tmp-dir
	sudo pacman ${PACMAN_INSTALL_FLAGS} reflector
	sudo reflector --verbose --latest 200 --country France,Germany,Poland --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	sudo pacman ${PACMAN_INSTALL_FLAGS} base-devel wget

yay: prerequirements
	cd ${TMP_DIR} && \
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz && \
	tar -xzvf yay.tar.gz && \
	cd yay && \
	makepkg -sri --noconfirm

create-user-dirs: yay
	mkdir -p ${HOME}/Screenshots
	mkdir -p ${HOME}/.wallpapers

install-packages: create-user-dirs
	yay -S --needed --noconfirm --removemake \
		evince \
		flameshot \
		google-chrome \
		gtk-engine-murrine \
		i3-git \
		lightdm \
		lightdm-gtk-greeter \
		nitrogen \
		numix-circle-icon-theme-git \
		numix-gtk-theme-git \
		numix-icon-theme-git \
		oh-my-zsh-git \
		openssh \
		picom-git \
		polybar-git \
		rofi \
		terminus-font-ttf \
		terminus-font \
		ttf-dejavu \
		ttf-font-awesome \
		ttf-roboto \
		vlc \
		xdg-user-dirs \
		xfce4 \
		xfce4-goodies \
		xorg-apps \
		xorg-server \
		zenity
	yay -Yc --noconfirm
	yay -Sc --noconfirm

fix-configs: install-packages
	sudo sed -i s/PKGEXT=\'.pkg.tar.xz\'/PKGEXT=\'.pkg.tar\'/g /etc/makepkg.conf
	sudo sed -i s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g /etc/lightdm/lightdm.conf
	sudo sed -i s/#theme-name=/theme-name=Numix/g /etc/lightdm/lightdm-gtk-greeter.conf
	sudo sed -i "s/#font-name=/font-name=Roboto Regular/g" /etc/lightdm/lightdm-gtk-greeter.conf
	sudo sed -i s/#icon-theme-name=/icon-theme-name=Numix-Circle/g /etc/lightdm/lightdm-gtk-greeter.conf
	sudo sed -i s/#Color/Color/g /etc/pacman.conf
	sudo sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"gentoo\"/g /usr/share/oh-my-zsh/zshrc
	sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
	cp /usr/share/oh-my-zsh/zshrc ${HOME}/.zshrc
	cp -vr ./files/home/user/. ${HOME}/

post-install: fix-configs
	xdg-user-dirs-update
	sudo chsh -s /usr/bin/zsh root
	sudo chsh -s /usr/bin/zsh ${USER}
