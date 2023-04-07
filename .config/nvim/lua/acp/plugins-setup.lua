-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

  -- nvim git controls
  use({
    "tpope/vim-fugitive",
    requires = {
      "lewis6991/gitsigns.nvim", -- show line modifications on left hand side
    },
  })

  use({ "mbbill/undotree" })

  -- managing & installing lsp servers, linters & formatters-- Lua
  use({
    "neovim/nvim-lspconfig",
    requires = {
      -- LSP Support
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      -- additional functionality for typescript server (e.g. rename file & update imports),
      { "jose-elias-alvarez/typescript.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      -- { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "glepnir/lspsaga.nvim", branch = "main" },
      { "onsails/lspkind.nvim" }, -- vs-code like icons for autocompletion

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "jose-elias-alvarez/null-ls.nvim" }, -- configure formatters & linters
      { "jayp0521/mason-null-ls.nvim" }, -- bridges gap b/w mason & null-ls
    },
  })
  -- use({
  --   "folke/trouble.nvim",
  --   requires = "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  -- })

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-context",
    },
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  }) -- treesitter configuration

  -- Plant uml support
  use({
    "weirongxu/plantuml-previewer.vim",
    requires = {
      -- "aklt/plantuml-syntax",
      "tyru/open-browser.vim",
    },
  })

  -- file explorer
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- vs-code like icons for nvim tree
    },
  })
  use("ThePrimeagen/harpoon")

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- dependency for better sorting performance
      -- { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      -- { "kdheepak/lazygit.nvim" },
    },
  }) -- fuzzy finder
  -- autocompletion

  use({
    "tjdevries/colorbuddy.nvim",
    requires = {
      "nyoom-engineering/oxocarbon.nvim",
    },
  })
  -- use("EdenEast/nightfox.nvim") -- nightfox color scheme
  -- use("rose-pine/neovim", { as = "rose-pine" }) -- rose pine color theme
  -- use("akinsho/nvim-bufferline.lua") -- bufferline for tab

  use("norcalli/nvim-colorizer.lua")
  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
  -- use("szw/vim-maximizer") -- maximizes and restores current window

  -- essential plugins
  -- use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("numToStr/Comment.nvim") -- commenting with gc

  -- configuring lsp servers
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use("nvim-lualine/lualine.nvim") -- statusline

  if packer_bootstrap then
    require("packer").sync()
  end
end)
