{
  stdenv,
  profile,
  ...
}: let
  linker =
    if stdenv.isDarwin
    then ""
    else ''
      [target.x86_64-unknown-linux-gnu]
      rustflags = ["-C", "link-arg=-fuse-ld=mold"]
    '';
  extra =
    if profile == "work"
    then ''
      [net]
      git-fetch-with-cli = true
    ''
    else "";
in ''
  ${linker}

  ${extra}
''
