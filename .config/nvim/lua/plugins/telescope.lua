local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fS", false },
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
