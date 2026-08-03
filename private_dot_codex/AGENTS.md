# Git workflow

- Never use `agent/` for branches, even if a skill suggests it; use a purpose-based prefix such as `fix/`, `feat/`, `docs/`, or `chore/`.
- Use Conventional Commits for commit messages.
- Use authenticated `gh` for all GitHub writes; use connectors only for read-only access.

# Dotfiles

- User configuration files are managed with chezmoi in the `dotfiles` repository.
- Treat `~/.local/share/chezmoi` as the source of truth: edit the corresponding source file there instead of editing a managed file under `$HOME` directly.
- After changing a managed setting, review `chezmoi diff` and apply it with `chezmoi apply`.
