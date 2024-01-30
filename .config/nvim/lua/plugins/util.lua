return {
  {
    "ThePrimeagen/harpoon",
  },
  {
    "christoomey/vim-tmux-navigator",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function()
      local wk = require("which-key")

      wk.register({
        ["<leader>q"] = { ":Neotree position=float reveal=true reveal_force_cwd <cr>" },
        ["<leader>e"] = { ":Neotree reveal left reveal_force_cwd <cr>" },
      })
    end,
  },
}
