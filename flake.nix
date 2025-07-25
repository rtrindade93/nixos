{
  description = "rtrindade93 nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.renna = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = inputs;
        modules = [
          # Import previous configuration
          ./configuration.nix
          ./hosts/renna
        home-manager.nixosModules.home-manager
        ];
      };
    };
}
