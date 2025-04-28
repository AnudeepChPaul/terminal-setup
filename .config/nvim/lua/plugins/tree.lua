return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  event = { "VimEnter" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
  },
  opts = {
    window = {
      mappings = {
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["<c-c>"] = "cancel",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["w"] = "open_with_window_picker",
        ["e"] = function()
          vim.api.nvim_exec("Neotree position=float focus filesystem", true)
        end,
        ["b"] = function()
          vim.api.nvim_exec("Neotree position=float focus buffers", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree position=float focus git_status", true)
        end,
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
        hide_gitignored = false,
        hide_hidden = true,
        always_show = { -- remains visible even if other settings would normally hide it
          ".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
        },
        hide_by_name = {
          "node_modules",
        },
      },
      commands = {
        delete = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local popup = require("neo-tree.ui.inputs")

          popup.confirm(string.format("Sure to delete %s ? (y/n)", node.name), function(answer)
            if answer then
              vim.fn.system({ "trash", vim.fn.fnameescape(path) })
              require("neo-tree.sources.manager").refresh("filesystem")
            end
          end)
        end,
        delete_visual = function(_, nodes)
          local popup = require("neo-tree.ui.inputs")
          local paths_to_trash = {}

          for _, node in ipairs(nodes) do
            if node.type ~= "message" then
              table.insert(paths_to_trash, node.path)
            end
          end

          popup.confirm(string.format("Sure to delete %d items ? (y/n)", #paths_to_trash), function(answer)
            if answer then
              for _, node in ipairs(paths_to_trash) do
                vim.fn.system({ "trash", vim.fn.fnameescape(node) })
              end
              require("neo-tree.sources.manager").refresh("filesystem")
            end
          end)
        end,
      },
      renderers = {
        file = {
          { "indent" },
          { "icon" },
          { "name", use_git_status_colors = true },
          { "harpoon_index" },
          {
            "container",
            content = {
              {
                "symlink_target",
                zindex = 10,
                highlight = "NeoTreeSymbolicLinkTarget",
              },
              { "clipboard", zindex = 10 },
              { "bufnr", zindex = 10 },
              { "modified", zindex = 20, align = "right" },
              { "diagnostics", zindex = 20, align = "right" },
              { "git_status", zindex = 10, align = "right" },
              { "file_size", zindex = 10, align = "right" },
              { "type", zindex = 10, align = "right" },
              { "last_modified", zindex = 10, align = "right" },
              { "created", zindex = 10, align = "right" },
            },
          },
          { "diagnostics" },
          { "git_status", highlight = "NeoTreeDimText" },
        },
      },
      components = {
        icon = function(config, node, _)
          local highlights = require("neo-tree.ui.highlights")

          local icon = config.default or " "
          local padding = config.padding or " "
          local highlight = config.highlight or highlights.FILE_ICON

          if node.type == "directory" then
            highlight = highlights.DIRECTORY_ICON
            if node:is_expanded() then
              icon = config.folder_open or "-"
            else
              icon = config.folder_closed or "+"
            end
          elseif node.type == "file" then
            local success, web_devicons = pcall(require, "nvim-web-devicons")
            if success then
              local devicon, hl = web_devicons.get_icon(node.name, node.ext)
              icon = devicon or icon
              highlight = hl or highlight
            end
          end

          return {
            text = icon .. padding,
            highlight = highlight,
          }
        end,
        harpoon_index = function(config, node, _)
          local Marked = require("harpoon.mark")
          local path = node:get_id()
          local success, index = pcall(Marked.get_index_of, path)
          if success and index and index > 0 then
            return {
              text = string.format("——————————► (%d)", index),
              highlight = config.highlight or "NeoTreeDirectoryIcon",
            }
          else
            return {
              text = "  ",
            }
          end
        end,
      },
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "├",
        last_indent_marker = "└",
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
      {
        event = "file_renamed",
        handler = function(args)
          -- fix references to file
          print(args.source, " renamed to ", args.destination)
        end,
      },
      {
        event = "file_moved",
        handler = function(args)
          -- fix references to file
          print(args.source, " moved to ", args.destination)
        end,
      },
    },
  },
}
-- local function on_attach(bufnr)
--   local api = require("nvim-tree.api")
--
--   local function opts(desc)
--     return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--   end
--
--   -- You will need to insert "your code goes here" for any mappings with a custom action_cb
--   vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
--   vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
--   vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
--   vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
--   vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
--   vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
--   vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
--   vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
--   vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
--   vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
--   vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
--   vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
--   vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
--   vim.keymap.set("n", "<CR>", function()
--     local node = api.tree.get_node_under_cursor()
--     api.node.open.edit()
--     if node.type == "file" then
--       api.tree.close()
--     end
--   end, opts("Open file & Close afterwards"))
--   vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
--   vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
--   vim.keymap.set("n", "a", api.fs.create, opts("Create"))
--   vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
--   vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
--   vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
--   vim.keymap.set("n", "P", api.node.open.preview, opts("Open Preview"))
--   vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
--   vim.keymap.set("n", "q", api.tree.close, opts("Close"))
--   vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
--   vim.keymap.set("n", ">", api.tree.change_root_to_node, opts("scope_to_node"))
--   vim.keymap.set("n", "<", api.tree.change_root_to_parent, opts("scope_to_parent"))
--   vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
--   vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
--   vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
--   vim.keymap.set("n", "!", api.tree.toggle_gitignore_filter, opts("toggle_ignore"))
--   vim.keymap.set("n", "@", api.tree.toggle_hidden_filter, opts("toggle_hidden"))
--   vim.keymap.set("n", "e", api.node.open.horizontal, opts("horizontal_open"))
--   vim.keymap.set("n", "s", api.node.open.vertical, opts("vertical_open"))
--   vim.keymap.set("n", "o", api.node.run.system, opts("system_open"))
-- end
--
-- local function get_centered_coords(size)
--   if size == nil then
--     size = 2
--   end
--
--   local width = vim.api.nvim_get_option("columns")
--   local height = vim.api.nvim_get_option("lines")
--   local maxW = math.floor(width / size)
--   local maxH = math.floor(height / size)
--
--   local row = height * (1 / size) / 2
--   local col = (width * (1 / size) / 2) - (vim.fn.wincol() / 2)
--
--   return { row = row, col = col, width = maxW, height = maxH }
-- end
--
-- return {
--   "nvim-tree/nvim-tree.lua",
--   enabled = vim.g.loaded_netrw == 1,
--   event = "VimEnter",
--   config = function()
--     local dim = get_centered_coords()
--     require("nvim-tree").setup({
--       disable_netrw = true,
--       hijack_netrw = true,
--       open_on_tab = false,
--       hijack_cursor = false,
--       update_cwd = false,
--       on_attach = on_attach,
--       view = {
--         width = dim.width,
--         cursorline = true,
--         relativenumber = true,
--         signcolumn = "yes",
--         float = {
--           enable = true,
--           quit_on_focus_loss = true,
--           open_win_config = {
--             relative = "editor",
--             border = "rounded",
--             width = dim.width,
--             height = dim.height,
--             row = dim.row,
--             col = dim.col,
--           },
--         },
--       },
--       renderer = {
--         highlight_git = "all",
--         highlight_diagnostics = "all",
--         highlight_opened_files = "all",
--         highlight_modified = "all",
--         indent_markers = {
--           enable = true,
--           inline_arrows = true,
--         },
--         icons = {
--           git_placement = "signcolumn",
--           diagnostics_placement = "after",
--           modified_placement = "signcolumn",
--         },
--       },
--       update_focused_file = {
--         enable = false,
--         update_cwd = false,
--         ignore_list = {},
--       },
--       actions = {
--         open_file = {
--           window_picker = {
--             enable = false,
--           },
--         },
--         change_dir = {
--           enable = true,
--           global = true,
--         },
--       },
--       git = {
--         enable = true,
--         ignore = false,
--         show_on_dirs = true,
--         show_on_open_dirs = true,
--         timeout = 400,
--       },
--       modified = {
--         enable = true,
--         show_on_dirs = true,
--         show_on_open_dirs = true,
--       },
--     })
--   end,
-- }
