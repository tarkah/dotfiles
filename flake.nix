{
  description = "Home Manager configuration of tarkah";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    naersk = {
      url = "github:nmattia/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:tarkah/helix/command/parent-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zbb = {
      url = "github:tarkah/zellij-bare-bar";
      flake = false;
    };
    ranger = {
      url = "github:ranger/ranger";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    naersk,
    rust-overlay,
    helix,
    zbb,
    ranger,
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

      zbbOverlay = _: p: {
        zellij-bare-bar = p.callPackage ./packages/zellij-bare-bar.nix {
          src = zbb;
        };
      };

      rangerOverlay = _: p: {
        ranger = p.ranger.overrideAttrs (attrs: {
          src = ranger;

          propagatedBuildInputs = with p.python3Packages;
            attrs.propagatedBuildInputs
            ++ [
              astroid
              pylint
            ];
        });
      };
    in {
      homeConfigurations = homeConfigs (system: {
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
          };

          overlays = [
            (import rust-overlay)
            (_: _: {
              inherit (helix.packages.${system}) helix;
              inherit naersk;
            })
            zbbOverlay
            rangerOverlay
          ];
        };

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {inherit user;};
      });
    };
}
