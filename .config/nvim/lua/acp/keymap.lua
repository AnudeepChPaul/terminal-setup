-- Keymaps are automatically loaded on the VeryLazy event
-- set leader key to space
vim.g.mapleader = " "

-- local function Map(key, left, right, desc)
--   vim.keymap.set(key, left, right, { noremap = true, silent = true, desc = desc })
-- end

local function register(wk, _opts)
  ---------------------
  -- General Keymaps
  ---------------------
  local n_opts = {
    noremap = true,
    silent = true,
    mode = "n",
  }
  local v_opts = {
    noremap = true,
    silent = true,
    mode = "v",
  }
  local i_opts = {
    noremap = true,
    silent = true,
    mode = "i",
  }
  local x_opts = {
    mode = "x",
    noremap = true,
    silent = true,
  }

  -- Noop bindings
  local no_op_bindings = {
    ["<Up>"] = { "<nop>", "No operation" },
    ["<Down>"] = { "<nop>", "No operation" },
    ["<Left>"] = { "<nop>", "No operation" },
    ["<Right>"] = { "<nop>", "No operation" },
    ["Q"] = { "<nop>", "No operation" },
  }

  -- Insert mode binding for faster escapes
  local i_mode_bindings = {
    ["<c-;>"] = { "<Plug>(copilot-next)", "Copilot next suggestion" },
    ["<c-,>"] = { "<Plug>(copilot-previours)", "Copilot previous suggestion" },
    ["<c-space>"] = { "<Plug>(copilot-suggest)", "Copilot suggest" },
    ["<C-\\>"] = { "<ESC>", "Escape" },
    ["<C-c>"] = { "<ESC>", "Escape" },
  }

  local function set_fold_level()
    local l = vim.fn.input("Set fold level: ")

    vim.opt.foldlevel = tonumber(l)
  end

  local n_utility_bindings = {
    ["<leader>"] = {
      ["nh"] = { ":nohl<CR>", "Clear search highlights" },
      ["sv"] = { "<C-w>v", "Split window vertically" },
      ["ss"] = { "<C-w>s", "Split window horizontally" },
      ["se"] = { "<C-w>=", "Split windows equal hight & width" },
      ["sx"] = { vim.cmd.close, "Close current split window" },
      ["bx"] = { vim.cmd.bd, "Close current buffer" },
      ["tt"] = { vim.cmd.tabnew, "Opens new tab" },
      ["tx"] = { vim.cmd.tabclose, "Close newly opened tab" },
      ["m"] = { 'V"-y"-p', "Duplicates a line without copying to clipboard" },
      ["li"] = { ":IBLToggle<CR>", "Toggles indentation guides" },
      ["lw"] = { ":set list!<CR>", "Toggles list characters like Tab, space, newline" },
      ["lr"] = { ":set rnu!<CR>", "Toggles relative numbering" },
      ["lf"] = { set_fold_level, "Sets fold level from user input" },
      ["sR"] = {
        function()
          require("spectre").open()
        end,
        "Replace in files (Spectre)",
      },
    },
    ["x"] = { '"_x', "Delete single character without copying into register" },
    -- ["w"] = { "<ESC>vw", "go to start of next word with selection" },
    -- ["e"] = { "<ESC>ve", "go to end of current word with selection" },
    -- ["b"] = { "<ESC>vb", "go backwards end of current word with selection" },
    ["U"] = { "<C-r>", "Redo" },
    ["dw"] = { 'vb"_d', "Delete word backwards" },
    ["<C-a>"] = { "gg<S-v>G", "Select all words" },
    ["+"] = { "<C-a>", "Increment number" },
    ["-"] = { "<C-x>", "Decrement number" },
    ["J"] = { "mzJ`z", "Bring botton line at the current line end" },
    ["<c-d>"] = { "<C-d>zz", "Scrolls down with cursor at centre" },
    ["<c-u>"] = { "<C-u>zz", "Scrolls up with cursor at centre" },
    ["<c-h>"] = { ":TmuxNavigateLeft<CR>", "Tmux navigate left" },
    ["<c-j>"] = { ":TmuxNavigateDown<CR>", "Tmux navigate down" },
    ["<c-k>"] = { ":TmuxNavigateUp<CR>", "Tmux navigate up" },
    ["<c-l>"] = { ":TmuxNavigateRight<CR>", "Tmux navigate right" },
    ["<c-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>" },
    ["n"] = { "nzzzv", "Goto next seach occurrence with cursor at center" },
    ["N"] = { "Nnzzzv", "Goto previous seach occurrence with cursor at center" },
    ["<S-Left>"] = { "<C-w><", "Expand Split window left" },
    ["<S-Right>"] = { "<C-w>>", "Expand Split window right" },
    ["<S-Up>"] = { "<C-w>+", "Expand Split window up" },
    ["<S-Down>"] = { "<C-w>-", "Expand Split window down" },
    ["<S-TAB>"] = { vim.cmd.bnext, "Move to load next buffer" },
  }

  local x_mode_bindings = {
    ["p"] = { '"_dP"', "Paste's a line without copying the replacement" },
  }

  local v_utility_bindings = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Moves line one down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Moves line one up" },
    -- ["w"] = { "<ESC>vw", "go to start of next word with selection" },
    -- ["e"] = { "<ESC>ve", "go to end of current word with selection" },
    -- ["b"] = { "<ESC>vb", "go backwards end of current word with selection" },
    ["<"] = { "<gv", "Indents left" },
    [">"] = { ">gv", "Indents right" },
    ["<leader>r"] = { ":s/", "Replaces search term within selection" },
  }

  -- GitSigns
  local _G = {}
  function _G.toggle_current_line_blame()
    vim.cmd.Gitsigns("toggle_current_line_blame")
  end

  function _G.git_diff_this()
    vim.cmd.Gitsigns("diffthis")
  end

  local n_git_bindgins = {
    ["gl"] = { _G.toggle_current_line_blame, "Toggles current line git blame" },
    ["gL"] = { _G.git_diff_this, "Shows current file difference" },
    ["<leader>go"] = { vim.cmd.Git, "Shows git fugitive window" },
  }

  -- harpoon
  local _H = {}

  function _H.nav_next()
    require("harpoon.ui").nav_next()
  end

  function _H.add_file()
    require("harpoon.mark").add_file()
  end

  function _H.quick_menu()
    require("harpoon.ui").toggle_quick_menu()
  end

  function _H.goto_one()
    require("harpoon.ui").nav_file(1)
  end

  function _H.goto_two()
    require("harpoon.ui").nav_file(2)
  end

  function _H.goto_three()
    require("harpoon.ui").nav_file(3)
  end

  function _H.goto_four()
    require("harpoon.ui").nav_file(4)
  end

  function _H.goto_five()
    require("harpoon.ui").nav_file(5)
  end

  function _H.goto_six()
    require("harpoon.ui").nav_file(6)
  end

  function _H.goto_seven()
    require("harpoon.ui").nav_file(7)
  end

  function _H.goto_eight()
    require("harpoon.ui").nav_file(8)
  end

  function _H.goto_nine()
    require("harpoon.ui").nav_file(9)
  end

  local n_harpoon_maps = {
    ["<C-TAB>"] = { _H.nav_next, "Goto next harpoon file" },
    [";a"] = { _H.add_file, "Add file to harpoon quick list" },
    [";s"] = { _H.quick_menu, "Toggle harpoon quick menu" },
    [";1"] = { _H.goto_one, "Goto 1st harpoon file" },
    [";2"] = { _H.goto_two, "Goto 2nd harpoon file" },
    [";3"] = { _H.goto_three, "Goto 3rd harpoon file" },
    [";4"] = { _H.goto_four, "Goto 4th harpoon file" },
    [";5"] = { _H.goto_five, "Goto 5th harpoon file" },
    [";6"] = { _H.goto_six, "Goto 6th harpoon file" },
    [";7"] = { _H.goto_seven, "Goto 7th harpoon file" },
    [";8"] = { _H.goto_eight, "Goto 8th harpoon file" },
    [";9"] = { _H.goto_nine, "Goto 9th harpoon file" },
  }

  ---------------------
  -------- LSP --------
  ---------------------

  local _K = {}
  function _K.format_buffer()
    vim.api.nvim_command(":retab")
    _K.smart_shift()
    vim.lsp.buf.format()
  end

  function _K.hover_doc()
    vim.cmd.Lspsaga("hover_doc", "++quiet")
  end

  function _K.code_action()
    vim.lsp.buf.code_action()
    -- vim.cmd.Lspsaga("code_action", "++project")
  end

  function _K.goto_next_diagnostic()
    vim.diagnostic.goto_next()
  end

  function _K.goto_next_error()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end

  function _K.outline()
    vim.cmd.Lspsaga("outline")
  end

  function _K.rename()
    vim.cmd.Lspsaga("rename", "++project")
  end

  function _K.show_line_diagnostics()
    vim.cmd.Lspsaga("show_line_diagnostics")
  end

  function _K.show_cursor_diagnostics()
    vim.cmd.Lspsaga("show_cursor_diagnostics")
  end

  function _K.show_buf_diagnostics()
    require("telescope.builtin").diagnostics({
      prompt_title = "Buffer Diagnostics",
      sort_by = "severity",
    })
    -- vim.cmd.Lspsaga("show_buf_diagnostics")
  end

  function _K.show_workspace_diagnostics()
    require("telescope.builtin").diagnostics({
      prompt_title = "Buffer Diagnostics",
      sort_by = "severity",
    })
    -- vim.cmd.Lspsaga("show_workspace_diagnostics")
  end

  function _K.goto_definition()
    require("telescope.builtin").lsp_definitions({
      prompt_title = "Find Definitions",
    })
    -- vim.cmd.Lspsaga("find_references")
  end

  function _K.goto_declaration()
    require("telescope.builtin").lsp_declarations({
      prompt_title = "Find Declarations",
    })
  end

  function _K.goto_implementations()
    vim.lsp.buf.implementation()
    -- require("telescope.builtin").lsp_implementations({
    --   prompt_title = "Find Implementations",
    -- })
  end

  function _K.find_references()
    require("telescope.builtin").lsp_references({
      prompt_title = "Find References",
    })
    -- vim.cmd.Lspsaga("find_references")
  end

  function _K.peek_definition()
    require("telescope.builtin").lsp_definitions({
      prompt_title = "Peek at symbol definition",
    })
    -- vim.cmd.Lspsaga("peek_definition")
  end

  function _K.peek_type_definition()
    require("telescope.builtin").lsp_type_definitions({
      prompt_title = "Peek at symbol type definition",
    })
    -- vim.cmd.Lspsaga("peek_type_definition")
  end

  function _K.signature_help()
    vim.cmd.Lspsaga("signature_help")
  end

  function _K.smart_shift()
    vim.opt.shiftwidth = vim.lsp.util.get_effective_tabstop()
  end

  -- Keymaps and functions for trouble plugin
  function _K.toggle_trouble()
    require("trouble").toggle()
  end

  function _K.goto_next_trouble()
    if require("trouble").is_open() then
      require("trouble").next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end

  function _K.goto_prev_trouble()
    if require("trouble").is_open() then
      require("trouble").previous({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprevious)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end

  local n_lsp_keybinds = {
    ["<c-k><c-d>"] = { _K.format_buffer, "Formats the buffer with smart indent" },
    ["K"] = { vim.lsp.buf.hover, "Impersonates hover effect" },
    ["me"] = { _K.goto_next_diagnostic, "Goto next diagnostic (including error, info, warning etc)" },
    ["mE"] = { _K.goto_next_error, "Goto next error" },
    ["ma"] = { _K.code_action, "Shows code action for cursor" },
    ["ms"] = { _K.signature_help, "LspSaga shows signature help" },
    ["mo"] = { _K.outline, "LspSaga show sugnature outline" },
    ["ml"] = { _K.show_line_diagnostics, "LspSaga show line diagnostics" },
    ["mc"] = { _K.show_cursor_diagnostics, "LspSaga show cursor diagnostics" },
    ["mf"] = { _K.show_buf_diagnostics, "LspSaga show buffer diagnostics" },
    ["mw"] = { _K.show_workspace_diagnostics, "LspSaga show workspace diagnostics" },
    ["mrl"] = { vim.lsp.buf.rename, "Lsp renaming without highlighting" },
    ["mrn"] = { ":IncRename ", "Lsp renaming with highlighting" },
    ["gR"] = { vim.lsp.buf.references, "Find symbol references" },
    ["gr"] = { _K.find_references, "Find LspSaga symbol references" },
    ["gp"] = { _K.peek_definition, "Peek at symbol defintion" },
    ["gt"] = { _K.peek_type_definition, "Peek at symbol type definition" },
    ["gi"] = { _K.goto_implementations, "Goto buffer implementation" },
    ["gD"] = { _K.goto_declaration, "Goto buffer declaration.." },
    ["gd"] = { _K.goto_definition, "Goto buffer definition.." },
    ["<leader>"] = {
      ["rr"] = { vim.cmd.LspRestart, " mapping to restart lsp if necessary" },
      ["ll"] = { vim.cmd.LspStart, " mapping to restart lsp if necessary" },
      ["rs"] = { vim.cmd.LspStop, " mapping to restart lsp if necessary" },
      ["tr"] = { _K.toggle_trouble, "Toggles trouble window" },
      ["tj"] = { _K.goto_next_trouble, "Goto next trouble" },
      ["tk"] = { _K.goto_prev_trouble, "Goto previous trouble" },
    },
  }

  local _T = {}

  _T.telescope_live_grep = function()
    require("telescope").extensions.live_grep_args.live_grep_args({
      prompt_title = "Live Grep (root dir)",
    })
  end

  _T.telescope_live_grep_cwd = function()
    require("telescope").extensions.live_grep_args.live_grep_args({
      cwd = vim.fn.expand("%:p:h"),
      prompt_title = "Live Grep " .. vim.fn.expand("%:h"),
    })
  end

  _T.grep_word_under_cursor = function()
    require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({
      prompt_title = "Searching for " .. vim.fn.expand("<cword>"),
    })
  end

  _T.find_files = function()
    require("telescope.builtin").find_files({
      prompt_title = "Find Files (root dir)",
    })
  end

  _T.find_files_in_cwd = function()
    require("telescope.builtin").find_files({
      cwd = vim.fn.expand("%:p:h"),
      prompt_title = "Finding files in " .. vim.fn.expand("%:h"),
    })
  end

  _T.switch_buffer = function()
    require("telescope.builtin").buffers({
      sort_mru = true,
      sort_lastused = true,
    })
  end

  _T.command_history = function()
    require("telescope.builtin").command_history({
      prompt_title = "Command History",
    })
  end

  _T.git_files = function()
    require("telescope.builtin").git_files({
      prompt_title = "Find Files (git-files)",
    })
  end

  _T.recents = function()
    require("telescope.builtin").oldfiles({
      prompt_title = "Recent",
    })
  end

  _T.telescope_keymaps = function()
    require("telescope.builtin").keymaps({
      prompt_title = "Find Key Maps",
    })
  end

  _T.marks = function()
    require("telescope.builtin").marks({
      prompt_title = "Jump to Mark",
    })
  end

  _T.man_pages = function()
    require("telescope.builtin").man_pages({
      prompt_title = "Man Pages",
    })
  end

  _T.resume = function()
    require("telescope.builtin").resume()
  end

  _T.help_tags = function()
    require("telescope.builtin").help_tags({
      prompt_title = "Help Pages",
    })
  end

  _T.highlight_groups = function()
    require("telescope.builtin").highlights({
      prompt_title = "Search Highlight Groups",
    })
  end

  _T.find_in_quickfix = function()
    require("telescope.builtin").quickfix({
      prompt_title = "Find in Quickfix",
    })
  end

  _T.search_symbol = function()
    require("telescope.builtin").lsp_workspace_symbols({
      prompt_title = "Searching LSP Workspace Symbols",
    })
  end

  local n_telescope_bindings = {
    ["<leader>"] = {
      ["<space>"] = { _T.find_files, "Find Files (root dir)" },
      ["ff"] = { _T.find_files_in_cwd, "Find Files in current working dir" },
      ["fF"] = { _T.find_files_in_cwd, "Find files in cwd" },
      ["fs"] = { _T.telescope_live_grep, "Grep (root dir)" },
      ["fS"] = { _T.telescope_live_grep_cwd, "Grep (root dir)" },
      ["fb"] = { _T.switch_buffer, "Switch Buffer" },
      ["fc"] = { _T.command_history, "Command History" },
      ["fg"] = { _T.git_files, "Find Files (git-files)" },
      ["fr"] = { _T.recents, "Recent" },
      ["fq"] = { _T.find_in_quickfix, "Find in Quick Fix" },
      ["sw"] = { _T.grep_word_under_cursor, "Search word under cursor" },
      ["sk"] = { _T.telescope_keymaps, "Find Key Maps" },
      ["sm"] = { _T.marks, "Jump to Mark" },
      ["sM"] = { _T.man_pages, "Man Pages" },
      ["sh"] = { _T.help_tags, "Help Pages" },
      ["sb"] = { _T.search_symbol, "Search LSP Workspace Symbols" },
      ["sH"] = { _T.highlight_groups, "Search Highlight Groups" },
      ["sr"] = { _T.resume, "Resume" },
      ["qf"] = { _T.find_in_quickfix, "Find in Quick Fix" },
    },
  }

  local tree_exists, api = pcall(require, "nvim-tree")
  local n_tree_bindings = {}
  -- BEGIN_DEFAULT_ON_ATTACH
  -- nvim-tree
  if tree_exists then
    n_tree_bindings = {
      -- ["<leader>"] = {
      --   ["e"] = { ":NvimTreeOpen<CR>", "Toggle file explorer" },
      --   ["w"] = { ":NvimTreeClose<CR>", "Toggle file explorer" },
      --   ["rr"] = { ":NvimTreeRefresh<CR>", "Refresh file explorer" },
      --   ["fl"] = { ":NvimTreeFindFile<CR>", "Find file in file explorer" },
      -- },
      ["<leader>"] = {
        ["d"] = { api.tree.toggle, "Toggle file explorer" },
        ["fl"] = {
          function()
            api.tree.open({ find_file = true })
          end,
          "Toggle file explorer",
        },
      },
    }
  else
    n_tree_bindings = {
      ["<leader>"] = {
        ["d"] = { ":Neotree position=float <cr>", "Toggle file explorer" },
        ["fl"] = { ":Neotree position=float reveal=true reveal_force_cwd <cr>", "Find file in file explorer" },
      },
    }
  end

  wk.register(n_lsp_keybinds, n_opts)
  wk.register(n_git_bindgins, n_opts)
  wk.register(n_harpoon_maps, n_opts)
  wk.register(no_op_bindings, n_opts)
  wk.register(no_op_bindings, v_opts)
  wk.register(i_mode_bindings, i_opts)
  wk.register(x_mode_bindings, x_opts)
  wk.register(v_utility_bindings, v_opts)
  wk.register(n_utility_bindings, n_opts)
  wk.register(n_telescope_bindings, n_opts)
  wk.register(n_tree_bindings, n_opts)
end

return {
  register = register,
}
-- telescope
-- Map("n", "<leader>fr", "<cmd>Telescope resume<cr>") -- Lists the results incl. multi-selections of the previous picker
-- Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
-- Map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>") -- find files within current working directory, respects .gitignore
-- Map("n", "<leader>gf", "<cmd>Telescope git_files<cr>") -- find string in current working directory as you type
-- -- Map("n", "<leader>fs", require("telescope").extensions.live_grep_args.live_grep_args)
-- Map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
-- Map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
-- Map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
-- Map("n", "<leader>gg", "<cmd>LazyGit<CR>")
--
-- -- telescope git commands (not on youtube nvim video)
-- Map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
-- Map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- Map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
-- Map("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

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

---------------------
-- COC Keymaps
---------------------
-- function _G.toggle_outline()
--   return vim.cmd([[
--     let winid = coc#window#find('cocViewId', 'OUTLINE')
--     if winid == -1
--     call CocActionAsync('showOutline', 1)
--     else
--     call coc#window#close(winid)
--     endif
--     ]])
-- end

-- function _G.show_docs()
--   local cw = vim.fn.expand("<cword>")
--   if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
--     vim.api.nvim_command("h " .. cw)
--   elseif vim.api.nvim_eval("coc#rpc#ready()") then
--     vim.fn.CocActionAsync("definitionHover")
--   else
--     vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
--   end
-- end
