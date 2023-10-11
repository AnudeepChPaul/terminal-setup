local function Map(key, left, right)
  vim.keymap.set(key, left, right, { noremap = true })
end

local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'pyright',
  'html'
})

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.name == "pyright" then
    Map("n", "moi", vim.cmd.PyrightOrganizeImports)
  elseif client.name == "tsserver" then
    -- Map("n", "mrf", vim.cmd.TypescriptRenameFile)
    -- Map("n", "moi", vim.cmd.TypescriptOrganizeImports)
    -- Map("n", "mru", vim.cmd.TypescriptRemoveUnused)
  end
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = false
})

-- -- import lspconfig plugin safely
-- local lspconfig = require('lspconfig')
--
-- -- import cmp-nvim-lsp plugin safely
-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- -- enable keybinds only for when lsp server available
-- local on_attach = function(client, bufnr)
--   -- keybind options
--   local opts = { noremap = true, buffer = bufnr }
--
--   -- set keybinds
--   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--
--   if client.name == "pyright" then
--     Map("n", "moi", vim.cmd.PyrightOrganizeImports)
--   elseif client.name == "tsserver" then
--     Map("n", "mrf", vim.cmd.TypescriptRenameFile)
--     Map("n", "moi", vim.cmd.TypescriptOrganizeImports)
--     Map("n", "mru", vim.cmd.TypescriptRemoveUnused)
--   end
-- end
--
-- -- used to enable autocompletion (assign to every lsp server config)
-- local capabilities = cmp_nvim_lsp.default_capabilities()
--
-- -- Change the Diagnostic symbols in the sign column (gutter)
-- local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
-- -- local signs = { Error = " ", Warn = " ", Hint = "H", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
--
-- -- configure python server
-- lspconfig.pyright.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- lspconfig.pylsp.setup({})
--
-- -- configure html server
-- lspconfig.html.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- lspconfig.tsserver.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--   cmd = { "typescript-language-server", "--stdio" }
-- })
--
-- -- configure css server
-- lspconfig["cssls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure lua server (with special settings)
-- lspconfig["lua_ls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = { -- custom settings for lua
--     Lua = {
--       -- make the language server recognize "vim" global
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         -- make language server aware of runtime files
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.stdpath("config") .. "/lua"] = true,
--         },
--       },
--     },
--   },
-- })
--
-- -- lspconfig.gopls.setup({
-- --   capabilities = capabilities,
-- --   on_attach = on_attach,
-- -- })
--
-- -- configure emmet language server
-- -- lspconfig.vuels.setup({
-- --   capabilities = capabilities,
-- --   on_attach = on_attach,
-- --   filetypes = { "vue" },
-- -- })
-- --
-- -- lspconfig.volar.setup({
-- --   capabilities = capabilities,
-- --   on_attach = on_attach,
-- --   filetypes = { "vue" },
-- -- })
