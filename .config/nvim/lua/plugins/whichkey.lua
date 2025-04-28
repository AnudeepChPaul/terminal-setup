return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function(_, opts)
    local wk = require("which-key")
    require("config.keymap").register(wk, opts)
  end,
}
