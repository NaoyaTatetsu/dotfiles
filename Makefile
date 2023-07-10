.PHONY: setup_local
setup_local:
	@echo "Start installing brew..."
	sh scripts/setup_local.sh

.PHONY: apps
apps:
	@echo "Start installing brew apps..."
	sh scripts/install_brew_app.sh
	@echo "Completed installing all apps."

.PHONY: system_preference
system_preference:
	@echo "Start setting system preferences..."
	sh scripts/set_system_preference.sh
	@echo "Completed setting system preferences."