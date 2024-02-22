return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VimEnter",
  enabled = false,
  keys = {
    { "<leader>e", false },
  },
  dependencies = { { "MunifTanjim/nui.nvim", lazy = true } },
  opts = {},
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
    require("acp.transparent").apply()
  end,
}
