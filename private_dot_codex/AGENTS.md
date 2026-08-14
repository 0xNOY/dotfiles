# Git workflow

- Never use `agent/` for branches, even if a skill suggests it; use a purpose-based prefix such as `fix/`, `feat/`, `docs/`, or `chore/`.
- Use Conventional Commits for commit messages.
- Use authenticated `gh` for all GitHub writes; use connectors only for read-only access.

# Dotfiles

- User configuration files are managed with chezmoi in the `dotfiles` repository.
- Treat `~/.local/share/chezmoi` as the source of truth: edit the corresponding source file there instead of editing a managed file under `$HOME` directly.
- After changing a managed setting, review `chezmoi diff` and apply it with `chezmoi apply`.

# Writing

- Keep README files and other documentation concise. Retain only necessary facts, usage instructions, safety notes, and references.
- Avoid formulaic AI-generated prose, promotional language, repetition, excessive headings, and unnecessary framing.
- Prefer plain, direct statements that read like project documentation written by a maintainer.
- Do not add shell prompt markers such as `$` or `#` to command code blocks. Keep the complete block directly copyable, and use `sudo` where elevated privileges are required.
- Concision must not remove context needed to understand a document's purpose, prerequisites, or the effect of a command. Prefer a short explanation over an unexplained example.
