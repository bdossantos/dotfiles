# GitHub Copilot Instructions

## Repository Overview

This repository contains personal dotfiles for Benjamin Dos Santos, managed
with [GNU Stow](https://www.gnu.org/software/stow/). It includes configuration
files for Bash, Vim, tmux, Git, Ghostty, SSH, and various command-line tools.

## Commit Messages

All commits **must** follow the [Conventional Commits](https://www.conventionalcommits.org/)
specification using the Angular commit message format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

- **type** (required): one of `build`, `ci`, `docs`, `feat`, `fix`, `perf`,
  `refactor`, `revert`, `style`, or `test`
- **scope** (optional): the area of the change (e.g. `bash`, `vim`, `tmux`,
  `git`, `ssh`, `ghostty`)
- **subject** (required): short description in imperative, present tense; no
  capitalization; no trailing period; max 100 characters per line
- **body** (optional): motivation and contrast with previous behaviour
- **footer** (optional): breaking changes (`BREAKING CHANGE: …`) and issue
  references (`Closes #N`)

Examples:

```
feat(bash): add fzf keybindings to .bashrc

fix(vim): correct swapfile directory path

docs: update README installation steps

ci: upgrade shellcheck to v0.10.0
```

## Code Style

- Follow `.editorconfig` rules: 2-space indentation, LF line endings, UTF-8,
  trailing whitespace trimmed, final newline, 80-character line length limit
  (Makefiles use tabs)
- Shell scripts must be POSIX-compatible where possible and pass `shellcheck`
- Shell scripts must be formatted with `shfmt -i 2 -ci -s` before committing
- Use `#!/usr/bin/env bash` shebangs for Bash scripts
- Keep YAML files consistent with existing formatting (2-space indent, `---`
  document start marker)
- Python code must be compatible with Python 3.9+

## Updating LazyVim and Plugins

All plugins are pinned to exact commits in two places:

- `lazy-lock.json` — the authoritative lock file written by Lazy.nvim
- `.config/nvim/lua/plugins/pins.lua` — Lua spec that re-applies those pins
  at startup so the locked commits are enforced even on a fresh install

`lazy.nvim` itself is also pinned: the `git checkout <commit>` call in
`.config/nvim/lua/config/lazy.lua` must be kept up to date.

### Step-by-step update process

1. **Update all plugins inside Neovim**

   ```
   :Lazy update
   ```

   Lazy.nvim resolves the latest commits and writes them to `lazy-lock.json`.

2. **Sync `pins.lua` from `lazy-lock.json`**

   For every plugin that already has an entry in `pins.lua`, replace its
   `commit` value with the matching commit from `lazy-lock.json`.

   To add a newly-tracked plugin, append a line following the existing
   pattern:

   ```lua
   { "owner/plugin-name", commit = "<sha from lazy-lock.json>" },
   ```

3. **Update the pinned `lazy.nvim` commit** (when lazy.nvim itself changed)

   Find the commit Lazy cloned by running inside Neovim:

   ```
   :lua print(require("lazy.manage.git").info(vim.fn.stdpath("data") .. "/lazy/lazy.nvim").commit)
   ```

   Then update the `git checkout` line in
   `.config/nvim/lua/config/lazy.lua`:

   ```lua
   vim.fn.system({ "git", "-C", lazypath, "checkout", "<new-commit>" })
   ```

4. **Commit the changes**

   ```
   feat(nvim): update lazy.nvim and plugins to latest commits
   ```

## Testing

Run `make test` (which invokes `pre-commit run --all-files`) to lint and
validate all changes before committing.
