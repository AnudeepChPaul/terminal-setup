-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")

local lga_actions = require("telescope-live-grep-args.actions")
--[[
local telescopeConfig = require("telescope.config")
local vimgrep_arguments = telescopeConfig.values.vimgrep_arguments

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "--glob*")
table.insert(vimgrep_arguments, "!**/*.lock")
table.insert(vimgrep_arguments, "--glob*")
table.insert(vimgrep_arguments, "!**/package-lock.json")
table.insert(vimgrep_arguments, "--glob*")
table.insert(vimgrep_arguments, "!**/node_modules/*") ]]

-- local lg_utils = require("lazygit.utils")
--
-- vim.cmd([[
--   autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()
-- ]])

-- configure telescope
telescope.setup({
  extensions = {
    live_grep_args = {
      auto_quoting = false,
      mappings = { -- extend mappings
        i = {
          ["<C-o>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },

  -- configure custom mappings
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--no-ignore",
      "--glob",
      "!**/.git/*",
      "--glob",
      "!**/*.lock",
      "--glob",
      "!**/package-lock.json",
      "--glob",
      "!**/node_modules/*",
      "--glob",
      "!**/dist/*",
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
  pickers = {
    find_files = {
      -- theme = "dropdown",
      --  theme = "cursor",
      -- theme = "ivy",
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--no-ignore",
        "--glob",
        "!**/.git/*",
        "--glob",
        "!**/*.lock",
        "--glob",
        "!**/package-lock.json",
        "--glob",
        "!**/node_modules/*",
      },
      prompt_prefix = " 🔍  ",
    },
    live_grep = {
      -- theme = "dropdown",
      -- theme = "cursor",
      -- theme = "ivy",
      prompt_prefix = " 🔍  ",
      -- find_command = {
      --   "rg",
      --   "--hidden",
      --   "--no-ignore",
      --   "--glob",
      --   "!**/.git/*",
      --   "--glob",
      --   "!**/*.lock",
      --   "--glob",
      --   "!**/package-lock.json",
      --   "--glob",
      --   "!**/node_modules/*",
      -- },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
-- telescope.load_extension("lazygit")
telescope.load_extension("project")
