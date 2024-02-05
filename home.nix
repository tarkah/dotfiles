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
  zellij-config = pkgs.callPackage ./zellij/config.nix {};
  helix-languages = pkgs.callPackage ./helix/languages.nix {};
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
      helix
      nil
    ];

    sessionVariables = {
      EDITOR = "hx";
    };

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

    # macos workaround
    file.".zshrc".text = ''
      ${writeIf stdenv.isDarwin ''
        fish
      ''}
    '';
  };

  targets.genericLinux.enable = stdenv.isLinux;

  programs = {
    home-manager.enable = true;

    bash.enable = stdenv.isLinux;

    fish = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls -al";
        update =
          if stdenv.isDarwin
          then "home-manager switch --flake .#${user}@darwin"
          else "home-manager switch --flake .#${user}@linux";
        develop = "nix develop path:$(pwd)/.nix";
        z = "zellij attach -c default";
        dlang = "source $(~/.dlang/install.sh -p ~/.dlang install ldc -a)";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellInit = ''
        # Sourcing
        function __source
          if test -f $argv[1]
            source $argv[1]
          end
        end
        __source "$HOME/.fish.local"
        functions -e __source

        # Bindings
        function fish_user_key_bindings
            bind -k nul accept-autosuggestion
        end
        # bindkey -e
        # bindkey '^ ' autosuggest-accept
        # bindkey "^[[1;5C" forward-word
        # bindkey "^[[1;5D" backward-word
        # bindkey "^[[H" beginning-of-line
        # bindkey "^[[F" end-of-line
        # bindkey "^[[3~" delete-char

        # Path
        fish_add_path $HOME/.cargo/bin
        fish_add_path $HOME/.local/bin
        ${writeIf stdenv.isDarwin ''
          fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
        ''}

        # Env
        set -gx DC ldc2
      '';
    };

    zellij.enable = true;
    starship.enable = true;
    go.enable = true;
  };

  xdg = {
    enable = true;

    configFile."zellij/config.kdl".text = zellij-config;
    configFile."zellij/layouts/default.kdl".source = ./zellij/layouts/default.kdl;

    configFile."starship.toml" = {
      source = ./starship/starship.toml;
    };

    configFile."alacritty/alacritty.toml".text = alacritty;

    configFile."helix/languages.toml".text = helix-languages;
    configFile."helix/config.toml" = {
      source = ./helix/config.toml;
    };
  };
}
