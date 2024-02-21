local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Setup vim options
require('acp.options')

-- Setup Lazy Vim Plugins
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  checker = { enabled = true },
  spec = {
    {
      "nvim-lua/plenary.nvim",
      name = "plenary",
      lazy = false
    },
    { import = "acp.lazy" },
    { import = "acp.colorscheme" },
  },
  change_detection = { notify = false },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
