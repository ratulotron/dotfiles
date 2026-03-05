# Dotfiles Contribution Rules

These rules keep this dotfiles repo portable across office macOS, personal Fedora, and WSL Ubuntu.

## 1) Install source precedence (must follow)

When adding any new tool, choose exactly one primary source in this order:

1. **Homebrew (`Brewfile` / `Mac.Brewfile`)** for general CLI/system packages.
2. **Mise (`mise/.config/mise/config.toml`)** for runtimes and SDK/ecosystem binaries.
3. **Topical `install.sh`** only when neither Brew nor Mise is a good fit.

Do not install the same tool from multiple sources unless there is a documented fallback reason.

## 2) Where to put new tools

- Add to `Brewfile` for cross-platform CLI packages available in brew.
- Add to `Mac.Brewfile` for macOS-only apps/casks.
- Add to `[tools]` in `mise/.config/mise/config.toml` for language runtimes and ecosystem tools.
- Create `<topic>/install.sh` only as a last resort (or for setup steps not covered by brew/mise).

## 3) Machine-specific vs shared config

Shared defaults belong in versioned files.
Machine-specific and secret values must be in local (untracked) files, e.g. `~/.localrc`.

When adding a setting, ask:

- Is this valid for macOS + Linux + WSL?
- Is this host-specific or secret?

If host-specific/secret, keep it out of shared dotfiles.

## 4) Verification requirements for any tool change

At minimum, verify:

1. **Install path**: source file matches precedence policy (brew/mise/topic script).
2. **Executable presence**: command exists after install (`command -v <tool>`).
3. **Shell load safety**: zsh init/path files still load without errors.
4. **Stow safety**: `make check` passes.
5. **No duplicate ownership**: same tool is not managed by both brew and mise unless documented.

## 5) CI smoke test expectations

CI should validate repo integrity, not fully provision desktop apps.

Required smoke checks:

- Run shell syntax checks on all `install.sh` and key shell files.
- Validate `make check` can run in CI environment.
- Validate precedence invariants (brew first, then mise, then topic scripts).
- Optionally run lightweight `dot install` subset in Linux/macOS matrices (no GUI app installs).

## 6) Standard `install.sh` style

All topic installers should:

- Use `#!/bin/sh` and `set -e`.
- Be idempotent (safe to rerun).
- Check prerequisites explicitly with actionable errors.
- Print concise status messages.
- Exit non-zero on hard failure.

Avoid bespoke behavior when a common pattern exists.

## 7) README source-of-truth policy (keep low-overhead)

Do not maintain a giant per-tool table manually.
Instead, document:

- The precedence policy,
- The canonical locations (`Brewfile`, `Mac.Brewfile`, `mise/.config/mise/config.toml`, topic installers),
- A short "how to add a tool" checklist.

## 8) Changelog policy

A formal changelog is **optional**.
Use release notes/changelog entries only for user-visible or breaking behavior changes, such as:

- PATH/precedence behavior changes,
- default shell behavior changes,
- removed or renamed commands/topics.

Minor package bumps do not require changelog entries.

## 9) How to add a new tool (quick checklist)

1. Decide ownership by precedence: brew -> mise -> topic script.
2. Add config in exactly one place.
3. If needed, add shell init/path/completion in the relevant topic.
4. Run verification checks (`command -v`, `make check`, shell load test).
5. Update README only if workflow/policy changed.
