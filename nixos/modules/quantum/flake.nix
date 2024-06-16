{
	description = "Utterly deranged system flake.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, fenix, nixpkgs }: {
		packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
		nixosConfigurations.quantum = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./module.nix
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
