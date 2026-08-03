# Wallpaper provenance

## Previous local wallpaper

The former `wallpaper2_1920x1200.png` is intentionally not committed.

- SHA-256:
  `b9b17c70b1ed390820797d8b9fbfcf48c855a3d3b76c1d93bb3e4c1bfc197343`
- The PNG contains no author, copyright, source, title, or description
  metadata.
- Searches by filename and hash did not identify an authoritative original
  source.
- Visually similar wallpaper sites use inconsistent terms, including
  attribution requirements and personal-use-only restrictions.

There is therefore no sufficient basis to redistribute that file.
When it is already present locally, it remains the preferred wallpaper.

## Repository wallpaper

`private_dot_local/private_share/backgrounds/hyprland-theme.png` was newly
generated on
2026-07-31 with OpenAI's built-in image generation tool. No image was
provided to the generator as an input.

OpenAI's Terms of Use state that, as between the user and OpenAI and to the
extent permitted by applicable law, the user owns the output:

<https://openai.com/policies/terms-of-use/>

The generated output was center-cropped and resized to 1920 by 1200 pixels,
then stripped of metadata with ImageMagick.

Generation prompt:

> Create an entirely original 16:10 desktop wallpaper with dense,
> overlapping palm fronds emerging from deep shadow. Use polished
> photorealistic botanical texture, a quiet dark center, soft diffused side
> light, and a near-black, forest-green, desaturated olive palette. Do not
> copy a specific photograph. Include no people, animals, buildings, text,
> logos, signatures, borders, or watermarks.

At each `chezmoi apply`, `run_before_select-wallpaper.sh` updates
`~/.local/share/backgrounds/hyprland-selected.png`. It points to the previous
local wallpaper when available, or to the generated repository wallpaper
otherwise.
