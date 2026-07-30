# Arch Wayland dotfiles

Arch Linux、Hyprland、UWSMを中心としたworkstation設定です。

- Ansible: 公式パッケージ、system service、udev rule
- chezmoi: `$HOME` 以下の設定とsystemd user unit
- UWSM/systemd: Wayland sessionと常駐プロセス

## 対象

現在の主対象はPanasonic Let's Note CF-SZ6です。Hyprland設定自体は
汎用モニター設定を使い、CF-SZ6固有のWheel Pad設定だけを分離しています。

このリポジトリはOSイメージ、ブートローダー、ディスク構成、NetworkManager
connection、Tailscale state、SSH/GPG keyを管理しません。

## 新規セットアップ

`sudo`を使える一般ユーザーを作成したArch Linux環境で次を実行します。

```bash
sudo pacman -Syu --needed git
git clone https://github.com/0xNOY/dotfiles.git \
  "$HOME/.local/share/chezmoi"
cd "$HOME/.local/share/chezmoi"
./bootstrap
```

`bootstrap` は公式リポジトリのパッケージだけを導入し、Ansibleとchezmoiを
適用します。適用前に確認する場合は個別に実行してください。

```bash
cd ansible
ansible-playbook --check --diff site.yml
cd ..
chezmoi diff
```

## 明示的な追加操作

AURのPKGBUILDは第三者コードです。内容を確認し、`yay`を自分で導入した後に
明示的なタグを指定します。

```bash
cd ansible
sudo -v
ansible-playbook site.yml --tags aur
```

Docker groupとADB groupはホスト上で強い権限を与えるため、既定では変更しません。

```bash
ansible-playbook site.yml --tags privileged
```

旧i3/Picom/Polybar/Xorg desktop packagesの削除も明示操作です。

```bash
ansible-playbook site.yml --tags cleanup
```

## セッション

TTYから次のどちらかで起動します。

```bash
uwsm start hyprland.desktop
x
```

Waybar、Mako、Hypridle、polkit agentは
`graphical-session.target`配下のsystemd user serviceとして起動します。
Fcitx5はUWSMが処理するXDG autostartから起動します。

設定変更後は次を確認します。

```bash
hyprctl configerrors
systemctl --user --failed
systemctl --failed
```

## セキュリティ

公開リポジトリです。秘密情報や接続状態はコミットしません。詳細は
[SECURITY.md](SECURITY.md)を参照してください。
