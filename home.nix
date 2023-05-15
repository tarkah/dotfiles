{
  config,
  pkgs,
  user,
  lib,
  ...
}: let
  stdenv = pkgs.stdenv;
  alacritty = import ./alacritty/alacritty.nix {
    inherit stdenv;
  };
  writeIf = cond: message:
    if cond
    then message
    else "";
in {
  home = {
    username = user;
    stateVersion = "22.11";

    homeDirectory =
      if stdenv.isDarwin
      then "/Users/${user}"
      else "/home/${user}";

    packages = with pkgs; [
      neovim
      helix
    ];

    sessionVariables = {
      EDITOR = "hx";
    };

    file.".tmux.conf".source = ./tmux/.tmux.conf;

    activation = {
      linkDesktopApplications = lib.mkIf stdenv.isLinux {
        after = ["writeBoundary" "createXdgUserDirectories"];
        before = [];
        data = ''
          rm -rf ${config.xdg.dataHome}/"applications/home-manager"
          mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
          cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
        '';
      };
    };
  };

  targets.genericLinux.enable = stdenv.isLinux;

  programs = {
    home-manager.enable = true;

    bash.enable = stdenv.isLinux;

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls -al";
        vim = "nvim";
        update =
          if stdenv.isDarwin
          then "home-manager switch --flake .#tarkah@darwin"
          else "home-manager switch --flake .#tarkah@linux";
        develop = "nix develop path:$(pwd)/.nix";
        z = "zellij attach -c default";
      };
      initExtra = ''
        # Fpath
        fpath+=~/.zfunc

        # Sourcing
        function __source () [ -f $1 ] && . $1
        __source "$HOME/.cargo/env"
        __source "$HOME/.ghcup/env"
        unfunction __source

        # Bindings
        bindkey -e
        bindkey '^ ' autosuggest-accept
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^[[H" beginning-of-line
        bindkey "^[[F" end-of-line
        bindkey "^[[3~" delete-char

        # Path
        path=($HOME/.local/bin $path)
        ${writeIf stdenv.isDarwin ''
          path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
        ''}
        export PATH

        # Functions
        function nvim() [ -d ".nix" ] && nix run path:./.nix -- "$@" || command nvim "$@"
      '';
    };

    zellij.enable = true;
    starship.enable = true;
    go.enable = true;
  };

  xdg = {
    enable = true;

    configFile."zellij" = {
      source = ./zellij;
      recursive = true;
    };

    configFile."starship.toml" = {
      source = ./starship/starship.toml;
    };

    configFile."alacritty/alacritty.yml".text = alacritty;

    configFile."helix/config.toml" = {
      source = ./helix/config.toml;
    };
  };
}
