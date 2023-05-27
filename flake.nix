{
  description = "Home Manager configuration of tarkah";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    helix = {
      url = "github:tarkah/helix/command/parent-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
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
            (f: p: {
              inherit (helix.packages.${system}) helix;
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
