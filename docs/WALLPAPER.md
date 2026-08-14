# 壁紙の出典

## 従来の画像

`wallpaper2_1920x1200.png`は出典と再配布条件を確認できないため、リポジトリへ
含めません。ローカルに存在する場合は優先して使用します。

SHA-256: `b9b17c70b1ed390820797d8b9fbfcf48c855a3d3b76c1d93bb3e4c1bfc197343`

## 同梱画像

`private_dot_local/private_share/backgrounds/hyprland-theme.png`は、2026-07-31に
OpenAIの画像生成機能で入力画像を使わずに生成しました。生成後、1920×1200へcropと
resizeを行い、metadataを削除しています。outputの権利は
[OpenAI Terms of Use](https://openai.com/policies/terms-of-use/)を参照してください。

使用したprompt:

> Create an entirely original 16:10 desktop wallpaper with dense,
> overlapping palm fronds emerging from deep shadow. Use polished
> photorealistic botanical texture, a quiet dark center, soft diffused side
> light, and a near-black, forest-green, desaturated olive palette. Do not
> copy a specific photograph. Include no people, animals, buildings, text,
> logos, signatures, borders, or watermarks.

`run_before_select-wallpaper.sh`は`chezmoi apply`時に、従来画像または同梱画像を指す
`~/.local/share/backgrounds/hyprland-selected.png`を作成します。
