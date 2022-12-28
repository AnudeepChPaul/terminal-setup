vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.backup = false
vim.opt.laststatus = 2
vim.opt.scrolloff = 10
vim.opt.virtualedit = "onemore"

-- Line Numbers
vim.opt.relativenumber = false
vim.opt.number = true
vim.wo.number = true

-- Tabs & Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

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
