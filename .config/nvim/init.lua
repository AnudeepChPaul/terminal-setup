local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Must be set
vim.g.mapleader = " "

require("acp.options")
require("acp.autocmd")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  checker = { enabled = false },
  spec = {
    { import = "acp.lazy" },
    { import = "acp.colorscheme" },
  },
  change_detection = { notify = false },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- loading keystrokes and options
--require("acp.keymap")

-- require("config.transparent").transparent()
