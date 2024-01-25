local Util = require("lazyvim/util")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
})

return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "E",
          [vim.diagnostic.severity.WARN] = "W",
          [vim.diagnostic.severity.HINT] = "H",
          [vim.diagnostic.severity.INFO] = "i",
        },
      },
    },
    inlay_hints = {
      enabled = false,
    },
    servers = {
      tsserver = {},
      cssmodules_ls = {},
      gopls = {},
    },
  },
}
