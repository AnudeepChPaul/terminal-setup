-- set leader key to space
vim.g.mapleader = ","

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- nomap to up & down arrows
keymap.set("n", "<Up>", "nomap")
keymap.set("n", "<Down>", "nomap")
keymap.set("n", "<Left>", "nomap")
keymap.set("n", "<Right>", "nomap")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "nh", ":nohl<CR>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>") -- increment
keymap.set("n", "-", "<C-x>") -- decrement

-- window management
keymap.set("n", "sv", "<C-w>v") -- split window vertically
keymap.set("n", "ss", "<C-w>s") -- split window horizontally
keymap.set("n", "se", "<C-w>=") -- make split windows equal width & height

-- switching windows
keymap.set("n", "sh", "<C-w><C-h>") -- make split windows equal width & height
keymap.set("n", "sj", "<C-w><C-j>") -- make split windows equal width & height
keymap.set("n", "sk", "<C-w><C-k>") -- make split windows equal width & height
keymap.set("n", "sl", "<C-w><C-l>") -- make split windows equal width & height

keymap.set("n", "sx", ":close<CR>") -- close current split window
keymap.set("n", "tx", ":tabclose<CR>") -- close current tab

keymap.set("n", "tt", ":tabnew<CR>") -- open new tab
keymap.set("n", "ty", ":tabn<CR>") --  go to next tab
keymap.set("n", "tr", ":tabp<CR>") --  go to previous tab

-- Resize window
keymap.set("n", "rh", "<C-w><")
keymap.set("n", "rl", "<C-w>>")
keymap.set("n", "rk", "<C-w>+")
keymap.set("n", "rj", "<C-w>-")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "ee", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary