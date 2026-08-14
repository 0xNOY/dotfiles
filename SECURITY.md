# セキュリティポリシー

## 管理対象外

公開リポジトリのため、次の情報は管理しません。

- SSH/GPG key、token、password、cookie、cloud credential
- NetworkManagerの接続profile、Tailscaleのstate
- browserやapplicationのprofile
- Fcitxの辞書、cache、journal、履歴
- 再配布条件を確認できない第三者のasset

同梱壁紙の生成条件は[docs/WALLPAPER.md](docs/WALLPAPER.md)に記録しています。

## 明示的な操作

次のAnsible tagは既定で実行されません。

- `aur`: 第三者のPKGBUILDを実行
- `privileged`: ユーザーを`docker`と`adbusers`へ追加
- `cleanup`: 旧X11 packageとserviceを削除

実行前に対象taskを確認してください。`docker` groupはroot相当の権限を持ちます。

`0xNOY/letsnote-wheelpad`はcommit IDとSHA-256 checksumへ固定し、Cargoの
`--locked`でbuildします。物理touchpadを排他grabするため、明示的に有効化するまで
起動しません。

## 報告

秘密情報をGitHub Issueへ投稿しないでください。漏えいしたcredentialを失効させ、
リポジトリ所有者のGitHub profileに記載された非公開の連絡手段を使用してください。
