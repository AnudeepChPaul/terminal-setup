local Util = require("lazy.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    cmd = "Telescope",
    version = false,
    dependencies = {
      {"nvim-telescope/telescope-live-grep-args.nvim", version = '1.0.0' },
      { 
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      }
    },
    opts = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")
      local telescope = require("telescope") 

      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = false,
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
              ["<c-o>"] = lga_actions.quote_prompt(),
              ["<c-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-s>"] = actions.select_horizontal, -- select horizontal
              ["<C-v>"] = actions.select_vertical, -- select vertical
              ["<C-t>"] = actions.select_tab, -- select tab
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              -- send selected to quickfixlist
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
              ["<c-c>"] = actions.close,
              ["<c-\\>"] = actions.close,
            },
            n = {
              ["<C-x>"] = actions.delete_buffer + actions.move_to_top,

              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-s>"] = actions.select_horizontal, -- select horizontal
              ["<C-v>"] = actions.select_vertical, -- select vertical
              ["<C-t>"] = actions.select_tab, -- select tab

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-n>"] = actions.results_scrolling_up,
              ["<C-p>"] = actions.results_scrolling_down,

              ["<esc>"] = actions.close,
              ["<c-c>"] = actions.close,
              ["<c-\\>"] = actions.close,
            }
          },
        },
        pickers = {
          find_files = {
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
            prompt_prefix = " 🔍  ",
          },
        }
      })

      -- telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
    end
  }
}

-- keys = {
--   { "<leader>ss", false },
--   {
--     "<leader>fS",
--     function()
--       require("telescope.builtin").lsp_document_symbols({
--         symbols = require("lazyvim.config").get_kind_filter(),
--       })
--     end,
--     desc = "Goto Symbol",
--     {
--       "<leader>sS",
--       function()
--         require("telescope.builtin").lsp_dynamic_workspace_symbols({
--           symbols = require("lazyvim.config").get_kind_filter(),
--         })
--       end,
--       desc = "Goto Symbol (Workspace)",
--     },
--   },
--   {
--     "<leader>fs",
--     Util.telescope("live_grep", { prompt_title = "Live Grep (Root dir)" }),
--     desc = "Grep (root dir)",
--   },
--   {
--     "<leader>/",
--     function()
--       return require("telescope.builtin").live_grep({
--         prompt_title = "Live Grep (" .. vim.fn.expand("%:h") .. ")",
--         cwd = vim.fn.expand("%:h"),
--       })
--     end,
--     desc = "Grep (cwd)",
--   },
--   {
--     "<leader>bf",
--     function()
--       return require("telescope.actions").send_to_qflist({
--         prompt_title = "Live Grep (" .. vim.fn.expand("%:h") .. ")",
--         cwd = vim.fn.expand("%:h"),
--       })
--     end,
--     desc = "Grep (cwd)",
--   },
