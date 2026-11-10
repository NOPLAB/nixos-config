return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.diagnostic.config({ virtual_text = true })
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = { vim.env.VIMRUNTIME } },
            telemetry = { enable = false },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("SetupLsp", { clear = true }),
        callback = function(event)
          local function map(key, action, description)
            vim.keymap.set("n", key, action, { buffer = event.buf, desc = description })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("grr", vim.lsp.buf.references, "Find references")
          map("gri", vim.lsp.buf.implementation, "Go to implementation")
          map("gh", vim.lsp.buf.hover, "Show documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>cf", vim.lsp.buf.format, "Format buffer")
          map("<C-k>", vim.diagnostic.open_float, "Show diagnostics")
        end,
      })

      vim.lsp.enable("lua_ls")
    end,
  },
}
