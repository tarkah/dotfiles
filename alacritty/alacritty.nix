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
  env:
    TERM: alacritty
  shell:
    program: ${shell}
  font:
    normal:
      family: Hack Nerd Font
      style: Regular
    bold:
      family: Hack Nerd Font
      style: Bold
    italic:
      family: Hack Nerd Font
      style: Italic
    bold_italic:
      family: Hack Nerd Font
    size: ${fontSize}
  key_bindings:
    - { key: Right, mods: Alt, chars: "\x1BF" }
    - { key: Left,  mods: Alt, chars: "\x1BB" }
  colors:
    primary:
      background:   '#2b292d'
      foreground:   '#fecdb2'
    normal:
      black:        '#1f1e20'
      red:          '#c05862'
      green:        '#b1b695'
      yellow:       '#f5d76e'
      blue:         '#ffa07a'
      magenta:      '#f6b6c9'
      cyan:         '#bfbfcf'
      white:        '#f5f5f5'
    bright:
      black:        '#6f5d63'
      red:          '#e06b75'
      green:        '#9f9f7c'
      yellow:       '#fff27a'
      blue:         '#e88c6f'
      magenta:      '#ffb9cc'
      cyan:         '#d1d1e0'
      white:        '#ffffff'
''
