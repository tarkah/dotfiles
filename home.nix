{ config, pkgs, ... }:

let 
    alacritty = import ./alacritty/alacritty.nix {
        inherit pkgs;
    };
in
{
  home.username = "tarkah";
  home.homeDirectory = if pkgs.isDarwin
    then "/Users/tarkah"
    else "/home/tarkah";

  home.stateVersion = "22.11";

  home.packages = [ pkgs.neovim ];

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
          ls = "ls --color=auto";
          ll = "ls -al";
          vi = "nvim";
          vim = "nvim";
          update = if pkgs.isDarwin 
            then "home-manager switch --flake .#tarkah@darwin" 
            else "home-manager switch --flake .#tarkah";
      };
      initExtra = ''
        # Fpath
        fpath+=~/.zfunc

        # Sourcing
        function __source () [ -f $1 ] && . $1
        __source "$HOME/.cargo/env"
        __source "$HOME/.base16_theme"
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
        export PATH
      '';
    };

    zellij.enable = true;
    starship.enable = true;
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
  };

  home.file.".base16_theme".source = ./.base16_theme;
  home.file.".tmux.conf".source = ./tmux/.tmux.conf;
}
