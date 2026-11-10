return {
  "tpope/vim-fugitive",
  "tpope/vim-commentary",
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "stevearc/overseer.nvim",
    opts = { templates = { "builtin" } },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
