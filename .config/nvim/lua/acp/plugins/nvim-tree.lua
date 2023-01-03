-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

-- Accessing neo-vim for custom commands
local api = require("nvim-tree.api")

local function scope_to_node()
  api.tree.change_root_to_node()
end

local function scope_to_parent()
  api.tree.change_root_to_parent()
end

local function toggle_ignore()
  api.tree.toggle_gitignore_filter()
end

local function toggle_hidden()
  api.tree.toggle_hidden_filter()
end

-- configure nvim-tree
nvimtree.setup({
  view = {
    mappings = {
      list = {
        { key = ">", action = "scope_to_node", action_cb = scope_to_node },
        { key = "<", action = "scope_to_parent", action_cb = scope_to_parent },
        { key = "!", action = "toggle_ignore", action_cb = toggle_ignore },
        { key = "@", action = "toggle_hidden", action_cb = toggle_hidden },
      },
    },
  },
  -- change folder arrow icons
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
    change_dir = {
      enable = true,
      global = true,
    },
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
})
