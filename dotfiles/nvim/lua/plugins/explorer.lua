return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    opts = {},
    keys = {
      { "<C-e>", "<Cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    },
  },
}
