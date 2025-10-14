{
  description = "Axon's reproducible NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    sops-nix.url = "github:Mic92/sops-nix";
    # Optional (later): nixvim or nvf, hyprland, nur, etc.
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, sops-nix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; overlays = [ (import ./overlays) ]; };
    lib = pkgs.lib;
  in {
    # NixOS machines go here
    nixosConfigurations = {
      example-host = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/example-host/hardware.nix
          ./hosts/example-host/configuration.nix
          ./modules/common/system.nix
          ./modules/roles/workstation.nix
          ./modules/roles/kde.nix
          # add hyprland later as an alternative session
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.erik = import ./home/erik.nix;
          }
          sops-nix.nixosModules.sops
        ];
      };
    };

    # Dev shell for repo maintenance (formatters, linters) — optional now
    devShells.${system}.default = pkgs.mkShell { packages = [ pkgs.nixfmt ]; };
  };
}
