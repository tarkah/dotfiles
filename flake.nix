{
  description = "Home Manager configuration of tarkah";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "git+file:./nvim";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    neovim-flake,
    helix,
    ...
  }:
    with builtins; let
      user = "tarkah";

      systems = [
        {
          system = "x86_64-linux";
          name = "linux";
        }
        {
          system = "aarch64-darwin";
          name = "darwin";
        }
      ];

      homeConfigs = config:
        listToAttrs
        (map
          ({
            system,
            name,
          }: {
            name = "${user}@${name}";
            value = home-manager.lib.homeManagerConfiguration (config system);
          })
          systems);
    in {
      homeConfigurations = homeConfigs (system: {
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
          };

          overlays = [
            neovim-flake.overlays.${system}.default
            (f: p: {
              inherit (helix.packages.${system}) helix-dev;
            })
          ];
        };

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {inherit user;};
      });
    };
}
