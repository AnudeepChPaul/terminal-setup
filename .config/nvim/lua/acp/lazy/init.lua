return {
  {
    "nvim-lua/plenary.nvim",
    name = "plenary",
    lazy = false,
  },
  { "nvim-tree/nvim-web-devicons",     lazy = true },
  {
    "ThePrimeagen/harpoon",
    lazy = true,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = { "VimEnter" },
  },
  {
    "mbbill/undotree",
    lazy = false,
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", vim.cmd.UndotreeToggle, "Shows history of modifications" },
    },
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("undotree").setup();
    end,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "InsertEnter" },
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- {
  --   "echasnovski/mini.comment",
  --   event = { "BufRead", "BufNewFile" },
  --   dependencies = {
  --     {
  --       "JoosepAlviste/nvim-ts-context-commentstring",
  --       lazy = true,
  --       opts = {
  --         enable_autocmd = false,
  --       },
  --     },
  --   },
  --   opts = {
  --     options = {
  --       custom_commentstring = function()
  --         return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
  --       end,
  --     },
  --   },
  -- },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "szw/vim-maximizer",
    lazy = true,
    event = { "BufRead", "BufNewFile" },
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  { "weirongxu/plantuml-previewer.vim" },
}
