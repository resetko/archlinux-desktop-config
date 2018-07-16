.PHONY: install-yaourt create-tmp-dir install-prerequirements
.PHONY: create-user-dirs install-packages fix-configs post-install

create-tmp-dir:
	@./scripts/create-tmp-dir.sh

install-prerequirements: create-tmp-dir
	@./scripts/install-prerequirements.sh

install-yaourt: install-prerequirements
	@./scripts/install-yaourt.sh

create-user-dirs: install-yaourt
	@./scripts/create-user-dirs.sh

install-packages: create-user-dirs
	@./scripts/install-packages.sh

fix-configs: install-packages
	@./scripts/fix-configs.sh

post-install: fix-configs
	@./scripts/post-install.sh

install: post-install