# Security policy

## Public repository boundary

The repository intentionally excludes:

- private and public SSH/GPG keys
- tokens, passwords, cookies, and cloud credentials
- NetworkManager connection profiles
- Tailscale state
- browser and application profiles
- Fcitx dictionaries and generated caches
- machine journals, histories, and package caches
- third-party wallpapers and other assets without a clear redistribution
  license

The bundled wallpaper was newly created with OpenAI's image generation tool.
No third-party image was supplied as an input. Its provenance and generation
prompt are recorded in `docs/WALLPAPER.md`.

Fcitx configuration files are deployed with private permissions, even though
the committed values are not secret.

## Privileged operations

Ansible tasks that execute AUR PKGBUILDs, add the login user to privileged
groups, or remove packages require an explicit tag. Review these operations
before running them:

- `--tags aur`
- `--tags privileged`
- `--tags cleanup`

Membership in the `docker` group is effectively root-equivalent. AUR
PKGBUILDs are third-party code and are not made trustworthy by this
repository.

The experimental `0xNOY/letsnote-wheelpad` source is pinned to a full commit
ID and a SHA-256-verified source archive. Cargo builds with `--locked`. The
daemon is not started unless the user creates the documented opt-in marker,
because it exclusively grabs the physical touchpad.

## Reporting

Do not open a public issue containing a credential or other sensitive value.
Revoke the affected credential first, then use a private contact method listed
on the repository owner's GitHub profile.
