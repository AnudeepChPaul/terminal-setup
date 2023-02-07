-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
    disable = function()
      local current_buffer_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      return vim.fn.getfsize(current_buffer_name) > 3000 && 
    end,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "svelte",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
  },
  -- auto install above language parsers
  auto_install = true,
})
