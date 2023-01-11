{ config, pkgs, ... }:

{
  home.username = "tarkah";
  home.homeDirectory = "/home/tarkah";

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
      };
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
  };
}
