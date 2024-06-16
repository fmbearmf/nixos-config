{ pkgs, lib, ... }: {
	imports = [ ./bufferline.nix ];

	programs.nixvim = {
		enable = true;

		colorschemes.gruvbox.enable = true;

		plugins = {
			lualine.enable = true;
			lsp = {
				enable = true;
				servers = {
					tsserver.enable = true;
					lua-ls.enable = true;
					rust-analyzer = {
						enable = true;
						installCargo = false;
						installRustc = false;
					};
				};
			};
			cmp = {
				enable = true;
				autoEnableSources = true;
			};
		};
	};
}
