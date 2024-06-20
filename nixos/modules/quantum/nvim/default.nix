{ pkgs, lib, ... }: {
	imports = [ 
		./bufferline.nix
		./autoclose.nix
		./neotree.nix
		./keymaps.nix
		./plugin-monolith.nix
	];

	programs.nixvim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		colorschemes.gruvbox.enable = true;
	};
}
