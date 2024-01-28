local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>ss", false },
    {
      "<leader>fS",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol",
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    {
      "<leader>fs",
      Util.telescope("live_grep", { prompt_title = "Live Grep (Root dir)" }),
      desc = "Grep (root dir)",
    },
    {
      "<leader>/",
      function()
        return require("telescope.builtin").live_grep({
          prompt_title = "Live Grep (" .. vim.fn.expand("%:h") .. ")",
          cwd = vim.fn.expand("%:h"),
        })
      end,
      desc = "Grep (cwd)",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "bottom" },
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
          ["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
          ["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
          ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
        },
      },
    },
  },
}
