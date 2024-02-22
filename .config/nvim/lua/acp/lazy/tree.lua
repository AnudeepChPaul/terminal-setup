local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
  vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
  vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "<CR>", function()
    local node = api.tree.get_node_under_cursor()
    api.node.open.edit()
    if node.type == "file" then
      api.tree.close()
    end
  end, opts("Open file & Close afterwards"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "P", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", ">", api.tree.change_root_to_node, opts("scope_to_node"))
  vim.keymap.set("n", "<", api.tree.change_root_to_parent, opts("scope_to_parent"))
  vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
  vim.keymap.set("n", "!", api.tree.toggle_gitignore_filter, opts("toggle_ignore"))
  vim.keymap.set("n", "@", api.tree.toggle_hidden_filter, opts("toggle_hidden"))
  vim.keymap.set("n", "e", api.node.open.horizontal, opts("horizontal_open"))
  vim.keymap.set("n", "s", api.node.open.vertical, opts("vertical_open"))
  vim.keymap.set("n", "o", api.node.run.system, opts("system_open"))
end

local function get_centered_coords(size)
  if size == nil then
    size = 2
  end

  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local maxW = math.floor(width / size)
  local maxH = math.floor(height / size)

  local row = height * (1 / size) / 2
  local col = (width * (1 / size) / 2) - (vim.fn.wincol() / 2)

  return { row = row, col = col, width = maxW, height = maxH }
end

return {
  "nvim-tree/nvim-tree.lua",
  event = "VimEnter",
  config = function()
    local dim = get_centered_coords()
    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = false,
      on_attach = on_attach,
      view = {
        width = dim.width,
        cursorline = true,
        relativenumber = true,
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = dim.width,
            height = dim.height,
            row = dim.row,
            col = dim.col,
          },
        },
      },
      renderer = {
        highlight_git = "all",
        highlight_diagnostics = "all",
        highlight_opened_files = "all",
        highlight_modified = "all",
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
      },
      update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
      },
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
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
    })
  end,
}
