local function Map(key, left, right)
  vim.keymap.set(key, left, right, { noremap = true })
end

-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, buffer = bufnr }

  -- set keybinds
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.name == "pyright" then
    Map("n", "<leader>oi", vim.cmd.PyrightOrganizeImports)
  elseif client.name == "tsserver" then
    Map("n", "<leader>rf", vim.cmd.TypescriptRenameFile)
    Map("n", "<leader>oi", vim.cmd.TypescriptOrganizeImports)
    Map("n", "<leader>ru", vim.cmd.TypescriptRemoveUnused)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
-- local signs = { Error = " ", Warn = " ", Hint = "H", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure python server
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig.pylsp.setup({})

-- configure html server
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
-- lspconfig["tailwindcss"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- -- configure emmet language server
-- lspconfig["emmet_ls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })
--
-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

-- lspconfig.gopls.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- configure emmet language server
-- lspconfig.vuels.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "vue" },
-- })
--
-- lspconfig.volar.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "vue" },
-- })
