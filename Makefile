STOW_DIRS := $(wildcard */)
# Exclude special dirs
PACKAGES := $(filter-out .git/ script/ test/ bin/ , $(STOW_DIRS))

# Exclude macos on Linux
ifneq ($(shell uname),Darwin)
	PACKAGES := $(filter-out macos/ , $(PACKAGES))
endif

.PHONY: all install update stow clean

all: stow

install:
	@echo "› Installing dependencies..."
	@find . -name install.sh -exec {} \;

stow:
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
