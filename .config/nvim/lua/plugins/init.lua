return {
  {
    "nvim-lua/plenary.nvim",
    name = "plenary",
    lazy = false,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "ThePrimeagen/harpoon",
    lazy = true,
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
    "christoomey/vim-tmux-navigator",
    event = { "VimEnter" },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "InsertEnter" },
    config = function()
      require("nvim-surround").setup()
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
    "arthurxavierx/vim-caser",
    event = { "BufRead", "BufNewFile" },
  }
}
