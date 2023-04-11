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
Map("n", "sx", vim.cmd.close) -- close current split window
-- Map("", "sh", "<C-w>h") -- Switch to panel left
-- Map("", "sk", "<C-w>k") -- Switch to panel up
-- Map("", "sj", "<C-w>j") -- Switch to panel down
-- Map("", "sl", "<C-w>l") -- Switch to panel right

Map("n", "<leader>bx", vim.cmd.bd) -- close current buffer

Map("n", "<leader>tt", vim.cmd.tabnew) -- open nw tab
Map("n", "<leader>tx", vim.cmd.tabclose) -- open new tab

Map("n", "<S-Left>", "<C-w><")
Map("n", "<S-Right>", "<C-w>>")
Map("n", "<S-Up>", "<C-w>+")
Map("n", "<S-Down>", "<C-w>-")

-- Map({ "n", "v" }, "j", "jzz")
-- Map({ "n", "v" }, "k", "kzz")

-- Map("n", "q", ":m+1<CR>")
-- Map("n", "Q", ":m-2<CR>")

Map("n", "<leader>m", 'V"-y"-p') -- duplicates a line
Map("x", "p", '"_dP')

Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")
Map("n", "J", "mzJ`z") -- Bring the bottom line to end of upper line without changing cursor position
Map("n", "<C-d>", "<C-d>zz") -- Scrolls down keeping cursor in the middle of the screen
Map("n", "<C-u>", "<C-u>zz") --Scrolls down keeping cursor in the middle of the screen
Map("v", "<", "<gv")
Map("v", ">", ">gv")

Map("n", "<leader>lw", ":set list!<CR>")
Map("n", "<leader>lr", ":set rnu!<CR>")

Map("n", "<leader>e", vim.diagnostic.open_float)
Map("n", "[d", vim.diagnostic.goto_prev)
Map("n", "]d", vim.diagnostic.goto_next)

Map("n", "<leader>fr", vim.lsp.buf.format) -- toggle file explorer
-- Map("n", "ff", ":$put _<CR>")

-- Quick fix list navigation
Map("n", "<C-[>", ":cn<CR>")
Map("n", "<C-]>", ":cp<CR>")

Map("n", "<TAB>", vim.cmd.bnext)
Map("n", "<S-TAB>", vim.cmd.bprevious)

Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

Map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
Map("n", "<leader>r", ":%s")
Map("v", "<leader>r", ":s/")

----------------------
-- Plugin Keybinds
----------------------
Map("", "<leader>u", vim.cmd.UndotreeToggle)
-- vim-maximizer
Map("n", "<leader>sm", vim.cmd.MaximizerToggle) -- toggle split window maximization

-- GitSigns
Map("n", "gl", function()
  vim.cmd.Gitsigns("toggle_current_line_blame")
end)
Map("n", "gL", function()
  vim.cmd.Gitsigns("diffthis")
end)
-- Fugitive
Map("n", "<leader>fgt", vim.cmd.Git)

-- nvim-tree
Map("n", "<leader>e", ":NvimTreeOpen<CR>") -- toggle file explorer
Map("n", "<leader>w", ":NvimTreeClose<CR>") -- toggle file explorer
Map("n", "<leader>rr", ":NvimTreeRefresh<CR>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>fl", ":NvimTreeFindFile<CR>") -- locates the file (in nvim-tree) opened in current buffer

-- LSP
Map("n", "<leader>st", ":Lspsaga term_toggle<CR>")
Map("n", "mE", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
Map("n", "me", function()
  vim.diagnostic.goto_next()
end)
Map("n", "K", function()
  vim.cmd.Lspsaga("hover_doc", "++quiet")
end)
Map("n", "<leader>k", vim.lsp.buf.signature_help)
Map("n", "<leader>rn", function()
  vim.cmd.Lspsaga("rename", "++project")
end)
Map("n", "ma", function()
  -- vim.cmd.Lspsaga("code_action")
  vim.lsp.buf.code_action()
end)
Map("n", "<leader>ci", function()
  vim.cmd.Lspsaga("incoming_calls")
end)
Map("n", "<leader>co", function()
  vim.cmd.Lspsaga("outgoing_calls")
end)
Map("n", "ml", function()
  vim.cmd.Lspsaga("show_line_diagnostics")
end) -- show  diagnostics for line
Map("n", "mc", function()
  vim.cmd.Lspsaga("show_cursor_diagnostics")
end) -- show diagnostics for cursor
Map("n", "mf", function()
  vim.cmd.Lspsaga("show_buf_diagnostics")
end) -- show diagnostics for cursor
Map("n", "mw", function()
  vim.cmd.Lspsaga("show_workspace_diagnostics")
end) -- show diagnostics for cursor
Map("n", "mo", function()
  -- see outline on right hand side
  vim.cmd.Lspsaga("outline")
end)
Map("n", "gr", function()
  vim.cmd.Lspsaga("lsp_finder")
end)
Map("n", "gp", function()
  vim.cmd.Lspsaga("peek_definition")
end)
Map("n", "gt", function()
  vim.cmd.Lspsaga("peek_type_definition")
end)
Map("n", "gi", vim.lsp.buf.implementation)
Map("n", "<leader>gr", vim.lsp.buf.references)
Map("n", "gD", vim.lsp.buf.declaration)
Map("n", "gd", vim.lsp.buf.definition)
Map("n", "<leader>rs", vim.cmd.LspRestart) -- mapping to restart lsp if necessary

-- typescript specific keymaps (e.g. rename file and update imports)
Map("n", "<leader>rf", vim.cmd.TypescriptRenameFile) -- rename file and update imports
Map("n", "<leader>oi", vim.cmd.TypescriptOrganizeImports) -- organize imports (not in youtube nvim video)
Map("n", "<leader>ru", vim.cmd.TypescriptRemoveUnused) -- remove unused variables (not in youtube nvim video)

-- telescope
Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>gf", "<cmd>Telescope git_files<cr>") -- find string in current working directory as you type
Map("n", "<leader>fs", require("telescope").extensions.live_grep_args.live_grep_args)
Map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
Map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
Map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
Map("n", "<leader>gg", "<cmd>LazyGit<CR>")

-- telescope git commands (not on youtube nvim video)
Map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
Map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
Map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
Map("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- harpoon
Map("n", "<TAB>", require("harpoon.ui").nav_next)
Map("n", "<S-TAB>", require("harpoon.ui").nav_prev)
Map("n", "<leader>hh", require("harpoon.mark").add_file)
Map("n", "<leader>fj", require("harpoon.ui").toggle_quick_menu)
Map("n", "<leader>1", function()
  require("harpoon.ui").nav_file(1)
end)
Map("n", "<leader>2", function()
  require("harpoon.ui").nav_file(2)
end)
Map("n", "<leader>3", function()
  require("harpoon.ui").nav_file(3)
end)
Map("n", "<leader>4", function()
  require("harpoon.ui").nav_file(4)
end)

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
