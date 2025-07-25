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
    jujutsu = {
      url = "github:jj-vcs/jj?ref=v0.31.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    naersk,
    rust-overlay,
    helix,
    zbb,
    jujutsu,
    ...
  }:
    with builtins; let
      user = "tarkah";

      profiles = [
        {
          profile = "linux";
          system = "x86_64-linux";
        }
        {
          profile = "darwin";
          system = "aarch64-darwin";
        }
        {
          profile = "work";
          system = "aarch64-darwin";
        }
      ];

      homeConfigs = config:
        listToAttrs
        (map
          ({
            profile,
            system,
          }: {
            name = "${user}@${profile}";
            value = home-manager.lib.homeManagerConfiguration (
              config {
                inherit profile system;
              }
            );
          })
          profiles);

      zbbOverlay = _: p: {
        zellij-bare-bar = p.callPackage ./packages/zellij-bare-bar.nix {
          src = zbb;
        };
      };
    in {
      homeConfigurations = homeConfigs ({
        profile,
        system,
      }: {
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
          };

          overlays = [
            (rust-overlay.overlays.default)
            (helix.overlays.default)
            (jujutsu.overlays.default)
            (_: _: {
              inherit naersk;
            })
            zbbOverlay
          ];
        };

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit user profile;
        };
      });
    };
}
