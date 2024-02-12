#!make

TMP_DIR = /tmp/preinittmp
PACMAN_INSTALL_FLAGS = -Sy --needed --noconfirm
USER_NAME = resetko

create-user:
	pacman ${PACMAN_INSTALL_FLAGS} sudo
	groupadd -r sudo
	useradd -m -U -G sudo ${USER_NAME}
	passwd ${USER_NAME}
	echo "%sudo  ALL=(ALL) ALL" > /etc/sudoers.d/sudogroup

make-tmp-dir:
	mkdir -p ${TMP_DIR}

prerequirements: make-tmp-dir
	sudo pacman ${PACMAN_INSTALL_FLAGS} reflector
	sudo reflector --verbose --latest 200 --country France,Germany,Poland,Netherlands --protocol https --sort rate --save /etc/pacman.d/mirrorlist
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
		alacritty \
		blueman \
		cage \
		evince \
		flameshot \
		flameshot-git \
		gnome-themes-extra \
		google-chrome \
		google-chrome-stable \
		greetd-regreet-git \
		grim \
		jq \
		kanshi \
		network-manager-applet \
		nm-applet \
		noto-fonts \
		noto-fonts-emoji \
		numix-icon-theme-git \
		numix-icon-theme-git \
		oh-my-zsh-git \
		openssh \
		pavucontrol \
		pipewire \
		pipewire-pulse \
		sway \
		swayidle \
		swaylock \
		swaync \
		terminus-font-ttf \
		thunar \
		tofi \
		ttf-font-awesome \
		vlc \
		waybar \
		wireplumber \
		wl-clipboard \
		xdg-desktop-portal-wlr \
		xdg-user-dirs  \
		xorg-xwayland
	yay -Yc --noconfirm
	yay -Sc --noconfirm

fix-configs: install-packages
	sudo sed -i s/Exec=sway/Exec=startsway/g /usr/share/wayland-sessions/sway.desktop
	sudo sed -i s/PKGEXT=\'.pkg.tar.xz\'/PKGEXT=\'.pkg.tar\'/g /etc/makepkg.conf
	sudo sed -i s/#Color/Color/g /etc/pacman.conf
	sudo sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"gentoo\"/g /usr/share/oh-my-zsh/zshrc
	sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
	sudo cp -vr ./files/etc /etc
	sudo cp -vr ./files/usr /usr
	cp /usr/share/oh-my-zsh/zshrc ${HOME}/.zshrc
	cp -vr ./files/home/user/. ${HOME}/

post-install: fix-configs
	systemctl --user start xdg-user-dirs-update.service
	systemctl --user enable wireplumber.service
	systemctl --user enable pipewire.service
	systemctl --user enable pipewire-pulse.service
	systemctl --user enable swaync.service
	sudo systemctl enable bluetooth.service
	sudo systemctl enable greetd.service
	sudo chsh -s /usr/bin/zsh root
	sudo chsh -s /usr/bin/zsh ${USER}

setup: post-install