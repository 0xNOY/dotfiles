# Arch Wayland dotfiles

Arch Linux、Hyprland、UWSMを中心としたworkstation設定です。

- Ansible: 公式パッケージ、system service、udev rule
- chezmoi: `$HOME` 以下のHyprlandテーマ設定とsystemd user unit
- UWSM/systemd: Wayland sessionと常駐プロセス

## 対象

現在の主対象はPanasonic Let's Note CF-SZ6です。Hyprland設定自体は
汎用モニター設定を使い、CF-SZ6固有のWheel Pad設定だけを分離しています。

Wheel Pad daemonはAUR版ではなく、開発中の
[`0xNOY/letsnote-wheelpad`](https://github.com/0xNOY/letsnote-wheelpad)を
既知の動作確認済みcommitへ固定してソースからビルドします。更新する場合は
`letsnote_wheelpad_version`を変更し、実機で安全性と操作感を再確認してください。
物理入力デバイスを排他grabする開発版のため、自動起動はしません。通常のクリックと
タップを確認できるTTYまたは別の入力デバイスを用意してから、明示的に起動します。

```bash
touch ~/.config/letsnote-wheelpad/enabled
systemctl --user start letsnote-wheelpad.service
```

問題があれば直ちに停止すると、物理タッチパッドをlibinputへ戻せます。

```bash
systemctl --user stop letsnote-wheelpad.service
rm ~/.config/letsnote-wheelpad/enabled
```

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

HyprpaperとHyprlockは、ローカルに従来の
`~/Pictures/wallpapers/wallpaper2_1920x1200.png`があれば優先して表示します。
存在しない環境では、リポジトリ同梱の
`~/.local/share/backgrounds/hyprland-theme.png`へ自動的にフォールバックします。
選択結果は`~/.local/share/backgrounds/hyprland-selected.png`というsymlinkです。
従来画像はライセンスが確認できないためGitには含めません。生成画像の出典調査と
生成条件は`docs/WALLPAPER.md`に記録しています。

Ghostty、Waybar、Rofi、Mako、Hyprlock、FontconfigとFish promptもchezmoiで
管理します。Fish pluginは`chezmoi apply`時にFisherで同期されます。

Gitのidentity、ブラウザprofile、エディタのworkspace履歴など、Hyprlandテーマと
無関係な個人設定は管理しません。

設定変更後は次を確認します。

```bash
hyprctl configerrors
systemctl --user --failed
systemctl --failed
```

## セキュリティ

公開リポジトリです。秘密情報や接続状態はコミットしません。詳細は
[SECURITY.md](SECURITY.md)を参照してください。
