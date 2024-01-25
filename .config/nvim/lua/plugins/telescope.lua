local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fs", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leader>fS", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
  },
}
