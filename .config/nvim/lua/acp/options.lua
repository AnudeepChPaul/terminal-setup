-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.laststatus = 2
vim.opt.scrolloff = 10
vim.opt.virtualedit = "onemore"
vim.opt.wrap = true
vim.opt.guicursor = ""
vim.opt.mouse = ""

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/undodir"

-- Line Numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.wo.number = true
vim.opt.fillchars = { eob = " " }

-- Tabs & Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
--[[ vim.opt.smarttab = true ]]
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = { tab = "<>", space = " ", eol = "↵" }
vim.opt.foldenable = true
vim.opt.foldlevel = 5
vim.opt.foldmethod = "indent"

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Cursor Settings
vim.opt.cursorline = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.showcmd = true
vim.opt.cmdheight = 1

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- While searching search within sub dirs
vim.opt.path:append({ "**" })
vim.opt.iskeyword:append("-")

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.o.updatetime = 250
vim.diagnostic.config({ virtual_text = true })

-- NeoVim Folding Options
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 20

vim.g.netrw_liststyle = 3
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
