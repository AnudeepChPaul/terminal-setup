-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")

local function Map(key, left, right)
  vim.keymap.set(key, left, right, { noremap = true })
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  -- setup formatters & linters
  sources = {
    --  to disable file types use
    --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
    formatting.prettier, -- js/ts formatter
    formatting.eslint,
    formatting.stylua, -- lua formatter
    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.cjs")
        -- change file extension if you use something else
      end,
    }),
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    -- typescript specific keymaps (e.g. rename file and update imports)
    Map("n", "<leader>rf", vim.cmd.TypescriptRenameFile) -- rename file and update imports
    Map("n", "<leader>oi", vim.cmd.TypescriptOrganizeImports) -- organize imports (not in youtube nvim video)
    Map("n", "<leader>ru", vim.cmd.TypescriptRemoveUnused) -- remove unused variables (not in youtube nvim video)

    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
          vim.api.nvim_command(":retab")
        end,
      })
    end
  end,
})
