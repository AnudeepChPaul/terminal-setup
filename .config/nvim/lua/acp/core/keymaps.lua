-- set leader key to space
vim.g.mapleader = " "

local function Map(key, left, right)
  vim.keymap.set(key, left, right, { noremap = true })
end

---------------------
-- General Keymaps
---------------------
local _K = {}

-- No use up/down/left/right arrow
Map("n", "<Up>", "<nop>")
Map("n", "<Down>", "<nop>")
Map("n", "<Left>", "<nop>")
Map("n", "<Right>", "<nop>")
Map("n", "Q", "<nop>")
Map("n", "<leader>mx", "<cmd>!chmod +x %<CR>")

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

function _K.toggle_current_line_blame() vim.cmd.Gitsigns("toggle_current_line_blame") end
function _K.git_diff_this() vim.cmd.Gitsigns("diffthis") end

-- GitSigns
Map("n", "gl", _K.toggle_current_line_blame);
Map("n", "gL", _K.git_diff_this);
-- Fugitive
Map("n", "<leader>fgt", vim.cmd.Git)

-- nvim-tree
Map("n", "<leader>e", ":NvimTreeOpen<CR>") -- toggle file explorer
Map("n", "<leader>w", ":NvimTreeClose<CR>") -- toggle file explorer
Map("n", "<leader>rr", ":NvimTreeRefresh<CR>") -- find files within current working directory, respects .gitignore
Map("n", "<leader>fl", ":NvimTreeFindFile<CR>") -- locates the file (in nvim-tree) opened in current buffer


-- telescope
Map("n", "<leader>fr", "<cmd>Telescope resume<cr>") -- Lists the results incl. multi-selections of the previous picker
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

-- Quick fix list navigation
Map("n", "<C-[>", ":cn<CR>")
Map("n", "<C-]>", ":cp<CR>")
Map("n", "<S-TAB>", vim.cmd.bnext)

-- harpoon
Map("n", "<C-TAB>", require("harpoon.ui").nav_next)
Map("n", "<leader>ha", require("harpoon.mark").add_file)
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

---------------------
-- COC Keymaps
---------------------
function _G.toggle_outline()
  return vim.cmd([[
    let winid = coc#window#find('cocViewId', 'OUTLINE')
    if winid == -1
    call CocActionAsync('showOutline', 1)
    else
    call coc#window#close(winid)
    endif
    ]])
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('definitionHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

function _G.format_buffer()
    vim.api.nvim_command(":retab")
    -- vim.api.nvim_command(":call CocAction('format')")
    -- vim.api.nvim_command(":CocCommand eslint.executeAutofix")
end

keymap = vim.keymap.set;

-- COC Config
-- keymap("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
-- keymap("n", "<leader>cc", ":CocEnable <CR>", { silent = true })
-- keymap("n", "<leader>cs", ":CocDisable <CR>", { silent = true })
-- keymap("n", "<leader>oi", ":call CocActionAsync('organizeImport')<CR>", { silent = true })
-- keymap("n", "<leader>mo", ":call CocActionAsync('showOutgoingCalls')<CR>", { silent = true })
-- keymap("n", "<leader>mi", ":call CocActionAsync('showIncomingCalls')<CR>", { silent = true })
--
-- keymap("n", "gt", ":call CocActionAsync('jumpTypeDefinition')<CR>", { silent = true })
-- keymap("n", "gi", ":call CocActionAsync('jumpImplementation')<CR>", { silent = true })
-- keymap("n", "gd", ":CocCommand tsserver.goToSourceDefinition <CR>", { silent = true })
-- keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
--
-- keymap("n", "ma", "<Plug>(coc-codeaction)", { silent = true })
-- keymap("n", "mc", "<Plug>(coc-codeaction-cursor)", { silent = true })
-- keymap("n", "me", ":call CocActionAsync('diagnosticNext')<CR>", { silent = true })
-- keymap("n", "mf", "<Plug>(coc-fix-current)", { silent = true })
-- keymap("n", "ml", "<Plug>(coc-codeaction-line)", { silent = true })
-- keymap("n", "mo", _G.toggle_outline, { silent = true, expr = false })
-- keymap("n", "mr", ":call CocActionAsync('refactor')<CR>", { silent = true })
-- keymap("n", "mrn", ":call CocActionAsync('rename')<CR>", { silent = true })
-- keymap("n", "ms", "<Plug>(coc-codeaction-source)", { silent = true })
--
-- keymap("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { expr = true })
-- keymap("i", "<C-j>", "coc#pum#visible() ? coc#pum#next(1) : '<C-j>'", { expr = true })
-- keymap("i", "<C-space>", "coc#refresh()", { expr = true })
-- keymap("i", "<C-k>", "coc#pum#visible() ? coc#pum#prev(1) : '<C-k>'", { expr = true })

-- keymap("n", "<leader>is", ":CocList -I symbols<CR>", {silent = true})
keymap("n", "<c-k><c-d>", _G.format_buffer, {silent = true});

---------------------
-------- LSP --------
---------------------
function _K.hover_doc() vim.cmd.Lspsaga("hover_doc", "++quiet") end
function _K.code_action() vim.cmd.Lspsaga("code_action", "++project") end
function _K.goto_next_diagnostic() vim.diagnostic.goto_next() end
function _K.goto_next_error() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end
function _K.outline() vim.cmd.Lspsaga("outline") end
function _K.rename() vim.cmd.Lspsaga("rename", "++project") end
function _K.show_line_diagnostics() vim.cmd.Lspsaga("show_line_diagnostics") end
function _K.show_cursor_diagnostics() vim.cmd.Lspsaga("show_cursor_diagnostics") end
function _K.show_buf_diagnostics() vim.cmd.Lspsaga("show_buf_diagnostics") end
function _K.show_workspace_diagnostics() vim.cmd.Lspsaga("show_workspace_diagnostics") end
function _K.find_references() vim.cmd.Lspsaga("find_references") end
function _K.peek_definition() vim.cmd.Lspsaga("peek_definition") end
function _K.peek_type_definition() vim.cmd.Lspsaga("peek_type_definition") end
function _K.signature_help() vim.cmd.Lspsaga("signature_help") end


Map("n", "K", _K.hover_doc)
Map("n", "me", _K.goto_next_diagnostic)
Map("n", "mE", _K.goto_next_error)
Map("n", "ma", _K.code_action)
Map("n", "ms", _K.signature_help)
Map("n", "mo", _K.outline)
Map("n", "ml", _K.show_line_diagnostics)
Map("n", "mc", _K.show_cursor_diagnostics)
Map("n", "mf", _K.show_buf_diagnostics)
Map("n", "mw", _K.show_workspace_diagnostics)
Map("n", "mrn", _K.rename)

Map("n", "gr", vim.lsp.buf.references)
Map("n", "gR", _K.find_references)
Map("n", "gp", _K.peek_definition)
Map("n", "gt", _K.peek_type_definition)
Map("n", "gi", vim.lsp.buf.implementation)
Map("n", "gD", vim.lsp.buf.declaration)
Map("n", "gd", vim.lsp.buf.definition)

Map("n", "<leader>rs", vim.cmd.LspRestart) -- mapping to restart lsp if necessary
Map("n", "<leader>ll", vim.cmd.LspStart) -- mapping to restart lsp if necessary
Map("n", "<leader>rs", vim.cmd.LspStop) -- mapping to restart lsp if necessary


keymap("i", "<c-;>", "<Plug>(copilot-next)");
keymap("i", "<c-,>", "<Plug>(copilot-previours)");
keymap("i", "<c-leader>", "<Plug>(copilot-suggest)");


