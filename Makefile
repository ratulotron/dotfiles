STOW_DIRS := $(wildcard */)
# Exclude special dirs
PACKAGES := $(filter-out .git/ script/ test/ bin/ , $(STOW_DIRS))

# Exclude macos on Linux
ifneq ($(shell uname),Darwin)
	PACKAGES := $(filter-out macos/ , $(PACKAGES))
endif

.PHONY: all install update stow clean unlink-legacy

all: stow

install:
	@echo "› Installing dependencies..."
	@find . -name install.sh -exec {} \;

stow: unlink-legacy
	@echo "› Stowing packages..."
	@stow --verbose --target=$$HOME --restow --ignore='^[^.]' $(PACKAGES)

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
	@find $$HOME -maxdepth 4 -type l \
		\( -lname "$$HOME/.dotfiles/*/*.symlink" \
		   -o -lname "$$HOME/.dotfiles/*/*.symlink.*" \
		   -o -lname "$$HOME/.dotfiles/*/*.symlink.d" \) \
		-print -delete 2>/dev/null || true
