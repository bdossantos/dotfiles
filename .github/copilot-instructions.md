# GitHub Copilot Instructions

## Repository Overview

This repository contains personal dotfiles for Benjamin Dos Santos, managed
with [GNU Stow](https://www.gnu.org/software/stow/). It includes configuration
files for Bash, Vim, tmux, Git, Alacritty, SSH, and various command-line tools.

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
  `git`, `ssh`, `alacritty`)
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
- Use `#!/usr/bin/env bash` shebangs for Bash scripts
- Keep YAML files consistent with existing formatting (2-space indent, `---`
  document start marker)
- Python code must be compatible with Python 3.9+

## Testing

Run `make test` (which invokes `pre-commit run --all-files`) to lint and
validate all changes before committing.
