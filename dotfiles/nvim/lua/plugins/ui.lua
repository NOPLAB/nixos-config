return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("transparent").setup(opts)
      vim.cmd.TransparentEnable()
    end,
    keys = {
      { "<leader>ut", "<Cmd>TransparentToggle<CR>", desc = "Toggle transparency" },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes", "ryanoasis/vim-devicons" },
    init = function()
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tabline#left_sep"] = " "
      vim.g["airline#extensions#tabline#left_alt_sep"] = "|"
      vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = "minimalist"
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {},
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
      { "<leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<Cmd>Trouble symbols toggle<CR>", desc = "Symbols" },
      { "<leader>cl", "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP results" },
      { "<leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location list" },
      { "<leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
    },
  },
}
