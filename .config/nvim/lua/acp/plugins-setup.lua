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

  -- managing & installing lsp servers, linters & formatters
  use({ -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      "j-hui/fidget.nvim",

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",
    },
  })
  use("fatih/vim-go")

  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
  -- use('neoclide/coc.nvim', {branch = 'release'})

  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  }) -- treesitter configuration
  -- use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- Plant uml support
  use({
    "weirongxu/plantuml-previewer.vim",
    requires = {
      -- "aklt/plantuml-syntax",
      "tyru/open-browser.vim",
    },
  })
  -- Markdown support
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
    
  use("nvim-tree/nvim-tree.lua") -- file explorer
  use("nvim-tree/nvim-web-devicons") -- vs-code like icons

  use({ -- Autocompletion
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path", -- source for file system paths
      "mbbill/undotree", -- Undotree visualizes the undo history
      "hrsh7th/cmp-buffer", -- source for text in buffer
    },
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- dependency for better sorting performance
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      -- { "kdheepak/lazygit.nvim" },
    },
  }) -- fuzzy finder
  -- autocompletion

  -- use("EdenEast/nightfox.nvim") -- nightfox color scheme
  use("rose-pine/neovim", { as = "rose-pine" }) -- rose pine color theme
  -- use("akinsho/nvim-bufferline.lua") -- bufferline for tab

  -- use("norcalli/nvim-colorizer.lua")
  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
  -- use("szw/vim-maximizer") -- maximizes and restores current window

  -- essential plugins
  -- use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("numToStr/Comment.nvim") -- commenting with gc

  -- configuring lsp servers
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use("nvim-lualine/lualine.nvim") -- statusline
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  if packer_bootstrap then
    require("packer").sync()
  end
end)
