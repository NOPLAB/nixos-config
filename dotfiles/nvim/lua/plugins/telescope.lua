return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-frecency.nvim" },
    keys = {
      { "<leader>t", "<Cmd>Telescope<CR>", desc = "Telescope" },
      { "<leader>g", "<Cmd>Telescope live_grep<CR>", desc = "Search text" },
      { "<leader>f", "<Cmd>Telescope frecency<CR>", desc = "Recent files" },
    },
    config = function()
      require("telescope").setup({})
      require("telescope").load_extension("frecency")
    end,
  },
}
