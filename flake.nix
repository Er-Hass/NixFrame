{
  description = "Axon's reproducible NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, sops-nix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; overlays = [ (import ./overlays) ]; };
    lib = pkgs.lib;
  in {
    nixosConfigurations = {
      ash = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/ash/hardware.nix
          ./hosts/ash/configuration.nix

          ./modules/common/system.nix
          ./modules/roles/workstation.nix
          ./modules/roles/kde.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.axon = import ./home/axon.nix;
          }

          sops-nix.nixosModules.sops
        ];
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = [ pkgs.nixfmt ];
    };
  };
}
