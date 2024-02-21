return {
  "folke/flash.nvim",
  event = {"BufRead", "BufNewFile"},
  opts = {
    search = {
      wrap = true,
      multi_window = false,
    },
    modes = {
      char = {
        labels = "1234567890",
        jump_labels = true,
        jump = { register = false },
        multi_line = false,
      },
      treesitter = {
        labels = "1234567890asdfghjklqwertyuiopzxcvbnmz",
      },
      search = {
        labels = "1234567890asdfghjklqwertyuiopzxcvbnmz",
      },
    },
  },
}
