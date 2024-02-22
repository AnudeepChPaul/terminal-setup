-- local no_binary_preview = function(filepath, bufnr, opts)
--   local previewers = require("telescope.previewers")
--   opts = opts or {}
--
--   filepath = vim.fn.expand(filepath)
--
--   vim.loop.fs_stat(filepath, function(_, stat)
--     if not stat then
--       return
--     end
--     if stat.size > 500000 then
--       return
--     else
--       previewers.buffer_previewer_maker(filepath, bufnr, opts)
--     end
--   end)
-- end

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    cmd = "Telescope",
    event = "VimEnter",
    version = false,
    dependencies = {
      { "nvim-lua/plenary.nvim", version = "0.5.1" },
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "1.0.0" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    opts = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")
      local telescope = require("telescope")

      telescope.setup({
        -- extensions = {
        --   live_grep_args = {
        --     auto_quoting = false,
        --   },
        -- },

        -- configure custom mappings
        defaults = {
          dynamic_preview_title = true,
          -- buffer_previewer_maker = no_binary_preview,
          -- preview = {
          --   filesize_limit = 2,
          --   check_mime_type = 'file',
          --   hide_on_startup = true
          -- },
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
              ["<C-n>"] = actions.results_scrolling_up,
              ["<C-p>"] = actions.results_scrolling_down,

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

              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
              ["<c-c>"] = actions.close,
              ["<c-\\>"] = actions.close,
            },
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
        },
      })

      -- telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
    end,
  },
}
