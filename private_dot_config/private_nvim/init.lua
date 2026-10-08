-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Tools from ~/.config/nvim/mise.toml, recorded by `mise run setup` in this directory.
local mise_bin_paths_file = vim.fn.stdpath("state") .. "/mise-bin-paths"
if vim.uv.fs_stat(mise_bin_paths_file) then
  local bin_paths = vim.fn.readfile(mise_bin_paths_file)
  if #bin_paths > 0 then
    vim.env.PATH = table.concat(bin_paths, ":") .. ":" .. vim.env.PATH
  end
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
      {out, "WarningMsg"},
      {"\nPress any key to exit..."},
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.caser_prefix = "mc"

require("config.options")
require("config.autocommands")

vim.g.snacks_animate = false
vim.g.snippet_dir = vim.fn.stdpath("config") .. "/lua/snippets"

-- Setup lazy.nvim
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  spec = {
    {import = "plugins"},
  },
  checker = {enabled = false},
  rocks = {enabled = false},
  install = {colorscheme = {"rose-pine", "tokyonight"}},
  change_detection = {notify = false},
  performance = {
    rtp = {
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
