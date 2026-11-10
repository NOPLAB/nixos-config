return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "c",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("SetupTreesitter", { clear = true }),
        callback = function(event)
          local language = vim.treesitter.language.get_lang(event.match)
          if language and vim.treesitter.language.add(language) then
            vim.treesitter.start(event.buf, language)
          end
        end,
      })
    end,
  },
}
