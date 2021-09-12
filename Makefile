repo     := $(shell git rev-parse --show-toplevel)
cur_dir  := $(shell pwd)

help:
	@echo "\n\tAvailable make Targets:\n"
	@grep PHONY: Makefile | cut -d: -f2 | sed '1d;s/^/make/'

.PHONY: purge # delete .DS_Store and othre dirs/files
purge:
	find ${repo} -type f -name .DS_Store -exec rm {} \;

.PHONY: acl # chmod to 644
acl:
	find ${repo} -name \*.sh -exec chmod 644 {} \;

.PHONY: latest
latest:
	@bash get_latest_vers.sh

.PHONY: vscode
vscode:
	@bash install_codeserver.sh
	@bash install_vscode_ext.sh

.PHONY: gitui
gitui:
	@bash install_gitui.sh

.PHONY: azure
azure:
	@bash install_azcollection.sh

.PHONY: hc
hc:
	@bash install_hc_product.sh

