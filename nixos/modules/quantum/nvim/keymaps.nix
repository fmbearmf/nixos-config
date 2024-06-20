{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<C-n>";
      mode = "n";
      options = { desc = "Toggle Tree View."; };
    }
    {
      action = "<cmd>ToggleTerm<CR>";
      key = "<C-t>";
      mode = [ "n" ];
      options = { desc = "open term"; };
    }
  ];
}