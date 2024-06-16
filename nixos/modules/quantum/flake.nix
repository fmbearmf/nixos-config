{
	description = "Utterly deranged system flake.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim";
		};
	};

	outputs = { self, nixpkgs, fenix, nixvim, ... }@inputs: {
		packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
		nixosConfigurations.quantum = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./module.nix
				nixvim.nixosModules.nixvim
				({ pkgs, ... }: {
					nixpkgs.overlays = [ fenix.overlays.default ];
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
			];
		};
	};
}
