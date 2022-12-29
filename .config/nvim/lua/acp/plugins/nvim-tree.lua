-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from nvim-tree documentation
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

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

-- configure nvim-tree
nvimtree.setup({
  view = {
    mappings = {
      list = {
        { key = ">", action = "scope_to_node", action_cb = scope_to_node },
        { key = "<", action = "scope_to_parent", action_cb = scope_to_parent },
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
})
