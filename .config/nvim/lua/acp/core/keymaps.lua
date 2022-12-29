-- set leader key to space
vim.g.mapleader = ","

---------------------
-- General Keymaps
---------------------

-- No use up/down/left/right arrow
vim.keymap.set("n", "<Up>", "nomap")
vim.keymap.set("n", "<Down>", "nomap")
vim.keymap.set("n", "<Left>", "nomap")
vim.keymap.set("n", "<Right>", "nomap")

-- use jk to exit insert mode
vim.keymap.set("i", "jk", "<ESC>")

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- Delete a word backwards
vim.keymap.set("n", "dw", 'vb"_d')

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- increment/decrement numbers
vim.keymap.set("n", "+", "<C-a>") -- increment
vim.keymap.set("n", "-", "<C-x>") -- decrement

-- window management
vim.keymap.set("n", "sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "ss", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "se", "<C-w>=") -- make split windows equal width & height

vim.keymap.set("n", "sx", ":close<CR>") -- close current split window
vim.keymap.set("n", "wx", ":bd<CR>") -- close current buffer

vim.keymap.set("n", "tt", ":new<CR>") -- open new tab

vim.keymap.set("", "sh", "<C-w>h")
vim.keymap.set("", "sk", "<C-w>k")
vim.keymap.set("", "sj", "<C-w>j")
vim.keymap.set("", "sl", "<C-w>l")

vim.keymap.set("n", "<S-h>", "<C-w><")
vim.keymap.set("n", "<S-l>", "<C-w>>")
vim.keymap.set("n", "<S-k>", "<C-w>+")
vim.keymap.set("n", "<S-j>", "<C-w>-")

vim.keymap.set("n", "M", ":m+1<CR>")
vim.keymap.set("n", "m", ":m-2<CR>")
----------------------
-- Plugin Keybinds
----------------------
vim.keymap.set("", "<leader>u", "<cmd>UndotreeToggle<CR>")

-- vim-maximizer
vim.keymap.set("n", "sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
vim.keymap.set("n", "fe", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
vim.keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

--[[ Comment shortcuts
NORMAL mode
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

VISUAL mode
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment
]]

--[[ Surround Shortcuts
VISUAL Mode
Press a capital V (for linewise visual mode) followed by S<p class="important">
  <p class="important">
    <em>Hello</em> world!
  </p>

NORMAL mode
cs followed by char to replace followed by char to change it to
'Hello world!' --> cs'<div> --> <div>Hello World!</div>
To remove the delimiters entirely, press ds". "Hello World" --> ds" --> Hello World
]]
