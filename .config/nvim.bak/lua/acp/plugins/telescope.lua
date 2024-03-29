-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")

local lga_actions = require("telescope-live-grep-args.actions")

local previewers = require("telescope.previewers")
local Job = require("plenary.job")

local no_binary_preview = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

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
    buffer_previewer_maker = no_binary_preview,
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
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
telescope.load_extension("project")
-- telescope.load_extension("file_browser")
