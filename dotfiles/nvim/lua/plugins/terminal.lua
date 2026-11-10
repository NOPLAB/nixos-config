return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 100,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "tab",
      close_on_exit = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local set = vim.keymap.set
      set("t", "<Esc>", [[<C-\><C-n>]])
      set("t", "jk", [[<C-\><C-n>]])
      set("t", "<C-h>", "<Cmd>wincmd h<CR>")
      set("t", "<C-j>", "<Cmd>wincmd j<CR>")
      set("t", "<C-k>", "<Cmd>wincmd k<CR>")
      set("t", "<C-l>", "<Cmd>wincmd l<CR>")
      set("t", "<C-w>", [[<C-\><C-n><C-w>]])
      set("n", "tt", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal tab" })
      set("n", "tv", "<Cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
      set("n", "th", "<Cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
    end,
  },
}
