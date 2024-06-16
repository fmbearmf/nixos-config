{ pkgs, lib, ... }: {
	imports = [ ./bufferline.nix ];

	programs.nixvim = {
		enable = true;
	};
}
