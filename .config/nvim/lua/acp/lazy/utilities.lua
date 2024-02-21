return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufRead", "BufNewFile"},
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup()
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    event = {'BufRead', 'BufNewFile'},
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "szw/vim-maximizer",
    lazy = true,
    event = {'BufRead', 'BufNewFile'},
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },
  { "weirongxu/plantuml-previewer.vim" },
}
