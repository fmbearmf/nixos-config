{
  description = "Utterly deranged system flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    chaotic,
    fenix,
    nixvim,
    alejandra,
    ...
  } @ inputs: {
    packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
    nixosConfigurations.quantum = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./modules/quantum/module.nix
        nixvim.nixosModules.nixvim
        chaotic.nixosModules.default
        ({pkgs, ...}: {
          nixpkgs.overlays = [fenix.overlays.default];
          environment.systemPackages = with pkgs; [
            (fenix.packages.x86_64-linux.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            rust-analyzer-nightly
          ];
        })
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
      ];
    };
  };
}
