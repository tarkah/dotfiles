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
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, neovim-flake, ... }:
    let
      packages = system: import nixpkgs {
        inherit system;

        overlays = [
          neovim-flake.overlays.${system}.default
        ];
      };
    in {
      homeConfigurations.tarkah = home-manager.lib.homeManagerConfiguration {
        pkgs = packages "x86_64-linux";

        modules = [ 
          ./linux.nix
          ./home.nix
        ];
      };

      homeConfigurations."tarkah@darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = packages "aarch64-darwin";

        modules = [ 
          ./darwin.nix
          ./home.nix
        ];
      };
    };
}
