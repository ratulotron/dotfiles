STOW_DIRS := $(wildcard */)
# Exclude special dirs
PACKAGES := $(filter-out .git/ script/ test/ bin/ , $(STOW_DIRS))

# Query for legacy *.symlink links to avoid stow conflicts
LEGACY_FIND = find $$HOME -maxdepth 4 -type l \
	\( -lname "$$HOME/.dotfiles/*/*.symlink" \
	   -o -lname "$$HOME/.dotfiles/*/*.symlink.*" \
	   -o -lname "$$HOME/.dotfiles/*/*.symlink.d" \)

# Common pre-existing config files that conflict with first stow on a new machine
STOW_CONFLICT_PATHS = \
	.config/atuin/config.toml \
	.config/ghostty/config \
	.gitconfig \
	.config/mise/config.toml \
	.config/starship.toml \
	.config/zellij/config.kdl \
	.zshrc

# Exclude macos on Linux
ifneq ($(shell uname),Darwin)
	PACKAGES := $(filter-out macos/ , $(PACKAGES))
endif

.PHONY: all install update stow clean unlink-legacy check backup-preexisting

all: stow

install:
	@echo "› Installing dependencies..."
	@# Run homebrew first (provides package manager)
	@if [ -f homebrew/install.sh ]; then ./homebrew/install.sh; fi
	@# Run mise second (provides language runtimes)
	@if [ -f mise/install.sh ]; then MISE_GLOBAL_CONFIG_FILE="$$PWD/mise/.config/mise/config.toml" ./mise/install.sh; fi
	@# Run remaining install scripts (LSPs, completions, etc.)
	@find . -name install.sh ! -path ./homebrew/install.sh ! -path ./mise/install.sh -exec {} \;

stow: unlink-legacy backup-preexisting
	@echo "› Stowing packages..."
	@stow --verbose --target=$$HOME --restow --ignore='^[^.]' $(PACKAGES)

backup-preexisting:
	@backup_root="$$HOME/.dotfiles-backup/$$(date +%Y%m%d-%H%M%S)"; \
	for rel in $(STOW_CONFLICT_PATHS); do \
		target="$$HOME/$$rel"; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			backup_path="$$backup_root/$$rel"; \
			mkdir -p "$$(dirname "$$backup_path")"; \
			mv "$$target" "$$backup_path"; \
			echo "  Backed up $$target -> $$backup_path"; \
		fi; \
	done

check:
	@echo "› Checking stow packages (dry run)..."
	@legacy_links=$$($(LEGACY_FIND) -print 2>/dev/null); \
	if [ -n "$$legacy_links" ]; then \
		echo "Legacy symlinks found:"; \
		echo "$$legacy_links"; \
		echo "  Run 'make stow' to clean them up."; \
		exit 1; \
	fi
	@stow --no --verbose --target=$$HOME --restow --ignore='^[^.]' $(PACKAGES)

update:
	@echo "› Updating dotfiles..."
	@git pull
	@$(MAKE) install
	@$(MAKE) stow

clean:
	@echo "› Removing symlinks..."
	@stow --verbose --target=$$HOME --delete $(PACKAGES)

unlink-legacy:
	@echo "› Removing legacy symlinks..."
	@$(LEGACY_FIND) -print -delete 2>/dev/null || true
