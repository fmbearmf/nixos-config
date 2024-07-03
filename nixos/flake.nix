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
			inputs.nixpkgs.follows = "nixpkgs";
		};
		chaotic = {
			url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
		};
	};

	outputs = { self, nixpkgs, chaotic, fenix, nixvim, ... }@inputs: {
		packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
		nixosConfigurations.quantum = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./modules/quantum/module.nix
				nixvim.nixosModules.nixvim
				chaotic.nixosModules.default
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
