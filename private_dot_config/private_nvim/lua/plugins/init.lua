function _NODE_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local node = Terminal:new({
    cmd = "node",
    hidden = true,
    direction = "horizontal",
  })
  node:toggle()
end

return {
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {"nvim-tree/nvim-web-devicons", lazy = true},
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = true,
    dependencies = {"nvim-lua/plenary.nvim"},
    -- setup is a method on the Harpoon object, so `opts` would pass the table as self.
    config = function()
      require("harpoon"):setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = {"VimEnter"},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = {"InsertEnter"},
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "arthurxavierx/vim-caser",
    -- g:caser_prefix is "mc" (init.lua), so mc is the prefix that must load it.
    keys = {{"mc", mode = {"n", "x"}}},
    config = function()
      -- caser has no plain-lowercase action; gu already is that operator.
      vim.keymap.set("n", "mcl", "gu", {desc = "lowercase"})
      vim.keymap.set("x", "mcl", "u", {desc = "lowercase"})
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    -- Subword motions: w/e/b/ge stop inside camelCase and snake_case identifiers.
    -- W/E/B keep their WORD behaviour when the whole identifier is the target.
    keys = {
      {"w", "<cmd>lua require('spider').motion('w')<cr>", mode = {"n", "o", "x"}, desc = "Spider-w"},
      {"e", "<cmd>lua require('spider').motion('e')<cr>", mode = {"n", "o", "x"}, desc = "Spider-e"},
      {"b", "<cmd>lua require('spider').motion('b')<cr>", mode = {"n", "o", "x"}, desc = "Spider-b"},
      {"ge", "<cmd>lua require('spider').motion('ge')<cr>", mode = {"n", "o", "x"}, desc = "Spider-ge"},
    },
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    -- Mapping-only plugin: nothing needs it until a comment key is pressed.
    keys = {
      {"gc", mode = {"n", "x"}},
      {"gb", mode = {"n", "x"}},
      {"gcc", mode = "n"},
      {"gbc", mode = "n"},
    },
    opts = {},
  },
  {
    "mbbill/undotree",
    cmd = {"UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus"},
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {},
  },
  -- Node REPL toggle
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = {"ToggleTerm", "TermExec"},
    config = function()
      require("toggleterm").setup({
        size = 20,
        -- No open_mapping: <C-\> is already an Escape alias in whichkey.lua, and
        -- toggleterm would steal it the first time :ToggleTerm loaded the plugin.
        direction = "horizontal",
        start_in_insert = true,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = {enabled = true, size = 500 * 1024},
      dashboard = {enabled = false},
      -- Explorer and picker are handled by neo-tree and telescope.
      explorer = {enabled = false},
      picker = {enabled = false},
      indent = {enabled = true},
      input = {enabled = true},
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = {enabled = true},
      scope = {enabled = true},
      scroll = {enabled = false},
      statuscolumn = {enabled = false},
      words = {enabled = true},
    },
  },
}
