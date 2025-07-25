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
    lazy = true,
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
    "RRethy/vim-illuminate",
    event = {"BufRead", "BufNewFile"},
  },
  {
    "arthurxavierx/vim-caser",
    event = {"BufRead", "BufNewFile"},
  },
  {"nvim-tree/nvim-web-devicons", lazy = true},
  {
    "ThePrimeagen/harpoon",
    lazy = true,
  },
  {
    "mbbill/undotree",
  },
  {
    "arthurxavierx/vim-caser",
    event = {"BufRead", "BufNewFile"},
  },
  -- Node REPL toggle
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        start_in_insert = true,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        timeout = 5000,
        stages = "fade_in_slide_out",
        render = "compact",
      })
      vim.notify = require("notify")
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      bigfile = {enabled = true},
      dashboard = {enabled = false},
      explorer = {
        enabled = true,
        tree = true,
        follow_file = true,
        jump = {close = false},
        config = function(opts)
          return require("snacks.picker.source.explorer").setup(opts)
        end,
        win = {
          list = {
            keys = {
              [">"] = "explorer_focus",
              ["."] = "explorer_focus",
              ["<"] = "explorer_up",
              ["<BS>"] = "explorer_up",
              ["q"] = "explorer_close",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
            },
          },
        },
      },
      indent = {enabled = true},
      input = {enabled = true},
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = {enabled = true},
      quickfile = {enabled = true},
      scope = {enabled = true},
      scroll = {enabled = false},
      statuscolumn = {enabled = false},
      words = {enabled = true},
      styles = {enabled = false},
    },
  },
}
