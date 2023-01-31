{stdenv, ...}: let
  fontSize =
    if stdenv.isDarwin
    then "14.0"
    else "11.0";
in ''
  env:
    TERM: xterm-256color
  shell:
    program: /bin/zsh
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
''
