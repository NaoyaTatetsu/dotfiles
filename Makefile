.PHONY: apps
apps:
	@echo "start installing brew apps..."
	sh scripts/brew_app.sh
	@echo "end installing brew apps..."

.PHONY: system_preference
system_preference:
	@echo "start setting system preferences..."
	sh scripts/system_preferences.sh
	@echo "end setting system preferences..."