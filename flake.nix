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
  };

  outputs = { nixpkgs, home-manager, neovim-flake, ... }:
    with builtins;

    let
      user = "tarkah";

      systems = [
        { system = "x86_64-linux"; name = "linux"; }
        { system = "aarch64-darwin"; name = "darwin"; }
      ];

      homeConfigs = config:
        listToAttrs
          (map
            ({ system, name }: {
              name = "${user}@${name}";
              value = home-manager.lib.homeManagerConfiguration (config system);
            })
            systems);

    in
    {
      homeConfigurations = homeConfigs (system: {
        pkgs = import nixpkgs {
          inherit system;

          config = {
              allowUnfree = true;
          };

          overlays = [
            neovim-flake.overlays.${system}.default
          ];
        };

        modules = [
          ./home.nix 
        ];

        extraSpecialArgs = { inherit user; };
      });
    };
}
