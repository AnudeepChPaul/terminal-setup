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
end

function _K.peek_definition()
  require("telescope.builtin").lsp_definitions({
    prompt_title = "Peek at symbol definition",
  })
end

function _K.peek_type_definition()
  require("telescope.builtin").lsp_type_definitions({
    prompt_title = "Peek at symbol type definition",
  })
end

function _K.signature_help()
  vim.cmd.Lspsaga("signature_help")
end

function _K.smart_shift()
  vim.opt.shiftwidth = vim.lsp.util.get_effective_tabstop()
end

function _K.toggle_virtual_text()
  vim.diagnostic.config({
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
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

local _T = {}

_T.telescope_live_grep = function()
  require("telescope").extensions.live_grep_args.live_grep_args({
    prompt_title = "Live Grep (root dir)",
  })
end

_T.telescope_live_grep_cwd = function()
  require("telescope").extensions.live_grep_args.live_grep_args({
    cwd = vim.fn.expand("%:p:h"),
    prompt_title = "Live Grep in " .. vim.fn.expand("%"),
  })
end

_T.grep_word_under_cursor = function()
  require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({
    prompt_title = "Searching for " .. vim.fn.expand("<cword>"),
  })
end

_T.grep_word_under_cursor_cwd = function()
  require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({
    cwd = vim.fn.expand("%:p:h"),
    prompt_title = "Searching for " .. vim.fn.expand("<cword>") .. " in " .. vim.fn.expand("%"),
  })
end

_T.find_dot_files = function()
  require("telescope.builtin").find_files({
    cwd = "~/.config",
    prompt_title = "Find dotfiles",
  })
end

_T.find_files = function()
  require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
    previewer = false,
    prompt_title = "Find Files (root dir)",
  }))
end

_T.find_files_in_cwd = function()
  require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
    cwd = vim.fn.expand("%:p:h"),
    previewer = false,
    prompt_title = "Finding files in " .. vim.fn.expand("%:h"),
  }))
end

_T.find_notes = function()
  require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
    cwd = "~/Notes",
    file_ignore_patterns = { ".*%.git/.*", ".*%.obsidian/.*", "Icon", ".*%DS_Store" },
    previewer = false,
    prompt_title = "Searching Obsidian vault"
  }))
end

_T.switch_buffer = function()
  require("telescope.builtin").buffers({
    sort_mru = true,
    sort_lastused = true,
  })
end

_T.command_history = function()
  require("telescope.builtin").command_history({
    previewer = false,
    prompt_title = "Command History",
  })
end

_T.git_files = function()
  require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({
    previewer = false,
    prompt_title = "Find Git Files",
  }))
end

_T.recents = function()
  require("telescope.builtin").oldfiles(require("telescope.themes").get_dropdown({
    previewer = true,
    prompt_title = "Recent",
  }))
end

_T.telescope_keymaps = function()
  require("telescope.builtin").keymaps({
    previewer = true,
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

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    local wk = require("which-key")
    local tree_exists, api = pcall(require, "nvim-tree")

    wk.add({
      silent = true,
      {
        "<c-/>",
        function()
          require("which-key").show({ global = true, loop = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      { "<Up>",    "<nop>",       desc = "No operation" },
      { "<Down>",  "<nop>",       desc = "No operation" },
      { "<Left>",  "<nop>",       desc = "No operation" },
      { "<Right>", "<nop>",       desc = "No operation" },
      { "Q",       "<nop>",       desc = "No operation" },
      { "<c-w>",   ":q<cr>",      desc = "Close window/panel" },
      { ";s",      _H.quick_menu, desc = "Toggle harpoon quick menu" },
      { ";a",      _H.add_file,   desc = "Add file to harpoon quick list" },
      { ";1",      _H.goto_one,   desc = "Goto 1st harpoon file" },
      { ";2",      _H.goto_two,   desc = "Goto 2nd harpoon file" },
      { ";3",      _H.goto_three, desc = "Goto 3rd harpoon file" },
      { ";4",      _H.goto_four,  desc = "Goto 4th harpoon file" },
      { ";5",      _H.goto_five,  desc = "Goto 5th harpoon file" },
      { ";6",      _H.goto_six,   desc = "Goto 6th harpoon file" },
      { ";7",      _H.goto_seven, desc = "Goto 7th harpoon file" },
      { ";8",      _H.goto_eight, desc = "Goto 8th harpoon file" },
      { ";9",      _H.goto_nine,  desc = "Goto 9th harpoon file" },
      { "H",       ":nohl<CR>",   desc = "Clear search highlights" },
      {
        "<space>sp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Switch Projects",
      },
      { "<space>sv", "<C-w>v",         desc = "Split window vertically" },
      { "<space>ss", "<C-w>s",         desc = "Split window horizontally" },
      { "<space>se", "<C-w>=",         desc = "Split windows equal hight & width" },
      { "<space>sx", vim.cmd.close,    desc = "Close current split window" },
      { "<space>bx", vim.cmd.bd,       desc = "Close current buffer" },
      { "<space>tt", vim.cmd.tabnew,   desc = "Opens new tab" },
      { "<space>tx", vim.cmd.tabclose, desc = "Close newly opened tab" },
      {
        "L",
        'V"-y"-p',
        desc = "Duplicates a line without copying to clipboard",
      },
      {
        "<space>li",
        function()
          if Snacks.indent.enabled == true then
            Snacks.indent.disable()
          else
            Snacks.indent.enable()
          end
        end,
        desc = "Toggles indentation guides",
      },
      {
        "<space>lw",
        ":set list!<CR>",
        desc = "Toggles list characters like Tab, space, newline",
      },
      { "<space>lr", ":set rnu!<CR>",             desc = "Toggles relative numbering" },
      {
        "x",
        '"_x',
        desc = "Delete single character without copying into register",
      },
      { "U",         "<C-r>",                     desc = "Redo" },
      { "dw",        'vb"_d',                     desc = "Delete word backwards" },
      { "cp",        ':let @*=expand("%:p")<CR>', desc = "Delete word backwards" },
      { "+",         "<C-a>",                     desc = "Increment number" },
      { "-",         "<C-x>",                     desc = "Decrement number" },
      {
        "J",
        "mzJ`z",
        desc = "Bring botton line at the current line end",
      },
      { "<space>e", "<cmd>lua Snacks.explorer()<cr>", desc = "Snaks file explorer" },
      { "<c-a>",    "gg<S-v>G",                       desc = "Select all words" },
      { "<c-d>",    "<C-d>zz",                        desc = "Scrolls down with cursor at centre" },
      { "<c-u>",    "<C-u>zz",                        desc = "Scrolls up with cursor at centre" },
      { "<c-h>",    ":TmuxNavigateLeft<CR>",          desc = "Tmux navigate left" },
      { "<c-j>",    ":TmuxNavigateDown<CR>",          desc = "Tmux navigate down",                silent = true },
      { "<c-k>",    ":TmuxNavigateUp<CR>",            desc = "Tmux navigate up" },
      { "<c-l>",    ":TmuxNavigateRight<CR>",         desc = "Tmux navigate right" },
      {
        "n",
        "nzzzv",
        desc = "Goto next seach occurrence with cursor at center",
      },
      {
        "N",
        "Nzzzv",
        desc = "Goto previous seach occurrence with cursor at center",
      },
      { "<S-Left>",  "<C-w><",      desc = "Expand Split window left" },
      { "<S-Right>", "<C-w>>",      desc = "Expand Split window right" },
      { "<S-Up>",    "<C-w>+",      desc = "Expand Split window up" },
      { "<S-Down>",  "<C-w>-",      desc = "Expand Split window down" },
      { "<S-TAB>",   vim.cmd.bnext, desc = "Move to load next buffer" },
      { "<C-\\>",    "<ESC><ESC>",  desc = "Escape" },
      {
        "J",
        ":m '>+1<CR>gv=gv",
        desc = "Moves line one down",
        mode = { "v", "x" },
      },
      {
        "K",
        ":m '<-2<CR>gv=gv",
        desc = "Moves line one up",
        mode = { "v", "x" },
      },
      {
        "<",
        "<gv",
        desc = "Indents left",
        mode = { "v", "x" },
      },
      {
        ">",
        ">gv",
        desc = "Indents right",
        mode = { "v", "x" },
      },
      {
        "p",
        '"_dP"',
        desc = "Paste's a line without copying the replacement",
        mode = { "v", "x" },
      },
      { "<leader>r", ":s/",                          desc = "Replaces search term within selection" },
      { "<C-\\>",    "<ESC><ESC><ESC>",              desc = "Escape" },
      { "<C-c>",     "<ESC>",                        desc = "Escape" },
      { "K",         vim.lsp.buf.hover,              desc = "Impersonates hover effect" },
      { "md",        _K.format_buffer,               desc = "Formats the buffer with smart indent" },
      { "mq",        vim.cmd.LspRestart,             desc = "Lsp restart" },
      { "msrn",      ":Lspsaga rename",              desc = "Lspsaga renaming with highlighting" },
      { "msi",       ":Lspsaga incoming_calls<cr>",  desc = "Lspsaga incoming calls" },
      { "mso",       ":Lspsaga outgoing_calls<cr>",  desc = "Lspsaga outgoing calls" },
      { "msk",       ":Lspsaga peek_definition<cr>", desc = "Lspsaga peek definition/hover" },
      {
        "me",
        _K.goto_next_diagnostic,
        desc = "Goto next diagnostic (including error, info, warning etc)",
      },
      { "mE", _K.goto_next_error,            desc = "Goto next error" },
      { "ma", _K.code_action,                desc = "Shows code action for cursor" },
      { "mk", _K.signature_help,             desc = "LspSaga shows signature help" },
      { "mt", _K.toggle_virtual_text,        desc = "LspSaga toggle virtual text" },
      { "mo", _K.outline,                    desc = "LspSaga show sugnature outline" },
      { "ml", _K.show_line_diagnostics,      desc = "LspSaga show line diagnostics" },
      { "mL", _K.show_cursor_diagnostics,    desc = "LspSaga show cursor diagnostics" },
      { "mf", _K.show_buf_diagnostics,       desc = "LspSaga show buffer diagnostics" },
      { "mw", _K.show_workspace_diagnostics, desc = "LspSaga show workspace diagnostics" },
      {
        "mcs",
        "<Plug>CaserVSnakeCase",
        desc = "Change case to snake_case",
        mode = { "n", "v", "x" },
      },
      { "mr",  "",                 desc = "+refactor",                        mode = { "n", "v" } },
      { "mrl", vim.lsp.buf.rename, desc = "Lsp renaming without highlighting" },
      { "mrn", ":IncRename ",      desc = "Lsp renaming with highlighting" },
      {
        "mri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        "mrb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
      {
        "mrf",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        desc = "Extract Block To File",
      },
      {
        "mrP",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        desc = "Debug Print",
      },
      {
        "mrp",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        desc = "Debug Print Variable",
      },
      {
        "mrc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
      {
        "mrf",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "mrF",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        "mrx",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        "mrp",
        function()
          require("refactoring").debug.print_var()
        end,
        mode = "v",
        desc = "Debug Print Variable",
      },
      { "gr",         ":Lspsaga finder def+ref+tyd<cr>", desc = "Lspsaga references+definition+type_definition " },
      { "gR",         vim.lsp.buf.references,            desc = "Find symbol references" },
      { "gp",         _K.peek_definition,                desc = "Peek at symbol defintion" },
      { "gt",         _K.peek_type_definition,           desc = "Peek at symbol type definition" },
      { "gi",         ":Lspsaga finder imp<cr>",         desc = "Lspsage goto_implementations" },
      { "gD",         _K.goto_declaration,               desc = "Goto buffer declaration.." },
      { "gd",         _K.goto_definition,                desc = "Goto buffer definition.." },
      { "<c-f><c-r>", _T.resume,                         desc = "Resume" },
      { "<c-f><c-f>", _T.find_files,                     desc = "Find Files (root dir)" },
      { "<c-f>f",     _T.find_files_in_cwd,              desc = "Find files in (current dir) cwd" },
      { "<c-f><c-n>", _T.find_notes,                     desc = "Find obsidian notes" },
      {
        "<c-f><c-j>",
        function()
          local word = vim.fn.expand("<cword>")
          if word ~= nil and string.len(word) >= 2 then
            _T.grep_word_under_cursor()
          else
            _T.telescope_live_grep()
          end
        end,
        desc = "Grep with current word(root dir)",
        mode = { "n", "v", "x" },
        silent = true,
        noremap = true,
        nowait = true,
      },
      {
        "<c-f><c-k>",
        function()
          local word = vim.fn.expand("<cword>")
          if word ~= nil and string.len(word) >= 2 then
            _T.grep_word_under_cursor_cwd()
          else
            _T.telescope_live_grep_cwd()
          end
        end,
        desc = "Grep (current dir) cwd",
        silent = true,
        noremap = true,
        nowait = true,
      },
      { "<c-f>k",     "<cmd>lua Snacks.picker.keymaps({ layout= 'telescope' })<cr>",         desc = "Find Key Maps" },
      {
        "<c-f>c",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Find files",
            cwd = "~/.config/nvim/",
          })
        end,
        desc = "Find Key Maps",
      },
      { "<c-f>b",     _T.switch_buffer,                                                      desc = "List and Switch Buffer" },
      { "<c-f>h",     "<cmd>lua Snacks.picker.command_history({ layout= 'telescope' })<cr>", desc = "Command History" },
      { "<c-f><c-b>", "<cmd>lua Snacks.picker.recent({ layout= 'telescope' })<cr>",          desc = "Recent" },
      { "<c-f>m",     _T.marks,                                                              desc = "Jump to Mark" },
      { "<c-f>M",     _T.man_pages,                                                          desc = "Man Pages" },
      { "<c-f><c-h>", _T.help_tags,                                                          desc = "Help Pages" },
      { "<leader>sH", _T.highlight_groups,                                                   desc = "Search Highlight Groups" },
      { "<c-f><c-l>", _T.find_in_quickfix,                                                   desc = "Find in Quick Fix" },
      { "<c-f><c-m>", _T.find_dot_files,                                                     desc = "Find in dotfiles" },
      {
        "<c-g><c-o>",
        function()
          Snacks.lazygit()
        end,
        desc = "Open git (lazygit)",
      },
      {
        "<c-g><c-b>",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Open git repo in browser",
      },
      { "<c-g><c-f>", _T.git_files,                    desc = "Find Files (git-files)" },
      { "<c-g>p",     ":Git pull origin<cr>",          desc = "Git pull origin" },
      { "<c-g>f",     ":Git fetch",                    desc = "Git fetch" },
      { "<c-g><c-p>", ":Git pull origin --rebase<cr>", desc = "Git pull origin --rebase" },
      { "<c-g>P",     ":Git push<cr>",                 desc = "git push" },
      { "<c-g>Pf",    ":Git push --force<cr>",         desc = "Git push --force" },
      {
        "<c-s>k",
        ":e ~/.config/nvim/lua/plugins/whichkey.lua<cr>",
        desc = "Edit/Modify keymaps/keyboard shortcuts",
      },
      {
        "<c-s>o",
        ":e ~/.config/nvim/lua/config/options.lua<cr>",
        desc = "Edit/Modify options lua",
      },
      {
        "<C-\\>",
        "<ESC><ESC>",
        desc = "Escape",
        mode = "i",
      },
      {
        "<C-c>",
        "<ESC><ESC><ESC>",
        desc = "Escape",
        mode = "i",
      },
      {
        "<c-h>",
        "<left>",
        desc = "Insert mode (Move left)",
        mode = "i",
      },
      {
        "<c-l>",
        "<right>",
        desc = "Insert mode (Move right)",
        mode = "i",
      },
      {
        "<c-j>",
        "<down>",
        desc = "Insert mode (Move down)",
        mode = "i",
      },
      {
        "<c-k>",
        "<up>",
        desc = "Insert mode (Move up)",
        mode = "i",
      },
      {
        "<space>lf",
        function()
          vim.opt.foldlevel = tonumber(vim.fn.input("Set fold level: "))
        end,
        desc = "Sets fold level from user input",
      },
      {
        "<c-s><c-o>",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    }, {
      silent = true,
      noremap = true,
    })

    if tree_exists then
      wk.add({
        { "<c-e>", api.tree.toggle, desc = "Toggle file explorer" },
        {
          "<space>fl",
          function()
            api.tree.open({ find_file = true })
          end,
          desc = "Toggle file explorer",
        },
      }, { mode = "n" })
    else
      wk.add({
        {
          "<c-e>",
          ":Neotree position=float <cr>",
          desc = "Toggle file explorer",
        },
        {
          "<space>fl",
          ":Neotree position=float reveal=true reveal_force_cwd <cr>",
          desc = "Toggle file explorer",
        },
      }, { mode = "n" })
    end
  end,
}
