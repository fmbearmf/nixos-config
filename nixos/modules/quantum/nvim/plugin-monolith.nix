{
  # the behemoth of un-refactored plugin configs
  programs.nixvim.plugins = {
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
        clangd = {
          enable = true;
        };
        nixd = {
          enable = true;
        };
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
    };
    telescope.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    luasnip.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "│"; # "│" or "▎"
        };
        scope = {
          enabled = true;
          show_start = true;
        };
        exclude = {
          buftypes = ["terminal" "nofile"];
          filetypes = [
            "help"
            "alpha"
            "dashboard"
            "neo-tree"
            "Trouble"
            "trouble"
            "lazy"
            "mason"
            "notify"
            "toggleterm"
            "lazyterm"
          ];
        };
      };
    };
    toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<C-t>]]";
      };
    };
  };
}
