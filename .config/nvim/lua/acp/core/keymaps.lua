-- set leader key to space
vim.g.mapleader = " "

local function Map(key, left, right)
  vim.keymap.set(key, left, right, { noremap = true })
end

---------------------
-- General Keymaps
---------------------

-- No use up/down/left/right arrow
Map("n", "<Up>", "<nop>")
Map("n", "<Down>", "<nop>")
Map("n", "<Left>", "<nop>")
Map("n", "<Right>", "<nop>")
Map("n", "Q", "<nop>")

-- use Ctrl+\ to exit insert mode
Map("i", "<C-\\>", "<ESC>")
Map("i", "<C-c>", "<ESC>")

-- clear search highlights
Map("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
Map("n", "x", '"_x')

-- Delete a word backwards
Map("n", "dw", 'vb"_d')

-- Select all
Map("n", "<C-a>", "gg<S-v>G")

-- increment/decrement numbers
Map("n", "+", "<C-a>") -- increment
Map("n", "-", "<C-x>") -- decrement

-- window management
Map("n", "sv", "<C-w>v") -- split window vertically
Map("n", "ss", "<C-w>s") -- split window horizontally
-- Map("n", "se", "<C-w>=") -- make split windows equal width & height
Map("n", "sx", ":close<CR>") -- close current split window
-- Map("", "sh", "<C-w>h") -- Switch to panel left
-- Map("", "sk", "<C-w>k") -- Switch to panel up
-- Map("", "sj", "<C-w>j") -- Switch to panel down
-- Map("", "sl", "<C-w>l") -- Switch to panel right

Map("n", "<leader>bx", ":bd<CR>") -- close current buffer

Map("n", "<leader>tt", ":tabnew<CR>") -- open nw tab
Map("n", "<leader>tx", ":tabnew<CR>") -- open new tab

Map("n", "<S-Left>", "<C-w><")
Map("n", "<S-Right>", "<C-w>>")
Map("n", "<S-Up>", "<C-w>+")
Map("n", "<S-Down>", "<C-w>-")

Map({ "n", "v" }, "j", "jzz")
Map({ "n", "v" }, "k", "kzz")

-- Map("n", "q", ":m+1<CR>")
-- Map("n", "Q", ":m-2<CR>")

Map("n", "<leader>m", 'V"-y"-p') -- duplicates a line
Map("v", "m", ":m '>+1<CR>gv=gv")
Map("v", "M", ":m '<-2<CR>gv=gv")

Map("v", "<", "<gv")
Map("v", ">", ">gv")

Map("n", "<leader>lw", ":set list!<CR>")
Map("n", "<leader>lr", ":set rnu!<CR>")

Map("n", "<leader>e", vim.diagnostic.open_float)
Map("n", "[d", vim.diagnostic.goto_prev)
Map("n", "]d", vim.diagnostic.goto_next)

-- Map("n", "ff", ":$put _<CR>")

-- Quick action
Map("i", "jk", "<ESC>") -- ESC on jk pressed togather

-- Quick fix list navigation
Map("n", "<C-[>", ":cn<CR>")
Map("n", "<C-]>", ":cp<CR>")

Map("n", "<TAB>", ":bnext<CR>")
Map("n", "<S-TAB>", ":bprevious<CR>")

Map("x", "<leader>p", '"_dP')
Map("n", "J", "mzJ`z") -- Bring the bottom line to end of upper line without changing cursor position
Map("n", "<C-d>", "<C-d>zz") -- Scrolls down keeping cursor in the middle of the screen
Map("n", "<C-u>", "<C-u>zz") --Scrolls down keeping cursor in the middle of the screen

Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

Map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
Map("n", "<leader>r", ":%s")
Map("v", "<leader>r", ":s/")

----------------------
-- Plugin Keybinds
----------------------
Map("", "<leader>u", "<cmd>UndotreeToggle<CR>")

-- vim-maximizer
Map("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
Map("n", "<leader>e", ":NvimTreeOpen<CR>") -- toggle file explorer
Map("n", "<leader>w", ":NvimTreeClose<CR>") -- toggle file explorer
Map("n", "<leader>rr", ":NvimTreeRefresh<CR>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>fl", ":NvimTreeFindFile<CR>") -- locates the file (in nvim-tree) opened in current buffer

-- LSP Saga
Map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
Map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
Map("n", "K", "<Cmd>Lspsaga hover_doc ++quiet ++keep<CR>")
Map("n", "<leader>k", "<Cmd>Lspsaga signature_help<CR>")
Map("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>")
Map("n", "<leader>rnn", "<cmd>Lspsaga rename ++project<CR>")
Map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
Map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
Map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
Map("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>") -- show  diagnostics for line
Map("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>") -- show diagnostics for cursor
Map("n", "<leader>ot", "<cmd>LSoutlineToggle<CR>") -- see outline on right hand side
Map("n", "<leader>gp", "<Cmd>Lspsaga peek_definition<CR>")
Map("n", "<leader>gf", "<Cmd>Lspsaga lsp_finder<CR>")
Map("n", "<leader>gi", vim.lsp.buf.implementation)
Map("n", "<leader>gr", vim.lsp.buf.references)
Map("n", "<leader>gD", vim.lsp.buf.declaration)
Map("n", "<leader>gd", vim.lsp.buf.definition)

-- typescript specific keymaps (e.g. rename file and update imports)
Map("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
Map("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
Map("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)

-- telescope
Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>fg", "<cmd>Telescope git_files<cr>") -- find string in current working directory as you type
Map("n", "<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
Map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
Map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
Map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
Map("n", "<leader>gg", "<cmd>LazyGit<CR>")
-- telescope git commands (not on youtube nvim video)
Map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
Map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
Map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
Map("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
Map("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

Map("n", "<leader>ss", '<cmd>lua require("nvterm.terminal").toggle "float" <cr>') -- mapping to restart lsp if necessary
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
