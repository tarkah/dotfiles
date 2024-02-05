{stdenv, ...}: let
  fontSize =
    if stdenv.isDarwin
    then "14.0"
    else "11.0";
  shell =
    if stdenv.isDarwin
    then "zsh"
    else "fish";
in ''
  [colors.bright]
  black = "#6f5d63"
  blue = "#e88c6f"
  cyan = "#d1d1e0"
  green = "#9f9f7c"
  magenta = "#ffb9cc"
  red = "#e06b75"
  white = "#ffffff"
  yellow = "#fff27a"

  [colors.normal]
  black = "#1f1e20"
  blue = "#ffa07a"
  cyan = "#bfbfcf"
  green = "#b1b695"
  magenta = "#f6b6c9"
  red = "#c05862"
  white = "#f5f5f5"
  yellow = "#f5d76e"

  [colors.primary]
  background = "#2b292d"
  foreground = "#fecdb2"

  [env]
  TERM = "alacritty"

  [shell]
  program = "${shell}"

  [font]
  size = ${fontSize}

  [font.bold]
  family = "Hack Nerd Font"
  style = "Bold"

  [font.bold_italic]
  family = "Hack Nerd Font"

  [font.italic]
  family = "Hack Nerd Font"
  style = "Italic"

  [font.normal]
  family = "Hack Nerd Font"
  style = "Regular"

  [[keyboard.bindings]]
  chars = "\u001BF"
  key = "Right"
  mods = "Alt"

  [[keyboard.bindings]]
  chars = "\u001BB"
  key = "Left"
  mods = "Alt"
''
